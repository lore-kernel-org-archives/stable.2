Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318770;
	b=zxmfzE19nUAtMzQGMNbl0NgJnj9Z758gxt6WzVw+/Q6PBNQqKxtBeTEz0ykAC/IEtmpf
	 i99BlfxA0o+i6kb6rLs8k/taCbD2B9/B/QmqBKWHGFIXv0mr8THzJIJucHUOznkNxhwJy
	 03AR4YkR3xz744SKfq7ktxuayAACddFGKaLoQVZiMZIlOe4PiCPyCU5tGzzlH6eW6GZPH
	 NgIIjU4P0pVBmeiwSGWDWFEneuctHt5X/NrE3hZZeRYMU+Xe1EuIn8OVQyIKx6CfXSCXW
	 a+qaVgkzbRPmvCR9SZJ66ONJcJGRfqL2daHssYd5r828B3krQFhD1Hq2YwcCbtlzomQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318770;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U6L/XOpYjTaRrStJmoigLxpCQPfLB2L7L2p+kUhl+/M=;
	b=TnMc3AfsvO7O2V/Bppu4wPtxqve4KdCDAondfK9VCSCChR219Kacdzx4z+7RGqqqpFiy
	 CxNfaZn3rM17m34kWTmEnRdTuht6KygGxMqkI6eij88i0BK/Xk/u3NY8Uz949mtOTpsf7
	 hY1cXfLSWpZrdZTW+HiX6nYwSRTnJHWqmtKbOfTaF19FQqv6bZ9FGiTgFoNPliR8JLugB
	 1cZBaGNs3G5VNLHvzkO44lkB9V77iRd5/LtHbyjyGyX2R7j3+xZ+G01tggEXgtW+a96Zf
	 mqXkaWc94kCmAKI1GR6Z3vA3PrHo8lufAb195j7AWLWU6hi9seqKLC6TMVrrL5H2TTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjfOGKkz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A27606A332
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjfOGKkz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231C91F000C0;
	Sun, 22 Nov 2026 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318770;
	bh=U6L/XOpYjTaRrStJmoigLxpCQPfLB2L7L2p+kUhl+/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mjfOGKkzLTrdPp4Qahs7Sbewpv5kWJvFEzcV+MHjaE4VXEQF7hFPXy0YnzJAWVvYe
	 9UzSU/FEnYb9jl21xW0s67b9Jyp9PKaHJ3KkbFNrpBUya+zBw5+D3yp0OgGWREEUMB
	 cK3RvpOxwY5XxyYQkOvGmOt12xLdWfQgO7KK4wUxsPDYm3KfiHW68+n1hJhXeuo4a4
	 qmdrQKQyvRO2knB7sl/1IzGgWiUWWYo5b2B8frBIHbWGRELVd05FAXKBlp8bvKOPyH
	 fEH+21ebY+uL8JNDpEjbbCtWyTFooeHT0Z2wQ5wzBf/TUsU6mOLqrH2azOtsNQ7YNH
	 A6ixn83HVFIJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.6.y 00/19] io_uring fixes for 6.6-stable
Date: Sat, 21 Nov 2026 22:38:57 -0500
Message-ID: <2026-11-21-2-daily-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

> Please take patches 6-19 together: they are the SQPOLL private task_work
> handling from 6.9 (8/19, with 6/19 and 7/19 as prep) and the fixes that
> followed it upstream, whose Fixes: tags name it.

Queued the whole series for 6.6, thanks.

-- 
Thanks,
Sasha
