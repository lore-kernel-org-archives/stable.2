Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0833A640C;
	Thu, 13 Aug 2026 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613119; cv=fail; b=OiZb4h9G61gH10qwNXWBbCl8nYtKNFxXx19HCw9V6GzgwKb+8XfUHzwhNBwICWpAGSEdJSU+h1Yhm2iQPLzXDw0nSwG/f/y3j6MTsUu24pR23nUnWIsH9jzyW5X6GqcGVbwCC02hlMXsE67/E4R0Qn2gBRn/YAkqglq2o6ys61M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613119; c=relaxed/simple;
	bh=3LYpj8hTiTKF4YMt52sO3dsujXe62IJRTrga2Ari7oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hoBfqFmrxfuKFdFOlTiyTas685UGlVKVGJgz6krqJF70iwEThQyEgtBn6goNtJgJrbpggQfEZGRRzh3nYqxtx0EOmNeie3tSwcqtcnKktpL07blF3mzYJL0lkdvtEh7eN1TggHk7XOH7A/OSL81PDQWl+yjq3IgyWhhhm3ed1l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yddYWpJE; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yddYWpJE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3Sq2mlF2EkascNZqKoH7qLJId9qcqiWmg09XZc58+Qs45v+8lC2O5sxqRR2Exzu9h0Hdn0wcrnMEf//mGEVKMysPoKObqxReP3JTWU1jTbJ2Xbvh4vpM4vB7otWbazRP3vv77/LDrxO5pxKeOLyvAfXe5oCblnZGIxORE7la6jv81BleMbLsaNXmLWdcBlRsUHPN5PDL/u592peyp2MW68OHo0//onUtdAOmngKRjachz4iolfXEIr18sRwa6Ekm7b1crxt3ZRyn/FmXrd6B72Vc4cj/hvYAckm/JKmLKTyupNoXmpQcuIdUCOTcaUCMKy7Re7pmpla1qDW1QyIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VtfE/EzHGMMaXxfquFSlZ5GT8zZhkbySdBJ/E4OflE=;
 b=g1fm9Ww01XfPgiPueD7ilyoxiZBhrzhV9FYcZIOr18M2blRbciCUEXQrJJ0ZgjP3dR2pQ7zxo+1XGwh3O9OMl4/7Y30ey3t8b2OuVs0X4L3nJLn5Gxh8zTJ7Q5e8PmT1pR0ln1Awcek47juTD2vndPXGcqmH5Bde5g9KfWhHbELyHPAHkO6pT0ZEIxy2+OlVgZP02JYyqzSAhXWWIwy1OIlzhY8wDUk1PvlzQo86bJrvVsqjTp2UIqeL7WVWr4uhLVz3TxGi49mpwBjE2K5SD/Da59pIghtOSrVE41XDJ1qAq7Whmdo7SYy52/n+ZQSLAORdzc6xezHlbOHyagX4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VtfE/EzHGMMaXxfquFSlZ5GT8zZhkbySdBJ/E4OflE=;
 b=yddYWpJEdd0d73Q2vMBfXWo6Wf4b7gQZHBhWYv9XAeKBHy0DC2QueuZJAr6gfULj9ecuj8pIurhYp3Iihl/ZPaASfqd4wxarSR5B1BZO6kclTQMneEg+6eokWerPgcbEQRTxfJ7WgNo7iZ3nGJuDYtn037JUnDs+45jPOcPdCMQ=
Received: from CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::26)
 by CH8PR12MB9789.namprd12.prod.outlook.com (2603:10b6:610:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 09:25:12 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::4) by CH0P221CA0017.outlook.office365.com
 (2603:10b6:610:11c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 09:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:25:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 04:25:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 04:25:09 -0500
Received: from [10.252.195.98] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 04:25:00 -0500
Message-ID: <b78d6e7c-b754-4872-9dce-793796a03296@amd.com>
Date: Thu, 13 Aug 2026 14:54:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
To: Mike Rapoport <rppt@kernel.org>
CC: <ljs@kernel.org>, <akpm@linux-foundation.org>, <baolu.lu@linux.intel.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>,
	<den@openvz.org>, <devnexen@gmail.com>, <hpa@zytor.com>,
	<iommu@lists.linux.dev>, <jgg@ziepe.ca>, <jgross@suse.com>,
	<jirislaby@kernel.org>, <kas@kernel.org>, <kevin.tian@intel.com>,
	<liam@infradead.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lists@steffen.cc>, <luto@kernel.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <pfalcato@suse.de>, <shakeel.butt@linux.dev>,
	<stable@vger.kernel.org>, <surenb@google.com>,
	<syzbot@syzkaller.appspotmail.com>, <tglx@kernel.org>, <toshi.kani@hpe.com>,
	<vbabka@kernel.org>, <vishal.moola@gmail.com>, <will@kernel.org>,
	<x86@kernel.org>, <bharata@amd.com>, <Ananth.Narayan@amd.com>
References: <anXvODEvV4f_Taj7@lucifer> <20260813055544.25567-1-nikunj@amd.com>
 <an2FdPPOWT50lLD4@kernel.org>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <an2FdPPOWT50lLD4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CH8PR12MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e33a5fe-d820-474d-ba81-08def91cc6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|376014|36860700016|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	jWq4uxQfVB5n1mgdRXgs2f5bN5bu+iW7LV1UZ8pB/6LF29a276bW4QT+OWzkbpRL1hENVJmlsdD/NFeuaIK+fvpc8bi7y+zo0XjXLAy3CWo/P+KhRDxTMce/X4B0RSNcdgTYEf+AiJeDzNesc/uATSTXtmHftNdW2FElMjteDFZuo1m76EVCX2rmTf4HCLUx9WhWMzJ+vtbHrM8xajEutJ48O4yIW2M7GEIgfwSKHbbD/beQ7ZjsA4ARpBGpU9zWzMRZktePfIdHG8mLgQm+mpKzyUSo8zF5yK8pa65qj7w/hDYnhIgFnbPhWW/Zt3HoMNMEv62M08tEc3MpbaB3N97EAvdhkLh6Ove+DqTbaAVF5kQjeoTjjGBNER/rtfW9wCF5hOL9hnxje87IFL3EmftTPm14wV68TUYRFOzsyo/yevNXrPsSiHCLw3oGIIs/Zj8W3CH3OuaTBvW4mHC2GDUWjUONhFzTcdAChoyJc2q2jKpPgKkJJRfPkhXpU/NJEwUl1BvvN7f3SDpkhU28o16E72RkHA4sGfBgPqjKTFYxwGsy3OOxREhH+0QsGVM5QN7X0f1b8aw5GIKUdw62AXe1ujEgfvAS9cCKYAGVZpgwnsrLwzetUPIps4nY/KANl37hHViK7tGPLcY1CN7xiypt8fQtvjCi0mSbzV1K+MCm7T3TMQ6MWP6tqlA8sNmt0zuK+9TL/u4e6veG2dM6TQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8WbSG0nf6DCeGDWZ45JvMdB+2JsNGMyIpVhA/oshoGTw1OCF0NdCum29uQB3obw6Oi9aLcuabykt4Y+s5UCBoBo+cU1Y7/5S0muN8aJstVfEig945R6AoXDiVBDqgE9tJDfo4FNerEh92J2OsiIo9y2JKgg8XQ+qA0AavP2Kbz0uJ7MFBzC6vDGokDubxBkkEBSJpBUfw9MmST+a9Lm/+V4SZrlCvV7uQXhEd2YgJrh0hYlbX4upFi7aty6xo95tc3hRhHTXJ+txPZavV/vNU5V4ZkUNSkXvs3nFANNE6kHnTT2aeHM4DdmwjIzOuEUFVz/5smrFEWfofMXpPhFrRKKKNghHAFnfIhn3hx41tP+sB4xSmqfygVb37goTYYJQFpIv3IorHBd7s/ecsk9LgU9eTdQZfC2Y1zGe+/DjCV8z6EPsL+NMGQ0vJTPYuqRz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:25:12.2837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e33a5fe-d820-474d-ba81-08def91cc6d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9789


On 8/13/2026 2:21 PM, Mike Rapoport wrote:
> On Thu, Aug 13, 2026 at 05:55:44AM +0000, Nikunj A Dadhania wrote:
>> On Fri, Aug 07, 2026 at 04:36:08PM +0100, Lorenzo Stoakes (ARM) wrote:
>>> +static void poke_vmalloc_pages_safe(struct page **pages, void *addr,
>>> +				    bool cross_page_boundary)
>>> +{
>>> +	guard(mmap_read_lock)(&init_mm);
>>> +	poke_vmalloc_pages(pages, addr, cross_page_boundary);
>>> +}
>>
>> Tested just the proposed patch from this email (without the rest of the
>> CPA fixes series) on the 512-guest concurrent boot harness (details in
> 
> For this fix to actually fix anything, the patches that add locking of
> mmap_lock to CPA are needed still.

Noted. 

Noticed that you have posted a v2, will test the full series and
respond back with results.

Regards,
Nikunj
