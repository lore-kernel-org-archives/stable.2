Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E741F5D5
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006296; cv=none; b=MPDMXdj6MS4EbazsYGVf2J8R6fsmvIgxeFwb4jLPejbJEp5xGbmjRY4BXupkfpWkTeVfvKmJvzWbv5/V4b6fOvfcy/t5p4GG4prsooJhke9dblOgzpqDhfBTBoQTGs74OaBZEYvILsKjdK+mjYbwSNdF+Kg265McsCHDuqGcpFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006296; c=relaxed/simple;
	bh=kx3GDDhRCcqWA044IjCzY0ET3bv50L3D8Y/3xTAPE9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qf8nMW8hjmTY2O/vbdai8bk5QoDhnjbokbNKLibmhGxt318V2NQ0GT8YbWvhguJYgVqTUerXhffJlIQU+nPQ7jasVnttjm+AQxMq+q0awwnJQxw5s+ImPcObLXhzg3mMtdHE9H/yDow0ijrY82eYa8IKYQ35knJN4EI2zwrv5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHGMWXyw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHGMWXyw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmJDJ994808;
	Thu, 6 Aug 2026 08:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N/Z+3z
	r6tK6CJAjQ2XZeZmS3VDBPlitHaSTyVuaBsaM=; b=sHGMWXywMktYe0Sx90UUH2
	vC/ynSIayaidujxKAN5yQklv3E+0CSDb4/BFwmXfXSiK05jTnkMJuaauiC3/s/7m
	GwnlhIEWDTVmfPtqOC/IAArwXCzfuZqtrRe5cQavJIT50ZrsNtkiftqRS+lF9e7V
	crikwtmfDdtYvLk5VcFtxBZbWaBDVlOwReNT+YKqUuVv1gOZT3nJSOh6xhBOZCgE
	8HwKtuPxtTxkXBFC3AEt1mNdNGMbueBWDWOVDnkN2KBhg4C6ehX/fTM95lvPp7E6
	FVrmkmuFSCcBpR7KMz4gFG3UhEnqPZ2nrno+4kz1eWdt2NyT+vkXkyMsK0Uij9ow
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hxyv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 08:51:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6768faEG002578;
	Thu, 6 Aug 2026 08:51:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyt708-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 08:51:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6768pI3F34275594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 08:51:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF6912004E;
	Thu,  6 Aug 2026 08:51:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91D972004B;
	Thu,  6 Aug 2026 08:51:18 +0000 (GMT)
Received: from [9.224.91.49] (unknown [9.224.91.49])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 08:51:18 +0000 (GMT)
Message-ID: <1a90e77d-4302-45a0-8fb4-65f614261ce3@linux.ibm.com>
Date: Thu, 6 Aug 2026 10:51:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] dibs: fix use-after-free of dmb_node in
 loopback" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, hidayath@linux.ibm.com, kuba@kernel.org,
        rc@rexion.ai
Cc: stable@vger.kernel.org
References: <2026080502-penny-cubbyhole-47d2@gregkh>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <2026080502-penny-cubbyhole-47d2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2OCBTYWx0ZWRfXzFyq+hSt5clT
 +EIyad8cKu42A+Pcb+Y/TeAVyaAQlDJ0QtaZIfiJE9gOsdMvw1Jq0Esqc7BCHFY5KcbjmF0fQtu
 hJO2D5Ip5A8nE0Lif4DIZQ1tLQbGdkQ=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a744b09 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ag1SF4gXAAAA:8
 a=VwQbUJbxAAAA:8 a=_uJhNAyd7QPUcH-DVqwA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2OCBTYWx0ZWRfX06jgZGy2ecUd
 69Vzz+g798xPSXqScSrxYQmJ+JyXb4TFTo78pmdgkPuaBR3gSc2lsoXuT6xQLD7vwaaCwWywb59
 QOO6I+xq5UQELEJxPlO0VIkGPicekzbIAJAvwHt8BKQbxhvwzU/kmKkpXJEzqnvc01Kh+tzDoio
 XzVwnf9/ALSLMmX7veZillL+3e6jNJgVYLQth13ndk1xnxtTwMzHLu2GsCPj4+3tusNViGkYH9P
 Sx77yxtA8E3bF/q5bVovadl+Pyz7TP+5RHXnzTBZhiA58N5avmj1gzE0NcHklF1+Zcki26lnp6h
 6tdfd1gsWsPWd28IaxJSOkuRGHAmze2P6G6lsgtGaDK9m7unaNNmqqaP4VsGvhQL4JbCdw664Nt
 OiyhQZDX3ZtOdqNWQVJO3VbAy/jL3NuBuM7jnu2JDVlSyXU7/B90ccXgVAcQl28prW+QF3s21s7
 iVrSbTNXGVUNYwKa4aQ==
X-Proofpoint-ORIG-GUID: im35vLWCwuY1dD8PPOK6YARoDShJyyOT
X-Proofpoint-GUID: im35vLWCwuY1dD8PPOK6YARoDShJyyOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060068



On 05.08.26 11:36, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 

For the records:
Deeper analysis showed that there is no path in the SMC code that can lead to such
a race. SMC currently is the only user of dibs_loopback and was the only user
of loopback-ism.
So the stable tag was not really necessary. Sorry for the noise.

