Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455037C936;
	Thu,  6 Aug 2026 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989798; cv=none; b=gJEZ+tewEbfa0+zBSbcouAE+ahdzbMABfYgZFgVpIKrU7BkytjJsrkW371aXxygwDgMxmT3ZSp8znzDWmIYAiKqQo4tejaAMou792+qRnJlzLWKOGsAiVnsEitrP2OsLyWMS0y6xh4xNAQpSnkUbK6TvQ8ZgMHgzKnrJvnu3hSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989798; c=relaxed/simple;
	bh=aonavSPPzSKWSWIzgorxjZy6QdfszdKkdWlyMVok1xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbygW2Timatko159viQDZf7cD6LfETbUWNQ3nif/ce5isOAcDIPb3+vNNoYpmC7/X+v1BKJ6eS2XQfFPPY0QKjp3qKmys2E/Ptzew3W9eTBhms5NLWfp3eNssOLc7cuknMtRbqBtpaOp9trVZXGMlyG1+0Dks3LJPuE0zH3eR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JOW7d+ZS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JOW7d+ZS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmgiK3405018;
	Thu, 6 Aug 2026 04:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gwoisS
	9f8oHQpET9xwSYiXFQBqMCffMU7etaY/y6jFg=; b=JOW7d+ZSa6aQvlYFZzZciV
	UHAO7PSt1TvVMp5NNyPTHThZDwMTS+2ChbmCFXJJi5M2Tm9cGnoGteDRdoEROh6n
	r2vnRF0ZquvrS6k+0XpnAIa2yXXd3kQfXte+WBwC2xU1V+qV7JAU1RmfCw80jdE5
	fuULCdy4tWJnc84xNaCGBGBwV4+Y2TZBsHMWmDHAHAGubwuHp9Jo/muKnmCglKuY
	v/Dxb4ebxKih2/yeMUqmisVvZ4Re6fiP4XHOq0l6JkM2O0IIqCsRifT7zhfWZpm4
	OMFX9w9U2YFeVV6GQG/vc6KiGYHxJ5VNY2aOAJj87qDXcsDSap1x8eFSTHj9Jk7w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqx6wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6764BhEJ014944;
	Thu, 6 Aug 2026 04:16:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtysc4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764GGBu50987436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E13F2004D;
	Thu,  6 Aug 2026 04:16:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 127A020040;
	Thu,  6 Aug 2026 04:16:13 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:12 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Thu,  6 Aug 2026 09:46:11 +0530
Message-ID: <178598971868.942627.13563864143431021257.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714175432.86388-1-amachhiw@linux.ibm.com>
References: <20260714175432.86388-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-GUID: cMzHl71MJqbAP-O5G5d2k1UJdLPCKwJI
X-Proofpoint-ORIG-GUID: VnOtkgwKa7EXPHTUs3O76igTzNqCEfr8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX+CDwA0DtstHu
 wmOjlQnMrQUBldKYtK4aKI4uQTrzJUqnb5FWvhD3lrK8BZGiSpOM8qEoCsT/rwgyEIsp3J4NPHn
 od8keoZeKMYNnpLIVdmrNk3K7s09nkA=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a740a95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=6Bqhn9LhGV_-7FDKSYEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX/Ri12xQvd29K
 zRD7da2RYMScQ6JNcfr5utN5lUCIa+eaJhDNVSIw2UdSjxuqbpl1IFJBhrypWFwFRNMclZ6lbOJ
 m/eY9KB5LyVhkce77mUV9yyZBwOrKlTfUJIdC612u3nwK+wcj3NysVcYqi3pQCQlR39Pnoc0mc4
 YlL3b0+94DGcwaRk8+Rfwz0jDsnNaKgvBr83rlqJLOzAfDCeQvf5IAFKBNj26uOJTbQxB3y/Z5l
 nbaY0jU6h45PUSDvy54oP8HU7+MwyzviYiAeQQncQLHRDsVfNZu7siV41y4a0vzXyBgF5wEHRe7
 /KOdm6tZUb41VF6Kuu1VKD1GAuLWsuAunOtncrnGrBUqvuaqTFP8IutyJxShhLrHkjLY1pbFp5l
 nlRWLh0O/akLLiQsUjoREfmHajx7eyqmYoSWWdMFmqAvFFkqVCeBMwYKDZ4bWP4mRX4yDRbAifG
 yBGM4ZvUIJy9DmrJzRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060025

On Tue, 14 Jul 2026 23:24:32 +0530, Amit Machhiwal wrote:
> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
> 
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
> 
> [...]

Applied to powerpc/next.

[1/1] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
      https://git.kernel.org/powerpc/c/884ea0283f4effac97ee8f451464a7d1be480d7c

cheers
