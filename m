Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C137BE84
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121855; cv=pass; b=t+lHq7O2u5VsTms43P7ch6EwIodipF2WI0IItMrWjloHRWCv6Qb0z0+FHVkq58sYWHyLi5aMDxcZbHW5jZc/7+eIoZDk1xVe6rf4+FRenWcsXSYn+sHpUWlgFBAz8VjT9qiSs5ZCEC+L3lW2ohCsrnO3cXZzEndDwL4wT6PKw1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121855; c=relaxed/simple;
	bh=Hq8X/4Xg0Ta1JBUv3CIgDq4vQ920HdWsgV3I1NkcJTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFeUD5tNQZQBO5EAB49gK6f7OzDEEQFuCJE4w5XkOD6t0iAsuZGfzBcSTCbJiNc1w8rNgXmjCEEdzKA0M6ZqRGGxo0MDS9FQ/4ys1gJZ2m5l2YBmfkNaBuF49k6K3AlAuQgoIXcAn5wIyxJWGNUdMpZiKDXrLdla3k0zABVwA4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK9yS6oP; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK9yS6oP"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-969524c1a63so2527646241.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786121850; cv=none;
        d=google.com; s=arc-20260327;
        b=hcvvTLU5LvrVK34M0fiyZf0fWrIA0W+IQ+WG/KGystThm9IGJP70oWDjrgc7C/T//C
         D6HhSUmca7t2i6PmF5L6hvx1+bjoI7tl6Zi2ulxQSM7ijnKsw/e/4LfQv7jiwBV5w3qR
         Z1DZpexRP0dxwwaGxrcn+lLX21kVRgjvDcC8YLyB5hhKJDGxYjFRQ6ZLMaJfJgPPNKZk
         DXnTBjbrQWyMjuEB1TWRr39zch1HkOZSfC1eRi0la7x2Ak/h4WMaKzJnyL/xp9GZ8bqy
         4+X8ejiwKa07X5C/xgS2bDrD9fIdBuQJN7gXUHJnhuiFAl2Pk9Sxy2bZBEhrcIG/dsI7
         JbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hq8X/4Xg0Ta1JBUv3CIgDq4vQ920HdWsgV3I1NkcJTQ=;
        fh=MCN5Ru9XiC/sxWgzCmxwbB/s9mzy1NiSYSoNK9WV3o0=;
        b=Qsh9Z8SsN6vsfmqZcAijhg62nQ7wsFF41ev7QpFZ3mGGlK4WXQx6ten07hRSEwaYZz
         XsS2j7FAWJe9UDbntepjzjMS8G/Ntb81jBw0Hy/K8Tt+ct4i+VQt9FWNIPeFq9d93QgQ
         Azi/KcTIL2K3FBjAr/u5VVq9JroeU6BnmlM/rmjqemEP9q4ZAEr5nFRLp4kFP3CM9bA8
         KJ3OD6BeZMtkZH3k850GeSiuW18jrqC5iUzWybHQZ5Qi/oaX4boVY36w/IlFRZGu3qe9
         H2hzNjmwbO/ACpD0cirRyHytEuPma5uD1u45uAUSAx9OdS5BGZ2B3ULKM4DBrxxAHTSv
         0siw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121850; x=1786726650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hq8X/4Xg0Ta1JBUv3CIgDq4vQ920HdWsgV3I1NkcJTQ=;
        b=ZK9yS6oPddDRHcub2lYpDVpOUZls/qh9M73aAGKloU+Tjxx7YQ2YndrPmRrCnitLwp
         cmOUrStBohAFMc41kZpgvgB9q/n2dFUGJQ+o1PYtQXO3VlU+JVvxiJFddx/MV1wZQ1lm
         rVrAiJQoTQOvgpBFyg2FiLhr0STJ2q1S4WGksGyvn9wtYBnZMgGe4WW0EJ2h3e0AcvhJ
         afWpjCwmPzpVbpGt34Sxz9fTfe55cuUakvJCtGplV1GQcR2oSumfWSQWq3vmI1JDzwjb
         8rJQ0YXCqbHScYk6JEIJ9TCHUYsO2YvCjIbf6vGDMyIC/9dPe82+bswk6MrKhLOq9btT
         6CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121850; x=1786726650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hq8X/4Xg0Ta1JBUv3CIgDq4vQ920HdWsgV3I1NkcJTQ=;
        b=hQU7yHSaz8BhOUWfbgOVt3IHpQAKxGy3uPyZT5dv5aHAS9/gkRGI1CeDxuKS2Fxt40
         3UvOGlUor8dqYGaB/gUEbZbM/kUCFtT6ce83VKA5+gvx/hVzc10y5zK2sbtzAThBZSZl
         NucoNpK0JtFHtU0ZALGIuedkKrtYsLBVKLFW2Aulx6qpo1SuvWZ3jqakcGdb8WPWF7cb
         MeFhjQf/7GBleTuu4RjtOFwAaYuG/Ryj+cQRPg75NUbeFs59BRSvsJIo/kSTBOLsvRYw
         /uDYZ28DDqPdvZnN3rnvUjQn47tnnV2PsDRGsptRMbNnXcvoMdQpvj70VLSUJS4QlA2u
         vQsw==
X-Forwarded-Encrypted: i=1; AHgh+RpHMPH9SJsiiGCIkc+6DK0EdXwmh8sIS6PUCh0wJf2WrIZyIa3CeFe2FtCmVeo6Wif1N6Jvse0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY84HQ1vo1Ax30/oaw6BrhJkMS8bCMRrWCGhKHSKgHYja84Ewh
	ytXwRePrQStHhkwLv5yVf0kmEd1HiPUcxGEjSuNKYIQRnUKIdgzt+Mi7RrtdvXtLfPCPisEK2aQ
	JZGczmdKhBKStdcUJkmxN3G8WbMpZZY8=
X-Gm-Gg: AR+sD128TgRiq81qqL0yfN1B5bgahBvJiJzDdnbAfI+rTzUjsn8iS5O8ypEoDXZ6eXX
	O2uusDiJydivN398bYGPVMnzIj0NVDpPo9FG9QA8uDrw/sNOyrLpd0zgtNj2lxteYar+kxLr26+
	wf70dpKHkRwg0m90UyWRiB+VVHSs4yR1acUa4wjRwp/GaGomACyFX0RIayrqgzXJK6oYbkEembu
	bpktt+LRDuSeQkq6gaWarrlZKchaSUGL8YIf6phIOG0rTFcgoOPczooywynlejeXsnC4uVF4VYw
	lR0ULIfMdXHJB3/y3cLZ5fVFogE7ECrr8HBNoM3yNpnUgRlp40GV2a0y4Ncn5o3ezEEMOjbWnql
	s5acyMYb+lRGIYm1uV6ZfjzVAEU+m9P3hDuIrcycKEKDa4QTcZr12axl6CXRCR1ZIIYUDRWXEkS
	OP6Kkx9Y4JJjED2Bxx4RTP3Uz3/77SzegLDgmy
X-Received: by 2002:a05:6102:390f:b0:744:d1a6:b11d with SMTP id
 ada2fe7eead31-764e4f2985dmr717652137.3.1786121850298; Fri, 07 Aug 2026
 09:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-submit-sunxi-nand-h6-h616-timings-v2-0-225515107640@gmail.com>
 <87ik5mav6x.fsf@bootlin.com>
In-Reply-To: <87ik5mav6x.fsf@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 10:57:19 -0600
X-Gm-Features: AUfX_myfeWEyYh7Y2JNZ3tcJ-zpan6IsdJA8dIqxxvbXvmFsYYO1pP5EnmrWVAg
Message-ID: <CADvTj4pHOpKfNCoVcfDmtCuHh2F0H8e+_AhCwcSKG8xosLpbzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mtd: rawnand: sunxi: fix H6/H616 controller timings
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Richard Genoud <richard.genoud@bootlin.com>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 7:58=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hi James,
>
> On 17/07/2026 at 11:33:56 -06, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
>
> > The sunxi NAND timing solver currently applies the original A10 NDFC
> > timing characteristics to every supported controller. The H6/H616 NDFC
> > uses two internal cycles for several setup and hold intervals and has
> > different delay-field encodings, so the resulting clock and timing
> > register values do not match the hardware.
> >
> > Prepare for per-controller timing data in two behaviorally focused
> > patches, then add and select the H616 characteristics in the final fix.
> > Legacy controllers retain their existing setup-cycle behavior and delay
> > encodings.
> >
> > Tested on an H616 board with Toshiba TC58NVG1S3H NAND.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> There are a number of checkpatch issue. Can you please fix them? (except
> the camelcase one which is fine with timing names coming from the ONFI
> spec).

Should be fixed in my v3:
https://lore.kernel.org/all/20260807-submit-sunxi-nand-h6-h616-timings-v3-0=
-91287b543f41@gmail.com/

>
> Thanks,
> Miqu=C3=A8l
