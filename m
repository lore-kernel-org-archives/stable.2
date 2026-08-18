Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB52DEA86
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034191; cv=none; b=NvUxl4bkDLTaqp17r+rUF5NKhD6PcXTBEUdx402M/9BaYvQyJ/xbGWIMoBNvJXx/fIt5wSWefL7fJ1ttnG1usHEMkZMiK6j3OXk0hOlMN0KTn85tetbrt2Kb7T3kXtWIzIAhZR8368u8zLDxO/nD5kQRBnoitZJzDu6xFAeM0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034191; c=relaxed/simple;
	bh=KafBwlNS7F1eBtW/P2W8LB66nN9RAdJZXvoaLTsucck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBtwxFs4y+9HUOVN5wctCRpGiQxFR9DQi1lxQPwMNKNnx7kMT1kzFpxAJdVbbGfOnbHaQFftSaxm7XkYlIWokZj1HYlDC5RbUN2x1Q53ss3phvFq7MqQHX3hD3loZRfPl8hq/bn6/FVFio1T7i1cj1meNfZzyy5AZE51hQKGpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LUL9kB0C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h3S1RC0N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LUL9kB0C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h3S1RC0N"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I53CRI3533505
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zfzm+bo2AIdMTY3h5qK5tKXhOJYpTzAyExl5KALMhX0=; b=LUL9kB0CaXtlm2h9
	1o8gAh2DUQQXz2VW8VsFpW6lBL51DvIWQ5BCl7Fljb4jCmGZ/tI75hk9+ZWze6Ud
	7gXIyuMJHa/+Pa2H3elPSMdmAWHRxR0HQrWwHPrW3/36LIqpvsDPdw4tGqJYJhgv
	k88X4gWH3Sumau8gZyl7ycyM1e6CtCLa5c6XS/yaHtlQkZr4EX7L/FeYZMs0lKi9
	/ZZ7ezxhl4iFdDhpEsDClunK21IgcD5/CXz5hpxyQoA8nja0nvbjfEsgSVQLvC2Q
	tmdvcYPl2HbIuCiWAJZABz7OYYsT4FhpIY6QZQgzigoWtIRohAQMM0nw5a3KBXWF
	BHsyZg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615jxu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:23:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e934385db1so48682096d6.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787034188; x=1787638988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zfzm+bo2AIdMTY3h5qK5tKXhOJYpTzAyExl5KALMhX0=;
        b=h3S1RC0NZ+wV/rKmP88iLTx9LqQORYRB+9Dyhn/elemNsyz0dhYvtuVE9/GyyqVV/v
         mUh39N1jpkIIQ/58vE4C1s2kbLTpxZweyKbnSbGwbVXckoGxEKGNmhwJXHu2M/b8m9kg
         rIOZf5A0oigGbK+NIUxCQNbF1pjMOIcl8fUSvxRAQaU1vY5e/oBj03/6ZddtyYJ2JhUO
         9l1itak/qGZgEMmP/5CyjHD+OVWbgUWMn+n1P0SuqTJKfhtLX5eZufHE4zyme+aRjMNK
         clje4hTSABuligA/VLlCf7z2A80pzDKT8a98lX4XkNr9qXdewbceOkWNMhGKDWRGw4ks
         SqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787034188; x=1787638988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zfzm+bo2AIdMTY3h5qK5tKXhOJYpTzAyExl5KALMhX0=;
        b=Ztf2jBG/Yvg/0DGilf8p1FK0NkfGNGp/ru/IsoXy3tQ8+e6lH6z75Z3XwuMWWb5PqR
         LMN8Lu2DODpt2d1G/YMWq64Ta8MZMjnIMsoC2tud/PnfSKPAk/gwECdc6q//+0qmtSb1
         gELVj0hfJtxFtWitUvJbHNvyo3PYwMd+HoSdNOm154kTkPN41i+dskRgDNcXRNXHG/TC
         P3hbZc+fYwULyTazffa0/mBJRvoE0Hdu5ghn+tJ+g5YMTVB5iu1NAvGxukNBiOsx6/Si
         sE5wIsfb8V9hdDce/G92+/5K+YGaPJYURcqi9Ddjy5I2/5Md6Tu1ufQjHJ07tlkXQwnq
         OtPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRsNtRKrhl7XGC9jWQLylGCpSa3GAa6hMFokGwQ2Vmr/iHM5WoXnyhl7iHWgeclnqFru6ddCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCLM3D7dNXKGxXjf28EMrTtF02fqVD4EU+H4QFk3cMIlgjYTF
	KSp9ZNnLBKGe0lTwY6WFj3ZsOI8p1PeQpeo5tDp92kd5eS/G5cWtfkBZUFkk+TqWFdgJsvH3Sge
	xdnAxnRdjevcYuE7lVLUef2WeWy7G7X/nRWWiOJ6TRIJ0IQFZQhirCBsh9j4=
X-Gm-Gg: AR+sD134GcoPp8cBkZVwgKiPm2Mrny7knrdTtxXiD3PAJVRdKRGpMNakwna0EIJbkS6
	beCSznNU3A1YvYisg5NXOtUm7RX/cypAegnb0u8HD++3b+1HCL4Po6mcewZhQSEqfApjRBaR7Ja
	zcGE40kKFUu0aVjuHYR3cTM/S1UiaL7vzGbxvjsCryabALhMWaVtUeclUy59JDjfyx0rRpFRM/S
	mKHtNVhB6gP0T6CtDbdcnsN72/w/tT5lP+X1IxNV7ZqERAxUbBZNc2I0HW05V0iQVWRd7kAHVSI
	FNzNax1IZqbxayAzNQn3DAed0+P7MRma7G9Fr0PpUbsPmxutg1agkKqVLpvIx6C3nks1HcQSw73
	dOajy2mKGvB+XypsGSzO0+yqKTTM4s9Rj7++raGCYK2qPqVhsMfXZE94ElQVs1by1O+8HGHTit8
	cVPhn39XZmeGq+
X-Received: by 2002:a05:6214:3f8d:b0:908:1bd5:9c38 with SMTP id 6a1803df08f44-90c4b3601a2mr71558526d6.14.1787034187641;
        Mon, 17 Aug 2026 23:23:07 -0700 (PDT)
X-Received: by 2002:a05:6214:3f8d:b0:908:1bd5:9c38 with SMTP id 6a1803df08f44-90c4b3601a2mr71558126d6.14.1787034187175;
        Mon, 17 Aug 2026 23:23:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cffeb28sm941348e87.49.2026.08.17.23.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:23:05 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:23:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range
 for Iris
Message-ID: <xbzl4s37jr3uzsd23kvphiguxmq4ngkajju4ifg76kwqrs4xrg@2egp56nwrxgu>
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <20260807162405.GA896590-robh@kernel.org>
 <c3hVumMy_QnRbUmbFTSWGjkfG7lPjGFEcZfPsZeGQ57nWKkhlBL3wgmcDcAgT9cNb8Ju3qZ_sSKgHk8vmow0xQ==@protonmail.internalid>
 <6ee7f32e-eb6c-e264-6f0d-541555f8fd62@oss.qualcomm.com>
 <56b3dfcf-b1ad-4192-8199-06c80cc5d124@kernel.org>
 <Gm8h4cjoxHsgA2enLuxEd_3c_3Nq_RVJ9PkosuciOEss5Bw-GbnVoJCzsc5ciseK-L6bnlf9dbkbbh4ui3PSOQ==@protonmail.internalid>
 <CAL_JsqLGOz7Fh=AsM+g84=Uko10YXU4QN1buApD3CJMkOmsebA@mail.gmail.com>
 <e5e2d588-cee0-4105-b34e-34d2718786ee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5e2d588-cee0-4105-b34e-34d2718786ee@kernel.org>
X-Proofpoint-GUID: QIp3gkiZgGETcjtc4h5LSkMMJl3yShVQ
X-Proofpoint-ORIG-GUID: QIp3gkiZgGETcjtc4h5LSkMMJl3yShVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0NiBTYWx0ZWRfX+Ue7bvvmvM9a
 JCM3+Pn2o9iqFu7twp8vdqx79Gd5UUdd3Q1jI80yNxjllqw5SPg7ikLnEhxvPScEORBWr5pTP2/
 EP9uJYHAo6Mm6Jwy+m23W8nAQVEI7+NfA/T6XWiELIzL+8koteCbCrCwmV8jKzv4M51t6qbbPOH
 cSHOeevoF1fc9ykBrStX9OB5S2mDy2FR6ML8oSaMZ4Fv8Nj/Dpi9OGd0aHsXxHlMhMpeAU0N959
 ff5tg7RIkj18Qcg6u4idDNkqC+G62BjT2tyzECpW813nR+NdFl2o1NpZmRN9gx2Hc0gGZFAN2TB
 mh+rXVDSmMssUUtxlA0WzKWz1jVfhK6CiPPXio8+U0Vr0QGSuA9s+0W+DQoA/ZYFeswlZLYEet8
 IBh+UCH7506DXKi5MfdRue5Bo9x64C6C2hn6dEtROw9a1oYgoRj/QG3Jq+ZH9NS3L7e5tW4AAb8
 ZLAnDzIs2IXjiFB0/4g==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a83fa4c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=YG64nluAAAAA:20
 a=nrc8q1p4nULiGNKnEEYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0NiBTYWx0ZWRfXyLFUXd2iOAgL
 oZPqP0VNiLEZgHIO4Gytgc0MXT4MCpzUBIvCbtAWv+7s/XSFF6zujpOc0eO1QoylboBqneiJkaA
 54aZrD65+b7P4VpCrqKCuCDEO1AZuE8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180046

On Mon, Aug 17, 2026 at 10:54:47AM +0100, Bryan O'Donoghue wrote:
> On 10/08/2026 14:47, Rob Herring wrote:
> > > > As per the reserved-memory.yaml schema document, the iommu-addresses
> > > > property for IOVA reservation into /reserved-memory is allowed — it's
> > > > documented for IOVA carveout reservations:
> > > > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/
> > > > schemas/reserved-memory/reserved-memory.yaml#L56
> > > I think that is an entirely reasonable reading of the text
> > > 
> > > Quote:
> > > 
> > > "If no "reg" property is specified, the "iommu-addresses" property
> > >    defines carveout regions in the IOVA space for the given device. This
> > >    can be useful if a certain memory region should not be mapped through
> > >    the IOMMU."
> > > 
> > > Which is exactly what this series does. Excludes a specific IOVA range
> > > from being allocated for this device.
> > But if "iommu-addresses" is the only property of the reserved memory,
> > why put this property in reserved-memory rather than directly in the
> > device's node? I'm only questioning where is the right place to
> > describe a reserved IOVA.
> > 
> > Rob
> 
> Back from the eclipse, sorry for the delayed response.
> 
> Ah I get you.
> 
> Yes.
> 
> I take your point. This is a property of the node itself; the IOVA < 600MB
> only matters _if_ the venus or iris nodes are enabled - otherwise an IOVA <
> 600MB is perfectly fine.
> 
> So it follows its a property specific to this node not specific to the
> overall system.
> 
> Yep, I agree - its a device/node property, not a top-level property.

:-)

FWIW, I think it's a proper way to describe it too.

-- 
With best wishes
Dmitry
