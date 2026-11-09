Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220292;
	b=3glWaFLg5Wvx9W3kUn1XonqT1i7byzY3WmjYuVhxuzosmNBSAnORHJM5d1NpYnIngqiG
	 onoMPyHfa1Izy7cKNqw0koDYtTAZCRD8WXGaJc+EXryBGxQOWJSFcVDgpinsaSd5pMNs2
	 brPRJF3S+3mlTiuXRijz51U/ybuVdsRl88H2DboIWz6zZdCN7kFOXiSFQTbINu9n93FPm
	 MgPJp80YjBpZzCbamzYcAh+tUgJmPS/5TtUNARGk1CaeToEY9IwmTQN5pnVtedzHdL++w
	 IvZ86l+noQbmvfyEf0NGtYOkXPJIbbEzMmDWV8UvwIdLAgJUDo/pxZuQAJct8J7gPCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220292;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FwG5jJ6NCBj6pBUW5ha/+byf2Kcii+aXYvfkc6YAing=;
	b=nn6INBXAoO6mVezQfwRViC5yWP2apofXe7qAi/WhAkk+Rl7dN3HWVYOXF3wF0vzvcrKT
	 STuZv+gPk2ude9m96C14En6RFaLXSZDvjmQFOT263dY9jkVJxDcBRgwC9SXAzxkMK0SRW
	 LyvnHkQhaiUriCPCqfQ7xEOHWeFg4womp5fYkBj8ECsbwY78UR54LeGkRzlrdVygoclzz
	 Cz64zlRQttYFZORiafX9wd+55cycoVTjlFMkKN1SQzL7GLEwQSs9PW2eRpwinIBjFI+rs
	 lUQLC+jkG0HfTFrsPXXVJ0Q3znqpWy4v904p+Q/3XT7UTKHVrSJ1iOZSyYUxGmbK5jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OYhe96o2;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F35606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F35606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OYhe96o2
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AEi123131492
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FwG5jJ
	6NCBj6pBUW5ha/+byf2Kcii+aXYvfkc6YAing=; b=OYhe96o2wYFcU4mu2YXmYo
	wivbybr8dTAazHPZ7wzASAG/JdaTu7AkD17BbyxqQQUnrhjpo25AhKvJdX03fveZ
	7d4WzD/BpCRaIq+U9aN9hJqIOWw29w8wHI6TK1iCeUs36J8ShnKfNTQ5DtH6aoD8
	FFBLPrMhJ2/f0yBX/K3FtUv/6pHtro8gCdySp5e8YZjRKRYW3xUeO2SeRKRBHE9f
	F0aGitWrQR3T2ihTxt0DlqQ+2x21zc/oQLGMiOasWQfOlk8E1LysbD6qdxPCflTo
	2C2mxtOFafESpfo2C9nAckhP4tu0191Tuxy5sOEasneYbyz4vS9WdKY6fvNEGMLQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumukxhu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:31:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9A4xZa4099090
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:31:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0xxtxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:31:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9AVPWW29032848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 10:31:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D065020043;
	Mon,  9 Nov 2026 10:31:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8952920040;
	Mon,  9 Nov 2026 10:31:25 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 10:31:25 +0000 (GMT)
Message-ID: <2f2c8c57-7f41-4582-b465-b83331ebc36e@linux.ibm.com>
Date: Mon, 9 Nov 2026 11:31:25 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-6.18.y] s390/vmcp: Initialize full session info to
 zero
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
References: <20261107061856-failed-5.10-f63eb4ee4a30@kernel.org>
 <20261109102946.664117-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261109102946.664117-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfX1ddkby1Mdh70
 CfUgtYPp5krzgEf4fqtCE7NKUodLEvdGmkzCBhBAlYDspZk7kdh/aDd/j/CrSXzsRXeAoCun9c4
 3/iaILVN4Gj2H3o0XH/GWflZ63FT+zk=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af1a102 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=i2OM96_FbZGJKM9_qW8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p6K4nsLAc_oAyW_DGscdeXE90dRsrkdJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfX0foAF2OCshsm
 4L+XB0OE+YZf3c0r9WGGlGmCGtduEUAqMO8DWWtWdeAkbR0TjS0s4BVhmFwQuzoY3mnGzDasBOa
 Z7zwz4XrN5fLv94jundkiDOlPGaCzPkjcch+NeRDDhTSVyNhbROzaifSlUo3KPnHv4N7AwcoC/j
 /A1SXs7bK6QwKWi4GidCqNLQV1gG+wYJzob+HPXSc4r7nrZMziqFBbLK8v/0R+YcidLELqK1Py2
 wHKojUfNEbpiv/YNoPjeaP2/md5R5LbLeKlx1ICj5ZImv9tKBMXr3a+Msjmu/kCO5w4+R61kHah
 oeB16jSBjRAdw1sWIMMzWiB8dItJSVcCCU35QdYv+NFXFCIhBuGcewDfJbnFkdog7W50f0Z3PpG
 zl34H/QMx9IeR9yIasZwJ127db07uCgtEPlsGZNpVOAOhxohQ0kQsackn8bvWgwHzrcmixrbpUG
 eveV1BY+DUUfsmmnhWg==
X-Proofpoint-ORIG-GUID: p6K4nsLAc_oAyW_DGscdeXE90dRsrkdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090040


Am 09.11.26 um 11:29 schrieb Christian Borntraeger:
> The cma_alloc bit as well as the response can contain old data.
> cma_release will not free the kmalloced memory in that case and
> the response code might leak kernel stack data to CAP_SYS_ADMIN
> users.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> [borntraeger@linux.ibm.com: use kzalloc instead of kzalloc_obj for older versions]
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

This was commit f63eb4ee4a30fc5d8de07a229d92310e3c8d560c
     s390/vmcp: Initialize full session info to zero

and failed for all stable kernels 6.18 and older.

