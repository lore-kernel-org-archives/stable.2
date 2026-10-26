Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055373;
	b=zEXhyHgTdKZ+rhTPk+2I2iW+4zS13slvjoRQrk2U2E+tsHUfBiz9L5lVHohMx0lDm/69
	 QztvItHheUhh988oURLcgKtiqUHsQuKBjSt6cx9kcD5Z2rsGCfQ2JCu3EU3tiDBRmtMLa
	 B6DhyxKM2YtmObvgSA0WVkW/XhgrS1lX2zkFS78bGEJQi0a4c/oQqps6IEMTIrV77joqt
	 bkltx6I4GJXuWJ5yG0DQPCBJTxn6WcTAaLpJzkvIEtcQ/q/WNfgIx2AgjiHeRRMzOgoG9
	 BoTIa8ilGX4taIwj4r2zjGI/8U1VzGETiFOPMviwQwNUL+AGR2Y2yvgJykTYoETUq6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IxmxSBB66fyBH/K51gLvTHBBMnkEjNFXBJSFsUsq+A4=;
	b=tvOK0T2e4RQxHphxEh2k9kM35Ib1SfVhLM7KLmCO39gSo6jLHcGtW1PY539JIpiwcYAv
	 Q7f8Zsn5ryfa+5G5J2LuB8MfcDXuO00sosyDt3avVxfnDzN0U+CKHC3652gKNcBfeB9cb
	 MmOaN9xML/u+exizgPyNzTO/rOBPJOpWSVW04zLoqToMSrKEuoVcKjjflbudQrp68GtpW
	 Xoft6UtHxvMt6KjKMZNX07Imjt+PNbtpuFOXyLuFN4VaB6tjqS1NafWTyzxChg2rwz/vK
	 B5Blc2i9llW6v9rQveVpOP/G/uAyELU0z/rda1vaG80YOFLQAcXGhHQ/ahs72htQKVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iguCVMij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002A606A324;
	Mon, 26 Oct 2026 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iguCVMij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274441F031E3;
	Mon, 26 Oct 2026 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055372;
	bh=IxmxSBB66fyBH/K51gLvTHBBMnkEjNFXBJSFsUsq+A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iguCVMij6fj9wiY6cU6qn+V3RlWPFgUy4P1jyicQ/+ntQlha7H4UnHchp6Gf40Wpq
	 McskL/DRMSeq206cHT1IRbg/4fKo78YdhRYSMLEMFYBf2n9mI7TTIOa2Q5La8G5jQh
	 yL73DjFJr4lFQJ2opbPW+/373UqLIb3AN422YBKqGcO0Os2NYZGawrESrmuSK4VC23
	 CgOLVZocbq3Lql7KHYpfwbC3zZF0sAfbf9OpP8xkqlSRRnU7Q2XqtQ1x/W6iscrhpK
	 N4nZufh36D3bZpujZV8K1/QsMURm0BjN9u38tc0Un1NYyNBTT/dUGqUEWnM0DHYAfJ
	 ZsXvDJzoFQ5+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Gyutae Bae <gyutae.opensource@navercorp.com>
Subject: Re: Backport request: fq_codel stale-state fix (815980fe6dbb)
Date: Mon, 26 Oct 2026 18:55:59 -0400
Message-ID: <2026-10-26-1-daily-reply-0008-fq-codel-stale-state@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026101337.22494-1-gyutae.opensource@navercorp.com>
References: <20261026101337.22494-1-gyutae.opensource@navercorp.com>
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

> Please backport the following upstream commit to 5.10.y, 5.15.y,
> 6.1.y, 6.6.y, 6.12.y and 6.18.y:
>
>   815980fe6dbb01ad4007e8b260a45617f598b76d
>   net_sched: codel: fix stale state for empty flows in fq_codel

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
