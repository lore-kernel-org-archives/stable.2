Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393656;
	b=y/GCpWuqGG5A4yxYTnAP3ktqya3biwM5HmfFSrbJr1HCKAYeiHpwdC9/sQjlF0AZyXyR
	 HooTGcVteilr4aTIXWtz26wPoA2rncRQbS+nkwg6wWBj3dkW/34VJdI4ByVcb56rqmBrW
	 w4Qd27+FuwRG6Yr9UxB00QbMrG07hiOiT02imVWct5sD4j8NjpiURgKlG8c93dOhYBoP9
	 e6zkq+H3103OcYeyqSCTH2ARzQmGmNJ6D1VjJBg2m94QZnMx+SizIEJ7qnC21aZ0q/d9+
	 7puf2wWgwdesrbg4UKMKxXwMQoBvBkODyQOraXQIH1U0Vg/Txoiqmi7YZHJ2Trb5b1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+KOvVabjZuUxEHkUVsi+rBzeFJOj/9Ziw63vH3LpAgg=;
	b=NsV3xNGrj+noC8yySsQgsyZNXc8JApO8we7eixeoX65FVgYttrh5zz7G+hhT/Ajeyp/H
	 OZDWfCgNIBt4RJ5JZaN/0LtRj1bQxujl8Ph2lPHFPLsphkb2KQT+TAt5pizQ0URUeOWh4
	 2ZGnDIJvLRDUv7Ay2JCzdXDaMZILyBPlfhwlq+WoC44z74OesfNr1vdg+oQtH4RT2QHX1
	 nIjsQfSo7z6BPvnwO/GG37RMSuOaclLqQdaBsAt9PDCiU88Tts+F/uXhmYuN84Fbwvb0g
	 BoS0HXp4w/Q3jfn++cGCFmfvOQ4+1AsYLvDaFZwbPiOEmEqbg7DWutGYnnQPaaaYQjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcKJAlWT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463C606A31A;
	Fri, 30 Oct 2026 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcKJAlWT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4DF1F00A02;
	Fri, 30 Oct 2026 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393655;
	bh=+KOvVabjZuUxEHkUVsi+rBzeFJOj/9Ziw63vH3LpAgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mcKJAlWTwNWfOB1yCLC4V1wNLumGiAiCWNqTl6af2NvkV5CUxoIcz6Slfq75jtXR6
	 R5tX4s7hI+WoXZc4kAyXjHM7DonQOAXC5zlpNnAH7kYdfsduX1Gr+KH+G2prsvBEHK
	 M1Q4AZmlyoSldq5R/tmdZ3WSD7msGMdvcjd4HztMKV6r/8dRZUTSFCfu4J+/eK7S2V
	 qjYZ5CRpIXq//FBWVjwG0AqE3WhsopkyZHFh1E+/BvRHLXUAHNb/F8I3As8lWJ5k5p
	 0t/OipiXoZqBqrj9aHTeh+imBA1aokVWtQEWftTZFGP+0zHn+AHgiItUXepmm1aNSw
	 bu8DiJ9KAoEiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: Re: [PATCH 6.12.y v2] kbuild: link-vmlinux.sh: improve detection of third pass requirement
Date: Fri, 30 Oct 2026 16:54:06 -0400
Message-ID: <2026-10-30-1-daily-reply-0003-kbuild-kallsyms-third-pass-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030-linux-kallsyms-fix-6-12-v2-1-689a11cb5b7b@linaro.org>
References: <20261030-linux-kallsyms-fix-6-12-v2-1-689a11cb5b7b@linaro.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Update link-vmlinux.sh to not rely on file size of
> .tmp_vmlinux?.kallsyms.o alone but to also consider symbol offsets
> within to resolve this, and do a third pass if required.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
