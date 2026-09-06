Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DCC2253EB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701663; cv=none; b=sVKPAMdT2uuilEnHzgY9H5MIM54fYBl+qijoUg1P7QQUV4JTyndgb+ugFva7gih9RV5aN4gtecrkLuNjuyxgpY1NKi7d35pMWQmadn8dk0oxx8ehlvbcqzO/4I6zfyK8zY7LKy0kcDpmIg4vatqwN7s6+B3e/A1rlQI9azTrM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701663; c=relaxed/simple;
	bh=8ZgRFguo9tD90Y0olXSE2ZcC8MfWW5mIjeES/+0JwhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZdLRBTxbbKwjhrncV3OFsAlL/8Xl62eXk7ttDl3u49HlfktZX8h5njTZTOvK3IVtPCMANpaldsDZr7ksf7bHp/S2Q6oOfzlfbjpTvGDb7bscKaM1XZYi/Kd9EACKYy8qr/WJuM8MiLIDYjY0IvpT2q//If87WLb+ym1suCVH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4MkZ67/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4MkZ67/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEA61F00AC4;
	Sun,  6 Sep 2026 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701659;
	bh=Hh2maretcw87V8SyLf4ciT9HdBwIuymj99nAHmW+jHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y4MkZ67/wJLOdXGJ92WcPrWA2BwUGeoU+B0yPBSbRniLImcEwfUMuNcq5wk6wPPkx
	 qFvDaMiCORxmW8zELO4Zi5kkJ24+6ZME0H+DVrL2VZTip2+UKBVCbZ4iVKcEcTxWTe
	 iXhBtXUBsLXgU+V2fvKIBmdVT4SA5qgQN74PKJwBUhWPGN1LXkqITGBUM0M+18wVpU
	 wEJty+OKG2/w/0L4kOF55IOyEkvSsaHCHW11ksHkV1DfqS3v5JRAWYMgNXRK7yO1nq
	 s/pfsAzxx08ottjK56m8cjrVcDEMIBrJK99KIAsKvGRM5h1QwUhM6Ww8DfqVGWW3Lf
	 ZFcsf/njQv2ew==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	ruanjinjie@huawei.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 6.1.y, 6.6.y, 6.12.y] entry: Fix seccomp bypass after ptrace with TSYNC
Date: Sun,  6 Sep 2026 09:33:19 -0400
Message-ID: <2026-09-05-daily-reply-0049-seccomp-tsync-6-1-6-6-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87fqzpa87c.ffs@fw13>
References: <87fqzpa87c.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sashiko review pointed out the following issue.
>
> If a thread is stopped in syscall_trace_enter() for ptrace, another
> thread can install a seccomp filter with SECCOMP_FILTER_FLAG_TSYNC.

Queued for 6.1, 6.6 and 6.12, thanks.

-- 
Thanks,
Sasha
