Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1D438000
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951549; cv=none; b=pFPk55HiySrsVxlcIlbkcjwUfPlja11YUGXX4PFTyHCS0Paq1ilJtnPk5sSWFCCVA3BA3dCbE1wF4ea0QxOx9e/XUNwP2qgWmQK3Y/NGTEup3z2vT+ulctvGW00Ruwg63EK5OlatBD45L9XIPrz3TT7O7of4WHsE6WB529AMsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951549; c=relaxed/simple;
	bh=DXjFWbsezh9XQd3Y5ft7S8+bsLXvl3CKO/w33wcKI2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EJb4xVDh+1fn1Hj8X4SGTp5zbhEQzZvhtYIM40FcOTBVmiSMZwjErEIWJYkgy71a6X53gsAEqUwHq+9l2hoaqhXEnoxmIBINvrykO3N0Wg5XgqDUxY/QriYF9rgnlZwnjmBXb4dpnHMWI9aBoDFJxyqdjTY+gQDiCIiRP8JWKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOQPMnj/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SBjw0ajN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOQPMnj/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SBjw0ajN"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDgFJ1480856
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vonu41nazZKgZgFzgiMlMdUi1Svr1anpCHuYLg93am0=; b=WOQPMnj/u78/0Gu4
	LIUId8l6vhHd1IqKI6bV+dVRsUyAGlc4lFE2RFB0/T4N7NBJaKdIesmQeyoDs/my
	pFmRqgz6AYrzUmQU7NHlqPr53CwTeYkuv2EVDgYXaFpSB7i3Rz702LL9rlcXIV0y
	i2iKlDzJ5omYPSxB/30nHogUBqhRUq1ruXIVa5CKsq32E1QOt2mfy0AAm1enfRBB
	K93/At46yKf1zSpgXKlHQOXNDMd3uhGMT4wOAy0ggLU68sQt2GgtDdj978LpxLrM
	QPOO0fpul3Xxr+qJjxcSo2G8od3PUEqYtsbCPvO8LGsLIwTSiVkdue4l0clg9maI
	69M4Yw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavs2s0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:05:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so4133002a91.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783951547; x=1784556347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vonu41nazZKgZgFzgiMlMdUi1Svr1anpCHuYLg93am0=;
        b=SBjw0ajNg6MK5PWUyfNPx5+DVJWBFpQ0bg1yWRWYkM1eIudzR2UC1lC9DySsr6V55O
         0yx/PS4Fr9F3chPuViBbNknHovdUJmMcAuOyI/+ZDr5l8I8AmJKCEYfuZW+hbgka7cIp
         sgxXDX7TXEhiuHp6hB8/OFJG/YcG3tsS3C52LU3tlpiU39KFAgClMAEkTaiFDMXOp5SQ
         sKVLtlNPHN8v8LO9qJryLWkVNchUXaAaQA4UvUyS9b/0/uLO9hTuVZObOpn9DqKfYMHp
         wWRv9aYvoH7KiSOKx+S8kHbdOXJIKaDFmxSGrONIYMTlkVdp2iWkn/vCTJdWrT0D2yEy
         ltmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951547; x=1784556347;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vonu41nazZKgZgFzgiMlMdUi1Svr1anpCHuYLg93am0=;
        b=mFc5vey10smFqPIqrx1atvLWlcNN/KHX9+1t/M/QY+CZ5UxFBJkJYjQtvAbNsi5z3B
         zSMf+1sRLRErbdIfE3ftrFOtwtGfDoi3N5C613q0qCAdTXOBliY+q6zFJ98YDh3qVvIX
         +RZXWYxtZKYEdez4mfyz9kMM1K8ngwdDGVKUVQvFAdGPIJUW27q0hkJfNjoy4949QPLe
         56DLmO79PQUC0fOCyaZUUW/3W2+z7t6I9vqrPtWUX4vWaavoKAYmm4+Lvkb0CCAsDIg8
         kZbd1Fn9JCtcvxt3SQreshaZ9iURpJoXrxzQiO6dG9JpAb8T2h1IlVCT7lJTaP5OnskD
         nztg==
X-Forwarded-Encrypted: i=1; AHgh+RrJ+OUaae04F6bkrP8/FZ+Y6hKlX5Oy/nrx33xkD6dUYmbwh4zV6LzXwgfCwfV+tqZ0pQ7kcGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOScWI6lAvdHY2XsRO6auGDH4VKfoLaQv7B3Y+DohNFKiUH38
	0aYZFL1kaK2mmMFbsYdccDeDJU/A54T+OSa6k1DJOjLoHxZGqaOtgefd+2U5xwH2rF7luUeh6Gk
	X46hbUYQilUkRU9O81Z9PX2fdRjoBWx19rclLK+2V9AqO+PBVKgDNmsJJciE=
X-Gm-Gg: AfdE7cmUS0TrSKEujPzWB6Gxzo0Qgp/a4AlMKPbEd4/8K3ERy5h5Xl5NIUWD7Cydy00
	+kQ5sPtdEs7RVsA+OepwdZ0L8XrSUMaT40U2PEf8tqRlhBHsh8ccriG+glApCK/+/Di9xTxZVRN
	jW/AtbahHH3J5GqL0D4C/wKHe3Kjh1ryVsaPCxCIQIE+C36GoITd298wYGL0iBepG4MpLLLS75T
	TWOB81IBT0J2iqIfcpKHdmNvlLtM5rzwMx/PDU4pfDAseu1aVe7SOi6e0mrlGX4mG65C+khnXIo
	+VvxWoPmw8ahaDki17w5lrIYQd7U/h5yR02usavlH6LT33zMFoCnVnl2iaJ6FsGNDbiG/HJcGZf
	hdLRbuNr9EiW3MXUsdwJkz5FWMiedUAaT+s2iVx18ZEveIPRFyS/qwNuG0P48oyQ29g==
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id 98e67ed59e1d1-38dc77c61d6mr7972430a91.39.1783951546510;
        Mon, 13 Jul 2026 07:05:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id 98e67ed59e1d1-38dc77c61d6mr7972363a91.39.1783951546030;
        Mon, 13 Jul 2026 07:05:46 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm77071424eec.0.2026.07.13.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:05:44 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260615112103.601982-1-jtornosm@redhat.com>
References: <20260615112103.601982-1-jtornosm@redhat.com>
Subject: Re: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table
 destroy
Message-Id: <178395154431.877545.2513390294359874255.b4-ty@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 07:05:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: UmWn-CLAOoHVJjpGUSe8BaTQs0TQcS2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX/JII6D725W7e
 FOSVabvJ4AqYEAUHfS33TpNq9fFRwmnllI35t6Lrd+R9qA4zLYLZlXPCrj1c7zN/+aZ4ybHXEZE
 aJaq4HtiQI+4as3KCeC4MlUROmmXr2/DFsqbr6v3m6jHiBR+5aaE/kps1KwNp/RUYs6U4SSlI09
 G/rbAZHTT4XTRKFzMKHTYrc/A8gxlqaRByJ4t4wPFOWUsa55JQTjNPuMLU9eBa4DsG6n+sU5HHv
 LyqTx05C1bMoaUzvtEPwKFv2/ofOYktnxr+eeY9ary+OdC2FVbZ3yHoT+OwmcCVG+vu+3t2M1DX
 ats0CMEqupyEb43q8pc5w7CvfeB6gzCMWdWxM5Au6D17YInodJsPI4lzdDW0bGDmHj2YLsTgsR/
 GLYF9xu/PZja/IH/+px0QEJpI7M1a3SI6/cr7zrUVkstiUj6d9A7jPJlZ/lTGQ6QeL4qHYVpsjD
 9YpLfJp0Ig1nRlwCQFA==
X-Proofpoint-ORIG-GUID: UmWn-CLAOoHVJjpGUSe8BaTQs0TQcS2x
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a54f0bb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=C_xO_HesPfbxFcvR4REA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX4wr1GBqbxAk/
 MlAUJzyIG/cAobXG3gxzp3SpzQ9W4m4HjfbuV62muoAQTVb9jOjthu0u0UTTBFEN7I5SIyxTK0v
 HHwxUCv5+CkGkZdMDrq1TTMNiSWG0z0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130146


On Mon, 15 Jun 2026 13:21:03 +0200, Jose Ignacio Tornos Martinez wrote:
> When unbinding the ath12k driver, kernel NULL pointer dereferences
> occur in irq_work_sync() called from rhashtable_destroy().
> 
> Two hash tables are affected:
> 1. ath12k_link_sta hash table in ath12k_base
> 2. ath12k_dp_link_peer hash table in ath12k_dp
> 
> [...]

Applied, thanks!

[1/1] ath12k: fix NULL pointer dereference in rhash table destroy
      commit: 70231dcd782201579990ded73e0435d18bb524ca

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

