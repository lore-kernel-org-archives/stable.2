Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443367;
	b=46E0IU8914wHFNghH2Pa7VUgS50qnLqOCc5xzbwlhZG49Ighb7rSrmDZliVFyTx52OzH
	 NNqdGak3UjsjeqSjIOMQHipiWMWzuTlEN1E3WYF3cg7eOvzWuLb+RccrebFPTsiPTD5Jf
	 N+0Rca2bIBbc6Wx09tS37q5yv01dH1cSDUCdVVdG7Mj4cvGW+Fh3omSQjjXpZgDToU9Yx
	 ROVbkq2Riy4KmVmqSBh5fMrWw20dWH7FdckCWflcpsagQPv1uQthURQYIQrWW7UQdyt/P
	 Ywm1eA/xd1W5sgeiFHN3n+/PDMSIxNipKc+wDRqLJOkQ0NsfbglcfgcdzB7Qd+Pw1GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443367;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U40s5hzaejDCQHLgHvkTwHJiRQKspKw87465M0WIMbA=;
	b=2DEAdcu8JJlvMEsckoh5wnPrIk7ufTxQSnrc7zou1TieOelVxaucGY7+O2b7nsU3GUAq
	 AgS/9wyvWOBhjgxqZEtzePef1HjzEFDdlcNEzCANk7g0vNvXXqFqSGDp4eXSf53ZtR/of
	 RvQIWh5Rrep2pVNw679eh2qKY1EwB6l0u3wDFvmI9AIrrunvzmNfrTygVZIZZGlre9frE
	 LqYKn8nZAZMns07K9hgAC8InfHnmDAlwJ2ogc1w72XJTErHw1C1f0F64uEou8x42yyGI1
	 LN+/DlpcFWytNPkfxJZBYNfTAJ746ga1ggV0SObyFOkrXxLgWbR9J3BC50Yf90tZPIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmjtYQ4a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CE606A31E
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmjtYQ4a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227531F000CA;
	Mon, 19 Oct 2026 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443366;
	bh=U40s5hzaejDCQHLgHvkTwHJiRQKspKw87465M0WIMbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AmjtYQ4a+savH+UXrkj5WO1cwa1aTVYiMNC/d0f74zkuhPoDbiRFghReSNH7Gv67B
	 DTuJ9xYwgdL7jkyw1XXMvotQU7H2PUsImHpi1h1IcKReGBGsLJ4BzSDvqzATyqw7WU
	 Hw5ZACNVbEC1GZvU8Vxs+zwVLfkp5oROFuxV3EKh2jzcc3gHatJMUi039IbSEx3MhO
	 jnmE+l0aKZuxm1ajBFFngG2hyRHIM6evbfssgTtTKtPCLurHAD/NK14L5qtsyVndoR
	 MzHU9HWskpyN02EXsq0dN4Vhy63deWlo+VxvXVybqo0yUpAv2chpYEXDm0FAXjFsps
	 hDN7YMJJbIr4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	technoboy85@gmail.com,
	hirofumi@mail.parknet.co.jp,
	brauner@kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: Please backport FAT end-of-directory fix to 6.18 and 6.12
Date: Mon, 19 Oct 2026 16:55:41 -0400
Message-ID: <2026-10-19-1-daily-reply-0016-fat-eod-request-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <96dbd7d103fa6df33b0bbd492e309bd7@tipi-net.de>
References: <96dbd7d103fa6df33b0bbd492e309bd7@tipi-net.de>
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

> Please consider backporting upstream commit
>
> 6a2875517c778ac1111b6920e94cbab91cda8724
> fat: stop reading directory entries past the end-of-directory marker
>
> to 6.18.y and 6.12.y, and any other affected supported stable branches.

Queued for 6.12, thanks. 6.18 is already queued. For the older trees,
please send backports if you want it applied there.

-- 
Thanks,
Sasha
