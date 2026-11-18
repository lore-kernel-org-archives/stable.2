Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966322;
	b=aarJ4UpqryLz1L2oTyaxz/SMU+K4zVFNXlLBCnAhBChVqVzxmaya7YvnPxH6C78T43YH
	 mLCPPTWv0o8B52x/jCpfYxCDKv9TxZus1MuSQM/43w4W9+c3XCsy6ZG6zijn482SjeTBO
	 ARw90VUhYYN44OxeW+idFUG5WDhABAXdgl0Wpp6G519gbx578VY0DU2kFczporKTO0NKW
	 pUcEGZj3enTWHD+gdgYr2AWj7wapee9/DBXq9vqVgyjG2YbUAk/8MrJabtkf/Tx9xLdSk
	 fQjO2cianQW27fXTIHEvvtp3a3CC5o6Qf1bLzQTZny2t9bbGg7VK8dAvjdvdtsyp8jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966322;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xy6xJHSs+3xv0hTa769rLPV89+WvX7mv4MSqSuyFZb4=;
	b=v1IyCamhKKniiD/1DOp2aUDRo5riqi+IcJq404gBs0B29RlGlOB7bUMrictcEyjYKLdz
	 y30lEICmFvOIk2mKK5CEQr3qOQFFWiNOp1RdCWxaMjrJa2943+9WrV+ApQJwA8HEGvTqn
	 HwkB6sGv2NfTq6jRbNATTtclfgMfQzlsBX1LKx6O2I8Mj5YMrOb3S+i5RqKb7a9vL/N8+
	 V0OuOk3ObuuNglqpccBymyZhQKcqfJMNYg5gD6j0McuEp/9DCGhHXahKAUT6wxqsSHXCK
	 ZA2Wz7cZ8fi8yuqjEZRwKbh9JBcTcQemAbhfCWlO8rb8kgImEHr8yFKtcnR4mPALJIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P8OvUAUi;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFC606A32A;
	Wed, 18 Nov 2026 01:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77AFC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P8OvUAUi
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMuZKV3803105;
	Wed, 18 Nov 2026 01:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xy6xJH
	Ss+3xv0hTa769rLPV89+WvX7mv4MSqSuyFZb4=; b=P8OvUAUiEbPndq+VStbB7u
	Bbgh5FxhOWchU5O1JuhMo6hKSKaPh8m+BXfME9kE3bNLSYE9nP4I82juxAm0zq0T
	c1UjAmYM8KALQ3E8EnCj3TgdztvdPMFRxg7Bf1UYF9qDpdb0J0Ibk1txpvnI+txV
	Fc+E1Q+GOOuZSovXkxwv2AVa/9m8sl06tLrmDDTUOKw/QTnVp1fF+0S1FgCGxobB
	+9amvV98PJI6bjyE4Ar/Ojuc80g7sTQRkb6VieCZHx6N8vVAbZiU+Y70fJLSCRJi
	/pTfzocJ9psHAJDnDK+lwSpxHT8b+sB3Pi6yjs47KB07H0QeW7OcPCACOTLLxTLQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n8d60-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHN4r3N440908;
	Wed, 18 Nov 2026 01:45:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvg9cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1j2KV37224934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:45:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AF842005A;
	Wed, 18 Nov 2026 01:45:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CFC42004B;
	Wed, 18 Nov 2026 01:44:59 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:44:58 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        "Luiz Capitulino (Red Hat)" <luiz.capitulino@linux.dev>
Cc: mpe@ellerman.id.au, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/watchdog: disable watchdog when watchdog_thresh=0
Date: Wed, 18 Nov 2026 07:14:57 +0530
Message-ID: <179496619904.633156.5886261180502004676.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261104034018.2676750-1-luiz.capitulino@linux.dev>
References: <20261104034018.2676750-1-luiz.capitulino@linux.dev>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfXx+kL+CqxJn3i
 3JLqBldCCc+Co1qM2hxKQIP8cvlCjK0VkAoMT/3APTsGx7HfxdOhQs+X5gz2fMF61xK5ZCO0/dq
 djQMaK6Xb6u7uHWw4L7wX8b4ff+rwGN3yhf6XPMppBCj9A3gBLUr7ru+XXv2WCQaEF6bgF+Y0Xx
 1RjIOdJwch/nrCbGbctcQgqDXs+0FaL1fSs2blIMrITST772bsBRimyiuPRpzil28L/fWL/Li/L
 q70C3TmzBZMVNR64ZkXneRy14WlrUBbNd13UQegaCOpk2yOelsC2GcmBzxRMdFgvOW51SxMHlec
 TiyKlsh3zPbkbA8KQFOEWvhEGf2RmoZPD0EzCfOnJsP7UPBYla8xs5uvEbUDh1RFaqtFzwPcqCh
 S2At8jgBVcjjQ0mqiGNoug+yJ99AXGHlcexrQUulOE+KDvA5MVCNCPKbpZfuqsvclY9iPvqX7H9
 63ECPAFWUEiV63bKndw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd0322 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=XfLR646rRCGFvi2gcZYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TeVO_a2RWjO2IFv6yLkg96AJea2N5z_4
X-Proofpoint-ORIG-GUID: 2hJsp2E0Ppy15eb0WNi8hNYuq6FmzvEe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX5raUkQMEaApe
 28A77eectKr1wNrsR3M9IlLSKtlCHH1ih0H7JFCk11zgXC0kyxMeQgz/KKCR8X+sg3159Oj+S3n
 lSzanzMlywp6GGhOr2/S6ufCDM7kWog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180005

On Tue, 03 Nov 2026 22:40:18 -0500, Luiz Capitulino (Red Hat) wrote:
> On powerpc, trying to disable the hardlockup detector with:
> 
>  # echo 0 > /proc/sys/kernel/watchdog_thresh
> 
> causes an immediate and endless hardlockup detection, eventually leading
> to an unusable system (splat example below). This happens because
> watchdog_calc_timeouts() sets wd_timer_period_ms, wd_panic_timeout_tb
> and wd_smp_panic_timeout_tb to zero, but start_watchdog() still starts
> the timer (with expiry=0) in this code path:
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/watchdog: disable watchdog when watchdog_thresh=0
      https://git.kernel.org/powerpc/c/d513ec3c907b067d4a32b14ec6f73c3e041cb136

cheers
