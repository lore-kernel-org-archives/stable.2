Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434117;
	b=eK1kMBCIt9c0aivrrGh98cFT/Dn4G/s605Z2XVemuU+iUx1/kkRUWIaYBMoEREzZIR/K
	 MhzEOntbYWlbk5530gEiDX3IJXrkrtXh8PhPV8hNlTBf3mQIVpXE0EYz2d1gjN+6T7pPj
	 OEHyGnBc8U+h7TbmbdcNV0E27WOEqNnCC7CvT/DIQ02K6/mrDdAP+LPuvwrjfLnLbWEzK
	 k5YCONddNtuo/ecSvyH/w/F94LwXaxorPKjMH5limU8GV7zTo51paqp9rMMBV79IcZGU3
	 kKw598rbQwr3K/WS1l178C6SuVTK/z0eQvmZ4y2MnzLd5Z6aKMTYcVNNYByP5EeQ+iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lXCkQ5v+MFtbBovaMeOuBEKUnjbT9v29ImOHGGjrqpI=;
	b=dByIyCh/92U8FHPQRv5t3DY9XUuKjp+xIfzG/W/lM1zZDG0+3Nzuo/j8wT2yqF6xt+Cc
	 nmctGSvoOaCkpzaRd7EkADRKq8idAZY6FqyLvzv8Yom4A8W0bi/EIbtx5shb/9uCu0v/n
	 1MkEyG4/7NFqTXlVy7x/zlwE7P1JoXuRdmGU2f7wXNB48a/EIxz3VAR7j4uBn5uclytFG
	 Eve6SSqOW8yzS+mwxtGtM90tcWGwMi5vsDs5yqmeh10a0pvGEEXsiUrfWDaRSmN8ypqbT
	 NPT3Y/hmLfoiqsSdEHntOpTasq6RfI0EdDbo4/Wu0Fupx5HgTHyyZiY8ML0Nx5GHoqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtTY6Geh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA860A380E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtTY6Geh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB921F00A09;
	Wed, 11 Nov 2026 21:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434117;
	bh=lXCkQ5v+MFtbBovaMeOuBEKUnjbT9v29ImOHGGjrqpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YtTY6GehuaHDZlIqDV0S58ebk55XIiJANaUdJBBm3sWBXsz6jtPp8NA55YYxoQ+lS
	 Eo/TV62G7rRxOlXrezZ3xBblEIW6eD5CchXudfMvSzMtgKmIGtkpQwOoZzlcREfxCW
	 AF0IOV5d+c6lZ3MZIlORwd9EYWytNomlEGpBFv/CsfVzmDnp7aIVx9mvJbP+KNHeo2
	 +t4zy7p2+GuIsQ7Rj1JBbnW/ndTv2xclGBOJPCuT/ch8eB5Obvq6YdzAHMJKWRw2LS
	 xJ/8rqawBIQQMuH+QDefL7QBzVthzmpO6UH8fvJgEtPb5V+s0QIAWbN2aJrR+/vNKv
	 P4wlsITeLUGbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: Linux-stable backports for IOMMU CVE-2024-21963
Date: Wed, 11 Nov 2026 16:54:53 -0500
Message-ID: <2026-11-11-1-daily-reply-0020-75e008cc30c56605257c@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111104001.216548-1-joro@8bytes.org>
References: <20261111104001.216548-1-joro@8bytes.org>
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

> Linux-stable backports for IOMMU CVE-2024-21963
Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

6.18 already carries the mainline commit, so the 6.18.y patch does not apply on
top of it. What 6.18 is missing is the one-line Zen6 model-range hunk in
arch/x86/kernel/cpu/amd.c. Could you send that as a separate 6.18.y patch?

-- 
Thanks,
Sasha
