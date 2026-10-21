Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598812;
	b=qlt0+v9DmXJS51voFLpMCp2QIvhNmYfCX2if5kYyvHrLmtsVrmbay7PiwU1WEsJcyNsp
	 X0aalEQCCrfSJT7e5xBP/YH2/bJod2t8A+/71x+p8e0cp22nHI31DICg1BEexwDLP7oDc
	 vtuER7F76dA/KCLcUkrr6papQDF3hyZ2BYGmTYLgZfdlo1hzZprnrWuvOEGeFPsuBsebp
	 smWf4qckOUk5p43OUSV6+NWqn0TESpoK3z0OoEWXbq0D4C4RJo6i9eoJbII/3RVdageUH
	 I2csmfQm+NCN+Mk+XOCVlCpMQ5evhsyjAahgdgOY0dOtNNGiqvZMNSSIxkfQJ9odDYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598812;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gpE25St1i/xZOuhawVT7ICtbXM/ic5RoVfPLMlzSuzQ=;
	b=4cGcuLfJYeJ28KAHNwHVajnAJBRz6rZOefgWTxtzSfDXDCn8LhYzZ/v1xuv/hajSasRK
	 xXYNisvrjrX9jEBbgl/qiQLDaQdutglf5bxGXTnacqSIHJo/yEcK5njsnjzufkT2KqPDE
	 Ro5nvtYF3I1iVkotHxM9RyuMqEhdyrPOFmdbwcYmnEXoa3PLXku0bTy5Nz4VPXrFwqv9f
	 yqDcTvwExYCw/LZhkaxtKofZFE3omYdMp+dXEl/0pJXUw/9ylI5ufdvYpdUsj9gSiVV3u
	 6D7h8F6VkDUU9VJuCTTsc7LCTRbYK1aAXOGrrPE+wrdinPK22AxO7EGNO7+40KLhCNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jtY6dLNs;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC86606A31F;
	Wed, 21 Oct 2026 16:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AC86606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jtY6dLNs
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFiRXj1512327;
	Wed, 21 Oct 2026 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gpE25St1i/xZOuhawVT7ICtbXM/ic5RoVfPLMlzSu
	zQ=; b=jtY6dLNstfbM0tlk+dKvZkOjheDW+jQqLN9U39iMXiI3WmHFJZl74fsUK
	z9nHzL+LXu/FaVDTgNies8BYl+IoDC1a+zTq1cR1l57glAnOixZecoXSRLj4nvNF
	7Oroi4EymJ/SukZTlXcwM+aDZyoJG1SBcrZo7UnK2AWJ+bJZW3/lInkZiOeul0uX
	+LHKwbsy99fBJCSdmOpL683SXKIkoZDQysO7rDyrYwx/HVTRWuiRhptJZnMLNA31
	y96XBvoHVGbWH9GX+P8ZxFCxD7EixX2yv8Byr0CqSA9rv6TguEICo3fzHyq0D5tl
	Gd0Ypej1A1l26elxVfu3UnXWaJO5g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5asw2w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 16:06:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFZ7mM3303173;
	Wed, 21 Oct 2026 16:06:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gqe6t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 16:06:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LG6eo120054562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 16:06:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA3875805E;
	Wed, 21 Oct 2026 16:06:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D2DA5805C;
	Wed, 21 Oct 2026 16:06:39 +0000 (GMT)
Received: from ltcrain119-lp4.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 16:06:39 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V3] xhci: Reset TI USB controller on xhci shutdown
Date: Wed, 21 Oct 2026 12:06:08 -0400
Message-ID: <20261021160608.8229-1-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ad8e312 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=9wCiUMfqzSii4dk5dp8A:9
X-Proofpoint-ORIG-GUID: yxxYF-TaDNKJ4Z1p7vqlYTSrO6wSyw6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MiBTYWx0ZWRfX5CWR9Fkp/cuC
 qu4GlT6ctfw2+wMrAVOeliDhTgUdIUzpD07LaNHRd/DJoBi7P17K1VEy8uQ9AD6xpiA4ky35iUx
 yW84WkfReYfRfZ5y25WcnZfh7tS33wmtQ2PzOOTjS3oAgKC4lMaRiIYlK7OhtWqTA/08r1RWWYQ
 tjP4UWYQRJ3FgOCnvAruUZ18bzGgAVQyVtFks5lFSOIQT+Bp5cY6ln779z08jXBSDKcfrtYAEQt
 YsXbjnYm89jjn1tfZBAP8GijvkuCuE8A/iUCM2PLKAIgJknUhpowiapYZ6IdzHHYuyVyeuS/Sba
 kojNYYjzwjtNwywGK8auomC4vrA3tD5tjgo0OW6d1BA72eKJ75l/2MpWCb2s4OjNiMmRBUPoZ+H
 Ws/aRuhLnUxc1o4y3YcDOqUb2MU23h+TkG1g+C/EDrhbbdhcIb6KVFgaZIAzyF3tQeM6SwKfJDr
 iaK9BYP1NMwCVE9sisw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MiBTYWx0ZWRfX5vhTtc432iVQ
 UceZHrR8WoE0vDvsbEiftPSTWtcpL2BH6+lTvspqOlXvU7JdZHmBrIlsRMu4fK/yL791DAjjpfm
 0FIA0ioKmqhtCV7eslpWDYyprVW9ksA=
X-Proofpoint-GUID: yxxYF-TaDNKJ4Z1p7vqlYTSrO6wSyw6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210062

From: Wen Xiong <wenxiong@linux.ibm.com>

Fixes kexec boot. Without a hard reset, TI pci usb chips will fail to
initialize in a kexec booted kernel.

Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 drivers/usb/host/xhci.c     | 8 ++++++++
 drivers/usb/host/xhci.h     | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a8889081ae82..782178da4057 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -479,8 +479,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    pdev->device == PCI_DEVICE_ID_ASMEDIA_3042_XHCI)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 
-	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)
+	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) {
 		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;
+		xhci->quirks |= XHCI_RESET_ON_SHUTDOWN;
+	}
 
 	if ((pdev->vendor == PCI_VENDOR_ID_BROADCOM ||
 	     pdev->vendor == PCI_VENDOR_ID_CAVIUM) &&
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a9e47e178c28..8e5e25ebb6b5 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -750,6 +750,7 @@ EXPORT_SYMBOL_GPL(xhci_stop);
 void xhci_shutdown(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	int err;
 
 	if (xhci->quirks & XHCI_SPURIOUS_REBOOT)
 		usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
@@ -781,6 +782,13 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"xhci_shutdown completed - status = %x",
 			readl(&xhci->op_regs->status));
+
+	/*
+	 * TI xHCI controllers fail to initialize in a kexec
+	 * kernel without a PCI function reset
+	 */
+	if (err && (xhci->quirks & XHCI_RESET_ON_SHUTDOWN))
+		pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
 }
 EXPORT_SYMBOL_GPL(xhci_shutdown);
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index c7bfa7f028d3..e94a38e5f4ac 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1647,6 +1647,7 @@ struct xhci_hcd {
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 #define XHCI_ETRON_HOST	BIT_ULL(49)
 #define XHCI_LIMIT_ENDPOINT_INTERVAL_9 BIT_ULL(50)
+#define XHCI_RESET_ON_SHUTDOWN	BIT_ULL(51)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.52.0

