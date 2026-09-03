Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E7E3B995B;
	Thu,  3 Sep 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434024; cv=none; b=iSbavYth/KR/wuzXzn+et1MgW0cXZjAcl1i4zjdsUMaEueJLiBJTb21bZ75PxRVHsmE4zkjF2CJb8Z/aqVGXFiY+PsZMhVeH+kE+ftWNoUMUICxvjbvGweEFTAQd+Jw3rxPwV259ki1695ycX048eGiQkXb45FUlo4zXZSVPTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434024; c=relaxed/simple;
	bh=U89IzzFoft7TfRALsnG7ekJ7+A8yWu1YKalPzY817Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PozY37NsHvP4WEgcW7uIR8sMntXf1/EzFrf1udderWgBiRu5FDV8TzSedLC17hova0KG6RVvPSJ2RvfEBgYfpi3rMczJiL7qMgfV4br8s6doTNx8U091a6diAKJCdTUNzhzhAKe9C1JrWcvMd4IUKmY7J215oLtzpFVdZLpdncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VGyr7SRp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VGyr7SRp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20FD11596;
	Thu,  3 Sep 2026 04:13:38 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 540B53F7D8;
	Thu,  3 Sep 2026 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788434021; bh=U89IzzFoft7TfRALsnG7ekJ7+A8yWu1YKalPzY817Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGyr7SRpN7I3wrB0yR+yGl8aH4MKlyOc/B5S1YfKsM4/tIyE3QGbP/fYOudUrKKL7
	 H7ARoqqwhqH+3ytHuL+nl7duxHVT5LSiwyrx/vz0rAEWVblTA1KnaIckaC8VdwRtAj
	 dXivUMLm8dfy8/wSGXanBM4oG0367UIcKjywUDBM=
From: Christian Loehle <christian.loehle@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: breno Leitao <leitao@debian.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/2] mailbox: pcc: Serialize channel updates with shared memory teardown
Date: Thu,  3 Sep 2026 12:13:28 +0100
Message-Id: <20260903111328.805352-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903111328.805352-1-christian.loehle@arm.com>
References: <20260903111328.805352-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mbox_free_channel() makes a PCC channel available before the subsequent
shared-memory unmap. Without serialization, a concurrent request can bind a
new client and replace the mapping, which the old release then unmaps.

Serialize PCC channel acquisition and release. Keep the channel unavailable
until the old shared-memory mapping has been removed.

Suggested-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/mailbox/pcc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index db30812c5051..14dc4a187bfc 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -53,6 +53,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/log2.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
@@ -113,6 +114,7 @@ struct pcc_chan_info {
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
 static struct pcc_chan_info *chan_info;
 static int pcc_chan_count;
+static DEFINE_MUTEX(pcc_chan_mutex);
 
 /*
  * PCC can be used with perf critical drivers such as CPPC
@@ -392,6 +394,8 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
 		return ERR_PTR(-ENOENT);
 
+	guard(mutex)(&pcc_chan_mutex);
+
 	pchan = chan_info + subspace_id;
 	chan = pchan->chan.mchan;
 	if (IS_ERR(chan) || chan->cl) {
@@ -434,6 +438,8 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 	struct pcc_chan_info *pchan_info;
 	struct pcc_mbox_chan *pcc_mbox_chan;
 
+	guard(mutex)(&pcc_chan_mutex);
+
 	if (!chan || !chan->cl)
 		return;
 	pchan_info = chan->con_priv;
-- 
2.34.1

