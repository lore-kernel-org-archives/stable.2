Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845922;
	b=guiaHjHLoY9W/rDK6QGAccrPxMxcviHn/P8Ua9v74cUqzTWKNfZ/dBuCxHExAJCzp19d
	 mEfFF5LzoqaHQ0DDz5rHXnnmrfyFDSM5Xx+y4RBC2vhp6HODTtCIOaEYkr9G/lFNW5q0g
	 k7My4SBkCux/nKLFV8xPVrY+BiwfRqEuefPoNYmZqF/ty5/631rQZ7BlGLF6EstzY6vyP
	 7IuQBOU3weaD1kaM29J2axba4kfE3j1pl6ay+pg+rwWRCoh/+FaHvz+Rl3ITmrfW+1k/C
	 eASpLp8aUu6aIhQhLiV+3T4Np0zkPPk0BunZemABtyY5Qyyo/TX4RAWEVUQE/hQ225Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845922;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=fFHVGW/qi2aH67mIa0HBYC7MRfeVrxQhZqbVRq/tVTw=;
	b=mbj++jZJ8ZTyIIp5g/hP3yZhmYUe4i4x67Oxospu+lJGXD2fWbWNpOOE5qkf1iO/mHDe
	 z9aq00v/lN5PmGbacF8c6vyKkRR8Vah1DynfXd0fPJNSlXMf640tddptFfmZV42EDLMyv
	 LuTjjONbqrRe9sL1NI4y8WZlb0Vbkueh0ilaBjbXYS0wuPcez46lcJdC16H/CdBr4GVMI
	 QPYvg77NM6u/WSaoVx6T8txVOJqipzlhPYazKE9zJQvyvd1qnwr6FszYkfjLYcP1xNuTa
	 V1MVVH9obYFq9BkYcnlOg8/w61gFbTqqPjOrPzzulsFM26h/DxVwF0xm46Xv0JWP31A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29150606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29150606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIfwL2162510
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:18:41 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxp1gjeep-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:18:38 -0800 (PST)
Received: from twshared77744.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:34 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 7A3D72F08A7B7;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Mani Tofigh <mt4022@columbia.edu>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <tz2294@columbia.edu>, <stable@vger.kernel.org>
In-Reply-To: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
References: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
Subject: Re: [PATCH] nvme: fix deadlock on nvme_subsystems_lock in
 nvme_init_subsystem()
Message-ID: <179484590948.648177.11478558432754935680.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 08:18:29 -0800
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
X-Proofpoint-GUID: OI0GMEf7Bfgg7m4UdtHF1_UW1oLnOE7d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX6HCJkgd3jXL1
 UH1ZGeXmL8gsWiTFZ7/y2gT6JDI7ORDMugWh4A6oRKY5eVxBNL/IErMv6EWdgFfXIr9DEa4te3L
 jo5VX25uiaSJFW4dPx8HiMPBS4Io2r4Ra+Fw/V9+ukhO2AgL7wHhkjOIOoF7sCV105HJATeZXhy
 woL+0AuOU/eMQ6L7FCLmRC2jkSfjX+MdGwdKk/6Jy6Ua92pBnJe2eQF9nbZlI7H1HMfrmJtHYW6
 64Nf842Z20etqxEy+EGF4tWJfNaRiNT9O1GTp/MWkvzzyK8Q8Bdoht0JI2gU42qBgT0PsKbcvfl
 9nbq/Z0UVaBlZV35LJ/p8femwITvs8UG9OBr3dMzv/byW335Tm2uz1FHfeApmtjV1hI0C0EWMNW
 u7W1AGHYzxLk45t1qKI32WvL0BrrB5Ma6jD70ezjS4+3pyMQdijCsABTayyoJPCtqODgXmIIq+D
 j5ttPTSjug0hVrGi12A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX7Y/x6UQY+f1S
 ODviGOY4uOyNW38Ri/AquIVEpVhfAK7nc/cpnuZdSRRC9b/EmZqBdagWOf3XgbCYveWlYp097/i
 vN6K6pk+oDWSOm+4/Jwk6fQ9SsLe/pE=
X-Authority-Analysis: v=2.4 cv=aMRlOr9m c=1 sm=1 tr=0 ts=6afb2ce0 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VwQbUJbxAAAA:8 a=csGGxczj0hs6o8ZFVk8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OI0GMEf7Bfgg7m4UdtHF1_UW1oLnOE7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01

On Wed, 11 Nov 2026 17:46:31 -0500, Mani Tofigh wrote:
> Connecting a controller to a new subsystem deadlocks when
> sysfs_create_link() fails in nvme_init_subsystem(), e.g., on an
> allocation failure.  The error path drops the last subsystem reference
> with nvme_subsystems_lock held and nvme_destroy_subsystem() takes the
> same lock again:
> 
>   nvme nvme0: failed to create sysfs link from subsystem.
>   ============================================
>   WARNING: possible recursive locking detected
>   ...
>   nvmesubsys/95 is trying to acquire lock:
>   (nvme_subsystems_lock){+.+.}-{4:4}, at: nvme_destroy_subsystem+0x1b/0x1e0
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: fix deadlock on nvme_subsystems_lock in nvme_init_subsystem()
      commit: ba1213be15c613a1c03db69ea6480ca140a6ca00
--
Keith Busch <kbusch@kernel.org>

