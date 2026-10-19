Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745DA4F93B0
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417704; cv=none; b=JunH/T6drfzIsw/W6XYolHnc5ilEkb8gvwyxyAH20w6zGhscqVHLuJVwb/BNVnmL3Nih6VT+JSEGqX73CN18fsD3D22dZSnnC1N4EK36sEDgg5ZyJx1+bC66YcSAsCwHhuiwNui2eOc/FsAIpjTAgDrWtqz+54Q5qz47pRf1ZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417704; c=relaxed/simple;
	bh=tLRfmvsQxuz+ZnT4lHMKw9IOC40CPpnagJ0AjgLCpr8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BU43IEcafBoKHJgcARZlfgok7651TMnk/1hNWO9xJ2Pm4TPZdBMirD1j0W7Teqbp2JeKuMVNym4w5MrYjfx/j/PA9DNp23SIqcwVcak96Hk44zl23LsnZUauQC8lob0nmoTkc3YloT53XzDFivh54+PLuT4CQYms+Wx9gfn9H7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jlw4cnzK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f6+Le0pf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlw4cnzK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f6+Le0pf"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Z1TI2689048
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zpych/XnIuCmoabW/bSIyQ
	n1vDjzC48Sem0ex5wfaVQ=; b=jlw4cnzK16VuAX+DAAsEW501QJpzVfoRd+djnh
	IoWcZmIkFafSwoqlLHagJ6eIk7nHJo/+PIhTpf6bq5fRwddPhpMHFx2Y+1ObMj76
	93SO+5i52c8gwkUISpgCYhh49fwTiAF0XvEUZBNyZ9hpUzEzKE48RABNuhYS19OV
	RiWgr9Y5QMNJbg0HbxuQ6zFnSqvSKOKxDdaJlrxmKP5SFQX4lf1KWEjndSjxolv6
	MVTCnYHAOL98qLbHa73vX9luqJmxgieE/SclPPXTYm/V8ONtyLWleDfsQvQKCIt4
	JeGGFHOy8N1hEapuq+s0GSnxDOxbyed2OHMnTqfHoUO4e1DQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn1626-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:48:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2c0e6653so383926385a.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792417700; x=1793022500; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zpych/XnIuCmoabW/bSIyQn1vDjzC48Sem0ex5wfaVQ=;
        b=f6+Le0pf77gOef4fQROqrx2kiY/kOavRqcPuJxCT4NIxKzRgcWaErR+l5VUm1H9qWw
         TlL/Wha3FZYP21K9HApw6Ns5hLofPf1A3cqVJQJsm41IWKqTMBOoOeNh98Fdjs3gnUuj
         nzHQlOlsg0qYV9QwYgKT4H1a/lhYqcEV2U8ZSE7s42YmoTzkvx80Al+LohakN+HLhvXc
         oIhrYCbZs6sy6OuB7YLZg0pEKQ7c6ktTaF9EdTMp9y71TngBXqF8vGglOCsIdvJvtl3g
         fGgtfFniscusJpECULi2CBS5mpvVTXwcuTwNl1ZJlXIQ1XjRZdsl436Igb8ooYSwXa+Y
         zqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417700; x=1793022500;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zpych/XnIuCmoabW/bSIyQn1vDjzC48Sem0ex5wfaVQ=;
        b=oBfhHcw6Kfu/PFBd04GL88JIYaFq6gbxbinchxp7VYXeiB0q+kOJmmJCXgaD4fjSYD
         AXJst1Ugz2cDPuPLhue2bfhhiBR24xnG8w9HIqnQqXDkcKX9q4PqCmaIBw+m82+Ay1Lv
         7VRVs1Qn8SgjFbOpBPe/4fp/8kKBAGOfLMgz0qeukTKGabgnyOF06RWAz1WaSAUSNlmr
         uKqA3NmywUtLpb6m8lXSRTFOL9aNSGi9HGzCqr6+EsgMrZKjum7HNLY28anrq/XghVfX
         sukRamW5+eWb8yT6qp2FQDEy3I3vhjhGlWqjWvQQam7YA35+bKn1kvvKq2uLVmeH80GD
         Y8Yw==
X-Forwarded-Encrypted: i=1; AKwUvBwra/y6a07S9K9MDmcA1ScyXMWTouGxrjdMzT5hk7Dcy6DEOTBNkfEmFQUNko0mYaMjgQspDu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIvyYBzxkWxOIIJ3DU1kIpRef+F0cQpeS7Ba1pTtkiAQ9tRve/
	ps/MQZXAe3A4vi/tWzEyJnjXNfxE2ijeARyOSLwH8kO79SjIpxU7M4+vzVFtUsi33SRI58SBCBy
	vWKJdvsGt/acC1q/9NaCjoY30DarTGYV8R+LZ2soJm50gyckcnYnSMTRUUxg=
X-Gm-Gg: AYBFou1alK54hPX1BTnLg00zvV7BDD4U+mchP+wpFOpQXn03ysbjOsCVlg3oU4tTUd/
	QQcW97Bjl70r+0wkqUPMLegxPf86NgIr+iE0frYtkPxCQwjTDCQcAw1YHVV4UxYQOFE1zz03DU5
	gAi6FVeszqwmMp5o/f4ihD2L0VB6yyVYANkfmqotG0mZiI9avDj2QmkLYyhjdY8FWldNLXJf2MN
	NnAo6pQOWCGd7FUDjvcYvq4P5a1oanL5H7M2E++XzdueR6mS1FH9OPIApNLSltOsXgerc5eHXoC
	pbgAP/0Ueoi9DFgg1sfOE82IN3aoOIx+35nl44EGBZrt1e4UfYVJ9Y6UBr99CTCcbsN+2BVTpqp
	P1y2gUs/UI0nMEGzrlU9UGgIF4vw0
X-Received: by 2002:a05:620a:2989:b0:93c:80d8:57ec with SMTP id af79cd13be357-93f29dbeab1mr1377073985a.64.1792417700541;
        Mon, 19 Oct 2026 06:48:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2989:b0:93c:80d8:57ec with SMTP id af79cd13be357-93f29dbeab1mr1377070285a.64.1792417700050;
        Mon, 19 Oct 2026 06:48:20 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c4fc4sm20595574f8f.15.2026.10.19.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:48:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v11 0/3] crypto - qce: fix self-test issues in aead
Date: Mon, 19 Oct 2026 15:48:07 +0200
Message-Id: <20261019-qce-fixes-aead-v11-0-11c55cc7a695@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcf1moC/x2LSwqAMAwFryJZG2giCvUq4qLUp2bjpwURxLtbX
 M4M81BGMmTqq4cSLsu2bwVE6oriGrYFbFMRpE47ceL5jODZbmQOCBND1c9BnbRoqExHwl/LM4z
 v+wGOalMzYQAAAA==
X-Change-ID: 20261019-qce-fixes-aead-e229fa2015e3
To: Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3817;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=tLRfmvsQxuz+ZnT4lHMKw9IOC40CPpnagJ0AjgLCpr8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq1h+dXyU//X8RcKw2W3vd43VcfpMInoM/EcTX7
 rkTFzc6DceJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatYfnQAKCRAFnS7L/zaE
 w1yTEACWX/WQGWgvL4uFWGc6oEczG5quppTjYc7NwYMv+fKC0ZT4KOUn2ElfaJUl1Pxi4gWcXwi
 rfAFqlk3UkF/aBAe93QKYkdlG7jxjIp4T2VcMhcWElwYTzJc56OsFJVWW7H8u+AWGLk6Sbh7CJl
 oC0FOaMiZBrDp5o2oVBrgA+QiG/JEMJAEMofvgXUurUEHY4b/LNDQ9eIb6VYooUxOwN5h4qQOz8
 q4yAI0waGnEH+YqscMYq8Pm2+1ep/7WF7JZU9tMSl14UYyW/a0yr8KE/vcb/MRtAdL/42i5dnOF
 mehLGZ29QvkP3y3Wtu5GSdU3nPVwo1rWP/EzuXZf3TPeTqw3bkrNWcNcGqhMm8pZ20TjHoyihIO
 hFa7vzqdOeM5PnB5OMor2iiqALBC2tKVNO0JqLro8sFwNlcvrW2dwnYuDPS6+2o6c8X3wvs6Vja
 SY3LtEPikgdKN4bab2NJN4b2VWsAcwhWyS223P6JsHIT9xeQOXoedsk0b+mTm218SV46x8eDsZd
 J4xaJEFZDGX3qQL+P18r9U1ivybbzZLHw6z6UJpj4hiwBFbSpptDQqgMqZ9MSg3y31VFMCWjjO3
 5OywGLwfUSuYwwTGS1KuKFfZrF1FNRTcgFDPfncfacYWmcG0gLCzVg5pXbRc+Q/ZpSdPPl5VQ6X
 u54pSyT8EHlk3LA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NCBTYWx0ZWRfX9j/sprvx3hp1
 yPQfci7kN1TRfpNojPbUNj5V1hJ2XBRZEPvbutcAlXpby9IVL6c09lDgiJJXe1x9GEsmWtn1sUa
 Mkcl5z7yZOC9eEyho9w+ZW1CV+S3Zyk=
X-Proofpoint-GUID: Y_SERGXr2pYf6rFbJD1MMI5Xu1OPCzrU
X-Proofpoint-ORIG-GUID: Y_SERGXr2pYf6rFbJD1MMI5Xu1OPCzrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NCBTYWx0ZWRfX6cIl2KsPioh2
 gB+tT2h5IEt7xqJs8hCv/CpR3X0X4PMnrCYzlKhZJ1etp5s9YqWgOpaHDFv8QN8LbCDpILuvrt1
 nWcTmIsa11SQNntb1wGnBmbfwzqTWT1v92bEWvnejdXN6R3A1NU7YbUPyJuvlLc5oupGF6RTmc8
 M1Y+U/B14S3+8Jz8zr2ApUwXjCvujnrT6SKZLhUKJQQslm6zCVWfmb2aU/aDXM+prYjTnsjkGqR
 QvhJ65lBTZ86rpB6myYzIOi65IvY/K3kaai87uo7AlBiLl6oNQFqeVeZLalxlvKIoNCDWuWD+BH
 cN/gVusRgQuiAYEjOjyBSPV57/oQCl8eIzrpL/u6b0xXSYzmSqatSQlzk+BcubiYx0loZEBEwMB
 1VJqCEGd2D1HsRYCorUOLmtBOBn3o4QSogCgazuX72XpnPYO4vINti+IMEBesGyBimd24/l4AnC
 dzFhyozBs+EKQKmdtmw==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad61fa5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=iK5QPMNa_E_FA8V_BHUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190054

As requested by Herbert: this is the aead part of the QCE fixes sent
separately for easier review.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v11:
- Split out the aead patches into a smaller series for easier review
- add a patch fixing a race condition resulting from sharing
  ctx->eed_fallback by concurrent requests
- Link to v10: https://patch.msgid.link/20261013-qce-fix-self-tests-v10-0-57162a38a554@oss.qualcomm.com

Changes in v10:
- don't pass a NULL buffer to sg_init_one()
- fix byte order of the imported hash state on empty finalization
- don't recompute the CTR counter in software for every request
- reject skcipher requests with a too short scatterlist
- check fragmentation for empty CCM decryption requests too
- don't use a static loop iterator (duh...)
- initialize the return value in qce_handle_queue()
- Link to v9: https://patch.msgid.link/20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com

Changes in v9:
- Rebase on top of cryptodev/master
- Rephrase Kconfig help text changes
- Link to v8: https://patch.msgid.link/20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com

Changes in v8:
- Add a patch making the crypto driver *not* register algos by default
  but only if the user explicitly requests it with the provided module
  parameter
- Use the "offloader" name for the crypto IP instead of "accelerator"
- Fix device module table issues
- Make the core driver use a list (despite it only having a single
  member now) of child auxiliary devices to register to make it clear we
  have the intention of extending this once we start the work on secure
  media playback
- Link to v7: https://patch.msgid.link/20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com

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
Bartosz Golaszewski (3):
      crypto: qce - Don't modify the TFM context for per-request fallback
      crypto: qce - Use a fallback for CCM with a partial final block
      crypto: qce - Use fallback for CCM with a fragmented payload

 drivers/crypto/qce/aead.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)
---
base-commit: 0aac16003b01b9282491ea3d454697c2dc7e8c78
change-id: 20261019-qce-fixes-aead-e229fa2015e3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

