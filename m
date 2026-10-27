Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059489;
	b=xgllNZ0PVDHAFwxZy91LOgs+8v87C/ILy3CQl45SI/7b9LD999XIGdU0woy0sCR6X2gc
	 1g2VAwkuqx4q0Q7J7uLuZXtdhzpZ/VynWUGdZTVzFKyjh2nsSIYaffBnMjlIUlLa0Rj3W
	 B0b1o2vB1TK6wE2nlxsymXQqqpf1QrysoBilHK1sJhpjkJ/9BxkVzXclKyOG+drppLOUs
	 FqKe2WXl+h8TmDgCgbXuXZNF/Jc+EsqbQVRqvfxH2iLvAwjT/lsdZISKuy9Yhlc1aL30G
	 T0iDdK2TyYCDudYm1Io/HTBY4mvCly8Ak3C3TEgSruO+rzBWbWMGmP9fuxVioyOhxTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MDxvbhZaezcuLpjluifFFwSKQ6XQooG9EPlhNbrcxdI=;
	b=Ca7NO4+Z7yG6EvFMj+eZhhVSOr6xmsDp8CueAzVC+HAMLIQZ3+kYadYZNrkrhNwrjtZd
	 XOkyFKmmREK/3ZTSQOyXxpJbSPHFOCqmvspDugvAgykg6LBB2jMjWqNFXfAyOon4MCg5A
	 7KTl36UqkHZVEKnJ1hqW1OPTqPDvrQyf82wpqAc0vHAXz/YWX6CXiruPSFzUYukINL/BY
	 GpE3g33S0Ay8mmE9DVYf85IFZuHRuCMTPgnzwL0/IoOe1fP0jbuGLnPx0qNDfbBAlw7rM
	 Iwz4cu3EUjbyGJSRjsVAOqmuIBuexSp/kvv0+cw3XbelYnSjEYUDBl3Nxe4aQpN/goQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOcphy0p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709A606A31A;
	Tue, 27 Oct 2026 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOcphy0p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6071F01825;
	Tue, 27 Oct 2026 00:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059488;
	bh=MDxvbhZaezcuLpjluifFFwSKQ6XQooG9EPlhNbrcxdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QOcphy0pHTEsRRTI7qoMCSYX15KgYQuJW3VkHHQNayFGZj99eDEH1JXS8UTTnRFJ3
	 rx4QT4EbivPdYbcpbBANlXjrwaWEKFSfIpu/yylCQVbn+2RjIlMuzRkLcefS3TD+vU
	 n2JyP1UHbtg/tTQd5lXgclF2CX7Bq4gNLJd+J8OoA528witJ4qSTQaySe52p6lpRgc
	 FxB4PcdXbQSQq1gSqK17au1Dctj/aaFGzL1EnM0nEPxALbUGaz/hKI3O+Z4KMxzAK5
	 /7r5emyfgmNcPTNQRDFG10UVqWWbhyf+gng/m/kKq7vbKHE9/8jyWOyZrv/PWgfuj8
	 BVcGuxJ49LuvA==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 6.18.y v2] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 17:04:38 -0700
Message-ID: <20261027000439.156775-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026-10-26-1-daily-reply-0006-damon-zero-target-value-6-18@kernel.org>
References: 
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

Hello Sasha,

On Mon, 26 Oct 2026 18:55:57 -0400 Sasha Levin <sashal@kernel.org> wrote:

> > Also, the upstream commit on this stable kernel can fix the issue for
> > parameters commit paths but DAMON start path.  That's because DAMON
> > start path does not invoke damon_commit_quota_goals().  To fix the path
> > with minimum change, add a new small validation of quota goal target
> > value before damon_start() call.
> 
> Queued for 6.18, thanks.

Thank you!  This and the porting for 7.2 [1] are ready to be queeud in my
opinion, though they have RFC tags, so no further action is needed.

That said, I add RFC tag to patches expecting those wouldn't be queued.  Could
we avoid queueing RFC DAMON patches to stable kernels from the next time?

[1] https://lore.kernel.org/20261026133645.119485-1-sj@kernel.org


Thanks,
SJ

[...]
