Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4137F738;
	Mon,  6 Jul 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348173; cv=none; b=PxMxAHWc6vE/+j/NBb0c18ko3DNMaIO4ftXowZTk8IKCso1rP6FU0CFXj1rw8mnu6C9wnadlIZTo0M2rGl5Q/KXA+xoVV1GNn7EXgrutGMMljRgiDP/WLfm0damazmbXb88JHcIySAtfwkhtwBsgHWnpGT5tDG4jZmyED9frn9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348173; c=relaxed/simple;
	bh=Sg2W91u2WOlNeYky+E9Az5PesJHW+j6DLJEmMDv3Nrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzDrm3rqr58zoPP9UhELazcU1KUXh4hTZnaET7TWNGm3vKlUYwG2oS72yuyrahUU7x3gwHfVx6u1OUVOCwDzpqqcb/u2YYS5uJwZns86jnIr6XqG0z3jOk9OBYIJweG3E20dkRGrKBaiv8hqe8qIBIarez3WIphI1cHj6eVQC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JM0PxGSS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JM0PxGSS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666EIjj4606520;
	Mon, 6 Jul 2026 14:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=ExJM01xnOdeglBWEwoWd8ermrj1heSrMTZ9DOnd0jm8=; b=JM0PxGSSxzv2
	kBojaIG+Mv8sBspk/I0n+i5bBposjjI6VpjU0O2VVXSXNuPZHyVbPIP9nTvrKq/g
	sgPwzZPeOvdNlXyO003Zm0J02ojTuZ+IbfzAAiOx1iC6BskfkYS+Irwq02ZXQ3lX
	0jtI/65218WpgFoAXX+j2dzlh/vUfUN7elv/Pdmcb0X7e/l5YPkm9dXw5kf415zV
	tX82VlreWrcEH7Kh9ZntzmI2mp4ax5o2oK5A8Rkdsy/O0i858PEYQKunUe7AvwDE
	1ilIt/uvb9t5+WrDN3wCAp/rz7/M/QPlA2pxu0RDrbq0aIotAMFJWe60nyklocqm
	3kFFSskMKQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn9yr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:29:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666EJwo0014754;
	Mon, 6 Jul 2026 14:29:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h5uqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:29:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666ET4JF51380482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:29:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CBA420043;
	Mon,  6 Jul 2026 14:29:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8471F20040;
	Mon,  6 Jul 2026 14:29:04 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.111.22.53])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jul 2026 14:29:04 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.4)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wgkJk-00000002A01-0gbJ;
	Mon, 06 Jul 2026 16:29:04 +0200
Date: Mon, 6 Jul 2026 16:29:04 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bjorn.helgaas@gmail.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com, sebott@linux.ibm.com,
        schnelle@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v14 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA
 deadlock
Message-ID: <20260706142904.GA17215@p1gen4-pw042f0m>
References: <cover.1776839248.git.ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1776839248.git.ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4bbbb7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=J6SQpo7RyPDJe7EV0JwA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: dnTLI0PmbyKfdG5MEaD6-cLFhttYCGxL
X-Proofpoint-ORIG-GUID: sn6hIZ1ohfrJk-91SBe9umMj8kbOdiuy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0NiBTYWx0ZWRfX0wNTi73Va8Y2
 WFydKbH5110MWxt2L+l01A6MIzmFCD/vD0N0nKYHpQWdbw5qDvijgXTjnLT+9zVQ27XSFLHIR8e
 wcCjv1TCpNH4VykuGpF0oQW2xrHWMKU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0NiBTYWx0ZWRfXxJm4uznkAmJe
 kKvXLBENGV2QwgKvxnmuxr8C/zMXx8MdohUXhkxz8oIjlUVGfZHuGXn+cRWbYVizuyPEk2pkUt8
 d556kKmyO7n5Kq337S7P9MQiHUQnOA+2S7TuYkY60iO2gxYMWdq6M2zhKyoLraFZYbzowzjsqHa
 5s8pBRfnq0Un9Na16OFw98/U70s1rXWPjuCilE227UbaXSNqrd4LHa7cJRcmbitXqeOXyxEJUSU
 Kj18u9ExjdX4Satre0ioKmj40q4s/s1z1yC8ISUqjlEDnOZUn65kaRTDLfp7jk5NIKPk4p5Oujk
 Qp0KG1bH7jgcBjJ4Kid+BW1i3DBGnN8gHGayZLh0SXP70s/NCG8cmF91da1NqgjwmduAjBwPdGu
 yCXoRfQKadb3BDij6fNDukCpvm3d/mJxpibeRqmOL4vPK4TX0lbpGa2Rnl122D9+ayfyB7JvTrx
 6pQDiWzsp/8dGWtPhDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060146

Hey Bjorn,

On Wed, Apr 22, 2026 at 09:32:40AM +0300, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> This is v14 of the fix for the SR-IOV race between driver .remove()
> and concurrent hotplug events.
> 
--8<--
> 
> This race has been independently observed by multiple organizations:
>   - IBM (s390 platform-generated hot-unplug events racing with
>     sriov_del_vfs during PF driver unload)
>   - NVIDIA (tested by Dragos Tatulea in earlier versions)
>   - Intel (xe driver hitting lockdep warnings and deadlocks when
>     calling pci_disable_sriov from .remove)
>   - Wind River (original reporter and patch author)
> 
> Test environment:
>   - Tested on s390 by Benjamin Block and Niklas Schnelle (IBM)
>   - Tested on x86_64 with Intel and NVIDIA SR-IOV devices (earlier
>     versions)
> 
> Based on linux-next (next-20260420).
> 
--8<--
> 
> Ionut Nechita (Wind River) (2):
>   PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
>     sriov_add_vfs/sriov_del_vfs
>   PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock
>     in remove_store
> 
>  drivers/pci/iov.c       |  9 +++++----
>  drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
>  drivers/pci/probe.c     | 18 ++++++++++++++++--
>  3 files changed, 50 insertions(+), 7 deletions(-)

did you find some time to take a look at this patchset?

I'd love to know how we can continue with this?

As mentioned, I also still have a s390x-specific patchset outstanding:
https://lore.kernel.org/linux-pci/cover.1776868550.git.bblock%40linux.ibm.com/
which depends on this one; and this still regularly deadlocks the kernel on
s390 with PCI hotplug. It really is something I'd like to have fixed as soon
as possible.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
