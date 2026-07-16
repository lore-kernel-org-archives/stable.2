Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8D41DEC8
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204405; cv=none; b=BVQ58KpfNFobm/Mt4a/dLDoM0Et8Pzy9Cuo0TdxqQwhhj8rzQCgCN0o7xDdoNrSFnd5IVjakyF2Lc5vKSNRXbdrIZduaeGzhmJuXucXf4KW9b6gDGiYIANXvymShKwd6cvp5mUhzeZUMQM04Bma+dPr8sCxshpQrD9roO0ogmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204405; c=relaxed/simple;
	bh=IvihLxTzJw1YuxfZsmv2OMWXoTk1psFfLCiJdYU77uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm7+vsoVydgjUgCfElMqsjOvXTrFOCfjwd1q275RMqzrgivPNZCL4vGDdjClYOkpLUXTFGiie0f2YQkKJv6zXPFZ8zu0wEXXzQOJ06TFR+cu04RyItvAzvBr8raafFMjsLmoDrtjmlU/b24TD4fzvB/Rqer8RjNjgOem85C2/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oo8ny8Zo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NFIL2xiG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oo8ny8Zo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NFIL2xiG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBiKrV2678168
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gnfV8mXoh8bJi/aMBOJjTI3s
	rvXjZPgofaMn/qDqyNA=; b=Oo8ny8ZocNouag3A4omFy8V+TOzzij2pOY5yAJ/G
	5kmCXudd6cVjO6qO8hS/VrMwcaB3QjXMpuDvCxx4Ozup9nV52IQdqSe3Eq8JX0eb
	5W+vlORkhKU0KbHu80oYT9560uQuQy8aBCIvN9hj+xiiHdBWXJtqnA4MYvghPY3b
	xb4f4LquG1ga3qzdHrf11TIDxgT2INR4RYwvQmqfMbTk8dqgKk+6+WTK7+gQYphQ
	qjFC5orxY29bcCjFHDPfLb+pQtVlzuJm2Srh9RVqjR89+7mH2qGgZPJrEFjBW1B8
	tAfkeMHdOmi9hfwM9aH5bkRdC1t33yvJ++os3qTYQ0wwtg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feve1rtme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:20:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso83848665ad.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784204400; x=1784809200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gnfV8mXoh8bJi/aMBOJjTI3srvXjZPgofaMn/qDqyNA=;
        b=NFIL2xiGDZ6qm8gVvnWfGOWxDbeX3wZbW3CfDqRpgQwqK69c3YDBCIfNht+TCJT4Xk
         MrDetGgV6Ms/fzLEW7Vku6NxM4OCxYuhBUH/r571m1k34Rhm3nObP4COD3vHn4Sd0in/
         WjjGPTy+TwmlWJaMXjL0dV0AlqW/WtX5jQiHHU0BMHNZ9fCd8/38ZkBSDUS4QXf2bl6x
         qYGd8HWH9gODGki2kEr766aldZjSnd6gSkH0ultmNOTTvVfJK8zmYGmhHsOVDlP4TtKU
         OdKE4n876Y2jK/tVJZTByRGAOFKd73QdvR14SER43QOOAoPPQ0UH0l4fgzDIUCntUjUG
         aKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204400; x=1784809200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnfV8mXoh8bJi/aMBOJjTI3srvXjZPgofaMn/qDqyNA=;
        b=HmLU7Ojx1Ta6/JiT+tYzXmafSXgF2n9JPPA0VsDkJYR/LL4IPz0W3wqd1G1uzxcCfN
         jBFccwKaxsuiQklEJYEw5YuxetEgdmeT66E/4rKu9Rb754cxup0HtyvGI+E0K/txrysh
         p9kfwY2Vnwbea9tcNKVKTAGYA2omjcUua1A7pt+r1dwsjyDPTNeNl+P9tapwteGAdf7+
         PjbukVAo+TJM2YbARcmYU408QUbeuVKP2PoN/dKFV6O+rHErqrCnY9euGFMIopW83O8u
         w2trsbgvQ6FCA9ha4AchYtcMvcd06YyiGajLGi8ajrmCfgK+nr7oiSCvTk+zxMV588o9
         vr8A==
X-Forwarded-Encrypted: i=1; AHgh+RrhwxNxF7KoCGE15R/oNCZ/WneeorXxbSsfk7+Mfcs0rSMAvurN9VXT/RJAcB3dkqBSMXU67l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhOfdRUlQbYA8MJ3MVNWDbA7AQ9LE+D8L2KnHvDTBaKNtsqVx
	6vZzR2Sd6c3SceFyXdhdPw5UQ9Bx6wh/h/LmBSBaSojd/8z8VeLPtkVD9uH2ZL3dPjInb7D/Hk6
	C5WEmv+LBQrqogP6KPcWlrUv17LDYKIq6lLN81kKtwXv4MOul2oCvGhzukos=
X-Gm-Gg: AfdE7cnEb+HAo28Ahl/bqPwvp1o9rBftzsjwU/oEqX0XgYDS0OVBXdTaOMc55S9eg0E
	cwq2RB+wCfmrw7bDDwxTNSKA3lMm6F1DKdNmps+/eA4kkQePNZUm1zJwvdj5ckyQXO2pRO7FqFR
	8aXrOBGNFwqwLNfPetHHLUzeY4zM/3nfEW3U7ox4LQUxEpTz1tXHKQt1pIIvWu8RBynjB5n3Huu
	sYA/Za0KKpUj2m48AYcoHcB/6hWK+Gfz0XifKbgAHWwX9J7rRbjc9cqgwtdXVDEbMwlauYyAwmU
	JfbsTO8QZrfYb45nBIbWRILMle3FDmIgLoiAheZ2/VRNoXqzfPcXmYch5a9LPgSWEV5TWUwrT2l
	JCmYxdGFkdzIUcVVViH1zt9gxoQg=
X-Received: by 2002:a05:6a20:c786:b0:3c3:9ed1:2549 with SMTP id adf61e73a8af0-3c39ed1356dmr135368637.41.1784204399457;
        Thu, 16 Jul 2026 05:19:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:c786:b0:3c3:9ed1:2549 with SMTP id adf61e73a8af0-3c39ed1356dmr135323637.41.1784204398889;
        Thu, 16 Jul 2026 05:19:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cdc4accf4sm2336066c88.10.2026.07.16.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:19:58 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:49:52 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Weimin Xiong <xiongwm2026@163.com>, robin.clark@oss.qualcomm.com,
        joro@8bytes.org, will@kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
Message-ID: <20260716121952.rccgie7y7ymkuh54@hu-mojha-hyd.qualcomm.com>
References: <20260716013229.91014-1-xiongwm2026@163.com>
 <20260716085313.207069-1-xiongwm2026@163.com>
 <6caf8ca0-8be5-4935-9766-10d21c71ac37@oss.qualcomm.com>
 <0f5ef1fe-7d15-4354-90eb-a7e42623ae94@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f5ef1fe-7d15-4354-90eb-a7e42623ae94@arm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyNyBTYWx0ZWRfX2avwRPNFmnsf
 a1odLbVKxOnn5yEcBoWWaOilZD6/UOkm6PvKTlmWVMVyGLVnO2jHruedWe53JL2HSj+hfdNxLoc
 4Frv742oNsDJH+xqOKTUmuQXotL8XZoqvZ9lLHgfS4xl5evL1Ty3y6idQYVCmMfSnR1Trgar9JQ
 ymp0F3TbsjXjtz7xOwnXNsHkmsY3ss5sot2hucmjHEmIM/DAowwldEcIpYDpguXYQYCEG/8smZE
 7qvWLc1GPOyETE5lJ8hmsCn20cUDH0NrttfOMUqD00zqkGd81iMXDF7fK/1kTRoJNGYmSHFidpI
 2sRg4Rtqd2pCZRZX/ToGD4azmL7xe5k9ixJlOHQwHeiek99jZKZZ5RKcwtdoCnT9ddmV1A+W8g2
 QJBAjlWLAEqJ2FhGqGbfaSnIkyTqKQ/Tv0mc6pWEJBhCttPfeTbGIzbapqVIFcX1UiL4tbwbfQj
 LuVte3AF3Jf6x6oBJ/w==
X-Authority-Analysis: v=2.4 cv=DvpmPm/+ c=1 sm=1 tr=0 ts=6a58cc70 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=3MspdcVbyA1qY6HslxQA:9 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: xSxRMqn2F2q0xV9CkyVj4nMAiRQdLcxY
X-Proofpoint-ORIG-GUID: xSxRMqn2F2q0xV9CkyVj4nMAiRQdLcxY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyNyBTYWx0ZWRfX3OrhgDm2rDxh
 aG/bmAGA+srYOQ6WSJjSlfc8eFuvJnsuKuCp2WDhzCaPKTlmL9JAuXKPM2hLa5s/jIR7ihKAV+7
 CcYV0V5HgHWujVzxEHLCKgkL125Olvg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160127

On Thu, Jul 16, 2026 at 01:05:57PM +0100, Robin Murphy wrote:
> On 16/07/2026 10:42 am, Konrad Dybcio wrote:
> > On 7/16/26 10:53 AM, Weimin Xiong wrote:
> > > Move the list_add() call to the end of msm_iommu_probe() instead of
> > > adding cleanup paths, which avoids the dangling list entry problem
> > > entirely (suggested by Mukesh Ojha).
> > > 
> > > This approach simplifies the code by ensuring the iommu device is
> > > never added to the global list until after all potential failure
> > > points have passed.
> > > 
> > > Changes in v3:
> > > - Move list_add() to the end instead of adding cleanup labels
> > >    (suggested by Mukesh Ojha)
> > 
> > I think this approach introduces a race condition, because e.g.
> > iommu_ops->of_xlate() depends on the item being present in this list
> 
> Yes, the IOMMU instance must be ready to be fully functional *before*
> calling iommu_device_register(), since that can start probing and attaching
> client devices before it returns.

Right..I overlooked it.

v2 is fine ..


@Weimin,  JFYI, Always send patch revision as a new thread not as a reply of
previous version.

-- 
-Mukesh Ojha
