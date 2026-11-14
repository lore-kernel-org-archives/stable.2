Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678154;
	b=GUiLBsqu838cSOG1CMpkqllf2ABs35uz8YwPV8QvLcPYRkr8KlfX2dD1rWU+5xbEIEta
	 ryUHjw+NrQjoRvUkv+mpnqrpP80ZJCdMw23A+f4js4U/08MFYkakOmsArYcL8MULtpEXl
	 OrxpS/zp5S2o1TDYBnb6/4flAQWxYuNYGrQOVtq9U3c5Uxw8Gli3N8enpgzQ2aO+a6MgV
	 Tw5pNHpOQGOY8+ZAnQbIWcIG3m9YYsdGtUYW+LlemNupyYrac3olxIBHyE0Y8c5yFczO8
	 bkZtb4LgqIuOdf0RKXRfy12F6Jv1OnDJUB5cYI9Dg3igNO6x7GbGZXgCRVcvVX1lOOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678154;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dsc9Dt9nDbKnfIvLGlOdAfobnhDRFBDoL6WDxQlIAzE=;
	b=ZQFzsrhZdClr1qh7IVZaK+pPYqgWLSX2piCDcX1cNexOWruf4SXwcKm0DtbxoLWf3sYE
	 /bR5uZpuP5Ub6vh0eO8yu3Y2BJB3i11Ks7g7Nd6rLqpcS5FdlqG51VBs1NKHgRgATCQpg
	 mU6NHPVix8kJ9p/vBjTtLV7ZhfwGHGSWVy55F2eqzkfWMjnEUv5NVyUmFpX36xJM8yJ9P
	 6G1K+wkI6YS8mW6N+ohGmj3xzweRzwPpjW09ZrJo45BIcNY157LGV8j6AuU2NRUJcGkOO
	 fTJOSu5KrL/fLPa6ADvMzoYaYBXpPbPFNH/vAZXLIojhfYk7XFETc0C1IEAZiAWK/EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBibe3XD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAD606A330;
	Sat, 14 Nov 2026 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBibe3XD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F0F1F000C8;
	Sat, 14 Nov 2026 17:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678154;
	bh=Dsc9Dt9nDbKnfIvLGlOdAfobnhDRFBDoL6WDxQlIAzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBibe3XDijygT2lWmdGnZ7ixuZjJp1LRUgvykdd8sZhg7gAcmxQxBG4rDKepzEM+b
	 dG8An5DlZqzy7OSDJGSzHm2sdJvoLe93TFOTaVTxPcYlCE13Xw2YsljPPxfpq8EKHG
	 XV+euHw16voO7iSc87ivg8xRYcczkOPQi1w35VSyWOMM9LlDtwRyd7TnJkkBayQ9DJ
	 oeVxrDF1rrv2luZOjiT1oXga+QVGBn7LJp6Jmm+z73rYe7drSWnO9GjjydjUmSwNh4
	 T45rWHeoPzgGbszxND/cxCnlWQyHu/MP5BHets+ueQOyRrlAlgVrX/dv0ZzLmmmV3/
	 xsBSSgQb+axPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	kernel-team@cloudflare.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Daniel Machon <daniel.machon@microchip.com>,
	Chris J Arges <carges@cloudflare.com>
Subject: Re: [PATCH 6.18.y] net: Use a dedicated flag to track disabled napi instances
Date: Sat, 14 Nov 2026 12:42:18 -0500
Message-ID: <draft-agent5-0007-re-napi-disabled-flag-618@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113-napi-disabled-backport-6-18-v1-1-8081f2887b69@cloudflare.com>
References: <20261113-napi-disabled-backport-6-18-v1-1-8081f2887b69@cloudflare.com>
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

On 2026-11-13, Chris J Arges <carges@cloudflare.com> wrote:
> commit 8dc87fc5d6a0eb337744737008177342a708bf36
> ("net: Use a dedicated flag to track disabled napi instances") upstream.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
