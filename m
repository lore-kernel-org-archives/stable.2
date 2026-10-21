Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792602427;
	b=ylaX427aIkZNLjE9Dq8JINykM6loBAg9k7MAm+HccmMVj8jx4uPdJ0GEUyM6U7jm4+rv
	 a1CjLogzJzlsnHpQAqdLfzUFx7VIrOMLysJJVo/7eRf5NgIPK4DVZlITTrIBU5cz7JF/i
	 yDPsbradsQN3y29emvhVG2Oen5T3wkpilR4TfyF2SyvvK4O9BerlSl3Q1caZA3AmSifTu
	 MT0YOB6NoYhR5uN7hs9z8cN8Ju3+RUwVt6Kf0KOgTL5hsnwEZvCTgdOz20kgtwkDhi8I0
	 e/GxucH4D7f1cptf1X8pNLK9R8Rt/ErcpmX7bRTIhrBMLFfmBdxRlQbT0ZyWsOe++WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602427;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=O2e5QeVvQJVei6FmOAgnoWQkcImWa3J3udnQRClGO98=;
	b=PJyTqAdwNladw1D/6XrrBegzvAHGgYd1teFEe9cphzjNGecE1lAxVONzq1hKtb9YRAJ1
	 4L2EwNqpnptUB22x/hQ8NpAwhzEGa8WQtcImKAN9Hz7rXSGmq/nrBjFXMJAXBZK9s7bSd
	 3rb8smy1C39d4xk6P+uGGa5lDWn8gsfwmNL3Sy0rYl9PeHMbdY+6uLq2qeUj05KV70uDE
	 l8RWZ0ZKqh6mNXsuo2G9QIr1vDQoZRAa+TCbUm7xEmxoCONIANrQqvGW5QVj9umDRpyWB
	 8Tpg3j6wmzbYRmYdoWihHaToElnapJEYsVciT6qIJI1hHAnQKQAmOnjUt0GkFjtR5zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="JC/ZCuR9";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EF606A31D;
	Wed, 21 Oct 2026 17:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 328EF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JC/ZCuR9
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 31FE2201E7D;
	Wed, 21 Oct 2026 19:07:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792602420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2e5QeVvQJVei6FmOAgnoWQkcImWa3J3udnQRClGO98=;
	b=JC/ZCuR9lzusyYkssVccmK98BxzxaHdjImoiUG5mLK9pMpg/lCvKd+NjI3WQZDrw5DCIKm
	9WijQwgoJbvn98GFRUkGFL9+AE4r7jF6nVb7HFpfV1hP+X3mdUQrPlzUgyV/OExra4LLOm
	v+QQ2owGgtjSv5yrfVf2+4mD0oCalHf9R8tHtfOx0DSQR+JK/23Hya+zNSkUQe1A7e3p+1
	WbvXHTMCOxw8bQ5Vt91UnEapI4OmBZ0lSPWi62ExSdSjhj72nUQC1Vi8mz9xlmyIw97Nlo
	r7B98Ps3TFL7v5j1CdGVlOOpJ4cow/BN2g6m99tLQQUp3OdpZXBBYSRFOTVMGA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792602420; a=rsa-sha256;
	cv=none;
	b=G/l50+gdHjKI81+ZXmFMUDwBE1YXce3hO3r0mk9vBkj9VcooJEZ4+wwp7my1+0hSNmA15Y
	xhWl2WGDG+QDpyQfqbfqvZ0Fr1wfS2A6Kl9QOZ33ShIAAVxUhMJzOvGvbNjxLnpFmE1AgN
	Vc3VZEdQcxukOMo84PooOSu3bOwZytGjPFeGd7yDujGZqXmK+bxhTD2eJ3+iXTcYF7qobY
	mLvsDa6jnvI5gLw78Ycp7S9E1ACXznVwcq0PZ2EqqtymG0S7VK79Q/QC4O/D7TXWy8NHs/
	/86thz+a3Wu5bqQyMo506fUJySTcCLP6lSDziRv4md6JXP6GgHpnPhuMdZc6LA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792602420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2e5QeVvQJVei6FmOAgnoWQkcImWa3J3udnQRClGO98=;
	b=C4QXHIqsamW3NbSSHcKnVamZYhJ+0Kkk7p54D0KxkssG7YyXkaG550SiWCfiGmH+FD/ZSs
	Vt7IllaEJ9LuGN+lRhBtFOua3ZCrkEBG08aZaZ1D3LrFPaTl6Cp9YrY84zZJ54imcAFBlQ
	P72TVlaV9ebtI3450DRYDy/Drsxm/DMZxii/3MnIJ1E2sQjH7hW8WRWnTMmKrGaPziayJR
	UQfTU2QXWcj0jWdApvqrOo/JKieL4yzCNx9gJkFgNOOrOi5zy4HOtKK/g2mf6cw+st+HXH
	BKmojyMJjKivtqgeCc7N77+pvoYD6RwvrHwMKCtFouaKZq2x9reVtUEPQDH+RQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJZmG-000aIy-0I;
	Wed, 21 Oct 2026 19:07:00 +0200
Received: from hardanger.blackshift.org (195-200-20-154.mclarenap.oninferno.net [195.200.20.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3F0575D03FB;
	Wed, 21 Oct 2026 17:06:59 +0000 (UTC)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net] can: netlink: fix CAN XL PWM attribute sizing
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Zhu Ling <zhuling0805@qq.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
 socketcan@hartkopp.net, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <tencent_9A525E0656A4F7D4CA9CFA1AB1A4BFC6D706@qq.com>
References: <tencent_9A525E0656A4F7D4CA9CFA1AB1A4BFC6D706@qq.com>
Date: Wed, 21 Oct 2026 19:06:50 +0200
Message-Id: <179260241015.2007736.18110746301007705397.b4-review@b4>
X-Mailer: b4 0.17-dev-d58fe
X-Developer-Signature: v=1; a=openpgp-sha256; l=679; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xKUJIcl24xWsRm86t8lqAt7arJK/2S8nECNh620zhlc=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi68VHvssCbu2pRou9crj1Vqizv2/7n2oST2r1dM9Yvu
 P+vYHX5r45SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBMRNaQkeHWyeZnP7c6SnBE
 zc1bnWXLtNXwUqKJaZnL4eC+pGmbJgkx/GarSpV3tpV5pSbx4pjrVPuJ7XslFmRzKghbye3z3sz
 mywQA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On Fri, 04 Sep 2026 23:26:40 +0800, Zhu Ling <zhuling0805@qq.com> wrote:
> can_pwm_fill_info() emits the PWM capability limits whenever pwm_const is
> present, regardless of whether TMS is enabled. In contrast,
> can_pwm_get_size() currently returns zero when TMS is disabled. It
> therefore underestimates the required netlink message size by the nested
> attribute header and six u32 attributes.
> 
> Always account for the PWM capability attributes when pwm_const is
> present, and account for the three runtime PWM values only when TMS is
> enabled.
> 
> [...]

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
