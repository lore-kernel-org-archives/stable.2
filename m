Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768814;
	b=LaqKZwVDrUG+taJf9HTuu1VRjKdxYrZVRYh/4ZMUf1GR7ibz0SxZJ8KdSWdkT8tWUA9q
	 91lhs9sUAqEDgIp1Iv2i+kouF8lhqmD0HAr5aeGUb2JSLB89kkAgaUSNUVdTZfFXxaS/6
	 na/cyavQ7LUVqfKpdd1frbhqVhNaDFVPiZyI8YzueFopPeScRDsQbRV9w2lkFBv4mgwsc
	 +EYggaDSvRJw9OUy53ONbh6/VtfBmQEoc0F4U/2gysKgp91O47Yo1qieKp8XhPY9tHubp
	 S3Zi1CsfjQk8BTirV/bAPKGOVoYZHisbMTPeeQ+AsWU5IUSVC2OotO9FXWQcvBv+DqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768814;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=yaJz6FgV4+RxM7rCm8e/oS0ygwQ36wh1oGLON6H5U6k=;
	b=kpyFvIRU9anBW1ye2PK2gdc8+nhP4/XmOrNiP2Eei3FIi9E/jREnR9EoS/Ivz52a53l4
	 8E1ArZb2elT7+9liLs5T4NQEv9hNnLGfrIySVgkyjdfkWdfh6lsWiR8jWxsJqJg3jXzv8
	 KKec7FY8CoGGZvYkqCeNypHujNWLjS7dCrvIohN4UN5VE4d1d2M73jqnYhvL3nEy0k/EK
	 NF7JWjP5m76ky+Zhb0QxxXJe11Iy4yqg0LVjfqZtJzj6nABgfWoVgn0iuiJNBonPARyTA
	 QC3NARL2+Nux5Js64FhKeC3mgP1PpzHu+1ai41LsVyw5gb9cnJqQb6FlGl3Puq2Ez2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=seanlyon.dev;
	spf=pass smtp.mailfrom=seanlyon.dev;
	dkim=pass header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm2 header.b=qa8DBmLB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Fdgv5lYP;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E0606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B87E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm2 header.b=qa8DBmLB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Fdgv5lYP
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E2B83EC0B79
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:40:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 27 Nov 2026 03:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seanlyon.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795768812; x=1795855212; bh=yaJz6FgV4+
	RxM7rCm8e/oS0ygwQ36wh1oGLON6H5U6k=; b=qa8DBmLB3CeuWfvCBvVdv3ONBK
	4ydoYYMK4rCVrOTl8ZZzwdP/lOQukgggfXFyDlyqXivJ52oHHhkiS+48+OH1RmNS
	oMT2IqLTcPPgiPwlIynMEyB/ECtRuhuakwQy4Qbmhy1v3E/imtQdB/9vabI2LLA0
	b306EIL1u2G+69s56FUkOQwBEOWiaxxy3fqZqrpO5oqmDNxtTVAQodKX1nwJ0hzi
	znCb1kXDZWQJYL6kr2siS1GvZxmdLmzHa6KN15sV/YbgWGle2OL9MYOFUyk9eMvy
	9SCe/Mp0dDK1Rqu/stD4BZvwQuhdODER1Yp15IF3linkucqSYeshJit/rm4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795768812; x=1795855212; bh=yaJz6FgV4+RxM7rCm8e/oS0ygwQ36wh1oGL
	ON6H5U6k=; b=Fdgv5lYPSIx1OFelTCtHshZpYGuiFJoyY3FppCb+j96Za8DEgaa
	MlD3K60+DsR0yJGXjEMhpNxQ9vw6ZgJleMXONzZ9Dpagh/26uOPpvhFdlNkGHRrm
	c2hUqmLQMU5WK1PCRGs2Uew2xWvuDnVceJyUiXQKv6xcSq9A4ycIjOmeMJBAczfB
	wEwQU6tTsaSWutq7a8XvQqp32/CLU5JjfY2ikVqLmsvlyGlZi+KBxiDNK9MvobUM
	1vTVI1kSWw+YPTre2mAOjbkdntiJh6Jl9XjhusM6de+sfQiFQqS7UjqoLcNSkIE0
	nRcRxCVFGtgd/wqcGfQvcBMTkbbFZvuTOSg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=seanlyon.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795768812; d=seanlyon.dev;
	mf=PHNlYW5Ac2Vhbmx5b24uZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Bq1zS+ZMfybQdQjHFSwD8ViKBDfo67CzQB9dXSZvYTcnkRZ
	qHqhKmrdr1NtHbhZjh+fag8n/0zXr7TtjaKf2HOBQHczD3gzQMr4lxQWlCYS6kef
	fhtOO/NzIt7+Fun5ZdbxDgxqV5fveRhejX3UWmeT/xAexFMioAybx/04xmyGy8dJ
	JX5nMpXBqjEuDfUfgRyeDcfjs9ewN5YBEP9+hgp0zvt7v2hwUYse2sF2DzYkSMFt
	KJr+SF/zStJGBp7fJiQKU6Ag9jPwHzFl49CYTUXQZlZYp1uY3DA6qIHGkArBB0kx
	s6fSy7QhB2VgUb8DsBGra2E92wWn20Q71yekj5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:V/E7wY1yhKBpNHmMKFyvR7GGIJC1MEvzdkYpHA99B1M=:hD3q/YTHLezd+UKPMVESboYVR1eMspmooxvS/oeak5w=;
X-ME-Sender: <xms:7EEJa9ziOIXc7lIYs-Ald4gg_WMVL5_11zkgj_WHMbNcp5Z_ZfycAw>
    <xme:7EEJa5KO3ZvVlR32YCCiMZH9Zc1Jo0z35ObsLcSpvPikrUCJVCd-s-363dm0VYriW
    JEDm_PrfDMo1VAxE9BH76lImTc9b3goztvpwIl1ePWges9p2gZVMX2Q>
X-ME-Received: <xmr:7EEJay3HGH8eGGYKQFl00KSMcZMgBpMDBHxOJcEo1LOIrgGkLfqbsac12RsyTY6P_QNOJKIRuQVsMz94GhyKcOdhXA4>
X-ME-Proxy-Cause: dmFkZTFUAqjxBOVIr+bv8avIB7td/xHveOqH4ySc9wDqn4hdvIcKD/FcOb8O9dRNkFeBpQ
    QDWBA/1x7NjOg7hFwg34KOkgNj9c84lCaKsuWGsS97km8YYX0FOmUQ29iUsW04xBYpnaU7
    9KbcKwF9h14JrRDuNMPEVz8jPKhCQou0c47i9ZTzFjGBat267NtK4rxVQfA9AHPhcPpKKZ
    txOxTiAhoJpbIb28jsadgqq8Pn1UeIxI0BEuIgodl0b/i1f6636L2d8YaL84gspECfoWGc
    VwwAV2sxj712/PQjkvmyZyiiXtDMja8ehL2SZB5ZbfwrBYR1jM9ZT1nKzT9rQd4geelspU
    7N784+Wp2GzOW5s4vb1RBLYd+ROyrHZ15cErGTxkdl6nG0rnUpKMbSxTJ1FcBNm5xLkOvm
    NfW9lRH9eVLi6pak52jgQuaKz1n7woPNaz1YcgBbD+6IfU4mngP2QbxV7JyTCjkny3VhSJ
    VbzwCgv29xyiESsfAU9aTGE9mB22NDpaekmWvn8JXJ9Yvich3j/ECkhOwPeQ37NItMI+pA
    eCjMp++Z38mEKeGNrwO/EC+MkdEDpbthj2D7Wz+dx7LyqQqEwJGy82AOwfwQ8YtDTkcywW
    oEtHHtdHofLKIwewitRNcedFkHx+ybEnju80+X9tqaoBx/fyaXqi5xJodI3Q
X-ME-Proxy: <xmx:7EEJazcmblfBCvZgNlFaL6gezCwNT-1BIKBCSZqgOet6ugIznmIuQg>
    <xmx:7EEJa25oW5gB2kl3RoG2SauX2oDBBchZWgPBB6oJMTrzGBupcHBe5w>
    <xmx:7EEJa2_hgWi7Zti-Mxn7lgdgNzJmt_tg21xBrsTK_j_5ewcPvn_beQ>
    <xmx:7EEJa9LX9E1XW20c6X4KF9zpiFx0G2KS9N0ncMTo-M9DqO2yn86GoQ>
    <xmx:7EEJaylFTrZHRCtQoME1HH_3T1drJwuJPuLCpuzuGxBGUOwW2oq1PHW8>
Feedback-ID: i07c64b5b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 03:40:12 -0500 (EST)
Date: Fri, 27 Nov 2026 03:40:11 -0500
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
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc2 review
Message-ID: <awlB6zSZqHpYCF8P@ncase>
References: <20261126105725.767748294@linuxfoundation.org>
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
In-Reply-To: <20261126105725.767748294@linuxfoundation.org>

On Thu, Nov 26, 2026 at 11:58:43AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.66 release.
> There are 990 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built, booted, and tested on hardware for x86_64:

- Intel N100

No regressions found.

Tested-by: Sean Lyon <sean@seanlyon.dev>

Thanks!
Sean
