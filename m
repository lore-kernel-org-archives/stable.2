Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941179;
	b=u56XrlkY3o6Ykg8l8bn/AYAcOF2y12OsC5H1GHq9BTJEUl+92mCSQdnkGarMrKToNKJr
	 b6RZIt2VydOhlSUWK7ve/bpmHD6ql4Q9ssuwMzjBfmkuomQwUPbCIshlIjeRsPAh7dlFy
	 IthxGf29x//+ooT+PVnd2lIUP7TmDgyR7+OXHNrFIv656CVh+KRjXeKYFUGc/VbwvB+qA
	 EeJ222o2sO4msENayVc9N956BUc6Lv3HTW5cbrmyb/T30ESzf9lfWvw2jebxpukudSPSt
	 djCD10408w9wt1jOgKihs9Mmok3uv+YD8jNAPp7ySVf8JEiVwSIlsjEbwjJQsz3mHXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FHdwDVfXzscoOylIF8ldsaUt1NeZHtX4dD7nyQbaahI=;
	b=aLYo7IDT8hr8bfkDX08MDQFEfsEQ5d2JF+Bi4esYG+sLZ5oCuUKP9pqeL2AZdm2FImOM
	 0G+8fkRCtVx6LNYHKmZw2y/qNHlWQpmUXZZD9FgiiI2ikuPonOOBvO7+kJ2UG1zrKhW/N
	 CqyFY8XRMX0jVyxdKDcfq16CXU1lZpWlNap1uwM3/+tPScyj1QPU2pWooI8K6p55ViSMc
	 euOk6Y3lh4GHrRsXANaRgcMX3G+iNH4tPcFCq5OHrTTbdE6UL3GmKQy038WLwNc3Hogh9
	 VJ9a4FGuHC9oKGySkvAMKiyhuPP6ckMNd/gysWjXrq2l9HxXObwdxSW2mHLsiJYUbbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZAQJX5mT;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED7606A31C;
	Tue, 17 Nov 2026 18:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BED7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZAQJX5mT
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQcKL2711551;
	Tue, 17 Nov 2026 18:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FHdwDVfXzscoOylIF8ldsaUt1NeZHt
	X4dD7nyQbaahI=; b=ZAQJX5mT0SeQUjM5RXERTdWRagcON8a5YCySxMH3U6+d5G
	oPaHnSREcXqvI71QrM54X7Y1XWIsAyvcc2oHVZ0/NtSCq+Wu0fDov8ytwfRuqtuW
	/h+TM4GWtjU7cC5nOvxMrx9WhDYjblYB6+mQq9OkiY+9UWJcqq3Hxx7Zzbfb+Dqi
	BnhYZRLOWxVMUJgAj69he9oDpxMXJfR5GtXjuA1k41gdAqZhlJp8EzDWmNUv7BCC
	wEVaF4r87t3PIl+soEwxayHaojWtkbN00xtIeJTEkr59WslFl9AEEMWDQyJOf94K
	y5QiVxwXYLuwgDJorIDyC0+zJK8bv+MjpkWbetOQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2m4e06-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 18:45:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFYvNs657683;
	Tue, 17 Nov 2026 18:45:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00nseu6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 18:45:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHIjY8t46203212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 18:45:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72B7C20040;
	Tue, 17 Nov 2026 18:45:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A8582004D;
	Tue, 17 Nov 2026 18:45:07 +0000 (GMT)
Received: from Amits-MacBook-Pro-2.local (unknown [9.124.216.103])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Nov 2026 18:45:07 +0000 (GMT)
Date: Wed, 18 Nov 2026 00:15:05 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Vincent Donnefort <vdonnefort@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <20261118000807.39005da0-76-amachhiw@linux.ibm.com>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	Vincent Donnefort <vdonnefort@google.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
References: <20261023145459.47516-1-amachhiw@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023145459.47516-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afca0d3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=htImR4CqiR0i9lyO-ecA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: K1E5GmLPINmBwwlA2p7SpifAqqGD8UI7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfXwPof/uXCy+PC
 AdkDFl9YDyk9JUH6DylNYDJQoKX0wFtI7jUYRFJUkTFtUV+iKJeFzbU1iGej82ov4po7z7B8qYX
 5jDPYrxvddt5a6rBnaeGSlA9QVIxHvY=
X-Proofpoint-ORIG-GUID: rCM-q8CD7jRdi7OSLfvP8KZpbji0QtOk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX8psedBHRYYYA
 k6FfCdvOUeV2B4pA7aD1oeN9MiWmDHMwqiKkrWGWRGZMXqr7Ssqe/m9gCessFM4NAFaT0As5li0
 wX25OEqs2UjQFWIjBsE5H3mhtAIWl6o1+hP/rGef3trDyew2HxSJm6JtzD0nCUgnoMsHic+ggYV
 WVU3G89EV+UEW+RZRCVC6+Hz0oh2PTucZRJRWPWYSrykBFzPfOd7TCXVCRd3m5R9U1gYOUoVaA4
 DaB8rJgYjbgGKkQuXgq6MyWq5Sk4Y8GpUKGLBcu0X8m6jH6HhVDjjjvBrqE+V0YpgD14GCb4MA2
 ImZoS2P1ge1/HXqxh1j/4ty3wWq2BMM0ZJTnBT/dgYXMX6o1hqKbZQElCKGNB0deSGAKWpy4D3T
 ftqKUojKUm8Xr/FYqH5EuD7wTz9V6OINs5ocYXkmBPE4Pz5FhEZM+Wmpa1FokvdYw2dIkUMjhp9
 7rwRZQjv6P4vu5KJ65g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170073

Hi Steven,

Gentle ping on this patch.  This has Vincent's R-b and fixes a boot-time
ring-buffer allocation failure on DEFERRED_STRUCT_PAGE_INIT kernels.  Is there
anything else needed from my side?  I'm happy to trim the commit message or send
a v5 if that would help.

Thanks,
Amit
