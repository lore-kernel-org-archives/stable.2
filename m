Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443372;
	b=uP2q4f3am4XOJMcXbEpAb0iVQraY/8z79z5lCsX+TgyQa1smF5PZtHEqCFuolnwuCkdz
	 LAPEPfieEXWyl/tf0FfJTInM+2vwPc763lbRsjQyk9p/0cCqdEfct3Uh08jkeHtvSLxFv
	 hTpoJy2v6BaZ48/9ltcxWtTp4YJBaZWrBTqNViNiWhCqLnczMZqkkmNQtgR+neLTVvNuJ
	 nqGtC4fmk2muEw4ujoUme/OpaZcZltKz+YWy/q9FjsI4/IBYQZtqm0Ouf8atw0DcKx/MX
	 /FB5GQcJpsaraPUDCG7K2HvCVknyCpYfywhJ+hKA6iY/qvNRfqYJauTH+yxLRRVd5PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443372;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hjgzqXYg4MN+yrBUpIrgnMwGb3HmtYsmUl/E81rLyRU=;
	b=sncV4ceLygAKlJyg5kTsuBMFhfA2IIV1hpQH86ZGbG9Tdk8Z7IskP2x0dmZLgHTgtsDF
	 NKlvtWKJ0YuHn7eyxJAzYUYnrA5UyFU5JASgZ2gNgek8wsbMP7PD/p53EeR6XVNdDSjSG
	 j8L5urP4BXiDBLoHexZ2+M6sWn7PQ1j/aalOCxwD4HlFr6TtB0+rv+kCW8/ScZUyij3VG
	 HAnu/M3B4M9zZABCvwUnz/LJfi0PObiIqM7Ozyx8VAgAxvdOyETHhBQlYY3gFs9M5Z6+Y
	 qjB9qlRIpzz3aucWOZsj5qJ4quk8TewK7yn104kkJ2l64PdXYZVOwe2xvLvNI5fCF2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcPuY+Ad;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0572606A329
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcPuY+Ad
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FB71F000C4;
	Mon, 19 Oct 2026 20:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443371;
	bh=hjgzqXYg4MN+yrBUpIrgnMwGb3HmtYsmUl/E81rLyRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LcPuY+Ad6e7hTnjhXwVxkLSSLx5LC4od1pC0CNjYf3aV9nRxXr3ibTTiJsmzcIA8V
	 W1D49zxEBiRujOPYOTsi5K5tBPObCnOG5Ijmmb+qYRqofWBZeiiyyXNBAWpugEtvXJ
	 YKnx0A5zQu+LwwjWg8zLAb73oTC/UF8+xkCRZhiZoDZ04MGbGV5V0f4OjEcP2L1Pk9
	 V7ILGf2kl0i+LXHp7lp/G+vrMLMmNUwMj/07rSP/3SBJ5BLUmbmJFU4SLzV/LcVXnq
	 so1hllBLfaFKSvWc/u80EHHTM/m347CWZ6Ml9lR2iJvgysmCKOm7VQAUKw+H6o1k1R
	 NKgIZ7g1vCloA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] bpf: fix potential 32-bit overflow when accessing ARRAY map element
Date: Mon, 19 Oct 2026 16:55:45 -0400
Message-ID: <2026-10-19-1-daily-reply-0020-bpf-array-overflow-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019-cve-2022-50167-5-10-v1-1-694b5f334530@bootlin.com>
References: <20261019-cve-2022-50167-5-10-v1-1-694b5f334530@bootlin.com>
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

> If BPF array map is bigger than 4GB, element pointer calculation can
> overflow because both index and elem_size are u32.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
