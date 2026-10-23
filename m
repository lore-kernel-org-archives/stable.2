Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744053;
	b=3v9P131AtOFcpI4w2z/070gBqD52P2EV73OEMWzbqIghmlJNe17nMGhTzYkqrIJyVTlr
	 Ml/7q8vWZC6H0x8TimUt4NcuZthaARJ3oWybXAjQnbk5G8aa98TRQ6DpACkAx/oaJJN3d
	 ZJBnrpAxQcFiKgatCxSlewFS7iBEbm84gOqb4oMLoO4AYMyYRJCrwk0Ih3WtCqWUbBLly
	 YJ17e5fhilKQiuDueyY9mBMgRzE9vpzaq93z6plSsuxXdpeA1LvmtfRLAIuDNHpSGrZPM
	 6khIqKosjzp+JtpM60Ln8D6Aquz2wzM1ESKDr+8U1T141lbcbIoWxv3xnU4ndGbDRbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744053;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NpvUnsLAKwd/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=;
	b=ofajpAEoT8K63XuVv+DdyU0FKYDbAO4IqXs7TsPtjEk46Xm32hF2sefLkQC5SKQ2YZh1
	 eGAVKBBvFXBHS52lU7FSYKvnX1pxkmtR886lL3cPZ/s5qb/dHeLDO3VaU0SUOcCgpR/3f
	 wfglGdWcfZMhE/OX73WWLu5YyIkBN4VDE/p8c0Soj1G3+dUZPFsC8yWiXDIwoYXc3GR+B
	 qw49w7Y97hoT4euFlmwigeYD012VUZCE1U+vPl6QfjWh6/NIOKO2JMpxpskF1kS18s9Dx
	 rFH6NoGYx9zi/I3QIMQFfIMqgwQk+6lITb+uVzHVqvmWPlrOMnmxwGF++WbAwPaw6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PSCwrHWj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="TEG/LDN4";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10809606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10809606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PSCwrHWj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TEG/LDN4
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FBD92092808
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NpvUnsLAKwd
	/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=; b=PSCwrHWjLM/jAps8RSV20iNK16a
	aQZJX1nEpSAcmkk01ZrCZlmW5VLt3jRD5RPCyblCXAEI4nDyEa3TcM+pDsdkSrm4
	Afir85mq12fk1SZYOzaatdiCcP312uVO1a+8FbaOy3E4sasc+e81+uz0vDDc1w29
	8+gRMGc5YUof3S0iCtxl014mrGbgoaFQ4bv+MW7xj6AkSlJqd9DbAb9v5PFPPhcz
	kCOZc5sqD2YgS9rM0RqrMHZFt7OtI3PM6uXpJ4x6GShuwP83CDkSriVsBOwANzWO
	s1uPAnx/A8lzHV6iIPxYYB/WnDiKaD8ZmHyNdnmaFYPwUyByxBwo7Zj4Gfw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftyg9xg3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso1067057a91.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792744051; x=1793348851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NpvUnsLAKwd/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=;
        b=TEG/LDN4HAPEor8qXVyZYr6c1+sQHCgba9Tig1B7NfkDO8zq+Gh+ZSMA3J9nZxeB+V
         TCSX0b5H2nRiZWVCly70xDFJp9OBnbbdZZCRPMSENY0PCSG4gNH6HC+mtzUQdrcFI3ua
         twGfhAHZ3/Mxt8xSf5nSclEthm3ELe2oVRxXm00U+gF0y7/lzbCGSXY6p+rdVlXi2Gid
         a9UUbGA8mzeYz2hbQiT4DgypXbWrqdChXr9En1KJDu+369aLtXfzUFpPRTw9zndtRGdE
         KzBJfsNhDUQyP7J2ODB8L1n2S2kWj66On6TkS9WskADmc253sH4Tv/gUM8R3qpC8glQi
         QOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744051; x=1793348851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NpvUnsLAKwd/VAqUA+EeIsjP7hKPCef0EJB8HBsJ+lw=;
        b=Y29J6r/hbFkQzpzpQrRbLq6atxNzXQtVsixmp2gd+ptw6XSXHbfwBjpzHRBXQD8Lwo
         ko2rCFGMwSvb1XAb4B7sgSgc9BPMo2ry81m3b9JdeL+3MtrcVVMMGaL3PEUZC89A0YMj
         zXwLS8sKhtgjkonc5aBi7QDgrRm8D9qehw+MyO2i0vYjplt9N9QjGbIOWpUfoHH+xUKO
         N5NzAHycsNwrnB1Jl0PjxrGPo9LUA2/uGGubNeZpUIPUmRdiWCB0z/H8umFn9AKY4/pa
         Ov3zlPQpcVWb5bheNSrAXnqVXyhoD3b6Vv4NyGEI34nq9n65mIr5Fk9aWq6TNo7KHQih
         ka+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxvG5povKGp6wL9ZB/IxLycxLITUvH6IMPWyVvwK3Nbr7OHysBzgBUJr3YpRpdDX23aIKmumLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIr4CUAAU/r3raWTlmumCdSeweGxs9e888ttTLECP0CCMNICteH
	uIJShQE8YFEHGsrY4d6pYtb5Zj01jVp+nwuqc6/Rv+h33Ro5B/wO+V/wpZZGH2Pk4jdZ7bv4dDj
	f+aTDo/7uDhERku7h8ObOz6xhcRf+6O9VX5JrAJTDy2ybWAQe3XjNWyPXveY=
X-Gm-Gg: AYBFou2DRDcpdgwT5ggN+ZgIqq0LSBGuOhw8P2p9Mmw10Es0Ee1+o/ocAW/l/guYSwi
	M2lyqiFu7e2R3PO6+s1+q+CYNfGJ58dDmglaH/1tq8vcaCXP4wsWFYdRHSjON77umYcBo2GWMr0
	F4EjRkSsMzBzJimTGCEa0o7AHSLmTDotG7ORMglr3EcTpDuK9DzRu6qyO5eqtONprlnJnahgQQV
	CHp5Sc3CLMVUH4AYlZ74igpnM9lRg6fPo0X/RT7qpIr/jClWE6oayi33Dlx4BHO3gBh5bdUs5kB
	4rUOPajETw49llhgOcPLhuQY/tzjBqZ743wmU5Yp8pTzsTeVfs/LNBy4QLnum6CKEfZgxCeGkwh
	RRcHghbCIRA6PNc6VYO6CQ4C7BJBaPeblAQ==
X-Received: by 2002:a17:90b:1996:b0:3ac:7406:b49 with SMTP id 98e67ed59e1d1-3adce5ff933mr533133a91.15.1792744050736;
        Fri, 23 Oct 2026 01:27:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1996:b0:3ac:7406:b49 with SMTP id 98e67ed59e1d1-3adce5ff933mr533119a91.15.1792744050160;
        Fri, 23 Oct 2026 01:27:30 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a27basm2692616a91.6.2026.10.23.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:27:29 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: fastrpc.upstream@qti.qualcomm.com
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        ekansh.gupta@oss.qualcomm.com, quic_bkumar@quicinc.com,
        stable@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: sdm630: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 13:57:03 +0530
Message-Id: <20261023082704.2859978-6-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023082704.2859978-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023082704.2859978-1-abhinav.parihar@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb1a73 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=E36itTYgs6eEPh_MiKgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX7mjq7IItEyu1
 EJpFMHBvBZYG0vVKcg3wUEsCr0ZhuFTPaBUnyufR5sj/64dkPAhQdPDroe5pjyq6rEapydbgW4r
 KTcXzlEBcTFQdnS/chNTnHAXj5NBdYQ=
X-Proofpoint-GUID: IvNaJpZRAetrcJql3d1z66DnL6IZ6lD9
X-Proofpoint-ORIG-GUID: IvNaJpZRAetrcJql3d1z66DnL6IZ6lD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX1SzxZjkQzcfz
 P9DQBTbrI4TfLXI++2FwkZ1o4U5mSdaEWYukvIxy5lMT0prWmOWklaMIaoRkuV9LgF9y8ENrzfg
 CYC3zKqnRdw2s1NJoz5yytCckxI2XoskOk8OIcfM0DqppCVPDYKrKiTIkLFmsWUd1HxE972vFnQ
 bk5d1XsgGmmAdI7MM7Oh1Uf++slA+PKRP1rK6kTzorQiOWPZesbvIH1ZYrSYIxZumVPkgTABBJS
 KjMEUmcVDyiT6M1ZubRVZVlnbQ78YAk9KZ10ppl8lh8+y+SwQGmV6QGB9uoe9tgj2r6FSgIBkog
 d4AlgxNEHPJSZmSiAb75PgJ36WbOkw/AVvcBI9WkD/qODNVfYMnxEHJ7ts1wsat7WeQ9y+0Avbm
 4zu/QzcgXL1FHC9i90itbA1EleS61NbHfSO/HptjmFqkRokzN26UpELzv8W3mLTkbgvbUmT92yR
 uKCfAifPM5xySaiEpYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230033

Remove the compute-cb@9 nodes from sdm630 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: e8e1fb5c703f ("arm64: dts: qcom: sdm630: set adsp compute-cbs' regs properly")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index a41ba0da380b..721885455639 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2483,11 +2483,6 @@ compute-cb@8 {
 						iommus = <&lpass_smmu 8>;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&lpass_smmu 9>;
-					};
 				};
 			};
 		};
-- 
2.34.1

