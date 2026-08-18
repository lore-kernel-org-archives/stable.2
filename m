Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26345D5E7;
	Tue, 18 Aug 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049194; cv=fail; b=YgwM+4uNEdXqofG0oQeCAg8ztIBRGAIhG1tPinfLkJmkb3iBl3tqbVE6qzrkSXLNVbT/4XnAPpDnnVUZ55xY8kwCgIVgLyC0DW5ia0CRUYPi01UqVGoQJkTUOkaLhYW52GtFTYdV5kqLTUMIUxOBWAOWD11b+32/1Pp7hJ1cfGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049194; c=relaxed/simple;
	bh=jm8WMA40xGXDPHtExcV0CsdpHSi0Z0QwsQBXHiG+xJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m8RE2GFmn3iiiiO9hhpP+ws8Xl6Fzo/8izgPaSFOgc/1TP4Pk5fBLty38gg7EgeLIXUFYt4SgwcC3PsEGSy8QLtdHG23cZz5eFvLRkayNVahH1rFE6VZVAaGJjgvAhQgoyWyBOrMgbCzclYRCgqPtnTa/ViRwEahktzIFEo30XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Hu1d2NUJ; dkim=fail (0-bit key) header.d=cadence.com header.i=@cadence.com header.b=OHZVfj8c reason="key not found in DNS"; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Hu1d2NUJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cadence.com header.i=@cadence.com header.b="OHZVfj8c"
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IA7c1x1749162;
	Tue, 18 Aug 2026 03:16:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=fqTnvk4uYu+19cEBCaKXQk79mKfzOMRIPHTd5O5Iqfc=; b=Hu1d2NUJux+z
	7K/C2UH6hqofmXaAb3dDfhJ6BadhZ2FMJsqu0TkEbXqMmfJOMH6U2UEJtOOQPlkN
	UBFPqDucwjKJql/3pkUSJohgiYfFGkpbtrC0zGXhbV0EUsWqfle0htGsY0piprlG
	+QLoepjCxlwi9HQLdA6Xlsv0LawduczHEUKlRI5j5Fzb4hSX6EVS2Op1WsQYPuDS
	kTRVmtKOwkTuE0LEnGwscLFrfVWB8WDy9sONHG7W5h85M7/1r8u/HsHrPRrEDdLW
	MHtbFyfiE4lkhrLqDW/CaC5uctrKasAFKOsWLIaYOye28o90Y9cyW4+mZfGYBWxC
	poc/efIPbg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4g2kpuf0f0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 03:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZIuBmnBEgS0KpfKlJn+S8QdV79ElcJHCLt5GRmL89F3T1JntdVVk9i7QNqZJOZhTWuNASgPjQIqg5jDpXTDiAsw561UvTn0X/DTVxmICpkJFabmZ6gmX3+ONY7WChzr9j0Xn/1pbTj2CxOdyJfGL3gvkT5cPmQyvK5l2f9LS8eAxPlUL991ajuWxMI4tzcEm9a5tcGkZ7KXAxu2+QKwrWYhEa6vanABjVnT9GiHwlgI+iBXmWhFMF4cKYQCtdwniJPVec1RcJ3pEXPvz5kpCRc4oKF37Trfvobg9EsptxD0SxeqlJJylhapW2afvldEsG51AQkejMFGiD87S+k68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqTnvk4uYu+19cEBCaKXQk79mKfzOMRIPHTd5O5Iqfc=;
 b=w24yXcG6vBZkhhItWJ/m0QBIitn3vI2bICaxMzvG2p1LjkIw8gtBTipRAB/7CBUUoUOe+/fo3bT4KWi3VZiBrSAlnZpAQ4FXRr08SH34GtPH5Mpjf0Qi1a5sQgGH0/O4xbOqqFQO0Az7mDAxbP7ttlmO/E73Hx6NEXBtJoZs/4bTynawSBwLwKY5cJJbItcWhEPFjmWSRtDKvh/ovJpftxvzW9xU46K87Xykxj/+XBrH5DXyGXEZMXv0/BZoT69+diujkRDIBKedqtOA7Rg2BkrWbQx7yycai8j0FsxXWTQ/nxN4mGHhnxEu18SfXbu8lHplca5u1xRomMVRoNVyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqTnvk4uYu+19cEBCaKXQk79mKfzOMRIPHTd5O5Iqfc=;
 b=OHZVfj8cvk3lyg9QbiN7yNrsEHwxzFggtQ9qPUjvecHwZ2XwugZqSt+G8rjzb53yRn8dkgqgGg8N4ljXg5a8IjxPtsvc9ShI1qYeBnhLXAp1s+gvF+wDAc3vDzWgeL5FSugzQ28vT1tYqG4ljzMWGe1BdRN+Y9PVzfoIksd4DATvRi12EGaMp10i2fy+Bzcyl3vEBTIPNYqk+Ps9WSlOtOLUPrJZmk4dXyPYrTiyfh+Ct6MjDLNgjQhh9HB2V2U2y7g0AtDzFBROe0qD3QiFbUocEtcgjwQpjqwaR07oFwmoYMuldjW0JC5kZW+l54vlFos3Gn5ixkt/+uYbcap1FA==
Received: from LV5PR07MB11354.namprd07.prod.outlook.com
 (2603:10b6:408:301::11) by CH2PR07MB7256.namprd07.prod.outlook.com
 (2603:10b6:610:7b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 10:16:04 +0000
Received: from LV5PR07MB11354.namprd07.prod.outlook.com
 ([fe80::f029:abb:79aa:d881]) by LV5PR07MB11354.namprd07.prod.outlook.com
 ([fe80::f029:abb:79aa:d881%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 10:16:03 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Peter Chen <peter.chen@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gary.yang@cixtech.com"
	<gary.yang@cixtech.com>
Subject: RE: [PATCH] usb: cdnsp: fix wakeup from S3 after controller context
 loss
Thread-Topic: [PATCH] usb: cdnsp: fix wakeup from S3 after controller context
 loss
Thread-Index: AQHdGpPf5ryW1SN2PkuX8dKS33+iebaCRWEAgBfmTUCAAbDegIAH40wA
Date: Tue, 18 Aug 2026 10:16:03 +0000
Message-ID:
 <LV5PR07MB11354B0942B610EC8AB481ED7DDA62@LV5PR07MB11354.namprd07.prod.outlook.com>
References: <20260723-suspend_resume_fix-v1-1-c12a0e8eaffc@cadence.com>
 <amgbVsk6ioQQGzat@hu-petche-lv.qualcomm.com>
 <LV5PR07MB113546210770FBED0E2A26E84DDDC2@LV5PR07MB11354.namprd07.prod.outlook.com>
 <an2S2-4J329OIqKb@hu-petche-lv.qualcomm.com>
In-Reply-To: <an2S2-4J329OIqKb@hu-petche-lv.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR07MB11354:EE_|CH2PR07MB7256:EE_
x-ms-office365-filtering-correlation-id: fd660420-f7cc-4fe2-9973-08defd11b5b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|6133799003|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 jiphL0ObImDFM7JW3+GWXokgUxbPAa+zVAsrjDlX/mAPKGlACfW6tuKuyuhDFu+tsI1jsORz7Z812gAgWsEvSxICr9CQv6teYgmUm27FeCUwk7tVQPeB3ZOic017KWE2K3J95KpjVopyUuoOA9bPrxadZHVYN9V2zuNmL/QhKlomDhsiKjBB69P9CDt6cXGxfsuCkBVhiawcP3tO7/JMAlSNPIXSbYCaiob07LmCsbx1OX8wxri+I01wp+qQWDQ2pIueCU3TrC+jpEYcGX4VBauXaZHcki1xHefexIyWsV/rxlrw1FoZqkCQB6S2DR2MqtWg4A493Hbts5+28PnTLaeXjn48VwY7LW7Z5MzNt0xlUcQyGlBwfCBam+Qm/ttwrUfwiVSJqr0m9h6WghrDWxcnnHJ7D01JpXg1+n5vafqY6UqkcX1bMsjGizie3pq6AOIAaroqUVt1mwBlDfM9UnpgjzcYw35eJchmPTNPcTXoR/6eSgszN3xUqvoexB7fw6mztvWxEIa5nAwQE1iW0cIqMn6F4KVZ8XoUWk7Ay2I0xbKzmsftsaTN6Qo6KeOVm7TZtQxItIzm6efPhneZAxpSX1vBA/Tuqt5gczF9eI+xzNcC6S0irWvoRIjvqqozyjewijxXMBuRmH8mSGmIwKnr+UKvqM3lJL2Rs9GP51YD62brTA/eNLQv3kCqc4/sqE57Es0eDxn3qor52xIcIUy06PRGaeAhVDe4243pTqk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR07MB11354.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IQk4GtfNmMVpjG34tWQi+60QC6+J7SyVn4xbSD9dTMDQvxPRhHOa/ii4Gtfs?=
 =?us-ascii?Q?8nvAWR+LwMFRa3AbL5zQ93W2ECV4Ttyw9sATp8RBo7tevbqIHd/V7/HLon8B?=
 =?us-ascii?Q?uQqgkBug+BdNGTT7WHVEBjJIOk+O5d2NDXPTUaGrJMpoAu7reCkkq1FwQWfx?=
 =?us-ascii?Q?o9uQSoKrQ3sATUM3H2JguCDm1KHkPoBJnSNs7B5oEYNlUz+0IXOni0gVEDiU?=
 =?us-ascii?Q?w3Ndnz5DbsXLovcTacI30Hgssfc0SqCT7j9D2EKuSNMSByQEpB50CqRFplk8?=
 =?us-ascii?Q?ht2QYJXRoiWblblYgnK9EOuOIqzGXVKpriWwxOmElW7ho4Zab+XeFVzEpoRR?=
 =?us-ascii?Q?Z5kyYhRJcyYN02BCpqlsO14RaO5CW8wsrFfTilLf8RKLT6cBcFEtxU+sW73E?=
 =?us-ascii?Q?RNa8Jhi1yNm6mpfNLw4r65ccTqjxzFf51Ogck1WxrlAVooWc2Irt4WM1fYBd?=
 =?us-ascii?Q?VGEGW3F2F9JiORYwGBB3LTKuylUHCyYMNeW5fsh6U9KWhkFWFaezIW9QDkjo?=
 =?us-ascii?Q?KOZ3paMVfPWuc/LxTGuF4XPTiVl6fPEc+We6mGYtsffz6vMCYZENrpxljIDl?=
 =?us-ascii?Q?QRZNB2kSu3ywoYgvOSyvJubZVF/oSlDYv3OoCnpn1VEmXubs5Dv1TL2lrkOF?=
 =?us-ascii?Q?hrGsdx/f+EyVXU2TsawhdpPl6TqFJcrtZCPfVNBQ3kB4r9cZigGpOA9ZNjtb?=
 =?us-ascii?Q?2nXpEKuqGzoyEmgZeEruyM+YBAtprDH9Xcz+JZE+ePUcf7eTQZRmkqK0hht3?=
 =?us-ascii?Q?atE5W7ii3Lgo2PhkQ/e101ScCXUX59xK0m3v/1mVVAzDvqm4fj9qcI13rvZI?=
 =?us-ascii?Q?NDjIg3XSEYEWlYw1DXio9zXCDd3CAKojRl/ctsFReDoTwf2X1u6P3RDp5HWp?=
 =?us-ascii?Q?VbdghuAWVOcbcHvwZUnyhVEIifN61NIVlfyamFnw/8Gl7sJ4wcxQCeIx9fs3?=
 =?us-ascii?Q?YZt1gm8MabVjrQxpA4UGtll5azRTNHk07aARFdakmk07BZID+s1GETI1FFby?=
 =?us-ascii?Q?CrTegyUpZatb5mBT7HOIKrD1NK5HLDuruer6TxPP1xpZytPMs37H2nDixaR0?=
 =?us-ascii?Q?K8iRZEopCnJbf4hO0DP+r4LVvFGQyK5BbqOsd8dEZbLQ4uoYWv8ek65rtY2a?=
 =?us-ascii?Q?hFEd9lX/tHJdlLIyPLjetxI6egm8TeRh73ab6RVvZWhtjlVyKOc43xS/4LLd?=
 =?us-ascii?Q?PMKlDIxTym/CmKB9MunI9yjBYjVD2BNnHrL6znhjky8i4JrU8qKKSFejRxVx?=
 =?us-ascii?Q?VeYYu8khAnO+ct5ltmYj+OWeTIjAHO6bo8OLEdfJqSASDzfWRW1nA3FB1007?=
 =?us-ascii?Q?b5oghijOMiI/LbuynBPoxvWNpTZplfR7kt431Ud7nN3dHbQpPbgMW5QLo5eL?=
 =?us-ascii?Q?ZJonvIHfMu5EQjk9WmZLEunsrxitArpiWvGR/nIdFx08b7sP5d6i48j43tUF?=
 =?us-ascii?Q?LbF6XmpR0P1rAe96eklrSickwyyGlqYt6ykts152YtgNdZczIPgshDRpwtEp?=
 =?us-ascii?Q?Ms87hjRwEOyq607Gwaw6fxBxjS/BvwcfZYUh4wTuDAAd2/sqK3qqXHLFS0We?=
 =?us-ascii?Q?j+bvQwbot5sRQ96HhEMHivH5xFI5lclxVQfdzvCZ8Aru5PUdZDapnz7FLb8z?=
 =?us-ascii?Q?Zr6QBpC1r8pSw8PyNewYw58MdsbrlBO4BmrCUTiMNLfdZBJHwdyHYjpB/6fd?=
 =?us-ascii?Q?E7TN3ohyOOOTfVjODp4P3PpsBrqDQlLuVgelwj+EctLSnsNiDw6HvZnRDv/L?=
 =?us-ascii?Q?eqIDnw8KVA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XneaV/6r1FDht11zhRcEp9sWa67l2nkJoTeOQE7aRh4ktko1GxPyCvwfemlQbhFFeRjUOrVNIMS1fTVxlr7HBni30RCbvNow7NRBuuv5Uw8cNO9/tymDiipc23nt7Kfy7rI9fJGD0P8tO0xx3t2BMxa5a8Bke53w81YDcwcEc1LLH5qdCBBn3uCGnmYytqyD6wTt/WH7H7o835/1D+PB4u6SjbZ4IabyYJ4m32no4MukVwFD6qB+i65CNpE85Fl6WhEZLKvgegvfcqE9anRvt9bjk7Q812hw596ycRfx4mj7mAbXqpblMp7YByBa5scg2GSAf3oR9YPhxHFbopmEMw==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR07MB11354.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd660420-f7cc-4fe2-9973-08defd11b5b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 10:16:03.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00mq0XY/2ovAMI0e81YUbDzaoypFtmttv2tYhnI41o27P6ngyJaFLtP41XAH6PilLdStIaHskDxlP/NWjQmsvUHsL2v+zN08HL46188PZ9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB7256
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3NSBTYWx0ZWRfXyTczbipt9P21
 Dnml17PttCbVAaYf0QNQf2w4eU6EV2kEFo82A8W+jY2ofwmRpSKX8HIPvMQPfKbduacEJhYu+Gc
 pl8kyM8X1X0rfG/myZXv3rW3jzwRC01LkXsp704HRCjG66gGMWcn5+H+R8KsGDHP7oW+DHOr1og
 E/WhaYHyvCN0gsJ4Rh8OSGrQQ+WXFrrJpydFTE/dU1dGVopwktJcVBf0PI1XxdfTmALgI+wbJRq
 JA9x64cqhIKy+ttAi+SofPnay7Pvlqoe+XkV0EZcLglvSKyWHRXFmGHazJn3vb5fwGZF/M5ISyn
 iU0M1fDklR6MpBQOnsJtx16ddmC/dST8wQpFtpx3TFWO6Fc+7N02P+ERSJtdV1KXK6QRMkk4WYm
 oYWKlJ/01J/vQyyhKdAFwiNZ5zKWAqNnzcZAefM5XB1S4ZBMhpLKuPpJH3+HLR3yMo3XW8nsyqJ
 y8zATooH1XsgYBu0znw==
X-Proofpoint-GUID: U1ujtu9fUfqXacVqpbG0cOqO8vT3yyHL
X-Authority-Analysis: v=2.4 cv=U6Oiy+ru c=1 sm=1 tr=0 ts=6a8430e6 cx=c_pps
 a=Ie6vhHcvS3zZlrI9i1bNAw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=tuMieXAyK57eGGFK7xkD:22 a=ITDZZCNPbX5oLOPDKMIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: U1ujtu9fUfqXacVqpbG0cOqO8vT3yyHL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3NSBTYWx0ZWRfX8d789/Hhzzrm
 4xwtvfCxothbWZK1aXZzsJLAjvk/iLVM60dU/KSlrQzYUgA8XqsG5VuFPwMHVu5lxK85m6zS+D6
 oIGkbSaQ0PcK9+C3/T4r5YAMlH5aFuAmUGv0YbLG9eKL6JY9Paa+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 clxscore=1011 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608180075

>
>On 26-08-12 08:13:08, Pawel Laszczak wrote:
>>
>> Hi Peter,
>>
>> Sorry about that. Yeah, I know. I think b4 added that address
>> automatically And I didn't notice.
>
>Probably you work at old kernel?
>
>>
>> >
>> >> CDNSP controller loses its runtime register programming across S3
>> >> suspend/resume.
>> >
>> >It is not always true, it depends on SoC implementation. For some
>> >SoCs (like CIX P1), the controller power still exists when the system
>> >at S3.
>> >
>> >> After resume the operational and interrupter registers may contain
>> >> reset values, which prevents the gadget side from recovering
>> >> correctly and breaks wakeup from S3.
>> >>
>> >> Fix this by reprogramming the controller state required for normal
>> >> operation after resume, including the command ring, DCBAA pointer,
>> >> doorbell base, event ring, ERST base/size and event ring dequeue
>> >> pointer.
>> >>
>> >> Move the basic controller register programming out of the one-time
>> >memory
>> >> initialization path and make it reusable from the resume path. Also
>> >> separate ring allocation from ring initialization so that rings can
>> >> be reinitialized without reallocating DMA memory.
>> >>
>> >> This fixes S3 resume on systems where the controller register
>> >> context is lost while keeping the existing DMA allocations intact.
>> >
>> >With your fix, does device mode wakeup still work, does affect the
>> >SoC like I mentioned CIX P1 which keeps power at S3?
>> >
>>
>> Yes, device mode should still works correctly with this fix, and the
>> patch does not break platforms like CIX P1 that keep power during S3,
>> but I have verified this only on my FPGA platform.
>> We cannot test on CIX P1 directly. but the logic is sound based on the
>> hardware register behavior.
>>
>> The resume path uses CFG_U1_PIPE_CLK_GATE_EN (bit 0 of
>> XEC_CFG_3XPORT_MODE_2) to detect whether the controller lost its
>> register context:
>>
>> - On platforms where power is lost during S3 (like ours), the
>>   controller undergoes a Power-On Reset, which sets this bit back to
>>   its reset value of 1. The driver detects this and takes the full
>>   reinitialization path. Wakeup is not signaled in this case, as the
>>   USB link has been dropped.
>>
>> - On platforms where power is retained during S3 (like CIX P1), this
>>   bit remains cleared (it was cleared by the driver as part of a
>>    previous fix). The driver detects bit =3D 0, takes the CRS (Controlle=
r
>>   Restore State) path, restores saved registers, and then calls
>>   __cdnsp_gadget_wakeup() if the link was in U3. Device mode wakeup
>>   works correctly in this case.
>
>Add Gary to confirm if it affects CIX P1 platform.
>
>> >>  irqreturn_t cdnsp_irq_handler(int irq, void *priv)  {
>> >>  	struct cdnsp_device *pdev =3D (struct cdnsp_device *)priv;
>> >> +	struct cdns *cdns =3D dev_get_drvdata(pdev->dev);
>> >>  	u32 irq_pending;
>> >>  	u32 status;
>> >>
>> >> +	if (cdns->in_lpm)
>> >> +		return IRQ_NONE;
>> >> +
>> >
>> >If the interrupt happens before cdns->in_lpm is clear, there will be
>> >no one handles interrupt issue.
>>
>> I will change it to IRQ_HANDLED.
>> The controller is stopped during suspend so no level-triggered storm
>> can occur. IRQ_HANDLED properly acknowledges the interrupt to the
>> kernel preventing it from disabling the IRQ line due to spurious
>> interrupt detection.
>>
>
>It is not so simple, it needs to co-work with wakeup irq. See cdns_wakeup_=
irq
>and cdns_drd_irq please. By the way, why you add above code?
>

I removed it in v2.
It turned out that the code was not needed.

Thanks,
Pawel
>--
>
>Thanks,
>Peter Chen
