Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BC48EC87
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045296; cv=none; b=hXrlEPWEiQ7Tate9WNvamhH1CZvzNDpSdfUnWzwFdI4foVbhaEmOsBTpYXC4klOUO+2lk035FnjCqEYF/870BXa3hvUGsu8sRGEXh1muLr6wYLaq/2A1qB42QoXcr5RbZItNDe9V6Fo8qO3dPJN/WRJHu3781FwZOfjZjRUgtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045296; c=relaxed/simple;
	bh=hIu7q1DvEoMcnU+VfFaa2yiMlGxyPd9bVWiqxS3GiRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W5YnXD4xKK9QLfxKw6rUzqPiJPhAXLPPTd9mId6OTWmU8rruqhaoxfTgT+IceBqTxCeEq6eDVzZFqru04mqkfN9BnLMU8KtXE4RNPQQDGQX4qfdMjcuDPd1ArZo3kdsO9yl2zANORUDmeJWAMDUoUg/fnH9LW+8EMJkeEDqV090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgWYe//w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TNChyP6L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgWYe//w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TNChyP6L"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7btB2029214
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=s6L7i/zDP+uUm8L2WT7cPx
	zqWABp+vuqdRfVcN6TUOo=; b=fgWYe//wh+Mmn1PO8qKClX83WAcH6vLd60D+Q4
	72ELKTxFbw7dzB6oXOjP7L9tX2ytNn2X+1z34EDg/7l4939Ndo1FbxQh9HSjliZG
	hPQo1k46cEwlS5f4FXLG2q386B0XwiU1n7Wk+PCucKyCOhCj3W98CJOZyrQpW+CG
	RD/whHVQ9vLnBCwmgkgw5A8pCPbGrz/w7D0ED7IDMm4Fjngirbf7802LJ/VOqk0v
	BfdZOfpYzsAihNpY4+4cb9O0CyZHAVEZwO29KvsByM5sBGKdxR5TMZmrzmaYHpG0
	8Qa+Kl6PKBjB/ezEu/Bwo0tBEOj82LosLNgRfUDPNjvfnihw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyhbvcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:34 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9106fce784dso33379976d6.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789045293; x=1789650093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s6L7i/zDP+uUm8L2WT7cPxzqWABp+vuqdRfVcN6TUOo=;
        b=TNChyP6LkRHXgA7B2Oqaeoh2jE9wHkRLxtTNAxk6POM124GMAt0mqrowkG5eB1j5lO
         907/b3Jvlr1zh9/TtMJKIFM7vK+tlu881Nqd54kdGjAoJ30iCqE+xEiMqNWC9viTvm04
         xSIvXR8GJSvkRkeExd+HP3IcLCUcmdkwC1pLOBMUdH1wkTKNlqLUNvvJVaPo0iE1WnZ2
         Pv0dj2nf2yEILbnbUcdRVT7JvgJuPOFJJZzJfq2Q2hlGQz5UyzJ8fG0e2Mn8Kgf4KRkP
         FZEK5wjkJv1EcFPdTUFSWgnpY4DtQlkoMVGN0puWUxfmJ8BCS1pYo53yn6nh4KthrBgE
         zSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045293; x=1789650093;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s6L7i/zDP+uUm8L2WT7cPxzqWABp+vuqdRfVcN6TUOo=;
        b=DMqjpoGfn0oSd4QYrg//fzKqzJJ7ir+0P1M7BsJ5gqjStJLtybqzRDrruKMxcwviZP
         onQxqQso9H8nwRzBUdNuc8KfLj8CVXuL7L6ebSz0DqnsJt+/IvWI94W9Hyg7aMF2dqme
         KSehC+56XhID5so1fRtey/qXVyPUOWg0jTgArkulqdynbWIzoM2VEFbE4Upn6MA9dbmt
         ltqG15B/0OZIWWMUxGb/9Nqu4WQcp6ofxiTQv1Lam0vvgbshHji34OF66RjGMP5HOsWS
         zojrbq3b4uZArxYDGkywm6LQ3wQ/68zFBvHBmgTRu662WFA0gBMyx/eFVEOHsaIuTl9A
         I8cg==
X-Forwarded-Encrypted: i=1; AKwUvBy03UptuvtTX6m90fNc3/sjClzFlLf78h+PkJ1HeLTKaUGq3VBVQTgg1LHtANS8nlc+bsBQ1SM=@vger.kernel.org
X-Gm-Message-State: AFuF++lAp+W+1bjkqfll1Cl6y9AxOrj48IOGd0mfDTeyQf11QeKmoQt0
	T3MJrllEbMLMT8Bz5G5s9WftSbg1JDPUjL7j1y13RSvY+AmaKsrCR6fCEzyR5tkdJBYC0pT0GaE
	jDio9kWDEtIVGvj0IDO9LyFGCQCVP3qJbVfkZBf0Py/iF3uyoftX876fgqD4=
X-Gm-Gg: AYBFou0/8P1VSK2nNpyZddkPZ7LWGKEsymmljLRDsw+EgfZGxcCis2e+F+U/cw9NlKo
	GdzASgL3a2TA5SoR+tq8Nx7XCD7JjTwIrYdUYzOWj0romB8CY8RCAdK8uk8EO+DySuTGpImi5/D
	KZP4OaLSkwnzS8eBlTiReMoeAujxuDp4702OS5hzyLHkJsNzUT6XjgyuivCdMZ9X813EwxcWotE
	Qm3fDxqwyBlGRzEiPBok+54dXZScnWDlKHFcJngi6SWSMf1fT7CHCVSBO31bVKcZzlA1X5eJ2i2
	pIONYmBoznLSOEimhaqgJ/PFkhruMN8BBFbeyL2oSpm4C+DJWwLqgVhIBHySpCdUjkD+lK9KX0L
	Gthevk3Z5DHxJgLb45qMbrf7rxKKs
X-Received: by 2002:a05:620a:2852:b0:939:ba2e:455f with SMTP id af79cd13be357-939d4ad385dmr1261171885a.51.1789045279577;
        Thu, 10 Sep 2026 06:01:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2852:b0:939:ba2e:455f with SMTP id af79cd13be357-939d4ad385dmr1260904585a.51.1789045271112;
        Thu, 10 Sep 2026 06:01:11 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c9b1:abfb:f300:5e98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26204ecdbcsm831849866b.25.2026.09.10.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:01:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 00/12] crypto: qce - Fix crypto self-test failures
Date: Thu, 10 Sep 2026 15:00:41 +0200
Message-Id: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPqpomoC/3XPwW7DIAwG4FepOI8KXDDJTnuPqQcG9orUNmtIo
 01V3n1OpWk5JBdLvwWf7Yeq1Beq6nX3UD2NpZbuKiG87FQ6xesn6ZIlKzCABq3Rt0Say7eudGY
 9UB2qdi0wZyBuvVfy8asnefFE34+ST6UOXf/znDHC3P3j/Bo3gjY6p9ZatjFmB29drfvbPZ5Td
 7nspahZHQ9LKaxKB5EoJfhwmXLivCG5hQSwKjmRHDdyaAwWE25I/l8KBlclL1KD7NAy2wbaDQk
 X0sZ1OO/kfQieyTOmFWmapl/XGUPX4wEAAA==
X-Change-ID: 20260610-qce-fix-self-tests-492ffd2ef955
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4324;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hIu7q1DvEoMcnU+VfFaa2yiMlGxyPd9bVWiqxS3GiRQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoqoFMmP99s5XVJjN92+NIMOSGuGixwCVu/faf
 SPmAuy72nuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqKqBQAKCRAFnS7L/zaE
 w9rREACKA//YaggSB8b0iLAZL09gpv59xYVYCEyMrO8KOzFVQHOkJxu5AcElTMivA9BZhYsxJle
 JP+nB8QWxM2vn5u3VjO47gSyMGllsV5CQmsHqkOlhUPmoOuNn0GgGJ+Kgd8/8U/iMfnQzqJtmm1
 E9y0Vrj0+7VCr9go9oOEozpgGlSZ4rAPvvCAVeI7A7FB80szyXFUMb++T3X15yaWbcQP4Bp+tbJ
 vxScycrzWM6z6s0lBQqb2FKOAcBFD60+q8eKw9fXiCxN6EgmVTTEIvATyVsCkKwkbRCLc9x2W7U
 pFl0fTYGYLHMN5tdVAixdFmoIDwXq27EZooYASjiT08DjwjBXDgn5pPJJf2LOlCmKC9M8nMEUzr
 3pry7r1QFOXAxSm5CTC4AamghVKDQCfnq0/zSwN0dd4qLPrKFKIDP33mb2jzGEuzhLBM6VsZ8Vl
 aEt0xA48w0WD0fy11mIyPSPhBGIKWeJMZV61cROlhufwmv1NEeelcbPhppqzs1g1tG5UiPuSpgN
 La0c12An/aM4YEc+M+lKYPrSGlXy9jOmd1Wod2li9kG/yHvzhcucjuC6sgaVM+oZ8hvXtFgq16Q
 QWKp2tlcJoGDXVjbUEQPnIGycKhT+kDmTaCCPZwDzAP0f04cSiGnyJanHtwiQKrSyMKS2J/XYjh
 Vzyz4lQiI4s8FNg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX5cbDlxngB73R
 ZDjOtMFKTa4jX7if6CYwyDgzHakxA7ekfsPNfAq4rrbVNkpTWS+RbEGLSeT/SMGiTuFAPBfEi3H
 GRP2PXr3EEXZQskZLkydfdPTMxUwhNkT2vLmKhCX51rMcMs+Z7wzFTTd3+CZa6vbn234uhoJbxC
 +OqzzQtWt+9Gv6Q9AzYluDSZBaUANfe34Q/TxEjHONcWsfBSPuRTIIuYcIVEuNnyZ0QzCFSPtVN
 UnBgfdqZAoy83zIaBNOIHE3XXGipfzpo5PHXAjtjsYPQJz1kuyIRi77h82Vkm28G1WxSxUIeQJK
 oMLHWnMFynfaPNPGZ1w2dgd4a/B9Nkw2BYo/X1waI4z0ESEtnsF2iXrKCU5EXE0O3g4iMyEIDAG
 W1eH6hCYey6pvwDNq/Wb3BhcHor5kqBb2GqlDp31LqEcCyhatghhMRqK9mon7gldXA+0FsAv016
 EncLnME45qkGyEyd5gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX+avxCDi8dPou
 1QVqZ7TSR6o07LUzTqdj3iYPAoZzPIL25ADS9WhgvkcWMR9RsoKbqL7UpCCnt9ZtCDHcAuf3XSh
 FHm7AbFnuubZZ+oh0yGljjHquLdcwZk=
X-Authority-Analysis: v=2.4 cv=YKgKWhGx c=1 sm=1 tr=0 ts=6aa2aa2e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=xGaVECbZqfUFlCL-B9YA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: EGObQHSk5EQYbXw8bqfzXX4GQcNRgLal
X-Proofpoint-GUID: EGObQHSk5EQYbXw8bqfzXX4GQcNRgLal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100156

This iteration - in addition to the previous fixes - proposes to split
the QCE driver into a core part necessary to bind to the QCE DT node and
enable runtime power management in order to allow to drop the
interconnect votes, and the crypto part registering the crypto
algorithms. The core module is then enabled in arm64 defconfig while the
crypto part stays disabled by default.

The QCE hardware crypto engine has several limitations that cause it to
produce incorrect results or stall on certain inputs. This series fixes
several bugs and adds workaround allowing the deiver to pass crypto
self-tests.

The failures addressed are:

- HMAC self-test failures for empty messages
- AES-XTS returning success on zero-length input (should be -EINVAL)
- AES-CTR: partial final block causes the engine to stall, output IV
  derivation was incorrect
- AES-XTS with key1 == key2 is not supported by the CE
- AES-CCM: partial final block and fragmented payload both stall the
  engine

All fixes were tested on an SM8650 QRD board with
CONFIG_CRYPTO_SELFTESTS=y and CONFIG_CRYPTO_SELFTESTS_FULL=y.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v7:
- Add follow-up changes converting the QCE crypto driver to auxiliary
  bus, adding the core QCE driver under drivers/soc/ registering the
  auxiliary device and removing the BROKEN Kconfig label
- Link to v6: https://patch.msgid.link/20260717-qce-fix-self-tests-v6-0-455775fe5f6c@oss.qualcomm.com

Changes in v6:
- Handle all zero-length HMAC finalizations (like imported state with
  data already hashed), not only the genuinely empty message case
- Add an additional patch addressing the fragmented skcipher payload
  issue
- Link to v5: https://patch.msgid.link/20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com

Changes in v5:
- Dropped patch 1/8 that's already queued
- Use the pre-allocated fallback ahash for HMAC transforms (Herbert)
- Link to v4: https://patch.msgid.link/20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com

Changes in v4:
- Remove remaining ECB and DES3 bits
- Pick up tags
- Link to v3: https://patch.msgid.link/20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com

Changes in v3:
- Remove even more algorithms and dead code in patch 1/8
- Link to v2: https://patch.msgid.link/20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com

Changes in v2:
- Add fixes for the full suite of crypto self-tests
- Add Fixes and Cc tags
- Link to v1: https://patch.msgid.link/20260610-qce_selftest_fix-v1-0-1b0504783a46@oss.qualcomm.com/

---
Bartosz Golaszewski (10):
      crypto: qce - Fix HMAC self-test failures for empty messages
      crypto: qce - Reject empty messages for AES-XTS
      crypto: qce - Use a fallback for AES-CTR with a partial final block
      crypto: qce - Use fallback for fragmented skcipher payloads
      crypto: qce - Use a fallback for CCM with a partial final block
      crypto: qce - Use fallback for CCM with a fragmented payload
      crypto: qce - remove the BROKEN label
      crypto: qce - convert to auxiliary bus
      soc: qcom: add core driver for the Qualcomm Crypto Engine
      arm64: defconfig: enable the Qualcomm Crypto Engine core driver

Kuldeep Singh (2):
      crypto: qce - Fix CTR-AES for partial block requests
      crypto: qce - Fix xts-aes-qce for weak keys

 arch/arm64/configs/defconfig  |  1 +
 drivers/crypto/Kconfig        |  4 +-
 drivers/crypto/qce/aead.c     | 44 ++++++++++++++++----
 drivers/crypto/qce/cipher.h   |  1 +
 drivers/crypto/qce/common.h   |  1 -
 drivers/crypto/qce/core.c     | 93 +++++++++++++++++++------------------------
 drivers/crypto/qce/core.h     |  5 ++-
 drivers/crypto/qce/sha.c      | 70 ++++++++++++++++++++++----------
 drivers/crypto/qce/skcipher.c | 62 ++++++++++++++++++++++-------
 drivers/soc/qcom/Kconfig      | 11 +++++
 drivers/soc/qcom/Makefile     |  1 +
 drivers/soc/qcom/qce-core.c   | 87 ++++++++++++++++++++++++++++++++++++++++
 12 files changed, 283 insertions(+), 97 deletions(-)
---
base-commit: c0b0cbecdd2bdd74c9e76409e6ae67b3e65d737a
change-id: 20260610-qce-fix-self-tests-492ffd2ef955

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

