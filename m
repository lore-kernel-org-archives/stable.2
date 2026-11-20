Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185520;
	b=XMey3lTZUYXNkugN9UBnsCbicmJj94dmrvocwKwCBZrexPwwpm+PKV5t7vSOaQTyTE2F
	 inqL5B6n4uMgc5c83S08g1n0S2YInUyqolsaCKO4HCL4JauRgLWL1FSOsaFo3s41cLfrB
	 4f5RdM+4Q5mwnWCBn3U7x3KBKQHS4Q8LX1gMmxStXpFp8wdjKVBYyK0+gexY34spmyjBw
	 5ZkLNmwrwuHZlQFKWoomdgXPyTBKl3yiMCTGZ7o1tWRYUal7LMwqVffSbWwjY4OWKX6Dk
	 yjHGw6eA/F6jFKGYkLptS0Za/QKnxef3blwsRitakMNk+ZmM3x5Q+4Vd4XjAOyzm4CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185520;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VRQsTIOmKMDfSGF8emp5/GvoAcDnlfBGT0gVE/NL8wc=;
	b=X71gBZw4+vk2nZPU/0iIf3UBoku1jnuEYYzlm3jyQuVr8zc1EP3Nq3kTMuRwu0x+P5LI
	 i3jT9feoIkdv1fmoxd+YIflZ7TRv+wvIXD+ijZTZhh9ohfnaJjHYx8Rp12zaYy66rilsp
	 UeRqk5ytkX6Q4hxLg68wRkpy5JQnfxtNs+7+8HSswEnlWtoQEBLoIUGBKBha5OgIjS3Y4
	 7j32Q8xgU8ixhpQiKO3pxYaqeSjOg+wBf+r57I2Rik0UmLXxSvVb2fscXkL4qLH4H60Xp
	 XI/hvb3BPDA1D3yIlZgPRwMFgcggwvDGcCoKwdGQDnARBclRshOsswrsxLiLz8b42AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V+Cqyru+;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A9606A320;
	Fri, 20 Nov 2026 14:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 393A9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V+Cqyru+
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAuIv92910194;
	Fri, 20 Nov 2026 14:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VRQsTIOmKMDfSGF8emp5/GvoAcDnlf
	BGT0gVE/NL8wc=; b=V+Cqyru+2rSF2UCeHIDyPTA+Yw1+d5mL5hS4pEodoKbkgX
	zlyvjLYHLCKmBp21Ps1T+Sz9qDs5Oy63v8arA4niYyfwyzvl9Fze+j2ymJOnbMXQ
	TIGpg/8HgJsovCMNLidnnGR3/UA8lDvaBFI4nFN2AMesfLaTv1mI2q0HoWctDXAF
	dny4wnWfEspNHuxWQkyvGRXrbcNJsl7lYDBu9LaeZcIoyMvrv8lp4LVo7ZJrcD46
	hslHQ8cbQug2KWwpQ6R+aj8XI4+u4wyh0b4HZ7Gm+bRXlmu/oEBynqEuiBlAQetY
	plMvVe1dkzYtHAIOgG1heeZ38KHjV0uPMOn3KOeg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w0sep-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 14:38:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKECR2w2162669;
	Fri, 20 Nov 2026 14:38:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j2nt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 14:38:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKEcH4l51970484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 14:38:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1C8C20040;
	Fri, 20 Nov 2026 14:38:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C2A32004B;
	Fri, 20 Nov 2026 14:38:17 +0000 (GMT)
Received: from osiris (unknown [9.111.86.180])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Nov 2026 14:38:17 +0000 (GMT)
Date: Fri, 20 Nov 2026 15:38:15 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Wei-Lin Chang <weilin.chang@arm.com>,
        Fuad Tabba <fuad.tabba@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH v2 8/8] KVM: arm64: Stop leaning on __kvm_inject_sea()
 for abort injection
Message-ID: <20261120143815.222720-B-seiden@linux.ibm.com>
References: <20261106183154.3590825-1-oupton@kernel.org>
 <20261106183154.3590825-9-oupton@kernel.org>
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
In-Reply-To: <20261106183154.3590825-9-oupton@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EbgS3eEjdCaBbrGbbxr9YFEsghi2Exa6
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6b005b5c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JmU91AraYWe317yHq-gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: EbgS3eEjdCaBbrGbbxr9YFEsghi2Exa6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NyBTYWx0ZWRfX27lHZCmpDP00
 9Z0H8HXi3ovApLYJfqaqPO69cCBh4vQqa902sPRn0W87gvv+IpJ9LMKt058N0KJqeOBMs2zxxmM
 ZjDa2JsxyjNwFPN/2/d+CZ3FYK37KsxA8NCA7EqezYWbhok7zacpn/+SQMw6/oBuJ9Vkd8QCYI8
 AVAmiKdjgYuZtObSbWaXgHtAO9yumqeyY0ib/Grau+OYKeIMC1BFND6Vw6mDyflvk5/tzzz5RbQ
 3neySW7iiMP3EpzUidPuczwX2rw8iI+J2cAXEfsIKR4jI0g9Hz4X2gTxP8pVMhXX+DT//K1B9Ni
 KdHD9BmIQTvevRk2QTRF/mGdmt5q+4+dbi0cIYkf7sGfyIYBjcsSYyvf55yO22fz7kAutmdsDFn
 0LJrp9pNXAwlweysvTrtamK5Z4JwSDX6RtLYypqCN8t24S2OsO3oTGpe0ckijup2lRwaRCMmdG9
 fX7nIu1FFlgopDRzYcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NyBTYWx0ZWRfXzNbJVc4AVRZz
 VFEmUKWbyEiQxgU1cxu1sBJRHwuHshlO1gWbT2875YjG2gvl6aGtEILDL6wTogtmml3vrJYIRHk
 KLyNMdrYb/+nOIu9a7bL0J5iHtP1xnY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200057

On Fri, Nov 06, 2026 at 10:31:54AM -0800, Oliver Upton wrote:
> KVM's handling of local abort injection is, politely stated, a giant
> fscking mess. At surface level, things look somewhat innocuous: inject
> an SEA and directly update ESR_EL1 with the correct FSC afterwards. But
> this is broken for a couple reasons.
> 
> For one, on implementations with FEAT_DoubleFault2 KVM may inject the
> SEA as an SError depending on the falue of SCTLR2_EL1.NMEA, meaning that
> the eventual non-SEA abort is incorrectly taken to the SError vector.
> 
> AArch32 is also quite bitrotted. No surprise. The FSR value is written
> to IFSR not DFSR, when a prefetch abort is injected. So while DFSR is
> aliased to ESR_EL1 architecturally, fixing up ESR_EL1.FSC after
> injection has no effect on IFSR.
> 
> Finally, injecting aborts into non-LPAE relics may use an invalid value
> for xFSC.FS, as KVM unconditionally uses the LPAE/VMSAv8-64 format.
> 
> Fix the first two by tearing the whole mess, adding __kvm_inject_abort()
> for injecting non-SEA aborts which takes the desired FSC from the
> caller. Fix the third one by selecting a fault status value based on the
> LPAE-ness of the guest.
> 
> Cc: stable@vger.kernel.org
> Fixes: fff97df2a0bd ("KVM: arm64: Route SEAs to the SError vector when EASE is set")
> Fixes: 2937aeec9dc5 ("KVM: arm64: Handle DABT caused by LS64* instructions on unsupported memory")
> Signed-off-by: Oliver Upton <oupton@kernel.org>

Looks good to me. Helps me integrating the fault injection code into
s390, thanks.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

