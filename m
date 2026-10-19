Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071A4CF489;
	Mon, 19 Oct 2026 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399047; cv=fail; b=qLaeJyiwrq98TFXi/k3d8lDEpuKWtJUA/Y6ZDFJM5jntWPPQI9efTaIKjPSfNWDxmItt/aB0eyxxLxHuLfHOwGf6hBGvLgJtPXjlVoy11byJbUscytaaz+kM265jozn1IHV0UkUfOAKmD1OuLTdZEzZNDsOfypVqiuFd2DvgPrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399047; c=relaxed/simple;
	bh=9DnFkL6lDKwBwzAj8Uy0w7ozQNC+IO2+Bm7Ass97a+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrHxjQkifW0jUvOoNZYT/9nMo7Ll1o5R8sq/CGkXx+VyxmpLL7A0zyFCmiGE0DnAC2AM7H3wgf+iAnq+cBQDhPavAmPB6FjKekFVuzFsCoDgyzkPKmbK051RK403FqeWV3kQbOox4gfCJLwTM0eDQyWgqOSg+yfWwZwAgFIlquk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pjWYZ7Bt; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=j7faHsgC; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pjWYZ7Bt";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="j7faHsgC"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J0YsdF966900;
	Mon, 19 Oct 2026 03:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=lUHFTrH4cmFmXtWELY
	/dsOdQtQgP4JVnoR6qRyJljLs=; b=pjWYZ7BtP3SrpmNu2rXiJUAlid57wCeQ19
	q/o2Q+QN2WEgWHJASsXKsvlleHtL7W4s/NH9C14vgZk+234xLgu/X2iQfqXViER/
	sQLBdD9DlqrC5Vd+MRwwnJEZXbd9C1wTYwi7GgSShnO7ohcI5z1G8Ez5D5cU0oO0
	PyPMrdQYdomQcjQ2+hsKcPk/qzEJrN7aGEjCOkoDaE1+63kUojAMrnhroNWHJl1z
	fpOKFa0GqR6Jwval9D06bVLLZNfxeWKksr05VzDKwwOXW2JIZ+5HrAZsTbLkCNyG
	qZMBajjho97c/HO1yKW9GBdgGX0/Hx0o/3SUfnzw7dHofG/X8UiA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023131.outbound.protection.outlook.com [40.93.201.131])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hc5ej1tca-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 03:37:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9M+iYAj1n5S8ZqjqQDz/PL7reEUJHIPXi/zFNaOPhWZrgZHglUrcSa6V6mwTzRH+kDojtLsyWe/XO/nK5+UsahY279dwiy8PK0bBMLGz1s0J455uGNKxYCZs6YooZOaOgpUacnQLYlFtq6KQvO/TStsJ8861zQ9S8UVRQDvJQv5zl6hcdGwWvqPwQz3hf8VFy3nJ19DIfcD72ZxndbXeU0sLtB8Y8l/XJ+y2dBlCEUY67uxAZDv1Npl7TyLk40Ayn7iNNYbj1AEWX8Y86TjQ/9OtbafQhwYLKTN7IwMB6FQKSj51J1ZwdpPKKQE3PzB3K5Zm4SB21pxlKhQgr2rGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUHFTrH4cmFmXtWELY/dsOdQtQgP4JVnoR6qRyJljLs=;
 b=kJztlYn677nhmeQbfDiyaanbvRcRV8Mtp4KvY/jLC9JdVtkUDon95nzzPGe1Woot79eS54qejrVF/rM4I20QxLcBKLotIQFKWUBfRJKKXOBSUrpdHMANf8AnNnGSMRM/LRTO9J23cDvEdafi134vIJAEJ/cF71sbW3B0OAtGqO3cKZB05yz3bKLVQJFDcLwLYP5EiaseedRZZ8rtNzBVpOHDstog/qug1JOaTbouwCp8P47km+0HewKy7mvqb2Tk0BGzLeMJw0h6mPtyaKg2oEZUGAlQUp9x2SIjppIYap52NkPEQo0l2zF5XExDEh/8d8lz/rO2gUcEN/XZcjj2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUHFTrH4cmFmXtWELY/dsOdQtQgP4JVnoR6qRyJljLs=;
 b=j7faHsgC7iOrenNdxMvOFsKwt+IGpPI0c/rWVhC7H/5H020C8cYWLVA0/M23bxfEWiEKNSblhl3mQbCEIkJgEiFubCZZJtlS6X3Qqhoj3+lI1y1zRdRgiqXA+X7ayeh/yNvskjROrnI95ARi9sCP/TEI0WJXPgSlyCwqeQZBZsM=
Received: from PH8PR22CA0021.namprd22.prod.outlook.com (2603:10b6:510:2d1::7)
 by CH2PR19MB4037.namprd19.prod.outlook.com (2603:10b6:610:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:37:07 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::41) by PH8PR22CA0021.outlook.office365.com
 (2603:10b6:510:2d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 08:37:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 19 Oct 2026 08:37:06 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 52DD2406541;
	Mon, 19 Oct 2026 08:37:05 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 282D9822565;
	Mon, 19 Oct 2026 08:37:05 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:37:04 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: SDCA: propagate sdw_slave_read_prop() failure
 in class_read_prop
Message-ID: <atXWsB1A1xQEgN07@opensource.cirrus.com>
References: <20261018192359.287987-1-srinivas.kandagatla@oss.qualcomm.com>
 <20261018192359.287987-2-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018192359.287987-2-srinivas.kandagatla@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|CH2PR19MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2576c6-e0b4-4109-c421-08df2dbc28ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|23010399003|376014|7416014|36860700016|82310400026|56012099006|4143699003|11063799006|10067099003|16102099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aliTC+IFDU3fTbzAl9p8oOltrlsU/wlyuV/HNwsSoyWC73b1gJ+z8h6s6H69E2nl3evd2ITxASy60crbSxUNjWOas9Jw+9JhsNolIIoyKF7MYlc7u6NW8X2j/WgBsQRXLyPYoplQIkbyazVt1cWL4GLzWPGwIQIqqJdvoQNJnbI8xABDI9gxW4yDz6ZWjltJzwEdeGOzMyAhnOF2epPBpJ2IUG60+WEHvooJ/qL+Ad2kspMIiN3JA2oQ05S23YBNMFi1JYvESU+XaLUzOiH5zGuVmCo/Z79xAOhbIUaDCd7YVyuhIgR8xexQkIzY35dlC6/OLe9bwrIfmt8zbz90zLpnnLcF/uqvkZPKX6eHgmH6zn8W0DQUQ/XnBooceD3/d9MLGmrCu1rWwf7pvi1/vHlzBEKRaYHd8ahNyc4oR8QVDEAF6F63zTKWhkOqXMlIGV8HZcTdTXZSAaHzNamuR9A8UoqreBazwX5t68Cw5SQ5OzgaRkLMNDUJr9RzBEwQ9/Wv/ILfA2jIZWVrEZn/Rtdhi9Ofpl9kU82w49utM7gp97S2HCqsgFEvIyrwEBNcpy/TSAfF1M1jrghpZSl7wWW0yySpQh6Jm4n51OhEjklg8MgNBgQnWdrHvqUHx02mZW2t+vySiNGPecNg1XB6BTamYRnnWDWBtIovW4aq3tjuFvwka3zWNgQJcWCSLF4CffnKf9GhRufPPbL6FxPIsA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(376014)(7416014)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(10067099003)(16102099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hJxHitzvvdFhzJDEYIfwBQEk2VNZVKwHkCZljgojNBzi8ifKaH3onrmGjO5bCqQnwcv5zYpqseT3oKmXu+/WzCb0Md2zjcwqDqRXJ9K7NFbaY1YWIN2HrS9fRkWwzTDFxOnLTwCDx4edlLTHmJ1QntaWFh7VzDWUEnkxfoCrUybpcGyG+nhi2uVZRKEb5SFW5xjQiPhbkGW0eAwJanFiEPzetNKIO8cI/TSA/iooA/SJ4luUz6DVblIFWWulr3FJeUZrDlex5iaWFktuGCGyhILj8p5rctD54uHQPMEk69p5mW8GwMLwtvj7DYsjQAQkYt+qe+vbyN0m1tvBjrtrzwxqXTfxl3phzgcB9kXlZwaHxltV3YC9nUv5PqIOLh56qYQo4JHCTjWLbp0edIwQievV/70t2BcZgGKYqkroGNDmKbJWmOk0WhFb7fQ7lP02
X-Exchange-RoutingPolicyChecked:
	Jl3d+KiKv9EabM07oVw35oDmkog1RfF0igzu80i9dEWbnOebCQrotsRqPWrn1crgC9WR+si2rhd+o1RTbXY/Nd3D1jmpCRVkiAqUeFrm1suApeQISsqf0NsegmJ6sCdmFtDNEo9YdZE6XuhPMEWyEeohGUSWX9VxxpyssyGhKf0Bi2YP1zLIw1g0mpkemO8kIN246k9c8K3UybMnkzVgj+wSyW5uRHJ0SOxZnFj9nBCVY7A4u7X1Je35n87Rnfcl/WUga7ohKTzu3xIHNGa3BvL8SrU/iJC1AcpoZ4A2tA2+iP/643eF0EK7WnNBWOJHcZl8x6OJW3igAbHW6rV6sg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:37:06.6176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2576c6-e0b4-4109-c421-08df2dbc28ab
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4037
X-Proofpoint-ORIG-GUID: Hkc638SNQlGEVsOlXbjZrGiD4w2cd1VL
X-Proofpoint-GUID: Hkc638SNQlGEVsOlXbjZrGiD4w2cd1VL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMyBTYWx0ZWRfX6O+Bxdj2wlyK
 tKRsluCVakzO1agdS6SGrPYGpQB2MIi/x/NvlHzLHntA1xqzZ2JoNX1ThXVh0/ycIuPpJZjYO0e
 kZyH8tPQgCMW0Y0GqriNZNIdzco4I0E=
X-Authority-Analysis: v=2.4 cv=KrjYSmWN c=1 sm=1 tr=0 ts=6ad5d6b8 cx=c_pps
 a=toaxmG8YyEc+6C1DZWrQ+w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w1d2syhTAAAA:8 a=wdhkNL16qeI7glDdmNQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMyBTYWx0ZWRfX7xNSuugdWv8y
 G6N3LDXMAq7BZRpIrawy3Ri4MTksHsVrst0CKrRY37VfRlggQ1LwoRcn+p7lmJb83ik7yKDhlC4
 8okRzfFrj3i3ZZq4/w55gKjJFHloE2/KKKc4d75F8NNPitJCZ1opUI5Dx6vYjVPph9c1cyoW9DX
 IZdOqNDapCV9B7i2NminLoWYVeD3vpqMryPYXEYy6z8r1ZRe1wdJQHjZt4CqMkY1FBZnYPuUMYH
 Gp/l7WYl0iTPCDjCwx26PHASL0EjqEvhSkSrFNoMovW3WXv+b3x8bKb/dlMaoE9DbEi6h+QJ9u2
 W5vrUElAS9oqMcpOlbo6xyjilhG+ZQp2Ke4jdV/N0aq8gbZOlyeDtWfzl/3J60Bwi1s1e4G+L6Z
 ykpsG+pdwcAuO5Um+zYYJlbnuOgy7Bm02QZR5y68+E+GW6MCaxhhFN+TB9IGkejxIRdypbD0jqF
 aPGNxPmm94eht86t+hw==
X-Proofpoint-Spam-Reason: safe

On Sun, Oct 18, 2026 at 08:23:56PM +0100, Srinivas Kandagatla wrote:
> sdw_slave_read_prop() can fail with -ENOMEM; propagate the return
> instead of leaving slave->prop partially initialised.
> 
> Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
