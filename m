Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816409;
	b=cDTOyE0gMA2OImGytCNIw2dKqycS1vUg65JOYmiJa/keu7RK4KHc5G4oTEViLoEBBro/
	 KzTpFRhRQWUgjMppawnfzChvSohG0ZegE/flOkeUekuBOjbRy0ellDG97b7w4xNeMSSdk
	 CIVyMolX5apH99kV5JJEKsoOuZiqk9VGQ44VPhvUMpzlKcSTl0Io5wWPavAKFb1Ouk3m7
	 BD5CPcNOZrc7DuGxBSTQwnq9jczxmVEIzPMiyu6TDmlq8/mG9+yCw2BCCRQt+MNykviPW
	 vmFyupaugWb60qVu7gD4anLOh+sq61wWrhwbsW8cxhMszvg4yV9IHTKm5EGhQb+Y6AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816409;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=Voebxl4/DcQA8voWRgiWEBplvH3q7171n/a/71SM/Bc=;
	b=S07sZvoqjR8l/GoVN+LPBZCOTl+y2S/Bezf4RXLtlgTkPwc4r1OIzSA9akBHybLkoUuX
	 PNb4BIelgMqWfGubSS+kNaF0v3Gu07Fb1k4VKpwvIBskrgEEurdJyiIleqmGLxqNWJ9dx
	 GNSIMI2SleiwOem6onMbRx0F1BRekFrTBo1I1CrJyvl13douQlWgTzjY8q0jtKTrvIGWn
	 WIDWqsNTpw78y0c9uQqzQVgV7S1becWDtAmtrpWymO+Huxp2e238S+ak+1IAvH33pOCla
	 HMmjFZxMrt913UeoQzp9pIjUax4Tycz+0F59yaRh6RPZJG8NRkLl2FmaGkz/jOV4pMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=aD67uigr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.89
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023089.outbound.protection.outlook.com [40.107.162.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE0606A31C;
	Mon, 16 Nov 2026 08:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7EE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=aD67uigr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yR6uAIxxYTzIPJsPF7xWEq+6HsDgwGsYL2indLZGJD7F8A8kSZ5/er28fekeNFFgWMlYXrAbYbtiU48iBQtTGYix5/zSK9ONXoJHZJlMwkCoLJB3+pSY2C32GN7JFVw0VQ3cfHma8YQAr4TPu/ofrOb4tutWA2ogsIIq8dggNrulDlmphyeevczAFvMAXRgpSNJGIgNqmRPFSvoC5tpDFxyX0YQhh9VTzDlG+YvdPWt3LNNA3oRkkcVaw0UZ9yaGH33hzLNz1r2/r7HHMqIwl96vi5RlPhdli3QVYTDfThvEacmlBUN495z0/5PM4Jx9oYXxgRGj5qxvF9FGRccGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Voebxl4/DcQA8voWRgiWEBplvH3q7171n/a/71SM/Bc=;
 b=fvD5+G3cY/JMCgrZ8pf52/nh4WLtitiVF869e8ZvtWhLoepRXcUmFFgezbbBNCby8fImiXEztT1Et2qS7lOsSVCzCjC6zuWLrrmNP+Nlz8stzsjyqEuHuMuvbc5MbZMmxdG10YlHXK434re0wVU2YdLOQSg2PlR5Ji8JS8OeLaj6D8oILG5E5rioMLqtiIJFYLgS4/dQ0mTIEagsoiPa005CZYG7HH0mTnYorM9iHYC34xE8t48DUHAX/PTZTu47GCzdJjTL5YGS/GEtagcZY0ofAQdPdbr3QFLYBrxOEOYFqTN6lN2DCswfGemnbRIHuLgv2Z4agdMJuIYY8yHaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Voebxl4/DcQA8voWRgiWEBplvH3q7171n/a/71SM/Bc=;
 b=aD67uigrz/Y1ZhKBJ18AdcsUNnwfOc5TTVjiyvTAFFc4cjiojkizqRQQS1lPSEspnRtuBNfZH6tWtuQ5cbRZLShTskVX5ijRcOJVqBPlWqJWZ3S1/yGOJEb6lRxkWwzMuTsFA80ePmEH9YEmb+DkxUbr2Rmcn/p3tLP8ebFTYv1jEfcQV+18B6TnN/+emstDFlgRtxbydKU4d+kTTgVhm8vC6xSl7wZXtuRsM3ZaSgrq9zJXVqrTly9gTuIt7/vIUmA29PeK6R9FnbfxNQlhG+JThRWvJbZw0q7GRevuSbN6M3JmdpGA5LlAscuV4LY3XWZ7niUICYViajcPy4Jtfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by GV2PR06MB10207.eurprd06.prod.outlook.com (2603:10a6:150:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:06:40 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:06:40 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 16 Nov 2026 08:06:29 +0000
Subject: [PATCH v3 2/2] serial: core: do not touch the port after dropping
 the last reference
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-serial-core-remove-deadlock-v3-2-899237225221@vaisala.com>
References: <20261116-serial-core-remove-deadlock-v3-0-899237225221@vaisala.com>
In-Reply-To: <20261116-serial-core-remove-deadlock-v3-0-899237225221@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794816397; l=1957;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=9rHnIKmF0zrfnunBh7XA9C6cbJSLablTKXNoWNAnQzQ=;
 b=8DlLOwQx5H2oDWKOEMM2ASN//5p4CKDrF19i+L/k5QPrE1fjDPoXUjdA4CwaPfzdlVGYu0Ug7
 1d3sp31pmBmD48hndyPKZAzxm1lj/aUToOiYX8lwgbtk+eSolbnYRha
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: OS6P279CA0145.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3a::19) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|GV2PR06MB10207:EE_
X-MS-Office365-Filtering-Correlation-Id: bed85478-9eca-4141-8dbb-08df43b88b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|11063799006|56012099006|261021123027099003|261022075727099003|261021121427099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|261009221227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	F0jX4az+5vB+faIrM3r9IU4S76hGpBG/eykxnXLq2bbn499XbNFt//9guf5uAhrLoZLMQTXrC7J/uDoFe0wp3hEViYKKkV8S+lqO6t78zEtw9gWXx8DZE8DmRIKtG7ArXB69lk0Yy8potbPboCiJZWNAyT4hWU6BFeV7ttt1CKCmGw7geLBsDsRJjxLIwrFjFUigaOFs7U17MOyozM+WsHaBuq4XoM2a+8Z1VGzbjLO+W24kNLMRcnGpchZ/toE2naf9pR2z/LC8uob4rRopZ3W553VBWHr4FUA/161CkE/kavM5Cpsvv7BYN30A42jA2TvLZX8T1ynp9NnS1rdmWE7/JDtrO9VpfmU00iY4ZPkkZgcC2oIMN1IpcaMCK3b90NQaqamW41evHubpG3VV3DpcrOQcTyzHPBUwBKvo5kqxcvpLGMvCFPvrztqS4RWqPO25wOjh+F84Ge1eZLM7EpvkBglQwHg3AbBlwVfIHXVOeUC48U8lIwLcXQ5dlCQhxDKNoq7DWwsmWUNLa1wzgTwcIF2Nyip66oO73LbDWPgJ4mW+JrWGq0yLDeqV3XjUzCLAVDO7p/XRmlPXEodmRx9M7bPAHW9eSc7H/XdHPDNoVd5vhlvJJBWXypy/QCAlFeg3vjPuC/rpWN39QWsPEkFhfo73MFZakDbv6bBTrf1FrPzVEq8fc9ojFXfNwIgYYFjkoDB+XT37uaQLRJouQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THU1amk5MjFEdDJqSEpYUGdrY2hEZlN2RlZJbkQ4ZElYNVhaUTNLRUd4aHZw?=
 =?utf-8?B?Zk44VDArbFpjRVZYRDVodFhYajdRVU5pMGhIUHJCamp1YWF4NDN4S2l4UTM0?=
 =?utf-8?B?QUx6eURzT3pyTzBZYTRNYVd5eGNpYlp1VmhNakx4YTQ5YXJzVzFPSCtmT0gz?=
 =?utf-8?B?ckdSRGkrVUo3UjhKOVhyL1U1clR4MFRJTGhRYm83WmJ4cG9nL3ZUNWR3eitu?=
 =?utf-8?B?cGNtTFA0RnZVdFJoRlRRSFgwbWxmMUxLQXZ4c2xyMUk4WWZUVGVHZVQzeUZv?=
 =?utf-8?B?akJaRi9uTlVtUEtlNGNDaEtnZXRORlpwK3JOVmQzQ3ZJanFIdmkxbjJORTNh?=
 =?utf-8?B?K2lQQjJoNGZ1UkVJMG5qSElNR3lSTkVEUHQvb1krM0Y0bGVUM0k4cmJEZVhn?=
 =?utf-8?B?d1lGYmR2eG1jR1k4aUVoOE5JY1BxQ0xPYy9TblQwM1BKY1JocUhVL3h0ZE9Y?=
 =?utf-8?B?eFlIdktDWU56WFpicGtyaVdXVzc1NkphSnE2aGtmOUZleHNYSGVnNXg0NmIz?=
 =?utf-8?B?ekJJTk96N294UC9xdmVSMkFvNWZCRW9iWW84ODVxc09FSS85OUN6di8zMDBC?=
 =?utf-8?B?dXVlVjFoL3ZsUlh2QldvWWhUa2JnSEtVdWlKNlRmUi8zWlJCOHQ5azM2d29M?=
 =?utf-8?B?Y01zN3VlNkNzZ0UrRlRFVkd3STZxR2ZBczhCYzZjYkUzWHFjY3duNHhSZVV3?=
 =?utf-8?B?S2QwOVNiaTMrakFSSnZjQmlkTkI5ZkpZdElhYUYvQUl0aVFLQ0RKU1k3Znlq?=
 =?utf-8?B?TXg0R25uQ2VrZGRwY0Z3NEpQdjAvZ2ordEdrR2ZPUldDL0M3NWxoeS9TcFdW?=
 =?utf-8?B?OGJrMzhVK1lPMFZqdmJrVTJHSkdOSENQMU4zSjRCR202ejJjYmxOSVE0R3dB?=
 =?utf-8?B?Z1c4aUFjT0FMajJYTkQrUVllQWdPNmZMN3FtR1hSdkJsMmtFNDd3cEtjcEEx?=
 =?utf-8?B?VWY0M29PRkd2SjdZSjhDUSs1Z0Q3SFg2MkhkNHJEcVRQdkIxKzdEdW9IQTZF?=
 =?utf-8?B?ZytsUW1Sd29jdUozUFVtTDl4NElnM3BDMWFlRHNlaW1YRUEvMEVvTE5tODZL?=
 =?utf-8?B?bjVHSVJ2TTZlb0NGWGlXTTMrUUNjd0N2VCsrdU5BdmdqMXpLZ0hqMUM5Vmd4?=
 =?utf-8?B?KzY2ZlFiTW5BczZkbWlVcFQyd2xTNCthR0QydVZHWE93WGVPeDFGVE1BQWwz?=
 =?utf-8?B?eVdVVHR0VzN0bjMxSHAxc3pCcjl2MXhyYXRIY2w1YlJyblhHUWJQNCtwMy9X?=
 =?utf-8?B?ZzQrNy94SEVXalpPdDV3OEhvK3M4d0ZSczdmYjVySjFnY05vS0pYTGlVS3Nk?=
 =?utf-8?B?aExxNHRzcnNjWHhwSUZYZlQ2Y055YzVaeWdRWmtXaC82ZStVSGRISisrRU85?=
 =?utf-8?B?elB4WkxnVXpVRUt3bEQwbm9qODJabmRJMlA0SlA3VU5FN05TWUZ2OGxkeEJ6?=
 =?utf-8?B?MU9Cb0Q4MGpwTjBEck1kTy81dWR5ODcwZExHNWZHSEFteXRlNW5qYnZmaWFu?=
 =?utf-8?B?dW1RNmFxL1RZTnpGdHh2V0hGRG1VeFc2dk9FU1dFVC80aUVST0xlR2ZBYjAy?=
 =?utf-8?B?a3BRNmxGRmNlUFd3Y0dFN3llN0t0TjhlQjh2U0s3TEU5cCszOHA0U2JBcTBN?=
 =?utf-8?B?OVpkZ2IzU0ViakpWZjI5aEtibklzQWtsNlFWQzdRd3UrUFo2eS9uNCtCWDA4?=
 =?utf-8?B?T3ZJL1ZndytoenlhYzR2dGZ3R3pSV3JYSkk4cnFXQ3N2elBXVE5nellHbmIy?=
 =?utf-8?B?UTZwd3htK052dUIvNVNTWHM4NXorZ1lrZzZ4N1YvTjkxTFhsTHZLZ2NJVjY5?=
 =?utf-8?B?aUljNXNPb2tzQTFDQUw3Ylg3eVBEYTJ1RERBK2dIbFIwRHRMeDJldE44VHR1?=
 =?utf-8?B?WFUwaStwS1liamxiSWg4YUYvMDZBQUEyNFR2NTRSUk9RZGp1dzhSTjZJZHVm?=
 =?utf-8?B?Wi83V291SE9heUEweFM5YlhGMUpHTFRzaVRXZFhSRkZMaUZuOHdCZ1N6VGUv?=
 =?utf-8?B?Rm5RWUpzS1Y3RmNCWXRpTUFRQmlpZDNXSi9sUmtLRnoxTGQvWDdNV1JNZWdl?=
 =?utf-8?B?Ry9VbThFazZrbW50QTgza204Uzk3WVkzakcwNTlYYUh6TUZBYUFWcjNCR09m?=
 =?utf-8?B?U1NpakE5R2crVGhsSWxrNUxDWmk1UmJlTVdseUtuRCtQNS9jZUVxNHc2eHFM?=
 =?utf-8?B?V0E3VnkrQU0zeGtUbmVBODNMK3MzaUZOQjlZV3kyVVM0VTYzMk0rQnhUclJ5?=
 =?utf-8?B?d01QUWFnWHBCQ3UxL3hmeUUxKzJPUUp2SUtpUW5zc0NWbS9EaHFUQjVlSFZF?=
 =?utf-8?B?THlDNXNmd1NFazRpWXFHQTBoR0FiOUFzSnFzanVVNHAwMVpTRUJXN3dWZUJv?=
 =?utf-8?Q?t7PeWLKoubazHWhA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed85478-9eca-4141-8dbb-08df43b88b71
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:06:40.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5NTQq98I3jxh19WDwqUH9wLQKWwOhYPRG1CaAVMrhQ/Mw20lzDb42PRoNV/tm2VSeDIzWFhhn2xeZmgzd909CjKWx8fCe7YfcjYxFDwQMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10207

uart_port_deref() decrements the reference count through uport->state
and then reads uport->state again for the wake_up(). The last
decrement is what lets serial_core_remove_one_port() return, and the
driver may free its struct uart_port right after that. A reference
holder that drops the last reference can therefore read the freed port
on its way to the wake_up().

Read the state pointer once, before the decrement, with READ_ONCE()
so that the compiler cannot load it again afterwards. The uart_state
belongs to the uart_driver and lives until uart_unregister_driver(),
so the wake_up() target outlives the port. Drivers that unregister the
uart_driver in the same remove() are a separate matter and not changed
here.

Found by review of the removal path while fixing the deadlock between
port removal and a blocked tcdrain(); not reproduced.

Fixes: 9ed19428a51d ("serial: core: Prevent unsafe uart port access, part 2")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2e53d194ecfe853ade1ac6f33e047eb8ff11e283..a6dfa90aba34c8e6ada1c23d25a9e7d0d78fdea9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -72,8 +72,10 @@ static inline struct uart_port *uart_port_ref(struct uart_state *state)
 
 static inline void uart_port_deref(struct uart_port *uport)
 {
-	if (atomic_dec_and_test(&uport->state->refcount))
-		wake_up(&uport->state->remove_wait);
+	struct uart_state *state = READ_ONCE(uport->state);
+
+	if (atomic_dec_and_test(&state->refcount))
+		wake_up(&state->remove_wait);
 }
 
 static inline struct uart_port *uart_port_ref_lock(struct uart_state *state, unsigned long *flags)

-- 
2.47.3

