Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECB38A736
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324862; cv=pass; b=p+eOw8ooMNMVkMQ3abbHbG5TXTTzxymn2rgmqDTELBS/ypr3f9rL2s2aShbFz/HN0k33ez7mHH+ghYolbB2nXB5o/8lREpZ2egmSbDve+AmuccSW9Hi/zgftjjfb0YKnBUKHbtm4I3KzyH+LRQo0y38lGxKUJ7fdgGIg6WREpFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324862; c=relaxed/simple;
	bh=15LJZtOorGFDC0T9o118Z9LBqCQ9DwdnV9oqHmbiXbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExzpniQS2pE3nf2JYn3MfZbgTQLZrQYfO2gDv+LmzPN/CX/IP+P1uDD6RcjlqUch4cVNdJV64CpfYuvIL6KV6rlJ1MAe9wlN8cSQGG5N7w275UHQqQ85KKENjMqlMPXTQ2ic8rjj74sJ+rj6v71pA10pGJrTkex5bGP1cOlFVF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwIZ2fby; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwIZ2fby"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a1981228f8so9249731fa.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 15:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791324859; cv=none;
        d=google.com; s=arc-20260327;
        b=eUqYct6ZcCrfOZJAfF3hei/DcYStUYYbVVpesolfRqTbchV4CFDtirDkUmqmC5iKYK
         7wfivwHuh3pIwFZC53HWnu5kWNOvVPeFmrVtu7yE40tg0KgcMCcIXswnvr+8r0rXLs/U
         ogghKetCAGpWvCbF0XJNpxn/NHySbHrufYxmBlTwHcJEDiHMGiIWUF/8heskQreABPpR
         pM2Bj+J0FyT1scoZvOoV36DT2aVbAQhWbJXbNwYDL0JlWJff5d5mU5SAp504h+mHNY/n
         i9oYMM1afQMX0ZEOQhwdAEZ6HE+Zl9nxGdWWucJJFtm5vmlQdVLhDg2thBHEPAuykqEV
         3Q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=15LJZtOorGFDC0T9o118Z9LBqCQ9DwdnV9oqHmbiXbw=;
        fh=xEJ9sWQhC8OYfjbaAHn6ZdOBzcL6NFF39ebYUlAuvMU=;
        b=F1tXhylwB9gMyaPN7Bypb3uSLuGoTH/MDGjxnc6ZSjph0MWN7ZwzhKzax97g8ewEgt
         mTKNCLVC/w35RVoHyMzZyiz6N17bayOEcLs0PBP0bY4Gw/hW8A8YFsBL6Nwxfhb2yVY1
         kg+xDxfm3CqZo6N9UCResas6676V//JhIlu/vbCiks+9Ih3XXqRZ3dspNX0oQVMDfkfi
         ekJlQOdIxPADb8YshkH/e+8MOSk3BR94uLgRPqivSj49hwNAm20gnb1ROD7S9zHlfn8r
         GJYQpd8cDWXFXJzxNfdFibKgc0NfNV2zorfp18QT0zQozWAcMJFhj15wVPiSq9KkFJ8d
         OnEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324859; x=1791929659; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15LJZtOorGFDC0T9o118Z9LBqCQ9DwdnV9oqHmbiXbw=;
        b=RwIZ2fbyF/Xt3q4GdX0D0ddAtr1bK0cWBG1ID+tRp3P9YuapoAh2QVmp4PKmEnwXqn
         HIAqd3EKSR8QCixTld0Vl9XdjmgeLxZrmJL61rneCt0NM16UaXr33vq19sJXcUIJ/qXD
         Uzgzk3MmsDEoU5Fn0kvOfREV/PrHVe9c01BJ4XNVvssm7Rwo+MT0ojYmjAh/nXE8+WEe
         OGFIFqFJylYhf0+Hg3anG2r1VqAKtxqjiqUuGEKH9HWOUZ8KveWVnLABvmAqUGzm9i6n
         9hRqHmjeDBcJjRGv73PbWpvTEDtwtijcZoKjiRmEIj1ObUK2afqUgEz2DlL12TKBPrui
         B+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324859; x=1791929659;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=15LJZtOorGFDC0T9o118Z9LBqCQ9DwdnV9oqHmbiXbw=;
        b=WzDxUDCVDQYj9BhOrIJkqUDbTwrfVlAzQOnYjUG+MGYo/5HSQwo10pEBcNeVPXy9T8
         QBmRzCwAOzNx4ivHqjvSk8XepcFnSPpttmJa3pIFQr7NWMzX4wf7JaE0jp+m3LUDvRhq
         ZmXG/mqnEuBLjylJ3gAWj8i05CkGGIOjrnaZfGS8U/tLHsXGbotleoGN8cWkye7LIPwe
         m8KWw8v6iLYNnOh83CWZha3V/eEWslJcAbAnrIdaT0NjTFmSR+JAlWhmtYV8rP0E1KNl
         Ac9IgdiEdjSZgt7Od/qurMssohGoZEKwNnS8ar13O71b2C2ezNKaRmZs3gcpFgRFoDyU
         OYcg==
X-Forwarded-Encrypted: i=1; AKwUvBxSaTthrGOIoQi9Fg4o4dPQoj6474lC8OQawwZ/ULJQM8vBkyDH22oWeGX67j/sIS12Fqq6iKw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqdcgH6I0o7U5GzW0bsZGGi5rJBgeMnam0HEtQS0mp/Zdombkd
	7vSoQYbOo3N+YN4twxXN1h4A/NVkXnlYsG4V3bA2gw1SlGsGO9dXSi4OncvkbL5zr1OZdfWSfCj
	dnsj0/X+13o6t0bTZkglXmTdbmoqp1tI=
X-Gm-Gg: AYBFou0o8KruOXNmoibEBw8oEmmxUwp8dERL5XrWuOiTDMi8uMoDxNSfbXXEwPk8kVO
	jnM6xCS72LwemmwwQ5MkLNxrcV4OheVWKRChcQaJpFQ1bVj5/BkT4awBcOvrPb67SuWQnX7wPOW
	fWL0JaDAHO3Oi5z/aje7cBZtyq/ZHGtOcvR8ltUsURjknTs9nkKDvkKXeEByU5Arhyp7sgR89UG
	MTjH5BCUCOtoTrkKbHCacVsHWI52bqHgbcVyotejmHGHJ/3+pY75thVK76NcQ14BnMnkiPm9OCc
	ets8vblntANiGr5jFqnu5UvVmZME/q/DZz4hE/+cg9nQXhJ456hRQy4=
X-Received: by 2002:a2e:be84:0:b0:3a9:7160:e83e with SMTP id
 38308e7fff4ca-3a9a2cc1e75mr696691fa.8.1791324858938; Tue, 06 Oct 2026
 15:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004212403.208681-1-oss.patchbox@gmail.com> <5e03928e7817104f062e27f0b14d180549f209c2@intel.com>
In-Reply-To: <5e03928e7817104f062e27f0b14d180549f209c2@intel.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 6 Oct 2026 18:14:07 -0400
X-Gm-Features: AclHuK-H1P6XAfW5WOEyeLge3myteWvfLBr0lYFKR2exJpjCcMV3nLYXUK8SvaY
Message-ID: <CAGG=RgCoBZwks5CR9GK0+xk8kexj_wWZf23WwmSTLZBu1hW=eg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Xiaolin Zhang <xiaolin.zhang@intel.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for reviewing.

On Tue, 6 Oct 2026 at 03:41, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> IOW, you're not hitting the issue yourself? How did you find the issue?
> Did you use LLM to write the patch?

As part of security research, I am reviewing how virtualization code manages
the lifetime of resources it shares with guests and devices.

> Did you use LLM to write the patch?

While preparing this patch, I asked an AI assistant questions to confirm my
understanding of how the driver works. So technically yes, an LLM was used
in making this patch. I should have disclosed this in the submission; v2 will
carry it.
