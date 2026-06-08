Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE9C14A;
	Mon,  8 Jun 2026 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908119; cv=none; b=jYxdaLggryBguM19u5XsOQ/sTpk4pXZdRKLVz1kv+Yp1GMwd8ZoLBJUyP46yNwRb4xFAlTmKQiQtvbW15hMumOoaGsK58vcJlfozAZrTpvIfknbQqZLnSAF4Tmm1Ya1DgcbuxrQ3MR6H0e1S9VKDY27SVOAEXpTuewaJkQlQYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908119; c=relaxed/simple;
	bh=VC6qM/f1wGW1sk5+lK9SwHBhqrDcjXd3aB1FF2iUpHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUKkt3BaJTemc4VJr6UdjANxedrs5S0AOHN3xLOeFVkq4njtF4h3CAPj9lk5WrmE1wPNSVhs9rduIAIoyzyp6EAiNta2tew1eR0vIX+FqwVgAb7bAFXzI2k1ClvZAzWHH/Gt7qjPMT5CXQzEftO/RbkCL1CEvS/fwvaAHf0U7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r+HbwqCI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r+HbwqCI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Mtrwr3416909;
	Mon, 8 Jun 2026 08:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oNmfjHZJRZvm1sNDrL/NuDvRFR+oaQ
	AgWMXuBwz+8j4=; b=r+HbwqCIo7V/5hwXKFd1LONZ4Jvf90IeZ1+lIEvbzx4fKF
	ykjs+qBjcHHEPPLtI4WAdiGrRzTVzOOL5hRwwjN3VMGHI+MT/EuHEvxDAU3jrUJ3
	22kd9dUPw21Hx7u9kIlSPsWFXqIZSxfmrtOlWC8JLRdw/3hqHrt7gov6T9yfrGGQ
	L30awkI9/8Ls1QzBYEiDFJXUvEvQNLDmADJPHVDOCvLnJMPtXVnv5xwy2ayF8TIv
	/B7lEpEPo447EornL4nfHm+ksg/skOJ0VpDwOFLgaziQLV8OgbTWf8aYhKEECLdG
	zOpbYqp0SMEy81lqd0mfpTU23b9zt+P3ZK/hKPHQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qed5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:41:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6588YeoH014213;
	Mon, 8 Jun 2026 08:41:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgvepd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:41:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6588fhO935651864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 08:41:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB5702004D;
	Mon,  8 Jun 2026 08:41:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89AE220049;
	Mon,  8 Jun 2026 08:41:40 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.97.181])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 08:41:40 +0000 (GMT)
Date: Mon, 8 Jun 2026 14:11:33 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
Message-ID: <aiaAPQmWG7JXGoGn@Gautams-MacBook-Pro.local>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
 <aiGJvUqgjUo6M5et@mac.bl1-in.ibm.com>
 <87ldctmosh.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldctmosh.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26804d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=e3Y8OUfPrnf12rFgJ6AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1cOFj7y23auh6U6zkI4yS1SfysaPNzKj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3OSBTYWx0ZWRfX8paRBT870B29
 JYikC9zZA2cYMzuICjHLPc1xPtCyVVFx2LXxAyzBkkqIoWv7hU2HP7ebYWGZs3YIqBCOXonkoL7
 KddPnCkctMPdHPf0lP5Ra7C7OD2bs05iHCjSB+o/tppHUjk0h82ytit4zIbYzz0KE1FKvMVwnpu
 22uAA3F2t7H20hOxFWuGnySOVVovyA5bzcuVjEanTCr9LwOtfxiBy+yCj2A63RQp1Gt4A7Zw9Y3
 5c5ymlgxsW8dxnH1otYTInGSDKeL383Gqe7eUDB8L15706QOwblq+F3J40b0MXoeoQqUz1IyUiu
 AWs0UnOHLqPj4rYid8MQYVOypnbWg1YfOAMYqk9HderLgVVlxXCUkvPr7jB0eRIC0o3Z1WpHWgF
 /0oD9S1uiIkP/WPgDJZ9tkalALs1/zv2/E+w+cakuTkwGcOZa/AxF6m6eAve4YD4WymEtGS/VI2
 cGW4Q5L/iMCFXSdCPsA==
X-Proofpoint-ORIG-GUID: ZtD31xyr9EAiG7G5dM9V5q-tjCIg3eF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080079

On Fri, Jun 05, 2026 at 12:55:50PM +0530, Vaibhav Jain wrote:
> Hi Gautam,
> 
> Thanks for testing this patch. Few questions:
> Gautam Menghani <gautam@linux.ibm.com> writes:
> 
> > On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
> >> On IBM POWER systems, newer processor generations can operate in
> >> compatibility modes corresponding to earlier generations. This becomes
> >> relevant for nested virtualization, where nested KVM guests may need to
> >> run with a specific processor compatibility level.
> >> 
> <snip>
> >
> > I booted a KVM guest on LPAR with this patch in the following scenarios:
> <snip>
> 
> > 3. P11 guest on P11 host booted in P10 compat mode: No error observed
> This should have resulted in an error since booting a P11 guest on P10
> compat mode host is not allowed with/without this patch. Can you please
> check your test env and share the boot results.

- lscpu output (host P11 LPAR booted in p10 compat mode)
# lscpu                                                                                                                                                   03:35:13 [3/3]
Architecture:                ppc64le
  Byte Order:                Little Endian
CPU(s):                      960
  On-line CPU(s) list:       0-959
Model name:                  POWER10 (architected), altivec supported
  Model:                     2.0 (pvr 0082 0200)
  Thread(s) per core:        8
  Core(s) per socket:        15
  Socket(s):                 8
  Physical sockets:          4
  Physical chips:            2
  Physical cores/chip:       16


- lscpu output from guest
# lscpu
Architecture:             ppc64le
  Byte Order:             Little Endian
CPU(s):                   4
  On-line CPU(s) list:    0-3
Model name:               Power11 (raw), altivec supported
  Model:                  2.0 (pvr 0082 0200)
  Thread(s) per core:     1
  Core(s) per socket:     4
  Socket(s):              1



- QEMU command line
/usr/bin/qemu-system-ppc64 -device virtio-blk-pci,drive=drive0,id=virtblk0 \
    -drive file=/home/gautam/images/fc41.qcow2,format=qcow2,if=none,id=drive0 \
    -m 100G -smp 4 -cpu host -nographic -machine pseries,ic-mode=xics -accel kvm


Thanks,
Gautam
