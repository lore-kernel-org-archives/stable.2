Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631813;
	b=Qao3lNCVT6jheKYXtuE1eDsrGvRjS2CLQcSmnwojMo3xTqCE+Ag5ynephxBeNSlefBf7
	 LXd9HaqQmMqbJFcwmD21GhczTcYkUWCXtsCjHVtQpVihnZwn3z09hWSugZdV0EBectJc6
	 dT8bcKz5O3aNUrnIwK06rgbKwxxkGc4M0o3CS75Kmn6CzjyyEUtYk+jKDVU1vnExZ3Utq
	 bWrWje01P7J8FZ8OISqCa1Iz0MobqzICrGrbpx2XXcqknC9ZgaGia9FRgTOSzRWJhhhPw
	 YBNDnHUtT/dg/CO0nwcEvE43MGekkRQuxrizOkgDGJjgl6Wr75Y70xSFqsb6xrkJqrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631813;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Ty7plVzP6jvaud7DoUmeGN556MPHdfwG2xwLmx4C47U=;
	b=VA9KW7tcPniM0dPlToIdN1NPmWWwC0Jqc48y9/P+PAOWRa+i+NU3j6WfIHjTcVqU1NfU
	 kDJot1sQ+6RnZ1jJS8FILuTWDFtNohmPa1byLlA8LMPkD/crEA8bQ6D+/FKLsvgqKc1en
	 H9ssw7m1yC4phJznpnswaUnhgDOVPvLhoUvBVqpy64s3ukqsD69GCxLfVKVCoBsHc84J3
	 oERyHlK5BNIT9y6eL+B0N8EXPwckNppKdUuyXxjrHswwkPrCWB03GgcscIZDkwp7Z1jil
	 5nLxqwDbcxJ2b6/dNQJ6VPYOPB3piWrdq6glq1642BFxcT/US/wRY60qNnKTiZ9Wq2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rea0vsSj;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365F6099941;
	Mon,  2 Nov 2026 15:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2365F6099941
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rea0vsSj
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEAG81949776;
	Mon, 2 Nov 2026 15:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ty7plV
	zP6jvaud7DoUmeGN556MPHdfwG2xwLmx4C47U=; b=Rea0vsSjFenbA1EeCH25jI
	RjotegPxVJ7fmYyRT+tBg2SGwE12PleDgewJ7lgSLOEhiiZwogugwNhqDh+JAyJ1
	NB6pDzoYsa2QRFjRcmVr73OIR98oIpqJ85cTn+YBiQvUA8FPF/cMjgMa5KS+cZE7
	wUhNM2WY239cD5k4KXyYA1TU2uLes4fI88cHWHV8FtyvmHup9bzWO3Y3HOjm1PXQ
	jA//bD0PYtEXMca2XGWo4RJCwhupC3QptYBGqNkfhvQI+ePS8yMtHMtSDylJnPI/
	I8m158tFcpni4Y1DfWCkpQ656nap1diOtdQwB/09N1zQoHrKlZ0Lyx+lVSRU7w6g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd16r1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:03:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp5CP1004818;
	Mon, 2 Nov 2026 15:03:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hntnpxj7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:03:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2F34dr5505930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:03:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81F0258059;
	Mon,  2 Nov 2026 15:03:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33BBA58043;
	Mon,  2 Nov 2026 15:03:03 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.119.18])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:03:03 +0000 (GMT)
Message-ID: <ff1965b1cdaefa0d68b2da6050ebfddbb7b77ec1.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: initialize the real inode attributes of the iint
 cache
From: Mimi Zohar <zohar@linux.ibm.com>
To: Cai Xinchen <caixinchen1@huawei.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        amir73il@gmail.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        lujialin4@huawei.com
In-Reply-To: <faee04cc-fb04-4e56-bfe4-1eae5b819137@huawei.com>
References: <20261102024703.816178-1-caixinchen1@huawei.com>
	 <cb3ef53e2e5c6d74051528c2b9b9c0a294d6c119.camel@linux.ibm.com>
	 <faee04cc-fb04-4e56-bfe4-1eae5b819137@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:03:02 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _NHq7FX3kmrwWPAwX001zhjUKwWrO8n0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfXwOteJnMCZIb0
 LLBiEieM+9+F2XmhoHdfr5IVHYKO9esk31p0tjvS6cnSgd60wCYUpZ33qDm+X12oowZ6iiJCIx4
 FxY6qXUmGp5Vg2i8BFW3HOf3EnSwPEBumeJoZE7BrQF1i6CaqvgwUOrVySl7NZJ7Zo9Yb4hoHli
 kgoJENatiywLf52N5lQYQTTby1qSmYvRT346wkp8pNPPfcXriNas/o+URBrF6vqtoBkLPqJTm7P
 q6uNaTTknyzC8lGIegxf9smCO5rLMHM2w0vCShuWQ3DH2+wRIUSKuAadsaIvaKfdNu84cte8Y4+
 qDemyGXPynWa7gnfUkT9mRijKQZRs9XVnsrzf03cpZKGKa33QpeCyAUz1U5k+7NwaXA4Vb/9Zms
 OdpKlLBS8vsIwPQZE/fMSWtZij9J4NTVWCzdgc5b4X109Roly3SD++QTqf0lYyN6E8PkTD+qd3d
 Qx5Kno25odQdbivsT3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX3DQvcukzl8OB
 Pl8NNSgM2XVOvlgSV1TCHRSGsWuQKRspVe0q/EZu6ISxPMx/x/NW2L8I9MoWdvxkhAd93RK3NI0
 Ntb2/ex+VlE1rDeIMQ3579VypK3KIeI=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae8a62a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VCljQN5vTxgyfkvg7k0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e6gg_4qVH1JgqX4-hhkFqccnlpj6l1Rd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020058

On Mon, 2026-11-02 at 20:09 +0800, Cai Xinchen wrote:
> Hi Mimi. Thanks for review.
>=20
> I mistakenly used integrity_inode_attrs_store. In the next version, I=20
> will directly use
> memset to initialize the real_inode structure.

Sounds good.

> I double checked b836c4d29f27. That commit also added real_ino and=20
> real_dev to struct integrity_iinit_cache and started reading them in=20
> process_measurement(). However, iinit_init_always() only reset=20
> iint->version, leaving real_ino and real_dev stale. After 309e2b775da8,=
=20
> these three variables are encapsulated into integrity_inode_attributes.=
=20
> Therefore, I believe b836c4d29f27 is the appropriate Fixes tag. If I=20
> have missed anything, please let me know.

Okay.  In terms of backporting, clearing the field using memset() would wor=
k,
but still the field name changed.  So it won't apply cleanly.

Mimi
