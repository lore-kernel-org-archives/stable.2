Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318770;
	b=qPVIXC8tXWyQMd6axIRezNti5KEBztHkP0p7NBIHHYY84xMMcZk0R1HoURfTMfigGWRw
	 gH1FxpXVCuN0qsSYjka6z8mF2AZDm5YKfi7/2dvotOLp9EKk1pfsr4ipbMQe3tcW/0DJd
	 mJcece2jb7J2iApc70rlUnJ913tNWunv6lcZ5EbiA3g+ScOSpooHZbaBdudDhc+nFCJ+e
	 w7h41FpoyXNe6Q0RW6QdoYqFwYn5V8mXUEJOawHKcrrgdVTyY4eyUx5h3pUHpN1gLC630
	 snw9pLX2LHf8L3jJlCAUdBWx806t3g0z+CRm0i/eg2lH5dWKVJK+qX4BshYv7vGFj+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318770;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H6uEwdDgwAiYPt7vH/Trfx8PPlfV6dVB5M3AMLtyg+w=;
	b=toxmIHlitO3VtK4M7DRGolaWWdHxc5XUnZeAAfbcQendk/FcPAVtDHuS3sAirclcPI07
	 PyK9e2iv8XjRk+x50cmzoIhi95h4/iPyN24CjrVUljIVQpY/iaExyWovu/EPFF5daT+48
	 FtbL7DBU/+mOeAMVYbXE1uVT2fCJokSdpiFIevbujZH00OHPUZjpey2p1aP3scfEPFKfl
	 fgUB7sWWsPOZ9Tv9TwhjiyrBl8EJQJMSQOdFtsgoytqojcBAPGpelPNcrcXi3dbhB2I9l
	 iAPaQna4LQP+DmxApRkR+29B1pgXMndA81TdkWmHGCcSz9cUIO13OKIgry1DrGsNrsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxPkqHYr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51475606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxPkqHYr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0C51F000C4;
	Sun, 22 Nov 2026 03:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318769;
	bh=H6uEwdDgwAiYPt7vH/Trfx8PPlfV6dVB5M3AMLtyg+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxPkqHYrllsj614bl4zgQ0lgw43mv+OH1f3BNIxmpYIyMBepk2at5MuHM4z27rVjH
	 1tmL3zAIuhp1bSZbbSRzvxCXNczRcNfomoI8x3qEWspVgP/9RnNR+TUZDyKpV3sZMK
	 YBMAPM80d84bPLPky0elsMYwg+UleM5Ya5puaVyfEW16ArCYtM0ARzES54Bm3lqCX0
	 39aNqXUPCVZ2lfcITOjKU3eWFXZrdcpBHWNiDsgbd93HzkJluyfXSBa+sPp4NqhSeZ
	 0JeKTdPyLHnVPMdybnbqKtR4TWUjvYM5Ix0SrEjcPr7uWHoNCI9EuTqCHFARTk3Mzx
	 5x+t6Ws36NT6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.12.y 0/9] io_uring fixes for 6.12-stable
Date: Sat, 21 Nov 2026 22:38:56 -0500
Message-ID: <2026-11-21-2-daily-reply-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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

> Here are io_uring fixes for 6.12-stable. All 9 patches are in Linus's
> tree.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
