Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700624;
	b=ONIaHsb3wdKU0EkJl1eVvFi6CWzQESfTZ8kvD5y90+3L1HN06JU5JaEgq0PPvEGfcSci
	 6ZQ6EPPBk17F1v98r/xSZihz5BdZFU728e11Vjp0udtNzwCntvrkPXPw1KPkuY3k67Iwk
	 tUXtjhDVHr2BLRKs37L7y4b7imbgGgcYqbm8aauYEwZRV35Gzs9Z7MYHoE6Wf93BR4ijV
	 IATmofayOjqUNSP0XBYTEWgNFSl3jx9ek9q0X/K9zsPyBVuu4qZWWODlD3lRcrYjPdXGB
	 s08mT8laBAR3pyizfeO3k4yDNqj1/kgOJiS0GGJYwmIrfJqqu75CVYdHcWn3vuYsFrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=Se9VnSLz074iSAXFSEvDfGm8BxpK3eBBy0PQtSOd2g33tWi98ckykkhgrJ3UoIHLUdxv
	 O8gKdkCBCC8dmWDC9tECm/V6HLdp0DUmtvTBaWX7cjY2yIz9BkdGnaxRgtmZSuudcB+DO
	 XDpn3kjE29jI/3LJEizvBRLJNUZ5aqY1R+XFtKyL7NJn84yAlOutizLWYUiRgLJsjCukP
	 5iuDuJNLJqDuJP1MnRNmq4tKS2BpMd5JDjKhOj3cUxOyTnDk3bwvRVTw/8Z1COzjMhMGe
	 e3Vdx5G9JH/8PkkLgnmti+SWJaXUt1o+BCnVXaljoP5LN2T1ELBoOCrZPQ4VT5ns5Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzRXHrX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9C60A3802;
	Tue,  3 Nov 2026 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzRXHrX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55D01F0093A;
	Tue,  3 Nov 2026 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700623;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzRXHrX9ufeaXz0LR2RDzdX8pA+pRgZ06SF3ZyCm7wsOLtwd7fGBh9sueSEAKybaK
	 ThfwjztZr3au5myV8I5TNTudKoypRJ/EpO3qwMhIqsqEj0elRSwkQCsD6h+/dQzItP
	 ZuZyckzgQ20/YbM5I/Aw/ULOel8Xa2nGwPXmEcdNF3jjFC9gGHJCIfqmutJLBReoY1
	 OqgGh9Vo6TwISjHk3R/Y6IUF0Rhk8dnBdZeIWtH45papu9kMjojzufMPzcQumoffK1
	 /CTzrGver/lvTQjhaaudOuqnSvESdbyjE0ZHnfVgNAB7w5lPo+IQsmN0TF1xw0AD36
	 ivJZzhK9h2sag==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: ixgbevf: drop the SA reference if secpath_set() fails
Date: Tue, 03 Nov 2026 10:10:22 +0000
Message-ID: <179370062239.488859.17760478051473372751@kernel.org>
In-Reply-To: <20261103100534.1310071-1-vulab@iscas.ac.cn>
References: <20261103100534.1310071-1-vulab@iscas.ac.cn>
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
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
