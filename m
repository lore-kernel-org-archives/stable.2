Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20A43803A
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951551; cv=none; b=tT2y6KA1R4fN+ZzOnb+oMcG8dQMKzuOBlgqIMhE+fmMzzO/XiEokHZMvqRArmbcYeCIBr+Iv3uZKAreXsF/NZdkz7v4d7fM3WBF7PvhzMpL5tmeaPUh+DUj+33qc0eXfP9f4qe3M8JWO/KXJSn7pfaX2dYnuM4IgOOtz99BOP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951551; c=relaxed/simple;
	bh=I5/9hti1F32/1KPjgPHJLHPIR9GYaZbSmdeYSSl/ye8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GZVUt/qnsFZ6LarWYNOj1GeixQ3aIHclteftVmDcx58jtnbZPrirzLid6CYyCI4/M7gjPi7TQ3HqvYj9BkBCSI2ld0TA0kfvVbtA/lGqQHopNB4GIKFsMoOHnRDumXTdVk8FuuqRQZHkImGCfIU21KNHAefkgTVt35QRuQyWLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dw/Tpsuz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M0JPDx/3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dw/Tpsuz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M0JPDx/3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCE36a1561327
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2zAQAxgJzZ/6GwEnCRM/0TDcISXjQZ73thDvTZAC/yY=; b=Dw/TpsuzJVR+Ua1G
	QrnHy5UsASTpfAkdoPbOHC1779GGPY3avXE8dKLCZYQI6e7sfcVcbYKWkMGMSoV4
	VYx87FeH3lbAanef+i6uFh0W6sdgDdefzQUmmmUGeXxSNvsrgLoCcgsPZwbs+LDV
	GIE9Q+E9ojrE9VYtBLt5532t5SvB3ChPHtdfdQnZ/4W6fXQQW8i9xTf5gEPryOKN
	6hZpsbQeb3qcnAtwxEm3cCks9OEJSyy+vl4dj8iIevRF9yzu2l1aWjt7e0pZ/Xa+
	Mz0FTXqXU7E3zYQ+bacVoeoPxzWBOM3DcZxwpNNvcHN9iztfUFczLzZSA0HcrNGI
	PpyBLw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn3av07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:05:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so4768327a91.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783951549; x=1784556349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zAQAxgJzZ/6GwEnCRM/0TDcISXjQZ73thDvTZAC/yY=;
        b=M0JPDx/3LT1mc1vM7cECxFok8/Q90GXsdEDWjtq9kOQ1zAyHnzwRWxhV1jq49hpg3F
         hPokrIOlm5nfJ8vaLQUF8PfzKVLuowbP4kO8V3yOcFsmWEfjbiDGMG5FKBSLTa8F03NW
         gYTCs9KK2dnYTj3e/LJ4WTKScKvt9gbbS0C/Md3l3QBbYDMFnAI/AgS2SuuYCgydtOw7
         ciukxuc4apBck512b0+tXeu/Iwznv97iZz0yCuBuvuq9dUoR0U+i+ZdqbUB0LhF1ExdJ
         XZ1Nxc+Epu2uCwQPbCEHTA/gfTbK1stzg3sTs7c8IwqmiE84tjgkUor1QPtBHYhNavFu
         Z6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951549; x=1784556349;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zAQAxgJzZ/6GwEnCRM/0TDcISXjQZ73thDvTZAC/yY=;
        b=PXWiHfbcSfgmtVqGJmSlBBUFHNTdfGScBlKnbigWsrPIgOrlMHdRRb703vezQKKM+N
         z3rN62BETtehlOpzRiCTJB+wh3O1WzYlADFQRNabnuMdcLoh8cI34XHQGc6F9425/t3F
         N2tnBBp6nRwAPuVP5ec8xhBJtv/KKRfiYWjgcXwfNxPxKlrA6e+RQbsd5Jd3hdww0GR9
         o64Qd06JtCuf67yBvqSHmA/ffbDHE3Nm6vo3qRosoAEZh+I9rscezg58b0xZ36iRWKhk
         08+JdZjXM6CCWccr2krJAi6i71ioMRVwAmp24cljjzeaWT4ZT0DQUcisn0ywJowurmGB
         ozIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJwq2C8nWo3SKdfjaHNRXGlxnE9Zg6H5OqD0w5oG2haBFEUIZeOCtnSkNIr5dhcjFfR0BLHKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3c/4tQHVZOYjOqPpZB30hjsnUleCn5XsJKUo1l5r475B+K4n
	iCyQuyH9TXeSTtQEOy0IY2FlUpvBDm+MhX80+BBbtaZEPrAaTgy/qQ7fqcT0q+TObLqtUpMRTd+
	acxxCMDhxLEQSWJdw1xeiWOYWUqmUpQn27qn5ytZ01BEEDOEqkD0+LFaUy6IsIcLabZQ=
X-Gm-Gg: AfdE7clWl3YJ5ghhvLBata9D9B1biB1aiiXlHykyCBVkKUdbIyqaHYtWMlFRahbML5v
	4lFhgJRh28PIzneXCxEpDHdR2N4zMLM0f1MAbkJFWVf8BpKMBg8ap8PYZxsHQaX2FQUjthr8uV5
	/XhDc91OzVygRyqHI/kAnfyIgtzcINOqbmeu1XNp4LaUwrzeM0GzlOYV3VwdEILNIvtPG9mr1x/
	6gS+rYK3oUinCiLrcQUqb8akgftp79xvOYGi5Cq5oLthyH37M2tRwaZO/T+0FOiD+g9KG5H6oE2
	YRj+qwNPldv84DBu0uAqapKamM+5uIqmDmlX/SENjPpWoKwqkQPYBO6yLKFRWk8IH1oTgcTaND5
	pZHcAMGewJ/jug/PNpabbfQRevEHNHT7kwklcDGqkxSADaZHx5Bzebk/pwmLparsaww==
X-Received: by 2002:a17:90b:554c:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38dc73c3441mr9757724a91.4.1783951548554;
        Mon, 13 Jul 2026 07:05:48 -0700 (PDT)
X-Received: by 2002:a17:90b:554c:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38dc73c3441mr9757684a91.4.1783951548071;
        Mon, 13 Jul 2026 07:05:48 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm77071424eec.0.2026.07.13.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:05:46 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tristan Madani <tristmd@gmail.com>
Cc: vasanthakumar.thiagarajan@oss.qualcomm.com, johannes@sipsolutions.net,
        tristan@talencesecurity.com, stable@vger.kernel.org
In-Reply-To: <20260702005020.708717-1-tristmd@gmail.com>
References: <20260702005020.708717-1-tristmd@gmail.com>
Subject: Re: [PATCH v5] wifi: ath6kl: fix OOB access from firmware ADDBA
 window size
Message-Id: <178395154621.877545.8436478026493365127.b4-ty@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 07:05:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX4jAoLbUi2Yl4
 K7EVePjwSCkKofFdSH0GTBTmAr9+2Dtqr2vMwaGJ/r/OSXaMLh/TFlcAXhGuFWA4pqVy5RepkW7
 eHkEz9DGVk6oOSCSk15EBKC/gTxDxiqOCr5l6iXZUZsbLWCzEW3PU3/q3vMf1PLxgQchTbLr9dE
 TIAmvamux+Ls8yT1YiOrGPNF5dquL93jxMs7iBUCRX5150L43yObvSq5ddUr7mHOSChxFD0Zwf6
 Y06tq0T53GlZ8wZ6ET4lN4McEgVOO4KX0fGU9H1roMmsp642qgbn6fRQ3cLiY3dE/F9FmuVW1S7
 7XOCcJVCPWIKsjxtRpwHfW4PCnzhuceXcOHUUr0jVDDsjgoXYS3vg5xKS0sC5G3Dly3AfREGxHR
 nyOY1VSpulpswvZ1pg+i7VhFfgJpCut3fwqrFsJj9ERioRFGHMTJiwdJrsW155+uOEngbp/VQXH
 Aufxra6jF7XiBUYzoYg==
X-Proofpoint-ORIG-GUID: sk9OpK1mMPlOx-QIGJgR1Myi_fqCw7ST
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX8RG3LHagzv43
 IpnzVcIcdPKHNGmb7u8Eau2oYz5p7OMrGyqvleME/oOz3OZ4LOMH8SWoVdpV7dBNwsimNv1ho/D
 H9KEltSGMs/BDldlXsxR/G+AKmGhcAc=
X-Proofpoint-GUID: sk9OpK1mMPlOx-QIGJgR1Myi_fqCw7ST
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54f0bd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9zLzvLqbpVBzozAWk5sA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130146


On Thu, 02 Jul 2026 00:50:20 +0000, Tristan Madani wrote:
> aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
> win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
> return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
> compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
> zero-size or overflowed allocations and subsequent out-of-bounds access.
> 
> Clean up any previously active aggregation session for the TID first,
> then return early when win_sz is out of the valid range, instead of
> proceeding with a broken allocation size.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath6kl: fix OOB access from firmware ADDBA window size
      commit: 44126b6994eeb28f2103b638e698f40a1244f327

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

