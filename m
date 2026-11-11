Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379544;
	b=pT3FkUTpwQW38SZG/t/Z1+jVdOVf4l/A1xJ88gjMb6ZuxR47M0e4gd4c9xe6VdZ0RT0g
	 uuuueqSP2KOTtpxXy8RUPSR60uJ0CwMt+LwheK5Rp0rjIQL2gYEXuU26zfJMLKRtHdSAo
	 eykAM0hyK8bMcioWjSSQwa4rsdnGgnKfrKGs4DYxrljSXOj/pvvMoTcAPhOnB662QuDlw
	 Mn9Su7UZG8dPZ+v1WyGBHknBCtBpKrWuLauDgebgpF3VhzTT4Ste1spF9f2bzK5AmTa1M
	 Y7iU1V6wvS/wFLNchJPnBug3KXBX9Di1n3xu+0Vlec7q6bLfZnz0H8O8+PdrDcbceZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379544;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JaGqQPxitmXKkHk57xhuWKtzD67cqSWyTVoKkGU2hoM=;
	b=yogNFhjzbBkGfpBt5+RfEEyLQSL9uubLDxujCp8b0TDvI4oRXwMi7wdqrViMgJv1stXv
	 uGOvOOao7ymuER2kwQaOWZYy8zD8buP9xDcGyk7m0npHCtmfMhWzALZ61RFvMDEjIF8y1
	 l4FWDvzB2NafO0r7Kdss+DcDHG9wAAT93DKs6d++SLk8gWFYwQxWtzTFRR5tyLBFSJs7L
	 H6L0WWebZO7wkilQ+hmruK1Ig4xJGGX1i01Qtk1+ffK3oE7PVS8OlOutoE5OAicG7zhGv
	 qKLdo+/bJplaBmG4K+Rcn7P+ypZhBuW5tbxIbPujae1lrkeCAXAybkMXYcJfGchVYZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b="wtWj+/1E";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.83
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021083.outbound.protection.outlook.com [52.101.70.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC23606A334;
	Wed, 11 Nov 2026 06:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC23606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=wtWj+/1E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJv0RlphtXGz3cM+ipM/cgmtFgmY81LfPzjfSDGKit7mn+t7VKGV45iNpp5SEpTM6qQN+Ls2IULvuf7tMBGvqOkKQIH49wJSr1EWZMwRXlK5Mv4Qgt2lF+/wyj7lZL+xu7M1C2dx4QV8hYmFGtCdwn8vAjhmr3rcK5pishANYDM33Xk70vcldYm+WtBPY4sIB2QDd34Lx7uzP82/TGvRgJxb0tSR3Xbk9OLpbCQBebEbTX/6N1AJyErUXy3HgJY+WaXVwRCRmL0cJmKgm3qm5s8nCZ2uej4LIMZXhNuCif/tj2whnNwzWsXLbmZi6zBFWVLh0fQ4o6euVLwuTyS5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaGqQPxitmXKkHk57xhuWKtzD67cqSWyTVoKkGU2hoM=;
 b=Kz0AOTk3ZshNaW1FfTjCH1CFwQzZg9Zz6H0iy+/vy/i30gzlY5P9I2lxVJe/SVdkDoTmEQ1ps8f6sJzk0+YehndSkbE2FovJJlIpmz0VVIwEFZPhY51V4a/3N9cjR6uSUkzOC8U06NBVE2jTiSV4kqww0hALRhUOKXCWU4AIQ1T6icMj0mMYpUDhv287CYP4nQrhO3Ppf+PpDUgwuCFcaedt5Fxzshp28FvQk5fpjD87hj65KFn88u5rIaUPN1wTUOvokrlPipYK4X/inqjj4IzmKAf8mwgtpH+ya2z6p9bd4wiXDiV+AoSKXUOQriOQgf/oxP/yTAIAzoBM/VoIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaGqQPxitmXKkHk57xhuWKtzD67cqSWyTVoKkGU2hoM=;
 b=wtWj+/1EPQtPQRkngPbcWa46emcBePlubQTVZSHmQhHAfgVzkFqtGH+8ZSQcxXuffKlR1+Ey+1LjZflhB8rjzf/JbP/mWbJwvHLPAVjNXvklvqjBDsUD3E4jn+Ol7GXkzZqnPSJGv7QF/KOOj37exQCyp6QXpuV1E+jZv0ABxXRmVIgZLxpGk6ELr7+OJPF+SvpJ8gYnZyWpIpFRMoPHjdl5G3jkS7M0uU8iJQdPmbq3qW+1QsdZIUi9asOq9wVEuZAslLRgQhoghnXPsVUwIbFpYS04fPNspPsabh3SF3r0pAgNOnqEE1jHuL3apwfeUlpCtSX2ybkdQiBy5uhdUA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by PAXPR05MB8112.eurprd05.prod.outlook.com
 (2603:10a6:102:de::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:45:37 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:45:37 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Sven Auhagen
	<sven.auhagen@voleatech.de>, Richard Cochran <richardcochran@gmail.com>, Kurt
 Kanzenbach <kurt@linutronix.de>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Paul Moses <p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v5 4/4] igb: drop AF_XDP zero-copy frames that span
 several Rx buffers
Thread-Topic: [PATCH net v5 4/4] igb: drop AF_XDP zero-copy frames that span
 several Rx buffers
Thread-Index: AQHdbCdZYmGgPwiFSEG43WKkhRY4RLciygAAgAWt9QA=
Date: Wed, 11 Nov 2026 06:45:37 +0000
Message-ID:
 <AS5PR05MB1102099EEF867597B2F442293B9712@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
 <20261104-igb-rx-ts-fix-v5-4-bf4b4367129a@aweta.nl> <au9LMP75WIgIQnub@boxer>
In-Reply-To: <au9LMP75WIgIQnub@boxer>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|PAXPR05MB8112:EE_
x-ms-office365-filtering-correlation-id: f9115827-d00b-4193-94c2-08df3fbf64cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|38070700021|10067099003|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 q/3vkY305w7D+veUFMkKkDtKzkxai+MJ8vZ7qigLzMwLhuCbouSnAtMb+7fK2jxHMvCUkcN7vkHJZKrsuaYOue7ZdywUVfzigWt1lMBTKP2iWGH6bxBqpmQUi5fQiGjJE2Uty4+f2nMDr5q08cmLrM+5/hv6E15r4HBOXe/pvywN7Ajs7oyday6lrTri35XPX5GwFhTA6/srXq3vybwO9yrABXhUmQx2u4NltYqm7N7UqMZYOVnxPipAAO/r88bULo9xeRsQ1hLcOT6e09U4m94SuNVjUbDDqet/joNcrUz4Wsi/VS8vI4dVMY3jmIaMbAQICmIVM+5AAC5rqsJuRQLi+Fr2evDP3SlMRp39xMoOK76wIZbYKgg+d5ARxEZjqt8R3giAp6w0FvP0wvbz7AQjgeSWZ1/Z5LBSYg4kGOHinANhh4aKhBeK7eeDzg8UMMvD/aRuKpu+FhL+Vo7cDG9t/Qjp+M3ZkZetXuCMDVK8oCNizz/GAeOftsbLtqkAYmj9QA7Xm0EdDEL0lXMw1qXNbfIdHYqnim4GJb+zok5aYa6KZxl2luNa4SyEETcOOJ//2tGvKEGXBER9kGoVl9qGlbCBMVv1ZYNuj3gBHM7pSF1+7SmvJE0dL6Ia2+iXlbsOki3ZnPTuFSUiahVO4ySoS8cwQjlTEV+hD3CBbZd78j+KEPe0lemBRmo5eyG5KLvpiWjtmFQiWh6qswQIVg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(38070700021)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tHGh4f7LgJ07vrafOVTOpv/UHOyMYJ0cKx7qGvdQgPS6Yl1CQ2pn83oNwqDn?=
 =?us-ascii?Q?k0qBTPbmrkHQTnXbPMxZoNp7ZAANOQA4HBi5MB5nRPxPPOudRTD5pYOYZc+b?=
 =?us-ascii?Q?0QygTjuqn3pnloEnqXwmwVWuZ5+LiVpbJ1Vl4s36mSixLS58NePZh0PG4DeF?=
 =?us-ascii?Q?kg46V2aEIFRJKdmZbzLcV0QJ7tR/2aRCT39oOnh3db43sJwQcte1JrEJkcFD?=
 =?us-ascii?Q?XgTPfcoV9ucEuwjttIdTBo9z08aF2CyJ1+60V1HMl41v0vFW2NawKTt57n66?=
 =?us-ascii?Q?wNPcoMqx8QUNTCXmpaugufsGdNnrA2uKL6kGRZaoQNQqMyz4jA4E4eYhOCEs?=
 =?us-ascii?Q?DQWfWnf0582L+XnIbkCuD2SmmF7Xwn7zwR6RF6NjBEPe3LS+sXzp2RnWzhYM?=
 =?us-ascii?Q?dtGfWfkG5H6ptQREIXFKpVtpiXTWQpHLwbWMjX9979v7RFvGOKw+jUlcERLk?=
 =?us-ascii?Q?2Fp5xO5WJ5trd1aYqfg/P9cUs2NvXB/zPUQ3s2ugo2eUDmJBoaZ8XvGcbhFG?=
 =?us-ascii?Q?71qmoFrA4LClg5hvTjDvZcYZIH1E6O/LfF+CvcguWsV+rHFiIvwB4NNISfbC?=
 =?us-ascii?Q?fhtpbzRCHP4wp1Vy5MAxxBJjv0qTM7aM0AAzQSFflTLpAESMS2pob5ZhgSyS?=
 =?us-ascii?Q?QG4tlqdR6npDaYVNxm55efM95XjBtiPyQpRKcaPU+r7CU1gOfkqkZbKdL5WZ?=
 =?us-ascii?Q?FWe5cUT1yYtOlJ12BgWD8xyGVFQ9YNP3mHzzZrq/F6necaHmPlQuMyjPX5xt?=
 =?us-ascii?Q?dxqhenO5HLwxpfizrJ9h1mBajmJKwBdA+HcG9UNrWBZu2AxlCkE77zri8TEQ?=
 =?us-ascii?Q?eKX2HUF2CSHNBUai5p0xCZcv6suwXMXN48QHj83oYRIrGx9h9SuXVYY+V77M?=
 =?us-ascii?Q?m+qiriLIVpdF6oUQXIzHk11FqURE5J8imUVNt6wv9YpzFG0dtswUF07jlJLK?=
 =?us-ascii?Q?E+NN0c8TR9rCjbeFCDZhwxn3AjJz678OgD0HV2xON8Fv8DTHkmeg37mKVNMA?=
 =?us-ascii?Q?0q7vFMeRmW/Vs9JqzzAvf2oDOgO11TfhYmZfEewZ+kbdd8q0KHC/U6pSmS8X?=
 =?us-ascii?Q?5LJ8NtXk2GeHVIrN2QJuQ4xE1r4wWDaExDr+aRqXjBWtX2nNkGaElY8hF9ly?=
 =?us-ascii?Q?iR22+BE1TBP18NfvqqtSFdyH/hxWKKX9gpbPDkdOAwsC5rZLo866vwBY2gI4?=
 =?us-ascii?Q?66aG+FFzwXMg3dn3FwvfW8ivl3nFIhb8nibyf+juQWuoNS2IN31gS0pfq9E7?=
 =?us-ascii?Q?WDpU+GwujKZR0AArq/TFxWq8fVtE/7fo7f0SyzvCHqffQq2zFcD66yvwdUSU?=
 =?us-ascii?Q?HwaQtK9Jh52uPz1XEhgeaWXj50Gi4ogCTlGJyVnrfFbOw+FekpL4OCICwKg0?=
 =?us-ascii?Q?0nI80rTZ5Bu64bVhB2JSJq+/fhsHpENIDAmtdlZm9bL+q89tsMiszbmwIHEP?=
 =?us-ascii?Q?x42w2gCfwUXNwnHzxTtpNjg36MeWFTrBABGy8GyOBNSJR+W0RNG3TuIZZZVP?=
 =?us-ascii?Q?PBAnaviX2Yn/dK4olKFeD2oiMI6g3AFN7bObTcSVJ9Q2HyDp7HScUxO7DEKj?=
 =?us-ascii?Q?WnHpvKEDTrVdRP/xgtP9AQ57dFAVegDrfq+iPPSnfmfC2D8OTuL/meolLmdp?=
 =?us-ascii?Q?mCNtlVhv8uHz/0kfWndgecvMx3qWFgztJdiwEMID8XYLSOhABn7vwn+1Aql4?=
 =?us-ascii?Q?RJmwpY8SCXThJCRyXVE/dkbJeBYpAUKLkJCoMWyhq4wwWgWS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9115827-d00b-4193-94c2-08df3fbf64cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 06:45:37.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kQnyfDJjeA0NXpQNyTQUV09ihrLGJJz6R0RKdkn3qqvJGJDJ0uPfCnDB1wkd3usInrziQo9En2pS/cQ68fFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8112

> I am missing the point of this patch then. Are you adding a dead code to
> hot path?

You are right. With patch 3 the hardware no longer splits frames in
zero-copy mode, so this patch only guards a case that should not happen.
Thanks for the background on ixgbe. I will drop it in v6.


