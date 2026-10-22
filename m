Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634660;
	b=nhAO3PttQTimS29ircHMfeyj527iAjrJI1ub3fqG+g4oQy5a6mA+iZZOlmo2RqMzVzJB
	 H7QTf6KZU8V0ijg6cq64NGoa/7h8YVlJF+bMXrYAK7HjKqzHorUrHZ0R6hjq8PwG32bL5
	 dqHcPgvSC2Xr47xxWqWpKCpErtOEIdmb7K+l6xvAAhiSLYfhCrr54r/Gjb688yc5N0rsO
	 ZH/A3GRkTrUPS5RikeGvq7P/9deRxK1tmoa5alL+SF6OD2STIXLtdWmGhWA/nP5vxNI/+
	 WwG/pUAE9kt//8GUpSIg8bxyhlGuQaEtCpxXnUFOwTzn2mbNj5QXtY2xCj38SmvFECQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Pvb1W6New77Qu7AZhZxWG2Le7gUUjpAgzIQyd5xgYrE=;
	b=rx2jdsKm+GoGXdNBWNtDNXJDd5ApoVRlm6LSvUwPu4dgR+LWPvk/6ebNUDWUzeFVgl48
	 1eM4YhjNpOF/npjjUOB7tQKexKjFJIZXYM0/XWXyzcOtXbvQ0vKwQhIr9X5VWPQiUID1c
	 mNIK34OKsy+obNnBahCRvi29fch2gVFH0O2U/TR0JcF06MCg4CWwiZYL1WzYY+iiJIshO
	 yGPo9+yfSA8mMK/TvzyL2dCzMKC47VLX0TaNHOkVjyyq5YPXDfvMZGW6kx4SXsqvbJzmk
	 qjWhO1bqg1BTLIQ6qvLN/Fkf3bID+Q2t6mrLdqxn6qfTSkoDMe5nDZwD57p1/nM5lJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfdODx0M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B064606A319;
	Thu, 22 Oct 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfdODx0M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150521F000C2;
	Thu, 22 Oct 2026 02:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634659;
	bh=Pvb1W6New77Qu7AZhZxWG2Le7gUUjpAgzIQyd5xgYrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OfdODx0MnouRb3RR2BGad1GjxqSs7yU83n87GraCP9GlqRh59P2aRMwZuEPgQahq+
	 53PJiCQ5mPlqPp/NJP1MYZJztP+p5BBTpVAXAHz6OSDha7bpRIaKene6KVOiJ5HBa2
	 Bt+wTP+N1WvB2mjHW8lrpKgKugewMLYosbENFto8ZWOWSwCSuYvysyHA1yNA/Nc+CB
	 62OH4OmtuXuOqnhY4ucp1vLSwugaucr+b/1sO2Trs2aWdnlbAZtYwiP2RVKZRO4Eu2
	 jQ4/82YhBppGzMom3HptWDoBSN+cHDToJcA2ZILSOQxdVbHNCUuFOqjh9dxYAybsL8
	 lsAoNIPxRszhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	Mikkel Sejdelin <mikkel.sejdelin@proton.me>
Subject: Re: [REGRESSION] 6.18.57: resume from s2idle triggers poweroff and hangs when tiny_power_button is built as a module
Date: Wed, 21 Oct 2026 22:03:44 -0400
Message-ID: <2026-10-21-1-daily-reply-0019-tiny-power-button-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me>
References: <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me>
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

> Suggested fix: backport f4203ec64e11 together with 52d864019636, or
> revert 38c79dacc806 (and its dependents) from 6.18.y. Note that the same
> backport also appears to lose fixed-event power buttons (LNXPWRBN)
> without ab06eb920401 ("ACPI: scan: Register platform devices for fixed
> event buttons"), reported at

Queued the tiny-power-button conversion for 6.18, thanks for the report.
The fixed event buttons commit you mention is already queued for 6.18 as
well.

-- 
Thanks,
Sasha
