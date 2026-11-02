Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633627;
	b=typuqYNnMzInCbzYMJ1GL7sjjJtjr2FA6mfgem19NfGrlKw3bcQedybOSma+CdP/YsqL
	 cSG36Zhh04J97cnSLbBKIuhcW0qnua1x/2Owd3wkJvtctNLHI9v4tm/Yc2qq26fILzb+b
	 rXWYHNmXswYlW3iRlSAz24CzAsOMTaWchlq+cHx+fZtrorAfq5Va7fnmA1g75jxpA7fJZ
	 wEuX805fXrFNuhtzcfBWmNmsvLNVzr4gVJjjJiE4CtrLY/kk3dZwDrXAhQLhwdcU3M5Da
	 LYAysU8+bUJ3Cx5t7WGfLUhkAE2IaF/tX9CsyUKsdAgfe+Ck1xGopA3r6NBcCHO+a5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y7iuroKMa4ykgSDTY3IFWJRazoRXh0A4BZiEOtVCpHE=;
	b=D5dHY1OQZEVrIxPbfxeY8UsQTiHhpUfsefy7KPq3dghnwSOX31bV0IUTudSkDqbu5oxh
	 SciKdPeCaq8ov3RJTd8pHt08gUSegGcWoeU0Ki3t7QDnDyDia3NX2iiisn/i+iCb7R74y
	 S6DCU5tW3iWVc0ZUwtLm4iQ/WLH0nT8NrE48wM9rUQY+z4m6/tm/3ISfQ6+gHeB5hmA2+
	 kZk6pJFRaMDI7QcVupN5tkjZCt0jiHFSQPsrDMg/45IPdV0xiBBYAKn0ycWyoncd18WV4
	 AZapSUjHXxlgExx64RIx2hmt8LjI5dADd2XbHylG81+pKc8FQXK2AZRyO1Cx0OOoNvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PE4OmIRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A329609FD9A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PE4OmIRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A69A1F00A23;
	Mon,  2 Nov 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633626;
	bh=y7iuroKMa4ykgSDTY3IFWJRazoRXh0A4BZiEOtVCpHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PE4OmIRlnIuOL2eyIPnDB4A22uf/yFx3B6hRJGfueteBFexrhK0BZkdGcTPYOEpXe
	 Nu0G5SkZ/0+GRoSb+JLEHQ/8H2nyKif0CJCdDMZW1PlJjv5FnEqlxC8jLbUjRcCekt
	 lIUKvnrKIMTlpikc6IPzJyA1TZ0SpLU3Q0+l/7k6uVzc2VSAhY8LNyxDDTuNPEa3LR
	 Vw/qENdpMAb6OuCxBsoYxMkI/UyFbwKilbPgSsLLB37XHIStK5SnjWEpMg1vx1y4di
	 gD0aVpyR1ImNCIbK/RLCcMdfQhePgY9jutkrXwsoVzas+lFyMimZZejrPG8Q4KJTad
	 78Z6Jc8BxlhMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Qing Luo <luoqing@kylinos.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 6.12.y] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 10:33:31 -0500
Message-ID: <2026-11-02-1-daily-reply-0005-sctp-auth-chunk-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102095345.1526404-1-harshit.m.mogalapalli@oracle.com>
References: <20261102095345.1526404-1-harshit.m.mogalapalli@oracle.com>
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

> Discard the AUTH chunk early via pdiscard when skb_clone() fails,
> so that the receive loop can continue processing remaining chunks
> in the inqueue instead of stalling the entire packet.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
