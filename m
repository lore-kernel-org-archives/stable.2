Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170966;
	b=zrVJqV5sedECTBJUDPL/CAOHCSsoeFU7/mx/fUJy0ViTCd4juerBRjpeHcQ9cdYk8e9c
	 b9nxEn5m/AajsKRl3VGjFetIij8vJk5NHfe3Tuyh0QbZZGklpgMKPl+0eD9qs0vKcPYui
	 UtFZyLhG74uxGOHbiESjwwqEbp1P2s49a8EPb52NlacUHpajBqnoNmluS8kV+YiqMn4oH
	 zFq3q9x/t7v1GpZzqJMpCKwyhNJ0YBrzpU/aJ7QQLpoQL1vb5QqzakMyKV5H6v8TUGtT6
	 zs5xUx6Mx4UOFcCd1+tlgzD1yORYzLj6BBtRxgMLGwKWRbS2DLK2xlufJXUDzJu64lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170966;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Jja5CIRJx6p71jdLiDhzh91wfoRIZk+1zpGerhUQBKg=;
	b=fxTg3JW2R9fg/0AwzyjM3l/Jc+dkWxRtiOLBTzHF+QxAbKGighLTcB4S+7QIiPRufZo7
	 t9hEj/6+riv2U7SXseR8Rqg+IR/rD1zfq5sTiMe6UZYYL7eKW9tHii2IvyQ+DfbxHrnTN
	 kwbIOToRXFXjgFS2PxVAmjtpaJyw/8M5d7Z1giIizA2VH/BlDfvoSaPMjFI7vISGSzhPa
	 TVj+1DpXJFuDL9SPikjmPj2vyWs9m2f9bmX3ycIlcRjjqCFGRPeKX5BtcXlKbhnJE0rBU
	 I124KC9nrlPkdiMamJ0x+C+SM+ZYk9uXUo68OmCNcX3a2j+1rCQr+POQT3uixSF80pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C+qR4cbO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="X/eUO/Qe";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947A60A2619
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6947A60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C+qR4cbO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X/eUO/Qe
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fDtK3320735
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jja5CIRJx6p71jdLiDhzh91wfoRIZk+1zpGerhUQBKg=; b=C+qR4cbOm4AQtRHv
	WIj1hFUNtydcyAh4E1CrmnryhpUuL4AyJrq1xnJKCD2K62S4iyMHxToMBgBiF2VE
	cMKQyljlLBoe25qhVfiafS6dGtz/SQtxJWRGOjuUfWOKxQM3XHx3QiK9RysI2K3z
	QO9BprVVJg/N5c0uqMjnats955ePDVr0XgCwh3Y3P7W3WHRbNb9IcDQDR+bRtUVX
	BKTUChVxVby3MCDRP9D+MUatUAS3OeIS2weqGYVeDYo/UaU6DscWfhN7D5CAvqpQ
	FFhYETFkKQLF2oGFa6k6fl7NJPjptAbY3g4bILgNC+KKOQVlng+WbSE2cQxOI0Rh
	ccLXdw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2frhsb02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:36:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso1311033eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170954; x=1795775754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jja5CIRJx6p71jdLiDhzh91wfoRIZk+1zpGerhUQBKg=;
        b=X/eUO/Qe63RdSTPLS7pGhQz+I1mr8WKnLRiRP2FNn0/fQOgQnWvk547NiQf8ip2v+o
         2OWd+Blhx3F9qNZ7sve8BrQNpNEbsLU+DyKe26ts+FsTWVEu4jwwL2WYQJT3KD9HVoOK
         f/ss2L9p2l/M+L0mIFEb4RfN7Kywvan2zufDZSLgB6GEyH3ZKUcXafrllalHL/65V5TN
         qKaLaW7M07mhH21yT68Xdd7kveCx1kYdORScRUgt6eN8YbEfRA+fgNA1w8J/Z0EaPbXc
         IjQzvsjtFOa2EEiSxuo3Q2+F9UQNShiCv240I71l9ynm/kpja3yh7eRG8cLx81tkWVQg
         /mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170954; x=1795775754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jja5CIRJx6p71jdLiDhzh91wfoRIZk+1zpGerhUQBKg=;
        b=mIHKpTBAHFaJBfkrH2k5JMdjVMpWA0Qg5nzBA7012sCp/CmA+sVKNDu3s4BKWo9ZD+
         1B4CXCp1RNV+qKN6puu2BxIUyfAcE6v1cHhWKdQzWUnldVE02C8cRgj7GYhkg/RLUVe2
         Apn6Pfpdzp9IpNbj7fxFKtrUpGo0KjChiaJ2XQ23/88v7sPBWXDCkSUvuLj6GiNKPc6z
         V2rCXUHyOI6GFzVZGr+CsSenf8CggpL3hE9sLJnZyDIRjRUlmzgXexzE1uElcZ9irZnv
         W4BISB9w0cBtujAswLsKNNLCgXjeTXzswVA800aaJDkQEOZ7dfB7kUOHpaEnG8XyQYfF
         UH1Q==
X-Forwarded-Encrypted: i=1; AL+hErHIgranYe56Ajip3sdvXsFj6NLmh2E6+5z6a4MzEvou1zpPVAyYgQXvqlU3LYzFV4UZilNgNfE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PGhw+J9FKXq8DOVnlFF2CJ0Wi6nLVCMoijRyIgAe4FkqJKbA5
	WXHqvQzoCitNAAE33ITNREDXzxXB6zqY0Dlo12iRBpY/Hul2w6thi0R7yV3kcit0mAcr8P6spzL
	GmBofxTCKwT4F8xaCQ3lNoX5ir463gmO2M0iTnx5ORBkNB2fjVqFBNGDRkzo=
X-Gm-Gg: AYBFou2dDg/UrmxPfniWw7Zr6M63ToS/GGzS6+znltUVZ3JB0NKfVgK6mofLb0qSjpe
	zFrh73iB9FK+eRW9FH5zNvUSLsYrkMUFVqWjnGijgsfJrvd0oLdt1Fhv+K8KN1hnO6/DFRYRiAg
	SY/j7gUihvKxSJquiG9XlgeXLUmK5jBGFcxcHVxH92jNmKydsBfc3h1oVkTSLh1OV1EIVJDgYZH
	GVVJJCA2K/TocjuC+HtGimxj0m1SkQ9dnCusxxiaL+qHwFlXdkAz4aRGloDqk5KhXAbExYVawWN
	kQ93kR15+4byZOuBluNCzY7617P/ofk7HvNCFKZT8RalU9Al2xm3HQCJVtNPBZ+8TvafGWnHzvK
	hxUCHdEmPlURRqijJWejasLXAV/BM/IZ9NuXEz9cE/tgyExgG9BlurHiAwgGaTpuYfUZCbutThL
	DQpd22bhs4
X-Received: by 2002:a05:7022:f50f:b0:1ac:1022:b60c with SMTP id a92af1059eb24-1b5567b2091mr2086366c88.1.1795170953601;
        Fri, 20 Nov 2026 02:35:53 -0800 (PST)
X-Received: by 2002:a05:7022:f50f:b0:1ac:1022:b60c with SMTP id a92af1059eb24-1b5567b2091mr2086346c88.1.1795170953068;
        Fri, 20 Nov 2026 02:35:53 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:35:52 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:05:13 +0530
Subject: [PATCH v8 1/4] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
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
Message-Id: <20261120-add_iommu_ranges-v8-1-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=4536;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=FYE2mL+pZ5Z1CfQkgLuaMoSmZ66ItGzwlfYFBujy6n8=;
 b=WLCvoXP/7Vfbh6awPjv6raAWHYawo4b5pLRUUX7uVPAlECWCVMKQvpoW6AEbF6Hm2zyCDu7DU
 LNluQNoNeBJAST7P4pA6j6rBPw0mJ/JExYQhkjltmeKvmyAlZrCtoro
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX+fZrKtVGWPOB
 gTQMbKTMM2+rmtjdp9Fxbvzz94MbwY4fzR6U+QZTTBITPjvxWCXk4GUMngq6xaaC35FbPf9+m0z
 W1SBQ/b1LTbdcbN027K/tOaOGQFVL8I=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6b002295 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EEemQ_ogMLg0kHTv6E8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: V1qWtP30mikgo-hSxw7672NbJy_PjQjC
X-Proofpoint-ORIG-GUID: V1qWtP30mikgo-hSxw7672NbJy_PjQjC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX+8ZGLDerWFlE
 RuTMa78dUDMA3wAjzvi7NRNfln7Oj3ewWVGhF+kyNNYeavT0gfOthLDXxGe/phnaQOmK5lfWsRe
 AyIEU1sRCCAbEKGG3PJy20Ef0FP6QWMe5q7IR7NoX/oSis/msvVuFxpAevybbNDLFa1o7MqDCrL
 Hnm0hB1zRKgMZWJS07XX3B1LWmHRC8Qa4PXBKhLhnPgKsZOLIFogsAA1xJJ+QUar0jsTlvM3hUX
 SKbFCMNwXBRP1TDlip+cvvbZkWBmFW/svEKqP39xbgj6s2U1zMxTIaQ90i0pD67JBKZyPV38TOr
 Oo43DFxUiubVURrvtL01n8Aj7vRt+/nRfu51qEvqcZQtC7tYQq6ib8Q4/OJCVC5QxlId0otkBAG
 e167zfM5lGo4ssi0yVp2rujdnGIOeBGwjxZCRNyecrMaD/VJhKM7orzglgOx3HUcFP2gtuyZPBQ
 3/0fqy2Ka2uboOlfumA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200042

The IOVA allocator tracks address ranges by page frame number (PFN).
The highest node in its rbtree is a fixed anchor at PFN ~0UL, which is
embedded in the DMA cookie. dma-iommu converts reserved regions to PFNs
with iova_pfn(), which returns unsigned long. On x86-32 with PAE,
addresses are 64-bit but unsigned long is 32-bit, so the upper bits of
the PFN are lost.
A reserved region that ends at the top of the address space then gets
the anchor's PFN. reserve_iova() merges it into the anchor and lowers
the anchor's pfn_lo. At teardown, free_iova_mem() no longer recognises
the anchor and frees it to iova_cache, which corrupts the slab. PCI host
bridge windows above 16TiB and the reservation after the last PCI DMA
window hit the same problem.
Compute the PFNs in u64. Skip ranges that start above the PFN space and
clamp the end one PFN below the anchor. The allocator never hands out
those IOVAs, so nothing is lost. On 64-bit, PFNs never reach ~0UL, so
nothing changes there.

Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-195658@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b66e83cfbc5f195a46d286d376068fcc13148611..2ee30df470730fd03b5dc46b46e3eaba2df130d6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,21 +505,34 @@ static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
 	return res_a->res->start > res_b->res->start;
 }
 
+/*
+ * IOVA PFNs are unsigned long, and ~0UL is the rbtree anchor. On 32-bit
+ * with a 64-bit dma_addr_t, iova_pfn() would truncate the range. Compute
+ * the PFNs in u64 instead, skip a range that starts beyond the PFN space
+ * and clamp its end below the anchor. Such IOVAs cannot be allocated.
+ */
+static void iova_reserve_range(struct iova_domain *iovad, u64 start, u64 end)
+{
+	u64 lo = start >> iova_shift(iovad);
+	u64 hi = end >> iova_shift(iovad);
+
+	if (lo < ULONG_MAX)
+		reserve_iova(iovad, lo, min(hi, ULONG_MAX - 1));
+}
+
 static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
-	unsigned long lo, hi;
 	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
 			continue;
 
-		lo = iova_pfn(iovad, window->res->start - window->offset);
-		hi = iova_pfn(iovad, window->res->end - window->offset);
-		reserve_iova(iovad, lo, hi);
+		iova_reserve_range(iovad, window->res->start - window->offset,
+				   window->res->end - window->offset);
 	}
 
 	/* Get reserved DMA windows from host bridge */
@@ -528,9 +541,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 		end = window->res->start - window->offset;
 resv_iova:
 		if (end > start) {
-			lo = iova_pfn(iovad, start);
-			hi = iova_pfn(iovad, end);
-			reserve_iova(iovad, lo, hi);
+			iova_reserve_range(iovad, start, end);
 		} else if (end < start) {
 			/* DMA ranges should be non-overlapping */
 			dev_err(&dev->dev,
@@ -568,15 +579,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
 
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
-		unsigned long lo, hi;
-
 		/* We ARE the software that manages these! */
 		if (region->type == IOMMU_RESV_SW_MSI)
 			continue;
 
-		lo = iova_pfn(iovad, region->start);
-		hi = iova_pfn(iovad, region->start + region->length - 1);
-		reserve_iova(iovad, lo, hi);
+		iova_reserve_range(iovad, region->start,
+				   region->start + region->length - 1);
 
 		if (region->type == IOMMU_RESV_MSI)
 			ret = cookie_init_hw_msi_region(cookie, region->start,

-- 
2.34.1

