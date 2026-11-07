Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091694;
	b=KRC0BwKEFZMmKAAeaFmr/rnxaQk2MX+bhMnJMq7WhtsXjYi4HgeJM3phtTHkpeQa2agr
	 0R2ViWqtAcgsNcl0q/+6Mmlt4JnRFNPzGhYwCNIXwWJOTgDWhsKkrpep7uu+fNzBb97+6
	 Ek1078ZCX1zNDR52ER/EHYYmuTpOwJNKp8tCQIEuQnIl1coHF2IpRWC7rYILx487ixRCU
	 sXRfigB4USau8QJcCirBKXT8AV2TkkKDE00uovMHAkwRUQyBotGlW0PtyQDrqAxKC0NWN
	 s0acZs+UZ3dw3b4GM3mlX39Xv3vS7Bgb7d0IACrkJ23o+uD7FFbwjjJO+Me0uNW8KWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091694;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=r93xgnQnGDvW0eJYTsrLNsZ3v+4WKqnYiy2NtOwA/68=;
	b=NNUC/EsGbjNiVr+YnYf0z0RBpkMkHkVW0cN5wLYV5waF/z4YkmDluxZSlL+nn1U/SVfe
	 fdfKVU8JwAhZWZxjdmf4ideOy2D5omCWG+3GO1Z6pnaUu/PBXAD3x+PogHI73UlNhYvYR
	 SKUyMvSxR1SwuHUCWOH2xX3hB+T7DU2eDJavlwta1PCP3ZERZFlkV1PXI9WOWANQQC5QA
	 oEPy+vWWp6jp251DxaZaZrTHT+kDPJDtog18IVen+30lKFGOsO8qipsNm2qwco453RSci
	 lJ/FYVRuo07qN4BDwLlzIzRYoQpLyrOgY13q6fiQAB4OExtOs/RLjOb3A13dkoBuiYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Co0WFuLq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D19606A326;
	Sat,  7 Nov 2026 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Co0WFuLq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F141F0089F;
	Sat,  7 Nov 2026 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091693;
	bh=r93xgnQnGDvW0eJYTsrLNsZ3v+4WKqnYiy2NtOwA/68=;
	h=From:To:Cc:Subject:Date;
	b=Co0WFuLqiounnTv/KIwnHob4J3Tytzzzbg9u7At/kRTYjW7LEeZF6U0e174jvnwTI
	 3MYg9JuI3oqYyznIxjDT8G1GlOkRoSlstSC5H04g7mgDzGhf8u5u37a0hKsakGu2qL
	 ej7bnAxCyg5Y6Mm90Y92UFwlEsoe+EzTk5sIBii+n2WSqbcL1lovuWu7r0PEyX8GfK
	 1J+g88apz1n7lv+83esBNJtYyoMhFt2E5YHX/MoL8qx3GkE9fFoT8gLKA0ms5WsIN1
	 VouAt/yrkqs1lNqjpkaoPn+oxo2ldPE9TuQnKRDZ7V+z+WKP61x+YLM/0lYjeXCj26
	 9xJruRIspNhBQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.1.y 0/2] mm/damon: porting fixes that cherry-pick failed on 2026-11-07
Date: Sat,  7 Nov 2026 14:47:57 -0800
Message-ID: <20261107224800.340250-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Manually port two DAMON fixes that cherry-pick failed [1,2] and turned
out to really need to be picked.  Note that seven patches [3-9] that
also failed in the same day were having wrong Cc:stable@ tags, so
ignored.

Patches that this series is porting.

[1] https://lore.kernel.org/20261107054458-failed-6.1-90c2fa6adfed@kernel.org
[2] https://lore.kernel.org/20261107055454-failed-6.1-5695abc4e742@kernel.org

Patches that also cherry-pick failed but deliverately ignored.

[3] https://lore.kernel.org/20261107054658-failed-6.1-cec08aad3def@kernel.org
[4] https://lore.kernel.org/20261107054701-failed-6.1-1bfb9384ae0e@kernel.org
[5] https://lore.kernel.org/20261107054705-failed-6.1-6f276422aded@kernel.org
[6] https://lore.kernel.org/20261107054708-failed-6.1-a1c7fdaf1657@kernel.org
[7] https://lore.kernel.org/20261107054711-failed-6.1-409d2ab6d982@kernel.org
[8] https://lore.kernel.org/20261107054714-failed-6.1-1d2397b2c414@kernel.org
[9] https://lore.kernel.org/20261107054721-failed-6.1-1c3352282063@kernel.org

SJ Park (2):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/core: remove unreachable damos charge_{target,addr}_from

 mm/damon/core.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)


base-commit: 807b0a2cf04f7d9b6d42d23f5e63915fb80a54fd
-- 
2.47.3
