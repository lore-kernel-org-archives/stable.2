Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663178;
	b=wSvN8y6hcTdTCl9SL6iY4OvVDweIzrvDewvrtR/fyoyceyS4MtLxFtpy+eEff9MD+jdR
	 tc9cMROKRK4LX4BhfbwytNwuaEBlsanwL2oSRp47lycRcDj6ziffgMPpnaU7YxxBQY97b
	 fmQX74OPzR15BRzE//1E21i02vQr0M0nXx878HmGHS7SwiBYJun53Sg8HTzsUvox1nGgJ
	 A9dwLTG54zki4ApeDSOAgIY3gFfoDFclaYSSLLKKKK/FyJ7n9k+I3fHPmjhnfNnyQPTzU
	 nKMvdmQEL0Esjv2H+9H1i3MX6cluVJELtSh9wTT9VtIzLBvRZda0Pt+OUzLrMmbqg6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AmQj8uwBx2GfeOV7bhqZUS7hhPWLS2NeFKbOTCeICMQ=;
	b=CjCrLRcGtH4yj86bMzgbsViV46FNQe2snlzin+/mxmCtu6d4YUsy61gg/LRkY+4jP3js
	 OL5c6fnSCErHe+8LDLuD7mS6jsJr1cfoeVrivMN3NqfSH1HeTxZIQhH9KgqsA+OcbmHZl
	 x0Lc6JYeNWTVHAvTuhOOiGSBa9F4pGjP4n0416k6xdFEG7VZNlJvEavNk+ROhaXcJPRn2
	 h9PZHcttKpdfsF3Wv819VkeFe/V2El0ICoaHWMS9XApjiS6CQp5uszX6dBskwzS2RzLB3
	 PAVsF/ypUTVi1kZp8d3qagDRRFFR4Py9J8+Z5fk/D6312x021Eqfu0dIs9UoE48MqHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=qNbVhWm+;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF750606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF750606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=qNbVhWm+
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53644ab1f7bso32463141cf.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793663177; x=1794267977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmQj8uwBx2GfeOV7bhqZUS7hhPWLS2NeFKbOTCeICMQ=;
        b=qNbVhWm+ke122SQXB9MrBng4L7WoGUSueMsGQYZmeW2ZpnSYtsvYguCVXC+gLB3ckb
         pWazlCsGj73QzqVCYWiUTx2K6MuGU82Y/+XCxS0fERU6tC8yOaicuTzU8dQluXV9JSQX
         Ckb9/gUR0O8MG9cbNtgPe1C1c3uqCJbqOeCui/lrqxd2MEfaxx7wqZPjtD8iqsUGpJUT
         RpU2UJJcnxD+BGaC0fxiFyoGILEmJzgjKZYQl5O/0i81DkB4mHxd5n9TFr1mPxEO7A8j
         BpOysCU28SZ4OGF0U9+ioqx+O4EWuXn9JwEiPx84Ju9XAHjsn5031CN66Vhj554TX1l3
         y5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793663177; x=1794267977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmQj8uwBx2GfeOV7bhqZUS7hhPWLS2NeFKbOTCeICMQ=;
        b=cxfiz4Iq6SRU6y7gdxwdzlmQ4lBjrgDk+vU4MjmeonGMYdxNfTK7E5NpeS1G8Gxk7R
         KurYe4wYAD8nOJSLnm4xlpJSLiLnSPv1hYiRSQ/9u6oKYLr8aOCrPFiBSz1Q5cCN7SWB
         vK+67dHKmmEeov+owi8klmAZiVWy+0y45YYXLIQpayWetWktz9exykzLgTaCK1CR6Ax1
         cso7qxfZXm/KwXZOnbH1yJfHIqv8t3xv/a5CeKhrQbhC2YskE6evXJOCHSr1mH87oDRt
         j9kcfTQblomRrmf9F5dMw+HJu0ktWT5bPRYPCKeKJW82KTJS5WK4PV2ZZb/F8MuWXRb9
         2EYw==
X-Forwarded-Encrypted: i=1; AKwUvBzyLIRGe+7XKqOQiFVp9CfBL0nNG2IeBpYYh2WuO7avWFE1DtXS3IvBU2z3E99hE8oVCO35OO0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s6bebBa/J/mRDYY7L6vp4/bnW7KmHxC7pf2YPj8Rt01dQ9Jtc
	G8teh4TUWhaR3sq+7YBufxEEN/jAZyinngaOmZ6jxH+OLLZgvX6j9uDRKLf+XQVbOqE=
X-Gm-Gg: AYBFou0CpkEDlEug6m9MGap5bL1BD91cRAeIzSYEN+eH7CMQBvpIxJnCHvtJJeEC+Hq
	2nYEMqkRwgFn5kRO4ogxW1sn/3sPqM8b5w6upguVh0hDB2UqSd5vSs4KdHWlxkfV/woMymG37sU
	g2jJmhNuS5rAd8PTGllNR3YZKQa4ZgRhjFy5Iwp8sO77WUaKr7t0+O0slNp6jnQUL6cCo/Sspta
	NUDKwaMLHthWUcXLIqab6wSL1IElmLx6NeepLcwS/zPgplFnb0kD3U0T6IJEK8um8P/UdgUwmeP
	zrlZIZcrojXUSqd4dJANPq9E7UgLW3tOMyWCP1GKRErmrqE3sK9ZAHJN5LGd+A02npdfmDXWnPI
	2R+WEg7bVtl6hw8Nqxy4ktSke6wm58QLSVOMMqCa+9UUUO3OYi3Z53rjy9Ftpz8090E2+UnB2DU
	ceSfPI/BZXW8XarMQP0B6tn0WgI1DuKOL6QMWV+k0voxidNfWLih6KctlVZeeH8QSkMZY3EKBSM
	lFRnCo6XV95AT3hYod8HYtSy28Q9e+y8vYI+YdA8ScZVhKoYnwRS5bS9++vBSr19EgJynCJFAJn
	U/9XwceQEzmEMsIWtPEZVdrT/3Hc4WF879aagMwGwivjqYs=
X-Received: by 2002:a05:622a:514e:b0:533:8900:4eae with SMTP id d75a77b69052e-542b6689b0bmr183674081cf.13.1793663176618;
        Mon, 02 Nov 2026 15:46:16 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce1dsm10765531cf.5.2026.11.02.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:46:12 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 02 Nov 2026 23:45:57 +0000
Subject: [PATCH v2 1/5] mm/mremap: fix hugetlb reservation leak on partial
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
Message-Id: <20261102-b4-mremap-pre-split-v2-1-d281dd11ad7d@toxicpanda.com>
References: <20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com>
In-Reply-To: <20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, linux-mm@kvack.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793663165; l=3765;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=KDPLb1ZOv3/5QJLviNYXmvAeGyiuG+gD4HjiBsWGw9U=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEv7pIUqS9Sy81RCl1FzBVibWv9b2W9xS3EI9szQ232/V3lF5MIsdU1x/nrbQ9F1BlsDUxdBI+P
 Yl2tKP+3tRQA=
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

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
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

