Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9B400996
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157126; cv=none; b=BDYCLiO0cNm3Umtscbti1rcCVcFFeJRb15Sj2YElI4m0T9xn0fhaDQXt4K3iynxjoabD2gOtV9rpsVRJg5ZhIviIP5IbhStV5TOFmtu6pTZ0/SqJPI5aAt7qihWvEBk/xL5TI7Hqs/VurVGf9zuHqj5sOlJg5vx5+tsCpQOSrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157126; c=relaxed/simple;
	bh=Bzwyki+7l+bqZEnRAo0HLamKrs7BWN4gflmVlTEqGTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJf1yx8iyri1ZXRVzY4PBeuExlKNJy+n8QCDrJJHkG2XNTvmIsS/b0kssyeanvPS6FvDWqvcBQ3VUsOUsCOqrawPfocsoBQbbYb0ebZ2mrrunxIzZrHGIk55q2+oRvipvOd/jzgcHa0uKL3SoZihYM6NcCpo74lL82WqQ96tHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kg82vcxn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e9W5C8Aj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kg82vcxn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e9W5C8Aj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RALwJw3355515
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mQMwWXTw4wKW415B7tw8uPLrjsQ4NQHn5F8w3+9zPsc=; b=kg82vcxnV3InbanP
	uMQA4Iy3epO3OXTtCqXsgX8xjwVu1UE5CJuAQTIkn9YpGeN8mwHhoasblVwv+K6p
	zwZ/7EuAVSYrGNTX8TmOMF/CYPEpkXaK8kVi6gPMSb0zLw7JLdoVlvX67Vx5GlYg
	Xh+umblQgO5yVFnzNngwKniGSsWWli2nAAe206MamWrqrEJnE5PDs38PIkTllPHs
	vD9wp2UGVpih67t2kqCCzbyVHZKfbIRodYj/Dlj/gDmDqoIjVb3FpVu8gw7bLNQN
	GMGh6neNRPTCX7OhrfuGvLuZp8VS8gSpfoO8QqXGRdpyDSaDSGb5TF4/cx2DikSX
	NtxFcw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbrs6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:58:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-907b38aaad2so41298456d6.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785157121; x=1785761921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mQMwWXTw4wKW415B7tw8uPLrjsQ4NQHn5F8w3+9zPsc=;
        b=e9W5C8AjVI3qZSnqGc8wPXLc56v1ICv/bPsaFz+Xv6batZjfrZXUxzSQwA6QOOY+Kr
         IoK2QgHEmwAJbJknq61no4YxAChWLaCalmHXl6rMS23T3E9Bmw5U/l59MTrarsfXBGZZ
         FpW++v9YVDtnc/zuwlsbcjuo71en5ECg9wOAu5X4vWOM/qn3y9TZcAeixL7hDhOVi1tc
         kkemifgUw8HO5Zpr7l0R8qsF1D+V74UCXmnI6XY+DFiKuL4yGsLhbythBJRSCbDKRPIk
         OSjteAhodK+/KUkCeQmFNeRKuCxJtgKkp9jJFJMqNZJL9Vr/y2DXkVw6hYVeLwhhPQ93
         s7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157121; x=1785761921;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQMwWXTw4wKW415B7tw8uPLrjsQ4NQHn5F8w3+9zPsc=;
        b=fHm3DEd3XvxAsa7gyJrbsQuL7noLBxH3Scjt7lVFS/YgS9zG7pEvvH72NCG04xevpB
         ZfZ7j5+Xds2xkBh5g8FTkvxgVAbo1YBIutxVSKY4ddF84PzH3dAPMWe/C5RKWfKdlY0z
         5G9gpJlfRybziwVT2/GzP7n8CV7secgQGlRW4bDdbRk7EQBJh8Q3ICgcsk6QvAUfnhvp
         FskA0kg3UWu79uSudcrbOx0y9/S7rqE7pd3+lAKyYmItP5XANgvaGgGZDVTjCdKMUkbs
         qCM4iSFx/0sMwxLIzDCgArdpNtjD6g8kRZGdlY4TiBkET0yKZWJR8A9H7wKLb6sM29w1
         PXMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIJK6zuEL8SdafhOgwoe1wgqSTH6Vv1rHc5PeydImQd9/7f9Nbd49B6d2WcYCuCq+nnQ154RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UTUmC4nRkMniwejroLMFx94ZB6gIa2RghdI1uBc3xLfkhvFl
	XFOMSphhYaUDZXCzUPohb+HtxrPAP38sebLlVc4i0Qi2AOhZCJ2c2UXkds8qWu7yhMX9juyyNad
	uD9VhwVIJx2wRG8FD9AhwnoXrjl9vqe07PvZEPoDoRExR1j6rzDT1V49xKrg=
X-Gm-Gg: AR+sD12XYoCR07RA/gWav58NIWSMSXHA3GppxiJMOpQb+jijiZi8yrFV2FGjk7BT89f
	IiD1/CPZh6Q87cXtg6l60Nz1rVavZxd3mUorvYjWfpuHeWm8StPpNLjvnF2h0anVu4MhqERnI5d
	NQDwwkU9xDY8o8+8gEgRmW4XGDb6tw7gsZbpnfbWU/YUTkbisrS7dTiV9TITY0OUpZx2n0m6TlW
	FpE2PU5MQPjX9pelIqo2uAuaFiZxXEuZYaWqNJ9bAw18K+DMAieRg1A54c/2OCUcd8uCkTxb+zr
	OVzc3M/i/FNAm/Aad3akci1dHDD+FiU5YUCG1HOhMhFgmz1weizNvxYyvQfmkvakIhnCyJZkXyS
	IW/xaqxCf9KS1aVm9n34z1+yed10=
X-Received: by 2002:a05:622a:2995:b0:51c:1ec5:d00 with SMTP id d75a77b69052e-529a86aca2amr79190841cf.44.1785157121074;
        Mon, 27 Jul 2026 05:58:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2995:b0:51c:1ec5:d00 with SMTP id d75a77b69052e-529a86aca2amr79190471cf.44.1785157120433;
        Mon, 27 Jul 2026 05:58:40 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1449:2d40:6dd2:20d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b49a6e17sm214676795e9.13.2026.07.27.05.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:58:39 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        linux-gpio@vger.kernel.org, phucduc.bui@gmail.com
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: pca953x: fix cache_only and IRQ state on restore_context() failure
Date: Mon, 27 Jul 2026 14:58:37 +0200
Message-ID: <178515709857.54429.8407222473989334213.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727080205.16353-1-phucduc.bui@gmail.com>
References: <20260727080205.16353-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Q31Y58cHv9kThi0QK9SSuEtRPDCFBWnX
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a675602 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=BYoRrCutAu2pXzHchlUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEyNiBTYWx0ZWRfX/K8PaMcna3Rx
 8TqhjISubCY8IYrs2zq7mcuDr7+9rXxpZrnWswtwrF2IL48RxQZ9F93E2E2AQW8YfOCb/BzIRhc
 +UGX3l01FoU2ESpYRccTnuxVH5V0W7w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEyNiBTYWx0ZWRfXzCOwbobazhxU
 EZ+GVYQ44730D/OHZbhG72WNDYP0WSM+txHLA2hDWcjTPrc8OYyjb6gfPyncsnpWoZfEC193SM0
 QXFdOJDG+lYB+XZcli3M9CbGKeyi3jo7pgznHdnVp5UX8PmzaMyptapoOVL2RKDSaniUlV3qZys
 13JD6h2Ac7U50WZlzrgghGOY255TgoySxOBJT9Hg61Ywie54ksTx8B79Xo6qMXVqFYUrg3+Jn4E
 d9qwoOVfFgrAiUWTQ95y3YV9A58sb2ceStug6t0OEq4hxCPamOGPrBqPZFz/B7sqCWwf5dpFS68
 RFh2GRNI1aU5xhbJQPZQ6HOBaS/mSqILdDykwzNSP6DfBN0u4tTABwDc77r6Q3jb4GO0u/NlQAX
 94vg1qCwZeKvGlCNUffZgPbEXTkiSxkNFIzfBv1PrIUMa909Of+wKDltAzaKZ8QZUvTWmxCtTPf
 dd+uky+GhjrpjIP3FgA==
X-Proofpoint-GUID: Q31Y58cHv9kThi0QK9SSuEtRPDCFBWnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270126


On Mon, 27 Jul 2026 15:02:05 +0700, phucduc.bui@gmail.com wrote:
> When pca953x_restore_context() fails, cache_only is left disabled and
> the IRQ left enabled, even though register synchronization may not have
> completed successfully. Restore cache_only and disable the IRQ again on
> failure, matching the state set by pca953x_save_context().
> 
> 

Applied, thanks!

[1/1] gpio: pca953x: fix cache_only and IRQ state on restore_context() failure
      https://git.kernel.org/brgl/c/c7e781391bbf42ad6fbfda1caa66cf8a5a2aa7bc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
