Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395112;
	b=X5LH7Sphf9TBT6/0tJpzyxulRB9sZiJKT5XarBkDb7CTGjQNriWJc4SJmUKMANNumWLV
	 jK3WDqifnnJCPUyCfIoWe4wZVjisi+/nUZSbQTEqK1ogUsI0eHzGQGHOkw+Kv0kspYlwM
	 /W36+ieijFlGts/+U6boSALJb0PYSH8tP/MrbAr4r5NdG6Pb9B2k75EdfeZGCV169ghDj
	 kEUttlQZnWrPPuGU+wtkcBPEJaqg6N5z4EHeU+isPwXcvaPsALuN/ZWuYaKxlQjp/tHsZ
	 WbbkFFiNb3Q73hngS4a3p3dZN1frGeCGrKtNsfU7lrFLprbwvp+xqO8wePvFsyEsC6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395112;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
	b=sgM2G2dJ0aakvbj1KsgN4Ro6aBTWXbz9WoBiNZ0VBSt9qVXxhkX76elKoetYWQSzfXjv
	 5KJ77jiVeoctokC1xJhxdJzSWxrXdFUPic6BVl3fw+VsogPpE7G4BpDlNDaBck5B3RGki
	 CIIxsvrE+f9x6eKhACmg6RXrRjWBWczAg0Vf7ntIVXs407TCBMvV2+G7PHCG3RcpqBgKH
	 36dwGTYQ0bT53f8/jdl0EGD+3zmGk9vsK+GYl27m49b3zApvaUtuD1DxM3YAcznBmKYZG
	 PaVy31aIb8woNyXQM5wl24b6M5TOw+3Xl7x1J5HN9oOXxPhj/d2hnor+Pk2BwR8+XJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mz7BvnsU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="EzLuUJ//";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A9606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F23A9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mz7BvnsU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EzLuUJ//
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KNf41386440
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aWDnnNx26bu9eNBEE5Ehcsoj
	fHfv5oN9+T/oze9PJL4=; b=mz7BvnsUk9uvZQBPrlrCP0FY0EpKMK8Fnk/BJHJZ
	eIoz6x8b3e5HhK20kdOqW2ekkFFf4tIzIIQd5SEedf5uMjSOn1lfN3HMweVk6lH5
	ntz+LJKj1xA3zC1lWMiPjWdkI7P4ItEVdW191lQ5ipmefuyWEOahTrGjWcSdxLuU
	6o+wZx4H6jlX5sycKyAHYbwEDsNvpGFbhB0YgljGlpALYPGUt4AeZiDZLjWRE7EO
	9Vv4M/xETI0XHrHJGE+QWvWV4JiSzyR+bb63NyL/COQ00bTFpK9FUgmvXY0PAZvi
	blXIaVCaAkAuxykk5ieBxYSJL7zNSqx6hLI4vaa2D1tpzA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnma8q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:05:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3425098ae4bso616402eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794395110; x=1794999910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
        b=EzLuUJ//xrWGfwX+3r8k/nxd7OXTopxuBG/mXXyND/7E3CnLEwXXVJ0042K6vTwmiA
         cZAi8Y6U7C5eTDfduKkzZaA+IemJrrv58lK9Mh3xtpf1bxYsRJc6gU9EnT/WwjPJn0Wt
         0pkCX30kVPDexZb1VCpIznA5suqMd6AL9A26ECMm85jHamay/XsOVGDjad3c+F/U0F2l
         9zm/LWmn1cMEybuA6JWpRP+7oiVlTJbHuAIIn660mkyWMAY4HIJHe9eyh+8ztKDNG+le
         JYbMnYoGMwuolq75QXCU111y3/yR2b3AmDeyuW5HKEDgI2IwVSWYT9AkL1H4R+KF40AS
         BZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395110; x=1794999910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
        b=renQDPEo8xQTcFvl9wVlOfG9QkKULOPSAwH30KIQ3rE0chHhXqI3FM97U5fj6EedJb
         lqf13p85fQEy4iY8A1Z+ZbCR7QBND5vOxPxC0FzIBtbDVmQ//JuJjih9RLUdVVb/HGR6
         b4HsK/Nyx1B/LIU+BeO7rMnMIwHtQIuR1igUG/BlOldiicXLrfSnqxRmbuj7y/8ypK8v
         vL5RmBdlKnUv8hQ4mo+GsiRsCuYma+gBG5L7/SbhTZam4zUghxKsJN2lJInjXrDH3aIx
         gTiA6eMIwzvOVIDxEp5lCFj4LzdQ1n3DHXwAEtDCxxJukJobSxUeJiLQ42jbNryWsLV7
         EYuA==
X-Forwarded-Encrypted: i=1; AL+hErGgqoy8UpFy/gBL8ob3eKsO0qrXTBE4mmanIH+3+69P12qQ4IK2MxqsUIDBeX9e1Wki+d+fLJE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yGQvuwU30xhLw+7trixTIVTk581hJpkAj5GFebiDYwFiyFyTm
	W2+XL6pu41A5JnpyRybJms3yHhlYHe1S0oPCjI6WGBzcrYs/CL4MJEaYmx9z2sx8GphJiAsrWqP
	f3CH6PZPZLFjJ1FDhP0sLeKZT1hTewClhwHE14zGKBplLeFWIBgTgJtX0Q3g=
X-Gm-Gg: AYBFou38uxJ1KSk+2O0h7I/8Eyn1PtvLO+eaT099OSlMehL3INVBJMQHZIBELCELud9
	j6pVrxsKaLHwHf7ILj7GklIllxj7Pp/nky6kKfzwBCuC7bOfklkbKQctntHctq1hTS4powDe7Mp
	8sFlC4cflyC9vKCJs9anJDbR0oP26MzjO+EJDQV3Rhba2mxIsEtUBkDTJL369/zMJgpl2HYjTp6
	c+fv0QYbfyam1X9/lbZhV2xfip7QY//ijCKGhz+sgZtMbMaVllZwJbQ2RR8VI3HqMaEOAVZtlnA
	7QwUQVQBcp2WoW4CuflUBighH7DpXQqOerXzW+n6PMFJ/bKmXhO1NlNllP7JyqgnmPyrG06558L
	ETp/bsZDPY7rADwmDvhqyas8MpEaC+OD9fXFEYt9Sc+gIAbT3nNCfsPtb8ZKYJv7uu2RTU2FJIM
	nc/Bc8YQs=
X-Received: by 2002:a05:693c:6391:10b0:376:c208:ed7a with SMTP id 5a478bee46e88-376c208ef25mr1678151eec.8.1794395109720;
        Wed, 11 Nov 2026 03:05:09 -0800 (PST)
X-Received: by 2002:a05:693c:6391:10b0:376:c208:ed7a with SMTP id 5a478bee46e88-376c208ef25mr1678128eec.8.1794395109019;
        Wed, 11 Nov 2026 03:05:09 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520608b52sm13502136eec.13.2026.11.11.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:05:08 -0800 (PST)
Date: Wed, 11 Nov 2026 16:34:56 +0530
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Message-ID: <avRL2AeIXEpA8SE/@hu-vkatoch-hyd.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: PcAdXDzVEA4ZZDEG1r4GE_t947Rcag4m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX080NcU8h7Zpd
 1pGiysrjGt7cfmRgTC/awvZUQTFAd0j8txa9NsKRn3X7dc3/OSUH/mGRXdm67klFPiQu0S7CyQy
 Todj/oPJUW6IZL1Bz9u1QDT2efZmsAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX72dk86/o2aFf
 oo1hylaKObVLRjAR0jC3ExEuZkHXkZhezkCW5EopW39UGvjMY+xsdHXTXm8Qeb6zv9e+Dqo0+zR
 Ia2udxxXWW4g+7XUVdFLDQyord8Dw4t2PfatjwE0O9scykxvnN9Dm5Jwd7p4MXrceZmJcMjtNxS
 0u9uG2DVRj9cWg9FDdD+duhtvkHEIeKvhzBOrea8XFVvRdTtur8ZJ8scWxfuj07PEeJ+druUjJ9
 Bx+LN1bx2RXF5fffiHSiW0ZrHn8p0ogtasVvQOfS2/rhW5ld8ilFT/9CEtDrZ6T+MZv3D+TJdQD
 nNGiKl4q4bQGaZv+e0bM+UMy15Ix4Eqb/WHoX/mR/vJXnovvvMXPYBQTiJ6w/TjdsrUoG3b++G6
 A1Mpb07zIgwF9H/iKX6yx1mjS3qRvdeV3SikAdCr0DmTujyID+3eW8ubySURMJOxzaTjgbwU2wE
 8EckepKwyU1nqVJ7wyg==
X-Proofpoint-GUID: PcAdXDzVEA4ZZDEG1r4GE_t947Rcag4m
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af44be6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DzlgiSjgYWYhIfnXaHkA:9
 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110044

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
> Changes in v7:
> - Move the "iommu-addresses" behaviour change ("reg" required, non-direct
>   mappings rejected) into its own patch before the iommu-ranges patch (Bryan)
> - Make OF_IOMMU depend on OF_ADDRESS and drop the #if guards (Rob)
> - Use resource_size_t for the size in vfio_find_dma() (Sashiko)
> - End the derived trailing reserved region at PHYS_ADDR_MAX - 1 to avoid
>   overflow (Sashiko)
> - Add a dma-iommu fix to protect the IOVA rbtree anchor on 32-bit with
>   64-bit dma_addr_t (Sashiko)
> - Use the "iommu/of:" prefix and fix the subject case
> - Link to v6: https://lore.kernel.org/r/20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com
> 
> Changes in v6:
> - Addressed sashiko comments.
> - Addressed comment from Bryan.
> - Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/
> 
> ---
> Vikash Garodia (5):
>       iommu/dma: Keep reserved regions below the IOVA rbtree anchor
>       iommu: Use resource_size_t for reserved region length
>       iommu/of: Make OF_IOMMU depend on OF_ADDRESS
>       iommu/of: Require reg for iommu-addresses
>       iommu/of: Add support for "iommu-ranges" on a device node
> 
>  drivers/iommu/Kconfig           |   2 +-
>  drivers/iommu/amd/iommu.c       |   2 +-
>  drivers/iommu/dma-iommu.c       |  32 +++++----
>  drivers/iommu/intel/iommu.c     |   2 +-
>  drivers/iommu/iommu.c           |   2 +-
>  drivers/iommu/of_iommu.c        | 147 ++++++++++++++++++++++++++++++++++------
>  drivers/iommu/virtio-iommu.c    |   2 +-
>  drivers/of/address.c            |   2 +-
>  drivers/vfio/vfio_iommu_type1.c |   2 +-
>  include/linux/iommu.h           |   4 +-
>  include/linux/of_address.h      |   2 +-
>  11 files changed, 155 insertions(+), 44 deletions(-)
> ---
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
> change-id: 20261103-add_iommu_ranges-549cf3fb0867
> 
> Best regards,
> -- 
> Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
FYI, we need this series too, for the extended mapping support [1] in
the fastrpc driver. I'll be posting a new version of that series soon.
[1] https://lore.kernel.org/all/20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com/
