Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794705217;
	b=C2b0G3kZ48WImDdA518w+ai1qwvm6W88ZQMGbD5O+EDjEmdRTtCSm2Nb2G3JDrn8JDLj
	 E61gFRIpE935KHYyMeOCoXUX0eB8HTj+/A3Uq1NbvcIQ7+fN4qfJN8OcKuV2QULeA+p7s
	 mTU3R5VtONoFFJHbST8uSPMmHeI9d4WSDcDYN0dNO4/JVoB0NUmXILUK8JNDFnophc8+U
	 7qPniN3OyB7+gtLFPDY0+Mds5iSSdxvu/QpxZGkbv116I/cbvzIF4oCOGgSNn4vw3w4Iu
	 x2MaktrP8xYO2azTm0PrUMCtKI8u+L7gEjIG70vmqElL2LQtPRH1ZNrwztp4g6B6v/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705217;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ENNKEBiaOoEoJajLPGgvZOD0gIX1qPKSnvnELSKFfB8=;
	b=KUwiAkdSKL7Z2NnbsQkaZWSF6qXDKpaNQOS0hNhSm7fpzDUbKBy/A//cm+jCCQABlEBo
	 yOEgPhGuX4FOwSdEcZDEKxtsLU20tlXIMDZrRdialgYi1ciBCSsldflHyraytcadqvgSN
	 chMRxJDs1tL2427YUOUSGrgpcNNs/mmynmhuXBK55nAC0ZGNY7BcDt+84JTMk2wjnE4e0
	 Mvx0zopmapHz2ke50ADYv6n54rutxATCO5lGxuV7WctW5ZGSIRs5pkEL+lQ1TZhbZb5cf
	 oUio2sqAsTVhrON8eJX0Kn7ul7tomKPpO4sCKGd7fBLZ5MdK+gbqJgEOPgiPUhDN8dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rebasedinc.com;
	spf=pass smtp.mailfrom=rebasedinc.com;
	dkim=pass header.d=rebasedinc.com header.i=@rebasedinc.com header.a=rsa-sha256 header.s=protonmail header.b=OJB2MaaX;
	arc=none smtp.remote-ip=79.135.106.25
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52C606A323;
	Sun, 15 Nov 2026 01:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B52C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rebasedinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rebasedinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rebasedinc.com header.i=@rebasedinc.com header.a=rsa-sha256 header.s=protonmail header.b=OJB2MaaX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rebasedinc.com;
	s=protonmail; t=1794705213; x=1794964413;
	bh=ENNKEBiaOoEoJajLPGgvZOD0gIX1qPKSnvnELSKFfB8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OJB2MaaXxQmXKvFgdwjUAo5NRuVgF/81ZJtxG+Dda5uCiHl2QGdbJAwiWEbK+F6/A
	 lPzJbgXsi7ckjLcSIbpAborzsXZ8e+rBnarbusedxs4d7SF/fD3fe0qTECLDRY3i2g
	 h6Z8a8/aBJ521f8Qdgvm3sAk/AprmKaxQN1bwPrIHvGjhLFqb+HvlVOiLLxfoa05KK
	 yfisnAhK2ADU2OU7ooBYzHjUoakwKO4TZ5h0p9/mJZOziWrxQtZ9rD/XEzKLchqyiv
	 tGM6jsVZKfzyPIPdi1aagPWcJ1PT5oPoEm/4inYtKpo+RZ2Fls/tvjvtxiMu1CK4SE
	 IlPsFfTxeEkwQ==
Date: Sun, 15 Nov 2026 01:13:27 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: dev@rebasedinc.com
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Yufan Chen <yufan.chen@linux.dev>
Subject: Re: Subject: io_uring/eventfd: registered eventfd signals only once after the cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Message-ID: <l6MRoKoZ-Ws6W9hLDlkTSwXBGm5Ozdgg2PU_u8lEBUv7ckH24ibRpB8FMBDpgxBvzA7EDuwuEV5-wVj8tBV-DPZwAvOtzGTCbfAuDJFgUC0=@rebasedinc.com>
In-Reply-To: <2026111310-pointer-citric-2f11@gregkh>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com> <2026111310-pointer-citric-2f11@gregkh>
Feedback-ID: 231970246:user:proton
X-Pm-Message-ID: 20cced1913b2880bf7bbb39f27ad0ff8430c2d10
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey, Greg.=20

I've tested the current releases, 6.18.63 & 6.12.117. Both still have the p=
roblem: the registered eventfd signals only the first deferred task work of=
 a registration.

I noticed that Sasha already queued the backport (thank you, Sasha) of 04fe=
9aeb4f3c for 6.18 and 6.12. With the patch applied, both releases signal ea=
ch deferred task work.

The test makes two deferred signals on one eventfd registration. Each signa=
l comes from a poll of a pipe that a write wakes. A second test waits only =
on the eventfd for two TCP receives that first get -EAGAIN.
 =20
Both tests pass on the patched kernels. These were x86_64 builds under QEMU=
.

Thanks,=20
Nathan



On Friday, November 13th, 2026 at 9:00 PM, Greg KH <gregkh@linuxfoundation.=
org> wrote:

> On Fri, Nov 13, 2026 at 11:22:38PM +0000, dev@rebasedinc.com wrote:
> > While working on my own async runtime on io_uring, I found what looks l=
ike a defect in the stable backports. I first saw it on Ubuntu 26.04's kern=
el, and I can't find any existing report of it.
> >
> > A registered io_uring eventfd stops signaling after its first deferred =
signal on kernels that carry the backport of cd305ee3633a ("io_uring: defer=
 eventfd signaling when queued from a wakeup handler") but not 04fe9aeb4f3c=
 ("io_uring/eventfd: reset deferred signal state").
> >
> > What I see, on Ubuntu 26.04 7.0.0-1016-aws, x86_64 and arm64. Ubuntu's =
7.0 kernel took the cd305ee3633a backport through the 6.18.49 stable update=
:
>=20
> Please test the real kernel.org 6.18.y release.  6.18.49 is very old.
>=20
> If that still has a problem, please let us know and ideally send us a
> backported patch.
>=20
> thanks,
>=20
> greg k-h
> 
