Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920956;
	b=e2TUjQ+wdiuwqvBdDBFKfhx+A8q7Sf/mm9aduCq5XKtwPTdZAUojem9wBXbr0H074rnc
	 Ft2tY33hJZh0wDD53FwFiGgED6ftLr7O2Dg64kLOhK66EeV4boWLD/7rllKrSHOw6gPJp
	 sUU0QptsczuHsnv+a4B3M0VqNpZ4xdTHdwmY8qeqouV6pXJvXVwfGRz5lHi3BejHTvy8k
	 m1WdGjZOMXYI2eZBFPrw1pUPXgSwA9usqA3mGrV6kTm71aV21JrgCyj64cAbO605VdQ4A
	 9U4F71YhDXYn1NeDnBDrjuIH7/Eya4kRb3pm3sj19sWA8p+Ac/F9ReuXTYrdOq+Fd/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920956;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:In-Reply-To:References:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-FB-Internal:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=F+KcKhR5CnH65kxRNvl8LH+QFZdieMym2Jst7zi2+xw=;
	b=srsBBTTLe9Z8Jj6fgQfwf39P+hFKPkt/ApiPQdPLKaqBxcwPaJ2zvHge1DSGFlOAiJEI
	 WE1MTpRo51pE2iGK2ec8uBRPmV8Z7xJBjANyRjyyJMfxY7wz3+ahjy84TsqXqJsAhpdSw
	 84EIQDqK6dqSlhBhVjHRK0Ah2jykHvqAAuQLfxzlURRST9dXqj7gdf1CZE/ui9e2tboWG
	 mYDU93v4Ft092gV7aJgHJVkIlwSqa+M4kTrQKoaJqBtV5k4qC/g8ewbSQUpgEUxD5djGG
	 MBqMe0J9nQCw3fzmuCKWnkafUG480FU2i6kP+8aWK+o53SYWhXKkWjwwQXiNopKLTLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ORyJur++;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36166606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36166606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ORyJur++
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5N3Hbl1244789
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 15:22:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=F+KcKhR5CnH65kxRNvl8LH+QFZdieMym2Jst7
	zi2+xw=; b=ORyJur++WYpP5A8LFnqWIwPQpzCvgVbRDMbbdRfItLuC+pvEjEx2d
	1UFJ2BhiFf7YTmqkq+8oEwAtgYESHPE5VVK3z4aC7JTNYR/1kjwnOq485x7agFgf
	TXcKrb3rMQuzQCa0VgztXqUtcbXQjHiudQqa0tBF3UthgToh/mnTOZyjy7UACd5l
	gW65iQ2eMoTd8G6XQWOqdeLqCCkU0VVCj2JWdQvDKZuaO1BDdshzsiiygSJPDHJ+
	mmXMBgdUOOpjlL+R6H8zJJxwyhcv6pq6bNopJrAkhwXTXXtq8a7ywd9MiqbFRO/S
	sDxd5xfUevvYvK25BD3+RrktkH0SMEsTA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrbcj27dq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 15:22:34 -0800 (PST)
Received: from twshared14956.51.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 23:22:32 +0000
Received: by devvm9890.eag0.facebook.com (Postfix, from userid 139328)
	id A434B55781A3; Thu,  5 Nov 2026 15:22:19 -0800 (PST)
From: Jennifer Chan <jenniferchan@meta.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Lukas Wunner
	<lukas@wunner.de>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] PCI: Add d3cold delay quirk for NVIDIA LR10 NVSwitch
In-Reply-To: <20261105215148.GA1566818@bhelgaas>
References: <20261105201010.2297078-1-jenniferchan@meta.com>
 <20261105215148.GA1566818@bhelgaas>
Date: Thu, 5 Nov 2026 15:21:33 -0800
Message-ID: <179392089371.3269676.8761425999098988375@meta.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=PYtqFShd c=1 sm=1 tr=0 ts=6aed0fba cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=6_OcV_819t3UPtOCXZEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WSTsdRfpLFNqXUedHU7Mg_jRnqHUYVhG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA5MiBTYWx0ZWRfX8I+U5GEn36Lh
 CjhkJVyG7aja7ysfYbLC0NaI91gMXBXMRLNCtWUEAc2Gw/7TKvv6LOaLbQfZakT6mDQF8xLiqVr
 POcq1+v5JaP7G2Rxt09XYjdB4pXz+/M=
X-Proofpoint-ORIG-GUID: WSTsdRfpLFNqXUedHU7Mg_jRnqHUYVhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA5MiBTYWx0ZWRfX7DKxvwb+ddYg
 HZm3aYbg/xhv4sdvKonwWuDczP1wAqi8dGJ4xU8T0C5UNQ+gWhXSjEU3YJGkAK7wHwLLPuGiONo
 DQ5zsgY62F7IyzA6m+qlbQmaNRxPfI+KT4DRX7d6uRxX0diU47Kn7X+nJXOjmsK6JcQh2wLpkx1
 u8cJ7prdkNtopdtU1kg7f7nva4RKqanN5pKpN5YlZc/INeYkfjRHRUl2Mnm+JqXKSWlzV0nhcTW
 E6wGmP0ShoaH5frbpPjbo+kwpinpIiTxN5F5ZtZFR8jKBqsKtFfwwcuIGfrxjXeaEE5nUY+YwPw
 3QwukGNnw1oL3pEgRtyFOwpuZll7OMQ7IVRc2fgUhK2DC+CNd0h39fYQcM41DudpzHZ3sl0+KcF
 8PfsSAX68jmttNgy1vo54a9sO6nj9u8dcvPteFoPaboueRV+QU9iRM45sXycSAIew9KCwgtMWjL
 SurPitUUn3pDVK8Hp1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01

On Thu, Nov 05, 2026, Bjorn Helgaas wrote:
> Do you know where the -EIO is from?

My mistake in the changelog, sorry: it isn't -EIO.  The four switches
fail in nvidia-nvswitch chip init, which logs "Failed to initialize
device : -5".  That -5 is the driver's own status code
(NVL_INITIALIZATION_TOTAL_FAILURE), not an errno, and probe then returns
-ENODEV.  Before that the driver warns while reading its engine
discovery table from BAR0, which looks like MMIO not returning real data
yet.  My logs cut off the driver's error text, so I can't say which
access failed.

> Ugh, a second is a long time to wait.  Does the kernel you're testing
> include e8df1d194c39 ("PCI: Don't treat ~0 as ready in pci_dev_wait()
> with RRS SV"), by chance?  It only appeared in v7.3, so it's pretty
> new.

No, both kernels are v7.1-based without it.  The fifth switch fails
because PM_CTRL reads ~0 in pci_power_up(), so the device may well be
returning ~0 after pci_dev_wait() declares it ready.  I haven't yet
checked whether the Root Port has RRS SV enabled.  I'll check that and
test v7.1 with e8df1d194c39 backported and without this quirk, logging
what pci_dev_wait() reads.  If that fixes it, I'll drop this patch.

Thanks,
Jennifer
