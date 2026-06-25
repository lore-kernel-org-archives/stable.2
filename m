Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020109.outbound.protection.outlook.com [52.101.69.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3D3D9DB9;
	Thu, 25 Jun 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392384; cv=fail; b=MgnlrBK1DVFyz46tg9yKtYmecXNP926XfAN4rCTLX8KefEusuwXm5nj/R8SQhD392giaapNAKPeMGsu4xxM1XnoNsTaNF0jv24veENMwrDMyeu6zSSsKuaY0mH7iCg6/qxdyHVelNmkDb/VYAs2LsxWitnexG+o6gDiS10X3NcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392384; c=relaxed/simple;
	bh=UZVXxLtaYCJkRSEaCgf/fXl185IQ5fQC7z9301GH9UU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sDZ3KUyPtKw21f8Eg9iAfXn9dK7mdTdkOGPT5r1fYqR3fKuZJ19Ma1O+StJ9oytQEhpGqFdTIIzweLyqpunR0z3QQT5qPjuKFewePHbfxvCSxI/nMXYjVQg5lADO3z84uwEzYoDcfuvdkxfiHIKSLCguVtQ3Xd1YYklKjll2+Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=iRF4Sm2L; arc=fail smtp.client-ip=52.101.69.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="iRF4Sm2L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8jT6TYbjbgQe5o9LXu3jQSwJP1TlQ4mfrL7gjtP9rpO53yPzEeL5iqYnDS4n4S/N+bjiKC4ZVakZkqEcaFoP0YdA+LlAxhUIPd5MWz6L+JZ0YwYySnb+PyC8DkLZudLHM/zbMLUkdNevLtXRkOkPhsyo40T1sVhasjZBVbwi3daspE4njFReeyyCNjJot0x1s5ZcDSfoJPye0mktVOcY/VEHj+/8bXKTMNci2CKM0K9On86ZP5KDLKU5dMv4ew7CBPbkuMEL0XC1MEqGljgTCoCeUgTmvt7XhLXWa4G/gsYhxnIbNuhE4hvodmh1BvrhMUw8yQc+nVVYi8eZ7ibiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZVXxLtaYCJkRSEaCgf/fXl185IQ5fQC7z9301GH9UU=;
 b=gayx6XzkXdM3AZMKsuHmv3J8Hz/fAf0eTHrEyvRB9AHl+QL7SRh6rGj6osLuEs8HaVM22cVKd/4nw4aWVbeC5FGsIJ7id4rQLz2/yjcyBVOnuBnJ+jfNpvfzjXdKcGCB6ec1trPL6cIN8jJor8I8/hNBe1/fzBiA0Bq1xqEmNGaDOqiKSGp/pmGnZ2EzChI/cXYLgdA/sL/5s9d0e/IcP+TSRZAdsVfounzJMW59Ie358wwozH+QL5+q+cuE5uG0EicDy/rbcEOOx9u/sW3foYsd8TTPfU7aVJ1pKYqcRa2l3/HaADInLl4b4LZOWXVMOTT7CNrOIPBtkf6Aj85BJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZVXxLtaYCJkRSEaCgf/fXl185IQ5fQC7z9301GH9UU=;
 b=iRF4Sm2LvpXg68NkexnUDA1ILYBt+PNYv/FV+smua/qQzQk+4ilv3EQPJ1ux54RXxlYLA9FIXZPG1QS+crMm3fvsAMdXn6E07UE2XhfNvqhiMjjQLmC0IvuTHXcubOSAzi8F8HqTxjE+3qLVvvCtvATQfj47+IWmCkWbweV8OeZu7nBwFxNqalgpgycghX79zpffcnyzTYn791hxqg4nT6m3fV59jbehm1GbCulUgudKnKvf+bytQzuhLGT9Rtf35sYTJ1U8fcen4YvPu7avz8V5WHQa7UVqYGBNmCBxtXrIjrQ0qPJ8HpCIiedvsllgKmgO0RgAkWNqpK59WX9DVg==
Received: from AS4P189CA0063.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::13)
 by AM8PR05MB8113.eurprd05.prod.outlook.com (2603:10a6:20b:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:59:37 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::1d) by AS4P189CA0063.outlook.office365.com
 (2603:10a6:20b:659::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 12:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 12:59:36 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.103) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 25 Jun 2026 12:59:36 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AS8PR05MB7800.eurprd05.prod.outlook.com
 (2603:10a6:20b:259::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:59:33 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 12:59:32 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: David Laight <david.laight.linux@gmail.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "tobias.gannert@ziehl-abegg.de"
	<tobias.gannert@ziehl-abegg.de>, "joachim.knorr@ziehl-abegg.de"
	<joachim.knorr@ziehl-abegg.de>
Subject: RE: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half
 FIFO to prevent underruns
Thread-Topic: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half
 FIFO to prevent underruns
Thread-Index: AQHdAwLMAOuYhCbC9UaQhkHW0WDA6rZMFloAgAAVUoCAABJ2gIAAIw8AgAAY2QCAAqq0YA==
Date: Thu, 25 Jun 2026 12:59:32 +0000
Message-ID: <GV2PR05MB1194183F888F21065CC596F3D83EC2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260623160759.506f456e@pumpkin>
	<418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.42cbe154-31f1-464c-8ca6-20ef01cab8dc@emailsignatures365.codetwo.com>
	<20260623171328.153735-1-paultyson.mbewe@ziehl-abegg.de>
 <20260623194224.308ba549@pumpkin>
In-Reply-To: <20260623194224.308ba549@pumpkin>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|AS8PR05MB7800:EE_|AMS0EPF00000199:EE_|AM8PR05MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f3413a-9ced-4945-4143-08ded2b99c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|56012099006|18002099003|22082099003|38070700021|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 o1z8nxLOIhT+VocS5Q7ls7pPL3DZtzMCxqjgzHGOWsiKJbCn6Wz2uuL7ccKmbtFDR2CDo6l5Agrp0fi/DKrzjBC6niaXSdudvowxKO4wE1g7rTHXo81ih5CvcidRTynKMv8EmLrojR9DWu+lF1/U4JqttQhTPP/vzJez24CiR3OyxUV/pN4cZazTTVeF0M+BzlAtaid1Es6vpebCrkmMKA7P8YDSbOVwvekDIJTqSvXrxVY+il7JzzALDwnMCmExPHuu2WXZvEFIja7/r70BHo/kptp1yzJ/2zX/E/OXXoHpwpJ80rA1L1aLpuwyv+oZhgwNmrHt69Z1g3CbUlFHysbPHWZ+S08E30hnkYAxcTTN1GVhbmRZdwAxsDFWVFkYikccg6l0kH/57tuF3nw3D77gIjFM8dVYy5ujZWWPMlcmyvS2wneyUaSiLeG/31yjnFbXKFQp4Ud1nVM5/WyQspHoBLERHqBLTr/9UmFhYaKUM7DdC7eCKn3FBp1aOrcI6rsafXyf4y27Ph38peR67P+SGk1kh66GmU1A+pKWE7VipBMC2uGaMS+1gOO2foQ0pH1olpadr3nWVaeX4QEhLFm9Db0JLSLaHgq8MWVceVsmA3v31pWOuKrBDH6VpL9vDofd9rkzuRsiEGq6uxNZsMpe7lp88rZhEEuU9XogrbiRbjGhR924QcZ7rSL/gCKM0gscej0MiZAFO0Wih3BGzSxBInQMNJOBpsH0vPm7RJM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021)(4143699003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OewdD6YJAN4qMbs/Qyq4QJxfKheYIYLpi1nWT9wip1+5FvfYKd5GMyXDKShT8ZB64+Tm+q7gFRlchx0PhN99vSwA7TVBhio9dBgpUWXtBd+/3UqbUnwz8j32iCo7pvIen3QiMapCenroxpKr6J59At00EvmmbcH6rMy+/oIKkZA8empYIt+ENyR3lD18zu/Ln+3ECmJ9pAMaRz2PCvMY6P9z2sOkOtMPlPaBNJDJr+ll45qihF++jt5pQ+NuKkJlNvNEgeuZRhAtfur1nldj9oXXLoS7cJh6kG6tD0NFFnmSk8Ss9BD3VMRFvim3GsaNUOYJhlpsPmEJdEWEIn8jEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB7800
X-CodeTwo-MessageID: 15103e19-40c9-4af1-a313-0c745876fcb9.20260625125935@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0a9b8d61-e82b-459b-4b16-08ded2b999c6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|1800799024|30052699003|7416014|82310400026|376014|23010399003|14060799003|18002099003|22082099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	6kWTrE0xZA9yiHOrbBo0kdlJXbCJzGynKRLxTemGTAplNAOJr5uL24ycIgwJWAUTnMfKm2aWDai+7gyzFFKx77ZgF2Lw+Fko06zfr0QnDjSAvwWsBHBl8k9r/Qq76k+D/ZaqkY/ZLwRjZIe6VyMZ2tJVkxUoR1NMaOCFL8sFQ1rx3wkcrC92JTAIFr+VZJtUOWm8JeFEBwsEgucNLMwHYK5Ki8/pwnQAoCW3L3uF9oI0o0GRlJlm/Q6RQVd9KHCjXQ1tNySmXZuOxSM8iY9gZlWkVfFtTZa3MH/RRKUcBMGT2BTeRVufOljv4U7bFQt/ZIqe6OTTrNTB7aH/MEZbAuRaxKsn6P/acpHroyYDFrIgpaIAxiLmRXmGdNTxNl0PaHMj5vNVmbSopKwtvIKVvTTmKZRrM3WtXt3sL1IcV+Iw70mmfinV2eHrbviQbqrRusnLTi5luZoDIUtlPs4dlhveJzplIDGR5Yha8dBPJHOYtKXBTNd777tX8fpBd3mlIIrKi1zDupvsGg9ijUfotWpua8EmY3qr8BSPlu7h/cirKRT+MVkE4eX0VJCdt4QNjWHmZdH0hBN1Su7UALVMgLXdINAPCb34L1QilET/WVAvq5eCbkH9WWp9DyIcrslnkv5YXMwfdsp2tv+f/bMWQqN1SsS2+d3cf/o1x9tJIIy+pp/94eKrngh54ZZVc0nsX0ZRM3yG8TxEASXNN8UblQ==
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(1800799024)(30052699003)(7416014)(82310400026)(376014)(23010399003)(14060799003)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xlMh5J1pd93+8O+MpF+4MtoG9nxCQSqPwOxvLaD9kpvbPC8BzFkc38vW1RQkUU9f/36AYT+aFKdwfmzqmtpdY616J3ZSM5+ioekoAl0/Xa/xeckntcdXMTFIHNq8lJrUXMqF+BcrzBfsq80NG0M+gbzKcyCzqGMS7hWx26SbqPpx2U8p5AVZUzzR7nBHGVJ0/x7Jl6ATWYz6LECKfJyWCDOIGp9cQVsEEdNh7I3jkZyd/UnJR6nzGwm97Y6ISiD/dbILXV8c/VKILqQuMmbq0iTZtWIhVLeeeydR9J3lac/nnua5doC8KnOKrZ5K+i3I38jMCioFj18yl3UkQ7DPxJZPHH7b1c/LNfi/enau0InlaDGjaGB8rgn8LM7JneiWnItX76N6kXWXf/VnBPW+zdow2KWt3gOnLEKcc7X+VLSK5PT1yp35apMVscb6cSr8
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:59:36.5600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f3413a-9ced-4945-4143-08ded2b99c4b
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB8113

PiBGcm9tOiBEYXZpZCBMYWlnaHQgPGRhdmlkLmxhaWdodC5saW51eEBnbWFpbC5jb20+DQo+IFNl
bnQ6IFR1ZXNkYXkgMjMgSnVuZSAyMDI2IDIwOjQyDQo+IA0KPiBPbiBUdWUsIDIzIEp1biAyMDI2
IDE5OjEzOjI4ICswMjAwDQo+IFBhdWwgTWJld2UgPHBhdWx0eXNvbi5tYmV3ZUB6aWVobC1hYmVn
Zy5kZT4gd3JvdGU6DQo+IA0KPiA+IEhpIERhdmlkLA0KPiA+DQo+ID4gT24gdGhlIHRlc3Qgc3lz
dGVtLCB0aGUgcmVsZXZhbnQgdGhyZWFkcyBhbHJlYWR5IHJ1biB3aXRoIFJUIHByaW9yaXR5Og0K
PiA+DQo+ID4gwqAgaXJxLzEzNC1zcGkyLjDCoMKgwqDCoCBTQ0hFRF9GSUZPIHByaW9yaXR5IDUw
DQo+ID4gwqAgc2MxNmlzN3h4wqDCoMKgwqDCoMKgwqDCoMKgIFNDSEVEX0ZJRk8gcHJpb3JpdHkg
NTANCj4gPg0KPiA+IFNvIHRoaXMgaXMgbm90IGNhdXNlZCBieSB0aGUgSVJRIHRocmVhZCBydW5u
aW5nIGFzIGEgbm9ybWFsIFNDSEVEX09USEVSDQo+ID4gdGFzay4gVGhhdCBkb2VzIG5vdCByZW1v
dmUgYWxsIGxhdGVuY3kgc291cmNlcywgb2YgY291cnNlOyBvbiB0aGlzDQo+ID4gc2luZ2xlLWNv
cmUgU1BJIHN5c3RlbSB0aGUgdGhyZWFkZWQgSVJRIGNhbiBzdGlsbCBiZSBhZmZlY3RlZCBieSBv
dGhlcg0KPiA+IFJUL2tlcm5lbCBhY3Rpdml0eSwgSVJRL3ByZWVtcHRpb24tZGlzYWJsZWQgc2Vj
dGlvbnMsIFNQSSB0cmFuc2ZlciB0aW1lLA0KPiA+IG9yIGxvY2sgY29udGVudGlvbi4NCj4gPg0K
PiA+IEkgYWdyZWUsIGNoYW5naW5nIHRoZSBUWCB0cmlnZ2VyIGZyb20gOCB0byAzMiBmcmVlIHNw
YWNlcyByZWR1Y2VzIHRoZQ0KPiA+IHBlci1pbnRlcnJ1cHQgdGltZS10by1lbXB0eSBtYXJnaW4u
IFdpdGggYW4gOC1zcGFjZSB0cmlnZ2VyIHRoZSBGSUZPDQo+ID4gc3RpbGwgY29udGFpbnMgNTYg
Ynl0ZXMgd2hlbiBUSFJJIGFzc2VydHMsIHdoaWxlIHdpdGggYSAzMi1zcGFjZSB0cmlnZ2VyDQo+
ID4gaXQgY29udGFpbnMgMzIgYnl0ZXMuIFNvIHRoZSB2MSBjb21taXQgbWVzc2FnZSBpcyBtaXNs
ZWFkaW5nIHdoZW4gaXQNCj4gPiBkZXNjcmliZXMgdGhpcyBhcyBpbmNyZWFzaW5nIHRoZSByZWZp
bGwgd2luZG93Lg0KDQpJIHdvdWxkIHNheSBwbGFpbiB3cm9uZyBhbmQgYXMgc3VjaCBjYW5ub3Qg
YmUgYWNjZXB0ZWQuDQoNCj4gPiBUaGUgb2JzZXJ2ZWQgZWZmZWN0IGlzIGluc3RlYWQgdGhhdCB0
aGUgOC1zcGFjZSB0cmlnZ2VyIGNhdXNlcyBtYW55DQo+ID4gc21hbGwgVFggcmVmaWxsIGV2ZW50
cy4gRWFjaCBldmVudCBoYXMgcm91Z2hseSB0aGUgc2FtZSBjb3N0LCBhcyB5b3UNCj4gPiBzYWlk
LiBJZiB0aGUgaGFuZGxlciBydW5zIGluIHRpbWUsIGl0IGNhbiBjYXRjaCB1cCBieSBzZWVpbmcg
bW9yZSB0aGFuDQo+ID4gOCBmcmVlIHNwYWNlcyBhbmQgd3JpdGluZyBtb3JlIGRhdGEuIFRoZSBm
YWlsdXJlIGhhcHBlbnMgd2hlbiBvbmUgZXZlbnQNCj4gPiBpcyBkZWxheWVkIGxvbmcgZW5vdWdo
IGZvciB0aGUgRklGTyB0byBkcmFpbi4NCg0KVHJ1ZS4NCg0KPiA+IFVzaW5nIGEgMzItc3BhY2Ug
dHJpZ2dlciByZWR1Y2VzIHRoZSBudW1iZXIgb2YgcmVmaWxsIGV2ZW50cyBhbmQgdGhlDQo+ID4g
YXNzb2NpYXRlZCBJUlEvU1BJIGxvYWQuIEl0IGFsc28gcmVkdWNlcyB0aGUgY2hhbmNlIHRoYXQg
b25lIGRlbGF5ZWQNCj4gPiBldmVudCBsZXRzIHRoZSBGSUZPIGRyYWluIGNvbXBsZXRlbHkuDQoN
Ck5vdCB0cnVlLiBUaGUgbmVjZXNzYXJ5IGRlbGF5IHRvIHRyaWdnZXIgYSBkcmFpbmVkIEZJRk8g
aXMgcmVkdWNlZC4gU28gdGhlDQpjaGFuY2UgdGhhdCBzdWNoIGEgZGVsYXkgb2NjdXJzIGlzIGlu
Y3JlYXNlZC4NCg0KPiA+IE9uIHRoZSB0ZXN0ZWQgc2V0dXAgdGhpcyByZWR1Y2VkDQo+ID4gaXJx
LzEzNC1zcGkyLjAgQ1BVIHVzYWdlIGZyb20gYWJvdXQgMTUtMTclIHRvIGFib3V0IDUlLCBzeXMg
Q1BVIGZyb20NCj4gPiBhYm91dCA1MS02MSUgdG8gYWJvdXQgMTktMjglLCBhbmQgbG9hZCBhdmVy
YWdlIGZyb20gYWJvdXQgMi4wLTIuMiB0bw0KPiA+IGFib3V0IDAuNjUtMS4zLiBXaXRoIHRoYXQg
Y2hhbmdlLCB0aGUgb2JzZXJ2ZWQgVFggZ2FwcyBkaXNhcHBlYXJlZC4NCj4gDQo+IEV2ZW4gd2l0
aCB0aG9zZSBmaWd1cmVzIChhbmQgdGhlIGNwdSAlIGRpZmZlcmVuY2VzIHNlZW0gcmVhc29uYWJs
ZSkNCj4gSSBzdGlsbCBkb24ndCBzZWUgd2h5IGl0IHN0b3BzIHRoZSB1bmRlcnJ1bnMuDQoNCkl0
IHByb2JhYmx5IHN0b3BzIHRoZSB1bmRlcnJ1bnMgYmVjYXVzZSB0aGUgbG93ZXIgQ1BVIGxvYWQg
ZnJvbSB0aGUgSVJRDQpnaXZlcyB0aGUgQ1BVIG1vcmUgdGltZSB0byBoYW5kbGUgdGhlIG92ZXJo
ZWFkIGFuZCBvdGhlciBoaWdoIHByaW9yaXR5DQp0YXNrcy4gSXQgc2VlbXMgbGlrZSB0aGUgc2No
ZWR1bGluZyBvdmVyaGVhZCBpcyBiaWdnZXIgdGhhbiB0aGUgYWN0dWFsDQppbnRlcnJ1cHQgaGFu
ZGxpbmcuDQogDQo+ID4NCj4gPiBTbyBJIGFncmVlIHRoZSBjb21taXQgbWVzc2FnZSBzaG91bGQg
YmUgcmV3b3JrZWQgdG8gZGVzY3JpYmUgdGhpcyBhcw0KPiA+IHJlZHVjaW5nIFRYIHJlZmlsbCBl
dmVudHMgYW5kIElSUS9TUEkgbG9hZCwgbm90IGFzIGluY3JlYXNpbmcgdGhlDQo+ID4gcGVyLWlu
dGVycnVwdCBsYXRlbmN5IG1hcmdpbi4NCj4gPg0KPiA+IElmIGNoYW5naW5nIHRoZSBkZWZhdWx0
IHRyaWdnZXIgZ2xvYmFsbHkgaXMgY29uc2lkZXJlZCB0b28gYnJvYWQsIEkgY2FuDQo+ID4gYWxz
byBsb29rIGF0IG1ha2luZyB0aGUgVFggdHJpZ2dlciBjb25maWd1cmFibGUgb3IgbGltaXRpbmcg
dGhlIGNoYW5nZSB0bw0KPiA+IFNQSS1iYWNrZWQgZGV2aWNlcy4NCg0KSSBjb25zaWRlciB0aGlz
IHRvIGJlIHRoZSByaWdodCBhcHByb2FjaC4gVGhlIHVzZXIgaXMgdGhlIG9uZSB0aGF0IGtub3dz
DQphYm91dCB0aGUgcGxhdGZvcm0gYW5kIGl0cyBwcm9wZXJ0aWVzICgjY29yZXMsIGNwdSBmcmVx
LCBzY2hlZHVsaW5nIGxhdGVuY3ksDQpzcGkgZnJlcSwgdWFydCBiYXVkcmF0ZSkuDQoNClN0aWxs
LCBJIHRoaW5rIGl0IGlzIGdvb2QgdG8gY2hhbmdlIHRoZSBkZWZhdWx0IHRvIGhhbGZ3YXkgdGhl
IGZpZm8gZGVwdGguDQpJdCByZWR1Y2VzIHRoZSBpbnRlcnJ1cHQgZnJlcXVlbmN5IGJ5IGEgZmFj
dG9yIDQgKDgvMzIpIGF0IHRoZSBjb3N0IG9mIGENCmxlc3MgdGhhbiBoYWx2ZWQgYWxsb3dlZCBs
YXRlbmN5ICgzMi81NikuDQoNCkFuZCB0aGlzIGlzIHByb2JhYmx5IGVxdWFsbHkgdXNlZnVsIGZv
ciB0aGUgUlggRklGTyB3aGVuIGRhdGEgY29tZXMgaW4gYXQNCmZ1bGwgc3BlZWQuIFdpdGggYSBo
YWx2ZWQgYWxsb3dlZCBsYXRlbmN5IGJlZm9yZSBvdmVycnVucyBoYXBwZW4gdGhlDQppbnRlcnJ1
cHQgZnJlcXVlbmN5IGNhbiBhbHNvIGJlIGRpdmlkZWQgYnkgNCByZXN1bHRpbmcgaW4gYW4gc2lt
aWxhciBsb3dlcg0KY3B1IGxvYWQuDQoNCj4gPg0KPiA+IFRoYW5rcw0KPiA+IFBhdWwNCg0KS2lu
ZCByZWdhcmRzLA0KTWFhcnRlbg0KDQo=
