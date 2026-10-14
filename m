Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B036B906;
	Wed, 14 Oct 2026 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016981; cv=none; b=QYxOHzdeK/nyyRqYW81w+YLwUr611RkmVS0Z7WvY+PZ814I/kxGVcd8RxYLzqhh5kQPOljB9jyHwdfsVYjqYsmO9Q5Qrtm4ehmJmW3S8QFh+57qA8n7C1OCR4OK9cyxSZQN+Fb4/4t73NiRtolHjbNS6foC9Zv6LNk+Od7TKp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016981; c=relaxed/simple;
	bh=FxLV6rUlmjvJvnrWA0n5KJ+3RmJVCCWsy0acd9a4MSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rm17GQZfjCPeDC08cX9nkQuJEHmQ9K/RsTGSvkredLcoQX2qSJLzdDrjMKocl2m6vjorjIZFEJc0JlI8+0ODGs3Smn9Vxsgv5hTp/A6zm+dSoenOP6w8DcLsxJ8Bnh9q7l9bgNrYwQjckgSUw9QKA+pvjFm2cJbOqeEVg1xmFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tebmoSyI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tebmoSyI"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEiFY32426973;
	Wed, 14 Oct 2026 22:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HpWxKj1YqGTJj9+efyCX/WEHUibAqCUtGScsPxzLj
	O8=; b=tebmoSyI70I/Ybz/r44bsFhy75fnoDagDkUcDH32JgjIzZ61lUVjVOsGY
	yNjCW+kjt0xvY2QLStCnnWqqe11MHsoxd8c3Ck/1Gkf2aRVqogPNfi7Gd5XgzB89
	DbUA3vvcbiwIcRPo3yDmx0IwzL0FZ6/CqQgcU5XqZDjr4/xahL/usNaPuskwC14B
	eI6PwRsu2M/WVXLvX+232C28RSSG+geI99MAOhcu171OoayXV0VH8pKXUldZdxY+
	fNdwUZR/WAajTN3RLj/Oq6X45qiXiZSylt8XYbTd3KBw+sGGar2wRl2n7s93eWW8
	rXGNZUAVFtA3tO7EnU1Vf0UHHZRNg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3py56-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 22:29:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EIcKxk660263;
	Wed, 14 Oct 2026 22:29:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3q56c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 22:29:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EMTZix25297514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 22:29:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A79B5805E;
	Wed, 14 Oct 2026 22:29:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0CFE5805A;
	Wed, 14 Oct 2026 22:29:34 +0000 (GMT)
Received: from ltcrain119-lp4.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 22:29:34 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2] xhci: Reset TI usb controller on xhci shutdown
Date: Wed, 14 Oct 2026 18:28:55 -0400
Message-ID: <20261014222855.13698-1-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q2x-2qzdaSDhLcHkSffdyXDqjvThEjmx
X-Proofpoint-ORIG-GUID: q2x-2qzdaSDhLcHkSffdyXDqjvThEjmx
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ad00252 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=yB8LFx1ia55OOJaLE-QA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4OCBTYWx0ZWRfX5Sg1y1oXlVAd
 TTpKWDRfj8E3QsgsBxsgTWSr0FTYFX89+qd7mSg7bH4pzvK77puDul3R2CZbo9DmLyzqwmwQcAW
 anNjZ4w6KglRjzgbHPYem7nKYtfaSUY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4OCBTYWx0ZWRfX5rx5DrcOcIZB
 PJ3DWcF9yKjO/Y5ksJy5kqHvl6WkDs0WgaL++PJvv8Jj3Iyfojtz3TRN48x5+haob58sPmUTFfz
 /ZQ+cFe/vUlR4VsKB0BLIrCBT7RrXzJ0tJpeNMiXlFxoPDUCSAlXwmsGZIKCkx/P0Leei9cW9tg
 gCAmUsDNsdyd9hp/pGPhTRlIiPpw7lNC3HoK0Tul+1ltwObccqmdz+8Uayupb0SWx4dj4XSWB4L
 ueCdRo/WAG/7GYVNuo8xFsarH/jQY2+IhJ/EXgJr1Q7UUtBhB+IVmkNlXENDKMURCjHqzumBYh0
 htDfqgNCjdQriLiDvjDI7x0xxACk3/ysx6B7DhTMDhuwcdJYxM6MIHcTWdnZEUGD2XJ9B0T0Nmj
 Qm5MtSn/+VhlgRhj8eQK5DF+b0aWFutDv0U3hSu8tiPHHrSlK4OivCM4GC2tYHi+MlRG/0zSwGK
 kMR6/kL+8S3KcKEOVwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140088

From: Wen Xiong <wenxiong@linux.ibm.com>

Fixes kexec boot. Without a hard reset, TI pci usb chips will fail to
initialize in a kexec booted kernel.

Signed-off-by: Wen Xixong <wenxiong@linux.ibm.com>
---
 drivers/usb/host/xhci-pci.c | 11 ++++++++++-
 drivers/usb/host/xhci.h     |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a8889081ae82..36191639bf43 100644
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
@@ -950,6 +952,13 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(pdev, PCI_D3hot);
+
+	/* 
+	* TI xHCI controllers fail to initialize in a kexec 
+	* kernel without a PCI function reset
+	*/
+	if (xhci->quirks & XHCI_RESET_ON_SHUTDOWN)
+		pci_reset_function_locked(pdev);
 }
 
 /*-------------------------------------------------------------------------*/
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

