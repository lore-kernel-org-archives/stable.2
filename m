Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383771;
	b=19gYfYYT8MvWbG0qqOLyadQTxjBMf8+pwneyHH0KuQcODTFqnZxCe3IBad/UqYII6DjM
	 SvQVQ1tywJA7UjBrXsoSjvdo+KYR/vOHY01+YdNT/WzPn4BZTG68wmYdnfrn+ueJfBmtt
	 5qCGVlpp8ACPIBwG59RvZiOuT0hHGavjeys++Tq8CulH6mXJbn30Nd3HtvZB91ZRclOCr
	 DJYbq5Ai7BKq58EDRl5ZcJ8Nw9b48eU1bqYolJ7A6BA/YcrFzC0cFlOjqgGAW23fl3TGs
	 WOnIDe50B0BagsDemspuFC/MkWnsp7N4ZxMM6F/J3NJWUMIjO6RUAPr7aLaGW2X+jZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=b0Vaf0OWgV65b40bb86pOZzRhH7cFTFGJOK7iQMFsxQ=;
	b=auxKVxUPGq8MroplhPq/1t9IgkjJWMngC7WllCwS4Qn87kPWKfBi5FKa3N+SpoeY4Sib
	 RqrDYiNlANmKyRuyAHD1tUXFnl3SJXycXI/a0afmUsZn1SWFd8u8Kae1OFXrQL3e2sZ5/
	 gk48rX28aEvHHRA013oQ/czCqRZpsNHeDrywf9KwJlT5iUJZBklnpBntAuYH6byHBH/Zg
	 IrYsVTEvmXHjy4EOBohHx2L/fmL8pdnyTzsi+td6efGNbgX663YPBZb0YB8Ba90VM06XK
	 koCAfRL/pvZ4gt3Db3uiNnmTa3O7KDieKqGEsqAnLy/LtZkD6VR8jwEfQ8Ihg7fh/EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=HEjMFjc9;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023BB606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023BB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=HEjMFjc9
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so22551945e9.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794383769; x=1794988569; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b0Vaf0OWgV65b40bb86pOZzRhH7cFTFGJOK7iQMFsxQ=;
        b=HEjMFjc9rcrAgpxiPtCpDiBF15N2lxFYzCAfn9+tNfCQtIjxgP8o5Dymthdy33fywc
         bcWDwNnBkbccTdz4QqIjBI4YK+LbYGZ+lO864HP+Loknip/zDSZcub40K4SyhOVuLP7/
         9XMf1kUaASNfCLExr0XaTX9lL4Azh+pJkaJEk7I9PxqNDAeTGbb626YknBhgM9NuIKLl
         Rkli9kULcEE4GLCZlKVbFpFmw7gTIpan1bupxhGeOcY9sgVI86xuY7yuEz8MLtAw0Vli
         83yejYDgfMw5OsX8CsuwsuwxdjpyGYsZ80sNg9mbCbOvRi+GZPIBliwDJRPTnlks3Wms
         bzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383769; x=1794988569;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0Vaf0OWgV65b40bb86pOZzRhH7cFTFGJOK7iQMFsxQ=;
        b=LJxbF8Dz9HOh9DoNF+4c7Fsgo/e+VVykAZozvXiVlq1AXF63YdTYN/by5bgOucdoVm
         5Gx/MA+KavrOW77dapHdTdzc+N554/0hfIWrltu++K6P8l92f8yXlQqnskd+1kMksqM4
         iN/z6Wa4FZ6Q4LV1n3H63Li1m/QPCXFGpmpbogXKUrbTCpS7V3/GDfM1TMa/kUC52ICC
         7ZcuwxekMSKKoLOwx5qkGwZt2Xr9gKnDe7OD0EedNk6NFVEFpSPGonRNM836qYiyY7T7
         Vs21a/ppVhmr28dcjd0jaOllgTsJRgDLd4beMdlhd76Vvj3vYB/GFy7v9TmzHGU1C6yd
         g5Eg==
X-Forwarded-Encrypted: i=1; AL+hErH0pNcZpPZRSA8uv0h8IUpxvVKkVMOMbDKi+QZHOtxtDlCAG+jg4n+FZxxyJXNXYKWSesPxkXw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mIoDF5WDBIE//l0dHAaIlKhcwVyTmhz1m6OJjIzGVoTcbRE1U
	a3gOGTYo12IyiSFOJvjKINoPEM1jQTMwXQs4MItwp4NHBzxbpt1dngkQ3g13vzaD5/8=
X-Gm-Gg: AYBFou1T/JlQoE9yGOnDtHoEeP1Llx3WOLBo0JcgFTX6gfZ4+G5Kj4RiuJc5+ZvsRK/
	mTFIxeqogtk2JnFE7AVbPawKX8INLq+A/kmloWHv7e72GfAOO7LII37uaqFM4Ig3P9XNNFyKK9Z
	5Prk132QW9YvBJSmBfej6z+s6RuvBiLFPrjKq1AsRRgfvomSp4MdTwvEbDXsXnbt6Pee1dSSBt1
	kMUoXTXQPE4XzU9RpmUcAfDNYDLbqFvdSarWHlOnyMLuPMmmgUBr4WzcAf2iTX29JCjvZiFGbKS
	PywV26XRQ3CtQtFcSmcv0Pp8o93fUasaiuP8P48Hi2utaBczAg4dFZ9ys6R9WKaNnXiJj1xe86J
	T0MKK159Ip8jIgMC6uc6bt5zrnp56jmkxoFDwubEzx9Wx/LeDtCbu7GoxHTLCq+HqTOIJcEpScX
	nac/p+/8sQTDyvs952/1/bO0L7OyJtFrZPIDZgNnmNosvAT2GmYtT10ZJCWL01nmO2yacd1IPkL
	KAbd4V+89visWiQyTzrcBXCvaK2cYny0M+7STFSiC6MkgqgArg6kFzNod/Jdb5f4sLN9Grqyay6
	z/DqlTV6fmdg1EkH4w9jPTvqV5//qunOhgiswZE6edpbhrjpD9RU6utOU9tlZszASrEBCb1x0fU
	xsm3H9ZAd/yqCWep3u/2rQ53W6pQYP3aI7dIrXC2Cp6WmiE0r73U=
X-Received: by 2002:a05:600c:4f14:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4ba093b5ec4mr30425115e9.29.1794383769213;
        Tue, 10 Nov 2026 23:56:09 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm132759125e9.5.2026.11.10.23.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 23:56:08 -0800 (PST)
Message-ID: <e42561ed-cd58-4ad8-a5a6-26f9f0b65f0c@suse.com>
Date: Wed, 11 Nov 2026 08:56:07 +0100
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
Subject: Re: [PATCH] x86/xen: Fix lazy MMU pause count wrap-around
To: "M. Vefa Bicakci" <m.v.b@runbox.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102-xen-lazy-mmu-v1-1-d99a3050b76d@runbox.com>
 <36064075-fbf0-40ac-8448-60bd36ad2a28@suse.com>
 <d2577859-1468-4892-af5b-7912aabd402a@runbox.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <d2577859-1468-4892-af5b-7912aabd402a@runbox.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EMnSocGpP04TlxlB09ymaZJw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EMnSocGpP04TlxlB09ymaZJw
Content-Type: multipart/mixed; boundary="------------I6Qouo7kO2ONsbd0kI55lGMT";
 protected-headers="v1"; hp="clear"
Message-ID: <e42561ed-cd58-4ad8-a5a6-26f9f0b65f0c@suse.com>
Date: Wed, 11 Nov 2026 08:56:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen: Fix lazy MMU pause count wrap-around
To: "M. Vefa Bicakci" <m.v.b@runbox.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102-xen-lazy-mmu-v1-1-d99a3050b76d@runbox.com>
 <36064075-fbf0-40ac-8448-60bd36ad2a28@suse.com>
 <d2577859-1468-4892-af5b-7912aabd402a@runbox.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <d2577859-1468-4892-af5b-7912aabd402a@runbox.com>

--------------I6Qouo7kO2ONsbd0kI55lGMT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMTEuMjYgMTk6NDIsIE0uIFZlZmEgQmljYWtjaSB3cm90ZToNCj4gT24gMjAyNi0x
MS0wOSAwMTo0MCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gDQo+PiBPbiAwMi4xMS4yNiAx
NjozMSwgTS4gVmVmYSBCaWNha2NpIHdyb3RlOg0KPj4+IENvbW1pdCBiZWM2ZjQxYTZmZTUg
KCJ4ODYveGVuOiBHZXQgcmlkIG9mIGxhc3QgWEVOX0xBWllfTU1VIHVzZXMiKQ0KPj4+IHVu
aW50ZW50aW9uYWxseSBwcmV2ZW50cyB0aGUgYWN0aXZhdGlvbiBvZiBsYXp5IE1NVSBtb2Rl
IGZvciBtb3N0IHRhc2tzDQo+Pj4gcnVubmluZyBvbiBYZW4gUFYgVk1zIChpbmNsdWRpbmcg
ZG9tMCkuDQo+Pj4NCj4+PiBUaGF0IGNvbW1pdCBtYWRlIHhlbl9lbmRfY29udGV4dF9zd2l0
Y2goKSBjYWxsDQo+Pj4gX190YXNrX2xhenlfbW11X21vZGVfcmVzdW1lKCkgd2l0aCB0aGUg
dGFzayBiZWluZyBzd2l0Y2hlZCB0by4gSG93ZXZlciwNCj4+PiB0aGUgbGF0dGVyIGZ1bmN0
aW9uIGRlY3JlbWVudHMgdGhlIHBhdXNlX2NvdW50IGZpZWxkIG9mIHRoZSB0YXNrIHdpdGhv
dXQNCj4+PiBjaGVja2luZyB3aGV0aGVyIHRoYXQgdGFzaydzIGxhenkgTU1VIG1vZGUgd2Fz
IHBhdXNlZCBvciBub3QuIEEgdGFzaw0KPj4+IGJlaW5nIHN3aXRjaGVkIHRvIGZvciB0aGUg
Zmlyc3QgdGltZSBoYXMgbmV2ZXIgYmVlbiBzd2l0Y2hlZCBmcm9tLCBzbw0KPj4+IGF0dGVt
cHRpbmcgdG8gcmVzdW1lIGxhenkgTU1VIG1vZGUgY2FuIHdyYXAtYXJvdW5kICh1bmRlcmZs
b3cpIHRoZQ0KPj4+IHBhdXNlX2NvdW50IGZyb20gMCB0byAyNTUgKFU4X01BWCkuDQo+Pj4N
Cj4+PiBGdXJ0aGVybW9yZSwgdGhlIG5vbi16ZXJvIHBhdXNlX2NvdW50IGlzIGNvcGllZCB0
byBjaGlsZCB0YXNrcyBhdCBmb3JrLA0KPj4+IHNvIGFsbCBkZXNjZW5kYW50cyAoaW5jbHVk
aW5nIHRoZSBpZGxlIHRhc2tzIG9mIHRoZSBub24tYm9vdCBDUFVzKQ0KPj4+IGluaGVyaXQg
dGhlIG5vbi16ZXJvIHBhdXNlX2NvdW50LiBUaGlzIHByZXZlbnRzIGVuYWJsaW5nIGxhenkg
TU1VIG1vZGUNCj4+PiBmb3IgdGhlbSwgYmVjYXVzZSBsYXp5X21tdV9tb2RlX2VuYWJsZSgp
IGRvZXMgbm90IGRvIGFueXRoaW5nIHdoZW4NCj4+PiBwYXVzZV9jb3VudCBpcyBub24temVy
by4NCj4+Pg0KPj4+IEhlbmNlLCBjYWxsIF9fdGFza19sYXp5X21tdV9tb2RlX3Jlc3VtZSgp
IGZyb20geGVuX2VuZF9jb250ZXh0X3N3aXRjaCgpDQo+Pj4gb25seSBpZiBsYXp5IE1NVSBt
b2RlIHdhcyBwYXVzZWQuDQo+Pj4NCj4+PiBUaGlzIGlzc3VlIHdhcyBkaXNjb3ZlcmVkIHdp
dGggQ09ORklHX0RFQlVHX1ZNPXksIHdoaWNoIGVuYWJsZXMNCj4+PiBwYXVzZV9jb3VudCB1
bmRlcmZsb3cgYW5kIG92ZXJmbG93IHdhcm5pbmdzLiBJbiB0aGUgZXhhbXBsZXMgcXVvdGVk
DQo+Pj4gYmVsb3csIHRoZSBmaXJzdCB3YXJuaW5nIHNob3dzIHRoZSB1bmRlcmZsb3cgd2l0
aCBQSUQgMS4gVGhlIHNlY29uZA0KPj4+IHdhcm5pbmcgc2hvd3MgdGhlIG92ZXJmbG93IGZy
b20gMjU1IChVOF9NQVgpIHRvIDAsIGFsc28gZm9yIFBJRCAxLCBhcw0KPj4+IGluZGljYXRl
ZCBieSB0aGUgc2FtZSBSREkgcmVnaXN0ZXIgdmFsdWUuDQo+Pj4NCj4+PiBFeGFtcGxlIHBh
dXNlX2NvdW50IHVuZGVyZmxvdyB3YXJuaW5nOg0KPj4+DQo+Pj4gICAgIFdBUk5JTkc6IGlu
Y2x1ZGUvbGludXgvcGd0YWJsZS5oOjM2MiBhdCB4ZW5fZW5kX2NvbnRleHRfc3dpdGNoKzB4
NGUvMHg2MCwgQ1BVIzA6IHN3YXBwZXIvMC8wDQo+Pj4gICAgIENQVTogMCBVSUQ6IDAgUElE
OiAwIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA3LjIuNC0xICMyIFBSRUVNUFQoZnVs
bCkNCj4+PiAgICAgUklQOiBlMDMwOnhlbl9lbmRfY29udGV4dF9zd2l0Y2grMHg0ZS8weDYw
DQo+Pj4gICAgIC4uLg0KPj4+ICAgICBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAw
MDAwMDAwMDAwMDAwIFJESTogZmZmZjg4ODAwNDkzMDAwMA0KPj4+DQo+Pj4gTm90ZTogVGhl
IFBJRCBpcyBzaG93biBhcyAwIGFib3ZlLCBiZWNhdXNlIGN1cnJlbnRfdGFzayBpcyB1cGRh
dGVkIGluDQo+Pj4gX19zd2l0Y2hfdG8oKSBhZnRlciBhcmNoX2VuZF9jb250ZXh0X3N3aXRj
aCgpLiBhcmNoX2VuZF9jb250ZXh0X3N3aXRjaCgpDQo+Pj4gY2FsbHMgeGVuX2VuZF9jb250
ZXh0X3N3aXRjaCgpIGluZGlyZWN0bHkuDQo+Pj4NCj4+PiBFeGFtcGxlIHBhdXNlX2NvdW50
IG92ZXJmbG93IHdhcm5pbmc6DQo+Pj4NCj4+PiAgICAgV0FSTklORzogaW5jbHVkZS9saW51
eC9wZ3RhYmxlLmg6MzE5IGF0IHhlbl9zdGFydF9jb250ZXh0X3N3aXRjaCsweDY0LzB4NzAs
IENQVSMwOiBzd2FwcGVyLzAvMQ0KPj4+ICAgICBDUFU6IDAgVUlEOiAwIFBJRDogMSBDb21t
OiBzd2FwcGVyLzAgVGFpbnRlZDogRyAgICAgICAgVyAgNy4yLjQtMSAjMiBQUkVFTVBUKGZ1
bGwpDQo+Pj4gICAgIC4uLg0KPj4+ICAgICBSSVA6IGUwMzA6eGVuX3N0YXJ0X2NvbnRleHRf
c3dpdGNoKzB4NjQvMHg3MA0KPj4+ICAgICAuLi4NCj4+PiAgICAgUkRYOiAwMDAwMDAwMDAw
MDAwMDAwIFJTSTogMDAwMDAwMDAxM2Y3ODk0ZCBSREk6IGZmZmY4ODgwMDQ5MzAwMDANCj4+
PiAgICAgLi4uDQo+Pj4gICAgIENhbGwgVHJhY2U6DQo+Pj4gICAgICA8VEFTSz4NCj4+PiAg
ICAgIF9fc2NoZWR1bGUrMHgzNmEvMHgxYTkwDQo+Pj4gICAgICBzY2hlZHVsZSsweDI3LzB4
YTANCj4+PiAgICAgIHNjaGVkdWxlX3RpbWVvdXQrMHhiZC8weDEwMA0KPj4+ICAgICAgX193
YWl0X2Zvcl9jb21tb24rMHg5Ny8weDFiMA0KPj4+ICAgICAgd2FpdF9mb3JfY29tcGxldGlv
bl9raWxsYWJsZSsweDI0LzB4NDANCj4+PiAgICAgIF9fa3RocmVhZF9jcmVhdGVfb25fbm9k
ZSsweDEzZS8weDI0MA0KPj4+ICAgICAga3RocmVhZF9jcmVhdGVfd29ya2VyX29uX25vZGUr
MHhlZS8weDFjMA0KPj4+ICAgICAgd29ya3F1ZXVlX2luaXQrMHgyNi8weDQyMA0KPj4+ICAg
ICAga2VybmVsX2luaXRfZnJlZWFibGUrMHgxMDEvMHgzNjANCj4+PiAgICAgIGtlcm5lbF9p
bml0KzB4MWEvMHgxMzANCj4+PiAgICAgIHJldF9mcm9tX2ZvcmsrMHgyYjAvMHgzNDANCj4+
PiAgICAgIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPj4+ICAgICAgPC9UQVNLPg0K
Pj4+DQo+Pj4gRml4ZXM6IGJlYzZmNDFhNmZlNSAoIng4Ni94ZW46IEdldCByaWQgb2YgbGFz
dCBYRU5fTEFaWV9NTVUgdXNlcyIpDQo+Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcg
IyA3LjIueA0KPj4+IFNpZ25lZC1vZmYtYnk6IE0uIFZlZmEgQmljYWtjaSA8bS52LmJAcnVu
Ym94LmNvbT4NCj4+PiAtLS0NCj4+PiA9PT0gVGVzdGluZyBub3RlcyA9PT0NCj4+PiBUaGlz
IGNvbW1pdCB3YXMgdGVzdGVkIHdpdGgga2VybmVsIHY3LjMtMTY3NTUtZ2QxMzVhYjQ1M2E3
NCBhbmQgdjcuNC1yYzENCj4+PiB3aXRoIGEgZG9tVSBQViBWTSwgYW5kIHZlcnNpb25zIGZy
b20gdjcuMi40IHRvIHY3LjIuMTQgd2l0aCBkb20wIGFuZA0KPj4+IGRvbVUgUFYgVk1zIHJ1
bm5pbmcgb24gWGVuIHY0LjE5LjUuIENPTkZJR19ERUJVR19WTT15IHdhcyBzZXQgZm9yIGFs
bA0KPj4+IHRlc3RzLCBhbmQgbm8gd2FybmluZ3Mgd2VyZSBvYnNlcnZlZC4NCj4+Pg0KPj4+
ID09PSBEZWJ1Z2dpbmcgbm90ZXMgPT09DQo+Pj4gRm9yIGRlYnVnZ2luZywgSSBpbnN0cnVt
ZW50ZWQgeGVuX3N0YXJ0X2NvbnRleHRfc3dpdGNoKCksDQo+Pj4geGVuX2VuZF9jb250ZXh0
X3N3aXRjaCgpIGFuZCBjb3B5X3Byb2Nlc3MoKSwgYW5kIEkgY29uZmlybWVkIHRoYXQgdGhl
DQo+Pj4gaW5oZXJpdGVkIHBhdXNlX2NvdW50IHZhbHVlIGlzIGRlY3JlbWVudGVkIGZvciBl
YWNoIGxldmVsIG9mIHRoZSBwcm9jZXNzDQo+Pj4gdHJlZSwgc3RhcnRpbmcgZnJvbSAyNTUu
DQo+Pj4NCj4+PiA9PT0gQ3JlZGl0cyA9PT0NCj4+PiBUaGUgcGF0Y2ggd2FzIGhhbmQtd3Jp
dHRlbiwgYnV0IHRoZSBjb21taXQgbWVzc2FnZSB3YXMgcG9saXNoZWQgd2l0aCBhDQo+Pj4g
ZmV3IHJvdW5kcyBvZiBMTE0gcmV2aWV3Lg0KPj4+IC0tLQ0KPj4+ICAgIGFyY2gveDg2L3hl
bi9lbmxpZ2h0ZW5fcHYuYyB8IDEwICsrKysrKysrKy0NCj4+PiAgICBpbmNsdWRlL2xpbnV4
L3NjaGVkLmggICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrDQo+Pj4gICAgMiBmaWxl
cyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jIGIvYXJjaC94ODYveGVu
L2VubGlnaHRlbl9wdi5jDQo+Pj4gaW5kZXggYzUxMTdhNzczMGQ2Li42OGY4YTk3Nzk5OWIg
MTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+Pj4gKysr
IGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+Pj4gQEAgLTQzMSw3ICs0MzEsMTUg
QEAgc3RhdGljIHZvaWQgeGVuX2VuZF9jb250ZXh0X3N3aXRjaChzdHJ1Y3QgdGFza19zdHJ1
Y3QgKm5leHQpDQo+Pj4gICAgICAgICAgeGVuX21jX2ZsdXNoKCk7DQo+Pj4gICAgICAgIHRo
aXNfY3B1X3dyaXRlKHhlbl9jcHVfbGF6eV9tb2RlLCBmYWxzZSk7DQo+Pj4gLSAgICBfX3Rh
c2tfbGF6eV9tbXVfbW9kZV9yZXN1bWUobmV4dCk7DQo+Pj4gKw0KPj4+ICsgICAgLyoNCj4+
PiArICAgICAqIEEgbmV3bHkgY3JlYXRlZCB0YXNrIGNhbiBiZSBzd2l0Y2hlZCB0byB3aXRo
b3V0IGV2ZXIgaGF2aW5nIGJlZW4NCj4+PiArICAgICAqIHN3aXRjaGVkIGZyb20sIHNvIGl0
IHdpbGwgbm90IGhhdmUgYSBwcmlvciBsYXp5IE1NVSBwYXVzZSB0byB1bmRvDQo+Pj4gKyAg
ICAgKiBmcm9tIHhlbl9zdGFydF9jb250ZXh0X3N3aXRjaCgpLiBIZW5jZSwgcmVzdW1lIGxh
enkgTU1VIG9ubHkgaWYgaXQNCj4+PiArICAgICAqIHdhcyBwYXVzZWQuDQo+Pj4gKyAgICAg
Ki8NCj4+PiArICAgIGlmIChfX3Rhc2tfbGF6eV9tbXVfbW9kZV9wYXVzZWQobmV4dCkpDQo+
Pj4gKyAgICAgICAgX190YXNrX2xhenlfbW11X21vZGVfcmVzdW1lKG5leHQpOw0KPj4+ICAg
IH0NCj4+PiAgICAgIHN0YXRpYyB1bnNpZ25lZCBsb25nIHhlbl9zdG9yZV90cih2b2lkKQ0K
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkLmggYi9pbmNsdWRlL2xpbnV4
L3NjaGVkLmgNCj4+PiBpbmRleCAxYzkzZGE3NTIyNmUuLjNmOTM0MWYxZjgyNyAxMDA2NDQN
Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCj4+PiArKysgYi9pbmNsdWRlL2xp
bnV4L3NjaGVkLmgNCj4+PiBAQCAtMTc5MSw2ICsxNzkxLDI1IEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbCBpc19sYXp5X21tdV9tb2RlX2FjdGl2ZSh2b2lkKQ0KPj4+ICAgICAgICAgIHJldHVy
biBfX3Rhc2tfbGF6eV9tbXVfbW9kZV9hY3RpdmUoY3VycmVudCk7DQo+Pj4gICAgfQ0KPj4+
ICsNCj4+PiArLyoqDQo+Pj4gKyAqIF9fdGFza19sYXp5X21tdV9tb2RlX3BhdXNlZCgpIC0g
UmV0dXJuIGEgdGFzaydzIGxhenkgTU1VIG1vZGUgcGF1c2Ugc3RhdGUNCj4+PiArICogQHRz
azogVGhlIHRhc2sgdG8gY2hlY2suDQo+Pj4gKyAqDQo+Pj4gKyAqIFRlc3Qgd2hldGhlciBA
dHNrIGhhcyBpdHMgbGF6eSBNTVUgbW9kZSBzdGF0ZSBzZXQgdG8gcGF1c2VkDQo+Pj4gKyAq
IChpLmUuLCBwYXVzZV9jb3VudCA+IDApLg0KPj4+ICsgKg0KPj4+ICsgKiBUaGlzIGZ1bmN0
aW9uIGlzIGludGVuZGVkIGZvciBhcmNoaXRlY3R1cmVzIHRoYXQgaW1wbGVtZW50IHRoZSBs
YXp5IE1NVQ0KPj4+ICsgKiBtb2RlOyBpdCBtdXN0IG5vdCBiZSBjYWxsZWQgZnJvbSBnZW5l
cmljIGNvZGUuDQo+Pj4gKyAqDQo+Pj4gKyAqIFJldHVybjogV2hldGhlciB0YXNrIEB0c2sg
aGFzIHBhdXNlZCBsYXp5IE1NVSBtb2RlLg0KPj4+ICsgKi8NCj4+PiArc3RhdGljIGlubGlu
ZSBib29sIF9fdGFza19sYXp5X21tdV9tb2RlX3BhdXNlZChzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRzaykNCj4+PiArew0KPj4+ICsgICAgc3RydWN0IGxhenlfbW11X3N0YXRlICpzdGF0ZSA9
ICZ0c2stPmxhenlfbW11X3N0YXRlOw0KPj4+ICsNCj4+PiArICAgIHJldHVybiBzdGF0ZS0+
cGF1c2VfY291bnQgPiAwOw0KPj4+ICt9DQo+Pj4gICAgI2VuZGlmDQo+Pj4gICAgICBleHRl
cm4gc3RydWN0IHBpZCBfX3JjdSAqY2FkX3BpZDsNCj4+IFRoYW5rcyBmb3IgZmluZGluZyB0
aGlzIGlzc3VlLg0KPiANCj4gVGhhbmtzIGZvciB0YWtpbmcgdGhlIHRpbWUgdG8gcmV2aWV3
IGFuZCBwcm92aWRlIGZlZWRiYWNrIQ0KPiANCj4+IFdoaWxlIHlvdXIgcGF0Y2ggaXMgZml4
aW5nIHRoZSBwcm9ibGVtLCBJJ2QgcHJlZmVyIGZpeGluZyB0aGUgcm9vdCBjYXVzZToNCj4+
IFdoZW4gc2V0dGluZyB1cCBhIG5ldyBzdHJ1Y3QgdGFza19zdHJ1Y3QsIHRoZSBpbml0aWFs
IGxhenlfbW11X3N0YXRlIHN0YXRlDQo+PiBzaG91bGQgYmUgaW5pdGlhbGl6ZWQgYWNjb3Jk
aW5nbHkuIFRoaXMgd291bGQgcmVxdWlyZSBhbm90aGVyIGxhenlfbW11X3N0YXRlDQo+PiBo
b29rIGZvciBpbml0aWFsaXppbmcgaXQsIHByb2JhYmx5IHZpYSBhIHNpbXBsZSBzdGF0aWNf
Y2FsbCgpLiBYZW4gY291bGQgdXNlDQo+PiB0aGF0IGZvciBzZXR0aW5nIHRoZSBwYXVzZSBj
b3VudCB0byAxLg0KPj4NCj4+IEF0IHRoZSBzYW1lIHRpbWUgX190YXNrX2xhenlfbW11X21v
ZGVfcmVzdW1lKCkgc2hvdWxkIHByb2JhYmx5IFdBUk4oKSBpZg0KPj4gdGhlIHBhdXNlIGNv
dW50IGlzIDAgYWxyZWFkeSBhbmQgTk9UIGRlY3JlbWVudCB0aGUgcGF1c2UgY291bnQuDQo+
Pg0KPj4gVGhvdWdodHM/DQo+IA0KPiBJIGFncmVlIHRoYXQgeW91ciBwcm9wb3NlZCBhcHBy
b2FjaCBpcyBpbmRlZWQgbW9yZSBlbGVnYW50Lg0KPiANCj4gVG8gY29uZmlybSBteSB1bmRl
cnN0YW5kaW5nOiBTZXR0aW5nIGV2ZXJ5IG5ldyB0YXNrJ3MgcGF1c2UgY291bnQgdG8gMQ0K
PiB3aWxsIGVuc3VyZSB0aGF0IHRoZSBmaXJzdCBjb250ZXh0IHN3aXRjaCBpbnRvIHRoYXQg
dGFzayB3aWxsIG5vdCB1bmRlcmZsb3cNCj4gdGhlIHBhdXNlIGNvdW50LiBBbHNvLCBtYWtp
bmcgX190YXNrX2xhenlfbW11X21vZGVfcmVzdW1lKCkgcmV0dXJuIGVhcmx5DQo+IHdpdGgg
YSB3YXJuaW5nIGlmIHRoZSBwYXVzZV9jb3VudCBpcyBhbHJlYWR5IHplcm8gd291bGQgZ3Vh
cmQgYWdhaW5zdA0KPiBlbmNvdW50ZXJpbmcgdGhlIHNhbWUgaXNzdWUgYWdhaW4uDQo+IA0K
PiBEbyB5b3UgaW50ZW5kIHRvIHRha2UgdGhpcyBvbiwgb3Igd291bGQgeW91IGxpa2UgbWUg
dG8gdGFrZSBhIHN0YWIgYXQgdGhpcz8NCkknbGwgdGFrZSBpdCwgdGhhbmtzIGZvciB0aGUg
b2ZmZXJpbmcuDQoNCg0KSnVlcmdlbg0K

--------------I6Qouo7kO2ONsbd0kI55lGMT--

--------------EMnSocGpP04TlxlB09ymaZJw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmr0H5gFAwAAAAAACgkQsN6d1ii/Ey+a
Iwf/RF6YnGDPAE6evaEsN26G1EHwFk7MA0YlAhv4OjL8J4+hSJeHwgrysIgebpXPdEvExRASeQ/b
ofF5nhoIs9Zw0xYT8MUUluHXqI7MDXbWt1btOyMhto7GRtpNmenM3Y/79r3nUzqy/VPAQcHNKRQz
XLOntQFTuEId+YRRPYuh5CTjqrHinqLlRGxNnDc07EWUy7Bm5L8anRtaD0mQMI99GHY0My4QxMzJ
3+majMTI21iftMHLpN36+a246VmfJT1xocfoI0E0vZmmHMdfPpNdUGbsdgs5Wm6dq/mWOt6dnsYy
y2SRvRbR8F0bLVTFsWlz0pvxYbTfZhscZxoqUj4W/g==
=5hhi
-----END PGP SIGNATURE-----

--------------EMnSocGpP04TlxlB09ymaZJw--
