Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454219;
	b=29TWN4T3pplgl4yMeE4K/x1OjfdbfXzRSXonc4AdrugzOXAa/XBEaWLYpSGur570Viyu
	 FFf3sxinOyr81bdit1LfxkYxAT4TckRMS15ZV5ITctazLyTCia/CDAIOLk8rbPhS8e3sU
	 zn25696iAS97E6IA03rb5dPPw0Vz+UoMj9rLFQ/wv8LOjuTVu4D9Cn52rYqVikTS4/p3y
	 AHAhPbTcmKVqlrjsmvw5nHV8bt6paIq7o/uOXG4hQ1YmBK8gCSmTnME7MeeHbaczYGt8e
	 rCqoTbWcUyUUVPzib531u1ikDeL20VE02X4lHibV7+Hs2jv3/tXrOYFGNPhE9DBxXFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454219;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=tRUaqlDh2OV3BR7rgMRDAIOLKymAWsk3E7UWBSc39L4ve3vsHyiZXilDzPlJRamveOUz
	 9HkVA4wLecMXXqfsKKMG5QzQdyEK7wxKJYpl63GkWbkDOg81wmqtcJjYD8HylvLtCYRA+
	 Ar5R4Qfv6hHHJ5lJi6x+dvqNXZoZBXdBGxQaZlrK4vSy/MoVs2LjKGxodPuHUji0ob2Jg
	 AfbAgU9Gxqo3JvXXG6vPbeT65B1xCsE9RKhMEPagSkNyz9yBkW7vEhRaC0ZcJxl/uAvHa
	 N9PCVtaRNiZvUJjocsjrcXe9I+kyd5ekFQvh62UJXv2AZdkPAxhaoMUqpFwCY2J1SYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHNFVvLl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39E60A2617;
	Mon, 23 Nov 2026 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHNFVvLl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D91F000C6;
	Mon, 23 Nov 2026 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454219;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHNFVvLlLyiTkqH1GZFsTD3AgGpFJWtMmMK2njvCIp4abaC8s7+IH13Ln35I6oD2m
	 w/RKQscrKgbLRFhdRDJ2yEmzRwWKOcAUJ9C40YRQCwQ871VAq2nQjz7b5b577FC58R
	 QEvU3ofPteXd9Saj5Av3wiWtibf6LJo0g1aZIEzulr14OZT+jH198oxSDPAjckoOyG
	 4yXPDIg2tsKBRDohouMuVp9jUrGenpABuCWX8QB3jTB9WV2CsCuZLxsnS1TcQzcrBK
	 ho8W0XBEHp2cfcnG6FBXPVOJEW09NPjNe6avTXVIoyJfmURRowyJ2Fc8FgdVxFoORx
	 f4PFhyGyJfScg==
From: netdev-bot+sinfo@kernel.org
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 netdev@vger.kernel.org, Liu Haijun <haijun.liu@mediatek.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Lin Qiaojie <linqj@xiaopeng.com>
Subject: 
 Re: [PATCH net v2] net: wwan: t7xx: validate PIT data before building RX skb
Date: Mon, 23 Nov 2026 17:16:57 +0000
Message-ID: <179545421789.3294.8652562780118952990@kernel.org>
In-Reply-To: <20261123171519.33975-1-fangxy@xiaopeng.com>
References: <20261123171519.33975-1-fangxy@xiaopeng.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
