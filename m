Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160032;
	b=paVyX6gX7gMxVE9mZPOtGdpSKsEiBRSFSDSEHX/VDgy6+oVp8QHN5cIdzLgZUsUTAGjH
	 fhkNUUW25/dtN9u6v3HJL66EMRPfSs93817lNpY4AakRikUMm611vxrGEFK64s0WuPEgS
	 D/fTobzvXfVg/wWA+TS/uPDlGQ70W3vqTzZnPBF3Mx6XYEE0YhBmG7y2AWu/CSTT+rMdm
	 UL3SWg2I0ZUrcl6XGKfR3kMI8g6J/mh3uclXMfQHfHBMgxlK9gM/gcqQ6Pm+21HssD5BG
	 x/OojVQ3H1p50uC13ffK3VhOyZifacyLzLDG7evQM3hTkyhhqvXD8R/F64Ka/2fIcrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160032;
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
	bh=gYPsKINvDJ2u0xLIzGRED4W5rKZDiL9dJDfiJgAs2dk=;
	b=kaBk1RH6vUd9Z50OQRpndtYhkpDjv1yBMYKQbHH52fCDQaL5qFCYFOy7TiciaXkMOZFy
	 11rXtKiMIBE46IdjWnw1hNvOqjBPOhEfuI5GBGCGLUYujNVmz4xyV7aRY9rYWYTZ9Y6/c
	 UdopfqZhB7kVIWh/BCpigwfoZeohov0IzxXMJ6giSlRjBq5JX1ELp7apRCdu5iJODmX6r
	 U1rQ67hnEFUvPODymnof7JvZRgd2h9GRW/vpmmZaOaP2pMJhvx/WWrYXPbhq1YBV7oWIr
	 OSVNCiwUSCRH7ZD22Df6eE4yIAMTdAkO9EyXSEVEJeWs4z5VnB1wFUEVxgw8wgkI7pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=kdaAf9sW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB195606A320;
	Fri, 20 Nov 2026 07:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB195606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=kdaAf9sW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5RZqIbpTbe5eqhHZ729y1A9/LVoLDEVV9ujm439QrGxhcDuFhjbyhV/PbAHBMtWl5tkNLHcKU98XK/tcI0jslbQOGFetcfvnj1y688DRbW8FAwE3vznKW9EZFdswaQY2sCdGX/i8PxOMZSRJsXJ2JvJoRWiWhcluKGgSuwKP4tev9qAp0sy/RyRMzMWeklevTQ/e9C8nNie+5xPSzHY9N6qkzUNy6W2ZFVWkusNjaIkjplpjPcz4aiuBF4e7suK3ZFQP+zK/KFHIuWfQnsyuZdpG9ir195fgDtN05DtJNx6bLEtUkS6IAQgFJVFpdzaXOyHrK9/3JpGVz/DQmaM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYPsKINvDJ2u0xLIzGRED4W5rKZDiL9dJDfiJgAs2dk=;
 b=QPo28tBOHXW1sirLYOQqAgMJRdxuG2iEUX5RihSR4gtPFqI01Ra359GdEqtdQgZJkTgrl1vB8hcY6itGt20DHqBk4ChbiqHL1Te+Ufu4X8qlSWNe2zYTH3SWx3/J6IZsAimAkBg/2VnuuC1iuRNWRuf3wsjPxSbIevRE/uNlvWW5BDUSjA/OSOnV42Ine+ZFK8ecjMMs9OgFKjD0fxKH04pN4WkT/AZ05MAdZGErqwsyFVB/r5pxIVwWoJUQmYr3ANUgEumfxOSLkwfFxeR14TCe4TNiVULeuzHSSumOEyoF74XQ/HiiWv+2zLsy2OR2eqTNfyXBQwYvi1p3r0iB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYPsKINvDJ2u0xLIzGRED4W5rKZDiL9dJDfiJgAs2dk=;
 b=kdaAf9sWAT8mEh9o3ueK4zkz+ruoa7iE3sRUe3RLGzMuIWe7rM+GiyX9L/v4uqF9x7haNOiaNF1Hl4I+dDfKYm89kaob+4CHa3B8wNrj0Mk2pWBaGBxE8P3/e6t2ZN0vTn06nFJxN6uUl8LrmwfXRp7eZotp6UyrpNFeVWwjAATpyaCWb/Ero3/DBv14C2iAn5Qe60sUXARqnPpFa8wXtu8SvcTEFBqTYBNgrkhrpp8rLJFTjiiYu+UJl81oIwMIOFRAiY/dM3W6VyTUTTpIQVaFO6Req94CFEjaAt/upHjRJOLJDwQCBYhZh/UQrEOvTCuBeiSftONol0YNA7423g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS1PR06MB8539.eurprd06.prod.outlook.com (2603:10a6:20b:4dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 07:33:39 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:33:39 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH 0/3] serial: max310x: teardown ordering and CTS locking
 fixes
Date: Fri, 20 Nov 2026 07:33:29 +0000
Message-Id: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMn3/2oC/x3LSwqDMBRG4a3IHXshj6rVrZQOgv7qHZiURNpAc
 O+GDj8Op1BCFCSamkIRX0kSfIVuG5p35zewLNVklOm1Mk8+XLZaZT7h4hJ+nlfJSAxtx8c42B6
 dpTp/Iv6hvq/3dd3N5MrUaAAAAA==
X-Change-ID: 20261028-max310x-teardown-fixes-e13949736e53
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795160018; l=5186;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=umTxtnyjgpwt46X22/giLFCz1Aq1Rtt7JkhNbpmbWR4=;
 b=QanyaJ6QB5cV4YlsGFehvTYt0dBysXBdbsLhWASDefpEim2rvCrvfLcKYl7yUM+bjfx7fBGNj
 TM0VSUJTP7jCiPbAHSWUQqxSW4CHYsjwkMszv9qDJWCRUVN0sFUGXJl
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0017.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::15) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS1PR06MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1f6e18-6606-4912-3ec1-08df46d89832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|23010399003|10067099003|11063799006|261022113327099003|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261102123227099003|261028144727099003|261026121527099003|56012099006|18002099003|38350700014|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	EdJSrt/S7JxK4Rc4svRAdj2W5C4V/qv6HIk5+e6BKJbGYtV2rhIM2qHsyjWjM7xsl0bRg3K8PWaNfvTg8s7x22Oz+HpFcH2nIaxb+Nq1SbLSmR7mIRL47EfVJrDUDVuUfI93AT5hCJHnomSa1OyqTGZiiPTAHBa4aN3G2sRiHBpd13HFfsWkUitZwVuIcL4Vf5MT61r0fHeLeHAlCbkrTs5yTz84ECi9EsQ5H6gQLFFQDxCjWYJoyI45vdQhFDkUotsDX2m9OFLGg+3Y9MBzG5Ox+CLxgRWOwyzfXllHUZOG6NgBA/1G7cdgE+cE5zgAF6BTN5ovJm4Sphvq/q0sbneo21WmRKSlvCGFSjgvZ3cFAFSN5HL9dNVHFu8xfWalPI1o7ecNhLgbxoiMr7c9TjKuNKdlGokTRdQ4sQuL94lICCmRuePk1wyIuhgecZDyQokYIcm0jI9UZ/INT4h8RTZSCU17Ohsv3zPgPrFkvFOQc2xC4K6MT06fyr3hcDULHsOElVaBRaVc6t6r3zipxILZc24IiRiBNVUZi8epBPBUXShtUs1viEQAgEaO1mT1W7idYTRvfERRTxpW56q2C7oJr/Cvj8fQVORv696F4Kyv1kf82TNdsQaKWrE+vr8cLtoJlgU/ZjvRnxFlVJdrmwQNxCM4VXkqVUcxSlyZRVq2LfV/rfZ1W0w7WMKl9c9bbdzMxFLWF8Sv+EJoZXg0zg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(261022113327099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261028144727099003)(261026121527099003)(56012099006)(18002099003)(38350700014)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzIzTXJBcVowVDZqdmRPM1lCTjlYRWdpdkVSSmFIcEpMcWsrU3JLbXJVREl6?=
 =?utf-8?B?U1dYS3ZJRGV1aGFIRkR4SmlFTjAzYXNndkVpckgrNStXTW12SXBjd0lDWkVs?=
 =?utf-8?B?TlAvaXJRV0JZTmY3c1hmWUQrM25sK2Frd0U3VjRnNGI3MDFBTENLb2xJdFpa?=
 =?utf-8?B?NjNHMG14bGVJOXZUNE1wOSttOWx0Q1BQZFAzS2sva0I0YUtWSTJsTHdpVjZy?=
 =?utf-8?B?NHZlNnhqbkZZOWh1c1pNSGtucWlCb25WSHFVMVd4UFU0YmN0QlZFczl1T25v?=
 =?utf-8?B?TkZnR2dSeW5RN3l2ckNPdmlWS1l3ajdkY1pwanJ6ZXJ3d3dsZkZ1KzUxZi9k?=
 =?utf-8?B?dExhYVJIQW5qcGpZU1lyand1S01Pbjg4Y2VXMGd4VDZiUzF3aTV2a0V2d2Iz?=
 =?utf-8?B?cjdDb2Izdnc2ZXB3K1RTLyswaUoyWTJTV01lU2Q2U3ZmcXduWTUxVjJuQ2lE?=
 =?utf-8?B?cnFrN0g2cGJCOHBpVVVoMWFJaTBGYXdIQmcyMFg0M2hGOTVXTk1kYmY1WnVu?=
 =?utf-8?B?NEJObkhIT1FtUVJIbi9OUUozYUJVU3lsVXpnYUxOZTJRcTBtMEFycDNEOFVD?=
 =?utf-8?B?TU1NNTNldE9RVGIrUVZQWmN4eXhNK0xvdVAxWDZqOXIrMjkxcGJzNUZheVhU?=
 =?utf-8?B?TlN2ZEtRVE5EZ2pMWUFaUlRNRmQ1UDZwZE5SZExEVXYvZ2tZd01OZHBIU0Vi?=
 =?utf-8?B?Zm5SY1VvTjJXWHpSZTF2ZDB5d1V2ZC9lMGJxZjdMT0dRY1NFVHIvS0V4Nkgy?=
 =?utf-8?B?Z1JWQTFLdmlIVWVuYk9CaTVzUUhuU0FsSXp2RFMzaW1WcGg0ZVBndTlkNDhF?=
 =?utf-8?B?VmtITkI3NHB0QlJzdkJoN0pNVFBZWXYveUZ0enAySUs2QWVvS0tWVEtrSkNx?=
 =?utf-8?B?Y3BURDAwamVmUjhQV3Q5dzU1aUNIOXRHS3pQcy9NZlFaRklNMDZ5QytTQkJn?=
 =?utf-8?B?V1lvRVZQNnhmdGg2d2txQzN3eGVCemF6YkZHL3I4aWxPc3hETEUyNktZM2tE?=
 =?utf-8?B?UG5iRi9EbkN5QTh1ZlVoUDhweGg0Zit3bmtNK1dUemJzQndLcHY4a1pINXJH?=
 =?utf-8?B?NU11OWVBWmg3Vmt0U2h2VVFCeER4OWJ4SFlQNmtSVW04Z1BaUVArQ1c0WEZh?=
 =?utf-8?B?SXVWUUErYmlTdEwvWWtybURGWUFtOHZTSHhicmNIMk1vOGowbzJBcERmQjZN?=
 =?utf-8?B?Um1sUzFDTTEyVUxrQ2VmQktLaDlmR1RPTGdQU2Q5OWNoaWZEcjdMckp1VWls?=
 =?utf-8?B?aHRxRm45RDhsdWprbHNlb3ZrU0s1Z1BRYnUrNG5pN2FiNFdaeFN4bTJyR0lk?=
 =?utf-8?B?NWw2dDV6anhuS1ZUdFhBQWRKK1dQMzd2QzZaL0JHM3M3clZWelc4RS90Mllx?=
 =?utf-8?B?Z2dzUUJ5ZE5TUjNaTmJCeHNxQmJpTHVURmVHaURIVlNyL01GWVlRcXI2by9h?=
 =?utf-8?B?ZlRDZVphbmMybTlzUDdtd1FiZVJmbkJVZFRIQW5xZjBTWUNNUkFyU1R4SEJn?=
 =?utf-8?B?bWZhTnVaSFlBZG1KdXhqdDhHZ2ZvTFh6RXpuU3ZsUms1NUpwaFVVb2lTYmpv?=
 =?utf-8?B?ZUIrRm9hTkRYNmFXZWdUMk15V2I5QTdDSE13MHU4QkRaZDFtOHlUSU4wNW1F?=
 =?utf-8?B?NkYxRXFsZGtEOTUvTEZmNGpJTWFVOFMzdUd3cktBMGI1VFQ5SXdqQnV0MGdL?=
 =?utf-8?B?WERhN3J4QWFRcmxFdEw1YTgrTTVjYU9NZ1Q0R2VxdGtsNmVhT0pzdVdLbDBW?=
 =?utf-8?B?NVpzQ0oxY2NySEFIVWtFR0tiWS9XZDR2Unh3SmpPQ1lhcW5CVVRvL3FrTXlz?=
 =?utf-8?B?TGY4N2VtM1FOcjluWlRnTTNyQXYyTE5wcWhuVStMdmdDRUJTc3VUdnQwUmdP?=
 =?utf-8?B?Q3EyK2JST0pFS2pqbFNaQ2VGMmZXQVNhbU1TT0lqdHNoc1A3a3dFSSt1L3RQ?=
 =?utf-8?B?VHF1bEpoVEcyaDUxMlMyaU56c1ZjbjNHa3ArWm1sOUZDT21UU2RYekZaZTJC?=
 =?utf-8?B?NzR1MmN3d0JjQzBlTnNnNDNpZm84ZndqMVpHWVcxdFdzUTJvNEduR2x4NVJW?=
 =?utf-8?B?aTdGUDdhY21nU25jMlFWUFFiUHhrenJjZnhLOFdubm04c2h4NFdHMVdlU0x1?=
 =?utf-8?B?VXNrZjUxdTRVSEoyOGxiY3l3OG5td0E2YXJpS1l6V1hVM2JrU1RPMnVMVnlz?=
 =?utf-8?B?dmZEbytwcW15TWFMZWpuMmFCb1FKOXE1K3QxYm9QSEQreE5PR29HTHVadmFa?=
 =?utf-8?B?NW9OK2Z3aVgxT2ROZE8weUk4a3dkeE5nMTlQTEovTEgrUndOcndZL2dGak14?=
 =?utf-8?B?bHNoV25vR1pTdFZFaVprUlBtR3NCSkVITWp5TmN6em9Wd1BuV0laeFBtVVBw?=
 =?utf-8?Q?3bQryuxWSnVd/4W0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1f6e18-6606-4912-3ec1-08df46d89832
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:33:39.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mS5dVrxU5Pc9lHpWV97AN66vfFsBNkvYl/2bRA2wjaJchW/iY/RwIKrlP6oKWKYHu2QoVr422mtR5Sb0KU8l9H/4mAJq4UAgqs9UH2uBooo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR06MB8539

Three fixes for problems that predate the RS485 software-delay series
and were raised during its review: port removal cancelled the per-port
work before the IRQ was freed and the port unregistered, a failed probe
left queued work behind and could mark another chip's port line as
free, and the CTS change was reported to serial core without the port
lock.

Tested on two MAX14830, four UARTs each on SPI, on an ARMv7 single-core
board, on tty-next from the 7.4 merge window with the board support on
top, all ports in RS-485 mode and one switched to RS-232 where a test
needs it. For the teardown tests the kernel ran with PROVE_LOCKING,
DEBUG_OBJECTS, DEBUG_ATOMIC_SLEEP, DEBUG_KMEMLEAK and init_on_free, a
500 ms delay was added to the work items so that a late one is still
running when the port memory is freed, and the probe failures were
injected through test-only module parameters.

The first fix was reproduced that way: unbinding the chip with a port
open made md_work, queued by the hangup, run on the freed port and
oops; with the fix the unbind waits for it, also while the other chip
carries traffic. For the second, a failed IRQ request after all four
ports were registered waits for the rs_work items queued by the RS-485
configuration before probe returns, and a port registration failure on
the second chip leaves the first chip's port 0 in place; a rebind
brings every port back under its original number. The third was checked
with the chip's internal loopback feeding RTS to CTS under
PROVE_LOCKING.

The series then ran through a scripted campaign on the same board:
unbinding a chip under open ports with blocked readers, TIOCMIWAIT
waiters and a draining close pending (80 cycles), with sixteen
processes opening and closing its ports nonstop (100 cycles), and with
verified loopback traffic on the other chip (four one-hour runs and a
two-hour soak, 1250 cycles, no kmemleak report, Slab growth under
1 MB); the probe failure injections with openers racing the node names;
lockdep stayed enabled throughout and no warning, hung task or stuck
process was recorded. Two bugs outside this series surfaced in that
campaign and are fixed separately, this series does not depend on
either: serial core's port removal waited for the port's references
with the port mutex held, against which tcdrain() on the hung-up port
deadlocks, and the driver's TX work advanced the transmit fifo without
the port lock, racing uart_flush_buffer().

The teardown tests were repeated on v7.4-rc3 with the same debug
options, on one chip: 100 unbind and bind cycles with sixteen processes
opening and closing the ports, 100 with a blocked reader, TIOCMIWAIT
waiters and a draining close pending on every port, and 300 s of flush
under transmit on all four ports, again with no lockdep, debug-objects
or kmemleak report. The probe failure injections were repeated there
with two chips, with either chip as the failing one.

Patches 1 and 2 are marked for stable. On stable trees without the
software RTS delay code the backport of patch 1 drops the rts_work and
tx_delay_tmr lines. The IRQ change in patch 1 also covers the
single-port parts, where the handler reads the port status on every
event of the line; on the multi-port parts GlobalIRQ already hides a
port with its interrupts disabled. Patch 3 is not marked: the driver
enables the chip's auto-CTS whenever CRTSCTS is set, so serial core's
software flow control path can only be taken for a CTS edge that
arrives while set_termios() is changing the flow control mode, and
serial core recomputes the stopped state when that call returns. In
practice the symptom is limited to the lockdep report.

Not addressed here: on the multi-port parts the chip-level IRQ thread
does not return while a port receives faster than the thread reads it
out, and the close of another port or an unbind then waits in
synchronize_irq() until the traffic pauses. Where that starts depends
on how long a register access to the chip takes; on the test board,
on SPI, it is a continuous stream of about 19200 baud on one port.
That predates this series and is not changed by it.

Two further items noted during the same review were left out as
improvements rather than fixes: tx_empty() reporting the transmitter
empty one character early, and the refill size and x_char ordering in
the TX path.

The patches were written and reviewed with help from an LLM assistant
(Claude), used for code reading, review of the drafts, the stress
harness and the reproducer setup; the analysis, the changes and the
testing on hardware are mine.

---
Tapio Reijonen (3):
      serial: max310x: fix use-after-free on remove
      serial: max310x: unwind only the registered ports when probe fails
      serial: max310x: hold the port lock around the CTS change

 drivers/tty/serial/max310x.c | 62 +++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 18 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261028-max310x-teardown-fixes-e13949736e53

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

