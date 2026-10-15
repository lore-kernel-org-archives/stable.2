Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2343D953B;
	Thu, 15 Oct 2026 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097278; cv=pass; b=WMxpQvcSYia3y7OrYSspiSnN7pYgSjaj11S3rodkde/cISs8oTsnxT7MjwrCx8mq4QmJHNF4yyRXRqKdRe3OR12oNB4YwThSdkFrjCQmgBxBT6y+Pe+SCQeT9b/um4O0YiCH27FlHY2zgnHacTKb3QDl0Mgh+D8KXicaoxpfZVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097278; c=relaxed/simple;
	bh=ecJoEQ2+FupJYflks/ysR3zIDwMo3io84sW4btFfNOM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fw0yOEFC1fL3EvPnBgpKnaSf56C3+GiKgO0MjMWWVIEq4d+wG1ocJaaRlauRcq5DhzJd5gipMFZZNCpFozNt0GQW5aTmkbYqKEBtdTtXaZbYO2q9T2nEpWIp5iXWTF+5/pXxjNaVKs1mD9RQyekW92WXkfwUZMyN/FmmCQC0QPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Dog3p+cd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Dog3p+cd"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7E4C6201B55;
	Thu, 15 Oct 2026 22:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792097267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsmsjLeIGGW8wdudB66o8qfd5ct6fpMCIxYaGDCQzGE=;
	b=Dog3p+cdgalbv/mRMBK9rkBurZZWP0IG39lt6j/8AXIcnsYGNvbu7tj+H0Waw96czGqhFG
	upKZeS/k5Uq92HHESmHYDRjF8+Se2YhnDB/DKIH/MTosmqcxhAPx+kaopzVIqGIgDxpy1M
	4zBFjFOTDJy+0vp79TmealwTgfyNW6J9iuUOg0nTraCOVIrApNgfBUKdOKq2ruT5XZpXAD
	NExDg3BnLsbny3JC/gN2Hu/f/WjHp7yR3pxuFuxshMMhJ3T2r+/trNe7iBeWXVkgZopwnM
	BKaHsNPfm0Eh3/IPoHzRdol3Nuxje33VfZQeM7Q9+tNM3G0BlPlRhymOzl+xGg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792097267; a=rsa-sha256;
	cv=none;
	b=QesDLyjJD+YRtKyyW1Fo6Rysnlx5twydI4KJxxCyqIzm0udxGz5k8lPglvGBprjvGMLmKr
	NtIcCFcpK4wkSSSsA/G5IK7qTEV4Rd0GVlmSRgkHwJmKhOfxgusZCu8b50P/huVP3SpWMc
	vzA6PFS61/xvqMS+AzXaTzZu6rN+5r4udEGnL4ltM65vZYiejoRGU4WZRso2ZJikKJAWcb
	H0Edt49Mz0JxoigcJGOEB3AHgKxAc4mT0kTCSC/lRzvkD1XhwSNNlxI/adXxWcZvyexzHe
	WJ3oy5hEbfDB5KKklwioOlTZ3XyT1UQKQqomRmONGx7jyit5Mtbu0pwTV5ZzXA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792097267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsmsjLeIGGW8wdudB66o8qfd5ct6fpMCIxYaGDCQzGE=;
	b=EMmp5gY3SWGJS/BekbWl6PMuHAOHvNbYyVuZ23emLjmLcJ+tgpS1J6Z8CjNlPikjhMF/GS
	Iy+f+T17t3K3ih/n3SkqV4TMcB+YKdtTqJMAQldEgGjlYNVDL9ttqAEL4Kkfv56xCMOnbv
	+iDDTNtrClTOV7rMLZFgAUE20gkIluYawrxcgdU06kK8goFBxcF/rJjWLtKGfmCbM2tXaw
	vaV7Bph0fkC2eUkdRWctr+T6I98L6P0GIPwPHJY9MrfnIqK44Lz5HextHrvnJhYfC9Iiqg
	KOIt6WfIrHv61NvmLhGri5y8GNUPMFkPH4JHgZ4Uv6qaw/p/LI5fVAKFosWs7g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHSMd-0064wv-1G;
	Thu, 15 Oct 2026 22:47:47 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C5425C572E;
	Thu, 15 Oct 2026 20:47:47 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] can: flexcan: fix runtime PM reference imbalance on
 probe failure
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260915170327.2503156-1-lgs201920130244@gmail.com>
References: <20260915170327.2503156-1-lgs201920130244@gmail.com>
Date: Thu, 15 Oct 2026 22:47:40 +0200
Message-Id: <179209726047.1181445.10810284189835060011.b4-review@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=641; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ecJoEQ2+FupJYflks/ysR3zIDwMo3io84sW4btFfNOM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6aP3hw7yCvshv/JZHVnP/j75r1nbW+NlV5fimew++v
 rjs09Qxs6OUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATeRXC8L+qe1f0cfvDARyO
 vv1fjKs/GvbambzfHL+YK7kmxv/pu0cM/zN+pbCskjijcPHX6qc8dx/9+qguIVl83j6tZfvX2/Z
 pHYwA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On Wed, 16 Sep 2026 01:03:27 +0800, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> flexcan_probe() increments the runtime PM usage counter with
> pm_runtime_get_noresume() before registering the CAN device.
> 
> On successful registration, register_flexcandev() drops this reference
> with pm_runtime_put(). However, if flexcan_setup_stop_mode() subsequently
> fails, the error path unregisters the CAN device and falls through to
> failed_register, where pm_runtime_put_noidle() drops the same reference
> again.
> 
> [...]

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
