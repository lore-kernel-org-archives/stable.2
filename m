Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89410518147;
	Tue, 13 Oct 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902486; cv=pass; b=C5F7nh9T4yJxMT2Y3rT5moe23SNoN3VXBzho68Wa3/SskdecLi+AmPFdm3yCkoJ4aQmY75KG7JT0JJL2kv0Sv7PD1pvL6lqldAkFC1n6Fm1R9qEZ8jwEOnO70f7ykOHqdu1XGDP/f40x8B3Cx31VHNURjMWc6exTiHtdaWz2K0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902486; c=relaxed/simple;
	bh=5xm7MxNqLSBWs6+7PgSbz1FrCnamTTGUOV/+h6ssAn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNe7qqVLTyouXO8Guag94vBc/2nlKEDr8VEcPhYqVPj7t/ciWeHb1Sfy2mrymzaLuEtd+q8gyuolfDT8vCtRu6G43L7ATSfVKO8JQ3qboF/CdLkOQWuQEXHLkq4djCbe6siWAh3F/jD4EBzuWXlpv8br6HAF+zNzd30lblYSi60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=KIrlBa2U; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="KIrlBa2U"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3DF31200467;
	Tue, 13 Oct 2026 16:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791902481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXCKXtUeTwD/OXxcWsx0jhFweCsNl4NPwKugfx/rprs=;
	b=KIrlBa2URZfmD/FmqJe1GWgkO+I6mlqaHLch1gzsY/k44XUy2cfZGo9vqcPbA1b9V/36Yd
	r6QMM7IDROOYNXe1XPb6FaSqE7tCbb9wYdikvo4UzheZa8Z3jdFcPgSIpiQ6FgyprSyJHW
	aWiVnazkzlI0aBCiwGI5AcaNjU0W8GV1ZOFkDXrbLJDjO/VPKC9uXiPadh5b+nAGQCxuOr
	fSLhLNclXGPy9ugee+c/RxCaM418A9lbnAoZES2m2YkB5TLm5JBax9WTu0P6Yfel5oLyV6
	GWLKdGAxn3nYWu2G3XeEk3ltcuolefG9SIBq764AZhXrlIOMy5HbjVPDKR3ysQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791902481; a=rsa-sha256;
	cv=none;
	b=JN6F6TbuYqKLjPPF80taIetatqg+2z/bfxZEpFcT9idjHVAQxSgPhtmPvZhdNlHzQlOqMd
	0dbjmCqNT3NZ7cMoSe0d4cLthZsJfKAIQskjj7YoOGp+V6CyXVWflgdQBRc+Gu8pEGICUt
	mYgOfhu14y+skHgGoWuzJiqFahTBvkMuk966JrXJvHsRg3lmZ8+ZhVuVTkf/4qKBCc2kkI
	NnexPpgj2qCy+H2NhQWOlthSehPwCwDlQuY956kOo5Nar3Re68Tn7Tf7jN+Y9mKxLn7HDo
	m6mQEw2N+ytOfvl37z57loRZQMFZHrn7s1ykw7AT/uprWHBX4C+7D+4V39ucBQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791902481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXCKXtUeTwD/OXxcWsx0jhFweCsNl4NPwKugfx/rprs=;
	b=YsqVrj+W6O1la8psQxwk7jDSFTYI2jODhzGigggnXZlA0ncOEj4tvLlTHANrXADawLaFpD
	WVA1o+wEK9nzQhi572OXZZXDRvPob9xW+s14kRRNVvOSBFQtxKVNomaa0tIsQ4MWUO4kdl
	M1fjaG50kAdN3p9WBicPx8m5T/nzRbsdR/m1FBgwqPFK2mCZwfyUoxM1kOqXJ1yuOCzRKe
	gwrjrJ46ISnd66g+cg7FOqNFPgx7sA/68xwC4CA0W31aslmg5eGg090pbhWlMvGDhysg4i
	UrxqPmewEY0n2O1uvaYdEYrPRJaqyyLkWy9pgFiXAY1BK0QJgmacX6R1mhDSkQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xGdgv-005hwf-0O;
	Tue, 13 Oct 2026 16:41:21 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BD0BB5C322D;
	Tue, 13 Oct 2026 14:41:20 +0000 (UTC)
Date: Tue, 13 Oct 2026 16:41:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	kernel@pengutronix.de, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before
 closing the device
Message-ID: <20261013-mysterious-enchanted-manatee-2e75af-mkl@pengutronix.de>
References: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>

On 13.10.2026 11:22:37, Cunhao Lu wrote:
> The close path cancels restart_work after freeing the IRQ and stopping
> hardware. A queued bus-off restart can therefore enable the controller
> and interrupts after teardown. It can also restart timestamp work before
> runtime suspend.
>
> Serialize restart with the close transition using a mutex. Mark the
> device closing and mask its interrupts before synchronizing the IRQ.
> Release the mutex before cancelling restart_work, so a queued restart
> can observe the closing state without deadlocking.
>
> Exclude the IRQ handler while reinitializing the hardware on restart.
> Do not disable the shared IRQ line while waiting for work to finish.
>
> Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

pr-bot: cr

-- 
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
