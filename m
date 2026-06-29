Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CD285072
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736592; cv=none; b=SJ4MZVVV9tXE84oqJk4Bc870OGwgihdsXez4bghGURCpFS/psPnY3LByJvKjPPpp9SrMko61VeuETtpxQz83Jy9XgkuuIh+YytEX4qjqctDWEAA1YUP4PRF799nmZrLKTZcKRZ9egkc0NnS8/vFeLN5IcnEqB4k8QnOmLrnuuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736592; c=relaxed/simple;
	bh=fOd1vlATrzNbyl3rkNB9cxiicKWC6JmMvDCgEnlt5Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2/MPJN9XjwTUinh3rcphlgITnNCkUGo+nN+dscg2yGgY5YpuXykUMSV4o7yUwHPNqNPddMGvCptpiyArNJY6UqdkMCKamM+GoVtMVdAV7okVLw2QPlbb+AgSWU0S//qLxCXZhuCM/L0dqQqua0kvHE+Vir0/T/IBDi1GznRrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fSQsE/3C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UyRiesGR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fSQsE/3C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UyRiesGR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TASxTr2641491
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ccr431kUVmDQuUtWvidvL76eb4saCqdVGrFri8yjl1g=; b=fSQsE/3CdQ6xfPPc
	p2/Gx341qGxio8XPLy7t+l94WQrlYyaaewy35VCClw/aXOsieiqygXBdAb40FX3B
	mQZcV/xir/5RiYgns3g9hr1BsWFXOZRv0QNaRWLw0yYkbchRE/dCgs/xfUyUoxs2
	hMGXXadSKd10/iucNtAXVMPY0NZ8zTe2SqCsfah2OrdcSjjc5BOAqrCqSfuwbDJX
	fTlAQN6QWaSIKUXNpYKMtiybsIkfjSRrFOUo9Mo8JW5fzxFGxIWIN9MnijUIuJYQ
	ACSFADHh2gP1XsKqgMcPPpt1BZqomj3iaiUKNsqwa0o+yM23gO275EHoiDlQWJ/B
	K7tZDA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3npertcp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:36:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf599c27cso721821cf.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782736589; x=1783341389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ccr431kUVmDQuUtWvidvL76eb4saCqdVGrFri8yjl1g=;
        b=UyRiesGRvXrW/AyJ5xQmCIPCUr/XaWrHmqzZt+V49L/1S3DcvBfZ22tHaWlMEBDFZ9
         RYY+yrO9tS/V+cFBKzqK7V5dg3Lvx1vI8xuqO3F9G0nM9vwuqiLYOJa8w/CClxucmyef
         g+uTiuXZw40UcbD+lgoogjZTkvTL84inn/CbFoz8TCrGTHuLq+jL9ydanU/dJUFBCSEK
         KM6H0kwKPT4mw+yt+gMcWUmxEEh+zge40QVgk+mnE1U0c78zggBvIk9D3o3ikupgjuCl
         jLNDQTNRxNSzbKclp/4cxEiNl0/vNNhCWcRfgZuzjxG4tAYb3BuhbnXtPieL/5mJi0JQ
         jo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736589; x=1783341389;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccr431kUVmDQuUtWvidvL76eb4saCqdVGrFri8yjl1g=;
        b=RwMFDHUupx29QxDlUIy032H8Truo7NX/MvywHAgYiI66a0zfwOcGvPiMuGFnSljqcm
         MqUdyWIWltpeuiIf+BPPz4+ygJV2vyHMt55a9ZAyFSmCVO/Bxsscc/bDrk+gVsgvZLAq
         quxgDb0KZBds0548Q19z4L67RlOSTzWd7kjoA9dXoIY51Cb1V5A6kgKSXXafdKDUfhIv
         Npyb7kBz3pYbreHzCjFLmq1np/pI5PQaOh1w0PuVBRJj80Ad6qdwbnpVPl9rOf+gIATH
         QhTp5MgSMaxnOH6AjZKlUUFpOop9MyrM57gren/iC05eBuTxz5t7d4tIYTgaygnDJ12h
         gJwA==
X-Forwarded-Encrypted: i=1; AFNElJ8vnhHNZ1/hTKIZfeUJ8rrU8QRowp6oKohKub7tywPP46lRsrQyisUe9DLTSo4dMUG1wd0KcMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kjHOAFhnPG7wMwve8hYj+ZJBA25xE+yZRoAjNGzIOp+ZBB7H
	FoUdxIXGekXrAPV5rEeOVv1gXTOeHqbtsg+vyS4EAgl47IwefZfgZAseLEytWhnoEAv9Ko1PL35
	ZkeR6jmwjH+71NcU3gvzwwyAOmjMGVxNJT9tdH7lV5dZ6R7A7L41ep/fRcvZAGkc5eZc=
X-Gm-Gg: AfdE7cnvu7QQ5GulRBSucToNEEq6pBhyUviAPCrEP7eFH4FayaXEu1B1jbmPPdHAX0/
	lS5zrLxHSFPUX6m2CjcNqa4W+s+89GOS9riUFSF+bEJfx7/PyKQMiorYX8BwYXgwmH+CfM1uiap
	mMB+2roPLSZma5Cv1Ufav4E60xLndrYkpAGvR+jB3wd/pRsJq4GxzkH8Q+QGwKhx31su97caEmJ
	w3QWefo1cwVlxkt+/Dq+P1zZuxv3PIpCXWQnoJdi5svVpsXc5/Lur8R9i5/JfHhe8C0Fl/icWTH
	7GKcej37T+gthYrECp450x6UnFouiP2q+tQ0l4wbBvgUoocR1Di00MHtu29Ac5g0rr7t/hpWAud
	H7hZ9kRSviS9KVEqy9iRWuHq6O0aPpwjJDyw=
X-Received: by 2002:a05:622a:211:b0:51c:8fb:fa47 with SMTP id d75a77b69052e-51c08fbfae7mr10319241cf.9.1782736588796;
        Mon, 29 Jun 2026 05:36:28 -0700 (PDT)
X-Received: by 2002:a05:622a:211:b0:51c:8fb:fa47 with SMTP id d75a77b69052e-51c08fbfae7mr10319051cf.9.1782736588316;
        Mon, 29 Jun 2026 05:36:28 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c126ed2de5csm118170466b.7.2026.06.29.05.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:36:27 -0700 (PDT)
Message-ID: <dff71427-abbe-4df8-bed2-e3f489229a70@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 14:36:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpmsg: glink: smem: order FIFO read after availability
 check
To: Chunkai Deng <chunkai.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Arun Kumar Neelakantam <quic_aneela@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.truong@oss.qualcomm.com,
        chris.lew@oss.qualcomm.com, stable@vger.kernel.org
References: <20260618-rpmsg-glink-smem-mb-v1-1-68a026453a69@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260618-rpmsg-glink-smem-mb-v1-1-68a026453a69@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMyBTYWx0ZWRfX/ar+6BARCFxt
 vit/6uAqqfWGtsZnTay+l6hXJcm+qkAPmA+8PHZXhSy+zMGmRk3IEp6DqjOMkSVD3MC9bh+ZmVN
 AgZaT1y8TVP9NrXn1teQwcBS4RvynTW1I2Ib+QpaOhmg0qrhnCitA4sAGk/8hgx0PPobuzUdyUd
 TGbXIPyTfhv2X26l+0vmNoAB6FWh7l6kPw/pw4aO5UTeNmwgkPmLC10BNs/Zj4Jmn2ixtPVZqfS
 TA8mw736XCf/WDH8pa6Cm5e6mQMMTnBkFzC+z54uorH+T99AxOugQbGwDmJOv5ZmUgp8hFs4n85
 W5oKaGm9+hNyREMcBB1cfLXG4pLP0mwJF5G3NQMktYBSsxrmzwTiZ+Z2M6PzEGAR1GRVPSwrxsL
 Jgs9zjNUETWho55tvbrpYrmpAsqFy1Zk1qCe5S1f5rOj/qDnDVNVT4MTwPAJQ+YRnmvY6lPuRgz
 BerQrWlAGN6qhSQMV2w==
X-Proofpoint-ORIG-GUID: Ck5-sCB3mPpENtRPcezc5ldU-IX6klMV
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a4266cd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bQgpNS1FtnsdpSD-sWwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMyBTYWx0ZWRfXx2Xjn2XRBzhz
 x31oDMtbhmC/BWns/PzohShW3mbe8zFUB9akdCK+58xy12/XPA6CSBJt97VCgeufy3w1e7kUOLg
 xJfetSP73y8XgTMGA5kZ4XIZMDkzaI0=
X-Proofpoint-GUID: Ck5-sCB3mPpENtRPcezc5ldU-IX6klMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290103

On 6/18/26 9:16 AM, Chunkai Deng wrote:
> glink_smem_rx_peek() reads the RX FIFO payload after the caller has
> determined data is available via glink_smem_rx_avail(), which reads the
> remote-updated head index. A control dependency between the head read
> and the subsequent payload read does not order the two loads, so the
> CPU may speculatively read the FIFO before observing the head update
> and consume stale data the remote has not yet published.
> 
> Add rmb() in glink_smem_rx_peek() before the memcpy_fromio() so the
> availability (head) read is ordered ahead of the FIFO payload read,
> matching the consumer pattern in
> Documentation/core-api/circular-buffers.rst.
> 
> Fixes: caf989c350e8 ("rpmsg: glink: Introduce glink smem based transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
