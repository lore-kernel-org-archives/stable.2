Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920907;
	b=npG9uK5Coi09nUjdisTxOCjmUn6jSQ8piYI943D3QeIl8RYFMbHtaFi/1z9B97m4O8S+
	 R1aL6Mr4GIpYPK6YqdiXr42Xgi0kyN4uXxsSaXYAvc2QkHPPQ6FO4iOKgImrTu77B/6gX
	 T2uUjW1Aim3LxMGmroMhjx445TpNVAGNsxtNqt5K8gNX9vlA7OjDWQeuDcHe/yiT6kZHk
	 R0W/n8SXr8teqYZxC1gv4+WL+XGwfYf57PltNCRYAYAhx1yRYY9QQ58r7GV4PTetubOSs
	 qm0AieT+7FcnTMiWYHmaklwkSXHuCXrzpgJSthLEbmMOtgDul6dOGZhnjcTD3jPzKRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920907;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=r3fOCQdjHLQtrv80w46oYG+ZzeQD38zM0ynHLGL06zg=;
	b=N3T57GStAEM6bI4VpZwEA2s6RoQLRXFUuLRPgvVd61soyo+0XKSaSdygh6IQlQmWvviV
	 inEsLBT16Ph4Jk+KEpUZoIY2xcaxfxPRVu6Iu8ZgamqXyWAhEKAmRUUO34OSi8n/nps9v
	 NIWKaUE7Rodqvj9GxujdnhZPYRfBlXEl9nY0rYBsvTqwmgbc7AgtfOvqAPPn2CmtqBgTX
	 yLEjYkJ1dHKfJXoCng6BrcjZGCnNn6DAZ+qDufIyTas4AGiYoC6SaPiJf1UmXEkOHmoyz
	 cNIte99XY3z8U6cInvY22dMbeK5khxonaVH4t67ezcz/1XGobcMdLket3ipqHSnDuwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eODroBU1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7E606A323;
	Tue, 17 Nov 2026 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eODroBU1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4812A1F000CA;
	Tue, 17 Nov 2026 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920906;
	bh=r3fOCQdjHLQtrv80w46oYG+ZzeQD38zM0ynHLGL06zg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eODroBU1dABEtH7DPElFrq6ojWYH/JUk1tDrenPyOgangSHitSnkBEzIJbxKtiscP
	 LoZ1g84TwXo0rSzjzehxISA49c39ReBEj8KWj6bCxc/mBv0uIpLbjafpiCHBOPqnnf
	 K47EBkOigwykyTHGYWlgSZXsza7LJZBbi7M7Ywm2ajOMW7UqZBlPen8vRe81DfJ7y1
	 p0Kwxb8ipPxPIxJLRayDyhoX+N3t+K1mqA7sTRELJT3xsYq7uH3CdHM0CC2HxI3Tpl
	 0+8DstV7PKjJH9jerX6M0gl/d8SIbpT2rAEeHZbl9wGCUZ4MzRCPJAo8yvyBKV2ntP
	 aar3zqpz5Buuw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Andrew Davis <afd@ti.com>, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261104193038.91614-1-danishkhateeb03@gmail.com>
References: <20261104193038.91614-1-danishkhateeb03@gmail.com>
Subject: Re: (subset) [PATCH v4] leds: tca6507: Fix use-after-free on
 unbind
Message-Id: <179492090504.5831.10534337417357138621.b4-ty@b4>
Date: Tue, 17 Nov 2026 13:08:25 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 04 Nov 2026 13:30:38 -0600, Danish Khateeb wrote:
> Since the LEDs are registered with devm_led_classdev_register(), they
> are unregistered only after tca6507_remove() has cancelled the work.
> Unregistering an LED that is on turns it off, which queues the work
> again from led_assign(), and the work then runs after devres has freed
> the chip:
> 
>   BUG: KASAN: slab-use-after-free in assign_work+0x414/0x5b0
>   Read of size 8 at addr ffff888010d5c0c0 by task kworker/1:2/65
>   ...
>   Last potentially related work creation:
>    ...
>    queue_work_on+0xb6/0xc0
>    led_assign+0x223/0x340 [leds_tca6507]
>    led_classdev_unregister+0x26b/0x340
>    release_nodes+0xb3/0x140
>    devres_release_group+0x247/0x470
>    i2c_device_remove+0xbf/0x1b0
> 
> [...]

Applied, thanks!

[1/1] leds: tca6507: Fix use-after-free on unbind
      commit: c92d6666ffaca04015e91df3b1789c15c965e3d2

--
Lee Jones [李琼斯]

