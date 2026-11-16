Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845926;
	b=LIQq/NXH+Zov5oGsgYNBTe7oPduWdrTOckONmdLX8oDW8i9Su1Fx0f9D8CAo444g0V8I
	 vfPIrHzjq/EllgRgf/ZQqDJnKsq+WIAVcd+7VgRS2VTaB8Xtyzk/IHZOC4pRmzkBy4Q2v
	 4wH36hzul0RexR1fvcAk6FASg582Tu7IPjF1hHt1xzVdkB4P9Oy9mipPIW021qrEJNVhl
	 kCnqLsKYfBz/w+y0r+Lb+DkPb3S497iC5pOf91RUOv6Ht+XL6eB5pzqHgR6Y0ALw4v8Nc
	 GDGqSBYdklnXZ3QK5np4v0rUlZ6YwkJlJGMNBzVJ0BHCwtuZvUayWE8GWoERGIqNDmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845926;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=2/Ptu2/zmuklqy6bzoMqM+lQ4eEViV98DmCxF38tMdk=;
	b=XVoOYgmItXmRe/xm9T01ARHaNK0AZ0YAtwksr4lqYr9gobTJB3rfPYOYpOIbZkh5K2/L
	 bY0r3R3X/AW4ZdGJ6UVvyP+0mWfQVs5dZbqoTOyxNDu+WOTyEJxuioS8jWLFP+aeV2VPY
	 drzSLlqrkvDzcJUeI5D8c4ToXKRFWaT2wKMkOAJ1enur1Mi7tIiKQX78xfkm1LuztLQ6r
	 0QUqBPZ3bp2LqLeF4VDVAS0RL61veBzvD2u3zQySYOrIIvelobNa/ZtYEIE4OHTqToUrw
	 M3aLeOIu3ToCrI47HSYZ7IKLE0XCYOYjL85e/aUFtdVmRMricfeC+rxBDiI/tfKxraQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654D606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0654D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIg5p2653387
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:18:45 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxnmcsyvu-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:18:45 -0800 (PST)
Received: from twshared76683.17.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:41 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id A0AAF2F08A7B9;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
        Martin
 Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
CC: Martin Belanger <martin.nvme.dev@gmail.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Martin
 Belanger <martin.belanger@dell.com>, <stable@vger.kernel.org>
In-Reply-To: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
References: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
Subject: Re: [PATCH v3 0/3] nvme-tcp: consume TLS records without
 application data on a live queue
Message-ID: <179484590965.648177.17811082474327168521.b4-ty@kernel.org>
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
X-Proofpoint-ORIG-GUID: FuEOFixDl2MSslnnmrTy-trp2fa9-NAT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX0Ww5Nulabn6A
 t2GbzWOJKU7YWH3Lx+WGHYR0SmSl9v+4SHp9SQBkL0rKPARnIsf2icWxu+hivGAHNN8NtKfTzp6
 9TmdLiu3piAQg+WGSxuFhjYYZeApcjU=
X-Proofpoint-GUID: FuEOFixDl2MSslnnmrTy-trp2fa9-NAT
X-Authority-Analysis: v=2.4 cv=EMKTQFZC c=1 sm=1 tr=0 ts=6afb2ce5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=LpAHWP_P3Tk2c61k-qoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX9h/lj7m+JKew
 BZ6MkDI+Id3QH7Bdn7xIcxIClJsNUnAtOQ5FSa9s+u1b2a0YK1f4zfOD12YuPsKeBwS8SVTErLO
 0FEOtnEAtLtx8yu1TdHpPVijYGMIoGcQT72XZ3Qe0h2ol7zABQB+YR9iyu94vRVUdgV7Dn240PF
 18hZUIJZGQ2mflDUfbtWWjpkHNjICNFPD30g0+Bl7LDPdzE7ILu1Ro43XBEfrnjGM4O2iDW9nmf
 v8eihchBIIqcGnMccpsHfWA/CPiJqIEgxE3P/B7FWLZ0tyPdzP37u/G8dOXlb3OadgpSoDTp76d
 3GM6AZemH+ffsjA0qSUFwzdajfZ4hDtrJAJ021OiO8NIOI8KKHxnRfusj7H2piqcPGWZ7zcyvRE
 rqKGdu34HzVsyLjTQSqFWeFGGvSSHKVQRYlqDY20yl0qm7e9CUcek4k/EWXmyUkWxbx9raA1w+l
 0vkIW89bayXjYa8yr9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01

On Thu, 12 Nov 2026 16:13:33 -0500, Martin Belanger via B4 Relay wrote:
> After the TLS handshake, a peer may send records that carry no
> application data: a NewSessionTicket, a KeyUpdate or an alert.
> tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
> It returns -EINVAL and leaves the record at the head of the receive
> queue. Since commit 288cfa187208 ("nvme-tcp: start error recovery when
> read_sock fails"), nvme-tcp then starts error recovery, and the
> controller reconnects.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/3] nvme-tcp: use an aligned buffer for the TLS record type
      commit: 1193566c35ead643e954ff8356bb54b1cd78378a
[2/3] nvme-tcp: move the TLS record read loop into a helper
      commit: 76afef5e29221e68f9a19df767f94b092c31e974
[3/3] nvme-tcp: consume TLS records without application data
      commit: 687e743e4089b2a854982b321cb2d681ae5d6136
--
Keith Busch <kbusch@kernel.org>

