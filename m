Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B83DB620
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655294; cv=none; b=rBydFcD8QRU6Zfg7FVtOrXsVi5XYpp3348KJ9OwcOYLdKE93agZdBaAgUc6Sadf4GfJty0av7tA+POrgOMOxK7qvl0jcC+B+47oCkSxZAmcakKyh2cNKBfv9Gd7bksP/+UX+ijUqLFaJcMJhCFc4JwYBW4BwrLUcid5pB9GFsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655294; c=relaxed/simple;
	bh=cFXjq2JXCSfmvvjsjl7kaIwIGpfd3uICNYyzTRRVr6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OU7WvCOf+Jo5MljZe7XBs7XZxB9tfWQX0RGY9OmtBzUETNfaCvb+ln0PbIQLHLTg3dUorbUgt0Dr8Q088GM5/k8/N7S/iuJFM1MfT8nOzOa3owCW5R1PYi6dEaTwO6em6YWg0viBAONaHf7D2w2cE6d+JxxhoqtXGGdCFyJT1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=U2qJSkGL; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="U2qJSkGL"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df9754484aso18046315ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 21:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1790655293; x=1791260093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/00Ko7gZUPuAiTpJB4dBnk2KXfjE/uS38djV/L4NvE=;
        b=U2qJSkGLwVHNC75N3D7jHJg6yXV34LZXxTC1qYxxz2WxEbXt/G4Ai8Sb6x18hcbyDj
         UJWewIbqzQCXsom078jmIevHvMWaTLYNWnkPBGzhxEWYl8ozBK85lzx77xxTxo2O7aUS
         axhS7hTfDqSp1CLVlYUw0ryWS3cMozc7uD+iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790655293; x=1791260093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/00Ko7gZUPuAiTpJB4dBnk2KXfjE/uS38djV/L4NvE=;
        b=rBl2pDC4OFHWDflcb+rRcxY2j1RjVe4pugz5x349kIfy0sjGnr2SH3+9MPEn0IJKR3
         XqZ48HLbP0DdXd3slAi1ic55A54ZvI8oqiYnMZNKlfLZ1pSE0C/eNjtsOuf+1T3vAoHF
         88QLQaW59aCgfl3nRRyly1z24GKN2CQvWTsGgThbUUbkQRcPiQH/W6ENvupsc+LlRxqI
         urzQau7p3Q8tvS31JPDHiDZdnmNwpsCeJbi7F7FrOBDIEC608MU02I/Z9fFPULPUl54l
         uWd/egO1ClDk/9X3UhjboFy2qYB2bROx7o5No4ZH9sYoY7yq0kC6nwinYwOxi1w6up07
         6P2A==
X-Forwarded-Encrypted: i=1; AKwUvBz6D1cU1I/5W259ZQOpd5c+b2PT9dX10uQ2Xkx589RbHVXKeDmCOWpC4BKiDHMCi1wOC7A9U0c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuYhMmj3zUGrBxgt4iD4F06IWJQuJCHIQFU596IzeP404/7C65
	pzqMjQhRJNOBmeUlbRi6hHIizDTp1t087lIYt5UCRkRb91mXNSsUjTSHZGiLzG/IJFs=
X-Gm-Gg: AYBFou1k4hnkCKeBBZ7YytjSHnECxntyTc36UTX5juyHlSxT0XIpc/06nClEhEFmpmv
	dM8wSlMxvPGD3kNuKIT+JSd0wUKamtST7gLnOFyw95WrBmIgd9bV4FHCROfUA5JTLMS2KWc0BP/
	VVkK7DkXWzuHRN3b58k98jGzCYmlnYLTre9Dt3XskYUU0h3kNtBKkGoQ/fZK7nIUd8VSC86oHPk
	N9hiPVgDomT0T8b2/3Lc49Bnv5CxqDstQKtO0KDcgrKTUbEx0dn3PA5rzEUWZxaWR1I9jvSK1ky
	7/mr2VPtgYlgbBexWNaHdMK2LP+tBUOzFxehl8H4Z3RlfIfV9S/TL4byFv5P2Gr5L3SF+j/cMGm
	Tx2CbvGdRy+An8vWTiK275LEXM+fvJzDS0nTbc8xmP0fuPj/5y2sScWLdsTJu0NuS440O0sLU26
	A6R0LQpW52oRNltCla7wjrWpYHxnGlLDA6WRPq6hvLN7R8jq2bYTb9W1Ea+PAhwL/H5/VS19ror
	6WGqLHrJrNmc7A9hJEDtlXkaP1GM6oXDdHL1zaFHAho08jUoeyGoXpUw66nYOlRJ/J4rTFwpUMP
	+5IFAxZO3aYgYpfbJTCaIUMP7hebgHPiX0KTnQ2YC2QxSLKLV0zBprTPazbOta+D+GbN53YPVWx
	3nwtFAhJgfUEWg6CRfk86A3uwPgbiCOF8f7SLdyknr6A=
X-Received: by 2002:a17:902:f544:b0:2df:98a2:a2e2 with SMTP id d9443c01a7336-2df98a2b3b0mr90144685ad.30.1790655292825;
        Mon, 28 Sep 2026 21:14:52 -0700 (PDT)
Received: from aegis ([175.158.243.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2c6f46976sm3192895ad.22.2026.09.28.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:14:52 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
Date: Tue, 29 Sep 2026 12:14:43 +0800
Message-ID: <20260929041444.9837-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
SE_GENI_CLK_SEL") allowed GENI to use 32MHz clock. This changed I2C
timing, making the Yoga Slim 7x keyboard (ITE 048D:8987) unusable
on all boots, and touchpad unusable on some boots, resulting in:

  i2c_hid_of 1-003a: unexpected HID descriptor bcdVersion (0x0000)
  i2c_hid_of 1-002c: failed to fetch HID descriptor: -110

With this change, t_high_cnt 3 and clk_div 4 gave a tSCL of 375ns
versus the previous default of 521ns, however the I2C spec has a
minimum tSCL of 600ns.

Restore tSCL to the spec with t_high_cnt 5 giving a 625ns tSCL,
verified on Lenovo Yoga Slim 7x X1E-80100.

Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
Cc: <stable@vger.kernel.org>
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 6a39e21d5ed4..1336a09ca183 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -193,7 +193,7 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
 /* source_clock = 32 MHz */
 static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
 	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
-	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
+	{ I2C_MAX_FAST_MODE_FREQ, 4, 5, 9, 19 },
 	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
 	{}
 };
-- 
2.53.0

