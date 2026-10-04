Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A813BE652
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131412; cv=none; b=a1uYdiDhyU+TwyednHPMpB47+Pkc8nU+kwQvj6F6ZHCQdsvNtcoDQOUptViybttTWpgYQceIrBAoP99ta8wsLCfvV2z3wcSdQs6EPhV6x/6kbdT2YXtlz5LO/WM+VEw9yMkUC68WmcTKoQP5V8F9mCwYUej1IL+O1BgmD+wvMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131412; c=relaxed/simple;
	bh=u9UvF5EBtGy9YL3eCPepm+v6c4tOZ5bqmZ/SuQVfTQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jq/Xomz51DSpiPSIAhSpzYgP7IM9t8Ifp2FKVsdxRggL0yME+oXECqt/6UxNyxLBVxU1oVdiNmsERnQulUklxEjbU4zVLUbUsZfeDj4i6VgORcljo6aghry8RzE4QDIkJ7Olu1td3/ZtYGjSvpGmRxFQkdvhoVqUbqFwB4/MoqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHUL/6kT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHUL/6kT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6751F00898;
	Sun,  4 Oct 2026 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131410;
	bh=AKvNTvhujcLNDAkTmx8Jg1TNdc6FLE7dynRW0HWjuCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHUL/6kTeooUb6WIw2KXstPGHTWMFkuQQqxcPmdQR+wHX1+F2McD3+9Ymw8XqRSJd
	 AT3NaTzrAcmk4d1QsjHyOuzzV0Izf/98hDhTkFGVzsBYpak6+9Pz/CtSuyLCjsBeAF
	 SHMMPo9ejNLaqDiZIf69Z7UgSe1GB8VuQ6LnWFmtlb+4s4evTEJLT4zUlP7aR5Sdl6
	 adB+zTOtpNmIKEPefMCjSCHdVQfQr/97E2AZHxZRJa+q+Pd3ikGuEzX0YprqxwInvv
	 hcG2pRarQ3J5RNtPQBcpncwS7U5OoEfWHN9ycsLpj/Zcl+RF/SU909c1i089RMNpkv
	 OY+BS84lsz4Jg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jason@zx2c4.com,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 6.18.y] random: vDSO: avoid call to memset() when zeroing reserved parameter
Date: Sun,  4 Oct 2026 12:29:43 -0400
Message-ID: <2026-10-04-1-daily-reply-0005-vdso-memset-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003144031.1375806-2-nathan@kernel.org>
References: <20261003144031.1375806-2-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit eb13a1ff271b0d180687eebb30611b0b276d5193 upstream.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
