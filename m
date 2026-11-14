Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621621;
	b=lWugCvlgjNFs3jCm2rUeTLRHr51X9A+rmK8whyxKXW3RvdVQW+95a+Gm7G9uP3Og8AD1
	 I+dkrCVz/WlOHWeywNaPgmD3nFhI8vW540NqGgyoM0UlPcz+/PVAsoblswVeAvzqtGP2S
	 ZT2yA4Sd2DEn/RDpMKLb9MvkBKfsgcklYYuDOTOolAjSWeBMq2lE1nlredHxE66Kp+7ti
	 dHkPiiXm8lDWj/m/K3UpqK6OxWMdFUpRevn3DZGUUUuTsFeSmGpS0Nxz2nZBFF/7Z3VB1
	 x9793YxKNWHo88T+edC+Sntlf82Wva7QsiouBAdrhNlpiYxCz7Tx6R+A3/ySXveQShA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621621;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xoFXsjXLKjXD/H4olKCJ+X+jvlc5wR5AHwlRcd4Ub+0=;
	b=PaoPOVo6polPYF/Fmz3PMMvuAQGzCoUGduE06hOZjYFUjNruWVXyCkz9kKaZ37QYzjnG
	 a9D0Vd1Zh+lSdz6aNi2Z8fbSSG4jLnCCx4m5xzeACQlvDbrXTR98foUk3QVpGQg9WchtS
	 LmYAWv/QdEW6X0keVv2pEn6Xk6t42a9y2RysZbnLnboSGclQX73iwBbe/tl5NMLQlVaa0
	 dJADlP3nPZcmf4imhv5eNIVZjKPU7nIWAwzikEMx5Es12AteHcwg4S0FjTXJPdTdmibMT
	 z8oF5ybjqDPe5N8JoNu07RUkysr9a2sWclNJXYzUXnnrDhHeIbxNRmLGzZd6/Z85hSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ifh8gdb+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDF606A338;
	Sat, 14 Nov 2026 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ifh8gdb+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160661F000C4;
	Sat, 14 Nov 2026 02:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794621621;
	bh=xoFXsjXLKjXD/H4olKCJ+X+jvlc5wR5AHwlRcd4Ub+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ifh8gdb+dPcTYXRBX0r4StppInPy9SLHfiCuCVthVRM6UGThIex/T6apM7OyMVP7n
	 PsHBA3I1ENMUt//7BZDNSnCAS2qAjfNg0LSgBvcW2InK6bpF9lLO8bWmApiBK68FGS
	 AiAYFPmH6iy/k6Mz1S3uRwswx0RnrMo3SiMXE6nk=
Date: Fri, 13 Nov 2026 21:00:19 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: dev@rebasedinc.com
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Yufan Chen <yufan.chen@linux.dev>
Subject: Re: Subject: io_uring/eventfd: registered eventfd signals only once
 after the cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Message-ID: <2026111310-pointer-citric-2f11@gregkh>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>

On Fri, Nov 13, 2026 at 11:22:38PM +0000, dev@rebasedinc.com wrote:
> While working on my own async runtime on io_uring, I found what looks like a defect in the stable backports. I first saw it on Ubuntu 26.04's kernel, and I can't find any existing report of it.
> 
> A registered io_uring eventfd stops signaling after its first deferred signal on kernels that carry the backport of cd305ee3633a ("io_uring: defer eventfd signaling when queued from a wakeup handler") but not 04fe9aeb4f3c ("io_uring/eventfd: reset deferred signal state").
> 
> What I see, on Ubuntu 26.04 7.0.0-1016-aws, x86_64 and arm64. Ubuntu's 7.0 kernel took the cd305ee3633a backport through the 6.18.49 stable update:

Please test the real kernel.org 6.18.y release.  6.18.49 is very old.

If that still has a problem, please let us know and ideally send us a
backported patch.

thanks,

greg k-h
