Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443374;
	b=ZOaHtjpGaeZpHKB5zeipxirPRCkFXp5BWteCxSTwmycm8wSRi6O4SjKJuUm+shyRqt3S
	 MkD6X6qDYZigGQkA9MCw/otChr2XKnEHU0qnbCDO4Vtj0sf+XzET6N40Ck4nHN7QCMXZQ
	 yzFifU8DfZy/Zwdv8Xt938Ddw8lZZvN/lhQDK7v4lkOs58QMKt9R3quj/+QkQQGQ5VSoq
	 3thtnqqjgjThpDIFslCiEv2dTLyWxGz+chO9xR4SOT2Q7VykudhE6lrmQHHQJGtIRJBNU
	 kRcA97qASmT29p5GCnKcNoteIW4t9MEkMPe7kZxIzSKfoP8qFimI/5JgyTYxU7Lcc2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443374;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=znBIZGIXZeGQsNPvrP7/8Hm1xcb2irITG4wHBpHL2qU=;
	b=ybIHDwnoeYu3pBe5ulemZSrab1TqCJ+IGHyhtpgZs5jM+apzApqoxdEY9TKsdBRja5+b
	 4JhTOXDrkP4uWcdKEUFyvJN3s6SE2Net5FBCGduZ2BdwgYkGE/ZpM4L3F30wNmVy8+uCp
	 +3nufs1EsCbEfXvsGg5j8oQtK5fo6nq2tGhE8aK6eqWBiXC9ITGm6U5K7gYHMC0wG0a1x
	 nUIwpFN34qdaoI3gAvkbjc+IDvmLQDUnKxpDNP/HnZAQLmi/Wzc6171IjMuFbiNNrAuLn
	 SQ+95bi5XzVWomqpjj4ZKcyhJUjjF7K3On9H942DrXGJkcmyvDP0FBXyF7x1PpWnPzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ2j8bt2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB62606A31E
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ2j8bt2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8441F000C6;
	Mon, 19 Oct 2026 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443373;
	bh=znBIZGIXZeGQsNPvrP7/8Hm1xcb2irITG4wHBpHL2qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kQ2j8bt21vnaQa2MRD+HDvUH521igfI1v3/Gjvl1CYi1SPkYuVZMrW37i6xeUupsA
	 MFgF/xXmTY2d1187DwMYIP4eavq/IYY2N9dUWG5wCyoMYRGyycqW8qrtxrZwhACgdO
	 tgv+0QhcXRFlmQGmgcu1hAaQDBpCpmIigGThtvgHgTdrLdejeJqol+lt6bEJ12VdJx
	 pWjv52wy3PDcE44L0lG/caiKnZRPJBZre3kU6PaCzrOHjf1cosZ+eFG1q8tn1cH8iu
	 VTwM6XJHsr080riYeuAanWCOCLPidQA/yTrB/N1EuIFw0C9Gx/SBzGWL9TDaJ/WDj8
	 YkeuubsDylARg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.linux.dev,
	Zhang Kunbo <absoler@qq.com>
Subject: Re: [PATCH] arm64/cpufeature: Fix malformed SME I8I32 hwcap entry
Date: Mon, 19 Oct 2026 16:55:46 -0400
Message-ID: <2026-10-19-1-daily-reply-0021-arm64-sme-hwcap-held-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_7F47B27F7FE811035796A0AFC61993769409@qq.com>
References: <tencent_7F47B27F7FE811035796A0AFC61993769409@qq.com>
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

> During the backport of a75ad2fc76a2 ("arm64: Filter out SME hwcaps when
> FEAT_SME isn't implemented") to v6.6, the I8I32 hwcap entry was mangled
> into:

This is a stable-only fix for 6.6 with no upstream commit, and it has no
Acked-by or Reviewed-by from an arm64 maintainer or reviewer, so I am holding
it until one of them has looked at it.

-- 
Thanks,
Sasha
