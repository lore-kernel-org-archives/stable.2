Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746205;
	b=5Dz8oYCvHdbq8IOVDV3o7PJvsatqr3ifVvYfO91i8ej7gaBUtjbzrrc9O47YwR9bUqtV
	 pZKCjZxfsWJ76gvAOqUo2FOffZenb0G9aYfBNyNAVwuwe+qM6QDJCT6DXACqssWz5Q1un
	 32E7YCb5Kp83kuxDnHO2edCXi5hQtSXxsXl7as7YDv/pcYqAcztd4jHUC89CnHPIdXuqw
	 LPFlRdUMdIA+sVDgX+1KfAeNCAoXe9tXUh6gwDC2IS09lQsB03ci5Ep3zKKusXmzh12GE
	 fGar1SlKXP2KqEezKEZJapAJGUB+f6nXmG51ztL/Nd8IEdwgUXmDVkkFA9FA3UIWnBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746205;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+q1eV+ucE2eCo/QY19WIgE28IiM00UBzaKhHu6xsTrE=;
	b=X1jQGNbwc0bOAf0cSpgStVrvto6+zTyxKNxoLYtXMHgDEZjJ+zz/UNgHBZkwE6ghZdAr
	 Ih+1a66azJWGhk2ScJ/CawsxapXt7wLlzpMdKKr8Vw/YdJKvexjtsm41votp1eVu6NkQh
	 BN4rOSEm+4vfpuGaAxClLMXnHMwy4GFFES1In9jLATQJzOIAGFhsxXfLLYepeQz0dHS9Q
	 h/IJmxWDLVpSZ/CclJ5zJcH2eIPqziuHo9S5uy4UXmSKpSN+JfdOqCgfA9kx1VU6vTQ44
	 NDxc6o5kg07edd1cn+dPDQqONu5thioCOD5ohSm7rsjNcJuxqQ4UtOFcGrzsEnFKF/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SlGnRFrq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QRa+RmDR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC4606A332
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67DC4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SlGnRFrq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QRa+RmDR
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FOZN2572649
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+q1eV+ucE2e
	Co/QY19WIgE28IiM00UBzaKhHu6xsTrE=; b=SlGnRFrqga1sYpOmb5seGpqnHXA
	lMVCsGwtF7E4P+qtUnTF4k+SVec0V+ocmiJO6IjCO61vOGOwBxaratwVbioz6qjZ
	bQGqVW0h0u9FFAPy1p1Oaovg3IFu96kG7hH+aST3C8rUoIKMR9LPkv3gHu8RTNSl
	/pBh6DZ9Wa+wnHTc6dvi9E5dxe3p0tp1evpskV7U6NzXDD3HEqCt31KCG2QbaNqe
	vC6SxfajvbTD/XK6ZkVNhaJ38gmVTiQQGh02anQwIO0byCmhbkAbYFxkp78g9eEZ
	cHw/fek4fN4hO10DnSUQaidXe1rOBSYh/rufLnMoDAzVD0QY38qDs0zrNAw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0kd9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd6532dbd7bso516710a12.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746203; x=1793351003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+q1eV+ucE2eCo/QY19WIgE28IiM00UBzaKhHu6xsTrE=;
        b=QRa+RmDRJUJ5mcV5fq/2UD/vP7mk1w+/EM7x/Z2F0Xo5ZiyfwuBMJoTuuc0aebc7MP
         9e+SiJ6OVJPDdGVahn0GY8tAJzW+7AalwedaiJhKicvvO3ztVIaE5CtroVhv8rC9ew+A
         nva/7/wuumKUDgil5RFW+zKfUgRelBL1SAqMNouTmupc5pldOf1rfP1m5aJs29mok8Jk
         +s+XByF8KNB+D+zFdLAV80tloxy6NXCduwrUyJoDhGBB/TKLCI5ugG1oZOTm82bedmD+
         pbqFfehqFBnPR1DP+rh+KqgMDlMXkWkFX5E9KcxiPs8UkTzU0ElFW3F3iKosEQuq4ZtK
         d4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746203; x=1793351003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+q1eV+ucE2eCo/QY19WIgE28IiM00UBzaKhHu6xsTrE=;
        b=dFzH9mEXqsOh/vK3I9TjOOcgB/PI7meu4TsPG4+DS+FyefTtpGCRvzDXgDFYvfuwIr
         N+9SnwJlBuAeixrCnOKUoxDHAA98q4EeXGzjmlGyLIbc/ZD12C8CIUlKOZ7Ht5wFK3GX
         LKU0NyIp6Jw9uRq1MkCc+fZFxSzXfempo8Np3MCGLowZTjzdS6RtaFLt1Ac5ABFuS++3
         v/jz5b6O9xHl96QM0hcLPWSu5c45uoGRYmYEoPMHxGd7WdYlsIT09AhXBXm8IkYmeakN
         BacI6BnBAXeZ2ASpDzYENdMZ8imz4NeyJ2ZMKjm7dZMPpFqYlDD4FDWcLBNIQA9pqEOL
         Zz1A==
X-Forwarded-Encrypted: i=1; AKwUvByfuyY3kDn3nZqSpJfxGXKvHPrqld2gHSdRjAkrxmMAAVdVYhDXdDwI4N3Jm2Yd8obUkTJLDYg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdw4D1f3qpZXEzRxrqZRc9MSu5sOHF7hepRQfNItJog6zvQ1Ml
	mPQHCazI04bMXp9UdXH+jRXi/AS8aYCFYTZJ01LjMPoocTJUQM88Rl4fOyQS9BkYHzM9QpBsiJP
	KnxhqZ+bjKbcOzhoo5i6WpQFjsSas0eicAS/6ykW9fE3mf+H4YA9sbI4poSU=
X-Gm-Gg: AYBFou20AyA7+PxVrWqee3CixiPB8VXLHYrxdb8kojasXYzuNOwk0dZ7yMiHp0u6noF
	JMMXm0BbXeA1pkNkcSW8uTYW5f9thUcejBS5ITajQ5ZAJRlSQEvUVZxSdOcg0xD3h503pe09h/C
	jyBAnJw6yPd0aCLwMQafrsJuDaYNB4ZntjB5yqR8F5YUS3rpQwNSNx5pk+Lxhn3Vi0SKxZW1K9s
	iJ5m6ks7LBJDLZC0S/3jQA29qqsysMTUMSAFnaLsxlTOHjYYsFDV/uUnL4DH3VxxmjB1NtgASER
	u3VS0/UciWg0UTtib7nGKVxaa724IaCJbUAcKC/aqcjgBEyhfZ80AUc10XUVkTD1+N5E13dfAZx
	zf5hicocSo9x0R5InfvD365IRqXUr2poKUg==
X-Received: by 2002:a17:90b:3b4b:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3adce74cd8dmr1384923a91.37.1792746202958;
        Fri, 23 Oct 2026 02:03:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4b:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3adce74cd8dmr1384892a91.37.1792746202282;
        Fri, 23 Oct 2026 02:03:22 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:03:21 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: dts: qcom: lemans: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 14:33:03 +0530
Message-Id: <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: VtAMQw9heTtSR2fIQvq3OKFkljpAZjTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX6H4Kksbfy+or
 1HpsF1DX3ph1VqiNBYcR2FxIB1GGDKh41Wqs03CHddwGQ1gA2Jp/acEVMv5+YhFgJ8amBYBF7yG
 wkef92xeDiP19QB5AmymrqfG1wo8tAjO6dJU4LWQjH7fzO+Rpk+ynVZw2BZ85aLd1YYL2ma0/Do
 nRVeJIeXHCSwEZsdTBME4Q8jiV6o8laCxmZ/mC48kOto4YR0QM23TRYQ6YCA1OEdjFxz53NWYPU
 uTGHGa1nKeN26uhhAjtKjv7wdIaCQgFrXldAJFQnfpTm1Km+7gVoqS7Yggu2QenuDyz5vJbtJjV
 thaRnh5jVuLFMl+BEWhMXzzkQYpoKP6aK6vSHAMHwB4cvgyYR1RgEKUhjDcPNp8vzom9xH1wul7
 CkvuRH2GnV4HvuE866wvnytuo9vRdZtdoM70V/8vJLzrZvhd4Pi49Qg23r3OdqVAyC1prnv+C1Z
 mkspppb3o/hT3se1EUg==
X-Proofpoint-GUID: VtAMQw9heTtSR2fIQvq3OKFkljpAZjTV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX1lVTDSJW88Dv
 f8lXlDQ/A7dYgWF2e1SEKLhgZIhGQA0jKhhD9h+zJ+hbuaM1s5kj3kvNxp7XtO3QondMje1z0/R
 b+UUVMiwYlbYaP6d+MCazhoi09hQKl0=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6adb22dc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=OoeahSk16-wZEypY81EA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230035

Remove the compute-cb@9 nodes from Lemans device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: f7b01bfb4b47 ("arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 695eae1b7256..5481dfb73454 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -7861,14 +7861,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x2149 0x04a0>,
-							 <&apps_smmu 0x2189 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <11>;
@@ -8000,14 +7992,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x2949 0x04a0>,
-							 <&apps_smmu 0x2989 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
-- 
2.34.1

