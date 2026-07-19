Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F4200110;
	Sun, 19 Jul 2026 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450517; cv=fail; b=lWI9VeZMrAgKgpoM+5rJVNsxrPPWEUyTcMqk17Cfs1tPShqP1r5zvtZOO+vhKS1uFE1xfPnBVFQquphh8EVTUZklgG/RBoZeLqHHJ/glkl1TIyPpfLsdF0OsAFaihQ6o8bEG0kChQqStJ/nfX3I9mAJWurPE31xs5ymCOGdfPZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450517; c=relaxed/simple;
	bh=l9N07ErxZAVyRdcK4w3qUS0oyW9EtpNYCH0y6klcSr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KxXVKNrh2surL0GbYZWO8FSjbLlWFJMguTvDGVpHduHKlnmfmL3EsaC8qZ4tN5yjbOoA4W/B0quuK46Gey/tcnNXqMD91ahHnZtZdsSeugQLRPNyTvDeoyEfhQkEOHrhTSoEfRzfYo23Uo6tZXC6qrVzPKyKbYllt5gdjmxzBDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EkEsTFtW; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EkEsTFtW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJTieNVKsRGvtOXXxHUj6Rn0QoV4NHpoBHgnHmsREMpqnOF8AgPNFH4ZyZj2Q9wXmJYg4J1fUHiagKfh2I5riprlvRHleiVPqKBuu3W27NFrvBnZESIIw7f6DbUgz8yRfVwVYR9MZ4cElHF//8C0XzSjw+UtuuObfY4x03jqTZKifld6JbxZVSQPnsb6MhUmS8UCOBw+KlJsnxdF4b67VWHO3gPHslfx/Qy9q5Satom96jTq2fZMb+f/HgHpewLPB7uctnqhQHbix5lMdncOmSQfAL3pFe7mnZ33qu4yT8iAumiJDoi5LSygAoKzR1fQYC4ydgeuwCeBsXMQpkklaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekvrcK3e4leYPIu6t7yk1Ce36VFz67Jem7UCibN0Lto=;
 b=sqrBZpF6NIcNApVpiEKNgXw3UaZ5wHFK0ZqAsSTpMRs3nVCAIrrrJ69QpC435K7/hkwwNEdsCxNjRhHx68KOkTrj5I5IZK9YqdFPLox4/uYGeflXfCiu/9QlIN2TFr8Gi7n8rqqVFk6FsXTq018yqf2vcq2AdJSHoh8rx2LP5Yp7h/rUgs+1DzdMIo/33T7o1/u+I6K/yF7Qa7vITfsuwR/DYvsqmGeuMhVCY4FP4VLDL6GFwsaztl1G5xFQhKFbytJBzefSy3MEEhqoxyeqSs4qa3KKkOA5kN6EezsdjxEYpQV++cd8z972h18K/+DKNmLkmDXHpUv2Z/sn1VrDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekvrcK3e4leYPIu6t7yk1Ce36VFz67Jem7UCibN0Lto=;
 b=EkEsTFtWQmQ51hGltw3W6coPDMAhp8McUDeZAlzMsgNASHqd5EkyFS8KJBU3Ye8ctirXH+UkER+PgvEWrWchijg4gysZCBtGaShNjBa3spkMvHzZnKbyl7zUyyllMhRM5NjuIOj/BQVx/wBti8TEwUAv3GnLk5gk+RQMVPy9cjg0R2bjx9nc+3wg0/ueD1yhOv1z2M3UCq8BokJSLgge2Du4Yibu2Uha9It+a3Z4Sn2HqwpV0rW58PVlPF4kMpEJnECBn6L6K5p7G822RcVFPuwma1gvLbMkyQ+yvLKooMy3uKGI2hD+Ftek0gx69uCjzKu0fAgN+LlZKftR8tqhTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 08:41:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 08:41:51 +0000
Date: Sun, 19 Jul 2026 11:41:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ipconfig: bound BOOTP options by UDP datagram length
Message-ID: <20260719084142.GA1906127@shredder>
References: <20260713141107.10418-1-zhaoyz24@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713141107.10418-1-zhaoyz24@mails.tsinghua.edu.cn>
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 195afd94-0569-45a7-4b22-08dee5719426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k3++jsDHNVSQddB2p+7CCF0LgKiRQmo462Mi2cfQBQJ4+sJfaf7goddc539XI7ua5xyJRHCsymhi2ELNOt1AzdC7pK9cMl061ITJlPl+uUJB32nq7pu5/+nCSebZGyk9kAKYhw/zxXRkoxgt2L+ZxYUrqNpKCO+4T6pK48E2900ESaYxz09NOAYjd52Bp3ovKzjJ68P+9ZrxQ236l3hHUutpJXHCusQzLVVpNvf2tsSaWKlOBJ7zkHSyaTJfFwbLbEy4Dch96gDyD3PO1hER+9E5L0CzXADZtxpojoNu8uSDEd8VkRMDi7wgqkAb01ZpzoAoJy3/MFuQvlMAQRVHo6Pu/u7oijdDvw25KK+KYxAVIChdHv5okMgL/0dGfL2l8J7WLDNqILMJ+iH1tm65Gy94vFQzQwNUx0iWcWjdzwwNKb+7hKzwRqfxE8nuFfjn15Fml8FN6zwF1aGXM4kLrvvhoXEXmueNBzRz7RVvdswTEvX1k7/KZnfVUuKAL4kLexVdETED+2ztV+HWyK4J2vTnyUUGwDuoiYuBBqdTvaBlOpzgWquSieNq5zzlwT8E4QnqYI+j2QNOBYdk9nYEb9isNTHyVsDonDLjl/cARCZojoVtGKOv/Kd53KPhvtvvPRmUa0SpmivqVFDaYT/006HxqAu4dUCoLwJ+uO7rjDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rf0VGDMZ1AkIWCELGrp7X3uO1FQOKVsrw8/wPdibXeuUZsUP3UQkYYXbZQKG?=
 =?us-ascii?Q?Xz1V9ZXfomVWF0C1PjqQR/KQyTvG7tCXq0OpJMbshe/sajKLnmyHhiL5ZuKy?=
 =?us-ascii?Q?fOZZ3398Ut1CC2BIAuAIIZZ4puUv6fN5N99PTHbiqXSQ3lTgvTdIKXOfyOYU?=
 =?us-ascii?Q?EzFzkV43w4WP7iBNpoYjVKQQFZfIjdxG3Uofju9wR2NFmz1dgoVuZnySnLIM?=
 =?us-ascii?Q?RgpVF3S1j+jeuCl3TNMbuEyV5S/Ti8kTpK7qp6Lxg7AjHJ//06GSnGNVjLh7?=
 =?us-ascii?Q?9uKWQjJLGOqbDjZOYHEdMeWzK/yc0OGMAv8RcND+PZYgLl6H/S44OorJJzLY?=
 =?us-ascii?Q?t/Crxa9CoPHk4x8+Gy9hLyDMb5XsFEikWQAz2IVG/vuSeeOLI7UZ9MNMGls9?=
 =?us-ascii?Q?Ia6KnhRiN3Qg67MEVdjRkx9QrkcmbYbz1ycqo4arQkLW7CB7Fx62JdCJLE83?=
 =?us-ascii?Q?IpCX3YAleTGxDWFmVtO3FYRhFaqf70Pmn93ls1OzuzloQzU2wKRA92F9B1Cl?=
 =?us-ascii?Q?AiflBzFe6zFoE0YX1zep1Xew8M+p22IOseeWYc00I81h/4TOBe31++f3lcgN?=
 =?us-ascii?Q?P+hRQZHIrHZxWgp+Xm8pPdL5rsLHY+tMGSYvBE9vpfS+SekGIUW0+y2QOpFE?=
 =?us-ascii?Q?tklOggpGWc3TxojwDPecxVLi+U4FAJgj7W+YgDz/kxI6MpEXhnzRvBfoIAB7?=
 =?us-ascii?Q?lQ+OMDaw948d/zIw9y0vqVXbqQWehSC8IXedPyKQc55g6fBPVD0qj0SPLtYm?=
 =?us-ascii?Q?nCADL5m8B9axh2r3hH6v6E2Gp8UABRXeZ0FNBhVyK/fPUlPiS3puRrs2Ce1Y?=
 =?us-ascii?Q?dTsrI0ZGkO1LTlK7jOzGilmM6KGoTixYCUGrmQOevV3ZFg2Uqvo7q7064WYK?=
 =?us-ascii?Q?fRp7EPhhH/Lg7iukAlUOVUfqQ2qW6E3yduakSjyU739U51oIOCKQBZh4kSJA?=
 =?us-ascii?Q?eJogjUgrDVxTkbDfdTZYoTlZFUdaWBjmWAJQt0rEWUw2G/lk4IoRAxRvVdnH?=
 =?us-ascii?Q?e2HiSVNVyGv4opMhZF/Uc5NjpJIW9/SD4cBszftMy0OOCXONxWt34UvLl6+6?=
 =?us-ascii?Q?NwG4WqOxUCESuwXH3V35GY6gODHAoJcBM2S3onU1WFhXVvYatKb/0+65hm0Z?=
 =?us-ascii?Q?9oEI5ak6sXMhzMus7JK3rhcwwEvZa9dwYsxWjngEu8tKCnoZ1f6hInK4G4Eq?=
 =?us-ascii?Q?hSyynWV5DtxZWM6z4ctlmVD5Q95KbvMkUCPDXxEQfQj+eOXZ8ltdFlgT+YQp?=
 =?us-ascii?Q?m6keZ33MAEX4GTOlncAKGFx3AO6yDmWl7/fHjTmejdShvMY24eygeoFDiobu?=
 =?us-ascii?Q?UxiJhiVAMP4saj585jvS77necGl5CEaOSVk9lKAueD7d8Z7rwV5h7O8yGzMS?=
 =?us-ascii?Q?2TdnUebLXTw6FJDxveU8fUKu6S05QZ/KAB/Li9yCrTwfKD+7E4vZbcPy6or0?=
 =?us-ascii?Q?b4bDXzH+5NVtJypNnHgKEuNReuRL8+skpmoHowAxMf6Ko/UUtTChZpUejvNI?=
 =?us-ascii?Q?5FZvCtp+uT5UZtLpGzejGuFYMqsW7GjPBoYqUBQXuUxJXHYNWa2GKnJDKB7F?=
 =?us-ascii?Q?Nd5Q/3oibxWwmcFFTS3yEUevG+v+LfkV6oH3oFwcC+s8IQ+vnA5d6Co4zDTg?=
 =?us-ascii?Q?cNkdKNDDIVZYrC2X5DGd2ngKWI7fl8P69be++gsypaj/paAZ1dJQcz8+OOC7?=
 =?us-ascii?Q?QAt00jD5VKCG2OBaNWObJf7OfnDNUBBX1SDwZum25jGGVFIr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195afd94-0569-45a7-4b22-08dee5719426
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 08:41:51.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjR8kZMx/qfClrQMfVDBG7r7DZqVCL4XAcmYDhM54OqZThd8YwjNu9IT4zifdkF5JuUQtVfgLRFREYxHlSFhgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103

On Mon, Jul 13, 2026 at 10:11:06PM +0800, Yizhou Zhao wrote:
> ic_bootp_recv() accepts an IP packet whose total length exceeds its UDP
> datagram length.  This is valid at the IP layer, but DHCP/BOOTP options
> belong to the UDP payload.  The option parser nevertheless uses the IP
> total length as its end boundary.
> 
> Consequently, an on-link attacker that can race a boot-time DHCP exchange
> can put DHCP options after the declared UDP payload and have ipconfig
> consume them.  A QEMU/KVM reproduction with ip=dhcp accepted a forged
> DHCPOFFER/DHCPACK with an IP total length of 290 and UDP length of 248;
> the tail supplied a netmask and an off-link gateway, causing boot-time
> network configuration to fail.
> 
> Use the UDP datagram end as the parser boundary.  The receiver already
> verifies that the UDP datagram lies within the IP packet, so this retains
> normal valid DHCP/BOOTP parsing while excluding the IP-only tail.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: Claude-Code:GLM-5.2-special
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

The code change looks correct, but why frame it as a security fix?
Can't an "on-link attacker" forge the UDP payload instead?
