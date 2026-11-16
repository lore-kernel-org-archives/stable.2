Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845925;
	b=1vnOyG20o1cmeI+YCxMnZgfKW8qMTq/Eti3ZvTiW7kQa0toWAieynmQdb3NIWDqxCBq1
	 m5NKVmiX2ldG5Qzdfr2TOWgUQfjo8YqHuTTK+GgKf9A/RxiAsk74lD9LWdW2Wo/lGxF3l
	 LwKpa3hTGTKSLznvoJFhAtmLq4X5s9d5Dd4oAvKS7cf8tHjL3h7LUmr+4DOrGSRMBR2h5
	 oTDNoGkx5FdTIVDBChIHPQeBtaIK2f4D3nEJyjY3vFXvXiDpo/KUEkkZJ+4zV3qyLvyXu
	 acQCyG09Xc7USS+cc+pzlW1beOytYEp07hjVteecsFbODHUAvOpvZ2qjRwj2epOKxHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845925;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=raiTjx+BmSkMR16aTA0YXPp0R1Sqdpp0zR0V56k7sp4=;
	b=3tzm2pUEfVVKJROIXauvhnPgdgrz2FYUfMixuKkEpAXBUiJzei1rj1aoho0seC9L2pNF
	 1G+uVvrQ9Rf91KsttsBT1Ifjs3dhEWvblKqZgsf/EiecICyIU2O6v/Rb1c07vGfWuECPT
	 TnD59zr+aBtT86oulFIp3wn4xYuAd6F04GGEFdgMR/G/9dTswSo/1YV3QlCAZJp1UVOTU
	 zlPk6OejAhYIRUSbO/+DbWPmAwzKnYZ5DjNFlKhDoUVqBCRhvOc/vRU5ES2GI8Glcib1S
	 7K99xmd6x7Hn/+8pBuekcY4E7XxYiSaLkagqKzYs3XzsrO/ofG1p+y5vnCcM6rp1esw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA7606A883
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03CA7606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIfwT2162510
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:18:44 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxp1gjeep-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:18:43 -0800 (PST)
Received: from twshared77744.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:34 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 7EA1F2F08A7B8;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn>
References: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn>
Subject: Re: [PATCH v2 0/2] nvmet: fix file backend short I/O and LBA range
 checks
Message-ID: <179484590951.648177.11841424492574370118.b4-ty@kernel.org>
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
X-Proofpoint-GUID: q7q4DMRIgqIZAzS7EDHlm9J5J7I8cTII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfXx4G+1kIuUuny
 JBUrQrsIubqOslQPXThDhWwFAGD6pAtb4CnPFeCQWtHzGVyNe8Z30QCFVhfWo7siOI1ftNDbDOM
 qwYgNC6AVIjOd0HjOxK0XnpWdyntbTlj/oJNlCntwtHrnUtDp/9CymG6dWyHLYnJxnThQzOXoig
 s516/I+dWaj0c40KyB+tEHkU0VeqWEvFDiLmdn+1mjVkrBLX0Whn7vispZtuQEH6/ee3XxN+4rH
 Z4dn45jhjCuZK4kwTpbjJb9PntzJtjhtBxyL4QfqfIsst3bXzOu8PDWKi3t5Mrj6oNgrPYnLo7q
 1cSx1+SsERoEy+IUaXa/JoPUbYviW5B8ZstSt4TWup8JPCu0CG3V+fpDfhzhnOCTxwdWxF9+bsS
 6pJS/E/Pzh21ut7BxJAglgQojYGXG6UhPuAimZWg455K0/NdjCzOg+rUZS4oXeTfnn+Ii6l9kUq
 bXESDCJO1PodCSXtWHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX1Y+ekoS7HBlJ
 2bLBQbbceaPIVObAdYbb4agVAsKA4TsZ6aJxqnqpLPYLTAHpONgphm2XBD1D2vUh4aenNVlYD6a
 M4Fj4S390GlnhxEMDL2RVueL+JgAOl8=
X-Authority-Analysis: v=2.4 cv=aMRlOr9m c=1 sm=1 tr=0 ts=6afb2ce3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=k5peSaqcjJABVPERissA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: q7q4DMRIgqIZAzS7EDHlm9J5J7I8cTII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01

On Thu, 12 Nov 2026 22:00:58 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> The file backend computes byte offsets from the LBA and block size with
> unchecked 64-bit arithmetic and does not handle short reads or writes.
> A host can therefore make the backend report success for a transfer that
> only covered part of the range, and a large LBA or length can wrap the
> range check and reach vfs_fallocate() with an out-of-range offset.
> 
> Patch 1 makes nvmet_file_execute_io() stop at an incomplete submit
> instead of advancing the position and eventually reporting success, and
> converts a zero-byte completion on the common path to -EIO.  Patch 2
> adds a shared overflow-safe range check and uses it for read, write,
> discard and write zeroes.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/2] nvmet: handle short reads and writes in the file backend
      commit: 1738de07a79b9abdcffe03571c442033b80e7fed
[2/2] nvmet: use overflow-safe range checks in the file backend
      commit: bcd5316e708d418f03707c183571549ad878cfff
--
Keith Busch <kbusch@kernel.org>

