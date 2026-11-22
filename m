Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323334;
	b=mtQe7uyGuvWrz86wY492FgvsXcQXRVU2mjbzKL4irJJHwxrKrC8O1RxixZEKlgByyLWr
	 Z3e1BczXZAODE/L5DwwyilvmlmM7QxJ+dz2IltUnVW/QABnQtSdA09xfpaikzMUXPBZp3
	 vzFsDuOAOcRHdT2JikCS9BMLzIxh0P1v4D+SImYUCTVRjmb+Va2GnyjEgK8ZH30orBJXc
	 DniGvMGNs5X2iNWBqazDqdp1GR76hzIRefHXcxFB7ChHpdy14ATYQdBZnMJVFOjO75auW
	 W94UqSjNfsKuSF2dxdiBC2Ojz7FyKfbk8XpIkOwYhLIXXv0W1D9QlPpYqdvlH0YsBuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323334;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=thwpgcBtCakbOmTmxUAgaX82W7RbYJlWb66owgXNdUs=;
	b=F1x2durvfGkW0zdUfXC1AzxBr9qOd11WCnjfm8JCGAq1/IGQ17KK0+Z+JxOwjHzRUDC+
	 mFs56nxQGe/eusTg6v/McV4GcszqtxGydgwiDXHfX14oU59Ba8/r5u+b+Lf0CETG7umie
	 lC7zcX58ShtTekrpsCe0s80eYYnxkPruIKzHWqpMlrM74VPOYbGt3eHjUktfNH4F/vV3V
	 scjwN9l+hIwFKu2omanWnPno+/ZwIM7mXRHNgGY8X6bwPBLUa4NNehaeUkh9Xh/pAOpkM
	 okEG7QTXiP98P3PIZON06skEOLeaSGNidfhm71YKrkSyQycY8eyQ7NEC8iQON5cRffA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PaTpGKGW;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F50606A32C;
	Sun, 22 Nov 2026 04:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F50606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PaTpGKGW
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44qcc2469945;
	Sun, 22 Nov 2026 04:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=thwpgc
	BtCakbOmTmxUAgaX82W7RbYJlWb66owgXNdUs=; b=PaTpGKGW3q9eSzH2kq7+RI
	pN35uVIJSav7sVVNqZs+2Nu3U+o6e8UUjozH/cbRi60lCW9bAfiLuQS0/mdb4kPB
	9SJUFQwXvP0h/U9jQPhl3HFJlR4tNvikpZvyxOKwgseNWm7L4p3pbBf/cu5IIYJw
	98BBVIU4a2T6XZW1Q9SAsgwj6YkIihQuLNyt2m5uwJosD6onkYc6Xtr3U9MXRVeS
	/8avab2LGk4kWI0klpZ7Th6o0R21KgTzUjWKQUTl4JLfwVOftFPD3cqjIOp0yalF
	PpGMXX6PTNXOWgwkOwl+DVE21f7MXv2yxFg6mQZunffO3hlmAZhmSnwQPfryXHuw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p44rtm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3nlu8811059;
	Sun, 22 Nov 2026 04:55:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h0hk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM4tDrs52035980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:55:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46B5B20043;
	Sun, 22 Nov 2026 04:55:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 486E720040;
	Sun, 22 Nov 2026 04:55:09 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.90.96])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:55:08 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/xmon: Avoid unsequenced accesses to tsk in show_task()
Date: Sun, 22 Nov 2026 10:25:07 +0530
Message-ID: <179532322369.92012.8619272472025580101.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115-xmon-wunsequenced-v1-1-42ae3fe45bf4@kernel.org>
References: <20261115-xmon-wunsequenced-v1-1-42ae3fe45bf4@kernel.org>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfXwJ1HDbFa87mP
 lqAvmrNAu6+SCIMPWs2wjQLQduf9MM7DDGMNlB0HeQsqVVVc22KqZmbsQZWo0/U+Mugx1cC6JmX
 4Cz9BDRMLDKL8FkKeqvZkaDstmQ6mbk=
X-Proofpoint-GUID: OYydPgwM-ZzYhCyZHv1QZkly5bhoRtwl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX676fR8w4GtMf
 PGRk3jLdcQaFwSLNxGJuRWtP6EFvuFwRSmiyI4uWrjFB93ziKOURnygSC/aVrcuoGZe7VHcT5nY
 rgd7H9/kN/LyS5+Q4W14MpeZQdw4a4NfHlzijRLIcCYBwxynMCtb8NY7tB2uCCe8hhFerZxxk61
 YAoWu5WcJ6HhwlIoUJz6GXXguBKsEq4q3VEunkR232h0NJ/5JcSVUcC6AFwJHZyZTS1+ILB8ZKg
 U7lkVgsD0rOHDt8UMdUfV0QhyOfTl5cnvLlItSJB5ntreNiIezoqSPB6PYLAGXALvH72YrC21sm
 8Kug7H3r6hO09GnjtB1TleReNp9eOQmI7z88N3rpnmcKZwdPayidkk5epIW7oCJVEzChnZIUeV3
 zKLLE8b2LuxsRkgjo4pKsugQ0qNGYTBS9dFicy2OLmoMda1VzDJOgMQ6B9RqzC7UfZw4Xx+VeTv
 dBTH4529FbK2t1d4rTw==
X-Proofpoint-ORIG-GUID: 0hUo7JWjhDyHlCGn2rfsBZ7-l8O6dy6x
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b0275b4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=2oOorpea6NrDkEfdVwMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220018

On Sun, 15 Nov 2026 14:18:07 -0700, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in show_task(), which can
> break the build with CONFIG_PPC_WERROR=y / CONFIG_WERROR=y / W=e:
> 
>   arch/powerpc/xmon/xmon.c:3262:3: error: unsequenced accesses to volatile qualified 'tsk' [-Werror,-Wunsequenced]
>    3261 |         printf("%16px %16lx %16px %6d %6d %c %2d %s\n", tsk,
>         |                                                         ~~~
>    3262 |                 tsk->thread.ksp, tsk->thread.regs,
>         |                 ^
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/xmon: Avoid unsequenced accesses to tsk in show_task()
      https://git.kernel.org/powerpc/c/9ea01307e6c824eb0b8934d95d52bbacae17887d

cheers
