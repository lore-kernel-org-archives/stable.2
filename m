Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417356;
	b=13IIEPN76zjl284hzp7FANCGZb5GSahTstybLc4sPZQwDB3NcnRBJJ1Gc5VKp4mvqbIj
	 AuQtn7NodRdmygNhuzFvnzevEiacm4m+ZXSZqtKczQu3TvbDYHPRrROU05YrrtUpGvwV1
	 o7w3CilEFYIioTIzJ69QpIjCDdXzHDSsrnI1rvi1Vs13VLl7QFRJ0woYboJSCIvjyOU7g
	 7HvTb6PFBfT254dK5pOS2gl+zZsso8uJfinX1fikNjuQ+rJX1HHDmv70Ios3enCdho5Cb
	 nCp3+f7WO6sMzYDyj3rDCCFQ1r+Npf27jlGloZBs2khLkvnPFBD5Rqe3RBni3obdCOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417356;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=ksHDiGEE3iw5Iuoc91zTitnxlJVEAazL4dJRvQWgSB0R6NFnzLzk4FBzr0KD0TQdJPz4
	 +gk32w5uDMVT7NdH7yLHNRWipwUgdw26e2tN+gVNfK02cuItX+zaDuL7JKcBRXyvNpllt
	 lxX+WN6Zi64jozfbcHD/ipXlglVWxWDMP9MG8CTx5IKsv48KvYcTxt/TtRXug6kQoEBTi
	 yyR6fMjtu4eZVo9rzMhr+z4N0a16z63PlIQR2rpBqKgm5v54cF54FAacyW/oM6e4CDfZc
	 Ngj+9KBFnq2TuNbbkPIZWgsJ7JDjYQTzSdiBzRrQsOxpnk20J6vHeG2nh0DQbKUddRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ocNCIz1Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A5F606A31A;
	Mon, 23 Nov 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ocNCIz1Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB671F0093C;
	Mon, 23 Nov 2026 07:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795417355;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ocNCIz1YGItF3cNjRyePacoWP7shU9QyV4akLLTaZVYJFDzTl2Tdcn/4LwgF9fblR
	 /wBP5OmmD5IyqDqJaYMMzrhitjvd1Uh4f2NTQuMMbrstdInIOvGBaHsrvBsYvycAaY
	 /+pMW+Rp06SqbAaSf5GGEukmacAkr/jltOvzbPcOvAdXvE/MIsmT9njpBAOFDd89K6
	 OfKFLSQ0Xx0f+ktj4+HLCSzpLnyvx6CGD7JmtC1GP7kEdLcXxXPdsu4MO0xWAG3Jyq
	 AKQu1YWerN2h9ljvkVCAqBL+OzxU/Am4kaeC9covGH4SM1z0RPD9eKS3kH/uKvpedn
	 tYXOh35ckQj6g==
From: netdev-bot+sinfo@kernel.org
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Hangbin Liu <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: 
 Re: [PATCH net] ipv6: route: fix use-after-free in ip6_confirm_neigh()
Date: Mon, 23 Nov 2026 07:02:34 +0000
Message-ID: <179541735412.3294.9380751586642589450@kernel.org>
In-Reply-To: <20261123133000.1.n0ps1edzz@gmail.com>
References: <20261123133000.1.n0ps1edzz@gmail.com>
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
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
