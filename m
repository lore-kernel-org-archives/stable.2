Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246449;
	b=Iri74wAcW+3KQ7fH00LrdVSIw2bW4+nwKdF0cUPyEaUbDvJA/hweFrhrNilOPV8/zPNG
	 BA6/nCZto1s02YBEq1HHf5LNrQDqePD4lsiAdNOOwuK9Fkg+3FA9MTumO38ZUGZFzz0Hu
	 wir7bn84DGhi9xtYAiwL5RHZ/GzwJNO3C/FjM2QEkIxvcLvcyCxmuk4XNrDRDEx2BU1wi
	 FQk6T/4f8owa6LkNkFoWD9ca61jwvtdkTTIMV4qyxJMfqfQCoiyVeqWXMx9tLGeboWtQM
	 EAhBhtYL11HHOXntHl0h46Jm+rYi1/LC7zWL0lgNp03cnG2kcmtjaq92zJjB0XLenTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246449;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=g4LcYdOZH4gsznCUXscaCp9ueXDK0eydwQ4sKQHtqYo=;
	b=gbB4rFL/6IuZOIKUnGY5juU59TlHHYNw1QldszrOMOJ+dgm/ba9x0JGEpr5CaJIrwFYn
	 IpKmPIAFLv+ZPxtsCVQPK7JTwUV26oPhO7Y0NwgCB/fPNGNIlE1pdaTsbY9Oj+fAL8kZ6
	 1fMAqT3Urlpxqn4YqC43saz2iKDX2026VDHZlB221F3P0tLoD5Ta29Krlgo75ob3nzJSu
	 INLv+Yjl5xQ3lT3ncb/BJj86kNkgPsUPvpiQhWp6F1iAOjwxXL9VyUeaYd3rgaPMsPGeI
	 0GLxb7bFogG6vXtzIuM+GWjpWRrqp2QgUJQkJ81jjLyWBTOgNfbto0N4DJ0no2+dCtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7189606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7189606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A9HIWZa1238192
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 09:47:27 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ht0btb4cn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 09:47:27 -0800 (PST)
Received: from twshared36767.32.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 9 Nov 2026 17:47:25 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 1CC432EB13629;
	Mon,  9 Nov 2026 09:47:13 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261105215807526OqR0Bg86VChvwhCEz5xGr@zte.com.cn>
References: <20261105215807526OqR0Bg86VChvwhCEz5xGr@zte.com.cn>
Subject: Re: [PATCH] nvme: reject invalid reconnect_delay sysfs values
Message-ID: <179424643310.2115845.680024030621638618.b4-ty@kernel.org>
Date: Mon, 9 Nov 2026 09:47:13 -0800
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3MCBTYWx0ZWRfXz9X0wsZ/gc9a
 +IqGuyRiOEB/3PiQ/7bp4TLvnAv8JJDDUzqTYwcymdqvagIhtIIrvNczMAIfigijtlOwO92GI8S
 OS00BL1zjmm/X4pu+zGL4HeA/NKdT4o=
X-Proofpoint-ORIG-GUID: tak8S3akhDtfNGO5sxZULQsyQm_hXzwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3MCBTYWx0ZWRfX0FgyzadRFPqK
 s4oq7AqV6QgrapaeVaD697DxhlcGH6lk6tMqBu263Mw+G5364Bi26M/mNMVwWXPfiOrGH7gAW7s
 d2vxd7Rhg0sXCaoLDmfYE8fnPaeaXM09TN/qozxZssWfLRVA0EBucfRAYELKBb5wHggLM6asCs2
 qlwKhIKso77/ixtAYUyz7F+xOWsDxS9H/Auwouy/iuZhNJKjQDCgfYaDWJVHYLXOmvN4Ku4sHm2
 t46dcdXFLJ6/Xb7fJFznthcGPp+MnOoIRzBvQZJVmMDUr5ZNyg3ZqSg5L5gVOr/QhcoUizraRoF
 Jkpjfk/PWaqpYqzB/4mc3p++lR2lA1xTdRnJfa0pNDTFiL2S6Vw5dU/anaNtFkZXAJ1eYWnSYyi
 JarhGXvLf7IvXTmkDYhs0nRFh8EWQo/17tlyPyrrZuubwQBQyHFLMeXzf1Fd9ANA1NjI/6m2gYg
 nk1UB4QJ2lse46BhvFQ==
X-Proofpoint-GUID: tak8S3akhDtfNGO5sxZULQsyQm_hXzwO
X-Authority-Analysis: v=2.4 cv=d65gWhjE c=1 sm=1 tr=0 ts=6af2072f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=vuk_V-wIeD6UzulCNUMA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01

On Thu, 5 Nov 2026 21:58:07 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> nvme_ctrl_reconnect_delay_store() stores whatever kstrtou32() accepted
> into opts->reconnect_delay without validating it.  The nvme-fabrics
> option parser refuses reconnect_delay values that are zero or negative,
> and the rest of the driver relies on that: nvme_ctrl_loss_tmo_store()
> computes
> 
> 	opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
> 					    opts->reconnect_delay);
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: reject invalid reconnect_delay sysfs values
      commit: f92fe8dea19c743eb9e4d998ae0384344dd40091
--
Keith Busch <kbusch@kernel.org>

