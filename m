Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907F363C46;
	Wed, 14 Oct 2026 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009956; cv=none; b=qI5KZAsI7iH+MDZRR6uGBGvnIBPaHItIcUbvqKpeHwjxP52KlTeok/k37vqjxb3IKfMBqxpkkeZ3cKjGVhp4TQK4QXGpFkOYnaCZ2cmaXhfwejk+d9NzaX5r+JwvKcpBf2Gz+5xlJlHyOfFPsWD4OZmQBQKbfrBju8CufRvXSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009956; c=relaxed/simple;
	bh=tWgKXUh22x9OhorVqOWRYmOtA0aoRz/aY9z8oYN3GXU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=quOWmhq/wP/wLnMURzEOPYDbZddSdnq6HdzATiPJ9GGtG1wojeRXRttM8IRLZdOL6lSmvDafHN6nfWi06fyHflQDKIaGe8wA7dKK3ZUKpRFuNRSJwB4TwmfCtC3PDYibNfM/1iYrj5sfXaCyb3oF/e9c3S7Dhw5sUAY6c9+CDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f9RQVOwq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f9RQVOwq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEiVeH2562494;
	Wed, 14 Oct 2026 20:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5ujUXx
	Oxc2+QY02Jg9WNRsThUM4Ckx/qWWSzFmoQbHU=; b=f9RQVOwqfvT8aTEFGdT+yH
	C3a6+D9GhKH2ODua3wxattCNxeQKD8V3Z0WPbQpf0p8aqWExeH5MTAceDkzBASTe
	Krsye0/vuth0hSsZcz4bkF7jjVRn+s8zz0FGf7CRidIbpfqSg/C9vAX4XixAgEL2
	WMEDUlxFJzflPkzwBx98peh9k/XKPMP/bPhFzqaStOFumjtGlEIn1CYp3Nmm4hyn
	zv4A1r+dCMl/TUlD9ZgklImmGndmKtXe3pwT5h8dcB43MIvhKhXJaD9krm+AetsP
	joVY+wpkLnvyDFiMy/c9CgcDxTvsOZ3WxkEJbRR1c7ZeGisIGlvqThwDvCVooqOQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugpmqa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 20:32:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EIeuFh634438;
	Wed, 14 Oct 2026 20:32:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2ypjyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 20:32:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EKWNtj32572096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 20:32:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BF9158054;
	Wed, 14 Oct 2026 20:32:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8970758062;
	Wed, 14 Oct 2026 20:32:22 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 20:32:22 +0000 (GMT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 15:32:22 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, wenxiong@us.ibm.com,
        Brian King
 <brking@linux.vnet.ibm.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] xhci: Reset controller on xhci shutdown
In-Reply-To: <20261006125546.10471489.michal.pecio@gmail.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
 <20261002102931.3cb06009.michal.pecio@gmail.com>
 <561d22493c3d078b26f547dd8f6f6f46@linux.ibm.com>
 <20261002161828.365ff859.michal.pecio@gmail.com>
 <55a53022d1c6f671a3ed549d8cf7cd1a@linux.ibm.com>
 <20261006125546.10471489.michal.pecio@gmail.com>
Message-ID: <64515dfd9a6cd8c3f5665e72a6bf6b81@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acfe6d9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=MWHgFnkp4v5QQt6DU_YA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: -H3wSmxdhVJawbwNyPSzjl3zPifwDwqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MCBTYWx0ZWRfX5kpe1Xh6FRDC
 9EtGiMheIepoAYuTFvIRFfKHdBOmXvU5cOO+nAqlTTISZ4Bcj5ugNyhp+xao/Z+xXkQ+BYjFN4+
 fpkPQDVRjLAUsBBNndCzdc2umjzlRWWAWyz9cPC83rmTbeQOzWH4u8JNyoIYPwT4HDrJ6ploJTx
 xfqSeuoY207NuK63CmR7ciRkkC6AFrXnntgP2lrlf2LKKuVACNb9cXP/Chza7otlCdXc9hHcA3Y
 y6HQAxz43t8prn27yZxBQBcnggzVCFWVeQ5H2GWCK6Ke3di8Q07cJXyIxPRNVse8GSANQ+0MYKn
 JbEtdiH7R1ZcZX3kWDa1lNc/NvadkQ3Axlxku8Pp+VyDlXdQyli38eyp5ji1q0VOk42I3mDo3/T
 ZnQcs0GQR4fa29D4n25ARpL+lWxNsvuDz1rDHElQzrv+3U3mOACYeksyiLw7YQMYahYP3xFscnB
 7cNfWxLCCqi1cxqA25Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MCBTYWx0ZWRfX/gyTShc6plTf
 hUJu+UOIik0rSfesCb3kvdkPS5y93eSzFc43xXUetT+z4qmKPJN6jx7xmduxmMKj/4UfsOtn1Pz
 XnFW7PmA4RkkJh4CNH+xq3QqWOPNOHY=
X-Proofpoint-ORIG-GUID: DqAWnHanW6LB_e30Wx5ZMHFYcnXfk7Qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140080

On 2026-10-06 05:55, Michal Pecio wrote:
> Are you able to capture the original kernel's dmesg (through serial,
> netconsole, etc) and see if the same "Host halt failed" is there?
> 
Below is xhci messages after executing a kexec kernel. This is dmesg for 
kexec kernel.
[root@ltc-boston11 ~]# dmesg|grep xhci
[    1.085853] xhci_hcd 0005:01:00.0: xHCI Host Controller
[    1.085992] xhci_hcd 0005:01:00.0: new USB bus registered, assigned 
bus number 1
[    1.144472] xhci_hcd 0005:01:00.0: Host halt failed, -110
[    1.144518] xhci_hcd 0005:01:00.0: can't setup: -110
[    1.144571] xhci_hcd 0005:01:00.0: USB bus 1 deregistered
[    1.144778] xhci_hcd 0005:01:00.0: init 0005:01:00.0 fail, -110
[    1.144842] xhci_hcd 0005:01:00.0: probe with driver xhci_hcd failed 
with error -110

This is the reason why we can't see usb devices after a kexec kernel.

With the patch,
  #dmesg|grep xhci
[    0.859562] xhci_hcd 0005:01:00.0: xHCI Host Controller
[    0.859670] xhci_hcd 0005:01:00.0: new USB bus registered, assigned 
bus number 1
[    0.859797] xhci_hcd 0005:01:00.0: iommu: 64-bit OK but direct DMA is 
limited by 0
[    0.859858] xhci_hcd 0005:01:00.0: iommu: 64-bit OK but direct DMA is 
limited by 0
[    0.859982] xhci_hcd 0005:01:00.0: hcc params 0x0270f06d hci version 
0x96 quirks 0x0000000004000000
[    0.860614] xhci_hcd 0005:01:00.0: xHCI Host Controller
[    0.860719] xhci_hcd 0005:01:00.0: new USB bus registered, assigned 
bus number 2
[    0.860770] xhci_hcd 0005:01:00.0: Host supports USB 3.0 SuperSpeed
[    0.861091] usb usb1: Manufacturer: Linux 7.3.0-rc6-usb-gbatra+ 
xhci-hcd
[    0.862130] usb usb2: Manufacturer: Linux 7.3.0-rc6-usb-gbatra+ 
xhci-hcd
[    1.127210] usb 1-3: new high-speed USB device number 2 using 
xhci_hcd
[    1.407320] usb 2-2: new SuperSpeed USB device number 2 using 
xhci_hcd
[    1.556759] usb 1-4: new high-speed USB device number 3 using 
xhci_hcd
[    1.806902] usb 1-3.1: new low-speed USB device number 4 using 
xhci_hcd

#[root@ltc-boston11 ~]# lsusb
Bus 002 Device 002: ID 18a5:0252 Verbatim, Ltd
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 0451:80ff Texas Instruments, Inc.
Bus 001 Device 004: ID 0557:2419 ATEN International Co., Ltd Virtual 
mouse/keyboard device
Bus 001 Device 002: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub



> And if you enable dynamic debug before kexec,
> 
>   echo 'module xhci_hcd +p' >/proc/dynamic_debug/control
> 
> what's printed by the debug message at the end of xhci_shutdown()?
> 
> Do you also get errors from quirk_usb_handoff_xhci() by any chance?
> 
After executing a kexec kernel, is the control setting lost?
I didn't see much useful information in control after a kexec kernel.

Probably we can resubmit the patch with mathias's suggestion.

Thanks,
Wendy

T
