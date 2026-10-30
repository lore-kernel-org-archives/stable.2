Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350683;
	b=TBkvfRPGD9LnRkqsSN3ldAatMDSHhtRMzOSj2hOlo7QkE/8zg6h4QuOd8D4thWQ6/N2/
	 RshgaNGmtVV/M78nZQW8ynXyC+MKPlrfvELBDVW3iHLf6/sPdKhgNVKl6P2FjGvlXplfA
	 f8YQNrDecBrCoAy44M/1BnFpmKAebb11UN2GhgbchS5mM89dR0ExDmVYpuZYBbs0RxNG/
	 SL6xC4h7eN4NIklth7uG3zF4r/yDyD3aXGnX4XEz+q1k5TJ0/AcloUFaB9I4l3GSJ/HXe
	 rqWWQt0S+ErI6XUxppRXXNo4WjmI5XeLceA5LJTx0zX+8m90KwWjJdnq6agP5IxbXjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350683;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ozF9/5H+ecB+0UlehZ2yh0Si0DSQDpCL5DtZtA/tSm4=;
	b=MxxfF8c60LTD9UUP+w0i81hGzsaUoeFbvEXdF9mQEfjex4QHWXRlmOol0GF6Ky6JE2eB
	 RgfQ9NsLAC18g2OM+BxACgglb2S1rBoHSpaVmDbekUjCtEEd3erwfiHRwxNQCGKn0L/Em
	 xnAdE8E3wrStHeZ4USvqj/IZXRF/OsUXhBXVGoCtP/YXvU+wvzQkW6j1xbZoKtP3aO+D9
	 Ve6vaXTTgStDdfO32C0tgiEEJUx9AmJC8TgMmda9lZNsZlzC4RqAKkrdWnM3WuaWU5vlZ
	 vIy39ReyeY0R4mLzJ0hQ20oS73Srk88tX4FeAYCW9y838l3P8jkRH4u9AzEbkwaNsjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=ro3NaZnP;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0B606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB0B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=ro3NaZnP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793350678;
	bh=ozF9/5H+ecB+0UlehZ2yh0Si0DSQDpCL5DtZtA/tSm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ro3NaZnPQcvQFxALMVrHOJa0DVV5T0Ul5Bd4oF7Wc+QBeGibQZfQaxG2DwRHzwqYZ
	 la6MAWO9i3LxEDaAbyJfsPYctkpbNSYfvmNoRFRxt04bB3PrAYQmHpwlCrVWEFj3p2
	 BLMey5WC9ZuuG8TmzVQdO4C+v6o9bh+t01e1wRT8=
Received: from HAPYCAO-MC1.tencent.com ([61.151.228.147])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E76B24F3; Fri, 30 Oct 2026 16:57:54 +0800
X-QQ-mid: xmsmtpt1793350674tdb2v2rsf
Message-ID: <tencent_6A5598482B26558B29AEBAA9D2EBDAE04505@qq.com>
X-QQ-XMAILINFO: M0msBj/q2J/m8IWtBXjfMlJsKdykaDyR4hK6S95T3OWzPyYwUYijwqapkxDZtc
	 sp3NatzKx24/AES82aaA3/vb7qvlwDY7J1OP4J8Y7q1r7WXZZx46csdLugek73MBDl7+FLHaL6Vm
	 OXtyzAIwEf4KTvH+ALR1Wyd1uf3atABfnuLSHA+gxwUGUjXcX5wX+bgPuKhAtaiHWOCT8OXYQsWy
	 aWpUCixuU5Kg5C7cmCJm+9hyVNyIidR5y3j+QmqL7gx/wtHC2Ph0JqnLkGYjnCCGxbe6rw0xM0yy
	 cADImU6u4BSd9KDDeklLnlBdom/ob8mux/01h2OqV/hypNpwzDq1WyRIyOyS/nwh/Eay/C8Eqq+t
	 TR4jAVwubN2aoIZV8x/Ab8FgcOp66McV0kvZKtCQcRfZ/KmRwPBV1hUMZak0e3SFKKzgrDCfSahs
	 poBj666Y89fl7eBPB8uG3y0svx5T9fp17txefRQ5AlYT+K6aNSZJEgs4O8ZxL8womaOl7MLd4b6E
	 tgRkABVm2ByskLEOCGnF9N+sK7FoC0Wd+tGq50ks4RjXugBPRpZjqzgws09IhUtBq0zNy3SDdYKs
	 YBc+0oyu78MOgGnxgum3kKkH5a9IrFoDhTclAR7raBOP4SJBGBn4I5jq+G1pmZPNgtTcbpCh7L4d
	 CCmmcujOr20xzSzsN1RCYfniQktgN8J9vy2ir9121yKU0riW4ZhLon7GoI5xs3yGCMa1y2ePEpZj
	 BAZ2xdQiurDE4aREgvzSqxtcYp8AwsZ4XAO0c6CFvUJdyTrx5nsQXIo8v7zZ5GqktpJX+F8MokeX
	 5C6/OXYeaQETdb0gqLJixYogDVi/L5k0LMfuGqSyR8K9NK1LMGqSxnKsTmKCdREkDeP1x0YxoW3o
	 8yFFXVF8xi9an1nW/i1lKolQQQ5QXEAuPDtqPPkQWcowGS9DvY+RVuVYGWbiOpjcRksGwfRbek7E
	 J7sW4i2oWbyOvSwWirkfNXsMJlG8grzSMiCvWD05fJRFxbqpcDhqjlI9Uoohy5n+YsHvdldNaecn
	 vKDIthBRW9NryXNIS7OSCpYjF9AFf3AcQajf3faweeCGAb2QGYkslPj0GERgZERclYgX3+BbD/5O
	 H3tlOIx03crLMUwR4ahSRVAgfIWrFbIIS0X1AhzBdjHDATbr026ZbP07643Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: bo cao <treebacker@foxmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: fix dead half of the MTU guard in __ip6_append_data()
Date: Fri, 30 Oct 2026 16:57:54 +0800
X-OQ-MSGID: <20261030085754.83762-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179335042941.3327.2302494904520671268@kernel.org>
References: <179335042941.3327.2302494904520671268@kernel.org>
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

The issue was found during an LLM-assisted source audit of the IPv6
fragmentation path (manual code inspection with an LLM's help, not a
production hit or a syzbot report).

It was then verified at runtime with a standalone reproducer: a
single sendmsg() on a raw IPv6 socket with a 1240-byte HOPOPTS cmsg
and IPV6_MTU set to fragheaderlen + 1 triggers the skb_over_panic()
described in the commit message (tested on 6.x, MSG_MORE on a device
without NETIF_F_SG).  The xfrm transport-mode variant from the v2
discussion was identified the same way, by inspection of the
ip6_append_data_mtu() recompute path.

bo cao

