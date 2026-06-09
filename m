Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657423859E2
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994613; cv=none; b=mTJmbBZV9AXHh8+x5SR7JvBLMq1mPhYWZabX0pfcC6xo7a4UYYtGrxTwxSyqkRV5bkobBFQ+Qzjlk2+kIstuTqTw1zXXPaX1m5Z3FTGBH2TbhIM2yYaoMDHZEZP6PFBLDJsWDYldAOu1FSmhfMzC3jJG0Nf+cPGXisHIiLXxguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994613; c=relaxed/simple;
	bh=stn3ZEPLR1afpqAn0RrmIjAKSrCZN4mu3yS/RlOo3eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NVsWvZCKZ5eR+k3XHMD88Okksfq5EJXOwWB+Hq9WB0fdIHucNVlgkrppgCrMZVrPlH4PiKCOu4mk/MwGOOpLhxvB7meou135LGICSQ2KgNQJWh7Y/ksNuOrrF/oMm6ViJ8Vqd1ITs9bv5msFiSN6ZUrLD3b8VQCQs16J5AsRdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dsOCcKvB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hHVeKVR5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dsOCcKvB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hHVeKVR5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rbeB2034657
	for <stable@vger.kernel.org>; Tue, 9 Jun 2026 08:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yNCq2Ath3e/Fyu9ozR8E4s
	0geoHbdmxBpm5kJ3fmgVs=; b=dsOCcKvByTrHjuEHVBo3f7p7JBDN3z4008UxcR
	INoWtI7y8kPulGhU1j8ll91HA+D8ap6qJ2A5LtamOYzq7O3nhcL6JyU08PoRwFzU
	q07yP9J5+3A3Gn1ZaVohsBR0tak6dubm+KAh3wcYjVoRUVkvU/P5BaOZySNsWGUN
	fhwomfmFhwb5wx/sdoQGJVP67lMggtkw/D0pTPg+te9KDpyYQJMuvbqsFFWgsRdg
	YIhVkOAClBtu6yZp94BSg3I2C2EU1sCnIpEXgvwZzRIA/fjsSoJW4PmlUbmCfT+M
	eukD4nuZCC69nrl2vptnZYuxfzsZ3+vFCrMgkhj77kJbtxdQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeeara13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 09 Jun 2026 08:43:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf281d523eso40212915ad.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780994609; x=1781599409; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNCq2Ath3e/Fyu9ozR8E4s0geoHbdmxBpm5kJ3fmgVs=;
        b=hHVeKVR5x/0Fv6Mmlp+3mB3YxsQ9U4HsI/WyU5NiZoHvklR/P95jsZ30D+PmkAyAiz
         3PkwA8BoeFY9DSsN8CtBUbk5ewudXu51NULKjm6UHOrV0f4zr4KA0zKXWSO+NSS5kWTd
         Ex/siYhLVO90tQrysLIvrnVynCT/0yDoBNFaj+bGZQteA2eIks03v/CAjUsy3hfd724w
         et++iadt+g93JwvaufPaKlvoCef9Z2Qo3RXJkI1bf8BU9KW8ODZvjtbYKI/A+6BMraR+
         CNo+sqiEw6019RvGEQFVNaBm+Q7jCFI0u2At4B/1NelR7XLSpHPkE2LSjG6FfhlKfLN9
         UwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994609; x=1781599409;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNCq2Ath3e/Fyu9ozR8E4s0geoHbdmxBpm5kJ3fmgVs=;
        b=Wh6H3dMDgEX97Y69xtpUfOW0oZktv0pPX4nkMv+V1TbJZHzN29mscQseUSUDP1s4i0
         9cMWw3NhwdgUjiEXeZaT1lkuY14C+vhM5spisWP0o5vEQSg/KxrwFHvUmgWPc6bA7gJN
         7w/bmlsrPZEk9IJbs3N3IXjOt88TMQYUDTq4BONP53eZCwnSx5iYUSaYXrR+z9KFiGTk
         aD98CP0iYE8V2xNPssxJDSP9wZloE0I8suw6oDyUZwofdkliJVn5YA6+g3DiBHUfHeVl
         FPcCZVU9Rn2XuSJowlRPA/VI1zTZd6ho3ALUGE3ljyovJ+fhLCkRNyMuF6zKu3IekRZ8
         CFFw==
X-Forwarded-Encrypted: i=1; AFNElJ8VPHIBKGXVyhnUCg6NRYsiOuIXdEx4YZUikqUzcBdPyg9+KTN+AmvyYcqUM6z+QDAAMBNdZy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZXXJHGx23xxiGM4dS6XvZx6/Wc5LRUlza0/28T2TMLi2X+x8
	AR8WCumVvP/5bgaccY6Io0DQ7VC0TR5riRdqBc6dkVhP29uVncDUd6Qw9wQv9cTo/ch+3JDWw2b
	FpqAGXsCSVZvhW7EYOIw5akZckzl21QzVrCkUbqt2HC7tREsNHIPWdj2wcqc=
X-Gm-Gg: Acq92OHMBAv2u9trWaz6mOkb/2Nib8bof+ixW33eVL0Xwlz1YOsB/1qC8ifbEXRSnl5
	3h+8lo/oY0mvg9gtLy1/pImCSFT9lj1Wg0owZ2Q5XxB2eAvd+Ws6/A/BtE3QsleMofTH/cB5VBb
	YiUA4IAgGJzDMbQMFX6WfNfdPSCYEXVoilQ2MudxVbwq2nUqdLVix7vVqD/bweMkAwypNLmFUoq
	2wZq7OCfyTv/M3p3mhxeBQdPfcqQ8vSlCl0UaqFh07eyLwsIW7e3AVPhDIgaWeiU4bT0LmrLzlG
	7MVkwzd2zamZbpstGqARXgb6vzAKlI5ZHI1UcoergBPLxOM8u+2An7STCnATG/zQHWYvjEtfBmk
	ll4BF9ZevBGv5Q9ouJoyPIrkYAbRT4CZp5Vq7r28PfrEv/WCrddi/nW0DQZpizj4tJj3o
X-Received: by 2002:a17:903:388e:b0:2c2:2a8a:af74 with SMTP id d9443c01a7336-2c22a8ab260mr164651345ad.15.1780994609564;
        Tue, 09 Jun 2026 01:43:29 -0700 (PDT)
X-Received: by 2002:a17:903:388e:b0:2c2:2a8a:af74 with SMTP id d9443c01a7336-2c22a8ab260mr164650765ad.15.1780994609051;
        Tue, 09 Jun 2026 01:43:29 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa00b3sm196489635ad.32.2026.06.09.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:43:25 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 14:13:09 +0530
Subject: [PATCH v2] spi: qcom-geni: Fix cs_change handling on the last
 transfer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-fix-spi-fragmentation-bit-logic-v2-1-e18efc255563@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABzSJ2oC/4WOyw6CMBBFf8V07ZA+VMCV/2FYlD5gDFBsC9EQ/
 t2Cce1mkpPce88sJBiPJpDrYSHezBjQDQn48UBUK4fGAOrEhFN+oWdegMUXhBHBetn0Zogypgb
 UGKFzDSooCirKkxC5tSVJK6M3qbIb7tWXw1Q/jIrb7JZoMUTn3/sLM9tyP1v51zYzYCBqQS2TQ
 utc31wI2XOSnXJ9n6VDqnVdP10iVKznAAAA
X-Change-ID: 20260528-fix-spi-fragmentation-bit-logic-880394337ff9
To: Mark Brown <broonie@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780994602; l=4275;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=stn3ZEPLR1afpqAn0RrmIjAKSrCZN4mu3yS/RlOo3eg=;
 b=nkbi4Vvc7G2lHmDJt3Rj5R8XMXZi/OL/bi7cdRKFiLoGGQhE2jhl5Ye03gsg95Jnr7XwSWOsW
 2jHB9f3fv61CeQtR2jnjRo7JDaXa7FV6h2yFwLqnJ2pwa9C3i0oNlHQ
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: L0mcYYACDpaimjHVS9uqgJDSvWMqqXer
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a27d232 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=RAbU-raeAAAA:8
 a=wpeXKL9a9D_Roaqk1GEA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4MCBTYWx0ZWRfXySuc5XJq6Fb0
 nmXkCNfy/eMIe9w6eY9nuxZsIP4vayWNN86GT3GlrFLgtT/bIRWr1pp6rzqH1LqeW5VtBORAdWv
 CFcN5sKy3EF3fGMb5SXtEFcil2lmm5zz+ZdWmlmvnlEXnCd7eR/tTadYDz3Xnag4BfJziJM1ftf
 seFb9rWwhK2STNAedmzMtLkw/MgQqTsHbCXG+pbfeCV8KDqHb3yz04N6HiDoUAAtpVryh5n+TwK
 17Wf7SoIIcBhzpH41+0PtIkzVFYsK0Bw1pu284uN0rqyUuaZQvCEv4do+K72S6M/ye5eAIXvU7D
 iIQF3liDnh+kQ1Co8t27VVlgT5BP8vQFJXvgFEJ2V2OMaThBYU6Q8xifqREzOqbWd13t2MDrwHD
 0jDyPOR4kPIJ5upHp2AcvdrtrX6/k6bGJZd2d8OS9HRcztktFGLZw2In6+F+vCTKI6h5lQnHJwL
 qMKJyQfIMnxXJFujgeA==
X-Proofpoint-GUID: L0mcYYACDpaimjHVS9uqgJDSvWMqqXer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090080

TPM TIS SPI probe fails with:

   tpm_tis_spi: probe of spi11.0 failed with error -110

TPM TIS SPI sets cs_change=1 on single-transfer messages to keep CS
asserted across the header, wait-state, and data phases of a transaction.
CS deassertion between these phases violates the TCG SPI flow control
specification.

This bug was introduced by commit b99181cdf9fa ("spi-geni-qcom: remove
manual CS control"), which replaced manual CS control with automatic CS
control via the FRAGMENTATION bit. The FRAGMENTATION bit controls CS
behavior after a transfer: when set to 1, CS remains asserted; when
cleared to 0, CS is deasserted.

The commit correctly sets FRAGMENTATION for non-last transfers with
cs_change=0 to keep CS asserted between chained transfers, but misses the
case where cs_change=1 is set on the last transfer. When cs_change=1 on
the last transfer, the client requests CS to remain asserted after the
message completes, so FRAGMENTATION must be set to 1 in this case as well.

Fix setup_se_xfer() to set FRAGMENTATION when cs_change=1 on the last
transfer.

Also fix the same missing case in setup_gsi_xfer() and correct it to
write 1 instead of the raw bitmask FRAGMENTATION (value 4) to
peripheral.fragmentation. This field is a 1-bit boolean consumed by
gpi_create_spi_tre() via u32_encode_bits(..., TRE_SPI_GO_FRAG). Writing 4
to a 1-bit field causes u32_encode_bits() to mask it to 0, silently
disabling the FRAGMENTATION bit in the GPI TRE regardless of the
cs_change logic.

Fixes: b99181cdf9fa ("spi-geni-qcom: remove manual CS control")
Cc: stable@vger.kernel.org
Reviewed-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v2:
- Updated commit log.
- Fixed typo in code comment: s/keep CS between/keep CS asserted between/.
- Link to v1: https://patch.msgid.link/20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com
---
 drivers/spi/spi-geni-qcom.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a04cdc1e5ad4..26e723cfea61 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -449,10 +449,15 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		return ret;
 	}
 
-	if (!xfer->cs_change) {
-		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
-			peripheral.fragmentation = FRAGMENTATION;
-	}
+	/*
+	 * Set fragmentation to keep CS asserted after this transfer when:
+	 *  - non-last transfer with cs_change=0: keep CS asserted between chained transfers
+	 *  - last transfer with cs_change=1: keep CS asserted after the message
+	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
+	 *     keep CS asserted across header, wait-state and data phases)
+	 */
+	peripheral.fragmentation = list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
+				   xfer->cs_change : !xfer->cs_change;
 
 	if (peripheral.cmd & SPI_RX) {
 		dmaengine_slave_config(mas->rx, &config);
@@ -858,10 +863,16 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 		mas->cur_xfer_mode = GENI_SE_DMA;
 	geni_se_select_mode(se, mas->cur_xfer_mode);
 
-	if (!xfer->cs_change) {
-		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
-			m_params = FRAGMENTATION;
-	}
+	/*
+	 * Set FRAGMENTATION to keep CS asserted after this transfer when:
+	 *  - non-last transfer with cs_change=0: keep CS asserted between chained transfers
+	 *  - last transfer with cs_change=1: keep CS asserted after the message
+	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
+	 *     keep CS asserted across header, wait-state and data phases)
+	 */
+	if (list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
+	    xfer->cs_change : !xfer->cs_change)
+		m_params = FRAGMENTATION;
 
 	/*
 	 * Lock around right before we start the transfer since our

---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260528-fix-spi-fragmentation-bit-logic-880394337ff9

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

