Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E047ECC5;
	Thu, 13 Aug 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628445; cv=fail; b=EvTM4xJgjnTAR4v4L0xudLxizLatSY3/FqdKgEDOv7qlD+HMlDRccq9KMjYUHupNr7T7JbGX5dwPT9dzX30uC/5opEY5ppsJ4AfrX2Tob6mFwu7zwPDkGPv7NGFCVnCfra/Tn1MH1WXadnSySAomrQMxB45IeOG3DtxS7KMuadc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628445; c=relaxed/simple;
	bh=Jb/1+ZfFf1d4xyITzidV+F5+7B3eMD46kq0wl8UeKAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KmSC/KM/DKF7iZhwCnTRyeagmB6M14+ceeY6HQZB6bUr9fAn3U9QJEIyWvI2DWOagUOp56JAjqVMbUlW788ejuI7yDitewrkFpSHZfY569bvS0rJuGooK3uKYySBlYwDozUsEPFCv87hivFTajH3c7PHemvv4NlHiJ+p6umz+lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YdVpRrZ0; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YdVpRrZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VImiiqEXh0UrP64Vo0EukDk6bQXCIbmu0/nsrLs/E6YH9EZ8w8mrvEymk9z87AFnpkkhiLiVGAOpsTVUJjGaJdcSaJpPDeR4378HpjHPPgkWFEfZKmpGsK54ohUyIx1cZuDeTsHAXWmYb1nfwFDIBjJGRbhMUbwuYSBNHfvKFkW5tN8LAzLMXgJSdd/7Gv0aLs0zUzTpuD6KcSv1ZJDL43ko9YLMSaNzudHTaDRnV5Aql4V4zumY6iInGAUUD5kfpat17yQFcuRTY9/WoIvgCTMdCoZcOuw7sc7ZkNUWjSLJTXv0i0f+3Hgow09hHNriP3GOw/zeVpB5YAQUx8zXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEsZUMVqwArU3A6abPFddV94d1zqyz/jNS6lJ/UDr5I=;
 b=XMg4zNJTTiEA0dBdxxbbI6VtuoGugYW0qQwx38s9z8DltPD6M4UQk+P2sELxKL86CIgsGzXXa/0e2xaA1bcSL3t0Q3QTYidsmDB48FzWHecwQZCQgwiyfs8TpEwfXxmliT6g/BwKmoZkfpetwOxZWtnwduwVg8VsDdlFdMSlGYTRHca2qZAP8TpCHYPbEI6/EgfQIAe5r0zaWuwyBFezAq2k3d+zu3vouYL45aWU1MvuVJuSmWhsccWBlurBCifKOWrN2p31m+dFr6fcQIvzwdiZWNBd/ukxX841x757k6nOrzhNSR9dLZAub2DavweyZazxe/HSiIwcuYp8oP6ZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEsZUMVqwArU3A6abPFddV94d1zqyz/jNS6lJ/UDr5I=;
 b=YdVpRrZ0IfhtTJqe0z7vM9VkUW5beOth65mcmPIctPISL0hwF49CEA+U21Rd+0CaFBsnw9RJf1aGg9R9a96CATY9uQ4Hu6pEqeelcSzbcviGqQiRtxep1/hwukp9AjRqwfUUjjxA+wWYgLuVnW2yTDuxRqRxAuZAY/DrHrFouU0=
Received: from DS1PR05CA0007.namprd05.prod.outlook.com (2603:10b6:8:457::17)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:40:36 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:457:cafe::82) by DS1PR05CA0007.outlook.office365.com
 (2603:10b6:8:457::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Thu, 13
 Aug 2026 13:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:40:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 08:40:35 -0500
Received: from [172.20.244.139] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 08:40:34 -0500
Message-ID: <a57bdf5f-c9a5-4417-9d8b-d84cd29238b4@amd.com>
Date: Thu, 13 Aug 2026 09:40:33 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/amd_node: Remove smn_exclusive
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, Penny Zheng
	<penny.zheng@amd.com>, <stable@vger.kernel.org>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-2-jason.andryuk@amd.com>
 <20260810140747.GB57095@yaz-khff2.amd.com>
 <20260812192805.GBanzJRTgkrti3Bm7F@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260812192805.GBanzJRTgkrti3Bm7F@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e568aa8-26e9-4f77-b6f4-08def9407440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Knp3B2l0H3kAkuzijDkHJE0YTTtW4wZs/eB9JLite9/GqU8bLVmfs1Yw4lMVbe/056jMCVcjyRTcyl4XEwKIyQttf3754rNKFKOfsSNOR4o4fFhrKZhcO/pbaCpkJFvkAGWyV/D5fX3hlM0ldk5uSu4N5C8zMhJqCfRebvVJJFHQHdiJ3r+7FfXVs1fUQXvgp0R2ZT9vtTdjxn4yPntvUlt21p6pcE+QZciGb9KuEip3fMc+I9vjPugwqgcXxTf2yf/Ta0gykWq/K+OftyGWSWSVILUZFDFQjj44lXjhZWV0vX7Os5Z4lBS0ejQydXvf5wOg0adYHhk/Z6uJ7yRgeMHi4XHsGmFTw3nDfQnCE5oYTnCeo3znUH9+hIdW1SdAGXbdgXgqr2cmZdHMwervJl3APMy357JQxtbPHuNdPxEzftHk0rFXaxYP6fksFiGpwwIwgSqQuavtR/aodpa2d6HFHZRxMRzVhNT1tTEPwrxfrhdu0mVC+UNlk8DY/JasqVZwGYQhmsbO7xPFK+AICeNbkVN9fVtPeE+6pVAFM4+x6h9kvIIdrnZmbgeESGqnlrzVbdZ7nTuydYmP/7YvfXauqD1Ah6ulDPOkoe8ePtdxJkgWk0Zv3CIVSMoCPJeshxFBkEIgn3oTryJF1bhiuSNKdkmJ2O1TulAAbpi/wVPFnH21MgbEnmEWTSa2Recducdais5Cx6A8oqxyZS9y2g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9Xb7xjKkf1vggqs/98Os7UjCH4nPpc9tROSGdzW94lfO4d/WX9TJCEE2eo3j3GmQn/uMjmnmhc2fyrsUhh9jup0dsHxD21zxxwKwjYY1MwTJWG6P8XkjFM7JkwEtgflG6Cg+phrbVVkVbogSxaMEEqiQa4Xn58MP7PfjqF4OcyPGR5B/bPMmWinN3npV2hIkh/rp+8nrk+pxcM1K/9diprJ732Cgm8Un+2P029ZxFMzAjcDMlkH1ShxWDt1njPZVL2Z92jP8wABkQl1iJ0kzAYGesMu4EJu5PB10IS0LY8UcDu1VKjxPqlr/3fOw6OaO4eO79KYHAMxvHgHMFz9etAdwtRXapJmy5bkRtXbBiSewxk5qoZu9Ay/reJnfqdqbPRk2Mm55WdH0IoDV1PAQr0xgJKQ4e99X5spbw/O6wSnfEHzzO67HPu/HttIorQs2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:40:35.6031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e568aa8-26e9-4f77-b6f4-08def9407440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

On 2026-08-12 15:28, Borislav Petkov wrote:
> On Mon, Aug 10, 2026 at 10:07:47AM -0400, Yazen Ghannam wrote:
>> 'smn_exclusive' wasn't originally intended to be used for bounds
>> checking the array. But the original use is no longer needed, so it can
>> be removed.
> 
> Why is it no longer needed? Apparently I didn't get that memo yet...
> 
> 83518453074d ("x86/amd_node: Add SMN offsets to exclusive region access") is
> talking about the potential concurrent access. Why is that ok now all of
> a sudden?
83518453074d set smn_exclusive after successfully calling 
pci_request_config_region_exclusive().  smn_exclusive gated access in 
__amd_smn_rw().

Things moved around, and now pci_request_config_region_exclusive() is 
called earlier.  At the end of amd_smn_init(), either amd_roots == NULL 
and smn_exclusive == false or amd_roots != NULL and smn_exclusive == 
true.  smn_exclusive is redundant, and amd_roots can just be used directly.

Regards,
Jason
