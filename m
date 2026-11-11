Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402101;
	b=iuhd9eHWxaCG88KJh5NVUwnj1ZKQoynuMG9xjmfW/9n82siz1CI9g0sywLU4fOnlWjN1
	 Vz6uPwFJeP+pn0oPA4POGS7KvzOYZGN7FciJQA0UMdWHR8F1C4DiPpt3LTcoAWe76BJqb
	 8lf4/5NbtOxteeXEuJYajZufE5zZKrb+zzIKX5kCBlUloYctUtxX5qHTY0UgEvkd5gsbl
	 vwX/J5SnOf96XHjCpkXdZOxw1p1ULLlJPs4AnzX/UxajgPtUXP3ujhiPaLNvLJlTMdBBI
	 fF7v5GmZ5AcLqOzpcAT8qaMIykVcGFWw5sn6RNmKpgJqNpS2SvjaIyZHIF0K49F0ahQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402101;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
	b=jaklWJfzatiL6nlHsX7qcQhMcZuMk9tICyMre+bsef9l5pEWxqUoUNWXXjDMtEhOPIfN
	 hHcEFT0KebIJk6opGNnAZ9RXQ2bj9CGYRPayVe231DxE+4/pH0hQxRsq4DIzTcwlEQOFE
	 BzOSCa6mXPgHehFKIEzU/CRZYe8IFcFxIfSbzM+a+wOdDF4xN60JWBAAIqVeWJeklguKT
	 Lx89MRLcIKii2AVIr7KT8s/4aN61DEetaKQUhs1sOTNbeiYtETqdMBzuSqzGqptQGS62n
	 LgqykbKRHNmI65IFmQEnlAT0WIjw3pNdAKPF+sQCMk0wgYgxqLrZO80z/clotuY2lFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6q+meWf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ahN0Ajmk;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE8C606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE8C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6q+meWf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ahN0Ajmk
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ6gT3292100
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fNNA5DINfFRpf2eORoYgUUVl
	bLJUUgtkmYcnEbAYKiY=; b=p6q+meWfh8pxTAsOPcNqXBXxXBRbH+GJDC4uiwKA
	LJ5hYTCU3/k1FKYji7ugZnbHErDA5WuhE5KzDaz8lgoup47Kf0aitPgAEw3rW0lp
	tMtswTpUYDD8q4tClQtiOBprE7ZUy4pXagV9SgI+lMAfwYQfVHVebO5KPPIcUnid
	chmnqaobA7mVsL+v/gdx+NJL5U1KFoj9M4mB1lr2ZMcQaWN29IzteadEmIgwVhrK
	EIpAcU2xW1xN36ygYXdO+5SKN19CrB5t79dsRs5D885Pvk1tYO8MeB2FCyVs7Qv2
	wejjCK8v+qWke5jhjykBYz7/jQCHfyyuSVzlG19XahwgNg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp2jwj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:01:40 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eac41ff334so2898125e0c.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402099; x=1795006899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
        b=ahN0AjmkD63PvVgeHmTW9R+4V623g7CKUjFoxTx/rILg6XoSPLCx7vdHPmEiblcs9+
         OXFKV7KwAzlj2DLe0CbFaW5Bl+jini2AbY9yNuUlleNQsjl8UoD/rLmNakZWu011wDRz
         38XM8LokSGsfwigtXiC7FcGwIKOc7I2XZxri8d7jzBWcGK4gC/ypzwPsIgP4XWflydYe
         RvqfloJW/9ugMzKTVIOYs+R/w5gem1fhgrJt9duQl6Q62scnAmDmH8VUXAEEpO75agNy
         j8BI4XUxTGkuy4yAazi5PoyFxyec5jlQglS9mkW6IXcVyjrruY5FmAnPRdATuGlT8Bjm
         HNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402099; x=1795006899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
        b=kzAPg0CecZVAvB7nyCwLDpd1LaiR3CbK8hqGrNcCtXouhvN4pDFaZpnMFxpz2d+RgY
         82hf+HkjCEhd/3pgOx8u6kWtx8vIRK6Kl6PNG9G+R9h08xOPBD9O9YTkhC43BGH0WwWP
         Du01VPGAwgcdZOTnOgo6NDWESvbNjGuM7Bllip6NO787FrblPKvtkeigWV1yH+NHTaL3
         a+2PyxBH50REZ1m4apfmcWU7lICnP21pe5w6uJFlm6cYCe/2d2+KhBI5KOpShxqlLYhw
         KcqEkarc/ZPmQZJ4dk1J5biLZeORgXCGRyWOFSAMe0HlaBtwL4ACCDy4FHiJk1ic6q6q
         YCVw==
X-Forwarded-Encrypted: i=1; AL+hErFOD/HetO1pOpVeazCdnB1Ly6jj6DOrYl+2u9LfrfUzqqq9A1QWARi9c9mRVSlmNvOO42IgYus=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oyYW/8FNCXEoCrG1taK4o87GOhescdfmwqBtybB52c+76T0TI
	xEFJHM0/qZvCzCD2k3tTxa6feDcyQPYgRQFqs+SaxJdnuAmVvLiNUFVoeceUfzZESU6YUb2VfU+
	53jHZX0DbYClvlFJBGWQILhex3DF8Cftw/1QKiBzKQMZs2ETioJ2pDNvMgeo=
X-Gm-Gg: AYBFou1nsitDAS+tIoga2Fsj2te9OHdDebzy4iQ1Jn2UNvgI1SrSl724Xn286pUIXVl
	6MVo4ND53nTUBLY6xT8YN85Z5qYiH1wPz0XLAk8G94WYlJkvKuNtUbIUBdf7Z7vuCjbM3L2+5kI
	dNd1SX/ZPotJYxt0XQ0ahzI2mq0CLCO3b8ljhHKFzd/Qq918JxHjp3KyveRBHsbyewHlWqJKzzQ
	yn5K7H80qYoITCcHe780EsYq+v2aQLHwWTIMYU9PGRmIYGonUVkAiKq88ysE9BNvYJy7VPDQS+o
	HzxSqlG1VcAdfhtMBKaDTbyuRsYcQ07o2ix/mIaQ/pLiPVauNPrAgBD4UNhO9oF8m3ZknKvIrBh
	a0ifTb/h/qbEAuORZlDqlZvryJqSLg9A3MyyO7HsAvt+Yl+x4IB+DcyWz+xIXDs5Y8jGjn70f2d
	KlIfHmVq8pinfXXG4cUH8A0NiN5Zq1poBFj45oCp9F9+Jkn8XuZttcw4Ng4+R7LQ==
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr672589e0c.8.1794402098899;
        Wed, 11 Nov 2026 05:01:38 -0800 (PST)
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr672510e0c.8.1794402098347;
        Wed, 11 Nov 2026 05:01:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157b7a657sm947505e87.11.2026.11.11.05.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:01:37 -0800 (PST)
Date: Wed, 11 Nov 2026 15:01:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Message-ID: <h7j7lyl6d67xfdw3gyabfngpurumbqd6fkcvuhyi4juashcx5r@egybwhfdaonn>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX8/JDeFQmcPVK
 X7iV5bF9QKrYwnXOPbJo+f9B5/UD2nHsFVVNVF20OjLBOaDktTHs1ek25LogFyr05ei/P/X6910
 H2v04y1cj1jO/IkdPrtucUNHSFMVyh6IhY9SJWiZti7yGEgrQc5Tj0oNX1RKGAPvoequgDSiN2F
 pBMDLTK9K8MTHzJ0WYwd28omAejvKUyp4uf/nZ59MkO3K0hQgzLU0Vu9xTH497Pcctp1d9J08qN
 cdThPImiU03pc8BPJooRzj2bnxd3ljl3gCT5d2DQSn7G4p3M/6ptcMTowdv5FdHP2qHv40TJmYZ
 jeuJTVg7SHlsnWnX9+ZVSKwE1D/6S82kDpfjicep2yYFVf2eH+EnrkH/F7rPLGKCiCGoL4MUMhj
 oBHUJ/uDNBlUf0otl3Kfzau8DbpJckNAA55HftXMUNTqEBfrHgDBtvOa4hJV0tdHgOXJqi0QZRL
 EapdxXQNSzNzQqOy/3A==
X-Proofpoint-GUID: uRTjYq_WjMhOjqh14OizDkd5rXRBQGWY
X-Proofpoint-ORIG-GUID: uRTjYq_WjMhOjqh14OizDkd5rXRBQGWY
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af46734 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ycv8Z8E-TvjlFfbjzzEA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX+pekPrF7NZYS
 3g+FngbJ8fp019BonFFuGTBqKw/kPulO03obT1HZCdIMlQdJjrhZrGpJF2C9T/2HJIOqkHooZiQ
 FG/8sZR9luPGJxvs9ldkCp+B5qAOpFU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:23PM +0530, Vikash Garodia wrote:
> The series adds support for recently introduced property 
> "iommu-ranges". It adds the required checks to error out for cases 
> which are not following the schema definition.
> 
> Iommu-ranges was defined in schema with this PR
> https://github.com/devicetree-org/dt-schema/pull/207
> 
> The patch series is being posted as revision v6, since the patches 
> were initially part of the media series [1]. The patches are moved out 
> to get review comments from iommu reviewers, which was otherwise looking 
> as a media series. Happy to move this back to media series if anyone have 
> any concerns. 
> [1] 
> https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---

FWIW these changes are also required for the DCP display controller to
work on Qualcomm platforms...

-- 
With best wishes
Dmitry
