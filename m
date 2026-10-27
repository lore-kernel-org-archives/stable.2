Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069489;
	b=nQZlQK9pNXYU9Js/nZv088nUjaf9m2uC/DttPeO+tk5Zk2iqYCtvgu3P1v87huk+EBZE
	 xeU43NrnCzZpFQDnkqyWftSfA06d7KKd3BGSdA8Kpl22Rmfd78Dsf2BZ9uMgxMbGxyW+T
	 ionAB+NqpuxZvIj5Ou9HiTEj1K4jc1h7ObZNSmH6ueura6i/2lk1xTTCQGuo6ykULhkJ7
	 PrEn4wr5B0ARQA6I6f6ZrYxMbgHXVD4PjWqzQVwI0Z/N4CpvVXMo0LTwvFv5vRkgRyH9j
	 vEHF8xBEJNDgeriOj4yKV08ora9Fwt1ks9DL5i7F364RKVSG2c3WBuJSQ3sqifyQwBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=TsiPBSIHxRve2GKXyABphoEtx1lrgoFJQJW+K54DVmdk3Yg6aqitb6EPtHSWZ2XuKcy4
	 GhGTjA+wdPSDPY78uExtwJRzYqZpuE0tUgAoiJXEnEpXBycfTV93h+Ub6Un5RwD17EE5X
	 MqD0RJXginDEISWux6Mam8VbkHqX+2Znhn8M9yk7PAu/z80Ym8H1jI1XCEBXbuOgGYqvJ
	 Y8wMXY6UfYuXs1S5NwO3AAQgdDJTl7X0Kjzmw+kxS2hlfEX5yE11DQNcc0hvvJ6Vdk1Qy
	 dn2UZXyRqtDdfUBMCvwZGb7XfSjmpbAQmBy1921Gx2jjVgU6GDk2g/QxPHG6RQSUR0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iq/5aN/W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA88606A31A;
	Tue, 27 Oct 2026 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iq/5aN/W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6631B1F031E2;
	Tue, 27 Oct 2026 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793069488;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iq/5aN/W890zA8ye7A3ApvvB/D5tmql6sS6e/9JERxWBcGY2kCNfr7hrVA4T14VR9
	 r5AQXu7it/ym81pKK4K/4W50EIKFdCqz5zEhC3cVuSLCy6jvPKw+ocFC3VscQvFFn0
	 LZjFtVC067V9WAQXcLc9PIwFlv8ehiLdrYJ+JWth8cWFuFXZoADX50/hUzIx7MGrom
	 dwhMYCUUXLlxjBvXemVNyxMi8iLPSuTFnz+jVoXUhp0nffK4oRJZDfoUo8GHOaBNip
	 IH1b7Ckq3YEscER/J48byfM+sKbEbWkl7RanoxnBW+B2qZBXgTKjV9LeF5VvyK71ki
	 xslSgPemE0ABA==
From: netdev-bot+sinfo@kernel.org
To: Prasad Koya <prasad@arista.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] macvlan: fix allmulti reference counting in passthru mode
Date: Tue, 27 Oct 2026 02:51:27 +0000
Message-ID: <179306948792.3327.2977782192715102568@kernel.org>
In-Reply-To: <20261027024635.366900-1-prasad@arista.com>
References: <20261027024635.366900-1-prasad@arista.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
