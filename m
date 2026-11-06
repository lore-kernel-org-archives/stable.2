Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990609;
	b=cJx1TI4CL63bKlGX5KafD0K5/Tnl/GzIeVRVKCGy6QTyIq84o87rNF+RP11bmu7peBCM
	 TeLTubtdQKQAPRDY4Q3RYnkHaqpid+ZNg1gKJGOLyqRv2wGXaf0bwPpivdmSBMzRwpmcA
	 5pXy9K39BI5ZUvmsfEvIbNcn/3pS68H/dMEKvjJGXVvTXWXZoNoVYz+rDpkmBG0DmJIJd
	 PMw+udbF6bYUuHWhEPP/17yB6pX/gv9WZl2qFU+ov/028rtaRnKRUKCEo5bSthq/T0S2s
	 2W5Ja2PlCCYnL/pU1+/TnC+1aspad6lydIAxCbYJk20oJE9PZU+CKGQPIP0hJ5UAAPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990609;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=7cDWiUbcFlhnKGjqNM2nYKV6Y4p9T6n4qbUjHUCHRdQ=;
	b=Qjn5pNVeArpPsCvWlujJxC+J4p88HZnwz8dnX66NI3TtP/yaNcJWsRHeFzVTHINiwnR/
	 0WiDkPmdifdJnccVDSaJW+rSXtUxqRGjnV0RRWpR2LaKIHpH7OCf+HCynzewiaEbOXxgC
	 HxN5pPD12noYyvNA/Is8f01NnG46Zx2+my5fIWa5BHW1Efo4yKrDl3Zmqn+VcHQtOwGWP
	 3pWTYdG7K4wW2T/BBD9UM0kbCYXcLjfub3BvvVa0c1A9eN5tqJTEA63o45VsLVWUdvCgl
	 srYT1BnZ1iK7sEe0PO8at2NKVKFMC8ZN8pdPEBXrw/sLSAdjm0lQ3gTbpUNpxDlzDLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0660606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0660606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6IdlXp3508106
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 10:43:28 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r36bbn-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:43:27 -0800 (PST)
Received: from twshared98006.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 18:43:24 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id CD7B42E8EFD4D;
	Fri,  6 Nov 2026 10:43:07 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
References: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
Subject: Re: [PATCH v2 0/2] nvmet: fix stale log page data and a ZNS
 Identify error
Message-ID: <179399058783.513959.1663411821731805278.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 10:43:07 -0800
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfX1F1P9P0JmTgm
 P1D9lBOuzD1ndOsz5cjO0e33TA/fUzikpiTO+M0wuVNRVMg5UJoVZf5fQx6UhvbGWfUVBHOy84l
 acHezcjl4BGQBBYC7jBd8jzgbB+yeVx3Reur+1+OkDVdKlyRGxuHeRBvGEUv/fZEtMFTgaJ3B0p
 9ZSLTXpTL2ZeorWX4g9pJqiGs8wQmaAa799bF7UGj1ycNp1CXQfmVo+z/UNNRLiJ55PcXtjPJuC
 hCDwTNASvNt4z6lxQqMGIXbC/iAChHqIR7WdywwgfcfKwPLYryBgbdlyKdkl8TBkAVmQ9iZbWn0
 irDNiVCFWsh2VUhkRInMiMgwQkaxDFuvId5Q197tX6CUyPJdShrF1dxY3g6xGo0rTJ3q5bItmVC
 4WElB7pCUttR94fNP0Q7r4rzMRWeIPkkBj7EVuMav/YpW0zgToSKtVYUIgbBH56JkVR3w/I2Ipp
 K/c+a3HbWVldhT4PbaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfXxc+ZMEEugGbx
 9RRvwTz6WZ6oqVrJUkH7p0rCyyYP7PL/sWTY45iUkcg6IRiYR4yb+aDwzobmbenfKNfnLZyP/Pd
 yvRxPGRAmUgNFKTDWOqDb8/GzClDyG8=
X-Proofpoint-ORIG-GUID: z8ozeKLrEKPDqqxlFWIdfAJOh8e2IjYt
X-Authority-Analysis: v=2.4 cv=N468hG9B c=1 sm=1 tr=0 ts=6aee1fcf cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=W_VHsVsul2iShNWWr0sA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: z8ozeKLrEKPDqqxlFWIdfAJOh8e2IjYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01

On Fri, 6 Nov 2026 23:00:13 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> This is v2 of the two-patch series.  Patch 1 now follows Christoph's
> suggestion to zero the whole transfer buffer instead of only the unused
> tail, and both commit messages are shorter.
> 
> Patch 1 zeroes the entire Get Log Page transfer buffer before filling
> it, so a host that requests more bytes than the fixed structure no
> longer receives stale kernel memory.  The Error log also clamps its
> ring walk to the requested length instead of relying on a zeroed tail.
> Patch 2 returns the namespace lookup error for a ZNS Identify on a
> missing namespace instead of overwriting it with a successful copy.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/2] nvmet: zero the entire Get Log Page transfer buffer
      commit: ad606ae5635b68e324005aaa06421be752619dab
[2/2] nvmet: zns: return the namespace lookup error for Identify
      commit: 687f3014afcd5826fa3d8f40b445f647b5a379b6
--
Keith Busch <kbusch@kernel.org>

