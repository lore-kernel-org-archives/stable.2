Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891512;
	b=OQGPIb2xNGoPOiLrr14HmlaVUzjz/a6gOQZdj6bd50nMP17z6PL56ZB5mF4qNgJb3kET
	 D/yX34++VyuFiqOiocSGrihjDb0a3N5hMjT63aZV5f4kem5nNwMm/GnAp+fSZTBq7utoq
	 1ngK1421KiTd3SY5WBLaAUKjhgP2S11SWhW5w4aQ3eBSQJ91p2p3O85f0437phB7A/P0e
	 QjEKvbToTsFQuVWRoucJMO3HjWzrFerMWxNNAxNLesabzhCJYaeY043hqXE0E3zNF3SK/
	 2k0/O+OE9nTP0Nz5vgrBS2yk+3FdUkbePN0WAxxclwN4H0+bekUV09Uj/IIGFA0jUfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891512;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=6bxWa9BhJ936wj2QTmk50qV7AcXRwA1UfxmnMBLdpAM=;
	b=ACPL5awwjutGlDwRrUZDuQAxMXQR432RKn8SeV00SQN0hblToz+h3JZ9PzsktcuNeveG
	 Cz+MhjpgLhm1m3DyXzF9/LH40xaOce/hTm0cL+zTt7ajcozp2l/S0/6ek0NO5qXSvzgt1
	 o2Yw0E66yPtvwcd6TRAslgoNq3eUTdKvcb1ctiMt1p4p5crNwyF7moNvQTOJlfciB75yE
	 0djRBSe1KPIRTgftiPL3SmHCcsMigcO9xsj6Bi6GIu+dTK7+RjslvBjIq6kogxM5Yt1ao
	 0JANoFkpigF5v6+My6zE2abohek6ppLxixShqqEXVp/IOQtCYGRZ4MQWITS+s+KunKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B74606A339
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B74606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5ESS6F4164510
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 07:11:50 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrqp21qy1-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:11:50 -0800 (PST)
Received: from twshared13996.31.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 15:11:47 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 8E6E42E7EC6F0;
	Thu,  5 Nov 2026 07:11:31 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
References: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
Subject: Re: [PATCH 0/2] nvmet: fix configfs attribute validation
Message-ID: <179389149158.2132554.16810927122814072564.b4-ty@kernel.org>
Date: Thu, 5 Nov 2026 07:11:31 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfXxjeUgR1Fns3e
 Cz6F6F48bbTaO/xhtQOjqYbrWd7+L7H6huOTiOS4S8iafcJDmmEyyTuq0AwmqCnOVTiAQjnXvbf
 hccpJqZ39Q6Or7QO7tql/pkt2TWbnghEJDV7ZkEhvFaSlvUn9no5IFH7u5sf5TrD2Ivjm4tp1cn
 8uPsOKcpFbR+Cf+vSPKPhof2PHXKbCTFMTG5ND+S51FhlsIUawuR+OBOfhkJaV308BrsAb61Sjy
 0xPhXK3unswaU2xQ9z/+YQmgert2QYUwJfboWTJJh3sfMR0azZvMJVjwsA+sXCgZrXSant81bxe
 IdwV7c98UA8pFVh6XSFmMa4Jbdmpj+//zvGHENJgeMwU556Y5mwAK9IzYuBtSm/mTEbDrYXTfOu
 lgrrbKqjKzvTcrG2Dk3Xwf/cUBEK5KTskKFHz38xw0Wod2biDPNyDmrRVBxDBWxnxLEbrg6rMwk
 0EvECmGXT6DIHSbNKGw==
X-Proofpoint-GUID: evoaat0n58pLK3zeYuU0zfGW135lB2Ub
X-Proofpoint-ORIG-GUID: evoaat0n58pLK3zeYuU0zfGW135lB2Ub
X-Authority-Analysis: v=2.4 cv=L8mI0OT8 c=1 sm=1 tr=0 ts=6aec9cb6 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=9dzKPAul-E0u2g9dFJgA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX/dLJjhj0gicr
 40J6bc/iVVBvZazIKTnYn34IBDm7DQNudO4RanN9e9buVUmcTMqNfGDryon5QcVSzSYdmlMO9ry
 KDxQ4Qp+dRYA9pD8+6MoKihAZNXiq0Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01


On Wed, 04 Nov 2026 03:07:20 +0800, shao.mingyin@zte.com.cn wrote:
> This series fixes two independent configfs attribute bugs in nvmet.
> 
> Patch 1 fixes a use-after-free when attr_tbkas is written while a
> controller is going away.  The store callback walked subsys->ctrls under
> nvmet_config_sem only, while the list is protected by subsys->lock and
> nvmet_ctrl_free() does not take nvmet_config_sem.  Take subsys->lock for
> the walk, as the qid_max store callback already does.
> 
> [...]

Applied, thanks!

[1/2] nvmet: take subsys->lock when forcing reconnects for tbkas
      commit: fb205953868a7f29317ad619366a5faf2bb268a7
[2/2] nvmet: bound the traddr and trsvcid configfs writes
      commit: 21d6e9f2fb79da2a516901697bd562c361ed6160

Best regards,
-- 
Keith Busch <kbusch@kernel.org>

