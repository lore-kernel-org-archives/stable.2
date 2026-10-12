Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EC3932DA;
	Mon, 12 Oct 2026 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775916; cv=none; b=kEykwxJgPZ1CdP5US9cvmpWDLhMISylKi1WrmQriJdDB9eyeDmbnfDP4/BholFImQpWJlvTAYMggubnjInYZ3xGdpFVrMvweuQ/GzQmMApOkfsRCpeesWuiiAOitXcm28FWisjvAeYCxmkDAudpSaVqL01cL9VXlSBnLUNJx1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775916; c=relaxed/simple;
	bh=pUx/u+ewmePs6CGYnzFZ4UMZHVfgyQmJNQj3BtH+42E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj3nxzU9VrCUToyHNnV/nC0vC0kx14A9cBQrtLcCVGWwuixwqTyxXD7aro1boiLIPpLIoSWmL0pP67qHUpmzMjcaTLVwiDel3WEXfNB3143woeGXoumfLxFU68FpL5GZ5+yz+WCiVffl6GdDGWoWyKL0BNpBTZASq7WEDaRU2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0sfyZSx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0sfyZSx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2EfNr3017674;
	Mon, 12 Oct 2026 03:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ytjfGa
	FasxKFRVRaAiMZ4nRRUtTJ4xxx7wJVG+cpLYU=; b=F0sfyZSxlPxPwLgn7WMYmo
	VSkD232GjPh7UVOyfhtkYKGLA2/OB6zo3pWu1boCtKW1+RG7qWT/3ZpXu6ZakNfF
	3d7gwJ3tWi+wu4evrYYJR/f8GTDLl3QBtgTw4KaYKY8G0eG/OIG+qMtLYDw4+fO+
	hsrfdYESfW1ERidTvIHtriJDf1YCqmDAP1KhANqYQ9x4ADrtd7BDl5ZB/WRRPEuK
	Hw2H2N9WpXShL8foHBFvjOyYoKMddikj8pAcA/PdbHcrTZIm6YBIb/XJD57YfmkA
	8L7B1JByQLC43DuIhP5IPsUVJrwPQz4qAj0KDbe/mgVS/1DzhCtoesxsuREAnfqQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv370bu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C252cT563558;
	Mon, 12 Oct 2026 03:31:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vknrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C3VVlj49086938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 03:31:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A1272004E;
	Mon, 12 Oct 2026 03:31:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C1020040;
	Mon, 12 Oct 2026 03:31:28 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 03:31:28 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: hbathini@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
Subject: Re: [PATCH v14 0/5] powerpc/bpf: address missing verifier selftest coverage
Date: Mon, 12 Oct 2026 09:01:27 +0530
Message-ID: <179177344604.763259.17482742440271847221.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789982239.git.skb99@linux.ibm.com>
References: <cover.1789982239.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OXpZ8aF7X_uM02GK6JY6Y7mnegw4Ghv6
X-Proofpoint-ORIG-GUID: OXpZ8aF7X_uM02GK6JY6Y7mnegw4Ghv6
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acc5498 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=ydiBeFUZ71z4b7spNMUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfXy+fWT1PX/84q
 AJ0tuj9knUr0rK9R9fXqIRxxiGdcwUDYrB/mRedMkHyK8FTfg0j/1i1yaX0XLcjfNpa0LBHWzZO
 55L6tf/9G32ypXka4Y6EtG4LQ3N3XYE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfXzhvhtCbnDfY1
 OMUR0RkXX86s6bZ/xgptStJ7Dhuh6Zf1ijVpExyks2Byv6DzaL2dfZP1JJwhEqvqn3eVVAtpplU
 m4Nm4xvF51nudz8M4VyBLAVoSsUeE8ZB5CEGQhwOxKDbNl9EbB0tQsFm41KK7DvDwyG4Wjf0DxJ
 L0LXqVqu8diX1KGSNQsWHKy+VN+96trhpMHej5QX4QXySraAccgrZahF0JvpbF4FHm4O8JqzoQD
 pC59AOlyBVlvJPamWGIdu+W5Od9rEbLTlffg2aRudrNstusp72gvcypk2PhiyeSCv2U4YnHZeh+
 biCWfgRbGPhruhx4Tn+xFmpifiaFpFGz8DmSeS7DaD/UYv2S5a/6T/MBjOFUZifHg2xlE+EQzrO
 o6mqH09k5zZ0fA+WlI42foyg2a+ZlmmbFzIN8FHgCxfiFHW/yE7N5uoiCT3/IbHknltde2FpiLD
 BrKWBjjZAQF6PjVypbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120012

On Mon, 28 Sep 2026 10:43:49 +0530, Saket Kumar Bhaskar wrote:
> The verifier selftest validates JITed instructions by matching expected
> disassembly output. The first two patches fix issues in powerpc instruction
> disassembly that were causing test flow failures. The fix is common for
> 64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
> architecture tag in the third patch, enabling proper test filtering in
> verifier test files. Introduce verifier testcases for tailcalls on powerpc64.
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc64/bpf: fix compare instruction emitted for tailcall
      https://git.kernel.org/powerpc/c/3ebf4ae6d8afac11fe6732418dd378e031f8f4ed
[2/5] powerpc64/bpf: fix percpu private stack leak on JIT failure
      https://git.kernel.org/powerpc/c/24affb84d98e6b37b276aa57e5dd25ad93458cea
[3/5] powerpc/bpf: fix buffer overflow in JIT for large BPF programs
      https://git.kernel.org/powerpc/c/78ce55b7913a78e1687306668e078b86bc6508ee
[4/5] powerpc/bpf: fix alignment of long branch trampoline address
      https://git.kernel.org/powerpc/c/04001e8ddb979f463f1c3ca8ac4d6ac59fb48921
[5/5] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
      https://git.kernel.org/powerpc/c/6652b9941a6c9b6814ca6d2eb153dbf162b89a02

cheers
