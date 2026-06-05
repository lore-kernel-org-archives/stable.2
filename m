Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761124611C4
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688266; cv=none; b=Ne+6BirVL0AymVp8uQvFIW8mditmgmGCPDo0O828TMeoOa4ewRVcR1k1NMwC9dVf04CeBZAEjgmYkeLRjeuupYuufedCYUNVtK4MQstMmZMuoN+PvfBvpf0v9jG68zCWptZ4CPY5h7oeRXSquUKF1TEknQZFiH4Cy5icxxQqC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688266; c=relaxed/simple;
	bh=vBn0uMOlc7dpYFaT0ln+yFEvhhfXz/A+/m2j6YXt3h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOMkpMqIwLIE7BPl/wgvPGAU6iaHH6EnNmGcte2swtX5gC8XwKp/RumjQIaeIR7mFLcLdkQ4GiqfY3aelUHNH5pu9zFg5pnXKtWjOO6+4lXu5NCHoRFXVsPzPK3J/ZeTvwhbc3K7nV80M1xJ46VZYWoYoY9MW7rz3veM0pLCUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhQeUXP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhQeUXP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5560D1F00898;
	Fri,  5 Jun 2026 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688265;
	bh=2fi/uHqpvLmbF2h2S8R8jkh2FjhztUdxW4dQUx1/05A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhQeUXP8aYCd1+VJTjMzHuSo76ND3xbxTksf6GWJXpeCr/z5n6+8sBmSlKuYkfDgc
	 gSS+rxoCO9NoyMTP8xvUfJWhMSwbhmipEMDcUTfJbjyteUgL2xfSmfDKy52GYf7gV+
	 zKsDw5cXOxXsG6v8M5ULyKB6Nl8Z/Si/X0B6MmPHWKGLWsC83qZAubSmr7KI+s2yeO
	 TlRiV7paW6VFEzLARL8JFfnFoO12MN1T0UljpGihcZpHoJ9Ey9GHyE6Mq3S5eaDQ6D
	 ATmyvK6oyt39ZTkrkdceRP8mfeg8daLrf3eDt+POdLeQYAu1ERhPpMZZ7pPMn7U1FB
	 ghhmOl2rRu1Bg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	nogikh@google.com,
	bp@alien8.de,
	dvyukov@google.com,
	Miles Wang <13621186580@139.com>
Subject: Re: [PATCH 6.6.y] x86/kexec: Disable KCOV instrumentation after load_segments()
Date: Fri,  5 Jun 2026 15:37:17 -0400
Message-ID: <20260605-stable-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604003031.561-1-13621186580@139.com>
References: <20260604003031.561-1-13621186580@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] x86/kexec: Disable KCOV instrumentation after load_segments()

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha
