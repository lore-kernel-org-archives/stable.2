Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9582442C51C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226789; cv=none; b=EzvEHvu2ydeOjhd4w1GD4zlBCqVZz3TOOvx9FaGLcSMe6FB5UyE/6dYDJMpURAwZy500aipMOZxDfea8ubp2VNMef1VrEyh0m1LPtxY2X827B/So0I0mnGiupwY+zPcgH7I7z0JvBYCWcMEpl2210LO6r7AllEAZOW6vtVr/Zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226789; c=relaxed/simple;
	bh=hWekATinSYKxoiyRpO+gjRE8SjbY1mwkFWiNupDb34Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAKQV/YFmRR9hMBiWDiweHGhGP0wVfAcy9RMQDBR/qPkZzyUYGlO0icHIDQFGWc74lTu0SKPoCb4/oBwGGsdp5DJ5A7ZxB8JbmINOEByDUlgryawa34f+Uhi3wF33VXfupJW3oCdxrY7+rui0DUKHsKWIBK/OwGtWfLunNhyOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cayP5UI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cayP5UI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24491F00893;
	Sat, 12 Sep 2026 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226788;
	bh=zPVRXlmcwMaMiW/7WhQMEh46cXuBTvm5tuY1T3vKEOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cayP5UI5axNMWbYSQI3X5N6x2Ta6nOy3IZ5oE7I+tbth34KjFwYBxdZOn1oawgQht
	 WKxvpFCaasM5V39fkeZcGh6v7KtFZjstvKpedjp75KLqgR1P56HuRN8wb4Pa1V1WwE
	 gcx95JXvKMfdjODN4u0qYUaDkYB6iYwpjJkcmJgFXMRXRvx3oVNsXMpMDFPAdlkiuh
	 IIcpyFOkVmEfqqRiI86aPKBBamTTfs4B1QfeCYUUer2g/aIyxCaled3DiEqykjhCxS
	 rBNZVIIm0b8ltBKU9H3M3GOjogVRNOXsVWvm6jDVuWl8UjxgVd0H5CQHunIfsk+/Tg
	 SsHnJYUuLeewQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linkinjeon@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [PATCH 6.18.y] ksmbd: defer oplock break until m_lock is released
Date: Sat, 12 Sep 2026 11:26:16 -0400
Message-ID: <daily-reply-0008-re-ksmbd-defer-oplock-break-6-18-hold@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911151056.27965-1-suruurism@gmail.com>
References: <20260911151056.27965-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Port the deferred break machinery (oplock_break_add() and
> oplock_break_drain_none()) from the newer stable branches and make
> the three walks collect the breaks and drain them after releasing
> ci->m_lock, matching the 7.2.y and 6.12.y shape of the fix.

Holding this one for a Reviewed-by/Ack from a maintainer before queuing. It's
porting the deferred-break mechanism onto 6.18 rather than a straight
cherry-pick, and it's fixing a self-deadlock that's already shipped in
v6.18.51.

-- 
Thanks,
Sasha
