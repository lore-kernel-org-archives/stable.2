Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313002;
	b=kMqId9HepMeB8Wkulkh+ggAcC1bjFBzEj3cpaob39JL7NCdlcecBkN6DGsiGRQRIWgj/
	 nmgtJkNtWWkdYwY0s6zetUyor3A4JDqT6Zg/cpeGltKQ0R1FGRjnjWUJLg6dyRzOC8UGn
	 i+yHDvVEh1080+T4vuGquOLEm3kGQ8CCkHNfl8FRyFACJmBVgMfdB4SlVVOFgHYIGaGkl
	 Fx1RbPU1ZSwdn1cjFyLXQpUqlix919QQljVvT/t6ljufOi2LbpP8IzOeAGpdHiD1t7nSU
	 1LlOZB8k1gUFiBRhBmLnEAZuHHZ/MBmpH2vhiXO6FaaJhhzZ8ru9Cuu0fucllt3o5vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+aktWRoGit5nV94N44Sm86fVZitGc0XsKrr4MgAGGVs=;
	b=t6RN5H7pdt9ADeD+nYLZ37ZVE0BHn88nQIeuHuoF+45H603rTQARb/IwpYQDvAZ+0bY/
	 EczA5GNwabqVostzNKVoIwSuxlCsneDSlurkiThVaSdmVZIry8++83FDC5sZZAcIvr9B4
	 CbYnJoyxkpGf6zvGLtwqnns+TZlPpfnVHuZNrtaWwekwui83OXW2QxCzB2HErr7qCmJC4
	 md0aS+sZAu+HKnagauSR6BTRP1GHNEt4yegLCkh3j4spjWEKAbpPcEd8ErIOv7FYQjYx/
	 OR/oIMYcijlDmCI/i8eLJzBGDBas3OEjq5RTx5Lkd0tY7lC++DpmJHF83iSA/frmHaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9yCaSN8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CE606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9yCaSN8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9621F008A1;
	Tue, 10 Nov 2026 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313002;
	bh=+aktWRoGit5nV94N44Sm86fVZitGc0XsKrr4MgAGGVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9yCaSN8zYo1WsnSBpd5DXc8YcfZLT8wJ8M/Ip6yVyihuzb9z/ULZRB2u/Hp5Wrku
	 W3+8B3CCIiFNbZWGxhWoieLradKG5Bz7s/9oKa8a0ma9n/FrZHARxFZ9/Q+6WKqehB
	 llpjKozZ+xotlFLVcGScDHDhlMoTXlenKgiJE035+qUgnQjwqh5chVcQFDMmUq8RSC
	 wfppFss9MrGc8j1msLZqgJrylSnHKZfZvrzrdiCqKiyAzWPvo1R1Zh7Lp/Pq0cq1L3
	 TE2o9dITHphrgtTGljxDRPnE5vZdxjsaeszSdyZeHXrSAy6AsAiJZ4MLmUV6uOxjOT
	 Q6+1KRbgAZW1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] udf: Make sure there's enough space for LVID implementation use field
Date: Tue, 10 Nov 2026 07:16:39 -0500
Message-ID: <20261110121632.1067415-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121632.1067415-1-sashal@kernel.org>
References: <20261107061427-failed-5.10-a61fb39759d7@kernel.org>
 <20261110121632.1067415-1-sashal@kernel.org>
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit a61fb39759d719a4f4966742b4d28387e33d81c4 ]

udf_lvid_valid() verifies that the LVID has enough space for all the
tables and the reported length of ImplementationUse field. However it
doesn't make sure the reported length is large enough to contain
logicalVolIntegrityDescImpUse structure which OSTA specification
requires. This can thus lead to accesses beyond the end of LVID buffer
for suitably corrupted UDF filesystem. Add the length check.

Reported-by: Yunpeng Tian <shionthanatos@gmail.com>
Reported-by: Gongming Wang <gmwgg05@gmail.com>
Reported-by: Mingda Zhang <npczmd@qq.com>
Reported-by: Qinrun Dai <jupmouse@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 781d2a9a2fc7 ("udf: Check LVID earlier")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 58bc19b82afa4..6994cf6a09d66 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1581,7 +1581,10 @@ static bool udf_lvid_valid(struct super_block *sb,
 
 	parts = le32_to_cpu(lvid->numOfPartitions);
 	impuselen = le32_to_cpu(lvid->lengthOfImpUse);
-	if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
+	if (sizeof(struct logicalVolIntegrityDescImpUse) > impuselen ||
+	    impuselen >= sb->s_blocksize)
+		return false;
+	if (parts >= sb->s_blocksize ||
 	    sizeof(struct logicalVolIntegrityDesc) + impuselen +
 	    2 * parts * sizeof(u32) > sb->s_blocksize)
 		return false;
-- 
2.53.0

