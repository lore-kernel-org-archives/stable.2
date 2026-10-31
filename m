Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456001;
	b=Hze2o0hv15ffC+D+kZQymdX8MS6zBOv5+t2tLSae+Y9xBGc45xRmeO/q7YXJ9sAExsPG
	 hihaE6/dFnfEyG4/tWIAXXIwXRDPr8RhKdQI8myJR/fgrImyTZoxvqRH9uiNXIL3+uyVn
	 hfwaInv7slF13DTstgafpCHj5tWu/aMzPPmOWIIpJzgNWjsKM3MccoQorXsQVjVsczyxJ
	 fei+1+8qwj725sPjF5eceIgCpJX/VH7uUosEnlDmSATDY0PaxiBnkdZlXLmkcjfLt9vdA
	 rfbg2OgT8+tAc6AzeQ2YhDeZQKFBFXm2KwEtHu39zs7iJWaHreLdRha/pV9N0/+eqfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456001;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+v5pcWkGdMeQYZ8RjouO9xsImQrKL+KqY7Ci660Ye1o=;
	b=qXGgYhllrW13XwQJsqvNuCvK3f3LSKsYRfZzRsrSICMLk5J5cAW6YmA68l/JRM9p0ZVi
	 VpN+M5rMuD2TBnflepP6E+mfgSAMr0t3RT3kpsHQlfe8+1weNwKW+VLS47UCjaLvywjuM
	 +AUvU1xL12Pka30BBSGvpzGN/ktF82E0W0xKJ/lTSM3YWkleZZQ6l6KhHkQjuHUSSh4d8
	 7lPqeY74TtBMLO1gjoTGRhj8FI78LTwaBdvq1Msb8TC39BUphyDHdj2iztu71oPhREwPa
	 qxVDSFQmLq1RIRkeIIJrMwCrZcpOdG68T45sk6zC51cqS4tSuML9LvXysvSiu9RR2oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="OeBeY/PP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6C606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OeBeY/PP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AAA1F000C1;
	Sat, 31 Oct 2026 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793456001;
	bh=+v5pcWkGdMeQYZ8RjouO9xsImQrKL+KqY7Ci660Ye1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OeBeY/PPy+OVgAwXpXwjqny29VgmCAJMpThZ1Gb6m8eTn3t43tmFHC4IIFRayPhgv
	 mShR5BvV4XBFS8nZYr4mSEE0SQ4QKnUERQ8om6QrSpFAUN7X+Uw+LaJjaIotBOH+mX
	 uiWecoGXgz/ZU9fFejgly45NvonwJOp/2An48+h8=
Date: Sat, 31 Oct 2026 15:01:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Marshall <deepspace69@gmail.com>
Cc: stable@vger.kernel.org, "ck.chang" <ck.chang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: Request: c182bfe944eb ("wifi: mt76: mt7925: fix reset panic
 caused by the WM2 rx irq mask") for 7.3.y
Message-ID: <2026103136-creamer-rabid-2d2e@gregkh>
References: <CABxJosiWT3Nrhj9dVShPLGc8dbecjbqwL_pkrZbrT2f8K_OFrQ@mail.gmail.com>
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
In-Reply-To: <CABxJosiWT3Nrhj9dVShPLGc8dbecjbqwL_pkrZbrT2f8K_OFrQ@mail.gmail.com>

On Sat, Oct 31, 2026 at 09:25:42AM -0400, Chris Marshall wrote:
> Please backport c182bfe944eb to 7.3.y. It fixes c4edf9e3e0e5, which is
> in 7.3 and causes an oops in mt7925e_mac_reset() when the wifi
> firmware times out during hibernate thaw, so the hibernation image is
> never written.
> 
> Thanks to ck.chang for the fix and Felix for picking it up.

Now queued up, thanks.

greg k-h
