Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF0367B8C
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303639; cv=none; b=CUCy7Mk2l4RRCssWVrhVMD9BlSDmBOZeGify938bLJ+dYWQRZ9viXBrU2oJNJ0Gpoy0STiQ+CLiww90f017+JAB5Dbq7F0oyhRqlMbDZJTFVjyXvLydbnMNdZuN6yBs54LbQtluZtPbsbUxAZ/W1yEE7+iy/yh0WxDS/wQphIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303639; c=relaxed/simple;
	bh=oGFvnXA5a4ylqmmPPN4yif8ivxnHqLZzKhvErrv6UGU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DM6jnEq7teyR4+tphqVOXwGx0YH6Q+LDqOgwf/q+Tr6ul6CvazupEp+pEUNTnBmYukWIwnQ0bmNtlY+Wg1alYx1+1aon4Z0sSQItSJL2IX/0r0aJRhR+W1caq1dqtlzInRm64GT08eBENxISY0P53+GgEaSUGlErCfmyLaGRstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i4xroaRh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HSGlvhiZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i4xroaRh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HSGlvhiZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7vwJ2106289
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uszRWZ0TknZkXby9p6KApt
	6G+IQIHzRbg+DPrnn7O3o=; b=i4xroaRh6s7SGSNPcgd4OL+mlrf3I2Hc+cejk5
	xL3ldyyLXeLEQCBkcV4gPGtZhJpvzbpjmdvIYP6NuGhRnPWL0UxDotipcHhar4CJ
	RKwLYoXvWHA46KgkdxXgcHnmqjNR/t4+QZT7shaTtQUfz1Wvg+7HZU04q7DHV9hb
	g1OPLmHYBbKvx+l1CSKU4IcDTdAdXAgyzYQLtRI+wLX1e7qWHmbduHtktMi8nKA0
	9f//Y4sOXjs9CAKwqUPbpktXdjwDNRD17dkoC4ilNu0/0SanYQpXqbbzeJTO1RZk
	/OkeGJ44kBI/dW6kjLDdzOOG22zrjAcO79MsY2Z5pl8AmZEQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfhg0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:53:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1e6f602cso94030611cf.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784303635; x=1784908435; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uszRWZ0TknZkXby9p6KApt6G+IQIHzRbg+DPrnn7O3o=;
        b=HSGlvhiZ0Rvu+AK24EV7rCdz8MyOUDJWi2NT5Hhifm9Qp5JjzjsDlvhqGmVhiwaCSY
         y26XvTeV83Mqp8pxmz7nG/kqhZtDil+SRV2w3qcBEi6aJf+bSM1Hh5Or7HrOXebfWXS5
         emUOKtnM6UvI6vFFfYClgxdTa95J50aTvoE7CLxOodFOWd2J+C11fhtKla+a3X6CO01h
         qA36Nd/WSWMzCVeSj5u2+iK2jzCTq43kKEZOhKxqOrzReuEexWR2wEzQg8PsgqRmJMY7
         E1L5dwK5uxqPMveG0kWuGw6885p4pftbWLegMx+A+06wam0SKE1WbpfMPiuIMCamfvlv
         cOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303635; x=1784908435;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uszRWZ0TknZkXby9p6KApt6G+IQIHzRbg+DPrnn7O3o=;
        b=J/iz974hN7BG1KvfcxAsA5ZWjyAW33Qui53bJiTPyif8Fvb8P05SksNkJM4vkU0gZA
         /+DEkCS5r4f7EHbe0NXOI9OkwWpV3JWRKnvELY0c9/6mH+geb7ytjmHb/jBOVA3rm7ai
         +6AqUXgizdbNYyBh6EJ4Jk8LhQOAk12klfCEmQlP55EKGfxKyGmL0RMjZcasnSmfO80H
         VFBq2imIIJs1zPSI69Gei0BJj7G9plOv8YTMlN50NNN/HrASVCGH5xNTfAKEjlgs/IOO
         5kVQnifN5QulKnZx6IqqOUDZRznSDUEuwtm0ByKSpavuX0tgfU6xt/rJoVl9QH71oNhE
         oy7A==
X-Forwarded-Encrypted: i=1; AHgh+Rq6zKY9N+Jcjc+nEiuaQ4qRcoqccV7nSjZ8tcj14c6AMgwJLfWsekE3iavmskhNURoIQ6+Tu+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywbHONZ1EVwiFMe2ucf/Sm2IVE/IH3o7pMFSTJUXC14+omzjor
	yyuKz3Vvp1VEUcbWgLXr+852wFpFTIW4TEF/o0yVR14e/CBy8pt1dJ40WQpJF/TRkJ9RzUO2QQv
	6CcfvRzJUwTK4ktlzsWeX1vufW192d0kMQhf+eX5/sr53ah1o2AC6vnzDoBA=
X-Gm-Gg: AfdE7ckgcLbBjFkUCD3b1QfPMvo9EimXxUC1sppfMYin6iWyI+6RZZzyZ1CBH6qbiKN
	iTOH/rO9DbGb3KgBh0xHMz3KSallvZEqDKBLNjDrUxYlacvURiVIkcWJaPQ5mG0Wvks7Y+BCBLs
	tbC3ni99e2l7NpFPK5KgfvGVpCEe0i7ZqJ9gojTXSO3hFl0Rbjf6ys23JvjjHFkajOorHgqrdcb
	A+oJuwbJcSA5Lw8vKF+piGDNNu3n7AED8XyOg7/fX4w/AN7no/o7kTz/KsF4hUYxLJv7AximoAa
	7zIxlNLk3chWAuyultdwcjLn70Jlm01C1sdPdSJu8PWPQ6L9BEBSn/ebYBMc/KUR9Dqy2DBt99l
	Wf2lxUN06Tx2YQhCtbmbWettQb805Cg==
X-Received: by 2002:ac8:5dd1:0:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-5213de89ca9mr30458441cf.38.1784303635221;
        Fri, 17 Jul 2026 08:53:55 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-5213de89ca9mr30458001cf.38.1784303634683;
        Fri, 17 Jul 2026 08:53:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:dc44:5b1b:5396:79d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2511sm47057095e9.1.2026.07.17.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:53:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v6 0/8] crypto: qce - Fix crypto self-test failures
Date: Fri, 17 Jul 2026 17:53:29 +0200
Message-Id: <20260717-qce-fix-self-tests-v6-0-455775fe5f6c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPpPWmoC/3XPwW7CMAwG4FdBOS8oMUnactp7TByyxB6RgNK6V
 CDUd59BmsYhXCz9lv1ZvivGsSCr7equRpwLl/4kIXysVNrH0w/qkiUrMBBMsEYPCTWVq2Y8kJ6
 QJ9auA6IMSJ33ShbPI8rEE/3aSd4Xnvrx9rwxw6P7x/kaN4M2OqfOWrIxZgefPfN6uMRD6o/Ht
 RT1UOfNq9RUpY1ImBJ8u4w5UX4juRcJoCo5kRy18mhsbEjhjeT/pcaEquRFagO5YIlsC11FWpb
 lF/DQFRSZAQAA
X-Change-ID: 20260610-qce-fix-self-tests-492ffd2ef955
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3101;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=oGFvnXA5a4ylqmmPPN4yif8ivxnHqLZzKhvErrv6UGU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWlAA+iwlncAoWZ/ziWeUFWMrFClphmIokmWDt
 Cy5WilKvPqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalpQAAAKCRAFnS7L/zaE
 w8F4D/9jfMFbvMy4RQOZY1gDQOU4LuPxrwiUgow8C7+laO2IMxncNSRqjhv1Oc1Wid2Y2b8zLha
 vY4BGB3Js2zp0CJ9wQO/dMCfI4tb15JhD1CEWMFRo57B0DqB2BGDBh9/ofw7nRURr+QDbuD5Oka
 8La197F6GaM7/z5YEZEccWBW7WcnimV9HNnwJ19tdcWViLNAg1aXcqnFZiap1ytGneuk/ptZnYH
 U2q66Fq/zSVV1m+Of31qwY2O8b3I0gxwDIh1HO5RDDjA1m38tvAjHkBHgMGfggU14weqm2oBmlh
 owPwGEJbxtbruKTh90an9NtRQF5AAXGDx0P1yQQxuB/zbMo/HgpI0GbaFXyzS/J+nJ3QsyUl/7b
 0dBF2gp/JbqBiURTLLLL2LG1zbSlKjUuBWeEbHAbXYNn6DA2cXPV+Kk3g8w5kWznfNm9Vf46GdI
 oW1U4UUYrdVcZSxeW7CYGR2kQcDiWbTI0bQE3Lcv/rKyQZ+GjkQiazm6Adw4QR1UEAJm3HFcRs5
 c0o2uzDAXgnYqVo9cP93WyGroefKENLmVFxzwnoTsJ+9PpU2qaLKRd3z3hFv2QQlTLey1E0uxrC
 b4VKuGvUo7L0ZBIKbxR+UFLroxztggV9LdgCalH0W6pItvq6/NeJ3M9oku1n8hIsSpdrPFKR+6q
 TXPb6oW8zXd2nBw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE2MiBTYWx0ZWRfXyGgkXVsaQCgY
 f/Gsj8cznWkHRTZQdURdYgB2xTaPsOL1uN1D/cgmnYIldmrHX4TsfzOBt/S96NEuq/huEF8P2DX
 MtiMpJVqFc+1cusTZiokLVzEveXsijhFAJyUmhSDMwIxHI17wGKTjzm723jLE6iAk0Yw4z2vBzo
 iVORAdUm+ho++IbxObRktvhhi+RiKL19iTHcMAdq/56YeAQO3wSJkyR0TBFS2cXeEWfN8LHH5V/
 kB5JyhguI91gNNTWj017uRmVLtvRC3Qo+WFPdB6ceIgNd4zluIJxYVXlN1eguPhA9XyOb5HPeSR
 6uC3x3f0aDjoG3QZ6pytfgIdtQlM1cOuNmJqQUWRnqgVhM+zUouxuT5EGMOkPHAF9ssT6hRorlE
 OtfkdyPPtsxKhJExDGoELhznN1l+0qQ3Y6fljVBy6VHvQqpNmt6KE6aR6x87RrcJ8vWfN8V3CJc
 okyg1wAVtxFjcmzeEew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE2MiBTYWx0ZWRfXxa3XoVUYO8Nk
 UOtpDAZPg05BMbgdLP3nWMRHE5d3CzJLRZ30a4iwApoQy7slzxY3MEDV1xLe3XWPhAx5PcVKCuk
 +ADHQQnAi1kzmNW8ICSigUpovDt2Zns=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a5014 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=p1cB-73YWAyPVz0D3agA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: OdnX_4MHi1O41UAj0lBlBoRUICJslCv-
X-Proofpoint-ORIG-GUID: OdnX_4MHi1O41UAj0lBlBoRUICJslCv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170162

This extends the initial submission from Kuldeep.

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
Bartosz Golaszewski (6):
      crypto: qce - Fix HMAC self-test failures for empty messages
      crypto: qce - Reject empty messages for AES-XTS
      crypto: qce - Use a fallback for AES-CTR with a partial final block
      crypto: qce - Use fallback for fragmented skcipher payloads
      crypto: qce - Use a fallback for CCM with a partial final block
      crypto: qce - Use fallback for CCM with a fragmented payload

Kuldeep Singh (2):
      crypto: qce - Fix CTR-AES for partial block requests
      crypto: qce - Fix xts-aes-qce for weak keys

 drivers/crypto/qce/aead.c     | 32 +++++++++++++++++++++++-
 drivers/crypto/qce/cipher.h   |  1 +
 drivers/crypto/qce/common.h   |  1 -
 drivers/crypto/qce/sha.c      | 58 ++++++++++++++++++++++++++++++++-----------
 drivers/crypto/qce/skcipher.c | 50 ++++++++++++++++++++++++++++++-------
 5 files changed, 116 insertions(+), 26 deletions(-)
---
base-commit: f6fa674bd75f9ed0e74f4ca85f88a6e461b5f230
change-id: 20260610-qce-fix-self-tests-492ffd2ef955

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

