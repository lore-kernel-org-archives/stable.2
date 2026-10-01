Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A31F5834;
	Thu,  1 Oct 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862754; cv=none; b=Ubq4UzJ6swkHOP7Ps3o0iX9nV9uvQj8dLP4QBqklaR31eexKTNERqJD41nVLN5BX4hVeYCqYRypycRTktsERKIIuZ23VstyW3lM6FCqAdCuf+iCCGjAJe4Gizg9xDNiMY8deDNHdtu5S3j6IsRbY2LrL+MfPF2wQfIOIIXUmYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862754; c=relaxed/simple;
	bh=yIaNlNBGzWvJ5PtDUGRvNY4b7o6HXC2jp4fhCE/GW9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9KRTfyvqpl8lpIIOX1jFfEtHi8AY8Dd8largk0d0Lj3FG1dexfhBGwSSsN3FpV+y5Lr0eJy0Ky5d5bqnzsHiX04J8WhnPDhwDs2PlKnuzfIJ0+5h2/DArV5j3y5/wu4vwQv20w9ccr+KcH9PvSIUuijWwgZb8+lbj/JGxMD7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iABlSZhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iABlSZhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E09F1F00898;
	Thu,  1 Oct 2026 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862750;
	bh=bJ6pzqwnP/x0B8410DfPeDEfJ+In8pWi8wc1pZgSKvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iABlSZhWeBQzqpmv8TN/P61XOq2a4YLHa5mwfEsZbhh5sJFAS1AMTvR/OJKrOZYKB
	 egdv2Bw6WZyVOyjrzwq9+jo9Z1drve3PLGriNf7zGDGP0BZTpBuUZrMR4XOgP7FPYt
	 IKtM1Pbe/d5ayoGVoWPT0bb1VIoOp2rzX1PucE2r6e0XUzb1Km9WsevASnsgYhPDRN
	 BmWtTfCkxW12XXtpkbzsFfS6ja201xb8w1IHI8x5oqWPJD7zCzdEr+hNF60k9FzxnI
	 s3Ml7cXVHobN/vkBrTEX8WtzEOyTnJwNpTTS2NXliQy6YgY7ibi0uzNnIHJ4MkgkD2
	 e/55t7dWnuh2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Arinzon <darinzon@amazon.com>,
	Shahar Itzko <itzko@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH 6.6.y] net: ena: Add validation for completion descriptors consistency
Date: Thu,  1 Oct 2026 09:52:08 -0400
Message-ID: <2026-09-30-1-daily-reply-0004-ena-completion-descriptors-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930024101.96014-1-artem@trailofbits.com>
References: <20260930024101.96014-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-40999. It detects inconsistent ENA completion
> descriptors and resets instead of consuming them.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
