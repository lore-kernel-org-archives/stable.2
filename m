Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344377;
	b=5SSbN6yzwvq6rQXMrDKh+6xVx1tZPXIYzqeTfCYUaB6eyHxkhhEB57f9pPD1TxMHl50L
	 7ZCDfKjCo74rHM57ywtKmUXEK2GbGe6N+h7Fv3m/RcIAZYrrML7o7zS/EXRL8ekOAc1h9
	 Wbd5cnyiHEYfrHeDXFBfPM9od9doaU04OzNwS5Y1p0Pz7S2emuuOtCou062aa8cCYzUzV
	 beMY/U6pevqS8+OnJ+OP4S3zvKfwkxUXqLzVrrxkI37PDWrkhiAtKQnRyxdB6iC2K1UdW
	 r2mmikxG8EJRQiZPnXoWxZvatQbvgzH0QoAv7ixuDmwUi0gAhQkQw5hEAkF6xft3/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ht+c272NuP+IN/yp5mXpYUqK6Dyn9bjb2OsGo33p4oQ=;
	b=tSnZbZg1na2kxG6wK8jJVAH55uybYuk/C5o6f3HT3HUkFGc97+T0mQnMD7Ah2CUjuvQ7
	 30PzpjkjemY8Xx6qEgZk1FUiP8Q7qLO7ggy5ZAgieDHVGBIKKDW2kJA2S/oXmH8al2wFX
	 T/wDi5/A/nYhGqz9dd5/QZVxOUzn1mj8kI6ccfBKnaJPMcr0gnUwwO5VnyU6LaPjC7P7S
	 6AGCOKws4jbcso4DjTBBsZSQs7kHNC3ac5eZfXEc96pEfDncohSBMYG3zX+fQgFDTaHpi
	 RkzEyj42OwZnAmp8R9girL6fKvRvzJ0RGzkmQwS8sFPSfCV5XAAIEC5jYu0vb9wZL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0LgQewp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E8606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0LgQewp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F6E1F0089F;
	Tue, 10 Nov 2026 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344376;
	bh=Ht+c272NuP+IN/yp5mXpYUqK6Dyn9bjb2OsGo33p4oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T0LgQewppw7ZfTs+bkTa4W1TceHRSdTa+KB2LiIfeVKJPMTkn4iiOkgFFfk6tbIv3
	 mEdECQEA1xuMBKLTJV+k6/2obLTOcvpJ9r+TVPacyyc4QI2aKKe2KfCsmOCNfUjbfD
	 8o+hp+v2ao80TeUlMiO8UwUbVJRjS+FHw/VBa/IL89j3feDSG98zMpYc5ooagxHcSA
	 2Ehd6uRtNwg8UuWog+R80gOAtFEsHA2CbT5OX4duF7l5R49chHMA0WY/K2CREzptp7
	 MFWTFLwbr8vNX165UZRJtsqmptgjl3NFX5EyTiMc8GfoLUmRtadRZYU718vHn/9ohw
	 ksad593AJtQ7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 6.18.y] can: protect the receive lists with a per-device lock
Date: Tue, 10 Nov 2026 15:58:59 -0500
Message-ID: <2026-11-10-1-daily-reply-0003-can-rx-lock@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110175757.791794-1-socketcan@hartkopp.net>
References: <20261110175757.791794-1-socketcan@hartkopp.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> can: protect the receive lists with a per-device lock

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
