Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794512449;
	b=m2OE/Zci/G5W1AjRhq+GvPk4K822BBFbg/v5BWOQ/TdBII9frpDyMMW9rg0X41XqmcSc
	 WWJ7BzqmLkurferBCo1RG2H2FTH3WYplq0SYN/aRTzgwYx0hw1qF8fp8viTtvHdDypCQP
	 0vdRocKBJD2rNwo8tqEEM5cDjwHjtnlkNb5waaqcG5emGaNZG2mzJYqoTcXAJRK3WImN1
	 iN+fJIhDee4xPv6cChAsLQl1tcCdfiYiwsDqi9zY6wiOzs7N6QXcjmpwac0pjWpy+/pim
	 lrDQ+V57qbG1dyV86z6fvOIu+GIyZFW5rvgryknFmaQHiGxh1yz32Gos3yFwPDwbiQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512449;
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
	bh=wa3YaHg/scjPlpXbydVlZUJu3n2s6s/2uzf1XMESG24=;
	b=BCljbVZyX0A6fXy6rcNPAmhsMwe1oykNpD4DEu5Q9ldUeRyawi5vLFzpRuyev9O3NOzc
	 B5VJpWE2KVB/OfIM/047DzS2YMwMdqdVX5GO41B9KY88w6wZ4mt+8lkX97KjrDY4v8BLs
	 tYBy/ugnAEN17cRFyxcS3hDv+jTs80SpQ/jy878BNH3mJcNzDOSM98a+YlLnrIhRoda+5
	 RZu5YGfHrVLiE6jchcYm0vK63Csb1M07hdo6Fsyyxj3pQrI5NKAPbLKr5vkEK6M4y+liI
	 N5O3B6ZoVdYEP5zZ4jPotlRzi/dbqWlmnye9/FggJH18xOxNJNQJomBamtmyjZHZ4bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M3iuTcAg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.55
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB0606A31C;
	Thu, 12 Nov 2026 19:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEDB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M3iuTcAg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfBMubNLZ1eCQCYBXT8x9587bh6LrZw4PlkazWmEBbyqYtEUFTc80zCA5PrJrlGukkxax7ZsIFwCXoiMnbkicg15WcQAGl2sdzOyqTrUGjdyHsCCJJdMLRBLzC3ndLCtWzE+LCB4MMJlQqq62gwylS8pHlsJj4crtmbCyt78fKddGm5KC0c8Th+zbr8Vw6hMrqk4fFaNSy1L4SV2+qKYbLvK6FXolv5+c1gFVYQoCX+2qjN5RSPT258SxvF+GoYYE9RKjqLi7Zy6Fhuy019Kqem9szx7j/gwezWshGk925kG/opZipBAnG/Hk/hYXjwh6hFyNgAdhKTIqYnL8a4+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa3YaHg/scjPlpXbydVlZUJu3n2s6s/2uzf1XMESG24=;
 b=X6xZoflg9U1a7bXdp910AoSDNmPnqyz0sQBrQKVHbYOvtA6J7fEgUDNyPsrmKsvyCRS5j6lKPfbP66BWOZAr13AmrL90GNc7smKFLrUBBrY90WZMuQ0a+zlYL3KivAbtSLHhAynavZZvAkKcY4JSbuHWz+yparRHVXKzA2VrMEVSC0kv2V2QTqkIAroOFUCucBWkS9uKUWEOKXNjSTIjXr1ikYW4ZrOpTFKN4Qaz+m1TlM5CCQMiGcgeXEJ6ZbKcnP4v0aByg2LTYSoy5h5cTKaAC2z0vfkoAwCXYYNYVPiVKwMXwh37mWlaMPyo+yxMaNy3v5kctXSM8MlkQmhJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa3YaHg/scjPlpXbydVlZUJu3n2s6s/2uzf1XMESG24=;
 b=M3iuTcAgjCSI5oPy+oyGcaBO8pn5qHO4uik68Ee4XnlswWZBnXKy3oCrk+/2X6tGm5nWeO1uq49A5qB3If+84XDUdw5juxyzOaJKgndjtnTRjYg86Y82nV+o0dKJ07thUVUFY3XE5PUMIcjv5CuOKz9gniqKUiOiGmhFt1mEqwfzo/85kttF1VGGNgBQD+fRz687K3yMjqIn9hM932wgekFFWHjio5/IneAq8CmnV661j7pl3us6eg/a7aZH6mb1iTg9K/nVB90M4iQ4/DgyEOR9JXgdRBprofkp4NA8VkBRzLQ7/k/Ay5DeFgFXkFvSKAOkSkuktVfyjHi96cb+fQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 19:35:42 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 19:35:42 +0000
Date: Thu, 12 Nov 2026 21:33:27 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: liamsmith827 <liamsmith827@grapheneos.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	liamsmith827 <liamsmith827@proton.me>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/4] ipv4: add FIB_LOOKUP_REPORT_MISS
Message-ID: <20261112193327.GA3410656@shredder>
References: <20261110061536.10811-1-liamsmith827@grapheneos.org>
 <20261110061536.10811-2-liamsmith827@grapheneos.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110061536.10811-2-liamsmith827@grapheneos.org>
X-ClientProxiedBy: AS9PR05CA0118.eurprd05.prod.outlook.com
 (2603:10a6:20b:498::7) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 984ce416-1148-4509-6e60-08df40f42366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|4143699003|10067099003|11063799006|56012099006|261021123027099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SFLxiNzcG1/qHM3wsFMvupuTWiRzvkXVEPmkxTxvu99B4dsxJsb/whnoQQ2pNy0kBoEs96XK6+SXNCUsL5PMr7qpygqfVtfnlzPK4oRKpp+Zf+OtjTm4Ks8Di4qDlTI2fmUD5JpVkJpqOgy/6BNQJ0+pbIQJoF/TNNplE1spf0hxoYS5eA3k2vm2zCQqBQwhzHROEFvKA8VvdJ5yvVkGFgsPSSwfIwQxM1CPKzQhFvtfObLL+YOUSxdd/jyaoFxU2N8qCMt32OeiR3YhXDi8qC+gNys+azhdcF9y/Nedi9v3fEHpgl1GclBDJdLNSSZK+VXqZoI9ohxipq2dU0m+DLVlzA/Gz4xbIB6xkY6G2egyT9/BIbAT8hfgVMQJS03SUaoitXTeKhz0AJcyomYSEsEl2sZUr45LnXcWcTmfeOqldPS6iOGYBmFVPvnYbiO090/theDpcJR8GMnDfzcZV+E/AAPwolwF+8jx96TOakk1A/D9kkAYbadJ6VNIQ/5YL5JumOrvUuvakZ3412T7fJRjVZ8akN9H6gdJCiP6p7s+z6CC9fX9/IdEsRX7zLq8EAAfubHXtukjc2MwPEfqV7BuwO44WJng1iWnbroxs0NGVhOMm1/Xg4qsJngrBGdmk/CvUfqth3gmfhjZ5HHTwqoQcHMHSQMrhMszri+eL2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ha1PeTjfhDK5+V9YnvdH+pMNlXpwHxeyUf3XHpLPSvkq4giZSn4W0lDo3WYy?=
 =?us-ascii?Q?iJq30L68/e9zmSzkM80zUFyDwDNFmudNp/tu5pEC4I/oO+9DbI0pYjZf6WuO?=
 =?us-ascii?Q?CwspNPA4jCRSC0U3j2sjZZRzQwwRSiQhjY64DZycG6Ry9PB6Wpzc+JZO1ZGX?=
 =?us-ascii?Q?bbEsWDwOLtroIaJASXqAFTcolOWUJRnJi6+s1Gs+/bIC3PLJHYGGffSm6UAU?=
 =?us-ascii?Q?ef7qYScs9EjQffOU4W54m01XUxkVdLFjtUeST/ZM2fyWaNJUZcZ3+GMK2Bi0?=
 =?us-ascii?Q?gsC4wUrxPRWXlFPrsWN0S05/mkKSKrUzXPDvgE6OP7LXGIKpVp9iefnmmgzP?=
 =?us-ascii?Q?hin28Xt8vRwH4utXhLMf3fjq7Oifr8H0pPa3Z+d0WEQvuvsdVTkMViKh76Kz?=
 =?us-ascii?Q?1vISUtCerj508xyG8B1WGLdP5v0/kMFWj9GtJaA/KvQPkVwzz4QXlBA2S/qd?=
 =?us-ascii?Q?VONhpI5DXKjiYtrb9beCb60GGnLqp/KizgC42Y7ETrXGGjUXBUDYeVOglXUu?=
 =?us-ascii?Q?bHU5lBXSWtAVVgibC86naUgURj0e48tywAwYjBL6KA/hVmf+iFzpypUQacAw?=
 =?us-ascii?Q?pPiactDeu9yX0L3xPwoheWV/xMKiu7Csh4mlxVcKc7FEvP1y3sGjE5eOvNd4?=
 =?us-ascii?Q?1Vx5j5CHt+F1EFnPeJzW1AWvyscxYC3f80leKJZWOYAKiuuKb3YmFs/Jk+aJ?=
 =?us-ascii?Q?mVzDlYt6wtxBE4ZpdLxLc45Kr6n50a29bpKKZ8F105Faf2E4bBpOPxIBawdu?=
 =?us-ascii?Q?FZ4WcR92llkwBUqKa8nWV6L+NyWT/hnpyTFzohc2GqX9M+RAXaCzHEUKMRlS?=
 =?us-ascii?Q?/QOjT6tWJEk3aiDxlr0MVUKW1ZtYYbeFr7xP+f87JG0F/AxNUKJpsyrO6Lgp?=
 =?us-ascii?Q?npgSqadA4uPNqWkwbN66N9qMBkyCFOFbsTjg7p35jcytV3kRY9n29WYnkkP5?=
 =?us-ascii?Q?cwwBVRypZBFc4aiZwRfHvNLfqG3jiwV4aDDrH6F9XQmW1mGLHN67dv6++nmt?=
 =?us-ascii?Q?2qtrU5AOHItnkzZhAMen4SFJTFEdq+GMhT6DwlF3P+eD2MJVZvVhTDMraPt9?=
 =?us-ascii?Q?oILk2W4qc5maIONaj1FiY3L01cVxvseJSkZGbsc6Lg5N3cuRyBYZBmph517X?=
 =?us-ascii?Q?psOcX96fsrRczVQsOitK/ZBxwSJcjLHl/Yz34RTviwKwgB5d2XgfVx1M79gx?=
 =?us-ascii?Q?R833RKaQ1+tfNN5pXXDkXzm4BJbx1M8xYWC7NfF51zm220QGVCIjMjlY3KuP?=
 =?us-ascii?Q?QmBvBgsZDMnbZG29lvqiNtpqBUDXd2x/mJzx+tLaDUjHWjnV67PmPuuphZ5j?=
 =?us-ascii?Q?O+us+GCwlT0cDFscPcuA/zq2/qamHXybre7iqnnOBCZdsTya4dfzyBrcGqau?=
 =?us-ascii?Q?Vjt5uLFI6Tvbi1RZVswiWNGNkZ+MPhrwsZIfmfKywbEGr7yNh9lmr/QumtcL?=
 =?us-ascii?Q?bllO3AX6BvPUT6GkSrDJre3nMVsp+610fGQK6reuy/FiaYPLE/Nrk0I2ia4J?=
 =?us-ascii?Q?/D4QCUo6ZblyriTXE7gVPkUEDgfaztmoOkA2v7bHgOkYfzCmXQfZ4uB6DYOL?=
 =?us-ascii?Q?q6gI7X1Z6Qos1qM8vk7IMJb+a02mQH9oFkUzwDANNQ1bf7C3dOyQKFRNnZnA?=
 =?us-ascii?Q?on9SiRGBvGq+sfuz2yhEWev1MWjQUhVoU0x8vleuw/VTx0lcJiVdZzskgiMk?=
 =?us-ascii?Q?qVdwuEyHhEFYLSDX/wBXkVdrmJgb6eYX2tic0mHhI8LMSI1D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984ce416-1148-4509-6e60-08df40f42366
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 19:35:42.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWZQzHI6YZp8VikUoANugEKnTvE6skRMlLgo/N0oTs+g2zAflwbJ0j5SS+HgqSHRuhaOWA4n0iYYNgrlFXDoag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

On Tue, Nov 10, 2026 at 06:15:33AM +0000, liamsmith827 wrote:
> From: liamsmith827 <liamsmith827@proton.me>
> 
> IPv4 FIB lookup maps a routing miss to -ENETUNREACH, which is also
> returned when an unreachable rule is encountered. This flag prevents the
> mapping, returning -ESRCH instead.

Please include the motivation in the commit message. Something like:

"ip_route_output_key_hash_rcu() will need to distinguish between a route
miss and an unreachable rule. Currently, both result in fib_lookup()
returning the same error code (-ENETUNREACH).

Add a new FIB lookup flag that will instruct fib_lookup() to return a
different error code (-ESRCH) when it encounters a route miss."

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: liamsmith827 <liamsmith827@proton.me>
> ---
>  include/net/fib_rules.h | 5 +++++
>  include/net/ip_fib.h    | 6 +++---
>  net/ipv4/fib_rules.c    | 2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
> index c6b94790fa81..bcb6809dbd10 100644
> --- a/include/net/fib_rules.h
> +++ b/include/net/fib_rules.h
> @@ -59,6 +59,11 @@ struct fib_lookup_arg {
>  	int			flags;
>  #define FIB_LOOKUP_NOREF		1
>  #define FIB_LOOKUP_IGNORE_LINKSTATE	2
> +/* Return -ESRCH instead of mapping it to -ENETUNREACH. Only applies to IPv4
> + * lookups. When used with FIB_LOOKUP_NOREF, -ESRCH indicates the lookup
> + * exhausted all rules and tables without finding a usable route.
> + */

The comment seems redundant and IPv4 always sets FIB_LOOKUP_NOREF. I
suggest removing the comment.

> +#define FIB_LOOKUP_REPORT_MISS		4
>  };
>  
>  struct fib_rules_ops {
> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index 92f4eb8b86d7..d0b4f261585a 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
> @@ -318,7 +318,7 @@ static inline int fib_lookup(struct net *net, const struct flowi4 *flp,
>  			     struct fib_result *res, unsigned int flags)
>  {
>  	struct fib_table *tb;
> -	int err = -ENETUNREACH;
> +	int err = -EAGAIN;
>  
>  	rcu_read_lock();
>  
> @@ -327,7 +327,7 @@ static inline int fib_lookup(struct net *net, const struct flowi4 *flp,
>  		err = fib_table_lookup(tb, flp, res, flags | FIB_LOOKUP_NOREF);
>  
>  	if (err == -EAGAIN)
> -		err = -ENETUNREACH;
> +		err = (flags & FIB_LOOKUP_REPORT_MISS) ? -ESRCH : -ENETUNREACH;
>  
>  	rcu_read_unlock();
>  
> @@ -398,7 +398,7 @@ static inline int fib_lookup(struct net *net, struct flowi4 *flp,
>  		err = fib_table_lookup(tb, flp, res, flags);
>  
>  	if (err == -EAGAIN)
> -		err = -ENETUNREACH;
> +		err = (flags & FIB_LOOKUP_REPORT_MISS) ? -ESRCH : -ENETUNREACH;
>  out:
>  	rcu_read_unlock();
>  
> diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
> index 060501b376a8..3d7dcb8d0865 100644
> --- a/net/ipv4/fib_rules.c
> +++ b/net/ipv4/fib_rules.c
> @@ -101,7 +101,7 @@ int __fib_lookup(struct net *net, struct flowi4 *flp,
>  		res->tclassid = 0;
>  #endif
>  
> -	if (err == -ESRCH)
> +	if (err == -ESRCH && !(flags & FIB_LOOKUP_REPORT_MISS))
>  		err = -ENETUNREACH;
>  
>  	return err;
> -- 
> 2.47.3
> 
