Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4C37F739
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271428; cv=none; b=Pk1K9pdR7cFIMKSNDHI0CFJxxCp6i21x8Jur25zPQNbE+fNRRgzNBDVNHOwFi+Zm3qNFMWPeicIQZIS8XIB4JR3Qdi5vX6Tc0IMN3/KkPO6QelqWR2wqS08e7IseLKlHO6iqaHAbrBRZ2K7JOcUwRqmbF3wB7d4Jlze1OtiZDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271428; c=relaxed/simple;
	bh=xeduSlkh5F/g1QDxornBkeh3jnYm61LoxT+eaLcg9ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuXaS2abjO3Dm36H/Ctd9NgWjS+PmokbDUYQhBnBfvdlJ+uQFeT5kVR9TBwENDKp1drWI3o3s5cOwCvcuubhhVqa5vQvKfg6CNhjj/OvdcB2jEPOIKZ6GtLT2EAuWdmpiRIXPDdWbq1cQnr1escuD+A1rkiyBazRpMiMRIHWJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQuF09hU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQuF09hU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1555011a91.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788271426; x=1788876226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxoZFsWluIEGR9m2/BmFPDYm372qjUJBFtS59WloRzM=;
        b=QQuF09hUGxQniiltnGO3fq03rWIJ0Oi/MHiOLGRg4mG8N8bWgL4068qbjSonMzVhVi
         hIT13YKCrd5b8fNcXROz0IPR9/0AbLdT486aGX+1eks4jdVhIvsITQ449Z+LWoV0RbCE
         0lkUCkX9q4O9MFqXoUWav+ywlctabLHMDLdlalKH0a1m2/zzcolOswXwndhbewL75cTL
         8vvCfi+xaWSzeWlawyg9I9LlpsUpP4cB3Ocbfrn7EteI0w+ib+uQlokBSsy5Ihip7Hza
         XwavEV4YgW0KbnC51Wci742OiGzr2ymZvyj2GyyYwRPgDiYD0v1k94c9jVF9zqoUHJBx
         I2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271426; x=1788876226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxoZFsWluIEGR9m2/BmFPDYm372qjUJBFtS59WloRzM=;
        b=UUwODubHqEiruURPBaGHqROjHqeL/vZ5U2XXOIHPHvbldLabtiVAXfN9KfBiGLvhai
         nT8woH7GQFFBi90kfobUeBarnmGXbjk3b3kVSTfBaX281E1xelds1BROjo+kz7XVVWgx
         Rneyscu8KPB698ihhlI6r8mbOTWSBwkKwDd7dBG2cNWdjHv7N9zLHWxxmqdmtx2B2UtR
         aKgQjIdBrr7cubXS/xk/XWs9mgg4jz0VSDCX1JOXe0yth3HVq0GhPbK5QAsPEbAEK56Q
         aR0u08UDD58S1ZXXr2G1/fQ+qn53ciQkiXiHctg3qw9ABoIrLPGHkF8JSLm8RvxCJOFS
         GPmQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7fxbpk0iGZas7P5gDVyb1riRzHE19T+0fOMKj19N02RNnbahyCXLdRJYfSDXW6h0O6E3escA=@vger.kernel.org
X-Gm-Message-State: AFuF++kkbfzcy9FDojpmzk4Jn4oZxGZoPgf1lmxL40B03RB3dO8b7FZ1
	VC+JlDXenh2PbrBoGkNCTgWrRRBT9Emd5glt7Ti/jREkGR5s9MRMATe+
X-Gm-Gg: AYBFou0pQouJZFQvyL3M7GwITQCoML8N2Ha2BzzbWnTITyxQgoXz9t5RdGuAnRIP/Ea
	HtqP4Gg+dX8J31u4MyD/JKIPSbJpl/J5jvcvm35/3gBxHUG54gjeQ0Z9YlXMG8kRRReLf4pXoKH
	XsXeSO+yvWaGeCjVwl0+nyH/GF9IhuWCdl+Z96HPQZHqU0sShImlD92IJ6IZSLiloDEi5EacMBk
	q+HjVZTjce2h/3ZC73UYqWcdg1uO994nsglcgWqVDrMrbKBQ4gvDS80CCuPQ5l+jcv0ZiOC8h1A
	R9NwK3oZbIrmM08hawkUeHchtDZGO494A+eLbE9UkrPwvO6pe6D7k01jxIZO5BSIR/vkWZoO1II
	1JHpEfKFrPi54BUQ2wwBe70D6d7t0tf5r37/eSKtlp/pFfi5jC9X2njpVrXQEet5eAvxaFrueuP
	1o+AFIH4cbIwhw5FsFYtbSfgRFmjiQ2agGY3ou6Ldq
X-Received: by 2002:a17:90b:164b:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-396d1007e54mr50590119a91.15.1788271426092;
        Tue, 01 Sep 2026 07:03:46 -0700 (PDT)
Received: from ArchLinux ([185.244.208.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bcf8079sm6872467a91.1.2026.09.01.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:03:45 -0700 (PDT)
From: Tao juncheng <tjc1437@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao juncheng <tjc1437@gmail.com>,
	stable@kernel.org
Subject: [PATCH] Input: atkbd - skip deactivate for HONOR NWB-G's internal keyboard
Date: Tue,  1 Sep 2026 14:03:36 +0000
Message-ID: <20260901140336.10568-1-tjc1437@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"), HONOR
NWB-G, aka HONOR WIN Gaming H7's internal keyboard stops
working. Adding the atkbd_deactivate_fixup quirk fixes it.

DMI: HONOR NWB-G/NWB-G-PCB, BIOS 1.10

Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Cc: stable@kernel.org
Tested-by: Tao juncheng <tjc1437@gmail.com>
Signed-off-by: Tao juncheng <tjc1437@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c8ad55f26ea8..de8edab3cb0f 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1923,6 +1923,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* HONOR WIN Gaming H7 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "NWB-G"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
-- 
2.47.0
