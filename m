Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B441E5B68
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966328; cv=none; b=DrKwEAp2GXlfL7uDAz6vOzsxsZ1oVlLA3E9whXHdDSA40M+jDo1M7fO5HnmsV7z2Jbz1qX9pa8hS5OJhpC16c/lM9P5d0gVfy3LTCvpXLv7vgbAYAk3zMZ0b02W9Ikvp2LCa3Aw7AWee7HTfqg9toa0TPZ0AxRve/nwRl8AScic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966328; c=relaxed/simple;
	bh=g0+5yC15dN1lPsZlckgDKhTfeod5v0kdYtEmcfiLYM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/l0nNOQDrf4y6B7dkW9Q0xM0eqNPnxJJn9U8x24RmXMZPOIL1VdMzq9OdCiEkJ5Wyks2uOW8oLrXvY2uiqiGt9zZRlDXzCadHHWf1R+B8MI2h7OCFuSPL4DYw+W4cC9fvHscYzenYwVMAPiUsPXmTn4lfnf4QaZTzjfe3JD4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K16TcEtl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K16TcEtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA62D1F00898;
	Tue,  9 Jun 2026 00:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966327;
	bh=g0+5yC15dN1lPsZlckgDKhTfeod5v0kdYtEmcfiLYM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K16TcEtlSpatse63y+hPj20LD1GdAO/Mo8tDL0/RgbxJkS7/IjcO/gCHo9hTZzLH0
	 GhbZf/yl9mn7BnPjnqF2z1WpU71K7+gF3vRWCv25XJWxxRc/ATU5elZ4Ywe5JUH3FA
	 Fs+TX277ABbyEYXwofINylyD4/vF2k6wHznbmrkm8HgE3LAUibVVbAfqhK91LusFHq
	 HuYVq+rBS0RZ6W0Ln09JSdQYSlxLtTDCFmZi+EXhRliOSmUTQcyWAgR8VTRMRYFZnm
	 rmU0x56jmdQ54+DMKdugstNVUerqzId8HcJtEVylXnp2+VnRfBEI4CmG/w4dSwZIck
	 eLhirUk1sQEAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Taeyang Lee <0wn@theori.io>
Subject: Re: [stable] Please apply 18fc650ccd7f: bpf: Free reuseport cBPF prog after RCU grace period
Date: Mon,  8 Jun 2026 20:51:47 -0400
Message-ID: <20260608-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH-2Xv+d-xVfqEN1NRpKbGmDFX3JdVzLBF1MXWubhzhbisaoUg@mail.gmail.com>
References: <CAH-2Xv+d-xVfqEN1NRpKbGmDFX3JdVzLBF1MXWubhzhbisaoUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please apply 18fc650ccd7f ("bpf: Free reuseport cBPF prog after RCU
> grace period.") to the stable trees.

Queued for 7.0, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

--
Thanks,
Sasha
