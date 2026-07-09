Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BE2BE7DC
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624624; cv=pass; b=PX+3cF8DxppuMP/B6gyv4HJabunGTbzyWKt0iChNmcy8IRDSfvtcUGm2VlGitDoOxx5PxpkjkCEl/e0niBZPtpCKJl0Rxd98Xt0MTweV84AFrhI0UHhhVq7IEphjmV/3UpRHU6EA31woLMxRXqQ9DtXMqsCh5M79ulE3Lr+7mtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624624; c=relaxed/simple;
	bh=2p7+oT4h1SRnucufUxHFnJrsgb4fPg9EoRM+HicBv5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/ZMGRZ7ghAmDlZQQxb38U6HLMl4VVSC2zd+hJXP1fpey/c3G/Uhd/6TvTmkZog/q7Gje8F7CvizMDvOHq+l5ZhA4Nt0pfLwVqZHQ+5EbFN2S5DkhTLUGP7VunE8p0cSPTYNzMa66gBhztoZwoaR1jbzU3rcDFHV6QcyhS6f8mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcy3hG4a; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcy3hG4a"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44d2204d195so39261fac.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 12:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624623; cv=none;
        d=google.com; s=arc-20260327;
        b=r5A5L2EwRp5qY68598+Tb8yexZ80usVVRM+RcW3qKrMrStyt/yt5SBmrSSvGg72pnf
         ghgFguv6ZUJ8ff1f8lg0IBoKG03bO+kPvI1TaDBx20tw1ttK8/BV/1F9FZJU9U7Yoy5x
         hzXEQtJo6km5lV1tUy/GChbJgFqlzPhmx8tnokESpgJCvBwykZaisiOlx4QfzMV36dk2
         PXWdzJPptA8WhuQITkjv4q0ScUxDZQ2diYiXAqGvdD51UpGFDFNhSGHRoMImMCP9BpJq
         c/47k2tkIt0BJC5CxcOt3v3KWOJSFD9jYjxkB1/IHkWviTMk0JHUrBZdzWdH1yr5G4x5
         VP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2p7+oT4h1SRnucufUxHFnJrsgb4fPg9EoRM+HicBv5Y=;
        fh=Foth58nxXWpjUKttQqZi11s2rHUYyCF1WMc7xJFIZ5o=;
        b=cmBWRhnJqEYtqhZmVbA9+AKzFwiNGCHGrWlGsqEF29pVdg+fIZ3XrD7xzGWeW6bQBO
         0hGEa22oi3hESLX9O63o32Hqij20mqGTNX+P0qkaGDu1VeHe3O9Wn6S539uousx9mV1q
         7tu0Z88FKVuD/ytn7AX3WD8gwcHetTbl8JBX9Y/BFY/afcxenSkR1NntyTYsVmIKfNsB
         tWvwSsOnNtLzl8WAcxHUgqJ0ps8ss92Wi5Vh8Xd/r1GIteuSysQOZShSrWDpfujXrRWR
         F0FoPjGH3uvv/0a2oaXEU3ru+S7ywYeChi1ONhnzXR83Edks6bfl30duW7jDQEexLyjc
         qNPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783624622; x=1784229422; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2p7+oT4h1SRnucufUxHFnJrsgb4fPg9EoRM+HicBv5Y=;
        b=Gcy3hG4aSwTY7lZf/dQVB89rrNsUCis43N6FlBmrmliZiO2PuMYOjSzwqbyY8PK9RL
         fdv/volreOaCzdXAcseDGlP4ecZYcluZaffr3IKp/LXvisbpVcCVBfdRC0RAfMq4Lwfh
         0k2KaboTMMTEkk/3/d1/NMHL4IYpSa0KImxVTTeSyAoMHyH4SZ7BuBQeY/jq14aS4qlw
         mTUv4pQ0lySUV1cJO5o5LmYuUumyWhghS8/KOFgX6RRsWu2Szsg0JVgdiMcy51aCUEiO
         KsTSdjpMO6VCdG1R5+VOCQ+E1UK4RHAl/kuFxJ3AqYFDADDra0icikRkqA+4DptvAqhO
         M1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624622; x=1784229422;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2p7+oT4h1SRnucufUxHFnJrsgb4fPg9EoRM+HicBv5Y=;
        b=DkUJFo9FJ1vtw3wm3ALN5b6EAhg0AULKDMlAsB8+TF1W3Z3ldbY2slA9xUiUJf128h
         w+wKeHSy1t6iBrXhfTVk4J9tVwCn8LKqGZ1v3mEO+k6DXzlibDfU9Z4VCL+jUG2WC9XE
         /2Xtu9pN3ZUIht9/JK9u0DFoWk+MF5SH7BIrak1yTMflv4YZdlA/0VqPY5Ri7DzowYX/
         Lsijy7iQYV8nUhzdFU1yhgEYRMv0fPgZDT9K6A1AHv/VOA7vDS9yradI8CqX/i4TeJFx
         EQ2WPLApy4x8eQmmwLzjUYa5fvZMH9pHBIUdu5vgQgF++hMi9Lo9N+R9+RiG6IhlSOgu
         QnKw==
X-Forwarded-Encrypted: i=1; AHgh+RqjpvpY66KL+z7h71qXGqXzl5sbRtYlg4SBC8R9GAxR4AyPg4hNQgakkH8tWpP48NwiHh62oTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9y2WujyKOyPqS4Z56DRD7H+H+WLWzJSFiebTYahgMMJg2pUBY
	3IoEP7DtqJ+Dmty3pBiC8TSYy5zKMkIrYDm93BXB6rYZPPoNHFzwH4uzMRxEWYXbi0wBz54UsVJ
	CjdQ88nyR4pqz2ykRjekUIY8a+owO0qc=
X-Gm-Gg: AfdE7cm+iq44D6yzk+z/RZ5RGU98uUEP0rG5sZ/Gan5nCCA/tPcggoFCPR1bQYV5pw/
	ItRBRARqd4viCJUwmfnYn9rJ1ubPC35n1EBKblEdDZnMZN+tiLeIdjYkLRaHf7P3duMYWvX/mJI
	AuShhOZKJcsHRB39ZPLmsm8kn4oKJIlse4Vp6L9v9z9OhpGV8ghFhxTjSwZgyvp6XyOYBsCmTrs
	AfhhP8ZK4xNWuvU4AUFgJXxvpHQbkbHpfEs+c7yKIkWRzun5sqY0Sbcq8gISwk7fjo9mSYydSRT
	pfnKq3lnlQkh3pt1Zeuyr5Av/NR8A39ylQXCTg==
X-Received: by 2002:a05:6870:296:b0:430:29c3:9d15 with SMTP id
 586e51a60fabf-451637bbab8mr5476553fac.1.1783624622477; Thu, 09 Jul 2026
 12:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702103453.348056-1-devnexen@gmail.com> <akd8E5jr722oTm49@zed>
 <20260703221651.41669d55@pumpkin> <aks7usxfDajS-W_5@zed> <20260706104652.GB66892@killaraus.ideasonboard.com>
 <20260706133956.39a11738@pumpkin> <aku6R_EI0kLUqD8e@zed> <CA+XhMqz2oTTy2kY_4uqvJRnoXb0am5h6hXnLFM4EPQ7Yb6N-pw@mail.gmail.com>
 <ak9UGtj7-qOvjRmr@zed>
In-Reply-To: <ak9UGtj7-qOvjRmr@zed>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 9 Jul 2026 20:16:51 +0100
X-Gm-Features: AUfX_mxOCcg4xxJn6r_NIxbQSmV8bRhUvmzPJGxaLDY5AKlV6L4ZVy-ehzY6xH8
Message-ID: <CA+XhMqzXMMDmtMyev_UuGpn0sU6TKNBDBzO1H-wN96no5h-yXg@mail.gmail.com>
Subject: Re: [PATCH] media: mali-c55: Fix unaligned access of AEC histogram
 zone weights
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dan.scally@ideasonboard.com, 
	mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Out of curiosity: why is (u32 *) case a UB ?

Alignment, not aliasing. zone_weights is a u8[] at offset 10, so it's
only 2-byte aligned, and casting that to a u32* (which wants 4) is
already UB - 6.3.2.3p7 - before you even load through it.

> the usage of __packed triggers the compiler to emit an 'LDUR'
> ... implications of using LDUR vs LDR on "unaligned access" ... not
> 100% clear to me.

LDUR vs LDR is only about how the offset is encoded, it's got nothing to
do with alignment safety. LDR's scaled form needs the immediate to be a
multiple of the access size, +10 isn't, so gcc can't use it and drops to
LDUR (unscaled offset). Both happily load from an unaligned address on
arm64 with SCTLR.A off - LDUR isn't "the unaligned one". The multiple-of-4
you found is about the immediate field, not the address.

So on arm64 __packed doesn't buy you a safer load, the plain cast already
worked. What it buys you is not lying to the compiler about the alignment
(so the UB is gone), plus correct codegen on the arches that do trap -
which is David's point.

> I would be a bit hesitant in changing the uAPI if there is actually
> nothing broken ... happy to defer

Fair enough, and you're right that nothing's actually broken - it's arm64
only so it never faults, this is tidy-up not a fix. I don't feel strongly
either way. Leave the uAPI as is and I'll drop it, or if you'd rather have
it cleaned up I'll send the packed union (with MALI_C55_MAX_ZONES / 4 like
David said). Whatever you prefer.

Cheers
