Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF9391E44
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488117; cv=fail; b=nF5dETMFj/O8LBHT/m8z87za5WqSuoBfvzMie1NqKWOVU7y6gQ0Oj0kZOa3OvJbtS6NDqjhmT5Q20Fldeb6mJJaBBQ17cOPXyjUcYZdjNodmK5XTdXLhmpkOE8VA+vQAe1rD/O3R8Q10wzFYv4pBNCTAgobUgwO0dGeeAQnZlCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488117; c=relaxed/simple;
	bh=UpTNAWLAPcI1tHnLvhIhGaHrBFuT8oJpff33lhphTh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RzA342rIat8Bs355bzqxheC5YMwAz0N783bGglJzdQqY5aEYzEKv35z/Rpprwl+dWdfL+PHdVcTOCka2yoEp7/8rjJwcsuM3fm42pk0f+eB097EJjZY60CtpmJZlz8I9GIlixiNGBdDZ5lb/CgVjIuyonAQwFbM7zJKLMTC6jGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=cGNVGYYK; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="cGNVGYYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnoAOCghQaikH0CleLpwevP1FzCYJtIpLC5yQNVmd7CykDYjGoZ1yevFoC4eMQJz/FlwhA9GSOBWWWlCNaqPzeSjC4Yx1zPiPXkUmfNxUfN22pbfsVpVpAZwQynALPef4yl5EIpbB54n50em6/UW9MkpuixOB7kzWY5kkCh4DDGuQZYKKsR8PX5KiH7ophAiEjHOn2R9rEEPMRXcN0x+JeYvoJe9MdN/CwjTFtb3CyZgJ+oAV4JmlPKIlpDS1rrEp+zBoM4NUjrBvGUIOz3L2hQMysjifOmERtAKqE44CZOO5msa6iIQ//NJVRiin0QX7PgUq2X/npsW241Vv7M6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpTNAWLAPcI1tHnLvhIhGaHrBFuT8oJpff33lhphTh8=;
 b=zTL57DyPUndZPqhCtUF/aOy/oUzImkpFbvkD0SRwDp1DiIZuhz6fZBatGoM+szx6BJAMVP8ZOc65a4wQ3nhFOCOgEAZfFRLGUG8TM9FaG6lPvyg2Hu+/n/9zK8iWwPw2xWuivHys/gUqTmKwhqHJZ5DBoYAT5m76bHue1/I+0LiM3Fkt1QpmHaht+guLgSH5+Qt44BJivkA/tLDdsZsXj4zy4MTJ8HVn4VEyd8K7J45uRhYJgzeKWlNB56R748xEeOKXKnfn1NRqpV42MfvotGo4+xLErBGPvMTmkJRJkGpoIafxi9Ci9oeaHnHSHyemvdHPiwo8ZLGyf5MSNwTVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpTNAWLAPcI1tHnLvhIhGaHrBFuT8oJpff33lhphTh8=;
 b=cGNVGYYKZnWbscDJI1nPDVcufjXktTxKz9Beeg+93b9MNMSSyG8Uv8qHdKw5xaC9bEQT+2bsB/nloXOIV8fw8hyIV32lvi3sCnfdYXhemvTv7XRd2tjG/uknL6DS/7n2od2lEboD3QY+GPl6R+IL2G2NFN8B9g8c96CA34VoIJGYctLXrwLA+bGtIge1GKDel++qdAUPOwP2D3HCHiFy7OvhSNEGwZFwIOcY7s+aBAlhRSVHjk2KbY1KZgxUNxVh06DHgHZlc88bRQlgHjxRb/WjsYTXiwAhfQWKeqyI6x4lGnf0Ywbt8svGiAxkHbLzUWhlqInpKgTBvK2JqDgc0Q==
Received: from AS4PR07MB8827.eurprd07.prod.outlook.com (2603:10a6:20b:4f5::16)
 by VI0PR07MB11036.eurprd07.prod.outlook.com (2603:10a6:800:2dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:15:12 +0000
Received: from AS4PR07MB8827.eurprd07.prod.outlook.com
 ([fe80::9805:904f:ef62:8ae7]) by AS4PR07MB8827.eurprd07.prod.outlook.com
 ([fe80::9805:904f:ef62:8ae7%4]) with mapi id 15.21.0360.003; Fri, 4 Sep 2026
 02:15:12 +0000
From: "Atul Joshi (Nokia)" <atul.joshi@nokia.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Matthieu Baerts
	<matttbe@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
Subject: RE: [PATCH] Backport fixes for CVE-2026-43198 into 6.12.x stable,
 CVE-2026-43198
Thread-Topic: [PATCH] Backport fixes for CVE-2026-43198 into 6.12.x stable,
 CVE-2026-43198
Thread-Index: Ad07uM6LiZnRrnXJRlamNQQBMLPh+QAEQhOAAACGHIAAEW8oMA==
Date: Fri, 4 Sep 2026 02:15:11 +0000
Message-ID:
 <AS4PR07MB8827D88BF7A373A0B5EFEF1982B52@AS4PR07MB8827.eurprd07.prod.outlook.com>
References:
 <AS4PR07MB8827D3A807C2D7FEB3EDB06682B62@AS4PR07MB8827.eurprd07.prod.outlook.com>
 <f54728ae-c3ab-41b8-81f4-6bde4450ce8a@kernel.org>
 <f13d81f7-5019-4376-a77a-67c2cecdc2cb@broadcom.com>
In-Reply-To: <f13d81f7-5019-4376-a77a-67c2cecdc2cb@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8827:EE_|VI0PR07MB11036:EE_
x-ms-office365-filtering-correlation-id: dbd10e5b-7dbd-4b7f-fab1-08df0a2a59b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|4133799003|10067099003|56012099006|11063799006|18002099003|4143699003|22082099003;
x-microsoft-antispam-message-info:
 s/p39RDs+igzVbYvQmpDKp12lC/gOPZUiZvfL1fTWUkLPxEPfU2F4vbAy4SPHWduHZzb2SxscdoM6cMYAcn/FAaLE/7uT2Ki0PZf5Jzi9gRld2nYL4l68qPe3sLUXnHRi81cev7c9ZC11DTeleIdw1VbvEfhdu1lqQ15VE3bZn3YLdJwaVBgyiHH+TtVw/YS16ErGGgyCb+aRjbFW62MogvfZXakqhZVBXEsLyrD+HASvunxg8mjy6SjTDbcZJz/wPQycsdi30LgrEnzIIt6K82doSs3PjkoeO0yg2kq8VjKotXzRvXcOJaeRTswIvC3Ijycu8tNd8t5C1WSiRfeJ6j/cR0gNfIMypj8v3eJQJO8i2mkvASBmNN0Y+TUjcXcFjM+SllwzV9CUZMhFPBhtbh8mw9yumwxuHrViuWKyDzvxAU41EpXOdCv1l8Qy2eSUz+hoPLx8CCQcF35VD6DOYxNYaRAoyBuUj+Yi5P0gjgfu/FtvDiKBdjG6478Dq5CdE0MAU+Y/MaV4tyAp9i/k7SNM6g+ITK60n3/WSuuZzmiZk6Qzxy9TNwJ4O+UVqJ4Kxh+/aeYwvDCCyd2BD3XkCdKbVBYbxMruaJwjzdPAnGPBz+E2o1I0CqTcbubehk1xMfBddgXXabsXbTvbAWV2qJcWpkcG/aNSgkEa5Uc+1qo0iqB0wSIrn5Rt3ah1BQHhmv0V4O1x+QGxDniQ4B19kLb/ZlqHYY7dPKFLKR5Ljw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8827.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(4133799003)(10067099003)(56012099006)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GDJ5o8cpJLN7bURV4xdgt7FTV6aJZ8z3Ipf4tOUz7hc3RioMe1kqFAZYXkIb?=
 =?us-ascii?Q?L56iO46bk7wLGAZnu3grG8gC7TNgtHiCuK5yLsPDBHTfE/E5H2cR3z6REbkm?=
 =?us-ascii?Q?HFP2FdhN38FVyujvIGBpZdxgmfn0EtArRfPBJPzj156CAKoYU0Cd4AQe7A+K?=
 =?us-ascii?Q?ZAgwOCtOVhCcmpEpDFMUUp7H1CtAT21kv9Oawr4JrWRBvYrUYUPYp2jvWEAG?=
 =?us-ascii?Q?EBfUkOXxtGlSbsbf/X+goz2E/Dw6NFNP72Jt2gZsg+PyPxS54kras1jEEtbO?=
 =?us-ascii?Q?ivfGYO13G028ACwhfxKIe71p8IJBOveoDetGf3EXJs7bbNRNAkX+e3dLt9aK?=
 =?us-ascii?Q?pU5nvquMvzMThjfxC+kOptJJcoiGCrcHrN+CdxJZhrEN1l+2utSBvtuIM6Sf?=
 =?us-ascii?Q?zG+5zrOIi1d6ngI/RWFRNxXqiodBuOMdX+n4AWIYOGSIaJVMp2A7OqfjINoI?=
 =?us-ascii?Q?Tc1eKU0WMtAQzkK3p2g48MgSf220A1aAJsgiTvEBUY2g6PTpG7kXp/mXSbXG?=
 =?us-ascii?Q?HMC/3RfbnI4GNHw1o9kulyvzuSEKh4hKArwEdqGAn+e2ZI9toz10l71OUWlK?=
 =?us-ascii?Q?cT/Gj2RP4836ZVmmxu7bQn9YY9G5q9UJ0ytz5D7XAlWDQBkSgypTzDuzKuUO?=
 =?us-ascii?Q?IUbdCbwhy0F0WVbCvWj6C9iH+7ZJuHy51n2RU4JMNGCU27fGU/IwBsJ6mkAl?=
 =?us-ascii?Q?3A/DNvVPHJl8ueNrcdREr4n1CsM4EaZdSAJbLcBS0AXtstqV4qGlb8vsI+bt?=
 =?us-ascii?Q?cmOtle8DGQ0ItS/CUHqBjIGajR+vJNvQBADBvn3/g9uRA4hAIul98UAQK9Z8?=
 =?us-ascii?Q?6D9VeOjo1YaxpcLmfpLuNkr1nRbJ429BRI4h5C81fOxfmjd/x2nFj825pp8F?=
 =?us-ascii?Q?ZnroeTuIc8C9twBJso0Ux48OsskJOvi1RZwXXGf62HpvqDgugCb3SrTG7GSa?=
 =?us-ascii?Q?eowSsifgpL3gs8ePPe5Ovvvfw8awCUDgsBJZl8wJYSyjSiNTEsEFow4vd0W+?=
 =?us-ascii?Q?u9E/FfzHN3BTk63LkC++ybytCnLZo8bwNX56DpJZAITn7xKi2VEUFjizxeRC?=
 =?us-ascii?Q?dppEQlxdn6QDiRyMcMFKYkyAL2J5dHuDTLkClyZR3Lx1ztYEb9HNpXIBe55j?=
 =?us-ascii?Q?44wUa+JeHj1WJ3xnJJWq6XKhNY87eMBhOxP7II6srd2NvgpGOV52lVt5kn9Z?=
 =?us-ascii?Q?ylOBeZfZuKMqs3W2wL9l7e8ue6DTsJCmjEPl4YBZZTXfRe2+GkkQKrvDp2KL?=
 =?us-ascii?Q?gzfbGLNOTS1JMgcItafQ/M1+ygEN3QYNkatr038w94e1ZI9TAT46SA0caQUe?=
 =?us-ascii?Q?bvy64M5bFcGi/31KQTDlZWEq5ZpMNFRpP2JvBq45lSnCZbcUBwXAcALqyz92?=
 =?us-ascii?Q?8K+RZQyaL0y6+JI6IJJYmYCKN3CtD9YDKmPPMde0SSb89SULDaFc0szEhmO3?=
 =?us-ascii?Q?xR4rFmC7dLpUe93QanW/qh+vUKmsi+IwA2Nf4Va9r2fnbclC9TV6KsNij8jb?=
 =?us-ascii?Q?Iitdlw84+fonlg4GCIpv0d25OPBR9xIP52Ex9HCAxNN+Wj01Ubpo2j39TwVl?=
 =?us-ascii?Q?dkmopPeBJhwR1s/FC7S5eKICFoLo/0OW70ClWN1++ywzwh9ynO01K3ILAKLC?=
 =?us-ascii?Q?u6lnIjuEOKWvr94wFyKAcVNHW11BFHLkMAboJv0jxwnz3rxrl0d28iUbeB8f?=
 =?us-ascii?Q?NWRx8Gjjx9novJ7B/niuxlASd6NwbwK7ozK6S98lXClQTnhjLaJ7U/TsCXh4?=
 =?us-ascii?Q?Gra8xyGXxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YXJGyJGXZY6F3JLEiffwl08GEDKaIk+bQUTbGkO4jFGZ21Y5dabeEtoAhEwTKNR+5W3tf7Tn2n/w0LgKqfrV0bXDIZAZ779LpluoaTG0TyQKAU3CUCs8vikReoAfXYubpQmReNmyMGf3+c+HcOhXDI2oGF0gCQqHPzoFcbwXb3HTwmPUJrUJb2iOXkDM5CZjxvYaC4IwlSCL7mfE3dkr65kcqs013ECCKWoSF1vZcMSC7PZttoCDL+P7TLEiWir90ir3qKShCbrzQwFE2HG8CGoTWC9sNoB8yb0rw4gRF3ELPANksiI3xTHo3OpPqHRm3PaBDiYAZGdo/NGBgarjsg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8827.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd10e5b-7dbd-4b7f-fab1-08df0a2a59b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 02:15:11.9318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XeQxPqu/0zSi+p8vt9LTnStuwFJiQEAptj1Zhy+y4B51XbrP1ZQ5MvQU1LiCGRI3oQ+Y08rrhP5XdviANIj7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11036

Thx Very Much for Info,

May we know which release of 6.12.x we plan to put this in.

As of now we are on 6.12.107

Regards

Atul

-----Original Message-----
From: Florian Fainelli <florian.fainelli@broadcom.com>
Sent: Thursday, September 3, 2026 11:15 PM
To: Matthieu Baerts <matttbe@kernel.org>; Atul Joshi (Nokia) <atul.joshi@no=
kia.com>; stable@vger.kernel.org
Cc: Joakim Tjernlund (Nokia) <joakim.tjernlund@nokia.com>
Subject: Re: [PATCH] Backport fixes for CVE-2026-43198 into 6.12.x stable, =
CVE-2026-43198

[You don't often get email from florian.fainelli@broadcom.com. Learn why th=
is is important at https://aka.ms/LearnAboutSenderIdentification ]

On 9/3/26 10:29, Matthieu Baerts wrote:
> Hello,
>
> On 03/09/2026 17:29, Atul Joshi (Nokia) wrote:
>
>> May we request to consider attached backport patch for CVE-2026-43198
>> to be submitted to 6.12.x stable.
> FYI, Florian (in Cc) recently sent patches for kernels <=3D 6.6, but not
> 6.12, not sure if it was on purpose on not:
>
> https://lore/
> .kernel.org%2F20260903000029.3508006-1-florian.fainelli%40broadcom.com
> &data=3D05%7C02%7Catul.joshi%40nokia.com%7C020ebc2630b94793eabf08df09e31
> 5e9%7C5d4717519675428d917b70f44f9630b0%7C0%7C0%7C639240543101960366%7C
> Unknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D7GCf6s
> k2%2BVynYAL3mmjllAgo1207sKAqlaIISMC2yLQ%3D&reserved=3D0

Not at all, I forgot to include 6.12 in the script. Now done:

https://lore.kernel.org/all/20260903174016.689839-1-florian.fainelli@broadc=
om.com/

Thanks Matthieu.
--
Florian
