Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F143AB0;
	Wed,  9 Sep 2026 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912908; cv=fail; b=V5B+5lFP9mtQE5Mf2Tv8H0E0Ua+tOAD6OPmthlHNyQxLkaiBbX2YtWfwbWShuY5Htt6Eux/855A1soO5l24Qq17LQbnTwR09w1DgBrYbBIQwVlkYADcsDKTNH+e4+N93RcuVSkk2ROXKZF1kykFmW/My/yNlTJXhFNM3jx3EsF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912908; c=relaxed/simple;
	bh=LgJTEuH8JIGNCN68y2vZYAQCA37GVDMTsPcb1KtP9B8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2UgizzVgphcXU7MPZlf099xzJ6crD65Om2Kgw2JSeqqRcqc/EUD0VUNTvfsRd3AsgpbeBYfwBom+DlDU2DbatPE5GUCjJu/7wvSeFQDSgzV7TtufROmUjSy/pRtjdJwkdR6QjWzBIf2pmTOgu/gqPP23XYVK3bek92RcfTzdmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=awipwADL; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="awipwADL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgdURZmAIrzy1H5iKVSglxfSX14QbaKKv0qAlX0u7j//h3xAjUvH0hy+ZX2EuOdXk9WQO3IrGbvHIC4hGScD1BK0plRxilf3OWifJrg0gLqxD49Ef4GJU0TAbiNpt4Cnuqf5vGM2Lk6wqyNn04K4ltf1GANdpHAvkQtaXIUJXvWrRPzmMK563WTPQFeO3DTARVFwvgvljXVUfdzJ8v4dwztx2G1z4w2oyFOU2/8faL+thjAGYjwP8HdCnwUT86R/NWSaAiAPBQapLzBvoMQL7HU39lha2laTqgsexEiBho9fJtTj710Bo9CDXOFeRgGCY5tctV4NKKfjqBeyb5FYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRO4I9ilzDmahfUCOn4nlxIPOPzBqt0tfX/iCNUXJVI=;
 b=bvhK2HidW3j1x17V6p03MW7AZjbnIFB6SyOGKhbgnJjIu/T84qGAf4aGugW3QvZdPU7TTTCyMVktZv2snQa2lFNinwGCwkaMBtkfnW9M2VXMm/NMIeGv9KWdB1c/e0iEIuvi3do8oZF5cekbzlDBS9TR4K+OIjhMgTfcKZmjbiJ63IdEtMM8szeshlxwt3R+GObwHLNAcGF5ogz8Bd56HfY8GlSr/ofJnBRqxy7LAYXxzHQXyo19QZIpg3wwcYDcVycl0uS6sQBd2T29AMNn0zkelR4JHoNO/S0odIym0pO4bpwMXXnj799BMuMBvDXXbn5LEb/8e7+dJxeQ2nzKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRO4I9ilzDmahfUCOn4nlxIPOPzBqt0tfX/iCNUXJVI=;
 b=awipwADL8D4KzWC+qbO1cy5VSgCPQyfGAeaRsUeag9mg03F4WK7pQRBzD0uuOYINE4YG7IqB81SV3XDvUjQrlnXKZw0Y67S0WHOqvbNOtoJuSWzxCACHEDFpCkIEvf3/vnmtEcvuZSs8rxXDi31T1WXk09OOKQOmT9BODRR+oK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by DS7PR03MB5415.namprd03.prod.outlook.com (2603:10b6:5:2cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 00:15:01 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%7]) with mapi id 15.21.0382.014; Wed, 9 Sep 2026
 00:15:00 +0000
Message-ID: <3243a1c1-0b20-49a1-a502-6f939e067372@citrix.com>
Date: Wed, 9 Sep 2026 01:14:56 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, arjan.van.de.ven@intel.com,
 sohil.mehta@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
References: <20260901231634.714144-2-chang.seok.bae@intel.com>
 <20260908223209.916758-1-chang.seok.bae@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20260908223209.916758-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::18) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|DS7PR03MB5415:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b999cb7-8185-4d5f-7256-08df0e07635e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	huq4luphpA4rdM/vYrnNgVOcHbrYmwm3icJxsEencLkRqKR07j0UuEKRhZkULLeaii1diSGQpi/iZA+9zsItX0oa/6QpmZrzm28wmJEjCjVz5321ouHZkyGhjyEwojLVDT8BidI3YlrLQPZRf4dN5FrTqO9jcwNi8WCSIk8JT49KjE3fXXZ8+VRNSnFPLi7i2gfLU6uoK5aNbTafrienN1cNrMx8TaFHJvsxg6yGGUHnRtClIL9lK9J6ga3jOCQJW33SXInteTEw9x1QhLbbmgNLHUNRQgwN2+dF4Ei4eWX/6uP910+zZD/x6YgowvzVOYues+7ZlPjKGTYoa3+kqRqg1wCoUgZ48bcU37BPEZOkLynlgBQEXjJ0ekrJVfNELD/VAgcsFmsTsQxp6Z8XoSTDbMvir0k3BpRb2ouoCtOK82NT/5BAn9RMoTZmAQEXL/d7j0y7YI6oxjKEytwqAX2Y+EvXB1Hy8c6rc6ML8HKOZk67t0ocrybXJ7V8oft/mTlbHGjjVEwjNb+anWcruzzncmHf2aNblZ3GZDOV8V7soOW6eKKEYs8ykPwegJL7ibqkY3bZmAOxR3ZXXa9onrSXD4KB6O9Tjr/DoGRlASd24MVc403JI4/g4/XTl7Nx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGNiWmtYTDlnVm1PR05WSnpQb1ZnUkNMWmo0MjNtWWVSUEdEdUNLTDNoL0di?=
 =?utf-8?B?UCtOZWh1UWZSN2FrSFltUnpsMHZDMVBPTzYra25BVDhCUUpBTU9WWVJoWVY3?=
 =?utf-8?B?eUg5VzBhclRQcjd5RXBOUWF4ZzZZUlFWeTNldFMySVFqSzVyTWdOekxHSDVY?=
 =?utf-8?B?RURrY1EvZzkwYStCV0RHTE1ud0ZnZXRGM2pRakhOK2I4QTd2UVRZdFh3Z3JP?=
 =?utf-8?B?Sk5qMk9wRnFSZ1phckpNcHUrY0g4Mld3OHh5NUtMNWkyY0dScVpTVFRNOVM5?=
 =?utf-8?B?dEt0SjVyTGg4NGNycW5iYW04VzJPa3pITW9yVllmWDYxTm5PdzRLZ1BYeWZl?=
 =?utf-8?B?UE94aE45azRMZ1VudjI1dnFjTFIvaXoxRDRtbkVUQWR4b1BWNzJ0NmFDMVk2?=
 =?utf-8?B?SkpkMjNlRm1qclhJMlpYYVJxeW9EQ01BY2hxaGhXVENjT1NHN3FwOEtZVkUx?=
 =?utf-8?B?bTFld2xGTVV2T1g2NXZ4U2tVb1JtOE9WcldzOGNsRFZjY09lSXlLVU56ei94?=
 =?utf-8?B?NVJhMXIvcjhjRVE5b2R4MnVUcFpzYzhhS0pmeExHeDlYeUFmZ3VDUFJhMk9L?=
 =?utf-8?B?eklrTEZOb3I1RURRN3k5SU5DajlmMGV5djAyNCttS3FsNWpEODZyVENVRFZJ?=
 =?utf-8?B?eFNlSk83QmRHNmhxMld1Slo5d2ZWUDBjUW1XMzZ5YmxhZHpBRWd2ZkM3OWNT?=
 =?utf-8?B?enJ1UjVBK0MzNmx1NmJGQjE5YU01ejVoejVYSXQwSkd2TE9wWUUzamVxUWM5?=
 =?utf-8?B?YU1rZVA1c1dXUit4SUlaK2I3N0VtdEtPRTdPZXBIWXZwQ3YxcktRMkNPZjFq?=
 =?utf-8?B?QXZ2Zk5qdWhDSzlBaWptdXNyc0JwUVVFNTlCMUtoOTgvcTlscVpDSm0ra1lo?=
 =?utf-8?B?QW81WHhIaWs0TjFuYzBGWGxRSVErM2UrRXRXTVMxcEpzTDNrWXdZZWRuLy9B?=
 =?utf-8?B?eXM4T3FJOXRzWXY5TjRWc2RtQTdmWnBMam5tcTE4QzNTRFR2eERGWlpUc05G?=
 =?utf-8?B?TUJXUmt3RWlSTjBoUllEbTVKNnRWaVVSczNwSFN4QUhqOUJUdjFtejVyTWE0?=
 =?utf-8?B?WDVUaWhGREFZNUFudFVaQ1RkaE4xcjZnMlo2L1k0UjI3N2tiZzlhL1ZXVXNs?=
 =?utf-8?B?Q2FLSTBlV2FWbGhTQ2ZYaUdINjR5cGkwaldKQXdOYkxPSmFqMGErRlVYaHFX?=
 =?utf-8?B?YVJvSzRGUERPb0pOeDd0MG5PNjZCZFMrNE1mOUJlMUVGWUovbCtrbmg2Nmwx?=
 =?utf-8?B?U1laQmJzK0xGNVMrQ2xudGU5VkhaaG1EZVpDU2gwWEh5TE5FZ0RrejlsbDZD?=
 =?utf-8?B?S3RwY1JBejBWVTVjeGRmTCsrc2NrUGlidFVDRjlXTDI2VnFwTDMvSjhUWTAx?=
 =?utf-8?B?QVdEd1RiWXhuWGZRdEZXa3pEaXhmNlRkbnNCUlg5YjAxNXd0cjljUkNoSnRS?=
 =?utf-8?B?bktXMU02OVlROXczaFJ4RngvK0cxY2lPeVVGbC9DOGY3d3l5Rmd0L0VQS2c1?=
 =?utf-8?B?MjlvcWxRdkV6Vy9nRys0MnQxOXBzN25rUSt0RzRGajZwdFFNc3B6dnBJNFBM?=
 =?utf-8?B?dzVKT1FsWDhOZVdmRWNtRHlIZTdyRmpNK3F0Nis5Sk0xdm04UWdmOUpUaDFP?=
 =?utf-8?B?SXpBb0JkK2lweXdudzVKelgxU3FVeUdoQk1Fbm1HbnMwNElIbUw2THplOWJV?=
 =?utf-8?B?bnE5dzcxVG1kMHN6QVdLeUlBWWV6cGI2WnlyQWNwM3A4eXZlb0FjS0NTNm5E?=
 =?utf-8?B?K21XMXV2azRlMGJCVlZJbHg2RWdXMFRkamxIUGdvZFdYWjFlR3lMdDlVK1FO?=
 =?utf-8?B?R2cwV1BpN08rQVhrbFhWSmdnYUdFaVIyTnZ2WjhPK0pQYklmSUdxNjROUlBD?=
 =?utf-8?B?ZytmOExGaXNmWEd3U1JyRkx1WkNxaHhuaDJmN2UvMmxucVdJcDZVRmh6VGN2?=
 =?utf-8?B?SFFnd1ZuR3hhL0pqNEFJVmxZQVhtdGQzdkwyL0p1VEh3RFlaRzMwNHlJb1l5?=
 =?utf-8?B?dzZkbmtIZVVZUGw2K0F4RjdSb09kdXpNYmNvT1Y0cVhGZGJINXJPTGN4MWQ5?=
 =?utf-8?B?YURUVHJvWWVsVFdoUjBtb3VUY0tkVG1VRnRSdUJLaW9LUCtaWWViV1ZJbFYz?=
 =?utf-8?B?b0VJcVpidkU5Z0dnMXd3SVRDQy85UU9jby8yTlIwQUhWcnRlcVpLcktUYWYz?=
 =?utf-8?B?aE5uM3lML2RjaWd5SjEveGZsUmRTL01xck5rbi9PalZmUDZjU1ZJeG1QdUV3?=
 =?utf-8?B?OWVndmtBcUFEM1JJejV5YTVvVm1iQVdtU2llVW1CM2ZUaUV4TFlhbWRyRHcz?=
 =?utf-8?B?azRFOXYvU1ZvNzV2MjJTTW9tb082SVRzbnR1N0NNWVhFZHRob0ErQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b999cb7-8185-4d5f-7256-08df0e07635e
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 00:15:00.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxAWtEGnbkZlnh2w5mxyx5TulVn/xE/cQyLSCm+nix9c4zYyqxvGJrday9oIKCs0ucO1SfehDvjkmqEQHIgBxqB2Rop/kPTOcheTkoGv9Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5415

On 08/09/2026 11:32 pm, Chang S. Bae wrote:
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 1142183c950c..61ad280497e9 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -309,6 +309,32 @@ static void save_microcode_patch(struct microcode_intel *patch)
>  		pr_err("Unable to allocate microcode memory size: %u\n", size);
>  }
>  
> +static bool revision_banned(struct cpu_signature *sig, u32 rev)
> +{
> +	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
> +
> +	/*
> +	 * Revision 0x1000405 contains prerequisite changes for subsequent
> +	 * microcode updates on Granite Rapids systems. Updates directly from
> +	 * an older revision to this or a newer one can result in #MC. This is
> +	 * documented item GNR98, #835486 (Intel Xeon 6900/6700/6500-Series
> +	 * Processors with P-Cores).
> +	 */
> +	if (vfm == INTEL_GRANITERAPIDS_X &&
> +	    x86_stepping(sig->sig) == 1 &&
> +	    sig->pf & 0x95 &&
> +	    sig->rev < 0x1000405 &&
> +	    rev >= 0x1000405) {
> +		if (rev == 0x1000405)
> +			pr_err_once("Erratum GNR98: revision 0x1000405 is not loadable.\n");
> +		else
> +			pr_err_once("Erratum GNR98: revision 0x1000405 is required before 0x%x.\n", rev);
> +		return true;
> +	}

This logic is going to need editing when the muti-blob finally appears.

This is what I'm doing for Xen:
https://lore.kernel.org/xen-devel/20260908171525.3196765-1-andrew.cooper3@citrix.com/T/#u

Notably, 0x1000405 is safe to load if 0x1000380 is in FIT, and this is a
necessary hoop to jump through in due course.

~Andrew
