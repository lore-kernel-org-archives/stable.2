Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55F3B2FD9;
	Thu, 30 Jul 2026 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390148; cv=none; b=rq10tnZI9E3RjHUiZTU3tzbR2GiHHoJ/GpYrSaeBCZ/pWvV+xIpLZG6d9q8KTRGaw3WX2Y7qfjTzUD85XZKeTegEcxiFs3Io6jGxDzUImFRL1QFYCDq9alB0yU0lAaeCHevsEr4cr3b0K2juzMb19qjN+mJRzy/n7kl+WVP6/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390148; c=relaxed/simple;
	bh=LX3lTysDj0GCPt9ShJvLPDtCi2kVt17N/tE9rh80NWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZM4kYJFt7Qm267xzEYr7a7E20Ktq7xuaOT9pGwNHQmrSVEwUP9uPeswPJhCQSXDuivDiDDW0pP8Wz89j7MEWXgrOIeFueqGLMfw74W+2nyPjp4M+TVNFtdLtHj9DOWUrlS4pbgMagg0FCSpQA366ImhwjfpipwnRSrqgNRh0kNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AtqUUV+V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AtqUUV+V"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mOnO1934610;
	Thu, 30 Jul 2026 05:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sTtMqA
	rJG4JpnUjhsN41gYysOstkNID3B74E2DDZ7/A=; b=AtqUUV+VZsMu/hMUivQu/t
	nCP1xixrFUGH0GBhU9vRDYBdbftSG8DvAge5AH0oG9oNMW2Q4bu8gMXOU50MVnrA
	hG6VD0U7ztd0UovFAbaoMHECC6DUj32ATcWmALy6Nxw+46PknBKhSK73SFm7d7Ae
	fYRnihnt3jbGt5kQeq3Px0Z2B/cQZjLCNtCRXflVB4JU5PL7VmBuvPvnMAl7bK0n
	4L22HgTNliA7E+QN17+L8mJ9qf8fLaY0djDQo+gIa8J+jXeF6lcaAEK+ZmM3Qvnf
	R9nXOq/v84vtq/xBPmwo6BDmTk/ClQEaKlJQR07ysW+qvLB5d95vIj+sVrrwUAWA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xx7c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fNps002059;
	Thu, 30 Jul 2026 05:41:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pghrs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5ffqo28901746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1D1320049;
	Thu, 30 Jul 2026 05:41:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDCCF20040;
	Thu, 30 Jul 2026 05:41:37 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:37 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        MOKUNO Masakazu <mokuno@sm.sony.co.jp>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, Geoff Levand <geoffrey.levand@am.sony.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Date: Thu, 30 Jul 2026 11:11:36 +0530
Message-ID: <178538948395.1278583.8213797923163532794.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711130931.740719-3-thorsten.blum@linux.dev>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
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
X-Proofpoint-GUID: SZv8Z9hwvPsPhzrn_mTgndZOnQM9W773
X-Proofpoint-ORIG-GUID: 2dffHeDNnxgAaMRWEhZdI8H9_XSXN9ad
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX9XO+BktGQgFa
 iymJ6sfCiSTyZd6azB0lymWRN+5q//SKOy0Z5BaKNCtpv8SBVH8ydRDBEjf1o1uWWfET953lBoF
 AWTjuxPbWvJ/2LepTcaBX7oais/LGUw=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6ae419 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=IW7kSglj8ZqiZljJpVIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX7y9hP7rYLMDH
 ntBcXV8t9yVf2tbz8RJG5oSoLMtjORS0kqJTO23GAkjwq1EFyn4H2TXXWpqixyeV7oZGvTVMY/O
 oi39JAOPYUtxAfp69zJXvqQ9+VXJvw5zrVC1eNRmKV4yi/UtOambB+/8QiRdQ4VUvpVP7IRna2U
 Gkqzx41XR1JDMKCVPaxOdCPjinEvjaOmjBAP5kZFIZeLk6HvRY5HOkmTrceWkbnfBDhiTeMwnRe
 tLu2igwRZjTujAxncP+gKeW9iLyJFKfFuYDpjFGYvNZbP09/SeYpP9/FawRJ1JS3Ak4xfM5VOLB
 gjR+dTGSCifZULdSrIYVKBgaSBSLvN6MQPIvIdg79OZu58LdWvtVUy3wVjzqqeaM9GBgzDMYHGC
 aIZGWbzEfeMFOM5gKGfeucQtkOMgm36Vuo0W3t6k/VP1ZYc5bJFJUhSF5uCWe8Si8EPF2Y29h3n
 8FZQDNykKPgwKAfzdDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Sat, 11 Jul 2026 15:09:32 +0200, Thorsten Blum wrote:
> If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> decrements iopage but keeps using the failed mapping's offset. As a
> result, it repeatedly tries to invalidate the failed IOPTE slot and
> leaves the already installed IOPTEs valid.
> 
> Recompute offset and invalidate the installed IOPTEs instead.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
      https://git.kernel.org/powerpc/c/0bb024f11d120abff3e8db9144a585b9d7fb8459

cheers
