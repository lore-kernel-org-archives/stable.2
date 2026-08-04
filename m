Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6833C502
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827538; cv=none; b=OEwLJ0K341kQrzhEeswH0wxd47QXtWSon0wbIefoFd6whn13ac2B6Io7z+sO/L8Ja6eWWWT10BrFf/Ha6omrtNHvoV8Jnr7golRnUFylgOai0P+vWZcEN5r9iD0u5xXGGMrv53+aywT8l9Oummz4xKJUUqASuH8/5O12K93TpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827538; c=relaxed/simple;
	bh=sYv2Yt7hshDOuKP+c1TAcrZZTNZsh9OCGmezpu25zVM=;
	h=From:Date:Content-Type:Cc:Message-Id:Mime-Version:To:Subject; b=H9ko5nsU5K61PztJBHWBz69KmMBWe+aK1Wm3qq9KqYu1Y3g1lXgpHOqZKthC3egIKdFmR3/8F+MxoKPTraqtgPRDKjACVfeJyxyQLVMYgSVnGZbJR99fp3jKbcuBikrNxUqZ/D03YXXm0d0RkUQEksXGOsPjG96zooGEYBTUNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JxSe5OQt; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JxSe5OQt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785827525; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=m5M1Lm+/NdKKpBFcWcOxFS9rDfn8UtHqjcdy9ymxzsA=;
 b=JxSe5OQt9XYwi7RshxhsAuRjOsfxnlvMWsLvOxxY1v6ixuLldp5pceztssqEBbK8oDUa6m
 7On7kWBXabIED2uQvt+a0li8EOzMQJuqKJxX6669aKuJ/TITGu7rysHi6ien7Tl0y8vO4r
 pLTNaDfKK0JaPOCEIiu1gV5sZS50DQR8LfJrNYvL5I5iKnAIeilSuFMWRNZQV8Pf9djnxI
 MALW6+ctSwoDLPnqFiULqFw59ltvyihhft4WgTctGgg5kfUNqUwkqABegfus78gHcRWfRi
 sF/8WVhzXl1pVLdNlYw7ZJg6m/UBB0vCjSWXs6IEnQHHfE4HWA3XuWNd6ycJ0A==
From: "Bo Li" <libo.gcs85@bytedance.com>
Date: Tue,  4 Aug 2026 15:11:28 +0800
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <hpa@zytor.com>, <peterz@infradead.org>, <sshegde@linux.ibm.com>, 
	<jgross@suse.com>, <wangyang.guo@intel.com>, <seanjc@google.com>, 
	<pasha.tatashin@oracle.com>, <linux-kernel@vger.kernel.org>, 
	"Bo Li" <libo.gcs85@bytedance.com>, <stable@vger.kernel.org>
Message-Id: <20260804071128.31022-1-libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
X-Original-From: Bo Li <libo.gcs85@bytedance.com>
Subject: [PATCH] x86/tsc: Fix misplaced seqcount_latch_init() in cyc2ns_init_secondary_cpus()
X-Lms-Return-Path: <lba+26a7190bf+9b43d9+vger.kernel.org+libo.gcs85@bytedance.com>

In cyc2ns_init_secondary_cpus(), seqcount_latch_init(&c2n->seq) is
called _before_ c2n is advanced to the next CPU via per_cpu_ptr().
As a result:

 1. On the first iteration, c2n still points at the BSP's struct, so
    the BSP's seqcount_latch is re-initialized. cyc2ns_init_boot_cpu()
    already did this correctly, so it happens to work by accident
    because no concurrent readers are live at __init time.

 2. On subsequent iterations, seqcount_latch_init() initializes the
    previous CPU's seqcount (because c2n was advanced by the prior
    per_cpu_ptr()), so all CPUs except the last one in the for_each
    loop happen to get initialized. The last secondary CPU's seqcount
    is left uninitialized.

Move seqcount_latch_init() _after_ c2n is pointed at the target CPU's
struct, so each secondary CPU's seqcount is correctly initialized.

Fixes: e2a9ca29b5ed ("x86/tsc: Initialize cyc2ns when tsc frequency is determined")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index ce10ae4b298b..84fb80492b01 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -223,8 +223,8 @@ static void __init cyc2ns_init_secondary_cpus(void)
 
 	for_each_possible_cpu(cpu) {
 		if (cpu != this_cpu) {
-			seqcount_latch_init(&c2n->seq);
 			c2n = per_cpu_ptr(&cyc2ns, cpu);
+			seqcount_latch_init(&c2n->seq);
 			c2n->data[0] = data[0];
 			c2n->data[1] = data[1];
 		}
-- 
2.20.1
