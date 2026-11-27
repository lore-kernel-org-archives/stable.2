Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768684;
	b=qt0CUja7KJ6ejYBDGbxSDvTq1mzv2mM2iJihqnWTmEvV9whRJG0y0CX7WETMly8Kkp5t
	 lGk/PmKjDuyeI7+Qd0Q1OknOwLGxrKX1JKd6Cya12dox9NgfMaY8Cc0Gndjmi2790/N7h
	 FToZcP1Fd6iIjHGkXi+a+fEu1OmD5gj9LJHucgGrggSnsQ1pWutv1CrUKo5DiT12u+e/P
	 qt5MmSYpuiGoJ9TVAP3cHpcvxUdEMKW06tNwtokhv/P9XWrOF5EIK6QhlNxpD7tuhNKOB
	 HF8ewrRpSq+PC3GBniWgV6tL6orN0IBM3LX7GwIDb/yf39o6xVxq6R4qQE13IRKJLuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768684;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OEbCNCHuO5Ct2OVHqEG/x84K48uQHkNFsc6ZNf2VV9U=;
	b=yc8YzT2ou+WMQERiCkg245NtPnl2BLiwndBxuAAdM6DcqCBZVWCzJKhCgHLPdGyapke8
	 Q6udo0B0jHWdCrVkXbSxk70pgeIkx1NL9CxJUSUcoXpI2wY6pG55XcYp5CWPWktaMQAYd
	 Fpj7d03wyiVZwyOGFcLSht2TGT9af2uyQlJVEWvYRwmqa8/GXG09BMcNfOO2thS6LB8pC
	 rY9sF1X69zg0Njyusb/d5nd5H2qH6grGQDNdswZ5laBlI9nHv6ZK/FeioF1Y0zWb2NA4b
	 I7oET/SkLzx2z8umUV9IpiRw8LZaPR/zM+ypE8U0kE75qjbsKkPE57RgN7cThmVBTcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=seanlyon.dev;
	spf=pass smtp.mailfrom=seanlyon.dev;
	dkim=pass header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm2 header.b=eGYWIO86;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=L7AQzsnc;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375A606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9375A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm2 header.b=eGYWIO86;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=L7AQzsnc
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B23F6140031C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:38:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 27 Nov 2026 03:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seanlyon.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795768682; x=1795855082; bh=OEbCNCHuO5
	Ct2OVHqEG/x84K48uQHkNFsc6ZNf2VV9U=; b=eGYWIO86Cgsxa0lwHcsNeD1HEJ
	0F+Z0pJanBVRslJvBJ0MdRvLKszK3xYGBSc9sHSRqbtffkvvlbenXkTZgtE7ZU63
	S0wSuzpRDVqQG2ePPXuMB5qs3YnZeSC0MUk/unphXxprlITbAJtUx8IOWGZrm+Vp
	lBSKifj9FfKBxQE+9/nI+tjVh73jEgwtQ/gzqT5iuXo9kaLYixf0RbxVabXrGZ+7
	8Eak7gtGj9Ry8GnczOJSk5ahQPUPwMUjAl05uTuUN+CwWKKVOlXBGHwYN8a2ziDU
	jfL4m3SG/RLYaLyubhKgCx+YAm2KbkB3B+XrdIskNIobDYrFdTanSZqBtXwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795768682; x=1795855082; bh=OEbCNCHuO5Ct2OVHqEG/x84K48uQHkNFsc6
	ZNf2VV9U=; b=L7AQzsncl71UpNtzNsFRGtc5FGEyFJdxwE6UgJ/f5gwmAicGTYZ
	VCnNUp5mO8mumdYiWVZf0O4xQcRs62eV1vzlWGpqjVnkTOfhoCTZn6i+QLy3rJSX
	/3/u+iOQGW34yBMHQKfHOqljD7xgCfLy7CzZQeyqCePRqSHI3NFHKCcNYKC2qVzi
	YBudu9fbDv8qCApkt+32kxOtqMEmYzse3CoS6nYSwmsfIAWZVziKw/t2HbnYVoZu
	SeptMW05wK+E76K0YzXYPhyAFsiQfE5xkRuP7cr+cR40L1Jh81mXhElkqgArNCdP
	8jhSYCXLJDsI4RyHkf46mrI0tHGrEFhA99A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=seanlyon.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795768682; d=seanlyon.dev;
	mf=PHNlYW5Ac2Vhbmx5b24uZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eoydkaidDmZaKAefpZI3UjPuz3PoWyZb3sLK3+MksW2yTkI
	yJ5wkewN7gdzSUSFUblFVgPOsT0+kyldDNqFGjH32ssF/xxEXi8Pk9nkggoPuQs8
	eDpugDJ/cb2YUwUpqj0GcxUDAMZ80q0Ez/8CWlKeMIavzOKjfPoyzI0Pa+s7HRCM
	tBiPXCoAnT3kPKeA71Y1i//TxsF53UI/EydiKHSMyCgATaTdeoYuTa++TOiijMGY
	S4R/JghAocierKnSl15manIKuiANrhgPAzAXrrvha07ONZ3dCI0HYphno/9oPKhh
	LludYjeoHrPYUrpGC4dwrnPmwOCUd9zpIN/CwNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YKPeEjzKDNKbZ01fKxoI04QOmdpHAlN/9nQYxrpglrQ=:x2/jcskNKqWHVyhk+WfezuGU2dUC1JouRP6vjRWrAZc=;
X-ME-Sender: <xms:akEJa47zbHXRLHuiQDfLs0etLSzR65Hxd_--oYjn0RK5cu0jKIDHTg>
    <xme:akEJa1yWIGmGgIl_CRkIjgyLFYRIlQdE-Pt8vkRQE57bVylc8Vw0o7ISJYvS-2qnr
    kYyPlsKvCXJfLuBkDtCP5Gb9Lp-X-2GaNrr73KfxcB4iuzToysBDAuJ>
X-ME-Received: <xmr:akEJay-U2nfaLtlxut-L8izy2Cs3m_muct7v3Lvy4WANOsNK3Kg1R-VnzbuDTTe7reCAWS6Wn212Zse6VurSTrO3WlA>
X-ME-Proxy-Cause: dmFkZTGfexL/VtPPolm/0MkCDjKSC5/J1UWTbCO6bKzEbPcr8aNMA1LsNERwk7sQinoSBF
    l9ruz4h/vYJC6xV+EOGHkCZ1ZYlblfSgdmi3XBuy5yt9577LvdVdqnX9WieaegrYZbSidB
    +8AZlWKuPyUqmZJlYlg/3DIbFM6+HUoTPdz+zkJh33fd3VdBu+dPw9fMJLykD9N0hbBweL
    vlvuu8lxK1TDly9d0YQdtANrGLcA8LEajJDp7rqAgwvy+KLfHbTZ/GL6StnuB/bKU3GHc/
    +aw2Xw3uVOtrzjCrCDaz67cPl8QYuROx4R0nBJ6Kx/T5aSeO0MWXU4pPD+4NPfeXXpgPVq
    2F7N4coDu1h2jdjSdqPFe1UTJ4nUP/PD7S4jands+lTgkLkkj/0x45C90gR5I7wgOcunLN
    a8ijKa5UYos2I7WyjDekanE3xV9Tm2fk7dS9nuTc9V4Wo+BycZ/UY1Y4JlVoWP52EARPrH
    HljRex8qyGF8FtvpvW77UcUb9Z5ABCffRpT0wPYZGuO2drQflhPq1vsVoyN6MocPFkrax0
    pvk1hye9OK9sbW9YXQJQHXmwzFkOH3rYI+AYNP1MbAf8VwQ1E4MO5b09BXgrdL8EsVY2PJ
    zRFELvbf3hDX2dB1RrsibzVf3Np91HtyJKtLdGtGL3YP9ofaEnPa5LOj1w9Q
X-ME-Proxy: <xmx:akEJaxE8-hk2vfaZTTJOuPRX_K16OVuLrk8cYrHpxTZbhy5jcdOqAg>
    <xmx:akEJa0CSmno0otng5EYx_QUjYR-tVj4mQ4kvcLZgDk9sLVS-t5IUtQ>
    <xmx:akEJa9lbkSZS4Sxkl9tCi6OZXuLBYDMyvLET0cXfoMaGc56nd3ggKA>
    <xmx:akEJa_QyP-jCA9HRjeuIttC_xu9mXE4RBdeatNTaYdJKu5Ypnkpqzw>
    <xmx:akEJa-NTRs2raWPvhn1JIBfinCa5S6n-QJLWnGsXSz5wfnY8LFLDtNaM>
Feedback-ID: i07c64b5b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 03:38:01 -0500 (EST)
Date: Fri, 27 Nov 2026 03:38:00 -0500
From: Sean Lyon <sean@seanlyon.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/815] 6.12.120-rc2 review
Message-ID: <awlBaMPsy_FvXrcs@ncase>
References: <20261126105709.009001842@linuxfoundation.org>
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
In-Reply-To: <20261126105709.009001842@linuxfoundation.org>

On Thu, Nov 26, 2026 at 11:58:31AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.120 release.
> There are 815 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built, booted, and tested on hardware for x86_64:

- Intel N100

No regressions found.

Tested-by: Sean Lyon <sean@seanlyon.dev>

Thanks!
Sean
