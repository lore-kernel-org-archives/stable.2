Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F53DDCD
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584962; cv=none; b=Khrwk+ZjNxI3sB+95yffrpEH6h1mD8RQaVGAzU0UvHt8yu/x9Rk9AXClvGMhyeBREbjdwC3aGIzV2YhSRxYfm6p3yvGvdutU7gct5nu/J+e4ad5soBeveJVH1mcr23IIktgvbSi/g5TDjrDDcUDQlwHdyQ8mzrgnPQuXPLML76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584962; c=relaxed/simple;
	bh=4yyAcVknUicAHnNFBh0eMnF/hJea/MMAc1JgVYj7fY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utqnjleCagDIAWOAAH1n/we6NbLOVDv4RuG+MCdzP2BEYa7n2zW7Rmk7oW+dTDTaUALRe+eGdPdeAOZGi3K8dibGGNqoIRf9cvxJup/n8Y5MFdn75t6MbtbgeMXY3qdVAeFVtZtMysg8lgecOr/bFZRQ529DfUDLbK8hPVsatdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=TRhifgad; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="TRhifgad"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caced6038eso18657955ad.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785584960; x=1786189760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/htim8H+8x9oNbHl26vDUAIesN+LBlNBvkdejEDGrc=;
        b=TRhifgadxAPmJ8/U0T62YS0UNymQDKERmTM6pNtHE//EmZ1tJ14HN23Q66I1ZIRlZg
         q+RD1DyKETOEEsNm9nQrRhCW36JXB9Egl65uJo1e0FzzXl5gAE3aLjgduWk/itkNe4py
         xFa9ac3gz9JilSRxQ3vmk8+s689CWVwiL/dN2e2CZCuitH19daimUhsqItQIsMObjQvc
         Sq8+4UteJ7R8Q261nRkBX8f/Kf2SWpH0ryxLrPrVMcUYxtvnlX76xAyqBUwAVwvBFqa6
         BcUOR6zZmgGSwDE88gse0jPwfzD/ih/nzG/sYDIIn9MKN0oCZviiSCRR6EtU0MGCgXGh
         8/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785584960; x=1786189760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/htim8H+8x9oNbHl26vDUAIesN+LBlNBvkdejEDGrc=;
        b=IUjon5tdRKYwSYEX3tk0o/UrHH8LUYiceXetJEevFcIbmBZcJMrhfuvkuz0tLng02H
         tQksW2FgPDnvKZJbbsWxDby0FYx4deSD12ILOtOy4LBvpDrGTPCkUPCq+H+XyktByF1a
         0eL1rpwfQ5L0mbWc046cMgymgqeakEE3iwuIliTcrXkIZFH6YQBswrC7aWWSWKKGjXXE
         W8CdUTP2X3jHWnOg4VuPFdKfBPuiIThMEMypJEpbAy0DnSc8/weayuNHBmARHMGAzPxB
         cKncRlIMRzEiRxyRlsNmWexDk0sDwdJHmorqtxqipS5tGXOX5BvqEXFcbdZlD0PZ+HR8
         oYKg==
X-Forwarded-Encrypted: i=1; AHgh+Roy5eb2DMpbxnjmGqaohwSgYqhZDvEFc9tZvDDPIv7MXTzISL4HxwkuTkv0ShFIAAPoP8FBJJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Tuj94xN+EYIdlOvZH0jpYTWNNL0e/lfPyQyP8WXmM5UNMEn5
	UVqI40xuW/q3DLNk9KU4PskB7VDap/PSqLGMQH4UJt1JS2dkTGIe6Pyvy4h57mtv9NI=
X-Gm-Gg: AR+sD11rU35o9BofmHJ4y4O/0AQmFBLPg5Tls8HW+DxCdEo8Zy+2lrKcEWvdx2e7YfM
	cgQ7iyLloeM4Jh/kP9jGVdOwkzufy6MuAyeGXJKauSVi7l+el1Wo2Yv5pKykhnoZzIgl+a7Teo5
	hFF+NrWdBHAtGlJ1VMXrecnQM/+/IZ4OLAJ9bI+UpsGBko3dEpvEXUizcNmGnzEfh3WeVTPaFqr
	oCnKi4Unx3MlNt2rPzy+CQ7th/h7PmTtqQAn66Di+ZqyvoPKz+5rLlpCP2tXZuQMJ8vO30o5EyG
	gCmtJ/ixGQchlzTonTj/Da/HMdT8aYesSzX9YGkDQAu2X+cuxG80KR32TUnNTHjKy9FrfCoO2VK
	NwuC7A+zlHz+Gem/kEpWoi6xmkw+ciA7qojdhYP0+9aBuYpX5rucb+0tO677Xs8kLoYAKTMkYAj
	U3mI4e1eh/fXpnp0Pk9yzEI/C0rBcFedAevB47n8Oeq4KRTRAg3umLUb0qUHXOWouHARMOAorUk
	E6JlgpGilDHpiRIkqfikhPNIaS3GpmiS0fxa6xZq7HSE3PTvA3ZR0CMl5Agx626Y4hJ+qaAyFf8
	fwRsyETukvddmsw=
X-Received: by 2002:a17:903:350f:b0:2cf:461a:3863 with SMTP id d9443c01a7336-2d047e6fe24mr51267725ad.22.1785584960370;
        Sat, 01 Aug 2026 04:49:20 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3153e06f8dbsm16967624eec.22.2026.08.01.04.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 04:49:19 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: jjohnson@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	baochen.qiang@oss.qualcomm.com,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()
Date: Sat,  1 Aug 2026 17:19:09 +0530
Message-ID: <20260801114911.91483-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ath11k_dp_srng_setup(), the memory allocated for
ring->vaddr_unaligned is not freed in the error paths that follow.
Fix that by calling ath11k_dp_srng_cleanup() in those error paths.

Compile tested only. Issue found using a prototype static analysis tool
built on the LLVM compiler infrastructure.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---

v1->v2:
- Moved the information about compile testing, and how the issue was
  detected to the commit message, as suggested by Baochen Qiang.
- Add the release function in the switch default case as well, as
  pointed out by Jeff Johnson. Also add Assisted-by tag.

v1 link: https://patchwork.kernel.org/project/linux-wireless/patch/20260727105532.118164-1-nihaal@cse.iitm.ac.in/

 drivers/net/wireless/ath/ath11k/dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f389b97acbdd..be65d73b904b 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -313,6 +313,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 	case HAL_RXDMA_DIR_BUF:
 		break;
 	default:
+		ath11k_dp_srng_cleanup(ab, ring);
 		ath11k_warn(ab, "Not a valid ring type in dp :%d\n", type);
 		return -EINVAL;
 	}
@@ -324,6 +325,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 
 	ret = ath11k_hal_srng_setup(ab, type, ring_num, mac_id, &params);
 	if (ret < 0) {
+		ath11k_dp_srng_cleanup(ab, ring);
 		ath11k_warn(ab, "failed to setup srng: %d ring_id %d\n",
 			    ret, ring_num);
 		return ret;
-- 
2.43.0

