Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092935;
	b=TUJ6lH2zog/2uC6OWTicO8r8xxPC+9NdyeT/Nwk7hJLvPtTf8XEQJBWzdGQbPtxOJJLA
	 n5zY8qjZgw+Y2eexdSbxp5rFhAWRyxl6+3WV/CMzY/jlb+EEeSmKDGLesWg2zCLyD77CD
	 d2tbx2deWQucwI3zN/sqSIl3bewLswHF794eiFPFERjwK1HbPs4jx3OoxFBsxAcsrJniz
	 XpG5Y6FDWXsYmUenJ1GKr6eQJUfNHiETNgi5WKycJEh/h04gkusP7qJEXmyHa5aGBn22U
	 +xL6yla3xkW4aiS/j58WuOvlqYCdcXCtcY7oACNitf5kMKlqDEDJ2XU8F04EZXfNMMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092935;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5wbVVmWcm5uyGXGomrFfyWmbiAFVDweHi8XdGjAXgF4=;
	b=sdzDYDbiKKMojTj9sFl1Pke84bKWAXJE11yKryqNCMbCEuzoBYnEWjbPgKlN+437LP8y
	 /U20m/Hp7DSq7KaWctzlcmniqOi6T3ucsWXe4IMQ/zk7TIT0dhaxE32Dak+Z0b4+AVkPn
	 fa7vYMxNgGGGIkyteDQsD5AwcuiZvHSfoBsyPfKkY99o6lnIRMz4e+9XJE3WI2GotR2N2
	 R4uiWDzDTX2gR3Wk2+FlxKAiK6jtEPHr/CBcmkhAUcRQ6t6i4nyzfqmCCzRCZrKVbnBYq
	 /7o5smVPDPwtA7zRUdbgdl1gAqKGH2dgfyfjmddgo7H0uv7KIHNJX5v83BrSiqkr+Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ez5tb28q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC45606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ez5tb28q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D6B1F031E5
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092935;
	bh=5wbVVmWcm5uyGXGomrFfyWmbiAFVDweHi8XdGjAXgF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ez5tb28q5dvJNGVK4Rjxx+DLwqUUtIqvY9etVQnsj3zVLBx8xjHSyx8zkcoXK8J3W
	 1ZkKGkQYz+WENAn58OGZerReIUtQZFJO9HyET7kB9bFKZPrTiPJa3Xt9YfqyYk0EI9
	 Iek9HflGqeEeKPlrxdMMjqdfbnGKXlqz0rePQjtJYgoQEJbPSZD+SX2gRX0suGSRAC
	 xPpvFVNbO2Gcx881PWurkgxDMRZX/9G2+kFCNPfTbby3OJqK6loSZUYYHC2WfpbTf6
	 V3jBtumX7mKJtsFC+2yLRoQdBHY3ykcgoSKnSslEoMjUPCGTx2Dq4BCFljkchPRT42
	 S+g7L6XNTgunQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a49a022221so27386631fa.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:22:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwO+zRk5RA2slpExeME6a+ckb4mBjo2C2tzYlvq+A/D/O7l7EnmIlrVZO5HQknCuGb9cgga1go=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4U+EvISdDSMJTrhqqs/2INRj7lM47jDqNhBE4kIS5VcM+8sC5
	2nK2BaXZla5MTZOA/yJyaYUMj/TVSvolGK9+qIfUlhaUbeNQ43iL/DHHnCGp9zTCajJsnXPau0H
	0DFJSBP/x3knHxwDrNfriUjC0PNxQ0Ys=
X-Received: by 2002:a05:651c:1445:b0:3ab:4c60:897c with SMTP id
 38308e7fff4ca-3ac6fd59c08mr21629081fa.27.1793092933744; Tue, 27 Oct 2026
 02:22:13 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021235732.1313305-2-kj2864@nyu.edu>
In-Reply-To: <20261021235732.1313305-2-kj2864@nyu.edu>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 10:22:00 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq0Ti5kAr4sRsG+XV6XJDMJkhk0eMaQW7n_AZAbghDOYA@mail.gmail.com>
X-Gm-Features: AclHuK8APDmMNo0ydcpfXRwiZ53y6y4WHS1Nwl34pF8p4sVxWR75dI3yGh_H4Dg
Message-ID: <CAL4Wiiq0Ti5kAr4sRsG+XV6XJDMJkhk0eMaQW7n_AZAbghDOYA@mail.gmail.com>
Subject: Re: [PATCH net v6] net: ipv4: add zero check for snd_cwnd_clamp
To: Kaho Jiang <kj2864@nyu.edu>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 01:58, Kaho Jiang <kj2864@nyu.edu> a =C3=A9crit=
 :
>
> When RTAX_CWND is locked, user is able to pass 0 into it.
> This could lead to writing 0 to tp->snd_cwnd, leading to a
> division by zero error.
>
>

>
> Fix by checking if user pass in zero as parameter and if lock is present.
>
> Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch ACK=
s")
> Cc: stable@vger.kernel.org
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Reported-by: co+71b6509cb791e531@bugs.sh
> Assisted-by: LLM
> Signed-off-by: Kaho Jiang <kj2864@nyu.edu>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
