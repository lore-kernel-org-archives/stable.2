Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845925;
	b=GgyCgmxh6323USimy4wOcKyUcqFV3WwI+Zn4kEWrvlhROUubABjV/d/6G9n1gMviInXL
	 WmRkydTHWDOeZbVmcqNuHWnyTGtJ6+WJ77lTWAIcmBsqHMc6LVkAuGjV3lgIAwxeO+ebz
	 DLeBZbedp2uOvhxnYKrY74iSDnLMRoeBagpNa7p1lBamTmOmbX7/IsudZ2a0y96fnZOBI
	 mUQT0ZryjSlTEoU1f8u1TOBPQ/9ppigwJ+vYhsFcJCFfjN+1qc/lGc1+mDK+zL9LGs94a
	 IZrIeQw8dPpuDG6LfGFVIH2yowjSk0MD3680GUHna8dcPf8oiVSUwWpLxD0F+Qd7zBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845925;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version;
	bh=es+zIQRw7IaTBC32drouG0t5KhieHio0Lk9afbuliIQ=;
	b=1NtQIZ8XK2Z2sMPPzTrUfFmQKyeFBj5N6pKA8C+LFVhLc/iyJYZI3d425pDCCza4XCpR
	 ytK+fu9mQWncWUtf0q8722BG+kJkfdF/ocyqHBu0lyxTu21ed6Hnwu1KPVtc/kyKeJYME
	 9vhfG57K3TeUwtA7qU0yrV7z21FHAbyDpKzh1Z5SS/8k8GFNWSPNRoX8dPbLaGo7R6giz
	 /PQ7/b2KhPJPZYtcv3DN0fNceWEBMIrFy6VLhBY7GmNuShGpm0jd9yRLW0pk1b4A1YTE+
	 slZv0Gwed7N4HhI1AtKMKKOk8gVpTx0GqMrl34prMZ6UQ7BDAznrpxpiWbuZ6xa1JSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3C606A88B
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F3C606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIguk2345161
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:18:44 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxp8hjfdw-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:18:44 -0800 (PST)
Received: from twshared26372.02.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:41 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id AEA4A2F08A7BC;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <hare@suse.de>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
References: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
Subject: Re: (subset) [PATCH 0/2] nvme: use the parsed offset for DH-CHAP
 secrets
Message-ID: <179484590971.648177.3828440087409001566.b4-ty@kernel.org>
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
X-Proofpoint-ORIG-GUID: 4qgWtM0Ivg6g82pgoWpsk5Jg7R4EbjGw
X-Proofpoint-GUID: 4qgWtM0Ivg6g82pgoWpsk5Jg7R4EbjGw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX73cyoDQOLZCh
 bSroBy1bK4MLT4M/qwKnhSUQybTTp5FcF5ngaYpaW2NhbDaHOni2sikpYrg2ODqvT2Z2Z5a4TAl
 nu64cooSGu58dAF55yKS/kzuS/CFzjD1xp/1lhCeV+4m1IP2tUpxdA4P20AO1OaZfwXzD3+m7gp
 DKYssQstjIxeJO5+jaljaEQdApTRpAhvAJoYCPlbheul1xcu4cEVygofUmCcInsaVfi9JEFMc4F
 LludbkOC9myf4tqNXXLw0VOsCOmCFlEXX/lmRQ1YfMTxvv07+1cCdlwOJfnzmYnjF2iQlaVgdUI
 Kzx2g9g9pKfiQTngKo0R5r5FO8wjoUiWvCRBJ+QUFjUCemWzTcviYwhf8BIGufmTSkUNBUmAI0m
 y30D0DkHvRCzzxbHK+RSBgzOs3sOPv99fKP/fwNd2W4MLLjSkjpWowv35oXqMv8r5m1PUxcLj6y
 IYMtLXbChUFuw/j66dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfXx1Mcw5C0YzR+
 lbu0JKDKo6sg7k5eZHf6H5y28EjssGMhShch3x4qT9+65zXqi+nOMslP7L0LDKPTrWRj/8WNS+h
 3eNGUQoyykpM57nY056u4DB2ruWjTGo=
X-Authority-Analysis: v=2.4 cv=J+4/fwnS c=1 sm=1 tr=0 ts=6afb2ce4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=Ru7rdtjBa1pdOxYo90UA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01

On Mon, 9 Nov 2026 22:59:14 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> Both the host and the target parse a DH-HMAC-CHAP secret with
> sscanf("DHHC-1:%hhd:...") and then skip a hardcoded ten characters to
> reach the key.  The prefix is only nine characters when the hash
> identifier is one digit, so a short but accepted secret makes the key
> pointer point past the end of the string and the follow-up strlen() read
> past the allocation.
> 
> [...]

Thanks, applied to nvme-7.4.

[2/2] nvmet-auth: store the DH-CHAP key offset instead of hardcoding it
      commit: 62dae895f986f7459fea1deebd89a0bce76a886f
--
Keith Busch <kbusch@kernel.org>

