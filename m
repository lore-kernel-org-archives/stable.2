Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622766;
	b=dZ9AehVBXxBmCo5tNcrqXrwe7L3Uoi7iGTrwlGVX++iFwhjXKMVntYezGO4PIjWywFPG
	 tkVNVwxGMWa590eBvB1XlaTy2eVovYyftq8cymA7FqFdFh5LQy69BCnxYbUS8DkPln4qX
	 nGrHDwErBzIt0MaWKjK0FKrMvR4cnm9MNMPgiDVez874AG4ssA+mWtWHp49pKSMDs82Wt
	 3wzWqMTL+0LT/kAuuqG7wGMFVqhfdW2YVos1aRwdh0gWlEXBaV+r2724xDR2gWq6Oh7Sv
	 mwth5yHQClvqFtLUG9AS9KxezkR5UABCZjJQADzbm8BvnRyFnEnO/VG6P+iJtdfth5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=xFEobrAf6WirewKCvSBOHq5k7Hbpzktec7ALKOJWs3s=;
	b=DdEeyNp//BSBNqvWIrOx2foXAcz5uu6Vn4S9nAUrfYk8iWb8+u2Zcwe/D5mowBg3Xjd5
	 TwMtMkQxZG7M538HKapVvXlQpmpiTtaMUBEkT0fknyA4x8sTPxkdS7ryV6XKYqjaDz5UV
	 6ImcFccbo9Vh+LqqCPst6wqIddl0NQPBWuc8PMAVos1illUq/fW36AdLuFHDvtb+or4fJ
	 1jPu5SU791YFUxd/RY3jsjb4M3d67OaMawnMXbPRB7vdYMwZLxNLHejtgB4inst7gE71O
	 kijP54DvefZTaANAilgeOR2q78/XQpn+QixPPGSQTEJ/ZB8BcUVDwF949gLmhxJx6Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FgBIOhOQ;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABF606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 02:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DABF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FgBIOhOQ
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so2334322a12.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794622764; x=1795227564; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFEobrAf6WirewKCvSBOHq5k7Hbpzktec7ALKOJWs3s=;
        b=FgBIOhOQ54RdK3lTC1U2kq05C10eiUDLZ/tsCgQc/CuXCqXhuyCP0s89wxY5DBI9XV
         gXtEXKdfSBCmuBhwq1oR0Xarrm2VOt9V0ikw9puIjvoDvanEbijJsoGPGf5zXolvOuhf
         jNtV8Fgp3OK+jQEptOL2eI48s69m3LWMGCwF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794622764; x=1795227564;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xFEobrAf6WirewKCvSBOHq5k7Hbpzktec7ALKOJWs3s=;
        b=KZWOrVi0LJtcBCURTq+cHIvFqQmucT1kbTCyFRG+Kq5JuXC52oB4cqLtQCNnREWzRr
         jAYMlA5zLQGLh6bHpTsCc9iZ0AvkoYRMGmwU4iM86mQfHnrBvNtcK4+vYkOgGEVM1Boi
         gEEz8Mt8JK4KY7E1i+t1UTKHq3SkjM/koIRfHA1NV3eZM8l2KtmQHwRVJABFjQgHAbD6
         cQf7MA/HEBsHNkenYjt+zpzPZskh/26EVY3I24dcR9rYXNmYT9SfFCoA9RfTm3irUYDA
         q3ArATDWJeqKiGFcz6cGhQeKQ4t/VOlZX93E45ZcxJfKMQlTXbUVXtKE7d61UcfVGORV
         5YsQ==
X-Forwarded-Encrypted: i=1; AL+hErHasHQ4pBmS/BHOAfFok4O/wW3+fASe+SRsEky2mdKURRclgsxi1zLnBP7mNnyXfaeoNpwxvEc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pvQLAw0ARh2sAFlPVgPqtzC0EyiSUmygtElOtp37b29Jy9kxX
	F+v4PtIXq39zH+60ukMYj/ZJqkYtbKuaT5QnnatGvFAPkRm3U8NYYj7vGo6ei0JGlfDC7tT2EN7
	0YXuYwM7goQ==
X-Gm-Gg: AYBFou3hDyPzbIKTxmGNjSWNi6OaPKaFuhhaFfc0hl5V2oS//FOoc0+5gBRMHu7KHs3
	PU0m4XdqbGZDALWOtqMB24wTleI5QqfgMnXtoxM1mjhAmbWUFRKvCmy5KvYJwVLBIRSwRhz5zpZ
	b5ZuwL4iE6RTuPBuLsY+LSfmDmLqIKJeN9hSwZ7Nx87haRI3dKFt08VKxNWgSQutMUrFpngoV1A
	GfYumT5Kz6KXSpgQSJ57YTIxZ0zwWxTQBarpm6riNAQnDZ2jzXm9cOB8awxeeZdD5ftNiuHGVzx
	gMjnJA8wNpgFMPng3OeTQRpVuID66XMs1ct0qyKQzQ9VgdQhYJ2RPHeurplaByoaDrtsQ1W4T9L
	EGuiNyLBuUi91pGcgP6lXqju6fwjnfSBlnSgI4ku+LW02Mb7gR5L81e9XL1nYK/1tSqKNojOmgW
	/D2hM2JDXmTgPDgspy85DA8f9DFEEMARuPncgPQKjXg/UkK3/tVHJJYv7lWC5ZePDGFfrrNjXhw
	vzbOaJ7l/CV+gUcFn3XhJ5V2HNHHUgfFSGx6ApJKILm+c506OZoqjsVxq1wNe0qPAFkLDffLS1h
	Jghy/dZcwTNVeduIdzT+jv3B6uAh4ZbTfq/wFsm4a4E/h6Gd+3tPcJ5/rL5bj+hNIZyGeu284yl
	w3U8=
X-Received: by 2002:a05:6402:5d4:b0:6b5:5fc8:9ca2 with SMTP id 4fb4d7f45d1cf-6b7c0c7dc86mr3462293a12.34.1794622763911;
        Fri, 13 Nov 2026 18:19:23 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c266cf12sm1713069a12.37.2026.11.13.18.19.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 18:19:23 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so2831625a12.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 18:19:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGbsWDmUp+/ItJ7ge13UUUmcYDmokP9ja4jwPs0dpeY71V0bQUj0AVrho5ZdUuWjkQuWvbkrxY=@vger.kernel.org
X-Received: by 2002:a05:6402:2b87:b0:6b5:8695:f839 with SMTP id
 4fb4d7f45d1cf-6b7c0d24fdfmr3606529a12.45.1794622762852; Fri, 13 Nov 2026
 18:19:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au> <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au> <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au> <CAHk-=whXvVO6a5AreZu3LPBj_wjpzUanwhvu8WqWP2q7g5S7Vw@mail.gmail.com>
 <auy-7TvVzJ-VCrG4@milan> <avcKfEvln8_2a7fJ@gondor.apana.org.au>
 <CAHk-=wg9baZ9EDhZr7ONxjuO65+vvWFo5E2hgxt+3rYo1vnhyA@mail.gmail.com> <aves3p5vrqqAuHma@gondor.apana.org.au>
In-Reply-To: <aves3p5vrqqAuHma@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Nov 2026 18:19:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjhtBnAz6YniHqcVJDCDvVVNp_UUL3QbiYyS6u+yKcNgQ@mail.gmail.com>
X-Gm-Features: AclHuK9T8qB_5bmjhcK4UnFzb5yfP0GrEfjJOo4l7azLABG4Kermbip3IVeKi4Q
Message-ID: <CAHk-=wjhtBnAz6YniHqcVJDCDvVVNp_UUL3QbiYyS6u+yKcNgQ@mail.gmail.com>
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

On Fri, 13 Nov 2026 at 16:35, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> That would make sense for direct vmalloc calls.  But this is
> kvmalloc, which is supposed to choose automatically between
> kmalloc and vmalloc.

Yes. But that cl;early caused problems, and then people seemed to
start thinking that it meant that the vmalloc side should also work
with GFP_ATOMIC.

If you are in atomic context, then kvmalloc() makes no sense, since
the vmalloc makes no sense. You should use kmalloc.

          Linus
