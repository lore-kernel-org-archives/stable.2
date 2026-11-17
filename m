Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794883161;
	b=eQ54RGYnImpCkygIlubiP2Sktv5GOq4rdeT8Pt67EZ7SmpJ5Ayx86l4DHhzAsQCpdDbQ
	 yXQ7ms18hzRfKW26yUhfiKe51Y9fYf175sXU1IqHjN0TMu/q1BGD4dmlZ6zvFwoN0iqWq
	 uBMx89Iy33UzYkYu6D0JpLK4zYvTlA5IVwJX/7JXPPJDQYKhZIWPlePdTCKEgx1bIvMUg
	 5nb5M2RxUnt+V356bvpFSeFZ7U/TNTDVWSOYddVVVWpyBD+rRmtovRfpKt+a9GdOAvZyk
	 1DeUcCYjVnxEvLQ+nodrp1pkgD3ACK0FJC5eDS+2IazfYy0/LuKR/gPhmjmmEj8bopg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=W3iQeyj5kHA8i7LNdw/GpSJO4XwaLwyqthlK+YVxrcY=;
	b=hztWd2XHlgq5R+xJlAdCWHuTBUsHbvdqKqjtgoap48hzH26S/IB+PdAV80cdiWUQsJ5H
	 V6kIWI5FDZR8BdY3zR+wiUhPFf1y2OL16UIN+VfVdXlWPS15g1VA9Gzi2DNvyyEw2UgM3
	 xsVjoi2BpdTVvGR5k907t/3C3eJd+ZUac4CAwl7V2oRyrwlUBObPm53pKonhKZsG6f7Lf
	 XvNOQhHKH34HqPtdYXM27OuN0GqwSX94qfa/xfCURVxGxBryfwf6wYK2qVBFL8Opm0+SR
	 OCpgLkMcRxyCgQsXRdBQAAVI21Vy/KBlzHM3r5Gq4iCF3ngpr8jyfolT01qh3dIqPhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=thundercompute.com;
	spf=pass smtp.mailfrom=thundercompute.com;
	dkim=pass header.d=thundercompute.com header.i=@thundercompute.com header.a=rsa-sha256 header.s=google header.b=o4J9B2OB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69010606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69010606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thundercompute.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundercompute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thundercompute.com header.i=@thundercompute.com header.a=rsa-sha256 header.s=google header.b=o4J9B2OB
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be47aa555cso4504979e87.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794883159; cv=none;
        d=google.com; s=arc-20260327;
        b=JqhleU1TKxMElkwNkKA9CHmFKnVWg8NcXyvfsmrRFMvzVWDi76T8lfMmAoYQMdgahS
         QmDr/+TubfSM3whrS7YQd6pTym1d8UK9SExpbDaDgh1zh570dasVU1zhZCqm+AdCzaH1
         keCzDDD0dp4/nurgc96ShsqxjVNI5MVPsvrJhCoesUG87jp9Y2DI7L+dXKT2gdo153C7
         u+5acPyWE5erK43xKPqFOQgoI68Uz839dQvxpuanux0pQ3I0Z1orEkuuXGfEX/3DlOED
         22LyVXPKWZG/s0QHRlxAFn8G083pvMRbABheHO70LTNentCLEIfwtXXTwnTgC1zYfESX
         CWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=W3iQeyj5kHA8i7LNdw/GpSJO4XwaLwyqthlK+YVxrcY=;
        fh=Z/1IohaFOItMmltdeuz1gi1OeXLBGBRUc237jTBJW3E=;
        b=XI10czfFmrOgdhNAqiUcVD+oMlqo1OMpXrq7pWnYWr+ZV+Piazsduk3fqasQNl2fNr
         lj10V3e6Q8TbtT+sYYQ5ZFm4u0Hkku6JUXw11dLOFUr6lutlozj/zBkMhGMEaIo9DKdx
         FGC+6Ab5mOexUBVwdzy31Dra5Iv1Xf9skrGZ5Na2ZzNzAmmxUHNG3njg+U6ftWwBTZyu
         OrQq0TX3rU8OmyiGDxafsIJKK5XPP/ReM2hVLt479zXrhVhZx+i711N4jToxYfM9G59/
         RlHebdb/aDbopqD+XKzYauEorlJ6shg6ag8sEJCmDxOVzPfk/As0rvgMM4b9ARcnl38U
         yhjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thundercompute.com; s=google; t=1794883159; x=1795487959; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3iQeyj5kHA8i7LNdw/GpSJO4XwaLwyqthlK+YVxrcY=;
        b=o4J9B2OBiZwX9esQAsXpEC/F1qNsFHaGsNHOMB8Ky9mo1AZ/tuMs2EC9tZGR8oaofe
         MZnAFzSR+lpNBlI1LZn5K73s4ZKojfRJ/Bdq2z8r6qjTKWXmXVntj0MmEzmysU+ebrQR
         cSNePsGR9yrI4R5sFPdBdArFzFV49xPvCxL2H0KbKxwiDzI90mrgLfLDDFiAmN8QnS0b
         JymGwy4DWFumsF8l9iXUffdWTyvBdCTCKRKN6S3rkNFmiW8k8/8kHfowTYEr+Horv/un
         7dCQgLp753gahp4odtJRj+QbCUhkIBAYtEmkznhX8R8VnOlK4pcBxnCZ5slYOWPyJBfj
         NoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883159; x=1795487959;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W3iQeyj5kHA8i7LNdw/GpSJO4XwaLwyqthlK+YVxrcY=;
        b=2aZJNbzPJVMuBSnSJ+H7FtjysL+WWwViLu4gZ56BD/HtQKaqpmC41zFxNyi7R9j9p2
         T81fV0MPzpHsoG/ZuRU54F9ElvvG9LNJD8Dcc+q6VNB2Gp/sxmnyDuGJKWyvu3LeriNA
         f1mWGZP8MXTkwpwQIfwY1O1X4r5N5NnP4h1EP3k6kQlQi0WLlGybxO+mcHETgbCRY7l8
         DmzYzbGFptOUlVkJpxkDZ0bPW4pwxPvR4rz2u4eRntA56pyKyImaOAwGUudui6KjpPpp
         roxwAwTnoOaCNYORh77fOLbCgC6xvaWvn5OJLxlZnkBmzOru1ZauqFWPRfAxY/8lDd8s
         O8gQ==
X-Gm-Message-State: APuU4Z/FC0VMJv4E7ixA5OP6gMRom2ep2abeEqJCZikuaLxpXgD8lelE
	qquIn0ZfNSFu4L93zMVZe8KL6oxiXR54vRdp6yzTXSJjWxpp+iKSBbQfI/fVUm9bjlh1u6ux2tn
	IPjqB70ZUqLAkIvnvjoma7zaCmlg87hQVUeqe+6CB7Hn9dWREUvEKI48=
X-Gm-Gg: AYBFou2QjXmP7bS6qXi7AnAKpropVbZT0OXdsrOZIvCUSYuFfqkt9VSpHn+LTLqeLUu
	mJdhIMLkekLYR8y/TT99NBsaPTQVZKexMbmJoDWU/1Q+scGiKIvqYb0R1gnxPQmU56Rji3SCKhz
	iXOtTdfOazZurX/4tktfpVrn5QjrmNDRaUDLnH3/fVopPhB599/5F1F8MJW4yRjF31OF72mm8cT
	nUWbAiLXfE48cspoq1pFS3GrcqREW6MwbQgTFSMLW9uidv5O6wuOiVdxiwFmV9nOqZv1/hq8dzo
	MNhCkTvWkn7UBXPL9m7Ur59B8/Pjkw8NBtdnSfs1gubA+E3bZf+qCw/QWepQ4AeBGv6f6lKBd9M
	Xqb8EJaJnR1ELkvx5mQwXcsgT3BsDwaurBbBCWDeDgefaRr/ScC1V8LLCRx1J4Mgi/JuMzcXfj4
	lJWlAq/JQrIU5wzJnSOcGzDFLspsIgmY3SUYIG2LuKnAiwWEOs0H+wjawODt4ZrP8NlJ/UsHbN/
	TS77JiSeeYKEhXdjz4=
X-Received: by 2002:a05:6512:618a:b0:5bf:c4d2:b074 with SMTP id
 2adb3069b0e04-5c170a159camr4783685e87.55.1794883159435; Mon, 16 Nov 2026
 18:39:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mark Polyakov <mark@thundercompute.com>
Date: Mon, 16 Nov 2026 18:39:08 -0800
X-Gm-Features: Aa3M54o62zRPxq-_tXfhcY6Zgma9ObTMS_OIn5JcKten7oxKU7zRiaBe3aoCxhY
Message-ID: <CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com>
Subject: Backport request for 6.12.y: mm/damon/reclaim: use parameter context correctly
To: stable@vger.kernel.org
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi, would appreciate a backport to 6.12.y of the commit
fed48693bdfeca666f7536ba88a05e9a4e5523b6 (mm/damon/reclaim: use
parameter context correctly,
https://git.kernel.org/torvalds/c/fed48693bdfeca666f7536ba88a05e9a4e5523b6).
It seems 6.12 gets backports of most DAMON fixes but this one must
have slipped through.

We've run into the issue fixed by the commit on 6.12.115: A guest VM
with DAMON_RECLAIM enabled but no reclamation occurred. After
backporting this fix ourselves, it started reclaiming.

I can provide reproducer etc if needed.

Love,
  -- Mark Polyakov
     Thunder Compute
