Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A74DBD8E;
	Thu, 17 Sep 2026 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647687; cv=none; b=fxyrhJ29TbHINtkJRUqirhSG4K0qiFprMLbU8a42MJq+sB8gcQwkDvDBEV+WcLda3wzA6se+Fo4SQPCTP/V6fTUVmDdzzJBMOryTN8WLjX7DcMU7wBzMxpSmQvP+jdWfSPbDPGRVSzsB39O7LIf+ehOamaYd1MF6L+qYYD+ibZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647687; c=relaxed/simple;
	bh=vXk/zZP/rWzL+je4XD16y2NHbePPEt5x3tRFzHbdslo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh1rPH4JTf4vt+Q2SnLCByI6xXmbox1OWSQ2mKpEIWj/OZPAc/xCA9IgIE2JTA+fPbnLoeZ+JUqhQTAtihH84tX912uRCZZWGwQ6GyCU6FkQvZ4wTtCFrbfZaOYrks9z8MXhxQ1Tdu1OD0B9Y0gMiragSLSB97SkPapsUtP4OHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=eTyZvLH4; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="eTyZvLH4"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4hlvpS6jM7zLlyB;
	Thu, 17 Sep 2026 14:15:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1789647313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVr6iAiRxKKwQhGkwIFRC/NuWDqPv9xW8VN1yGPgEBg=;
	b=eTyZvLH4EygpTa2sVyxL3GcvLsQAThfPUXbXiEqM9i6G39A9xd0xPJXPVRfgpxY6d5CPZQ
	zcAgPa+0E2VVb5FGPJ89oei4oJmfUciMxXRAq84gcAAsCpaC/SCsmB78o0ZBXDFq74ZwxB
	tyGzaye0imdbo9KIs/Gq5AgEiiGvWe8FUzrpSH2tDvTw7E8jtQJex47uVKyDOWsBlJtWyg
	OEkQix9ArtiwumuFmkJ5vfdtPFrkU9JcsnsFpXLZrFvwAlzQtCVRoVyoHAD8GeUoHMzGqG
	ytbbulKlvhd5snqOjGUMwXOR0RxDmDBCYrg/go1vefSTL+V41eFCCAc8xxb4fg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Emeel Hakim <ehakim@nvidia.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5e: advertise MACsec offload only when supported
Date: Thu, 17 Sep 2026 14:14:57 +0200
Message-ID: <20260917121457.636792-1-ralf@mandelbit.com>
In-Reply-To: <f7678a37-4dd6-4219-bcef-34a2d74783a6@nvidia.com>
References: <f7678a37-4dd6-4219-bcef-34a2d74783a6@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hlvpS6jM7zLlyB

On Thu, 17 Sep 2026 13:45:44 +0300, Tariq Toukan <tariqt@nvidia.com> wrote:
>
>
> On 17/09/2026 10:10, Ralf Lici wrote:
> > Hi,
> > 
> > Gentle ping on this patch in case it got lost in the queue.
> > 
> > Please let me know if there are any comments or if you'd prefer a
> > respin.
> > 
> > Thanks.
> > 
>
> Hi,
> Sorry for the delay, it was missed during August vacations.
>
> Patch LGTM, you can re-send it yourself and add my tag:
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>
> I can also do that, let me know.
>

No problem, thanks for the review. I'll take care of the resend.

Cheers!

-- 
Ralf Lici
Mandelbit Srl
