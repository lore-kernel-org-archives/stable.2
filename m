Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794388546;
	b=Dv2zgs6OnyBTdab0hxTXmkG9s9nWsCLUCZZy/eizhIT3mWB7H1kGqVQj+VV5d/7L5aQB
	 iA6TrR1OUUN1ZH3M6U8jRYX5KT11nLldrAhZyPUeWRmZfPADmYVl6+JanMyKrlzV74xHc
	 bU/ECtKPpoJrWWpNxn4eam31EiGgfcxUZomBuESL/ejSdoEpfNbbOf5VtJqShBnLt7s+p
	 cgo3ryDKTynIeci1yJAS81kIOQzs0o5bOqvOpoXYSNJ8gRenpDcPt6F5qj+xoknflKATh
	 ZxNBxOxbqdIz4R0h6XtmJcjtg+gl0B7SLSckBrA+lC1ssETR/Z3CBdk2qeUNaavZc2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388546;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=vDW8BQ3QK7DFSdWh63AuwvUGvwlRPTs3t87UKhBTiKQ=;
	b=NoQusHCj3gL6PW5vwrKsBNTGMz34xgPapiunL3oF+gmY6TCHTk+u6s5QDHEO0nKMxVsw
	 rHq2qdGa5br+0lrlW7XlkDUMVp1C7XiThobJM63VLrW/6Wyg7JaASDyDX6At4AgqZ4YPI
	 GzjSuyxpj08uoUHJZwWNrv5Dy7xbXoyWfgJ17vnoFZgTkNLwb3zxH77gZ5qA4e4WwdkBN
	 qkFJqX/N3pWrSipAxXiwAOomX0316iKpv92L2bfOaig3ZpdzwvUBC4lsXMk/fOaU0xdd9
	 CrUZbA37HQVi7jYQGoPktBLOoBJSBh4eUeCgWo2nt/EiR36pVdxWBceL0L1eR4nNCRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Qai0FJm0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8F606A31C;
	Wed, 11 Nov 2026 09:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Qai0FJm0
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 88861200668;
	Wed, 11 Nov 2026 10:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794388543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDW8BQ3QK7DFSdWh63AuwvUGvwlRPTs3t87UKhBTiKQ=;
	b=Qai0FJm01qvgzYgCzoKUwfFRkWXXkV89HX8W0AIUeeo3O4D10HCjZm5UDfhSbS5IZJa05H
	OLNwC91drMq/tlWnEk2mvH0dSbS99tbn8nBe5DwomURL4TwEReV4y2mKQDtJP2mCvVyBpE
	r1PblBgZUoIZ0+aAqsKRQQXXXjoBZ+N+bGdnX0GLCvxzOJYxCdEtzgZJqnmIsgaiRzhswL
	x8vFWQN+JtfoE63jqkDPmz9YtwsuAuUsUy0cJ5MpXDpKex9mQ2mXTsC7aW2AnQTig/Y8pV
	+U401Ip4zWrlIQiaSZGoDvoUKwYHK4dDePp5fG8qGIrCmkTr73gxXsWgdbVLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794388543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDW8BQ3QK7DFSdWh63AuwvUGvwlRPTs3t87UKhBTiKQ=;
	b=flt1gfAWqs9ee1FfpsFe0RiSyc8UOlD/mXAjMwv3JJh0nPp9NxsrqQlUNKmSLvlgXs339S
	MPjBobd/kUrbPNisqWdF94gTDH8InCTX2BgLBtOvlJPC8fkmEaNfnCrVNLsJPc7GMM5/BP
	Ydjfxw5jZbOQ1GwtXXGO9EDvUPuQIagv8YKQg2377e+e13WY88QXj96IDHvSYfAtYTCD6A
	VSlFZyMWY6/4h2L1Mwx8m/dQClLhEE6SHj8J829Nda5l9bnPg9zvQijmnV8E1RoN7HmvAr
	9cckseGJgxaDbzTo10ngxQGmmUsxK+tnp4ktVhY3LeMEXFxRkdjZ5lkbOriAcA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794388543; a=rsa-sha256;
	cv=none;
	b=edgHNN1SfJhgR3AMrv6ln6caifgSbcJRITbBxlYwwYO6gDawrVAFioKvxFNli4RPBYIT1d
	qorW9rG3iBlGHABSJiR8thQLZZPC16vpD0QidrL/XYiHjPs8tbNQTAVzhXvdkbsJvpiGyk
	e2q5BvXRvgq3aS6HhUT+gDGa9ph3LthfICG3yCyHxpoQFefoZamRMef2AnZl10u7Ix17rM
	zFAX0Edj03CYU0rMeInQ2/0QpGYceSeWI9BSrVOYwCz9oAfOs88muWNlvfbhsZo0+wpo6q
	JRMG1I6vws5llz0TDgpbPj8EAJEicd/vfEc60athUit7otjdR2k3bf7IV90PTQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <dbc39e63b74e1df9dfb134b6100a8deb0ba6afcd.camel@pengutronix.de>
Subject: Re: [PATCH] phy: hisilicon: fix UTMI reset leaks in INNO USB2 PHY
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Xia Yan <yanxia@cmss.chinamobile.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-phy@lists.infradead.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam
	 <mani@kernel.org>, Pengcheng Li <lpc.li@hisilicon.com>, Jiancheng Xue
	 <xuejiancheng@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>, Shawn Guo
	 <shawnguo@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com
Date: Wed, 11 Nov 2026 10:15:43 +0100
In-Reply-To: <20261111085942.159625-1-yanxia@cmss.chinamobile.com>
References: <20261111085942.159625-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mi, 2026-11-11 at 16:59 +0800, Xia Yan wrote:
> hisi_inno_phy_probe() acquires an exclusive UTMI reset control for each
> child node but never releases it on probe failure or driver detach.
> The leaked controls remain acquired, so a later probe can fail with
> -EBUSY when requesting the same resets.
>=20
> Register a devres action after each successful lookup to release the
> control on probe failure and detach.
>=20
> Found during source review of reset-control lifetimes.
>=20
> Build-tested the driver object on x86_64 with W=3D1 and reset support
> enabled. No hardware testing.
>=20
> Fixes: ba8b0ee81fbb ("phy: add inno-usb2-phy driver for hi3798cv200 SoC")
> Cc: stable@vger.kernel.org # needs of_node_put(child) on <=3D 6.6
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

It looks like an equivalent to devm_get_clk_from_child() for reset
controls could be useful.

regards
Philipp
