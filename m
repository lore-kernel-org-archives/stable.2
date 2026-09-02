Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31813EE1D3
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339732; cv=none; b=n0A41Ad84kQG0/MnFYAI/vMHZbo/jmIiSz47n2gIn9RIDBINETFWs63J6ooiCWXk0B0IdjXdU2DutQczreDYGbqbM/F+Enc7Ii92JVJ9UOLcYyqfYVQjHOO3iwPUBAlKWluFnBsgUBRbC6Xw1ykNHuWHbspjtmV03BkVsgFKhSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339732; c=relaxed/simple;
	bh=LE1FGay9sT7mvcDPSk+q0IW+U2idHpKGbrIWVgYjQao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLMEqsX25xj6R6vZP3+4ARFW0Mg8jTnQcSKIfGG6RX/hK+pgsVUL+5fxGBweRQS4uPrw7V5yct3/UAT22USdm6S0rbhDtTPlNlBcW4H31VE7MFuLQYbW8lsIi0UwxV5IvJhYyB+OYngERNHquq2PZqaWQOmaus3tiDvJMjffiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkJyrxRa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkJyrxRa"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso838309b3a.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788339729; x=1788944529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fy8D77TbbTZZuJ5DhR2JoC+KqjSKdSPnzBcIAoctkic=;
        b=jkJyrxRa+3fXokTj3tIcKafUOb1XAbk0nHOEmSiJwF4zw6TEXteEs6O+sm22jRGZv3
         NK2yRRSwY7peKCarFp6GRs1Tv9qCFZtY1s4ShfL3dhVXctL42UPGq0/oNX6Z86vaaI9o
         /OxzRTcQTuMyPonZwLogHOA7/gpojovVjUB83NrBP2axB0OXIu4EyNIAcYZ11MOQNDN/
         pFfXHuFV0MUP1U8Sb83cwKDu+lxhX6jCzftZNxsjzam1cGfk66jpPMCZSzzV+BRu06hq
         bYWEW2WMfBe4mMt/idcieM8LPS+GFCd0uOhtJmb2zNjov3wr/QzslcjP6hdg31p8Nq9K
         EakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339729; x=1788944529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fy8D77TbbTZZuJ5DhR2JoC+KqjSKdSPnzBcIAoctkic=;
        b=opwF87eS6Lz3LglWcP22TAOMTEYkQ7+D5OB44XUTjYY/xD8z2iJ/2hV2qSZlI88at8
         Py+5AHTBWeJB0Lm5tsas7IN4TTMWDGSJcTPGlklw5uR+1A8jINfxtWTfb3DqnJwJL0fY
         NuwLMJTSev8IqXM86ZXMvMHwJh1b8fr4ANZEQ3iJPP571iBCIV9GynAkSBFbl1hHgWmY
         DB67rzrEwH49DGDvrK8qI1r3nd0wehUG0Hq4WvH23lCKA0s/SktUK3rGyxrmxjYfTFYD
         x8Tq/48aD1o9ATV0bMn6yvV1C7vTcm62Pa5sJMwiocu+HAiMlP2+4ZvkIa31CFMb5l1v
         adzg==
X-Forwarded-Encrypted: i=1; AKwUvBxGwvzb7r9hFkrLHrb2D7P67xwdWeYIab2Qb/V3xKMxZL3QpVV/ZJHVSQ5jmzdaTZWENsizRDA=@vger.kernel.org
X-Gm-Message-State: AFuF++nER7IUkIR/BperOXcoEnOjFwMPBRDy750tfQYjfRb5HBsyjzJy
	7L++NuxrQRvrru5MNFq5urZJjsTkwBEWD7lrF3zR5JIB1z8gy1cdqQy0
X-Gm-Gg: AYBFou3S13lgny1zobfEyOyNIKiu2LhZoTMlAc70VIkgKmboXotDmYMyztaImdjHbtI
	KNeGdYfuCVRvSrr3IA03YsdBqB2GrmR/nHHlBc+hSmZ0bREd2d5QJ4H+AINH2tBFnkt6EAMVgwF
	DTyjjFCyT1aE9IjtbZ5unUFxySkDQctSTb2O84tibmMY0qew5og9MW7m4yeqzMgLiWw8aL/Vhuu
	RnYOfIGsLwV16Wzu19z8n/MjGHXKl6OyFOgE24m/3Kwonx59aDP8GsZE9DKMtUO0txiLpAXMA7H
	je1hMc1S8xyUwpnOX8Aa4MDt4/vlN6Uz3bJHtu/kHZ71GoX86sulDsf7rASrsleeMPfA09JRCj3
	eglEm1on1puenscJ/QQJrwFvfwR7Hk1/A2KantQaP2s7MLklpGG80+dABK7k+cs2ui85lNhbSFx
	Q+BPaZpP5KOjZURPSQ8msuubbqyR2FNrUe6MFRkTFLxVDBxGHGWnH1QXcI4DqbbsF+g8wOHHlFZ
	brDBZh04Hygnklq+Q==
X-Received: by 2002:a05:6a00:7099:b0:848:48d0:934 with SMTP id d2e1a72fcca58-85f448cdd36mr1124512b3a.18.1788339728703;
        Wed, 02 Sep 2026 02:02:08 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db23f7b8bsm1038728b3a.2.2026.09.02.02.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:02:08 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix false positive in
Date: Wed,  2 Sep 2026 17:02:17 +0800
Message-ID: <20260902090217.29968-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902081825.18931-1-aethernet65535@gmail.com>
References: <20260902081825.18931-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 16:18:25 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> When setting goal_tuner to 'temporal', if the goal is achieved,
> quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> will always return true, even if no regions have been tried to apply at
> all.  This causes qt_exceeds to increase unexpectedly.
> 
> Fix it by:
> 
> - Returning false in damos_quota_is_full() when quota->charged_sz is
>   zero.
> - Adding an early exit in damon_do_apply_schemes() for schemes with zero
>   esz.
> 
> Fixes: c7ec7d5f6b3d ("mm/damon/core: handle <min_region_sz remaining quota as empty")
> Cc: <stable@vger.kernel.org> # v7.2.x
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
> 
> Changes from v1:
> - v1: https://lore.kernel.org/damon/20260901105925.106186-1-aethernet65535@gmail.com
> - Changed the check in damos_quota_is_full() from '!quota->esz' to
>   '!quota->charged_sz', because the former is an upper bound, while the
>   latter represents the actual quota usage.
> - Added an early exit in damon_do_apply_schemes() to prevent a scheme
>   with zero esz from being evaluated by damos_quota_is_full().
> - Changed patch title, original title: always return false when esz is
>   zero
> 
> ---
>  mm/damon/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 8e3ded1a2cf6..de78ad56c8b3 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2560,6 +2560,8 @@ static bool damos_quota_is_full(struct damos_quota *quota,
>  {
>  	if (!damos_quota_is_set(quota))
>  		return false;
> +	if (!quota->charged_sz)
> +		return false;
>  	if (quota->charged_sz >= quota->esz)
>  		return true;
>  	/*
> @@ -2666,6 +2668,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
>  		if (!s->wmarks.activated)
>  			continue;
>  
> +		if (!quota->esz)
> +			continue;
> +
>  		/* Check the quota */
>  		if (damos_quota_is_full(quota, c->min_region_sz))
>  			continue;
> -- 
> 2.55.0
> 
> 

Please ignore this patch.  The title was truncated, so I've reposted it.
If Sashiko provides a report in this thread that differs from the
reposted version, I'll forward it as well.

Best regards,
Rui Yan
