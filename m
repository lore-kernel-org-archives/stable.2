Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9C4A2A69
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359759; cv=none; b=H55uU4RcOJB+YKb2vp/9MzYEtkhyNnzixsJ2i2SrLSFkCNq0cX4Zz9PRUR5jez44BO8rS9Q5uodXtT3l4hgn6oFubaw8KFFgYzCQfRXpujR10A68dgaL5gD4CtZTuVP9TJuiSuNZu/dDpqWvK46AjuZ7CX8r6YoJAvyecQ95ZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359759; c=relaxed/simple;
	bh=6aOkKqHhym80a6kBJ8PrVxu95b/21N9MEjLfSv0uAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ0t0onaaZxZ/tyB00IxNQvJOoAabwlEAqyo+7V8n7wqI4430kjHvaxJG/IGfs1AALfquLvLe4BZQ/u7OOdaqYaSvIstrTdqXil9FB7+YhCibfrsTLY9ongPFv93rZnvvD0v8rGH44UL9GbnCl7Q9DaaYtd/1Nah9ors4WIa6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6SB7ZHq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6SB7ZHq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8557c3f270eso612845b3a.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788359756; x=1788964556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hr6y/ERn9mwLYkItat9vlE3A943++Ow9sTB6oJwTNEA=;
        b=k6SB7ZHqvtvHM6xTNatLqfS6zrE/f8MhZAzWyLekglRXvfBNHKc/xMRKwkmVKy6NhB
         iLVhDOmQm6Wk6GMZUTzrOsdQo23zBhyTTUhN3GPFRiku7phxMDD9CsZWOTkLlbi3io8x
         5nvg8qM0hmA6wnz0/7ddqumb6xsOEQSfFhhst+UGekywSa9F/CRulhgmg7d4DmerP2kn
         PaVbeQs1uQBLo4cxZ9jn5suf9mRwGiwFKASz2S87+sYWWut8S8uu7FrpzlpvSHXID9YJ
         clI0DI5G0lweN9Z2ay8sG8h0AMuHHECzCxJKdGMTU0pMhYCAxLZFt6gDyqT+8Hpsc3pJ
         S/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359756; x=1788964556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hr6y/ERn9mwLYkItat9vlE3A943++Ow9sTB6oJwTNEA=;
        b=i7OaVBXup4IP7/XQg5ivszDSVuKTjIzniCN3gcLQ5M6Kt0OtleqQPMm4q0W/700jf4
         xNFUFfQT0lamqwZektAU0nVdGaX5nYcQbcm7zD1fZs89W5iNpFGxIyBWZfO3hb8XmtaA
         9vDmlwQPDUN2jCPc3bW2yke7nsl0g/PwIHVRSUI0LKoQcxjB7zrkpeLKQa5HJMG09CWy
         Jcegh7X9YWw7Tk3dCsn/UCNZbA+9VTPsXjC5N6CZgwfKenVyYG7CN3HKtHQAisEkZ2BO
         Ux6ZxfY2VJWeNzXhtUtIFxg0yE2sFNJwD7u8cEd0676dnpsXJ0gRbmxiD458fGjr+WH7
         W6aw==
X-Forwarded-Encrypted: i=1; AKwUvBx1t4hTc1VB+wNOXC6b7ZWNiYQG57G6F3wNDfRg1uyQJof2QaWeaS++/jnFwww//hzq6tWPk1M=@vger.kernel.org
X-Gm-Message-State: AFuF++kSeeulWYA8T2+GmVowg8cdc3mbwxcwofrMHVPVb7X+OSOZUKse
	/ArFjQsW6rCXJMoQ55hzLVPPm5gaXhVMYRO3kBrR0SiS05Zmxd3Ct3K6
X-Gm-Gg: AYBFou2rB3QHwSp2FTzdfXX5EFgggYFpIU4eSajnNfiO+gAD0LpaMdmSflP6Yf+EW9Q
	joz6xyqOiy5qVCNspzPONCl8Cjr7rDQ5llGVDxWGfqGVOIbRlkH3Zb4YOaP4CXlWdOfa1RgXLhB
	zlQF+95gD1pBYF9Gu7ydZtaHtZtL7hTcBca/4fxEMXdUpwgS5HXkUcAu9DmHJgmf0RR9GCgTW6a
	ougi8VzSEY81XR3LOuO287S8ASfxsauiJ7uvgR1EKE0e0QwmsMl09WppHYX49EHujS02vUHfHHY
	ds/Bl19exo4VhyLQhh/40vxXfCJyY5jRJWB1zgwuyK3ZhzK22n8YzDgoPYWCZlKLXwWbniyx7eY
	GY4x028mbamqy602o62VYLSO+DZJ1NeXZGkikMs/gRvuqg77MYgoK0SQf9auilVrkGOnF8MR9P9
	KgJoyLH8+mfXlnQz8J5QAZTGDrcf4qB/ML3So0OjhApvVGmK9rzM2k0DDkHQxm3Ws+oiMbwsPyr
	KZTn9qnNpVDbHdQ
X-Received: by 2002:a05:6a00:1c9e:b0:857:73e2:9104 with SMTP id d2e1a72fcca58-85ed94bb41amr7949304b3a.20.1788359756325;
        Wed, 02 Sep 2026 07:35:56 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f2076sm1560348b3a.4.2026.09.02.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:35:55 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: allow esz to be set to zero
Date: Wed,  2 Sep 2026 22:35:20 +0800
Message-ID: <20260902143605.6785-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902141349.86896-1-sj@kernel.org>
References: <20260902141349.86896-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 07:13:48 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 16:20:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > When the temporal quota goal tuner determines that the goal has been
> > achieved (score >= 10000), it sets esz_bp to zero so that the effective
> > quota (esz) becomes zero.  However, damos_set_effective_quota() clamps
> > the quota to min_region_sz, preventing the quota from ever reaching
> > zero.
> 
> Where in the code it is clamped to min_region_sz, when?  And what user issue
> this can cause?

In damos_set_effective_quota(), when quota->ms is set.

'''
	if (quota->ms) {
		if (quota->total_charged_ns)
			throughput = mult_frac(quota->total_charged_sz,
					1000000, quota->total_charged_ns);
		else
			throughput = PAGE_SIZE * 1024;
		esz = min(throughput * quota->ms, esz);
		esz = max(ctx->min_region_sz, esz); /* <- HERE */
	}
'''

This is a minor issue, the main problem is that it doesn't match the
description in the documentation, which states that if the goal has
already been [over-]achieved, the quota will be set to 0.

Original documentation:

    - ``temporal``: More straightforward algorithm.  Tries to achieve the goal as
    fast as possible, using maximum allowed quota, but only for a temporal short
    time.  When the quota is under-achieved, this algorithm keeps tuning quota to
    a maximum allowed one.  Once the quota is [over]-achieved, this sets the
    quota zero.  Useful for deterministic control required environments.

Best regards,
Rui Yan
