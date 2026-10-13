Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956F48FF8E;
	Tue, 13 Oct 2026 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871819; cv=none; b=a6gXX8Cy/Y1ox1Hxeqf8oXTbPbjlEx5FCN02k7O17JRSphzg4+/Tu59m1RfWcteq9irG/lL5+7nz0TAQNnSCMNTTQogOQoOjuQ/Hm8/FAYCaVFWUJuIYwZ63r6GIgdLMpD4hsMn/LkcmnM2Ny0arlHNbt1jx+Le7LKk2DnQS6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871819; c=relaxed/simple;
	bh=JaM13//qanTP8TJ71KDDNWoM/oxl80dioRFxbj390NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceMOYatW0SObwQ408KxK4togmkPyUGSJIdkXo0Qotes+sqVJvnli9L18SBd8ZAacUujAGddGcDjr9qEcDx/nfyXgpPiNwAchF0PyWN3pVna8ivkE+GRDUHgHIfO+z6p0lPATRhasPx0MG1LbpdbzJzkb5zoYvKKy4Sn3139yC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=hPR1F7S6; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="hPR1F7S6"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D51xSU2122405;
	Tue, 13 Oct 2026 06:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=rMyLpkb2Ko1Gi
	29ez3e8ETPK/MLyp0S93/vOS+Shfmc=; b=hPR1F7S6cn3MPAbbDRFhtrNLBPK6Y
	DVf0rp7Up4Xvk7fgtZ+4EzAsyDcvheetCUyTc6u6SUbstcUFK/WHrJ9b5uqEHpSG
	TEoo8sL2a81lcTuy/FIixmCV7J4V1qg1czW75XSr0lCpt/9U1k5UzTAHzV8d9PvK
	miKt6EFJRgh+zkQy6vkT33YP2RhR0q/z5iKZmsDvWc4QQ4obyf6J2GrbRQmH1C5B
	nmphecdzgmcHezIDZYeoE5xKzHn+yW94iKEubWX+tSat3NGZQRObSeTpTydf1dX+
	D270EP3IiAXh9P1wtWDXjRM39DyBmfm9MQFB6KCx6/tB9XP2e63VQ+O5g==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4h98tkv8je-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 06:10:07 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id F1846804788;
	Tue, 13 Oct 2026 06:10:06 +0000 (UTC)
Received: from localhost (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 49D88801624;
	Tue, 13 Oct 2026 06:10:04 +0000 (UTC)
From: Keng-Yu Lin <keng-yu.lin@hpe.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc: Keng-Yu Lin <keng-yu.lin@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.liang@hpe.com, david.chang@hpe.com, s.collins@hpe.com,
        jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
        zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during enumeration
Date: Tue, 13 Oct 2026 14:09:57 +0800
Message-ID: <20261013060957.1023448-1-keng-yu.lin@hpe.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com>
References: <20261012104645.975190-1-keng-yu.lin@hpe.com> <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com> <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P94nU8FdZ_YgNLs-1ZbLUtljqvM6GEMM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyNCBTYWx0ZWRfX+PMRdTLGzyIt
 DqzdFOHx5+tZyL7u8TL/kCMX/83s8PTFRlRmydcXH1gqXZI5x/SF5CG9V6Y4E24nuPT7cdaf27G
 stG9aqIGLlH3pz3dvMI2ZrBdS4NhMAJEQni6Vdsb1srotf9W4P1+FRswZCTVMnJ39+n3PPIGFMb
 O+JoyXw2EtsJzhX2T2HJ4tfM1jsQcKdcfh4QnlppyB8mV1V2Mv6y+LPX+I4yS62AiVWfrak3iDu
 fsL1y5WnmLKc7VEbak0p/mN6uuE7HkLhESghP6MXFHO3JbRdPNAAKJVFrHKKwcK32DELXcDSA3g
 ZoLK8JwetpxPnqkRknWOMGiMGym5kg2FdN4OxmhJ2a34qMXbmJ3oe2M1mGPjKE2mx8v8NYc8Iy7
 S9IuWeJYpNUHNTDKTAjukX0a7XJDcRbQEB1Q6h0NejW3ClLpBVPHVdGKSAN5kzrKsWr1aUmYUUD
 /hda/tCUeZmfHmSd8cQ==
X-Authority-Analysis: v=2.4 cv=GtTXaU1C c=1 sm=1 tr=0 ts=6acdcb3f cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=-hSnzOVrXkb8ETtfCG8A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyNCBTYWx0ZWRfX5IgSFkD+uMWl
 /v0eI1Pm1Fl6xaFE97Mc9SPK25APTZPzyI474E91GacAG6H5sAC7Nd+8lQP5Wt5wY9rnRD5uAlh
 3fdK7ZE/SAUs0rG7sPRv1FHWSe0JRWs=
X-Proofpoint-GUID: P94nU8FdZ_YgNLs-1ZbLUtljqvM6GEMM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130024

Hi Rafael, Mario,

The initial read is not needed to fix the reported D3hot-to-D0
failure. I added it to avoid extra BAR writes on devices already
in D0.

pci_power_up() does update current_state, but need_restore is
calculated before that update. The check includes:

	dev->current_state >= PCI_D3hot

For an initially unknown device with PMCSR reporting D0 and
No_Soft_Reset clear, this still requests a BAR restore. Reading
the state first avoids that request, although the final
current_state is D0 either way.

Before submitting v1, I tested a restore-only version without
the initial read on Venice. It fixed kdump, but also rewrote
seven unchanged BARs during crash-kernel enumeration. With the
initial read, only the two cleared xHCI BARs were restored.

Thanks,
Keng-Yu
