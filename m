Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FA4071C2;
	Fri,  5 Jun 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689100; cv=fail; b=oO0UA/KIKKrnN9vXkcjld6Zbaa//a6hvIBmnrXkI+XXcCWSzafGjFkiBxvoqz1CvkDpznqCwZ8Tbjn/765JbQxsTRHiSuV9BaLPFw8PVjO2/3BDs3c/lQJdP7gyXVb4RFipxxWoEc4oKHTVPJydBK/J7JRkdi9vZGFLqFEjWzoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689100; c=relaxed/simple;
	bh=vTj5vDqDZatZadE0CpMiJ6AAzAbLuo+qmAWnY9lal6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GS6bUB+0jfYRZx0wLAewqdxbZUxK+xlXxR2XahaGpVnWIS5pdYycb9a8tfsMN4cavI/C/C7Kp1G6/oX5FvGoTPZRxXrnV+H/8AXQg/sg/N3fLZNQasjMnZxQUjPfJP9TCWwr18R02RWZzUip0E6Jh812D/xNb3N482VNnzLlrak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LQ3XqjEE; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LQ3XqjEE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rr4pnJfdfbOyCVQBKTratt/9cIi685Eyx7i1FAWzpkU7nkKnM2I91KJdRiWk4c4Kft+Ucwxy3yK36RBnHeArraum1EAjpknT67tj1Ve8OhrvSiX4BliwX6ovZM3k7imYwWatmGI2jgZa1S0dMawVPhNRM0R4rVJdl0rOvkNnVDlE1R1hs8ZCXG+PjB2IIIhdfKacVnb4fD+wj2X8Z3gBK66XBXenydYsfoFL0Tmgok8dmZbO3N8WHjxtrjAr1chVW+kNC5ppB5N796npsc7GJVNGxrxJV9hyN1bkhOCq7QtAIVMSNs9rAT6hZzuNYg/eCA6bfYmo+3aDCICuc6WTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI3AYnxtoV3x/mWaqf73LyKoYaY0hAcB5hcTPZEso3w=;
 b=mB8rFu9ubM9y2TOVRqARZgbZ5opeJO6APpl/qGaQoW2asrM6KSzm7LwCdEBJI12hNxgKpK6fxWOqUF1nuNzRlUgMqZ+i0eJG40A7EQXYkMw7J/1VXVmd3koj9B4lIF/pwzpQ4kADyVJh2ug65TEewfJC+pRWaspCc5wA2MiSTt4nqedYFh4kv1PN4JVWpqje4OQdDEZ5DuC9vjKk4RbtZrhmPWUu7TcV5HSZ9Vqh8RQ7OniGN3BNJee6lOeK/88R8/ZfkL8kDWW8tUeq+/DABYdPg4wcKZUAf9Lm3a1rumauCxEByAo6IBQ6GMAdOPqGWAnTTAKc0GmNho5FUB5tmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI3AYnxtoV3x/mWaqf73LyKoYaY0hAcB5hcTPZEso3w=;
 b=LQ3XqjEEAzB41W+AuMM2G5CzqoPnoFSHVKYwG7LJRGXbwEp3zB2S07YNt2zqZf2W4x1dtc93rX1JBFPdWS0/WXXLLyIogaKw+t3xxrs0SYFnbtjvpMz/fVtkPAKreHrwgFwbKedM4B3vNHQTJ5fcrS4K5N1Q48LB1tqPd5W6Tbw=
Received: from MN2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:208:23e::6)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 19:51:35 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::5) by MN2PR14CA0001.outlook.office365.com
 (2603:10b6:208:23e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 19:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 19:51:34 +0000
Received: from [10.236.189.17] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 14:51:33 -0500
Message-ID: <3e43c933-54b4-4d94-af7d-de8f3e7717b4@amd.com>
Date: Fri, 5 Jun 2026 14:51:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: Fix missing port lock in cxl_dport_remove()
To: Terry Bowman <terry.bowman@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<djb@kernel.org>, <PradeepVineshReddy.Kodamati@amd.com>, <rrichter@amd.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Li Ming <ming.li@zohomail.com>,
	Tony Luck <tony.luck@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260605182014.2254410-1-terry.bowman@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260605182014.2254410-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc0cd91-643f-4f04-b5dd-08dec33bd947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	Z0MYEqRfn30i9ZeJgVOLzFUp3+f4v1ConLGISk1sw1TrXBIwCxlyDYXOCpmEjQJsojcbFusmqVO9wU7//yDW3j4p7tx6YtJE8e9h1tk4XutHeF274zt3OZYjOO9UY9MsehEqSyPXkDUTZQeJTzKQTTlYVbddwgWGKokufLFeNHOGqL/cUBjEb272LiDETWfxR5XQ4ruJC7LAMX+T50snjuVoR79c7CvkFwsEnmDEcrRzvfrc+MvkNaDVeQm+35WmCyEXNTCzewQ03bg8Xijm0hm1GNebJG78h83R0yHd0QTyKAdyQt/MJEliZKwrcYQe7SqbpmeXyg9L+edTSra+g1O3QDsWxjLonR622b5kQl44+Tt03RyE1is/CTw7kgvYprtjcatlNnFOHcCR2H/D3byJ/TjWnF9z/WRzjop+efQP/++9n06rWnfScX7TiJzkIfU8CIEuoAsTEMJ71UTWKQ/NWP2i3Fw+Fix/h3Vccu+W3tQOehs7gU0tF+fzVdYANdfAGO6DffXigr4DQaaIYX8L/Lm+Tk/zXihtpAA7Fc0IJpT+clSlVgsxlz+Q7mIjcciWj95YpUO/4XBRN8y4rWqvp8T458ydvdZWu7fOeu12BqF+pJ7EHrgUTSBW4e5xVqDgzEBqssU8fL6PfnrIzZDkQBgxgnM+aS8iIylZoD5CmTbD8gaIyo2HYJLCTbQ2R2d9OWIlGlG5EBUjnDMJRfsdzRUQQ3lvoBn9jVX0boCLeVQLPcTMoEwIP2UPONzm1XQip9CJYTVQBrjPQTh+tw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yvLePtjaBgyhFz+YzfF7XXRFys9TdvBkV4bv1vwVSu0MwDfjYPtWtHOC5vqKdaHZ/9fcmJX6Dmws4f/8b3YdRf98iJ92Mp94sCxyI7FFsOs4kiWmnuV5qGXwTQKtR01FDS2FlErYHUdGdPffZer8BaS47fDc60jmlpPzBh3mcFYk8QWeXPTG9U004fGsb1WbmWwhoz3r67z7jG1tNuwSWH3NJZrFk5m6DdS5YvzmAN121kzQnUWhNjNECxwFZw2l7O7ujr9vM/v73TnqijIRBoJ4zsuVtNxK7Y+XD7HLvhQxxhxl2ivmrJmVU+73adW8eLJFlCAgJLDwqZzttGPfNibzE9lGyOLAhD5l5vPxQTXrhgBJ+s6zyebHCgTjP/+7Gh62P9gBhjQoR6Y5zLQwH4tRzaaHacYd2srHRBTtmkmPb7955Bl3f+FRcKrCCMZ5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:51:34.8596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc0cd91-643f-4f04-b5dd-08dec33bd947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

On 6/5/2026 1:20 PM, Terry Bowman wrote:
> xa_erase() in cxl_dport_remove() runs without the port device lock,
> creating a race with any caller that does xa_load() on port->dports
> and then dereferences the returned dport pointer. A concurrent
> cxl_dport_remove() can erase and free the dport between the xa_load()
> and the caller acquiring the port lock, causing a use-after-free.
> 
> For non-root ports the port lock is already held by the caller on two
> paths:
> 
> 1. Driver unbind: devres_release_all() is called from
>    __device_release_driver() which holds port->dev.mutex.
> 
> 2. Dynamic endpoint removal: cxl_detach_ep() takes the port lock
>    before calling del_dports() -> del_dport() -> devres_release_group(),
>    which synchronously runs cxl_dport_remove().
> 
> Use cond_cxl_root_lock/unlock(), which only acquires the port lock when
> the port is a root port and the lock is therefore not already held.
> This matches the pattern used in __devm_cxl_add_dport() for the same
> reason.
> 
> Reported-by: Sashiko
> Fixes: 391785859e7e ("cxl/port: Move dport tracking to an xarray")
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

So I think this is a real bug, but I had to think about it pretty long
and hard to convince myself. The scenario I'm envisioning would be an
error occurs and the driver is force unbound while the error routine is
running. I guess it could also happen if someone does something weird
with force unbinding and rebinding the driver, but I'm not sure that's
possible.

What I guess I'm getting at is this could benefit from an example of
how this can happen in the commit log. With that:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
				> ---
>  drivers/cxl/core/port.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0c5957d1d329..80ce7c4d357c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1088,8 +1088,17 @@ static void cxl_dport_remove(void *data)
>  	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> +	/*
> +	 * For non-root ports the port lock is already held by the caller
> +	 * (driver unbind via devres_release_all(), or cxl_detach_ep() via
> +	 * devres_release_group()).  Acquiring it again unconditionally would
> +	 * deadlock.  Use cond_cxl_root_lock() which only acquires when the
> +	 * port is a root port and the lock is therefore not yet held.
> +	 */
> +	cond_cxl_root_lock(port);
>  	port->nr_dports--;
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
> +	cond_cxl_root_unlock(port);
>  	put_device(dport->dport_dev);
>  }
>  

