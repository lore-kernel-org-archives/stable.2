Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAA32B100
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131414; cv=none; b=I0QhEQyzE21IFvAOJGSzWvNw4iGGQG0EBFLUU+mjzAZkzlsaRVQqOf8+fJzd78onPo8NUMBkC9V09U7/hWwOo8Wy+PFuh+SmVq0glTSzff6WQj7JzIdHFukpW2hVnj2XtI9D66/UXMAi4OSdHLY0q2b6MsOzwifdQrHBB9iZ56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131414; c=relaxed/simple;
	bh=1CgYZs5qEEWAGRjwFufwSDs6ZRPg7m/XO4ZTexLPk98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyZZ+6tv1Zw61Dt2DJgPxWrOr4uZGdKt1/bhCQH/ZATdTc1Fy84q9zHod8co4jYB8HY2CfiCuN7a4S1/KcDXf9IvV0JGdIaHfZwwia2By5k7ouXuxjrceG6Qn8hkc5gn8nxBf5hvY7QV/jD+a5Unsxz2Mv9Vf1IhJfzc1/3BjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYwwxjZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYwwxjZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E96F1F000FF;
	Sun,  4 Oct 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131412;
	bh=Uqa74TgCV4FAROeszaVaZt8uLCc8KiSAIduqJSK+D2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYwwxjZsWEqEkCv9qS3ruKjtsIVMxlG++zpJdo1NGPHGYP13vqvNWq0g9bCJoXdmm
	 BwndCmVz1MwazmctWiAVj1TrVg29Cs/e3FRO6r0GNzdZi9t5Nhx48jQuEUaaRQrg6f
	 bJ6SEWUNhbxCZLvhsIVfoMyYr2l0xqnXPBpy4zHwN79IwilP4ZbMAFlcjhV8BJQyet
	 tdVvatrmQcdx2vlXN4iw5kI0vLWYyWPpnMQCLrrRbQediSlbgX7Te6LWjOZE+0wyFj
	 CUz24A42l+v7FvXI3RoHiU8PEt41e00Mix6WdQnSinuBOiKDzGEpBmL7q7t8aZNLSi
	 62mqlr7Xyh1fA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jason@zx2c4.com,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 6.12.y] random: vDSO: avoid call to memset() when zeroing reserved parameter
Date: Sun,  4 Oct 2026 12:29:44 -0400
Message-ID: <2026-10-04-1-daily-reply-0006-vdso-memset-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003144155.1375966-2-nathan@kernel.org>
References: <20261003144155.1375966-2-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit eb13a1ff271b0d180687eebb30611b0b276d5193 upstream.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
