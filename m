Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344404;
	b=UhutGA6XBYbbrSsQpi+FpJNYp8Jo3+TpUH8kZyjpkkD8D5rUyxHMRO9HgTDyFBtup+Ku
	 HqN9IXz9OFfpJsCv/fmL//yU+v4YZD4GZVFjjxe2tV5J9njMyTWKZr+xs5AUapyMyrSgA
	 +4E9FpY/0l0lKFfnierkENPooJDq5/UXCG8lPl0jvuPzQVZ5j6YZZyRBvm4F3MUpgsEud
	 br4705pK1H9BDCpsYIo4UO8ZtPg5rOAhJNOpnjAg632WxAPyMINlthfzTqx6PlfFZT0x5
	 z3cf/UKIkizemCxcomAlmZlNtvQyf2B7zWzyi4M1XdE48Js8cpll8w30aGp1+4yO83Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344404;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=frj497f/RdC9+IfK25XIiqfzsdGpk49BzWOWXrF4Fxc=;
	b=FzgOzRSQql58IpGtu2p+9FdNHdYNjGJrUECJViH6dFhzaZuoj9KBqRAqh4h+C5F+0NB7
	 RfJk9Wlu/iAtQv7yaGt/z4WPmdK9R+OPaIPCrfK/6eD244OHuCBIH4UFSiNYG+hwBN6hX
	 I54lfKdmJxIrSo/oDDmsQiRH1BK+HzOXrzzp2rOz4wZOn2GzfhnaxLKWlU7ppLzh88Ebg
	 mgQBQtu8u6OFOY+ejsImfT5yX0HobIvPHbX3j3WfOQzKdIhUjQRqEm2UWxdBoYcZVSPQD
	 txRNnfPDlxWNQyEURuEkatocFvYHHvnmuNZeSuyscDeVbflgNx9AYtrG2fk/PbTzxzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BG58dPmA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2E606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BG58dPmA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2891F008A3;
	Tue, 10 Nov 2026 21:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344403;
	bh=frj497f/RdC9+IfK25XIiqfzsdGpk49BzWOWXrF4Fxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BG58dPmAWrkFIBjSJKgOZ2cGj6+0dBZlZJWLA5MrQA/asVZqad53vJ6TdrqyGpMr7
	 u158VEUi2rBLCGK8ofvyPEFG3/PX4jBye1Pekd/w67sS6ZHL+FgKk86mOe4HaARvDF
	 E5/+LDENWoYeBIJo2N/3FZZAisFzYG3I2UEO2FCQ9hHTB66VdAwmFdgUFytTH6OGgK
	 LRf95yaMG4TZ4XuctPI6ktqKh2OnLaF43ThRxICbvVSXQLVMJqONu5xJGk2EVdVOTW
	 0UzkzX/5fIN9IA34WGVRzXPE+butm1rAiO/IEQbqv84ms4MN6uCJ4FTUuBk/vBnoGg
	 01ANjEBD68s1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 5.10.y 1/4] media: uvcvideo: Disable autosuspend for Insta360 Link
Date: Tue, 10 Nov 2026 15:59:27 -0500
Message-ID: <2026-11-10-1-daily-reply-0031-uvc-5.10-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109163941.1114322-1-ribalda@chromium.org>
References: <20261109163941.1114322-1-ribalda@chromium.org>
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

> media: uvcvideo: Disable autosuspend for Insta360 Link

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
