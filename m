Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794119323;
	b=X5bVeCt1ovZUdch2FX+RYQJ7QzPd0CVHtLurFOA2OKKr1ZyKBKoYLN9KEo2Wp8btsBJn
	 z1SGfzSLrzIbKOyztQ5wKQXQumO6ATimwswGZz67+Q9Nb30NwRMpUe6XR1laJdssae6W2
	 eHat0mmqX36kLKLrOW0tJe81jSzeAWeKzJMdomoWH00oa0hjtr7T2kceggYrxDUh0MmMQ
	 EU1Pf3Yv6fm73OHEMLRqxgle5MrqlhVGQz/xvZlOEEe/uz3aMTNhKFTu4N7Oygk+ADpTl
	 NhNrDzlv06FkqvI2DqOVHK80jWUGCfb01VoWVaZlUCvuceJmdST9nCZ3LSrk+KZhPag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794119323;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=c78D4a1RW3JHtc1NdajB+jnOJRb2qfhMFFzLKACsSM0=;
	b=1425jGwNHNSWnpJ8+NhFhUTtNT19aqREO2n7mu/WsSdCzed51XOqE/uh4Fbv3RcLiDbh
	 UgO4+0XFWRU+4J2WlN9pyaUXkPDkzjSx3WT1++2brt2wzZa5rNcAVMFXlu8L4Y5Zc/jak
	 bn9NlUBK86W88FOwdaoFknhD7jFe62kK37jaJFHOVfeHtfyJf1Qg7Pht5CvpiW65cabcd
	 EX5b/GUa+fWbJ433IQQquNkrBlffmtGH+CWMEA4pHmKrL4LhrZRKa8GjQoGXyx+9kTyLA
	 duAlLt95ltIc72998w4vvqe6x4Qc0C8GAMEV67EqP4qfWpxnaiIc59/Kidd3JCrq7EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB8606A31A;
	Sun,  8 Nov 2026 06:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95BB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jMjfW41Wwz55RJ3;
	Sun, 08 Nov 2026 14:28:35 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A86SUiH057590;
	Sun, 8 Nov 2026 14:28:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 8 Nov 2026 14:28:31 +0800 (CST)
X-Zmail-TransId: 2af96af0168f4ca-27bd8
X-Mailer: Zmail v1.0
Message-ID: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
Date: Sun, 8 Nov 2026 14:28:31 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <akpm@linux-foundation.org>, <david@kernel.org>
Cc: <linux-mm@kvack.org>, <ziy@nvidia.com>, <matthew.brost@intel.com>,
        <joshua.hahnjy@gmail.com>, <byungchul@sk.com>, <gourry@gourry.net>,
        <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBtbS9taWdyYXRlOiBmaXggc29mdGxvY2t1cCBpbiBkb19wYWdlc19tb3ZlKCkgd2l0aCBodWdlIHBhZ2UgYXJyYXlz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A86SUiH057590
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 08 Nov 2026 14:28:35 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF01693.000/4jMjfW41Wwz55RJ3

From: Shao Mingyin <shao.mingyin@zte.com.cn>

mm/migrate: fix softlockup in do_pages_move() with huge page arrays

do_pages_move() walks the array one page at a time.  An entry naming the
node its page is already on is never queued, so the loop runs without a
voluntary preemption point on a non-preemptible kernel; the existing
cond_resched() calls in the migration code are only reached after a
folio has been queued.  nr_pages comes straight from the syscall.

A 6.6.60 x86_64 kernel with CONFIG_PREEMPT_NONE=y and CONFIG_NUMA=y
reproduces this under QEMU TCG: 50 million entries pointing at a page
already on the target node keep the CPU in do_pages_move() for 42.9 s and
trip the softlockup watchdog; with this patch the same call completes in
44.3 s without a softlockup.

Add cond_resched() so that long calls yield periodically.
do_pages_stat() had the same problem; it was fixed by 8e934ab44389.  In
current mainline only alpha, hexagon and classic m68k can select
PREEMPT_NONE and they cannot enable CONFIG_NUMA, so this mainly targets
pre-v7.0 stable kernels.

Fixes: a49bd4d71637 ("mm, numa: rework do_pages_move")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
  - describe the reproduction and the code path, as requested by David
    Hildenbrand; no code change
  - correct the do_pages_stat() reference (fixed by 8e934ab44389)
Link: https://lore.kernel.org/all/20261107213856462Jx8pIdgdtLvPLfOFTwV4X@zte.com.cn/

 mm/migrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 875079464930..3122ecb85270 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2372,6 +2372,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		const void __user *p;
 		int node;
 
+		cond_resched();
+
 		err = -EFAULT;
 		if (in_compat_syscall()) {
 			compat_uptr_t cp;
