Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966301;
	b=xQItsXZ/aDY64KA43qmGkTYMhiU25R3GVZy7YtGY71rlbpSTNi8Q7XFFfz7NmGPw0m6T
	 TKSVVTRyAzqG+ZKhNNvErkoKXKNLtdOkSiJqpNgOOFE8VCHNSBcabk54iFFJLdC+Sj0Yu
	 J1bimzt2CDCQoG8bqR/VlvpNzSrSmDvkJW1fPJa0FZ+l93AgF937Lzv/IdGlB7sDJyE1e
	 sJ2u6JDrEexhznCDya7o+ELZAEW6OoNb59RkdBjUdK0cyBY0e5J273bOhTqhk0EFdRYgQ
	 XSxfhe7PXc5MOQQVMhBkT4ByCaGyRGR0ioTgoqbczQZajBXjhV1tnjbKqkN3O2fmOhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966301;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uPj2X8KhO1OscrKtkgCKzVwK3Pjz1SVL5I8ga2MSWvk=;
	b=xbUwXQJQXJ3x0fzYaq+sCjskKs0R5DcHSdhQ1OR889UBlbe6uhDlGGcGC8InyCx4lfmZ
	 LkKN/zHWa9OZnJXKbHOI/jniLhyliqtx/LLX37w7cPfvqkeMR/Gzge2Hprl0dfWTwdKma
	 wI/sjRMf0p4qRC7S7T8zOExcw+b0BO8TzDdlPUt4HRNSVarM53kw0V+DCTwUk6qJf7Daa
	 Jwu0veMhv8JQZ7wyCXg40HhyssErale5aSOdLvoDzC+5zoTUgI74u6pCT4WlU33dvW61b
	 cwLcNzfDVrrzUykbNxw7TCKC8+ZzdIaV1pQ6AePjJ64vKk5fe+N7mCGuERH6/T+ZSFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DXYexYPX;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8513B606A32A;
	Wed, 18 Nov 2026 01:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8513B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DXYexYPX
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMvD3g3642039;
	Wed, 18 Nov 2026 01:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uPj2X8
	KhO1OscrKtkgCKzVwK3Pjz1SVL5I8ga2MSWvk=; b=DXYexYPXuS9F/DZPPZ03aB
	aYieMQWdFBVQevusWuRVxc2xjMIYmtMJ3OmZkmxKkZvc3R+f2XijRdmmCaiBNVvT
	8HzLkjcwxKC7in8n6O+Nskn513q8P0lPkrWuEkvJKzT1F8Vj2A8AJMwRx/0a4Tiy
	e+JO0lI3y8bF91hW/4IAo7VT+qcxyWOr4CjleK+A3eXVZ3p1nbC3oLletsRnzx9p
	LqHYYZjALdrWYGxnxYfKRwWZPEsv5ZNl6h5poXKqZz1kXjyQ99lwosVXBnxQ9rLo
	r9L3JES/QFzvVdHz5nQChFdzCBx1amKOMxwTpjTuER53ogrkVdfev9N/kVsbtkGg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t0d6k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMo0dC030822;
	Wed, 18 Nov 2026 01:44:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ne2jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1idQ329032828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:44:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 466212004B;
	Wed, 18 Nov 2026 01:44:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B17E20040;
	Wed, 18 Nov 2026 01:44:34 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:44:34 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, Avi Kivity <avi@redhat.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock users
Date: Wed, 18 Nov 2026 07:14:33 +0530
Message-ID: <179496619897.633156.6514109970527173646.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261014185215.71832-1-amachhiw@linux.ibm.com>
References: <20261014185215.71832-1-amachhiw@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afd030c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=qyQGTUAR5DSMwchT5_QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: a3dRU6Gzo3Ru-U3igaaGOBCUqlvQ5g3O
X-Proofpoint-GUID: JjmVVTr0acEnABj2T5hmRDHE_ZUOdW9n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX9+yNv2YB5W7H
 MxM/zGFNI/qx/4NzsMRuxO2qlwYqSUfoT7vr4Eqzpb55pShQEjmsSDwpNzSuxTWmMv5tg4EWP7g
 BltX7lvCLcM2KgUIbvjhBWVvjPpC5RuN0oQvhqXz7DK9mzJW4mjrqPRX5G8ZCC50BWORrCHTdG+
 8JbzuJonsEFW/bgrI/JhYJmLk2X2JSRJw68d/+o/JG9/2iDJsZg2C+hrRtSHnd8w/Tcn9/rXfQv
 MP03hJk0PWVbR/NOJVFsAdSUMbJuUvAqjpIjDKOuyw54lOIiapRIfgfsYvCMJZ1/dJDefbHcv+A
 //AuDRRYv6xCJPbRw2edi5upIUt5uPgbC162T1yBVA5eXzxZYPHWsrGLgaEGMyAXqP07XyaoA5O
 eVj0oE9+CJxc8Gx5A6uE8cTigsRGNbZwkbfbeSTRrUfyowdmp2d7o58lNGNZRJcLSxVgq0k+lJm
 VJgCXXQ6BF3SQhz3ySw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX+yJuBQ4n8Ggx
 l+aYmtizKtNfyz67Nj5BwkiZ8h/ct5L+EMxYDM0qsv6WVYsOlkU7hLa5CZ8NHTqQ83EYcqZw7rN
 Lw5kHXQoycTVTE69a1Jb/TlcL+pG6OA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180005

On Thu, 15 Oct 2026 00:22:15 +0530, Amit Machhiwal wrote:
> A previous change ("KVM: PPC: Book3S HV: Add preempt_disable() around
> virtual-mode HPTE bit-lock users") at [1] added preempt_disable() around
> guest vCPU HPT hcalls and page fault handlers executed in virtual mode.
> This ensures vCPU threads cannot be preempted while holding
> HPTE_V_HVLOCK or the reverse-map lock.
> 
> However, several host-side virtual-mode paths in book3s_64_mmu_hv.c also
> acquire HPTE_V_HVLOCK and lock_rmap() in process context with preemption
> enabled.  Specifically, kvm_unmap_rmapp() and kvm_age_rmapp() take both
> locks during MMU notifier callbacks and memslot flushes, while
> resize_hpt_rehash_hpte() acquires HPTE_V_HVLOCK during HPT resizing.  If
> a host thread is preempted while holding either bit-lock, any guest vCPU
> thread scheduled on the same CPU spinning for the same lock with
> preemption disabled will never yield, resulting in a permanent CPU hang.
> 
> [...]

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock users
      https://git.kernel.org/powerpc/c/4e6e66ecf62185828f731914000a6b0baff355db

cheers
