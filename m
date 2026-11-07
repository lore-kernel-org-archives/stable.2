Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090131;
	b=iI9pS7pq5OXNOHTt6iFuQwtN7H15C6eyztu47UDiyn8zQ5yi/KSqFfXbujx8YqI4FSuV
	 AJpMEQU3g+lAHeTHsgEag0pn4xC2bEKXi3UZVilNqWzrykSF9mTXKjMrEI3DWSGipLkh7
	 1c4ASP2D+QJNZ2fTOj5UWonsUy0zcQuXPc5qZzxkRqpAjlqBiM79uMVtiAvEUXZZoeQvy
	 IMemxnyCKdOxOuQC10lqKCo9zjeT9Hax1cSV30pGfOqlZ2iIo6Npq6CbswGx/Gzd/xCIm
	 jMhIAWUX3Rt7fg35SdBQY/vsnOVU2d7130bFC/1m8SlPRkIXbprqRTvnry7D3YEP4HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oFyH1lXK+D22hmGRk2EUFASP4KJBcyjWs6rRrcnHQkU=;
	b=bzgUUZU21HIml6rblavsks6bJclAsnGE3RGi8sKtQIehBSox1UItCjFNuhqEgztyLBAQ
	 RktEIg87NedKLMcYvpaY3KlvmLjLxEP9ZH6b42bGhu/t7BrOt1T1pwUYgqvTYy7qbHb73
	 tC8cS1Oh/sITpPCc8nR9q1+nZzzWHxNwRKu0jwFlSmpNWRWCWT7Vi1QkTMwi3PHwjEFEU
	 K/cf7RJm+E/hKUFCjPKP4aZ0cMIV/xzOTASpB2hAvc083STDKQWw2VjZFUNqY+8//EJkl
	 jCGat2Gcvs868IE5LHfjNlvOZmGxfdaAKeKIkzCg+h33AH7Bh33Vc8/OY5FW8TWZ6zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPcfoW1k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B0606A326;
	Sat,  7 Nov 2026 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPcfoW1k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7944B1F0089F;
	Sat,  7 Nov 2026 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090130;
	bh=oFyH1lXK+D22hmGRk2EUFASP4KJBcyjWs6rRrcnHQkU=;
	h=From:To:Cc:Subject:Date;
	b=lPcfoW1kLglj1i6JIN3nPgQGGSRI0kGogIB92HmszE1lxF9XvVJLA08EG7T+wUvXY
	 hmCvBQLap57JcbniUzaGg6q7caY0NXigaLeV2PYLCH6ppcAPphz9EHwEmWh0MS6OO4
	 t9OtWKorGE83GpQeer47a8uum2Y9o94AY6hw02VKRgVR6XVfWysmNhz7NLggvMLD4V
	 9Y9VYOSuzCVu8dXMYrgmfyg4yWixOz+Xw+cekNA5eDyirDRjyVfIuPVqTOKYoh/cl0
	 8yRrR4pQvQvWnsdmCFGdB0v69UpOvGRFPRvCstQNhYloherKXePTOSSTa/uCJfQKqt
	 R+ARw87afnLlQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.6.y 0/3] mm/damon: porting fixes that cherry-pick failed on 2026-11-07
Date: Sat,  7 Nov 2026 14:21:58 -0800
Message-ID: <20261107222202.331476-1-sj@kernel.org>
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

Manually port three DAMON fixes that cherry-pick failed [1-3] and turned
out to really need to be picked.  Note that seven patches [4-10] that
also failed in the same day were having wrong Cc:stable@ tags, so
ignored.

Patches that this series is porting.

[1] https://lore.kernel.org/20261107053211-failed-6.6-90c2fa6adfed@kernel.org
[2] https://lore.kernel.org/20261107053907-failed-6.6-bbeec2d8324d@kernel.org
[3] https://lore.kernel.org/20261107053915-failed-6.6-5695abc4e742@kernel.org

Patches that also cherry-pick failed but deliverately ignored.

[4] https://lore.kernel.org/20261107053348-failed-6.6-6f276422aded@kernel.org
[5] https://lore.kernel.org/20261107053350-failed-6.6-cec08aad3def@kernel.org
[6] https://lore.kernel.org/20261107053353-failed-6.6-409d2ab6d982@kernel.org
[7] https://lore.kernel.org/20261107053355-failed-6.6-1bfb9384ae0e@kernel.org
[8] https://lore.kernel.org/20261107053357-failed-6.6-a1c7fdaf1657@kernel.org
[9] https://lore.kernel.org/20261107053400-failed-6.6-1d2397b2c414@kernel.org
[10] https://lore.kernel.org/20261107053402-failed-6.6-1c3352282063@kernel.org

SJ Park (3):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/core: filter out damos address filter-split failed region
  mm/damon/core: remove unreachable damos charge_{target,addr}_from

 mm/damon/core-test.h | 11 +++++-----
 mm/damon/core.c      | 48 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 13 deletions(-)


base-commit: ba98b310288deb9f3814fc8f80d8a33ae0f59850
-- 
2.47.3
