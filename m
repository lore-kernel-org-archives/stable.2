Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62C361950
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573878; cv=pass; b=FePnxUJJV9aDprHS5HQxS7I5FzI2yoFFp4Y/hhPAhbduLCmvfdjOTZULM+sI2BpRR+pRgdULRCFl9UpHGORKd8iZfmtlcnf/QVHOx7qML9bX5cFwQ6Z3AbDDs//sqdVZCfnIllrDWAb1j10yn5mGTvU3AuZ9DDDsvx9342kKyzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573878; c=relaxed/simple;
	bh=hg7R3W10037xc+eRPQmV+ftbln/Y+wn5xo2JK6xVBZA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8PnPaRovOKO0uMBFfAcoIWP2zF0MkhwP01x3Puk0KEIdKwHJj0H+MOZeX/uEcTYIfBacn4UMPa0TzS08xeqLxhgjxEyh2IIHTVxweycFyTfOfJ6doRzZIZdf/ntA1/+AqfwJTGbosZAPMao9B7iRqKU8lGcGWlBv8A9IVd4pmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOYozYgh; arc=pass smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOYozYgh"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5f7af3e1so121519985a.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790573872; cv=none;
        d=google.com; s=arc-20260327;
        b=WxHULi/lLZTzCMCtw4WS7Yx5rxG2DHG385mTpm5eRPr70+uJTo5hPDxwEvRfX379Um
         AOvZ5vXZewly5BlA7Asas/EVh3bh129hU+GNZJN8Ip/8YiBR1NHiXC/XEkrQ8OlnxS+3
         KZ0ViLMl6yOqHwaZmAMdcUZJQ+qOSzIOY4x8SGQDdViNJa5N+XY9jHo4fyzyfim5eAKw
         u+M5xfXptpDQjrqR6uH/7SxPLphPIHpHhSUewXN8borMAJIY9HhYo9IW3XGfoJy5ql7V
         zaoX5ukueaDF0CpGrunlSLbiDP5BI0e11OBCKwVJQvCYRuwsqUm2k5J31pkEOBSZbSEt
         w5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=hg7R3W10037xc+eRPQmV+ftbln/Y+wn5xo2JK6xVBZA=;
        fh=2HmH3LWcFpWPzL62lJWEpgoKyBF+/lJCY54On7jpAss=;
        b=hq/Xnl9T/YViEKmp5z3nLwSPhPpW960szWT7iHANm7PL93Y0kZw+FJiuwU7Ji1UBY1
         9/v5eJ7KBRvXTEpiDpA0+1RM6RbcMjrOZSuaVkg3HeLV32j2zbabEqeoxEGxGwW0LQg9
         hiuzTnUR7Ggh7PnJmdcQR7dfKTl26MeMAE/DVGZjPtGQwn+0H5KfLvUp2e66msTYM5ZX
         5ms8rNG7c6FXPT55io3xqqIJ8+zi3yG1JwcEj574F2fuQjFx+aeLKDQuNX+gmaz68M4d
         5q6I6RsxsEBj1XEihI7BK/AnhKuhyGSraLUkTT00bRyBGO5Tm3nldXzVa/9UsFdORT4n
         7ZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790573872; x=1791178672; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hg7R3W10037xc+eRPQmV+ftbln/Y+wn5xo2JK6xVBZA=;
        b=jOYozYghRfyk7TcJ7Y2eam9e15wD4h429OW7TMEkZzvd/GVW82CMPgFmViTHv7yihT
         ykKeMLZ75rhI2KIPfgfn190ACmvIXEV7suR5jgxA82puB8bPbhHeSM0lJU9Y0gXpRppb
         InBhK1mr2OpBgPDCkBozhWwLNDjGmJAurX/uRni7JS511o6ytSbfxbebbDPjdOMclVLm
         KJ5xEsyKS93JSG4WFf4IskWVA9vk9wlg8Eskp5KrQLNB/zasebB0fZmcJYw0V6ccfHQ/
         0XKCOUWJKk2AkDSJjBwh4B/yT12uRrCY9T1RacWCy3HFXDjTtxv70DPI+w+/HFuFQhaG
         k7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573872; x=1791178672;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hg7R3W10037xc+eRPQmV+ftbln/Y+wn5xo2JK6xVBZA=;
        b=NHlndGtRCvPE5dIoak2v9lPWKLoJWTpsxi4DkaQrDLpyDI6wIdlhFf9a1v2vdNqIcw
         NLBFzaTmYhMnPmXDc38MRlg3UDvj8X4bY30Dq3zpMFoZ0E0LL4liauwgBeu4iqaB3N1C
         HJVvywdJISaeG3dpSYZGhChw28YsVcv5JGCtEfs6QjpzrujmGX0HWnmm2beqxfqOnZ+9
         ZF5ZBWHUy7/bB5xkQ5bAsFo05NqRD4SoqBLiDsQ1XUz4u4KKnmQZcwk97ck5y/N2d6Fz
         jwIG7zn1kVlq03E5M/R/J4RisPxH1namMmWzR4PhsiPOKgBGhUpLBI0dLefMPbvfCt6G
         I2AQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5bZuwXvUFkiYj+k1yEzypWtBAFeDeiBRH2wWK7mlk5/93o5xU5ZJh8vB/K/4LYak1u6VRgmU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfttjtGaBlgb6+E4Y98dYoXpLnsQXApFq6lQmKIKrMt0J0el8J
	JKPb2IZC5tRVvt5u73Fjpuq+ommgZzY2e/60LSVWhLEM00oUM6VqhEczzUazt4ElDYS/D5hpjh4
	qMBdPyYxxtpmqh6/sljYNiQEk2eHvwehj98ZL+ad9
X-Gm-Gg: AYBFou1Oz+DqiSvqCO20JLOaomebtj8ilFLvpBGaLmoPMdm9G8Jcqc/skQ01XmFjw7D
	d3yWlU7nbHN96pBUl/mtwFdVe3WyzFADg1YJvW1ko0YLR7YApZoct/MFGodEhZ9Wx2qLQs5UA8H
	Ne+XXqDYdSxDjuTf3lFAbT3rm0Rv3E6wcCO0zT/3gcR0Axr1D11ZE0GiOQp7NcKLux1K7XP4iqF
	FgXxDPdtiHwY+5vM7oQFIQ6nzyAvxiSuZcTpx41YvwqFmhiQos4YzI3+aEvX2YJC3W64T6i9Vfi
	9kh+kAqiVvzCzH8yLJ++KLW9virqJ3E5J+zNmlCOxnDzcPBB8g4ngIBU1cBPloMiTO4xYGT1JFc
	ildQZWe2s730=
X-Received: by 2002:a05:6214:3483:b0:914:404f:a02e with SMTP id
 6a1803df08f44-914404fc104mr132705646d6.25.1790573871302; Sun, 27 Sep 2026
 22:37:51 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Sep 2026 22:37:50 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Sep 2026 22:37:50 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260926071811.77481-1-kmehltretter@gmail.com>
References: <2025021020-copper-visibly-e6a9@gregkh> <20260926071811.77481-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Sep 2026 22:37:50 -0700
X-Gm-Features: AclHuK8GWYurU_Chr7XnTPJnT16XQpfVqJN_YRPlg4xYgm7FjJeUGneKs-gP6-0
Message-ID: <CAEvNRgEMM4Zp-_qbv=9uRq7OscHfFAd=niCkjNdw7B2P5HHTmQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] mm/hugetlb: fix avoid_reserve to allow taking folio
 from subpool
To: Karl Mehltretter <kmehltretter@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Muchun Song <muchun.song@linux.dev>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Karl Mehltretter <kmehltretter@gmail.com> writes:

> From: Peter Xu <peterx@redhat.com>
>
> commit 58db7c5fbe7daa42098d4965133a864f98ba90ba upstream.
>
> Patch series "mm/hugetlb: Refactor hugetlb allocation resv accounting",
> v2.
>

I can review this in more detail later. For now,

> This is a follow up on Ackerley's series here as replacement:
>
> https://lore.kernel.org/r/cover.1728684491.git.ackerleytng@google.com
>

This particular series linked was abandoned because an earlier version
got merged instead.

88819619688c5 ("mm: hugetlb: consolidate interpretation of gbl_chg
within alloc_hugetlb_folio()") was merged.

git log -n6 5737df3826dee4287f986dc2eaf7dc352068710d shows the 6 patches
in that series.

If this patch replaces the linked series, the commit message should
reference the upstream merged patch 88819619688c5 ("mm: hugetlb:
consolidate interpretation of gbl_chg within alloc_hugetlb_folio()")
instead of the unmerged series.

This comment applies also for the other backports (and this one) for

+ 5.10.y
+ 5.15.y
+ 6.1.y
+ 6.6.y

>
> [...snip...]
>
