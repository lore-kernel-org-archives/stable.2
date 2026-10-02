Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058EE4ABBD6;
	Fri,  2 Oct 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949952; cv=none; b=oaoYtz1jxC8T/kClOu+/5lgwK/hYAQJDOPq1DoXrvQchDYftNEYXRGPtjdhAczGYeBL9zb+eMxgFyyrvFRZDjf5ulawewfNjYvhf/wTHbtyjmJArsjKTZuCVgYVp2WTvrljobS3mEQ2R22u0HLnebckIAOhe8DG8PdRsOYBmSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949952; c=relaxed/simple;
	bh=q5klAE9DD3thUimA5dIwx5LE5MqDhMhQpxeIz9mICH4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hK84xF/UK+M0FYzraBzdVICejyr//C1b2LDSdavjRKxQNBKZctz/eKM6tVqWGRlDAzQNHJ4AXji2cbh67CbglFjGh2l1BavRjEPfc+TymbLDEKTQtUPed7iNOzvyIbfZ2/epbjzCCgVPqAmiBdKV28CqfZhNw/oh6GVptx+Oq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YQTPpsbV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YQTPpsbV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DZZFp468482;
	Fri, 2 Oct 2026 14:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J2/g6z
	qQl0Tf53uBlO/lG2BQxo7zc2ZVFcAISvvP6EY=; b=YQTPpsbVc89JGs/+R+xzj1
	8fzWHraqX4ZiWGgDcBGpMOEACw9RFxcdYVYh5eApGlk3CtqfGbrcw9hqcr+47bgZ
	XEjeJB/0JSbuXKxAo7DCXryMGDxzG4IEphOCl15hT8hzRbHA/mzBqWm/dyjGyVI1
	yGiTkxfraTEP5Huao8CkxmTqiQsB3jY6y9Q2Vb3da6RY8aGxG3mvrBUJgIIYyKjk
	1xmSta2G9QdOfkuM2ptiG7J4xI/iICzysPm24koqEVeQCfgwxc6mVBuxnJXV0ikC
	xJo7tJgnBKrTvd4uxD1ISW6G5YQgUwDWnc8DXnrcxCzVFTPZp1rOc/bCOBmrpsWQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkrk76-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 14:05:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692DHUZE2575928;
	Fri, 2 Oct 2026 14:05:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h21nu2cm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 14:05:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692E5bu730147162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 14:05:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE2858056;
	Fri,  2 Oct 2026 14:05:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82A3E58052;
	Fri,  2 Oct 2026 14:05:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 14:05:36 +0000 (GMT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 09:05:36 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, wenxiong@us.ibm.com,
        Brian King
 <brking@linux.vnet.ibm.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] xhci: Reset controller on xhci shutdown
In-Reply-To: <20261002102931.3cb06009.michal.pecio@gmail.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
 <20261002102931.3cb06009.michal.pecio@gmail.com>
Message-ID: <561d22493c3d078b26f547dd8f6f6f46@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: AjWKzsGLmIFYd485-Tz7BYwfpeoHqIu0
X-Proofpoint-GUID: EDpPcOpQdaBFLAdOJSob6hL50V7VPBJ-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX/CsA1AJUlCoR
 TmKDiOArPdmnYlckMWE4GUvbrIB4Du1UvX6CzqyJFFGKTs3bFZewjeTT/xH93OcWvA6dxkNWjnp
 IgChjjLjrKkM1LFDxBAelgRFXuImde4=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abfba32 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Qr99yXs4eVAMDqtuwm8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX/nIQur9SkSdB
 oaygbQi8gDXhiSmKV1z+U3P5aNZUi5A7ofKmS9ryH0mmRuaD4g9fnzwNNThC2wD5exbhPkw0qBA
 uoWp7tqB12GbfqBm0FB57kIzPOxazSUghRgfzHH/HXXA8Ea04bsWmk9+sXFeZCBMgP6sXbMnLKQ
 TtX9/lflgFNIJdksHNTy9Mjjg5g+DLStkxk8egLE2YpwPa6ymiBR6rrmg7agbalDdC4+L81LNX4
 LdSlwqzaVT42i64RouA/jdZKmAAI0KDI1o+NcxE5MFKhmldDgscR6cCnjsbzVjuT/IkzlDdwDKA
 b80x67r2yqN6XJrZyr39MloT8yuuTj147CSRAORcBNFeVI3tfzFg/SDmPkdT0By1hxKET/tzYvO
 tJePze6C8EsVm69B2//28VvOFiX5IVuZzOzmcwBCy5LCCaExXCXKgIA3r038qZCNrrLtU0w0F0y
 8WepLjnC944PWfZjPtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020056

On 2026-10-02 03:29, Michal Pecio wrote:
> What exactly happens after kexec?
> Why a PCI reset in particular?
> Are we sure it's not a bug elsewhere?
> 
After executing a kexec boots on a bare metal machine, the USB 
controller disappeared.
With a PCI reset, the USB controller is showed up after a kexec kernel.

Thanks,
Wendy
