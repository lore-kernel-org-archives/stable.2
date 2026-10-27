Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090073;
	b=0iQaVBmQ17TzZmZjXYmLFZUfYCPivBCt+xCma16jiqILNFf9Fg/xc48pUe/uRQraFKvg
	 zwW1dx4SFItVEFEBNUENlvydkb/R/qcauD6FvZH6LFQ/X7LRgRt0qSxj8Gf8+I11ufIn7
	 gn5SM+zNOn6ezgx9uFKrsqU+xblJtS+7gnBGFaA/42K8cQjT1qBOO1TUmNXjAagZhPlcu
	 GT4xSlTKsx/H41668uXtxQttubpWtbAKK/73G+a+O6IWndX4dGxM40HuzOyj92LwqfCZg
	 ubpp3+6ldoIX6CVGtJGmT5br6OPpJ215ek6ITmgUJdnRNo2k6ThaI9jIslSZ0VDOVAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090073;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4wrQkMaK+dW/8z6fl3qfa+S+gShoibCmJmmER0g7vrM=;
	b=NjwYO2FsGqHvX7lTiXDMieWu3iZ1q5fQU+JEgMi6o/wMxrxPRKHAEhPTIJg2/PUqBEOb
	 FJygsdSbr2erD6ffG3DO9QXQOAe6T7CGi2f0bZfNa8nEgbd0MOKYT7J655p5oJIFOS0Vm
	 gBB6l/C1fzJNOy3homEG7yBI3QnG52utO4pKyJJ2+YzT+uKC2er5qWB1MHgnRwp7DlZRf
	 jWeVLkTn71gDI0UBqU7H6N0E2xvL1lKN5toaZvLa170wNoKEVocLZg1mEYUdWD3k6plCd
	 n2MP5SQwQgrXggGXqO2m+AVIodYsbCDP1r6ZT3SgAeZ08rXiQJoPqa1Wp22JeIlijvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kF5My7A2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WkZ3Opre;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD2606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06AD2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kF5My7A2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WkZ3Opre
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5YuUr752068
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4wrQkMaK+dW/8z6fl3qfa+S+gShoibCmJmmER0g7vrM=; b=kF5My7A2IRd6QUBi
	LDTYgdiZ/J3U/lZ/GtNQZpoNmIiPeD/WZfJ2vEo+v5WVHLqxlGvePKQH8aOLYeB/
	JNQ7aOJzzqefKSquofAmkbedrb5n2jlEQvZSxXa9tkajc+Ku2+BqMjz9IkEb/9tP
	CjgoVSDwqgLw1/H/4j6gu45p5MUH/4XoiH4djvxfGAhaZ+txFJ6DRxcLm0wmE8Pz
	Ii0eD6WaM92n9RQdEqhrgpBocvY90oLPn1OX5k0n/AzxtGukDq8xYvipujlZrbnw
	F1Owy/Qb1vLiVqIARITwyXQvCI33laY3SizEWol549pAazrsgAN0gBvGIN67KjM0
	eAWY5g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmapcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:34:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a0619b1fe5so2984011b3a.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793090072; x=1793694872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wrQkMaK+dW/8z6fl3qfa+S+gShoibCmJmmER0g7vrM=;
        b=WkZ3OpreAQb8BVy4LA27hGCZAGNgGCGbi9Jl4i3eoSIA6QinNB6dw+zEiuvI7fNM3q
         5O2LqR65CO1qNKs+POfMM+gzrAWr/4+HhI+uS0TchA2wGexh71gZLwm4uklTkuoD+xVx
         /xNmU1n/tk9eJNUpftST7IGfm3BNLY0a/7qgMMS/T4WAPoBpBQLuNx2Bx9i/yPqC+NPP
         t1zRBMmcgaj8VL9NkU0KzUCfvjDb/GVcM9R3XFgqbxf1Fn82nr9Wiwt+PZazKDshTpq2
         qwo90GDjXXCDkbYkgD/J4UBnRvRl+cY7wifGAWBexIQfUEa4XAblu9MzZqcCVukmYq0e
         MizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090072; x=1793694872;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wrQkMaK+dW/8z6fl3qfa+S+gShoibCmJmmER0g7vrM=;
        b=mosH0ysqJJlJRYXBr34Ge9P5d5j9vD50CI/Vfcw25Z4CySJDVQnu57FiNieXsBxL01
         1DSudW2hAtjj5z4v+GhlVLIPx3KcplxvylvB6e4YvnN6A4cAYDiixcGR1HryYLOWIuxY
         rad7KHrWRxjurfVZ39x2jTAsgZQJMLaDvF5FK0iPy6bNW69+o3AiB6FECmJK/Kid2Vpa
         VL/QV4J3I0id+UzyiXd6WIWejQOhCAYcRtg3QdJbcWoJbQ6ygbC/wGVv7dGbLCOXf1ft
         wgQBAS5dU6/u/MDq01X4jKw1VPEt1BnBhaamZD0i3KS0AU6h1Ok7Qcg0/tZwMCnO+PV0
         q19w==
X-Forwarded-Encrypted: i=1; AKwUvBwzTsMXpUE39ph4xxCUW5mZprDkn7B3Wu18g+1sr0W3Op7zxl37spSaKxvTbZgNv1TaY27GldE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHr8nWznsBWAvn1I9sG/0Ht8n4IeH6sz59MqT9jp5nDHxp58dA
	usP5hf/0c2Q5e2hrDo1foE4DrRtEfBQuzImAgohN/6vIt0p0gEGAyzfeWLClFJB4zDhJ9iKhk5/
	YgTBamqV9plbPmoleEKYTLSMQEvy2yILkgHYHuiIQi/IAm9Y4yPlQK+uGZDw=
X-Gm-Gg: AYBFou2sd6yk7G1+byjsyJfW/IIdjHhrnRwRjnXaVXAKiKeb5vvPbvlgFIHu+TPb1Zm
	0jDLHZneXkCfdip4vjLgrooZxt8woH2oL8VxFuJk0eLfHZplEgnKYUA0CkaBs1aj/0TQfRIMj+s
	PtNaTXsApAnljd2AS7g78q8X+030ybdoHjPkxbsdPy7XlZkRl2vmpTCRtuuhfeqyMYkI5kRIVlx
	BgyUY8Ne5Y1x9USx4kU8SRenztkLuDBqJFrplKVjLlEp8GZ/bhjV742Hsmq//hJN+UJJqqRy5tW
	4lmGvI8XMDgWsQ+tHfdxnrZKpXDDBsoOgOfHJpWHqRjn3eoOHkhJK8NSsa9Y7iBG2pYBln3WysJ
	Fx6GnHN3qwU91sz3MSxZUpRa5ih1ONp5LQ77AFNg7yxK0H0rBa4nSsCRiU4N2q2J8kPPo0/iAog
	==
X-Received: by 2002:a05:6a00:1889:b0:89e:7bfa:f884 with SMTP id d2e1a72fcca58-8a367a3cf01mr7107768b3a.18.1793090071598;
        Tue, 27 Oct 2026 01:34:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1889:b0:89e:7bfa:f884 with SMTP id d2e1a72fcca58-8a367a3cf01mr7107751b3a.18.1793090071132;
        Tue, 27 Oct 2026 01:34:31 -0700 (PDT)
Received: from [10.133.33.161] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a368d87afasm2119266b3a.7.2026.10.27.01.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 01:34:30 -0700 (PDT)
Message-ID: <87eb6978-74fe-4ec6-b76a-b09210ceea7a@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 16:34:27 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix lost 5 GHz range by
 tracking reg ranges per radio
To: Ahmed Essam <mrmrmidoessam@gmail.com>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Shenghan Gao <gsh20040816@gmail.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        stable@vger.kernel.org
References: <bbd65b93-816b-427b-8abe-1d1fd1cf4e70@oss.qualcomm.com>
 <20261027015919.277156-1-mrmrmidoessam@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261027015919.277156-1-mrmrmidoessam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzMyBTYWx0ZWRfX9tqGAWhvC2PP
 PpAs8jdm0HKvxs/sMKbhv97CPf8/cRI0mWEWPyz+dQMmrEiswnG9X02TjUvmPQZ2q9w/dlli5gD
 NGbgHR+Uq7CrzRGWHtdF8mSujEP6fdM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzMyBTYWx0ZWRfX1FgzRTYE3sLW
 +Y8oT4euX2+f6BGySZ3iL2kruRJrLhGVTyPrbieFV9I9ld9J1NW1OTfGL1Bo0Frh0eAhfjo2yOE
 1q24Anh0BRxivoHWMU1EzZqKjmcnxpXkzO4GwAQ7tQCRVvp1NRrQuvO9i/yVlhEbw4g1AUMMEN3
 cP6lOxvDUCCVkWfJ/r2U8V8VF+Odlia+J3wr/JtFpYQTaZeIFUjaTcZFx+lci0HmPYcgm33TyBT
 AbYGjRwdgyTj0tWPPqZLR5nTWeijG3BTemEtt3VMwV9sbgnvz4iDPDNq4SrGr/065fm8a2TTdQ7
 e6QgsD26cekKZ39wl8IRiXVO3CxOPfp+mFTqr5i5nc7rAVtK+WWa1ixNWyfyYEnbxRPqGZfSxPL
 KP3G6p9DTkaNLUWOFKQOh9fbS+yyPsuuMWh5G4rKxV9q6Kp6VO7cqI309+pVcGL+FGlCeT0mCxX
 G5X0Y2vr1ll+mq4JeeQ==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae06218 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JLF8xD7Yat_ry6Ihdo8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: WD1_MZWBbso0OZBhUEgm9IWOJDMreYXK
X-Proofpoint-GUID: WD1_MZWBbso0OZBhUEgm9IWOJDMreYXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270033



On 10/27/2026 9:59 AM, Ahmed Essam wrote:
> ath12k_reg_build_regd() records the frequency span covered by the
> received reg rules in ab->reg_freq_{2,5,6}ghz. Those fields live in
> struct ath12k_base, but firmware sends WMI_REG_CHAN_LIST_CC_EXT per
> radio, and ath12k_regd_update() uses them to compute the frequency
> range of a single radio (ar->freq_range). This causes two problems.
> 
> First, ath12k_regd_update() cannot tell which bands a radio received
> rules for, so it uses ar->supports_6ghz as a proxy: the 5 GHz range is
> skipped for any radio that supports 6 GHz. That is only valid for
> split-pdev devices. On single-pdev devices such as WCN7850 one radio
> covers 2 GHz, 5 GHz and 6 GHz. When firmware switches to a country
> without 6 GHz rules, for example after an 11d update to CN or EG,
> ar->freq_range collapses to 2402-2482 MHz and
> ath12k_reg_update_chan_list() drops every 5 GHz channel from the list
> sent to firmware. From then on firmware no longer scans 5 GHz, a
> 5 GHz-only scan request fails ("received scan start failure event"),
> and 5 GHz networks disappear from scan results, typically shortly after
> boot. They stay gone until the driver is reloaded or firmware moves to
> a country that has 6 GHz rules.
> 
> Second, by code inspection, build_regd() resets all three per-device
> ranges on every event, so on multi-radio devices an event for one radio
> can wipe the range of another radio whose regd_update_work has not run
> yet, silently dropping a band.
> 
> Move reg_freq_{2,5,6}ghz into struct ath12k_pdev and fill them for the
> radio identified by reg_info->phy_id. In ath12k_regd_update(), include
> a band only if this radio registered that band and received reg rules
> for it, instead of guessing from ar->supports_6ghz. Checking the
> registered band is needed because a radio can receive rules for bands
> it does not operate on, e.g. the 6 GHz radio of a split-pdev device.
> 
> Also fix the reg_cap lookup for single-pdev devices: pdev->cap.band[]
> is indexed by enum nl80211_band, but was indexed with the
> WMI_HOST_WLAN_*_CAP bit flags, so the 2 GHz lookup used the 5 GHz
> entry and the 5 GHz lookup used the unset 60 GHz entry. Refresh
> reg_cap for the 6 GHz band as well, as is done for 2 GHz and 5 GHz.
> 
> With ATH12K_DBG_MAC enabled on WCN7850 and the firmware switching to
> EG, the range before this change is:
> 
>   mac pdev 0 freq limit updated. New range 2402->2482 MHz
> 
> and after it:
> 
>   mac pdev 0 freq limit updated. New range 2402->2482 MHz
>   mac pdev 0 freq limit updated. New range 2402->5330 MHz
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3
> 
> Fixes: 657b0c72c4ad ("wifi: ath12k: Fix frequency range in driver")
> Fixes: 13324cecbb2c ("wifi: ath12k: Update frequency range if reg rules changes")
> Fixes: 0d777aa2ca77 ("wifi: ath12k: fix mac pdev frequency range update")
> Cc: stable@vger.kernel.org
> Reported-by: Shenghan Gao <gsh20040816@gmail.com>
> Closes: https://lore.kernel.org/all/20260715065218.41232-1-gsh20040816@gmail.com/
> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Assisted-by: Claude:claude-opus-5-5 sparse
> Signed-off-by: Ahmed Essam <mrmrmidoessam@gmail.com>

Ah, I have an almost-identical fix pending internal review, but I think yours is better.
Thanks.

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

