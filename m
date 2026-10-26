Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007987;
	b=CY0peHjaOUnwy6hT602BEBoVTJqgTJDz0d3WKL4JCGdW5cqHBuA9z1l6Ilxg6FfaybIG
	 RyE4pbmsXdbUj5m0dv7QLY3eaCFy4FEpP3XkKKlGtfeLPpI5WgLy8fP35IxaL7AolsAT9
	 gcqFSHJb72uUttzURLRfXIBrB64+DIXaVZT7cdCuX6h/d9obnImoAWSD9JS0LdjxIPvHw
	 cKwX+wL9z24x5KMLJ8otg5oU5S8wTB5ZWj1i+FSf7cUu3MfGQsZTXj+ygUN7s4GjzSAqD
	 Knf0jsfVMxTsg+mqwZSo2ElPAibw+RNyEla9HDkr1Ju+vhAPDKSnvNVmLU+KfkHTZ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007987;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5FaPGddv3jsTPg6XlTe9zmDBqKOfwv/g4KIMTTWQao8=;
	b=IKOiiSdu3jOeU76GnjfJDERhd0IbFP0GGBWshhfJ7bCPOviTWRG8Ip1Vt1YdNLAUkg3p
	 nlAWxcWLMVWUNIjQGrnymOFco2S0+NPzEwdghiyFvgMYR0VGlbL6LR9O3UCOnQYvJ59KW
	 WkCwSuroXpVtdfIniM0gtUu1EVh3O0eBIS4TgDoutw3kBB50yPjg/+Hiekm9xjy0pAxI+
	 Y49I2QrTfU/XX+xYhQegRitmwQEmqNTTe1fGu0oYHPLc6Z6XvVyGKqcrgqRrNd4geXyWR
	 63yAsu7YC7ItLF/qT01k+sXXF7TJvNPQIJqiz2Q/zUHUjJvAGxhdW40KwNwih2OBaWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NxyqMdmK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kc7paIkW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDA606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5BDA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NxyqMdmK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kc7paIkW
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aWfP1708702
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5FaPGddv3jsTPg6XlTe9zmDBqKOfwv/g4KIMTTWQao8=; b=NxyqMdmKoVvfLMeO
	s40Z+fdjqNzuH4HzMnn20HG0ND+xaBGNFrCcuouUvBGONCTVF41j+iPQgVk4k5ni
	5gni8uuNjA9QSJJKKacl1iHxQXdebwkrcxMuMHfGjOlfMvKlAsPK2WpYclqnv/Rq
	6akED298mhKi16QeS5bvtYd77+kY5gz5AuS0sZMXNXLTWa8fYdLZAej3tePbOYuS
	hgPyRE/iVSaNR9q7gpD6GkQRBlkz+Y0/ziLvRAS54Hz0QlnIFgxZFTbCggD1B+D2
	MpzEldAro2OZjDceWlLYrvHOqz4xfW+kxDI4NesTf1/5/PpznIJEOXVmbFV70xtu
	za0lrg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd9u32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:46:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-533758f24f4so3734661cf.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793007985; x=1793612785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FaPGddv3jsTPg6XlTe9zmDBqKOfwv/g4KIMTTWQao8=;
        b=kc7paIkWru6+SlgKA2gVTR2i+E8Bu/eWnbOxfx0GitogLeF7CrOYYM8bO5tDZ8+7o4
         dXTjszSzMlAXqA+pPzwheKNtZiZ4Rx5+ODpmogKVcxa4TQOjC8PmP+lHIS6HYwAa6sHa
         ePGqnewBbc2bUn8EG2GtzI9av5HUGQGZk7QqOw5LAmBnulXugcLs9cxllA55v4SZb1Qj
         AzT56y/GeC83wgrceAGxFfGdh5RfEqCVj6F55EF2MOJ7obNLzVlh7VmI3Fe7GNAcmmnn
         6Xf5NZfsIqj0j2n9ajsUH0MOEwYtxiSOJ/rUFUfPN5uf8IzpIcxmZIoXAUt2wZ3IIhpg
         uQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007985; x=1793612785;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5FaPGddv3jsTPg6XlTe9zmDBqKOfwv/g4KIMTTWQao8=;
        b=14/tFVmf9vz+AZG07vAk9r1fMRMRcfIwz8w98O97B42GzKpp3gnRA6vQU4P1vvWOom
         QBCsb/fy+Y2TnHJ6e4x/VF0AcAKbnbPqI5+WScOG46z/dpuAjnkJDmztoztwai2kjcit
         U1pPbDJRv75b/mCdxZ/dmHht/urYpE5Yd54ZVCJWEmBtFCGxaTxrlcG/rQ8WRpmrjUoS
         khkRFwttzjKH3m/vhCQrKwVzF36GGhkTPA2h4gx6trtgaRfCaqfLV29t5Wflx+2pMrcr
         9pywpUdnSN2fPMHRnlTLpG9OFceczP4yOn07UniBp2sXOnuxHE0nzx944CNPkCvrwDQH
         v9WA==
X-Forwarded-Encrypted: i=1; AKwUvBxqS94ohR9aDNxFsLxkYynnOQ6bhazD6jPNJr+qNCBY/3EMyqyxgNAUGAZzTfxp6RU8QtzpEEY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuDpv2NLGybmdad4bIXk5IkRfrh4ZqwcEjRaYqnWH1sYzea9hO
	jD04z5+HSN7vPKO5IPEnmRkC6b/ST26FEfvvnLr7ldvGAbk8GQgc6BWm0bCTMvXtqsb3IigDkGj
	k1JAjL84xnwRnl2DkA4k2QuXJGWTEJciRjmHn2P7X7gW283LHQZuEcqTrqOk=
X-Gm-Gg: AYBFou3vk4HvnAdK+Qxv1WyJJuhy8l3DIxew2/kMLOwCZyWY/SGfEDbXh1akb6qSoHQ
	NWGC4xI0sIotnMTuM8TPZjk8ks0W9SF/NEIA+6OTCdNsRgetlYr7SqrO2zRs9XxpdWVa6MxbINE
	3xFiWAQOB8LbL1w+7mrJCeEW4EGji+h9EXdSwaEJARfIEKE1Fgt0RZEuRqlI678cTRORNc7j7Rg
	XNKa/J9wXvt1eCTsRxzti5E8fYl7nnLkEvzd1yBjGjD564K0ykjq5YpStKzuLFHQEAcobrwTNXp
	wjYQn4ehawo0hzY2zGrF7oCPlrYJbD9JIqIRBUM2J5ASMatS+1Z0JDSRQgZstYx0udMY0uvurB4
	9jv9MSjXE9kHYCc4ria87GQ==
X-Received: by 2002:a05:620a:57d1:b0:93f:25c7:a4e7 with SMTP id af79cd13be357-940ef915dc2mr1132234185a.4.1793007985003;
        Mon, 26 Oct 2026 02:46:25 -0700 (PDT)
X-Received: by 2002:a05:620a:57d1:b0:93f:25c7:a4e7 with SMTP id af79cd13be357-940ef915dc2mr1132230885a.4.1793007984572;
        Mon, 26 Oct 2026 02:46:24 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd650118sm301524966b.49.2026.10.26.02.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:46:23 -0700 (PDT)
Message-ID: <269610c6-5ace-4faf-aa44-6074074e0cb6@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:46:20 +0100
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
Subject: Re: [PATCH 1/8] drm/msm/a6xx: Check BX dependency vote index
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <ltuikov89@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-1-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-1-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HhQvZXAFzJhnzGEYWv3081G3_fh9bzq-
X-Proofpoint-GUID: HhQvZXAFzJhnzGEYWv3081G3_fh9bzq-
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf2172 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=kjaib4mTrQJa5ucwwGQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX7kLydovkRrNd
 MP5GsmrPUyu6Q/IVexQQ+LHVmhJPLLrx3+m0Ux3mQxzEbl8jw1F1maRm2ZB5+KQxnP+UGkGDmI0
 c7GFt0+4x79Kd+/7RhJALSPo7bF8VC4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOCBTYWx0ZWRfX3ApE2ccyIctB
 WXmvRTxRE3OJ1LJsA9K56pQ/BkiaOWVe12QgA/uZp3fh6V/7X66O0drVLdiJTMtl/9+sRM9Y8Rg
 Lm9trtN8242slv6lrRi7kLR5AvrkMs30kVRONsi/YrRzk7BTl0ChArj3sIEpPZHfvzt+C4u0fFV
 tsfWEKwAg6n5gIjzXcmoMGamB00NOezvKKjEcZZ43uFN/buFHOrMb6s54HQjoXHLDviQ2O+PPUH
 cHHa3HQ98gP4hYAvQLcXEWuGVgnk9ytlFnJjyGPiTyE6pc8jMFtwV3MsjquYrUcmEn4Gh1E1l9y
 OvOuACG12DQYoHaSa1QS1EhKdEWCP0izvOMjuv55G4JrP+h/6yxHHgFjY7lpIFz93w62enZd0q3
 AxOPQSWLqfTq4N8sxzs5rJP1jys3MJMDiOpaGBVsMHoyigsIG138GG2KnQfNkfmQSReAzSseVRA
 EHs/flip2QZOfAGx6NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260038

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> a6xx_gmu_rpmh_arc_index() returns a signed error value. Check the result
> before passing it to FIELD_MODIFY(), which rejects a compiler-propagated
> negative value as too large for the field.
> 
> Fixes: 020b8eaa1db8 ("drm/msm/a6xx: Add BX rail support to GMU dependency votes")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610070334.bYvBJSpj-lkp@intel.com/
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
