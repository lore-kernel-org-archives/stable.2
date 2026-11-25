Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.207.212.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600317;
	b=gwkuXic5XLKYs2EgbktOz2i3DDEhq8NileJwts46udp+lxORv4pYnGiCgc2hmOfOa43X
	 YadyvgWjeLj9QhY6VAARjqXij5VNNr+5Gc0NP9w35PJgbnX4WEIL8e8qlgJlNSbWyijPW
	 5F0Gz10/SiksJFY9PGFp8pX2+Dsy9QVYsuXM83TcSd2drP8nPFWy73cjZaHu+xBxoOn9R
	 eeSgbt5Mi3rNfAFSez4OvK3RVkf8kwfMDxRsBPUdytJ6iZOEMA3rf7rlRJe4m9QZ8nmhB
	 m6EtH1Jc/l4GBIJltHkD0PH62XkKO/IPWiJBV0jC0fH9RSCZWpTNKHxAx89U05iNdyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600317;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID;
	bh=olLPCePRoTvOoSt0pwVcurmzTyyN30ZXGLZ3ovcfBec=;
	b=mOQCR9qcO8oqM8SSS5zypNWgpeag1i6sVW4sk5zR2goZE2JLgn93TD1phjmbaS5dBq3Z
	 n+qlh9kUxIAsyLkgnlrFtrJMxjCM8D64pwf1J0MVJ5dvi3aZWh1+RuHYlnhrBqNpuSzfH
	 q1I8EDbKQSj+/LKC6VWZ4DL9uDqNuzZ/N5ypZNNgwo3HEOuyCZYzsYbDZ8Ky5MZMp9Va1
	 vi2GV9FOY3Z1fFpL7ElRR2XTyWdfgqX4DS26RfMdwrhLxoIgMHhxFWYPn5TSnQrxCECM3
	 aHZeMhIVbVCyQVxH2TsXKm+nV0k4KqlcNERUTEEPZE2UJSF8KZnYKIPBkqHjW5UM8iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=imgtec.com;
	spf=pass smtp.mailfrom=imgtec.com;
	dkim=pass header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=VE4XAU64;
	arc=none smtp.remote-ip=91.207.212.86
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F7606A31E;
	Wed, 25 Nov 2026 09:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 975F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=VE4XAU64
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id 6AP7RX1u1892955;
	Wed, 25 Nov 2026 09:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=o
	lLPCePRoTvOoSt0pwVcurmzTyyN30ZXGLZ3ovcfBec=; b=VE4XAU64lB+uvwVXs
	sh/0f5EJUsZnBMhDcTMnFBbHFcee2bnbDolmTK3LomVcd2rn4aDHJ7SHZEy+wgif
	YqgQq9cbuZh1XwmrBQjUo5Ez7wq/y+7jELQtE+Jod8jTOSXhNf3GlTARCWm3GIgI
	4ycthnSrk5x4Abcmuew3kDpaDYT7d8Vlb2EStkevbmtBnMGf/zqgCfreoYXan8ce
	vtQmjanHxRRojLZODGNzl3C3i9jdBJJDT99J3C/6Um3xGXy//zQ1M/hQAniXyNg5
	q4RWD/BGMDA0kssLF0mONbLsMxIPPJM2Ed1P7SfA9EfpCf098+K246amjESbpQtn
	bfvqQ==
Received: from hhmail02.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4j32ev2y2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT key_exchange=secp384r1);
	Wed, 25 Nov 2026 09:51:09 +0000 (GMT)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.206) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 09:51:08 +0000
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Donald Robson <donald.robson@imgtec.com>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Ryan Brue <ryanbrue.dev@gmail.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Brajesh Gupta
	<brajesh.gupta@imgtec.com>
In-Reply-To: <20261120-rbrue-suez-pvr-compute-overlap-flag-v2-1-ca2b0d3adb4e@gmail.com>
References: <20261120-rbrue-suez-pvr-compute-overlap-flag-v2-1-ca2b0d3adb4e@gmail.com>
Subject: Re: [PATCH v2] drm/imagination: Fix the value of
 ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
Message-ID: <179560026866.99509.13316300592251732499.b4-ty@b4>
Date: Wed, 25 Nov 2026 09:51:08 +0000
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
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOSBTYWx0ZWRfX9Dn+HSZAD6Tt
 SYYpIcPLjUBMWUDM3vcw8m9mU+rJS0xtYnHmJ0jHK9IapFkRjyeUx+6vtbuoTnVpUH5tRl+/2Pz
 QHmLmgfhZJIhpEvG+4ijghc1hGTXkoQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOSBTYWx0ZWRfX8tMPxaCEGI3g
 N/MVU1jIlvUfaIcoHctcTRtCJkHudGuEKsZyJQFs8cOl3WuXyOSCZhJu2Gwlg9Jft7R4GW4WUvZ
 eZKy9a3iDIGHohhmvG9OU6qWsGzfqjgVYqXeKcEK74UM6Iw5zLaLBUzXiJ0b+TXG5iSMBYgrM5D
 LlnU9mO7sTTpDh3BwjzaFavxcm9bVuqcisFgTJJ1ATDq7AgizVPOno2RyEdEcuQT9bpiw98d99h
 a6gc6TJyHWx2DVEWXjwzUe4Z1qWCA/6L73HrvUZHjRfabaLIwC/U2lIoWsRs4qVPiCPsFrLIiPw
 m8Obgv/ZKlqgUGMHypqN8vMnElrbnv57+g9uQWtrnoQeF/bLud1zyimbwOSgMJNCwkgaksKFr7b
 KfwRi6y9aqYlc7EfD+sFla6KfsGwGNIWOXSRT4g/YFfUZMh8rWQT7iA72r2qdrzFd9Z5GvBjc8W
 JCKN2ICBNx1qHnosb8A==
X-Authority-Analysis: v=2.4 cv=T7AZ3PKQ c=1 sm=1 tr=0 ts=6b06af8d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=x1h3Vcw_oJoA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=QMXX3u8eltJvR-spqCwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: xmHdNanYvgEey0z5TzKpi7asIuJySAaX
X-Proofpoint-ORIG-GUID: xmHdNanYvgEey0z5TzKpi7asIuJySAaX

On Fri, 20 Nov 2026 12:10:21 -0600, Ryan Brue wrote:
> The firmware takes "prevent all overlap" from bit 1 of a compute
> command's flags; bit 2 is FORCE_TPU_CLK. The kernel has used bit 2 since
> the FWIF headers were added, so the firmware has never seen
> DRM_PVR_SUBMIT_JOB_COMPUTE_CMD_PREVENT_ALL_OVERLAP.
> 
> On a GX6250 (MT8173), a compute job overlapping fragment work from
> another context hangs both data masters. With every compute job
> submitted with bit 1 set, a test that hit the hang on every run no longer
> does; with bit 2 set instead it still hangs.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/1] drm/imagination: Fix the value of ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP
      commit: c8f6ef3d41ea781227869e11a625a6fae574af57

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

