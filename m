Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005610;
	b=YmZvPOr41nt2IR8tQBDRpnG3wxw2mHmK5AQETQjTFNM3KdHNPZkvmOcB2z9g+6ejpHI1
	 5BbqAkM1Q7Hp9uSEcDziBes6g5iDNdkSnSKbFX6u6XjRuCsrV27ibAogM9QWBo2uOaS4I
	 z66vILrSUlSaD+0i90WQ/Iiq1CZPw52veTZAv3nUn3w5RYedD9R1qqgxJTausHqYD2ngN
	 XRShaBIoSzCANS2Psn0mLn0lV7bcOGX4g/0IUUmaxH4+ByoJZlz7hUPoGqmuqWSdfodlJ
	 0uUGwNbw1vWLvWgt8OtnbMCChQcPGxthPjj0/TUA/C8+Jy1ftMt9rFzhC9gDrdfVDYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=93315cMX21u3DHYgcba+pINy/eN5JSNaE8BW3BgW3t8=;
	b=NooAx4q2rOdrvNB38cEDoyG59QCIuAr0S/lw3rfJfDIrh1JxsUjnT5Di5c7j+LwOjiqD
	 lNvtMpWOoBRfZbBFxcxZkv42wFmAr9MzrjxIifJ5+36MJAUnWrKMzXJiUWKJuMXSXnBOf
	 dM0/NcqIbSffx8reVAqT7WCmtskxSMvm+RWS29wMPAQVMjuZmFdQwJA4bBXpbna6K7Xq3
	 ZctFAsZxGNhcB/QoDDaTTVIs5FrQ7ClrafrYnPOrYL3cckf4crC2wbcQ41q3yGEtVNRpE
	 fUsCB4fJupm3/X+OA/d9IZmooEyTLyUIL5M+8lWnDemOkz80ddrCIiujI5Yzte/osZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avLhlc5g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4AE606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avLhlc5g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5E01F000C5;
	Wed, 18 Nov 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005609;
	bh=93315cMX21u3DHYgcba+pINy/eN5JSNaE8BW3BgW3t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=avLhlc5gtyifVIUaEj8Agw1MjPyyB2scVNGHwX2gs2BGB6vbQb+Jkzhrc0NsNqe7O
	 RcYXvR8hHCN95l5o7fxO2sC2pMFVOCefDasPyh7n8KWvnWZP0KgSepO3o4qvaqXWAy
	 CjG9vbFciLg0fMTDzPgJoEeIxbfazI2huk7nvgQXOjIbzR1JZUxET00hIFLl2hsOf+
	 YFz8IcPkZbvDDKj2IyCCLbB4TG0iEADHl1iOOp9Qh69QjMiNaDTF0zD4nzuEffqeqV
	 NHbMk/g9ti/oVYKJHQrHPyvTsDE4+SFkmN2+T+55ivFCSzwtg7AlTHyZH+Rlb8DPss
	 hLL3s6afgBv/g==
From: Sasha Levin <sashal@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/cma: accept memory of CMA areas reserved at a fixed address
Date: Wed, 18 Nov 2026 07:40:01 -0500
Message-ID: <20261118124002.3727477-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avszpOC2q4p8dVVK@shutemov.name>
References: <20261109201234-failed-6.6-f8f9cbc34a30@kernel.org> <20261114161849.4002504-1-sashal@kernel.org> <avszpOC2q4p8dVVK@shutemov.name>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 16, 2026 at 04:48:52PM +0000, Kiryl Shutsemau (Meta) wrote:
> accept_memory() takes (start, end) in 6.6. It was converted to
> (start, size) in 6.12. See 5adfeaecc487 ("mm: rework accept memory
> helpers"). Here size is taken as the end address. For the usual
> cma=<size>@<base>, base is above size and nothing gets accepted, so the
> bug stays.

The copy in the 6.6 queue is not the one that was posted. It already calls
accept_memory(base, base + size), see
queue-6.6/mm-cma-accept-memory-of-cma-areas-reserved-at-a-fixe.patch and its "[
sashal: ... ]" note.

The 6.12 copy passes (base, size), matching the 6.12 signature, as you say.

-- 
Thanks,
Sasha
