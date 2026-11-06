Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979458;
	b=h4ZecVb8CgvdQJZEHWI2YnT/K5SmHNsUpcfvTkyfOXQQCmdT417RUe/r789PgUKqm6mR
	 QPSEkD25GmMEnbg3FnEYC6dBA835wVnIedh/6TRPCjZaNj1ZYytGRIJ92T2NdUSVLeKPu
	 J/dLvnEdcisOzfcxewPfB2+qR+U4XuoRZdGMzMm6HCY/Tbzt7evAGf/eiCijtwVcWZqPb
	 854qMdXoO2tLWfCcNl+y0Aywx+2N2GZoXQUnaAdJ9V8Nm7M4Cn3sG8QP6leKgqqWfqmm9
	 5+nibDi8MGxLClvjw+McUXgCEW10vL2M7Y5b0agFkQjg7JuknkUtZ0V/tzcWPSCKqAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979458;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3I1BCAsuvr/3ldrIukp083xit1CTPI4404rHCJ/nKZ8=;
	b=N3j7qQcuOEY9/o26dUK9vhSHVkG7kJT1AuVJDOjSK/NyW88s0PvqV7CxqBvEL4z7Lv5T
	 G+S9btwIcyeu20i1FcHlUWU7Imfy7A44qQou0x6sdFASBAv1lQ1QMwsty1bm+TqhlEslh
	 axYjb8DcnJRyW3d14dp3Vh5rWQaY2gXcfBxGixQVC/IfAAJxWdiukMTfneQNaICO4HEr4
	 gjYiUqEW2pl7ONThvoW4A03l0H12QaXh1RVu/JU2s+UQqpmZPGWClC+zBMXroHyhh6RnR
	 1rWvDH3mryTQNQKP1sTIkqDplCsw+7rcUX1zSWC0i0er+9NNWTma/gotG/ghCXkNgmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=seanlyon.dev;
	spf=pass smtp.mailfrom=seanlyon.dev;
	dkim=pass header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=rjPCGEZm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k2eD09i9;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59276606A336
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59276606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=rjPCGEZm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k2eD09i9
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E12F1D000A6
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 10:37:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 10:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seanlyon.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793979456; x=1794065856; bh=3I1BCAsuvr
	/3ldrIukp083xit1CTPI4404rHCJ/nKZ8=; b=rjPCGEZmjsYU3jXZ3b2FLiJk9J
	x8AgJnvLHDR7/e/bcV39ljL9RTgMw39Y6K1FpeqW1PXZ2p36FW+D4nRPlhodMdVl
	rEKiT3w5VQy778hXyFSy3y4BGU6uGu1ZwkVBFMIyVW8A05G3blwSPxB2J04idGlP
	WAJHgmCbgR6J25iBpGuktdWYEB0264Rug/YNLY6tlQAmkQIURbrxCYq51zeHV7Cl
	gRZVQf39uct7gtgDKUuUUNSeWzWlzWuElkw5V7SRh3orjuCBp+X+rvye3fgEMxws
	khVLT307oCWqVzeRgflSzaWzY48r9vY+wNwkGUDEwqWeu61H3ZJIlBVvbobQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793979456; x=1794065856; bh=3I1BCAsuvr/3ldrIukp083xit1CTPI4404r
	HCJ/nKZ8=; b=k2eD09i9waK+IsAcfULXGkuyAR1ao8FcpFn44UBKWaQvHYzPpCO
	X2lPufqF/egMDHyXfj4qsggf2UJBaQK8sIvpZZ76J/BuN7VJLOkjOVhxEV+IWzfP
	ulXaw3KDLY/HA69AVN+ucn68vdiOrhxDR9uV2Wk9qp0xObFH+GhhKmw8FWq9HwEa
	ex53HxTy/XXrmUbFQ+sHityWmHIruCkRDIDFIYzpRHt+tQDr0PB2bwqpgjFgbe3N
	bh7h3mW42A35VTomz45aneDwNSwiJVg3iwXt+uoaZa0k+E2oxoERPjA2dukllBaJ
	DsPu1ojrx0t47FrGdcBdhog9ppykgbeXWrw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=seanlyon.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793979456; d=seanlyon.dev;
	mf=PHNlYW5Ac2Vhbmx5b24uZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Rx+fLrHKM/O6EwN94P1GEU/1EFOYdN2Yr6vB+A/tz6Q6uVx
	OA4sIh2UWzkPKBktHXWlTbRpo8BzZE0Fdg2UenikgmCRSzEgoLNpcIxFEFILc81G
	CxZ/q1+oSciKUW1VZssbP/+K6lS7LR3/nbVn5u9wud+8G7JcCqIiCzXXgmm9Y5kD
	6p3ZAk2s3O5JNkRQ/W1CJQg67EhT95/T0Nmede25GxgZxN7sQSj55ZfF6QoG8hF1
	uFwvR6n1zDLLyhHHGH9ke0iF/vlU1/DQrQofxjNtOvkjcXXt2DWu2TelAlGgrkxF
	nsFGNeSvsGVHI50ESLa7L8FzDmtlqoUnfvAOPqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hMWIR663YLcGpmRnr8B7JFwGzsfgwKDvBnpv4IVgMBw=:wzK9TzPZfmrjaEwIl+Vvxyoy1JTMv5wgohAotlyVAiY=;
X-ME-Sender: <xms:P_TtarRD5fcUdnmQQZPdo5r-KpF_Jk7A-TAtpBdvV7v2ZiFS5e9c0w>
    <xme:P_TtaoraZOVyzr2u2ChtojIiJJauRXgtGDL9x28O7THlMfjg5uUDVUw8m3gtcr6xh
    DHZW3uow0HKgpd9pWr9E17-6KOJlGV-N_zfAZ3UOsNqDC52MOVqduuV>
X-ME-Received: <xmr:P_TtasXvlHQ6gNMZJ4uCAwM8uksbt8y7s5_5991-lgeruu9Ze7EGgG7PxcqjBoAMNmg4_S7gFa_fxdG5wI9z_Ro26ts>
X-ME-Proxy-Cause: dmFkZTE85sSYL6ax+V3Zv/R5qKBM/5s/tc8Ryip5ZndsHxL9I5o9azwy7zUowQCaVmya+y
    pHU/TkBlm1ju10kwNaZXHavf7L/0dy3gtL8uWZZFTtK1+hzoay1Lihza/qqNhQ3EzpG9ZQ
    DM3miZu6/rPJ8qbkfrAt1YU9yf05zlbzTi70E+ARo94OjBsFs0/nHVb4f3wGOwsxyZEamn
    2M9L1N9AbiI8AlnVuEhQN5Clct3a+oS9eYzdKl2zbrcxQoV6rrS29gURqWW+LP6DbQftTf
    z2tHZzvKWTOHUMturYQ6rmq+V2hzaR1sRdP0U6tEafCNJYdhDC4Yeby3Ps7cF8mPHdOZon
    0nzio15v6y/iHyeIMtUSt6KeDwNnAv321Tzyk0acBkN5aS5RvRpNCFf4KJ4z89YlLqcwYv
    oUNH+FVa79fXTqB+WreGkc7hbXop2pL5J5Ur5NprsiyKL6BiAG2FTbk/km9UbwjW+3aFdZ
    EKgelrPpa5KrBzjP0DVPgqdHAZ8nDCEYNIbzQ7zPU9ep4i/vjlI8pNVYrjSBvny7YaCkrI
    eeyC6FwHR4n6Aj6+2R7ePvDMoVWnEUFiFIW9cUQJyxHBUqlI21zvWZVYT6OiX3wv2Rmegc
    Jjki6x1rGjcpJKC8qPoodZu3+ZHsoMOwIrtzoUHHChcC32F3N0VvW0h01f9Q
X-ME-Proxy: <xmx:P_Ttau_-46WxxgzHGp3CmIS_pYETHfbEB1JRqIrF-Jq5G2s5VeNEIg>
    <xmx:P_Ttasb-3Tq1qqOdllyWKtP1Hbq4LaNHRwchuozgrUkDa7wCmjc9Fw>
    <xmx:P_Ttauf0TtaumaAc9uOe1xfqAKgQluR5eme9RZoBsj1KBsEevOJDsA>
    <xmx:P_TtaurxY1CHBu2kLTJlEUSc4ILaG_4P8x3Tiw_oTQru53NBQRbCxA>
    <xmx:QPTtamld-LUiOJKB8jTHcti8_ILBPCnxxVJazrf6Th2ovYR_jm8decZf>
Feedback-ID: i07c64b5b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:37:35 -0500 (EST)
Date: Fri, 6 Nov 2026 10:37:34 -0500
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
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
Message-ID: <au30PlcYPAQDilX2@ncase>
References: <20261104211038.406938024@linuxfoundation.org>
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
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>

On Wed, Nov 04, 2026 at 04:03:04PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built, booted, and tested on hardware for x86_64:

- AMD Ryzen 9 5900X, Nvidia RTX 3080 (nouveau)

No regressions found.

Tested-by: Sean Lyon <sean@seanlyon.dev>

Thanks!
Sean
