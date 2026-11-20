Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170946;
	b=JEsLyZp7ElRoLAFmlt7yHoyCkHaZTDbMd2pU9NC1WhUqCKTVMOlOtrpnvQpv+gpVKFOm
	 huXfEyCXt32PBGOFwcCV+nTs2d8zIoPYlzMkaAxJB/+AjcHvUGCpiGSOUTerV22RTym/d
	 X3SEy4vd7fBnXGz1ge87It1XXymbxdX5HrcZsEzIf54CSCF3Ab/2wfIP5zq/iOmetfw/F
	 jt58W4Xbwcyp9Sck4Asy0XFnkDMrkzNpXjLFca+OA+wNf+M3LsKW5usdvAOsFhd+n78pT
	 K+AjMd3UJ+0rZFzE4R1SKFZs88IzQLK+dMnGjbLVneMpX2rKXAXoMXoEsHJcAnOAiJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fGQE7qT4NXgldceTPPFhsj1qcpB7We7i0rIqTaL6aHQ=;
	b=4sOyH5MWg1/Twt2s3CLVXFd7YQNQLYWvb3EwWznjG3pjHCNslytEYCyYrt7fcb8xb01y
	 JfWbTIxnbRq8hT/wqT3BPaWwlUf13LuSFpxKpHcRYEinuZGPkoN4y6AinUHysvmhQwWIi
	 PQqsPifVLL8FfTlOGp4Hw1Q0UIm6a4YIuee/cX7VBjt/nnVt/3QUAg+m1dOX19ZsBbjnx
	 Z+jZbr2DlD4itZ6lm+yYRs1OJb4lABYqYLkvMXQ/cn7Oejxp57X3raRnA8I55XqhMIjBZ
	 8Jq97fsW+nxvn39UUZ5e5W3U9sMh+Sz5UPsgwogDsndC3uF1c7kzkGWdKI8kWy2BoEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BCK4V0A1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QfG427G3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC667606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC667606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BCK4V0A1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QfG427G3
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7esM62019478
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fGQE7qT4NXgldceTPPFhsj
	1qcpB7We7i0rIqTaL6aHQ=; b=BCK4V0A1dKIG8oniMCufQ1infKALXo/PQJemoT
	MJvZQwPR7cvXGPSepenf7gdgxqjzvAZcuyX5nYzZ+Be/mlbPbXZl+kvRSc0TheOn
	BxnBN/65T/OxkfKYb9xPIj7pTrwFoNQpNHNP9VWUmk2tL8MBdL1V9icx+vDouEWp
	adb+dZGXs8qvJC+W2jeMjLsvkWMBrdWcNXM2R7vdh21HqfS1GfUVZJgBqdQCguvU
	QRYDfhJnmWNMxicPHn2ty8gpA2CDoUuIvB4c9Tm3nDH7CUIPH0w3TDvFjcRcsph0
	MDyJgWkz36cAb/u26inxtbJHYnEo7+Hjt24Qw/dsvTmubBfw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjj9b7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:35:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-383ec96a7deso816075eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170944; x=1795775744; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fGQE7qT4NXgldceTPPFhsj1qcpB7We7i0rIqTaL6aHQ=;
        b=QfG427G3EXitR3leuMcYAjtS2Xz63V5dMSQKTdOntoFnZADrarsLsZF3X43xAMCiRa
         UyD4kKQEzUTrTc3TOORdnCR5WQl3Wxax/6DnIJpMjlChydtVACCm0ZkTCc8AP2ygDpoG
         si+Nao/rdKKNfYGwoo9quMFh7BoNiCQgKndN8lc71sz053Oj6DxSakl/dwESN4HqxYxr
         I8ENBfty4agjzy0KhFv0fjIQ+KK/gnKnhK/thqhA5+wbM97czTb9Xa6WzVz3iCim71yN
         denw1oG1p3ntPmdb904BuWuOW/axjK8fOptgYsQRIYGKSYgHxrnSOHbBU0c3bLZ+iGMb
         RHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170944; x=1795775744;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fGQE7qT4NXgldceTPPFhsj1qcpB7We7i0rIqTaL6aHQ=;
        b=F2ApS4RW93QbGcswkRuJAbQXX5yURhoiN8QM8zwHD/Oy+3ZrY+hzaxif5hxhxV7pUr
         9VDLkj5EgZfed1C3Q8pyP6YEZmfgeiABzB218UnubMNj1/G0BfjsnB/xCl84iW1E00mx
         c3ssZNnAeSWsLC5INfZ0WTtzTHhNu6xS3th6/hb2QQ2Xo8jWiO24a7SxO1zdbBJqyeUH
         QiZCsTN6mOHPRiWFMpVZOAbLhoMaifmpGp2E/5kMIPI/KPmOkQWLHqiwq3P3PEU22ym1
         cwlBOSk9azYrt7LnC17NphpEFGcB0uTZYN7eREqEj/zy49saXqMI212xk6Oej3oJMbZE
         kFGw==
X-Forwarded-Encrypted: i=1; AL+hErFrxURn2bmkDCDfAjW8+7LEO65e04EPnXzTAYzi6jJV5by8EB7ov7d8T7wEjrpski69Djt3qzE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h8C9ep/zTwQppocxxnYsDX1pHUx3m6TuomD3GC9Ow8XOrDAlF
	L3uNIVMuecVY2bu1sm3GML84sjuuYDMx0TtImR6iPZlCRJz3PH1Pogq/E6ZPwyKtINwGaP5ds7P
	m/15wEyp6e3KEaiDCV8bbgFsKcSOIuxawkHjqr8JBSsqc7GvC3HzS7iDvCek=
X-Gm-Gg: AYBFou0v7s9swIPMRU+M13dfRirs3BztkhQm8Bh60gisFrhKDBar+b2fuokLcu5He34
	p2Y2NBLK8Xaw1haeYz9bn1R/SoHMotyih6tb5DmIRzVbHgapmwh0qa0+d1nYcZ8hP9Fmehe6PzY
	9N1Mn2DOGw3xjqfEVX2obABHTYC83QIEr+bsVy9hXj54yeFu8aCtTjnhzRLnFmM8YX/RbdaGN1F
	GDv+tumAAGKGyhpN+v7LkmmrYt13M7HFkkGc6U3Rg5Z8k0odsQmQnO10QMj3GXPVyPB/to2VnAa
	KHbnAAXk3wInzRbAPsql2KPfuXnSkpW08MSq3JNWMj9tjN44vX7ODU8/OCLLYG0ts6MLlIDgJEh
	YiT9wYYkVhsigFiH2R5B2C0O5Ss7qRfZaRWXceZAl5+3/tbPhXlRuFhQQc3w8DMQ4v1+WFckx0H
	ryd5JQVdCg
X-Received: by 2002:a05:7022:6988:b0:156:6676:d0e2 with SMTP id a92af1059eb24-1b55689f5dbmr3186123c88.10.1795170944382;
        Fri, 20 Nov 2026 02:35:44 -0800 (PST)
X-Received: by 2002:a05:7022:6988:b0:156:6676:d0e2 with SMTP id a92af1059eb24-1b55689f5dbmr3186082c88.10.1795170943867;
        Fri, 20 Nov 2026 02:35:43 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:35:43 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v8 0/4] of_iommu: add support for "iommu-ranges"
Date: Fri, 20 Nov 2026 16:05:12 +0530
Message-Id: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGAiAGsC/33NSw6CMBAG4KuYWVvSh7TgynsYQ2ppZRKh2kqjI
 dzdwsoFcTPJP49vJog2oI1w3E0QbMKIfsih2u/AdHq4WYJtzsApl4xRQXTbNuj7fmzCMo6kPNT
 GCXellVSQzx7BOnyv5PmSc4fx5cNn/ZDk0v2DJUkoEZI5UXOmmRAnH2PxHPXd5LUiF1jMpH4du
 eGo7JSGOsVpJWzJN5x5nr9LrzL8/wAAAA==
X-Change-ID: 20261103-add_iommu_ranges-549cf3fb0867
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=3521;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=GzIgwPcWsEdtE1R5dZ2OEfKuPBvzYazXDg9uDLXcGpk=;
 b=sAZIyYEFMPxc/mKwyM+anhz4daQoxanD7OvyvyY9sxfkh769HMHL94xBo7DLUmcOBPF1ICV4I
 Dc/pfA2MwZNACkbu6kNRYiyo8oaXW1RwkH5NV5lp7Ze0wyP781gadTQ
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b002281 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=18qFwLbqBIf2JpEd1ngA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX72dSCr2ZFSvo
 tnUh4DhxSBuZcJb6/C/LgYBr45tzCrFsXc0jEfglFzUxZTd8O0JCKDPF5kLxj7uGCZpZHYX11h9
 4EVbgsFOwLeXEOzc1JZaRdTvP7/5LYA=
X-Proofpoint-ORIG-GUID: pUKREndJhfrglfr98HFQIuBvZWIwJKhe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX6HyYn3eqRqqK
 1yipgNoHV/68/QKmwNnHbntswrxJTBO2Ybb45aJ+4RLtlZzebnjerDTx/NSgWiPl1IzV158IVpx
 Q7HCGO7FggFVhGqEGo0NL99WepPVuY0j1bpTx1aC9AlXf4vv7+Sxm3GNURR3kZJDkQNvVm+Vz3b
 LdRlilwK9OrRWSrVdOXewZuvvkYSjUDs+52BzSXEdZMA2YR3kmj+/MSDxuWmSuavYTFRr0UIeT1
 cn/BxjAw6SaZeRGjKxW/8HWMeA0H2Bn6uCKt/DrrbSb1l9uE+VgDsPu83TkoemnXQktgeZglplc
 vQ26RZtT3sU75nEXinSTiGrogTawXFmryyHRG+PTthD+lJBmJ5MLMpKOxSdFdEdTQR7KcXqi1Jf
 uAxD7CiWYPxm0kqcARqHceaWMrXOSrXvXdhxXV8Sc9ij4/AYrjaYDDJJc44m7R/u5+gqwGXHP33
 2Z0lMJBjGsl8Mig+U5Q==
X-Proofpoint-GUID: pUKREndJhfrglfr98HFQIuBvZWIwJKhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200042

The series adds support for recently introduced property 
"iommu-ranges". It adds the required checks to error out for cases 
which are not following the schema definition.

Iommu-ranges was defined in schema with this PR
https://github.com/devicetree-org/dt-schema/pull/207

These changes are required for following clients
DCP display controller
https://lore.kernel.org/all/20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com

fastrpc
https://lore.kernel.org/all/20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com

Iris video
https://lore.kernel.org/all/20261103-vpu_iommu_iova_handling-v6-0-e4b6ad864f8f@oss.qualcomm.com

This patch series is being posted as revision v6 onwards, since the 
patches were initially part of the media series [1]. The patches were
moved out to get review comments from iommu reviewers, which was 
otherwise looking as a media series. Happy to move this back to media 
series if anyone have any concerns. 
[1] 
https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com

Dear IOMMU maintainers,

If there are no review comments, could you kindly apply the patches to a 
tree and share an immutable tag. Other media patches can proceed with 
that tag. Otherwise, if you prefer to have any other approach, kindly 
suggest.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v8:
- Drop patch#4 to avoid ABI break (Krzysztof)
- Update commit description for #3 (Dmitry)
- Link to v7: https://lore.kernel.org/r/20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com

Changes in v7:
- Move the "iommu-addresses" behaviour change ("reg" required, non-direct
  mappings rejected) into its own patch before the iommu-ranges patch (Bryan)
- Make OF_IOMMU depend on OF_ADDRESS and drop the #if guards (Rob)
- Use resource_size_t for the size in vfio_find_dma() (Sashiko)
- End the derived trailing reserved region at PHYS_ADDR_MAX - 1 to avoid
  overflow (Sashiko)
- Add a dma-iommu fix to protect the IOVA rbtree anchor on 32-bit with
  64-bit dma_addr_t (Sashiko)
- Use the "iommu/of:" prefix and fix the subject case
- Link to v6: https://lore.kernel.org/r/20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com

Changes in v6:
- Addressed sashiko comments.
- Addressed comment from Bryan.
- Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

---
Vikash Garodia (4):
      iommu/dma: Keep reserved regions below the IOVA rbtree anchor
      iommu: Use resource_size_t for reserved region length
      iommu/of: Make OF_IOMMU depend on OF_ADDRESS
      iommu/of: Add support for "iommu-ranges" on a device node

 drivers/iommu/Kconfig           |   2 +-
 drivers/iommu/amd/iommu.c       |   2 +-
 drivers/iommu/dma-iommu.c       |  32 ++++++-----
 drivers/iommu/intel/iommu.c     |   2 +-
 drivers/iommu/iommu.c           |   2 +-
 drivers/iommu/of_iommu.c        | 115 ++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/virtio-iommu.c    |   2 +-
 drivers/of/address.c            |   2 +-
 drivers/vfio/vfio_iommu_type1.c |   2 +-
 include/linux/iommu.h           |   4 +-
 include/linux/of_address.h      |   2 +-
 11 files changed, 140 insertions(+), 27 deletions(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261103-add_iommu_ranges-549cf3fb0867

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

