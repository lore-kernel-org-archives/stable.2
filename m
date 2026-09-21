Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91250493D30
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992226; cv=none; b=nyFbxNgpHc6OKPM+ESpCnwuG9DOptCENUDuBPjRvMJd8NfbrIhyXjpBuxK2vso/47PEdhf/pgM4jbVt5n6o0kVSx9ou3cRUF87BiYKY7tgyqTAHB0VTI83xJqm8xZgA+uDlj0zwS/EOURZNsoRPhQJYHeEbjKIscAOzE+bjQ1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992226; c=relaxed/simple;
	bh=dkCg0VF/nmtJQ9q41G4WkvDXretB+OVH59ybsKpgbv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9o+LmoZatklUZl79RZ4zFcCzBGkJYJVdcs9HvbA3s3RwPprf3MFheSgc8y9F4U06Gc2lKYT71bOd9roX71U1tfd9ADiqOvAIqAt0Z+RbSnNsuRQ5Zz/UlLFwYkDXinGVn4OfOjUyoEVYpgMoqUiwYQA6YagPxS/CHS6pxkW8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAeFgV08; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FauWyBGP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAeFgV08";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FauWyBGP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeCja837943
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vr7HzjusZyhP4/dXgy2m4qWv
	YG4scQg6gixx6oakxiM=; b=NAeFgV08TE7KU6No2mBroDHTkTdOAvfq4qQHZ5Mu
	A0kq9ITkZ6jeF8X3oOcNFdGvUnT1MqLX1MKMjpWeV7/MYM2xkwldpCDJN9pqs6lM
	GG5mvctAQQCZF9ENDq58pXN4dB8ASIyWIPBSOgoErlB+Hme4/fY82bF9jL6JwULx
	qyr2DgMsRBeDEVOnb8R1xZp6QULEYfAHeG7BmKh7Xqp262dlPO1GrGTnK+VkYLr2
	3J51OU8nbbO6TpWs0Dn7nipKa/Bp9+V68y5IMk+cQD2DI4y/OkRKaIYTqg0q/X4Y
	waCWUNSrHiytYE/lXZqk6LUrBnuzr6X4WMio2o6sJSDNGg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hpts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:03:41 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7a8a773db4eso180410137.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992221; x=1790597021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr7HzjusZyhP4/dXgy2m4qWvYG4scQg6gixx6oakxiM=;
        b=FauWyBGPg5iliAH3qWGUDc3DPH7vnt50WZk2EH9NJI9qgvvgmFFljOXI7lfo9ODBpc
         pqb/3nP7wappL8EWWVL1r0Uwl/2eDTwnY4Lzmi6KY0CC7hL8Sg7lfagEzKwfjTwdQolJ
         pEGdKYw6BCWYLdI8e6Iqk4MirYyKAZhntPypyI94FY8K/Gm3BQSpFOfwWrrjXggYjTEj
         VUPjA8TodqgT6As7mnu7psJsJvD8LbIWBmX2Rvm3ZDNcAssSFhBLNMcInU3dCOq/yb3y
         rj/RVU02sVLYH9r+nH3fgwcAnrv8PbrGO4gNHwwwJrsPcy7vzc7tq2cSxtoJvJlwXNRV
         1a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992221; x=1790597021;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr7HzjusZyhP4/dXgy2m4qWvYG4scQg6gixx6oakxiM=;
        b=pqtBO3yTh03MSJQ3Z7LFNDcxa5oUBNHFO8vMMk2plkblqBoHcdMfXl4ZJZneUitTYh
         DPUEnS9vhFu0yBjFJ89Nfgc/0mF+y1xkOHtvf/Xx2k84AYlwg4wOm0/0J9J3P5xn+X1e
         Do7EI9oIyrXd939jW191vafK0lTh27wIdibAvE2a9c+TMAzfbeIv18dC3rT+T6wMQKhR
         mWZFQ9MNA814993aCtfA1qpEBzQZzFagIOBqie+9pyfrq4TlH6+X5cVjOjh5ekUNH32u
         n6GiZ5+k7FBKdABW/+A8LIy+5NLVK4JjwSWMLyt2xlUpPbNO72b5uuuDkkMqnDnlzDP0
         EdIA==
X-Forwarded-Encrypted: i=1; AKwUvBzuHNytP8zKI4qGeM9c6vZHwHRkuzVgrDOVBtC+9ml5eNIQFgMLG23iDOftSYmZn50lTFmZ5yA=@vger.kernel.org
X-Gm-Message-State: AFuF++l30ivSbUbzgAhbuPsGi6i3Ah3nzRG7mTmYnj2OKRWaK8HnCidw
	CeS4MIWrUyZ/TEMy8RW/zFAAnyoChcCaom65Hk4X2TpCQK4KXyOFVewelai5ZVBnHVzra+QfeWP
	Z7IcbZx0r+AxvD9ZMCUpjdwx8Zro0IScmBC6WT666rc06qgwsIpXS+SY8Wrg=
X-Gm-Gg: AYBFou3H/dhoAtb2Kfv6Zggj6y1KRWLUyuB3+5zAKpyEOuTdFwPPz2yYCXvQTfY/RMU
	Clkensd7RQiLw7vYXd8jpJHZDvof1lCjUYrrqAewT6XwH/5v7TW6OZQj4X6gTSEa43f9qxJY4Hl
	AIx8mnk6IP9dgG8Tm9YWytr/Ko/8c8XhORevczumrcYbOQmUusRi6Zu0+2/gkVqEci43bTkaRA2
	8a7PgZT3w51z6cv2jlevgyMtWTU/bzO3e36NGIQn/ZOQXxIPmsuemjGnaeW5+yzRDavVYTlJ2ZW
	Gf1QDoPd3NFCRZEQT24h8KZaguvRVboldKFAHsoDiTCeP0ykGZ1GJvnoAmugWbD1NRFPJ6AojcQ
	QvtbPnXzVYNsuQ7o=
X-Received: by 2002:a05:6102:c94:b0:7a8:1817:278e with SMTP id ada2fe7eead31-7a818172947mr1115769137.20.1789992220906;
        Mon, 21 Sep 2026 05:03:40 -0700 (PDT)
X-Received: by 2002:a05:6102:c94:b0:7a8:1817:278e with SMTP id ada2fe7eead31-7a818172947mr1115706137.20.1789992220398;
        Mon, 21 Sep 2026 05:03:40 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc471b9a2sm147882235e9.0.2026.09.21.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:03:38 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:03:36 +0300
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
Subject: Re: [PATCH 03/11] clk: qcom: ipq5210: add 24MHz rate for USB UTMI
 clock
Message-ID: <is5xheeyacsg4evn7mrtwl5wzti34oswus6xorhweaknahm5dk@l3cdldjupkjz>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-3-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-3-d242e3d49648@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab11d1d cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JaUoqYncsU2g2DIqJJIA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: xum7wWQhK7y-JEgAYkDCGLNPVkkanwT2
X-Proofpoint-ORIG-GUID: xum7wWQhK7y-JEgAYkDCGLNPVkkanwT2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX0ftgKUS77VtP
 J4G/fmV4OWcQpOp4/n2MTaqo8yKMo545VKyq5ngWShYycGYaj+/GLgVucP/ic4oMUFj3LWOUcMK
 L4nzxFEXbK8sv1QlLGnGTJbEerVgET0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX5wjSUuPE7yol
 dFAXBxrsxZaH5X/i8gLw+1GAev3f0OpEv3wIF28mryhmtKgSaLUj+ZItPGJswuF+lApzDn96bg8
 L5bQ46i8/8puKbzkuisLhVLIt2iPb19LNSlSB0qEA+0/Pcn/F2U4h5yWuvdte78OwL8UQya8+Vr
 tymmcwRJgDZkzuhExMv90oPWKiSsbfrHLWjH7kqK7SvZ8ECn4/FO9L73KEuVzWBbcrXCCbTNxDl
 dXrx7zK8vv8bO0hGn7uPBreFbfPgLzfyUgVHOKRS7WldAJTFRgF6DyriLhQ6appufZHTw7rOoqj
 pFEQLTRpHWs4vo7/+AkfhlpBtmD8QYrrvwOFsDx1ZR0cxYIX8g4uG5YILFS4z/Qdu7fStUMcjeD
 AtuvjnDjSwPTfl/2MBEbWax6pzIXlITbi/mGTyBiyzyms/7chGHVkgULhtLbqjwMJUIhHRCCN89
 FzAzOK2bWLNaR9LWX7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210174

On 26-09-21 11:49:36, Kathiravan Thirumoorthy wrote:
> The USB UTMI reference clock must operate at 24 MHz, as recommended
> by the hardware team, for reliable USB operation.
> 
> Validation showed that USB 3.2 hub enumeration with USB 2.0 devices
> fails when the UTMI reference clock is not configured to the required
> 24 MHz rate. Configuring the UTMI reference clock to 24 MHz to resolve
> the enumeration failure and ensure successful device detection.
> 
> Cc: stable@vger.kernel.org
> Fixes: 844be6e24afd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5210 SoC")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
