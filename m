Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795788712;
	b=KQUp0bA+0DNgKJsYFcfR0RujkmSAvEstigcHhtVTs5FC5cxek6TCTyl9jAJl6BLib2Q7
	 qgROVQvKqjFFScEj4nIHfeVjA8AAwn1PikBQEEDcG1AyoawZqYeXy+SJucFXOqXGFhGDu
	 EPyLmW3sOzaDX9WGoSjs3hf9prhiCeZYFntlgGFBy3YH7ewtaAp/rUJDTRTRyO4rW0u0X
	 CWp2kYbeZeiPbdGXR3UXihyDCbe3BfmHLw12GGsz3o/ddayfpTqXElU75l82pRpitH/CA
	 Er1ipSYUTr5r45XpVZiEYbzI0QnibmYTdQ3UKlqmvYol/9c8bDSaS/MFXKEsgCUR3kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788712;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=U/yyr6b0Cz3855QFe2ic4261xvvETR5gsPm+ZyFSYrE=;
	b=kKaz5nlzD8gx2CA5qFpseYPW/4tqMdaVBNlW77axzOgbp1JCT/CwWAupAxwbNSDzxea8
	 nOLakyZdl3yUm9h/auUTxKvu5NOsKaoPHW5V0jMXfcgiPG04n0wuOzji9ekd0jvdn5P3b
	 mJ1pJz7buy/2l3LpR9DS46afFn4GMHCk1ra8AVSeMUSe+PCMPH4L4Ofv6ejGYAaGpBml3
	 /FskY9fT5m9y3bicS0pBWNX4Bdkh/lHo32yKzpOTadK7dMUxmr62yNBmdxNIzzs71Q91o
	 cD6ar+jsJOMqtOItsveah8KI0KvvIYfyprz66wLPiKyuANp/zQSKQT+u3PFBMq4xozw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=OLBLt5By;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.19
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011019.outbound.protection.outlook.com [40.107.74.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC6606A31C;
	Fri, 27 Nov 2026 14:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9EC6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=OLBLt5By
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkV4PKeBzxTTcqGS4GN9bVo+Mw6QMPn+N6bGP0Ymxdv7eOSeO7BGes+ToqmxtpljSzPaiQi1I8tga0hzSTkykDrlnZTLzo5syz7xxCZPEuAA3MNeHjD3xTooZaZCOdoyq058RzPT59AEF/e+T8Rlfv7l94dV+8eMg2zxKMRzyqTYWPS5DCPeCeymAnbGhIUDVOe+q3NYCgzeRfHWs0bMurzbEogSuwf321Fa3u+BxczneCfMRGcbzNxgy7+uYsM/JdPa1bymQIfEkPEVZZ8uzw5j4DvtTAbd9EIN/umXzb0AQS3wiycNHXstEIHr5vdzJOSXzNcXTzKC6oW18Mstzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/yyr6b0Cz3855QFe2ic4261xvvETR5gsPm+ZyFSYrE=;
 b=zPruabuFE16uz45s3HtpWspyxgrZ+l5xG85SdRMVqwxqkEGm1+qT3ltU+VDfjWlqIRz1fsxhPWQenH8Iv94FnUt6PSYg+FltwwCq8K90AOPZLSdQ3WuDBryNVLiZ5ylQVoiDoucoDynKGYWgAnUq0kUrKhPbiCogNG648z6oDLFVzCMfoWn9Bxy+Asy4eaSeCHdQtSMahk7IFJZrYe6vFONBKZi8wtWAwR3kL/ZKrugHslbCFhJEbH+vwG1atMWbShbNY7Gyw08pm1QiEs6ZdyaflujNAYvUi/Px9/+hu8UbXzAijS/Lw14/pDd0rEfKVv0nfhezFPOrol/sChE+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/yyr6b0Cz3855QFe2ic4261xvvETR5gsPm+ZyFSYrE=;
 b=OLBLt5ByTst+9BJw3cgOxgxoarGrt2zKjQBjpOpaEeNFUnsUDkOLkQlTcvvrwQ89u0HlSPclP7OlAxt4Og0NmybQSH/Qysr8bwc340uU7EOXbtiw6tNErr6TA7F356KZUSwxCUwdj+LtfrUuZeIK2AJyqnDHFl0rkyLSFPax9rw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11) by TY4PR01MB576160.jpnprd01.prod.outlook.com
 (2603:1096:403:721::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 14:11:48 +0000
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4]) by TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 14:11:48 +0000
Message-ID: <fab26152-3c42-4e48-a241-fbc061a3c13f@renesas.com>
Date: Fri, 27 Nov 2026 15:11:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mainline-linux 1/4] tty: serial: sh-sci: set the RSCI RX
 FIFO trigger to half the FIFO
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 stable@vger.kernel.org
References: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
 <20261120-divo-ssgrlpcsrc-2996-rs485-v1-1-a989baae3559@renesas.com>
 <2026112012-aftermath-trench-f567@gregkh>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <2026112012-aftermath-trench-f567@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA3P292CA0026.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::11) To TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11)
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
X-MS-TrafficTypeDiagnostic: TYYPR01MB15118:EE_|TY4PR01MB576160:EE_
X-MS-Office365-Filtering-Correlation-Id: 091be182-8419-45f0-1b8e-08df4c905fad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|10067099003|56012099006|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003|18002099003|22082099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TMUuG4AEIVjwt24qaoSgz7clIBoaqf+JZImdJx+bkTK+U9RYZl3lhSRoumY+fyW3zlwa3aySlP2z7kUoBVzFF9Y3Gj5gbRP5uknfSZNHBRZHNWCk4j0SxrJy3ahANdovUnFD735PFaV5Eu16/2C/OkAWErVBKbfbWHntguYpNRuppTwmFRqIXrnICNkUled56d1uLvTAHv97HSt1v0Lonxv+2aE4OhYLUcAd4FbWOGnEnglQbfLs7iPeNzKY+26wqThn21fbkBRrYbwU78qlNcCrYpR30XlCJplqg8ItXGUz3eApxLjX1s3wP2fxjMGkuUZFythCMKsJODhve0BIDn9J5PM8Ojtb6Bj+D0G+FH/WotI5ip/8fYkPX+fE6LcEJpTvMbQ2KaJQ7/8r9At5+gf+c+V+60e7s3FLlLE4NWbOUfjCzZpDJydPbgk7WBUwyw2id1tac0PxdzvsTA/mw9XT/hICPcGe/7u/oYCEYY9CnO7gJGgUp3Hivc23pLNWGsFd7zJuqTuNGAlJ+A1qnT25rBm1mCk0oeQRpPGjKxZ4M7CXpozryH9bPDNtTxLRArZHVQNQcDdTc0JSF6mTS01uur1H+149N9G55GqZeU9siyec/tia35Eoxtu7q0H0CwYOA0AkdoaQGOj82osF/Wp7KckmMhawJ0XnuHJX6PQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15118.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(10067099003)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWxzL3lzT3hnTy9kaVkyUDFGa1Z6WGN4QUxhT1dkbHpPSmMzQ0dteXNVQkd5?=
 =?utf-8?B?KzlRd05WY1FhSHR5Ym9YOWdSbmlRTkZYUDdyYTk3SXFkRlRXWXJhaStzNTRq?=
 =?utf-8?B?eURTNll6Z28xNDBIeTZQRnlOenIzRytYYWtGWUJMb08vUzUwQXdqWDRRTlR6?=
 =?utf-8?B?L3NRcXM0TXJGb3NubmQ2RGVFeE9KMU9Sbk9rcG5XRDBwc2JFWERQS3dLM1Ru?=
 =?utf-8?B?U3N5clo3M2cxRHR2QTV0U0w3SkMxSkJVTUxCNkg5N0dWUmtuVUJMY0JJMXJm?=
 =?utf-8?B?SmFKUERrWndvMFc2M3JvVGh5aVZqcXdqM2tqd1JmTjhrL2NjNTdReGNwN0xZ?=
 =?utf-8?B?S3FndFNJS1dMNEFEK1RLRjcrNzYydHFFOTV5THJGd3JKT3duZGlnTXYvM1dx?=
 =?utf-8?B?Vy85aUhTSUdrNDE4OElnaWllS2hpL0V6cmFBcUtsV2pEenlHdWhrekV1ek5v?=
 =?utf-8?B?SFM5bW9FNjJhT1VsZE8vY0FqWXNsaXpUcjIwbDJlNDBGWlZ1YWVOUVYwdFph?=
 =?utf-8?B?QmdxTUMzU1pwL1FVUHRLM1RiazlwVXlvTll1U1h5MElwL2RMb2VrL2syQjdE?=
 =?utf-8?B?cUg1ZEpWZk42R1dUZTZMQlVJMjczaHkzYmp2OUNBUkZicDR5N2txUjRMelY3?=
 =?utf-8?B?NEZZNUkzRDlsN0J3UTBvamsweWRXLzR3M1JjbTRtRG54SUFuLzFUOUR1eHBT?=
 =?utf-8?B?b0FlcmNlbjgwdW8xTURHZ0ZRM0NtOUpscHdYUUxhbFk1RkVnc0JRWVlBMHBK?=
 =?utf-8?B?TUdGa2R1WkROdjlXbzY1WEpNRUk3dW9nNE1pK1VkNkI1NG9Jc3VCOFFSdkJZ?=
 =?utf-8?B?VEU0bFlwYXVNSDZtRTRIK0xobFA0akpSVlBGZW1uM29SY1RlOHZxMkNFMU41?=
 =?utf-8?B?TTIwQ0tvUHdLWHRNc0k1cU95NFZUdkh5eTZUbG5LSDNsY2FsaTBNRXg3elZZ?=
 =?utf-8?B?VmhtNGt1QlNmenh0SmZTbWdwaXB0UlUrWkNkalM0a0xwZUFBb0lyaTBheDBU?=
 =?utf-8?B?dWxubnVudmNIelFzRUU4SytKZ0JsT2xXTG1YQ1owYndXRkVLUklGSHdFL3U4?=
 =?utf-8?B?eEJJV2dBc0U1aUxXSmhVa3d1ZDNJZDFCd0J2Q2xva2g0R0Yxam5wWEx1VVVC?=
 =?utf-8?B?cXVacUVRQlg5WG5MZzFDbUJEN0RQYnFobDRmbDRCMVN5YkVuKzBxNmwxTm5q?=
 =?utf-8?B?QjdCaHptdGYvL21pRjE5bFFvNUVvMUdYYk1OYTNMZm9icDFmS285dDNiSGJm?=
 =?utf-8?B?bFJocXFoV2NCUUs2U2t2RWo3TnIyVWd5M0NrMjFvSVB3aldBSWJFMHdPZmhR?=
 =?utf-8?B?RmtVYzIybFhNZmducnExQVViVGdGbkJsS1hpcWdrVm01YlZyczZzOHBsRG5H?=
 =?utf-8?B?dGhsZExFYXdUNnh0dWdwb1RWVVArUEhjSllaVUczalRRVlZmOXRmS2RvOUdl?=
 =?utf-8?B?QzBabnBnUWczbUZnMjNNYXF3UHBCTjNRV3M0QzJ2V3JzaE9yYjQ5ckh2SERV?=
 =?utf-8?B?Q09Tc1JxTkhLOVlZZDZoVXVLN3ZYWm9ycENtNEZTdEVFaitSN2haYVBhS1Vt?=
 =?utf-8?B?SndrcFV4NVVGdFVNR2U5Z09vZnl0b29hS0JMWXpJcGVYaThrNkdOaUErUnVm?=
 =?utf-8?B?cHpXNzh2UUVpZTZyR0tqZ3l2aWEwSDNUUis2SHhPL0NTVVUyWTZRNE1GZnJ1?=
 =?utf-8?B?SGxaTTBRNC9ObVJsMSt0Ni9ndEp2OHJYRnlndTY0bVpEME5Sendtend3T0xR?=
 =?utf-8?B?WHYzTFBYU3dDeWZvMEdEY0dJUUJHdVRDNGl2WiszVUQ0cC81U05yajVXSnds?=
 =?utf-8?B?cmlmMWRIWGVKOUlQcWhKZGNERzR0UFhiWUozeTlvMEgxdjY3VDZOWnFZWVlj?=
 =?utf-8?B?MHlxT3NDY0RzOHgxTmlpNzhUSittYkg1Tmx2VGpRVDh3ZWs3Nm9xTnRXYkto?=
 =?utf-8?B?QU1GWnVjVDQ1dEdVZWhrckFGTk84azFnMTR5TU96MWpDMXUyZWV6cGhjdmlq?=
 =?utf-8?B?NU1jYXJWZHNCSURHU1hDMFIvTmZtWituV0Z3YURkRWlvejlvbUNUTlMrT2V4?=
 =?utf-8?B?Wll4d3VRWHBQM1FoWlJJTUNXL0l2TGJmMG1sQmlsbUNEcGVhYU1iSnhWaG5n?=
 =?utf-8?B?Q1FpMHM2UkduK3BRcjRPazRnSmw1ckRkeTZwcXBIT2NFNEc5Yy9najYyckZy?=
 =?utf-8?B?TkFhU2xRenRDcGhpZnU2UVU1ZFR5S3QxbmdWOGpiMGUxakdYNWFTc3h6Mkpt?=
 =?utf-8?B?NlFiWDlIdU5XRTlWQkpkaXErTUkzcVdNRURKK0RtcGF4Wk9GTkdMVXNheU9p?=
 =?utf-8?B?aW5wNGlTYkRXVVZrd3lWZ01FYmFpSU9GZko2eE5KaEtlSXY0aE0yZz09?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091be182-8419-45f0-1b8e-08df4c905fad
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:11:48.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6tj/XiHB4p2PsLJvGHWyqQATthe3ZpHJM9cHEnRqDmuPe65sJ9NgdsTm5SO7ukgk8IHPKA9IRSTv+MFgP9OTIBmfsCvI2d0tp8rdn043ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB576160

Hi Greg,

On 11/20/2026 5:11 PM, Greg Kroah-Hartman wrote:
> On Fri, Nov 20, 2026 at 03:49:24PM +0000, Diogo Ivo wrote:
>> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>>
>> The RSCI port types ask for a RX FIFO trigger equal to their FIFO size,
>> which rsci_scif_set_rtrg() clamps to fifosize - 1. RDRF is raised once
>> the FIFO holds at least RTRG bytes, so the receive interrupt arrives
>> with a single byte of space left, causing overruns at 1152000 baud on
>> RZ/T2H, and at 115200 baud on RZ/G3L.
>>
>> Every other port with a FIFO triggers at half of it, SCIF at 8 of 16 and
>> HSCIF at 64 of 128. The only exceptions are SCIFA and SCIFB which set it
>> to 1 because they have no hardware FIFO timeout and a higher trigger
>> would leave bytes in the FIFO.
>>
>> Trigger at half the FIFO for RSCI as well, 8 of 16 for RSCI_PORT_SCIF16
>> and 16 of 32 for the RSCI_PORT_SCIF32 types.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 3a3ab10245b6 ("serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI")
>> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
>> Fixes: 42eeed6d9f31 ("serial: sh-sci: Add support for RZ/G3E RSCI")
>> Fixes: 8f18d3cbd920 ("serial: sh-sci: Add support for RZ/G3L RSCI")
> 
> So this patch is going to fail to apply to 6.18.y, which from this list
> looks like you want it to apply to.  So please break it up into
> one-patch-per-device to make it simpler for everyone involved.

Ok, I'll do that and send those patches separately from the RS485 
enablement.

Best regards,
Diogo

> thanks,
> 
> greg k-h

