Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F74490BEA
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992189; cv=none; b=BC3juTeEZOZOGX5+o7mATVlPbZd3LpKQX/2ySWcAh8Fc/45Xj12IA1PLNVb/BF9/MZ4IQxDJOzfcDvShY2/xagpkpYpG0iCrCsdqX4NOZcHd4slSvq3Bd+yv8usNrn6N/l1CRJ6XZOUjDEYrD+cwqpFEBORppvR8EinwFyPcpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992189; c=relaxed/simple;
	bh=KrMmaOz3/B6mLprGBDFofBWhY9m+yMGMGlz7ua+NZBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBtwxnhA+Nu63sNRO8JQ3fIj5uksLriPSB5wCM2gBClcJxnZUigMZilCxMmdedYp9FuRN5MCyeHuxJ7UYqvPRV1ogUotpuMrePgC4oVksGa3kZKDSGiBSDfQEi8TGaPGBCR2+eiwQBCB20pD0ArL0dTT09ccYsmIY+jXvnUNvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W1kyHEfm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/VhdcEC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1kyHEfm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/VhdcEC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdoC41217553
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dtVe7N4NXxJzsEz81o96S7Bz
	tivjUwZ+xFnS9CSgSEs=; b=W1kyHEfm1p8TTyAdLil5o7Zw5BTPRuxB59XGDSY0
	QIcJvksg3DGKEmoFs16i5gowBRIE49RujsEeVGRLoGqOMIU01VTTYeKmVfPux7n3
	+9IsvQBZd//GTpdNanmMrSbJW++kFQOlwZstLAi1YoSWhS56wa3WoRl3Jnj1iFlA
	gosL1u32lu+5KnrgdNaraHTmGL2MCTg9AA7TMzTU1O97s4I0XtUi2o6jAbBOE/PF
	boqHAiFbBmpS1/8IqLSTVjuWlss7Oe09HJ60oKTp+HxVW7DTpsIDUR1ttUtK7wpo
	nxNFPHtykvl7Vfl/nVRjMSfjGIx0yP4AHiWH35P+6+E8dA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01194jq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:06 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-980b637ed69so144201241.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992185; x=1790596985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtVe7N4NXxJzsEz81o96S7BztivjUwZ+xFnS9CSgSEs=;
        b=J/VhdcECtPeLhKuWi6dLEbey6MW0+3Vxcm4DN+shmlfLkb88D+4SaYjGRA0ySguN76
         ncRUC1LoVVTwjWSfoKzEN9G3sUvu2bXRkxxZfJhwiHEP9Arrlp6WPXGIxnRDHjWZr8LK
         GezKUMolSZBOKbqUF7UTqI1G3pbbgtjkxjZx6OoJbu4cdRTZ5PZoG5C+IIZr7goveJhp
         GF0mUe37H1159VUWCvW/1N3yFTE8gc6M5brmuCTUlNHJtKRYa6orhJtheRwIHhg69vc6
         xk8INpSp5vA5544iGrcaQQ8XEdFoYyUziGHyOnZ1Naka6NnSmE7/AqTD0EE58+kS1t/g
         001w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992185; x=1790596985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtVe7N4NXxJzsEz81o96S7BztivjUwZ+xFnS9CSgSEs=;
        b=Cs3Q5ThYFTZFxUpI71u3Cli08YVy1Ih48NIwK8M5cz1PpyDZDD4bMUqtcuPjPRxNdk
         R4PSHoTdzGdk6gSAF5Ju5FB7UGfTdfng8RSszxDiibPPKvwkgXEz/4qbuKwGiQOFdLT3
         OGDz6h61mK/i8RLqCxI2UdabvkoyjePw23/2F8qBtZcGua+1oHRemNKJr1w16WzXd179
         oAB7hlt64i+Hj+I/b9Sx5YchmLrYLYgRcGQDl57GsuWfhBYGY/bynORmzMfgy0NzkolH
         s9O+MdDtCExKvCce0thkAuL/7zuGKW1mc+2j/BJPdnJoQoBr11vIjHGDOsidsAATOjOo
         HoQg==
X-Forwarded-Encrypted: i=1; AKwUvByWfBjcnT5ta177ojBSVZuleCBrzMJxSdeofCd8kFbCQ+Y/chxAAnHL63Op5/78ZG02LyR1GIo=@vger.kernel.org
X-Gm-Message-State: AFuF++kb2HDxK+08CzC2EwQHl4QI4mc4CF1FYPREDQgCAbRZDuoDURwU
	3MJjb45HXrHL7GabLbaiF6LiMYX0r/GdQcoI3oOhVBbsHnVMS4mUe3hXr0g3wFyQN0SNKIkTbmU
	e3eIBxP5nIGw0WPhaxiozyffP3+SlYbsQj1UT7+nojMu2wKhKGAlrDuvavsw=
X-Gm-Gg: AYBFou0FNKncKiqHRsh+wzYaN8QqNdTnkmxywPmeW48IunZJU2cM5bDbQ0zpObZwTqi
	FUn5OyIMWHXoi2wDZPu76BC0AElbeT4whkYHE+EKzhGXpr86qBYF9Zil46iv+llyalbr5PkGbMO
	q6H06ysyQB2KyzN/jUhoou1TDKUBusJW+CD0Hz5qq3OJiRx9FQZaa/4cRiCe+/tVVQoylF/PJQN
	eEp7WVJBxEm5h6jV496BShuJot1HNUm/8C3Cr0NxMpy7R7oNG/PiE2Ql+zqaw8dVq0iOUuIo+5O
	ueXl/VxmN2mZjWkhezWh8BhnN3rLsRHFbiLIWSHLWj503X19Zj/2zOj1VRmQZeVBMR8NwfDeYnE
	+baLjbljO19PCMA==
X-Received: by 2002:a05:6122:6b8a:10b0:5c9:c60a:e9b0 with SMTP id 71dfb90a1353d-5c9c60af4e3mr1306953e0c.22.1789992185258;
        Mon, 21 Sep 2026 05:03:05 -0700 (PDT)
X-Received: by 2002:a05:6122:6b8a:10b0:5c9:c60a:e9b0 with SMTP id 71dfb90a1353d-5c9c60af4e3mr1306917e0c.22.1789992184755;
        Mon, 21 Sep 2026 05:03:04 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872456ee4esm21504766f8f.21.2026.09.21.05.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:03:03 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:03:01 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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
        Kathiravan T <quic_kathirav@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/11] clk: qcom: ipq5018: add 24MHz rate for USB UTMI
 clock
Message-ID: <rcmwsup6di3nmi2qwnayspzmxxqaidsplx5hlezpyxuu45ykbq@arnpm3epmu6d>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-1-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-1-d242e3d49648@oss.qualcomm.com>
X-Proofpoint-GUID: B0OpniBwVhtDK9hlY3OJT2nbN-yrbE-i
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab11cfa cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JaUoqYncsU2g2DIqJJIA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX9iiEuzakYUFL
 Yz916vnuwvqH9e8cz4H7UWE68TeNtijMRXFREv7cgM0WpKY/Nm3ocvNv+VhVxzeRX7HUAVSZVUj
 AFC6AiKanK4OWxrmH4uU+0iTRfq8AJnkKk5is1qcBp9aw97MjMYAFX7KR3YhYDq6vW7BlNqwzTJ
 8vE5tAOeiKx1d9ddigGKXW7mtotJNRZHT4xnUOcgARxyUh0woNnVK/N9c01+XlWNqzV1UJDZyFD
 Ms05AP2yaixnnl1Tai6ctJduABH85NKdUEh8DzTHehCn5vHV67Kjc9tbT1tCXoq+HTt//q5ZnP4
 o3ka14g1/kCQkcTdofQCet8dHXyZ9sjVazem+8eI9jJlVjMuFYFfkysbNgZI7aJHJT9h06OS4gP
 CRIo1CPSqyTpmvfEZIUMWpppj0bJacY3TsJKeC+UqPrl9c6yXiw8JxVUnXNbNOZGvZf64Arj316
 EafF4ucyLZ3zJ4Z/P1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfXze+4MSaHB91j
 /Hb4t0A/LzA+9ZUIfJ2CgwU2zHg5RraVWYKvxkIqZbVpuLLfnspjWVMHHVxTPQvq36tP235PqwO
 WvhMeI0ahiZwTaSgOOvS+QIfjHIdFuw=
X-Proofpoint-ORIG-GUID: B0OpniBwVhtDK9hlY3OJT2nbN-yrbE-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210174

On 26-09-21 11:49:34, Kathiravan Thirumoorthy wrote:
> The USB UTMI reference clock must operate at 24 MHz, as recommended
> by the hardware team, for reliable USB operation.
> 
> Validation showed that USB 3.2 hub enumeration with USB 2.0 devices
> fails when the UTMI reference clock is not configured to the required
> 24 MHz rate. Configuring the UTMI reference clock to 24 MHz to resolve
> the enumeration failure and ensure successful device detection.
> 
> Cc: stable@vger.kernel.org
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
