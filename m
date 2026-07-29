Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8728C037
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295080; cv=none; b=mTID7LI54g3jxmQCgKXjUX84ikziOckPR/7Nn/pUPeB6f6/iynxWzbKLT7bvcZOeekgEfofFmQT4x22kF4oTbquBKRnH+1Sd2y/+PYt6Isbvnt8eHB03lGu031I77nGPYa6QhpPR4f5OP3lEQltiYP7e35PC38RktJPt9trpupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295080; c=relaxed/simple;
	bh=9Gnd/6ecEoAq8B5d0GTMZJ1gN07BaWN78736Vixs8g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9dUVNEgmd2wGyljDApuV3LU9uzSad/41dCKnvqDdILIpwSVWJqLJehpEdfrPxsvjSlVkqMR9lsMtkhZ78FJYNptWWqMQfNJGQlKwTyUAJZKBS69xlYyEML7mRrGYxZ6Djc74nZZyOLDe5DVzk2OTxIVkDFJXxwRI3M71oX7iAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H73UsF8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H73UsF8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ECD1F000E9;
	Wed, 29 Jul 2026 03:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785295079;
	bh=qL2PmaG7IHdlSA7SXfRmZs90C5BFk8nAy+c93Uvh7kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H73UsF8vIF4TUmbV9ewON6az+/D7i+cQ3np2Auaq08QLixk7WNwj3msO/BaMizXtd
	 +M94NFhhp4v1WdjCnh+Q+C79cw2ytb8UTeRl2aHPhy+sd3bM/8HpvOnM0L/yGQBsx1
	 KEOxVVGD5m5SCpZK+Hxx9kMH61CleoUmm0k1U1MA0w6qBCqvnckx6Z4zz0PUw0+cop
	 ypEbJFMZTcxGpn0JC2KeyHB3UXlt6IdCtQGv6lFxJMF+N+k5OLyx0D6zJ+/eCbZnlV
	 369EN3J0ZZPcmaf9aj6/EjyCrVFeWv50hF4b7ChZl9EwaEj1pkxnuoo7LZApVOx77Q
	 VWvuE1sAoPAQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.10.y v2 1/9] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Tue, 28 Jul 2026 23:17:53 -0400
Message-ID: <20260728225500.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728163902.24067-1-socketcan@hartkopp.net>
References: <20260728163902.24067-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 68973f9db76144825e4f35dfdc80fb8279eb2d57 upstream.
>
> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()") replaced synchronize_rcu() in bcm_delete_rx_op()
> with call_rcu() and introduced the RX_NO_AUTOTIMER flag.

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
