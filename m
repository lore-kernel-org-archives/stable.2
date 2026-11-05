Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887340;
	b=MWxmB3f6ixhxBih4dMCtLMMVbrvFf77EtszgmF7RF6UtkQaZx4Cph0gQUc1t2cEVZFga
	 c1V8i9urJYOeW1XJDYaZ0YkWkKOPPPvssPUWgr10wHiTNIWSuX16VCYbRS7BSQR4eyPur
	 IC4YoKysRaNRFFFmi0xaW/nTbC//KDaJ6mtAvp0A8A7M4A6eAsTX/8KTGKTFMKVcG+Xne
	 olDa1kKUYlNI6+i8wayW7G//9XSVmknXOjuwY+U/qT2aCNF/9sktoQi7Pqr48jERaERoc
	 7607DL34g9TXmJSeeN32Vh3qE3+snk7LTcri74Skv8E9XW/6WDqKYzy6Ab7jdqXXFmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=P0d6VE8Xxg+YHeBUs9f6ShKNxSqy9UVeoYr+QVUfLKo=;
	b=lnKJe/RrRW90ybUu4yw7eNBOtnMv3d9JK6QTYGmq+XhxQVEcfM0tco5KH2YOPnHu/rBA
	 JEk2cFpssUcPqEkHeSqJV0MtAHfCrwLyIyWWz5wwen1Qx5sn+wkWOQSJCWdQL5DT9f+4J
	 EuGIZtA26pJo3T+ks9vHHzTv1CLyb95aizyueC8SHflUh64OYR6BIJf2SyxL/h/8HL65j
	 BO6K5ux3zxYzSEfpBrisAcIAXpEB2WfW6ujckCFXI/NfQ+SsB7qYc6kIMRxtMFROyYexs
	 gMuZfUMRehqP0jZYs4lWBuH991c0aTIz20BerKhqNdbnEAgXjNoQtwbAcdsYSkybIJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=qXVOr8Fx;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74C606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA74C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=qXVOr8Fx
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b32daac9d7so5260467b3.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793887339; x=1794492139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0d6VE8Xxg+YHeBUs9f6ShKNxSqy9UVeoYr+QVUfLKo=;
        b=qXVOr8FxsznlhvTguZM/0FDJTMdIgVD1P6rsIRRKDZbpcy6yFs/eRqKvXjTwU9rbLn
         Sv6LNYSBwrO8NiBQjPt6y/F5nbf34MYqkCEHplC1XnzRXruWJvD+ESz9bSi9bEkEzx/+
         gmPqCynQIUFob6sWEsxRvHLJBjNJPAcYR+x40yf2Tl+zEwUsMEPWxEOVqKz3IVI64fNU
         7JYmy0q/H1NBrGx0JhnhTWtyRwysVgXnAbzPggDz1T9rNOSF9IFOQAKLBx2qhfzK8QhL
         dDyI26i9DLpGzvv3akq4DQ8FBw8Tov/BeC56uh1CgN1bs3NVXsVv/iO3mTitXNSYeGmb
         UJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887339; x=1794492139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0d6VE8Xxg+YHeBUs9f6ShKNxSqy9UVeoYr+QVUfLKo=;
        b=M7Ox4wl75joUfIVAn+IXFF97AZ0MtEk8XXB4yKoyDvQiD1l0O685zpJPddXsIf5jWC
         gnl+Fre4GX5kZmxJvtk38+sxuB4u9S0Dx7LipgMMA4FsLQM8zKa8O0AAiPW9poq2rhHg
         qH/aMN70CouS8crRoJFFJ4dD1dQYQZqO4HXpZC2sovzrAs1j6ITzuru/w0Rmq3QxxLhy
         CgfsrNmzBffUPvT8gTPOK4vrqMZj2X6AClkZu76CG1EeCzDIQhJetMAfYvtDrCETWFFx
         Xahi9tdJKuYa8UhTB/HujSj2wRabo5Mvtdy1vvBadPmyEA6e+/Tz1STpowc+eKo/vWMH
         16fA==
X-Forwarded-Encrypted: i=1; AKwUvBzKNLpMAb2YEvR8ZqAuRdSUWS98XXdxWxXCUNhhgQcw+xMwv4Q6mZIKZ2lbk4OyHXLxn28soLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sANDlFOpOv2N4jfslsrWUWKM7whMYC8tT1AEBB5NrVLBnFUNz
	/eppiJpqS0AzB+ELUPQKtb8R7/L+8DzYsMlTFluvuordR4glNJo9FZ5f1pzf6ZnDvcM=
X-Gm-Gg: AYBFou00Bez4OZQeZfAsK53glItBPzeUbVl5xjaVw1Ux24el7XXS6ztkX5xDxpDmAcH
	/MCvZGJthSElfgD3usM73hS52LsU5fjd7E0TtUZ0rX+pDQfhBTpjxXj5QWT5kyPIBiiA3cSive1
	I0qTPg8miOrSdrusEdA1yoLXD+w/8v0d0DM9ctRYdt1vvKa0Tn6BHS5yVeBuRPMaFgbZ/zwEMKl
	vHSPR1YMxOsNeZo1ktQcQCymsU4oXhqcPQt0EG5VGT5KEuZIyo+lF299snYZ6ygn2vj+K4PvvlS
	a+cXPSFGIBP7Qx6XJRMtMPEiSNmNiY83Yx2zSI3MGIn5lLOB9nbG8bs93OolwpcMbOC1He/r7/9
	oOth7CfsraGdRpAAS6gtuaLeMk4yM1RlVVR57VRv8EwxRGU6s8LX1NZfhvbHE9ucNAoeWTaqmp0
	C6d8QR+GZKf2QULO/X3Jns/laBy1HYTCyFJCwN1xAoDk9y/JhGUYNVGBrEjW4UztguigZezEF3C
	bp9hZt1iDMfS1de1Nqs5hgMBp1elJfUrBlZGehkg81CywOOv7ePqIh/TwoEbE5IzllEkLMIVRPF
	OiEQXLiE0LV1Ji0QL4KBt4kZcCxB9BSVDkUGE+IELBgY2A==
X-Received: by 2002:a05:690c:c707:b0:8a9:a1e9:2665 with SMTP id 00721157ae682-8b328db920emr14100817b3.6.1793887338563;
        Thu, 05 Nov 2026 06:02:18 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b30992b0aasm40722867b3.17.2026.11.05.06.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:02:18 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:02:03 +0000
Subject: [PATCH v3 1/5] mm/mremap: fix hugetlb reservation leak on partial
 move
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-mremap-pre-split-v3-1-f8789de76849@toxicpanda.com>
References: <20261105-b4-mremap-pre-split-v3-0-f8789de76849@toxicpanda.com>
In-Reply-To: <20261105-b4-mremap-pre-split-v3-0-f8789de76849@toxicpanda.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Sarthak Sharma <sarthak.sharma@arm.com>, linux-mm@kvack.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793887333; l=3823;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=i9R2QfX6Wwas4a5Gy/St+nxvaWI6sgILJM0qO/Y58VA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO4SLiPWQwytHUwF7H4RiAPHLp7yvnFj+vHoSzp4vwTgR//weZYFHjhEWL9ovyefJ/rHcQWYYKC
 vydARvmD1Wg0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Moving a part of a private hugetlb mapping with mremap() leaks the huge
page reservations of the parts that stay. They are not returned when the
mapping is unmapped, when the process exits or when the pool is resized.

fixup_hugetlb_reservations() takes the reservation map away from the old
VMA while that VMA still spans its whole range, because the moved part is
only split off by the unmap at the end of the move. hugetlb_vm_op_close()
then finds no map in the parts that remain and returns nothing for them:

    mmap() of 4 pages, MAP_PRIVATE | MAP_HUGETLB    HugePages_Rsvd: 4
    mremap() of the second page to a new address    HugePages_Rsvd: 4
    munmap() of all of it                           HugePages_Rsvd: 3

The source is unmapped in this case, so the number of VMAs ends up where it
did before and the check against sysctl_max_map_count stays as it is.

Fix by splitting a hugetlb VMA in prep_move_vma() before a part of it is
moved, as commit 597e4b9ab48a ("mm/mremap: fix locked_vm leak by splitting
VMA for MREMAP_DONTUNMAP") does for an mlock()'d VMA. A backport needs that
commit, which is tagged for stable itself.

Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
Cc: <stable@vger.kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/mremap.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0d06d7f37f19..5926ecdb31e9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1038,7 +1038,7 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 }
 
 static bool __check_map_count_against_split(struct mm_struct *mm,
-					    bool pre_split,
+					    bool source_stays,
 					    bool before_unmaps)
 {
 	const int sys_map_count = get_sysctl_max_map_count();
@@ -1092,14 +1092,14 @@ static bool __check_map_count_against_split(struct mm_struct *mm,
 	 */
 	map_count += 2;
 
-	/* If pre-split, the -1 observed above doesn't apply. */
-	if (pre_split)
+	/* If the split off source stays, the -1 observed above doesn't apply. */
+	if (source_stays)
 		map_count++;
 
 	return map_count <= sys_map_count;
 }
 
-static bool needs_pre_split(struct vma_remap_struct *vrm)
+static bool split_source_stays(struct vma_remap_struct *vrm)
 {
 	/*
 	 * An MREMAP_DONTUNMAP of a mlock()'d VMA needs to unlock the
@@ -1109,11 +1109,23 @@ static bool needs_pre_split(struct vma_remap_struct *vrm)
 		vma_test(vrm->vma, VMA_LOCKED_BIT);
 }
 
+static bool needs_pre_split(struct vma_remap_struct *vrm)
+{
+	/*
+	 * fixup_hugetlb_reservations() takes the reservations away from the
+	 * source VMA.  The parts of it that do not move have to keep theirs.
+	 */
+	if (vma_is_hugetlb(vrm->vma))
+		return true;
+
+	return split_source_stays(vrm);
+}
+
 /* Do we violate the map count limit if we split VMAs when moving the VMA? */
 static bool check_map_count_against_split(struct vma_remap_struct *vrm)
 {
 	return __check_map_count_against_split(current->mm,
-		needs_pre_split(vrm), /*before_unmaps=*/false);
+		split_source_stays(vrm), /*before_unmaps=*/false);
 }
 
 /* Do we violate the map count limit if we split VMAs prior to early unmaps? */
@@ -1162,10 +1174,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	/*
-	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
-	 * case perform any split ahead of time for an mlock()'d VMA.
-	 */
+	/* Perform any split ahead of time if the source VMA has to be distinct. */
 	if (needs_pre_split(vrm)) {
 		VMA_ITERATOR(vmi, vma->vm_mm, old_addr);
 

-- 
2.55.0

