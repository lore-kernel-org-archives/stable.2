Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0031716D
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442151; cv=none; b=Sqieghb5gekp9mM7xbPOhTQDvbyeoIFOnJcgn8Rl9EjOHqBPNL0Z67zVfKKBRG7pQW2mUpb+2Xc0qvbrVQzUXKAJw1M8wuWopQEUiKGpHEmmQXADXMb9SFwmLSWZJmu/tstwlywW4fk0hyNqqpp9khOsNestiN29KfCp6dsIFUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442151; c=relaxed/simple;
	bh=icP0yGCzswj6mUyjJWo0McyYmwhFhCq9CCcJJ1QQl9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2lD8XsgLVqe1zrCHs1TXIWsWy9LREySzGh4pkZZnpcZsBg8/h5QH/IRL5pmgqxCAyzGKxj63xKFOv2om4tSw/LhZopkJ5NpKCh8Mgw0FjMTuoS3EeAq2fQjfT4qhPaV4IX4dzl8stygipG0dD3i95pmvI1fxjIj85oYSnd9coc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kc6kdFcN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MOYB1G96; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kc6kdFcN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MOYB1G96"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6984BUBv1775342
	for <stable@vger.kernel.org>; Thu, 8 Oct 2026 06:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/thxqmSGXCGdxA0ka/F92mAeNv7Z/Yh5f4+3MKsC4Es=; b=Kc6kdFcN81smkTc5
	skQNvg0P4jBmpKtFgj3UYdoG7PF8j4K9I0mNYgd9FDGK9SsaHCpTlX063CSLTcfY
	rTsBJLTroHIUL+yvDjSK/BG1DF4bPMWUpiLo256r2FvBuLNxkg4M/uVZEO76GZOx
	sNdNLiISe+cRJhFLWeBCUdQqeeHsjxah/7kpxa6bxta9bc071wNYE+ceboxqu5zS
	XGMfYsMCswnzJd/4djH2ZZkwkqKRGRrOI2svWGTS2riZB0PnIc40sTuCefyakSUo
	aNUNVpTDvAO5Wvho69fMa9LrzwHtD+i7lJfTgmNLyMx9niy07urjSrcCqGEPrp0A
	cCnHmA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe39g5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Oct 2026 06:49:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso6247407a91.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 23:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791442149; x=1792046949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/thxqmSGXCGdxA0ka/F92mAeNv7Z/Yh5f4+3MKsC4Es=;
        b=MOYB1G963K/BeM8ztziSTdjHTnovpgMtFv7I8Buk4SZrHpOs+I8IbfYd/JNon+CxWp
         ToKSZYHM3HCJhO1cYSdxTKdgcJzKJ5JqWDQYw4+5ITeKv2t6bgGUQmacmjz3XrE7lIqR
         zCPxO2UVd2vUn1VlNwJTXaefxdyLdyGEGP8LJ+tHu9PO+VFV8xVaEb4EQgZIr77FspuP
         q5ZOxA7uipX/5hRhO/By3Jpakne2FRbBbJikNzqtlGOTzoYa1G+jExX8XHU8lRbn1Dyj
         F323lVM16sw3W0flr5G2uQCXReFGBWI1cfIUAsYYXsKB8xg71HEk9NCgAzVf8NLi0S3A
         5GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442149; x=1792046949;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/thxqmSGXCGdxA0ka/F92mAeNv7Z/Yh5f4+3MKsC4Es=;
        b=A8QLevUvmx6PJZ9GY7Vt4tGs0ReO8n5VGeP1JQG8BZHssx5W1Cncu20pNpdOBIiRFN
         4vW8YYwP6qLoeU+vxpvZzwH6qhx7AEEEKpLpXkMe9KUDG7Ddj1r15R7i75SdJpTYtui1
         V9XMCafQFehmCvLI3FjA5X7l47a5OgYnjqSFPkg9hjVv8h9R/U9TwCq/bcJSTq2x0HCI
         /8tYfd7tW1JNYKCqU0JPlWP/VxHngXv4YOEc5hZfrk21YEvCIEbDOrlfWaCMZgWkjXuQ
         2hbJckXHG7uGjO0GvozF+eHKaRG7s/sSD41LB2CLZkYqN3py/Q0X8MPo2RKGnh46vZs0
         VJuA==
X-Gm-Message-State: AFq9FYKBh6pbGfH8m+lelUL/aerKVBueadk/TuT2EulfFwqDoHQvwkyt
	mO+68vDxTIwvz941rKs6vt+2mTFT4s1fPOErCTRe2bRD9bG9R3oJuUDf9Cvdo34SpE96cggj5Io
	t3rx+r88B7Yt0B8K9cTDKA74S/AoCZXGEKDmaYG/c9u9pGDQ6fLuotD63r1E=
X-Gm-Gg: AYBFou1OSHtximBuQnBDxvCtt+8ikoVBCY+ncvRETdgu1gpjG8o//wpvNw6YiQ8wi1C
	/pUzlH40zMCIjg4am4AkpFbDtuCh6Ub3BYossmReqdNBsdGKdK/LXWHMY/ZMLkhi2u9kXC892yo
	9Q+E+XHOg/zNotQP54z0jb0rhyC6Mf75hoUxhWX0lLsm9+yQoAaxrQjG89rrTr78kiYJpJBrj8B
	tuMzPt8hABuE1Hn7DSleSTSMaX+KVPpWXCjmYh9odQvRpfY56jV1/bZ0IO6rRVtqu+zWlqCxW1z
	33pXAKW3+/bNhKn3iWPdnLOu6FuoawvV0Xr4VrVElxhTUPLezw0jsZHUQ2xSs0VcPOo2Swu6IpS
	znNV0+gqVfDwVLXPRPAoOOdvvTVJULUD9nIkazwDCiGQS3el5Rmb1sMKflBXw7kk2tuTMFrM3
X-Received: by 2002:a17:90b:3b4a:b0:3a4:adf9:5d38 with SMTP id 98e67ed59e1d1-3a89f674ce1mr3494811a91.4.1791442148493;
        Wed, 07 Oct 2026 23:49:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4a:b0:3a4:adf9:5d38 with SMTP id 98e67ed59e1d1-3a89f674ce1mr3494804a91.4.1791442148021;
        Wed, 07 Oct 2026 23:49:08 -0700 (PDT)
Received: from [10.133.33.26] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff8d5896sm2860608a91.12.2026.10.07.23.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 23:49:06 -0700 (PDT)
Message-ID: <2689b288-05fa-4a51-be5d-c65fdee22ea6@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:49:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: validate MAC/PHY capability count before
 saving
To: Jiale Yao <yaojiale02@163.com>, Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261003101944.596546-1-yaojiale02@163.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261003101944.596546-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ac73ce5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=CgAF95LDYrE-zO_MwBMA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNiBTYWx0ZWRfX/bCEfHQvoTWe
 IxJaeHS0GoRZHeT10oj23XxOrKU0plngvNDD0MB9YtKuk1+OrabszuX5chHwMRc+KDxaAJhmP1N
 +d429urKPw2njmkOtcoZRJ7L7cPwis4=
X-Proofpoint-GUID: wKSPNMidTJYJSuCzID0xP6tTAc3-ZFa5
X-Proofpoint-ORIG-GUID: wKSPNMidTJYJSuCzID0xP6tTAc3-ZFa5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNiBTYWx0ZWRfX+42t7eg+eD0j
 DI9JvSR2VM4rFW4L0ZE1kz1eyyxZmtTHGGGhJmYkrb6qKfN0zMcN05fREFTm3XlZZSXQ+s58CCM
 6tFOhNFFDEmMKnghxsjoeCExZdp4VCpCUL2dFpy2M8Zuc2g4kKW5wJbfC7bRaqzTMHnr1yj1tNg
 BlsPUwmWkdRZSopWpNjiG+zbrHJm3EjtRU3sXrWISMgE1S4C9ErR125IasbQ9UoOZdyywPoetzD
 4GLU2W1TYKl7jZUa+BXfBhcFNcqfRy40MbfnPdCNoh1quHxZNRao0PN9qVkofF4YoL/sE3p+JIh
 jWvqAPY2KB+Ue75UVYLCzpHIQpBXAMoTD7gdiFzOaQtfmRN3+Nk8qsnEKmOx3gpjYtQURrL5k3s
 mbUQr1pWbXG7d43/8WmbNAgSndSWd20zMAp/3F4EakN7UX+VV7i0R4IIqnVrGRddz3kwBOOxGD/
 VDa7L+BHY/lXvZJaz2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080026



On 10/3/2026 6:19 PM, Jiale Yao wrote:
> Firmware supplies the hardware mode count and the PHY bitmap for each
> mode in the service-ready-ext event. ath12k_wmi_save_all_mac_phy_info()
> uses those bitmaps to populate svc_ext_info->mac_phy_info, but the
> destination is a fixed array of ATH12K_MAX_MAC_PHY_CAP elements.
> 
> If the total number of advertised PHY entries exceeds that limit, the
> loop writes beyond mac_phy_info and corrupts adjacent memory.
> 
> ath12k_wmi_mac_phy_caps_parse() allocates the source array for
> tot_phy_id entries and rejects excess capability TLVs. However, if the
> event contains fewer capability TLVs than advertised, the remaining
> allocated entries stay zeroed and are saved as invalid PHY information.
> 
> After parsing the MAC/PHY capability TLVs, validate the destination
> capacity and reject an incomplete capability list before saving any
> entries.
> 
> Fixes: 062ade23991e ("wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
