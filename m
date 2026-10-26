Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055371;
	b=cVWeV5BTB0nfywcbYfXFRH2zry4/njnFXvcsgUSN7UCoRzwtqA/Uh0ER1MEwO2OeuNuh
	 1ZT0W3VEuNR370a2fZEBD4HdRAW4vNz8s8vbnlPM96pN9fX0Pv0EfSOVP+skGYcfwkn2V
	 BoLWo5Gv4TuvSxIv49hEewLVcBdyuMZMEHwIaeTT6rdJlCDKjLZYxirHTSpcl8WhUV3Cs
	 fxM/tkhEIx0i4H4B3GumjYeCStNhB729Ny4h7JQpHCxoFMg08+sPETg8vzdovKURPuPYm
	 oNvuZkC5lwKaHAd5QDGs9E8YJeYY1/xRBhODOFqpqnmQ7sBRIln6IqbcyZz9ASLLq2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055371;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hzabUPaqxMDWk1LN5/UZ/6EnnSWEJcKuvFp3doWo4w8=;
	b=pKU5jz9bPKCEr3mNXKphu3fb4MEMKpl1BarMPoOYnIdyc+XQnTtsaXa/nnLrUFKIMwWT
	 C2n7LpEyO8iMG6AwcWj2UOKLiSzH61KwvdmYV6iHT3R0FKZZLIQd5T7R5jLHcBJG6aA+R
	 1mcixqPYz2vwD47mvfuaRZbdKsP72AIJBToe3OzXeq/SmJeBfNWZxjKYraVR/vpqAMJyh
	 7UeIbP2XsnJDOyKZxDHhfiw/BQE7lWUMjl3pQcd/EPRF/FYIapby9oJByf+9xUrRcKqfP
	 2rarNAbgdsxwrcSnSCrHZ1GL7Cq4/a5sBFurXa/gLd3cmEiG0rl9msrRhIu3n2DKBsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nglWobNB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24562606A32C;
	Mon, 26 Oct 2026 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nglWobNB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA4C1F031E0;
	Mon, 26 Oct 2026 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055370;
	bh=hzabUPaqxMDWk1LN5/UZ/6EnnSWEJcKuvFp3doWo4w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nglWobNBsbPeQ7ZuKD7NSBzNFEyv22iXun1SdrDTsMNDxfNiIvMS++3ljx0JkrDhy
	 Ys8oi+oZxPQrYxioeu76kI81Y4CP0MxAy5m4Ebu+0SdvcZtqZWJ8HIE6kIPD5p+4wo
	 D5Is7BN9ivdhtNR9s8i0nc4VEs1yHACsIoQ2ff64+soFsUzvxke8Yl+kv6nRtk020W
	 Vvfj7D+0Z86Oizgym9suTHcwCUMUkb/AY0AW0NhJExj1rE86PBvArgzU+nKpmooWf8
	 Qbp+5as/ja+afBsEDyKhH+MqrxbsaLTBO6S0ZVuvmOhLcCf/P2UeD+bS+2x+y9JpVz
	 pXGRBEFc+qmwA==
From: Sasha Levin <sashal@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 6.12.y v2] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 18:55:58 -0400
Message-ID: <2026-10-26-1-daily-reply-0007-damon-zero-target-value-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026135555.149244-1-sj@kernel.org>
References: <20261026135555.149244-1-sj@kernel.org>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
