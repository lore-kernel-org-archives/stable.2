Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF041463B9E;
	Fri,  2 Oct 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950151; cv=none; b=jJaV7E2+2Zg8I7mT0iXnbyoSyipgkpW0TaCbUJHuFtNV9NNSAhQm2Uww301qhV2vDMfUD9P05IFic3CSFAcutNOn3cj8A+RKBVqmgj+x7E8lD0Zfp6+pDxKTeOGF06vgvgb687//ZSRCvDLNZ8/Z1aoVo4VIwuSW1qgOL6q5UnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950151; c=relaxed/simple;
	bh=VW6pcePcRlI72M5Vfcqm9dIYw63uj7dH9+daT8hg/Sk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NP9RWuDuVgmWuhu9nZHW1fH5HRJTkriC88ooC2T2CfiUdU/Znp1pVhGDTtgqFIwkIGDDc7Yzuou+XRia8zJsLNeDa/Hu4Gl0YyrY5qEuAaeWNmIIKpD0gLPOPJxGlSyy0R1juLnXldip4Men1WohLqE0Tzyh0Tu6DpvBTufItoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VJn4YHzZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VJn4YHzZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DZVIK3589626;
	Fri, 2 Oct 2026 14:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Qeduu
	Uw5LpHQ345ca40vnpPjWJATrD5A7Na+tqld8Q=; b=VJn4YHzZKVd5f5N3xCRPuW
	S978Ud8JNG8ViXLTRo5DIqeuNICywF9zhy9XLM0+5KdUnFYKH8tRTjXT1TjGJ85U
	JC5ItCf4zJS/JDm8f0+SWDG26DzFcmU8fQtVrzlaxChkPOQ5Jl8PzwDKLXSBH+SV
	Xjgwc7ttDoL6Trk/7xlMhr2XOUGLDfS0wXX0Sv9fsjYGGewbZD9KKVgNaliAbBGU
	fiQqTAidvrHKqxTt2ya3o9vM66J9sY8r8imVOfneOnxKayWBHkSIL0xLpuI5h1q8
	RMyG32WFKv9WjOkskIonMYqZRVktzCW1saRMdUOnDu8eNA4UObRazXkYKioY2z4A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fer83g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 14:08:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692DHiFb2576808;
	Fri, 2 Oct 2026 14:08:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h1xk133xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 14:08:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692E8v7O64422324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 14:08:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F393C5804E;
	Fri,  2 Oct 2026 14:08:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 252955803F;
	Fri,  2 Oct 2026 14:08:56 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 14:08:56 +0000 (GMT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 09:08:55 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, wenxiong@us.ibm.com,
        Brian King
 <brking@linux.vnet.ibm.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] xhci: Reset controller on xhci shutdown
In-Reply-To: <b43b9d21-4134-4e4c-89d8-f867207b125e@linux.intel.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
 <b43b9d21-4134-4e4c-89d8-f867207b125e@linux.intel.com>
Message-ID: <3d04f9132ddedae73ba96de428801db9@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abfbafa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=mhd8ySKZzU042aZgE0sA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX5vYlPEVZQhee
 /AdJo/f1/RdD8rTdhbYNX43/9Wj7wLrcw/OpfX4Zp+TZ0UNApBeeu91Jyr5wcequAhhzCv84bZN
 ZGU5PxCknDF/Rxgol8h39Vg6QlwldJA=
X-Proofpoint-ORIG-GUID: bcqIDO5gLkyh2AHD24Z9cq_bR_kemMDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX08T693Zm07bi
 sowIbHHLpfKzeHu8zvfILU5JkR8CiNIJs7+p/SZmNdjmbWNhRirsWHaKJNLmo8H6qfzIe7m1H9w
 HdqvJxMxzuulJHAokiRVMV04+UvwSZMpdF7y9miDqMIH7dKNTEU9AE+Igi86vTuCpSp15uLwVeN
 SfmQVoT0HbbSqf/lTqNlU7teNvJKpyvM8L5e2MCKibHs3USXHiY+TAEqjNp2OR+zTP2jz99mx1Z
 CrQH1vkFavWRChJgXJSsfn1u50qzbyunQY5YWKF5BLlifecR639ntW/rsJ17FaGb1re+Q3ZDY6d
 rfEHKHDgHUoOXLnfC88xhddxd93x2geDZX+aULaxH5+Wp/vnJCf619R0jHxDxQ7+++jCZkO+qGw
 l/Z5fkOaY2KtiVWezCPFzf7luuMXjoMJNm+mi2Boa74YicwfGNC3JNivkUOo8J2AvNuKoO7OX/z
 3c0Ky9GEWtgSSyKo6Jg==
X-Proofpoint-GUID: bcqIDO5gLkyh2AHD24Z9cq_bR_kemMDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020056


> Should be added to xhci-pci.c: xhci_pci_shutdown() instead.
> 
> Probably also limited to that specific TI xHC controller
> 
Hi Mathias,

I will try that.

Thanks,
Wendy
