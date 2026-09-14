Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282593B0AE7;
	Mon, 14 Sep 2026 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370501; cv=none; b=qLptgJricnrZ7OJJomGKxMNyWaumDxo/uNBqv15m27rhFhx3LAFu1Gu5Wc9HBQFM40kqk2ezdYPIwlyfzCuhRd7WVGWHcXrdzeKzTSZMEGFYCnzFe8x3lATMfENJ6AVRbBA8zZWtWhna1ukHgsyXzxM/szRdB2rInzxXL86nRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370501; c=relaxed/simple;
	bh=CeqCwB4utSXB+w/N3KGLmyefG+SuUJSVkxFO4em5gog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9ZNDDUetX+6lEGpuykEqIrATix66KBLmPaMmcSuV7TK5BvoROlFIpT2gO8Igcvn6l6FUyiV9hIh6IIqlmE6z+AwjQuXlUSN9VzuSQUUW8PFkWz1hRQvep4WbSiC1oLgImXuoXJ2Slw8HBTNE7RXVO7nWUPtWrbvGqZaKI0EJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qz4mXj5P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qz4mXj5P"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E61cs81243088;
	Mon, 14 Sep 2026 07:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hd43wX
	kwN06QPvygSuX05VSZMVrtZafK/VMRVp/tNMk=; b=Qz4mXj5PVVegwcxVBw5ENv
	SdDVM0U+j1ip/ukhXZpFIIkkW0MOeYVmbjnq1s3fPGDedxWPvg6gyglKlWme7Xoc
	xvhAAoSpNkxmh51nh3+bp1pMYrygBpAjUBUJK1aDjTZlWPcki1mu+i88jR2IGaCt
	7jPOAfuNmGMd+rGIog48cIR+K7MZKhIvMZskrs2J/cEMmLMpIK3R9MsLFNbM0s8z
	QQmMGZ3wcfoNvK6J+FTo1xkG5s11dMk7pRe6sUwFDiWB1+Oax+ks4zIgnJKD/oA2
	mSKnNLfJaekqh3GBeju+T0IHLsVR6i2I67P4ADf35/IPxUZ7Fe13zKCR+UKIwzrQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcuqk8s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5o6KM1751657;
	Mon, 14 Sep 2026 07:21:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnj2jvk60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68E7Kw4c32965104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 07:20:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 365CF2004F;
	Mon, 14 Sep 2026 07:20:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D62BA20040;
	Mon, 14 Sep 2026 07:20:52 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.93.83])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 07:20:52 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: leixiang <leixiang@kylinos.cn>
Cc: seanjc@google.com, pbonzini@redhat.com, stable@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Suresh Warrier <warrier@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Set irqfd->producer only on success
Date: Mon, 14 Sep 2026 12:50:51 +0530
Message-ID: <178919368040.441103.17640401400836975796.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709055755.31297-1-leixiang@kylinos.cn>
References: <ak59frQUBl9Gs3Qn@google.com> <20260709055755.31297-1-leixiang@kylinos.cn>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX/OSjqh4Hyfq9
 ysTVC0+y8xyuP6Vh7NuWNTcDwlpvZN8bQ1WNqBBZvmJkZMtZArwh50gKV8iEE/MHHaxan9QE0QM
 lzrTEo4xL79JlfeyG9jO42kGI3PoZy8=
X-Proofpoint-ORIG-GUID: o-9M6jW4VltOCLoYxFRp36SN05Fh8v67
X-Proofpoint-GUID: opa0Df-h4njrn0h1niVtQ7wHVyRfMB4j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfXyhiAkVXfvuVX
 CbqWED9hWuqTkWBqfAiY1UoArWRSC4anuQdD1ImVzU/jWfLWF8W1tfp8Qy661TW8a5oVFQmidXB
 TOK3/O7yOUAGXmyX6Fu06MV0SIu91tYsvgmzQCA4ga3tb3urOCfRLHbUSnQANAiH+krh+FXApQP
 QLOGxgR3RZFmXBFRqkUZK1Q86VUqQrgD5NqPZ4eGsK1iQ7yLRg4XEtq56q+89jrO2UNCEggNseg
 2SUx6PPsUusqXUuIYe+niOwVfCxHroDCYLCZnkqAoKowv7j635lUByCkZvMnISJwcNwVRvEC72O
 8ARzZJqsEd9+pLYHDt39PNn72cQFSoQvyGQ2c0KQC2YKDkZ8muu1YjNXY4hCSI3XrlFpcXjD/pL
 APkgtYsWnJGegG198GMk8LF8J0QApLZNMYtHOYQgSM3Yvqp5PuuzASHCAF1sDUhJIS2qo95wRRz
 JyLx02Si+GhKCD6WgDA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa7a05d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=f1hmvgOKX2ZYp0PRnOwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140098

On Thu, 09 Jul 2026 13:57:52 +0800, leixiang wrote:
> Set irqfd->producer only after kvmppc_set_passthru_irq() succeeds to
> avoid leaving a dangling pointer on failure. The bypass manager does
> not register a failed producer, so the pointer is never cleared.
> 
> 

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S HV: Set irqfd->producer only on success
      https://git.kernel.org/powerpc/c/1144454ea22290d7c6998a2af6239e5995476afc

cheers
