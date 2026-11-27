Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810368;
	b=RjSbC/f9igrmjuy4dyDBlu+SKZacQlTYVE7peWdmX9sIQ4xM7jw56EdAxJPw8Yu7g3ok
	 3V5v86R/xvulkOx8eT5jpJQ2/tNGtteKzaq1dRqtC4R5RFZ622szWHHT/r1qlCVuUxAFX
	 QtimNf/rZ6BHKnA2iDqoDEPnrwnJcjUxOnp4O5rErGVMJt7BafcBSK042pj04uyA4bbkj
	 AYYt6eN3xZbO+9lUgB2jUQrm9kmJcUeR6+jkoXgulJR8ckgpGtaNd+CnyR+A5qo38mJ80
	 gDL1A1N2bG0pqhQ7B5nqf21JTo7kVg8Ww8jHYgLUur5h+VjTjdi0TB3cfkISeXDIM2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810368;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=LYceGOXzN4hiBJZC1Gl2vPJRF3wXxgb/h1evZjNGMfA=;
	b=KvyCXA16uNQqGL/M2JgcNHCC2r5HYTLUfmSGkAuT2FY5y4u7Qid3vU2z/pgUYedrNqBu
	 CzF/SjOSKoKKjFTyv0aUqDgzpjC9WnimLyZTCvMOaG/BK+9T/+YkASVL7cVOk9xcC/hFJ
	 0Gzl3K7eQDr5xlLlpB1LbjbuWEG6hKqzrEeSepBiTZcKab6NggRookMv9aQoAGrPyXYw4
	 lBnxu2l3hV1RF7ugJGgmm97pe4taQw6FUqofXa/S3YkHwQ1mvX8KHk88TOoTZ7WZPKigC
	 UIGwtKGyPy+y5kyuydPRiK4Q9QEwNQW5mrWEr8Dj2ML+o7H1+ke2xQIpLnOUzfVXcQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFqTmVod;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C1606A323;
	Fri, 27 Nov 2026 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFqTmVod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5141F00929;
	Fri, 27 Nov 2026 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810367;
	bh=LYceGOXzN4hiBJZC1Gl2vPJRF3wXxgb/h1evZjNGMfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MFqTmVod5hzkGn4ZfBotiC8ehNkVALKRz70n+huCUEHtvDSRMiVrEmrYvpgazjr+a
	 o+hPkekFfAWN06iXJTm8uH+SgSvbw46/KaNwJRU9v0kgQpGBQfieb/igf7Lkejc5s/
	 vJ/AEaFQjxjX8mTSU6ZkCJGDjFM1n03TOMcWLAedv4JpwHW/No/zXjz4lljCEWEqlI
	 bG1+SYVayjO1UjiWM+XfZfntV50QIK519F/SiMzLDxgHIXd5OfcivzrJnZcSKegeHo
	 Gcpk04V0GvUSbg2KRWzgx16K3pBS6t8jQjwKDoycGTSzQC8bxfqPdzImcohMBSmBJ/
	 hxZui8HihKu8A==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Fri, 27 Nov 2026 21:12:33 +0100
Subject: [PATCH 4/4] mm/slab: clear stale layout values in
 calculate_sizes()
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
Message-Id: <20261127-slab-ai-fixes-v1-4-cf13b6be6692@kernel.org>
References: <20261127-slab-ai-fixes-v1-0-cf13b6be6692@kernel.org>
In-Reply-To: <20261127-slab-ai-fixes-v1-0-cf13b6be6692@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Chris Mason <mason@kernel.org>

With O in slab_debug, SLUB can place the slabobj_ext of an object out
of bounds: in another object, or past the end of the slab.

If debug metadata raises the minimum order of a cache,
do_kmem_cache_create() drops the metadata flags and runs
calculate_sizes() again, which has to recompute the whole layout. But
calculate_sizes() only ever sets SLAB_OBJ_EXT_IN_OBJ and s->red_left_pad
when they apply and never resets, so the values of the first run stay,
and alloc_slab_obj_exts_early() uses both. For kmalloc-cg-4k with
slab_debug=FZPUO, 4K pages and no KASAN:

                              first run    second run
                              =========    ==========
    s->size                   12288        4096
    alignment padding         yes          none
    SLAB_OBJ_EXT_IN_OBJ       set          still set
    s->red_left_pad           4096         still 4096

    slabobj_ext of object i
        = slab + s->red_left_pad + s->inuse + i * s->size
        = object i + 2

The fix used here is to reset both values before the second run. The
s->offset is already reset that way.

[vbabka: consolidate the resets in the caller]

Fixes: a77d6d338685 ("mm/slab: place slabobj_ext metadata in unused space within s->size")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Co-developed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 9bb031f9a41f..003023b6f8dc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -8860,8 +8860,16 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 		 * order increased.
 		 */
 		if (get_order(s->size) > get_order(s->object_size)) {
+
 			s->flags &= ~DEBUG_METADATA_FLAGS;
+			/*
+			 * Reset fields that the previous run may have set and
+			 * now might be different.
+			 */
+			s->flags &= ~SLAB_OBJ_EXT_IN_OBJ;
 			s->offset = 0;
+			s->red_left_pad = 0;
+
 			if (!calculate_sizes(args, s))
 				goto out;
 			/* Created as unmergeable, so it has to stay so */

-- 
2.56.1

