Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371387;
	b=QrDmzyX/ZWa/tVjqC/TVMuCCe5fGPB53INOMKqkSOXCLVnflzmnAlGvb32ncEPgvPuO+
	 yJrSu5ICWlTfybBcMDJF9W8DvwOdnXrFZrR/19uaZS2tSr8duVxIQliwBR5OtzAS3L24M
	 2DLfVumMewg6YmSsz43cMLgDTYb33t6nxWtqTudp+Cxx83KEwlOLY2rDPNgaE8QZBGoJ4
	 4nNfizVBQCQ9yDYuO0Ssa2fhrzKRKShwtYx3+tTEEO2nw9tPt6Qhe/3AM2VAzu9opi3f5
	 gN4s8nuyA6l8KGCmAKX7eXUhcK1mdkVzv0wwRd+X1mtGrixjkxeU6ojLJ9LHbCYfgaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ZSW8NWM9gOucFIr1T7wwU0cwLVYpwHF/t22hLvEg2QQ=;
	b=XRs+IHimsWkZ2L46jCyQEuNkXEjPmK+G7/MYjZQ7riPnjn5sHI05FQwYwfZnYRzCXfDX
	 OJggYWbxuWjc6MESupiO1ZYMHruOaAOHxt7kxvim3fnFmNftYUDKO/i4bqtfayDLFuMFc
	 UYVBckmrv3Auokv3y7tSrRCAxqJkUAUcf+JWbFF2/eb7NLE1HW5rfCguWbYgsRV+5IYcR
	 LquNkTbB9VQ8S5Vn0PePgXU9F0uphCLb154C0SxraF+z92WXP2CcHTfi4Kc23OgdjtKRh
	 uoS5ndm2uhx3IkYqsYg51Y4N7cZCaYk8yGbxYecBqJrZUbYYg4jyZV1SZUJ7mtbkcxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=XnlRORDK;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F9606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 817F9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=XnlRORDK
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a215e64962so7592395e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793371386; x=1793976186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZSW8NWM9gOucFIr1T7wwU0cwLVYpwHF/t22hLvEg2QQ=;
        b=XnlRORDKh1MbI4/llMzBhmHVDaz+8+N4i4RbJrqSNygoqVI4/WBPU1veh+0kka21KO
         sgC/TPO80BpXDh7Aq3t2VLDGQ1YhKquLuZzSUXYK/sUDjSHEjGD7NKkz1/hg1zC0cW4D
         sxtQm7E2mbIncpJ3O30ZKI24BRCH0KrzkvzciYo/s3T9hikjjzm37dmVp1FYvDughBRl
         SvPVOILboZ6JDJ9y352yJgkysCaJIOykjEaBDf0cpIuUtSBEFZ3EJrk2BTgY3LoabY9g
         XdqHGXJKrajm0M9Pez/S/Phd/Wi/xb8Est0/mIY/NqPbGaiCCfrynNneFbPcmPfF5R2Z
         mWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371386; x=1793976186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZSW8NWM9gOucFIr1T7wwU0cwLVYpwHF/t22hLvEg2QQ=;
        b=baYzCUHEYyDtgEjrB09+H5QsLg52DiMlE2YlFznJQfrfADjMVi3TAvU1YiJKYVgoXV
         DIOkMmVmUYMuJ9tNGq3gzo5p/AG0YmDFfRJzF6MPceBv4dnHFWm4fsTOeqn1yUk2jgKS
         A6QxLRja4XGm6psgLl3QckcCCFLe443Z2IEorUjO7IxObNyJcMBicwj7rRm3vy508879
         pkPiENcfiUoi57EcPWGUQQOnPut0Jd4kBfh9jb0T1fjrlbVbYKCcgN8uX1e5XU1yXfj4
         OhBjUWtmndSib0aBK44bItfP9mMuFnh+o7tkIpGeXmdVtcG5xAgn06N5v6SNK820xhHg
         RfDg==
X-Forwarded-Encrypted: i=1; AKwUvBwgvMjdPhpOlmy/wWdzVZojHfLBP64LtZvmur3P8z4pizMFS/w77sDcNe14ezWFwkbsuVQFzpg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBFOTMPkAA6gKcLVFupmPhK/luZQZKd1k2LThGPLDl7VIZQ/gi
	fOck18V/FmIsWRm7Ng+X7G/bZEtJ0ZfcYAv2PcyYE/mXggD/zzE0axM3wtz7dA1chgU=
X-Gm-Gg: AYBFou3cKVLX8yypoKDVObd1ibSeiBBXHUbg4Dqs6liZJ7sWjr3Ntt+xbG+yKNffbk4
	/j9u7shR8CUYAkmcCPVcup/ecy8BvyjSNVpVNGspv2O6aRF1M5dMHSp56nSxuKWSqfbA4rA0h+B
	RYZyatYEmQm/2p4T4hF/q97RfOSDkaXSv+RQuorR17TyThsHKGPbSk39m2nX1ppjFV6RJWZoOA/
	GhOvzRp8II0exmMrLreZ0IELcvIpMvIcnj77/f7zNXJq6+qaP3rjdU8WregdXq7c9Jizsz/HcCV
	jFSRi2MfyHEf2liyrSTu1WPHt62pYPnTazu034qMsQPcssZ+bQE+BOyJX5DGFauqQ+gqXQnqQTs
	DobaL9OuUsveN6dyfdgcFiCz87ewOBrJpZLHrfu9wAy8f236VYHc2p4KMySSSEawh5JbqhUqBJU
	9oWvVM3WA5JJR91LughRhyB9y15pKFNL8lZAR8YrVoJcw9RH1wN1KfCKVZaURllsPhrricTJqYY
	lwgRwacpJL4EYayfu9kqPM2Hh3g8Hgne3qs/F6y8T/OBF+rOW+rzps+CmANWnp5awBsnAQGx5Yi
	WHzWntOI77iOnLQFtJhZuyvBnUWaTtK77OSaI483UB7cKdiZv3mqU+Cmd91vXxpCj8If
X-Received: by 2002:a05:600c:1385:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4ac182dc0a1mr60049575e9.16.1793371385879;
        Fri, 30 Oct 2026 07:43:05 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm101763505e9.1.2026.10.30.07.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:43:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 30 Oct 2026 14:42:46 +0000
Subject: [PATCH 1/6] mm/mremap: fix hugetlb reservation leak on partial
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
Message-Id: <20261030-b4-mremap-pre-split-v1-1-c1829811aed0@toxicpanda.com>
References: <20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com>
In-Reply-To: <20261030-b4-mremap-pre-split-v1-0-c1829811aed0@toxicpanda.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793371378; l=3779;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=727RyBekzd9lpkJV+79/5zYip4JhzFujNChohpvOxOc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKbBQKJFRO9eraUD2FoYjwF7jz42WONgsIsbFgra1tdLv93O728OAsAQmmqZtMeD+fhR4JeSkby
 7DwP5nASeUgw=
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
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/mremap.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0d06d7f37f19..cf746bafdee4 100644
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
@@ -1092,14 +1092,15 @@ static bool __check_map_count_against_split(struct mm_struct *mm,
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
+/* Is the source range split off its VMA, to then stay mapped? */
+static bool split_source_stays(struct vma_remap_struct *vrm)
 {
 	/*
 	 * An MREMAP_DONTUNMAP of a mlock()'d VMA needs to unlock the
@@ -1109,11 +1110,23 @@ static bool needs_pre_split(struct vma_remap_struct *vrm)
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
@@ -1162,10 +1175,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
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

