Received: from mail-dy2-f37.google.com (mail-dy2-f37.google.com [74.125.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4292D0C92
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961920; cv=pass; b=I7Hk4cg8V7LgScEix+L9DLdFA3gxu16Ye9YL6Xc9e89kuGuhN9J4eXVw6tVQJmFIDOUBjnhDF9TPGpv311e5CNw9BaT1OQdnFr09lrRCaHQq37i/P1gTo00iFpN+/LutUpWwq5w3YQn6NEyyBEUzuveNI9ef7CNd80WtzPCZpUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961920; c=relaxed/simple;
	bh=iJW5n9lYKhgPDuN4ME7juYxYIrsiTfvzaNpYx8Slis8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I4RtJcqftpoonQRwu4hZKO1GpTguMRws5MQUhzje4dYFhmLkyZvIlRsph/qdjd1T3JpsiAUqhl/gEuqeWSPp3A/+USBeZFrJWhHz9FIk0WOaQ7qZgtNwE/zZOiriDLvnJIrvbvL+O32nfjrH1/80jBosrfylLiTEMHlx4Mtsscw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baseten.com; spf=pass smtp.mailfrom=baseten.co; dkim=pass (2048-bit key) header.d=baseten.com header.i=@baseten.com header.b=HU36yVWW; arc=pass smtp.client-ip=74.125.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baseten.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baseten.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baseten.com header.i=@baseten.com header.b="HU36yVWW"
Received: by mail-dy2-f37.google.com with SMTP id 5a478bee46e88-346c612c7a8so4158034eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 10:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790961916; cv=none;
        d=google.com; s=arc-20260327;
        b=lxBHol06IkHe3FgP75MoQdeSxY5F6GIuAMDCB89jMvaYeH4/zbGuzVS/QzM3osENyf
         IKYm3nmdPWqNZ541u8kzE2vTg3mnbnRSJOPSXh2eVWqgHWloTuMMRfjmWPnmZX2SMeA7
         0vohBxcv8o49zy1Mhum211UuHwIfbUNgZ7rwKF1GQQQ8MuEF/5u7+HzWFHlMEpyDq341
         znHXbZyryv67mH0Jqu8K9TjApdMKBsZmHWT5eW43Ox/NRmKNumF89SppoCfEu8/AWO/1
         r2pj3ew30CJYr1Vwtga7gtTQNaAOpP+1ODt4Do2y+661puj3zaHa0PHieL9c231Brf0i
         BuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=36VoWV3Ti/+vwmY3FsUwjMumBjaKK+gWxVoK8yEZhak=;
        fh=W4C8ekefEgX+fTrfH97z0Q7Kfc1xkl/KYfBySNZVEho=;
        b=k2wAeWLijDUIIHqqsO2unemLjZUDuau1X8dtBuurgfNuh92zjk+IGupZ72rV4mJibA
         ur4iv7Ult9SXqVDy9qxnbSgkwd8aEOyqT98EPQ7Gi/6YhkTGDCLX11QK2xbhf2cSIfql
         xy0gp/fnrHit2nb0CicLPM7N+viYvEIGpTqcVjV9OV/qiVsSF8CEBQg/g2cz8Zd0EZe8
         CuncOcVyt7RQd7zqEaOZjpbblr9DPLvAfMNL0tGUX/J1D7R7CO3SRVSxh85Ee/FIsmpY
         o/AG8cBw2i8dv61abeNeu2i+M1jGVRLvv5ixrESoBjOAwqOdDHxTTa7ExaucayqApdnU
         6JTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baseten.com; s=google; t=1790961916; x=1791566716; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=36VoWV3Ti/+vwmY3FsUwjMumBjaKK+gWxVoK8yEZhak=;
        b=HU36yVWWdLQT9KXSUraZvJS3vC0E4auKiilEUQjK06xKgdJrzn/1hP5fXJEnhVwy55
         naN2otEZhGz3anjBHloQsvTtU9kDrzHxsyCe83WCAPzeVksgxR7ay60S0lTiV0vYsrdr
         tnn3lHLaXnelO8hk0J1afw66pUjHmSPGHLTvZKKnSxwEJD52jQqOifRlCULKxu1arvRe
         cSAPXWgf+rIXF4R6JGM/GPwOQNqvGWH3ZSi34X4c7iaDIQxhTZZvZi9m+IIHsMhQHH6S
         d3g3B6q05oebhbt1nOD7ra2N8m/vEfja0JsepS3piEViUQ8u3A+8I4vM9aLbEphVf36G
         mFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961916; x=1791566716;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=36VoWV3Ti/+vwmY3FsUwjMumBjaKK+gWxVoK8yEZhak=;
        b=vJsvUN0iHgBJulRQll9/BFgCsJHkzJpYVAl4s0vD3DgcAnAMM8WPrsyUh9rhnDyxb/
         bXqkzgXmPMOtEd3QXLm1AgnIK66hPkLM5c8uQjhE4BB2hp+T7FEGzoXb4N84/mG+RvAV
         Yy5c/bQ/pag6oxflet+jDFCAhfOH+g7gN5kM1WTatHL4H+5SQp0KzmEu7xEeSMM8WGrP
         4bTd9iM0xJ5vcIn81e41Up+k9V4XxEAqyGtlrmZy9i7D5tk4Bsmo60rijysTbR/HyiU7
         4a8q5/Eiydfw9QLxevfxGzOwqYoSioIdDQ3VfFUgKC6afZUyqqDslPy+RcBFpmF8Pfx4
         UxwQ==
X-Gm-Message-State: AFq9FYKUDt4J/60pEHO1t2I2VgR2BgM3u71AIRTp8f4/z4b6y2E43Z3a
	vIeWoUZiyEn/YG2dn50mAG8xWAmQBU72BygsfLkSXjjYDdTeVNoVNMCcz57wNNPebDap/MoYSeM
	UbHb55FqzwJCsrKVDhFamwy1JFqJ69n7oBNleMDHLV24Fn4y+1mKwjZnxy3w/
X-Gm-Gg: AYBFou2zPXjGqYkB+Vhf3bjG9KyvvECTXrAVcCw7zhhRh9fSkNGgPOwzwuBv2IAGVVi
	hhdTedg6pnE+Lv9Ea2slD374HlCnatJsKiO4vRLGV3ZmF06zjFogRFxHeWOS65wMTWv/dxvEi1K
	QZkdgi+ZWAYk0aAVQ+Oe2KDvCkMT8uZNbPti9HgBWZLPefND7oy8KDnVPBYCrtqvTp9wcOOCXpt
	EY7n78+OfMYSMJjgKjJamc2uaH+NLvs8ekmCZ3wVLEz34MCMhI5Nv1v9/XSsb0ZNfr8am8ZvPoi
	z3ZcdPcPd8Viic7UUYq3Bz7nBkuiAqi5ONeWSSb/ILl/ygkADudZDQ==
X-Received: by 2002:a05:7300:c38f:b0:34c:f181:85dc with SMTP id
 5a478bee46e88-34f219cc55fmr3705851eec.41.1790961916077; Fri, 02 Oct 2026
 10:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Deepak Nagaraj <deepak.nagaraj@baseten.com>
Date: Fri, 2 Oct 2026 10:25:05 -0700
X-Gm-Features: AclHuK_gu6ekIgZzuPh6tSY5SjecXJODoF0dIZVigkc0eizta5azMmedNW4Fpe4
Message-ID: <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
Subject: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to
 xas_split_alloc backport
To: stable@vger.kernel.org, ziy@nvidia.com
Cc: mfleming@cloudflare.com, Kaz Kato <kazuyoshi.kato@baseten.co>, 
	Stephen Day <stephen.day@baseten.co>
Content-Type: text/plain; charset="UTF-8"

Hi,

On 6.12.110 (Amazon Linux 2023 build 6.12.110-135.201) we see kswapd
panic about 1100s after boot, on many hosts, same trace each time:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  CPU: 6 PID: 131 Comm: kswapd0 Tainted: G OE 6.12.110-135.201.amzn2023.x86_64
  RIP: 0010:list_lru_add+0x82/0x120
   list_lru_add_obj
   workingset_update_node
   xas_store
   __filemap_remove_folio
   __remove_mapping
   shrink_folio_list
   shrink_inactive_list
   kswapd
  Kernel panic - not syncing: Fatal exception

6.12.103 on the same hosts does not panic.

I am not a kernel developer, so please treat what follows as a lead
rather than a diagnosis. It is source reading, done with an AI
assistant and checked by hand against the gregkh/linux tags. Nothing
below was built or run.

One change between 6.12.103 and 6.12.110 that touches this path is
789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()"),
which landed in 6.12.109. The v3 posting of that patch carried

  Cc: <stable@vger.kernel.org> # depends on mm-hotfixes-unstable patch:
  mm/huge_memory: initialise workingset state before folio split

https://lore.kernel.org/20260804-add-gfp_account-to-xas_split_alloc-v3-2-38cb3ff325c5@nvidia.com

The commit that landed has a bare Cc: stable, so it seems the backport
came alone. The dependency, aca1f2d5de17, does not appear in 6.12.108
through 6.12.111, and I do not think it applies there as-is: 6.12 has
no xas_try_split(), and mapping_set_update() is static in
mm/filemap.c.

If I am reading v6.12.109 correctly, split_huge_page_to_list_to_order()
calls xas_split_alloc() at mm/huge_memory.c:3524 with xa_lru unset, and
now with __GFP_ACCOUNT. My guess at the 6.12 equivalent of the
dependency is to inline mapping_set_update() before that call.
filemap.c skips DAX and shmem, and shmem can still reach this path for
an order-0 split, so I kept the same check:

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3521,6 +3521,10 @@ int split_huge_page_to_list_to_order(struct
page *page, struct list_head *list,
  goto out;
  }

+ if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {
+ xas_set_update(&xas, workingset_update_node);
+ xas_set_lru(&xas, &shadow_nodes);
+ }
  xas_split_alloc(&xas, folio, folio_order(folio), gfp);
  if (xas_error(&xas)) {
  ret = xas_error(&xas);

I have not shown that this hunk fixes the panic, and I may have the
mechanism wrong. Matt's report for aca1f2d was
VM_WARN_ON(!css_is_dying()), which is the same area but not the same
oops. The distro kernel also carries out-of-tree modules (the OE
taint), so I cannot rule those out either.

Does the missing dependency look like a plausible cause? And if so, is
the inlined mapping_set_update() the right follow-up for 6.12, or
should this go somewhere else?

Thanks,
Deepak Nagaraj
