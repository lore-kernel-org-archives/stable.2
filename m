Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402156;
	b=WycHrt+BWXULBurBqZyUAHRBTSpGcnVe0B/nTMsofc0EGs7XpXW1LXhZ0EWaZzHNVc4M
	 q8Y/bm6+7uTUwVLozObpECaRZwo41IAKPWmwrV/qlL7xETNnouQSZ8y1ADuUzOGGGlhdl
	 W3+Xo0KxQH88XAw87Qn10PscoqqZMq39+cN+z64/QWZKCxPNwOHYlzAjPsmjFUm6XS+re
	 JLtzfI6iL3xxZhEkSn4Iv9hKRS2SRHr261/TKFIvFl+AbGMEmA9smoBC+zFeELb29F6X0
	 u5t/5Y0XD0JIZLABD9BH9mKxzKw+T4ldRa8zVJlJPV+YPBNqrwnHrbRGkOh3wPoMqAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402156;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
	b=OmZqj/heR6q41TrxSvw9tRlM4YeGHUyHsmAiwb+HbOIB2NDr/OnXD/DK+yLVy3DIVytT
	 70asUtmtdCXrchj59R2RYyIV3HeWpgUwLTnmfyTl6/WthIcjN2jJRulxBQkLleIaMxjgA
	 zbbxEk1pvcKX8/T1p4lkXPy9WW7ZJBDwZmOcWEkxuxWUl9SYcHV//LwApqS2948uYxhOr
	 ZVBUT6sxXsjDDyx9eIQxvQEZwnYE/aEzJqLq7gsEf255lKuXWFc2qod6djCk1fwF3BviV
	 5ZZaxxZ7H8/InSxjjNzOFZWZ9khXLaMVwYvVz5zuYCBg5f+qWtwhxXN6dFWCCgGLUgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMYvY7ez;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bZuShfxc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4221606A88B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4221606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMYvY7ez;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bZuShfxc
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ3W82356788
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gL7PRluqOkzpLiN/UK7bTD43
	fl5T1IxvJlK3ZPRyK2w=; b=EMYvY7ezmzJ0k40Xt1ZuHaDmzZ3tilOwId0a9hlK
	AQFxTU37UV7LI9UXhgIZXO+CS4P1RpIm31tkGUjuTadL6oV/3qq5WgSSD226R9jq
	qbuJpilJYMz5hu+B4t0TpR9eAGf0kyGl6OxeDSpq33jzWKKYVKt79BbIX4u1X0qP
	cJm3uxvBWcuaQzBZtQiXE3DtrPa7XqBEy1P3zNquohvHnQRdxZEtl8aP4O8ghzH7
	uRH0iP7kni+J5wq4twsVr3vu5IRzq71lqawbB3iNG2K8r+T+a3vPWopy/oXK/jEt
	GJr5A2ke5Kkqx9r8eJKJwPyt0NYJlJ0rwoN4LJOSqulQGQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdhwrj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:02:34 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ecc172164aso2313407e0c.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402154; x=1795006954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
        b=bZuShfxcAnDXihKmV6NZOlW0JhFuxnBRGMS16+chGl/HRrzhkJEmqP4uO6T+uoCh92
         /48tV2jeBN8k2MV/S0n+e8Vp5JuYVS5JGCi3niBhahbKeZcKPVojNv8P3mLOrAZ4X08v
         yuhok4t95QqzPG4PhjQG1hs38oAJK+/9H3InmTxdFC45vlHkeEQ1KvwilLoUZFYGLv71
         AU2dfI6zSA/ANkB1GlzglY93eTm2w90k8B5Zi8BR1GCYOq/o1wB3grtMiVFoHpkrbPNn
         kyITVPwCXx0rQxZegCLHq8bJpQ/ivNKdj9snwFil3xbG8OWnBlmkjHvHvQcvu80mgt9Y
         J2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402154; x=1795006954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
        b=z6Cr9X/04+G/qda7xfoyYmfojUBUwHf2PpCDZxWx8nFhaIVZQDTNSaZ9YlBfKJNVAz
         hNd/8YSvLobV7DIZfWkRQOmtvJAEP2psFyIS/9qfv85VUtvu/osLxOfKBFhpDuuJpD8S
         dedTytJ6ireRGFBk5mbS4LtUztNM2fWCwmhCJTt/GFfPk/KlXaNi7GWPRwrbWMteBUSG
         V5W09P1yBONrB5QMncuICjrnf7k34XDsia4Wt75B7KX4lPjR3yapBdZKnHWFmiJ+Iv/b
         pY8Zk3ZFCfq5q6Wh7qj0dWjAVXIvbgta5aKLAlOehcA294pDkzW34Qb2iSj0ZDZYjkGn
         ir5A==
X-Forwarded-Encrypted: i=1; AL+hErHDL2dw/2JMPpiVtF/cWuJQ3XrjgXTDMJWew9FKiezPZqgEmszi/BXHdFA9FdPZBl9SNQ+HSJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WrWV+FDqPH538mUMLF1RObmJclzJX2Y2/vDz+dN1rysii4fci
	XqmU32EAhJ3BQlDKXxsAtKeiPqDOAReT4IiHxdRhL+moIH0/RnxfdGtD8JSuel1IEX68dj/dbVP
	ZdEonv/Ip8isdfeyvKwi1M0BaAHXsPX0fj9LAJwLAzAfbSIXA7ehlFRkNl5Y=
X-Gm-Gg: AYBFou302MOu8J6PJK5YOPQ5IfJKayljRPkxn92pcF8psB5O2G7v13Ak1nWndDQlZVq
	+b75SAcj0gUhRQ/URZux6SLyQgxQpqs2q/boHRD0AouirD/hv1dss+h7J9ZEaalfjLe2NrXCqrU
	fAuOVxCHaM5Z35dTJ6ZI6x/oC4SIWLHvPGkSE5zyTbJRE+mxwrUDD+J0A1jVUQFPDUvoiQQ7oPr
	OLtMpnfX7WfWzlCCa4JTt3LvL75ZvagKhBDL4Y5yKtPziSAjEWwJOEuhDTZMRX3N4CG9qScz41M
	MekBl44TUu0rvtE3IeMxH+ILMmVWmMJzyPOP/D/y0D8nms7uUwXGJCCVLemAKfu2xmBVZ+OIH9f
	UAjn9y4C8PGoeV5rkDju9FmvqPaJSoDj0KweXUt+V9NXLA0tgAGfPnHfqz+r4TwUsrF6+CUiOZU
	Rj+vFmBDia2Dqp4q8GNj+8weWM80siyb0LYfq+ugrgMpPT2MJj+Xb5JJES8EC+zg==
X-Received: by 2002:a05:6122:e248:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ee1c292c8bmr762393e0c.2.1794402153816;
        Wed, 11 Nov 2026 05:02:33 -0800 (PST)
X-Received: by 2002:a05:6122:e248:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ee1c292c8bmr762282e0c.2.1794402153278;
        Wed, 11 Nov 2026 05:02:33 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157baba35sm933313e87.46.2026.11.11.05.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:02:32 -0800 (PST)
Date: Wed, 11 Nov 2026 15:02:30 +0200
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
Subject: Re: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
 length
Message-ID: <hn7dczsvgtq6siyikoaf6y5stlacmdyq53eg4mhyonugjhujlp@7k4cxflzuu56>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af4676b cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EE9pRYFAw_fItPXnlVYA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: YjfuJnlDStJLXP7gd1X8kzWyg16-fz9h
X-Proofpoint-GUID: YjfuJnlDStJLXP7gd1X8kzWyg16-fz9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXw0XbnL23PZlf
 cxJfr9NlZCyztTUg3f9V1oYpLNfWE56FlfcMpQMg1ng9rBJbGSJgPy6hmymFY0UNSxKQa5yOK+q
 A1doHrBHMeJSE7aP/lK3bw7ibhiO5LMiL1B+h3a9RQQJ/BcOYVyWq9oIyTbZ0p/6EAqka1S4abF
 FrGsxfXVrA+iAWDZeGbfjZZCjd7o5POGmWhVwDjGnusjIoFouXRENSW4Qx/cbKzA+nsiLLHynWh
 kdQcg2XiSUfXcqretaHu5AWP5Ic160ZMV2/A7y0k/qVH3ySZ16Gye8tIkT0QZb/IFHwvLU2rseo
 QFg+tNx2kQr0GwUWFJ/S1w/Q5u6E9yvXfiN3p0iLbHSEr8DxL5Ejkkc7MBG0Ud1CMSoqztHYKbf
 P9RNT8eVPmJn1HJhn20O0JwDcw+oBHz5ineGxfkDf0atI50BtkpjIMdN+gGwx1wEGlP+mEYrTFY
 D/p8evvbm6MmEBZakfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX3v8zznGceXjy
 ek4o2vEkdhEBG8xjO7QyHZNUVW4ZWeFtKyVJlCYWAf5FzRb42gKjoxU2FIArY6yMnTt6RPBg1pl
 hySyVNNez7Ha5Ock2YK+C+I0aK27zkg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:25PM +0530, Vikash Garodia wrote:
> On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
> region can be larger than 4GiB, but its length is stored as size_t,
> which is only 32-bit there. The length gets truncated.
> Use resource_size_t for the length so it matches the width of
> phys_addr_t and holds the full size of the region.
> 
> Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/amd/iommu.c       | 2 +-
>  drivers/iommu/intel/iommu.c     | 2 +-
>  drivers/iommu/iommu.c           | 2 +-
>  drivers/iommu/of_iommu.c        | 4 ++--
>  drivers/iommu/virtio-iommu.c    | 2 +-
>  drivers/of/address.c            | 2 +-
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  include/linux/iommu.h           | 4 ++--
>  include/linux/of_address.h      | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
> 

Thanks!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
