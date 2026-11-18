Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027753;
	b=WsmHI4F6auMG3ZqidfVgyJkw0gQyp7aJ46qOpAyjflyu04BvwdyXKBUbd2g0pynoKvy+
	 ryBhPVZE2g1tjAxelgU41DbKLCKfL8NqZHGJ139fn093F/6bLguRaNni9oNp8+LYu5He3
	 cVrQPLIAYOEyObSA/MVls4dbAL/EdJ3nUMN9yJEu0bKLlRU8UEtEq5vg4E8uHE+B/iNs5
	 VVppJ6Vs6YETXpWQaup2RrQNodsaBWiNaqyIbY+X645eAqmPAHjfSzsusl2JS/Dy0H27W
	 28nCrPwoaDMlYiuYjkmicsbWuCP4XvpjYZEiYLkHnc9P+modm8/9QVtaaC/HA9lX80w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027753;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=IT35RAfppl4UUehoSk7nGvH1FGnD4GHel2o1zUJJqNo=;
	b=DBF48FXXWBVycmj0n+fj4YX8UpXTwAOT2WQSsyHIvcV45iFa1z6yROSrLi5jcDQvUctz
	 mhOU+QQ6P0Q4Ll85+dHk83rzDEQJjl2PS6/1fPKCYS7O6br4P3szgClGNYFdMDT2ktS1N
	 oEblKJrmz4AEjz0aVys7kyTnOaMa18zUvy1YgurhnVfWR1C++cqiQ2ifpY8HuNMyt9lg5
	 wU8BUfnLifWes0JPPryTm/RYw3Zr9CWrDjeUB0Ww47H+tHUuFfNOMcMkf0ejGGnNTJC6T
	 EC0TtLltrCnwVhuNdp2Lk6P1XIVWiJpGR8l8PBw/p4chYKlbOQfjNwLkwI61M/ii4QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DmVVW2rU;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE098606A335
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE098606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DmVVW2rU
DKIM2-Signature:  i=1; m=1; t=1795027750;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:erop3pnGay6q6YNUa/8JSt1EnA71
   Yj4g/w5oLaBTS4ngGDaVd8X4+sxbKLPgKSxFmqUbUbmlj8OJ6zVe7KEl+FwTgCNUsVvG6cUtbo2
   tGryy418A/FIXEePqb0qtLfLL9kMZqF4tJzvUUx3OaTl1EYqpZHQvoAPKdYRznnF2mHZsAD1X6v
   AROzhHrAwR9SCbr7lQzG2JiXoz5elx//wTmaZjNUp+DBWt4mf9zyyW5CgoG8QJr3qohwAFuj4F3
   0Aln6ca+3YY4upgM6DLwb05uYWc8FLaIhqY2r6FJ3+KMBy52ggszgFyTL2vBto0QsbcSymIrJuI
   r8SVshqN5K1wUg==;
Message-Instance:  m=1;
 h=sha256:
   yuTDrZq77bOv399nY8P+UsDCwyojnUe8qz2FoHp2qQ4=:
   GZos7/OV7nF0/1naFtMcLo/9bq9x30+wMfNoYVdcA3Q=,
  sha512:
   SOk83oPQobIDVprCBGjYFrsGXS9Wz5T2aJUj7Ztrxg1+54SUA7ExjJMvUsbEUBYQia2t8/pI/0hBcaM7swg3zA==:
   Mhj1n9lJ4UyOnUeZbx03hubdrc9Tn1qLdgIZ419QumcSZD6T96AAgiJ/nCkhSNa9/3IZP4gHO7p8KNoLD0iotg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795027729; x=1795632529; i=deller@gmx.de;
	bh=IT35RAfppl4UUehoSk7nGvH1FGnD4GHel2o1zUJJqNo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DmVVW2rU5Y8uaC/rcn9NxC6ovweshvibcWNogPBOlb0GawX3T02M7mv32TbNcbWQ
	 ARLxABSCGBnVJKY6y9A9Dbjtj9LerlUGN41TEPlWMgGe7SBV4TtJRJwck73xMaIQt
	 LUhlqomCA9tnQCp8qwRKsYZVZsYh1NnL2PKVOz1Ne/bYPBGeNmEQeFT936HC0NejA
	 M7x7c0xXVm4+swBNly+nPZ000SHfRopkBI0wiSJ0Ndltgwxd0t7bdWSyuKasxghJ2
	 3TaROMeiU2kMcXF22u8kHtp42muDdvyiYB2dSArq4PZHykBHOiJZ5r3lL4ecLRLrB
	 5B3sdmMoZtq8ETItcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1xKv1V0ysS-00GLkY; Wed, 18
 Nov 2026 19:48:49 +0100
Message-ID: <4f2af4ab-2fd7-4564-9d71-638a8a991de2@gmx.de>
Date: Wed, 18 Nov 2026 19:48:46 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: cirrusfb: Fix overflow in the video memory check
To: weidongw@illinois.edu
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Zijie Zhao <zijie4@illinois.edu>
References: <20261112-c4-n053-v1-1-1e45ef75304c@illinois.edu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261112-c4-n053-v1-1-1e45ef75304c@illinois.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DYdIltZRJ3ji6+FI6ywq2lhZPbIFYp84zt53H4r0ZHJgDCdMfxn
 kBbCsfm3U0DSyYO49NcRvwXwZh9j8o8xSRNxULUOHHhwEDIZ1oZRY5YWuB8LCqV7MmoTJBA
 EZtgxVT3cPRtDV1ubUu8jWYeCXwcbRQ/Qvvtt+pffdqIDVejvl2QcQ4gL22E29fqMddbbQV
 jbgYGQZXvrpEu36IhHWNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M4nJkkrGyH8=;Wmic8yOSF0J3NUIt2nhlhBOkQ1y
 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

On 11/12/26 07:37, Weidong Wang via B4 Relay wrote:
> From: Weidong Wang <weidongw@illinois.edu>
>=20
> cirrusfb_check_var() raises xres_virtual to xres and then checks
> xres_virtual * yres_virtual against the video memory in 32-bit
> arithmetic. fb_set_var() checks the product for overflow, but only for
> the values passed in, before the driver raises xres_virtual. A mode with
> xres 65536, xres_virtual 640 and yres_virtual 65536 passes that check,
> becomes 65536 x 65536 in cirrusfb_check_var(), and the product wraps to
> 0, so the mode is accepted on a 4 MiB card with a line length of
> 65536 bytes. The framebuffer console then draws at offsets far past the
> end of the video memory mapping.
>=20
> Do the multiplication in 64 bits.
>=20
> Found by an AI code review agent (an LLM-based bug-finding tool
> developed by Zijie Zhao and the submitter) and confirmed on an
> unmodified kernel, without error injection, on x86_64 under QEMU with
> -vga cirrus (GD5446, 4 MiB) and KASAN. FBIOPUT_VSCREENINFO with
> xres 65536, yres 128, xres_virtual 640, yres_virtual 65536 at 8 bpp is
> accepted as 65536x128, virtual 65536x65536. Booted with
> video=3Dcirrusfb:noaccel, fbcon's redraw then faults:
>=20
>    BUG: unable to handle page fault for address: ffffc90000b00000
>    RIP: 0010:cfb_imageblit+0xbc6/0x1970
>     soft_cursor+0x5eb/0xcd0
>     bit_cursor+0xb41/0x1910
>     hide_cursor+0x6e/0x1d0
>=20
> With acceleration enabled, text on the GD5446 is drawn with the blitter,
> which QEMU bounds, so the mode is accepted but nothing faults; drawing
> goes through the CPU with noaccel and on the Laguna chips, which always
> run without acceleration. Asked for without the wrap, as 65536x128 with
> a 65536x128 virtual resolution (8 MiB), the mode is rejected, as it
> should be.
>=20
> With this patch the mode is rejected with "virtual resolution too high
> to fit into video memory", and 1024x768x8 is still accepted.
>=20
> The reproducer, fix and changelog were drafted with AI assistance
> (Claude), then reviewed and tested by the submitter.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Cc: Zijie Zhao <zijie4@illinois.edu>
> Signed-off-by: Weidong Wang <weidongw@illinois.edu>
> ---
> Tested on v7.4-rc1 (05441d697f7f), x86_64, KASAN, QEMU/KVM -vga cirrus
> (GD5446, 4 MiB). FBIOPUT_VSCREENINFO at 8 bpp:
>=20
>                 65536x128, virtual 640x65536    65536x128, virtual 65536=
x128
>                                                 (control)
>    unpatched    accepted as virtual 65536x65536; rejected
>                 with noaccel, fbcon faults in
>                 cfb_imageblit, panic
>    patched      rejected                        rejected


can't you simply check xres_virtual and yres_virtual values
against sane values, e.g. bail out if each of them is bigger than
e.g. 16384 pixels ?

Helge
