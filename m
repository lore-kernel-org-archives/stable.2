Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489529;
	b=BNvhWCUdkuRCxWxcxJr7XKV9csRbgvJLy54gWCw9XzoGIoPFxTZILKiScm/ihmApxEXe
	 uHbws46dqYYvU98hDfS1N5KC1wU73jPwC09s8fe8skCfYW5xJr8NDWvBWccj4GHs9aUHX
	 00xAd5ND0ZboypOE4V4IccHG+IoERgzg2x6leiwjfPhwAYZ+MjomMEFYyKfKD22iuRsRA
	 C60Q2PLJNyeUttGot/22/hI7siGS5r40GGHmYjUCUZbb8XFTBVe+KMm79pGjUf3fBCOzZ
	 kCJdYNBXXh6ny4xcRU/OrJ9/qtqpjTCFPU1/DtVTrokXKntL4mC94fUe7qndB8Q7c/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489529;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FYKf+BSxd2cb15fIXmB9GOlvMtwvtc8EHKSqZ6YcNI0=;
	b=hbLnGL9yObepOKA680nvJ1avbvrOHsObbezhsFzp7pZ0wqkerVvawVyEq1zmK18canKy
	 onYcuwYzUQ5EUSMwDqlFy395Yb+i90b66PavZiZ+Qy4aSc33ANZ4GBrY6mCd7XIZwXlah
	 z2sNWOYqBS0hFaIE4x76j46JWom29Piy0E2s89ZPagBfELmGhmlP/SbpxEawclUAvBCMo
	 hYkyk4DVfBVG+oykpDKb6T66r89wU4CB7qUKLD6lJveaVG5ilRm92vUpviGZJtX2qaG+Y
	 GkA354OLyKs81vaccU32CklPydLeAoKAh3J4Fanawn4fx5VqOHcGOg/cRDRFjWXGX+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iEV4faAH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAWxeJJr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDEB606A881
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EDEB606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iEV4faAH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAWxeJJr
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACBAP6f3477100
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FYKf+BSxd2cb15fIXmB9GOlvMtwvtc8EHKSqZ6YcNI0=; b=iEV4faAH6AEwx0yK
	M8mdfguFa67BDVndXkch3vGD1FgznzpBchyXDhGoZPawVNC1dGjOQvR25hpW3Xm5
	gYz8OciFHmJZC1PAWKdsA6NTFwNc3jT87CbXxksERiEUcwN9EUi67VRrQW/QtPqm
	dhg4Qk/mThJZB+x/uQAcwelSZm8sIFBG0vn+u1G+NZ81DGD7R3ZPcaIL9qNneVq0
	0bbqu0E3mPhjh3nSQTBEcFMGntolMHPmaok+g03Lc61oY0Qzq3Rdpp7nXapZHY3i
	nDRRC3D+HBu1Plz+rpNbp4LrtHjqj1aW0nuIjHP1fW2yWkPPSSksSIGFWU0mpl+0
	nzom3w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yuhp1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:18:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375f0fd31f4so3077951eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794489527; x=1795094327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FYKf+BSxd2cb15fIXmB9GOlvMtwvtc8EHKSqZ6YcNI0=;
        b=YAWxeJJrmwgtpLdrXgRxtWdhAHbyFVdp8oXahHIP0oYMmIVLxpn9Po7ZDdTgUQuVeH
         gxiuxJsZoXYKRazaTliQHaMjlYuJ/dzkgDCu+kg37puDm7BdMkaY7Lo41sczo9STlmtd
         UKHDnY+tafrAEIpyhnFjttObXI2+ryWuwfVVfYQgcz8JT1v//9qcnt62bW87LYtI15u1
         +KimLqtNrClzQ0JezqoCjTNPXS5Zog2RPhJP6ZRwmtlaIXyQLCSxUeU2D1oKOOq7N+ul
         xYsNu8ncNpY6kAuPQ2xnEQO8g9Rlc6iG/iUGEpJ4OzFp8RDc3OM8JwqrsUoL1XXXNKp7
         VOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489527; x=1795094327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FYKf+BSxd2cb15fIXmB9GOlvMtwvtc8EHKSqZ6YcNI0=;
        b=QH0m9efFXlbvpUWRxKfjR8jpXUwKW9hpsvmeXQJ9Xj2V9aGKZFTC6LK97MMUnHLza4
         I4o7XeFTr3BcdtznbRqxCEEsEAW+BbD6As/C1Rmmc6hhueJEKZ04evLKGKbmDyuS9//k
         ejSEIHYDWf9JyMTY3+vD+fq2jo0+b4YPU7Ac5AcafjBk6RDQnSMYBv7pxGTmO4RbLYAt
         L15rPPTz/lN5WKv6syVi0hb4WUQco0oqO6vd/vVIlzjMK+H3Y+pcaE1tFW67Rb0IszHb
         EmUeE4rBgUIsxuDbU812PA4RXfEIKIA0/E7jrBB2IWhwKIVPsLxD2K8wbx/sMaqTchfe
         Hj1w==
X-Forwarded-Encrypted: i=1; AL+hErE39AVANddzFQmQtEFWlAAasVFFpsr9WtYZQu/SjAsyRnolatxziAInePPZye1eElMpU1oMUFQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rak7uYusFHd5Q/d1KLI0qtH+6BPn/IGEZqOctHqeGZfEpygOs
	vACCIigJ8oEA3v7x7L8Do0qTiLbYgQasOIVsNB40Fk/1tKik3McrbLXKRKQSZkWWCAjiMCTzorM
	2Q1BMtOSy6Z5St1GDIU5MMwJMhJhDykzD641Ess+9gZqRHcLfTtZgaZWAszw=
X-Gm-Gg: AYBFou29+jXHuyfOsw1AkwY2Tt1gbwav4aApaLKihpaqmo34ZnbUMPZSFiZab9TZ1y4
	YLMJ20DOUsSNkPXGNls/ZLo+py24QuYiABJQFNMNncPOTC0S9oKHPWMlk5NFXSF/FA9RL+pKhuL
	t+ZJL7mQhqNmMe3TpUDtaA9Xhfy0AcbJlJ+L70aSpCE8+MhSoThAIXz98YZf7KU6HSJP7kBy4v4
	Vbt9LXphn1XW/IwyIGy8Kw/YYh7fiIEi/t9E/57CGcpCQGjf0Nsmz/VqXGC3UwLW8TVgsmP6/Kf
	+yOKDf5gcW/qwJygZQWeZlpFdUgJ7WGWzYdFnn+FNWp3iqpYCYbFGatZKcqmffVIcD0l28SQ96+
	31uuRIst+NGib+wZwFEsKpfaavyDCL3CTnEKC7el0DLZrlFC2sRydpwuXi8SHwFw9i2mBD7IssY
	7ub7QN0Fo=
X-Received: by 2002:a05:7300:ce01:b0:36a:1452:8dad with SMTP id 5a478bee46e88-3768636e3c6mr6130138eec.20.1794489526691;
        Thu, 12 Nov 2026 05:18:46 -0800 (PST)
X-Received: by 2002:a05:7300:ce01:b0:36a:1452:8dad with SMTP id 5a478bee46e88-3768636e3c6mr6130104eec.20.1794489526047;
        Thu, 12 Nov 2026 05:18:46 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm43798356eec.22.2026.11.12.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:18:45 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 18:48:18 +0530
Subject: [PATCH v2 2/2] ufs: ufs-qcom: Enable ICE before enabling crypto
 support
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-qcom_ice_pm_enable-v2-2-177e454d6f22@oss.qualcomm.com>
References: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
In-Reply-To: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: zEfh0kmi9TxpnMbaAuojXsaDAJG2xlrK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX3C9gaKtBJIb5
 XUNIB9XDm2yOf2SHudZvdp6Qkkz+ddijgSnAe4mwNb35n4wmR/SLmRLmwV0Pv/vjf92TuEkDOQp
 HYXZEPN/+hBG/62S8AhWqvRW9kcWLkI=
X-Proofpoint-ORIG-GUID: zEfh0kmi9TxpnMbaAuojXsaDAJG2xlrK
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af5bcb7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lF1qQ_KX37YNnQO-sMYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX6SkCAxPXjyiy
 FYYmJkiKPSY0YMNLOE3+kRr6o5kZrnNrR6ClkckWDCvuwKDmpLlRglGHCvh3qVAblMQuqFIcXSh
 gyUGZaMVEwysxtuI1AYHDpFHrYiMcS9IChb5In6wxrTRwDDa/55mRIOJQtjXHcbS5r+Bem+3DZL
 l+JSijKqqZOmxin3k+t9goaxyqiyXxNLP0JP24GDfoqikSR28kxV7BEKK9i+dxuZxFI2kfuykqh
 iKv6c8j6nnK0rEeGPB8oIF754X7XIrbmYYDEmPwZyxESeOAr5CtpqgM8qBxj7z+jeUc2LcbD7By
 C9wPGL6bwIi1z/fxTh3flgCK08eovlw4wXslBR83U5gKPmQXf1zxE6ED8G0DumgoeBdtXD4Z3qf
 i2FUqhdWGM8SFcH7j1/+GCm06lvdjyR+iy+NbXUsWdwrcwRyJ13QMyptMM3eI2EZDJYUHKw8MAP
 f8Jw3DhTlfZQboPmC0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120052

ufs-qcom currently exposes UFS crypto profile and sets UFSHCD_CAP_CRYPTO
before enabling ICE. This leaves a window where blk-crypto can issue
keyslot programming calls before ufs-qcom has explicitly enabled ICE.

Similar to MMC, enable ICE during ufs crypto init path to ensure ICE is
ready before blk-crypto can issue key programming calls.

Also call qcom_ice_enable() from HCE PRE_CHANGE path once crypto support
has been enabled. UFS controller reset can reset ICE state, and the UFS
core can reprogram keys during HCE start before POST_CHANGE.
Re-enabling ICE in PRE_CHANGE makes ICE ready before reset-time key
reprogramming and for any later ICE operation.

Fixes: 56541c7c4468 ("scsi: ufs: ufs-qcom: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/ufs/host/ufs-qcom.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 6afb8498b8c2..4ec400c5281b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -158,13 +158,15 @@ static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
 	ufshcd_writel(hba, config, REG_UFS_MEM_ICE_NUM_CORE);
 }
 
-static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
+static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops; /* forward decl */
+
+static inline int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
 	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
-		qcom_ice_enable(host->ice);
-}
+		return qcom_ice_enable(host->ice);
 
-static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops; /* forward decl */
+	return 0;
+}
 
 static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 {
@@ -188,6 +190,12 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 
 	host->ice = ice;
 
+	err = qcom_ice_enable(host->ice);
+	if (err) {
+		dev_err(dev, "Failed to enable ICE: %d\n", err);
+		return err;
+	}
+
 	/* Initialize the blk_crypto_profile */
 
 	caps.reg_val = cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
@@ -318,11 +326,12 @@ static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
 
 #else
 
-static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
+static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 {
+	return 0;
 }
 
-static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
+static inline int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
 	return 0;
 }
@@ -636,12 +645,15 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 		 * is initialized.
 		 */
 		err = ufs_qcom_enable_lane_clks(host);
+		if (err)
+			return err;
+
+		err = ufs_qcom_ice_enable(host);
 		break;
 	case POST_CHANGE:
 		/* check if UFS PHY moved from DISABLED to HIBERN8 */
 		err = ufs_qcom_check_hibern8(hba);
 		ufs_qcom_enable_hw_clk_gating(hba);
-		ufs_qcom_ice_enable(host);
 		ufs_qcom_config_ice_allocator(host);
 		break;
 	default:
@@ -660,10 +672,9 @@ static int ufs_qcom_fw_managed_hce_enable_notify(struct ufs_hba *hba,
 	switch (status) {
 	case PRE_CHANGE:
 		ufs_qcom_select_unipro_mode(host);
-		break;
+		return ufs_qcom_ice_enable(host);
 	case POST_CHANGE:
 		ufs_qcom_enable_hw_clk_gating(hba);
-		ufs_qcom_ice_enable(host);
 		break;
 	default:
 		dev_err(hba->dev, "Invalid status %d\n", status);

-- 
2.34.1

