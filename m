Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793722270;
	b=LNcf7b4/zddfrRZKKmfaPPtSRyb9qXNTIAE8B2Lc9qnEY1PpJhFE/YF1yfkIB3+Dbl1/
	 Bzi/OzIe4cD8YFxCp5CdL9EkzZnkPXYZfLTAN6rTQrR6ypyi0ndmGrxOFIs3ykCxLta65
	 JBkTmbB9fXSc8I4g5aWcSkv/JiKpMLP5CwNkaibE7KG7sBHub1MWfCn/zjDiGCum/3jt/
	 DgaKmOmGz6o3aAdLm00EfCxeCYgqIrvP+R4hOLedbhZ0kMjkqDd7Or9FAbO/sSgR6Vuic
	 4CXi/HgsZ9/EaoYQyE5AMAGrREM2s6Q4HeB6B8Dmefl4+G/1SDg4YlL7jh7As8hfnFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722270;
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
	bh=NMm/Gnblg6Vn9CTPdG+TBG+iwUUlO0AC0wZvlPXcD4o=;
	b=y8DUxQPudp3hFo74RwVk7blyfXUXHd+6K4odYZFzjAORecHs2q9E03PQV952CGrcXyJr
	 /QXsyQyENRgWOBtV+ztSy6FLEGLDa9xt2ehMSgcio4/MmQZYdib0fq+nAmtVsBetX3C8l
	 ctQQhQNPe9VJIcYf1OJLfu3OI7sXk+K+COdrpyMYIoNGfGDtOC9mvVd5eTlTOY1rjEpI6
	 rcKWLmro5tn5fuXMk7rFPkrLgV3EbwQ/WsvTVucub2e7Xs2fmETn9O71BMjnt/g4c3vWs
	 d867C3jHWp0DFOwURToX5TI5NEZXDoFDa5qBKfULoaHVCTtNIczTQL1Km1v0/YQopFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bc0G7Xxk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.49
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D7606A333;
	Tue,  3 Nov 2026 16:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E9D7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bc0G7Xxk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irt7qghua/7OqlJlOkdMOHYwimQWqXbQoA+QsdbJbMGgyFrirU905wS/QQwjIgy3gbiiLBRi4XEIOMJiPtVAQMRVU0s5b5x2EdI63oFrApZz+8SgYMH2jhr1QeKjKhiiJl5/QjKDL17YHkFJOfZfwlt7KrsJXh/df3zEEwPr4xZxLlqccP/CEvqk6q07DArcv6CsHzfVRA7/7IyqlOdtnO3iPrqdhCqUJtMf6k9/nFShb85GKfqEjPRXnvX7NenR2wmRZf45Ybgwzsy/DwWOALBZd1PlvUzgW9jIenUlRYGvdcb+tpflIsoBJSJf5UUP5fbfgmmoGlEbpt2hV4H2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMm/Gnblg6Vn9CTPdG+TBG+iwUUlO0AC0wZvlPXcD4o=;
 b=tCEiKt4pgQppKJiV+SuYZzfZzJwzQhitjVyCXqEIQrjhlbYqYtf5crgtJxAsYIjPIrmIo8RMBfTkvuQz+EA/MLYv9fDQ3au2oLn1YEUDhNrV7wEQQbf5U8eFzfjKwvDqArgjqFumznGhVtTMqKLbwef86yEzZp1e7H0bnFcDbrRjT5FkvxVB2yPuXQ+rlT1ebntwi7aAWL+WrI4u1Nh2W4kqhACH66V9wcup/sjEPne2G2BeCZDHsAN0TkGQP9qvEviTux9A8y2OkgeOzmw31Mzk8ihCtzvCAF+oI8xvM7MceLK4EUtJLE6B9tTGA9oj3goMsB2VpVoAxyzGuIISNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMm/Gnblg6Vn9CTPdG+TBG+iwUUlO0AC0wZvlPXcD4o=;
 b=bc0G7XxkX0aUNHZv/ZsseZQ1zf8KotkNjRYzK4/GzMyqI29yX3IL949KhBjmJ5NP2BxB4CLrIF3UQJfn+UFhtyUoFZ4XV8AdfTY6tJAQjv++CPKw+mTn5Ny+0qhlmPtQqlDHbMO6aa4lKNUn3oFXrgdv8wMvZp9F1BP2thW73VFQ1gRiaXFYfUVNz+WP7SbbWRat3EOCF8TnbPZBnnAfi2FKnvyumlniuVXvCRTbmrx56SB7jDqO6pZPBaziLFTxxCqHjT0ByfHBwj+jxa3qj51zFkMTK+cxtXN3jNvGsqCb1t8cU501LGP7bUbnfuDv4CpYkJrWYKYl+O2hsYK3eA==
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by SAWPR12MB999315.namprd12.prod.outlook.com (2603:10b6:806:560::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 16:11:06 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::2) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 16:11:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 16:11:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 08:10:41 -0800
Received: from [10.191.53.38] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 08:10:38 -0800
Message-ID: <1acc56d9-3df1-4a79-a961-85ce607104c1@nvidia.com>
Date: Tue, 3 Nov 2026 17:10:35 +0100
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
Subject: Re: [PATCH] block: keep flush error across tag iterator reference
 drops
To: Christoph Hellwig <hch@infradead.org>
CC: <axboe@kernel.dk>, <tom.leiming@gmail.com>, <yuyufen@huawei.com>,
	<bob.liu@oracle.com>, <yebin@huaweicloud.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261020190426.1073318-1-nirmoyd@nvidia.com>
 <aumwXVXRiqqV-IS7@infradead.org>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <aumwXVXRiqqV-IS7@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SAWPR12MB999315:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf3e1ed-aa0c-4453-866f-08df39c5108f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|22082099003|18002099003|13003099007|56012099006|11063799006|4143699003|261026140227099003|261009223327099003|261022105027099003|261022075727099003|261009223027099003|261009221227099003|261009221727099003|261009220027099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	fE/rctAfPlm4BXhC8OLlrhhUlE0HajdrzJa6ZR5J5eQFOnc1EAIDey6FuyzGWzcoXTO9amN5m0mXpjirkvMp2U4m/olFVFlzT0kCvcVIMn3abzNYA5Fysn3+Ee4YM/6h9I4FWDVmDGxwdCk5JsaB6+sO+cLkFsVq4l/mZYvCgA5LAShMTXFCXLMFqqbdMRZCUeGWDOGV0FOk3WS2hIMaiDp4FkhYY+FPypkOFEAR6IqYF2mbyKLWs32+SbFchb2v3XpZ8hir2L6c/zHGRgSiBZcLNC32/QkSHTwaejHP6hPfDOgCRLQEHnYgjB94AWeEyJKqVgDYSyE5WsPZnuazVK9Z/Eoooh3HprkmcbAcUW8gG+Lw/dVqobudXtYsn/B0odATuRsDAZI3zGqaYjETQj2oS2NqYW2yV8Pf5q/MxrV5dzublr+0fkz8F4axS7uJiHb3BHucBM2zJ1CaDDnbTnjCDA3WmWUNQgz5oDXiFBa1vwE6bgVnEYLS4oCAHUWIFAZcSn5gmw69TQ3X+jjkTkjTJfxcrnEf5q8/Z66dV8jg+fYQFhvyb09BLcv+VyNHenqoSxONVohJYKuYEprt43XJfF6us7PFrf4huZfDDM0Y/AyVlPKSGvMIsZv0uGhAFFCt/XO9YOTJQ/a+drczZzZ4JhDLrvVRFS+6CFPARWQ36sW1iJshlbt0TheARb4UFlskZayvLdLHeyGGW3t3NA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(4143699003)(261026140227099003)(261009223327099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003)(261021123027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PnG4dyEuhdeIqJS/Udb1LVjIjIRhrJPfTy0jGN4rr3YUaTRJ1ExYsW/bPcyeT6q55CYerusCpav+tea8nPRXSWBHbpuls9had1GPTmmv06qz40d4MAWcu+pldC/2I8uWxYT18u5Ya10939sfxAH/rwXSNcJO6yNng/8z8A8sAPOFz791J0K4r0+jJsPHRJ3hAFoTT+OXl5G8D+6cac/dAgvQAOVZnWeUNJ4pUpCJl84YLYYh4GdmL38mmrxHyP/VoamOZsVZ2CYcL2jMoMK/QXUpyFJ1n42toCe8sM9XzUpwoDAKfwjYqR6fCQQ7jSFH0xctlf/4S2EFpiQObkH/vWSwp64mPL2EmFIBdKaoBL99og7IcXpa72pvU+1kHHVio9SGlhBtpBmocUAYMq7Ff2aNwz9nEJhYry6m9+NymKbJhAgL/aTCxnf0cKj7zwZ7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:11:05.7829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf3e1ed-aa0c-4453-866f-08df39c5108f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999315


On 03.11.26 10:58, Christoph Hellwig wrote:
> Looks good.  Bu I guess Jens already picked up the AI-Version of
> this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=67c43ceaa29e9b904216651697adf20445b219fc
>
> Sorry for not catchign yours earlier.
No worries.
>
> On Tue, Oct 20, 2026 at 12:04:26PM -0700, Nirmoy Das wrote:
>> Reproduced on v7.3 in an x86 QEMU guest with scsi_debug, failing every
>> SYNCHRONIZE CACHE through its debugfs error injection while 16
>> processes read /sys/block/sda/inflight:
>>
>>    modprobe scsi_debug dev_size_mb=64 ndelay=100000
>>    echo "2 1 0x35 0x00 0x00 0x02 0x04 0x44 0x00" > \
>>        /sys/kernel/debug/scsi_debug/<h:c:t:l>/error
>>
>> fsync() returned 0 for 35 of 18000 calls on /dev/sda and for 46 of 18000
>> calls on a file on ext4 without a journal, over six runs. With this
>> change every call failed.
> Can you add this to blktests?


I will send a PR https://github.com/linux-blktests/blktests


Regards,

Nirmoy

