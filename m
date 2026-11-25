Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574968;
	b=HX32sXfXNHMNP/NS29qVwMVWXaBRZn01di1f2G7SufKbUr4SH+FU8B79UwpPYNZzg39K
	 YFCSvQP22+OQjLqcq/UGENugds0qGaj2SOUmuq9TmL8aD9GfrvPMIBA7JR+ogha17rwC5
	 tds9Fr42aHU5K6OVE3hXrWtFysNktEA7T/nq3rshYS9+7SXYmbaHSs3ZwDDTc01DnO+51
	 P8qAmGMO6xROt3rIh+XuB3nhdKO38mC93IrgNp9vvZyKy2NhEDgMWGHdjtgUpBJaGdNCN
	 YnM5sg4/S3IADdpwK7dq1AuDjUP+vG88UefxA376Aq7gSeN5MVLN82q4rvLndoataZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=almGU0M12O3V1h/XU8fpumV3vMxLnGqRFrnMScmHn+c=;
	b=t5PTH6Ty9OhnfYG8nhD0qf2fs1y+y3eYW3x5tVCfh+I+dcz5g5X7WTVsiGm84AXDS/Z2
	 xWBP+akexJyLeuDZcOTDEyFXXNBYEFR/E6lqLzV14sBitxwFv8lDqFJ1m21G7Hk7hndgF
	 qWopDSBnik2z9zDsCUMhA4rB0DVbT9Og9/nVyZFc3d5wV1dROaOjdiL13mG3DvH+X3eS3
	 lVujjMcgP6wvKGJCCQRWEPD2n1xz9CRl30Jq6Q+A7sT/XmWGLMSzqH6XnpGymYDxBd4tQ
	 +3NqqfXPLVz11jRC766sGUOl2BrAWqrMJC2gCEavPiNH2n+JfqKP6FiifGg/GoGSIEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QcUTFiwH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="KI/aIrVo";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E0606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 895E0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QcUTFiwH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KI/aIrVo
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2Ax9V2109417
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=almGU0M12O3V1h/XU8fpumV3
	vMxLnGqRFrnMScmHn+c=; b=QcUTFiwHsxIPWbmVGqKC6+D2A/CdxE+d5pgUT1ZP
	fSSH7rJFZ2aH2xxSBSwrsn07rqgeH0EvX5UeyHmAZIlN2zzs8keG4RE+IYJRE2SB
	LstqzaUeyiMKYGtuObjEIm3hJ2GfdX9NqYwtJ3wTVAAMZZoqs7t2JMHriPNnBWx9
	3oMAOHYHNSZkHOGiZgedgg79K7A7wP79ZrNf7ZsWXAZI9biEttUfhtXnlwcs3vyr
	AgxYOLXB3tMcAr+FIJWBpMfNSrVOdzZGqYwAlUuGnVsKLV9DpsUGU/Ry0Nqxl9pq
	513W3O9w9/NV32ye+jlCJo0IIVUp1H/0Z/9ABQ9W10/NBQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eyd9v9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:49:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386b8624cf7so155477eec.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795574966; x=1796179766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=almGU0M12O3V1h/XU8fpumV3vMxLnGqRFrnMScmHn+c=;
        b=KI/aIrVomJr6py3E2Rnd3EC98HKSmuINOiybgadLfuw1Qu/Kg7l/AtYFIFFpNWoCbn
         iY5U0CWd9IzB4dXFYwR3fIp1Nzs0ELWwLIHwsV0h8RdV9UIuIuYnf/uMR47vTR78gC5U
         80kRY+M+yOIWSrmw6gkmSMjiHrl+SRzY+xPadCmhWb8ptOJKQcn8DjSgNPQHhe6ybslQ
         11cW5B567IKmai3bHDL1+gqHtjmdfSZUBZB+oxZ1FDTvDKoDG56UsizLBsV8qFWR6/E/
         KPf8j4uf0/8zRb8vk0OI43Gd9xZPmGBReM7t2u23TOErVf4wYXr/W0yi/ujaifR/y1BP
         EtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795574966; x=1796179766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=almGU0M12O3V1h/XU8fpumV3vMxLnGqRFrnMScmHn+c=;
        b=qxqpxRRfNEwXrh+ww+emnL8i3U+bZju/iDuO1INBspKMsYlprj5y4fLWb4crt18kmc
         lDD/MPoA/U1fJhgIGLmXY83jc7wKnAbBrxjJb/TRKQ15IJYcs+hj/JPIxVkpYKiz9BBE
         qR1knH9DMNhKnIN3Jt81VnJP9/kfhz/rvY3KHtS041sjeneog1UgyYf1nEmVVIxkkKRn
         E744lLpZkAtpV+qGU1ovQZNGEJRf4GUE1q1iDFyyVMAP/CpFy5NlLIohG68dEphLZnBD
         ptbzftjRnkAGgJMGZ7D+5GDCfCfA5aTJyo07je/JIWggYTR2sAV+Y4ccnCiRSaVpQmYl
         eWAw==
X-Forwarded-Encrypted: i=1; AL+hErHgLhislDxWTeuaM1csPiN8aT3VmCrSkVvrYNEvb2DCaMkarMsNV/FE68f0nWSJLfQ/PEUy8Yc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pftNn7atg6SzKNfwwI91axP948h7j/m53xCE89Om4B2LdZgTw
	d8ZFIVF1G7DsbuymrUZXRxKBQFGRTLwmKzCeJv13d5IJwcxkAdFGualNWcr6dTj1blMUhqbhzfi
	WOAalSIqEWYI6SlysA5M4fJyvA1IrHlnZlmNtlXkDSKBzI/m0MrGGxnbn4Fw=
X-Gm-Gg: AZFdTZfd3CZJ09qa50JeewIdIlZRuO8pHf/O09GxgMAE83pprtdQA1+R3uSsM57z1nR
	u8jI+7/zU8WtWp2SH0VVYK0egO2OYujBwN2qJX4Nv6PzKcI/6+vTOd/jD3maa1qs9sbJWuvdiAh
	JC8QqxYRTlo9xT7xB/z8y+cYVC3mXp7/92BPWryY2yigTNwbWwI0nWdbH8Uk9ecqnpajYZBqBcH
	/V0x4UdhBTIh5NQXx1xAuzaESE324BTL4DtORPIZoAZjwmRlJb+3a2y+FkbMKhfifEIB/Aa6srK
	O6KsbYuEojXH9UYv8na3W31axrXt6+2BxISNMSUVgPOkFN6eCIaQphyEFBYbx3r2vCIQ8VogF5J
	lqLEOr8LfYRQ8YCmZKXrGRmMk0UkmVtzSJA8i9yBbUvJYcP/+lXJvfmQGbuQIxQJjx5iNllTxU2
	CpEqbWL44vbE11wSkcy++2xNo=
X-Received: by 2002:a05:701b:260e:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1b556900476mr18812725c88.36.1795574965853;
        Tue, 24 Nov 2026 18:49:25 -0800 (PST)
X-Received: by 2002:a05:701b:260e:b0:1a9:c52f:655c with SMTP id a92af1059eb24-1b556900476mr18812707c88.36.1795574965252;
        Tue, 24 Nov 2026 18:49:25 -0800 (PST)
Received: from hu-petche-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm37123698c88.2.2026.11.24.18.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 18:49:24 -0800 (PST)
Date: Tue, 24 Nov 2026 18:49:23 -0800
From: Peter Chen <peter.chen@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Jack Pham <jack.pham@oss.qualcomm.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: Re: [PATCH v2] iommu: Hold group references across bus_iommu_probe()
Message-ID: <awZMs6kWUvXnwXFL@hu-petche-lv.qualcomm.com>
References: <20261112110747.1903321-1-peter.chen@oss.qualcomm.com>
 <179520803625.1164516.5819106673711321760.b4-review@b4>
 <awU4DyS7irT1a-nu@hu-petche-lv.qualcomm.com>
 <20261124124933.GA8680@nvidia.com>
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
In-Reply-To: <20261124124933.GA8680@nvidia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxMCBTYWx0ZWRfX+axxcSybcp5e
 033ZUjtaL+gZ1eWG2IHiN9JlDwOIYBfwkZZW4ZOdEhSOEn9tP79OEk/TEv3JodmCGggZqhLROB2
 c9tyQocGoQ90bADO9nCWgnPrQopkFYo=
X-Proofpoint-ORIG-GUID: q7iv9_cjDNrkTLzVzSZU_a4DeA_2UPv_
X-Proofpoint-GUID: q7iv9_cjDNrkTLzVzSZU_a4DeA_2UPv_
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b064cb6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=DD7KCJoPEUaelk3Q9vEA:9 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxMCBTYWx0ZWRfXxRoB/MLgEI3v
 QC8GfCqz2dFkyk7/N5Ew/PF48X6LEzRMHtU88MGBIcaBmxlPszVwQBVaZS2cilW8AAtIOoE8p8x
 CCpBACXnXAyhhBGn8KpNM+ssusZac/xbfc111ZLoh7g83C1zMTc8ZQlp6bOu2jXzl2ei/ei4VNt
 DzgG7QMFd5HyuWyo8ZI52Llyl2tsBR/bkxVfazX9iJEepZWhN6h+wnlyQpUjTAMbQobQXE6UO5C
 ufsr2eYD5hoe2tUmSRLCVNTbVnQ+CN3tGWrW7r0xV7Zct5DOPJa2gotymcrkuZlScPs1Kmd22lW
 y0VUCKi5QQhcv8s9QiU68BoHAvuWdcliHFy5ZC2neuoEz4l8FoPf3DrEOHdVifZvx50/dMvFPDd
 3fuYZpbgTWvk+wOs784V1tuwRydsq3z1viP36Tu31Zixc3kua0U4G2W6buh+K/jhMlkiD8kFCNV
 GXf5LiN2+BuLzChrzLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250010

On 26-11-24 08:49:33, Jason Gunthorpe wrote:
> On Mon, Nov 23, 2026 at 11:09:03PM -0800, Peter Chen wrote:
> > The glue driver does what upstream dwc3-imx8mp.c does in
> > dwc3_imx8mp_probe():
> > 
> > 	of_platform_populate(node, NULL, NULL, dev);
> > 	pdev = of_find_device_by_node(dwc3_np);
> > 	dwc = platform_get_drvdata(pdev);
> > 	if (!dwc) {
> > 		/* core probe deferred, e.g. its SMMU is not there yet */
> > 		ret = -EPROBE_DEFER;
> > 		goto depopulate;	/* -> platform_device_unregister() */
> > 	}
> 
> That's not how EPROBE_DEFER is supposed to be handled :(
> 
> The driver core is already setup to reprobe the child driver later
> inside of_platform_populate()
> 
> Your issue is it is quite wrong to try to synchronously reach into a
> probed driver's like this from outside. Then when it fails tearing
> down the device means you defeat the natural EPROBE_DEFER.
> 
> This should be asynchronous, then you won't have ordering problems.
> 

Agreed.

> But OK, it is clear how you get into this situation.


Thanks. The iommu core can still see a device disappear during
bus_iommu_probe(), from glue drivers like the one above or from any
other removal, so I'd still like to fix the use-after-free in the
core.

> > 
> > Yes, the list head is on the stack, but group->entry is in the
> > shared group. "Is group->entry empty" is the de-dup flag that
> > __iommu_probe_device() tests and sets under group->mutex:
> > 
> > 	if (list_empty(&group->entry))
> > 		list_add_tail(&group->entry, group_list);
> 
> A small comment might help. The lock seems necessary
> 

Will do. In v3 I will:
 - add a comment in iommu_group_list_put() explaining that
   group->entry is the de-dup flag tested and set by
   __iommu_probe_device() under group->mutex, and that
   bus_iommu_probe() may run concurrently for other IOMMU instances;
 - add the real-world scenario (a parent populates a child whose probe
   defers on the IOMMU, then depopulates it) to the commit message.

Would you have more comments?

-- 

Thanks,
Peter Chen
