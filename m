Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785784;
	b=rCGWlVsiDGd4GjAb1CVIxAdxsbtt3AXKH7w2QDxpD/+lthRc5ghFJtKtlPplHoQfGGh7
	 IJ+9zggWBqUUSXBhR1dGywbn8ivncwEFTNlcwjufqkHv21FmQUAvuDz+wfsrv1muzthN/
	 Pq1+GXVKe0/n53uZ00fBpQtSVEAMSFPjzGiU1u2hdAYydG9hQLCgYQWgbAMEHbf+glBN6
	 LNDs08MXbmQpli2nGQML6gubGg6UEhokvMMJRnIDoyMKQ1lK05PzEU+aRzzevhF0KL1Xl
	 nqxkmr2T/zYwU9fqTI7yPHqnItbEoN2hCCkuEHlb0THS222t6O+f6I0IAX8tK1RSidw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h7cEtkR3wUMaj/5k5bwBQ/UPEGYAUdT0rjLHkXCUXEM=;
	b=nrKOwk7h6/V89iuRocypVV+LMw6MO+yoyn92h8KlX7Y9f/1VEOFAy9octwHW88rPwW/f
	 iXl73OJnAyhuiRouh1GwKkKJnIpqmNVAc80OM0RaFeZf7V7G9SF2IQGy/Yy/9E9rT0EgA
	 is3Qm6/O4FyRp2PbMGJhcdZ0gayCOSZuIczKZuMRgbWXYPa0vWTLqk0Xw7p+KhG8RZVqt
	 13THtyxTRf63R6uhc0vau+sCyJQotFTjGMPrWiYxkdF9jMw6xzJ2rVPi+NgSl0TJvMbKC
	 aANZ0X1xbFWvFMl2Diz1Xdo+1dqoyJTtyTLsCoUCUbn9CBqpcxea1LJb5cDcStAcTBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxACvXuD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81628606A32E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxACvXuD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73A51F01825;
	Fri, 23 Oct 2026 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785784;
	bh=h7cEtkR3wUMaj/5k5bwBQ/UPEGYAUdT0rjLHkXCUXEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CxACvXuD5lkFiaq2nEPLeu16y7OzrwLy12Sdeag5srJBKCzNnhv2ZtEM2NXySTDEv
	 MK04pZYpSY76qFC2KDis5paPv53IOkhlTvUOlhDTyxAKSsEfLlhan7611jJdN/gI/W
	 Uh9UNjf0J2TUlqlHteSj+o01ty6Nu3dUSVE66izzpweCzOSRV3RHtD3xVI0xXlsv1f
	 JihJew8oDoibId8jG8u6IpFFOSbUJgh4pBdt/AwYlDyxDqhwrbvbLzh19ggEk3frIy
	 gvywNDoe1Pnx20HJaBY0XkVlkV/YOPFMD0zobseiso6CM8mXR0po/wcSRSp1A2XRAr
	 899Qjt7gzhnfg==
From: Sasha Levin <sashal@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 6.6.y] eventfs: fix SRCU read lock leak in eventfs_iterate()
Date: Fri, 23 Oct 2026 16:02:45 -0400
Message-ID: <2026-10-23-1-daily-reply-0009-eventfs-srcu-leak-6-18-6-12-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022064046.4048143-1-joseph.qi@linux.alibaba.com>
References: <20261022064046.4048143-1-joseph.qi@linux.alibaba.com>
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

> The unbalanced reader prevents the grace period from ever completing, so
> the call_srcu() callback queued by free_ei() never runs and the
> eventfs_inode is leaked. Every readdir that races with removal adds
> another reader.

Queued for 6.18, 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
