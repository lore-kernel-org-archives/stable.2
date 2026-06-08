Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD873C9897;
	Mon,  8 Jun 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928396; cv=none; b=SCVHNmXMXSkhpAWik24yoU8+7zGdibYdvJndcUUN74nTzlHJN5j2mOHDT+roTRGEfVOhr4TFSLAIJZNxeNSINMiIgPw6Fx1WDEhRp7hEib+YQGrEeakfggpNBUduQ4uOmasc0StC+yYZXVmYoxpEzgSC+FbmmyJO5dVrnvpp5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928396; c=relaxed/simple;
	bh=JwAsSmZHEmJftDoDT4o1AxRFk9ffHF9QhSJ5W3MhLtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBv7PzX/9MfTm4mr+h6BeqPTcBeruHVRF4St2f3r8lqdVDef962O3nqYV08IMEZg0NFxxyGRMXbDGiJSry5yWK7vvjmRc4g2ax8iBbND2KdqkmI/j6D73XCSrsQjy0BiQYFoYWd6thih/E8Zzxhfcvjw8rIMVFlkKpLrFme2/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kv2q8G4S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kv2q8G4S"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588A7i91458768;
	Mon, 8 Jun 2026 14:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pTnj5hc2AGLIaTtiaPIpTmrWWo1jdc
	JMYBjGgCDyyjs=; b=Kv2q8G4SKMkysAkJbBslHkb5PPRE3mJDxWiQ3cLgS3TK3G
	CVxKz/xk7dwvU/sN5JEnyd+oX8gVFE422M9b9V1W7JOLoxcMu07mW5gSeWiWS5Te
	N7Ia1GITDv+Lck+8yu3SNXU7fZ4arSA989yvWA2TlvIPrn86j9EHo126o3aFSrUD
	+SRaUloFIfkjGc6eLFSeYb2dHbw24HVh8xovpQFm7lAKm32ZCGS7Dhy4ihBTriFG
	Q+1luifPjiY0gyH1dQ0YsJovPIkGs8XRCPFOBa+xtlbFsd89mL9rKdeE3FpXqXiI
	Z3op3V0W5+9uaP40C4KOqflfLYohTJxy9ImHwEOg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb957nvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 14:19:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658E4baE005680;
	Mon, 8 Jun 2026 14:19:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpwt7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 14:19:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658EJXOH25821920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 14:19:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 122C358056;
	Mon,  8 Jun 2026 14:19:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 060B058052;
	Mon,  8 Jun 2026 14:19:27 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.27.161])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with SMTP;
	Mon,  8 Jun 2026 14:19:26 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Mon, 08 Jun 2026 19:49:25 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Harsh Prateek Bora
 <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree
 Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
In-Reply-To: <aiaAPQmWG7JXGoGn@Gautams-MacBook-Pro.local>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
 <aiGJvUqgjUo6M5et@mac.bl1-in.ibm.com> <87ldctmosh.fsf@vajain21.in.ibm.com>
 <aiaAPQmWG7JXGoGn@Gautams-MacBook-Pro.local>
Date: Mon, 08 Jun 2026 19:49:25 +0530
Message-ID: <877bo9m7wy.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26cf78 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FEvzW7QgZIPG8QhEdCYA:9
X-Proofpoint-ORIG-GUID: IAcZRhrd19hqH9tIBTGj-YEn3gPFGtPn
X-Proofpoint-GUID: 334FODx7fJ4QzIEJE24es4nh5iroqIfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzNCBTYWx0ZWRfXylAXCFV89dhV
 h3DNgITWM2xtuWmkgirPy1GBkIstat3tS0bbwOP6pFg0W7epEjmPogLG+49+SVmgT5o8R2kaKA8
 BcnYW5fRkD1YcRbac6Fkget9AhawkCvWLuia7SF2XcEYkaohaiMjdFgaKO81cTrPv82Ec0lPTEP
 YdNKRzsL65uq4+nOJSYSCAMcO6KXVozVhw8WK/6vIhoDNlW1n+wvWCyrWBlZh9DgipxZ6i9/x7s
 WCVxXDeuKYbzYgAZcjnHeP3v283XEWZ/h43rBO3I8fK5XQ6m3Ocu1RGBTwH4IqOx4wFxcGPcoUe
 VTO4J3b7jFYrK1ompMK2bobCbqF48BHCsCpS9LJDkLjtIOQTcQP4F6pdLHzVrMAPMuHwIgA7+dS
 UBwKhdV4pWGY3McmyGpPcGmh5h5523bNRHcYNp92at38+nJbBuLRqrl30eP8lhSK7KTJebDta8x
 Rem2ZlEwDleecsuhwzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080134

Gautam Menghani <gautam@linux.ibm.com> writes:

> On Fri, Jun 05, 2026 at 12:55:50PM +0530, Vaibhav Jain wrote:
>> Hi Gautam,
>> 
>> Thanks for testing this patch. Few questions:
>> Gautam Menghani <gautam@linux.ibm.com> writes:
>> 
>> > On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
>> >> On IBM POWER systems, newer processor generations can operate in
>> >> compatibility modes corresponding to earlier generations. This becomes
>> >> relevant for nested virtualization, where nested KVM guests may need to
>> >> run with a specific processor compatibility level.
>> >> 
>> <snip>
>> >
>> > I booted a KVM guest on LPAR with this patch in the following scenarios:
>> <snip>
>> 
>> > 3. P11 guest on P11 host booted in P10 compat mode: No error observed
>> This should have resulted in an error since booting a P11 guest on P10
>> compat mode host is not allowed with/without this patch. Can you please
>> check your test env and share the boot results.
>
> - lscpu output (host P11 LPAR booted in p10 compat mode)
> # lscpu                                                                                                                                                   03:35:13 [3/3]
> Architecture:                ppc64le
>   Byte Order:                Little Endian
> CPU(s):                      960
>   On-line CPU(s) list:       0-959
> Model name:                  POWER10 (architected), altivec supported
>   Model:                     2.0 (pvr 0082 0200)
>   Thread(s) per core:        8
>   Core(s) per socket:        15
>   Socket(s):                 8
>   Physical sockets:          4
>   Physical chips:            2
>   Physical cores/chip:       16
>
>
> - lscpu output from guest
> # lscpu
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   4
>   On-line CPU(s) list:    0-3
> Model name:               Power11 (raw), altivec supported
>   Model:                  2.0 (pvr 0082 0200)
>   Thread(s) per core:     1
>   Core(s) per socket:     4
>   Socket(s):              1
>
Argh, this doesnt look right. The kernel patch should have prevented the
P11 compat guest boot on P10 compat host. Looks like you havent used the
corrosponding Qemu patch [1] that could have prevented this from
happening.

Had a off mailing list discussion with Amit on how to address this issue
and he will be sending a new version of the patch to address this issue.


[1] https://lore.kernel.org/all/20260502140021.69712-2-amachhiw@linux.ibm.com/

>
>
> - QEMU command line
> /usr/bin/qemu-system-ppc64 -device virtio-blk-pci,drive=drive0,id=virtblk0 \
>     -drive file=/home/gautam/images/fc41.qcow2,format=qcow2,if=none,id=drive0 \
>     -m 100G -smp 4 -cpu host -nographic -machine pseries,ic-mode=xics -accel kvm
>
>
> Thanks,
> Gautam
>

-- 
Cheers
~ Vaibhav
