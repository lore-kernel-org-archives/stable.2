Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936533343B;
	Mon, 29 Jun 2026 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782701265; cv=none; b=cATC+4aFjn0sbc2x6OKU+pInlbkYW3X3jVaBtVhyf3r8vF6xMKjjXUsEyGF9+RNXEChUFW1EghBLc5aYkSYCcUwMHfTo8pcdtoev06P09AbAIsnHmzf+jAdZ0Y1ZN2v/eJsLufJsA1fbvqQlsNteamRcqEdPZQoVREkDmclIkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782701265; c=relaxed/simple;
	bh=IfiArASDtxlFBPheGBtZmD17AkDg02i+zYiovzmIuoo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuoaTuk4iYqi6cXgK446+4gLYjpif2Yf+NzTxnAZ85M7n6DmAnzz2dhmV6DC7vDVhFNcsLrY99OnpbebYk1pUBn1Q9tQ5Z1V0O0/y1dbvgYfegl6JVHzHEVCsEZPuRoSsJlG9OfO/kG7f96auMVmtuc0MgPOhqcN6QJ9T9IBpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=g895083d; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g895083d"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T2cwJ0740293;
	Sun, 28 Jun 2026 19:47:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=IfiArASDtxlFBPheGBtZmD17A
	kDg02i+zYiovzmIuoo=; b=g895083dr0vUMu5EYngr4MB3P2PVn79OvhylcVE77
	l41zyrqAkS7QL5m9SfoO7PAdhhRsyubkuiBbw1X0OL5qgBt3J1RSIMjnXmJYiQ+6
	u/Xtw27AmXJd+cBMaScOa8oylZdfOUyJ/FEy4oHNgrZVcqlZ0iWH8DC1+lzkGhax
	wS9bUrMG2CoLADQj7vSw/7stNHjKK3uAv/alUb2YoZlnQe2qk7kyaL/w1bPT7gnS
	DWpHINDJMrGXrZucxCPuXPyr9MAmtqE4Tgsd8xNqy0ky2qViUlXhn8Q7m5iK/8kJ
	rTD4k4Zc0JiwqIOw50L3CDfjqInHJLv/No3vl0kItvZ6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f32s69awt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jun 2026 19:47:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 28 Jun 2026 19:47:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 28 Jun 2026 19:47:07 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id E8DA83F7069;
	Sun, 28 Jun 2026 19:47:01 -0700 (PDT)
Date: Mon, 29 Jun 2026 08:17:00 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <jbrandeb@kernel.org>, <richardcochran@gmail.com>,
        <amakarov@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <jianhao.xu@seu.edu.cn>, <zilin@seu.edu.cn>
Subject: Re: [PATCH net] octeontx2-pf: fix SQ resource leaks on init failure
Message-ID: <akHcpA2kRjtkDfg4@rkannoth-OptiPlex-7090>
References: <20260627060350.2544241-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260627060350.2544241-1-dawei.feng@seu.edu.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAyMiBTYWx0ZWRfX3Ynaswn5VgXL
 8jUpGm8MzLXzduUhQakQ26/ryhaLWdWWitoRwryZ4QhosipB/F5x30tnNb/7JumENjGGKuVMZmL
 BMmlbf0TyMXiTLmPv0+w2VMx0OUZVR8cJnAAptFDYCtDGuvhOQcXz5Sz/QgpxCX8Jy2X8IxATX8
 u4ByMKB/gZiq4JPTyzsqjpwzeMY8iqpFwxbx5QJ+nniXpxGDz4IpJXg+xQFEhbgUvqFHHvnXj57
 2sTRR7TQ1YugLxMYJo4p1u8lZ7iHnn6Aznw9DeojcfFM78z5NZLQ5qcpZffzOtapOcCJbafvO+Q
 TD1f1FStzc12r7rwKv7fPC+KqjxATux6mb2U163WEWofKEHRLyPlYiRC7+DiG2gLmiPa80rtWfZ
 QN61mfewMCnTzPXHQ9S+ktiFQhj2kfzcMCXhfH04CXfAXeGMEzMmOFb2HSiI1hJcZ753IvpkwQ7
 2LVf3bmmwYfeAbxbbhQ==
X-Proofpoint-ORIG-GUID: e0wTKTtZQAl40xmpJ7PjsYOfj1oRVHnL
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a41dcb4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=ceM9LITnlY0sHtZh5UYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=4Pbm1F1Cy1QVNLGpYn_S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAyMiBTYWx0ZWRfX8Cmg3ZxK7byq
 Yhlq60x1rmQnY1lYuAHKRINl8mfRWP4Stk6cDmNaVWbiS6AWgb+oUbgvyx5pDL+n3BsitCXuGnQ
 lkg+gV1Jr/iQcQpaAujxuh49/ehrlbw=
X-Proofpoint-GUID: e0wTKTtZQAl40xmpJ7PjsYOfj1oRVHnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01

On 2026-06-27 at 11:33:50, Dawei Feng (dawei.feng@seu.edu.cn) wrote:
> otx2_init_hw_resources() initializes SQ aura and pool resources
> before several later setup steps. On failure, err_free_sq_ptrs only
> frees SQB pages, leaving the per-SQ sqb_ptrs arrays behind. If
> otx2_config_nix_queues() has initialized some SQs before failing, their
> qmem-backed resources can be left behind too.
>
> Use otx2_free_sq_res() for the SQ unwind path and let it free sqb_ptrs
> even when sq->sqe has not been allocated yet. Also free the PTP
> timestamp qmem from the same helper.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
>
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> OcteonTX2 PF device and the corresponding AF mailbox setup to test with,
> no runtime testing was able to be performed.
>
> Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
> Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

Thank you.

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
