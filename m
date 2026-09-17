Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919ED3A6EEB;
	Thu, 17 Sep 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629379; cv=none; b=T/mh7UjF/EC/3FR1+gxf2eAg1WpkV+0g4aXrDVSpfc4cdwGf154TgQX5oLtMoLCX58gDSvp8Fuu3AvyS29Knvg2H6A4AYk69paaBqx+kNLmOkp+h+GN11t4OK3iLFpgGtE2HvHSuFODBcKSZexwoQSSKPzc9jHhwqj/PaejNXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629379; c=relaxed/simple;
	bh=V8RcAx202x26kSjJpakdZfJdw5sdXwJnNusDidBSCAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQFGlfShwrMAumn+grHmoLF0zVDAv/gGShWYtCH/FmKoexCALJDkvHWbhsYsN48ezrWQExqZz2el4CeVt0Kl+uRc5Y3sl7/tRrEhVB3TVGR5WR50RzP9li4014m5Q6/agqVM6vNi5M07+RNoKf+nGUrNu9wneOSvhhc12syqe5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=13lzXpZW; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="13lzXpZW"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hln2y1SlDzFqX2;
	Thu, 17 Sep 2026 09:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1789629034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NtNSd0YeXseSD4BykIV+GWOZRNqeRPpb2scRbw76zY=;
	b=13lzXpZWG71TaXW1DWLwigQT8m4gCXyCk9Q8SIh0aAVCNdjvoJ62iQe1ip3GEQoPNpnIIl
	HbUK2Et5z2mCoEoQJHcYdvl8f0gmoX785PAMnXRMG2tl15wJUFWq1ZQ9RIMVAiTvPT1lli
	pg/L3LVlsIeXFWgiZtY9Ox+09ac004lwTbjPSF8Y8nep+ULGD5u6AcCbBdwcgFKW8BzYCE
	kUHoAVMsAJtI6zi7lfQAM9WyGa/9sBwszv0sHeym2D74wrhGbXVOXQ5LZPJfWmB9+qOrxJ
	Qe69V4X+nQcqE6id2f1OS75e8dPo4NKE6ODiRkL/YDLWReY+K07IqymW7ICL4A==
From: Ralf Lici <ralf@mandelbit.com>
To: Ralf Lici <ralf@mandelbit.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
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
Date: Thu, 17 Sep 2026 09:10:19 +0200
Message-ID: <20260917071019.134035-1-ralf@mandelbit.com>
In-Reply-To: <1b7ebced14243c1b342923a25bcc44ec77c45907.1787086511.git.ralf@mandelbit.com>
References: <1b7ebced14243c1b342923a25bcc44ec77c45907.1787086511.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping on this patch in case it got lost in the queue.

Please let me know if there are any comments or if you'd prefer a
respin.

Thanks.

-- 
Ralf Lici
Mandelbit Srl
