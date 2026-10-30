Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793370350;
	b=gx1IAg+qTv718eNpAXple6UGJOHmQkLjYy57BABHHaShuhhZEfGubbMaHP0k/9rDdiDL
	 kCQsZzWdZvxmDr5SGH4BlWUa4a1diqy8UOMGkpBMuMOnAhnFvuEyiB3hSl/iF1j/SmSrl
	 RoJ38ixNLSC/ZarhEcf3FZOS7Rn3ESPyESKkQMlMy45rwh8eYfXFLRjKP+Hcu/BVnILsd
	 mjGitdFre5s6xKINLgzXxhHyhGzUUojX6X/A3+XM1BhN7Xk6ot1tuEtVzlp6glAbBokS+
	 9kpZA8M7a7K9o+l9JdlQqtauCqVoBCc3jHxAVAHcE0OSSaZy2mOIh/6gHgsnDBDlWnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370350;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=V/UorKQgSczawXynYoJsvFuj2Kk9/4kfJlNRm3k/Pmc=;
	b=WUnplH1GkWLUAwdieUPJCUl+ISW+koahZwcdvCghHahXiqVgmSVtctvmv9CO8kUxKGhc
	 2w3iy5MAusqegmb1HOiiZBEvfjq+VCvx30lV9XCHvPw2Q8jHS+2348a9TibykMBqEJWqB
	 /ku5Un5DAOvYoKZXDtP9xUjtT4crM3KAasJOL/tSsH3zI9+WMdGYeW4eRbWiHtfYcwUzh
	 PbFcXPs6sPei7r9znOm3h1SBm2cwc32wCVq0k0kVcG9VMPoxfA1cvBgbI6I++TpYdfUDV
	 y98R4PZU/tp9Zv/9sf8JKFcrET4ssK4D+nXhA38MQjfIwn/q03eZGhlvaMQIG3gqoYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lckuUmwZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.26
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB3606A31A;
	Fri, 30 Oct 2026 14:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3EB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lckuUmwZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBOkOMggw5L0MxFZU4sPSenfbeEp1tYeCGRCPI6jrUNojs4B8qIOqwwSymmBhmdwBEMZpQfowMueitl7EcY25zLrw9k0vE++8NnxNIjAhfSExfEwK4YQxwPkp8Kh/lYAi3mD7Fv5vIEp3yYjC4fc4faY+O5k7PuFaXFE2/Td9zowH11VKh3aTeF4Z8gN72Yz/JIy4nplSqtuj17Ebwt/xPQJgQ+dAucgrj7s/+oH5gCMoMXuzaJge8rsw9FXO542aGxjgcG8sWw80EgzkjkRUvseXDp5o+gnqiAM2xLRUJLTs99aSQBuU/C+f1eG2pebql9CffG/iFz8FWosmdIShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/UorKQgSczawXynYoJsvFuj2Kk9/4kfJlNRm3k/Pmc=;
 b=LejqtM62ARQnwYI0E/WdNoFHBUykrhtS1CBg9ceYUO6ORI9XpiigCHBvtUqnMf3kgffU3eVXMQyZtdzoHQqR75F0fFziD/HVYCuzScAiuHwDE2vrlOosLjsNv4s8Hflf0kb2l5xt92rRr3zMWQcj1c+O35iTPJdzMkGsYIyaDdbIvBiMga7wc0un3vdq3J0RviDOovSFii9Y9it33dtWo7yGK5SR2q8zyqykD8QYP4SBnAcTiFk78WeHKDrm5uAxVBwi8aPFM4LfZqKU00NAvR0w6/YaMlvAcA6EIFO7wJE1usFWQ+YWXEqMkhzdqtfv/B1epFc1AXoY9ameqwdzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/UorKQgSczawXynYoJsvFuj2Kk9/4kfJlNRm3k/Pmc=;
 b=lckuUmwZL6fFIyi2bgZqOImKAeX3gv9K6VN8Nc02QNKkR3n8FKcYdV8oliq1cDm4cqcxvP8QULaMaucer0MU58hGQUagigrOyb/jQz7Gj28X2s3fOkyVrGMXw3dfW9Nd5iksxE4GoCio69DVWHW+dh9krsOkuMaIrwU0zYmTWzs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:25:46 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:25:46 +0000
Message-ID: <3bafc5fd-242d-4d94-83d4-f3b937301ed2@amd.com>
Date: Fri, 30 Oct 2026 15:25:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: xiic: don't fail a read whose data is already in the
 RX FIFO
To: siddarth@nexthop.ai, Andi Shyti <andi.shyti@kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::38) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
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
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: a63b3761-e034-4e22-f6ac-08df3691b006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261022075727099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003;
X-Microsoft-Antispam-Message-Info:
	GjNHhHHgqDohOrnZnf2R2YLWUHWiDIuGikydta4D1t9/pVTEhC/upTwpvks4CPKyeSBGcwB/LCq+507HBM4CHicv0OgWTPpyEreZX0PacUJqiIW4oUyrc0qcmIjLZ5JG2vEbxEdmcw3EJE7rG4hup0d8Snr0OT/36wr+1Xh/L8zMiUxsNcDhuzuiLmWkd8MLD7sBxTC0eQeDBoasZyetH9u/SAt+reLBYoCJbv39kdNAEj6/IpRFF/V2pbDnhT92w865rHbK2Bear2JVDxG6CMOZZR8N/PTUKE8gIKMGjMvuqyrqBAhqgZRe40oyKKewBAk9p+pJP3LL8Pqpxfp+x4/BqnsNVcgx4WDMafT/vBgwm0/+tNs7uQs7zpuagbd2rSCZhDbOJlMW3XA8LbEWWeuDTOF5fn1GdUvj2nDMKSHLAIqzfvboawxJAnJY4+7YQg0wxEyCqX4tm3GSwwfOTM4HsOmQA6AlzrDbO1v85q/DxwXt3r8TpbJimnDy6k/TwZD6D/k3ofRWaDwU7kcPH6sjItIeoDd6uMcyHX2LMwxUDv1giw3bZy83kfeLJDuLSUj6fTFsDu6MxTHp3CENHyx9HXo5fxHamTFstBtoBLNA2FBLFcpNWvKTiYZ2c4BWpmwCvdmNbAQ7ZhLPCeZZR3yu55ejPS/Z2Rx6rg7G9GQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akZVNnMwbm1pUEIvaUczRWJNN3JrYXl0RzYyd05kT0hjdlB2d2VYaTRZL0ZY?=
 =?utf-8?B?c2J6ek51b0dxaHJWMnVNSS9rY0J6czN6YzdDS0VFa2tFVHV2TDZocHhWY2xq?=
 =?utf-8?B?NDdaZmZRdTYxYzdIQlo0TnA2dUtnS1RNYnZpdWxvRE0vbGd2RXNBRGNMcU56?=
 =?utf-8?B?VW1sdUlIbkNVaFV6QmZJU1lqMFFQU3YzbHlLN1QxQ1h3NVpRNmc2UDdXODNu?=
 =?utf-8?B?RVRTR2wwdWNyUlNET2tybzhidnVreDlvN1NrTjBUdjhUcjZ2a1dLc1NSbys2?=
 =?utf-8?B?elQ1ZmlwcEtsc3EwS3cwWHE0NlE3MXBKUzQ4NEFBUnREZjlwTDREK2FJaGV1?=
 =?utf-8?B?d2U1eXNscGhwcTdsWmNyTFN1NkNrZEltL3J5N3pEb2EydTZuL3ZWeEc3N1c0?=
 =?utf-8?B?TjBCWDZ0MWRJRnRqYkxJRk02WG5MUXlkZGl0VGNacEU0UmlHVHM2Nmd2Q0cy?=
 =?utf-8?B?NU1EMUNOMFB4SXVBREhGMHNMREgzVWw4Z29Cb3FqRXJqcGh5eTVxYkhya2N1?=
 =?utf-8?B?TGc3MW81OVljekZvblRKMmlQSGRTNFcwNUY4LzREaklVUmR0Y05xT0w4YkVq?=
 =?utf-8?B?Sm5KOHl5czdlRFBSYlNuSk5EWU5UV3lhL3o2QVltemhEYXZMcU9xVjZoUVhS?=
 =?utf-8?B?TXZ5WDJGd1QvdmthcmVUNVQvL3g2VVM5STQ0dGNnSzYvZkt1UnJoSkNCTTdE?=
 =?utf-8?B?dEVacVV6REcvSU1yOENtWGk0L0ljYWE1aHlNRDJvQ0ozaGpkZ0lsU0w2MEhT?=
 =?utf-8?B?TWZocFl3MEZvcFBzbjFKNnVWWElJa3R3LzNQL3phZGlYcng0Nlp5UWxvVlhN?=
 =?utf-8?B?TEtsSGg4TnJYKzIyeHJXanRXNHhqRHg1M1VzVVBobFZ1dzVQejAvT29iTVBS?=
 =?utf-8?B?OWRWTldlTzdJTmpNcVFmL292U1czeTd0S2dOSEZtNEpJTkcwMW1MRVZ4MUlF?=
 =?utf-8?B?N1kwY2NoQjJNUmN1K2FSdWI3dUprUVNOVDNESFh3bVRNcy90Q1RMR1RSc0FS?=
 =?utf-8?B?bDREOWcxWDVXODIxamg0bEhoUDBUTEZOVXFpMDRJenk0SGgrQlVCYm9HaTFx?=
 =?utf-8?B?NnZ0MzdCZGxIMlpXZUlyd1NRaUlYTmJTbVpwN2pqNXdTMmV2S3pidUNRWnYr?=
 =?utf-8?B?VjBxZVZJWi9CR3NBWTE4R1RGa2t4OVBSakgxWTBBYittak02eitBN0h1SGlD?=
 =?utf-8?B?UTFQSWZrV3lZRTk5MUJCQitiRW9kRmF6SVQ4elJEU0FFcHFVdzZ3VDE5RHE1?=
 =?utf-8?B?Qk9YZWZsSDY2MDhFeWF1ZHgxM254VWhZMkhLV2FiZnBYLytPSndzSXhFZFFG?=
 =?utf-8?B?czY3ek0rMTA5OFBIU0wxbzBPbzQ2ZnplQmpCSDd2bFZKRVp1akx3VjVCTmYw?=
 =?utf-8?B?K2FVbUVnYmx0Y3BWZ1V3cnB4eGY3WnR0M09xRHJIZURjbllJQ3FDdWMwblZz?=
 =?utf-8?B?elA2Tk1mWE1lZ1VQcHE4VGdUT2dYVXNOQzNMREJrWnR4VTlJS2ZWcElvS29C?=
 =?utf-8?B?bitEY2Zzb1dVdmtoaXlWZXd3a3dkdm0yNHR0WmphaGVmbXlLZVFnMGFsc0NU?=
 =?utf-8?B?dU1KU0xEaHQvU3U0MFdva3JWazJ0bzlGcHMxQlFKdTNvZmJlMjNyYTJnVjBx?=
 =?utf-8?B?Sy9aeVE5SHZab1NMdkhlSmJmbi9PMEY0dGIvRjdYd3NhYzhLV0xxL2ZMQXl1?=
 =?utf-8?B?cmpCTkpHK1lUQXNFRGlJUndBcnFuSXJPMG5ia0FDbWgvUFh6dlBKSWtxVG1N?=
 =?utf-8?B?NHl3MmsrTVVGZHM4cTE4aVcxUEorZWZzV2xnU3hqTW55SENHcG5FNjVYKzBu?=
 =?utf-8?B?cjM2c3hSdnVSblhzRHlBMU9iWW12aVhvZHJTMmZOakJvSEJzdDZuS2ZPWTh5?=
 =?utf-8?B?OWJFSnkrK3p0WFJjQUJ1ZFdGR1R4S0FkR0NEVTB5Mkhna21MTGVMcGYyNzV2?=
 =?utf-8?B?K3l1aFFVcCt5YUFHS1FMeTgzWU1OZHpzbmswSlRCeFJrK1FSUUdpS0hLZ0JY?=
 =?utf-8?B?OFpRWE1OdVoweE1aOUJoSFhRVnhTbjdoQ01meFAyakhNdGhXV3ZZZnFPWTFj?=
 =?utf-8?B?akwyMFlGRThKVlI5ZnFRWmtLZXNyeUtvZGNYUTlQdkVYUi9Ua1BvTUZ5YmE0?=
 =?utf-8?B?MzZ1WFRZM0hGU1Z6K0JrM3RiaENpTGI4SWxlTWp3bERzY2h4Nk4xWGRVVzRY?=
 =?utf-8?B?UXJCMDNidW5mRnE2QzVTL1NLUmxoSFlBOE5KdXJLSEtVQXJlNEVpQURLN1k5?=
 =?utf-8?B?ZlhhcHFXdTFOK0VJbW9tRXVXVmZzN1ZIVnBDRlpqWjJDcEVZNFJXTjVPWVRH?=
 =?utf-8?B?cURoM1kwTjEzMlJuWUFyM2JvSXo2WkFHeXdFY1Mxb3ZsVHR5eU1GUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63b3761-e034-4e22-f6ac-08df3691b006
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:25:46.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eLGer7YlNywwSpyO4zWBJ1XbB3M1oDbIVTFDOk6saeXlSaGcF0692QSFvxOV4m/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314



On 10/5/26 20:50, Siddarth Chilukuri via B4 Relay wrote:
> From: Siddarth Chilukuri <siddarth@nexthop.ai>
> 
> When the controller is the master receiver, TX_ERROR is set once the
> core has NACKed the last byte ("transmit complete" in PG090). We have
> seen xiic_process() run with TX_ERROR set but RX_FULL not yet set,
> while the RX FIFO already holds all of the remaining bytes of the
> message.
> 
> xiic_process() treats TX_ERROR without RX_FULL as an error, so in this
> case it reinitializes the core, the data in the FIFO is lost, and the
> read returns -EIO even though it finished on the bus. The next read on
> the same adapter can also return stale data without reporting an error.
> 
> Fix this by checking the RX FIFO in the error path. If the message is
> a read, there was no arbitration loss, and the FIFO has all of the
> remaining bytes, handle it the same way as RX_FULL and complete the
> message. Since IISR is toggle-on-write, only clear RX_FULL if it was
> actually set.
> 
> We found this on a system with several AXI IIC controllers in one PCIe
> FPGA that share an interrupt. It only happens when at least two
> controllers are busy at the same time. With 12 QSFP-DD modules being
> read in parallel for 480 seconds, the failures went from 2083 -EIO and
> 1158 reads with wrong data (out of 11.2M reads) to none.
> 
> Fixes: e1d5b6598cdc ("i2c: Add support for Xilinx XPS IIC Bus Interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddarth Chilukuri <siddarth@nexthop.ai>
> ---
> I tested this on hardware with the 6.11 kernel we found the problem
> on. On mainline it is compile-tested only.
> ---
>   drivers/i2c/busses/i2c-xiic.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
Shubhrajyoti please test and review.

Thanks,
Michal
