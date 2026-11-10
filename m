Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312241;
	b=fCKEA5tDkrNEr6GY9Mnvkrth7rEKVPnDcT3Fqs14tjcucxegjAcxNDXlSW7Lz+drN6Zc
	 JZTMPeZ/p7KIb1LGTZdQXSdG4tpmhVTRpzn7Z3l3Aww24IkwY1UsJDeLj2fB62z+/Hlgg
	 vrCUfL85/+5YQfHZY92mYcp7HrJnFr/ATVn7RunXZ3IyXCgDIO9bfttKX3PN7Hq9/ijfR
	 B9OXQzapYnayrwn+s27DUD3ov+Xy20IgxWMjqYJrfbehvJvzNHJtikS9xKm7QSkX8oIIW
	 UHitkTCI9R38ZmhrkBxgQNSH2nFmyC6+EYP/U8kmM3nvR78SrWmywV7v+SwZ64oqL8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hdJt269ooI0EbQDFV+H0h7wqhjYrr6zMU5FC6j37kI4=;
	b=s9CmAgLYE0PrhNrt84kcNOPP/YHPPLaKhYWZW4U4cXq24Vfk5UVls/vAUrjg7U5vyZYe
	 c7UzrvIll8Km0wdZRdp6qpk1xXuT+A+ZZVmTzAnjhTzkNtwFxyvyygWKTPhPprPMgj5Cl
	 jyktsGiy6YUpYE2fau8Ewp8reGIaHi5UAcYcMPBWKx3cBDMwhZTGFKWeVuKC9hq8ZoAWp
	 SIrPbRyltZLjSLioi9CziquoQ9OoIND1L5eVOlGxQfoCYIWYde17jVylVL4S/tETUBeWU
	 K+XaBi4ayD0RGribI08BWSmM2vCsfB46WiV3nrj3SbMed0tpuiJTGX8sHYiquUhvtGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpdPmSdG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F860A3815
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpdPmSdG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685081F00925;
	Tue, 10 Nov 2026 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312240;
	bh=hdJt269ooI0EbQDFV+H0h7wqhjYrr6zMU5FC6j37kI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cpdPmSdGI35tDYCsinZagGGVulQv2cFUKGytSARatYn7YbKxKWGtBN0aRNver7l8c
	 QQ1zgjRAN/AyW9kt3YuuihAdbuJiJoGfkQcM4iBXEgoht4FX6XfrbXe9Lk4BdlhRSB
	 dnfCw/2yPIp/6f2S16ZVhQSk7h8dGi2WAaWZxqTZaaCHgMkJOMKp+BpT9hIVuYEmhD
	 Py+RYduVzRoyRXPTDTIEtYX8w9gnySgZL/HVBqX1cix8dgdXRgc8Qmf3JpQXYtEBVP
	 JuwAJ+V8vjNevT0g76ehFKRbEPENSyLep94vWJTQQmgxkl3Z0GMt9IB7aSrLq7kL5z
	 tkiNIeam/+cPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Yunpeng Tian <shionthanatos@gmail.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] udf: Make sure there's enough space for LVID implementation use field
Date: Tue, 10 Nov 2026 07:03:57 -0500
Message-ID: <20261110120351.946680-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110120351.946680-1-sashal@kernel.org>
References: <20261107054056-failed-6.1-a61fb39759d7@kernel.org>
 <20261110120351.946680-1-sashal@kernel.org>
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
index b091cc98406b4..f924a814874b3 100644
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

