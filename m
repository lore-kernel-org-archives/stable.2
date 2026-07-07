Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2333D891D;
	Tue,  7 Jul 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431667; cv=fail; b=GAqR55FKbQU7diu31npFk2k3KFWgI/O6mD71FNhqj2LJChwuSbU3Gvd2o6iGadWKPklhgIoYH1DF3dBsGZAyp1/H/Th8yoJfV5hWPkQB3l2u60xOr8qzxMs38FRT5DPqiD0/jEIiqZxQTpXoESCeF/dMJ2Rqf+dfI6Vmve9O09Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431667; c=relaxed/simple;
	bh=zJaRecQvWCfyOb0u+CgzjGM8jpBNb1iGN5U7HLxKqFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m2QoaBR2n2Z2/GnGpbXs42MZfJj9NAhUyg/XAimplpnT+scXNEM6rvpEPo0Tijidloi9eG5Ej/YtyVrLR/KTm4F++dYnpO8Ml7YJgQPgeBBW907nJyM+UaHgTWG+/dLLJ7wemcvMeLETTo2iXUmh+AF9DDpK/D6kIaXKZbIAumY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com; spf=pass smtp.mailfrom=weidmueller.com; dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b=xMclREJB; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weidmueller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b="xMclREJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfMIXmFji4NvXABw0TQp9PqkC2iRNa+Ak1VQo6hSgB7BemY0QpHwt5rYxXrRRgmTlyx1rL/gzPHCPpFnpAXY/AnkteF/DsNNFcePcHRzhSgQSblRv/AFpXF4cB3tMKSgKW5mHcGVVcYH3n7mEhiAIC65n+m+Zok540KtldIxKa7va86VDPlWAe5bZlK+uw8wyXYwJMoRfKfWgBMsqpLFFWnKD8+RXhwyKJMGoTetxCMueZ3pO/52MgxgckijU26EOuuGwhw6E07JZMLpsuI4v8MW72C1A+B5S8ZkS+FmdRB2XE3pqmJeyylRSYjcWxRQcOQ+B2rgkH9b0PiJ7YBBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j6MZLgnczjtpuyb49JFyeq78S/rDz/ucpBsZhnCN88=;
 b=CKlghPH1MP8aajqiQ4tDst7mHHVAZIssWF842bcYSIXqwk19L9KzLsSlePgbnJQ3heimUhbWnCVg2ui2ZcyHY8CnChAY9zkbmFH0QuE9HCLQTY92S6r/XFxrZ4I08baH5ClJxbQcr41zZXlfwqbvn0/rXo/nx4hcw3BOJk3WkGCLvDNdUVx/x/CPDwQXk8VUTQ5Ic6rmchSDy8kd5a8SHg5eexGgA7xghzDJlW1+TGd6w77y/TUByy8t5OWu3wAZbdubbu/7J2cxjG+bIC17WGSibndU+MsLrP2qCu9BnH7iqzRtYOaZLmG/hcZ2SXHnmanT+/8birCXTkldogP9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j6MZLgnczjtpuyb49JFyeq78S/rDz/ucpBsZhnCN88=;
 b=xMclREJBSF0Dvn6cFHvaj1dok5NcnuJpjseR/RlhTHJG2RkNY2Hy5ouBIYRD6OE012ffkTc1jCkTCQdA9O5GsBiYJxGM0tMKAs4/OlZsvKQd9ZBA1gSp45UC65tCDAxXhyq2oxdCtoUdLYvXbV8oJ5cruweeWqar9V4YQj4bEe5drZRRfS4ErzbeU2TYNdkrDO2HSZm1pVPhRHC/mVGPhL5p3G0XmMc/Yb5qDNzT9coirrRBJzcN2TAVyiaA9pvwcFbTED+2ZxysOLwcl645jU1IxZF/m+jINS+ZH39LCcww6aFc77GVjp+x9i+ocyP/DWNR29eYxKWlG+BhupATXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com (2603:10a6:20b:578::22)
 by MRWPR08MB11730.eurprd08.prod.outlook.com (2603:10a6:501:99::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 13:41:01 +0000
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778]) by AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778%2]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 13:41:01 +0000
Message-ID: <389f9c70-a2d1-4d6d-9c36-b875f896629e@weidmueller.com>
Date: Tue, 7 Jul 2026 15:41:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: macb: mask TXUBR during TX NAPI poll to
 prevent IRQ storms
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 christian.taedcke@weidmueller.com
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
 <20260706150552.EomovsBn@linutronix.de>
From: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
In-Reply-To: <20260706150552.EomovsBn@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To AS2PR08MB9199.eurprd08.prod.outlook.com
 (2603:10a6:20b:578::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB9199:EE_|MRWPR08MB11730:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e951b40-3a45-4db2-fe4b-08dedc2d620c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r2ivLaKhSVBeFkt6zTTkrrAygZTLulzeIwwVxEAfDAXJt16+3cWHZ8sKqNIhLYwMS47nrPIg1LYpOmdOX+bEe4JLlgJWKpBphIwAdL1RJz9L7qJlcMZ91LrgPh9LEA1lm59pGQha9PuFP7CgXKD8GP4+1bhtKcXwGFzUfBYUdBTpzm5W1FrXd3PaKsAcGnCqKZnYQK+BELVOt6AusvCMsXY4mm2GaMOLwwkksA5Bs1fVqsT3r0p2sUH7djCRwYfEq5W+eOv4fwcUboZl+gfFCPKAQX8XodlUWiyDjsVCMQqu5KDGPJktCVXyKssmLgTkzNkpFhOacR4B2mOBfPy+UgkQcm6mfABT5wi3nbOen2T7DVzkgxfHqAPgGTWrH/jiGpcgSi9vBY4f/08sh+Oo9FeEPcVhZd62YYHrn7DxHzI88DBRmucjKW3RxGvavKou1FmbJTWiWqbC59ii4AQEOGsYXm/HW3DOSKoH6HB/PJVkY5ebWem9PMWct/lcUh91uBZeP1fTd3eZGwBb5Wr4mGrjc5K1QeILVe2kwqn+c2vozSpgX09W4xsbnlCFSvw04SULugMl9n5oqgqctqBKFRMsaFUzSbFvzecC46Tug0483Z8UQ2sy1XyZWHV27YQzuiDBXxK7cU+j+YT8c+tyJuHEgNiWy4kD35jtLKsmTM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9199.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0Q2MC8xSjFTN081ZHZlbTYvQWo2cDViWnd6b0sxb1RwZlZQakhRNFVUQWhk?=
 =?utf-8?B?SnJEbjlXRUNRT0Rnb0JvV1lYYVRzc2YzTVkwVEM5cFZkaEFVU0dyUEpRTTlx?=
 =?utf-8?B?VzhpMnhZa01Oc1ZkRm5YU2dkT3A1ajJscnZGOXQyUTNlUC9PdG9iaklBVzJI?=
 =?utf-8?B?N1RwaDhGUlI2ZmNXNmZtTFNkT0V0d2ordnhJcXlQbktYYWh6WGkyUytUbHly?=
 =?utf-8?B?UXczT3RPY3U2TDc0d3BKZmcwWjFUdjREeUROQy9lT0NZUW5QajR2S1BJUTFG?=
 =?utf-8?B?SHd5M3NHclZyWTBkYjBnQXdWRGdqZm1BbkZaQnJ3SjVFMElMZ3hkZktiQ0lK?=
 =?utf-8?B?MjNqT3l6WnpWb1F5Vmx4Z2h2Mks1UnMyK0k2bGpjQTlla3RsdGJEajRUcy9i?=
 =?utf-8?B?NlNsTVlFS1BUOFpiVTJ0Wm1yOTBDYkNyUnVOTjhUdWVCanozamJtWjFmSlJG?=
 =?utf-8?B?WHRhVlVYc1BRZmxBRXRwcWoyRlhwUmdSUWQ2REIxVFJDYk1zMkRkYmhzWmZT?=
 =?utf-8?B?ZDZON090VGRKMEpMR2x0ZVZuZnAweFJ0QVU0OEZnZkdSdSttYVRvd3JLdlhR?=
 =?utf-8?B?MGl1ajJRME0zM0Z3RmRwNlZEa283VmQ4WE1WNFZoZG83NnFLUm4yM2gzRFNs?=
 =?utf-8?B?Sk9xWUFIamNqV1pnejhNZnBCeDFnTDZHR0tXNm5Ic2lrNFovWVl6ck5OK0xQ?=
 =?utf-8?B?eGpXUUc5REdPR1ZTM2V0aUNkeVQxOXhYZE5CV2tjUXRQSzkvTndncHpuNVdp?=
 =?utf-8?B?OFdYUFJBRFhOUWNEZmJybDRTSTNoUkJPQW5BUnpRN3hLKzNFbk9ZUzdTT2Ni?=
 =?utf-8?B?QitqQTFPQ2lVVnZHc0dmL0hLSDVBL29oM2diSE1QVFptd1BUZlRuVGUyYWo0?=
 =?utf-8?B?akZ3eUJXQ0s3dmdaRDRocGFIWDhHK3I1MmplZVN5NktXZXFLRE1ScGNxLzN6?=
 =?utf-8?B?WDEvbHFqQnJuL28rSU00VzdCR2FMU1d1dDRrbmRNU1hzZ2Y1cTcwZkhXSzY5?=
 =?utf-8?B?MUwxWVZOQVBqd0phb3ZMaUlNT1BpRUx0RnNFZStXbGN2dWYxTUJ2MCtXKzNz?=
 =?utf-8?B?T2prL08wcGJBWDBjODBpYk5MM0lDKzJQMHFXYmMvZlYxb3ZhSEZtc3Zmb0RQ?=
 =?utf-8?B?NDQwazdhcVpRL3MvVzBUVTJuVGFIVXlGSzE0OExhQVBYWFJmaXZoMmMxSVlB?=
 =?utf-8?B?Zk56UHdmYnluWFdrZGRWM2Y5M0hFZzRPNlFocUY5aFA1cnVlbDNrTnZWRkp0?=
 =?utf-8?B?RGFod01pRTgzMlRKYXRaRTQ2eWNwb0dTMnA0SUNzQko2NWxkRXQzYVBObS9h?=
 =?utf-8?B?WVY1c0hZSkJGTkkzd0tHVEhLdmJnbGQ0LzRFSENKbkxMcW5melh5aTBWbWZE?=
 =?utf-8?B?S1htbXNIR3RWZFRKREJqd2l4QjFHYnI2V3JxbnBGUFVoY1RYa3YvVjE5Tk01?=
 =?utf-8?B?RUdQUGxZenBrd1Azc3JpamU5ZXJuY2NqNUxWSUR3Z2xzWVlWYXNMY3FhbWVD?=
 =?utf-8?B?bE4waFJKbGhYSTgwOWtzb1pXTXlvK3llVkJCMUN3VG95R09sNmhDaFMrWkph?=
 =?utf-8?B?c2pMKzRZa2phN25vcG5Lem9UY0xwUkF2enk3V2FUQUl6dTlMOStxL2lncDVO?=
 =?utf-8?B?aEFnU0NjMGVMS2R5T2MreHd0d0FpMWtwcWVFZHBYdndaRTdYVFVnT29Td2NG?=
 =?utf-8?B?cUc2UFNuSllIWDA5T09xQ2M3SmRuM0hUUUdob2x2NE40bUdZbVF4eFpud3dG?=
 =?utf-8?B?cWVETUJLWHhZRDlpcWc1Sk9zS0ZnTzJsYWtaNWV2dEh6K0VOV3FhUG9Gc3E5?=
 =?utf-8?B?UjdRVFdkT1FBNTRuUkxMWlh6K1NkWE8rcHNmYXBNOWJoUjFaVVdwTjROMFVp?=
 =?utf-8?B?ek9YSmdaaEs1OXBjOEpDOHVaQ2ZFcTl4ckhuOExCKzdtUEFoMThCeDZYSFRL?=
 =?utf-8?B?Vkxya2FpeWFyRHVGUVA2NjJMbFh2RUNQZjlhUDJxTDBXZjFoUkZhdWhyZ0VK?=
 =?utf-8?B?TmQyMUd2SzBQcFp5TUV4aDN6c3dCRktFNjBVM1pQMDd6Vi9hWVRNRTVtbUwy?=
 =?utf-8?B?aHBrbDZkdDR0RmVJN1hXOWthS2EydG5hSFE4MzNKa080SENrUEZheVc1RFk2?=
 =?utf-8?B?QkZUaGNRQ1V3Vk9JRmVuZEVJOXZBMktubzlnWVlHcnJMYWlsb1J4MlVRekpP?=
 =?utf-8?B?RENEdFkxTDFNb2U3RXJTemVKSDNSTkZBT05SYTNxZjdPcldYQjZqbk4wQlJt?=
 =?utf-8?B?ZlhUUUJjaXloNEZveEhFSnRsLythRjhBc0k4TjlJcDhpcVpnQXdNNTNKaVNB?=
 =?utf-8?B?aHJBdmJWaVpLWlNFcmxEcXJJNGhVZDMrdnNQNzRlNGhWdkNHdm1SUnpxTy9P?=
 =?utf-8?Q?KR/NDTKEvws7M/m5o1Ydb8vwomdrcYwnig4lt?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e951b40-3a45-4db2-fe4b-08dedc2d620c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9199.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:41:01.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGu23iYBh0SnG2rgrfGZir5nXgVUsgPvuKiNpR04Scg3gTQOLZp6h6vazlJuJmpWDvRYTBczONVT6hzXyuxZWDspHG/K20LAmCe/TzEYM2qTAErHxLnGS/M/OU5vVJSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11730

On 7/6/2026 5:05 PM, Sebastian Andrzej Siewior wrote:
> On 2026-07-06 16:02:15 [+0200], Christian Taedcke via B4 Relay wrote:
>> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>>
>> macb_interrupt() defers TX completion handling to NAPI, but when it
>> schedules the poll it only masks TCOMP, even though TXUBR is enabled
>> alongside it (both are part of MACB_TX_INT_FLAGS). macb_tx_poll() is
>> asymmetric in the same way and only re-enables TCOMP. TXUBR is thus
>> left unmasked while responsibility for handling it has been deferred
>> to NAPI.
> 
> So this is not a race condition, this is always a failure?

As far as in understand it: yes

> 
> Sebastian

Christian
