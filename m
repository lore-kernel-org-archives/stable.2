Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7C46EF78
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656652; cv=none; b=YNSpHR2FBotTc6JouCKYRiYxgEDBWviHbnGporC0D9J/HMAYWoOtIo3k8XqjzXE4gCxW2jjX4PLdSJQKC+DY89nRRl16GX1/B5WC+lPo/R1HcZd0FBeiYkbGT8UZz0n1scctTag/r9rs8MtDmNusYSvk7ajq1mRK6Fo6Qiq7rE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656652; c=relaxed/simple;
	bh=ojDG5A3aFReUmVTmFESylooTByZGHDf4YEWxXzujdgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlwjZp0S4ZbUfaFLcS7MhBElSemxSWXVo9QJ1sMjWvqWeNFOvLz282pNITUUrtzlm6EhxWxYkv9tRIYm2aCYybC2HjGuCABPxzMRTX1JApH5juR1ML09/GBo17T7iW2JxodEfaCeSUVcgkZ55I+TbADCQjpe1C9gl1V5OVmMISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drAymWl4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B+zI38V0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drAymWl4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B+zI38V0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHRehH1927755
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WLI8exdLgFmHsc6o2HEnEZMx
	prx403KO+VO00Ykrbc8=; b=drAymWl4tn8n2kngCUXL90iJ7B498h39PAKLInd3
	59Jl43XGg9gsbGefPmV30T+FSFo6KfaUf6tuMzf4qaO6Ud7A9i1pAWHNlecGru58
	XDM4CW2Futwj56tecdqgrtwuzkl/P1rIpy12cjuEflFTdHLBHgnw6LNm9mYKixqx
	73x/IYH+rxEYHBiRxE2adhNJpF2e6d1FeahSUyfhKXD2V8Dcv6Ty4EZDrVsydPyR
	jF+u5pS3HZVoGwDGrJGUhRmecdXoqcQbvEKeqdPNVfBaNb1OiOd/Ue+KpUAXPlpA
	Db0ZSvQJLzlPpzSKwHBGKPPnLuaPoPU/xMtVU5B6pV19jA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6fr56g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:57:30 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-744c204396cso8829995137.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784656649; x=1785261449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLI8exdLgFmHsc6o2HEnEZMxprx403KO+VO00Ykrbc8=;
        b=B+zI38V0vE4pMAFz/qSEWSaGVw8SDTcGHcO/0JAaiLvVgWERJC2MR8sF8dk8NomlCn
         31Z40xqvOauU7LoHYS3q926hQbAgIWDgdLUTiSE/EkdSarqxPctolXQU2Jg650RQzi6X
         5kO1rB9eimloJcT65VjE4eT0QdbPjm67NcA59UeNGZNFb5hb4IV/asDZIUtnHcxlmDnX
         cqdjWzEUPfuCntLuVgK5xQQalDZbe7Jvx02mC7i9ZQn8f5cYW6yiBmSLb2PZic2T50CD
         9ERjQlG+O4Ec18KPSfwqTImg1t94FjKxCr9r2+Erv1TN5De3zZYruPOc642TUKUexQP6
         1RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656649; x=1785261449;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLI8exdLgFmHsc6o2HEnEZMxprx403KO+VO00Ykrbc8=;
        b=FPLc6QjB2+4s40JKec+Wk2fI3MYa/prC52UcXF7+3rBi7MtZkBpqnVa1s7vYF56uHt
         fE6qKA7uLwqbfhrPhuusFjr7P5h3u7jI1jAq1iIFbdHsoO0Y7ORzCbLyvfIo3z4hOPZ9
         vrzRWfoPtGt1H3SiKxgS3trMU8RrJ/vlYn/6WWkppjHRx4mie7WvoAns/zX4t8izcSaq
         nXPMe9DcVjFFnrDuPQvctyvtMS301mtUhHehIo1ykRJijOmcBtNZa/NM4ZL1Evxf0ItC
         IZMIfTxpfhKxN0JUTLJeQLV72mrmNFPCWoSY9KvMhnU6Ta/LXl+CmF3ZoYDGLJeOwkRR
         7ZwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoACQYW66X47b+B9HgN8/h0seKVdsQqrc9dGPm6DLUKlrr1qSyG/cbuUNjyLDhojUOdIZIamhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkd4hPsxwMZV0awKorOmZt4Mw5xO/6wWyuwdTDdgNJ5Eq8m0VD
	RJzny9jubEjYfEv/24dwffO2u6WmFiPBNQU+OdnDFrTrNQf0hpr4jCPxFjWv4fxRAld/hTsIvlQ
	lb6l7I290mR1Aski8bA9GhnUOjDk3Vyph6a0nNsszAJzUj3eVmplNe55zD4E=
X-Gm-Gg: AR+sD10IR8DSzKhxYEvzoL1CCot/TUNRIshm+mP4t8HRTSAmhoK8bPsBYI7b7ftcwyJ
	KEMg+pALOUeyfR/ZxUyRGKYCd3bfYg9CMdGAk3rXTqzRM00YLtX5lm7w8uxNvj1pKYSo9DczY1t
	bLPyRLgdYmvJENw3d7cqcIMd5b8yTPLXMPviCdcg0GXAznkjRL+J4HWcV8awYm8x0ZO+FFlyF3i
	yQCiTZIXue8h449u3FfrXrhi/c4zdmw/gwLU7izh9K86tdzNeLxnIK14Mrfaz/3GqXwLZyrkJdR
	mRwgIGJJKvNpa56DeOLPwNFRMWA9r+3jot4WhKSwYxSvov8fOLfqg/TOOl0m3rF7LZm02EWO9Me
	irz2Gd86HTztjhwGH8vIShNOQeDLf/qLx7uwNTP5uGErSpjLGq70pCltWD9V64hf49O3NUfXBrO
	J3JUyKiqvsKD3UNw==
X-Received: by 2002:a05:6102:5e83:b0:722:826e:1423 with SMTP id ada2fe7eead31-747536fa410mr6545680137.20.1784656649242;
        Tue, 21 Jul 2026 10:57:29 -0700 (PDT)
X-Received: by 2002:a05:6102:5e83:b0:722:826e:1423 with SMTP id ada2fe7eead31-747536fa410mr6545666137.20.1784656648869;
        Tue, 21 Jul 2026 10:57:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6c5e37esm526821fa.28.2026.07.21.10.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:57:26 -0700 (PDT)
Date: Tue, 21 Jul 2026 20:57:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 2/5] usb: typec: ps883x: Return -EOPNOTSUPP for USB4 when
 parade,disable-usb4 is set
Message-ID: <6vg2kezxu6jguqassp2l6rsx3cg7ja3rxffitzmzhtbc765pnt@m4lalzge22td>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-2-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-2-cec86d0b909e@oldschoolsolutions.biz>
X-Proofpoint-GUID: PaKGy7SIIBEBw3-pIPp5nD3FnsEj_zty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE4OSBTYWx0ZWRfX6fQVHjWmJl9x
 lywxrajVobRLwwwolJ5yhHY9P4FEFLUi/1hre5QeXzOz2Eh5u6Gwe2VsHyAUjhhI9uTBoOOr8Hi
 NLJnl9kyQpSISQJLHmCqT9rt3fP5bom5ZxbSgd46qy+i3gpd+e/j+rEABYHTKIN7wQdsFBo6V58
 6qu0BLSnzDZVh8ra4KqIm9WS30A13skZEdst60tInSqG1EraVWBLl7wKc/gt3jA7H1Vom4b3cwG
 D2pyEEl94aSPOvHlQaXkkd7pwmVHKnHLjqJSXnlhlJz724xmga/AJ8y+jyth09vm7lhenGZGlKb
 GxfkYmYXzYuIGgGEoNCyQOczAmC9eKOywXl5WHKEJhtHae+Wq4/kJ6N6EuBlBVEw4uJej/ULweS
 nQM1wqVL4R40vVbG2WTTx8gpVC80kcO1+iWVdh9l3Hto8icQ/WTTphv7I8fFTnNQnFp03AFYQYz
 DEVsPmLE2chy/4tJtRQ==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a5fb30a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gxl3bz0cAAAA:8
 a=0lkDo64xaFGs7FDVTQYA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-ORIG-GUID: PaKGy7SIIBEBw3-pIPp5nD3FnsEj_zty
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE4OSBTYWx0ZWRfX1t/bs6xrqjLR
 aVMQXGpH+fEsPuAVE6C5uMH2lThHUcxR2Vw73O1KprKTNEf0W7gbz7pZhvPLmubZWuB5JUcKQrM
 unAXw1jVP2crupdKBpaGAjXrG41xMsk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210189

On Sat, Jul 18, 2026 at 07:06:30PM +0200, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> On Qualcomm X1E80100 platforms using the Parade PS883x retimer (like
> Lenovo ThinkPad T14s Gen6), hotplugging USB4-capable docks such as the
> Lenovo 40B0 results in working USB but no DisplayPort output on the
> dock's HDMI/DP ports.
> 
> When the dock negotiates USB4, the retimer receives TYPEC_MODE_USB4
> and forwards it via typec_mux_set(). The qmp_combo PHY then selects
> QMPPHY_MODE_USB3_ONLY because no classic DP altmode SVID is present in
> the state, leaving the DP transmitter and AUX channel disabled.

Would it be enough to make QMP combo PHY to treat USB4 as USB3+DP for
the sake of this issue?

> 
> Add a DT property "parade,disable-usb4" that, when present, makes the
> PS883x driver reject USB4 modes as not supported. DP altmode
> configuration is still applied if negotiated, so both USB and
> DisplayPort continue to work.
> 
> This is a temporary workaround until proper USB4 DP tunneling support
> is available in the X1E USB4 controller and qmp_combo PHY stack.
> 

-- 
With best wishes
Dmitry
