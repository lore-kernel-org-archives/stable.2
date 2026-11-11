Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434115;
	b=jJy5nKQ1bcFDPPrT3c55Gs0ZE1wl6zHYOxgx06FgEu3C41qZ2nMWwbovvWSq/n1erKvU
	 FeEy14P8L+hxjZKXIFv/ycReMfhKY5l/Oq55nVwviox+G3wCPv3cAKneWc6mVSB/4fPKt
	 TI6KejNc8P0v9EDVrDRDcgxgo5QfWcivvdjxShst362vr7266PpcxwPXLzYeNL9QCmdN1
	 6vz/2gnhSQO/gIJcPeLh9LFmuvipgr99jq0cLAn8+F0KDwHamynfJDfVQ1lSWwT4170vN
	 Zi7zbUmCThW4V1CrtzDDjxAJvDILWzvqm86j0lpSHbUuR736aygpxtf2fIBp9xtz4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434115;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y5W/AsRYEx8LDI7pZnpvQ/4Yb2+txMaQ/IsBfBj7YzI=;
	b=FdNVyyJGp8/NiutVSwzsgJXjsVzqTiCea7ML+dE5RMOl+h2bRL0xqSGOw91pErEAK9QT
	 3kOA0/7vR7WqVsQIjJdgl8NYtoiAaYPQLPMyujoeRA/Urw/y41pPIw77igL9X6DUS5TPT
	 5tkddytuhUCbzDx72nroL3EzG5QyqRGDJsLfYelIALGuMOzsNdPFKN/ZEwqe8Z1t999eU
	 zJWAeGQsM232tDONwO0j2qcwaWnD/9kJsdDdm9pfQ0ZND7wdYLizqx4tS6OGmJwadxQ/R
	 r208HFlSAb+4GuFeSFDq+lnnPbbxHtxHsUfOdtW2+rDXN3D9Ks5MrghNK2SUPVrfD5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTmppQbv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9D60A3808
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTmppQbv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F901F00A05;
	Wed, 11 Nov 2026 21:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434114;
	bh=Y5W/AsRYEx8LDI7pZnpvQ/4Yb2+txMaQ/IsBfBj7YzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTmppQbvwNQjf+xoxLQ6IFJom2+H9EjmPBR5GDM0gKQQJ3NtxgA0BPxSz9IgDpinD
	 rH4gFg3lxMwuMMSOPb6ZDF649Z1eBu4/aYASq5oiPJYwBC/Vq1FD/BsAwhntFybp2e
	 SdpJ7usgC1dGF1wxQuqcg+I1n7xF/Yt+RAsMvop4cQgPV3kJJ4AEPhBuikIIoe1f/g
	 BI7+3oLb5++QfTtwsKaRHJw2Wv/XLW92eyabwvv6gqbTTHl3RwtGunVW7nu7qiWHxF
	 +RiYAjABmYCmkK/VTlgxGmDXJUD/OVtpOS95ldYT42sRPnGOVnslt9FHrhSWqybQGv
	 q7eUijeufxVuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: Re: [PATCH 5.15.y 0/2] ALSA: bcd2000: backport the MIDI URB use-after-free fix
Date: Wed, 11 Nov 2026 16:54:50 -0500
Message-ID: <2026-11-11-1-daily-reply-0017-081e9effedab7577b8ca@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111040953.33271-1-25031212351@stu.xidian.edu.cn>
References: <20261111040953.33271-1-25031212351@stu.xidian.edu.cn>
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

> [PATCH 5.15.y 0/2] ALSA: bcd2000: backport the MIDI URB use-after-free fix
Queued the series for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
