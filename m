Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669770;
	b=nW+krRjh65zcfS27qauq4acS+o4UoB2HIWI92TyUB7wS6mLIN7ojT31P4keElcFsO9p/
	 DC/wLa6OMcWmSZ7yfVVopQ2USOgCGOXJlcHng8N+grikta/OsqHncgcXBUH7/MHBdJhCs
	 u1KZg4hpswbeQo2gK+J+I8oSbo9K+5AxIteU7OsaCW1MGx7XQQNTQef1G/gxSeh90NE1U
	 W88DneZiXsnjVwcfkBCj2i06xRohVj5ase2eYJXN33ANp47++Xthxf0/NTPUkJE/BoCq3
	 QzTwnCs6T1Jolg08ZWtSZhO/tqPz3ZndJebEEWGY18VL2G7lzDBz/SpUswxwSMGP5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669770;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zAsdaZRGsLmiT5zds1ArUk9LqIdColIf6n/6TEPhe0g=;
	b=YsyN9r/0VArRkjfpIaiySn9Zn9vq6SkUV5Htv8OYaCz22BZYrKe+Roz3c6sTDtq40drO
	 MVJ/DQwr6VX87Jg/6JxEA0PpSx0ES+Mwy2Dy2cXjKbPv5SWZS+kUk7clfet4BQPkJbF35
	 Tvy4UMeLz+8WFc/lRbi0g076mIZCiuLmrjX2UUh48xPOOFv/i+J6diX/QcWEI2UIE5u0F
	 dALj2J+5wWUFrwRWLwpKjNOGDtwYLwU6eWUnwYwko9DEYZXNs5yavnLp7BQfrlVeQPYgy
	 2a3lkfPl19orwW2UY77ZTSWxPIBKzrFbQBic1/3sEQZrEWsS3JtpkQ6HLlpOBV9Pa0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bb/smB0q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC50606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bb/smB0q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9191F000C0;
	Thu, 26 Nov 2026 05:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795669769;
	bh=zAsdaZRGsLmiT5zds1ArUk9LqIdColIf6n/6TEPhe0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bb/smB0q6GP/iKzLFGNgH4YM9Tc+2ZDMI6BdRyG6HXH1E5HqDrDsjqOOIAvEI4b8j
	 J8314GS4q07xFp8WR0IVX6qfN1vFCzn8dY9MQo60MIBOsidrsP3gNMpTR1AmI0bA99
	 FG1rD7St34fLn4vJIgnW1/iM9QdbrnlOBT3nM5ImQbFKNXa34Y1zZEvKDofTK59n5M
	 t8ic5RHdrZDlsBJsr7aBLF6/bpWh7Z7hqwScEaLgpyYWT7vdd3Q+ecMYU6XwO/bIcP
	 aTlF4vqcogNG7zpe7galG5K+0nOqp1w0N51v/SfFku9mB7YUkBXKjBa5q91TFytjIA
	 d0RuNyto3G+lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] dm-cache: remove pointless error check
Date: Thu, 26 Nov 2026 00:09:25 -0500
Message-ID: <20261126050921.2111286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-mandatory-improve-2cc3@gregkh>
References: <2026112510-mandatory-improve-2cc3@gregkh>
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

From: Dipendra Khadka <kdipendra88@gmail.com>

[ Upstream commit 4feb014bc79a42485b15bc3912dd3b0bca592520 ]

Smatch reported following:
'''
drivers/md/dm-cache-target.c:3204 parse_cblock_range() warn: sscanf doesn't return error codes
drivers/md/dm-cache-target.c:3217 parse_cblock_range() warn: sscanf doesn't return error codes
'''

Sscanf doesn't return negative values at all.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Stable-dep-of: df8daa4d916c ("dm cache: validate the discard block size before narrowing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-target.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index d209b46fdb6fe..69ab5f9a33483 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3323,8 +3323,6 @@ static int parse_cblock_range(struct cache *cache, const char *str,
 	 * Try and parse form (ii) first.
 	 */
 	r = sscanf(str, "%llu-%llu%c", &b, &e, &dummy);
-	if (r < 0)
-		return r;
 
 	if (r == 2) {
 		result->begin = to_cblock(b);
@@ -3336,8 +3334,6 @@ static int parse_cblock_range(struct cache *cache, const char *str,
 	 * That didn't work, try form (i).
 	 */
 	r = sscanf(str, "%llu%c", &b, &dummy);
-	if (r < 0)
-		return r;
 
 	if (r == 1) {
 		result->begin = to_cblock(b);
-- 
2.53.0

