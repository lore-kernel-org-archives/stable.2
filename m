Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633634;
	b=Z0UITCDajMVwFulxH4sXlknjcOVEKvp7gyTmaKxhvNiueXzLGerkfp9AATgbHKKScP3h
	 MEwk6u0Xjea9fXpzts98NsuiSY7q6jInajz50KBYa44/XpUu2cb3hOswKp1R1/dhbO3oJ
	 WLGO2lK4K3Sfd8+x6Qkn6psOlPS/dUM1uo78dn54NhUmntzDgDOpXNQMxMGadnAGsX7rt
	 gj9xQDBRtVhUI+MtThgayOL+Qy6ZumTLhfWNPdGONNI/42GgCZX/u6Elc5hxfnx24DUjm
	 nZzZb388Hz8IwqtxAFIIDSjPLH5k+rPQowX0d11GWu3IgfarociRta4StAQnIiyUXLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yhqrxKniWvmwFSmFCISp+ceOGGboxDBvmWamj+Gedzg=;
	b=ifsBE2bZxOGb5V6UF2G931vOeTYn8kFr+Ht62foVt3mWb13pnoYC5At9ENC+U+8r5T4+
	 ddjjCd9uBRCD1S0hWdk7Q8X0uRE5gad/QJQQbk3YvGg3YWJZTC9jTfW1+nIr1tRJ3zQvh
	 OhsYECM629MbliL14m2BG7xEFd1JycJtVlVVwgPxUPAcz7KOMkIG/pqmu6cG60DPf6Rvm
	 ki3Ga1g24ML+sUdFsgK/nPFIAnhCwHPgBM7dZDQh3ES2jwdS3HKP4Uo12ftDs5F3R1WSj
	 ejFkENWLODT8D68E9Q6rHEh71p22Pea0oLW4lxeMytUBVwgak698SbdgYSjSHdRBujQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntSQOlUu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83D609FD81
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntSQOlUu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C641F00A1A;
	Mon,  2 Nov 2026 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633633;
	bh=yhqrxKniWvmwFSmFCISp+ceOGGboxDBvmWamj+Gedzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ntSQOlUujmxDvny6FddaWCjC0XtMeIwEdtQGq2r5qDVHQRdkAENpPeHGuNQkyt9NZ
	 5cX0Qul7Qgs2+kNTwyvP89a8lXR7JkfgoL564FA3kyg74DzXbX00zGsP/g41nX5GHj
	 pxsHEGn/zQntNLSyOESpdzrsE+aSe+LNQJGEkJy1MO+/q5t4v8b5tOBVrcPhJysyB4
	 NQG+teZ5xoeUchJBfQXLTXpy1V5FyDiHCR5oLE82o8FjKKiODMADD6kk+nlIUlHmmg
	 48bKQQqmJfCwXhXxX7ggK1cVkBSw/FrO1mxNbd3K+ERPY/aAVtBLVyN5/BsEdc8r5P
	 vj7aB6ukV0VTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: Send two commits to stable kernels
Date: Mon,  2 Nov 2026 10:33:38 -0500
Message-ID: <2026-11-02-1-daily-reply-0012-gicv5-send-two-commits-7-3-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auhU-oxrjzFoFctB@lpieralisi>
References: <auhU-oxrjzFoFctB@lpieralisi>
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

> commit 1d77e79d62cf ("dt-bindings: interrupt-controller: gicv5: Relax IRS
> properties constraints")
> commit 64212d63193c ("irqchip/gic-v5: Fix standalone IRSes OF probe")

Queued both for 6.18 and 7.3, thanks. Nothing older has GICv5.

-- 
Thanks,
Sasha
