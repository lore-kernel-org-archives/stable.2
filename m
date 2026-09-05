Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0B44CACB
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604771; cv=none; b=BcQyK3KD+D20SbP4vG+3WVYR3Zvx1Toa03H86PjihtBuOFxIHbgPjNMBjtXhJiP2g/7YF50adTNvVIU7iU6gSP4BapWlDHYYyweF9yNz66/WivZvnqXCQnplGxQXDaNx7tnnP7QpInHludhz9kgVGW2TZtQBtgeIuetEsdQ8aOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604771; c=relaxed/simple;
	bh=qKwArP0WigeNsSMiWM9fRKfNl+ixVag40Kpf76pLGks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8p6AkjLbMhsnx/1UNZC7i+XNVoCWob3yJMvgqtv1K4/pujDL5vT/2C5Iuws4s+uTp5rNi0+EmlJ9fvmWZmsAZ9MOhzPh2zQ+NqpBL07xlqLkRRj4z9haBM1vrYEjbfy4JYDkDrd1JPSso/p6EzWFpfRYQV8jBfI/9K6S1TOFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFULPblh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFULPblh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d560775ca2so13964555ad.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788604766; x=1789209566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WXSZYdhEXRp/byDgRnPhYVP+JoRijs47XywpK06FLE=;
        b=DFULPblh00QzhGjhOtYWYGszXWRkwWab78QiwXLfM1kRqCEkM3tx/pMIGnUlLk83HW
         iKhdG+QqugrnTwBz3pC2FU18hyRDjy9yJzCFcuA/GHu+lNlmb2bVW4v6hFk46afk+KuS
         3ewZt1dhIN0Av8jqnEtgUozxtIvkcu1hsnb7eLukyUbw9wb/r1Muh9sWsbGIBvzxb6Oh
         8f5wGk03q/mNyOanUsTsrhxRpijFf8ZHCksTpbeUJB72ykkwVrLvESRXJRb+AuG7UTma
         G94BoQ0r6gMmQgZ82lMnEc3x4xJlhO1SmMVRXdRid42IeWYf8wAMO5uJ6bxiDO7mGho/
         EYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788604766; x=1789209566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WXSZYdhEXRp/byDgRnPhYVP+JoRijs47XywpK06FLE=;
        b=JyV8od0p1g+UG3P1V6SHdcX92owSF87T07jOZNH7eBEihErgeSkgNtM5q42vHCRXCT
         nJGb+dSH4I7YOl2d2ZO3uwFJvc1wRiVaZTHPutz2Bdui8SLXH38sxatM2DyykEhiOn17
         OETjtZwBpo1qVsxdYUTS5IilpsjxIEDJ0fUVMT2qQ7Dw3lINibZMW75ob+vH1r944tlr
         tP9ccyN+cbiTV39+IVqBXb19HJfF0sMSbeCZjIh5EOHe4E3ud+AAFDSicvJ2wEEpZN6h
         IdrUDZldhdKO/XflJgf+DorKiezoCnyidSqKGH5e2KTumNriLykh8zkdPlm2jjBKg6QX
         OHMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRFv1jja+fN2oqCRADEASfT+1HaWu3PwojCXFbHRbyqpC6N1sDBmLQiWVmMDlNbkJpOoF4CgQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kWa9QX+rmAiCozxZBCOnZQLMe+7Lmcg7cH/zycFWs9tjOSZgDe
	1ggh0HGw5oUgbhV3F0IYecusjpO+HYGvkIqwADSDJtOV+/MOr6k2oyPvJzzOmQ==
X-Gm-Gg: AYBFou3HBxjIJRA6qVna8Zxd24xv1N5IFTejC/y1p4kMEx31xBdLp6GSdswYprlGAjd
	bCAJ2ymNVoT8/CAv/f0Rsh+x0z3KdI2BzOLdJPMyzFMaycE9Mx1t4xqOdctXMjp7hRSSdAa5FVV
	OdxfVb4iOP9E8Q/oGHj7E1WmNW8b4nHXu12iRPb6LrQVc8yoyshsjk3l5cBZGbXpc6L9rZ5SlYx
	E8QUvPIDE/PXSJ4Wt9orwhAtk2Oz+K41eFRzUXRDaO6rugKkdPsxFDBAn3FyoA3Fsi1t4P9nWM4
	z+jQbKl2zumox2eYp5MiAkEeE2qk3t536vZMhFFEqI9e3oxZPEXbxkFmsn45Cq6UEbWrz1uRhf5
	CjVziUiCALwz5qox5l4Eff9dcMiaG+iOfqRf9NbrxC2bwvf1eJMGqdcA1HWW8EDKaYK8ejTI5rc
	k0XTTXwOfSf+Lhf5uehqERSnEgUSI8tZKMHSNvcRpyKikhZjX5YILsnKqaGBqz1FCzCC1BVBXbJ
	Egx
X-Received: by 2002:a17:903:198e:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2db125ca4b4mr188947935ad.13.1788604766401;
        Sat, 05 Sep 2026 03:39:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([115.164.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149ccf2esm21288335ad.73.2026.09.05.03.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 03:39:25 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Sat,  5 Sep 2026 18:36:58 +0800
Message-ID: <20260905103935.4871-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905002534.67885-1-sj@kernel.org>
References: <20260905002534.67885-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 04 Sep 2026 17:25:34 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri,  4 Sep 2026 23:35:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > That said, it's not important for me to add explanations to the
> > document, but may I know why commit [2] changed the behavior which
> > introduced by commit [1]?
> > 
> > Commit [1] Behavior:
> > 
> >     if (quota->esz && quota->changed_sz >= quota->esz)
> >         s->stat.qt_exceeds++;
> > 
> > Commit [2] Behavior:
> > 
> >     if (damos_quota_is_full(quota, c->min_region_sz))
> >         s->stat.qt_exceeds++;
> > 
> > Before commit [2], qt_exceeds will only increase when quota->esz is not
> > zero, but after commit [2], qt_exceeds also increase even when
> > quota->esz is zero.  I'd love to understand the rationale behind this
> > change to better grasp the design evolution.
> > 
> > [1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
> >     (Fri Jan 14 14:10:20 2022 -0800)
> > [2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
> >     (Mon Apr 27 18:33:50 2026 -0700)
> 
> Seems commit c7ec7d5f6b3d1 didn't make a behavior change that you are
> describing.

I actually wanted to point out the behavior difference between commit [1]
and [2], but I've understood and agreed with your point.

> 
> '''
> $ git show c7ec7d5f6b3d1
> [...]
> @@ -2601,8 +2613,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>         if (!time_in_range_open(jiffies, quota->charged_from,
>                                 quota->charged_from +
>                                 msecs_to_jiffies(quota->reset_interval))) {
> -               if (damos_quota_is_set(quota) &&
> -                               quota->charged_sz >= quota->esz)
> +               if (damos_quota_is_full(quota, c->min_region_sz))
>                         s->stat.qt_exceeds++;
>                 quota->total_charged_sz += quota->charged_sz;
>                 quota->charged_from = jiffies;
> '''
> 
> And I don't think there was a behavior change.  Hopefully commit 54419bbd0ee3
> ("mm/damon/core: allow quota goals set zero effective size quota") will give
> you some clues.

Thank you very much for your clarifying :>

Now I completely understand why there is different behavior between
commit [1] and [2].  Because in commit [1], esz==0 only means quota is
unlimited.  After commit 54419bbd0ee3, esz==0 also can means do not have
quota at all.  But the qt_exceeds should just not increase when quota is
unlimited, that's why the current implementation is completely correct.

Best regards,
Rui Yan
