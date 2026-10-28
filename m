Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220617;
	b=UEuQwDkM/3djMmgA3IQlxddFbbehyp3FFsCBUV2NEK05BunkqFRSl9lBUiEEiXtgCg78
	 5bAUJQ2269Ei1jknbb2x2llc6DcMGV+HsFzSz2oDjF41tRcx7Z9A28Q3QIF5KSBFOAppf
	 Uiyd9XZPVvWF/EpnHg5e2x2pia9utvGdLA7FzFhRx1pU7Z4np8/VXmLyjofretm7NKdKW
	 cRHh7Em2nkPxzvghLlSDEncrfFjiEgU6Xp520y11C1DTv4b+JzEh6jCOcEuC9PJM734R7
	 xYTskYLJPJBCxhOtpiSvqxvMuEU9QowQxSwTEQWTOp7KQBpZEo4sYHWUxK6DKxJE5rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220617;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3J+m5zssHO30+gGvjgsMEVpbwVkuGxWjmnZLOzezkqg=;
	b=pQQDeVX6YIXiVCgdIiQTXZjmbH8OUEfZEfp94MI7g4Li343TUo5IeIh9UqzfX20BQQ2U
	 QDcH2Wv6N720hASB50zkHnKmjszpQh9yaTDqUQVdwBwUkPa9KSw1AgneGSJWGhrs60+Ae
	 Jd3+1pMx/hkcbzDYt8xfZQch2R6LV/YHkofJHGwAu7y7fV450f/uNH6zt8Bo0F6A3oBgN
	 Prk7Sn9LYP4Fxo//j0vyNiMg0Gns1DXv/Dz0Gsc+hpQQTRjNGVACHf+lKvPYm2asiuBH/
	 0QWzZ3yPCNNT0J2PxlrHE9q896RTeweNb6U7Emr7t4WHu7O1KhsTK8OplU2aQObjXfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=go0Fx3+N;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0091606A31E;
	Wed, 28 Oct 2026 20:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0091606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=go0Fx3+N
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SJYsnp2340162;
	Wed, 28 Oct 2026 20:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3J+m5z
	ssHO30+gGvjgsMEVpbwVkuGxWjmnZLOzezkqg=; b=go0Fx3+NOkNNIrw4Ln4G5+
	n1hVw44Bg5eoxTwZuoZ1R8LgTQbs6pxo9Pyx77Kqpglb/tAN5HtBfVkzBPbTtg+S
	lM8gxpWaLWvaZEwC6TrV7UkdWbJDmj0mBrz6YyMf89fwA4thgPY86YsIWVtBONqt
	AzKDOgfZdanBt4b7QJjxPvSRblpD8+vCnWwa/W3cnyMQVObeIbf+XJEFCUhIwpcV
	tAGpd0tz12wl7SHtYL80zcN/4F125F5OM0qWl8D905bYiiWvzFWyYLLQoAvyTjJO
	45eenpUAlPJww7erptCqOOBuPeDXQbmNLQI13+eeU0USi4g00NjOIirTq5AAlRoA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm646y1u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 20:50:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SInkCG1983966;
	Wed, 28 Oct 2026 20:50:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pc1wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 20:50:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SKoCPs22545028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 20:50:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F9075805C;
	Wed, 28 Oct 2026 20:50:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A589058054;
	Wed, 28 Oct 2026 20:50:11 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 20:50:11 +0000 (GMT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 15:50:11 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        wenxiong@us.ibm.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3] xhci: Reset TI USB controller on xhci shutdown
In-Reply-To: <20261028103616.29110069.michal.pecio@gmail.com>
References: <20261021160608.8229-1-wenxiong@linux.ibm.com>
 <20261028103616.29110069.michal.pecio@gmail.com>
Message-ID: <c10dd783a61e66023b04aac7829c66ae@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX601frCAB19/q
 uI/YX55lZDL46lwWnclqvOCWBrF4GSZJ30O7k5FmAE90xoWvjJVKtmQ0K4njkWF1eXM7fbBBMy/
 iku+wZ3kD7Efj5mY0LIdQ/Xaam08lZY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX43KXMdpUq/rL
 9e3OQmfoHHGFh0wSriTm+Nzt4QfloGu4utUAL3uPGrNk0hxV/ye4mgAbixY8zYrxzHLcVq0jHMx
 gWA8zrb5IcCT4gLxCAfRBgkYHlD2OjyXrvIsTFixdnFIRZEvmgItbWxe48XLXMeTSHOaozSf57p
 82xJf3zeouc/3adjbj01urlfnoinAdAzLFe0/1XvXysBgJvbsH5YGps7ViLk90FyF3JwGQCvxCi
 FVqYf1vMCJNFg5uvOAc/Ivtnq1c97UpVAQaGpmlbFM9FrFRhemAXgre80fgT5prRcDQl0Hw9uOb
 65yhfZpAl3VqwkquCM4vJebV+ctsQVfyw+j3qgsyL6HgdZzDFydY+1r9QVskr7CgvAfOY+E62EX
 VVOZ65TvVtGhv8rAxCYzyrbQar/W6To9wWA1Dx7aK+kyKacUDF4WYXGYaO/41iAZ3EgBcB7BJV4
 R9GZZ2n60kVt/mCviXw==
X-Proofpoint-ORIG-GUID: w1D2aPIGsQzg6O2eGCeEIUcG8ZgfXFVc
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae26006 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1VaoIupEdHR5eMkdamIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ochY4GT0oiw3AJipYFMkE2_mabINeyr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082


> I tried to make this code a bit more "proper", by moving the
> pci_reset_function_locked() call to xhci-pci.c from xhci.c.
> 
> I found that when I actually run this, I get a warning from PCI:
> 
>   unlocked secondary bus reset via: __pci_reset_function_locked
> 

Hi Michal,

How about we add check TI/failling usb controller in xhci_halt and 
xhci_pci_shutdown?

Thanks,
Wendy
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a8889081ae82..af6ca5447f22 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -950,6 +950,10 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
         /* Yet another workaround for spurious wakeups at shutdown with 
HSW */
         if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
                 pci_set_power_state(pdev, PCI_D3hot);
+
+       /* TI XHCI controllers do not come back after kexec without this 
hack */
+       if (xhci->quirks & XHCI_HALT_FAIL_TO_RESET)
+               pci_reset_function_locked(pdev);
  }
  
/*-------------------------------------------------------------------------*/
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.cW
index a9e47e178c28..67108692a354 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -120,6 +120,8 @@ void xhci_quiesce(struct xhci_hcd *xhci)
   */
  int xhci_halt(struct xhci_hcd *xhci)
  {
+       struct usb_hcd *hcd = xhci_to_hcd(xhci);
+       struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
         int ret;

         xhci_dbg_trace(xhci, trace_xhci_dbg_init, "// Halt the HC");
@@ -130,6 +132,11 @@ int xhci_halt(struct xhci_hcd *xhci)
         if (ret) {
                 if (!(xhci->xhc_state & XHCI_STATE_DYING))
                         xhci_warn(xhci, "Host halt failed, %d\n", ret);
+
+               if (pdev->vendor == PCI_VENDOR_ID_TI &&
+                               pdev->device == 0x8241)
+                       xhci->quirks |= XHCI_HALT_FAIL_TO_RESET;
+
                 return ret;
         }


