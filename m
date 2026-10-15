Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490335DA7B;
	Thu, 15 Oct 2026 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097430; cv=pass; b=m858pl+eX4lsw/dgij11h0SUWWsREQFj+stVeP83iBLOPU/OMwSJzroZJtxFnfA5/vbe2E9VUsnVCVX0ZAPXwHTx5EQGvT9tXMFNbN3PmYqDiBm6HBev2RjXqdh8Hnv8vbnRyraEZW7EKDCX+81/7RWcdxAMG80aybJmRfv8OXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097430; c=relaxed/simple;
	bh=zT2WbWgW2AiGM/7lf7fXjZCPjWO/sPphJ/NAHIbSVXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=di0RQeoc92ydeJ04y3/qAbnvG6uo3sH6ctsQ7Y/7VcfNXrSCQwSWIqGa7K9mZ5BmKun94EYds5xal14JgYMoiRiE2Dd3c3PgZRU4wryk5q5eFReWdBcJGwBW3OwC4878KbcmiMfLZ6qWp8P8qqNtFUJabyVYiUktikCcydO7gro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=AbLXLZpw; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="AbLXLZpw"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 59D7B2027CF;
	Thu, 15 Oct 2026 22:50:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792097421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pm6SaUQnuKXc1CA1BAOk+CC1Ysk+NDQPuPg6ekfQZBc=;
	b=AbLXLZpw2LZ3kH35MEGksjS8LgAgY+HaDikIye+vPXG3/AKbQL2UG8wGton2AOFxNmEty6
	ldxAsxPjpCIMretuAZVUeJoVvib5yK6F+9Tj7PnMFNHZPQbWXzmdTz1/hXkV6tWQw5Cvzd
	Hs25lKQRnyu5YQVgbFeroIYoUfYlT33CqDRnyqKAgMwV0gjlPOfXOEKUgA1i9XQ3tZTSln
	o6pO4MHbL+0f8OkAiN+/o/4U68u+GiFo0nkkwdbFEaJbS0kM7IyTDc25MZW/sDeBmJ0k6S
	0mVE9DA21LDQwH7teTKIAxaYa+w5DRI2SNVOjX4f8lj/hVXAhyEZI93AcCdvoQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792097421; a=rsa-sha256;
	cv=none;
	b=TlIZr+4pnbw3vnV+vJ4xumUO4G3z4Dsqio9FSw6KJdZBUUVvzg8rT/i+ueK83k7qH/xIHo
	Fl/0j39ZdDdw1BSwB9lhjH6k4l3yFA1zZEvGLP9fHvhRwzu+X5VbQf5bFekj88JhLGYIFq
	t1RA0ddN84UIg+zD3pVt8MuY4lJchXkZTr4druNRuzaEyidS6gufhkK3RIPk81CJJAQAT4
	LYlQ+ijORIPM5ttiyIvEIIwebJX1QnE4QTBlPjLVkhvdwPSHNLVoKnaJEZ0q4YmTxUnXKU
	M7/bmkRr/ar1DR4FH7x6pttTlFjM3VLNyYP6gp9iII5Kj4eXYZv2A/1X5SAJgg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792097421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pm6SaUQnuKXc1CA1BAOk+CC1Ysk+NDQPuPg6ekfQZBc=;
	b=TX1jEwekF61WdMflH+8mmX64l/M4pUpCtyKhknN5ioQsWsz0SMaDhsB4UR1keW1q/KaFft
	C3Zuuazm32Al/gehN1Ahxw3y5mEGu6ceo7Da+BRcUMkN9nrgqEVgC/5yx2B/iHwdGrhLPe
	+TCtf17dRjDysAJw3kgJkgxOengvQLsuJ61Dc2JwhES7p5RdEinnwetL6IzKYVR7qpFcyK
	gBgweuUc/8Cstaz47qEN9Akj1EB7dMK+sVpUaZ2KcJwmWOHrMMDMXqY0+YVNQso5HttgTE
	qd8yv4rLakSGtXTG0wHK8N62ox3IWeIxbULAg10wlOYVuvf810tdKanzmBoGxQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHSP7-0064xD-0s;
	Thu, 15 Oct 2026 22:50:21 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0666B5C5736;
	Thu, 15 Oct 2026 20:50:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260915170327.2503156-1-lgs201920130244@gmail.com>
References: <20260915170327.2503156-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] can: flexcan: fix runtime PM reference imbalance on
 probe failure
Message-Id: <179209737242.1181445.1074070842176651620.b4-ty@b4>
Date: Thu, 15 Oct 2026 22:49:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=359; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=9KOjnmj761cB4ARxTNM0Q2r2u9qCTI5Jn9MOPCnK8m8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6aNO1wluUPUps49zUQI0NnBuZgyQE626I8jxubl8n0
 fuzqKK6o5SFQYyLQVZMkWXpjxOKAoEOpb0vEybBzGFlAhnCwMUpABM5Mpnhv9tOvu7sSz97rvVL
 T+V/zyQk8v5q7DFu85zVBrftcv/35TMyrExiTzu++N2eB6yp/t/mru2NMtQxUbxwOZKPO1aAd30
 hKwA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54


On Wed, 16 Sep 2026 01:03:27 +0800, Guangshuo Li wrote:
> can: flexcan: fix runtime PM reference imbalance on probe failure

Applied, thanks!

[1/1] can: flexcan: fix runtime PM reference imbalance on probe failure
      commit: f40b25291025b0c3382f1ad159033a4ec885cc58 (subject to change)

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>

