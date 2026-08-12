Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C013BE16C;
	Wed, 12 Aug 2026 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523974; cv=fail; b=laiurchj5kMOdof4GD0V1PdWErHEHEv2XPNyzD1oax33cv1N0g0VaFwvkvPy+MFN4iUCvBFEHU6ETHFWaT1jk6STxLhytPVU5vFtaWFHiVrORHANClm+QQ+k9PFw28TXbv4D86yMzDUfz0dQeNcBhITP8wT8N2X5EL2kqB7OF+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523974; c=relaxed/simple;
	bh=NWOdoQWGJjtxoS5jhg/9/0SKJWRHPv3q1NxGeO/UWEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WAka2t7/qT5gxXXlmeUARvy4gHHGnIF571RYqE5jOk4RiAptYa2lZUb22l4a4RoJPLtBd1BdpWh33k+Gq52vqW2MDrK9KZMIh7gmqoJACp90b13Pok5U8yHkMW3sFjJNiqlVcZPgIvUKwBCS04FrN91zLHDeKOK4LRWIgeG0ff0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=RFAj4NYK; dkim=fail (0-bit key) header.d=cadence.com header.i=@cadence.com header.b=MO7Z6AK8 reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="RFAj4NYK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cadence.com header.i=@cadence.com header.b="MO7Z6AK8"
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C629pl1277325;
	Wed, 12 Aug 2026 01:13:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=E6tQynWoZGHytdraXazYhHmC00sOAwv6t+PLJn0CQkE=; b=RFAj4NYK75Gq
	9vFwoHxQXEAql6hU7E5nNwcruDe2yowfsAAL+CD3IzrzWzcN2GjHPU5hAz3elQ0g
	qpW17VYbLbPJhUxA9/sDVhQUb9lE/hHZN46jHAZajOAxoqO9N8zWVBZPwRgCseFn
	5ftvXGGg8tdjJNqs4JEwR9gNjKw2RxBou8JIGstc4Xh/1qln8PifmiAXY9OoBBer
	qE5yY1nq+erigliRL62sYboBDTbMwNW3jmVLiqKOodOvhnclt9VuM0QtDoy749Fe
	t4RNuDxNqFmgFH1OF0ALeLE59bRMaULk+Q+4/ouptW7KGKZQx4VcltwOtqqkk622
	vFSI+8XrcQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4g007p10xw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 01:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1LqWSXxAhly8GUDdW0daP/9VXgTVvZC0n1fi65wJ+7B8OdFYiU+B12RdwVqyRrzIhgi+YmHbw1DOxgBiXt0c1w1i5vKkMyex6+3mDtV6nlgvbDb9MN/If7rh7q903N2LVA/0vtWGjriS1Z4Id0JLHx2ih/uZ8kjc7HvdrYiFqzIMsFpT6P5thBfg9pfjugqDWyaKyoMxz/WxRnpMyUG1MWHPM8YpXbbSMDWDy8RYt71Z5+Nk2bqoBjMMsLbSAbrvC0IPrU3sGI3B6qopzVdv3zY9JBzaMf/vy0qOsZ/IsD1jrD3hhWM0/oyS9eGw5jGpN92FNVNKNFVWbrtCP61NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6tQynWoZGHytdraXazYhHmC00sOAwv6t+PLJn0CQkE=;
 b=tPCS5GTs+zGNG2Gq2unD0DhhxOPKvtY3HyOFgDxP0m12X8CbNBbmjhgnsFAXqOqkwuTZwS3AtZcsHX4J3KHt90lruacb0qjAZvEkuLPnucnw0XktiSNLbpSvVfF5EILqIsIA3N8mtbGg5GLG9HxhdQM2yUYZG/brhm0yQ+DsK5fL8MgkdsXm/o9IpYklRydH3FH+ScjqP/FLgRpIdg1VnKZdGa3hMSI+lr6u24Kd902tBjr+PgkHFXU6RfSrKh+N1CN4OT2h0NpzYVdJ0X66dkJEphG8IYA8rW9t44XkuYhwXw7GlW0Or9UKVcoQN5Qi7vmyn2mn4JKZy8RNZSTRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6tQynWoZGHytdraXazYhHmC00sOAwv6t+PLJn0CQkE=;
 b=MO7Z6AK8pI8AgGhNX3EbQMIpxC2hTcVzzXzw1PKphXqPzA/zutSX8HawPKuCX9L6BOFAnI/px0FFiME++EDiA1d3GcBNk43KqBoUSylc9sntTcBGjEJ+F4ImsXF2vgbRieBhns+TGtbelmHjtcq8t8WoMoZfa+eUHrmrqU0CVJBeKwCT2y+/pa9V7bacp6n7aIHS+DDx1LmC+nJkrLoUdZUKhwiQfv1gTyHPgqLv0wmScCHC6SkoDjr6Lh2iPna5v+Vl0dSt2cXzIMGTcpBNDv2FCiz73aE4WC3Rq/+GCF4wMQAZ9/IYCzUGI8FufsR5trJf8qmbsn6P8YVzkGMIDw==
Received: from LV5PR07MB11354.namprd07.prod.outlook.com
 (2603:10b6:408:301::11) by SA1PR07MB9599.namprd07.prod.outlook.com
 (2603:10b6:806:2b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 08:13:09 +0000
Received: from LV5PR07MB11354.namprd07.prod.outlook.com
 ([fe80::f029:abb:79aa:d881]) by LV5PR07MB11354.namprd07.prod.outlook.com
 ([fe80::f029:abb:79aa:d881%3]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 08:13:09 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Peter Chen <peter.chen@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen
	<peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: fix wakeup from S3 after controller context
 loss
Thread-Topic: [PATCH] usb: cdnsp: fix wakeup from S3 after controller context
 loss
Thread-Index: AQHdGpPf5ryW1SN2PkuX8dKS33+iebaCRWEAgBfmTUA=
Date: Wed, 12 Aug 2026 08:13:08 +0000
Message-ID:
 <LV5PR07MB113546210770FBED0E2A26E84DDDC2@LV5PR07MB11354.namprd07.prod.outlook.com>
References: <20260723-suspend_resume_fix-v1-1-c12a0e8eaffc@cadence.com>
 <amgbVsk6ioQQGzat@hu-petche-lv.qualcomm.com>
In-Reply-To: <amgbVsk6ioQQGzat@hu-petche-lv.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR07MB11354:EE_|SA1PR07MB9599:EE_
x-ms-office365-filtering-correlation-id: d6fa964d-1b4e-4a48-fe32-08def8498b84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|10067099003|56012099006|11063799006|6133799003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 1iBISLB9NY5QMxjJeOIZfZT2LbLqFYNXy3JhJj2ZJ27JBEkylSEbWisHfDm6JKaueOlbk/+fPuVbuTfbYPDlJlpUnBqBHpWJshJTL5AwkDA1nbNJoCQQeLpcWzDTzCsugp3TqWXD2zoB+mn9/TAtzKT1RjQJYo/2PQnPdnZ6WzQBX53V+2jowNAClX2qPYUcQxHJQWN1IYkh0gk+gEpcIluQOCgMsZBd8lWUYFHJTP+d0wAiFORwOrywtYx8tzgS4jCTws/CJNwWJjpzzbaEwR3KdJI0vQau9wbBNtssy5HrzHtUWmJgp0YyXD6/IzIP54OdE8vAAJ7JhqnJoXqjAme+atYsiGiRwt3FTlj1n7uV4ucWqJYUHguGKSU3HB6jJUpqaHGar/DNHkRiROh4qvBET5LjL3wumuPaJSFe4KBmjiVCml5bdBkedgDxBMPPubxl42d+guVGTIyinQAHSybZBitGJmQMWad3vzrAOYEdtMkq79Qokef7ga8ZNOP7p9AdR9VGGCTTjgiBI6GKZQW/Wc6rcyqfiYCdDTw7O1ypj312RtDeIsXrXLX7WRvAkjEfki37h88ofJMmXK/6Zyt1o6BStsoNA9USaZwmz7O7WfBJf2alUH0uTISig9uwBt6NtMNitU5dYL2XuWxovoNDpf4jsWd8yeQAPxiYOqiMqK9ww1sbmlbcsVetB0uenTGUTunN/RsPCEX4mH41ufQwtI3Yrv2dRW/2OGacXTg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR07MB11354.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0L8S0HbxYC0OZsIJ/vA3kF9xvJhIf8qJr84izAyAa0drtf69HDCSRAIFn65d?=
 =?us-ascii?Q?VFW/08Q2f61I3TyhPCbHHvAuQkHTtvnufK4vsZIFLz52G9d1XVV1SJlq+Q0w?=
 =?us-ascii?Q?915yrIz8Q1l6yFJIk+nLMCeTFGM5mpbccOgKICb0Ztyn1eGaBQpF/DClDvqM?=
 =?us-ascii?Q?JbTCvIRCMwFa6hmhXsrXr6yqvBtwxesVlCxI3jiAAp0m3vWjT84N4cgmrW+b?=
 =?us-ascii?Q?YSg3jH8sJ8oabw5lmhhq2TLxFkKd1QWd4/aHV7TnyZ2XUoqyoOS8mLTQr4yL?=
 =?us-ascii?Q?p7YWInhnNETSJ00//sLkRZPEq6vGMq8CG53nZv1pspx/o1pYxcFRvh6sQ08G?=
 =?us-ascii?Q?xD+pU0zG9Fs6TNc7AnR9LMBIdqlnBVmnY5N7AKfkBRBWFIq7nM4f5vyeACAW?=
 =?us-ascii?Q?T4Dv9AAl1tTMsDeEEy6sdUOsbnPn4MATjT43uLLMXbfOC4T30JK+GWLouRWt?=
 =?us-ascii?Q?7bAaOjUaDiTCl6fjKB1k0MXQyx9915RmzWM70RU4Pyxqdmt7BbAXZGTSd2QZ?=
 =?us-ascii?Q?HwjNARfyxdyCmpVKj4cIjmmXnm3m6leKXCIvhoAzIEkxaaBDJ1WozFB4qUZV?=
 =?us-ascii?Q?Ya4a3JrTk2uzLexa0s/eHFYlHRgs2Fsi6KhfVpUK+PAF9ylE8DAxpgWzusos?=
 =?us-ascii?Q?NntWSZGY1/p2/mR+dsVwJR5NQsTupjZRRDzyzoVooXUpDQzuYRDDgdOOHrrN?=
 =?us-ascii?Q?BV/w6I4vgssbm4fo/BtXHUWPRiJiqtx2x3kD2eUyqz5udcDXoukg1QokmNZB?=
 =?us-ascii?Q?m64N5bAs+zBMRh+XsEFIGWt1jQbXXLpSOkLtYnJSGmXdwDloyNGLhQkJiq0b?=
 =?us-ascii?Q?fZGUuSBm89do8VtPQPx13NUYshW+1R4dioybbux5iMo128anu721VPZUTn0R?=
 =?us-ascii?Q?m/7m++q+6/mv4IVgNWU4ZKq+/ook46ZvDGVwj4e2Nkh9KntG/jvAK9P920fP?=
 =?us-ascii?Q?gXRwLLBtHHsAy86C6n+8ww3zDCZhuRotDt3+TFN9sye71onSBR2gOZOSigYZ?=
 =?us-ascii?Q?sEGXm5PMdrVSOaBYggYc2+t7zylTBcqxl2By3mHwkhNjH6PbLvAM17Q3J8F+?=
 =?us-ascii?Q?K2M7PLbpyYBLTAb4DQYjK5b6n8WZmaM32VnZKilp/1pQNHwdsDN2dRXN9+Pq?=
 =?us-ascii?Q?KpR4keeaXeiBaD2N80R0XvdyRdN37GnuZyumUrd6G56ReqJLL0FbLZct0tsx?=
 =?us-ascii?Q?+W0ZzWmeeG+J7CGMOBJ55WgDB9qXERIJm+RqvZpJ5vp9B2HNNCkvw/OxT5/M?=
 =?us-ascii?Q?S7Bnv/Yfg47VE9DF5uTWkAF4dKl9JFiN2kK4GOJrAYdbkr3W6/9AbO1zK+az?=
 =?us-ascii?Q?3M1vwpoRoWqKj51J/FbUM18NWIuJvOSA8PADiTvr47URM3UWxPR0aR99WD6Z?=
 =?us-ascii?Q?/L6cRjV1dCIth4ZKJzFAQ6T0inrs3AbdVjpOPDPuyYBTxjex13uOEB92KLjb?=
 =?us-ascii?Q?VuIPV+MQAIwmQRS16lAP0vonrVvmnQtW7jHNvVSkRJmNcFpnS5jf8jUckful?=
 =?us-ascii?Q?tLxAC0O4rgUW0Bs2qGOuqJ3GgxsI6vMcUBtVoDY5i8u+6uQtdwmqvFTo1hvl?=
 =?us-ascii?Q?aBhNoIzjIniR5bjq4jTFHzZb0mCdvE6+q9M2uXIPjqBcRJ6Vxi4xFIIU8eQu?=
 =?us-ascii?Q?JXvFNMTjaFutK2YQV5QHKLc55IrgFE+DRrXks8eR4rgmm+jca1sJcmjGy+dV?=
 =?us-ascii?Q?F2BdbfumL9Z6RCwQ70nQ1Nx7ldAOUjgP/p/OJoy9C1Z3+NuKTjX/rh2g8Psc?=
 =?us-ascii?Q?kCOVs45kEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Kod2wt6D+PjawN+gNH4q/SOBJ1B+NuMldp6ohZS1Huw+MfNI73q6DV8eFG83hv5BnFHeyurCrnljucBEkfusxUHvGnjStcyx+WSYoF51hkeK1Ok7YMp9Kwt/Gx0VtKfryjDEy0qeKZ9E903sq3PnDAb7XXoE2gKZQ85u7t0pw6aFpWRlZGQyQyeMs/y1XKuuK15bp29DpLpZmERGRUxfjfPMWf/+iS+wzTOEfOg5IS4Idzg+nBYVOYIgiAamiXnzk0H60P2Wg4rrKUZz6d/zgTKsMH2EZw5kuyZEkO5cItlKJXp3k5xCOJZPbSbAdjVwLkfqwax/UHCWHufJr4kHWw==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR07MB11354.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fa964d-1b4e-4a48-fe32-08def8498b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 08:13:08.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfVG7ysjzhJmxJLQHLHfFaGQHxPXr1sXO7Cs3A5M91gzOCMbCXaunVw0kAgJY4E9mwgaqAVtyvg3RoLfH2nayQhZGqOxmIZJNJQ3Z1OML2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB9599
X-Proofpoint-GUID: R8mHYZ2s69X5qyRARa-VQdPCk1kAC5Qz
X-Proofpoint-ORIG-GUID: R8mHYZ2s69X5qyRARa-VQdPCk1kAC5Qz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NCBTYWx0ZWRfX7yad62zWLBWS
 qP+QQdREtqEud64qCuyW5DWZJJuvx6WxUNGoKRit+kIk46U/P/XELK3IEvWJlAfKqZuFoEZkfiL
 VoYrUy6tzRfkk/QDEQ/N6U5icOkKt9eZd1d3lIohSt7DzRvRuooY684x8AXBjTsUU+gBs3nQH9w
 pxw3XggtpmtxWkCExm2NdICMmKfUmGMM1qIil8nC0freBUirvzrtF5RuMA8EVpG3N8uXQP+lmEe
 HucaKQEIMsygQf2RAApLHDrwn+86VhQ8ysbwQGPm4PMAoQPAxYZY1/kZUmaRjOzbZhkDOElEx1e
 mkoRGrcIcsdKYzXuQdFZTuLc7dXBsUWrlkwiPKvhZPnvOGGRA6iLv9ox5WrLQBmmO0FhjnZ7E1A
 sUatSuERLcDzJiu2ANKx41Szv6X+o+gygqbEY8hJ4CCFnuVHAVO7tFD/cJa/ET4usVUAPDolt2n
 h8JaCGAkucj9cHXgyEQ==
X-Authority-Analysis: v=2.4 cv=VYXH+lp9 c=1 sm=1 tr=0 ts=6a7c2b18 cx=c_pps
 a=sh6lJpoQSmOZbBTv2jax/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=Br2UW1UjAAAA:8
 a=VwQbUJbxAAAA:8 a=QYdYL91hUQGaeitjtcUA:9 a=CjuIK1q_8ugA:10
 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NCBTYWx0ZWRfXzVdCN3JK7bSq
 fdoh4nADBW9xVLaWGLoYXqLJ89NcovHHyindAaS2peQdiCsZea6NqWvf/DTdG7xePcK0Zo3sASl
 6KwtNlHem6D+xawD4UrxxpYKVbxvmxb0DBaDVrXgMYZvze+XykrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 priorityscore=1501 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120064

>
>On 26-07-23 13:28:27, Pawel Laszczak via B4 Relay wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>
>Hi Pawel,
>
>I have already left nxp six years ago, please change my email
>as peter.chen@kernel.org.

Hi Peter,

Sorry about that. Yeah, I know. I think b4 added that address automatically
And I didn't notice.

>
>> CDNSP controller loses its runtime register programming across S3
>> suspend/resume.
>
>It is not always true, it depends on SoC implementation. For some
>SoCs (like CIX P1), the controller power still exists when the
>system at S3.
>
>> After resume the operational and interrupter registers
>> may contain reset values, which prevents the gadget side from recovering
>> correctly and breaks wakeup from S3.
>>
>> Fix this by reprogramming the controller state required for normal
>> operation after resume, including the command ring, DCBAA pointer,
>> doorbell base, event ring, ERST base/size and event ring dequeue
>> pointer.
>>
>> Move the basic controller register programming out of the one-time
>memory
>> initialization path and make it reusable from the resume path. Also
>> separate ring allocation from ring initialization so that rings can be
>> reinitialized without reallocating DMA memory.
>>
>> This fixes S3 resume on systems where the controller register context is
>> lost while keeping the existing DMA allocations intact.
>
>With your fix, does device mode wakeup still work, does affect the SoC
>like I mentioned CIX P1 which keeps power at S3?
>

Yes, device mode should still works correctly with this fix, and the
patch does not break platforms like CIX P1 that keep power during S3,
but I have verified this only on my FPGA platform.
We cannot test on CIX P1 directly. but the logic is sound based on
the hardware register behavior.

The resume path uses CFG_U1_PIPE_CLK_GATE_EN (bit 0 of
XEC_CFG_3XPORT_MODE_2) to detect whether the controller lost its
register context:

- On platforms where power is lost during S3 (like ours), the
  controller undergoes a Power-On Reset, which sets this bit back to
  its reset value of 1. The driver detects this and takes the full
  reinitialization path. Wakeup is not signaled in this case, as the
  USB link has been dropped.

- On platforms where power is retained during S3 (like CIX P1), this
  bit remains cleared (it was cleared by the driver as part of a
   previous fix). The driver detects bit =3D 0, takes the CRS (Controller
  Restore State) path, restores saved registers, and then calls
  __cdnsp_gadget_wakeup() if the link was in U3. Device mode wakeup
  works correctly in this case.

>> @@ -1575,9 +1576,13 @@ irqreturn_t cdnsp_thread_irq_handler(int irq,
>void *data)
>>  irqreturn_t cdnsp_irq_handler(int irq, void *priv)
>>  {
>>  	struct cdnsp_device *pdev =3D (struct cdnsp_device *)priv;
>> +	struct cdns *cdns =3D dev_get_drvdata(pdev->dev);
>>  	u32 irq_pending;
>>  	u32 status;
>>
>> +	if (cdns->in_lpm)
>> +		return IRQ_NONE;
>> +
>
>If the interrupt happens before cdns->in_lpm is clear, there will be no on=
e
>handles interrupt issue.

I will change it to IRQ_HANDLED.=20
The controller is stopped during suspend so no level-triggered
storm can occur. IRQ_HANDLED properly acknowledges the interrupt to
the kernel preventing it from disabling the IRQ line due to spurious
interrupt detection.

Thanks,
Pawel=20

>
>--
>
>Thanks,
>Peter Chen
