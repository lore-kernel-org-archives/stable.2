Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794540102;
	b=cpWXlwBWdLFQJKq36TLoJaU24m3yDF1gW0aAD+8W0O14vt+MDZzfRqbJtos8660dEI8o
	 GNtsA3UuotK5BLHAhTIGzDHvFjyVtTLoocx1t7gjnQEnTsq5vdwfM8ffJMtcuXdcjcWPJ
	 fqtDYefFZNigaZk9GoDWo0/Fypvr03a82Vp8JJgNGtsTRHnLe+5rPY1qUfCrtSvX2Vned
	 YfnrZ3K8uzA6jfvM+68VdXP5ToB3jWVjBTp27IcHYZ+Q2JK3yo9J4zZr5Csue55ADPT2X
	 q2RQddIgjZ8GloOBkxkbLhnXsncc6N5ALOfx07Ok9x0ZuUvaAJ+92E5RGBXqU83Lvpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KlC7kz5Wd2GugrQzeadNEBgbSiUKxvLtosrmHbuGMxk=;
	b=ibVoUOzDcXq6I0PUJJxANqDYuE8P6X0jWChmshjhVOJ7pv8/9005cQ37DVVqNqrbBAg7
	 yoXlXEhBpVTwRDkGz+3qrVxKonWaO2mzDBiGTuOvRrQx+TJOvUBBcJjywqylgPaYyhtsY
	 /CgttX8UWHIWWuWqpXlhp5/Np4xCmKpZNZ5S/fD3Xb0z237TTrA5cXLROLuyFvr1owzt+
	 +SySZrzCv4WHuC0FepnaXfKcWZ3ktgCcOtVlIoV/59O+YM9hRLRQolgEs7AkV6N6sCH2P
	 nYTAl08wopWTXfZ6O1V9LKlqSh8GSlzB1WW5wO+rOZ4eJbjdaCkURbb27NCVyagJB7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+yKKFSE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869B606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B869B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+yKKFSE
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso114297137.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794540101; cv=none;
        d=google.com; s=arc-20260327;
        b=UmzNJ41WQiA2LtiU6trj/Bl4VQvfZrq6f2aiXOBnwusKFfzW5jrDaAliYUO6SGghkv
         fQ0+Ha8+eNVVLL0wpkazwFbIxOsqUMmJiQrcN9U777mJs5b4+p0ohZ/+RUpzjz/1lQfV
         bGs4Pd0ha4e1A5hJsgAgFSkiDpe2Ma0apB5lgMYn2insuq22nONd5y8Gn04IE3t4Xe5G
         MRAXqZS8M26Mfkc2E6MHKt5Grj8q/cjafWp6zat8pqsTtux5v8vJef5TfJVTpq1o2P75
         JpQWRLBQs7PLN4RI97Tq04q8t+TpaJQDC7GZ5GEbVyEXAawYHs4EdlghX6egOxWuKh3v
         j31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=KlC7kz5Wd2GugrQzeadNEBgbSiUKxvLtosrmHbuGMxk=;
        fh=Szw98snw+xO5AjdgUbrVsMIQcJXeJzrruin6e4a6tpU=;
        b=bzF6gwiAxJrMoYaCDjpXd3KSmedkICi/BJatAtef7wyy1tfw9k3NthpZWsd7pyL4Rk
         BFeGAwKA8lA4VEZ5J25WhMwdrspTo7HpklEjaIXGfok1ETyghssqoop+4/o3MDepW7lZ
         2svynG+wmZ3mUzIJx8Lbz+5NBjt/omlzMlGxGxq0+zah+XeLNP1ycpWl7wE2g3obSCBe
         p/zuQX67g3N1rfBbGUPid2KPtUoQajVUCOLUVBh4MgkMNIu6GAbq/Vo2jE4QTbbG+xCD
         F8tyJTpDrKKaY5Z5WH/RMf6/SiNQiNuAkQ6xC1N7YusAxj2GcNA1o2mF9ux7ZypzqJhD
         zNmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794540101; x=1795144901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlC7kz5Wd2GugrQzeadNEBgbSiUKxvLtosrmHbuGMxk=;
        b=p+yKKFSEqRUjbz47fBwoJzJkS4+jhIUzdjZZZSJ0azUfzJBRj5DHk0RgEvku/oYJxo
         XxcqzyLF3WMhME6fBoDP+MsSVr/fV3oX3jJQBy0FwS5rOXOZYhgJIKxrjh4O7jZS/MOd
         HPhv3+N//W02rVjqCkp5DD6PWaKm6pkVcOTmBgAs69qYezPxCuC5P1udn2MiPjTn5Hox
         rmmWjAXCjA1y1up4AQwQHY054NrxA1WZB1Fp+fNZ34v0JSv2b/oIxvcrB/mI4ckheFe7
         xrqFDzO/PFUEbh8XoMu5qiIHHdWIzrAOWm9eqUUWS1LHGyzjjqF4gHwTi+XgzArqUMXF
         kRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794540101; x=1795144901;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KlC7kz5Wd2GugrQzeadNEBgbSiUKxvLtosrmHbuGMxk=;
        b=RPcMLaD63krYW1IYNN16PGbFuFc4z6eV1HUXxKhYM9KzOXt+4gYzPF6EgY8VpnLlrm
         IRkwgEwLTTt+sRyTtWzO/7KjuFvUMSMSv6A4AxiKIB63b9tM8TFvrrBS/nYP+FyT92/B
         dIhuTtz7I4sZroRNoAiZYAW7yqUxZGqT+HAfZYUO5AKp8LVNxynmwRuLRNRs7mYgxWVq
         R+BWLlv42w8gkXTocDk6jkes8DL+g6NU+1qp/DQiGKyCRVrpTaEXY2cMH2CnFpG5BlTl
         grBttZ6uG8bNLqJT4wJcucxi2sOv9L6tu3whdpYNtMmDXO3zZsEbJluLXYTPuLAC+hFa
         Qwpg==
X-Forwarded-Encrypted: i=1; AL+hErFZUHyeQXfOLZT02a+ArcIKWwWEiducpkBSmIRHhPYxlT4p0w0YLjyLYq04Z+Ffusdt8xDhtSU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HGBM0MjcmDDDZjLzwtpM0MhZi2b47H7Ijrd2xCvYsIHPNSkgf
	UYv3q/Dj48+LKR8Ybf+2GnHtveEsT4YEC4TzbJIzneh1UFCIuV8t6oFMeNTJwh21tzu4RMVwwwA
	eel6ghcBlpKGZR649KSEYUHA2DzG4FymO7g==
X-Gm-Gg: AYBFou1f1jvqFk1zdMzE4XIT0FjIz+2kxZFr04JDCtfU2KfdQl1hGW1zFxSuG5utZ2E
	kYAHJ5pmNX4OsOGGXVHZmsbk4BJ3njuljI11W+Loc0vEwkRD4RUxpYc330vZt+Mqc6qO2a+N8c2
	NtvUFfV7bhlpaEgIOaCjpIqjHH6XKQZfp1MT6YGaE7mOXY09NQbh5cxIrLsZH9LTJMfGh+eFIZw
	mQ+xAHr9S71uv7im5zW38BRXK5MjM2E+lo+aZY7RWU+wADSeTGQAxFAgKcKc4m0aaNGhxTwUyLx
	gowtnwTTy1AD2t1Kl33/R9vysNLnRgp5WW7D5p5nGhN+PeMX4S7ZfCZLW1CPUdR7V2sinzk3Sn6
	jAfmlaJB605gFC/edw/NN6seIlyJk37L9phjQ
X-Received: by 2002:a05:6102:c86:b0:7cc:2daa:90ee with SMTP id
 ada2fe7eead31-7d64d74eefemr361865137.15.1794540100262; Thu, 12 Nov 2026
 19:21:40 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 12 Nov 2026 19:21:39 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: enderaoelyther@gmail.com
In-Reply-To: <27d2c98928859d47b2c3cf76870d868882685809.camel@sipsolutions.net>
References: <20261028141751.6728-1-enderaoelyther@gmail.com>
		 <20261028141751.6728-3-enderaoelyther@gmail.com>		 (sfid-20261028_151822_083722_A5EF7A18)
 <76bc126fb977cac0f0a124fc80eae9fdb803264d.camel@sipsolutions.net>
	 <CACHPgzw-JeorCAX-b5jjd6d5=L0oYpPdGtstUSaz5sPKZE2HsQ@mail.gmail.com>
	 (sfid-20261111_204546_211086_1FE84B1B) <27d2c98928859d47b2c3cf76870d868882685809.camel@sipsolutions.net>
Date: Thu, 12 Nov 2026 19:21:39 -0800
X-Gm-Features: AclHuK80WoaUMO0xvfMrBMj1IE6hAop1teGb0zcH15s2lA-M5re3Tk-IE5T-ugg
Message-ID: <CACHPgzyGx7trDo1+j_HKCNaQn8K9ZE_nxDX5ZxDfx=U3kxTAdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mac80211_hwsim: serialize radio removal with
 frame commands
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "John W. Linville" <linville@tuxdriver.com>, Javier Lopez <jlopex@gmail.com>, 
	Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> hwsim_tx_info_frame_received_nl() just doesn't do anything that sleeps,
> so it could just use RCU protection directly?

Agreed, and the same applies to the inner transmitter lookup (txdata) in
hwsim_cloned_frame_received_nl(). Extending rcu_read_lock() across the
full use works there, since teardown unpublishes the radio before
ieee80211_unregister_hw() and wiphy_unregister() unconditionally runs
synchronize_rcu() before ieee80211_free_hw().

> hwsim_cloned_frame_received_nl() uses it twice - the inner use is not an
> issue as above, and the outer one is just acquiring the mutex for
> synchronization with ->started, but given that mac80211 will sync RCU in
> stop that's perhaps just not needed at all? Or maybe hwsim just needs to
> synchronize_net() on stop.

The existing mac80211 grace period is too early to replace the mutex
during an ordinary stop. It runs in ieee80211_do_stop() before
drv_stop() invokes mac80211_hwsim_stop(). Since the hwsim radio remains
published, a new reader can start after that grace period, observe
->started as true, and then be delayed until after the driver has
stopped. That is the window the current data->mutex closes.

Setting ->started to false and then calling synchronize_net() in
mac80211_hwsim_stop() could replace that mutex. That would be a
different synchronization protocol, with the grace-period cost moved to
every radio stop instead of keeping the existing per-radio exclusion.

> hwsim_pmsr_report_nl() uses the mutex for pmsr_request access/swap and
> GFP_KERNEL, but both of those could change? might need some more work
> for abort though, not sure.

The abort ordering is the difficult part. cfg80211 moves the request out
of its list, calls the driver's abort callback, and frees the request as
soon as that callback returns. The existing data->mutex therefore does
more than protect the pointer swap: it prevents abort from returning
while the report path is still using the request.

Changing the allocation flags or atomically clearing pmsr_request would
not provide that exclusion. Abort could observe the cleared pointer,
return, and let cfg80211 free the request while the report path was
still using its local copy. Avoiding the mutex would require a new
request-ownership protocol that abort also waits for.

So I agree that direct RCU can cover the two non-sleeping lookup uses,
and it could cover the outer cloned-frame use with the stop change
above. It does not cover the PMSR path without redesigning the request
lifetime.

A hybrid design is possible in principle: use RCU for the frame and
TX-status paths and retain a per-radio pin for PMSR. The reference
version instead keeps one lookup-lifetime rule and leaves both the
existing stop synchronization and PMSR ownership protocol unchanged.
Its trade-off is the short hwsim_radio_lock critical section and the
reference operations on every lookup.

I still think the single reference-based rule is the smaller and less
fragile change overall, but I agree the RCU approach avoids that
lookup-side cost on the packet paths.

Thanks,
Zhao

On Wed, 11 Nov 2026 21:34:12 +0100, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2026-11-11 at 14:45 -0500, enderaoelyther@gmail.com wrote:
> >
> >
> > The underlying problem is per-radio object lifetime, not command
> > serialization. get_hwsim_data_ref_from_addr() returns a radio pointer
> > after rhashtable_lookup_fast() has already ended its RCU read-side
> > protection. A concurrent deletion can then unpublish and free that radio
> > while a frame, TX-status, or PMSR command is still using the pointer.
> >
> > I reworked the fix around a per-radio reference count.
>
> I'm not convinced that's necessary.
>
> There are three users of get_hwsim_data_ref_from_addr:
>
> hwsim_tx_info_frame_received_nl() just doesn't do anything that sleeps,
> so it could just use RCU protection directly?
>
> hwsim_cloned_frame_received_nl() uses it twice - the inner use is not an
> issue as above, and the outer one is just acquiring the mutex for
> synchronization with ->started, but given that mac80211 will sync RCU in
> stop that's perhaps just not needed at all? Or maybe hwsim just needs to
> synchronize_net() on stop.
>
> hwsim_pmsr_report_nl() uses the mutex for pmsr_request access/swap and
> GFP_KERNEL, but both of those could change? might need some more work
> for abort though, not sure.
>
> Dunno if that's better overall? Maybe, maybe not.
>
> johannes
