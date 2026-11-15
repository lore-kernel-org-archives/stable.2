Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786075;
	b=2rY84oNXZtYznz7Xb4agzFk/6xYpZ7QtUQPu3fB2OCwpq4oRgHGYQ3YFRkAy/s2j6Tdf
	 GDN6J84xURK6O6u8B/Jhnd15MQKD1tpJbcmJQlhjyWOTJOWMFTs/EHXYScjv3w5hzvbIx
	 DvdtcbtgAIirJiHDkERYWbG5bAmOPAkl9bqesVsS7AmEM8lIU6So1T6nXjlbmqPiULCI2
	 VM/ht2cGKY6+YN2HKS69NYR0xmxLIVhsNwO7bXfOP3uYWJeME19qib1yy2u6x1L5TX9I5
	 6dbqJTU0KIwHOV+yfcTN5FBfmy96ubimgJY9tB9xuG3H1mHG94PTztU6FipF+psRhqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786075;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DokgtxCvImzny8oteciqlbqkvPzjli5MfYqSFiVSXE0=;
	b=Mn2STA+qntjCuMrHhSqCIbSrx5cl5Sh7NWVWGcMjJMRoildIgmtqANiGnhdXKzroPZhA
	 6xcqdKY8teeWDZQ3VbQq7sWLL2dj3n08+Rbhle0GUjCUfvM1uqmX9pDtV2uYdGACgN9Ov
	 zb+a19smcqIAL1ERpmoVy42GOTLANhiA3yR0Q+AnbLjlD1brgYpS212R1l+poJEtlUppa
	 2nUwzmDWNJkk/lrWjZuyTDrSg4wfHPuxyrFMDaopv7MHzVkWn6VnygsBGqOpzw8h98wEl
	 dFkmwvWz6PzIeeJTTL12uUVqgMUYC5w6EvsDVkteZROhhPWK7BzSLDCtkWyiNSpE+oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDrTFSRU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543E606A331
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDrTFSRU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFE11F000C7;
	Sun, 15 Nov 2026 23:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786074;
	bh=DokgtxCvImzny8oteciqlbqkvPzjli5MfYqSFiVSXE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDrTFSRU/yWfEpnCnlNdkKxGR52Yx1SV4sBZ6H92Y4YogkpilsOpYdbU9Nr4ij+QP
	 geCmxkMtrh6ioliL8Wxn0vG26A0zJUrxv32w8V3LoG/svmjqY1tQU61Leq43WO2tTJ
	 x4GnswX7FNCIuvvS0uNEKLmTUFkMR31RmRWcZUIBAnI53YsQGdArY8vBPFX073QkjZ
	 cde/DOXbn+7wbuWdpoJdQpdCxE5uj5fJR5dY2Jd3j1+d5Eb3AC88OLruZtsUkVBqBh
	 Ea64cz1GX6DTqTU/7VI4j+TpMt7ueu91wmmzwboop/oVMPiQDGrbIGm+YboM1W3qDk
	 /SSgBlqoTsPBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	ljs@kernel.org
Subject: Re: [PATCH 6.6.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
Date: Sun, 15 Nov 2026 18:41:07 -0500
Message-ID: <2026-11-15-1-daily-reply-0006-mm-vma-lock-seq-66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114180830.55586-1-ljs@kernel.org>
References: <20261114180830.55586-1-ljs@kernel.org>
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

> [PATCH 6.6.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
