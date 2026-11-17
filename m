Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088845;
	b=3hDlnOcX7P7NWK5tGJIDGnNyE0X88e+Rl3aLopevqz4kOO22k5RXvka7RUGNXx3q7yGi
	 WsTIZCCtyO+AO3Lg11LmMJq4mQuSb+122QQqh06NU4XKXM83CEA9i0R1OwJ0iIf/sslll
	 V4wE36bkUnfniqoC0M5JSn+fSDhkHA7n+3u0aFwZSqT5i/LmqWs6IZ7+QpgRrUdeSStCF
	 bO64VVOkRfdu9elFUjJWpG5tapjbjLha0JkC04NqUKTOPfwJHrkfZnML5df0/diO9wR8c
	 z8HzfACarrhpRdjjoTv4bbcRYLVv/Aml/KBvaFdkqNAlcNMw4aRiN7rTNETBhXj1CTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088845;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SeNYMReLqI/57UF7oSO4tN9QhH9Hwq3LLM37FsnO+Eg=;
	b=fIpScsasflNWppd8iNvCwHL43zMkw7PRK/bnpfRYU/MzoAXur/pZBYuUDVXQoc0BR0ui
	 yOOzE4j26bDDhtS0ciCTjUm++zRlj6oPFscIoEwVY9WdBgkGAB0g/3mNS35gHBR5F4k9I
	 cw34rTwKHCg3jN3LUP5P6tE68eAgOHs36znR/lsZH08cYPBDfEWGWUP5JI9zcrn08Rt84
	 YtVk0OayXSJegoJTlzEwkC4HX1ddorkfYlbasnAbJctB59gKz5tQjfmaM7dNpnoLEQE3m
	 sFOyiqo55ROZuMsCd1s1mi1b+lgswccdb+e/kmoycnIySJI8jkk76TrBh99uezl7C6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=hiAUIZgr;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A060A263F;
	Thu, 19 Nov 2026 11:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2A060A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=hiAUIZgr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795088843; bh=C5XJOvgmV0pmxDRwCafPA7PJDVzAgiAmPLNSKjOJ/wQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hiAUIZgrm0XyUuYgV6mqmIOdeFpgyP9o7o9VgZXZEHhf4QX//pwlW/T1MSNpVaX58
	 FtI+Ho183w/7NrJmB9OX6eV2zn02xyGE6lZ5RfzMctD7utA2wkZKHH4mGRecsVvR7K
	 QTzDKfagmj6AONArz/YfvQ5IadOxXsUo0QBzne6oJrRL7XFr3RSmOa7/Pp+c6urrsd
	 /PrlGtVNivbMKbGzzUdwt17JZLVk0ZWbWYYUXRLl/bHQj8zjLorVFg/8CRv2LBuT1O
	 zLYhYbqa9GipJsDqG7w1VpOGKAZ6PUTqLGjMeOMeNCKak/rAOLK5vnth2DmB0Zh07m
	 aLEoKcMbGOLvQ==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: =?utf-8?q?Miko=C5=82aj_Pisula?= <mikolaj@pisu.la>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261117103918.33701-1-mikolaj@pisu.la>
References: <20261117103918.33701-1-mikolaj@pisu.la>
Subject: Re: [PATCH v2] wifi: ath9k_htc: fix use-after-free of tx cleanup
 timer after failed start
Message-Id: <179492024982.208602.1289096293879697421.b4-ty@b4>
Date: Tue, 17 Nov 2026 13:57:29 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 10:43:45 +0000, Mikołaj Pisula wrote:
> wifi: ath9k_htc: fix use-after-free of tx cleanup timer after failed start

Applied to toke/ath9k-pending.git (main), thanks!

[1/1] wifi: ath9k_htc: fix use-after-free of tx cleanup timer after failed start
      https://git.kernel.org/toke/ath9k-pending/c/176a947f3d98

-Toke

