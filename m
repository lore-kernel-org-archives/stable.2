Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625C58E2B2
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096873; cv=none; b=KoAZFL4EpOCOs8mH/gK4U4zko8krhpcheLdcPaVCDxMJXRGd/V+sm55qy287mnBTavDtfFmxAzvs4zSvlLS06Nmd+LukZeloIXFWChXr79/ALixAkc6+/BPDLjKM+2SyhNSzL3cCjtxcwVrdetNHOo32EaRaW4Pi1OUAIkPo7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096873; c=relaxed/simple;
	bh=XBa7XjRKeJ3NbqHnarNo98CmUhjOgDxizD3P7JuqFN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iE2sZN8EfS5gfbQdlE8dk/4dvxYPQec8Hsnc9VZ7WQb6Vl7VsDQqTTS1T6KPY38eefQQVHSr6Spw6x7yaCGbk5GUsxduAnb5yzC4Jv1okncthjtItD+/82W7GhtYRd9zuQ2gJbT3op+TnXDkEOQ24YtLO0xpmahuA0GnUFK2wfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT7ErP8S; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT7ErP8S"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a16c399641so55065415e9.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792096870; x=1792701670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2W/kXlm5ND7ClrDzBFtvNJDZO1bLmd3mgAbbGVfKnFM=;
        b=KT7ErP8SrE69QPgiqBh+lusvVt+J6U1wnon0AitSEzMy6xF8ZXNmZ9EmAbqU1YNGTv
         7Mo1Il8YkGIkPjxmImyeZ/g+gvnYJrxhTB3izP/ofQFkdn74qg+nY2+m2La8Ttp1L9jo
         q81tBZUgpg7ZCIKcZtmhR0SjHKD/FbuO76SvCGHo28L6Sd8HkxTpq5YgvddCQXvKd95s
         fmBioHlN0p5D9VXWGzxyeeIkXfcEeHvFzWramlpe8b9Dmg89t5kvYK4zwrcHHUiV/eMN
         nD9jow8Fr/qtZ87CLF+jd9WuB8BUiDx2DUTyX9a0MYINAt8IDJvILxjVs1LOAul0Muuz
         045A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096870; x=1792701670;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2W/kXlm5ND7ClrDzBFtvNJDZO1bLmd3mgAbbGVfKnFM=;
        b=D8gf7yoTjIJZqIdzDuxqOGu9ClRuAuj+4dZfg0u1KzYDGiekshpxpKfEuWpEYUpo2l
         kmvqk2BFEKXW77ilPWLlboaCuMYBuqn1Nnc/8uITZoBYc8thokiaPKmNPfsw9FMbJ+gX
         dMDCZ/t6D6EmMniyFm97LQnug4ai6zfWeZvisn4aSCFR7fe5vEiTfdKoENxpR3aflQSb
         9U48gyHSHQIA6NXmliJvJaw0UHkOitURrwYSnh8LHe53ocFKG/dQjDpIhOiaF/mR9Hct
         ZuMVqs6SrYpXULsMDZ6QAGQDskjw7V5vdnPDpsweoGKTlhbfuugjUTG1W6mOQXitSS2Y
         75og==
X-Forwarded-Encrypted: i=1; AKwUvBxsrRlZ9XwUwM0s+jzj2m7owtwrPepC9MT+z9AjoFEq4cK9I3sXxMT/0PsyXC0ARub4SDzp2Jo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLlbg5IC3qEgX5b/eVQpl9umObI47E9hsTXHArOA06LFoDQftA
	FQZ4OKgoTjSuNRDTktknzPlmXgTaADSp306Stqtn5OpOIaIjb6ihjQas
X-Gm-Gg: AYBFou2B7fCehHeJhbRNHe2JNUB6wGHYE1EnL+2BY7cW2Yguok13hkaMx2wBK3YhNV+
	ClDTqU/n0vDdUxpBznSE7/xd/RGzXLe2lczJPVDuN6ouJcJ/vypUBWKPQHRupZda2/cNQItFzmH
	xdRuqEKICA2R1G5oMHmB5eUOtSObzyq1RoK5qUfsKum72AZWU4fZFJlmSkxJJzO/4kp1rNraECK
	TtOFXk4puoK+0biW5ZXDQvK5S0djw/KJUjzVPqIYkZETHf96BVB3eICTWfrLOfXIEaZirdB563Z
	lcC1cJ3/VhpLDqA+wMfj6BgVb43TCawTLmA7NCBQdQiYfG83QXBIDzdgArumrFTdNKEhkvY6d9H
	S7RTOc3UpNT/SzoV4Ws+K+LjVuP74qyfXWuBMHS1UHNN2pl1oJS1Xs7umaU3AfK/0QFUI0xuj6u
	WMxymwhklsSAzb/xy3wl1HMgMceGaYT27FoYWXsI/bV6TCwclrryurJumrUYbwp7vu+ifU77Nkh
	QitQQjFJvCUIQo/oSDZVldd2B2ZW1MSpIvdFcb5/gXXl/6y/GxBEgDCPmse3k6Yrfuw3HOFspP6
	bnUsZU7cMTgUiGFoAElDAZwCGp+QoHCt5z6U9sYUuhmPhvzl+4GHmoITzZPd6Yi86yL7fRFdiHq
	7ByXOGS/m0lJbYgxiyYh3fPw5EuwGUthEbXqwrjfFtQ==
X-Received: by 2002:a05:600c:19cf:b0:4a1:7b56:1151 with SMTP id 5b1f17b1804b1-4a18e48f00dmr402724835e9.18.1792096869665;
        Thu, 15 Oct 2026 13:41:09 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm91136205e9.6.2026.10.15.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:41:09 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:41:05 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dingisoul <dingiso.kernel@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 linusw@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261015224105.7b27d7f4@systembl0wer>
In-Reply-To: <20261015203559.2125485-1-dingiso.kernel@gmail.com>
References: <20261015221818.09527ff6@systembl0wer>
	<20261015203559.2125485-1-dingiso.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 16:35:59 -0400
Dingisoul <dingiso.kernel@gmail.com> wrote:

> Applied it, rebuilt, and reran my reproducer: the trigger now gets
> properly unregistered on unbind, so the attack just gets -EINVAL
> instead of a UAF. No KASAN report, no warnings.

Good to hear, thanks for testing!

-- 
Kind regards,
Joshua Crofts
