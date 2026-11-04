Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793788051;
	b=hKUrhmMwQ2l55M4W5bh6HGDnE0L3xFRoFeSOyB3YSWkZYE5Av9O1J6zugHs5KX1kJ/w1
	 voCGVoEBagbjWJEAbPToz52aUgSuM84L15nGxducef2bMDbnZQB1pDHznkkwVTRzlKuvF
	 JkjGNF9401pFVOvXlAiTxxKOPRpw/bCOlhNZvwFguuiV6romRw9mVTmSbUTX4ai/qF+zx
	 FhClwxzUVEWq6Vzb88bzy4REVibboQaT9aZmxIUJKCfmRJMV6CtVooefG4Zhwg64g1MKm
	 dEJj9V7V4Eq1Tu+K7pMkuGTZ0roS9tq4MQRS5E5WE7OLVCbBV5E15R/N/FEKU8oJpfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788051;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=02CAB6p54iUG9U/gSzsWevdsKxEOF54gFVgEpZJEuqc=;
	b=3jtXU3shDHkL88AnD+gkR2sJZkvqPym/t4AHlrvAgbQYwrossm5gVvZ9ndIW2RQhtE2R
	 ZoGuLkn3U+ZDC4zE9YmjLgYHw6mEVDukOmHnahYR9EcM2cAIW9bDuJRG5T8WZMjhJDlHj
	 AnaF1JeaxCl2Yg+tkgSrXw7siEixOCHZ20vK2xLSwhcflTJ7LNcMK0Btj6dYh+p0SZCoH
	 8+UZmU96Nt9rexG1G/Eik8uG9TH1UAm6XAF+M6SzJxF8zPhtbHDDSBBlUzgesk7k0qxbw
	 IFc6Wv9C7zaQ7zzOP2vAt1Yebv+T+uo/snAhALTfj6GMhUSSpqKI1Q0ujuPqXdwnNRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b="oMqOp2x/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.88
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021088.outbound.protection.outlook.com [52.101.70.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28AC606A326;
	Wed,  4 Nov 2026 10:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C28AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=oMqOp2x/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkVHEClVHJgC+YFQTgOHF8dZE5sJAKgxkayl+qTHMwjh4rMxTKgtK+NP7DXF698B36HpJTpq9G7zXHWXhusH5BudMXnb+K50BGQmOb6EpIjEMBfba2EKFeVS+ptUSwJriqjEvWXFUxMPPsEW5VRdYf/5+1DyGJkr4RAf83vIQfS0KCTcchlmj3B8sHCX2Yhm5vDfEypBE5Kkqc7QKgaPL4G+wTfj2AiGYT5NGRZs6DKUmgzxFCSbOZKsFRRL6GDhVyoZAtHs8px+iKNdHTkgrbVTfLZmYsIqedhN+GA5YSTFg1ADZjKrc8ISBRjghgRcrbMgej9pKO9smHacikAT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02CAB6p54iUG9U/gSzsWevdsKxEOF54gFVgEpZJEuqc=;
 b=LYwxR8BjPRezN93JniHZrD6r6jtL7HgR79jWVtfbRu6Jx/Zpc4ti0u7/QscRT2BB/Y5WmSTQ0HtK27ubTuBxWFwjr6vb//g3an9BUjo2AoGeVaBC8QVJMyk0/TAnhhCxLeakRMhAzWMyWThq+MW+XSSa8oRi4q7UmCTYH+ADFP51GkWtId/9UfQFHsWHCm88kOYaIL37toenFTAzwBOR62PMZFkAd2V9bFFPEoy9xNTbpHxxLU5h1n3b8SvWR1tZSVDNrOUQD366z2Au5jDYpEasZ2FeZG1MOrXCzHAiRbaKxhi8J/MYDlZOdnW+GiifoN0syyle1G/Vx5iKn3kJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02CAB6p54iUG9U/gSzsWevdsKxEOF54gFVgEpZJEuqc=;
 b=oMqOp2x/yR8a+k/FZJLaT+m0jvIno3cRN+9c7D55gq8W51sAjVblOcpQNMHwP6LyCiIvzBrWrltfDtvg+3ItGEE3HiZiOWxv6bghlznU65R3PYrzNJKybdFmQP35SiFElWMYnEw+z17g0wP1+ClxV/I9a08TrbXCkPhk90MxBuViHTfLg8ZHSF7mP448FbRBTVSx2qmeu0dPE5EXIEKm3ZoWR+mBnpkFgrSfF17aQh7jcs9aSkzcKquEzzqOkSblAgYVdsyfWE0R/G5/R7//1rGXJ1yJlDXDnKC5qSenazE8rxHsx2+5q9NKmhWXeZW5XUJXUDBDov3ruysKaH6iZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by DB8PR06MB6457.eurprd06.prod.outlook.com (2603:10a6:10:128::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 10:27:23 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 10:27:23 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH 0/2] serial: core: two fixes for the port removal path
Date: Wed, 04 Nov 2026 10:27:14 +0000
Message-Id: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIII62oC/x3MQQqDMBBG4avIrB1I1HThVYqLmPzqUDVlAlIQ7
 97o8oPHOylDBZn66iTFIVnSXmDrisLi9xkssZga07ysNS3fvV85JAUrtnSAI3xcU/iwaa0Zx+C
 dcx2Vw1cxye+5v4fr+gPCN0RFbQAAAA==
X-Change-ID: 20261103-serial-core-remove-deadlock-0310bbca5554
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793788042; l=2789;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=OPM7JdNPs0bdowNL4v/tzz59C+8G0NPyyZhOEpbGmkE=;
 b=WLernqCiLf8vH8dwmdZF5Xh2xaJXOSIWJEbJ0o6BpIQScE3T6Sc2FHNOsbCGaNhKxl0laLeu+
 Arbv7XjpNsxBAk2DWIepolpCQd/4agXvdzrRwNXvaawffl1nXvU7MAO
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVYP280CA0042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::23) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|DB8PR06MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a84d15-f363-4cb7-1f84-08df3a5e36dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|10067099003|18002099003|261022105027099003|56012099006|5023799004|11063799006|261021123027099003|261021121427099003|261028144727099003|261026121527099003|261102123227099003|261026140227099003|261009223027099003|261009221227099003|261022075727099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	gI0wMIC7Ui5xcFLRFfkWJ+efrUZn6KEv3S2M7wUufVAUzTbAoWI0scj3h8sllnqE1VJaoiSr6zpbzFbgRqSYNWCx1zDqXD0KXsFs6zXu773n0Xmpm3xj9u42YuoJRR+mra9R5Tl0TYLXiU9xNT2qTsDXJvg5dl67CIdGtS+pAAxSiyZEzznltSLNThZRZQICAd9P8DsjrOOnOivVMLtBC2GLY+jZ16w+KtRBir1q+DdHR+cjB7NYo68vDBC6vMtnkSGv8ls5Cz01488p3+i/K26EflfZyrlTf5s+7IvYArB7gBHWTy6PiDyvrioOIDChv1qnUjdo4ctHcJ0zeNAxEPvDPHhfhoL9QpiaZN1bJgU2OUU4BAkCzmxj5GBu/2j7cKOguOIk35W0+5RjbwXE8Vj1yd15RpTq0o4P+tX4G8TojSg3Cgcj9d5uHM3xip6dgXvltmZlBOnT24WrdYxjptEGfXgs6MdPJBRR+dtWkNfNQHxHXrsBcqp5H9oQfwosRu7S9L3WA4kz8w+Ik05J0WboHkmQKv4UPKVQY5eVwld1VJOIQqf+2SPslThaMwTpUU7/a07XzbSm4WK/RnXn3J+vJla0J5cubzs0Ed0RA94tbjFgX1jTr/v+nokbwrkc33kCxuC8A3cVlSWdqAZuZrAPC/kT3iBDs0C8skZ3fsYzMmMdo9iSz5i4RH7FcmlrWG2zA+pizlvxl+OyBThs80l53N4EBzlU2k/gB394afA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(261022105027099003)(56012099006)(5023799004)(11063799006)(261021123027099003)(261021121427099003)(261028144727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261009223027099003)(261009221227099003)(261022075727099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmMwNzFLWldLdDQvM3liQjNZek9LSHpBckViK2JJS0E3R29yUCtkdUxXVjcr?=
 =?utf-8?B?NFhoRW5sV1lVVnExeThSZEdzdkgrQW16bS9PM0kyR29sbSs5L00xdFJ6ekJM?=
 =?utf-8?B?dFN2bWxNMHdQdHM0U3I5RFBUZGFUS214Vm9aRGlSV1luUlVlNUdFWUFUNzNF?=
 =?utf-8?B?dTRLaEljY1Eyc1BwbzE4cUY1UThOWm13N2VGY1RWTjJyZTJPVHhiR0NGbzM4?=
 =?utf-8?B?VnlldkJvbnM2cWRNMGhpZWQzSGsxc25Qem9sRFQzRnJaaXhOQ2x6ajlLSXdj?=
 =?utf-8?B?anV2UHlNZVhrSko4VjdtOWtkbW9oYnZSTXZycS9JSEZBcXRLMVExL2U3Rkho?=
 =?utf-8?B?NTUxOUR5OEVvay9vQkF3Tk1QWThkNEgzZUEzT2hHbmF6MmpoVWl5dkFZcExE?=
 =?utf-8?B?NHRGRzZxS1FFbFRLQnJINkpzenA2QXlqbHJncWdFSUZJaXFNbk93MlRUMXR0?=
 =?utf-8?B?NUE1RkJGcW45RDBRN0hBdEI0eksvVnFQZ28wM3Z0TnMvWXBnNlNuWG1kRTYz?=
 =?utf-8?B?b1BtUGRDUHZ0bVdGRW1Uc2NKSVd5WStkR0RrcXpMUXp6L09hVE5mRGpNTGZS?=
 =?utf-8?B?UEtaZG1jZWZlbW8vSDhoOUh4RUQ4MFlVMVkzbWlialJkNG1aNGVHWTBpaWtS?=
 =?utf-8?B?MXlYeGExdnl2VXVIOWVPN21rT25JTFNzekg2bVkxbXFHL09EQUd5cmw1d2Vn?=
 =?utf-8?B?b3BrRzRCaWpXY1B5YmxCcjllVDZ6Ymo4dSt4TXVTM0VIOEJXdkg0VG41Nzkw?=
 =?utf-8?B?UXJXNUJ0QW5aUHBRa2dTZWd4NFpaRUlVYTc4UEZnYW9RaFRBcmRjcmlKNFI1?=
 =?utf-8?B?dDNERHlha0FYbjB6d0dmZENHS3NwWjZ1aWk0Mm45U0Vib2JSRFJiSDdqVldX?=
 =?utf-8?B?Smh5RFlKUkc3NktHbHJ6LzE3aWVkS1ZSVFRTbzRSaEF4ZGFqbDVmbDlWeHdY?=
 =?utf-8?B?aGVJRXJlbW5QNDUrcHNiWHV0dGpCZk10cGFIOHNxbko4dEkzVUdIWlpQRXJz?=
 =?utf-8?B?aG9PS3ZFSDZIVWZDU3c3U3BzNC8vZ0lFOG1BVlZIOTA3K0VLc3VTcHdrZ0dQ?=
 =?utf-8?B?eUdxbDhod29SY09aWkxucUlRb2ljdVBJWkg3ZklGZkI4ZmJzbTNQN2NDbmRQ?=
 =?utf-8?B?SmdHVFJXR2lwMzgvZzg1eU0zWjNTVFVOODRPbjI1SWFyRnhObkNtdWZQamtU?=
 =?utf-8?B?KzF0S05JNTRmQ1RIQVl1bHdFc2xXRTdIeW54OXVDSXVSdWNMQVdSTkRleGZ5?=
 =?utf-8?B?cGdzUXNjNERCN25vTGh1NXVnK2pyWkFoc2JyYTFtVVJUaWFBT2tnT0JaRTZV?=
 =?utf-8?B?b0Y2RUZHRjF4eGEvcHY1bkxpcGFEZGJGcmw2dGFoZmJNVDFVdWY1V3N2QU9z?=
 =?utf-8?B?UndBeVloZ0tDanJnQkYrWDJFaVJGOElQNW1WZXJ3aU9DZzFnbm5nRTdGZEZT?=
 =?utf-8?B?aUdoZ3B3NmNoZnFKMzRhMVJrMTNtNGtqbXF6eU1sbmJuWXRnekw2VXZJS0NB?=
 =?utf-8?B?ZHFwckpCMDZkWWgxSWVkZ3hiYWVaY3J6elZ0N2FCakRabVFsK0hCd1YrYmsw?=
 =?utf-8?B?WjdjdGpFSHdCVnozTmhqRjVXNzdsVC9FM20yQnliaEY4bTFSN1ZxRWxVQm1r?=
 =?utf-8?B?V3doV0ZHT2NreDFmczRKVDFURnRwSUZoN21qeVVSSlRUeHpEcFhQcHF1S3NX?=
 =?utf-8?B?ZmpsS044N0I2WlQyNDdISVBjNFFkaGwxNlJDOXVMNzZLZUhNNmljOHhCeUVn?=
 =?utf-8?B?MExTQWVneWJmeDFwb3hLbkdkYkRGRzRRVnJWOVBIdzNRNGRZVHNVRlZIMnk2?=
 =?utf-8?B?LzYvMG9Na3BlbUxCSmhUVDJpUEVHSVd4ZjNJdFFhT2tSenl0OU9Wc29vczli?=
 =?utf-8?B?c3liWVVKSndVY1hxSFhRbEFWUXpoRUpiWCt3cTFCbzhLanhucDdlMFVQRjdp?=
 =?utf-8?B?V213R2ZQWGhzc3B3ek5UZDh4aXFuZnVpVjY5V0VqVXFEd3Ayd1Jzc3ZjSTc4?=
 =?utf-8?B?RUp0Z3ZraElTanJYZUtJQTdPMzd0TXRJcGR5NmVXSVRyLzRLWEZpMUpVcFpY?=
 =?utf-8?B?UnozZ1ZPWURPWm5EeVE5YXFCR3Znc0lLZmJoSnNUTHhQK0lQQVVXbFFLMGdV?=
 =?utf-8?B?L3lyMlYxYzNVS0p3bUVsUmdUNHVSdlo1SzNDeG0zK0RFc1RWZUxTaWMzTjlD?=
 =?utf-8?B?WCtycmFOQ3VzNWtPSDZSYUVhSGtrZzRSV1phUEd6TTQvMy9NUXRMUFJuWUtG?=
 =?utf-8?B?R3VDdGJoV3R6K3BuQmRRTjRSdHJnOWxQQjgrdDB1ekVDdkx1Tk83VGFLSkVj?=
 =?utf-8?B?N3oraWRuamJKMHVZRm9USzlucXVsS24yalZJZXphdngxaCtoWC9Ma1V1d3Zo?=
 =?utf-8?Q?R13U3ioDHz/r1bx8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a84d15-f363-4cb7-1f84-08df3a5e36dc
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:27:23.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qstpiYAYztUMuNzDkV4g8xO1Iln8DbHEGgVIQUiRGWxlGvgIhcb73JoaNl26TcStxAjh2Yxncgmk6VFnYRw67fA/UlUYMkh40G08YF1y1B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6457

Two fixes in serial_core_remove_one_port() and its reference counting.

Patch 1 fixes a deadlock between port removal and a tcdrain() in
flight, present since 8ca59f7baee7 ("serial: fix ioctl hangup race").
Patch 2 fixes a read of the port after its last reference was dropped,
found by review of the same path and not reproduced.

Reproduced on a MAX14830 (max310x) board, on v7.4-rc1 plus the board
support, by unbinding the driver while four processes drained a few
kilobytes each at 300 baud: the first unbind never returned, and the
hung-task detector reported the unbind in wait_event() and a drain in
mutex_lock(), with the drain "blocked on a mutex likely owned by" the
unbind; a power cycle was needed. With the two patches the same test
completed 46 of 46 unbinds with blocked tcdrain() waiters, each unbind
taking 2 to 3.5 s, the time for the drains to be hung up. A two-hour
soak with lockdep and kmemleak enabled, 1472 unbind and rebind cycles
every 3 s while other ports of the same driver carried full traffic,
completed with nothing reported. The change is independent of the
driver: it only moves the wait for the reference holders out from under
the mutex those holders need.

Tool use: Claude Code (Anthropic) was used throughout. It analysed the
hung-task reports and the /proc stacks from the stress bench, located
the lock order between serial_core_remove_one_port() and
uart_wait_until_sent(), drafted this change and the commit message, and
wrote and drove the test harness that reproduced the deadlock and
verified the fix. I reviewed the locking argument against the code,
decided the shape of the change, ran the hardware tests and read every
result. The code and the message are mine to defend.

8ca59f7baee7 is in v7.3 and is tagged for stable back to 2.6.26, so
patch 1 has to follow it into every tree that takes it. 7.3.y has the
same guard() form and takes patch 1 with a three-way merge. 6.18.y and
older still end serial_core_remove_one_port() with mutex_lock()/
mutex_unlock() and need the change written with explicit calls, unlock
before the wait_event(), lock again around the NULL store; I will send
that variant when the stable mails arrive. Patch 2 applies to 6.18.y
and 6.12.y and needs a context refresh for 6.6.y and older.

---
Tapio Reijonen (2):
      serial: core: do not hold the port mutex while waiting for references
      serial: core: do not touch the port after dropping the last reference

 drivers/tty/serial/serial_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-serial-core-remove-deadlock-0310bbca5554

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

