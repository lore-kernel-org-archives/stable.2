Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274870;
	b=w9+QU/umrU8TSsvf8HQzWJWScj+ewdmHDaY7Cut0mYVwWkYJN1R0+2hCtTO4u7v1gzsK
	 GlIsvFEtnkfIbiGMQpfzgySX0twtHl38iLVBR74reEPB2hFhi/flyriJn7M3aXrkP13mY
	 y9ulWjeBNmrqgzcaV2zevEEefcBHpxoddSgWwmM+c6yxcmkmK/MRqjS9uejUIsv8A4vxr
	 TDflb2BSiQpubCRe8bZaILrqwv3X8cbIazBStjmdml4zWc8uuM95XvE/In6JQjhNebRAy
	 B3BQERM6SCU/JVUqZDyjnJL7/K6PwdvuqjRcqsWa+pQ/WypUpn54VKk509u8Snn0TvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=71/h6Nc2Yz90Qu/VqGJi1BKctHrPxF4JtV6UsEPjLtA=;
	b=nzQiVz55Wsm/wIMZKoNTAYn4LKrYAoCB7G38RY8deThtR87083RPdTgJbpnKGP/ZSjV9
	 05YrIOQOQlxc5hKrbOiczzLDq36GJqpkzgO+BuOv2y9zI1wHoPUY7mfpWwOywKZcl8Buv
	 rjTDxfMYhPUcKftG4u4Eb+hBWIYCBf6lISOe+Rush+GqzKm8XuJdtRv3BdIYsBJ9+/2Kz
	 kHUewwH5MMnkq5E5mTCFbonDkaKwhdtUTJzeHUjeI5i4E/v3ETjvhEZAHqMkyqzsGIQ/o
	 g+5oxS1w08+WhRrJy0qN1FSGkY083seBGTy9oSMqngxINkf0cdefncpVSz0D88jwKMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEKWoLMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5B606A32C;
	Sat, 21 Nov 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEKWoLMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BEF1F000C4;
	Sat, 21 Nov 2026 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274869;
	bh=71/h6Nc2Yz90Qu/VqGJi1BKctHrPxF4JtV6UsEPjLtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XEKWoLMG7+NW+lu/wuwueI2RGzwvIYjYZW62ANY4uTrm1EikiC5Y5QEvN65aXC/BD
	 NRHEpeyeaaFETKoszc/msxAji6sCTiBezj7dkJkpIhfds0wchzIGxs6rRyn0LiDPtb
	 39hqKmS34YolX6VUyFZHdjnhewveOOS7Df87oeQ0DbTyb0jJm11QYxxn8fI3TgMRKA
	 qpKV7/Q/9aWHflL9BENGlA/0AAXKHUO4EnTbYwIQ51WeOWgFNwWHj2NBokkRZDRcWY
	 540stOqNF/eeRkTLqYjJqfdcoZgSoHDgHvv7wpEZ64SCS+p7AMvaVUhpUztb7ZGnhQ
	 MYh9IzOTqUDpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolai Kalinin <nikolai@kalinidze.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vladimir Petrzhikovskii <vladimir@dfb.sh>
Subject: Re: [PATCH 6.18.y] virtio_net: check RX buffer length before DMA sync
Date: Sat, 21 Nov 2026 10:27:30 -0500
Message-ID: <2026-11-21-1-daily-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120143953.1560229-1-vladimir@dfb.sh>
References: <20261120143953.1560229-1-vladimir@dfb.sh>
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

> [ Upstream commit 29dfa436bc488056a84ee423ba82336db453e2a6 ]

Queued for 7.3, 6.18 and 6.6, thanks.

-- 
Thanks,
Sasha
