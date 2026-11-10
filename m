Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312641;
	b=COsNK8Yq3xWNGj3yK4j5CKEhQKWjgbrBgv1OTlnU4Uo9F87GLWFmVge44mzTfG+RY832
	 /1bOv9AhwLgtyiB93dljKivyFB2Hc4fS3TcKA0kXgZCLaptEcshnlo9D8+AvVGmsgKzmA
	 uKWi1i3JtHELQUmEGYKcZCsXhS/JxLcMMlWriCPGPbSeK0/fdBVvL9kGTn0bY1p+Qz5Zt
	 5PUwO/2fFGJ6X/jHkrV1PeUWUTtnOz0cDvyUGdavZ3Z7DGk318E5BLIzVqTNyDFRx2aTZ
	 7W1qq8xYfO2popEulU4kNd5+4Epoa4gpVl/OKjO64x2JZUBueKmxTrwqNlAwD+hPBiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kHUeGlyC1eB7IOqu+eOnOYNVXmgNs4R0Ze18IPK34Zw=;
	b=id3CF+vv2FFI/d5eKvs1jx+iWuweqUv+r8mxI6xJuHX7JDOALv9ztv4kAHQp3fUk637w
	 stSZFC8qb+t17wzSuI0nwJNmKvXplEGQLRy2u/KWG/LzGj1Wd0zuP5xprh1qZf9N/42gt
	 Ny0AqkBhGGXrdAd/makX5T8F8yAm5aMPDFEOuCkXVq8tcABH3Pm97wFcaLRRQX7+uYA1c
	 xlB06WulbewL4NsSec8qF4ML05RtqwRDLWbafTP4uJI8jpswG0FNwCdUs/hWWNGN28/vm
	 r+6hJ0rEETof65sZ0emJN4QEu3ixZ6gsgd8L7jgg4gSngBnXc7h1R6LsSv2VV4WnxWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkP4djRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A68606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkP4djRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2B91F0089F;
	Tue, 10 Nov 2026 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312640;
	bh=kHUeGlyC1eB7IOqu+eOnOYNVXmgNs4R0Ze18IPK34Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkP4djRl6uZhEfGWmOA0vnYLnpwALEcbklCBPqIZETz5vi8EI77y8za8o1yoq4iY1
	 lITGEZK0gU8AMiFsvwv9BLZMlYQiUwnDdtvu/a+4J6Wc3cRXOHYNp0Ac4w+MLRwW3q
	 i/xE7wMV4hMRob04buqaFvCpLNAWdWeethvtB6j+EIBWv4kGOl4M97muQwPql7Lh4X
	 b0vNOJ8cPihasntDHtmfEEXeqGoEpOn+47Tm4ZKYUBiAHM3ctMqfTKfnZH2ZF4bZac
	 RPclGOSpSNfBS5YJIb28K7PH1uMwDQVvGqk04XE/RapaNKbgGjhj9TA/k5/YMwv2F9
	 qGIcu8DvQxk2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] udf: Make sure there's enough space for LVID implementation use field
Date: Tue, 10 Nov 2026 07:10:37 -0500
Message-ID: <20261110121023.978616-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121023.978616-1-sashal@kernel.org>
References: <20261107055724-failed-5.15-a61fb39759d7@kernel.org>
 <20261110121023.978616-1-sashal@kernel.org>
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
index f9fe3f950de85..6857c15f5a0f4 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1582,7 +1582,10 @@ static bool udf_lvid_valid(struct super_block *sb,
 
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

