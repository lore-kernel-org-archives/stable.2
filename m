Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782411;
	b=Vv1n2kyhcHq15ceHqX/0qro2l813hip7Og4OZPyDJFIQuuQxxCDGM5k7Wy8+sy96lLLZ
	 cfeKLKlHG5mcM4X6TsRM+Ve4fJpcG7soKtv0CNLZTiSvx0V4SBIlq+k9YwBzeYnAEddLQ
	 3to73yVavU9LH82EHchzlaBVHVTaC7dcQo8euOOH35AB8+UOFQ98crrPGX0/UOLCulZAz
	 fqyHYGmUV9w6azw9XWVihBaMCbxOhpDYDrHDY3qbyHVCj8B3yk7n6DCRmIa486Fs0GZpt
	 VpGR4VAlP9VXw5OSmQRJMQMXQHUYiYbs8AlDmfDi55W2Bo3MNtjDQFwofk3IHTli1/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782411;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=2NFthcya1a66R8ebfxDjnh0H+W5qbjiXYgOAVLzY/Qw=;
	b=jZ61mcI+rM1qZn/H5RcxMITIT2YVh8ESzyYrfrO0ZkAHS4cU5LOMwi5WKF/ZXfgopcvX
	 FcfBvOgoglcexjVJ68VuroiITsC8DGiQSBXf286vRBaOV9uZrnaPCndYiD/9nbDIO2wbk
	 qB8VO4pQ2Hg8c5vbv3o7//ccyauI4+pH+p8hgsgazOfAlA2Dr7vsFTiNoEkv4+BXv4YCo
	 CqzSqwI9ohh3tdeeuorezl2CPVyO5b0OCfD/AA755JUdW48gw2svYgxch0LZHhb2xw2ij
	 67nwo9ZyjLMxQS/T/bK1ZabT+K/vyQOWGNf6BWZTfsTm2QNYUWW7HzGHLoPBVv2/VDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=T0wAXKGW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LGI2pzuY;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E378606A33A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E378606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=T0wAXKGW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LGI2pzuY
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfout.stl.internal (Postfix) with ESMTP id A81EF1D000DE
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 17:40:09 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Sun, 15 Nov 2026 17:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794782409;
	 x=1794868809; bh=2NFthcya1a66R8ebfxDjnh0H+W5qbjiXYgOAVLzY/Qw=; b=
	T0wAXKGWt5x2sebykbycdYNga26eKKv3oQcMxQs1MERTjcDkO6wPdpmA8acwq61A
	mPEMF5Z0Ax+vI4VHMoMYSCXsx7gm4NUmuhC7zXz4y9gLsHAoSc/YL55Z/Ugbxb0K
	/JbUkQYiilFvxq0N5p77nFQf9NKofwDoWrSB1k3+Bea8G7OZULoqHyqWnzGiRyzr
	+kge1UTr2lg3iDIkCqZuX0dhdxFv9BAZsqrGaVUzNpwpidCgwhwFn0PNryAqLA97
	GL5hV7VpQ3jtRldPnIcC3hwF6HKyIIYqR8rYO9O2AsRQ+ao0BEm5YegCEEs+sBEB
	6NmFKgXtkWADy8bg08pG4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794782409; x=
	1794868809; bh=2NFthcya1a66R8ebfxDjnh0H+W5qbjiXYgOAVLzY/Qw=; b=L
	GI2pzuYVlvSPtXpVpnaSxB4wY/Ph91aLb8vLLbHm+79lFO0jVj404aXtZhNmBevi
	k/mGNJmvJQ4e8CdZYkS9zcvLq49m+/zXqP3YLat3IISZ0XtXHxwahWLV4TMUBvyX
	Nch/zUGbh5Fa7Dg0LZe5om5bJKqW+oGeCbbWeXufxI+qpeJ1dTo6D+l/WilfKjz5
	jYA/qjdYH3eT6WF7BlZd9p7hO4p2OfTGmY8L1KRuzUXxl7qsX9NXLerBVY9AzZzs
	kah9IX5cGbm69rnpEOaS6T06F5fFdFAZHGoGCRBtEIvbbcywvtdOaCsBheMKDQgW
	c7veHRLCxwrTv+YKW1BpA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794782409; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lNLEJQyuz4XHHnuAx/pxDIzhnsgN1rlYKeFWACX/DHea3HV
	u4D16n41a/f7jhspKpqbSDFl/FLmEOJ37fjT+BgkI7LF1IdbrWyG6u1vM4dfgA7/
	EMzWO2W8yHeCMPLpt0kNojMxE6rGHZKN7p26BPa79wu/YQg36RodICM8yXkHznNa
	qcJYuLQ0Fd0NCcA37NTqOu7H2hHzyNvz23V0WjoHB6VTVYVHMqcFkanCiUPsJf16
	RM9cKa7ehDvPmME82HZ+PUefdsip6QIw+4ug0AsexIohZnGMCkgkDPIf0s9gPGoT
	vrACveif6voYUnDdYIUxC//igzsOmDVDm4khnJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:inem2IeyncJLIfsz0LnE4wBE4J61G137aPTQ8OiX6x0=:/zk5tCjydG7YuTD0dmXiFowmvfjG1P7JtO8599w1W30=;
X-ME-Sender: <xms:yTT6aqeKk9vjXfg3Zmz7o58VqWs48m9yqCXRN_Z0csOKzIDzPzyaXA>
    <xme:yTT6avDm5ov8p8wRHvw7zRlYSdlFL95tbk4YfpNkCr_DY95lxSRf37UjeMpC2PEEy
    i66h3Vlam_yDIziRPRzhwqB5WLw3sivTZGwxrrUDpLQcjh68SuQEVao>
X-ME-Proxy-Cause: dmFkZTGyEn2hwp2H41gw2dmlbCKOthRCfkpaB/Tx62XyEiWowdHujXesiUBjAyMacUc6yP
    W9oW2S+/SUhw8f1QrHwav0BpJR9P0Dqmc43NZE95k6KtDYEf5ndPqac/OUUBa5QhY2sfjO
    LSgFvdotvUccS1orVGJIdEQDa3yY9CzwxBEqseDQP4dDULVWgP84gml7NOERuckjJUkpJE
    4bhHPfzIvD28rGEVCOOhydSUAb+btwgh4nKZEGFK+wTX4JA1/d/09J1K7gobcaTzug6DNd
    YAkAmgZwCwhllvqjqj9M7KFSaKd9szaO+opOO92Lx/HjwwUdX7YjEkY8DHS8Yi7wOsa+Zy
    PbdPo3M3V63CeJi1eKRV46kCRFBnfh26RHyXEgLJdMOIkw1xUbQ5hYcxbO9zlikW22TFG/
    lTal6q5d5NlxQ9tsthldR9hGCETu+Zg+8gdOpxEv7+ck5/Iit0hehnsQU5EiBT/LvZaOx5
    tGNU+IxAQNLsy5iRlJw2+TGxzKuph3/02K2K7bkz3+Tz+royyaaKqHSB3pI1Sxsnx+wzax
    pQESrBU8iZM+yWPiGmjvvtk33vqH/KzIn2WWN7mKPAXLuimdanYG9bd0qCWoD6hO08+L9C
    sEisOIzeuewpoaHeU9xOh2RkyfHkEL6KsLeajRoUiTidUtVSNUDHC7Mvghyw
X-ME-Proxy: <xmx:yTT6agB205kAH3jGCfnWOlDMtBZZXlSpm1cJy36V_biuvF0ntSE54g>
    <xmx:yTT6akF7u3WLvdc95PNvurgNS7vSeZijZZGf2XbsGIaXf_EPF1cclg>
    <xmx:yTT6ai13BtZ8ZCxp8IolUj1ElRFZkQ_QOm8A2Uzs1nMMwsnVYqroEA>
    <xmx:yTT6atP9Tf4cocwvTUgsLiYBgqEKFF9qDuazFod2fr0EFAzUjakdAQ>
    <xmx:yTT6ahgyiy2GKB_rhqM90N5Ux7_76jmdIS4uSYvMsvp9BWnWpJvWyrBN>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 5167C2C00085; Sun, 15 Nov 2026 17:40:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AFJahWOVFX37
Date: Sun, 15 Nov 2026 17:38:35 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Rong Zhang" <i@rong.moe>, "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Gergo Koteles" <soyer@irl.hu>, "Ike Panhc" <ikepanhc@gmail.com>,
 "Andrew Kallmeyer" <kallmeyeras@gmail.com>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Mahir Faisal" <mahirfaisalantiq33@gmail.com>,
 stable@vger.kernel.org
Message-Id: <859daa2c-e891-410c-a528-58fc49a2ccea@app.fastmail.com>
In-Reply-To: <20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe>
References: <20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe>
Subject: Re: [PATCH 0/7] platform/x86: ideapad-laptop: Trigger the EC on YMC events
 following Windows behavior
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Nov 15, 2026, at 2:27 PM, Rong Zhang wrote:
> Currently, the ideapad-laptop driver triggers the EC with YMC command
> 0x01, which seems to be randomly chosen with trail-and-error and turns

typo: trial-and-error (this is in patch 6 too)

> out to be not a command for YMC events. While the devices in the DMI
> quirk table recognize it, some other devices do not, making the
> trigger_ec functionality a no-op.
>
> Lenovo's YMC driver for Windows (YMC.exe) emits YMC command 0x08/0x09 on
> fold/unfold YMC events, in which "unfold" means laptop mode and "fold"
> means other modes.
>
> Adopt the said sequence to make it work on all relevant devices. For the
> sake of caution, only emit YMC command 0x08 only for the known fold
> postures. For all other postures (including unknown ones), emit 0x09 to
> make sure the touchpad and keyboard are still functional.
>
> Beforehand, also fix pre-existing issues, modernize relevant WMI
> drivers, and add a resume callback refreshing the posture and poke
> ideapad-laptop to trigger the EC. See each patch for details.
>
> With these changes, add a DMI quirk table entry the Lenovo Yoga 7
> 14IRL8 as its EC must be triggered by software on YMC events properly
> (i.e., with command 0x08/0x09), or else the enable state of touchpad,
> keyboard, and keyboard backlight become out of sync.
>
> Reported-by: Mahir Faisal <mahirfaisalantiq33@gmail.com>
> Closes: 
> https://msgid.link/CAGAHqH6o0TUa1HXMrNV6e+HNYwU3xxHkOM665756n8Cp3AzhVQ@mail.gmail.com
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Rong Zhang (7):
>       platform/x86: lenovo-ymc: Use enumeration to represent device 
> posture
>       platform/x86: lenovo-ymc: Serialize WMI event handling
>       platform/x86: lenovo-wmi-events: Modernize WMI event handling
>       platform/x86: lenovo-ymc: Modernize WMI driver and factor out 
> events
>       platform/x86: lenovo-ymc: Refresh posture on resume
>       platform/x86: ideapad-laptop: Trigger the EC on YMC events 
> following Windows behavior
>       platform/x86: ideapad-laptop: Enable ymc_ec_trigger for Lenovo 
> Yoga 7 14IRL8
>
>  drivers/platform/x86/lenovo/Kconfig          |   2 +
>  drivers/platform/x86/lenovo/ideapad-laptop.c |  42 +++++++++-
>  drivers/platform/x86/lenovo/ideapad-laptop.h |   9 ++
>  drivers/platform/x86/lenovo/wmi-events.c     |  38 +++++----
>  drivers/platform/x86/lenovo/wmi-events.h     |   1 +
>  drivers/platform/x86/lenovo/ymc.c            | 118 +++++++++++++++++----------
>  6 files changed, 147 insertions(+), 63 deletions(-)
> ---
> base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
> change-id: 46a18a06-ymc-82yl-d59b4f8f891e
>
> Thanks,
> Rong

I feel like I should be able to find some more formal documentation on this, but as these platforms aren't in the Linux program not sure what I'll get (or how long it will take) and the series looks good to me. I'll see what I can find so hopefully we can avoid a long list of quirks (as needed in patch 7).

One open question on patch 4 - but patches 1 to 3 and 5 to 7 look good to me. For those:
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
