Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8AD78F2B;
	Fri, 26 Jun 2026 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447629; cv=none; b=ktANKBBsBDPCVygY2w0BmR18dui5j85VF0BGchoTEhsxFuV1mvqx2kcJp96PHRtVV1laemQ2CB2QPgTpvSUUkG/ROD9ATYBoMJvbY93B8FD2004GSbbswJOokWAqMuJa2WKV0yux2DyQVi/CpRgCEaWVa+r1KCSRleN/ni2Rl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447629; c=relaxed/simple;
	bh=R/gQ84rbKMT05VYw5tdAgyGqVLFfbIMcRcRFCySssLE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr88EDxatjCARtTIw8w/D8c9DXEnJYpz7yutT/12hAtuOc9MhRNsifkfOPQ/Ext8nVZd25bUj9iw82XrWAbDpexsuU4SQZABChj6rj1SwTpsigjNKzZt+JM3HVxSlr3GeChwGeGaXDBSTpW2O3FVwIrbXN8F5EjVgLHGrFQzcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D35NOrnB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D35NOrnB"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2q6hZ2487038;
	Thu, 25 Jun 2026 21:20:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=z8xFpqAOQsWQ0PO6p2TwMB4Po
	lTMKxGg+AKUihtCJa4=; b=D35NOrnB2oGrzw7DCiDcE54pY01L71xXBQVcXPzGx
	O6cH7rFYxm+c4k71pf82fjeNftxN/ePbblCdavr1XtBzhYW0VmTW2NC3H/TkzO+n
	79s/nnZEc2mwD2gAYz4cQZVM/vb1czL+9pzl2RsrEatyEAYhXDxXs+S2Z66vWVti
	AdxTB6bj5Xxv95y5Hh1DkPdz//kpxZ+WoELkDVNpA9HXCDT5N5DabVVPXE1kzStC
	2HAUF0XNCNAwdOWPhBFfYkVzZHJq5Q/+y87YHjWJ1haJ+4ouIIlCnklPEnCQzk/i
	uVZWksUBjh50BdRdsvccyCwNYSXiD/GKg2y95DpIx+MnQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f11jpb8hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 21:20:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 25 Jun 2026 21:20:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 25 Jun 2026 21:20:14 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 1DC643F7058;
	Thu, 25 Jun 2026 21:20:09 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:50:08 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-af: Fix pci_dev reference leak in
 cgx_print_dmac_flt
Message-ID: <aj39-PTEOiZjyZBM@rkannoth-OptiPlex-7090>
References: <20260625063951.44361-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260625063951.44361-1-vulab@iscas.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDAzMSBTYWx0ZWRfX95nZQU70dl+q
 kG7/QGtwA5ELU6v3xa6ZbsqFPbCW4NAAA49SIEyRHVVgmilI9Ee74Rv6xtb6PG51tDs+BwBKdTd
 JhIM+JkSWDngw8reODxh49rZmi/+AjsW75Tuou3ESz606Lk9CaYe+BgYD3Pe2dZ4SDco3brzTNs
 250Rm/APwpjyKsMyYCot41Y13o9sm56BVudv6LD6koxLEcSzGsLVWdL0k3ORFzBd6dFMJOps56O
 Tf1ILh21h9fApQ2+oCrhMJipphFD2lzeS5ahznxc9o2FljtqIoV/bp2bkLI2GlneeZzbRgqdkVx
 ykiv46psLwYsnW7gEBHuCh1zECPHfr2PUiDwMdcnhcae7HqnpvKF6VStz1KjcTPSX2UE/7zHJQZ
 K1vkdp70WrG8XqLioHd06o5hj9Bnl4d3Lx0OF9XvL1hxHFxkBmlKXPVUCmzGfUEl8yBgdsjsfHu
 K8iczN7o5FyQPkm1Cpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDAzMSBTYWx0ZWRfX5iWTZKU6BaIm
 XX/AwhzRfjW5F2PMnPuf1z9eBl9Qr8pXfvqkc36yg3x4rDCxbI4ducOu6RuQrxRf+F0XJd0xQh3
 7FL7A66EFifGhZ90muu2Ajy37tsC7Bk=
X-Proofpoint-ORIG-GUID: YjQhefk4nsKgGsIN3mPVqHS-Dod4sTcr
X-Authority-Analysis: v=2.4 cv=KIxqylFo c=1 sm=1 tr=0 ts=6a3dfdff cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=gnFPaLZqP3XV3ePR1egA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: YjQhefk4nsKgGsIN3mPVqHS-Dod4sTcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01

On 2026-06-25 at 12:09:51, Wentao Liang (vulab@iscas.ac.cn) wrote:
> In cgx_print_dmac_flt(), pci_get_device() is called to look up the AF
> PCI device, but its return value is passed directly to pci_get_drvdata()
> without saving the pointer. This means pci_dev_put() can never be called
> for the obtained device, causing a reference count leak.
>
> Fix it by saving the return value of pci_get_device() in a local variable
> and releasing it via pci_dev_put() after the drvdata is extracted.
>
> Cc: stable@vger.kernel.org
> Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index fa461489acdd..90dc13df9ff9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -2949,7 +2949,7 @@ RVU_DEBUG_SEQ_FOPS(cgx_stat, cgx_stat_display, NULL);
>
>  static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
>  {
> -	struct pci_dev *pdev = NULL;
> +	struct pci_dev *af_pdev, *pdev = NULL;
>  	void *cgxd = s->private;
>  	char *bcast, *mcast;
>  	u16 index, domain;
> @@ -2958,8 +2958,13 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
>  	u64 cfg, mac;
>  	int pf;
>
> -	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
> -					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
> +	af_pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> +				 PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
> +	if (!af_pdev)
> +		return -ENODEV;
> +
> +	rvu = pci_get_drvdata(af_pdev);
> +	pci_dev_put(af_pdev);
>  	if (!rvu)
>  		return -ENODEV;

Thanks for bringing this up! It looks like this issue was resolved in a previous commit:
469f4462ec83 ("octeontx2-af: fix CGX debugfs RVU AF PCI reference leaks").

>
> --
> 2.39.5 (Apple Git-154)
>
