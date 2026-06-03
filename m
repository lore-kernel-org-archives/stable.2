Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651446AEEA;
	Wed,  3 Jun 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488411; cv=none; b=RQcgWBIwmIAbFwPcBHdUPDH2+VRITCBCQjO847AiOnXGzlBeHl8AuNgR9N8H1jn2omiXIviptavakA2s+u5MN9Enuw9bThd/ELSMv70zKOlwcpAN/BmnbtIEq5vG1GKx/Rma7Odd++zdDGmHC3cSSQRDiKq6ENvnDKBNSluNwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488411; c=relaxed/simple;
	bh=JizyUJtj9l47MDABYPY2Ol/uBdvkPaKWospKIlUIbw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hEpJCO+DJYA3CoZzyR8e411vQoKMB4B6fRZnu5g4vZm9ZDyWTHclAIQ/ao7kR0NyHMNY0AYedHDMRqszsfmisxge0KNK1nMTxRjOCpHnqRxMUZtZFwP8dm+zoVsb21eanJdLNPjFo4HTdOujURdVXCqui7vRrEjHKSYZiNB+S1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHa+LUGCBq2rWAEw--.4908S2;
	Wed, 03 Jun 2026 20:06:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: corey@minyard.net
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ipmi: fix refcount leak in i_ipmi_request()
Date: Wed,  3 Jun 2026 12:06:34 +0000
Message-Id: <20260603120634.3758747-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHa+LUGCBq2rWAEw--.4908S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWDWFy3tr1rXFWrKFyDZFb_yoW8Cr17pF
	43CryYyF4FqF12yasxXry8XF93uayftr98WrWDt3s7Zw1agwna9F10kw1agFy7AFWkXF43
	XrsxG3y5CF15X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5ku4UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwHA2of-lBevgAAs0

When a caller provides a `supplied_recv` message to i_ipmi_request(),
the function increments the user's `nr_msgs` reference count. If an
error occurs later, the out_err cleanup path only frees the recv_msg
if the function allocated it itself (i.e., !supplied_recv). In the
supplied_recv case the cleanup is skipped, leaving the reference count
elevated. The caller ipmi_request_supply_msgs() does not release the
supplied_recv on error, so the reference is permanently leaked.

Fix this by explicitly reverting the reference count operations when a
supplied recv_msg with a valid user pointer is present in the error
path: decrement nr_msgs and drop the user's kref.

Cc: stable@vger.kernel.org
Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/char/ipmi/ipmi_msghandler.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 869ac87a4b6a..5b9d914cc7a9 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2347,6 +2347,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		if (smi_msg == NULL) {
 			if (!supplied_recv)
 				ipmi_free_recv_msg(recv_msg);
+			else if (recv_msg->user) {
+				atomic_dec(&recv_msg->user->nr_msgs);
+				kref_put(&recv_msg->user->refcount, free_ipmi_user);
+			}
 			return -ENOMEM;
 		}
 	}
@@ -2420,6 +2424,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 			ipmi_free_smi_msg(smi_msg);
 		if (!supplied_recv)
 			ipmi_free_recv_msg(recv_msg);
+		else if (recv_msg->user) {
+			atomic_dec(&recv_msg->user->nr_msgs);
+			kref_put(&recv_msg->user->refcount, free_ipmi_user);
+		}
 	}
 	return rv;
 }
-- 
2.34.1

