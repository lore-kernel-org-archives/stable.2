Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719804;
	b=GtF4c+eDnskuE3R34xr1PzrfDzdnJYGYhy7r3pcR3rabpftPygmiDJcAjOn+4yErCN68
	 aSY9bH6+FU5VEEzjyI4tGFg35CIl3ptMMVpCpncLFVL68ag3PYVGnU/rI/uAVSLLexzn0
	 9aAvS+Wuo+LR1trN5eSve1pLPKKlNY0Yc/sAbwhmCupXmcZvkym4qniSu5DOouVV//279
	 gs/Y8gD6nQFa8feBLENi34NOy44P41ANLvPnAXTUcGfyNPAtDl184goLfIxWCbGbx5/ta
	 3yGgxyIUpAQcHVRjuI9vJ77wDiLF4KM6uzb3OY6jPY5BPC3r7Nmc2ixSNeqrMN2SxqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719804;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bQd6RbHrwsL4u6rZZRuTUnC0+p84cIRZnk9NR9KOcck=;
	b=GP4TiM6I8nKXEjnBBaj6t+aDv3BIYT8d4MwrU9L31rcvQGemirHh9M1JNJIyuM4kyDRc
	 /41wAY6+4dfs7KuQDw0Nt0GyHRnWP+E7NSbf7cRbkGvG5xnCDiKpamdWyzEgS2woqDQTA
	 0mMxoNKd+iHG3ZSxMHEiicyFv4kCAFewd9wM9+BqkcbfsaaMEx7bulLcOyPvTfmVoqkIo
	 l0EbPO+WAjfuWp8DS2XzG/MFr9xff/8JdQ7wMGTqrREZR8s6dNtHmYounnrQjHihnZjdf
	 mSPkbQBbkIXZ3xQFMRQbrpwTMT9NimeWOpi6nfNgqzdSvU3ACEy990NN9lYdvwqNp6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aNNlCmxD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IFEJ38Vo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223D606A32F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4223D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aNNlCmxD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IFEJ38Vo
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9tJ62119615
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 15:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bQd6RbHrwsL4u6rZZRuTUnC0+p84cIRZnk9NR9KOcck=; b=aNNlCmxDnqe4aPYu
	rtBmbPcLtbN4aCtGfjN5/MYSGnRCuwwp0vmkykmCmFtud+3SvVgRUuinp6CJR6hV
	fhrGuI/5FiDv0VnLUzix+RaHBCCnaTDSXo2sPJNh/CThRuzHjZGI9AcpUMgM1V0i
	Qt4pKFFPWb7SmGmWRQ4YQhHy1XOywQz5w53ienYA9kBg4zKamaRoH+3FX039+TTY
	Q17eUtoCX8Dp8I+3HEV0lOrQA3jFbnDBPX8tIH3L8+ovNafD1uHyj3UfkSZnJaul
	qXwQnMN1sLPHKA1uDQxnzq0Yc68vbkIZja0eNL/XZlo/ii7SJlKS15K/E8EKMgPB
	Z1qTfg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2brcaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 15:30:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3692c5b061bso11613790eec.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793719803; x=1794324603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQd6RbHrwsL4u6rZZRuTUnC0+p84cIRZnk9NR9KOcck=;
        b=IFEJ38VoslMeKK8f4Xv/wADDBdu2TVrQSAEAQVHrut1/011vJ1bsZwryWUgwz61AzZ
         W3P2pjnD6efE3FZ8BzOevQXxqRY80aBaFKyBr0g1zTVLEU+PZ/Sj4W9AAIy/JHpZOkXT
         +ATFiVaMRy9c0GnYRn3Os2jC0Ps37AghldkkoGXw00TY1YuCADQiWYnRD8WvkfU9YRbH
         ObjQV07mErtlK8iFKlKkHR2mubsE/VNu7ex2q06wt/A/0vt0qdyT73Y2BKmfFZMlUjbe
         AXvw3eEqhWw+VGi3Ur3JGu/susEsImJUmNdcJx89JN5yfVmQ6/ijx85AjSEVbrp/5dMd
         woDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719803; x=1794324603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQd6RbHrwsL4u6rZZRuTUnC0+p84cIRZnk9NR9KOcck=;
        b=ckX8rcftR0nODUaNt8N/kxLg28ERlxr0w99u4TmoV886yRszQj3wOBhVWoLd5sx4r4
         Q4K0p6WRL/SLOhKnbXguipiEdIuOCzLYfnQcw73TxG4Hsrk0W9kceMgJMFYctrM3bgea
         TqVWRiJz48GkPX7Vc3X446BgMXIA0nKk09XUCz66JOsuH3LGZhbOhy5/4zBrN04J5VkP
         jA06FE3abvans1qNA9yPaS7LQalsVDun5jlqteswE5DlxXV6nZJgMSSGskBraZiSZvhg
         fEJRB19mu0PM1cHPc8JRz1LV34UD1sWFKTEARbQcLVV7UU7zoZXyDDAcvKt66a1M0tyY
         oN2w==
X-Forwarded-Encrypted: i=1; AKwUvBzqDiyq1ep4Ny/SEdtbk5gOVJbH1rkq11SIkW5CrMSGzz/48feM2NIrAWkLl18xh7PjqkKIWRI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oJpBNzP3BSuwKUBp0euhs/OsR7vXHStUdIOLmiqrYirWNWVqc
	C4mBObTYU7ETn13rh7NJKqEwrD8tJaRWBNRpT2x7SaEUlGu+hYDQ1qROGTkJPe3Kwx7uft+awlM
	CYpLsAV5RWscvkqfNSKkN+8xc8YuSsQYupDGVSEK3766sltl+W4QKt4+wu5Y=
X-Gm-Gg: AYBFou3Rcyl2cFWddAJ7fQUBGxgTkupm5cP3/2gs6Z8o2svjqWivggJKqIU6ozFMk4i
	TlJ2q9fk2Ka3CtP4+GIxFTdy02ZX3ua5K6gAgPtk4dkt0yQwp/ipU36Am2eBiSS13T42dYsd4+G
	9Oi+IPGw/B77erwoRBp9ZQj1h0U3vOj53pGev8b+RdOmGk6tE6znkgkYx79gAHrXeIPCwByLhZM
	g6TmL2XrkQTPiOO7J8pV2aFVnnSZR8Urvhbg2IcMWAMsbzQMc0G/NoTc0M9zSArCQ4OZeNGOBy7
	kt8zECP+axzuQXAIfvHP0sncdweSLG4LXl1Gfa8d47362mnSEBfF9PTZZW74pwS3+zMVW+qF+lo
	Cw+qEptxTXHNQR2BXz8dGtIureAQuOOJFCoKkLoQbRkbF/f0j5Y4ogHXE9yMwaWhgEmhsLitr7h
	F83lWXRNWV
X-Received: by 2002:a05:693c:8945:10b0:36a:3bba:2e07 with SMTP id 5a478bee46e88-36a423becbdmr19458239eec.26.1793719802467;
        Tue, 03 Nov 2026 07:30:02 -0800 (PST)
X-Received: by 2002:a05:693c:8945:10b0:36a:3bba:2e07 with SMTP id 5a478bee46e88-36a423becbdmr19458183eec.26.1793719801797;
        Tue, 03 Nov 2026 07:30:01 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm59888302eec.1.2026.11.03.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:30:01 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 20:59:32 +0530
Subject: [PATCH v6 1/2] iommu: use resource_size_t for reserved region
 length
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
Message-Id: <20261103-add_iommu_ranges-v6-1-361f3921a133@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
In-Reply-To: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793719787; l=6612;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=tSFE9SoXN0wScIhn8/Dk9gzsTRM3sDTSAdOwPZ2HB6U=;
 b=fnW6G+xnRTqfeHOBTeg5CXq/CFd+n0N+zTJFlHldOQncznfCF7Ziyf+kk3BZW3d8NhbSlDtRk
 fMxo80iX5XaAZmXD092WV1CD3l/BmQg4e4LDWm4RwAhYE9Z/w07aqA5
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfXxFUE3kZuhD0K
 enALhGzbHHcVJK4vdyt6mAEiA2eF06nCh0MR8CATV5ApuVoRGJnCS1zR/Hy7rk4NMtG56KI6F2j
 5IOxz4CYpx5KEFC3qOH64nVcVRTFGsI=
X-Authority-Analysis: v=2.4 cv=AKV9GsJK c=1 sm=1 tr=0 ts=6ae9fdfb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4yj0ZD1ENdkg75-yOzwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: H5YZKqqhhkjeelkvD3BZjzZCaQJ8sJA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX0E45X4tTkEKP
 l8hrN3+i6kq72D2OFU6wc71C7vVmSubriHoXVejmFru4NETzIoM7DcRqmxS954fbGjlD5RttZ/N
 fNvjp8KAKHRvPN9bZt8brCulaWSnVV2nyjTnU7BW1824s9O683LgMcUbtpxFYTB7ys6ZqKFodQZ
 Q1XRqdCa/dWDm1gYUDeV3C2nMU1jCfe5EMp+cS1677F12YpxMIMJT+9eCX1f4C+cR5+pvRt/29t
 dFT7jD/4NPolnpUSg544pzUhdyt3ySUk4e1Hck797hW2wTNwVc6ULZBv+bJVbwqcyDW70LPDY2G
 0f6q5OQAH38jVmsLWUpoJYUJVJPLFsZnrfGDZ+p5KYazV2OL5mwwEO+0iGh0bNPBKNF7Le++ta9
 ytVZUk3cWv95K6h7wemh7GU9Or+E7r0L2YfVyiLG7nh1/WyUSlG5a7D/bcBi+My6/DixS8LIlxC
 8nCY+yy9xoxE0RDdpIQ==
X-Proofpoint-GUID: H5YZKqqhhkjeelkvD3BZjzZCaQJ8sJA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030061

On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
region can be larger than 4GiB, but its length is stored as size_t,
which is only 32-bit there. The length gets truncated.
Use resource_size_t for the length so it matches the width of
phys_addr_t and holds the full size of the region.

Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/amd/iommu.c    | 2 +-
 drivers/iommu/intel/iommu.c  | 2 +-
 drivers/iommu/iommu.c        | 2 +-
 drivers/iommu/of_iommu.c     | 4 ++--
 drivers/iommu/virtio-iommu.c | 2 +-
 drivers/of/address.c         | 2 +-
 include/linux/iommu.h        | 4 ++--
 include/linux/of_address.h   | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec69b346d1af73241dfa51393b0851a..179e6c28afe6f86c233d9d7e64abb0870095e985 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3327,7 +3327,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
 	list_for_each_entry(entry, &pci_seg->unity_map, list) {
 		int type, prot = 0;
-		size_t length;
+		resource_size_t length;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e025245d4b42c4a9f765c67d708d4..70e210ca085ff52519376358a3e3b7a01619d7a8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3535,7 +3535,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 					  i, i_dev) {
 			struct iommu_resv_region *resv;
 			enum iommu_resv_type type;
-			size_t length;
+			resource_size_t length;
 
 			if (i_dev != device &&
 			    !is_downstream_to_pci_bridge(device, i_dev))
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcdc359d936234bb3f8631306c8786..18f3efb94043ace9f1f4abc7c6ac8974dc25b0c0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3010,7 +3010,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 EXPORT_SYMBOL(iommu_put_resv_regions);
 
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
-						  size_t length, int prot,
+						  resource_size_t length, int prot,
 						  enum iommu_resv_type type,
 						  gfp_t gfp)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a18bb60f6f3dfdba853b6e16dd2a8616f6a731c7..5c266511db78910d6fd221af5437cecff4931c22 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -170,7 +170,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 static enum iommu_resv_type __maybe_unused
 iommu_resv_region_get_type(struct device *dev,
 			   struct resource *phys,
-			   phys_addr_t start, size_t length)
+			   phys_addr_t start, resource_size_t length)
 {
 	phys_addr_t end = start + length - 1;
 
@@ -246,7 +246,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				struct iommu_resv_region *region;
 				enum iommu_resv_type type;
 				phys_addr_t iova;
-				size_t length;
+				resource_size_t length;
 
 				if (of_dma_is_coherent(dev->of_node))
 					prot |= IOMMU_CACHE;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f12227e69aedbc721cfd49cebde2ef..a37e713b0678a516a777436d616f0d3df54eae38 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -483,7 +483,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 			       struct virtio_iommu_probe_resv_mem *mem,
 			       size_t len)
 {
-	size_t size;
+	resource_size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
 	struct iommu_resv_region *region = NULL, *next;
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 499d37ceae210ac844eef853aeecbfabaaa5e138..f665432638a6d1cc1ebfc0d2356b813c8c584910 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -655,7 +655,7 @@ EXPORT_SYMBOL(of_translate_dma_address);
  * Returns a pointer to the cell immediately following the translated DMA region.
  */
 const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *prop,
-				      phys_addr_t *start, size_t *length)
+				      phys_addr_t *start, resource_size_t *length)
 {
 	struct device_node *parent __free(device_node) = __of_get_dma_parent(dev);
 	u64 address, size;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a3651419679316c5a20cdf049efeaba..1d8f9381a358ec2309503bfe2866f08a1f236b2b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -306,7 +306,7 @@ enum iommu_resv_type {
 struct iommu_resv_region {
 	struct list_head	list;
 	phys_addr_t		start;
-	size_t			length;
+	resource_size_t		length;
 	int			prot;
 	enum iommu_resv_type	type;
 	void (*free)(struct device *dev, struct iommu_resv_region *region);
@@ -968,7 +968,7 @@ extern void iommu_set_default_passthrough(bool cmd_line);
 extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
 extern struct iommu_resv_region *
-iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
+iommu_alloc_resv_region(phys_addr_t start, resource_size_t length, int prot,
 			enum iommu_resv_type type, gfp_t gfp);
 extern int iommu_get_group_resv_regions(struct iommu_group *group,
 					struct list_head *head);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 0cff9036539168b0cf2826ee34417738a4836ace..ae6d96c8c110adad966f2c1bad2cbefaf55e5c57 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -56,7 +56,7 @@ static inline int of_range_count(const struct of_range_parser *parser)
 extern u64 of_translate_dma_address(struct device_node *dev,
 				    const __be32 *in_addr);
 extern const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *addr,
-					     phys_addr_t *start, size_t *length);
+					     phys_addr_t *start, resource_size_t *length);
 
 #ifdef CONFIG_OF_ADDRESS
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);

-- 
2.34.1

