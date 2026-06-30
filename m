Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866323C2BBA;
	Tue, 30 Jun 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838412; cv=fail; b=bmrJjVctYiJb5voeym3YS3tjHqH5+y3hJ1AFU2IZgxGbiu34ZdXWSaJp95+xizJby893/7a2tY0ufSl9h9oxJMvjmTT4oPlK795nz+YIemAeHrckyhGSPOWFIXPoERD1xxBRqcxuHYxNzx1uv8+JdPPPKAqhKiUe12rIU+Cpq64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838412; c=relaxed/simple;
	bh=v2E/uSu1sHtvIXPrgx3zY8ctoxoEXOu6N2u4fuOWH8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jRWkVlbw0//ERkG5HgQlL/UkzoSkTtgIbyDiajV1F7R3GNOUgdj6nR1ZBn1JWzagZ7OZZwQwYCW3IUTBZRkOJ1/XERkh1TYYNDI5pDQbH1dQByG5jFhWwoeBHP8oz1pkoECv8cOJ15pCGDzF5vRKrVIEyCN71X4rKZ3mAXNHK4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sv0c64JH; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sv0c64JH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh4NGoCKZAwd8HBpHBVxxNRAb/MRug7ykuApRckC7mowLOKEVrzhTnaootVehauPiX3S+1v9X0wftB73Trz3zy+ng6QzzsYAhGO0gKCq3DWL8a4BW41H8FtdkCd0NpSo1vyvhu9Eum9HxfQ71I6OZwavz18zmk6ZSVcWpu8UgRbnDO72mNlE4WHH6vH7UtRtnLV8OA8SoUoUh0wG7opNFSQt1VXhZRHw3ztkHczQRIT2i4UR9x7/fSz4hfoNBa6lNZOl5f7bRzKGnet7Wkxfu2pQJfHF8acHywUVMv3bU4NTmzrwloEHFbB/1I/ksMi3zswynDq/jYkRnSjW/hYBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPMJ4ZlQ0j5HtNaXqL/xwJMdSqenXPEKoAzm8QDGGS4=;
 b=M6OXxAoxRKCe4Z5tkZAYuD298U2wtkrHx1/HwqULpzyBtg1FlVcDdR3D4b7mcm4iyJ8qiuyGz0YRs+XYkY0muYZyeQuibjH/Ul7ntyYUarPCnLHpTDEk+kBMq992NCtANZ48eYjUm9CzZHNokW6RWhRWUwpD3JqdB51Lp+LQkJwR15act9V0UMkd5YfJUnUrJ9XGDebseyHwIUXzQVSU3S+Jx5BYT0iK4pIhFwooRaudG1a3i2I+eD7Hh+pOE3/b6/8HhwreskTJizYv6hsU5kbvb+0geGDisHPjlWTcOqB2ok7mXQNNMtrI5rDg6WgAzIHw/rJM7Nr4ZH5nsCTxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPMJ4ZlQ0j5HtNaXqL/xwJMdSqenXPEKoAzm8QDGGS4=;
 b=Sv0c64JHgUosHaB7P5up/PiozWETQqBHVSBR8iZCAVa6UBJ9T6RTUwieFnqLyoDEJrqeMNo/3KNWbmhhp8dy4LFkEM/3cMxzR45TRg6K+0LxTOkQQQVjijPqgqT79wlYOXEJlzUep3zd6+BdvZVs7/yQviW9IV81N4o+zZYekIQdn+iBJAo8GbLswRvh0AVeXykc0idDCQOY9JRrneXzVtUdqlOHzRHULVrRmxcWNbQVvxDedSiVCTvomZdUTwtUulhfVpE2P+yiJ0TtWMmqTRgq5OAR5UDGvzEMeM/fUKM5W7fmRIxXjM4oZR5NRlqMZfaY8TRNUwDu7Fnr4N4TZA==
Received: from CH0PR03CA0436.namprd03.prod.outlook.com (2603:10b6:610:10e::33)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 16:53:23 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::89) by CH0PR03CA0436.outlook.office365.com
 (2603:10b6:610:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 16:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 16:53:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 09:53:02 -0700
Received: from [10.221.135.3] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 09:52:59 -0700
Message-ID: <acb1b298-78e6-416a-89ac-80f3d1984236@nvidia.com>
Date: Tue, 30 Jun 2026 18:52:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: make busywait timeout clock portable
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Shuah
 Khan" <shuah@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260626144902.3214350-1-nirmoyd@nvidia.com>
 <2a1c4eb4-a4ba-4fc7-9bda-6a7a8d0be2f1@redhat.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <2a1c4eb4-a4ba-4fc7-9bda-6a7a8d0be2f1@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdf9f9e-9adc-49ec-a0bb-08ded6c8193a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|4143699003|11063799006|56012099006|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hM6wD0mqI6dP6kifODwnn+1eU7RgOI8mdFGpfIvJ8fMJlQbl/InHFDa0gsCm1luwskd9vdG+wDXqvxJrWxnNcLIIb1dkkPham32pUjUE/ifv4NAy6miXr4B/BG/tA8Zo7tkG073eRIU0w4XWbVwVw8uqdkYXqbvJSinjcMJ8Nf1y0cQpMJKuPM3JqmiEHlXjH4D9rrS4l+FWzGBJWF1xz6REd38B3yYHyWCUlRqcKy1P8Cnyfm6pM8AbTG0n977DBFjCw+ORAX+LQAk8Z31JjJBEWZoC0XJv+fdTYpVPoGe/Eh9lcKh0FSq0rZGpA695fOhe13XZodNR72088qqXd60Ln2EFGjzRg7yWIZFzija0OUkT3nhP4dtj8gnNWMWwnL9DYbH2wLfQE4lJ4WksMMaEzfwYkYnVtlobEFUJRGk7soCdS0BGA6wPa6dr+cr4GfIFcfKvrIR9YnOtI14Ln2N79iXdgHU6zfSvlJ+B9Mvs2rHy2kgJooXBvWnf4Vqy+0nCmsOpmYiM7gWzh6y06zBOzdI4twrcRTpCoU9JPH+e4WwDIVnnwq1RHFVJ3jJ7XAI3+Adnk1VUsvz0DGOt0Tln/usmaZvBfb8BalvZy0pODvgpVMiJ5fK9JtnDAMheC8I87oYmYDgvwqhepqEz+WZ8IjEMk7DGO/jlayfUgU1yDqMzwPjRta3wUZlqAHQNRlIFv6UhC5pyFUJ7NpcauA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(4143699003)(11063799006)(56012099006)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yl/DvboXFNUdVMnNv2KCVza+6VSYeBn0DtiC5l6arHPBc5wx5aZFXPqMh0Som0sVOzwqILCA+vD22TcZC+BLmEKT0gZ7kOPuy3Ykmgkxt018McAwhZHc6MQZH2gpMoE5gowaOlUiVivaKw4hBbvWGyTZPqAyOMh+caXzeTgaRiATmtST0ebyjm8TmvnVVlHE0GQ8sbS10Rieb8cRy8VByAhRvywNn0uCr390o7TipgdTv7WnB57ZfrQ0eX+gArHyQpTcSY3X+/qFG6WUqdqszzndU6rQHsS/Zz8pm/yma5IyCtSXoq9r9okhoPidM8E54JarRDNi6s/MfRcaQstRvebwLfy20oafYsqM3IUOvigEYdzh+boptxWWXSMIfIcUfkpAET48mCd55FCTTh5s+S0kOzo+VtGWNpvX2kjTHuj21RtyRKz8Hp6G0ACHTboq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 16:53:23.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdf9f9e-9adc-49ec-a0bb-08ded6c8193a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029


On 30.06.26 13:11, Paolo Abeni wrote:
> On 6/26/26 4:49 PM, Nirmoy Das wrote:
>> loopy_wait() expects millisecond timestamps. However, Ubuntu Resolute
>> can use uutils date, where `date -u +%s%3N` returns seconds plus full
>> nanoseconds instead of a 3-digit millisecond field. This makes
>> busywait expire too early and can make vlan_bridge_binding.sh read a
>> stale operstate.
>>
>> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
>> Cc: stable@vger.kernel.org # 6.8+
>> Link: https://github.com/uutils/coreutils/issues/11658
>> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
>> ---
>>   tools/testing/selftests/net/lib.sh | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
>> index b40694573f4c7..fcaec058be6d0 100644
>> --- a/tools/testing/selftests/net/lib.sh
>> +++ b/tools/testing/selftests/net/lib.sh
>> @@ -70,12 +70,27 @@ ksft_exit_status_merge()
>>   		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
>>   }
>>   
>> +timestamp_ms()
>> +{
>> +	local now=$(date -u +%s:%N)
> shellcheck says:
>
>   ^-^ SC2155 (warning): Declare and assign separately to avoid masking
> return values.

Thanks a lot. Sent a v2 with that fixed.


> /P
>
