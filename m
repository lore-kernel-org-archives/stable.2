Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E92E737E;
	Sat,  8 Aug 2026 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786189137; cv=fail; b=ZwUaY5jxA1Ao1vLJ6Aa3l7OH7XRRzKhAKRAMXquCBb5mHkrIBb7PUFsoVgyHqv98uo+1kmshrNZzfrUDgrOPupdM9jayuauISPomKdJMvOkvcz4GTrjgclLOvlrn0eInAd2LCENQrfTN7tqE2VfvBSBKm47vNgzqbgpvCyl8CZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786189137; c=relaxed/simple;
	bh=RvoE9GzHXDux3ePEukdH1382DnuzVHL0wUflTD0P+9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mxf6SPMZuJegi2upRQsEE6lHK02Gudb09gVmz6MyK1RmGSFEkDxrnIn0/ubpj9Zhf0yoO7M2Nj/PPcQbDWS7Dzq4lIAAfiLxZy7Li1HHnZx0yQ4zqX7HplDr/5+bbLiislaT7cOtUb1KgXcMmkFacb/jrmrn4V46Xzae/pTUKdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fKb8gy0K; arc=fail smtp.client-ip=52.101.53.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fKb8gy0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrHteUvia+oXEMTci2E0zKF+dUlnibDkk1hhuOfQi85TxfrODnnsF91pA28PiMtRcVX6ePK/5bReZtzPjC6h0kQDx+DCTZI6VBoHDKiCpk8JTKQwqkDksftsc8jhJdizlpJm0CmkPBmjQGtZB8NZHnAdVGdmCpwib3P7dHnosXos7L+ONVKzsF/g+zV1eoSEawv1PV4Gul0iE8Neg4bg7ZfkUoMFXxWCy5o6AamXttMyBW2bhjPHRQemLild9+4UyZu+Lxkp8bbBQ4oAI2L/z9vvb7uOytOPLKKht/PkSw+IYevfmtg4RmfC+LxBlXr6OsHROHkgt769OLsxXRe9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcfKNqkJKg6hMOnsvuHbq/ivpyM7OZ0QTNK5Ofo8Cko=;
 b=zEwblP45JJ2FdL8pUjhYlGX0YXDDTlMq6m8pWd+AkfhYkx7b5w79jBgl0GGrlgl4tMZU+aqXAyXfOTw66ySrbwCaxCN7DrDtDtr5Jb6q1UAH7Dkqhtcww3he/ovK/oJ8tLtOwS4AyDNsVmtKcAah1FY03wRNn8hrrVb3bTpgDoDKGh/g00hLYxDGbpXfB+HOEK2dd1HjPG3l/AwF2C5+aZ0sIxd0pFCPjP5HL/xTdWO890HuZoKTjhfSmHP7Xa7MS56ARh+IrXvddkZihVwRAGm1ztRu9nVXmvaOdt5KCpykS7rnXcw8CWDzas/N0xn7gutXpsJy/zHUVpbLonRbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcfKNqkJKg6hMOnsvuHbq/ivpyM7OZ0QTNK5Ofo8Cko=;
 b=fKb8gy0KfR61fjGTwUZj2h/Hm0+wugapgS/Tjzysa6kBR0VIfuYZ76QPRyYw41hTFTeNsTLZ1P278IRzItAGw49jyIVqcdPmdj4mH8byskFbz06tw875tKCOV/ewpXJEjMZz9cirOko6FMk6JgdpEsV6sq5Pm3G0G7ZkykeBlIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Sat, 8 Aug
 2026 11:38:51 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 11:38:51 +0000
Message-ID: <262b3d37-84d1-44b0-8626-c3184fd70021@amd.com>
Date: Sat, 8 Aug 2026 17:08:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: tipd: fix uninitialized typec_partner_desc
 on stack
To: Greg KH <gregkh@linuxfoundation.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com, stable@vger.kernel.org
References: <20260807174659.3720863-1-radhey.shyam.pandey@amd.com>
 <2026080849-quench-earwig-f998@gregkh>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <2026080849-quench-earwig-f998@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B3.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::5) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: d30e1c35-c32f-4014-dbd6-08def5419e44
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|56012099006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	950kGAOiOhl6Ut1f+qSOavnvdZHFHT7rRNf7TVMmJGDXU6gDATsyv8jsRTsohNhfalsFg1ihspqwZM3GcLtNSUMXQtxLD1sTez6nfFNm0kYeuktUUQEypqOxijQCElZBWUbAUll/96G1c9t/QNMzhgY2kHGzHWxQv5LmmNCK7rS5+WlXavi1SLlpu8E64GrjpQIBz+Qo5UVNntPQlRW03WXGeLNq0uhEmQVqPDWwsCjKOBBLT/I570MD+zKDDXjmFfzkVMqab/ExVf5bEXFGYcrIyLXlndGMIn2MMLncOZ67OfFiI3hIDUN/MudX0mCoMdsvtx5esVRg3YyygnSJiDu1Wu4c0u4bDIroUj8qcWNTz87MlIqt5gBM+9lMvCpCWF44OSkENnk5ZAeqBZxfNJt8K6fTDQVr2UBHo6pkmE2YIRgMlhpOM9g1J7i3drBtkfxVVycp0WUhSnV1Qd7Xn4SgUf4ei8gWGEQzWZO7xadxq4ZGA6fW+HZ0m9WWVMZEiXXa63omCtFOBp68GKeJHzSt54x9gbd0uZFe5v9VW25dk5d6vSsm3okqNd30fqCRyW0MIW/A5gg+8XP5wtIz3RhFEnc6ThihVmguEypn+qOpyIh0GLCefFfiXM36XLZwkFdqcXp9pXC54P5gBqdJoAuNVxEfMKQ4PEAA5yrFwW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDlvVld0ZnFRMGpLdG50WCtLZDE3ZHU2WHA4anhmZ2oxZ0l3WXBjd1hCVmZm?=
 =?utf-8?B?bWZkYWZrWk9OQkhmRldlNVRNVE1lZUJ6UW5zSTRrcFhpQ3hOYU9vM3ZrcSs2?=
 =?utf-8?B?TDFpUThiUHdyWTJxMkpISnlwVGRoaWxpUXR2WnZNeGtTVE56dUZWNGRhMjhV?=
 =?utf-8?B?UHZuRXhOL3I4REJJUTh4RUswNHRvVDV6czBXK1VuRnlGeGlvSHlCZ1VaTVJi?=
 =?utf-8?B?ZEVnS1FSVXdPNnlmb04xTG9RbllkRVVIRXc2WTNuT0x6cCtnZlY3eFJnN21S?=
 =?utf-8?B?V0J6ajdMdUZRZjQyNW5malNvV0h0NFpLQnVIVTRxdWtHM3VLQ1dOT08zMHMr?=
 =?utf-8?B?M2NDYU1yV2haTkFtR1NFV2RnNFhmSnFzRko2N2kzMzdGT0xHL3VxWWtBRlJp?=
 =?utf-8?B?SEw2cng4NXFIYWdxZjE2TGxVZHNhSzIyNjNUN2xUOFlrL0xXMnZ3MHdaNFNv?=
 =?utf-8?B?SGkwcnVnclNZS1dVTGxOZjhHYlQ1bmpIcVYxcWJRUFhyYXFyREpGK0l2MnFy?=
 =?utf-8?B?d2hBSVFLeVBzcmxBNnU1WG5pTGo3NlhpcGpicnBLSjNubWdOUVUyTk1oR0Uw?=
 =?utf-8?B?TDhHVVk2OGVwZWNueTNBWVc0aUhFNUUwMW5DYkhvcE1vVnMzUHV0WlY1NFNW?=
 =?utf-8?B?b21IS0MxcEZRekpIZEVsRmdMdy92cmJDY2lic1RGSkMwZktPM282WkVtN0Jm?=
 =?utf-8?B?eHREYTM4QTRRMko1S3B3dHRTdGg2QndGNW9sdFZWM1JMQ1pTaHpIOUt5N2JN?=
 =?utf-8?B?THpNZnJjNzJPcjB2NGl3dmxtRG1rMUxxUkZ3VUNUNnRNRG9PWC9qam9Dc2lo?=
 =?utf-8?B?dHhiOWplc3RUaWJBeWZKY1FUdlRRRVpzUzhIa0V6Zk1OclNwMWRWTEJoZ0pV?=
 =?utf-8?B?cWtPNDVmbEg2SmNTc1BtUXRidC9WNmJMNFlmbkVsTm92TWdXMlRUUnJ0MFNT?=
 =?utf-8?B?YzZ5TlZmbVUvdllhQUdpSTh4NEZwY25NdnFaWWJQNjAvZHo4RnN4NHVMZFI4?=
 =?utf-8?B?V2NmNlpScnJ1OTUxVUowSDlnUEJVS0IvN1lqY202dnlYWVBMT0NMSjJCeFll?=
 =?utf-8?B?Z3hENmpSK2VFNHp6aFRQbUo2TlpXWkdEeW5PWXhQK2xxbjlrS0tuaE9oemtE?=
 =?utf-8?B?QmR3cGk4Mlg1RmZrT0RVS1AvOXd6dDdjdmcvNWl1cVBBbjFJKzlGSlRwWlJh?=
 =?utf-8?B?T0ZFRG1SVUtzdGVMR1JudjJIVWpFcy9UeFo1S1hUc1dabnFjY2hXZXFCZ0Ry?=
 =?utf-8?B?ZnFjSUJaQ3dscVlXRHBKSUpLOFIwY3E3TkIyOTJjdzZQQmlGZ3o5YlZBNW15?=
 =?utf-8?B?UVNaY2VwR1lSY3l6UUt1ck5NVDhNcmtKeTZhb2FnRG1oemR2cWwzQTlneVoz?=
 =?utf-8?B?SVR5ZjcrZE5aa3E1Qy9rMndJNGQvcC9pYXg0MVl4WkF4R296K0NGNkgrV1JQ?=
 =?utf-8?B?czdSL2gvSkYyeUhTZEdmL2M0ZGVqQUljamttV1V1NjZSZjZRU2RGS00wNTFU?=
 =?utf-8?B?dC90b0ZnaEYzSmlCbGtQYkVVNG1LZWg1NU5EbHdpaTg1elpQSm9rZkFKNTM1?=
 =?utf-8?B?YkpNTGZSd2V3RjVkQVlnZjRpZmF0WEdLNTRVVHVSU3VJanhUU3B1aHdESEJu?=
 =?utf-8?B?aE5GamFRYzJ2cEVPSDEvUWZhUVhhOEN1K3IrY2hhTVVCUHN1SitVbER5a1B0?=
 =?utf-8?B?QkNKNmRXVGJMNlc3WDAwZlpFT04yWHRrc2V2ei9QTWQ2MCtKeE5YODJwQWJn?=
 =?utf-8?B?OE5PRHFhcFVWbkFIdXM1czcwcjlsczFvRXhEaDhTL3BxYkRXOXpja3V4b1Ay?=
 =?utf-8?B?d1NDdDNrV2ZXMVFGbjlwdnFEaERTb2U0QUY0cnpkSFpQSmJnRFl6RTExUWFF?=
 =?utf-8?B?akdKcUNmRGNOVFR3Q2xFN2NDamJlTWhwdnY5Uk9uQnlYanMxTkEzYkxqRVZR?=
 =?utf-8?B?a1VUMkI3Vkk0Y3JCZ0JDKzEzcElrTDNOcVNRNDJHcWF4dXN0dFhkbG9mQVMr?=
 =?utf-8?B?Yjl5Y3dBUkRXUyt2Z3g0Y1UxTDJlUmduSUthVWJLV0xFWnQzUGVxbXJyZmNi?=
 =?utf-8?B?bC9qdTFMVGYxTll0UngrSUVrT2g1RS8vaHR6SWpHdmFDTUtGU0dDWnc5UGNp?=
 =?utf-8?B?WEVWWEhnanJ1TmFZM0VsTWcxVmhJKzNsbFhqYU9uckJITGFkU3k2MmREMlhM?=
 =?utf-8?B?NXdpVWora1JYcWtiUlIydUxnS3VjWnkzcjg3d0N1UG5odSs3azA0UmZ6R3Jr?=
 =?utf-8?B?QVhJY3JvVnBJQnQvQXAzWEdWV2pnaUdOcEpQZ243b29SU2IvTlhyMnJ0Wjlv?=
 =?utf-8?B?V0prRUtYZDlEQ2NOUEZNeVVjSFFpRWd6NVVPWUZmSGhXdUg3VGpNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30e1c35-c32f-4014-dbd6-08def5419e44
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 11:38:51.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTnFfta8s10y5uxURdSgjJGboCjd9pm5D/gTnyHme9S0HKxQE3LG0SgXFVHDgaZt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321

On 8/8/2026 12:41 PM, Greg KH wrote:
> On Fri, Aug 07, 2026 at 11:16:58PM +0530, Radhey Shyam Pandey wrote:
>> tps6598x_connect() and cd321x_update_work() pass a stack-allocated
>> typec_partner_desc to typec_register_partner() after initializing only
>> usb_pd, accessory and identity.
>>
>> typec_register_partner() copies attach and deattach from the descriptor
>> into the partner. With those fields left unset, garbage function pointers
>> may be stored and later invoked from typec_partner_link_device() when a USB
>> device is linked to the port. Uninitialized pd_revision and usb_capability
>> similarly leak stack data through partner sysfs.
>>
>> Zero-initialize the descriptor so optional callbacks remain NULL and the
>> remaining fields are zero.
>>
>> Assisted-by: claude-mythos-preview-high
>> Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
>> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> 
> Two different commits caused this issue?  Does that mean two different
> commits should fix it?  How far back should this be backported?
> 

The two related issues are in different functions and were introduced
independently by the two commits listed in the Fixes: tags.

Since they were introduced independently, in the next version I will
split the fix into two patches, each with the appropriate Fixes: tag
and stable version marker.

Thanks,
Radhey

