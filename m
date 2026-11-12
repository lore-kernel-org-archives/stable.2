Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489619;
	b=wudwMYAMUxFMj7V/xUYK2u8F9XO9FMI6+6lfV3TgaC7BkVu1AKhh6fUEB0CbS9NPUQNn
	 TsjE/aFPePIla1ZTn7jkIG+tpITmLISqVd6at0/A3PkPhnngSA3fGOvJWK86G+CR2vIxw
	 XqGJ36So6+4zmMglrmPP7mN4FYx2LIKBMT0DU2TbE2GBBW6USp0sOfL2GvuF5NfFnVqUu
	 P0vwAdn/9xTa0GQ1y6qJAKiOrJH51Pf1xT8G/y9tCdu8WP4l+gu+yidi3nBSmCTF/haqz
	 mtEVfnHLEd6HRMMHCXXN4Z1Nh6/1FRn6mCFcu6wHYvhidTOmCAMfcAoyMDvIFTpixTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ud1KwhBJxzUmwkiA/rZSRNzFDb2bfZAFAs5A7HMP8WM=;
	b=CMU8tYZBaXcM0GQx7e24RiTS7CCfIia9f+15QjWpcUmWE4+fl5q00zfXKPvI4QKZYN36
	 166hF/KnoDspz3d0JhYiWsmcbKdItLDnMJ56q5QJEefNteFBuNgo3aVKAdt4CrDXy5G3l
	 4W+gqwBEdr35/fOkvmICk1nUXsdnRDxN1nEcMyj23iqR/v3nx3DAeYvEauF4WF6jBFKi9
	 y0KuQVCvzMoN3Lt8EFme9Mon/dRExmCnfW/BF+u8V4S8FyJznLqW7xwTaUoDfAgyIHM78
	 2BwG1jFM4PK8sw4+Dsa+D2tZR1/WVXpwYnjkWQH5Le89x3u01Su8DkYBZMXdj9JwqsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Um4cZyH+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XxV0bB1a;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4B606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B4B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Um4cZyH+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XxV0bB1a
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8s1iq4149474
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ud1KwhBJxzUmwkiA/rZSRN
	zFDb2bfZAFAs5A7HMP8WM=; b=Um4cZyH+RcAapiMx6tk9QyN4VzQ3CLV9uH1s5e
	q6OoZhun2/r+Nzu42OuwmUyH3sRAsD0siB6rlUhBJ+OKZ+sFqgGVuwZsOHYi5hDt
	X13+Yj1O1RShqE9NWE2mEKEwBDvB0ObUp3pBgMoSJDpO2pxIEUU5dymWvxHSWKky
	q4iXejZj2SkCbJWRXXDzCFuPriPgS+H8QIKcy0+95NauLnDr82Eu8VzDxqxJphQk
	2UXC2BOBCGPdoyOy6MXKbXyg99t71MdEAkGUeV8g8Ef1eWFu1+dHw1E6zlruGQTk
	DUMgT+JVVw2B+dVXXYiDhoqyDdJr3vd50j6C03BHyFnaKHlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc63j3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:20:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-944101e6367so161581585a.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794489617; x=1795094417; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ud1KwhBJxzUmwkiA/rZSRNzFDb2bfZAFAs5A7HMP8WM=;
        b=XxV0bB1aEKrEx6Zxs4rrU3VaIIv3TYtFRBbCPLy4LtAebNlTxWTW/XO+OvePu8y76L
         JifCYtG5MpQgwQ13uIE7nIfuYRiwf+QZsyYSb2DNqOJ2kksXs2HS0KoHqaGhvDxlzkVt
         nWvOxc7GNRiDclmekbUh9Fr7Qe4FO39smOGiC7nsabU+2H5YhlZs6JWyFAsGDSpQhFRA
         JTwoZdp7iXDJIFgC01j4pGK5mha4NH7TQt+R5yknAqlqaXjgH3waxUUTw+845KQdobbp
         Px9wmJMonrYx/NiMa5dQeCj7xVpCuHV60sagA1wS5ZtmihESvjqBtGDIHP2oOzgrAbpQ
         p/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489617; x=1795094417;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ud1KwhBJxzUmwkiA/rZSRNzFDb2bfZAFAs5A7HMP8WM=;
        b=gMLExdEG47eEa11ffG21e8l/Uzo8t/KI99FEpqvPuibR1e2iYHAvsIbYsYOuY7ziGc
         rCvFhUHESWYb6d92RAGfdE2lFuuQB16Tfy6WmNIiHhuVjnFTzKLTWE1h8cmgACwV7ZQ9
         l+S/cq8FTPsMF0iOc+4pa4gG9B3QPvDXQGwGHzsC2MO1SA4MyAVS+HPzwKlmxhTlveID
         +TT5SyitcnpkMgH+klxDwBlFzgLvQVeMFNx6zwQv5fGa4LdzpS8oqugIt/a/1w3788yi
         wXzJlLg5fG0Ck7pCuWbCzWQ3m4fDi/eU8a83dacbGXy64meVKpaJExJMX2oDMyOX4YeI
         Du3Q==
X-Forwarded-Encrypted: i=1; AL+hErFkXzBNM7mha5Ft3CcExlVGCPWhTmLWZnFnnNqxOTF2C+sHmdVmuQJeKf29U96qr52jkGXaRvE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BtpJimd0Lc9WUSxpBHjIHkZUOgVGT9HziBdYkoY3b6tgmglIY
	l7ewIdvogR2e6tYyn9xJovlzbauo6unuht5YzooBNFAku20PTMYureQ6MVe4oj7K7sGeoTLsUuN
	wq1qp7KKkcnYGlO40n8SllXozfBjMumcdRj8AoXgJbAZX7EULH8tKz+t6Nw4=
X-Gm-Gg: AYBFou0Z15y8qYPIJIKCQDMcCr39Mq4oCo7dR8ORUvSpOJCsGK7O2Wm/9JfxQWb0Fux
	NPZwHqhXo78WFEqtLpc3+8fwQDG3Gz1QLpCU479RR7VMxPFhulasKO9VnPbh1LM0r0bXq1ET1us
	EPXR5dN4xRpk4uN+q7BIhA6U+BF4aB8g4ckdLD3cNYp/ohKj7093d/0240dYseYHHQnif/uUewC
	hj/ys3g1GPMw5vttAW8MuauImM+Rma+9n6JrPIL7MMZajdbMcAb46KlvCoouVJuF8xB5w3vS40P
	2EStXua7mQV2iGEm2vyFokMSUdRVRreavJnx9jmfODZNoYHMG+MI6FU/gLXbhhwn4o1gOrEm/PR
	mGwCC2SoGsQUrsUacg3bOyC4SwBIQCa3WZiYeC4LfGC2rkPl1/T4bMhtBtkPN5bHBsstjuAqOKr
	RPXF6PZ/A+63rgZMyQlxKRLm8aYfCrbv+Nz0uX7kIo6rD3TiZBh4HZfJT3njbsvLA=
X-Received: by 2002:a05:620a:bca:b0:93a:1196:ce5 with SMTP id af79cd13be357-9493310729dmr464011285a.33.1794489616814;
        Thu, 12 Nov 2026 05:20:16 -0800 (PST)
X-Received: by 2002:a05:620a:bca:b0:93a:1196:ce5 with SMTP id af79cd13be357-9493310729dmr464006685a.33.1794489616340;
        Thu, 12 Nov 2026 05:20:16 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a495csm16744366f8f.55.2026.11.12.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:20:11 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v12 0/2] crypto - qce: make algos optional and remove the
 BROKEN label
Date: Thu, 12 Nov 2026 14:20:07 +0100
Message-Id: <20261112-qce-fixes-broken-label-v12-0-7b5b9c7083ed@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAe99WoC/4WNzQqDMBCEX0Vy7kp+RLCnvkfxEOOmhqqpWZUW8
 d27tYceexmYjxm+TRCmgCTO2SYSroFCHLkofcqE6+x4QwgtA6GlLpXUGiaH4MMTCZoU7zhCbxv
 sAUtrfVXqwmMl+PxIeKz4e62/PeG0sGD+wS7QHNPrsK9KffBfEe9AgmyNcabwrXTmEonyabG9i
 8OQc4h63/c3Ic5wodsAAAA=
X-Change-ID: 20261022-qce-fixes-broken-label-e6aaf9624fe9
To: Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Birk Skyum <birk.skyum@pm.me>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4173;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=EwDtYv9Buv4+7yibwtqLU5DD3WUd5mC4sm0SNiT2HWg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9b0JnqM5wAUYNu2WkHJPkueCqCZKKegCm4TiV
 W6zS6UcNbyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavW9CQAKCRAFnS7L/zaE
 w3ZuD/4ht7rcv0iLK0QTLYcxmUGqmxhJXY9EYDH/fNilZxyaRCgNFYHRFVxO4K4IsEDJZqgioei
 R+qc4Bbd0Yq4IKEeFWpKgtTQfxwQKgJM5wXB/RqXUgEkyo8RBZgdDIxOroehAxEcLySlsE5qedf
 CL0XUdu1AYg9eF1VUMXcdRrV2GMG2mrOvSPUD2K7bw/YvJQUodnQMd5nKwZHUF5hPljq86nzGNu
 +exO0BExbOkKWij1351zihPY1licNMnBVOnVD1iSmQsvbHCA2qoBVtAz9q+sgoXwxnwFTLQxK0R
 ATNOvG/adpkO7ToRNCHTCVzjMoTRR/DLpXTqP2IHwiETIiGeLGbHWAtAqUHh0sYG+2Coz7DZNQ6
 zntWc7Y0Bl3RiqKuVAbIm5UD7kd9+PP1AcYHveTiZiYu9ENRDq/7QkpQt0xrSncPODtTJ/bwFSI
 B4n0jaJGeL4dzFf7DbHYcLdJQXaK1nHkr2ayPInBfGpGqpm3GDKy8iKcLTWfu8lJFbNdJm0LwM7
 v1MHkXe9gZFz7rMzXAPt10/GCSTd5n4ZUijLlINCpQBLWpBtnIE+6rHBLCMm61exxG9eve5ON62
 N2Thobas0cdhj5gvQzfgLEJJqPct9kudBc2Y95siP6AJDioB4brD2lBO+3tI0obTNNpiqpx8G9t
 QREFz4PwpyNXc1A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: JuDL0RkqQlyxnWkMM6-xFOjNaD-b711q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX40uP2T4zR/jw
 4GltUvEM21Tm0XfU0aUdCuXT5tmjIXKWJsUaDALYKBSTCSFEPVavrCWzz26BC/ZlgY3Dd15n6HV
 dZWx+CjtNzL6qG/ovHu+y1gPDmiRKEYCTkGEvuQbCwtJr+INBTZ3O7ksK6Lh49RcmxZeMRh/CF5
 R9ts04slZZPJwFLfcuPVBL3AXndAsA9pj+9oxmYf+uns3PHOP/rYtXjOzBrbmwHCXAMHVHXPvrE
 L2OPDEMx9C/7efUtSGb5auIoH+iSqBckk5fLUxMVCHoCjhM+04o+HaSMuvhbyVR9CaSiomglwER
 2bXVbIsN1jKRg1jg+ztS94K1PhceGpydnh1XkzkhKx9ESJQ1tMF1jH2IMt/daUO9lmqKrXtjtZS
 J/Vr+BdXCF7e3OwEbIfDP7ZKueLcS9BgoQuidBSHfa97GolCBE5xD1ddouCEIUKx7sZrHvFnnR4
 o5skqxkAJUX+wYyZ3Gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX3p1Y2Pz/dL3c
 t5twZTCtZHUN/vRhBKiqp4bFvhXWK0hZWur11mZqpxEm7oCmxBHn3bmmJiaFaQH/l6+J48QnVUa
 dV5pY4VPyGMRETila9WAB6HrWmlv294=
X-Proofpoint-GUID: JuDL0RkqQlyxnWkMM6-xFOjNaD-b711q
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af5bd11 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=RPm8042193-LcWM-IooA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120053

This is the follow-up to the three smaller series fixing crypto
self-tests in the QCE driver. It makes the crypto algorithms opt-in via
a module parameter and removes the BROKEN label so that the driver is
built by default.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v12:
- Add module description in patch 1/2
- Drop dependencies from the series as they're all in linux-next now
- Link to v11: https://patch.msgid.link/20261022-qce-fixes-broken-label-v11-0-0d33c34fd0c3@oss.qualcomm.com

Changes in v11:
- Split out the patches making algorithms optional and removing the
  BROKEN Kconfig label into their own series
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
Bartosz Golaszewski (2):
      crypto: qce - Only register algos if the user really wants it
      Revert "crypto: qce - Mark QCE as BROKEN"

 arch/arm/configs/multi_v7_defconfig |  1 +
 arch/arm64/configs/defconfig        |  1 +
 drivers/crypto/Kconfig              | 22 +++++++++++++---------
 drivers/crypto/qce/core.c           | 13 ++++++++++---
 4 files changed, 25 insertions(+), 12 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261022-qce-fixes-broken-label-e6aaf9624fe9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

