Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951398;
	b=fUlaMm31qjUOZ+y4gPP4hiulXidA70DTK11ukMj406EBk32kqiZHt+4MGdmWrsiEirpi
	 TacdFclI4fyZNi9aYIN61bvX9eC4VBvgnnCsn3hRD6Q2luvQYac5XXbHcnoyJsLSZO/Fn
	 +4pVWbl3euAGaZjhZJAK3ubLUfTs3JehtX+HR03IFMCBHD0KFw+qChCYMoWYd3D/5lhDO
	 Gpei5D2U/nuLaPanR/5I3GdxUKBduQ5SAZAgvD49VNIQZXKsygCXn817G6AIE2ZBN/+BK
	 JEN6+oG9NO3xKBtMtUEr4ZSMHvA9l5YEeQwGYic5QPepYdm0B5I4B/5r7uqSa0YY8eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951398;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1AHI0cHVScIUZqupXxfL2S2LYfFvIDAWL/E9K98CHlg=;
	b=Lkp3yY5ahBTYTnwG7MIn+dyX4e1uhUoG3M3HtavL0yKOsE7R5OGWHWyBybS8ptEQhrkx
	 jLHjynVqH7u9T7fsLVx1aektGpJfV/JEd6EdLZh9QyzxGV2j8556honXFKb7QPd7HQHlj
	 i0ZC0KrPrFb5nYQk6tXt/VAeLssjv+BWY7BSD1ogluYHYriEvmsaY3bhbtxsYBiU/WDRi
	 qWjCiAIC6YIaM7uuw2GRe3wwgrWQKNAS1fwlvgthOB9LToWbzEAwrkQJxB0+pCEGqa70e
	 4rTvPaXa2qE+q0UtKYgKnfjvBgObcBtO1a9U3F9gFeECCKSpKPT//RBy4XcHb8Dp1qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AhYgfsmG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="GMU+T/4y";
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C20606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 07:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C20606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AhYgfsmG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GMU+T/4y
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EB217EC023B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:49:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 06 Nov 2026 02:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793951396;
	 x=1794037796; bh=1AHI0cHVScIUZqupXxfL2S2LYfFvIDAWL/E9K98CHlg=; b=
	AhYgfsmGeDZa4/y4l3w/90waPCwb35P8koRZwK1P67HFJrdLKmLlKD9Yr+jNClix
	thttOryLmGVvG93sREOKNtvjn4jrn9RdBeBEgGq3Yvijd99tGCFt2K4y4BVWnJRV
	OTn/NoiVdlBFJfWJDUjqleDVezpnzAsdPMfjcaq16atGeEeQfefUQUFJCeWV8Ogr
	2focazJ7DGMuDwSeu9UL3QMV11Y0Q/OstcA+90emcsjenb+RgfqzKi8drvS/u0PI
	XJ5nEvxadFT9iVcxQCeaF/L3d/609R4o3CrtpPK1mTvVcSqPtSncB/dAPLtFs050
	WCyO4b8EBqSYm/MoztQBPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793951396; x=
	1794037796; bh=1AHI0cHVScIUZqupXxfL2S2LYfFvIDAWL/E9K98CHlg=; b=G
	MU+T/4yC3xU7sJY4lwPdj3Jd+cy9+eLdZPQJA9OXCyaL+jGsPkpnzLnAoYPl50d5
	iicgCraTfSdKoluVdA5NIkyD9y5msb/kcl9WZ059rMglzbspFaJhKy39L39mKIBY
	ZXd6lRAqRKxEzB8nm3vgWmwbqRQKUKSi7x+uyQMXLtFyCA5yW+lHPtmQWCDy37BD
	0GocPCMLOFustRNxJ+Ei6xAaExiooHHlzkb3NMeiprGbGdR4cFc2OHA7BL8pS6s6
	MWsJfRENJbfa+crYg2SBTkxsygoFu+4FY+j86oMH+9ZbxMEipS74CRMNfepsHctI
	iuMSWIPJORf6oS07usewQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793951396; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iqYt9IRas1ZHKh3lJCrWBRyXymod23TS5VKP637+MWm7Ppe
	smOA9u4R5h70z0MypgPijzecME5VBHFe5m2Rp9abkWKZtk1tJXxpBWOTCng9fV26
	LTY9P2583bzDEH5ou/niKCRRvIT3WPEjd2FpmVcMnnUr+be68dJ0+3OfGzvFhAFd
	qppuuS5UJVhMA5TPNpROAjuFlB28qoFlYEmPNe/fpAnTUyBFBc34kqxeRIauw3uN
	AFNdVqvVK1kTKbMexhVYmCXhBxi5ZPQ7w6QadvRXQJSFlVA1tcSxQz+BEin93V4I
	pfqdptkVn//Toqjc9oJQ4cxQ/l4fQ7cOOuTuNKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KIHw2e3xfPS+YXrajfvk65Yocyqa030eA4wRjeVGb4w=:ZvUPCHxS3O6LS4EixgV6YSZVVcpJv+np6nRlhY7v1+4=;
X-ME-Sender: <xms:pIbtakR_amYMBEUB6E-QWeefd2HVmu59l1dtAYPNgFs8oAmWihxKnQ>
    <xme:pIbtatqWYnCwAHmfcHQBLikYyEAJkJq-9iAEX31vyzkAJAfZ7vDV_PHQDdP04dIkO
    1TQ2Cq8sJDPOA1b4dTKxf9-rv-uEIjlQroMecnntAz3IFxt0rNUgF8>
X-ME-Received: <xmr:pIbtatX9jZNMWsaLnEmAuD4i-1UMXNGwA_i3ry8118mqmjk7F5G0Fr4oOs4whZnNzB2R4L3kIQ3uWvQlgOSRSWS3Ptn7of4Y>
X-ME-Proxy-Cause: dmFkZTEUI4H6PQciHH1C0CTjTEnjL/+AMWtSU2echlVeolgKazYD6YGf/jp1/AUiVQw0Vc
    b22NY8UD7W0YPFI0J2KMmNRLoechu8v/kX7oOmBz84ncHJvjlSUovwz4qgMh1SKRVBe8Z/
    5ZjCeXkmh3z8IuoYffyLxHtkGDLObwXWUm091vKQ3RUMT6pRfAog4p7mSkKalMV7vdAhuT
    uUnBL7oi36i7Zah1e4k9lvlFnJTDxj60I6igSytI/qIkf672YZkuIUbB7Zc6Isas9YspU+
    0mNlCtDXC1t6hCmqwQ5C/d85MR78RM/1srLqU5nc8fMEAsP8Iu+lM0E9MqRNR+Dz4XgSFy
    0YNg6jYE/w0MrFPCfZA2FrqN7hrziXa9c59+Woa7xZyvN+MYSAztTxA7gXfYcNz8qXUUpE
    tJQ946pwRgsNDOpNVBuT6dYeKWlT0Li1lbIDl/UrFvaEfZTUUDCVtIkde/+vZfYYvkxrIv
    +2XYWrZT3FgyIS1Y6zuArYz1IgVgPm4ompaRP99c2ILbnh0ldSFmhTgnSCOWfyZ0QwLTmr
    HuIV2udmQuoaGaQyzRUNY/39Pre8AFsNld87DnbcQC8S57tn9Cbu82Ir4OVNFUmAY8Bc4H
    OAsgSMINGnSjxGogNtoHGqz3YbCvhp/Wgo5LfctWDnMnemHPIONhloZLZ62g
X-ME-Proxy: <xmx:pIbtar9bUW_MOSTIJnBBYi7LyE7IbFRgPhPVkneRHn11isJhF-_Spg>
    <xmx:pIbtalZjkS-co1ma0Jj1-GcIMF1nvPbd2ui2hV1iWK9vSA4xCsavfQ>
    <xmx:pIbtajcmyse4no46AtwihIz3DohQdLOb7FNAHsDh6-ZSIuXb9_Quag>
    <xmx:pIbtavrQ5aXKANpBHROOLlv9A9MkapwBVvLVBYxS0ozFKbb80QFnWw>
    <xmx:pIbtavl57qGsT3499otKlSu6KzlMMghN7ADE7VbLpcCzQgXUTiVKlQpA>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 02:49:54 -0500 (EST)
Message-ID: <49bb4977-b5f5-450e-b3ba-9d494fd5a7ad@pobox.com>
Date: Thu, 5 Nov 2026 23:49:53 -0800
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
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261104211038.406938024@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 1:03 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I tested 7.3.1 + stable-queue as of commit
aa65920a134b0366b65f438be80335f2060ed664 ("fuzz cleanup"). This is
after the broken xfs patch was reverted, but before the tun patch
was added to the queue.

Tested on 3 amd64 systems and an arm64 virtual machine. Working
well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
