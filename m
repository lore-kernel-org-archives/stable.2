Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985325;
	b=ilO88TsHtMPIxPi8SOpqN89IC1tiQuyrOqbz4KWzD6OFYkCHSbvSU7S4j/pT7lkFOCkO
	 eWfezLk3WnPir0JIK2qkRzVIFM8fcUAavTGodNKVmuQo22I4dmk9iN0rpRTR3kPUzEgCu
	 xNvEOvHRmxSIjrWSZgn97cn9GdHM0Z1iHLKAW58dgUst4x6a5EekRmZdrWBSIarhMD81C
	 gJok6eLncQ2S60IHLR2U0lJKEvSxuy42oYOsq0TRefOeuDdnO9N4VkP6nKUvSDzCLGDJu
	 00P6cIZSVIWPg6w7qr19twF3XY/ddX4LESoUPZptCUNuWqr3952rTgILFRPzcCXDOKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
	b=c2q7ZNwKKVmMW9aBsqHKjbBpJrucB2Hz/ncu3B+ev+ddQ5vefGaHywra1V6D3+CfSa46
	 GDqs1jN15V0ylmHrc10/Pmo9n+AIdDrlDWmyNN8P3bPLI1f87bQsbIQ0YsfnaWEmHsUuV
	 y1JDj4kzfh1XGnNCjseJa/ImNVewxu4qI8JrmvT9Dg7ydkvo4kYzCgH2FgaBN9WCq6jUq
	 D3gf5Gk2blosmYNkDl+lSXs+8INk9DX9acR/3ys/y3mAAcFoFIpLGXdyopCUyLOlDE7nH
	 Z7MASg7RCSBGpHy4C83TLe8R9FW5/TUukqF5zOR3Tb+PKnSFGcQ70j/3dOgc4GYeBTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CWp3lA3Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZUaY7i0I;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF38606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AF38606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CWp3lA3Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZUaY7i0I
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F06Lx1122030
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 17:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=; b=CWp3lA3ZBUkp7Fol
	KBi1z85YbvC4Ff4EFM48+Xn7Eqdk9aEcyUzQ406xTDaux23vDyYkIz9jEPk0lJ5P
	rPBzMh/seGrgl5g/hIvVahi1yVqaEtvgeKZtxoIufjZahTCVsoxYE6C/Jqk3kf6s
	hwq7mJmRGNkliz3jREdoBRzAzZB62Gqr8L0ZKybwMSVYk7rYMUQdjBR856l3/qVK
	m1EgHrXjSJc5RNx4Basgl7U/GdAgv8OOnHUpjq2/ZxZh/h5wxKWcAHbn3HuIymHi
	1EdQ/D5TOfahmjntC+L1j+Csi+VS0Njjsbn/jbZozEPqs87nw0hibGDoMvLR2sA0
	NzLASw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9uusr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 17:15:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a3451ea93so1268094eec.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985323; x=1794590123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
        b=ZUaY7i0I3yQpXGP9Ty8PsHJxTMq3kbf4feyznEGpqEiuDMyGq9fSAOtTNCXTzbxkom
         EQwsBwMYkbYbceaxVvcWeP+/BZ3Q5jNhZyO18up617uRkWmrYWS1Kp6UM2UtXJA6dUVh
         lMNhm80iBnsGcK+XLgqox4YYms1JlGFcAjrPxLDkPZc3cfcBTFXngbHC65RYXSnVG9N+
         2xgEZQUJlwwJQdefkRhIBTjHO22iDfeXegPztdq1B8phoCFfchUBk6l3da/jwClderEo
         VZrc8TNaNy6PYUaiwssCq5fkyakU/m+EDQ+uDTjaf9QW9Wm/qppJSYq61qeNqvgZpg6o
         byGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985323; x=1794590123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
        b=zDSpd7CPO36N2n/VktzvVEIWT1g19gxURVn22lqmoBcLpA8IeagKNXcTBEbQYQNMM4
         osY/VtoPO6hnXc5IEfjhKjBLgLvSCUa0WTU/3yWJTQqfS7P4xz+E3HGW6F8bKnythEYA
         kcVqmSyuFa3Ss8aqA19ljSPkYS4kBHQfEZEP5xyzyf4IOBg6Rfbfr27FswJgLEILJb9e
         UKSutxH0SmuF3mj2KGKwd7N7csSm1g73Hb/q9qYP0BZ5fM+Vbgfmzu8e1gB9a2y2s0Pq
         ar/n58AgaCRs7emM/mxl8Rd4xQ3FnnDyO1w0sPAW3EYrMG2lXipjjt+/Bm/aOE4Yy8c2
         7GLg==
X-Forwarded-Encrypted: i=1; AL+hErE6EutCTtuOW2PmFbTdK60Uu+nK3qJfYGfiaSDCzq90WysEsNKsnJRFUsPDAI1/sycBR0kRHkM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TQUWxKofmw7KTqz6GjBf8c6I/cJMTSvcnh1mWL+JPqNSbg+eh
	ukAIFF3ebj2XRXRqdNKB9zjI6KQxJj2AdMWDRktnnRtQ1J9bJKvZLhfegfqCQTVAn9TPm93rV5B
	vtQKfNaz5dWo8rWFBIv3b+QciTFYU6/Ho8o0nli8MV4/mQqJuGx8VpngJSOs=
X-Gm-Gg: AYBFou19jQ/6UDj85VeZajhCpPAbQVRKvY9XMoxdg/4xSSuEOqh4u2ENF6SOOx0yxYp
	EY8PRRN9ny88nASDS/VBeU+D94XspmsR6Ll2UBGMSTTYq3tw0oDCH6fHE9yHoU21FpCYKGeL0LG
	Q4MNuK0DNu95t2TC8srGbRarbccmbqilPDCeDKf6M01vIS8pg6zTLuzj1Ezdai6cpC/hiWYRrMz
	CsDZMXUMfumuGh+tJo7QNaCmQpeX3FEzpWkzc5dYt4cctMNaic/5je1sKW0SEJo+ehQiwA+xJcB
	AH5Qn4pugNsvjuqTUM/8bLv0rpiEBy08uznE4zVKRXt2KKGWrPDY9C6y6GHbGlIWQwvBnKWpXND
	As01lmXbZiWDZeYI8v1DRMGrm7jIxp4P2dmdDbAI1JuN5WLUh3dNqIcsq9D6z6Fef/TRi4PvBob
	WsRnYr5PZD
X-Received: by 2002:a05:693c:600a:b0:36a:3186:b712 with SMTP id 5a478bee46e88-36f76023b26mr3971952eec.20.1793985321804;
        Fri, 06 Nov 2026 09:15:21 -0800 (PST)
X-Received: by 2002:a05:693c:600a:b0:36a:3186:b712 with SMTP id 5a478bee46e88-36f76023b26mr3971885eec.20.1793985320950;
        Fri, 06 Nov 2026 09:15:20 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:20 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:25 +0530
Subject: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
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
Message-Id: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=7235;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=llMLpfQId9UaG2rP5mXxqKjE8GpDMlcPgKGb0UPmgHI=;
 b=xOQtRH8sZwd0gtSU2fFskz28Dk4hc+HSvL1AZEsMm+mQ6tli2NY766/rhiLsr2TyCT8PTBDrr
 OAMPQHcGFXHDLPeeE1jhZGBbjPHAf+2djrReXZOQxJ/wO2HIwXTG48h
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXyhjSvj40T/QB
 mhkzY6xPnM1peHax3zvCDsrqXkP23nXnbnp621bb/SfluPbmFsU/vS5xMJwzua1JSaucvzv3v7A
 J2x6tshJsNClQBwHgnL6HiKybQhkqtw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXxZI0rK5TRiK5
 bohCYZGdZQXAqC728/VicchyoNyJwxxX+/vkzB1+91jKmo3yjNMfv6iJI5XR+Jqy3fw6vefNiUP
 /jkj3oyC1dlnphNbQ95R8fzbztAPQ/7eIDzJc+FiDjafXTZ6X2ERAjfU2TGLbbVDTZ8rr7vtwGu
 GDjLcAQMGc57pu5xaETIsQjokYz6qz4hPIOeMByCD2H+Jg97+E1vziL8yS5dHSXAnlVKj8MSzOZ
 w0GmnmmvcnupJ9+C7HpEJaLliUNIau+70VVqgtFVY/McHf4CyQH/hrFdDM6/0KinBuy3B8VM6d7
 uQwkR01YlIapRr1rGK0sBtMIj7PhKvsOt3j3+qhMsTMqOcr8keHmYjr7qoqIJxIwoTD5exv9mQG
 axOIJi4/K6h42EgIhxpsBcIzGZv9YzvJAnMQUIhkJrR4fhG51Za4VL1Aya5lyTv+SLleAenc1yP
 JbvlHAvwfSkW15J4HLg==
X-Proofpoint-ORIG-GUID: WxBIwiEHyQbl9xnJ1ExsQR7-HOFQcAI6
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aee0b2b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ljjM-8V9AhcL1OkpCucA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: WxBIwiEHyQbl9xnJ1ExsQR7-HOFQcAI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

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
 drivers/iommu/amd/iommu.c       | 2 +-
 drivers/iommu/intel/iommu.c     | 2 +-
 drivers/iommu/iommu.c           | 2 +-
 drivers/iommu/of_iommu.c        | 4 ++--
 drivers/iommu/virtio-iommu.c    | 2 +-
 drivers/of/address.c            | 2 +-
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 include/linux/iommu.h           | 4 ++--
 include/linux/of_address.h      | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

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
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f7addfbe1aab4f6fb662b8b2fa66bc02d98b5f03..9f508143505ad9e603af1730e811c30bd5edce16 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -164,7 +164,7 @@ vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
  */
 
 static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
-				      dma_addr_t start, size_t size)
+				      dma_addr_t start, resource_size_t size)
 {
 	struct rb_node *node = iommu->dma_list.rb_node;
 
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

