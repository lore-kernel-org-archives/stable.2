Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FE3385A5
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971597; cv=none; b=gWlsCitadCF9wM29fqUIP7SARAlUEuQP3JQCasz4Ky9UZMxJ9O+C230IGc1n4L8hIQpkYRa8uCClSVKlBZChbVsvuW9d1aWgel3KNyB92hs3bKvg3fqnmxRM6OQCAqVAk2vDQ5PfivCcD0ZJTHicjWhG2MQA+INQ3OT9meBsfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971597; c=relaxed/simple;
	bh=80/vGrZ3GHUbldEoaZPJNavu/WmYAHTn//dUWIpRDOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gL8a6rkGXCjRU8MmaIUvAw46RWd2xkjf5gNtAGvSrjwJyoAL5NjY3e3AZZRI+D3Ozzql7NI/1woBCrx9sE96FiTkR4JY7i7drrn+LcY5zQuKKlPKBByBmKSebCUMpQ5IknkBhpg2hdt6k8I7Q1gnh/asLLlPUrcgH4XZidGCq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PuIfRqk2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RLJngAd8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PuIfRqk2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RLJngAd8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3Z7Rq290685
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W1GrKVI9HDm4uvapAYqDyihZwduMuJhrjZ2Za6rHkrs=; b=PuIfRqk2QP7HSOZk
	fTqbFM0wMZMvB6w2T08iTyr8zCAicKvM6dtlrZi6ePtwujzaHOKEGA8lFIkxVua8
	jX52Sc++aqRjyeoz/zr290QvTyAinTbuetZ/PIO2XplgAllWjMVm2RMdZQZ5q9i4
	iAf+nzTBs/7SCd1aAiSoq8uM+Lee+n3FQKLo9DdTlawuYWmgo6pjRse7fa0IAplM
	jlOf+gW8S161jhqR4CaeMIZ5vDfpj49UgVaLEm11EbP3ZD9CNF3tDe/piB5doOOJ
	l9p5zg5az0xH5kZIOZvLmogUwM2wBi5tWoCQ39hdCQrv0BmcnMXAZXllWs1QjB+s
	BamGjg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjfumyx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:19:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso1972836a12.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971594; x=1790576394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1GrKVI9HDm4uvapAYqDyihZwduMuJhrjZ2Za6rHkrs=;
        b=RLJngAd8aW8Rv3v+eRUk7yYZ2EB+5cYbkx7RtG6rQ6aZ/nnNZtTRGiYPigKOA52N7L
         DanEp4n91DSEsNXZRw+86pEluPAawm7azkjcoEhcBNAs2ANvNaeLWLUomx79nzDfPJRA
         FQnVXS7XkzrsM9LBmSYHbV/HERGBZ6zvHQlFgsrUwfxOwxMXqgzJItBPNUr2LRVKkWxR
         tnmklhxfpQl2tCzuyEHWccC/4ID6QhGaZEKqt6T6bSSpxpMNgF03Hv3oSuqAqxmBuoi6
         CMnhQK9BJCi8b3pkwfrN4U76WjcBs4dBFnEfFmrfq100F3GsdVoZo9JwG2JK0TYra5Td
         f/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971594; x=1790576394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1GrKVI9HDm4uvapAYqDyihZwduMuJhrjZ2Za6rHkrs=;
        b=vfL60RZrcygP3I6BY3+h6n2R/wCOyVftOrpg5r/RMwglXUc0xsITN0PMOFz+PMKZmV
         ejDJeb1rZDyT+v74XPlBmMfFms2g52fhWvFEisfYAaEXuQT0V40NWL0JSOBmQJwxqo54
         RB2N/h0HrQ60Gnmi6AF66SQQmLb2MeAfsBDTPOnqCgYgvw/yCnelh6cQNnvsawHKC7ih
         BLpC6LakLLo5oxvb7sfGJSMnsCxMk4olvPzWlNI/bdHa4/5WPsz8xbvktoS1QY+o6YY8
         ZWN9jiELh9rlTmGW3V+8tbrJ/OsVic0tpi84yf3B0W+aJaM2v403X/PRsY/rf/ojDwQM
         Krug==
X-Forwarded-Encrypted: i=1; AKwUvBxwICKRPJT12e3TaoCY3zB9Rp3UnkTQ5XSq56jOcNazTBNKwjBWUFes1+qg9Y7sd8+BaJIWFb8=@vger.kernel.org
X-Gm-Message-State: AFuF++ltoZTWisRJ2wLkTWoN2dMjvnZFEjF+q6VzdBnxnhjEWq46mkUk
	2xEGwob4GuwCHCLgVyVySpKiWcP4aXcOXTWsVvU62wYNHrxmTiqQn1kr0TtY34mcfXOvdMZ2Dnr
	1HXGYYQvBg4owgIFBD24q2IUbJXyRcnGdilVVJ7I5jEZOjcziwfEjfOcCrXo=
X-Gm-Gg: AYBFou1VTFpKhsGfY6VfO0S869NtQ4/NYB4HY53RaEZuDfFnUHUPqdx+SDllC8clPxZ
	aHmZoQCuQE2gGpYx50fQ6Mj8FLX1Ps0VSF8DBo50RRF83nkUxx/ne9ZL6P3mAI9l/CSGNjSbFWm
	/K42roDtd/pRglcmMynpBGdHuVWflGh2+9ZwRTTg3UuUQXBITr2U/fqk2Yq3VyvHSzpIk85U4Ev
	qxh+YzfuCVCYzzH1JIvXshwGfhn8duzMFsLJ7jdgwrfv7R5VLuLe5xBa+kvZqGho8J73cRkTt5/
	KErMM9l5q69cogTmOrh4mht96g+U8QTFwS8q1PoIlAAQ78dgaEfC518+OWFwPrOsvSfU+lVddie
	d9i02AlDLW4inkGYEAOCmfaOdyv16WJA8uVeyuEvT4TDR2DtKXUvz78pbXwRdxaylOmef+MWEar
	JKyAyuc8ca4UuJAPsBLNaH8S2T0zlHkFjUPA==
X-Received: by 2002:a05:6a21:7e8b:b0:3dd:a00a:7acf with SMTP id adf61e73a8af0-3dda00a9faamr7840840637.60.1789971593728;
        Sun, 20 Sep 2026 23:19:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:7e8b:b0:3dd:a00a:7acf with SMTP id adf61e73a8af0-3dda00a9faamr7840824637.60.1789971593315;
        Sun, 20 Sep 2026 23:19:53 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:19:52 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:34 +0530
Subject: [PATCH 01/11] clk: qcom: ipq5018: add 24MHz rate for USB UTMI
 clock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-1-d242e3d49648@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
In-Reply-To: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfXypDw+FsyeEVT
 4+0nRommytxz/5H7FkvRrshmkVcdpqHbYBPKG4680TGBQ4K8bTvVhdpflDgGuprl0WGre4qdolo
 V8z+wVsIiWjTHR/KP8Fblp9aYNjgjhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX8bqlcJ+6jMsd
 ddYScAj8/YwGZOrrIz1XwehiOdfXR35uHLWGPXOdvDiLBZjsg86GSVOSUBtn2RFxoFzA+gRcZ3a
 u2R2dsuBhPrg5n5e6LnlZnajoYMmvk4B8vErSKnmvnPXe4Ca2nYIodSK+Gn6b1B8F5IzOrA/Fq1
 o3+i6jDTFz5VmG+bfu0720Iym9FdLKuPPjy6gkWXTnTDGMvd7ajrjqkSi9AyGSSDAnC/xiMvL5L
 YE+6s8Oz2TXFsdMYpo5ExPFjokRW4zpw6yAFN7JjbIMmjwHlZxp9+h5Qq5N6eydBfx5jRtreGYL
 q8lisSxRby8bLhT4KvETX21GBWtKUFblo9i8dpPs/WEaJ2qPI+oKuminxgYL9tvESHt15tVf2qI
 yrQG/7XtrCqJdFfmXjbR2BZ/23/nwgNyciiUnEK1y6NIorg9aOhPCtg4WAOKvQ4Y4qSFXO27idz
 4QR+OrGQJyonteBj1WQ==
X-Proofpoint-ORIG-GUID: BlszC-IYfMpkRaXKOQpF1sBAWGwOybAF
X-Proofpoint-GUID: BlszC-IYfMpkRaXKOQpF1sBAWGwOybAF
X-Authority-Analysis: v=2.4 cv=QKv91QLL c=1 sm=1 tr=0 ts=6ab0cc8a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=T_jLbkAMJ8GdCbUqRukA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210089

The USB UTMI reference clock must operate at 24 MHz, as recommended
by the hardware team, for reliable USB operation.

Validation showed that USB 3.2 hub enumeration with USB 2.0 devices
fails when the UTMI reference clock is not configured to the required
24 MHz rate. Configuring the UTMI reference clock to 24 MHz to resolve
the enumeration failure and ensure successful device detection.

Cc: stable@vger.kernel.org
Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-ipq5018.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 594dae3bac4c..7d0889eeffd5 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -1260,6 +1260,7 @@ static struct clk_rcg2 usb0_master_clk_src = {
 };
 
 static const struct freq_tbl ftbl_usb0_mock_utmi_clk_src[] = {
+	F(24000000, P_XO, 1, 0, 0),
 	F(60000000, P_GPLL4, 10, 1, 2),
 	{ }
 };

-- 
2.34.1

