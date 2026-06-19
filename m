Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023073.outbound.protection.outlook.com [52.101.72.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D630F927;
	Fri, 19 Jun 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853761; cv=fail; b=K3jnbFPZ0hf3/pQ2AVMNaAb1nWZNs1F8WOQiFtyYj/zLyGajSGeSf6j5V6hWqFIpD3Gx3UpurWGkB2WMYgznEh3rcj7a/zkXSG9IF3q20Up75mdyeFQPNPWwLOh/s0Sr1DmkaNDC1kie7YePUpW/055RgzKuP+aOgTxFAIF5yME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853761; c=relaxed/simple;
	bh=hGP0tDiGS5xgR5U2WStJsxq8sCKPCOaSVdTQC1ahJls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ou0gTg+jksHAPfWt7TvIS9xbvtVHn8VKC+hPVrV1oFOaxz02rXHzHmNvJ9JcgN3yTV+RWH2N+nZ/FAHixw5Ut/far38EtRcFL3VmRCTJkYBvLsUJKe9fyAbg0lQ59hoGunafmRK9wOG0J7RUtWPZ4hFhOix6O2fmZDvY0hWr1NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl; spf=pass smtp.mailfrom=aweta.nl; dkim=pass (2048-bit key) header.d=aweta.nl header.i=@aweta.nl header.b=FYMxcXS0; arc=fail smtp.client-ip=52.101.72.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aweta.nl header.i=@aweta.nl header.b="FYMxcXS0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMXR4W5FqQRp14vZzycFwhoZaKEgxvc0+FsIFrECC813FWNB2x+fRgba0OJnbSqwl5RFQTlqV/XkH8lysyIrCG+PVedCAaCJxB16jenGIzOWhOLYjzdOZNIGGQo6O2Kp0eTT0dnB2oejl/GfZFa99dvwhK9q4EmpRjR4Sb8+QHoW51hx+Gc8xeixGO8DPWgbZ01DMOeko9h7apzABcNBHB3dguFqTNVMH+LYD9R9yFcHJi8Z+OztlaBSZJ5bdVBxzvJbu5PNIhuRrKStwf3ILrLeguDcgmJXdAOga5PF2F865YAmg08eztxEiTURt7GPLqErghRyyZ4rLehmWAdq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGP0tDiGS5xgR5U2WStJsxq8sCKPCOaSVdTQC1ahJls=;
 b=LILxKMN7qHBiGV/ufysEhOHxrHaXlJMgdnfiX+csLp/0xKO5Sa0ff9IS5yiFcnYH9Imo3fh3dTqnYwQyGLIS3MNSkXFoO6GHb1dUxl9aLKZpAJaZEmk9AKjdyK09CTF3GmmpV22s+sVP7I7nT4JA6Vb2k2WjHWbf8Ru4MOLpxXvXZdqkrfcTEbkejpiPhIicUVlF+j5DAgXPeAR1ax4UA5JUNwS/Hbez/3/kTPX1TeVHz55+D1y+O6lGqSm5nN+iyiUN6eAvB7c8HXM/6VvoBxhCIhVRVwu8OjkdBDEZ+bs8SkZFXivK3wt82hEBHAq0io3bKcq47AVwIL/vpLsr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGP0tDiGS5xgR5U2WStJsxq8sCKPCOaSVdTQC1ahJls=;
 b=FYMxcXS0+OwRCI2E4tYwDOmpV86DLONMQXNMBjhTbDNwQmnxPa6aIh5li9F7TcvGvZkSfMkLICS8V7R8wqIoA2zUbxajojSidY1e3eVCY3HbJCfa22qxNK3kxcSy5iEwrWmE8cQWkRIEVgIdRj9o3bkl8j4j3UlA/rn4G87kIMMc3YTLp1GFGWsp8X49bOsx53SFCziB451T6sCYEs/rlm24dP8O/P6YjFjHylRXcdxRSi9g99GyESjW/nyMkX7gMs17XlxGc0tUlMuiN3dnekrmAN8ZlakjuiXl1Bh5ZVXdL+GmNg/UgQ0gXclloMMBhtvMZfU+2dpAnul5DcNZ+A==
Received: from PAWPR05MB10691.eurprd05.prod.outlook.com (2603:10a6:102:35a::6)
 by PR3PR05MB6892.eurprd05.prod.outlook.com (2603:10a6:102:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 07:22:33 +0000
Received: from PAWPR05MB10691.eurprd05.prod.outlook.com
 ([fe80::3b9c:573e:3c13:3754]) by PAWPR05MB10691.eurprd05.prod.outlook.com
 ([fe80::3b9c:573e:3c13:3754%6]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 07:22:33 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "hawk@kernel.org"
	<hawk@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] igb: only strip Rx timestamp header on the first
 buffer of a frame
Thread-Topic: [PATCH net] igb: only strip Rx timestamp header on the first
 buffer of a frame
Thread-Index: Adz6QcrRn2ovfM6lTRK8EOoivUdfWACWOigAAKuim4AAHLI38A==
Date: Fri, 19 Jun 2026 07:22:33 +0000
Message-ID:
 <PAWPR05MB10691A87E84AAF07B9E7F4A2EB9E22@PAWPR05MB10691.eurprd05.prod.outlook.com>
References:
 <PAWPR05MB1069106D52F4E17F1EDB99C67B9182@PAWPR05MB10691.eurprd05.prod.outlook.com>
 <8733yojljf.fsf@jax.kurt.home>
 <55ab9b13-ee51-4ac6-af7b-b3feb159eb51@intel.com>
In-Reply-To: <55ab9b13-ee51-4ac6-af7b-b3feb159eb51@intel.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR05MB10691:EE_|PR3PR05MB6892:EE_
x-ms-office365-filtering-correlation-id: bb4a0f3f-df52-4cf8-2f2d-08decdd387dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|38070700021|22082099003|18002099003|4143699003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 bP7+JvFlqPMQ/k5LGJ7CMvZ0PC59HyAjWceURO3fahO0bO2mK0geK2JIBUqJfYd2/cOs1KA+ozxz3uCIkDUlBc+uAV9qXwl19ghBg8YeTtnJ5/uE6hurK9Md3pbGj+ubSUoGj53NmJ5dPSnYwqGPpL8H523u2ckbhk5br+rANb1rj1eMNhPG6Ba25CVAKgHgtHygh33F23tR3hGMJn7vZSQwzg9ICngAxkvebN5PVQW4jnQ0jlVhF/L9eH6z4VMXDu/pFvBbqtW6u8Gb2I0lwvOmoW7mtn41fycj1SzEKD/SlCpwXRm9GXnvorfJoY7kFVhiGe16uprHYzlqMOeIPeijMLweYcDFRwDGQ/Ert3rIdlyRF5yErUSh6rw2WRVefG2DVUQbenVj1zU+Jwy5KHMiN9PnhCrC8MFhOKd0yVOINZX/iMIb4sVZfm8pF5jtuq1OUsAMSpUhAG2N+fcl+aPLpNQIh5xHWL4pNoTDzR4P5CqzWh2oFNOwRypFWmxMBGrJjSXcS9C9lbrRhkdx2txEdMlat0M/eeq8905hwa0F6y919gqCu7Gw7Q9uEqaTUiaK/U/N2ltSiP2C7ywE43qzoNu8hpny9vymROQ2nZIiU8GwWtsBucxlpvMFkCht0YLcoesIRkM93fIppcdzQ7kiwVitKBHcpKO9FsrSAoVlL55m7k866MZ+lu6QPhtFX/T3Cn6+4EfQvnfApaXjnCtLSrlSfOl/VvXcdfOeuiA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR05MB10691.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnhvVFp6NUJSRXBNK25zT3lrTDlBa0VIQ0dXZmMrOWt1UGs5WkxWOUtuZWRz?=
 =?utf-8?B?bi9zM3RkSFJMZ1JOa0RjZWJKaWc2ckVTWmp6VzA1Z0sxNGlZcnRmTlRGOFBu?=
 =?utf-8?B?M2xEMmoxSXk2cGNGZGFCT1dnSVEzbnZyRTk3V0g2TW1icW5LRkdEZFNyeWVo?=
 =?utf-8?B?K3ZxMjh2b0JYN1JGdytRb1MrenRsOXBtYkx0dG1sY0ZKdkU4c1U4RFdWUTRs?=
 =?utf-8?B?UW9BenlzYzhYZjdiS2pYQ2FKN29Xd0dtdmUyN2crcWJGN3ZKdjJ2aEh6T0E5?=
 =?utf-8?B?YUVlejhkVHlBclp0OXZrayt2OStCWnFzN01RUW5wbmo3Rk1OcEFmblJXZVRj?=
 =?utf-8?B?cnJsbkN1Z0x1Zk9ic1dmeFFDKzlnY2liejRLVU1LcEcvK29GVVVVelg0WHM4?=
 =?utf-8?B?QmM0Wkd4ZmZOYTZyck05TUg0Z0lvOGpkbGx5dHZiQ3MvUW9KOFovOTJ5R2hj?=
 =?utf-8?B?N1k3NmlUVUovQWt1Nmhwc1VqdXpPeFVGdzdCemoxcS83dDhmMitaV29YQ2lC?=
 =?utf-8?B?SFZ5QmxSYlYwaWZGNEF0Y3hoazRMQW1UN0xQQk93aUlHbGdOZExDR1lXUEVO?=
 =?utf-8?B?TzRiK21oem93SmVDb25KaE41WEwwa3hNUXgrdC9zQSs3SlFZYmlkVVIweTJU?=
 =?utf-8?B?Y2ZGNlZka3lZeFJTOFdNbTAyRUFFa296aXV3NVAwWHJzZG9qcm1BU1R5R0Va?=
 =?utf-8?B?d3dmdGZ5QTNSaVAzak5qREUzcExKeERXNjZsL1A0L1EwZlJmSU5GVlc0Zysx?=
 =?utf-8?B?WnlESExUYUtKVGFrV3ZYejJiemw2VWs2SVdXWnNYbGErL2o0dkdwNGtlOWFl?=
 =?utf-8?B?bFUrY2daeG1EQ0xkTHhvdUJYOVBQaDFYQWQ5VmRacU5DR3lOcU1CMnQvMk9r?=
 =?utf-8?B?MytXUWo1bndzUzVGM2hNRnN4YkoxU2ZaOU45OWptL01RcDNTUFdzNU9Yakxx?=
 =?utf-8?B?UWZQa0Jwb1A0TW1wQ3d2Q0JHRldVMi9yYzNxNHNkRHdYSU5zbUV4SlVnR2t5?=
 =?utf-8?B?Y3dROHk0dUdqYWFyaGdqWElnOFMxR1AzZ2Q1TUlFQmhkd3FoM3NlbUZuNWJ6?=
 =?utf-8?B?VnBzVzYzSlFLUVg5MnVkWk91a2xrUFFmUzJIelNKVXp0RlU3UHlZUWwzZnM3?=
 =?utf-8?B?MmUzVVg2ZngwNTFhMGdUaDZNbEhjNlBZQXRsZXYrS01HeTNOekxRbExIdXZr?=
 =?utf-8?B?TlZIMmQrZHRaeVFKODFTUXcrTjJ0WkpxMGxheWJENHl6ZzEyRWdrc21DMlRL?=
 =?utf-8?B?UFR4bVlVZmZnc3ptcUR5Tmw5ZE1PMEg3bi9yanpNQ0ZOdk1lbytLVTRrbitB?=
 =?utf-8?B?MWZsRVVpODlrUkYwODRMM1BIdUhhY0JDa001MTMzSDhqN0Z2aWdzTGs0b0NP?=
 =?utf-8?B?QkNQWFkySktFQmx1SDdBSUs1eWdhYjA2aFFFTGZuUVpiV2NPR1g1MFdOckVC?=
 =?utf-8?B?WDBmYk5ORzFkYTlMMC9Ha0w5NEJLaldzbkc4eFFocVQzODNteUhET1F6bXVM?=
 =?utf-8?B?a085WkZSRlViODBnb1BhMDVEcElvamdlVmtTc0RiUE8wQVcyVy9TMmJGU052?=
 =?utf-8?B?RDB1a0NzN1EvdnZ0ZzVNa3h5K1I3anVQRHNTWFpYa0FoMUJGTmRwQU5ocWNl?=
 =?utf-8?B?WnhoRTR6VElvamhub0hLZDVSRE8wV3c1bjdoaGdrWGtpV3BxR3ZnOE00anJi?=
 =?utf-8?B?dFA0TmdzU1o1VXgrYWx6WFUxejQ5TG5yZTdueWNEb3lNL1NEdEU3bTlhSFlo?=
 =?utf-8?B?VWVkRjBqNTJoR0Q0aFcvVDhhTTZQbGpsL0lBSlN3bXlBaUFpazlNQUEyK0pG?=
 =?utf-8?B?c0ljaFdTbzc5UmdHV1Z0bEwvb2M2ZjVCVHVUZkU2UHFxYzZrbDMyVDNCMUZ6?=
 =?utf-8?B?Y1pzMkZaNVVNUWlRTmhkbE9kUTZsRHF1OTZUMnRna05zRDNFY0EzclJiRGFw?=
 =?utf-8?B?WFhSdGNoNXZmUnAxYXpmUXVrSExxTHNZV2I2aDAwUE1CalRGNHZ1U1BMYXBV?=
 =?utf-8?B?ZktNT091eUNiL1V1dDFOM3JyZWFGSFhvSWtzMW9Jb2QyU1BWdHNiekU5aXMx?=
 =?utf-8?B?Z1dRLzZXNVQyVDNPeW9RZnRPZml1bmg4OTFKYTlXQkVVM2pRYjdYUjlPT1VH?=
 =?utf-8?B?enk4cmdnK1o5N2M1Y3B1cHpDR1czb2ZKeFZIcU4rcStLekxDMmlEbVBMZTlB?=
 =?utf-8?B?ajBKVVdubjduOUNEaGJTMC9GZUtTV1k5dmY2bzhHcjVrMnhSYWVFczJ2UEpC?=
 =?utf-8?B?M3h6QVNEMWtEazFUeFBMcktMV0loR1VhcW54eVVQVThWeEpsVGRNL1NJMDU0?=
 =?utf-8?Q?bKmJ6UzIl5vLLvORvr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR05MB10691.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4a0f3f-df52-4cf8-2f2d-08decdd387dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 07:22:33.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WS/aSnm6jymW5nVyj1GyR7ErmqC5VjHcUUiH3MYDrCjQWtaQggKBRpBJRhT/KMnUWcxEeZ0xzj3AeNhrYoKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB6892

SGVsbG8NCg0KPiA+IGI0IGhhcyBhIHdlYiBzdWJtaXNzaW9uIGVuZHBvaW50LiBNYXliZSB5b3Ug
Y2FuIHVzZSB0aGF0IG9uZToNCj4gSXQgd291bGQgYmUgZ3JlYXQgaWYgeW91IGNvdWxkIGdldCB0
aGlzIHNldHVwIGFzIGl0IG1ha2VzIHBhdGNoIGhhbmRsaW5nIGVhc2llci4NCj4gDQo+IFNpZ24g
b2ZmIHNob3VsZCBiZSB5b3VyIGZ1bGwgbmFtZS4NCj4gDQo+IFRoYW5rcywNCj4gVG9ueQ0KDQpJ
IHNlbmQgYW4gdXBkYXRlZCB2ZXJzaW9uIHZpYSB0aGUgYjQgZW5kcG9pbnQNCg0KUmVnYXJkcw0K
VGplcmsNCg0K
