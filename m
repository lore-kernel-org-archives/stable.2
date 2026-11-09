Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184491;
	b=4KSWFvpTGMKGr6opdPiD5zSF4pSoN9UZ+pMbPyS02tmlcZU/a/d8af/WuN9FPdUiHs/j
	 dB+VG3eJ89GgEvQ0gsF+CsFKwolzJIuVkFtXzbeZB5N3JPIQZCE29uMLj7c5JsWe/CRle
	 630PV3P2B1m+oEjtn8AQUvmMn+bndxkeOT5avzTSckfcVM5zdDb/+QB2cMbQCCmjFBLtv
	 e9H6OBbDhP/lZSg4g8PryWLFiNbOOb5BONlCc/0BmCka/VAGL2R4F3LCUC3IzBoD7qbYy
	 B40KXWP9+3IW5BLz0qL2COBQcz40bLPgXy5lmf8pImpiZzQYmKJmoEKK3arGksj0bmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9Bo9AS7Swq2CvNAJp1BGWwJ4ueU2VCtoYeAywO7Zrag=;
	b=dBx0to8iCnDMVII9OHWc3NnTIkGK21Iyczgh0UGqDIa/IPUQEw1o694hX3Z6f7zsSouz
	 pttI6ijscTj9QfOLK0rdq+7tVNlLoxJ71TqDJo/Kr8GRdV6yLxbDPTuqMzj8fvbgofCi3
	 aZFNYvb/S8ajugZhmmD9cKy3u00rPOiOGhjP0wHlZkC3uWW45Dd5uQUloaHQVnkXQWlCX
	 VhA4PrmEMUK0s5bk5BVzbEgYOp9fOOgYEdweh2bVNRx17lmjcn9t0m83jLWrgeqTg9zGZ
	 81q51v2V6txb4BeuP2RFahuQJKM62OfJGQf1E7uNwejGuIca1W7PfkpnsIaf4NTms4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gj+pgrfy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18977606EE92
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gj+pgrfy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DAD1F008A1;
	Mon,  9 Nov 2026 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184490;
	bh=9Bo9AS7Swq2CvNAJp1BGWwJ4ueU2VCtoYeAywO7Zrag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gj+pgrfyse+MmNoqaF4wJw/QckeaSrwPxJGhPBQmjlSuN1fYGQ6G68CI+Kv2cj513
	 x/OMcCLSCic4QGZrOMamQsBHKU7k+bm5+OjKgTqHcUbKxa/qwLcTtTuuKX92/3ynaC
	 PcPjiouSqFagrMavJxe2yVdEvQX1SyAOxxPnJi9S2rSxtNOpUqMFe1sg5efcfQ7eCe
	 xkfWp7dHHKpY6S7nU3HqAID9hTScSYSXULi8U3cgj8e8Ll5OPI/YlUDLf+WfFazDx0
	 hn+Mw+5pmxfpbgWpxSj+YeOkuQ75JklQKIiXi5ZbzwqGkB7GMCNbx1vyfNPrEQj+Qk
	 UW3u3HcpgYw2A==
From: Sasha Levin <sashal@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	iav@iav.lv
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y, 6.1.y, 5.15.y, 5.10.y] genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path
Date: Sun,  8 Nov 2026 19:34:36 -0500
Message-ID: <2026-11-08-1-daily-reply-0008-genirq-kexec-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <877binwiyw.ffs@fw13>
References: <877binwiyw.ffs@fw13>
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

> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
> +		ret = __irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);

The 6.12 version is queued.

This combined backport passes the irq number i here, but
__irq_set_irqchip_state() takes a struct irq_desc *, and upstream passes desc.
The arm64 build fails with -Wint-conversion on 6.6, 6.1 and 5.15 (and 5.10 has
the same hunk). Could you resend it passing desc?

-- 
Thanks,
Sasha
