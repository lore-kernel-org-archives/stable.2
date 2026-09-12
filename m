Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54593418A5B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226786; cv=none; b=Qb4mRJK1RGW/0k2pJJTn0Cd9Quh2nMyI7HLnaLzyc0WpUoGuXEesDXFwOW38b5RmRibnYeHWHlU0smmY/FkRz1u6LoiOpb+2XfZPApVU0W1kQwEkvZn7JrRyni51J4QStZItyYhwEdSaSeen6pAzHwyNru8dyvtY32g+rqgHIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226786; c=relaxed/simple;
	bh=rutvr9eqKlKEI6oPG6GtTS6V1RYd5BNqr6zyMFAr3V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPBj/CwykR4AOgoT0n3tXD2kQKII5kI3GTw+RvpVfju/BHlQJrDk1R1Ho0e7C8bCULmf8rekdteatZKFg14aBU8+AS1B8O4TKc8VGKRPOKl1wNIxqCilw/bPlDqIFMryylOT1BAeo/BNpZ8zuVZELe9NMtt5PZ/76/XidrEbXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzRQtKkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzRQtKkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A4E1F0089A;
	Sat, 12 Sep 2026 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226785;
	bh=uos4eA+4bt0W+vF+TWfyiH3+/JyWTFD//3nb8H3p7xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MzRQtKkLUzoIVin7tRP1k6yE5vMx3d6T0B3I63dW3lSTghtmMmCs7WCjjoZ0g8C8s
	 LheqxUyIqkMjmA/vABWBdnm3DU/SYUg9A5ucpRW3CJpIJq+jy8g7o9jIKGOM3dTCMQ
	 LF2rK6g2TtNW8MawfWPkr/JiNdXjF1kSr4dznBnRC4FOxeEcDTOoNJ3hx2gIng3Amv
	 da58oFNTUEWccCpyysAbbJwQyqoJdH4QvTgOeJLbeDJqqths8fRfb65aonjreMFxHR
	 EueXAtphtM7il8kwNr5cJKOmr8hfI5DDAdEmnO6lZPRn2Q+5mNyuBnM2BXzGIPZYUL
	 XEotrN9Abw0Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [PATCH 6.12.y v3] ksmbd: fix use-after-free in oplock break notification
Date: Sat, 12 Sep 2026 11:26:12 -0400
Message-ID: <daily-reply-0002-re-ksmbd-oplock-uaf-6-12-v3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911151032.27929-1-suruurism@gmail.com>
References: <20260911151032.27929-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> smb2_oplock_break_noti() reads opinfo->conn without any lock and
> dereferences it after two allocations which may sleep. [...] A break
> triggered by another connection that races with the teardown can then
> resurrect the freed connection [...] a use-after-free reachable by any
> authenticated client holding a durable batch oplock.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
