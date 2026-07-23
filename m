Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA73D890D
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790907; cv=fail; b=bDzBXLmx95f2Ya6QNUHYt1SKMqYsvKZvxLthhwlmKfRLr7pNQ0P5t45uDsaSeCpN3DeN0l7H7PUQ7ZHGmlOjQpNr0uNMHcDSCzyXHMg/jtGyk7hX3LBEutlCCbsH8Ox16EQraIOHXtF6R7IppPaYIZh6/xq5PffofEYt2jF72jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790907; c=relaxed/simple;
	bh=TamsMNEfbhOmiM8e1izNj6+08AGp9KxrlQXAGCLGRH4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=moe0TeO6M9q35TNtTdlwxli5lGyiQBWEh11oRVTDKl/fUv+UYH7A/G6HC+4q2hwMuSPg9fgNKWpd+vmJs5nyT79UvWBEzHeAVa+x/1rDt0M+VZ4IIiBBtZ7rCpJWlF/sQF+1Uxy4Sd7IjMccDA6cnG3Qlw2iMQ749Uu2heBMmL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=qOqNV0my; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="qOqNV0my"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2YCj5yCmmJ3qB6TJsOZnerdP8Q1/OAJuRlto7hS7n7LD1vg7ax3IpNZXCDLEPkMduJLCBLdLXk1r71h03TIfi27CnfnaSgvogaze05jw1f1XI2EBWqXIAceyzB42U/ERYce7CWE9s9dcsaZchkeP3b9/Y6ZleKrp4ylI1x6IYx1+1zMjcS7pWIa7UOHzUvu4FcO18UWRGZjJksgBetMbTcvUqZCmzFA4hQ6NXuHnhPczB2JlINg8oIQdC0+eq/LnOxgJfDBwIDPvFaRKQ5iCRt6WwFnAb9T7wLTwFiGD73vjAJAV4B+Y0RsfKx6ewwSBbv2C06QuD61hg51YJ1zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+Mu3l1zNuZOgqUvJ2+yDyg5FnBL50f85GUIaAAwBmk=;
 b=C4Qy9ofIWW7RfR/dCzIYegMHzICEvmiWDUlr0kR7XwmI3czy5jnCFY4ZXWTe2Ofkpes4h8EF9UmAyvQh14dKSZN5dKtxgVuesrQGp1ew9cxpiFFCOVv4NKGCjtL+OeX45rID8Azut4G8TPJD8cYRgz4j4pMbfXbEkYsi9Va5BWTqoR7hXddZUYpFXWfL+SmkEvR9+6v6DO7UqQoeZFe3E6bgltaSQ0PD3u6z0jZK2iR6pGazlMGfxKNi69KPejU1/Htf46byOIr0n1gqz02K4zCau5UX1vxwmCvgLlG1OnBJnMFLcpZQN594pdP6VqIscsic7p5DXBO9lav/Jzotuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+Mu3l1zNuZOgqUvJ2+yDyg5FnBL50f85GUIaAAwBmk=;
 b=qOqNV0my8LmYBSXbxhNODcgCe2WBUL6F5iP9/GV4ZlZoyHKkZPawIM4jAgUT/z/meowr3/qcLnYRx3cDHdpbdR7+lqbsDS2B+SAtzXgOqCSbsspLAq1oxvoFZz/GJNM5SLU1gMBFxsUWTfrMcFSU7WdzKS4WloWsb3MYePpxgQzFJsegoRf//wbhW+sLAWD5Lr2maCzsXKwVFSspJ6nNRpqkus04VXYSLU+lbLL3Y/lCpOOXKU/yPSkRcCWU2cZzepS0iI0FnLUSHBsAh+/rgPvlczM36dybikBCgaF5PbLTBu6LTAcM3e5yMrci1olYj8iEQxvGSlycrsx5u36QGw==
Received: from PAWPR07MB10071.eurprd07.prod.outlook.com
 (2603:10a6:102:382::17) by GVXPR07MB11660.eurprd07.prod.outlook.com
 (2603:10a6:150:316::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.5; Thu, 23 Jul
 2026 07:14:59 +0000
Received: from PAWPR07MB10071.eurprd07.prod.outlook.com
 ([fe80::1dcd:8631:dd7c:f813]) by PAWPR07MB10071.eurprd07.prod.outlook.com
 ([fe80::1dcd:8631:dd7c:f813%6]) with mapi id 15.21.0270.004; Thu, 23 Jul 2026
 07:14:59 +0000
From: "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
Subject: Please backport 101f3498b4bd to 6.18.y
Thread-Topic: Please backport 101f3498b4bd to 6.18.y
Thread-Index: AQHdGnEWTqj4qCpD9kasF8HeqNc6+Q==
Date: Thu, 23 Jul 2026 07:14:59 +0000
Message-ID:
 <PAWPR07MB100715EA5D8FCEB34B9987DF69AC02@PAWPR07MB10071.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR07MB10071:EE_|GVXPR07MB11660:EE_
x-ms-office365-filtering-correlation-id: 525e9010-d79e-4d5e-c40c-08dee88a1b88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 8+KcLISn70XEH5jk0zHQ07/r0Ri1Qj+jUBCuCRJu5SS3/yJEIkPJHPn12CWHPgrffoVzvxk5aeKqF5FqW/ahK8ceSMSlnp5ItYTmxXIW5/o0ZGwbmuBupWacXX4CA/GSxv16sL3OfDiFbkxG8xqaixdH02dUAYG/X1ONVvtIaRrKNeJfzBUA5kZ9Er7JBDfWVgztATHVbV0+1S6ryxPWkOnfoCNiXMb8rR4yHm3BZjQG/kAEi2QY5VVp4oDT3uKvoVIdnodtMlabxl3gFkGXz8ynySaIcddR1IZmn3twVx42Nd5qyizjXNwC30jS8vDS5r4olN4LKyThqy6eCjm0Nb9FbikVI2TiKg8HKl+0q0whgFkJARhrmxiGzBvA8l4nBv3T35+Zm9kSR2vsO4gWqKteBT6pAm5hS5Bj5FkBrraKHaJnpoywtPMo8suWEukWGEINS+Ul7xDXuokKxQfqs31Vp0ZYcmNb8k3NUD4Dx1XmM72f2DRHAZgagXjl7zoJUs1M2yJ+GUIuVxYzA5hC1a1tUYRAFo7uiBIFGjsWbEWdkiXc8MXrAUETEHsr436tSZHkl9/DRaHk002Ip9Gusut4x31+OLWeq+q88ihm9oJwLbQhkzXw/+GLK9XTlVLXNm1aJ/Y6ORdlX1wQm9dsoGpCERhwGitH8n7ooHpRLkllccj7wp5fy2YmQAKGMY+X+l6zQ15d16KQ+h3azpWLVLZa0stRfXU+xCi1meun/20=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB10071.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?r+m3seFdCyJQARpma99ZS55IC+X2joXfb1tD1zOVxxEA4Udj1q158oWhDp?=
 =?iso-8859-1?Q?0uLtCmvv+gAb4wGcLViKDrpNJF4CgFu2ynIBqnHMRZT5K6tNm7mwx63Sgs?=
 =?iso-8859-1?Q?llqF2D0IG5BAIQ7595TSD8vPPdAd4URH7eg5ruZLk7ZS03CTFoWaPf+JBv?=
 =?iso-8859-1?Q?V+enj659ViUWTjeA3wIJ9nm8Ol4u7GTstDjtMo2ikm1RurAbStUkpG9qzh?=
 =?iso-8859-1?Q?imWDfPbdvzHKKNt1tUUwU+l/XjSrFtoLi02Nu4ttJ9n1Z6w0NEeOD2AYrw?=
 =?iso-8859-1?Q?yh8faD8O+Z78QoSzMrXtlhO8vGtb3LqXCswFL4n/cC6eEosXq5YFz0hyNa?=
 =?iso-8859-1?Q?Icy3LeTwqu4OK/ytIF/BH/Y6rlXbdUJW+DgXgyAlLIAclDIvHpq25qHV8V?=
 =?iso-8859-1?Q?qvYOjASPoUBm+CzvvxH0c8Q2g6YZiSLk1rpQM8itgG+s8OvhOTa2j76z0q?=
 =?iso-8859-1?Q?BTqaTFYtSokLjlUGvqgFUSRuDhTsCm4rzRCvjKrSX6Sip9oiCV9VfZSApY?=
 =?iso-8859-1?Q?GtOyHMfZ/zcfNArsaSDUwdXLBAmr84sa3MzLn0rb+MESkHWaivXuu3i8Mq?=
 =?iso-8859-1?Q?xcYOwHoBhnONF85PKXt21/gRDce0s+9x2xViWMmqv2LMhJnHM5P/D2fEYz?=
 =?iso-8859-1?Q?5IYW9dg6wjfEA3wZmT2kqHKC4cUMDs/sMZs5FNxsV4BcfpFAS69Uf8JahZ?=
 =?iso-8859-1?Q?qv1wtj3nB5zWgPtrd7YI2g9qTgRHAIYuT586jP69hbIBcfoQFqwEJk1ydZ?=
 =?iso-8859-1?Q?KNPMuklY+SeZ0rbbZl+lg/iPkEl+KbUsbBD654F+3ccB3k0DTwfAcIle4u?=
 =?iso-8859-1?Q?VSFrpTHUYqf6pzIB4ylFJJxN4PUqxVNN524J5upwtJ32HoDepVPE2B4znD?=
 =?iso-8859-1?Q?/hO7Bxgztmo3+O18dHxEv55y0q+lGEO/N3oDV45eIJwj5gP1IP3cI6g/B6?=
 =?iso-8859-1?Q?D4UqfTFHwkORwS7gQzBqUB2g/EpIzvSnsRmk5nNb6l+ynwqZx15IIlak2f?=
 =?iso-8859-1?Q?ybKKCQbcuRSxSryWOJHqbORtw59CLYkSgmBwTmRm8qx6OPCMUezUwnd3ZV?=
 =?iso-8859-1?Q?VhSG9vlrQJMO/GjXsD0+V9QqVMDABsRc8oaiOGCwoKCMAJPA6R/XH0t+ae?=
 =?iso-8859-1?Q?VbNLaQorVYKw8+c7z3yGgkykaX0TcDgAsltkkgPewnl+Ng1khn61gxRWFw?=
 =?iso-8859-1?Q?Odf5mOGCPVrkNBC+xy/k3FKqinQuj85y51V2hgUC8HMMsMDVFKhtKIoj4Q?=
 =?iso-8859-1?Q?s6LLTqHJayykR1+S7X9fhzq2GWhtlrHOxyXk9M9JzIKfVYgsQTPrRRt36t?=
 =?iso-8859-1?Q?+pPIEv4gOsXxh6epn2NTjVfdiPiudYSdoEZ4f8AcdGiFxqUbeUAyIeN5ts?=
 =?iso-8859-1?Q?hXn5SHXMWRNUWASk9ITciACu32XDYD82/D55m23CBLScN/dRbamkaASxM/?=
 =?iso-8859-1?Q?9gNHqlS8uc1Ay81ZxVmYi9xmRV42hFIDgV+NaVR4Sl/ehG3Z65iBItBkFs?=
 =?iso-8859-1?Q?9sDJOpseFoP7UV37/graTcuTTUhxXgMRhk2HF/6unOqPGDyxZcc6wzAmws?=
 =?iso-8859-1?Q?JrBY4hGG0NQI7A4Mzoq7wZ/CftFle/tVJxH5GW2H76+b86nx43EPXbDyus?=
 =?iso-8859-1?Q?HXL2U43HPnmTq1D1JVhIRRWATWdAS5hwQtPk7Q7oOYks4clrBQf4nqxIz4?=
 =?iso-8859-1?Q?LTn+1uCa8gau8sEAlalhgiLbj78mVgIyAnIkSg8ICJTpVLs9UeyXx1xXrE?=
 =?iso-8859-1?Q?5gSKTqHIAxu34kfFAWB23C1DAOaAJiRqUVxtq0TeG84eIas8IUX90eVbQv?=
 =?iso-8859-1?Q?omalbsRavw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB10071.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525e9010-d79e-4d5e-c40c-08dee88a1b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 07:14:59.7837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBl9Ol8RXzdeplZvMSZ6HzPYuIOyfXyEfuPwWVMXTa+Oo8g0xENR1Rbl0cU3qhYPjiv+QVM5/Y9jbqtpV3RzxbQI05cEcaJkuguoOeboeL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB11660

Please consider backporting this patch to 6.18.y:=0A=
=0A=
101f3498b4bd sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix EEVDF entity=
 placement bug causing scheduling lag")=0A=
=0A=
=0A=
Rationale:=0A=
=0A=
After updating a bunch of servers to 6.18.y, we started experiencing=0A=
some scheduler related starvations. The servers each have a group of=0A=
very dedicated and isolated CPU cores, meaning that they normally=0A=
only run a single user space thread (in "system.slice"), they don't=0A=
process any interrupts and nohz_full is in effect. The thread is=0A=
SCHED_OTHER (nice -10) and it is almost always runnable consuming=0A=
all the available CPU time.=0A=
=0A=
In some rare situations, for e.g. debugging or metrics collecting,=0A=
there might be also some other thread for a brief period of time on=0A=
such a core. This other thread is also SCHED_OTHER, but it is in=0A=
"user.slice". The affinity mask allows that thread to only run on=0A=
that specific core. Now whether this CPU sharing is intentional or=0A=
not is debatable, but I don't think it should cause the kind of=0A=
problem we have observed. What sometimes happens is that the thread=0A=
in "user.slice" gets starved for seconds, minutes, hours (seen),=0A=
maybe even days (I don't think we have seen that). During that=0A=
starvation even SIGKILL won't release the thread because it gets=0A=
no runtime and cannot complete processing the signal.=0A=
=0A=
After staring at this way too long, I came up with these observations=0A=
and (not 100% proven) theory:=0A=
=0A=
1. The vruntime of "user.slice" advances forward quite a bit and=0A=
   the corresponding thread gets pre-empted. The slice is now ready=0A=
   to run but ineligible due to its large vruntime compared to the=0A=
   "system.slice".=0A=
=0A=
2. The vruntime of "system.slice" starts behaving in a strange=0A=
   "sawtooth" pattern where apparently update_curr() nudges it=0A=
   forward a few times (causing the upward slope of the sawtooth)=0A=
   until a reweight comes. The reweight then calls place_entity()=0A=
   with 'cfs_rq->curr =3D=3D se =3D=3D "system.slice"', which seems to mess=
=0A=
   up the vruntime. I don't claim to understand the math in there,=0A=
   but to me it looks like when 'cfs_rq->curr =3D=3D se', the math=0A=
   includes the weight of it twice when calculating the lag=0A=
   preservation. Apparently this may negate most/all of the upward=0A=
   slope causing the downward drop of the sawtooth.=0A=
=0A=
The overall trend of the vruntime over long period of time seems to=0A=
still be slightly upward, which means that eventually it does reach=0A=
a point where "user.slice" becomes eligible again, but due to the=0A=
vruntime constantly snapping back down, this can take extremely long=0A=
time. During all that time the "user.slice" is never picked by the=0A=
scheduler causing the starvation. Introducing even more threads to=0A=
"user.slice" of the affected core seems to somehow fix the math and=0A=
release the blockage, but it varies how many such treads are needed=0A=
(they hang too if they don't manage to fix it).=0A=
=0A=
After coming up with this theory, I noticed that the scheduler in=0A=
7.1 was changed to not call the place_entity() the same way anymore.=0A=
With a trivial backport (I think there was some difference in the=0A=
division operation) of the patch mentioned at the beginning of this=0A=
mail on top of 6.18.y, we could not reproduce the starvation anymore.=0A=
