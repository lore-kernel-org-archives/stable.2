Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311797;
	b=KjXb2txZZ9gWGhIvXg0tjwTvgmVtj9N+ZNSnqpxuZuuGCWAqYAXXcg3tJgoFJV4Ib8Wk
	 jSnqGN2X3KiRogdxDAjGrmlI5RX6j9hgq2GgQJdQCDBqDwgFsI016Z6uNNlL7ccELSNqa
	 jOBhHAZyxekh04JQO3rBntg/EmhFfNRbNO5VyZBVV44yyQxAni/wOkd5VGXqMMQ8WqThh
	 eIuu6cvjFLBA40WWXFQTruzQ+o9hKA60a8qwfT9hrXswcCouDiW/4t5FNqr2LL+keZ5yB
	 3lL/E3Cit85Iba4LkCIe/i+7uZo3PUQnQjK2PkNKAc+i8aElhYJn9HFwmDN33qpdCWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iPdoBRKyDaV4poBXYoEa6S8T6oYCIbQ0TgoRnLNBvco=;
	b=ToiGgtt2YeCGv4I6GO0F6VmDwVvviUkY8e/b9+zwJqbW6SdJqQf81pA7SwmAz+2WhFZM
	 De9GeUgFm145pclSBAfHNeWqPHkl0MYJekoCuMTE6YAvSqOSBuvHcz2jBLNscvZmn6ner
	 ATHn8UUxb8w/J+Qo8EvYODAltdrNk5WJCooEq4/y9yqMRyey051x6EsTvISfS0haBeN6b
	 T005ZNeQfGwtk8+xrLiDTR64XguJH7COw4RtShC4KJjpdlAcad0XqoTFATnHeOslKvUYl
	 tfDSAsYkSxYmYdybz2uaBK9rPMCT5N/LBqYifPGBkb2vnC3sZkZKvwwbQ6CI6q2yS5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dox8atky;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E526606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dox8atky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0561F008A2;
	Tue, 10 Nov 2026 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311797;
	bh=iPdoBRKyDaV4poBXYoEa6S8T6oYCIbQ0TgoRnLNBvco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dox8atkyRGNqPr8lvz+ICYWwHKawZOgC+dVQ5jshU2fe9CMmy6MzTmF4NK/inY+0V
	 GkEl8mMyNZNCw3nU8RTHNuXFGBIJm4yX1STqfQmdCXyaMtPIYnu+krts012CSI1VTK
	 W90caqBSZ35nquQeg3Z9eOmATJT+SlekWp1zKZ8JEb+OCAaWJwSN8Qik7lR4Sh9yhx
	 QAKgaqrZiwZE3U1AA95VHiMG9OkZ6VwFCChJAoncKf4LmAZzp2pjJ+4MO/5xsE84yV
	 WlG+hn+FUlxGb295i+8VE/iBZSBezg7b7SaxOSHwJfq4w8uIzxGpT4y+kASWfhOrMj
	 7PLe3Wtp4IzQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] udf: Make sure there's enough space for LVID implementation use field
Date: Tue, 10 Nov 2026 06:56:34 -0500
Message-ID: <20261110115625.906950-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115625.906950-1-sashal@kernel.org>
References: <20261107052823-failed-6.6-a61fb39759d7@kernel.org>
 <20261110115625.906950-1-sashal@kernel.org>
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
index 67c9111624d84..7f71ce6b9b491 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1657,7 +1657,10 @@ static bool udf_lvid_valid(struct super_block *sb,
 
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

