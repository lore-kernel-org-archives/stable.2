Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528850;
	b=fLezBih1lJLX0wt+uyj9o604BILFo8nv7Pev8c18ZWtSVFBDdmh5bpvjEHCheGWLrJCu
	 pF/dwOLamCsmn5IYNIl3ZR8l/tTM8EJWpCfjk9lAKULJl5PAggzR1EygL6vQyFq2f2QLA
	 D+nY1HES8FdbnbAmWB8OnZEg1yBZNSUSiKEb5ArYsGMDGXeQIidB5wrJ9qv4OxAb7xj2E
	 zno74s8lOrLsxbUYu1kETMt4ieDUXDS0kg/RDMVJAsieZfpjOZFkObjV8LIw7fEMHJBxc
	 t1BgP9hKt8MCrUFurU1puvm2YF/8YnatbFMHzGb20F1SbgPIh1S5SLdICPwcKOUVx0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528850;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nmC/incgC44p0YLHcQ1YsL8k+YChQ6lTfX1k4mMNozs=;
	b=l0gSSUtdV89e/eo3ZQN/gWiHiwpZiMmMy8nIci0nQZq4egClWf10nFoKwsyznNGLf6kl
	 E5G0N8YIN0dklUuQLva7k3nI/DO8PKsGUL8L0UTfNOgxhmG4k4LSl6Y7uSGEqjV/KlhUf
	 zU5Bv+aLNpyQBtZdkutPvZhHaeGAdRyfrR1yodJf1FsNJbAIEZcOXuHSTeSC5CQO97a/q
	 /ZURwRo+LkR93HQwAnFvgCtQn9vWjmrpwxHVhkKPDjOri6GTSIwnObtEHqgMuiif8S8Nt
	 ANeTyFemN0PXNm1onTRmtBlBvynl0CqDnNkKq/OC+Hckkm4FHUf4ClEtTdjlV/JjTVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Eyv12zPY;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB51606A31A;
	Tue, 20 Oct 2026 20:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Eyv12zPY
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KHEPYL3067822;
	Tue, 20 Oct 2026 20:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nmC/in
	cgC44p0YLHcQ1YsL8k+YChQ6lTfX1k4mMNozs=; b=Eyv12zPYcwSqGAvQOd6/tM
	O0wEtbsLeoEegPD5Y0YbawQ+3VZO6hPc3abEsk+7Z9LdnRLaquXCqzYHJgSRgeF8
	ZoHkiKDIsMEJq9iP/4k7x4VKE19Ek/xkePZZol/Eu7MB1wiJQGYh93Pbw+ketQqT
	MAjJlpe2yUHDhKpgzDI9VqoBSFS6gKjfwEDTE/7FCQKgfDK5GR3GMicDuKE4mMnU
	g+O1N2UcHYgKOUzLtg6EbGavueClSat/8xyDLJ/Gr9wnmXPRquUo7RbWZKIYPpAX
	+dSeyXevy8S1ZjqiWFkAGRcTFW4at61KDGVmr3X8iUfVqLNhxkvPLS7GkccBQXhw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw59w3sn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 20:40:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KHJoTP1793404;
	Tue, 20 Oct 2026 20:40:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvm2gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 20:40:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KKeOsa7078418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 20:40:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D299F58068;
	Tue, 20 Oct 2026 20:40:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C89258060;
	Tue, 20 Oct 2026 20:40:24 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 20:40:24 +0000 (GMT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 15:40:24 -0500
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
In-Reply-To: <20261015103307.3ba25345.michal.pecio@gmail.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
 <20261002102931.3cb06009.michal.pecio@gmail.com>
 <561d22493c3d078b26f547dd8f6f6f46@linux.ibm.com>
 <20261002161828.365ff859.michal.pecio@gmail.com>
 <55a53022d1c6f671a3ed549d8cf7cd1a@linux.ibm.com>
 <20261006125546.10471489.michal.pecio@gmail.com>
 <64515dfd9a6cd8c3f5665e72a6bf6b81@linux.ibm.com>
 <20261015103307.3ba25345.michal.pecio@gmail.com>
Message-ID: <5510281a5d91bbd435d9920431a3fa75@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MCBTYWx0ZWRfX4XtqGvhWkg4f
 8kQxnN6848X+gcsx7WALTF9DKcCLIt0kO4rLLU7t6fghQ1hMzccXt+FsP2bmOQc975fLakJ1Non
 y6Nww9Ml2L1UXE45PciOVA3+UXPGwSRIbeLI+cVucbRH7bZNlbWRwgg+51tesQrU88IufLW5Fod
 wbcEhnbFXqZqUjvCgmN2bV4cFPgBfRASs7RTETZ1tfuGoy7FUDz1ynSaDa8EpAZHXjFjV7LzfiN
 onUZcAsI7C+fZegwPQ5uZxOlwVJ5dMOctpEvOKclYKCxs0sn9z9xKexvDBZwXD8jaA5L1qVqvtb
 7iT0BH1kW79pjGQ0Fc+c+ag9xYIMYL7Wdszh603C8sKSlYSPsNoqM86lS9W8HhtBcHCsqYQMxBJ
 QfuErwWkoJWrdybP87puPjA03gcXCklUyi5iszIq+qGvifIKxxQGVmvVfZaCeyIww7F7AUZ0lNK
 MYuxWQq3Beuv99zhG3Q==
X-Proofpoint-ORIG-GUID: y6EkgGZBlFtU8poduQyeycfDwTpiLXTs
X-Proofpoint-GUID: ULvzCJmwWIHRjaPUnlzOOJ02bZjFnke-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MCBTYWx0ZWRfX6H5CSDYMVph1
 N6irgTUk2d/1JOgG1GIDieWHUuFQ2E3pJAuB3zB9Lv4D0Xbizc7PSNibc0944hsCLokAAvl5CpJ
 PLQMzFQyjVLg9njUHV6r0FYb9swEvlk=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad7d1ba cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=nViXcNDWPswa_XI7mFQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200080


> If it doesn't help, it will look like you have something (machine FW?)
> monkeying with the chip during kexec. Then we could try fixing some
> known bugs in quirk_usb_handoff_xhci(). Maybe this will be enough.
> 
Above patch is similar like my V1 patch.
It works fine and all usb devices are showed up after executing a kexec.

If we can combine above patch + my V2 patch(set flag to TI devices in 
quirks), it should work fine.

Or you can other ideas?

Thanks,
Wendy
