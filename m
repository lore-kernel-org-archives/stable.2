Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402187;
	b=CoqXeKiczneot/JcRfYhaK4E2WooskcOJ34YsnzPeBMHZo1dbwgyG691WCw3yWCrHiGm
	 90gGQxGaasTnbf5EE2HAB6IwCchJbhJo9Wp+it9opRLsBfL1/1lP4ppi/hntSvcIU6AOP
	 i61hyjMwiXbClbgE+WvRazsCV3bqq7YnndHmlHOZEZihqmrON4pYoEl5BUSHd2vdNsmNG
	 1prDCyg0y7ioKVSxllvYv1L5H+x06/2pnuWVaYppzlVdpLG/gjXXtNkBq2BfsdQtEXoHK
	 2pqQUzmro6CGFA7oSoplU8LD5fQ2UdlC38u54EBZBq1kLn5XCQcJelkRSZkZpyV5cSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402187;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
	b=ZymM7PrsnsQ7snu3MAK4zGFNq6o7syRqWLmO2gpig+NUqPQ3t6GKXUF89j0u4WDWpxfu
	 5WH/Oh2N2nva121pwkxl9zyfoIEaEfUfxVs1hnTo4um6vmQH252XacJ/wW7Axgo8I85D9
	 GahyIP6eX59iEMhLa80eWDbuu8A4hGNhh12hJtMV1rVRQQyz4PgViiywKI3OTVuLqnH+a
	 h5YUxFFdmYGHi1yY2MEmnto/jtlTyiMxfkXXnV9E7jFLJgtpxOpBbSOqMq78LQT06SmG8
	 O8bfGA6v1xz99f8/THThMt3lHGsn+o24drF86SP23NjNkFr5AXULPTKmC+Ae0T3Bl4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9mWwXg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZjzR67P8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55879606A33B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55879606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9mWwXg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZjzR67P8
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZO2Z1250754
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L8WR9+GG2EfUF3UrFaA4c5ks
	UoCcRyLK8GiwEhxkvFI=; b=PH9mWwXgQ5gEnifkFQhZ3anQH+M6DXWxjaYRNBm4
	8z/pNaY5400bAsBEpQNm+vBW+Q+jfqxxN8HzrTI5OzBHGZzkIlvScO/QKa7SGl2a
	PcypMhUu/gBKUX5uX9oh04q9yOC77RcAXm6BOFLzWoUXUVzVzcsM5EsBVKTYRsaf
	ij+ZkoP+ccbshZD5IvbBTtE8sEoCZpbwWmu4e2y+FeoOw8o2qNPB3O+GvjrxE3+p
	AL5/WPO/FeuqH2XP24+LiL3cpFAdsvCWMFBzD9x9fNyI2UQVztZgs07w1ZKgjDrL
	0O5WFB1GTvFsJB+TEYBpy6tRV1lwTog6SnR/2XN3l1argg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5md57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:03:06 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eabb3a1bd8so2972141e0c.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402184; x=1795006984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
        b=ZjzR67P8wqGqtdDTOZihJridX5Q+5MAT9lUERZhujk3OFRjnm/V3mV6hyZLHbMF+FB
         +byN0EVBtuZuuy7pVYmilcT+CwaRmYKUJUn1DS22CGwS191pyWZ2YqgC0M32PjG0nK7r
         fdUJ0Z32Nk3ThjHjex4z18y95JXPOjKkHBew2NeXNP42a6nE9fwxzlMoOUFCPeMLElUM
         u44kv3rU/ciITpwAdoXoXmblb0bND3+tK1Q4gU+gaSRSlNag+u0LRXnKMR+hpPZQyPwk
         wTgsrQqOEWHdoXmaZhouO421u7IYZzMWsXy53ZGchDt7r/u5x/cejS8bsSnALtMQugnt
         0rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402184; x=1795006984;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
        b=ckE2LKHoesNcNeR3/fbyIgooWwVDDJBtCD64V8dENWx8lGZw7yH9UHhF0B2qb0Vqez
         /Sv8lLtDVzTtvIuQDjSYN5zVRup/TK6R6PxN40X2h8sXI0hKtjPLfLdKfWGTyFSZasdW
         soNZf+7kI+/ILc+XOnFeQH+r6bzObQdECYaRFyHEIgB67bNyMaFsl3iA9KmU95kwuoYG
         oXSPo0xYf7HvNgHkisEGA8+FNqeVrPxh6V+DYRFZLu+lkXqzRZHvUqtBITR2LtteQGoo
         j/7Vg9aC9voHxab6LijzuiZA61ie9lm5O+lHLqPLn6nUpd85omRLZDmxQZaRVm9BTG5N
         2CMg==
X-Forwarded-Encrypted: i=1; AL+hErGV0CL8DWErHIIZcOiGGlLWVhSrqM1Fv/0vJTz3GjuB4eaDMLxnYYFYRepgN3FK/FXs/Z9nkjY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QHb851vI/4tFrLLUfx/3ZGF+UdbYkelW68BrLDga4jPkJzzuA
	9GQgz4oQqgulSFFVGK6QHR6/5tOJEOflrySa34q+qxPw+mCjjl9pJKzCm5rxOYhvTfsy01AnqkK
	4DSFkpnoDTVv79hcFVYlEDmdi3u+7DZ74YJGRKeo1/QXOZxECAOBW7Q54z5s=
X-Gm-Gg: AYBFou2lZIbEoD6pjRgnptGCtoN/RDWkbaN+gjb79yKGhcuUPAG2bpgRovaO7ycm9sK
	iQ0zzF4cCR9zlUiu23MWZGqB5F4OUR03Dh9UwOXyR1WSewwd8yq21e3ywyGko6a96KAPSJ4zr3c
	nTsx5tELFU0UNWiN7fi4aMddHbWk0wgVpammrc7hXfMpeo4yVRzdhS/1wn7hJtJPM+Xba/274Oz
	3W688pcx+0zo2NNnPK5KKC7TCS5v6K7NSKH+frNgnkcnAZZdTt9T1dBI9Q4y6FxI59XIPoTkbtN
	XoxXHpuXnH4MhIF46gXuFR50UfDapqmDLROJMK+IyQTyFH/3bAsgfB9fJ07bb1t8Ga6irZByOz7
	hS5PFnsEiGg47mHSDVP5oHE7OT8+0Z/2mkDCDn4ALvbvd+BX1ghkFTZChp4XN3olWmMeWRHv5BP
	VU1SPuF/fytqy0izDDbyZrKAlOrRx1NC5/C5icQ5SycVfzQksqjFCQsXAxpLPaww==
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr795085e0c.2.1794402184282;
        Wed, 11 Nov 2026 05:03:04 -0800 (PST)
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr795003e0c.2.1794402183114;
        Wed, 11 Nov 2026 05:03:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bafba6sm959941e87.62.2026.11.11.05.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:03:02 -0800 (PST)
Date: Wed, 11 Nov 2026 15:03:00 +0200
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
Subject: Re: [PATCH v7 1/5] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
Message-ID: <5pyhbuzlrk2pf3sct7zopoycvgliuvzzmd5qse65p3r63jarvo@g3clac2ao4xq>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX9yt/4aHUtOAr
 VHcNiEH8eOsx4l41RAAfgjH7YfPgBoq2QuPsqt56kFRfVgDQwXPasKqwAZHaGp3y2dSyzOSUgrX
 HD8uD6lejsu8+hFQD8l0SKSfQgI67KTwS8zt2K3WtVsuFSYp7An59t7LmwKTAWDcHIfR6XRKEce
 E/uFBcB6fYOnMRLMb2ZFRwo3IKObFTEY7r8fCUSJd+ASTx3rzRDwtPBqMFJA4YC/NBk0s3UXbGB
 mpHPLbCLcYoGkmsV9evvpw0KTGK7Yv5TZ8WEZJoV5OGyxPq27DIm7/mciMp5uq3O+1aqLk9S+lX
 /YREyV+4O1MZnu3bKfQ8Cm0JmsaS6BoJ4JZLznQKBIYW+Mq4RS66XPAsOkka7lGik3PnP7kKIFM
 5CW7/XiQXYP7HKOtBope+e4GeA8/9nGSRMnRRHl2z5iCaEJ+2YfU0g1aoUt59Uyvu4xzo38RqTv
 3m4OjDJpBCztxme+X5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX/GO2O3KBc0gq
 PIexORPTakHRhQNoHd4978WbyT5decEdER+tH+T8UoFRcPeIm8/dMS33knkCPMwf+TPeLeM2X99
 BuClmql7p0lUIgIVWRgUzYkzpc3BTfg=
X-Proofpoint-ORIG-GUID: Qr992K3ZBF2cKIpHyd0ZQFiW3sJcM90r
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af4678a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WA2_6xBGtpbLEjlkeFEA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: Qr992K3ZBF2cKIpHyd0ZQFiW3sJcM90r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:24PM +0530, Vikash Garodia wrote:
> The IOVA allocator tracks address ranges by page frame number (PFN).
> The highest node in its rbtree is a fixed anchor at PFN ~0UL, which is
> embedded in the DMA cookie. dma-iommu converts reserved regions to PFNs
> with iova_pfn(), which returns unsigned long. On x86-32 with PAE,
> addresses are 64-bit but unsigned long is 32-bit, so the upper bits of
> the PFN are lost.
> A reserved region that ends at the top of the address space then gets
> the anchor's PFN. reserve_iova() merges it into the anchor and lowers
> the anchor's pfn_lo. At teardown, free_iova_mem() no longer recognises
> the anchor and frees it to iova_cache, which corrupts the slab. PCI host
> bridge windows above 16TiB and the reservation after the last PCI DMA
> window hit the same problem.
> Compute the PFNs in u64. Skip ranges that start above the PFN space and
> clamp the end one PFN below the anchor. The allocator never hands out
> those IOVAs, so nothing is lost. On 64-bit, PFNs never reach ~0UL, so
> nothing changes there.
> 
> Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
> Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
> Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-195658@kernel.org/
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
