Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010006.outbound.protection.outlook.com [52.103.33.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51903B811F;
	Sun,  6 Sep 2026 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711326; cv=fail; b=YYDBpZ57Hrr+uqV/Wi4HcTz2+9DUcUsKT1uT15uhGygXY56zfC7s27iw4JYgEaU+tNB8wwxyy44Op8azqV0c04PErbphpYywjzOWGI/zhdOS4NqPRF6XR3aItS10bHrN32jdtY+KsOKLvdIi0SRKd91aQ3ocHzabDEXE446tAGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711326; c=relaxed/simple;
	bh=Q5fpQbzXK5w0l3bSpq2POTUf9oe9YGJfUDSVeuJ3bnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vre9fsrM3K20sUKgaJrIlfICAxwQKv5CILEHbTlkqORdSb47pLvvYTiOAJCPG1DOMBmVCCzSnxn3LYR+/BN6BaMPmkisET36elkF/JO/+gSxeVVgadhRQwHlAAzS461oruAZNtRTlPUXpilXdiRMyGb4DmH9tTgS18GHQWJVVLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.it; spf=pass smtp.mailfrom=hotmail.it; dkim=pass (2048-bit key) header.d=HOTMAIL.IT header.i=@HOTMAIL.IT header.b=bWCgH7LA; arc=fail smtp.client-ip=52.103.33.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.IT header.i=@HOTMAIL.IT header.b="bWCgH7LA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY8yGueePNV728ojBetOWofSrAel7mJF5nZ6CiyphtPDy3sAUR9L5pDgzTg5+pCLiXT3m2Gya0CY8qdUZaYZNJR9rpGv4tnOvmL3WTFrkvrz5rVKd1+c4XDCcAmk2kUfoisL6ZAMJh36zTNZO4BZRnlEjPlMh5lv1Rk3FXV6/A67vUrNGc+C5JmDMs1IeWwAhTCKdgTjOxppoR3VGTF6C7pQkh5IMeRwhlbzEmKtiQI0Ly2Zf31SdQ1hoJLVEFyRnR/SS3uHV9RpjzcXy0xAK8A2ZWNDtfjv38g8TlAnkZ9qmoeaaDPDX1ypiEju4mAKBX8SUmExo4bUwDhZuSO7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDv57iVSgzFt/LJETA0Ytf8DEHcX5660xACMkIUWD2I=;
 b=rOmxfn9bZnLvnseFPew6DE3RrptQ3UqNMe07QJ7Kax7kQd5dTdVVn0bXyXxtznSmNZ1YFyJCG7mJL+4hZv83dVZY7QpvdEoNiva7KrRL/BpSYYRiTkKaXYQLe4R1BMMueDyFmsyYgporQQB3Jcpto0r1Inl3UORgwh/YUK+eDOZwerdphcyuEbnqzv0bYXPMy54jnccHtIV4mL7FokGHPVwQ4CnB8PcCrnqZFmzGMn1IGCGHNTZUYUikBzGQY1YUDVkdbhyX+8T4FKbZUA1vVxgHLH3dWRkJrfYQgGTbiGgnqbNA5Z8TTOLolW5B2PB0dxu12jItkRttE+dei0n2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDv57iVSgzFt/LJETA0Ytf8DEHcX5660xACMkIUWD2I=;
 b=bWCgH7LAOqDxsfiqPbVrgWU4BIJpIDBtJ3IgzywsWLHh8K+lgaioF7nu6pwbEjvr88a5Zbf6DlZw5me/W5acMquIiqalDRy+Dqh2lrn1iKt310fNNSJfMxA/egCTq7jF0JbNxTRE92w8MYDk4mJgg2/5e1syHnzO8PPVsEukHblQs5RQTPU7byEhHVgCQkbVv/CQC8ssvVQHBiUBSvrHgPyLA4eWUIz4NDuq/hNpiyjPtsLnMvqv4caY1A9ePx8cX4TkHusjcM+1Jg3Tm+v1PWno4vDwo/+kfAaxlYt8LI00AVIcfvfMXOPHRCTiGA3xXj7bfMuom0747FBG+JQ44g==
Received: from PRAP251MB0706.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:294::21)
 by GV1P251MB0747.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 16:15:21 +0000
Received: from PRAP251MB0706.EURP251.PROD.OUTLOOK.COM
 ([fe80::830d:4c6d:e6b7:769f]) by PRAP251MB0706.EURP251.PROD.OUTLOOK.COM
 ([fe80::830d:4c6d:e6b7:769f%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 16:15:20 +0000
Message-ID:
 <PRAP251MB0706AC6BDD84A9904592BCBFE6B32@PRAP251MB0706.EURP251.PROD.OUTLOOK.COM>
Date: Sun, 6 Sep 2026 18:15:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
To: david@ixit.cz, Joel Selvaraj <jo@jsfamily.in>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>,
 stable@vger.kernel.org
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
 <20260906-ebbg-ft8719-fixups-v1-1-4e846510cad1@ixit.cz>
Content-Language: it-IT
From: Marco Mattiolo <marco.mattiolo@hotmail.it>
In-Reply-To: <20260906-ebbg-ft8719-fixups-v1-1-4e846510cad1@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2PEPF00000B7A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40e) To PRAP251MB0706.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:294::21)
X-Microsoft-Original-Message-ID:
 <1d7f927f-09f1-4cce-85af-683ca148f6cf@hotmail.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRAP251MB0706:EE_|GV1P251MB0747:EE_
X-MS-Office365-Filtering-Correlation-Id: 268cdcec-f285-4bed-b1ec-08df0c320c16
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|39105399006|22141099003|23021999003|5072599009|15080799012|6090799003|25031999004|37011999003|19110799012|8060799015|4140399003|25010399006|41105399003|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3NXMGJzcDBZMDdKbEM4MlNEL1NadWxMZkdjUTVQNFBhdTlVR1RWRldMNEk5?=
 =?utf-8?B?MW9QTENpeXpjeGFDUUlIN3NnazFneHV3MEZlaWRyWk16RVJlUG9SQlpYQng1?=
 =?utf-8?B?WWFSdE5BWEFacC94T1BUZnhUamdUY2w0VmJkUVN6QXl1SmdVcmowUDZjWFVT?=
 =?utf-8?B?VE9oZkV3ck9LeXR0SDFVR084bGF5ZFR5VXNwYlRobXFzUjErcU5mb1oyVTRz?=
 =?utf-8?B?VDY4aDRpM2p2MlBKa0NXRlJTRWx1WStnejZPdDk1MGhBVXdKWGtRbUpRYXlk?=
 =?utf-8?B?SHNYU2toeGFQWUlQV2pMYVI5RFpSZ0hDaTFMOXA4SlVJSWZMR0xIQTJoVUwz?=
 =?utf-8?B?SEZXQ0J6ZGlTaFBSNTkzeGZaV0ZWSGJYc1N6bUxVS1BJbUhiaHlYZnVEVW9t?=
 =?utf-8?B?QjNVZ2U5TkJDWVhzNXdURGVlNUxuQmN5dXNNSnhPQUtweWxRQk5vdzU3QmtQ?=
 =?utf-8?B?ak9SMTk2VlpheHBSOFVISWxEb000RHhuNkdVNDBOUW5XYjhhbFByT2JNWHh1?=
 =?utf-8?B?RUJFSjdKUHFwS2lHQURydDZ0K01ISExxeWtOQk5NSU1JUE01b0hya2M1a0Rv?=
 =?utf-8?B?WHlWV3NYMG43VEh4c0QwNS9pUzVKaUx2SXRYQU9RT2dNb29FYzNtRUxMb3Fy?=
 =?utf-8?B?dCtuMzNSa1R3QW01RHNNY0pLUUxLc1g5dzNtVzdDcm54RHdHZjkra0NtWjh5?=
 =?utf-8?B?N1NjRHY5a1BReEVyWTJ4anNkaHYySDQrNFBzN1NVNHdHNUx0dEs2UnVhQmw3?=
 =?utf-8?B?Rm53S3BWN0pHa2V0RnVWbW1JL2FQZGNHQTgrRUo2SzhIdnNvcjR4Ny93OHc2?=
 =?utf-8?B?QW9pYlpBQlg0NlFZODdYNkhBTkluYVJjWUpZMi9WTisxQlJVbGRQNmJydlpX?=
 =?utf-8?B?TmpsWnRQd3htK1RvUDdyWllTbkNLa0RHNDhENm9mb1p2SGhWQjRaTEtHdWQ0?=
 =?utf-8?B?MFowQTRYSEVGVHdSOXBmU1NkcDA5Yk8waHUxR1liejFpaFBSR0xmMnlQcUgw?=
 =?utf-8?B?RXhrNE9mZkgwOExnY2Q3QjJFMm80S1BZRDJRb081ZGlPYlVnL2I2RERQT2dD?=
 =?utf-8?B?MnZiSjJoMDA1ODFva1pKN1o0NElUMXE0MDNmQSt0V09pL1FNNm5JU01UdkNl?=
 =?utf-8?B?aEFyd2Ewbm1xR1MxTFkrNm9EcExQSG82bVZLanNzU1FvQmxXOVh6a0VWWTlh?=
 =?utf-8?B?eHhNbGpQb0NUVnFkQ2ltTXlmSUJnZjhKOWd0OEYyUWVLNEtDdXByaXloV3gx?=
 =?utf-8?B?VmRZT1U4UUZzaUxwZGxndDdFY1BmdTBvVzJjQnFJWnZma0Q5SlkrZDRyY2dh?=
 =?utf-8?B?cHBITkRGekhwK0dEYktmcWtkb1BCR3Z6ZDN4TjJyUzFPWnVFWHQ5R2tZYnIw?=
 =?utf-8?B?cnZrQTNDelA2Z0cvdnFJaE9RUVJ0QnM1aVk2YzFheXJFbW5oSnAxQ3dsTkdE?=
 =?utf-8?B?c1drcFFOKzE4eEJJQkhsR1N0TUo3R2ErdThhMEpRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnZha2F3bnZzOVE2SWllTnEwM2pqRkhtcmR5aStBc1pmZVF3VE14UG8wS1Zi?=
 =?utf-8?B?cjdPcEJCWkdFeDJ1RlcyUmRLZnhCdThsOXgySlFnMkcwbmlxL3dkRWRKZzl0?=
 =?utf-8?B?M2lnZzFNVm9HYmZscXUwUCs2b2xiSTFKdE5UTHRXb3JSWXJ2UWtqM1NGRDVN?=
 =?utf-8?B?bVVzSDdOekJWdzYwTmRuTVd2RG1LL3dFbGVxd1kweVFGWjdpVVpVNlg4Skp5?=
 =?utf-8?B?Qjl2YW95VHBocXFFbmhZaEhkQUNkODRHMGdQai96Ylg0aDViNXBqaTdRaWp2?=
 =?utf-8?B?ZXk1NDU1T0VHQ3VOTVA5Y3BPUE5pdnAwMzZBOGZOaEp5Ym5FeWFaQXJvQWVx?=
 =?utf-8?B?dFQzRllsMTdoQzNzc3VISHlVMlN4TUpYV1ZKWXJhNVBLYjVkaUhTamgzNHN3?=
 =?utf-8?B?S2hZSzdYemUxUUM5TG8xRTFqSGtoV3g4blhKNHNNT3dBL01xTXNpSTk2NXJY?=
 =?utf-8?B?QTlQSDNOT29BdVIrb1lIQTVneVdmbitqSENib2VmbDhvSG9CQmRWdTVISnlS?=
 =?utf-8?B?UUJmbEhqeVZWOXVIQ0pDOG0zR1dxUndFa2JDd0FFYUlqczlNWEt0NXFKS0xU?=
 =?utf-8?B?Z2pEVVYrN0ZVYnQ4RjY2djVuQVRpS3pUNmdJdkNRV2JXL29qZFVvb3BIY3E3?=
 =?utf-8?B?aDQ0V3dITDQ0U29VckpQM2FOVnM5S3QrVkZOUVZVVXBWNks2cU16ejFZcys0?=
 =?utf-8?B?Q1NtVGc3K3JsY0tFKzhUSWpPSWV5MXM5Q0dDRVQ5cjVTN2pvS2xJVW84U01n?=
 =?utf-8?B?bmw3SUtBTlNlMnoyWGRhZ0JKcklpZmFPQnY5SGJBYzg5WndWSU5SZWQxSy9h?=
 =?utf-8?B?OG50UFFrRXhSRVE5TW95b2pWMFJPalYzMGFDUjZTN0FBOWVQeXpOS2pCV0N4?=
 =?utf-8?B?NWpQeUxHWmZGVjZLY1JhN1dpenpJTU1XUjB2eVdEWlFEY1RBZDcvOTNpRVUv?=
 =?utf-8?B?aHpiWmhRYURYN1hVcFBWcW10WGNZUVlUMHg1Umh2Ujdxc0Vld1IrY2tUeFA5?=
 =?utf-8?B?NXA5SjIxUnpqQkxjUUdZZW4zajk2V3dleGNURy9ZazgwNndPTmZLTWI2OU54?=
 =?utf-8?B?ZXpQVXcvUzQ4aW5SbWFJNFpLVW0rYTZ5ZjJHU2ZXWGg0bFRteXhubTM5QVMr?=
 =?utf-8?B?cC9RWFg5TlFYZzgyMERvenN6eVpOZUJlTkFCWnFCMkl6eGd4cFJJLzJKU3pz?=
 =?utf-8?B?RGxrcFU1WWxCMGV3dExXLzFFTEpERXdmNk5pTjJkZ2JwV2RwY2FBWmFYaEZq?=
 =?utf-8?B?U1pwUFBjTURzRGdBRUp2NCtUOWdZK0s4ZUxHTVY5eXNLU2UxdHVDd0hxZ05L?=
 =?utf-8?B?MEZNc2JyMlJibTJUOW94ZEdwYTc0T0ZLUG5mTWp4MUJoRWdEa1NOeE5SWmFO?=
 =?utf-8?B?TUlPQU8wMmcvWlVyd210ZFRqKzZsNmsrWmI4U2RaK2VscUlYbUJoQ3BsU2hF?=
 =?utf-8?B?bE40bHJ0NEprbFdBWlJnMUZnSW9MR1QvUmtscXByeHNqVGRWYW5SR0Jnajg0?=
 =?utf-8?B?MERlT21qZnI3MTY2Qjdwc0YrRVBLZ3ZXTklENHREZU5wbVcwelVGSmJUanly?=
 =?utf-8?B?QXN5MUpVQmc0ZDl6eUhWa3RhNEVDTjNzM3V4K3haZDVZM1pTTDZuVndURlBC?=
 =?utf-8?B?SURITWN3dHpiYVRHMUpOa0Z1QjgyZ1pyd1gzaW9UU0FZZGR6K3AvYU5iUENX?=
 =?utf-8?B?TU9DK3c0QVhxVGJzOGZLNUJPL21IT05BUUdTZnFRQ1dYMjV1enM3a2pmMDRy?=
 =?utf-8?B?UFZ0YVIyaW8zMXlrcVN1M3VXNlNhZElSUXBvb21EdEt5bm5ZaWVvZ0RuTjZa?=
 =?utf-8?B?RWoxNWJCakQxWTBBOFNaZlZLaWFCT1RpK3V0Sk5MWU5GTW9rTEpseGJSQ3hW?=
 =?utf-8?B?bm5Yc244V0dwb29aVGR6NUF2ZTViTitOd1BtcFhtL3NHeUE9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 268cdcec-f285-4bed-b1ec-08df0c320c16
X-MS-Exchange-CrossTenant-AuthSource: PRAP251MB0706.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 16:15:20.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P251MB0747

Il 06/09/26 3:19 PM, David Heidelberg via B4 Relay ha scritto:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> This corrects the host initialisation sequence so that we can send
> DSI/DCS commands in prepare().
> 
> Cc: stable@vger.kernel.org
> Fixes: b00de0e237da ("drm/panel: introduce ebbg,ft8719 panel")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Tested-by: Marco Mattiolo <marco.mattiolo@hotmail.it>

Marco
