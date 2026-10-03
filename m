Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06953101A2
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988437; cv=none; b=DJCydJ3N6lphwZxwT3QUfP7tMhnW7SDv7BUNHXWuN2YkbWuMACxc1vZOYE0I1xze3WCF55y+1mLvxWscyXPYBkFOp2MLClztAFm/BjV/TbnL0729IYY3zKohg5NOo+uqbcfBZWEXQ8DcspL7Cuhg3oNMhibBCktYHPkPQDqLqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988437; c=relaxed/simple;
	bh=7MnVFgNdC3RvPzdpl/bBNmvKJknpsmhzM9+gnj4Ftng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALbLiYGX7YsV4awN9T8BgP+4SjQ/A18UPEjMRDEObkySyXjmR0WmLvfhtuOfGBb+w8LovtgWKgdrIxeAhdwU3Mj5kHOIaS5a5oZ3MbyMHbmOaH9tQZIJ2OzHc8EaH5SBqiW5EWx25km0mc8nbvQ2ejX6ZslwvHltqhfuLbLC1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/Q6ytf8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UBvQ1Wnh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/Q6ytf8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UBvQ1Wnh"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692NeIG62928375
	for <stable@vger.kernel.org>; Sat, 3 Oct 2026 00:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ZcxU10TAc9LTeYRglm1g/5Bzo8itS+vHj6k+ekfAkQ=; b=L/Q6ytf8kWv9eKaD
	xtQE0v7LF3Fw6PfttVeQgX3/zHCGQDa8tRjgtvmlCP/SgXsbjn6q8ibAAxVHx7sh
	jStM0GEul9bIF8qNtm5E0+qCEcABPZGoUsIShQlUDW4c8kYsw5dqDTiJPyDUEFIF
	prGYDqLKIluJ7V2Egi6UD1Fl7jpscIhzmq5QWpv6ZHfktYNyiN1jDl1Mqcoq87yb
	1mlLtmI1yjjj+jEfg+/wa66KCv4kVPji7Em/cne5B6zHl2rVbx0PthAOOcDil3fB
	w1/EKzWsnjp10k7GGxLkTNnwLR0xSkwPLdWH6pHNM6Mza70lVhLGH4QEKplnRkw6
	0d69cA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20nfvvud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 03 Oct 2026 00:47:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93bf4c0af4eso490184885a.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790988429; x=1791593229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ZcxU10TAc9LTeYRglm1g/5Bzo8itS+vHj6k+ekfAkQ=;
        b=UBvQ1WnhIWeduXK/BJww2TiHrQsPfyhhR3ZA15JJjeegtzgNv6OiejSk4Mw1dqJS5D
         x1TWnSeysN2znW1OLNnhBrwLZdyPd6SWTmroLKTHQbTusM7B+CZqGB3AdjyyAtYwOQBB
         8qdsOseZHMNSHK0SGbFuHlThOavIqK9EUK1xGzQPeTOWxu/BKk7MkFvS631vQbznu8xb
         emwWMQsXJRL/B6xMQh5hRAPNGKqWAyHrA76KDntB3PsV+17+Vn84poNYCntEsEe3SJIF
         +HTMMyHVf0EhWwwLxwQDdPRkJbAJvMayy7HzMlXRwsDQHXrtb1ljABwt2ARS+1RTq9Tf
         R4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790988429; x=1791593229;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ZcxU10TAc9LTeYRglm1g/5Bzo8itS+vHj6k+ekfAkQ=;
        b=upuJK5bgnc68gNuYQd7hiif2fmoAj6AhtK48l2zCq+wHe5SVlVwQoBJCUkG06t7Enn
         SxjsuCmZ5ia+8Oy/VSITplmDH3kNwxEgD98iGKALr79EdujxXHDMV4VzH0lGIExyL2Tt
         JBqWWvvLWBGprFAKvSs21LEuOc4o9D8K2G3j77vEJnwKIK9px3MmwVkg5xHo/qoQqeEo
         jAo8eP1RK/C7wysmeotowtvIvDhcWe39bDY49U8jjZs7xphXr//mqlDugCppDdc1oeac
         gBx/2/lIHt3d2S78QsVMt1K4gXYKJmksmdLcMXedpuTaTEr5LRIgCch/Oy1KMiv2l+Rg
         aQNg==
X-Forwarded-Encrypted: i=1; AKwUvBxccZzbcTbi0GtNMaujl6M9BHxW3Bpau2AC2jB1H+YV8Y6xr+7fkhU0S+BXmwW4n2Ak00rq+t0=@vger.kernel.org
X-Gm-Message-State: AFuF++l8a+E4Y2SBcM48m3uqgVA1KEaLoCVkulcbtfXLW6o1czJcD9Wr
	wKP/B6/WspmoaSvjPxworL8HAzHBeqoiRHfVxWpVAW4/MukEmIqRjjDRFyxbbNxfnLVcpNEfZOo
	UhqZIb/XhjYhZ4eXO4qC4yJOPmQRntUY/8q08cWytPNALtvGRyuU/e0Lh9X4=
X-Gm-Gg: AYBFou3rq1VSb+yRoGmegqV4FE/fL0JTr26Dz0Ll9ozILfe7yjfiH4iAwaEfPYa5Jxq
	luOVxJsY4Z/7LJ2+WAVLsCP9HDd9VDIEYWlx5hMfYAx14hH6RjL/PnXX8jSbrJtu5vR71qmeheN
	wknJLKLN/4Ov5TBQY1zh4rOfxfsXS1QjY05HOUtrvvWnCxUyUu9ZUIq91NBeWsURNnAUgU7iJpi
	6IU641CLRQdKQ+zwFquvXfpDP8UWDq0/aSNzWcSS1pFzhA+5BGeb2H2KoZHL4FnO9RhnUwVntVh
	vomBnWqMuipeo49BZbpf1IQagcu/r+X/s0jyBEgvQa0RfwaAC4qiHhTfzBZgtBoudSNejjq/Sfj
	pVmMU6C3z2AYYHU7o72tMMqagg1L6zuGRSrlVjUjB+OFNQC4CNJBkfqTYX3VLPU4Y5+Yg2/PBPO
	8c+Tag1thIjJWF
X-Received: by 2002:a05:620a:1a10:b0:93c:65e3:df81 with SMTP id af79cd13be357-93cb5a5be1bmr1444376085a.13.1790988428838;
        Fri, 02 Oct 2026 17:47:08 -0700 (PDT)
X-Received: by 2002:a05:620a:1a10:b0:93c:65e3:df81 with SMTP id af79cd13be357-93cb5a5be1bmr1444372585a.13.1790988428238;
        Fri, 02 Oct 2026 17:47:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:47:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: abhinav.kumar@linux.dev, Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lumag@kernel.org, marijn.suijten@somainline.org,
        robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
Date: Sat,  3 Oct 2026 03:46:55 +0300
Message-ID: <179098834079.3641559.2074719170971578581.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916175738.2089950-1-vulab@iscas.ac.cn>
References: <20260916175738.2089950-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2fI5L5ZKutnpa_8QMptxQEr8HY2m3UME
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX6cUytJHPOfjv
 He388bM7YnzYy6FIeRvh9JxYh66jvGhWA1rTNq0T95DfluCZ/jsIEwFW6/1CXHvkfDSbQ+F7+VR
 qMUWaI/P58Ulk4b1EirybLeI1bqNUvk=
X-Proofpoint-ORIG-GUID: 2fI5L5ZKutnpa_8QMptxQEr8HY2m3UME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX4qHs7HYt9Gp6
 mZBGKa2+LxvbBLpGArzw4O8S+v59DHEpsSoKZxdrZLDioEAx8DrwpPi5Wq9sPnW4xkjgPqsLRey
 JJwhkHAc8+Ik6wfcaqllqqpT90QUiJQ989A1xUlV+VBMGeTXAKlzS3W8EQZCC9OH/9b9Pg6lso6
 NgD5Wn4dmU995obZdjZaE/xqlFIOKgdyUDk73jDdBEZT2urM11+EsARCynNnW6E+e6PVhbeUvdD
 cP/ygj9uxAHAkzqAEE6DV4ChKtX0kHJjmhZyXbTqV3gFNRIwlmikm60okjsXoV4Vz0WQoq1SEq4
 3bZFcgxUcKv09bAOqnChtw2emrWHtcvsk5Lvp+NzPxR6hoLwx6dG+USzJsTEGnU894g75iKA2Oq
 kpQHDVJFbg7hreC+Hvp/cvrSnI/mMjwIWD5fw/cGYPOIGEm7+B0eLHRyyUDTc1W4F/W18MmqYbd
 7ta5LDAuBKQIvf4aCFg==
X-Authority-Analysis: v=2.4 cv=f+jdl+yM c=1 sm=1 tr=0 ts=6ac0508d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=nOZalv0Y895iF468lBgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002

On Wed, 16 Sep 2026 17:57:38 +0000, Wentao Liang wrote:
> dsi_tx_buf_alloc_6g() takes a reference to the kms VM with
> drm_gpuvm_get() and stores it in msm_host->vm.  If
> msm_gem_kernel_new() fails, the function returns early without
> dropping that reference.  Since msm_host->tx_gem_obj is cleared on
> the error path, msm_dsi_tx_buf_free() will never see a non-NULL
> tx_gem_obj and thus never calls drm_gpuvm_put(), leaking the VM
> reference.
> 
> [...]

Applied to ttt, thanks!

[1/1] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/ab91ba61871a

Best regards,
-- 
With best wishes
Dmitry


