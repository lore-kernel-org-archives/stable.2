Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.188.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794061723;
	b=hSDpeCFCco8fVxbnH9ipXQKX5I8E6lN14/FpwZHLM+t6JbnhofCqk/ari87aOooS1h2G
	 W5H81A6M5GKU/je7fYKzkqyh8GN4wmadAWN7IPrtSbs+dbmzjrg3k2A0bouVoOBCHFIwR
	 3ZOvqxCfPui53UZOb2piGyVLOizIYSqEgjQYRKFRc1GvWfrD49SxZDEaOLtvZ53ju4e29
	 RyNRrlc4eMmjiOpooDl78fuWR3KDbx8wgoqq0Xh8DdULKLXhmUQHU78C/non6ExBeS5rU
	 niyojmE1wc3k0ZvQdhgiKiBgnZlcw7GBj9ALZMBXjrlIVPBX0KCJjedwwSY5yW+Xwzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061723;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mGszJkDwPOCJ0NeCByr2uOkrB8WhlorD82JcbzZGxNs=;
	b=ENylc+4+3GYONmSn7teV8AMEE6JPACsXx5g7oeI1lw1pxMB1lLZDXOe3CvLYtwc8k/6i
	 i9nceiQr9HhJOVQdiTqlhS7iD3Lg23VjIcMTYUhdJwyJaYwpvvopp+zHb+EeRhBFvV1Xh
	 mFlGSJ7sOhZCGrWvX3Ztq7w0wg/KtlHgWumeZ0IFBSVIT93XeRmax0QY8LGuRlzkA3jhz
	 oGVcLWdmrIT4T8KK4s0PPqXvRQRE20ZLpx32jFVY481mTU7LyllgYx58/yOZjIMkchQx9
	 1lZ2Cv1obmrrbmomgL6OggrellaHkHteYJmbAEk9QijzjHxzvh/PFYxneKG7tOlldhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=epfl.ch;
	spf=pass smtp.mailfrom=epfl.ch;
	dkim=pass header.d=epfl.ch header.i=@epfl.ch header.a=rsa-sha256 header.s=selector1 header.b=E1SUrLJ8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.188.89
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020089.outbound.protection.outlook.com [52.101.188.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94AA606A330;
	Sat,  7 Nov 2026 14:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94AA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=epfl.ch header.i=@epfl.ch header.a=rsa-sha256 header.s=selector1 header.b=E1SUrLJ8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLqaeaS4wR+JUGvXI+eA+8Snt5avMNR3vfg0AXQ64BnlwyuihFQR21gYfrZgSu8qV6fwYkHPXlCx/HT52oROMZLr2x5iMUTGvVwcf1fF70kV+B1NRPxqF/E4h5FXLswTTTpwXuVD5i57gLgsKLcsLSX1GbWpVkWlG1Y40HWr65sRzo5c9OTyqYyKg+qhBysZ/Io5wZvDOFco9Fc8P8Mu7k+67GaOrduAuTlbKjSvukcSB0yr81yVnoj9yNT1lVykPxswQ8duroXnFHwV4jcaeeZ5BWNBfaG1ewbnmfdQWJJkEL5KXEY/9+LDXNyh/bdahJfQfUHJWEFAfnIJHowY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGszJkDwPOCJ0NeCByr2uOkrB8WhlorD82JcbzZGxNs=;
 b=sHtXBF3Rq8Sq/Rj6s1rTsBo7PnqaXNQCtwGGyZa9g0OUFDDMP9KRImXkupxIbWFmXVZSYERJ2A0U3RiN7aDINgdHf6UKQhZr5KqWq+UkdPNCUtYLxOUckZF59W0HVXooMFs3JzJ29s0YwccA9kRANtQSRwQyytG6gF7KRcOI/YASG72AAfusTro9ectK3nCyTmyrX5cv5W0p16qV4Mc0DazF0HGy74JDWpWKKu1wAJc7gAiodikmQ0Oy5PS/i1Kfu9hps8OmF8+eULlSeo/PP2iUMddveTvLg4TYxpjNaJuvYp7JU3PNjzY/1Zju2o9nEZdNktNUPI9QqW/r7zIqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGszJkDwPOCJ0NeCByr2uOkrB8WhlorD82JcbzZGxNs=;
 b=E1SUrLJ8oxEsGrALOF7U2pRGZ6/g/3Yhj7SKOSNF6fho7h0XycTAcPmufUW4QgFn/sWqqIH/oqQUF1JAa1/NG36srYZMjMT85YgDyInAv/HRuMCwjoPoEMT4yvR9ImPZH5LzVrVywSBPSn2kHl7hI7gZXZcwbd8iA8F1QHT+fKs=
Received: from ZR1P278MB1104.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5b::5) by
 ZR3P278MB1512.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:90::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.11; Sat, 7 Nov 2026 14:28:37 +0000
Received: from ZR1P278MB1104.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6790:6f1c:eaae:5516]) by ZR1P278MB1104.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6790:6f1c:eaae:5516%7]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 14:28:36 +0000
From: Georgiy Lebedev <georgiy.lebedev@epfl.ch>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dapeng Mi <dapeng1.mi@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: [STABLE] perf/x86/intel: GNR stall events read 0 outside PMC0-3
Thread-Topic: [STABLE] perf/x86/intel: GNR stall events read 0 outside PMC0-3
Thread-Index: AQHdbsRGyvhd++nQd0yOMWVu7iEh1w==
Date: Sat, 7 Nov 2026 14:28:36 +0000
Message-ID: <1CA02EBB-9C68-4B20-BE53-0E857824A541@epfl.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR1P278MB1104:EE_|ZR3P278MB1512:EE_
x-ms-office365-filtering-correlation-id: 5577bc15-9a7d-43ce-517d-08df3cdb6912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|23010399003|19092799006|10070799003|1800799024|366016|376014|18002099003|10067099003|38070700021|3023799007|11063799006|261026121527099003|261026130827099003|261026140227099003|261028144727099003|261026135527099003|261021130227099003|261102123227099003|261021123027099003|261021133027099003|261021135927099003|261021121427099003|261022115727099003|56012099006|261022113327099003|261022105027099003|261022075727099003|261009223027099003;
x-microsoft-antispam-message-info:
 Stp7AKcAncE6xDuqXYhuoff/MkGGxJ/qhl5C8BhiGrjvU/Ylhua48lFLwf/nacPjw+bRkkbToiaxU1Hs2dD+QYyPJ9HvTr4peqYtJWGl2gXUJZ/N4llzqgteVzbhRmbL8sAkerCTGr/MazXn4zZ08MEa41bEls7zYp3AR1nw3sXidKiXLfwn6S0d5HUdhIfov73O8MH1IFKNv0cQCbYNSFWZsXVHj0VqY0ehQrezxaNFmNhGcNPTOFFLOL48TwYLN1eJF984gtgZODsCoKGUaUmc4M0+TsSd1gIGcShjAkrq0YOS1QjHVwVAnKlYU2Lfdp3ZEvBckQQ9IhC8otMSaHH02Kk/yIQqlVQ4xdN7LWvMvJYr32w+Y7BNRXciMUHXfGnI/UogodXDPI1E2WbbpJhQZX1J1wMzsCy1OwR2q9KnzYz/QtIJozJm48Di0fomhdbEJfDkksxSVpk5KERXEhmvzB7Ce9oXfFTwiub5dO9kLDhQhIjGNH+t2E08VOUeMebidSulxisT+McWY49vXQ2RBa9EZo4MoA0809IpK22j71CcaUWO5RyQB8VGs6sT7OsPX3LacuFz10c7iDEwVn6PdhGM5/Yx5BOxTGLzFxLN6KXNEfYIVrFzvbKnZgPAKP49+OaEczGtg0yG9Evowix5/DGlDsTHe9WUEiAs1t4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1104.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(786006)(23010399003)(19092799006)(10070799003)(1800799024)(366016)(376014)(18002099003)(10067099003)(38070700021)(3023799007)(11063799006)(261026121527099003)(261026130827099003)(261026140227099003)(261028144727099003)(261026135527099003)(261021130227099003)(261102123227099003)(261021123027099003)(261021133027099003)(261021135927099003)(261021121427099003)(261022115727099003)(56012099006)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rLhO3VWUNzeRaWNNvvL6CVl9kN0YhV8UcVFqbbDw9PW4uG3ixrFCOLPh04u+?=
 =?us-ascii?Q?nBjC6HvJ1JgFqsx2E19KuVx6iYPH6TDpgLbo3qgF07+myFMfn2LT1egZNl8R?=
 =?us-ascii?Q?e205T7HRGwkFqcgmcd+wuYo16Ux4QKVxIEaFZvwwT+YeyMOA1/BE5sQXo/6s?=
 =?us-ascii?Q?zMIQBnvpRWqOEXmmiGX8ZhLeop3+Zkr2ag0ZRSYSMj2xA+5QE4OurzaA1k2B?=
 =?us-ascii?Q?U4cLvGaio8vUursgSk6H3vs37kjttagICuoukE/SWFQDahC0W/432eMrKso9?=
 =?us-ascii?Q?IgWObtHHg8+RgweWeg/YtXcSfiB68oZBQJRgmLetNbxf6CTWdaCp1LNP+429?=
 =?us-ascii?Q?lUv41tX9BZ4bn2KrpCIEnSZuin0+23W+G2jSEs3YYc0RMOy/4BlhJ2hxaq7n?=
 =?us-ascii?Q?PbF3oLZqR46E46U2NhV6kWbgv8X4YhL2FPnf0qlxXlDTCBdultScx/yHkiOV?=
 =?us-ascii?Q?QoqzRyVZnrkqs6t+q1KWvYKY6ccJo/Xzp5gDTkY2ANyVHPw8UNJlTQXmRj4d?=
 =?us-ascii?Q?ztq1HzABQ1lERQ/Jv60AO7D22aWnZLvUqp1zEz5w/VFeISNJcCXZ37luD8Vb?=
 =?us-ascii?Q?ckeZ5pnF2kS356T6spQ5UlLiN0q4MjCa2Odh6kvcSb5MWlO8LmSYwdpV9zFZ?=
 =?us-ascii?Q?FD/jhIElGPR9BK4GxIeCIpKbVfi4tnWPT2awou2zG3Yiz67yAxPJbNbN0tcd?=
 =?us-ascii?Q?BKVCf5a+uMPAhjBpl8zTw1pzr0ldyfRqjt0fdxEnoWY4rQvH/nPz56GZi9f9?=
 =?us-ascii?Q?8tgGUgrQ5UQ5oig2ymUSY5CpA/EVeDMJmaWlpIAfcqZu6VbNVMJGUnoqSG7j?=
 =?us-ascii?Q?XP5pyJNcY9OuslB5JUl6Aw8LA61um/wq7pVfiJsEbPI+G2vT94JBlzJEywo8?=
 =?us-ascii?Q?d4GEJuEzbYZMaSUf6xARK5qsTTzOX9UKModozYe8zQXYzEQwfN9o29ihh+m+?=
 =?us-ascii?Q?7tZ41/+rK1f5ZRCLKfXODwtvgWkoD8yncqXBQj5LN1OoCQ5q0T35R1+nDjA9?=
 =?us-ascii?Q?VPdPej6TO1ChiFoGXjHIWIkHj9Hc/Y0M2I1nffBIhvkYzoV9syP+R1DiXgpY?=
 =?us-ascii?Q?GHJHfIz7pJnf8JNJPGboFHrWSIRQGElMz4gGkXaOD8KeHaFjTaZJecf7ca/M?=
 =?us-ascii?Q?pYpmJtHkpQAQdZMTZ3z/VaFs4ZQPsxSfGBYPelm3fIgpzMXmf5ftk77pBucZ?=
 =?us-ascii?Q?sOvVZ67WC0eK+s7sP4/WUgzEWt26+J4AlCsj64S88U8Wz9g3KwHSgpIpwlFh?=
 =?us-ascii?Q?l/W/O1wvSgmlcjlrdgsa2Benk7mBKj0I8cbjVPHFMPzwnhcWf+AVqFSZCISG?=
 =?us-ascii?Q?q7UdtTMWma1sW10cOVyasLBntqergT93p+nRrv/xGRQFq2IOgCTTGBsDXx23?=
 =?us-ascii?Q?7mry+jb2t073hNVeVmrN5kJcaARLa8Ga9hXDZbjJnnJmYZXCCaelf24AnXmB?=
 =?us-ascii?Q?1xIdJaSCzRyjm25eYXW1tYgDPEB09WedfHmiHw6HNefieP84wWNn9MVZ5cLq?=
 =?us-ascii?Q?DJswz6B8BTZU4kqjEN4kXyOaY+zOGpi9t6NQ7LGvMz17oY8oNYeSaXR6p12w?=
 =?us-ascii?Q?Gk1e7mvLOjVhzdb7HvgRoTSaKh4cD0rBJorVUjEFh/GBy+E1Rt4yyCE/sZDE?=
 =?us-ascii?Q?RyBEXnao1h6PSsl2Te21+BIWYW1gUcPjTWzngADdbcWCngvJxn79CLKDZ/Q3?=
 =?us-ascii?Q?D8Ow6iPGbumyzZDHaRXy5UgDr4egGLj/ByDvttGxXjrc/o+qyaZQmmIVcetf?=
 =?us-ascii?Q?M/P1N1beSnDxoTOiWXsqA78xmjejWb6PNhPQULOd5ULgaSFl06/5985ewi+U?=
x-ms-exchange-antispam-messagedata-1: aBs0UL6QgiV5gg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29C2F3C0E6B0AD429BF9FE82D1026412@CHEP278.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR1P278MB1104.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5577bc15-9a7d-43ce-517d-08df3cdb6912
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 14:28:36.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TziEJDzEwsuL3oK2HlDVXGkNLK054cVzcnLSJ0T2vMTHhU9ls0q+6136yBSFgm6Lxb7/hPrL34MjXUJ1gPJzkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1512

Hi,

On Granite Rapids, I get silent zero counts for the
CYCLE_ACTIVITY.STALLS_*_MISS events when other counter-0-3 events in
the same group fill counters 0-3. Mainline fixed this in v7.2 with

 30d82ddee085 ("perf/x86/intel: Update event constraints and
                cache_extra_regsfor SPR").

The commit has no Fixes: or Cc: stable tag, and the longterm trees
listed below lack it. Could you please consider a backport of it, or
of only its constraint part below, to 5.15.y, 6.1.y, 6.6.y, 6.12.y
and 6.18.y? Details follow.

Problem
-------
intel_glc_event_constraints[] (intel_spr_event_constraints[] in 6.6
and older; used by Sapphire Rapids, Emerald Rapids and Granite
Rapids) has no entries for
CYCLE_ACTIVITY.STALLS_L1D_MISS (0x0ca3), STALLS_L2_MISS (0x05a3) and
STALLS_L3_MISS (0x06a3). They fall through to
INTEL_EVENT_CONSTRAINT_RANGE(0x90, 0xfe, 0xff), but the perf JSON
event lists for all three ("Counter": "0,1,2,3") restrict them to GP
counters 0-3. When a group fills counters 0-3 with other constrained
events, the stall event goes to counter 4 or higher and reads exactly
0. perf reports 100% running time and no error, so the zero looks like
valid data. The counter assignment is derived from the scheduler
source, not captured. I measured this on Granite Rapids only.

Reproduction
------------
Xeon 6952P (family 6 model 0xad stepping 1, microcode 0x1000433),
Ubuntu 7.0.0-38 (7.0.14 based), NMI watchdog off. The Intel VTune
modules (sep5, vtsspp, pax) were loaded at boot and unloaded before
the run; the OE taint flag persists. The SoC Watch driver
(socwatch2_16) was not unloaded; its activity during the run was
not recorded. An unrelated workload ran on the other socket.

The script below runs `perf bench mem memcpy` on CPU 120 three times:
STALLS_L3_MISS alone; grouped with three MEM_LOAD_RETIRED events
(counters 0-3 only), so it lands on counter 3; and grouped with four,
so it lands on counter 4. No event was multiplexed:

 run  STALLS_L3_MISS  MEM_LOAD_RETIRED.L1_HIT
 1     1,363,145,483  -
 2     1,297,633,963  2,990,786,608
 3                 0  2,991,311,493

STALLS_L1D_MISS and STALLS_L2_MISS show the same in a larger test.
With 30d82ddee085, run 3 needs five events on counters 0-3 and group
validation should reject it. I have not tested a fixed kernel or a
clean boot without the VTune modules.

I also filed this for the Ubuntu 7.0 kernel:
https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2173631

Affected trees
--------------
The three entries are missing in every longterm tree that supports
these CPUs:

 5.15.224, 6.1.191  intel_spr_event_constraints[]  SPR, EMR
 6.6.161            intel_spr_event_constraints[]  SPR, EMR, GNR
 6.12.115, 6.18.60  intel_glc_event_constraints[]  SPR, EMR, GNR

(also v7.0 and v7.1; 5.10.y has no SPR support). 30d82ddee085 applies
with offsets only to 6.12.y and 6.18.y, not to the older trees, where
the table has another name. 7.3.y already contains it.

Possible fixes
--------------
1. 30d82ddee085 as is. It also changes glc_hw_cache_extra_regs (the
  NODE entries) and adds a 0x0200 fixed pseudo-encoding. The
  constraint table is shared with the ADL/RPL and MTL/ARL-U P-cores,
  the cache extra regs also with LNL and Lion Cove ARL, and the
  commit message notes the temporary impact on other platforms
  that later patches in the same series repair (4ef863352bcd for
  ADL, then MTL, LNL, ARL).
2. 30d82ddee085 together with those follow-ups.
3. Only the constraint additions of 30d82ddee085 (diff against
  v6.18.60; 6.12.y is the same at line 355; in 5.15.y, 6.1.y and
  6.6.y the same lines go into intel_spr_event_constraints[]):

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -356,7 +356,10 @@ static struct event_constraint intel_glc_event_constra=
ints[] =3D {

	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x05a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x06a3, 0xf),
	INTEL_UEVENT_CONSTRAINT(0x08a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0xf),
	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x1),

  None of the follow-ups change these lines, so this preserves
  mainline's additions to intel_glc_event_constraints[]. The commit
  also adds INTEL_UEVENT_CONSTRAINT(0x01cd, 0xfe), unrelated to this
  report; it could go in as well.

Thanks,
Georgiy Lebedev

---- repro.sh (sh repro.sh 120) ----
#!/bin/sh
# CYCLE_ACTIVITY.STALLS_L3_MISS reads 0 when the kernel puts it on GP
# counter 4 or higher. Usage: repro.sh [CPU]
# Kernels without 30d82ddee085: run 2 counts, run 3 reads 0 at 100%
# running. With it: run 3 cannot be scheduled (not tested).
load=3D"taskset -c ${1:-0} perf bench mem memcpy -s 1GB -l 3"
s=3D'cpu/event=3D0xa3,umask=3D0x06,cmask=3D6,name=3Dstalls_l3_miss/'
# MEM_LOAD_RETIRED.{L1_HIT,L2_HIT,L3_HIT,L1_MISS}: PMC0-3 only.
f1=3D'cpu/event=3D0xd1,umask=3D0x01/' f2=3D'cpu/event=3D0xd1,umask=3D0x02/'
f3=3D'cpu/event=3D0xd1,umask=3D0x04/' f4=3D'cpu/event=3D0xd1,umask=3D0x08/'
perf stat -e "$s" -- $load >/dev/null                 # 1: alone
perf stat -e "{$f1,$f2,$f3,$s}" -- $load >/dev/null   # 2: on PMC3
perf stat -e "{$f1,$f2,$f3,$f4,$s}" -- $load >/dev/null  # 3: on PMC4
