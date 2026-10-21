Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792572087;
	b=dRNaQr7r0LKfTu0SAVODnSpgAw9TLfDT04Zw4XhaRvMhVEQUHMDlNiYUBXvsR5p2dJ9S
	 ceaO57js8VdZMHULEpaOMbLe4BtWhtq6UhU5hZoFRe6dIHCaf1Ib8RsHhFvsIwTSP8f0B
	 oDxiGOHJDtgkfEh0IYx8faFyy1CWJaQ+JYaN8sKQiScie4X6d5FspKj/zz/hQIe+BBbiu
	 dfN4bCDaFXrs0JfeFPNEdeZSPE8w7OX1RQBOFmflWjyTPkHkJUD21C3I5OYjcmVtxoNNs
	 BBPwQ3LOCB6IUVnmJmJKn9/ciiGUbAe67Mu7QwlduHIZt54NKncEYrjzUl/h+zJZGDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572087;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:References:Content-Language:To:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=phPl9AWNF5Eclhqxc2VBOo+xMrb46Sq2wbCLpvvlleA=;
	b=MCipuYk22eLGhNDsDV6mortZv36q1bdxf4D4ZYkGD4ImoOtVFYvBPS/eQwHu+eb9BKYB
	 dEjF0Kp9Flkw5xm5fi6n/xt4VWkuDlzV7iLUFoT+YfOAaZeDL5mnAeWHHj0KxDHpVZJUU
	 DkBgYea2sfsGxBlKfNm1HQGhFSIfVGY7M0LwGN0A/su7wK3t2J7bmTK3JggUjYEJfk6kH
	 Wy34K4joDax9tNVZq8Q5HHPI6UlBV45TBuOkDSF3ha1qthYvs+obLZaeHYiH3+TAq+IMY
	 zcjhqbz+sVj+rRNdU/12uRsrMZkpMWEr6TNoPAzOwpG5o6N3fWykBfey4+7XS1nhY0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=faZ0w0Lt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367F606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E367F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=faZ0w0Lt
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0D40D2018D2
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792572084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phPl9AWNF5Eclhqxc2VBOo+xMrb46Sq2wbCLpvvlleA=;
	b=faZ0w0LtJqOY4n7Bn5XDGtBdGW1Pa2CQGNfIhdP4OVUV87icFgyAk8Hg/PIGmpy2IBrtd5
	koviLmgHPHl19C0iyKELJOaGzOeSxq+3B/6r2X6qUbEXWmZxp1lThNYobT9Ns9VW3/a3z/
	Wd2jW6/3xDiBioiWYTIABzpc8YDNpCJue9OUKr85HBWkIC/egRRsQTsSiPjnWbl06hHK5n
	RvyB6JWiHjAnLhRPnHDJ+h50+1u+dvyUQagnbkA13LB5bN66B6WCgDhpmrEUZuz+bB0Xgm
	r3yjTzJzaXwSkQ48fuhVeuAD9MXz194pltpnOfDNQYbPK2EiRruY7w1EUODc1w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792572084; a=rsa-sha256;
	cv=none;
	b=OCttD2m2F9tY+d4DAJG/dOUxkvL4CtWqcdDCBFJU/2or+yoAFgviS++yaImOreoTlWmgYD
	KaukMlp4RbUwJKJu/6Q4SFi+JfU6Ly8THh+sLKSeNYOEhiNiJXO/axJH+iRBKWLfVVrKHF
	tfwN/DQmDc3N9tAikyivwLBbFV4EiD5Ww8YltkXMP7HPJOuit5z58sgq8KD66hPpAHgIvB
	2ZjWmldCUicqVHxaE/lNyQFVtqZ1WJ4xUfRzEJnL4K4DGUJ4l/+z7gOPfXbEd165tYGjr3
	KbakUEeGNdubrTTZSxvlK0dJafYv3B9VU7e2oSf+byXm3iCpodktoq7+vYqvLw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jre@pengutronix.de smtp.mailfrom=jre@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792572084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phPl9AWNF5Eclhqxc2VBOo+xMrb46Sq2wbCLpvvlleA=;
	b=FPdxSyVx4e8A12Rjl+jenbsH0y1Xs24YfZeOQfQMoC/hv/VeHl++OfQai2HCze7wBoC96A
	ini40VsJg55TAUWqeEJL2gDFXixDWbiZBmrrOb9BAbnonkIydHAACOubYUs/7+jcHToeNV
	yZI7K7z/iYDpDXU9gPtjB6OUoxlHpNOsk7upB2jrNS+oQVCfrlhnPVY7O8Un3mCm/CI5na
	l3RArf2RXL743bx9K6iGC2HLstIks5hG25yjzl++KTbel+Eh4HiFlkfxYQFb+MmefX9I/S
	p2Ne4ylxaQrWiOw3OX7iSUE8pOCvhJODk1kf8qr5LeI193TWpo0NhRUiHx+qYA==
Message-ID: <5fd4362d-3635-46d4-b833-363930693fae@pengutronix.de>
Date: Wed, 21 Oct 2026 10:41:23 +0200
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
Subject: Re: [[PATCH stable 6.12]] mm/huge_memory: initialise workingset state
 before folio split
References: <20261020073121.190190-1-jre@pengutronix.de>
Content-Language: en-US
To: stable@vger.kernel.org
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <20261020073121.190190-1-jre@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

On 2026-10-20 09:31, Jonas Rebmann wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> [ Upstream commit aca1f2d5de17e138bc6c4859126b77e516b82541 ]
> 
> 
...

Sorry for the noise, sent by accident.

The patch is being discussed here:
https://lore.kernel.org/all/CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com/

Regards,
Jonas

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
