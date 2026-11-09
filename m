Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239608;
	b=Z/LIWlWNi/3F5gAP7hoOe/UZtpMgrcJTjIUCe6LEt9FydiY4lBxobM2Oxva6cOEBZoYA
	 nWy+pf/ePLbqhhqRlwEDMka6sEleg6JeEMkeNKGsuATVzvsMM3P1EoF9zY5oSEfd0OTnx
	 mvY7Yqo6xxs9tzH9EWHXNJf5+3LAFsVDGp8h9ejiB4MZQO0JKVjjTHmlGl8bfelQFLVKP
	 oyk+t+wJe0PQNxbWevNrwQMegJHfRICyBBFBT//YAlEhFgoR5B96f+vP4MU9DzDCduJh2
	 V60P4no2KJWpGG5Rg9P79ESnSfDlvmWWcXVmzSQZlNTC7xDN+vTdgSLKxdnL3XWHOYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IPmS0UQ36DPisMahrt1u6xEBWvTZyY9aNb1Q2O5i9Og=;
	b=gxxEDM/Lyiwx7c1Is+Ktt7SSTCwS7f+Y9vEqqUsw+sFm3CtL7rbRCSGbBWzP0PE28nBh
	 8HXG6ui4hj8f/oqF4PTc/XWgiTLp5+9tzEmWMj1NAoc0qht2vLCZ9q8RBFozdy34I0iC8
	 Lb0VuoUAa7X5YUH2/wURTwpT1YK2QhrH8VbH53nMZQbzXA7pkTXG69P/FJ4bJLpwCq81a
	 c4TEMyfZ9xp0sPQ91fZDbrToh7hvvKq/WRTVCEdkTJe5H//um02rp1Ep4qnJ1zxHqEm+V
	 X9WxyBNEkF0HyPQw4pF2d6s37PRvjjYhOKIi4e99MXitpaDDYPu8WM1UvdgjQDWUtDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AM3ebVZ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC88606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM3ebVZ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C1F1F0089F;
	Mon,  9 Nov 2026 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239608;
	bh=IPmS0UQ36DPisMahrt1u6xEBWvTZyY9aNb1Q2O5i9Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AM3ebVZ/xgfa2rnIcA+W9hhJQ7NfP2J/ABm5LfH2+pN97mvBJrB3plXfhbfMW4T3C
	 AAfh8wffELpQj4igkyhzDJFb0+pt2NMxjZLKumTKWbf6TMGIlKlw1haoeTfrGazvsX
	 tkMIoje1jj7ZLE3I9c72T4fpM8SXWZIq61R54CgYG9Jer/fdrm73UT5R7Iz53/LEAq
	 H3wh1HJJDPlMsh10PkMaZMijLTd+AJzfyd0WiXLuI4LgS+ZZ9Q7383Rywyhg5AA7PW
	 X/qBm49mtzn6/Y/5t2wfEU2CNVDvK8H0swA+I3iXB6d/N+iNNWwGg6ibCars3y5PP1
	 wnMRU7bfjzYVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Pufan Jin <cyan2254650260@gmail.com>
Subject: Re: [PATCH 5.15.y] spi: zynq-qspi: fix address buffer corruption and support 4-byte address
Date: Mon,  9 Nov 2026 10:52:43 -0500
Message-ID: <2026-11-09-1-daily-reply-0001-zynq-qspi-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108171350.66362-1-cyan2254650260@gmail.com>
References: <20261108171350.66362-1-cyan2254650260@gmail.com>
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

> spi: zynq-qspi: fix address buffer corruption and support 4-byte address

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
