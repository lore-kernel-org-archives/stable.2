Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F6470E89
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814144; cv=none; b=MtDFOed8ROblth3xzTvROcAi/97qZZe3R7MfnH1aYHRh0MaVtC1FMP1/T2R9DHLBQSSiEk739Dn3cUGiUdb2ARO5ouT1WhVng2dxasV8WRLOg/zGxaW59ToktbeN/jL5T2q4rIzG3CzLQhHM7oRyaIS4Fw7N9p1eLjGddzZuCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814144; c=relaxed/simple;
	bh=rXDSy+BU+H+23ibWV85M7YcB8RMk/WwX+AGQ/LhTWeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diEs0Dcqve9z4R1mkVNOw4bHsour7l4yYra0qb5S1kMMHW+mIXPD6icjyJekTSzOE9cJzBO/tjVjiVd6KRhwQcAntqdoPRFZharKj6exjFQei+YQbmLyiYdURLv9bjTu1i/9iuaf0MCM4wd5w2x9T5pln06K1E4pJ45/4KGaFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDbvHozW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A0me8vHx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDbvHozW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0me8vHx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC0C542275954
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HsMKY3ZM6LxGid9PCtLXClBhJ9KMfSEQKanq6xuXqIo=; b=FDbvHozWAc3Vgbvx
	k+iCtYU2yJzgCrXuH3dfRQI6rUCZKD/uYpqPUBF8Jku1UqzTpzlkJwsHSEIyEZXu
	rrLF1xKg1Muj1+bhF+YHnzMw0vxLZG5Cco3I/S/X0PC6hgfuhHXs/Ek+yPKyuHME
	9M1xLMk61eql1zhryplrcFVMSDVkp0B7ynll99K9zqpAvVutwh55icJ7tp6DqG1Q
	x2AzSC3t3JM2SgMUhalF1oatgGbd/YMExpBXJxEsRbJk1uXsjzcvjm30CWXizXWA
	dPiTm6YyXhPpZO7s7tPkffBVhvyzqx6wxZmzNATyx5ClcwzX9iRu//s81pvtBCSg
	Q67UzA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq1q48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:09:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93dd3c3badbso435935985a.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791814141; x=1792418941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HsMKY3ZM6LxGid9PCtLXClBhJ9KMfSEQKanq6xuXqIo=;
        b=A0me8vHxq96hC52ODuC36ki1LCj2V7nNUccnQIA5fGBzYhlAnI8dRhrmZndrCgAzhU
         sZmRhcd521SzBk2g0dg1UHSxgLtgD2wABfiJpqZaLj9HzmqilKwW+cWshSvaDJZhsN/R
         BCWgczUvfvD6H59mfXgeazQWGxUHQEpmIxEUQFxBWkGsFERYOQOWHBpVkYwxySp/0LYZ
         U19231djYGvMSGwcKcwbzRJRza9lAMdz8TEt+kJd1jJ9cgiVvR+d8nakDGbV1p6HCQFC
         DQPHjhNruBCkQXbtYnpGyPu7fRNpk9T5odCIEIGWEakqjFIEj4PKmqHHE8jzhxvJMNuL
         9Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814141; x=1792418941;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsMKY3ZM6LxGid9PCtLXClBhJ9KMfSEQKanq6xuXqIo=;
        b=M0jPSQ7tJzC1cZjTyiJEO7Dfv/KrtQDYbWmNIn9KPO0y+tfv4pcW0L9DcVQYyOWBOg
         2fP7hXdox+LwEV/zJ48nEdn9p5igt1d5Xeb5wndFWq0X0htzkHArUXV/i5KdXjW4KTza
         t7jcswHiVSj6iNdVwh90Xq8B8f5cZ1rNBjNVm0JqoDC46O4YQqL9u5mAu6R7IjHugcKg
         93MOga8a57zDKTpiovnFHMm4KTuqkrfC7rs61yeMhZw2rfWg1OUutuxkGDlctJqVMTYy
         jhB0uvBUS8a/h5/CqvNfFUS7AXYBRH3zh1TLGZNOxdTUIVtn+UwpmXlPaKbEAKXbVvE4
         BRnw==
X-Forwarded-Encrypted: i=1; AKwUvBxqnyymPxIuPvIVomiDG+Z2D345XMB7+iISdd5opPOu9LbLr7XtrF9qUikc1/3PCjJkHzdU9bs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtMZ5Rubsvqa+hrlMmTAtxKiuRu/OzykzRgf6ziAEbjFq+fZ+P
	H/WaHy1D9uihyAShgdlCQJfdx2YIVkQZwr46oHtx63hH57t7TxywT7TM0QSkN1EHa1CVLQOV3O/
	4p33TkeqzoUPDZEtk4PbAEwOxNKTuuY13QRuaIpDYj3jmmpYMWsuMrpNKJUA=
X-Gm-Gg: AYBFou2ON2qNrn2e+yZYHUS1P78nxhI/vemUAl7eYcR3xsHyGZ3Nqn0t7qU0kPKHJ68
	KpjEn6mSwKzlF8MHcTM38oLoRT75c4ifypsYfNfgRYml0Fq0Jv1vXGNKdra/9XfSn9578QZf5oB
	yg9X6wXozMyPpNOSPh7cYF62rBZ8P+VNY3x9N7YVdqnpr5OCOrsh+0hsWEQo9bK/nAGsZIaZIN9
	0C08zGF1Q80YgClNfYPu51/YpC7/fQDSbHsoNlgwYMs6UA0pUXWO0JwGAWKDa9MivoBXIHLI0QJ
	u8vuBU3oA8CQQW+8kywSqPkYh/aHDB+GtK3Wwtta5vlbyVGKlAvMsfkKu3BaiSAeECTU5M72sK5
	rFVCRmDpMUtd8TNJbLrxNtcAAGlY=
X-Received: by 2002:a05:620a:4693:b0:93e:6064:8996 with SMTP id af79cd13be357-93ebd0c3204mr1662170985a.8.1791814140941;
        Mon, 12 Oct 2026 07:09:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4693:b0:93e:6064:8996 with SMTP id af79cd13be357-93ebd0c3204mr1662154985a.8.1791814139458;
        Mon, 12 Oct 2026 07:08:59 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1a1feb78csm83436555e9.0.2026.10.12.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:08:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tools: gpio: fix building from the top level with O=
Date: Mon, 12 Oct 2026 16:08:56 +0200
Message-ID: <179181412811.12167.4474187537392007806.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261011223358.2327625-5-sashal@kernel.org>
References: <20261011223358.2327625-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acce9fd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=HJLiZkcYeBZheiffgpUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX/2txhWOQNr1u
 G8wBBpHb43p+614TkfcWJXN19VTeCTfdiEXc6Vg/eplPkl3gDVV4satVMYa3Xtmu+ekJY4eAzNZ
 F7nQIX6v2D7RRDPtLTyoskdMbuaf9tE=
X-Proofpoint-GUID: E3_Odf8BYOIMFngzXatCeMueIm5q5vqM
X-Proofpoint-ORIG-GUID: E3_Odf8BYOIMFngzXatCeMueIm5q5vqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXxfACxa8KskN2
 Pvsm18eOHBRYG4t59P+sttOnzF9qc5BbRIv1a5xnSHjD0OiwUvJdon5XJo/O6ty5WohufCk+z8u
 /l09mHE5SOQQDNAhRU7XD2rVamxSV5m43uxwXsK+nvkb2EYN8uaBPDBdnwCms6rrW75DHNZbw2u
 xq14JsgUziw1XkeMSVGzdE7usd6Hyra+UokPxsR5xx9yOSvQ29iaXbvEarpclUJpu/wyVic8BDu
 /Q7DHN8aq1fALPJwUJNLvbpo/h9P7cfo6fwMVY98WsugrXjfRbjxVRgRf6p5B6dBwAEd8kBGwz5
 Os1AxCXrBej2SXdS8s8l7GXO+ShBt75Rz+gcWbYLbGH3B8hLi/PTzVyiknLb5DvyWi98o7ZtCoK
 vTTkpIpOXYwCx0T50SDp80LHFHl0ZFbLyBSk3DmCOtEUMOlUGLJqgb0I0f4BsbPXq54r7lQaFOX
 xTSWMIunR30zcjQICgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120056


On Sun, 11 Oct 2026 18:33:33 -0400, Sasha Levin wrote:
> "make O=<dir> tools/gpio" fails:
> 
>   Makefile:27: /tools/build/Makefile.include: No such file or directory
> 
> tools/Makefile clears srctree, and the gpio Makefile only works it out
> again when building_out_of_srctree is not set, which the top-level
> Makefile sets for O= builds.
> 
> [...]

Applied, thanks!

[1/1] tools: gpio: fix building from the top level with O=
      https://git.kernel.org/brgl/c/52336337f1a01ad803c7f3ddb23f40222e9ad58d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
