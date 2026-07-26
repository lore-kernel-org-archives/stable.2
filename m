Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9131AA9B
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067500; cv=none; b=ufhGFCRWPa2CuleWsD2Neq8gYC24WCshRwJDSJfPzggYZdNdDswzu32P/mSAngdb9YyP4OxUF8SKnFc4WbK0qJJqE6Juoy9ATa4fyor/owiG6/5X/QDfzoyMk4YOdh5u8DMxDi9OecPJVbwqGUUBylFvttUdmTAa2BAFT2JvGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067500; c=relaxed/simple;
	bh=/cFgfW6NpK/RmLN6Y2VJBgFLHBs89MwRs2lQHTuLxPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alBBO1k8fJUfukj7byhAhZfH91Nw/C6f3zo02eRgxPsRxIhLfZG76RBQ4r5nck2IusEDQensIydTl3ChVwrHaR0e18FH1x/t7AwrWR5JOwDGkGrT+HHNuH2a3MhK19ujUHoISSfhU/nj1liGshpBP8JoU6+7qDVFT4P6Rdw1wYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXuNrU5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXuNrU5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82BF1F00A3D;
	Sun, 26 Jul 2026 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067499;
	bh=KwO2hDAsKF/LJsoVSvVVTqJ6T3rLCIaP1nunmkm2hhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QXuNrU5u4envVo2ndV95HZ4fWNJge2goYmj2SY9ZqTgERpcZ4zM5XLnF4SCH1qIUA
	 L6+nLDbVUnbaa4uOis591OyFYgGxe/XbUBo8+6nTAYoV9VJG6zPwVpAI8WvbyoBRju
	 aRkzv8hQmuzM4wXJwZmsF27DrkOhs5/95K5YfqYTEmOH4WWOqF21t1Uo+VJyBGG9HH
	 tfCJz8M9BcQ45IjCm4DYFKhDlJgpa5WB2qV68tBVH3zQWKsmzin77mY1e2da3YijNS
	 6NaXpr+bQhTHj3zq39S/CxBbEqcJWL/Gj+NLAwh+bW9XRLESpqqtinwa+r78OtwrLb
	 pm/1bC4pQwoWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6.18.y 1/8] can: bcm: add locking when updating filter and timer values
Date: Sun, 26 Jul 2026 08:04:41 -0400
Message-ID: <20260725192000.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724102558.17056-1-socketcan@hartkopp.net>
References: <20260724102558.17056-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 749179c2e25b95d22499ed29096b3e02d6dfd2b4 upstream.
>
> KCSAN detected a simultaneous access to timer values that can be
> overwritten in bcm_rx_setup() when updating timer and filter content
> while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
> run concurrently on incoming CAN traffic.

Queued for 6.18, 6.12, 6.6, and 6.1, thanks.

-- 
Thanks,
Sasha
