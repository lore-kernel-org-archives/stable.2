Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793624834;
	b=ADxwdA83DflnEo0TTztUbf2R7YJISeHZ40Xyv13k/NCuwNYPM3wEszem4NoR/FdlXdaS
	 9k1K40tjOQgFSJvK+2uz/F7gX0JNLOjrihrIvBsD2kRqbeXsxVSK1K0K/cxTUNJRuKmZv
	 bQqIdLzDlgpW0A2+7elcswU87sjoI2ZP9xLjrfISOzDQRRRPsplz4zfedVx3EcdTfsVKL
	 drCuwBvda9GOOtSOIMBAwZl96+0qFnVsxcP0zYstaBrC2tylkzbJ0S1BiAqv92PYUXmvR
	 B/2RufQm3aeEdSsWQmVpmR0+wL/LdCHJo9eeNwBjrx2iCEFt0uFbAJeSPwjOZQHOk8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624834;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SwNyy2LNWUprG7oTiXSP+SGIrZbrnmLxnxw36eC3+jw=;
	b=NyFB1pT9TkDy2KPt5P7qdnCmZs/A7bJBAu77MdyjOlhUJrsAA3BhnB+Q5GY7/uVF5+oV
	 7+59jFzvHSMgQjfS8PqAb4v7ZR04zmiNItpbZ600jmWnFpof1vtu0wFhJyuWuWMpGSBGx
	 c5Qs0X0EUaFPxKv6A5Rv/l4kRQObkmqfmz2z5xXwsyCNCGIiaHcrvYHXTDKMF8EoAaUXl
	 5gjYnG3IJDvAKRtFxA3hR3e4WldKdwWNyxpo41NpzWFvIvtjLRkdhBm3Ozz1YyTnvJ9vA
	 BgWP2WKET/zHF9/jmfSSfWFq0ASbULE4ErDlQITWcsuszOmV+TgQI4K2rx+KiPUqTmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y0b8k03s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.46
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D6606A324;
	Mon,  2 Nov 2026 13:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 733D6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y0b8k03s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyl5t+JIPzgYqCv1mRRqlPAeom2hsQIZB9H3x+P7szBbVYN9+NLae+SrCVr8DdyFJ2vFW+2kLXwVgxU5nV0du8blfh5ysKM7UC5n+wrxK52NKWGU5UpNnrNtswI11knVFXUM1wbRqPRA+Q5ax4G4baS4o/XyxkdFHrbVXjuX0iOltjBWhYvRcMfz67NE71/tJtbSdVJnzftPUk6SBaCAWciRLgiHJLc130hwiSs5C7399NCI8mstA1g7/fO8O3MoHKi7JOI2o9zG+DIV75O5UaobxeH6SYqh0yBYX28v6ih0tTR9G2d7Akje2vIAHhBwwKsKXUbrynuHOl/k9Bi31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwNyy2LNWUprG7oTiXSP+SGIrZbrnmLxnxw36eC3+jw=;
 b=HH6qBM+z+tfNU+O7RjtrJAbIcdlhKlrdN0kRnDgg+81XXs10yST8vwlL0ASp37hlb/qPINiwCE+VkVzvCy5S7WrmtmnCzYGI59vuzl2eGJgACcEIvUCRnr+GKNkpk1ir176qUkeRD2s+TEMQwBAZQ8pt7J+9ftjaQPfRVbR5z+5LZYo5vl/mcxGyKd+gTHZ8Dk2Vof/uHoEbvKzwrdQlr8/pJdJLP/Jwc58poMOhCEtrslVq3CorA8xdfb0/1P/ihiDY29s58FStjDhWS43vmV74jxQF+Ji38WL3MHileurAyUw3GfdOjE2hW6TYrigCU+dIsuCqeFfVYedKZW6qcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwNyy2LNWUprG7oTiXSP+SGIrZbrnmLxnxw36eC3+jw=;
 b=Y0b8k03sdKFm8XxNGPOslNiOuyn5NkznCjRqJQgDkxUzppYpRN/KDBDrQzjM6LiegZmZ2cA0PFVB1RDBg1FMpBx8KwIxt+urMdIlD8ikLycmSSLdTFhX9EdpUVpcl9k/cS1902X+QTRxjU7rQ6Uzvb0+jVenv+KZDNxmqzMdnHU20TB/WJI/uBYMeQEeJqICMe3t+d50PJT90Lzb5ikJWazOBotnb6RzLHDmwI8hb4RgHn+/8rcGTKsJ7Df0TcgxexZl2PT5M+KKfFnZJQ7u/iiGg4fSP38ezLXSKg9UEZXGYCVNz0fuUNp+F8TbR/EfKJ8S1qnFKs8raYA0xPEC2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:07:07 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Mon, 2 Nov 2026
 13:07:07 +0000
Date: Mon, 2 Nov 2026 15:06:58 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stable@vger.kernel.org, yana06070@163.com
Subject: Re: [PATCH net] ipv4/ipv6: preserve multicast filters after a failed
 source leave
Message-ID: <20261102130658.GA922454@shredder>
References: <20261030063603.697510-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030063603.697510-1-yanxia@cmss.chinamobile.com>
X-ClientProxiedBy: MR1P264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::22) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e10df0-d92b-49f8-2afd-08df38e23276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261021130227099003|261026130827099003|261022075727099003|261022105027099003|261022113327099003|261026121527099003|261022115727099003|261026140227099003|261009223027099003|261028144727099003|261021135927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	umoTDMV2lyXtqp9hmrkbbxXhTghB79NOPc7UPpyl21nfNm+H9bUG+qLLUjJBNP6Lfpt/EWVmMMrU0ea25fPs4KIL79Uh1bPRtD03A8xsdsimi8HC1u7jlgMNV/MzXdSMX0KF0ZTqAaCsqsZao43HBu3TBIISsi/j8YcbUUoxrT4k/+lJ+kRSmknKKerv3M/pgC7VhbfzHYrJ0UVpZbwilpXRN+IjoxaNhxH+URre9PZ9G+QyrhKITfLe53jcM+bc9HdVhPw4N3RunDC+KHM0rqUb7HnVo1Xpe1PdaGVRMbpRbFK/MJckQW9uvSrJCVGnSIzdjlYnB7y5zgUWdWX0HMhx2UOFffGHWTSjYLV4AUukEUw+tyTWgWpjUK+LH4d+B1vDGhPopLOYgUA0lsDNTkUw7SldsSlPHL2wN/c4/tRxWnNibqmfl95VRyfx2jDyQgi+ySB3/6E2szAQ+cFBs6qpnn1hui7JC9UVCUHLEvOI+8RNVilfW4bQj9v0I38qMJzNwNgDjb17qIglq0f5aKtRkgpmqTZ11AfG1CfQHiKpPFqxH50VxZobf6vlEQoeZ8GuQvMbLzboAMdbQ76L4BQrod7mA1AD8OtS8hEPeTpWBpvUj6WHtjqOLCNWKi/PbPNhED5Z6iAo2ItMbgm+WNP2BUU4//vV9jrw4UZSCOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261021130227099003)(261026130827099003)(261022075727099003)(261022105027099003)(261022113327099003)(261026121527099003)(261022115727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021135927099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aqpS/ymEACQJQ/Czap2jzWnCHpVkb3YOiYbV62dqDYqLqXcNa6tn8czR677E?=
 =?us-ascii?Q?ifGm0UVBFxDG9gPP7t6D29TOVlLVc6cgVudeoqbEyeVFiBpBM8SFR1ux2Ie1?=
 =?us-ascii?Q?rTBgNjUfzxa0udNItkhpxx+Ktlsy0Em5DXSOGkJ1c8HhTRPKtrwfYntb+PiE?=
 =?us-ascii?Q?KBcXhmNUuDbbXOobKB4pOCbn+n8IeJonfCfNjH3vXhBNvXikZdE4xsPUixdg?=
 =?us-ascii?Q?aKtZ4PSbc3QiunECdpQ+EyBoTB5bn6JNDj6O5uyyCj4apgFkxZ95j1CM+D/X?=
 =?us-ascii?Q?5GSJZiT6ESJ0a0lsIuDk00pK+Q01KalK0pyJfX6QPt0vkKAVZ/0Hdcr6IDCM?=
 =?us-ascii?Q?ZqwxmoHFTkhjx2DyQvMMqxTi2Mz6myQABkmWtqsIOxJAQ66SpHYPXvvLf70K?=
 =?us-ascii?Q?j/dblanhXmZ52nKrXks1TPTe2Q0+R61SwIOMpkwgsxCbF6bPvlYUR3cITGMp?=
 =?us-ascii?Q?EeX4xfD4SFusijVfauuwxRXkc3XzB1V647xSynrsA02k2K9+fr59oKiIbLp8?=
 =?us-ascii?Q?QTYqNp1un+dfv9eoS2dTCMhcfbovzbtlLvBI08blKaMQZIL6YYatNBHvZxyu?=
 =?us-ascii?Q?AvEXKO4wbF9NUYY0eBnl82WHwlfBDKKNJOZeOso+/2p8Mh1sh9vooo6lLSro?=
 =?us-ascii?Q?7hWSrbNQOTkDTL/Jh6OOPveNsTw+vxfgZ25NE5tWbJmG0Lbr8+XwHXwVYwJA?=
 =?us-ascii?Q?TXxKGRNmv7ySZDpc28d4Iw9fgpDlCVyu7jLKg7iJmzja8OtiIF4epPl6vSwp?=
 =?us-ascii?Q?MKningtt4rxhp4NCr9/DzakSOwBvw2+xyJp7Vvnv7QnTQXLHX0Tl1shFV+Bl?=
 =?us-ascii?Q?2dYVss4b3KrleDmNyBPfHeylVlJHYJyzUspF6bx9X8Q3Zs3ag/GGZgux2EBG?=
 =?us-ascii?Q?3bMJqfQnQxnJ/mrVcxNeFG6auEf6RGsXO+U0U5ygXr9ThCvPUIf9FkD4otXs?=
 =?us-ascii?Q?9u3+SkAt9plTc25Gcg9KX7ECoZtMkbyuYUNy689H2NtGsJ7a1p8lhBhvSD8M?=
 =?us-ascii?Q?23jpRUKVMaGr6v1v4v+UG86ji9Q1NuC9iPBa0IM8nRkSdJ2w7YerSX/XsDFb?=
 =?us-ascii?Q?GjpytwcAMMZt1T2plvDdw9vxWpKXpUzJInUiYHFcXD36ILHgvJitpT30fz53?=
 =?us-ascii?Q?zCOeoPogRAVRDImE+ftYj/7zDCdycGiHbp9CcCE5eh176C7+uJp5PIm2M3DY?=
 =?us-ascii?Q?meTB134Zb8jxwByl4TM055pjyYv2uFqX62PXOzDH/ZYaxbwJy3AMxUvE1nYK?=
 =?us-ascii?Q?AeifN5kD4Lhjxcm3JwN4FF3Umk1XOOrAfhBilNud90KXghC/YyT5xw54Km+b?=
 =?us-ascii?Q?NDqIvmLws7quAl0/AK6fpsl7uDSD/xkWwHSIyuhqoYqmJDkw7k/wCUSdynqw?=
 =?us-ascii?Q?B5qisUAr6PncF5zbAcvsnhMEHfrKaRVxannz6LP84rG+J7gjeaE26hBJGb6f?=
 =?us-ascii?Q?KBuo7sSuOIuQO9S/6u26XtjiLvX0KFeupJe4qFAOQhybV2oGMUjHZJun0vt4?=
 =?us-ascii?Q?ntaPCXLEanHB2GRp3LWL4Spu4CZOe5oqCW5O9yhSCoVLQHcyI6W1TU7n4tlW?=
 =?us-ascii?Q?ohMSksZKw6PKkjYgj4K/hacPFFY9/WNy9VdX8pEPnkcap/hlVEWvTCizczVu?=
 =?us-ascii?Q?HOQ0/3BWhP4uePZTDnjhYf4r3aMV0EVWPRN1d4cMhs5EMwh5MQoAGGOxaKnq?=
 =?us-ascii?Q?pe4LxfbIIZ+IxEOpUejZvTqbCQ/O7UXfXoS68CciBHEOXmkU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e10df0-d92b-49f8-2afd-08df38e23276
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:07:07.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2J5d27NE44xR9nc4dL4eCbxZOfUEPId2lP+kp701x5aeMhB5SaZretuMoASG3y1jgg2QMsbtpKpFel2tphBiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

On Fri, Oct 30, 2026 at 02:36:03PM +0800, Xia Yan wrote:
> After joining a group with IP_ADD_MEMBERSHIP or IPV6_JOIN_GROUP,
> MCAST_LEAVE_SOURCE_GROUP for an unjoined source returns EADDRNOTAVAIL
> but switches the socket's filter mode, so the existing membership stops
> receiving. Leaving and rejoining the group restores reception.
> IP_DROP_SOURCE_MEMBERSHIP has the same problem.
> 
> ip_mc_source() and ip6_mc_source() allow an empty-filter mode switch before
> checking whether a source list exists for deletion. The failed request
> changes EXCLUDE {} to INCLUDE {}, so the socket no longer accepts packets
> from any source.
> 
> Check for a missing source list before changing the filter mode. Preserve
> EADDRNOTAVAIL for the rejected deletion and keep mode switches for valid
> source additions.
> 
> Found while reviewing the error paths of ip_mc_source() and
> ip6_mc_source().
> The reproducer uses socket calls without kernel changes or fault injection.
> 
> Tested with a UDP socket reproducer under UML using the IPv4 generic and
> legacy APIs and the IPv6 generic API. All three paths lose reception
> before this change and keep receiving with the fix. Source joins and
> leaves, block/unblock, last-source leave, and ordinary leave/rejoin also
> pass.
> 
> W=1 x86_64 builds with derived allmodconfig and allyesconfig configurations
> also pass, with no changes to the warning sets.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Same comment as:

https://lore.kernel.org/netdev/20261030151629.GA85001@shredder/

Not a regression and not a security issue / crash. Please target
net-next and drop the Fixes and stable tags.
