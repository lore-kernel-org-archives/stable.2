Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB58184524;
	Wed,  5 Aug 2026 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785900500; cv=none; b=Jt5Fd2N/kXspGNXa6yAJhh0raURSYm4YDG6rbqpopFpclAgbG3KuTLsmf4/I1TwsKf67YdtM6kHIEyobneaaPzNYqA3GFEanru91k5InRmfm/SIipJ1oHRIeREQ83yB+eTxewfwRzIvtyKuetyFmD6vs8Uv+g2esc84r0QOqXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785900500; c=relaxed/simple;
	bh=NwLCYq68+6gQWO7WClK0tyMVog+TRZe4r+ujpcPOdks=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOPIiy+kx/y4y8JbvLSvUid7xiiMNyiB6dTQeS8T4dLGBFt3egWdI8KSHRc2bAzkgmZ1SGuTeYj3j5OLRMZ8bFQ9pOVaBo4rxJYAX/u+rRQCkXgfJCWXrA8YE7xXRdIMcC76tGEzb540Xqxm+l6t6Azzz0YwmqAxP9ybQDzoEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YNMKQDck; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YNMKQDck"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6752doub3233247;
	Tue, 4 Aug 2026 20:27:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=NwLCYq68+6gQWO7WClK0tyMVo
	g+TRZe4r+ujpcPOdks=; b=YNMKQDckBFbcGqUV8vz1vjgalFcIWYiCnsMDbC0tJ
	axsbs7cwP6KrDN6M+LxcZm6qmU9EyYJP/+J7e2cZVePLuienBodjgFBpgdOy5n1Z
	H4jfxJksQCL1DNzbaoX/uyZbPps4AclN4ts8XLm0r7Kycds/BxbLs7pmaE9YY7Gz
	V0Pl2Blv8EecCzE424jEu1XnrUaN+YILAwU3lHPhwZoN3UfsTCiEa4W/9FvtXR1F
	WoV5eOPwOyBNcaNCkstLKYfNWZYToVLRpKVcQd3pzR02u7aINIoEW1ZMslKQ5Zcb
	U75E1p6tFwKwiHibvqtTdrQB/Ly4xE1RuPAHHmqXyxUSQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fu31d59vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 20:27:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Aug 2026 20:27:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Aug 2026 20:27:53 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7C63F5B694D;
	Tue,  4 Aug 2026 20:27:48 -0700 (PDT)
Date: Wed, 5 Aug 2026 08:57:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <Sergey.V.Frolov@kaspersky.com>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "Naveen
 Mamindlapalli" <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2] net: octeontx2-pf: Fix UB in shift operation
Message-ID: <anKtsyHJPFXUIarG@rkannoth-OptiPlex-7090>
References: <20260804120446.1955448-1-Sergey.V.Frolov@kaspersky.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260804120446.1955448-1-Sergey.V.Frolov@kaspersky.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDAyMyBTYWx0ZWRfXz72QX60IpJk8
 yPPWgWmjFarv8R9tIMffauCiT7g3UwpNDF9j3DcKdPmWGbpuCpSJeaWu2ksZHvK98WeWlUYOwRW
 AlMeKdhVbCH4u2oK7nWbtedTutREWB26DxZX6Y02MrOOxwtXf6dbDpFbGPYCsnsKVpEBO/IzDAt
 WeXcpFshuemuRjHH6qcdrmkLTfaTfAFoaVxySRX+iwd9QY8+tqKkPj6EGREBd0XYwYbRPO1kBvT
 Er8rzRlZgdopYRZEKkRP2ETuT8W2K20lBW0GhwOo6fCJLDcDX11+oAbGNxe6OzW8QsgHLREPoGj
 6RBbqtxUwCd5+49hXcsme2ojrvy96Rqr3niCMMiqPJikX5FpETBtuLPLxB3eNPGHS2vbUWpgcpr
 4K6wWMNVWuFjRqQ263O6BX9fH54OVAelW7fDzRlfN6MW/011VZydJH9TCfFCdM3KDD6DZKmfnzu
 lqirTvebwEQ7d3QZv7Q==
X-Authority-Analysis: v=2.4 cv=T9K8ifKQ c=1 sm=1 tr=0 ts=6a72adba cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=ACEZY41XAAAA:8
 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=wh1V7qjZsdyru1OWLx0A:9
 a=CjuIK1q_8ugA:10 a=QM_-zKB-Ew0MsOlNKMB5:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=hoMZ6-YlqaBSvj5liN1y:22
X-Proofpoint-ORIG-GUID: udZYFHx9jWPQ3vKOrweM_LEc99VQ-_Iz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDAyMyBTYWx0ZWRfXyGHGFCCjcXpL
 RPxpLWXSNCOth2DsDvXhR5fVRUtKar0F+YZe3RTIfJgX6a0DzM+WxkmoxqO2lozykSb48i+nX9u
 rsGC7JwK/hc9kdJRi8YsBbULawO/U74=
X-Proofpoint-GUID: udZYFHx9jWPQ3vKOrweM_LEc99VQ-_Iz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_01,2026-08-04_02,2025-10-01_01

On 2026-08-04 at 17:34:48, Sergey.V.Frolov@kaspersky.com (Sergey.V.Frolov@kaspersky.com) wrote:
> From: "Sergey V. Frolov" <Sergey.V.Frolov@kaspersky.com>
>
> In function otx2_get_egress_burst_cfg, when the parameter `burst` is
> 255 and the max mantissa is 255 (0xFFULL), `burst_exp` is set to
> `ilog2(255) - 1`, which equals 6.
>
> This results in an unsigned wrap-around when calculating
> `(1ULL << (*burst_exp - 7))`, since `*burst_exp - 7` becomes -1,
> which makes the shift operand 0xFFFFFFFF. This value is greater than
> the width of the left operand.
>
> According to standard 6.5.7 p.3:
> "The type of the result is that of the promoted left operand.
> If the value of the right operand is negative or is greater than
> or equal to the width of the promoted left operand, the behavior
> is undefined."
>
> Fix the off-by-one boundary condition.
>
> Add a WARN_ON(*burst_exp < 7) before the else branch as an
> explicit safeguard. This ensures that if max_mantissa ever changes
> in a way that reintroduces this condition, it will be immediately
> caught at runtime rather than silently triggering UB.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: e638a83f167e ("octeontx2-pf: TC_MATCHALL egress ratelimiting offload")
> Signed-off-by: Sergey V. Frolov <Sergey.V.Frolov@kaspersky.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
