Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289451;
	b=GkULACbZ8h8gbR2n0yWj6Scs8zeiSTN+KgiEK9DsG2L3zSXqb05xGBpotGi3XmLd1GkV
	 cTsblF2yLDDK9+ffyKvf6e2PTk1qwKJM/OJcILrAXReR6oCBWg+wsx7P6ugk0L+/57L0p
	 wIBq/3VdrhO4O1SBJZC86iZ0ahODYREucfSM+iUkPD/iKfI+XiOoaOCooa5b7PBUER/W2
	 H3b45w2LzdVE39g2yWZXLCRWROBhu0WP1z904IrEw+KaV9mVn7AdiLLRZu8EMRrz53oYj
	 AFzOZbnjOedjEvazSWtcKwTf3GDAT511uzTa13qa1cNvYcfC8GwWnbkrSaRaMJAGMXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289451;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Tr83yHUfWmbpaDbNaIgNsrKv+GzdebCxhsuHkRBV/4M=;
	b=pPS3Rz59bm317vJ21T8WpVPxHTS1sL2lh0BTKvzz1WhpuapFfNFuxLTi4TFk2ZvuOuHA
	 8nnjFCq9sJJjViMNg0MGYGvklyU6GoPOH26ShRawP8+FAUWcgRO51sQ4dioHgb/4v7ZmS
	 7pv/gDaZ4mdU7PBMkCaubByc/zDjqR5dT/0+ZBOuxDC73ZPrPiPdkHfX6IMW/IJIf9bhw
	 VHcvHgAFSRy1RXq/GWxH84QTOIt/tyaA1PfO7om7EC8k6aC/YBGqA9ZT1Yj9vPZtonhrr
	 FF0m8I/exVOqn+982ce0HGtcW+DqxCIz5GFU7odL/x0Hh9WD0+24ZxH5mmbhcIXbxbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dU8OModw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b0qTM9We;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CC606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B4CC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dU8OModw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b0qTM9We
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 763011D000B3
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:57:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793289450;
	 x=1793375850; bh=Tr83yHUfWmbpaDbNaIgNsrKv+GzdebCxhsuHkRBV/4M=; b=
	dU8OModw4YLinvyCjQLfMbWJqvky+DOyKTGqibF8MUT1Xlgj4mjQV9ArcV5tb9EG
	XeOl9dfcWm2rfHcDwy+XFIfpRI0J7ayBDpG/YdpjpdNLnGZoz2N74M5ROR0axP7o
	gAdEaC6yA5A/icJBTerdpa6qahyF6h+ri078/OY50djsw/Sr+PEsj0nIDgwUlThF
	GWe00FsIRZ/oZY6sfZUFJu5c0pmReSZefBx8oJNXI1beADzI0CvwegBGm4EufyZ+
	bQmLA44s384i/6UNyOjVsYSg0LzHBhmcFjmZs0LYDx8oa/ohONEmtSJpdK5uvnMB
	hvgpwpNNcyvXUNNqrdoT8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793289450; x=
	1793375850; bh=Tr83yHUfWmbpaDbNaIgNsrKv+GzdebCxhsuHkRBV/4M=; b=b
	0qTM9WeiMq4uyEuebcevP9SUvIFHLoX9cBOPB+rS0Gb0n+COjsXw4zER2I8mQ3Y8
	vMkb9WQt50IkgUNWjo8aPQXQKXNgq57IeaZ8YDZk9Ao6Bot6iq5N5KXkEOMvX5Gw
	LoBU4ZM6x2xc7kB5FDT2jzZYVBd74EmZKuXZSz0m2o1YksTSdz/pNKEe30QTbGEL
	f+isSB2T4GD08INamB0bjgCZvUjmNeV8fLyiZiPTaeSIHjQhyJe2bwuZVQVn5zra
	a/CXmc7fgspyrzMUkT0kaZwX8gId5rF2PzIwTXQnCPiImIJzn8CSJMyeNK9E77jl
	SR5Qb/NNqtO7lg83Or85Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793289450; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Fp319XR9VOAjVuiXPsKN9bclbMWmdcm5jPjUO2angoKayMw
	jcUvRdK6anlVbQCMJTy/+BLPHgxj7fLf0LxKqiQoZgWJSAvKnuCyoooKiDJ5k9kW
	YWwVVc2+CYXRq7zLt6j7jaZTBVKCHCsKHr7fh8laXMa9c/yRL9tkf6aI1olPwxJu
	uOOquJ8Qu4+dawtScClHt9q4yu115Nor3SLqWpxA9XGa7mZRhA06V15uHw2uUHp1
	hcwzALbHjk3k4/zyimtwc/M2Tw5wCoPVTs5hGxkA0Ex7jonJJdJZ4XGqKPk3VPim
	Wha/8s3bf/r5/8ZhZCENmyBQ6N4ZvP5HfU3nU+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hecsQBECakpCXpRprVUuzwjxk8xpMtkmFXMfQRfKLKU=:Uvb0jAgA6zzT764z8xA9jUk7EB9vjtbfSjqSMtrFU2Y=;
X-ME-Sender: <xms:6WzjatjLCmk0hHAGBk6KUwz90l7Uph_OKpc1NuAlpksePtm_AU2_nA>
    <xme:6Wzjat4p4INXBLJBFQ_UQSl5G5L78jh5_S1xa0Sp7KA2KC5UVFjzmghGGHfLeoHb5
    s28L9s1dAt59iF2RzmN0MWhBjho1mOQ9fxpaE1gGUgHU0e4sMcJMZw>
X-ME-Received: <xmr:6Wzjaokuy7Fs3aaZAhERcMoAuM3JIRqnb859J2Wdwal63SmBVEYhIwUrTS3kzRa9Pr8PeZH3a2kkOGZpzJvFOlLDR-CxgQiu>
X-ME-Proxy-Cause: dmFkZTFyi+2BXmgCre10T8IqYNpRmOPTBMZFggV21Mp8I45O0utNIcqj4G8U0QngIABQA1
    06QKSvlDo1XIu7S3avbFB8+h7iId8MOWhyEpY5yfUHRWS7wUy8RbvEtCJuUsewMcrqT0Vd
    +Y14UbKzLYao27r3p0ci58AJGqujG1ecv5G+5f0gpCiGw7wJ9G3+osXWrN+xzetOtslkGH
    HqJNK6abeaCylYjvS51S4mrugEZR4wvR8o+hlmNQ21zam8BKulMMPj3mWI8gHFWfvCOt0g
    zO7ZYbOJk1p9sOuICobrOVanGykmbpoMmkrIBNupvCyzKxVWcutcw25LQvvRFvFzvN+/to
    y0+lQD9lSrals6hj+Jf5+CMRScECPS1Pg2usfj07ENzboCwv7a0jxpgIn+OvEE9Njo1Dys
    4glJS3ee+wxYetLu4gy/l870qmhROYYnbm2mqofkn+bWPkJWHZA/LyxoN6kZh1E0c+SzlZ
    EyB+DY27BkEZEbPybzq5Gs4bHqiXFJ2Ui2Egw4cAsAUhebgoeetEDz/jrPTpgcDA4mvK+5
    1UUwy/4xCnH8DIdZS5TdCDedtAuELAIeSArDI4k8Cmct1qV+iIJRgscMmIb4++y29j8NmP
    NL7ekJ9SoV6un5WgLidSOS6CIXpz9yZA2N1Na7iI5MpuURHHxyNtUIlwyFnA
X-ME-Proxy: <xmx:6WzjamPQEEeLS0xDaZeKusRojgjevAf7IO51pkcpijlMpautSCg6GA>
    <xmx:6WzjaiplEc6Yeg_fgw0SlnM_JZVxcNyrtfcz-xWZ0xuC-CtIBJFrCQ>
    <xmx:6WzjantlX83W8n8F-sxPxoyMvQ2R-ptBJPvQlQjAcvCPzFvff_R1uA>
    <xmx:6Wzjau7Y-GeJLWYBhVtiY2IP7PyzPUo57ZzwRq7l9oSerAB70YTRSg>
    <xmx:6mzjas3Rea8Omepb9mTNTNlmwVnpmyycnZcP3VxPlpiBQJwQJF2L0GZd>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 11:57:27 -0400 (EDT)
Message-ID: <63c56460-9b17-415d-b27a-2df7a0308472@pobox.com>
Date: Thu, 29 Oct 2026 08:57:26 -0700
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
Subject: Re: [PATCH 7.2 00/88] 7.2.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028165942.107695352@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261028165942.107695352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 9:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.14 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on 2 amd64 systems and an arm64 virtual machine. Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
