Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B573412BE1
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204778; cv=none; b=PkI28l0Yo+U9EuLXawLTCAzlMSKy0uhkNcUMtPI8SDmier3Db6/CydBw3x76Vnpq9y0aqa9FmKs+tcqXjGlbH+ve6QSIz1/VVlHDJHJU+oLeKY1iPDkIr1IjoHonnHpAv8yBHDi81/y/IcT3i+FV1DZJw0zeqa1nXAi2ZiU8zyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204778; c=relaxed/simple;
	bh=FwgUuktWlKEDuO9hQ/D+uCsYBI78tLaDcu4N3uVEcwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5WSuychjxFX2nRUBVWuEO0i+AHJAycaZdYCLesmyvJ15IOqi5iUC7aofKFrt59skq/8IVaJ0vcywboJyVdHcG4mIaTCe8tL7dVLSu8EFIdte0Gq5ME1KN64NMgwMbFcj78wbM6EQ83JQLYPuIcTofz8fB7fIp/IIeu69nLP9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WN9ZOkio; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EscIiUOE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WN9ZOkio";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EscIiUOE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBiobn2355519
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0IxISuJ62EXm85nVi30QXZSl
	UArQyp0zpe3atXf2f9w=; b=WN9ZOkioGzp+oOtdH2jEA9K4+lZUR26J9qJB0Rw8
	ayPzszB9RP58b01sjy1CNIlKQ+Peo4ehIvoSgOQ8tK9dbOa7wCl8lAJvXSXDf8g8
	fcAjQUrHT0RB/R1BQFyGWT4hrDMKMcCffZF1LjK5kD4Womdgh0qf9uJGQQvRPMOF
	iy/3C9G7s7/Wtng4OwsiBSjT2wZRXjObbslz4Gv2h/z1nXcyfgqnPkKuvQRwmrxE
	BxqQuHVUYq0loajXgLeHnZa2cQmF7kxXU9LaUW2fO6KwvYT163p60yqsfo5m9HTi
	EAF8wPXhkTeOjR2KN76qwh7PtML/BYpOfKZ0fioqzTr3FQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed064b23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:26:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so668133a91.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784204774; x=1784809574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0IxISuJ62EXm85nVi30QXZSlUArQyp0zpe3atXf2f9w=;
        b=EscIiUOE+Lr9IoRLVMjeyUy9qMaK7IdPESPoJml7xq1WfMKoUT1Z1OK5r32ZMKF3r7
         D6/HoTekV2WRhWjNq81FNaCjvX8L7qBFVvnrdzmEgSSXQaKGps7tA42sweV3++xaorsH
         ArVAIz2Rr9M5Z5aRdcTFHnVAhjmOI5Zp4f6C3GVyXgMzEwy86hs7LylkfK7Drl2yuyg6
         fkUQ63nzbk/SHVzmXrozktKEXOzv4oS+oAwQacGvCja4lEhyqZb+GNf5m+wSvpdh6tvX
         uM2zwSzuMTKzFg95k2o+1G3I1ZcFelS6rxTznXmbPdVEe1PtNXeLSN4UrXfsMQFATzCc
         hReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204774; x=1784809574;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IxISuJ62EXm85nVi30QXZSlUArQyp0zpe3atXf2f9w=;
        b=d4EvIjfsQbWpve3wIDJsyzptucoLXVS3R7eRfb0BLrzURx4eO/HigLoRatqu4dWPRK
         azMNUzV/QokKJcXuCKca+TY2jJT06PXy+lOdsJTPhSUk3cNxWcKtFqqLOtMSgkUs86TU
         9YvvJUS0BMkE1t3XYq8MOfV2L5RqFmWYSUYAJ+9mJs8guQg5GyWLhGhVSc1CkZqqx1po
         XYJtMsYgX/Eibvy/oWqs7z9D7B7XL6ioJF5rA5VkSIxWwj9ZZxFGNlEDapOR4zG7hgPT
         TiZaRIdMXBLjtxTgmdcN/SuArweOQ53MQoeKp+1Mh8HXNxtBz2ij0Gc0OvFvPU0C3dQs
         puzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQCZPb0qPaRziw+4D09rS418qcJ2hLQZTl+pkLXVXtnQ68GYdImJmZfedBybtpyJm2mOKtmkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdO2lKb1nL2i8bAlAxlIEx+eR0jb9NR7V5IR4fnPANZAWoBZCR
	L789Qlj01y6mo4cNjdbpPc1vmTs35itXf/ZIEr7IRA9lfA4rAJq96y+TL8t8LBmqkEc88QSPgKw
	IZoYrqU97SUz+y0nKNo4rHVveGiPr2s6i9N7xXFlixf6D22bFLPXdt4JkTJ8=
X-Gm-Gg: AfdE7clCaf47jNs/dp9w+0ZngQpkQGJ9oB5cQgxZlZWFaA+YcVVDHTskryLvknhUOH0
	l6nqB5zPXRlZtkW3WhVRVMB7BqE82T491yd3rZNoWXGP3ROgjWhhoygXBQh1DOGmQxkQ4z1+Ml/
	nk3QD6bpAYYNxbGWCnbRJ9+5tb0s8DfoN3wgIZGfJ+5GgGRD8xuFhryPTZR+S/djJk+HSwTyKgY
	9/ekQFzOOHs0Fvd+aBTWyMAGPU0Eq02lQoAPG7/kYotuHfx1xOsZOZ2939eayHw7AxcTRJbnaO4
	cCWgdVFnWsFUJ8nHAGiVOA+OoNAoGiorH6MP3r0TdyaxqZ7Ltc9myBIq+0Pj4izLXc/oZGNjwC3
	GKowov/WgN3RFUbmnq3R1tOkn7mg=
X-Received: by 2002:a17:90b:1345:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38e3cfd30a6mr2342232a91.0.1784204773861;
        Thu, 16 Jul 2026 05:26:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1345:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38e3cfd30a6mr2342202a91.0.1784204773304;
        Thu, 16 Jul 2026 05:26:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e3a0d69sm12253893eec.0.2026.07.16.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:26:12 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:56:06 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: robin.clark@oss.qualcomm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] iommu/msm: unwind probe state on registration failure
Message-ID: <20260716122606.ybsdajd6qgomte3s@hu-mojha-hyd.qualcomm.com>
References: <20260716013229.91014-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716013229.91014-1-xiongwm2026@163.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOCBTYWx0ZWRfXxx+mVjxt4N98
 SEOArMwUGPp68ptJG98U+e6pkO7XeiyBnc8JEtAGY0Lc5Crqi8obzWn1/Od1IvEVeBAhLFFMYiq
 0MqWwnKKMqplI/tN+zOjr2iS6LMhFdI=
X-Proofpoint-GUID: uT_PbNIxt2M_2Ww3LvdvZugj2yrV4C3W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOCBTYWx0ZWRfX4yAyL5Ip8Z8Y
 sAXNc8P1oFFrRF4S/cfnp0Nfrjj031cDd9d9bcYC38vr887nLw+O6tZR5ShdkAfI9XBqYeB2arD
 6hIx83nNj4TRgG1RgGtBgCJsSSXjKSgRiKdB+crydSE2YztY5+mWNPILKXLAGQdM2vLqIlTCg1J
 epS80zOWJTPNgRFYNbS1Q/B+jS9F0cQf+P2u2XVSVH93KeIAsSBtVLm4OgPPaUFc7zwkltm+Zyp
 v9hDPZZIbX8hGCLvFlTU7LWTnBBGHTHQr33T1t9r7v5aI3yFGolWB9+CkITu6ktmR8veCecinqr
 4/cNKCvTm3CoPLP6MuDxct6N4ukvnA70Auvy1shvaXCj5yqBlXixIVqp4LHdrYn0EkPtCKnqLtN
 /Le/aWihjCuBl+FCSaGXZjsnd1sseo4nCpysAwfz9Myp/1fo0k19EbafaIdzY5hBm+nVi8k+Pf8
 5VOS0EvOw8XsZu1HU0g==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a58cde6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=qwb6liyLOyoGEZliCEEA:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: uT_PbNIxt2M_2Ww3LvdvZugj2yrV4C3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160128

On Thu, Jul 16, 2026 at 09:32:29AM +0800, Weimin Xiong wrote:
> msm_iommu_probe() adds its devm-managed IOMMU object to
> qcom_iommu_devices before adding the IOMMU sysfs device and registering
> it with the IOMMU core.
> 
> If iommu_device_sysfs_add() fails, probe returns with the object still on
> qcom_iommu_devices. The driver core then releases the devm allocation,
> leaving a dangling list entry that later list walks may dereference.
> 
> If iommu_device_register() fails, the same dangling list entry remains
> and the sysfs device is left registered as well.
> 
> Unwind the sysfs device and global list entry in reverse setup order on
> the corresponding failure paths.
> 
> Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha
