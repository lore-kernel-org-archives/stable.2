Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955E395D8B;
	Mon, 12 Oct 2026 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775906; cv=none; b=gORKanJGnC295N/8JGXwQ0vDiDn0csqFXfqE1lIvXKmbW15/04aI1VfukQh91uVazilOCkKftw2csHaRzzwSsjeBm7zgckoCpqysxhpN+qz0gSeNsJDTaTgn3UWda68oaOl94MXfdLloM3T1oqfUi31TQ7AOjNvP9eDoNO6Mg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775906; c=relaxed/simple;
	bh=yEk78BFdEWjGsRY7o9eAQq4BaLG+BDDUtopCI2v7/aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0AgCFmVnPXjjVpXJ9JCxsOTN93XYvWxootG0ki9Y4YPXeQdL1VjZbVyrvzufAMPLC5836I3+hLwYZKwSH875XFbN1weHNFfA3DrqVLJ6xnMMemiSwiFoUJGdIOiQfqaiYgNu4smyR36GgVjgR8lXi4qTnQTQc/8ZrihUCabD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EU0s54rZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EU0s54rZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2EeWq3156732;
	Mon, 12 Oct 2026 03:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T+SbBR
	5gX/WtRVsS4FVkIfpd8oxF7wqOXq5potRnwgM=; b=EU0s54rZ1iyJYu1J1v+8Yi
	GpoEZDHKqhMnyJ/QACfp423xlOlx2+TFZis2gpFTCDiL7ep/OlFijNqHR+F4f57+
	+YZ/KwAMMU8oXCzJqy8BHeOyG/PbqLRNy/ffo8Oth+woFwkJSQCevTquE9ui5ZeN
	UV4xxOmOOd/GlvpRzOKVSo88GdayjITFIk+r8cwjLfk7WUzwgcmOOnVIOSuUkcPH
	Vkjq4XEBBSfzsocI3EkY1Q5NQwJEw3SYvutCkwyAxVv4f3zEfvIgFhpCpP5f2yMQ
	UNfQ/wudm8hNWuOudm2fAd/Omy5USuZ9+x0pjgpecgU7zwE7cTKecBjCROGoulNg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug70kb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1nwRV522102;
	Mon, 12 Oct 2026 03:31:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjkhw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C3VG5s40239612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 03:31:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81B9E20043;
	Mon, 12 Oct 2026 03:31:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81DAE20040;
	Mon, 12 Oct 2026 03:31:12 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 03:31:12 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 0/3] KVM: PPC: Fixes for Book3S HV HPT locking and paired-single decoding
Date: Mon, 12 Oct 2026 09:01:11 +0530
Message-ID: <179177344611.763259.8666438787088008833.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928122837.8782-1-amachhiw@linux.ibm.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acc5489 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=OxHsgNImaD429JQx8ZsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iAjixt9z5N4hr9Tjob1PHqiFKs9bitHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX4cNdI810VKcb
 rjqrBOTpfHz/m5HvJoqilhbO2sJgT0KvSyw+XoqCXlyaT7uuPF8bXXXPYHraYKMFWdyOQn8VDBa
 v/hbcIki7nmYw3MGa5ABspBo4YFVUWLqZE5rnJ3DeJ1XEoDJnS6iamZI4S0FjCbKyLuS4C0pCOE
 mKhD7FSKyGEwK11MU0da4RKlgbTto8ckRabPIMPfjGo0P7ncNAU23UA5/gCaVZziF26f/dwI2eQ
 bClUH/CI05JAki3jq1+c/2x3f5ScMDI/z3DHoo9RYa0cJ6OVu3iwnw6QpesyAj8PxbC1IQLXCrS
 Blmr3yrlpxguxa3BlqPivAAZ4iumLhAuYFtOizR8kPy2BJ72h8d7ZL7tEbWAVqoPZ4lGpjSrEax
 miG435g9TI54+hWg5IVvG1u/RxUggSAQoJdIeaLdW2Ne6WL7GF7blQCcY+0jnEX/PF3S2Ik2shS
 LgCUn4YNAMH4ErKNhfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX9IJu/2BT72z0
 C7A/RDZc8qEo2VMxh9FrHOrplLh447M30TgWdZgJdCWvcjYEwVxjVXb06GNqXHuVnLbBfvDYB/G
 YdVssvqLeHuZPSMtgnIFpVQkSaBDp/w=
X-Proofpoint-ORIG-GUID: aU7aU4v3p7_5lACyzVzqyRiIjlLGp91O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120012

On Mon, 28 Sep 2026 17:58:34 +0530, Amit Machhiwal wrote:
> This series addresses a few bug fixes across KVM PPC Book3S HV
> locking/synchronization and paired-single instruction decoding:
> 
> Patches 1 & 2 fix synchronization and preemption issues introduced in
> commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for
> HPT hcalls and page faults"):
> 
> [...]

Applied to powerpc/next.

[1/3] KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
      https://git.kernel.org/powerpc/c/61a39797bb136243c48b46e2586d8a9e2cea6a89
[2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
      https://git.kernel.org/powerpc/c/abbbe5ff83e7c9ed3a4d61b73011f1df7bf87907
[3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form
      https://git.kernel.org/powerpc/c/31895b0ff96778b524c74b43a108090581271603

cheers
