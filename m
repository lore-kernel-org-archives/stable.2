Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877391;
	b=C2OVRZhOgTv39k+ttBwPJjbu5IqvW+8Vctwp53fexz36GFMuay83/+4uUwHsFO/IUBO5
	 iWiLCExRnLfk2Jhu2NVtGKABlr0X6F7C29fvYPBxhh7AVTy60UsTmNqcswkv7lIp+euDW
	 sRvKOHGF97Iyr9Sn3wq+xO0HbmwSvTQ+On2+mev7RPi75blybM/1W/Uub3nTKGB3f+AAt
	 4RndmtcaM1Xzg7T9WQVlagfIR4k4YIlqeaLBZyHm9aNC/qCCBeDYM1Tip23O1JTxOFZyo
	 kR1tVFDKlJk9rdOE9Ha+1WGIJvrQQA4dz1ahEoPw3IOULz8Ja/ngZfdrF9zgVqpFhhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VSsxVqIpPocHwXdbYnDV3IVSPQ59g639wPhtS/DpJuc=;
	b=2aGBrfwTxK/sOut+lPHv9hWgOFdlE1Xq3CTX+jtjAw5xooKocXOt5XhzCplM9EBP5q0b
	 Z2AXBVISwcEL8KKBnt2fkC5+s8YkKsk7MXzL/X+22rj6tCrl5iEMb3O79207Kar8sZ7Qj
	 e1mBIuUubFDG3At0xDJAbNsGsaWbD/Cv2cmF19Of18YmcD2SIqA2sR67jZYM465sGmPT4
	 YS9IS+ca5W1/Tq7qTwf1TId6dakd07jyutnv1CatAH834WKB2aTe+BhxJV96FIj6ytgiT
	 PUZAOSsBw3D7YsqZ1sZ1FhwcStYv1ovNuQE3SG9hhZnub7F/3ac0BhWRC4nD05OLEVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DH7Q9ors;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4223606A31C;
	Tue, 17 Nov 2026 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DH7Q9ors
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03FD1F000C4;
	Tue, 17 Nov 2026 01:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794877391;
	bh=VSsxVqIpPocHwXdbYnDV3IVSPQ59g639wPhtS/DpJuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DH7Q9orsMuxRWex72emEAe5XG5nw2FYKjuzMoTSK3GfjJJmkEC1WQLP5Y5+Gtv+6l
	 QnvNmptz+7X9hjjGEkGdgJaaJTaF6AAGSSa3FM1Cx0iC6Z9D4k1NIjzMoHsFJL/BkF
	 UN0ZnAPzeUi0k6ITsflSZi16v5vdjrEZbrpCxjFp6/EXdbojvsAkKDJgzaVyyFJVVt
	 UndfjfDpKDm+uXMxPmssB7a01LPbAwGLyVsHfUckcHaBqxY4aIAnKiqqht9tDfS0hC
	 +iyjI2nEVE2gA0Fkd9oDqdLj99f+wiQBmPB0ltOLzDDzYZQVnwKbgI8jjX7iXsVFQV
	 nKPrt+NXjTfKA==
From: Sasha Levin <sashal@kernel.org>
To: florian@wagner-flo.de,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6.18.y] ACPI: button: Enable wakeup GPEs for ACPI buttons at probe time
Date: Mon, 16 Nov 2026 20:03:01 -0500
Message-ID: <2026-11-16-2-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116181104.7297-1-florian@wagner-flo.de>
References: <20261116181104.7297-1-florian@wagner-flo.de>
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

> That causes function keys to stop working on some systems [1] and there
> may be other related issues elsewhere.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
