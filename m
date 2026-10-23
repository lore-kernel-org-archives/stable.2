Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746231;
	b=NszIPkC+7+/RAngCSK/mv570drZVTrsTeuNmWaqdsytmJ96p5vrPFd6xYEVvikVp9Ql0
	 R987YOFKwGndKI8FM7itxyiKEXpsWpQsE+0fJZsFhgcJ4fOIUjzGke8iAbTVnJNCQoBrw
	 0kRmH6orPheBhbY9PXxFwGUn57hd/2A+vLt+7IBeSpxZuBwFz7DBQBoYc4afmAAwUyNH1
	 DIYb9GEHWt4o0hNga/in9v4UhmIZ6q2les/lkgeJs4UxmCYVjQ/WEUuO10+jMgwMIjVDy
	 h6R5N5fYFNYuW117+wtExBGk8HLYG5bDAft/k9/QLyuPWk9uPxuiik2TzIzv7/r0aQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746231;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EhRIYoT55j9ig8mGHfIEupQGVMISzGazIaZrj/4btXE=;
	b=PujekFvyeF5EugfWvBRjlmB0W6x3WriTUq18erymBcsw3eWL6XTdzh5D6NaymRReRdOQ
	 12KGGzJZtMJQb++Hv0J1os0/25NLIOFEhGKxqoTqCHNRa8sn59Vdw2hRsEl49LXXiiLch
	 qpqaTVIQCdQD45O7ki7YgZR83AwrEWviF4ICLkquWq+85dmkmcV8EbFMAHRbAvXnoWMRc
	 EQrN6bSXaTRqMbUe37UUUkxSodcEQG0kmxNmi8VNhIG1HEosd5SfYbntiFe0Za0zywIQC
	 YK8c0Op54fKRL2WIJ0nwfywdoETLlL8U1fXQNgzPMMT9JeEjcfCmzK7vWOX/7I1USzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oNnya9H7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bo27Z13I;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28A606A323
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C28A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oNnya9H7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bo27Z13I
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F5Ri1200734
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EhRIYoT55j9
	ig8mGHfIEupQGVMISzGazIaZrj/4btXE=; b=oNnya9H71PxHpHVdWa6UdI2Fpqr
	RAlkKwL56vIVmImFPeL+WraxnAv4ocEDUrEXkh/p5Ev+MgY3vyac6fKmBmGgZ62R
	46ZoMSkbvMAvSFNM8quyhemenFvIHGCIK42QtgW32IGMG4JS4GBh0O26wZq8KVEB
	bQSzOdjGZTcKEauPhxqkNxQCbzTjLeU1GFV2XnDSCwiyd8ao+bMOp1pjJDEX4S+6
	LMTD6sF+usPRdctUauAWxeqc2DSAqVXBMQnGQZ9+6HY8QMN4YPQ6fYc2/c/V3Hvl
	R0pm9QMY4PyDeAbIvaZ2o1y7BzFClrmQMVFKQVRA+FOSLCTJ3W0jPsqViFw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms2ud3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd63a7cdfb3so521331a12.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746230; x=1793351030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhRIYoT55j9ig8mGHfIEupQGVMISzGazIaZrj/4btXE=;
        b=Bo27Z13Ipn016rFW55XN6GYdXslelEAAFsr46tbfA6lrF8QKWzL53HDfMuxvMhXLgS
         i6vsZYAAL4AHqLUQCmzBIftOhJGWCL+w9daeqELCZa5bd30GIpPmvWllO+165ZQJGZfs
         f9sA5C0iGKwfT6RgpFP0+qebtMygDu1TXPnCQTXIgd9Xvl7vb4XsGu1fukZTcBmbEYNm
         MqFIheELuVt8Nhhrc4ZRVaotXJlnF0xjzX2lu6avaIrHmIS+TP6HNUEafeHhMSRCotFo
         l/Dp2s9iVpn+ftf9B+3ziyEn+Ciavha8ZgSV/q4XDlULRWUUvtOeg3SNQWGqEuRttRJA
         fBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746230; x=1793351030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhRIYoT55j9ig8mGHfIEupQGVMISzGazIaZrj/4btXE=;
        b=mBeE5irX2c9iYjHUFGP+pWwLz25EeV+8FaLHZW5SorIFtOywNKsDng9AlxtjEY+0GM
         /b6pgHBOSGpm47Rj54piJ7vrRrZnScRi3UF7uJms+N2pkIqyfjlh+xRsH05iXbOOXZSS
         +d9rn2nk1yNsV0oPzBWh6RO3ov5MTPFlOEHvz98hlcW8gg4ILAg0wS9pyZzGxZC0THeG
         aaHbkJxFTN8KdIAn710vZKeC6EovswECBG1EbDeXU0Kp/9cK+/jK9RzME8TsvYwAGjOe
         9s5vrVCnuHP4wLhqW2GBPgudwEgr9uD0v+uFLu7mWykKHXE9My3Sxszuc3mogQhWizAx
         27Og==
X-Forwarded-Encrypted: i=1; AKwUvBz46NrNbEk1l4Izm9RR9XGoRLJv/3qldENFWzZXIPwIgO3V4mKgoxCq2+kPGyXMstFCAXquDSI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZGbr+saXrIkJO3HY2upNfWQc6sSATVKldhVYdvfFrBrjSi6UO
	bRYkz4rhSEH62/rLeQdE9ojbGZ7zfUtheEDFTH6XrAOL7FpY1CsHbuNz9q7feg6rxoR7pECWm2i
	SoDVu46Hg1x0A+XdbZJfjSE1UNiWCGg2e9TD5tNk2nXEfE/OvYRdxqGf8cYM=
X-Gm-Gg: AYBFou1MwGg6zMkayDpHrAyc8O8gSOw+KwyFhv7CajYCg22BLie1LXyoTFp+hgzVr9o
	ER0dlRAtHIxCfA0TlaFfarJfDaso/ozWv+czAS+M51kGa7JZcaoYWo5VeYyFufjNuT5+fOGa6GY
	MH1oDANn5jCdHYqJMYVyeaBJc9aOI7U7AZ1/KWPIWoanqWcNURMKmZ4C1XyUo1zdhgGnQmOGArB
	RxtKOPLMpmArI7Z/3kbO/C0iFAuvmRZvrd2DV54gX5hMpAyt4xLcRR6nuxloGRgsiMGvGz5zfeZ
	supAxf56j0k5oeIiSnVHg+fXAwfe2XxkBZMym4o9QXpHwA6kG86FE+5p6caSM8vEKZZ2OXVENe6
	8EkeEwZJmJSjf2ElHEqlCxqL6NUsGpMK8dg==
X-Received: by 2002:a05:6a21:6e91:b0:3e0:c5f5:626c with SMTP id adf61e73a8af0-3e36945f18fmr1219881637.40.1792746229785;
        Fri, 23 Oct 2026 02:03:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e91:b0:3e0:c5f5:626c with SMTP id adf61e73a8af0-3e36945f18fmr1219869637.40.1792746229374;
        Fri, 23 Oct 2026 02:03:49 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:03:49 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: qcom: msm8996: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 14:33:08 +0530
Message-Id: <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfXxPPv0zNUQ0D1
 AlxjcAlRKKr5NqS4FQxe7RRfI9DQctfFHG1ULwnpFH0sTgnHEIaC2gTfio8aK6GiF1EfKId94wg
 kozV7TzR+Zy78N2/6bvJSlUEJIkkuqZuYGRbUXFoyDQRfecmsuMuJKL90k0GKRHyQxnTP7q7+Hh
 1uKV+z2+1y6xB3q0OBEm6sywY8SOJ3nMLu36lwXfQACE9XPG36aqAwrbwyF3bgMzYSTZrOHhTDx
 6YAJMisbdl2RlMieeIttaut2h3I48mj6ph0LF1uX3AzH+AK2NCKRhCwBrb/34yzF/L9pErFUsUU
 GHTlmDgpMuHSzCf+5honeezwvKoAGEvCBoqy+HoyTaeLLGbj+ypPz/U7feSMIgQ+58llrViXvMN
 3doQYOJDQ2qYzlePJOy1mCxjTeJlstB73EITiqSpyLTuQLQ+QQkhSnRgZ98sB6rF8braar5BAIT
 sEPpfj12RcqyBPjwTdA==
X-Proofpoint-GUID: ITY8R9zjaj-azF-7z1Pp8c-tbxhdDcfN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX2h/Zt0RtcRiI
 dnDpkYGSiErP4v0duhYvSNJDeZcTJ/w31Rm9ZelBuJ3F6xVaN4w3ixOR3yVfS6mtWKa7eVd+gL1
 tnXSuldk6EID873mENCS1PZkyZF2Yr4=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb22f6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vzw34t4vhacumBYsXzkA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ITY8R9zjaj-azF-7z1Pp8c-tbxhdDcfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230035

Remove the compute-cb@9 nodes from msm8996 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: 1b80b83f893d ("arm64: dts: qcom: msm8996: add fastrpc nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 818e5660df91..51ef306c1ce0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3701,12 +3701,6 @@ cb@8 {
 						iommus = <&lpass_q6_smmu 8>;
 					};
 
-					cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&lpass_q6_smmu 9>;
-					};
-
 					cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
-- 
2.34.1

