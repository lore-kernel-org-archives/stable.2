Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792507440;
	b=PfeRBUc6bjiqpZOh/aG5OQCH+n7JZBn1WQrFLjl5/mP8DJ+s9vIXYyYTVV3gLjAS3xTQ
	 tqen2kLIHFQG6MshjUtRQKLlM9QE78Hif0JQFuG0eBzIwFQPEnXXDU9TC8YPkPstKsQ7h
	 QXF05XY7yx74a29UQwcMweJcN2I+s4pruZ4ERcDgPT9tyHxX2AFpMviVt9jTVYrWBmR1O
	 yzknsyvW6E53Na+J5s5rDAI32w1ikbh3YrBXH/lO64SnVCA8kVZk/QsgdDq31OONKfksg
	 2vix/um0xecSO8/lJD8ONn7RyQNSC1cQxsvL9/nOMsMgdzyfjWFKk3lau5gfiqOo4xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507440;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7IPvT4Mz0MGzHZeGVk1QcdyiZql49ZPPNNR74eOuKHg=;
	b=oS8JO3uvx7wkDeqQ8F+WiYqP0c/+RHg1vd/gDSUtlXS31bGvmvipB8Ezzg8cs4LMXvZa
	 PsXNQrSG6mEzzRpZBnUixHAaGWUx5QlN/+OKP8AObk93RMKdCvSNIYyLIyVeKDvRM4pkl
	 3re1Sx66xJ3h+Vlt1rg5hBxchGAdiHZ3jOngSGvazTKalscL9FKgJNWBOwMaR0y4UOewY
	 3MgzXnoUPghCorxkQ7ohIPEQC6WFaDgvdMb7LHorkvQomt0mj76Wd5m7az7Pgcu7ChP3W
	 8WE0JDVG0N3EZuMk2i7FpJvwr4r1JzkG8uumyfx6wi5eZ6SqDbATKXyfW7nehEDZ9HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oooaWVYn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.64
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D1606A31F;
	Tue, 20 Oct 2026 14:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583D1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oooaWVYn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls+1ve9kMz3s32F4r/dxeqGORBpeQDg49KeUYoC2ggv95jzJuTU4BsMPD9cEhZtP+Ta6sYYfInkN8/P1B6TKKzeKWzoMV0EHVgbQlb3WAd4Ld/S/aorlrWjDOuhcvTJOuj1z0ybN1tbUYv9FVwf1gHNIjwa69ECQP0luacnyazSAI9smO55PBUNOePYSZQHhhPkvkq/PqZKHltZPWTeuj6+6tZuIlf7BjUvynNq34F9kVcYQbun0gTMlSlyJKfAyXSjaTy79MkuV72qejqLSbL7BTABTt+oH5O+9zuoCi7FKWWtkamdZyZFf3F9FxWpL698SvE8rv753Fr643AxbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IPvT4Mz0MGzHZeGVk1QcdyiZql49ZPPNNR74eOuKHg=;
 b=uZTvuFIFdzzkarbpEfzXStg7VpaQJzivuqktn0noDTh1IIWTUL/dQM9kyk5PrsDXVdW8v/heY052AblFbf2VZ7R2vv1swzbU29O/pLSGPx/LJ2jePNGPMHdj3VsJWf/4jZjFaTGUvIHhvOHWPS9rRwDAXRJLTJEC4VtTDXx1lAEci4hT7VOyV3LdA//VYbxbkQOmAyAYzoOdrWBhn6YtDNWSs8tkhih4JVVBfkswUcoR9vU9Au20nmOuFWt7/w2CuVwkqsEtpBuzsVDUc7OcGPgxAEiW6CExzzSHxXFvIIesjXXO0Wyy+3Xo/gxcNop+wMVndkQB0GYC+hs68T/SKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IPvT4Mz0MGzHZeGVk1QcdyiZql49ZPPNNR74eOuKHg=;
 b=oooaWVYnIGLR5JuqsCVq+0k+/1yxJJaVwzjDxaQ/FAB0nLKDKD9i52zQuPXk0FqiekbTLKiVJNI6/Mmh4ZAd/EwHwlyWNxlbLgIVz79eO4xvnPgs+KlTo7YxlM17z2LR+qOd5S/LXWTgsT9/3LGc8iYxy+GtW0YHjJ4XDK9Jls3CHYqmwDeraQ7+ouohUWHqraaK4gsyOXNfqtZ5Ockuuq5A+M7QbulIjvpiHgtHhhgEkSZ5y7O1waZonCNr3AAm8VDM9AKoYaYBQRzDo1bQ7a/xXqq5l4OPnWKAZMfwrfP6Q0YDrW89pSWtWdX3vjdzKDr+kffEPvRt99uzw6/3zw==
Received: from BN9PR03CA0508.namprd03.prod.outlook.com (2603:10b6:408:130::33)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:43:54 +0000
Received: from BN6PEPF00000071.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::a9) by BN9PR03CA0508.outlook.office365.com
 (2603:10b6:408:130::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 20 Oct 2026 14:43:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN6PEPF00000071.mail.protection.outlook.com (10.167.248.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:43:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 07:43:32 -0700
Received: from [10.64.160.70] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 07:43:29 -0700
Message-ID: <50307a46-9e0a-4c38-be48-eee441b391a7@nvidia.com>
Date: Tue, 20 Oct 2026 16:43:22 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
To: Jens Axboe <axboe@kernel.dk>
CC: <ming.lei@redhat.com>, <hare@suse.de>, <dwagner@suse.de>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
 <179250720323.3338252.2582321707097985664.b4-ty@b4>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <179250720323.3338252.2582321707097985664.b4-ty@b4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000071:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f05cca-7bea-4f74-71f5-08df2eb89011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|22082099003|18002099003|10067099003|4143699003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cw7/SsWf8eyVcAXajhvV5B1E9D9e90xGyuI/d56TvSWIdB5OYmwbTzZFiWyTxWKi3x4Q2znsV4pQ4lqrdFC63stdIIZs9x+gyJYop/Ufhn3gpXA+WXOcXfIVBa9QpZmuWaZZQvpqNWrfPrjSQHxDaL1YjwldhQms2xbJk7V2qvg57zqhVjpvDB6PZNsNHtoAZ7UCjKVec/ja95nQDxrwqhDiPes7UFerBYWLbhw6N1AkmnoN2K5NSjDNk5DXmbMiIz2QIKJmxrVSQ2wH8aINd90MC8ptBydHp0JooBVTU+E+NqXMaP/DM20zX/6woWX0o/3MqhPoPwqN9F/mR6tV4IAV5CQhHakrBpnjpcTjTZakNCYL7IIA7RoFDrt0muVqMcoVS1S0iii5dYZty5FiyArBim2GAN1ZdPd+rDDqAvECMZY4WOrVqxcSCuZkkmmQl0B1oN+D71WlQ+x3OMNIagtYfzAO8PFTpuGgQsd7wlRWJUDDQMV2KbjuGJitH27CdbMYLOcUBeSpnddaOAAYI8HUed6cAI5rAF89rvBOQNCHe2RWyr/nfo9t0jaXy/CdMkoFU139H2J9eeUjyqMMTBXkgGtUOD7r1x4feCMy9zF1xGwVIzvtqJtqCiIH9oiZOZ3Hba2wvvlRz4UM6gF5lseQPmFHbL7PdLjPZGJ8cZ8SDbcw8q0MQJy6RjIz4gjHqFDUJ+r5naN3utSpeYHjfA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(4143699003)(5023799004)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x5rVyEPd8s4OM+nxgOGE04p1htntjVpcOQiXc57qV0iubu5R0H3B72MYfp1I0SMfIeyPkWptC4qNNL1XOhEtNdffN8c1l/J8LX7CRWY+oXAUOIDZwf/089iSSMa7YHgopv9VdrdYpuuqk7o+CvFfu0g+YhTyt0/n+TOqopZfOPU3alTUF6Xu1mnWX51/ht36C330RO/RcrT4s0l5ZU5o1kCWMcY7NcTDHzrANRzqV1wgLPtHcP8+2D+Cm5jHdsrVpnKy5413+okMN+4jPznFu4f+IkuTFKV9KC2ged7icNsFB8v7jWnc6/aU6X4VLFvI/ozkpVjkWkx3w27e/OaGKXDgRXd6Vz49Rl0rxOkOxiibTjaPi3WxHGSLPzzPy8CwNk6D4oswKpLxBI+vNujhu0pAhAsv1WHw1R09ld/HPooiCu9MTnzr5rsu77D9WMlX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:43:53.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f05cca-7bea-4f74-71f5-08df2eb89011
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000071.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732


On 20.10.26 16:40, Jens Axboe wrote:
> On Tue, 20 Oct 2026 05:51:29 -0700, Nirmoy Das wrote:
>> When the last CPU mapped to an hctx goes offline,
>> blk_mq_hctx_notify_offline() sets BLK_MQ_S_INACTIVE. Updating the
>> number of hardware queues exits every hctx and parks it on
>> q->unused_hctx_list. A later update can reuse a parked hctx through
>> blk_mq_alloc_and_init_hctx(), at any queue index, and nothing clears
>> the flag.
>>
>> [...]
> Applied, thanks!
>
> [1/1] blk-mq: clear stale inactive flag on hctx reuse
>        commit: afc1de47a7ab607ae6403c4bfda36b0bf3cd342f
>
> Best regards,


Thanks, Jens.

