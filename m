Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FE755409C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985630; cv=none; b=IbZI+fOXJcg5aUxRaktpBiKhmWd5RnigmkrlZgXVUR865u9w3N9SDX4InHXCKrSSeLSz17jz/Pv9RMRX9rfChNrIMxaMctKSf84j2txdD+wmWPBqCAidwIdXXhLozHH4VWY3+ywAw4YNwyNAr2DSX9JqUzdsviULU5PjRqhVQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985630; c=relaxed/simple;
	bh=1OCd0dEPhHK6wdUoona5AsbEVYQ4QJgdWsEWBUzmYsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0IQ67m9JPLvq/x863EZ9wRPDsrOMOAt8DPts9bhJiBm3yl2fKDEdP3jQRQyHOvAXOFa0/3lPaqqcuU4Ruye6JcTAco96zQ9pZTAslPSztINsz/D7aQ/qFxYklcP+LmXnxIK3eoFX7gBQRDH2a0eaRWGF13/Pgh6MBxaWdADboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxZQ8ipV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxZQ8ipV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DCF1F0089B;
	Wed,  9 Sep 2026 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985623;
	bh=2HqxTuyEX1Q4WNWkconKTlTvRBCdrzp8rDr8XD2Bs5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxZQ8ipV5AHBXYj3eiggJ2iswFRUOW2nSAxhWDLgQ8Nibv3eJiHD/rIxOOVgb5027
	 edm6H1np+GFaiVKdJ5I2k4tH3d6NSoJ3AdSPQx5+Ba0j5CLfFZgLyXISerN3pfJ9e/
	 c1amti1KvGyY6I4ONAE4S9dDfgfP3yNSahj/PRQRRZBFjYlPQ2cb3dW33zN2e0/2Xz
	 ZPJc0uIJliJL8eoc24eJZDnLVqPoxk5o/ydHDA+s0kUpB7tY82bwLwl8XMQpKrlG82
	 RRzLaE5juQ2Qp4uqSBxSBr5J7NSeikAn5JYNgn3DfQBYM0mt7WAvN22E9R+vUsF611
	 3IjTsaCR95L1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 6.6.y] ksmbd: fix use-after-free in oplock break notification
Date: Wed,  9 Sep 2026 16:26:28 -0400
Message-ID: <2026-09-09-daily-reply-0030-ksmbd-oplock-break-uaf-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909075830.3269-1-suruurism@gmail.com>
References: <20260909075830.3269-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Select and pin the connection under ci->m_lock, the same lock
> session_fd_check() and ksmbd_reopen_durable_fd() use to update
> opinfo->conn, so a concurrent detach either loses the race to the
> clear or keeps the connection alive until the notification work
> releases it.

Same issue as the 6.12.y version of this patch.

-- 
Thanks,
Sasha
