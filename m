Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055370;
	b=JCr4qhJx/cvbonJi1uqPFpg97voed2TxNNfLR8nvUqQAdgdK4iI8/LyRtHLWtbV9IAdN
	 A8EGBWP1Emewpd1cF1HnMFCk8enVAu7KIbzQYUTJgVg0FRVdFWFxlgBq0F7kXBI+dMiL0
	 TCCQT9Q1OzT5ehA+tqw3hOrfYcez0CSaFo1KHWeGAuy5MLF8v7a02QTHc2aFkUSrYplhS
	 peXWV9LubeHYsaW/WgDwo9CfrHKVudWnT+QeEIhr4wCe3SbsxgIIYjFdghGuBHeWimLoG
	 hcLrFj4wUIap1ECSLnYKv02JW7HKhr5yG7WKSPi/KXL22aYYD/qErp66+iKQIwGKsdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055370;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=50DPD+pH2maEeR1T0q8TsL7h2F5lpY+dTHGdMvmi2aI=;
	b=JaFQ4xnh6/ndTdzzje7NbazdLafMdY85JlwtRscy2BN/2Xt2Ir2YKVptZyKNcBzPIAe8
	 l/wkQP8zxnk/WOhuVhAEqG3jl1nq7z/p9Xiv8Q+xXOGsDg2z2+ePSNm+qk48Z7CM1Qq2a
	 AjsM8tCQA9R3v2UTh7zvwd2WrjBZJ2qdkGlv2Xrij9ovys6XwISlTzxWd51xxcrmNjzpD
	 9Ha3HY+sOD3uZJBJFzfpE4UIZr806YG03HZxtSaRFHNmMwyATjZUVQ+3tNBQrnImEbIgG
	 bIGOBB20hv7hgmBboH1GWWckUOs64TpXNLYP02HTWGKkmReHY3om7rcxUj2jTovRyow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYHbSZWh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF8606A31F;
	Mon, 26 Oct 2026 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYHbSZWh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFEB1F031E1;
	Mon, 26 Oct 2026 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055369;
	bh=50DPD+pH2maEeR1T0q8TsL7h2F5lpY+dTHGdMvmi2aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYHbSZWhlg4+NHIxV7K9kwzpQNcgvriD+3VstEKScl17ajn9TeHE7Cei8dgu48jr3
	 TQxz4drVnZ0uC8ZL806vPatRWG99uYgleUYpmRo7LmYX+5neZIYE0VlukNyUJ/wnEb
	 unJfljsH9KhzmBZrNFMnfnotHnZ0vDpn+KS9dqGiDqzEQPMv8CcLlXFYM0u1VWqHst
	 eYQXZNxrCdqMi3rWn/fTgLAjQLOER5cYg1x0HnqUXkhmyXhwyv8VsCBFuj85ulD8VM
	 skjsvD0IH4FcGFBw4wHjAu22N1ApixjX+u3+X2dvw9KLkzTMhIX48wKtx13h7f9RBn
	 PSu30cXkdkaUg==
From: Sasha Levin <sashal@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 6.18.y v2] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 18:55:57 -0400
Message-ID: <2026-10-26-1-daily-reply-0006-damon-zero-target-value-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026134740.149027-1-sj@kernel.org>
References: <20261026134740.149027-1-sj@kernel.org>
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

> Also, the upstream commit on this stable kernel can fix the issue for
> parameters commit paths but DAMON start path.  That's because DAMON
> start path does not invoke damon_commit_quota_goals().  To fix the path
> with minimum change, add a new small validation of quota goal target
> value before damon_start() call.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
