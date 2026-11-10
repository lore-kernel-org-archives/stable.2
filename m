Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344384;
	b=joB/0N0orzMw3YYKEktlabsVX4AI2++7jnIVYNrbZU6XPsyhE3sJLTNgBwpwZbPzm2Mi
	 ne/bWIumXij9bg6bnzBeUKs4B25G54026I+rrjsyktG6gbYroGNm9kxSjIDaBXPQFsuDV
	 P6r+caFho6xucjBVur/mgDWvSqX5vV2d7PRUt4jMmYtyVFVn8JDVx4NoIOLhzOdc8vebH
	 3kEo4NphZQtQ/RcsRVKGxSeyx2bkQNIJ+B9Ad4NbsTO1Fuaa7tar7u2PCLJewdsT8l05K
	 kIczWd4XdNHCZC53Ux11skxdkzZMFb5ZTCGtAmU1YrLzVMpCA5Wksne/BHAd2OaxDmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nvnj33XjuZfq25lQMHb6sViLFzw8bJbeA5Ji/iMWa5Y=;
	b=h/XR9aVkbDraaUdFXGIa76BUAyjZAnd5VjlYplLeJHfMnyceHKsxqVqZsIy7KKXXsNv4
	 DfZ/CjIpJMWC//A5IskUmP0O4KVu94UHltHGU4Fzr8yUbNrobUxskeMN5YzVvCPj+hHTI
	 XOCnTPx1faNCcKePs5QIcht5PcryvB+W9BznpUcvlMRLqLt5YyUGQN09LJLZ4t3TEMWY5
	 W89KrnPVSQEqDTw2h3O+q6T4FuGpJlvXBS9BAlKwH/cUTNBCUS49JvhDER8kXp9O4cIoX
	 Cv/wX6owgeRW0Vb6jK4frtXXT/7OtNkqjdxOjwsuOoddoD+whrl75gjzGoE7h7DN5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJBqT9pe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07CA606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJBqT9pe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9631F008A1;
	Tue, 10 Nov 2026 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344383;
	bh=Nvnj33XjuZfq25lQMHb6sViLFzw8bJbeA5Ji/iMWa5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJBqT9peX5nljdAGj28I2sYeCpqE9NURrccLa5la6u8u/X1JUFLt12dPBPb5IPM5H
	 nQ3lOnTUDaO04hdxRjaEDJEEiOBprU8MrrnbiRgUUZNmVFF1otuULNO1sw+bNheFeK
	 HXN54j1LQATSUvPN447u6QamoTQj5sS68nCf63Of3YuTlqD+7MFCbenY34mxD+2q0l
	 FaAOQj/EW58BwcLDlOYZKoStZsYcASLmFk7dzrmGj+CY0PxH5hem31tCEijWzB0P8X
	 XuG4IZlkWeVxLJL7+IsNXoJyduXU3RB52vsIu7gmSvP/ZKcVXCQdayIrjPvbm/HTFf
	 wCfSB/uBF73Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 6.12.y 1/2] arm64: sdei: Run the event handler on the kernel vectors
Date: Tue, 10 Nov 2026 15:59:06 -0500
Message-ID: <2026-11-10-1-daily-reply-0010-arm64-sdei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110120845.373988-9-kas@kernel.org>
References: <20261110120845.373988-9-kas@kernel.org>
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

> arm64: sdei: Run the event handler on the kernel vectors

Queued the series for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
