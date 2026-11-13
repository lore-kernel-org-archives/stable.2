Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537222;
	b=hLRKp/VGlHNDl1uCI/5xsoCejkBDc+NuVJozHJAtmgcVdiPVmFuSqJnltQFvEqNm/dOe
	 QWZunPUhbpalayKPuFm0olRrZgSWJYtea8Q55CYYyG95L0msG6huExgcOp2oUrW2lwX7S
	 PqUHrIL5ggb7j/sQSuTULphlTbfr3GWBe9p93Ov20XBDoUxMAxoktdTHKmZC4MkWz/o24
	 YiOq0iOOjciJFg02m86q/QKYmLObtGvqORQRZNsj9wXa5xxeM13i04QmhHOph+UvYE7nD
	 N3E5drXN6r3QSvI52b+0xBTqsIN55qxodk5qfxnnwE0TBAdjytKoR/5FyyPNmqD4MYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537222;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6X5QnbyDVBxyazjoaxsxoxAQpPHcQ6RmSftc5tKZOGw=;
	b=WpHNwby5yN/1dN1aLQd/xWfswe1F0NLasPDeb5NM+1+W8b7XuXk6rvguhtePmu6LmSu1
	 VdXJxsaKEYy5JpNVYDThBsLnXeExKM1LJEANqveRPiGZ8tdNvg9CKYVCwumIKyJkpK3Xk
	 cE98+oNV2ItoXnOjeUVzWbKUMWsn3XCU+VY3oGQE1IwmkmWyiWbUrLfCQV5nFDeREf0SN
	 JEJ+8ttyPAS03s06eRGTqZQsiO1rOfpJA9UdksmuabCDnEi7glHvU/KHpnXrW3fM7QpFa
	 Gppk49E6s114poYYShDnl0KvYySsSadzDgW1wqTZmgqm5dyA8nI8/F0YVMPFr9HczhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZjVIV2f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402E606A8B6
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZjVIV2f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFFE1F000C7;
	Fri, 13 Nov 2026 02:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537222;
	bh=6X5QnbyDVBxyazjoaxsxoxAQpPHcQ6RmSftc5tKZOGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZjVIV2fhwH171oiUZQf/YbtOFNy8G4L3SYvnndBgJrl+qbYDNtNe2oM2SSgJOA0S
	 +oaDcfNC8aMD/QbFINjnHP0wgucmZGKExx0EXSnye/xBiKKe8/Im4c0ue5B09dIq0p
	 toMVoxq0LX7SfEzQXl3SGjeKDxSJcn52LuXWQSEjo32FeFAX4WSOlfm9iNCbkzBwhV
	 cBs22cZrkVQBnF45k9jmlKasgz70j9+ndYxkY3zd3aJgjuGpFCwX8Dp2Lo3x2GsMny
	 XS6eOxhxkYTFIIYuLf2FeuP/E347oSEjO0bP4ot+bZu51TqRRqCuG2sj6G/hFIwvar
	 svpjI2yDsboGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>
Subject: Re: [6.18.y] Request: 10a47fb67340 ("tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures")
Date: Thu, 12 Nov 2026 21:33:22 -0500
Message-ID: <daily-reply-2026-11-12-4571868778@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avT46huKpXTv09GB@eagle.home.marco.cx>
References: <avT46huKpXTv09GB@eagle.home.marco.cx>
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

On 2026-11-12, Marco Schirrmeister wrote:
> [6.18.y] Request: 10a47fb67340 ("tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures")
> Hi,
> please backport upstream commit
>   10a47fb67340 ("tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures")

10a47fb67340 ("tools: linux/types.h: Add 128-bit integer types for arm64 UAPI
structures") only adds typedefs for d4bf9e08d412 ("arm64: uapi: Use __u128
instead of __uint128_t in UAPI headers"), which no stable tree has, and nothing
in them uses the new types.

What breaks on 6.18.y without it? If it is the resolve_btfids build against
distro uapi headers, please say so and we can look again.


-- 
Thanks,
Sasha
