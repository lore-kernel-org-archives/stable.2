Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793719195;
	b=obXrsEqNzCUkEhw0QytAQLd154Qjiwg1Tz2X/X3jJnOQea5oF8MDLNXG1SI7iz8lDkVK
	 J/0E9/BJ22Au3h5ynJdgKg+P10RHGW/3dNyd6A5fa78Dp8cSmb7uh7EKM36+6+B2kQjYa
	 VPjFrnMlerZgKY7c2J1NinI+83bvWa6cvPLmpqveiyipGgE9dc++jLSkoWYgbfw8xri46
	 P7SOCFHE1WhPrtxy+75Xx4ZB1TYm8qz52IWHXNs6mr3bjNvdgB/enJX7txOMW9StLgXO7
	 hzdUwFAZCWoqk+qDqIha0hooW1U6QisedGnSc3L+9t5WlNxhJ8v6qH5LNikglkQtQWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719195;
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
	bh=pa7xwOq15AkyMl75H7c78ElcIY/9iE6QdDNeg1g+AUU=;
	b=ahYjdd6uyRTSGN142+TPskVyphCp3bH8ZZfAEMYG0/Eic16zjf9aaZNtICqoMWyZ+2gV
	 7xIwa97kbinwoHbH3nI+/ZDhKUR6qyecbuXJECzlyem1vOZGoED+yUMSSniKTNu+n6Vl5
	 AuRU1uV7HV21xes4lV0eusOadwE2Wu5snQsAz+6JrWsbD7Qw3Dt1Cpeg2qzGCcLMmq10T
	 B32UuKpW8WXqSGTFXfBBg9YCfcqG48eCJ0FrIIwKL6BoWa6axZtq1Jg60h6Jk7iex283g
	 LpV8wiU668SZevr1o4Yr4fO5mZN22tA7cly0pKVjH26BJBKx/7Uv2HGapzMPJvfSsEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="KMkm6J/O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.2
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033B606A327;
	Tue,  3 Nov 2026 15:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2033B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KMkm6J/O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ56fxjuy00qzVMJQ2mdgEWhRIBFmIaQ9HumJTBfKWnGjVh4sf8da0tZNbeH93twF1uRusXkuuTPxjM7uMt2P8SmkxnFs58vcVsEdD5P9XdtfyddFjc7BhUwPRLHeYsq+oxJsPV4yUSwVHekewuvZEmgu2g/yv4nUODl7Ipob7DPrMGEZeDd9beURzgu3f4kV2FS9m3xZxGn7r5sNTZiiB8Baf/oB9LJtQDPYn7s1j1jr82plsC+NlW18l7JdXVM7o5lIvZsX8QurO1VgymbZZN06ulBRZrmDOd8/erl+m/hfnhHV5DY1GVcXBCdCwY7uxcecNYSMivGg86vxCyiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa7xwOq15AkyMl75H7c78ElcIY/9iE6QdDNeg1g+AUU=;
 b=NTC6wwqnqyid5aTwvRQiWU0hfAVVYIEvt98bEbiWY0QE2ycN4rj1f/TDPmmW9JgheMD5sav9zSvTHz7CBVZhjvrWbRHHdp76WxnQIHyi5NCFQWULd1KVEVpgCbhgPrDzNmbBOEwRqp4GF8WUE2bGCFUuD+HkqydhufHlXzNa7GJZIt38Y8iPM7x0jxQUr6UvoZT1GejOREF7KnNtMlpoml3SVxL2og7fALvDFHkUNnlyfj6bxSWiGHDINjQfwHbrCww62yQ8WUHIEHxp+TTNBYAJ3rrixv5+qmL3RraZP6//0ye25opluXank6Rbt3tbJSuOmhZ2XIgcxeqO2mBP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa7xwOq15AkyMl75H7c78ElcIY/9iE6QdDNeg1g+AUU=;
 b=KMkm6J/OzbZCCzC3FpErSOR+rMa3ibLslOBWusX8ktN9JWI51nVmY6h7jQ/3wqNAYX1qVw8lIevd7zl2SuTvBlgvol9T/Q4GGt117R6S74KmKOcd0hzFCFpIlL/MhoqY8t9NvJ3v2+BxoMXQgMLtN0ZL+Oy0OEPQgIbKt5eQFtRf4+4GVduvhmsQn1jo1i73I1K/kaeFdzDnr9saxfFBLISbynKJJgPFbn0hvrCoBMW4YSCMlEm/WJpnKvne6DAXb6f/WPHuySwWfMyir/UydK6KnZ2KvXumQY1YnxP44IJF3DxGu/HqGVyHJ9vmCDj04MCP6BEZONK6hTk6IsxLoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:18:56 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 15:18:54 +0000
Date: Tue, 3 Nov 2026 17:18:44 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: zhangmh25@mails.tsinghua.edu.cn
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pshelar@nicira.com, stable@vger.kernel.org,
	jianjun@tsinghua.edu.cn
Subject: Re: [PATCH net] net: ipv4: fix tnl_update_pmtu negative MTU
 advertisement
Message-ID: <20261103151844.GA1234870@shredder>
References: <20261102155444.2658518-1-zhangmh25@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102155444.2658518-1-zhangmh25@mails.tsinghua.edu.cn>
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
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
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdf5972-523d-474e-bdab-08df39bdc5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3FT3m+AOEF7GtHFGA3hWiBSbD3hCIIT/7njCK8HhL2kJt+zk5FLE3aZRODpLzYU0elkS9Lj3d7cJD0NRrF4ZQ+UPIqri3n7yutUQ7e32YnaBlrAh60hclBwzWO7O5V3cHZZ5mPtSfLu8XjGGGdb573yUG+Ilbl/PM2JGeNvv6HlwU/OLqe3F6ebHah0kGXSjpgiHhxzlxI39sI5T6zmRU1ahwLmFZGWzJ1KY3LLfYLZXYpVv+MH645mYbcowchvaU5cThGry+jgE8XvE0L/rhNXJSYzrcQ5A8elsqkLmpZkHZHbURAgFNurwYZnnXYX6YwlQvdoHWa754GGQhX/wHVTdb1IwTeP2YrFBfueezamXiqyEWCXP+7LPGvVyyLECNVM/T/JK6b5uHri+fZjS1BNPJmykrRG4T9uMjU4LvYFttGVf+3jIz460pmtxaQvuFJlbOb3zh92eO+Kpm8GBdQyiqS7AThETTzhlYAsUwk57BTauJgzPBG7mSzb7jEf/X2mql0YMh4rmgKlvIMfzzpDgBAfh5DFjbaIVBY+lPwZ5/b3paxphrwN/EboLVfz6uyXz2m1+iMLr3/3za2wsArlJund7wldcPEf5/vcOnG44eGJEgdrRtDHWCLQliqaHBoPEHNpxRaG4SeSAV7EqMdyWKTL0/D71flIxRyBQWZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErYUkT+lH9W8GAPhuUCzdPnB6O4Aialu6EN2dV/0Cr+lWrE2fKauZGO4Dg/d?=
 =?us-ascii?Q?3NstxNPb03LwvxczdmqK8rN/4OwObZLmXPOKmCkUrMaA1VV/yVG72MFzPMmG?=
 =?us-ascii?Q?UIDomg4p0ycBBPq/kVQbiM0HE0VfzWLUoQCwPMe78D1TwcOih57nnCB2/wV6?=
 =?us-ascii?Q?BmY00AO/X/f0iTV7MSx9QLaqYyCw5y30BsR4QOfDfKUkRhl8J1nWe4PQO3Uh?=
 =?us-ascii?Q?QntXv4No+/siRcAP7cm9aUKXCdIE58yDY4gZ9twvBb6W4GtFY7BMyJXKRy78?=
 =?us-ascii?Q?0hc+W0c1zJZjO/VChHPymPZ2T0aT7UEn3pictm+TZPbr/2v3DrLMQ45yF7la?=
 =?us-ascii?Q?H1te1TIMiBMXj4a0O5KwR/VvaAlPgg5DwQiQkKnugm5FMnDT4fAhX+EPD9t7?=
 =?us-ascii?Q?MxtVOvw7o00HPiWkDmHRJgbxjuVbFKDNcq7Ag8USCOvE2Y/uOgsE9poQmEMx?=
 =?us-ascii?Q?gkO7uB4qJxWDqLt5zJafj6Uy1+CgEVqunpcegrxbe2mXl6/kEcLkYZ5hFtCp?=
 =?us-ascii?Q?nd0GNw942pLzolwJ4wKnc4hKS43Zb9Gkqeb9oZ7bvuPOzhFYU95fKDtDNr+i?=
 =?us-ascii?Q?vA8dOnf9vt4mpD+nYFNsmy/pMfR+fPbjwrx50mMu2BVzZaAshJd47WDlpH4B?=
 =?us-ascii?Q?DC4sS41oPqiIab4U8NStZ1lNdfCpL825H7BZGVmJDXFxIcGKiH5Emg86lc3c?=
 =?us-ascii?Q?HbpwS1jXmFiIFhlahSMUX4qAX6c7AV6VH67L19k8zxSrMmeWNJhqsmc4hNFd?=
 =?us-ascii?Q?7bPjSpVgQkwZCs5BcUUkKpZFIZ7DZJOvbKoK6e588XZpB1H7JVBEyw6KqTkL?=
 =?us-ascii?Q?KGgHQFs59nxPDRXTxtwmVryeyCvigusg9S8wXDyRjTiySPUe8Wv6PQnCezpN?=
 =?us-ascii?Q?LlMgiij5jN8oX6X+6flccFvPWL6BMSBCDiSHcN5pVctQZL/Sf9SjNjIDlBNO?=
 =?us-ascii?Q?Uf/PqFPczSbq1MsC+FCCk4tqy6Pu8n5GP9DlOC5D657NIXN2MmYKvGe+Y2QT?=
 =?us-ascii?Q?bwb508mFPqzt1ybAEdEvBa66rEKs9sDIu7EqVhI1SQbEMuqt+yxDx7vHoLyk?=
 =?us-ascii?Q?lZyemVKYZUH1bw6+zK4dwn6Xp6YMczSK/U99SaRMUthrGjlhAgbLr8WpM1dP?=
 =?us-ascii?Q?OX/K/upQrt/2Mv2GbDtKnUXXNxnHMX3EXuWiUZofzx0apcgZ0bKLjDn1kj27?=
 =?us-ascii?Q?IdG9RFgOHeJ9dul7dm5QmcdelW0N6kwFqjur/+eVW+es5lzmzCRpnLHqguzd?=
 =?us-ascii?Q?TRCi0WPIXisErCKHqWMh8vVh8VUEp3Wjw2p5HNg8S7sEef0+KWP/PnvzkuPA?=
 =?us-ascii?Q?JSoXwjXdWtYjEsWgnudhJqUOBYsX3A9RAo5w4N8aWYyU7oJQZ8aRjDCJkwkj?=
 =?us-ascii?Q?2LfN+QJh7smhE5I1fTu51xDLSWvc6rP9eYpt+Kq6sZNhA417s+ktrU5TS1LG?=
 =?us-ascii?Q?YDH6elkOHTT8UNiAh+BKuynj2dZK5kB0UTMwnPqi65O5ksXBgW56CLxrsnEc?=
 =?us-ascii?Q?S3SNefcNRHjPrXUB8sUZD/U9StTr+rd1pre7QDwvO76djVBDAtDfv76M1NCR?=
 =?us-ascii?Q?nGK4bEjvmaXWAFXkXRt4YQI9EDaps6zXVNMeQLIavzTy/0r3+EQiWv758ZK2?=
 =?us-ascii?Q?W/Rr+CH53W5/FLLt3SQqQ+ZIP0I38JYRZA1HB7dhfh7UOiZxlld8jjeIq3kN?=
 =?us-ascii?Q?5iDcO7mzHlskKIQTogYkefRfUKR5w2hgvE/dgRtt1mCwf1eE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdf5972-523d-474e-bdab-08df39bdc5cd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:18:54.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA7nXpD++MhhQ1yIslCSiyiSgZ6SpuyC5AKWv1/fmHbHOGWog9WadGLw+yssXPu9MyHTV+SU7aYK6C2tFagCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

On Mon, Nov 02, 2026 at 11:54:44PM +0800, zhangmh25@mails.tsinghua.edu.cn wrote:
> From: Minghao Zhang <zhangmh25@mails.tsinghua.edu.cn>
> 
> tnl_update_pmtu() derives the tunnel MTU for DF packets by subtracting
> the outer IP header and the tunnel header length from the MTU of the
> underlay route.  When that route has a very low MTU (for example one
> installed with "ip route ... mtu 15" on an ipip tunnel, where the
> outer header alone is 20 bytes), the result can drop below
> IPV4_MIN_MTU or even become negative.
> 
> The IPv6 branch of the same function emits ICMPV6_PKT_TOOBIG only
> when mtu >= IPV6_MIN_MTU, but the IPv4 branch passes the unclamped
> value to icmp_ndo_send().  An effective MTU of -5 produces a bogus
> Next-Hop MTU value of 65531 in the generated ICMP_FRAG_NEEDED instead
> of providing usable PMTU feedback.  Values below IPV4_MIN_MTU are not
> valid to advertise (RFC 1191), and ip_tunnel_bind_dev() already
> clamps the device MTU to IPV4_MIN_MTU.
> 
> Mirror the IPv6 guard and only send the error when mtu >=
> IPV4_MIN_MTU.  The packet is still rejected with -E2BIG.
> 
> IPIP previously rejected packets when the effective tunnel MTU was
> below 68.  Commit fd58156e456d ("IPIP: Use ip-tunneling code.")
> switched IPIP to the shared transmit path, which lacked this check.
> 
> Tested in a network namespace with an ipip tunnel: with a tunnel route
> of "mtu 15" the kernel generates an ICMP_FRAG_NEEDED advertising a
> next-hop MTU of 65531, and with a route of "mtu 88" it advertises the
> correct MTU of 68.  After this change no ICMP error is generated for
> the "mtu 15" case while the packet is still rejected with -E2BIG, and
> the "mtu 88" advertisement is unchanged.
> 
> Found during a systematic audit of PMTU handling in tunnel
> encapsulation paths.
> 
> Fixes: fd58156e456d ("IPIP: Use ip-tunneling code.")
> Reported-by: Minghao Zhang <zhangmh25@mails.tsinghua.edu.cn>
> Reported-by: Jianjun Chen <jianjun@tsinghua.edu.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Minghao Zhang <zhangmh25@mails.tsinghua.edu.cn>
> ---
>  net/ipv4/ip_tunnel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Why is this interesting?

An admin setting such a low MTU turns the box into a blackhole. Why does
it matter if a bogus MTU is advertised in the ICMP error? The overlay
source will see that it's bigger than the current MTU and won't update
its PMTU. At best this seems like net-next material, but even then it
seems like unnecessary churn.
