Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350489;
	b=wCT3a1AUnVHOoss9fkcqPEEQZuAf5w6zerFBi3w3MLPKqo37dbvXIlh7IgY9jgxAOvhg
	 M0E715nfZ9phaXe69FATtXY3JYH7KoJwj6a+l+pGjRHVeIH+Z7y9mG8upsh+rmWA2Yisg
	 CE3JvvESUzmzBctQp26ut79R6GMAsfCXAW+wcXKGc+1I7/ygVwHNr4xiXMkrTLG4kZ+Gg
	 7D984D1nxQgx29P50Mrkl4/hMYD7ra3sJuGWRdIz7rhLjP6jvFHB9pKVokm6p/DECqW7b
	 9PRknllGz/FMnG6+0WgmflvpaRz26wIf+kV6RvtKXe7xE5U8dXtfAwitIvxWpf4l1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+qnt9z5iVQf5fuDUN2dlVBxlAwceMcWK6DxW4LuqhIs=;
	b=TPGuCVwJHtTFDOgWU6FlKXoTmvciierNsOtXfCvWMz/pWUdwZK4uN7dqJQI+ilKKJpUV
	 +on9ua0Vs9C9CscgmrOPtR3lxpZTG+n+acHtjEpeutdLqTvx5fU8Poe2qrQzOB9y+AvRT
	 4F37XEgOmxXh3ND7suGqYtrVMi25vl6tT6BsG+mjqERJPuypjIfU/rzN6hqLJ3bi343wE
	 qYTgBEDzDvpU90KsvAIIWeS1M/f9pI5GNaN2PTf13rrDMn2R3JQRFrr8Ds0AYsgMyF9Pz
	 pnWabyKByeTV0v6XoLQJ5RyO6S79cwyu5e0scCeb+vBgXOv+877sfZkLERf20FEJf5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCuP9m9q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7531606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCuP9m9q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5571F008A2;
	Tue, 10 Nov 2026 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350488;
	bh=+qnt9z5iVQf5fuDUN2dlVBxlAwceMcWK6DxW4LuqhIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aCuP9m9qXQ7tIJFRXdwQQ3B1Pd1wGH4JUD+kE1ibORIyFFPcFquIDtkqYtLDYMrb0
	 DHuQqmtcNueW/6NNmvsx1PC54WEq8u7IIaRyMmvLMBnx+e1GjMEodVj7XWlUB8muDo
	 DeqX1Oxq7lo5mgKU1FJJ0CwvvgO32MiKtaBPkd8Y71ZlZ37t24BZTJ82ThDsUgrmH7
	 OfGJZlaBWMhGujd5dXWf3bcTFNTIQS9LEnQ/VfEt+DEqm2bZ2Tpo3YIesncmAgnlbB
	 r2OPxHyPUb7bEhQe715Qc2+F0zOQfSPuLRbMpMpBt2DPMPd1+68bpOlAExRVlYeSxM
	 mIIFvJidSqndw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Yu Zhao <yuzhao@google.com>,
	Alexey Gladkov <legion@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] ucounts: Use atomic_long_sub_return for clarity
Date: Tue, 10 Nov 2026 17:41:22 -0500
Message-ID: <20261110223252.3777469-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061036-failed-5.15-b14fcabd34e0@kernel.org>
References: <20261107061036-failed-5.15-b14fcabd34e0@kernel.org>
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

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 32342701b4ba57a6fd77e8aca2f65f68c0fa1da6 ]

Decrement ucounts using atomic_long_sub_return to make it
clear the point is for the ucount to decrease.

Not a big deal but it should make it easier to catch bugs.

Suggested-by: Yu Zhao <yuzhao@google.com>
Link: https://lkml.kernel.org/r/87k0iaqkqj.fsf_-_@disp2133
Tested-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Alexey Gladkov <legion@kernel.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Stable-dep-of: b14fcabd34e0 ("ucount: take the rlimit reference before checking the limit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/ucount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index cc8ec071d46d3..a751fb6e94e51 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -279,7 +279,7 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 	struct ucounts *iter;
 	long new = -1; /* Silence compiler warning */
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long dec = atomic_long_add_return(-v, &iter->ucount[type]);
+		long dec = atomic_long_sub_return(v, &iter->ucount[type]);
 		WARN_ON_ONCE(dec < 0);
 		if (iter == ucounts)
 			new = dec;
@@ -292,7 +292,7 @@ static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
 {
 	struct ucounts *iter, *next;
 	for (iter = ucounts; iter != last; iter = next) {
-		long dec = atomic_long_add_return(-1, &iter->ucount[type]);
+		long dec = atomic_long_sub_return(1, &iter->ucount[type]);
 		WARN_ON_ONCE(dec < 0);
 		next = iter->ns->ucounts;
 		if (dec == 0)
@@ -330,7 +330,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 	}
 	return ret;
 dec_unwind:
-	dec = atomic_long_add_return(-1, &iter->ucount[type]);
+	dec = atomic_long_sub_return(1, &iter->ucount[type]);
 	WARN_ON_ONCE(dec < 0);
 	do_dec_rlimit_put_ucounts(ucounts, iter, type);
 	return 0;
-- 
2.53.0

