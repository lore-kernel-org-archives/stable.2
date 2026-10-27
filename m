Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=96.67.55.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118372;
	b=uyjXJpziRvGr1lSAQX/40wL51aDdar8jTZ31qXCnE9O4Ro2k8qUeNJ00LnRzdaaXytZC
	 iKEYoQi3Ju2llsyL2Cgob6FfDtkppnivUE+Shw+rtE+9pbLpMdUgICCfXpuR5cPBe1uJP
	 yGdPvavppE5j0lItxYVMlyMwISkKsiXWs3hdADvJVMKnyFD3e7EEjUMmrcE3cCRNGiVo2
	 6mNmitKPIZ5qO65vse7ShztKQe/Oz0j5haK1W5Khlb43cIcF+bGtBeOe3xGVtiIRZUhbG
	 1zbiiJaKcSIDuUeEi7aoFXPDLq/QNp9hDaxd3nmhl0LnZzqsoDiPh6i/BlzyOBsNHZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118372;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ILUBuVJH4L/oZLvDgH4oxNh8y8fuYLx5r3XHzPh+Rww=;
	b=kqwGWzMJ5wySr4E00kRmipyF1ZyepSl7OQ85MuwTIri0If/XtuPhTgJtxkHZ7Gteh4PF
	 xIyxEG0L1NeqRIs3m/dP6h34pKrJbccrUwoTkghrn/jR9nDwfpD7uQBRt7LSjwwPHfqcx
	 LglpIWUnwBkSX1PHGvrNNs1ihyH9XDPOx90OthVNE3Oar91CBWI7ukEpRS3eWlZ25bVLV
	 WIEpyHj4P9U3oOfSFq7D1GSJ8Tw6C+sbTnkhgE1c6k6xZ0PKEn3D9V06hp1oma7beT5EF
	 835+8dSCr89KzHrZI5c0yn/gj+q6ZhEhJBW2H+uetTO2udMfanBKh8t/MggOrMiQkSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=surriel.com;
	spf=pass smtp.mailfrom=surriel.com;
	dkim=pass header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=Hpb0YMf+;
	arc=none smtp.remote-ip=96.67.55.147
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F2606A321;
	Tue, 27 Oct 2026 16:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10F2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=surriel.com header.i=@surriel.com header.a=rsa-sha256 header.s=mail header.b=Hpb0YMf+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=ILUBuVJH4L/oZLvDgH4oxNh8y8fuYLx5r3XHzPh+Rww=; b=Hpb0YM
	f+ogu0R2Z+92vhr54itldzLNbHirDqW5EN+w1/iW08lhRJyppurid9XifdmtQzY8vX+Nk8MKD+INW
	KJpblL3RRnjUsOtlk2IzFa6EVrdMcPYEnimnjflot3+EB1ol8Yk/ZJHNSuRLHeLd++odfqjAo6iOL
	+VS7msGp1Yh3nrCDHc9Lqp7uUv1n5et79VMnIPhqCCeOnd1KXJzl9iyNDXX6fige1vEgmFj1yr5fS
	Fx39rrmWvfh6mP+jLE9m2EEuNRBZsGBpGHo+/hORdeN+FubjmZIflWX5AapVKsW+67JJJmNXyx1Re
	5vBfSsAmaloaekNlooJUZw16CfLg==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xLjzE-0000000Bhxu-3hc6;
	Tue, 27 Oct 2026 16:25:20 +0000
Message-ID: <6455a4e9218729d68f73006ef532e6fccc0135cf.camel@surriel.com>
Subject: Re: [PATCH] x86/nmi: Ignore negative NMI handler durations
From: Rik van Riel <riel@surriel.com>
To: Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, 	x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Nathan Chancellor	 <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling	 <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Peter Zijlstra	 <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, kernel-team@meta.com, stable@vger.kernel.org, "Paul
 E. McKenney" <paulmck@kernel.org>
Date: Tue, 27 Oct 2026 12:25:20 -0400
In-Reply-To: <20261027-nmi_negative-v1-1-b436a005eb8a@debian.org>
References: <20261027-nmi_negative-v1-1-b436a005eb8a@debian.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-27 at 03:43 -0700, Breno Leitao wrote:
> I am seeing NMI handlers in the Meta fleet reported as running for
> about 584 years. Over 30 days, 11 AMD and Intel machines logged 637
> such lines, for example:
>=20
> =C2=A0 AMD EPYC 9D25 (family 0x1a, model 0x11, stepping 0x0):
> =C2=A0 [ 1650.616627] INFO: NMI handler
> (nmi_cpu_backtrace_handler.llvm.9643156322683129580) took too long to
> run: 18446744073709.551 msecs
>=20
> =C2=A0 Intel Xeon Platinum 8321HC (family 0x6, model 0x55, stepping 0xb):
> =C2=A0 [360448.230129] INFO: NMI handler (perf_event_nmi_handler) took to=
o
> long to run: 18446744071018.936 msecs
>=20
> =C2=A0 Intel Xeon D-2191A (family 0x6, model 0x55, stepping 0x4):
> =C2=A0 [81787.188959] INFO: NMI handler (ghes_notify_nmi) took too long t=
o
> run: 18446744073709.545 msecs
>=20
> nmi_handle() times each handler with two sched_clock() reads. When
> the
> second read is lower than the first, the u64 subtraction wraps, and
> nmi_check_duration() treats the result as a duration. In the three
> examples, the clock went back by less than 1 us, by 2.7 s and by
> about
> 6 us.
>=20
The comment above ktime_get_mono_fast_ns() makes
me wonder whether for time deltas we should read
raw TSC values, and calculate the time delta between
them afterward.

The reason is that another CPU might adjust the time
slope between the first and second timestamp read.
I pasted the comment below.

Of course, that still leaves the actual misbehaving
CPUs. A two second time difference is not explained
by a clock conversion adjustment, so I suspect we=C2=A0
will need this patch either way...

/**
 * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
 *
 * This timestamp is not guaranteed to be monotonic across an update.
 * The timestamp is calculated by:
 *
 *      now =3D base_mono + clock_delta * slope
 *
 * So if the update lowers the slope, readers who are forced to the
 * not yet updated second array are still using the old steeper slope.
 *
 * tmono
 * ^
 * |    o  n
 * |   o n
 * |  u
 * | o
 * |o
 * |12345678---> reader order
 *
 * o =3D old slope
 * u =3D update
 * n =3D new slope
 *
 * So reader 6 will observe time going backwards versus reader 5.
 *
 * While other CPUs are likely to be able to observe that, the only way
 * for a CPU local observation is when an NMI hits in the middle of
 * the update. Timestamps taken from that NMI context might be ahead
 * of the following timestamps. Callers need to be aware of that and
 * deal with it.
 */




--=20
All Rights Reversed.
