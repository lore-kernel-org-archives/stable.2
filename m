Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792921167;
	b=4Fih+yyib75LjakTyhB/NI1PBURUfo0K9wa9oZnWe5YQnHrYBaWuhOzpfuyFy3NViFZr
	 e6uJEPNn0A0tqUfheWjChElRXV8nQPlokP3n3PN2bD1IiG6uurVdg3z7CR2hdoqJScg0h
	 p877mPhVsBady5DdhM5YzJeXKCE46do9gRNN7ryzVv2Q07riz9zNo4qxuutVQSX4BIWpw
	 +7/6CDhkOBCFKBIrnMxar+Ghhin0PH9ioP6WC3EpqBdsofBe188+hcImcs1yZ1xKoQFMa
	 cY+UlRrtu8EEiZD3JD5gCIEh3BWK5TKVHp/Yg+WDBunotCCcn235cPOh32Md19mf5iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792921167;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1YX/NGwD+4icII1vdPQ/3V0UVnnxb1F3CZZawSscMPM=;
	b=IPWV082HI6noKp76id+2jhyYhIZ3HYI42ySZaaQjcsGmbGSXU/XOSILudes0QRMZSGWR
	 KHGNDBxcmJKdYI1hJ3iXWIsFO5cyS6Z3CGlRnjNOSGoMFmIVhBG3ypjBoO/fGKv4FMdSN
	 /IYRAq0GF5wNzrr4OgEKJK+tDKCxzXXNUVPb3CKH1WOzu5KsIITAcLsNwmFLGwj8t+8hp
	 oSI4sLti9hxCp6nKW7pjqvy1Uh7Ja172r5Dgt7AIAvqEN+C9MH/lbxSWUBG6knbEQusPY
	 qU0TJmm9YOrxobURluPPVIEuGnyJBgZqgvpqdW4HoKudxHe5F2t3mIpttEm5m/5RTqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Li3uGMvB;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26319606A31A;
	Sun, 25 Oct 2026 09:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26319606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Li3uGMvB
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792921162; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1YX/NGwD+4icII1vdPQ/3V0UVnnxb1F3CZZawSscMPM=;
	b=Li3uGMvBikF6I88Q8L2529ZboW54EoEqSDH08rUmKZrTNLPMq+5pNGAwGgWrU9inxTbJEU709O4HbGHqD5my+PbRbZBaF1R7QuxVhdKWVkqkGW2H/q6vdfOP6zhLcxZU5thcFTRiBYzEWmBvWbXb7FRPuIrgrjmBWdZHmb+be74=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=jinyue.li@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDQ7Uop_1792921161;
Received: from aa8c952a0f58..(mailfrom:jinyue.li@linux.alibaba.com fp:SMTPD_---0XDQ7Uop_1792921161 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 25 Oct 2026 17:39:22 +0800
From: Li Jinyue <jinyue.li@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/vma: reset the VMA iterator when merging a new range fails
Date: Sun, 25 Oct 2026 09:39:21 +0000
Message-Id: <20261025093921.1011927-1-jinyue.li@linux.alibaba.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the new range can be merged with prev, vma_merge_new_range() moves
the VMA iterator back to prev with vma_prev() before calling
vma_expand(). If vma_expand() then fails, NULL is returned with the
iterator still covering prev. __mmap_region() falls back to
__mmap_new_vma(), whose vma_iter_config() requires the iterator to
already contain the new address and warns:

  WARNING: ./include/linux/maple_tree.h:796 at __mmap_region+0x1a04/0x2398
  ...
   __mmap_region+0x1a04/0x2398
   mmap_region+0x304/0x466
   do_mmap+0xe7c/0x162c
   vm_mmap_pgoff+0x1e8/0x362
   ksys_mmap_pgoff+0x76/0x402

This is easy to hit with fault injection when the new range sits
between an unfaulted prev and a faulted next, so that dup_anon_vma()
has to run and fails on allocation before the iterator is
reconfigured.

mmap_region() used to reposition the iterator itself in this case, but
that was lost when it was converted to vma_merge_new_range(). Restore
it in vma_merge_new_range(), and only when the iterator was moved, so
that the common no-merge path is unchanged.

Found by syzkaller.

Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
Link: https://lore.kernel.org/linux-mm/CAGfhM4AaEygReogOAmkmu5UfRYwoBXAMdLMBi4jbakNONbpsMw@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>
---
 mm/vma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index 6c35f0d775ab..a801e3d29dbd 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1141,6 +1141,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next = vmg->next;
+	unsigned long start = vmg->start;
 	unsigned long end = vmg->end;
 	bool can_merge_left, can_merge_right;
 
@@ -1198,6 +1199,10 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		return vmg->target;
 	}
 
+	/* Undo the vma_prev() above so the caller can insert a new VMA. */
+	if (can_merge_left && !vmg->just_expand)
+		vma_iter_set(vmg->vmi, start);
+
 	return NULL;
 }
 

-- 
2.25.1

