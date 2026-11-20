Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204741;
	b=1rrq9ZdjDYJnTNwD0TpfHl0gasxuVO0iIf139+72DM0/tBglt8Api/akhsOe4Ak1nOwW
	 EfuUXAyoMipjw/Z8tKeyQ2XCnfMP+ly9ci6+G9xx/34S2SkGGcITJnsdTzZeJ6hEYrCtA
	 3/IP/4BtC54sGDCdwrS1gYf1+5K8lFnJAZ/Mw7KcvNcOsax8hgL2G7udAUFbWewxMZgwt
	 CBlj4x0L7E/lqREDNcaUXr6bCqzbzs72Ls3ufiMQKI0BPW1q9NGvbTG/8YAf7uWkF+6Ae
	 RlKxC4SI1TYThBET2sKV7G51Db19qc1yo3WJZUcKOvRk8xjmt9y5mCpohHSbjT0ns/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204741;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Y2JPz8PyNKP1HZJJ7Cy7AnVS9uekkiup9Il/843eWMc=;
	b=bDKs5yZXLuVZHp78A1JoJ7E3yNXhGhNmD4V4jwTjKYw/5cpppiRqNL9CHLGkQpf5bG7l
	 ROMktdvN3wdpxfpZIWYkIqIiJ6BnHzJM1YSRkDs4SgqLLH/7C0gE1/mlW8RpAI4ceC06w
	 DthESE5UYPkY5J6nt6avbeGyZPJlHgpPedwA/+F7y/VCkNd+BUrH2vDpN3LyouDQ6jnFS
	 u6QjhlrPwgTNkMMpU1zUncPCOeIPHbwgWf1/99hcb4LIiq6b8FA0b5zIg2QKGDkplPugj
	 ocaCp2PGnqvNjy1m5FwTwLE/b9N6n5fAXqHuxuNO68x4bpDAwfd0DGNrfaQndpXZjcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NVZQsBLk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.38
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B09606A6E5;
	Fri, 20 Nov 2026 19:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B09606A6E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NVZQsBLk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xu4XiIiaORLMm5DkVdVaUf8XaqzkZHpRRygS2d/HBbp/HoxkPKmNbd+xoTWrXl6WGtT9E9IfKldZ6u5kb/M5SNldfiDWs98Ob7+NaXYQK2TEmAckY/zH3a96r1gpwG5hLJlHDrjwlGd83VkbBI0fR7t7bJlonIz0TMc8G8wB0NuRS4nDYgzfPaKxwMdDZaRjKyyK9/+9n70O8/HzfuEu71JpdZ7J8XC93L6Ak10gyWzki+uVIz4sEcAHgiqtK30dru7It5JbH0/US00hbO0DO5GcVEYlt17TK4jms8TVQr1d66jyc1N5IxYtLPLpVLdIr69jOSafj5HOuTb5FJ0NVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2JPz8PyNKP1HZJJ7Cy7AnVS9uekkiup9Il/843eWMc=;
 b=x6qovCuMgdrL4HPYpeHWJl2S+TwbnRnfal19os/k7FnQ15qZCWanPdCo910yQGcIuzHFSR9F6kjDJpilzZEz8DR58yrkr4y7ylgR819qiops2NCldA21937upzQRh8mwY6U8SOsYyxFE/iTwvEhPYmjC4rezfUhbti15qYjifSZzlj7X186e7tsqkjD3jufj09kdmwKV3aLgHhRfDkzzdAJylsjstoFO0o8CZc0dvC3iFb2k9To2XadU61WasM5R2H8qsZKjQvOqiePDatL6LR2JqIzkFEytmvAImUfP51BEega3HIrlpEDl5gWh0ODYY/YrzwL4nv5SNwgTZgWDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2JPz8PyNKP1HZJJ7Cy7AnVS9uekkiup9Il/843eWMc=;
 b=NVZQsBLkTvs1NEm/CdrcNMJFTm1pJIT50OdYA32FteU5TJaSMreHkAuCmMF2v+hOv10l5Q90kzNUo6I+PXVOmA0T/A7n2/OFr2PHp1xS7UKBH7fcVu40v19Aw2GiTPk5RBOor/JhwfSf0BLy38lzrHw3tnJAGVMBVg8MQSPGLGE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 19:58:44 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%7]) with mapi id 15.21.0615.009; Fri, 20 Nov 2026
 19:58:44 +0000
Message-ID: <41a95b7e-9690-44be-9960-08f959081a13@amd.com>
Date: Fri, 20 Nov 2026 11:58:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] ionic: limit TSO segments to the minimum Tx
 ring size
To: "Nikhil P. Rao" <nikhil.rao@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Breno Leitao <leitao@debian.org>, Eric Joyner <eric.joyner@amd.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>, stable@vger.kernel.org
References: <20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5@amd.com>
 <20261117-b4-ionic-tso-max-segs-v2-2-f9792566c5d5@amd.com>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20261117-b4-ionic-tso-max-segs-v2-2-f9792566c5d5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
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
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0438d6-6553-43b0-2a5a-08df4740ae6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|56012099006|261022075727099003|4143699003|261021135927099003|261026140227099003|261102123227099003|261021121427099003|261021123027099003|261022105027099003|261028144727099003|261026121527099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	zlvAgqZ0Az8kGa9tzpd0jKpY9Vz3iAvXCS5lUllynzC09d1wU3aKlezZmusdMWzp+MevWApKuWudVLKgiSaTjs4HIWPh8uQlpNJWBwRpyVpl/88UFO7G5ROCaMd4DZ2H66nPNTKtDgHK1/9T0OntBOQjLUx1OmbBALCPFDAFPQET/0SuAuDUIlNw0nELlVzBkDXFFwgGJg2P4oI78xCmx0Iszbjwk60LGG8Uf82YIGpu5rRlgCQDht7s8yOz+kc4v4+U4Q9vD+2usx3KsIr1ozlvBMvdc/a6KqFZbUuOufBlrffO9HHl4zEv6gCsJGVHeBlyqmCboK5Z9BCmkg4JoFhB3my+qh6xaV7lnRr+GQSfvk08DoL8pGXV2SitoAsf6R+AwPmX7jOKpGZC5vdny6TRvPTDj78Y5/rLZJTJQjm20NdkGGppXLbVHZu2hlHnYf4y/Qn4+R7rJgI8m0lhScTqy0qYgbRNPh4MdkxIpliLzlD3N/lOzPnFnvH2kTksaYQtlSDcqt93SSByuke2qvMi40I2XSl4Z46fYkfrP2Vmm2yZF03DGjC+ST+3pZ8VImbM+Otywuzx2gR/DlP/yW1fh9EIxo1j5c2xpFwvlDGk0FOA/GtTAQ7mBN1c2j30
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(56012099006)(261022075727099003)(4143699003)(261021135927099003)(261026140227099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003)(261026121527099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2xxRFpiWTN3KzA2TG94amgrS1d6OUhTbDRjaVh6UnVJbWNka1FFNFRZQ3RX?=
 =?utf-8?B?MUtNZHVYZThHSEo2M3lsVDdJekpCM3FRdkVGQUFJZEttT09NTUM0NTQweGVH?=
 =?utf-8?B?UEszZGgyWXp6aWNleE4rVnl4ditwNUgzMkM5ajV6Sit2WVhtYzNTWXhTa0l0?=
 =?utf-8?B?YkxBT0Z3YlNnemttd2Q2ZEFFZG84RlBsRHNIT2RaU3V2UVExbGZRU2dZRTZy?=
 =?utf-8?B?ZGVWUWFYczFLZGtER25aM3RMY2k1Mjd4anB5WWtGTllWdWJNMWphUEl0Zmht?=
 =?utf-8?B?cW5HcWxhSktEOGNOVjdjTmxJNGZ6UjhZVzJwTGs1UVpXRGZSeVFLNjRNUlRI?=
 =?utf-8?B?UFJDWVlDT0FTS3N4bUtIbjZFQ3hzM293WU5nM1FNSHczbUF0TUYySVFrTStD?=
 =?utf-8?B?aDNtS0c3WXRuSEdiN00yZmthU3plV0lhNXNjb3VMTGdWTkJXRGhBVnFKN0cv?=
 =?utf-8?B?RFpsVS9DMHFXWTZmbzI5QW5iSGdLR2JBcGdHUkF4dy9UMFJibXFRRmtjQkR5?=
 =?utf-8?B?dG44RkJUOXZ4NWJtUXFrM3BwK2dWVDlCbmc4RGhTSlpVVjFlOVRrMDdQZWlD?=
 =?utf-8?B?S21GMkw3emdtTXp1a251T1FYTndiQjNHcVBIeXJoS0ZHQzlJdlBiQXQyTGJ6?=
 =?utf-8?B?OGU1NkRkSjZsTHByTi9oTmhwT01FTDZOOW94cWhUaFgzUmhoekh2d1dOenhP?=
 =?utf-8?B?L05PbWFBM294bEg2UG1rc0ozNml6bWZ1bk41anZYbTZKdjlVbkladXJ3U0Nu?=
 =?utf-8?B?ZWQ0OThxSjN5bVkyQmlyeGR0ejY0RVAwVzl5ZWVhMTBRMXp0bDRPdUVuUmlH?=
 =?utf-8?B?K05KNitBZFFPazZpRmw1WUNLeWhMSllDcFVpNGNJWTh5a3k1ZmwyZnR6KzNV?=
 =?utf-8?B?U3VxUVhnL2NQOE1Mck5TRWhUMTJQYkpWMS8yb1I3ZGJlTURwTm1STG9qUUxq?=
 =?utf-8?B?NG9pYWk0TFQyNHUwR3Fhc3hJQ20rbUJqMTFiM2NyUzN4V2RvMERYQVM0RUhN?=
 =?utf-8?B?V3BYM3RaNjN5dk9OVXJldWpwVXRNcHNlSWhQT3ZacnBqK2RlWWlKdGdISjlG?=
 =?utf-8?B?a3diaVVYWERLMndXWEkwaElyVVBMamN5YnNhWkYzd0FOY2NFUEYzOTRlY3VS?=
 =?utf-8?B?K3R0NVErYXJNYUtGb3FLbkgyekduZXhWdXRyc1lSZU1RMmRFa1NFQTlkWWpM?=
 =?utf-8?B?MFBXQjltWEdOc3dsT1hKV3Q2dndVc2pZSmdLb01kc1VSNm93bEJpME1QN0hw?=
 =?utf-8?B?MENMTzdUWldCYmxkdnJNQXVEcmd3Nm05NnprOXhKS1gxM3JveEUybnZKcTZU?=
 =?utf-8?B?YTBaODFIUlpDY0FiTzFMbFAvRnJoTW84UEtJMDgxNkVZN0plODM2VUVPd1pq?=
 =?utf-8?B?UnJWaytnOXVpWm4yRU4xclMrQkpyb3c3eWNMVFU0cDZKYUxnOFpDZjA4NGZO?=
 =?utf-8?B?bW4zSjA5Q1NhNHAxSmI1dmRMRTQ3YWxycUxJc3JscURIVnNjaVZyanBFYWs1?=
 =?utf-8?B?OUUwK3g3VHhFWE15czNLQzNRVEFNaGZUMmxlRHY1dEhCdGpJQTllaUo3M3Ey?=
 =?utf-8?B?NUMyNmZYVVRWUm9XR0JmclB0eXV2QU9Db1FPWnlRcnBOUGRXdlhYZnJVWith?=
 =?utf-8?B?Q0FqNDFYK1dWQ3BjS2t6Y3M4UW1uWUtyMUt2U1F0VHRnN2tiaXN5ZEZYZ0lI?=
 =?utf-8?B?TldWc2V6ZXhGUmJ6THk2bk1oYVNRWFZZWEdCSXJjNDNILytqcWZVcmx3TERw?=
 =?utf-8?B?YVlmcDFBWktoaFNyVVFBbEdNRm9Vc2pPZndTRmZNb1hJbW5sNyt0dG9FaVFj?=
 =?utf-8?B?Nmd4QThWbkpCcXRtZ1VOSXVPalZJamgwckRRSnZFL2NNeG1ydTJkelZWZXJi?=
 =?utf-8?B?akw5UnZrQ3FGZGxGTzdQRUJHMTNyY0svVlRyY29zQlArK0xFZTNFbVVRRGxY?=
 =?utf-8?B?MWsxKytmbS84amtCdnJBR2RSb0lnOHczdkxQQjVEUngxS1psRExmbitxcGlJ?=
 =?utf-8?B?QW14MCtHMkE0UzB3T3BDWHdVcVowZi94a3I5L3k3ZmJEUzZiSjhjb3Q0Q2hH?=
 =?utf-8?B?TkNFczdta09Jd2pUYlJTSzA2UjVpQnJYUmw0SFFMaW4wRDFpb2NrWjVzN3lW?=
 =?utf-8?B?NTI1dGQwWG9ubHptTWJLdS81bEpOMHo0Tk9WOWVUQ2FZT2dSTHc3UlRhOGpR?=
 =?utf-8?B?V0pVemxBdVVTTUN2TDBNMkQzMVIydG9CS3BKZkJMaTU5S1E0YjZ1VHZFK2Q5?=
 =?utf-8?B?WHBzVC93a0FCbG1COGFZWWJNTU9xekZHUzdvYnYzaW51eWExeDZ4VWZobWIz?=
 =?utf-8?B?cnpUQnc2MWNaSlZIUTFKY2F4eXh6VTN6OEhmRmJ1SGZHTlpTUnF3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0438d6-6553-43b0-2a5a-08df4740ae6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:58:44.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCLvONmiLbgHAAlwdSetIpmzNJlTeCapiZn3KQmCkvwRwsySTjD0cZTUcLaPWZHCiGmUyno6Cza2Ouh90kK2ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611

On 11/17/2026 11:18 AM, Nikhil P. Rao wrote:
> ionic uses one Tx descriptor per TSO segment, and a Tx ring holds at
> most num_descs - 1 of them. The driver does not set tso_max_segs, so
> the stack can hand it GSO skbs with more segments than the Tx ring
> can hold. ionic_tx() then stops the queue waiting for descriptors
> that can never become free, and the netdev watchdog fires repeatedly.
> 
> This was hit in production: guest TCP traffic with an MSS below 64
> produced 64 KB GSO skbs on the default 1024-entry ring.
> 
> Raise the minimum Tx ring size to IONIC_MIN_TX_DESC (128), for the
> hwstamp and kdump Tx rings as well, and set tso_max_segs to
> IONIC_MIN_TX_DESC - 1 so that every Tx ring can hold the largest TSO
> skb. Larger GSO skbs are segmented in software. 127 segments still
> covers a 64 KB skb at the 536 byte default MSS.
> 
> IONIC_MIN_TXRX_DESC now only applies to Rx, so rename it to
> IONIC_MIN_RX_DESC.
> 
> Tested on an AMD Pensando NIC with GSO frames of about 1500 segments,
> injected through a tap with a virtio-net header and redirected to the
> ionic netdev with tc mirred: without this patch the Tx queue stalls and
> the watchdog fires, and with it they are sent.
> 
> Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/all/20261112082753.6ee90fc8@kernel.org/
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_dev.h     |  3 ++-
>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c |  4 ++--
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 10 ++++++----
>   3 files changed, 10 insertions(+), 7 deletions(-)
> 
[...]
A note for the stable backport: on kernels before v6.19 this patch alone
does not stop the stall for guest traffic. A guest's GSO skb arrives as
SKB_GSO_DODGY with gso_segs still 0, so gso_features_check() never sees
it exceed gso_max_segs. That is the production case here: guest TCP
forwarded through the host to an ionic VF. be1b70ab21cb ("net: init
shinfo->gso_segs from qdisc_pkt_len_init()") fills in gso_segs before
that check.

Tested on v6.8 with an AMD Pensando NIC, using the same tap + tc mirred
injection: with this series alone the Tx queue still stalls; with
be1b70ab21cb added (a one-line backport there) the frames are sent.

So the stable tag on this patch should have been:

Cc: stable@vger.kernel.org # 6.18.x and older: be1b70ab21cb: net: init 
shinfo->gso_segs from qdisc_pkt_len_init()

