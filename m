Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592054;
	b=DFtXjecU1CY6k/ZgVMHKRQjQG0UKJKLBN7mV3ViJZA1kM9UWZzqcmlHFVIv9hBYxI0xJ
	 itHfdoFonakrb+EkwVeMKRoEm6RfkOwkRcsC5xIDv9JzSN/E8fMc4ZJWkZdV2B3gNvXg6
	 fMpGPhsf19WKiylJW7uNGVgDBy7qufUMq+vzZnpSybtvBnJO5mVZYNX4s/u29os6U5EuD
	 SrvF0vPs2OkklhDwOtmfELE2P4SilbUo1iyA13xHTbx9/fAbsq0ewQbotaQSSIzbwc4Qt
	 1Mx+AAxvXBWYrCRWBxpl/hNNmRnHn5yELI86acM9RFMJQTqmVekFEqz0FnoqEtvLMeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9tvCvtyBDwclMOHXQzuvgqL/VLhDVcOm2ZijhPSIJ6U=;
	b=Za0qEzLOnEOCm68zi1dEtg44Fq1KsiHP+VS14d3uSIltER3cas0clibfp/EARXiq6pur
	 84d4Q7VzIotsQH2DYACCUaIe/rk9C8HO8i3RxGRQ2HFRnnKmJpCdNMnsiFyey1gXVp02Q
	 vOx4ecOO5YUhxEhHK/owNcff1TVK41Q+wSI7gxrJdt00CQGhMLt03D3JeZEyl7hh++FXR
	 5PxhWrgRDwz6SIhWqYoBRbuWiYy1lWEqB9I3YiYw2zq/znRFNDEcneNag3jC0FUDQRd5x
	 2bmyIPJgo/WfZL5hVKjfBGrQt0bD1kd86g794gwD0GbdvZ5MRXnRtXYlo6K6BZ4k8lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JAX5AANp;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2870606C08A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2870606C08A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JAX5AANp
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so234137466b.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794592052; x=1795196852; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9tvCvtyBDwclMOHXQzuvgqL/VLhDVcOm2ZijhPSIJ6U=;
        b=JAX5AANp2k4dqYgZKX68bnlMSxI7nx8VhbQOFDXPCYwST7Mv9EsQH57WMoP9aDCCJm
         8omGqU9l0L8iBJoO8erMFKiXPojMOXS4EjcF56aca+ogdTLbFVXYB+Qt3eToRJxFNFk4
         OK4pLmRHHSIuno7w7BupPHFOmyAJ6UTsreg8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592052; x=1795196852;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9tvCvtyBDwclMOHXQzuvgqL/VLhDVcOm2ZijhPSIJ6U=;
        b=juQNn5SPHkpenRKb2opQGS4CEa5HxYFbVEgCvrDMA6pUt7Je+8A0etN3Sdjv6a918F
         iCeSYi1Q88mxUNx/E7DRHfWMfoneagms/FA/FhKqOo/t/GMxIJ2WSyUDWqYGlHTAv6go
         d6q6C0MtWotTpXK2hD0q969e9ypZvjkOU35JK4umOIO16DBQlNer8simXtQRrWg/8srm
         npW6RNhHt6ymNUKCgwwcCmAqXWe+LiWSJTjUc+BleUX02LOV+sfAjaFxYUFORBljTXOg
         MB1WjFuShV+Wy9IT+mGJT+F7jF05ssHup0MCsPQLLcM687LrAE6x2zyR6mgKT/jrff8z
         KTwg==
X-Forwarded-Encrypted: i=1; AL+hErEei7wu/Lani6in53wBZw+xQJuLa47lFzTichwnfp+xkKDW6b/4/3q0uwfY5oGluWUb38RsPVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Z6eXOP0WASpbnDm8S03Ak/sw9FQA4x/eU3fIv/HmkJQI5QXFU
	O+psJvMcCrtmYsY/EVk6PsoXCGNiyIMZpZyUBWaxzqr2MAui37jm63npsdOOF4UEheapBbw9SSw
	ZONVMTMTZ4Q==
X-Gm-Gg: AYBFou1pJeKzkWwmf0RRxRqo4iHencRA6nU7Xd8NIe+6lALZwb8kNQm/5PcrWtz7cRv
	4aGsoOuE7+8v7d9jns835LiPnNaRP1giDIhsr477qsckKaAc/V/eyyIHyw0JwfOs/s2K7l9KP2e
	IX04F981/87uNw+nFrj5w5C45EStMH+HJlO8EV798f2cvN1yhpasgMg2eSfOvDPtrCtGaxo5tdg
	xDG5RkzDVe1uJMCOVtqIzcbScK2kF55uh/7pcHF0zJpRGlMmb31+AjIt/CRDXmfGr/arE7+CpDI
	Nj/wlACn0nEEQe6p3VOEKlaUBTWbjj+mRF2nLU09/cTL6fVxpI1uBNbTDcaQ5XF1qdwg6H5gzLi
	AQ8zl0Jsc1LEQKa+Kt4YAE84rKCteNPv7RoVNn7zaVcyM0myxIR1Afa+NKkrgkLYr+usHJZ9SLL
	ZS3CX8fN+0f5umQpPmM3ILCyMluUkUnYeS9UqWZEijZs25X0o8GGwIMNRmzzn3kGShFi3bLwIJD
	IZgM4h70Jwsu0UM5P3S+6JPSRc7I+mKNRTSC3nwkszXL18Shlo3RPhm0FPe8lcujtzNJC0oYYcj
	vXlvMd5jFFMYIeqCclxlgHkbCA9xyXZ1Qn7y2iousc9e9ZnJiJLCvT5ZT5f5kaYw2Uo/RELxkEX
	J3QGY
X-Received: by 2002:a17:907:843:b0:c42:24ea:3220 with SMTP id a640c23a62f3a-c50963995eamr294839966b.31.1794592051890;
        Fri, 13 Nov 2026 09:47:31 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5c213sm125308766b.7.2026.11.13.09.47.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:47:30 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c445c95d553so234966066b.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:47:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFtVNPLAxq8bOnNNb1pMAnwhz6VOH1p05SYy6eQNY+TLiTozUuygJKdeycvECrz9xnk8QOYYAA=@vger.kernel.org
X-Received: by 2002:a17:907:9811:b0:c41:9228:baef with SMTP id
 a640c23a62f3a-c5096328cfamr296705566b.8.1794592050271; Fri, 13 Nov 2026
 09:47:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au> <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au> <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au> <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au> <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>
 <auy-7TvVzJ-VCrG4@milan> <avcKfEvln8_2a7fJ@gondor.apana.org.au>
In-Reply-To: <avcKfEvln8_2a7fJ@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Nov 2026 09:47:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9baZ9EDhZr7ONxjuO65+vvWFo5E2hgxt+3rYo1vnhyA@mail.gmail.com>
X-Gm-Features: AclHuK_LoISNmN1EyeTV2FunZOXs5TWqNCSWTUd1ttcLDz0e07xK1bcusX84qg0
Message-ID: <CAHk-=wg9baZ9EDhZr7ONxjuO65+vvWFo5E2hgxt+3rYo1vnhyA@mail.gmail.com>
Subject: Re: [PATCH] mm: kvmalloc: Bail if called with soft or hard IRQs disabled
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett (Google)" <liam@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 05:03, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> OK let's try this patch:

I don't think this is wrong, but I do wonder if we should at least
have *some* way to detect these cases and report them.

Also, it turns out that in __get_vm_area_node(), we have

        BUG_ON(in_nmi() || in_hardirq());

so this call sequence already has a *limited* test for this all. It's
just that it explicitly allows softirqs, probably because it used that
bogus BUG_ON() pattern, so it wasn't a debug aid, it was a "the
machine is dead"

I wish people would stop using BUG_ON() and friends. They are *only*
valid for things where "something bad happened, I can't recover".

That __get_vm_area_node() is not such a case. That function has a
perfectly well-defined "what to do in case of errors". It already does
it for lots of other cases: just return NULL.

So using BUG_ON() is wrong, wrong, WRONG. Commit 04aa71da5f35
("mm/vmalloc: do not trigger BUG() on BH disabled context") was simply
not the correct thing to do.

The correct thing to do was to replace the buggy sh*t-for-brains
BUG_ON() with the right sequence:

-       BUG_ON(in_interrupt());
+       if (WARN_ON_ONCE(in_interrupt())
+               return NULL;

and yes, that would give a warning, but it would actually fix *two*
bugs at once: it would fix the bogus BUG_ON(), and it would deal
correctly with broken code that thought it was ok to do vmalloc in
softirq context.

                 Linus
