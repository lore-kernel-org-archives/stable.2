Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982965;
	b=rcDzDCjIlvfFw3phMnqFDaDI5yK5R7qrstRm5Q1T66yPSIgYWxdl0wwrWqijw6HXMGty
	 zb09STBuThRAhi3rxI6dxpfiXshR4IgIE2qGloRqNfNM1lMM46OGnk8WRksLKj0OZdHpl
	 dZi9zgjBEOjI0bXHGjsOf1V6o58mV++z+oI7Gl13aKcfHI5W3A0SKYgpRn7wI/IAo3d6y
	 w/+reYz8lpGgof83izHQZlgHQkhkRh/drdtfICC8LM1X41dVkNnirLoqi25T/eG0Wzg9M
	 KnwYb/yLo8fgJ8fn/aYqiiD92OvVV70oEHkF7eBozdgRXS3svGuJu+IgrHYJOmZ0XXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982965;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YO1cp0PaaQRIdWZlmbM2ymtDZAgZxiUBSHfHBmrBbU4=;
	b=DRqU5a4JXzxC7MoOcFN+3K6z4TGEOYDR/DuRPWsQKq3Lt0xVlYcgqtRBdPvGMreLlq7C
	 xE0Oz+wx2aFtoTvImnXad6l6n2KifWzz65FT2JYA2OtdDSdCy24Jf8kwLb0uJC8maumPV
	 UNTeOiG8pHWn9xgwmpgH+YErq6+UX+5eq7BNmE+JD1G0RUbtXRovoxsvDcGcCZPbEJld9
	 fDplYEMa+sV9HK+0Yb3K+lfklSynxxjXoyZ2H2Lw7SZlWcGvY8mbhye/ZyoeumpTTQh9b
	 2DK8Zh3eQoJ8CABp9xdCmEGuTiyBT9d3GDej9YH2//DM1cfXf1xp3qrIElJvqumDPrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrYCRKNm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F48606D825
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrYCRKNm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C46E1F008A1;
	Fri,  6 Nov 2026 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982965;
	bh=YO1cp0PaaQRIdWZlmbM2ymtDZAgZxiUBSHfHBmrBbU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QrYCRKNm3G+dPMGKE6CT3tu21EZnzrmpzYSY4v3O4A9LmNZPFIdAmThtb6wuzhoXn
	 i3D0EZSaJoqUGUYh4YosNVx7DFEwJViAMmbWWLeP6rHIDv6sN2MFTNIQvHwcdeN2Up
	 p1Rfu8p26+dOgCNOeCt2IzNpa4I4k0lh9O0vOOBlOy8+iVUy1v0B9s34A0yYpDKQA0
	 av8boKo+DSYDAF4FZJIyj8eLCPsLQc6EacM8FhLZS0e4aGuLO3KWBg2H2vne7K8GZ/
	 yMaDRuJ4sAeDoJZWMHE/nMapUnIQlougaBiM+xXaqamuvpvYCMM6GSj/sBTF6lAG0l
	 PGKC17Z56ulxA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	linkinjeon@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Subject: Re: FAILED: patch "[PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers" failed to apply to 6.6-stable tree
Date: Fri,  6 Nov 2026 11:35:43 -0500
Message-ID: <2026-11-06-1-daily-reply-0008-smbdirect-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <751f0e5b-c37d-47a4-a45d-56043ccbb8d2@samba.org>
References: <751f0e5b-c37d-47a4-a45d-56043ccbb8d2@samba.org>
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

> smb: smbdirect: fix buffer length underflow in RDMA transfers

Queued your backport for 6.6, thanks.

-- 
Thanks,
Sasha
