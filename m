Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEEB40F731
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790966087; cv=pass; b=FvO9c45Zbug+Dw/xcvf/qHaNMDmTxQpTfTDpid6hjyL6KSHzE8txeNo9VjlNxeBUdO/wf9gVEO1KsiUi8yL3eCTR3cF8epZ4J39fD25AiqmMnE1ZOeYT6medOfoQvCW0foPaiULcmCjFC+TbJHkOVrWkKy+w+JPrQhVwAvhnFRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790966087; c=relaxed/simple;
	bh=VXBoZhnpkXEYdNp9vQxMLiTkrfcHALG/eUOsIAQW6QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWUzhDpQRyhKTFrCfFL7dVVSdekvNzMlNs1DHUzv7/oBtilZk3WQw5axJLaD0isHwtNw9HrtupqjQE02bQHMdwKmftBMXP+4MLKOMcDIHg6WeVAsgKvYc3XQTnwtgjMI7DV8kKiJhBSqZYjzPfuv4HCTTTO5X/+h04CQUPzkgDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baseten.com; spf=pass smtp.mailfrom=baseten.co; dkim=pass (2048-bit key) header.d=baseten.com header.i=@baseten.com header.b=IJkvT3Hi; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baseten.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baseten.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baseten.com header.i=@baseten.com header.b="IJkvT3Hi"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b3e517e6dso2393733eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 11:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790966085; cv=none;
        d=google.com; s=arc-20260327;
        b=pOXznEr206cS/eXJW9gbkshGazgmPcc3pfOSlZ1NHuVAG/lm3VWQkkNQJsD1HQD/XU
         qTxkgIDoxHp564EcHNqTLD3b9rZFckwBBV9pSzmxKUOj0k1WmrLILWd0iQhZQVnvkEJT
         kc8kRo56bylGKDnEAjqFAJxGJxcknc5SyUXp+6KgmCItLAcOOtXvuU3skNYIbYc2oIt8
         CX89tDI8bxb9b4FjNb9xQubo98/+0Jb5dpmA/qkj9eSLZgURWx49lDEkQWBkrs/ZIzQA
         8hnsTOljwCeiYe/Pzd6xAXR2DX/iENySvI8M/bLg0U1wJ289CB9xre2VKEy224+SSRrx
         duWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FRUhuT33Hvyx9UmpoV2KcFpLk9yCWzv2fyzX+ZRYaQs=;
        fh=YprKSC+DYK3+Aw+Qb2LEILXZ/dXKBt1CLjR4Mz4+ByI=;
        b=iNFXaorNLZ0UCEa4YpjNaUNwEzUHJrSXP2lpExK2aVUeDDynYZ1Ki81pIBz8IHPYX4
         FJNnqCYwOIA9WCPmcDsbbZcTmJyx/wny51qhEJ/arL1cUQCZO/F7uL9/AdzNmxiF5VbY
         y7dddVr1pqV+HufudL7qVPqciECTQgMBJr5hfdAt43lhbnvV6IWBVyevdEqAfjmuXIRa
         Q6EM91Y76lSskxrgS12mpLYFGXxYTL5Opz8LwmYro9hLLq5FlV6c/udBRReHsIJVDh3o
         0MHdg76eaDlH31w2ginbYp1ZhJW91S1Ddde9pQABapDF5QqASKxLcQBrEcgF3JupoB9m
         TaHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baseten.com; s=google; t=1790966085; x=1791570885; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRUhuT33Hvyx9UmpoV2KcFpLk9yCWzv2fyzX+ZRYaQs=;
        b=IJkvT3Hia4Z2/lVG/ymfxcdEUQ/G9yEVyt1Jup8Rg6kwj6D3RLTExpg2cI0qNHzvfY
         xUlqnYEl15+EFFwuXwXyLg4a1v6XW9VD6ZF2fAuRgH3VarL7sjxQHyXmhIoi6vmnqVva
         G37VhLwL8IeEEHARHn7pi/h1vNHEtqc6BHGRI1ENW9zEURs8kAijjfdROGAi65icCfQm
         nCWfNCLiPB7nuXE7gqJgg0hmPBPuGZITS/kvaNgWutYOepyVr9vjpJSQ1mu7mKGN+mxB
         tMQKYHm/WxL7hj0KUHCsAAGcwDhqt68J9WtpHqc/oX5AniC3/a9QRBgScfNRcZXU+CbH
         9BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790966085; x=1791570885;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FRUhuT33Hvyx9UmpoV2KcFpLk9yCWzv2fyzX+ZRYaQs=;
        b=f+bAvJHxT5xrZB8hnwZ32IvSxRNTrEGBqil4g45nU+dxdYxJBa+5LpSpL9uKY7gmwZ
         JQh+33byc0pClO4GhnaNfkkwhx7nql6VyJFjLPqY2tkvfBr1qFo+il2CiPQjCBGkZQBW
         AgOsQWAzs5nmeEztDXO5RiVW45opBI3jgCNY9obNvBWPOHrel+JnPXjLbe0c84kJqwmE
         wsN00+Uh3KRntb3RDfcO/RWRAhsPlp9FGspjvMeo2AC+nTxr75+0EtSCKxT3SPhc7WEE
         9uKGyUVc0L2MXm8fQOL0+y3RoXfAtnTweZRWmM8jqKTaJ1+QIFXynv7VkXjLAn4Sr56v
         gX1w==
X-Gm-Message-State: AFuF++mFjAFF46+HGQpRIOKUJ0VJWLyX9oQZEf7i4Cwp/emZBVXCGCOx
	i11PoD4RMAamhM/et6skyoVfKdHIRXkUlsBwH9cNaQ/sD0/qNw5yMIwVWWhYZgOkXngkHrPF8Xg
	xeKrnT1d/KUYKmbnaOpm3jo7EVbw3mZp2AgUkPkTmIA==
X-Gm-Gg: AYBFou0jEC8RU7jONzAfR4EzUlWR/fxFHx2gz9hCv+RbdM8RsJgWVhmw6P2zAB3Ky/q
	UZ0MnK0NGOFau1SVB3wol1DbFgPuqHr8xBEe+jjUImBZkHe3Vl8TSSkEXHz8dIc+LRQ8R9Gyo5J
	Vstvw5MWIDgUEdEipAB96sPkRAZ27vd3RJuv37mZhMzS8uDrIHtdfRfwIyxYaZEiLpPpVfrpDJA
	DL5Sitrwai1L1BnK/9yFRaMVxnDEl/9d9HHOQYu0zk/Hjv/1MzbMivYww+mpeptKygxDqMcltA1
	/tW8ppKgkWBPUhAEUKh89bPA4B6pPAzUU/KJ+9ZY7u18kQuJjT/HwnxzRXQ9BIl/
X-Received: by 2002:a05:7300:fb91:b0:33e:4475:5e02 with SMTP id
 5a478bee46e88-34f14488781mr6316608eec.5.1790966084533; Fri, 02 Oct 2026
 11:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
 <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com>
In-Reply-To: <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com>
From: Deepak Nagaraj <deepak.nagaraj@baseten.com>
Date: Fri, 2 Oct 2026 11:34:33 -0700
X-Gm-Features: AclHuK-uAmXfCGozMAa5rak8cC_9fvKthtakmreZBGGyL_uh6rOPcWQRaBv8DxI
Message-ID: <CAL3JwHN34En=iiEB+Zyxo3=_xfODTY_k_kddb2njN+AJwSCnnw@mail.gmail.com>
Subject: Re: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to
 xas_split_alloc backport
To: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org, mfleming@cloudflare.com, 
	Kaz Kato <kazuyoshi.kato@baseten.co>, Stephen Day <stephen.day@baseten.co>
Content-Type: text/plain; charset="UTF-8"

Hi Yan,

On Fri, Oct 2, 2026 at 10:38 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 2 Oct 2026, at 13:25, Deepak Nagaraj wrote:
>
> > If I am reading v6.12.109 correctly, split_huge_page_to_list_to_order()
> > calls xas_split_alloc() at mm/huge_memory.c:3524 with xa_lru unset, and
> > now with __GFP_ACCOUNT. My guess at the 6.12 equivalent of the
> > dependency is to inline mapping_set_update() before that call.
>
> Yes, it is probably needed.

Thanks for confirming.

> Why not just export mapping_set_update() to mm/internal.h like mainline?
> split_huge_page_to_list_to_order() then can call it directly.

I tried that. On v6.12.111, mapping_set_update() is static in
mm/filemap.c, so split_huge_page_to_list_to_order() cannot call it.
The patch below moves that helper to mm/internal.h as the macro
mainline has, and calls it before xas_split_alloc(). With that, the
6.12 split path lines up with mainline.

I have compiled mm/filemap.o and mm/huge_memory.o for x86_64 against
6.12.111 (defconfig, CONFIG_TRANSPARENT_HUGEPAGE=y).

If this looks right for 6.12, could you Ack it so stable can pick it up?

Thanks,
Deepak

Signed-off-by: Deepak Nagaraj <deepak.nagaraj@baseten.com>
---
 mm/filemap.c     | 9 ---------
 mm/huge_memory.c | 2 ++
 mm/internal.h    | 6 ++++++
 3 files changed, 8 insertions(+), 9 deletions(-)

--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1526,6 +1526,12 @@
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
+#define mapping_set_update(xas, mapping) do { \
+ if (!dax_mapping(mapping) && !shmem_mapping(mapping)) { \
+ xas_set_update(xas, workingset_update_node); \
+ xas_set_lru(xas, &shadow_nodes); \
+ } \
+} while (0)

 /* mremap.c */
 unsigned long move_page_tables(struct vm_area_struct *vma,
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -125,15 +125,6 @@
  *    ->private_lock (zap_pte_range->block_dirty_folio)
  */

-static void mapping_set_update(struct xa_state *xas,
- struct address_space *mapping)
-{
- if (dax_mapping(mapping) || shmem_mapping(mapping))
- return;
- xas_set_update(xas, workingset_update_node);
- xas_set_lru(xas, &shadow_nodes);
-}
-
 static void page_cache_delete(struct address_space *mapping,
    struct folio *folio, void *shadow)
 {
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3520,6 +3520,8 @@
  ret = -EBUSY;
  goto out;
  }
+
+ mapping_set_update(&xas, mapping);

  xas_split_alloc(&xas, folio, folio_order(folio), gfp);
  if (xas_error(&xas)) {
