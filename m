Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982293;
	b=Ul8UaIVeWqtUi4+zxDB9eKb+0ip4wla7ZF8aAmxFojYR75IfBKXCIrZ0TyCiVs6HyoZb
	 5z2nKiQB0KcRQ0h8cnl7DVrXU2vkJBGH/bDGwdk4fGrzY5y5qrv9jeKyBGRVpTG2jJ94s
	 UFz9+6dXZvMRGZTfGNeFheYyC6XUYsgc5LLoT9RC/BuMhCO9t4mIM4aXUtLbWUcCUseeq
	 qCxyMlIQQwFTqvrmbfljQPEIHIOx4FNDKMGTAc2mph8lSJHeAkVLpnFkOFuZPsjYMvMop
	 UpjtWlxVmmxiXnimOcUqpK8TrvW9DDDbVc8JhyOl73iGeXAr/RZDKBXk3Z+uhJhYXEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982293;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=dUX6vmch0BlrqiuGD/+X7XOM9wVyLBBUnwLYfplnWJA=;
	b=LyQ9LBb2QMzfrlExtS9q6xjQtVTuWU93A7H7mlerwce8yRxBziExiB7QmXe22bFMECEZ
	 NwpcjvJkbTA2nS0HV9wxD4S99bf10cg0ZoJ6IfNgTWZgiwabtjaDcZWc4scIggHLoqNET
	 gXCsRP9ol/6QPNWYYBRfanvGZMPYmkCNC/AH4OD2nZ2RpfPHC7CxcF7rCeFF8JzsiAUd2
	 peXiKzeKXEPudE4wOSHeMiddrWOqkZhy1ximSf031N9Fj2fHa0X1gZgU0t6cuIRWAH5HU
	 RA9UEu/Xv29o4Oc5TgIdflmscSbE4D0+uCE+A6RjiKkyAEB+xfd8l5XEGZoFg9hJI7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YZ6jXegV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.47
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366E606A326;
	Fri,  6 Nov 2026 16:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0366E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YZ6jXegV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xixLxf9qtWMCBbECC8eZZ1iSSfo5m+Um4ATDioaARSHg7pFvlkIPJQTtnuS8A+k5RymrTSo646LOhldlLOWLYeRnKipepXKI7oqHui8rrWlj/Mg9iFzXUw0rgIEFSGCT+KTyN0yhEnXhsRdvYM2mn2ePhKwWVqLxXluQCIOHZlRyyuvBvaVCgvOuvIFTjaDdVxIxuLe4gZwEqLTcfyuCd88z+OSk84GdJR4R170yWRA9l/Y7gwNAYd3kVF57LSsuG/Z64HltR2qQgu2E39Bu7LsXpmorMrGYclI1FTG6WDsulYHU//ZjJk6c1u8cveus4tZ95iR0UlxhIHmYI5jrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUX6vmch0BlrqiuGD/+X7XOM9wVyLBBUnwLYfplnWJA=;
 b=ha7oI+5E4Whr3IWD/17KVHZaq3ivAnBiA+LBQofNexfUYLFD2sohSs650foKDHevb7bJztQ7zvyHbhfCqsCxF2WyIepyVcxCt+n+V7LvYvsRYIo6Idc8S5RqpauHvbrVB0m6Bzm9oQj86SLdc9GA49640oiKWW+Wa4SYcO9Xd+0WzVRwCoJ+XPxJvan5UrlBMyno0Hltes88x7jX3nsoY+nnArbDSKDxtCRedCAacMfDitI6Es7+tXgwzvq/0ZfvWn4SZwx4onlMvjuClyDNOx7foVJZnHhM+yzkC844K2UssANrigv89eWFugilvJecJMCaGGcG1S/1FOW1/Jg+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUX6vmch0BlrqiuGD/+X7XOM9wVyLBBUnwLYfplnWJA=;
 b=YZ6jXegVWHllUX9QR4gYgB9zlqlNeJPEo/4SgM2+S95Y8WsoL3BTAUxzQLedN//wf+AR4o97zCTBmtgaoO33/pR0ENbzWavbR60ajZ8HvqnyqwhA+anF9R9kYwntPJX+G1ZP9Hv3lZ/Zyp6pWF5OTrDmieedxFtlpNZeWe+WEW0dTCNOPFn3JK5tEYOeJnABGAqT0IFsOjrvr03lfu6W6TFqPzasDLrnPEl7TURZ4yNLxJlMWO9Yjpt5S+JmHBPSsi6kt82NlJrt3SpJjcWcY7zlx9GUSkzTJlXYhuVW8xMu2EoG6bHLhSckRp8BdG0BZcZacic3bwPl6XvOykV+aw==
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:24:49 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::48) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 16:24:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:24:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 08:24:28 -0800
Received: from tuxedo (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 08:24:23 -0800
From: Petr Machata <petrm@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] mlxsw: core_hwmon: unregister the hwmon device on event
 ops failure
In-Reply-To: <20261103102850.1340455-1-vulab@iscas.ac.cn> (Wentao Liang's
	message of "Tue, 3 Nov 2026 10:28:50 +0000")
References: <20261103102850.1340455-1-vulab@iscas.ac.cn>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Fri, 6 Nov 2026 17:24:19 +0100
Message-ID: <875wya2aj0.fsf@pmachata.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d64f1a-d2fe-4091-4415-08df3c227ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|6133799003|10067099003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021121427099003|56012099006|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	hVK05cdysX/BMKLYoOsJxMkEtiZjKepys2xV46TYUM/KpLwSmxfpSzn6/mUO0twB1KTeO5CBlTan3f+VRwsy4lZ4ugp8RdObu0JvGhNqS4C2qUbjgqE5anq/QpHlYVOLQ9r27JsqdQWJhoOHhD0I5iBQfCPXxztbKFMfPNIXv7VG/7vYHFVjftQdfYuPyYLBcLbNDJIQgzOFbW89cyejsnmfoE53RyAPtI2Ubnum1GJR4TxHmqaHQoJBqtRgXJ4VjRy0ErvLbEje9WQmakltA3ek105z469kRxbAjTx9I55SYeFtX2vPUI3Xs1mWGsLo7XIVdgOKl+efayCkcfL2S7TnPPwPCXuYL5oDj94a20SRSfORgUKDAzMShEe4+IddjvUH8Hf/dakefOiY9ka9kGD+ReX07AabCdApLo6iNtTLLHe9FcbyPWtrTK6fn7IXpFGxRfli9zmhCn81Bw+k7ZMRvIjoKvsxthxagsH3s60w9eosJtAg85J/tzlSGlz4fa8snASJs6gbI87c/YEbZ+k3e2IdZ6hZrTG6eoWeOx8ruFP3B7PQzh1BBYKGiuBnWbdfYwcP294A9KvsJXhpHvMWVqASG/q3qYcXnIBCIkAGpz2hNn3PU/V/9dOq+CYg+ZQr4qujp531WE2SKR6Y0MyXu9GM4P66KXKwtR6eRAEtNEDxhey71wqC46CyXtlh
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p3rxYOFBl1o39Ykwh/wJnYR1lPLG9BUXiPOMmeFKWSYgZg90MzWpWRoV/SDVJrdnrl/cDUMBHGqQVBR0mmJzMxd3S7O9YZgWi75JnFlu2jhG2c0vlZiXUEucC1rSr1mzbVTGYFg5WiPQvpFJFQcdwJMlBx33bFnuTb/O5SebICm5LUzflFifV1R8kEqnosxIx7/SSQt9KQ0X7sSTTw+06+lSKpmCtXY1qyhkBXVy/M/d9DQ+GpmYjQBws+x5KSBFzVZgi6+GDEd06VsGvvYoevHK1PNpPCK7YHmfgtsR+PwumrkqRdEJbvvLwsr6/x/DXflo/pyBsiR+lkpdpR2DVIsxKHjfW/sceZJY/q+phhm3jv0r7aA4sPa4BShZmunqa0RnUP/aMIUOIyRTe3jP7Ww9Q94wjmLcekDZXzmF1zReB2xJhaKpKnvpp3PTEBrb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:24:49.5110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d64f1a-d2fe-4091-4415-08df3c227ab8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

Wentao Liang <vulab@iscas.ac.cn> writes:

> If mlxsw_linecards_event_ops_register() fails, the error path calls
> hwmon_device_unregister() with line_cards[0].hwmon_dev, but that field
> is assigned only after the registration succeeds and is therefore
> still NULL. The hwmon device returned by
> hwmon_device_register_with_groups() is never unregistered, and the
> error path dereferences a NULL device.
>
> Unregister the hwmon_dev local variable instead.
>
> Fixes: 99a03b3193f6 ("mlxsw: core_hwmon: Add interfaces for line card initialization and de-initialization")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Petr Machata <petrm@nvidia.com>
