Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31ED3A83A8;
	Wed, 19 Aug 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118421; cv=fail; b=oYnEiZe0t2oJuochSfPk5fk/+FbwP23OEJ0Hl3ywiKvhXHPU7lcYnrXQfoTJrBvdt3V8RjZegjlTZKK+GStdEfaGsYgBSrXCMc8wTLC9+pfTe9D5YvyjtTdNewmtFN0KgvI7mofoDbCi0Xq1YgMyyfRfCQqiMt0C1eeMr+CY1/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118421; c=relaxed/simple;
	bh=FNs4GsGmMlefsK3SQlNIkHutYh4nR2toWtRKk/RFibs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pLjbz/kaf8NxYW3HfTp61CPciXDP0X2O+t3tLdCjsAiJofv8HRR7jZIO7TlYy8NATBKTGV4CqE9Hr4fGPUhq6BJe/XWTRQJoa+5ZeR0YypmwAmOvU+nFMPPmu1J8nZLfpMmqTUlPyBAwTPsj6dtpsIaVW12OuhnIlkJoMy0wVOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=dw8uBLmI; dkim=fail (0-bit key) header.d=cadence.com header.i=@cadence.com header.b=Ej40moOI reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dw8uBLmI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ej40moOI"
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J5VFZn1400205;
	Tue, 18 Aug 2026 22:46:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=RhrS9PK4ulddlR/P1Jf6kIZ3qjNJq3m2Gz70hjBpwrI=; b=dw8uBLmIERbl
	KjbXm7iXBP8LKRb1de3ymfmc3r/egR3/qkgdx/2uDdGhb3yH+Gy59GOZULT4Hlni
	K8gfYPWAm+G4xTdYs6JTNap7NGhfg4C+YijJ0nuF9yQ2Iax20StTzYc6cyVA8Ntv
	evVMgVPhGiLl7rorcNyvI8lPxIPpgamjsyRc+Yw3fZ5AdbffsQrW6x1f6VK3HHIW
	i1rOwZyxiwyBqVfIfmyLCnqkDVr2S/zIaY2Asie8C5sliVF5DtCwIuRwHI6dA2Ra
	qiGyiLiTJ2/bEzQz08M+5L1exW9Fa7fNNdwic001al4t1u5p9ANELrWlNjLcx9rh
	8GEJ8JORMg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4g4yf9bqa0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 22:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgEiHFs5AsdGM6R40/5b+DE8ONcpN13WpIrmPY0sZosDSEqVkGCHHP8icibucCv73/BhNybDG7nbVD/mLZVTLkpZ5yV0XrklOiVz5ljAGDk4RCw17NI9sZPdKdz/gPGfmWovXsbUpzznyF6Ssljf5CULNoa9VZReliKIHmLnTYWwbqMQTrhL89BWS8Jplok0Z6+qGB/QdjdYhjpj8J8IALxZQmihveXgkjaD+ypSi8Y0m1fAe5E8rMNE6+TeXPA7Irn3/OzPpoG/1YXsbInMkNZ7n2fGWjPDKIW5U/KXes7158lLlw79K5riChXkDYlFcaPksENmCK+QKz3qLAgMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhrS9PK4ulddlR/P1Jf6kIZ3qjNJq3m2Gz70hjBpwrI=;
 b=xVoxXDcEmkmWIJEJ2dVWX6qVJprI0URw6v0960RIFRXOWxf+/ytrMX7cNu/r8SX57lQDagrVWJ9s7Jq3PcpVcVi+Z8WWPByEirOrViqY85nsRxCPyJ0HLStHVPzmS36D/JM8Q+tbwV5sPy3v9TJ63aG5dmDEGX5esMXYXULHdA8xeORdNBM3OBsETtxUIobmhJkMvqEnRH0o3zqP2Zw3Zqxpljx9/Bu0qCKWdEKwbg2lwUab5QL9CL/OivflUxOU5rWrLmyAp8EmJc7xYHOpsp6uf0/GAhipKUZlU9/5VzwKvNZchQiDZUOBqbbQmkIkUac5S3z4Y8LnvWJy1vDb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhrS9PK4ulddlR/P1Jf6kIZ3qjNJq3m2Gz70hjBpwrI=;
 b=Ej40moOIGYxuvor4QSne+F5F2Jqa2/Li1/azxfmr+TPGAT2FKiowrvtR+OPuT8wjUQIwSqMFDY8jpAC3HyPOo5RzltrXXhUHzmcMEBti+DcexTaEMG8JBvIZNcuKdnMaNTbDX0RgHmZuy/KjIFdfM80s24ciCmQdHnK68Zb4Q3whIqsjjesCvVgwYdJWVi/wrO5BMwXfncnrTcVF+ytBZQMAea7wS3UqR8pXVJfuLiUtH2lXd3FujEEQ5azrast2tg2iADHkk54q+rf7pRU+CCgp/ORyZZvsGsvSpzOSWeDthm/j+hghewrcd6gSLwvi/1r7u2ZJIGnwmOLSAnYFow==
Received: from LV5PR07MB11354.namprd07.prod.outlook.com
 (2603:10b6:408:301::11) by DS0PR07MB11517.namprd07.prod.outlook.com
 (2603:10b6:8:28e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 05:46:33 +0000
Received: from LV5PR07MB11354.namprd07.prod.outlook.com
 ([fe80::f029:abb:79aa:d881]) by LV5PR07MB11354.namprd07.prod.outlook.com
 ([fe80::f029:abb:79aa:d881%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 05:46:33 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Peter Chen <peter.chen@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "gary.yang@cixtech.com"
	<gary.yang@cixtech.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] usb: cdnsp: fix wakeup from S3 after controller
 context loss
Thread-Topic: [PATCH v2] usb: cdnsp: fix wakeup from S3 after controller
 context loss
Thread-Index: AQHdLvoA+VTjn8wCZUert5waStwt2LaksnKAgAAq6CA=
Date: Wed, 19 Aug 2026 05:46:33 +0000
Message-ID:
 <LV5PR07MB11354FFD5A02F4B2A6ED05060DDA52@LV5PR07MB11354.namprd07.prod.outlook.com>
References: <20260818-suspend_resume_fix-v2-1-4750091943df@cadence.com>
 <aoUef79PQPB0CfiC@hu-petche-lv.qualcomm.com>
In-Reply-To: <aoUef79PQPB0CfiC@hu-petche-lv.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR07MB11354:EE_|DS0PR07MB11517:EE_
x-ms-office365-filtering-correlation-id: e58542d0-bf66-4039-cdf6-08defdb539df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|4143699003|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Mfe4QgUZfHm32QlyniwCXhw9ETwvnX4vaSv1hgs1QgIpOdRSguxiUewDxDpILJIHJkNzurWxemuDkKOvbOoWP6+x2nhgIxW2sA++/wEZnkdmt6AYjvVZdhDy70BCbAx3oGVBieDDHM3jFl8ELx88cSFoJ1VIvO2WXz8futbSjOFb+m92aPuhzSLtV6jYkDBHSDzneiRpuPQGK1+8zhYGHzAuY2D4jR8/O3GnuvDm1rLz+M2OHRQzEoTVomY3qL+bgE3997P0KEFL3JzAom8PbBm/f4RaFG32pRljCqNIPOu68i0tzUAXsXuFFPtiHjdV3OGAdW7hsi/rB8IWXu4TM4qjFDckJ0LVIAYwIJJcJz1GE2P7ejOVBkqK9pVn+6rOGKNOqRPrW21Tccj/1U/ifgUBPIjOwBW+zr1xTNwrW8qtBFUAbgksdznloeVUdBx/HMyL8Fj63rwU2LI6BPdsF4WyTdPJU8BUb4v4BxRZdbGo+6ATV6ddRqacCcd4J8SEd4CQnxapAWfxASZ7qfwZTqx4Srp64nNJXqLOuIQBREdN294/93GVFnMvpri9m+z/pq4Y2EX3DlF6n/GJ2uw2YL0E6PRyC6SdSq5hckw+ibkrn58L40Hv5RSDdmN7Eqc1ByOmOn1Lh6GM0fNML2nDAKV/cDX6R4W/AxzExFMV9cE0OwyyxwOzxZUg7BaH1HkJxwgnZ53bDlBcSRS79Wvb317pgwsPViA2pAy4bFjwmvA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR07MB11354.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(4143699003)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xdNzbsMI7YthWkwmjFMEithBKE7feKQdO4XC/pV2p+Cht4PrN11v5c98HhiH?=
 =?us-ascii?Q?vPRWOfP5hDJAYl5PczSC65AYw5RV1lP8V1mtTstfujCwV6F+ZX/A/upMWQ4Q?=
 =?us-ascii?Q?YNvmeQ5Dj9n1D74EV/upPqhq4NrcF1gXEq0tphYNMNJzOnpn2L8pDQu+Sh+M?=
 =?us-ascii?Q?cDuOTTbe4lkzHTsnPm5ZE1k9CvxkgWlZFaMBg/gY325aMZlp4Qpl6nTI/zGp?=
 =?us-ascii?Q?2I/CV7zJRUHwYLa+gRjqA31j/LjRt6rzEc+bWzfcuppdEzy/d0B1D0JezxdH?=
 =?us-ascii?Q?SP4UuAK7MKrcIKPL3lzeDcC4DErjlRnTDDuIh4V1ciM+HmNxUHmTjsZogC1/?=
 =?us-ascii?Q?bHGsA/uF6nDnterpw7fAk8hQX+aQUnAifIdCYcd+MXXMNDdNv6Rl08pXHBoW?=
 =?us-ascii?Q?+uuqqX5dR8342rrtVJQYka1sQby+oCo/ivjNzIUETsA2O4xqUkFSUNRvkZrn?=
 =?us-ascii?Q?lUiQw0bMIGrvZLQdnWkD5NmDTH8+0P4pIku/AJPPRf+VkhI2IrwoXPkjJlwC?=
 =?us-ascii?Q?U4dQc4GBJUCm2ha9s7xPWbVhe0OwfVH1hlc0l1kSGEIsaIsyEtiZpG0Eiijl?=
 =?us-ascii?Q?tv3838gANDx6ZEG77bM5kHR+ofbXFDuJQqayDG1wksHeCe4Fe65yRx7s3FR5?=
 =?us-ascii?Q?dMfgdPefWeJrxH/KMDZPesmRo4ojzKj9AWetUEteloiOgtrwAcgzR7G3PE0v?=
 =?us-ascii?Q?1AUNsfFo4h5sxeGapF1Dw9b8MjGKImK/tZDdnv0mLXFBXBPNtwOS5uY2Swoj?=
 =?us-ascii?Q?u2ukni2HyTW6/XfIEL7tQ6oYPOQZTDZye4NHQ64M/SesqNN49r1hCsjGTPNr?=
 =?us-ascii?Q?yVR1/aPqEwn8+Hor0PDAIFz1D5ygIAmxR2aOjQEyY02YapxNRcgHE5+vMql0?=
 =?us-ascii?Q?KLc+EGCQkrLYOFJmuVYQ27v0AM88FAb293nOSZzCA3o8mM3bqiEL6GlU3eiV?=
 =?us-ascii?Q?bmWnepO87ySUb4nUUyznt3EaSUu965mJwlbu2Z/k/nXohReIVajrVbzEtSld?=
 =?us-ascii?Q?XyEh82jypFqUPdXpZZ2qdrGQYbrL4Q+c9M7nA9BIy9qBBXsdpN+LJpcQtdDe?=
 =?us-ascii?Q?zSKpEjFiG9bTwJ/yNhTnHrxZywfztqxhA0dQb9nYZ9tlrhD6zha3eNqLUtW0?=
 =?us-ascii?Q?CgNtne0P6AjlXglTj3G6mQitNl+phlHS6b3p8XmXrYr9gITOSLaec9lK3FFf?=
 =?us-ascii?Q?8LtYm/56HTqRXn/mN/a4BqfxiGzFeNyb9cXiWYac+aBXhFsDOzymSU4C+d0V?=
 =?us-ascii?Q?/4i8k7ZnWjdRHEPIYKvj//ALIDdlmLqnhzQoi6/xswJbMLOvT5YAEbOYWoLw?=
 =?us-ascii?Q?eHo7MSi1pyoOYPsRok4oROAkORKhMB+SZSM/lMAiAafKYDmMtGRoUxsLgZSY?=
 =?us-ascii?Q?NQ662Nm8Zj4NEEdYpdP+Kq3hq+ODbNDpEFEeRlP7z5p0gFPrCrQ30RaUDvEW?=
 =?us-ascii?Q?3M0Va/lE5D1VjRdD+Lyv4ear9mSoK7xd+UoXpMXVA2hcQy5tVLhyix6Coo32?=
 =?us-ascii?Q?BwO21FZ2jRGJXIU06rMetG2BkaptMHTAmJM6PFTIwv09qdNQxunsqNal0sfE?=
 =?us-ascii?Q?iE5td7RgU59EWjB9yS4hsyHlvg3hvfibcobc/FFeoCF6db5EG/t+UZZy+JCd?=
 =?us-ascii?Q?+FBQ/1tmafH0OJj3r/qRaC+DoYMfG+Nxfa8yuVdwz2pIaLkInLmYqMCTPWpp?=
 =?us-ascii?Q?qVPplhKIZ+QPuYsytDrHn/jidgmEo+x3NAsTpVOBpJkL7ip6XUJhgABMLTIZ?=
 =?us-ascii?Q?xmjZL3qIWA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VH/ggFEgw4hNR5alPaztmx/rzlAacLkhFbDdBRB5PvQwMbm0zc1p2VmlFjkhnnEDxO2zbERsggwLE+I61Odes9DyS9187zuAYQrUzNwX+D/FnkGgz1acbTvWJ9ZuGzT++k63SDmHNTZp9ElD9R5Ka51lDpBvcmJyLLq+2o9zP+lD1v6xAX4H8IyHiolgPee+Ag4iog6OKATCwX7oXWuwNQWdUPijJmlfCCIgsU+X+DuaiV/wCFKm3P+Jk0TjAJpiRMZHyTukPX3XlHBuAwtNRUaK93TcIfhl1WBM7S8GVGlSKPy+uLHlXGSnEPw7gq90DkHbmfkx8s8VDHK0Ls32iA==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR07MB11354.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58542d0-bf66-4039-cdf6-08defdb539df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 05:46:33.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79gefw3wpcxVwLOwZaCM8d7rycPd3fnyWkhcan5YqweliWa6QYfqMvSbrxuTuvvMXerd/gHWbvIAMZFPHacURFwCyN2SK557yHdI5+gWfKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR07MB11517
X-Authority-Analysis: v=2.4 cv=L9wtheT8 c=1 sm=1 tr=0 ts=6a85433b cx=c_pps
 a=4NR8cDhszsP7ZiL8l4sOGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=jPItpJ3sizTKmla2ehJN:22 a=Br2UW1UjAAAA:8
 a=VwQbUJbxAAAA:8 a=DTTY_x4ioIg6e18bkkAA:9 a=CjuIK1q_8ugA:10
 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: mxyMrsNqe3OrXyNLc9FAHJ3x7xMwyIJf
X-Proofpoint-ORIG-GUID: mxyMrsNqe3OrXyNLc9FAHJ3x7xMwyIJf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA0MSBTYWx0ZWRfX22OgkFgMsn2v
 c6qXyAHJTvY1wGoUNS/2cjwG8eN6xQ2d+mIvRqheV0P9nkPOPoSLOZrmSiGflsB10cjxuPw37E/
 vbifhGqHH0zCk85ck0SXGzbgs0+9xZ1kdwOe7H4Qk7Xe9rtoNgFw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA0MSBTYWx0ZWRfXxYtCE99QIaC2
 yxG7fdKdFG2D8CX/7AhzBAZ9LCg49D9Xa8UNESIo29xHOKicxjVnnOMssB3RRTL4aiQbPF1h5+t
 loqvTSlfOrqlLjIyzG/xUoBFFshkzAa6tZPHpFh6D9syb+zyFEpT9m7SjlpLEcVpFoBewTxj3sz
 lU1tBM1vmBwV4SdlWOxwNi99BmDc2qDpUlDgCUG1UoDEMW7SzUv86/Qo72wyI4ZEGuQz2UlIztQ
 fZkloiS6mAj2mf//04/olhGPePQXR+QBzOA6kpoS+E78EuZN7GF3ZHSGHWh/fGDFVshM8Kuiv68
 J0agN8TT6mGUOa+vj3G0FLnOVKOBNIxxw2GIDSyGd2kFYph6G6pG83aXeAq7LlA/NL+0mqa1krV
 qRP6GUkGufji/xRHROajwJ4oBn5ETaSqnKrnEWVDfPo75DApN1voBGu3JG/JTw5AmYLVO9R4vbv
 kOygzSt409VJhXe4pSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190041

>
>On 26-08-18 12:29:29, Pawel Laszczak via B4 Relay wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>> CDNSP controller may lose its runtime register programming across S3
>> suspend/resume, depending on SoC power domain configuration. After
>> resume the operational and interrupter registers may contain reset
>> values, which prevents the gadget side from recovering correctly and
>> breaks wakeup from S3.
>>
>> On SoCs where the controller retains power during S3, the registers
>> are preserved and a Controller Restore State (CRS) sequence is used
>> instead of full reinitialization.
>>
>> Fix this by detecting whether the controller lost its register context
>> after resume and handling both cases:
>> - If context was lost (CFG_3XPORT_U1_PIPE_CLK_GATE_EN set or power
>>   lost): reprogram the controller state required for normal operation,
>>   including the command ring, DCBAA pointer, doorbell base, event ring,
>>   ERST base/size and event ring dequeue pointer.
>> - If context was retained: restore saved registers and initiate
>>   Controller Restore State (CRS).
>>
>> Move the basic controller register programming out of the one-time
>> memory initialization path and make it reusable from the resume path.
>> Also separate ring allocation from ring initialization so that rings
>> can be reinitialized without reallocating DMA memory.
>>
>> Always perform the full suspend sequence regardless of the current
>> link state. Previously, if the device was already in U3, the suspend
>> callback returned early without saving registers or stopping the
>> controller, which could lead to commands being issued on a disabled slot
>during resume.
>>
>> This fixes S3 resume on systems where the controller register context
>> is lost, while keeping the existing DMA allocations intact.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>
>
>The changes in this patch are big, do we really need to apply it from the =
cdns
>USB SSP introduced? How about just apply it from #v7.2?
>
>After Gary Yang tests this patch, I am okay with it.

Hi Peter,

Regarding the stable backport question: I would argue that keeping
Cc: stable@vger.kernel.org is appropriate here, because this is a real
bug - not an enhancement. Without this fix, the driver hangs after S3
resume on SoCs where the controller loses power during suspend.
The stable maintainers will make the final call on whether to accept
it into stable trees, but we should not prevent them from considering it.

The analogous context save/restore pattern already exists on the host
side for the same reason - context loss after S3 is a
class of bugs that the USB subsystem explicitly handles. This is
consistent with that approach.

I agree the change is large. The size is a consequence of separating
ring allocation from ring initialization (required to reinitialize
rings without reallocating DMA memory on resume) and extracting the
one-time register programming into a reusable cdnsp_init(). Without
this restructuring, the resume path would have duplicated a significant
amount of initialization code.

Thanks,
Pawel

>
>Peter
>
>> ---
>> Changes in v2:
>> - Clarify commit message to reflect SoC-dependent context loss
>> behavior
>> - Fix cdnsp_irq_handler: return IRQ_HANDLED instead of IRQ_NONE when
>> in_lpm is set
>> - Fix suspend: always perform full suspend sequence regardless of link
>> state
>> ---
>> Changes in v2:
>> - Clarify commit message to reflect SoC-dependent context loss
>> behavior
>> - Removed in_lpm from cdnsp_irq_handler - the code is unnecessary
>> - Fix suspend: always perform full suspend sequence regardless of link
>> state
>> ---
>>  drivers/usb/cdns3/cdnsp-gadget.c | 183
>> +++++++++++++++++++++++++++++++++++++--
>>  drivers/usb/cdns3/cdnsp-gadget.h |  31 +++++++
>>  drivers/usb/cdns3/cdnsp-mem.c    |  98 ++++++++-------------
>>  3 files changed, 243 insertions(+), 69 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>> b/drivers/usb/cdns3/cdnsp-gadget.c
>> index a5275c2fb43b..67b265b456a9 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> @@ -1338,7 +1338,6 @@ static int cdnsp_run(struct cdnsp_device *pdev,
>>
>>  	cdnsp_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(512);
>>
>> -
>>  	ret =3D cdnsp_start(pdev);
>>  	if (ret) {
>>  		ret =3D -ENODEV;
>> @@ -1837,6 +1836,82 @@ static void cdnsp_get_rev_cap(struct cdnsp_device
>*pdev)
>>  		 readl(&pdev->rev_cap->tx_buff_size));
>>  }
>>
>> +static void cdnsp_set_event_deq(struct cdnsp_device *pdev) {
>> +	dma_addr_t deq;
>> +	u64 temp;
>> +
>> +	deq =3D cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
>> +				    pdev->event_ring->dequeue);
>> +
>> +	/* Update controller event ring dequeue pointer */
>> +	temp =3D cdnsp_read_64(&pdev->ir_set->erst_dequeue);
>> +	temp &=3D ERST_PTR_MASK;
>> +
>> +	/*
>> +	 * Don't clear the EHB bit (which is RW1C) because
>> +	 * there might be more events to service.
>> +	 */
>> +	temp &=3D ~ERST_EHB;
>> +
>> +	cdnsp_write_64(((u64)deq & (u64)~ERST_PTR_MASK) | temp,
>> +		       &pdev->ir_set->erst_dequeue); }
>> +
>> +static void cdnsp_add_interrupter(struct cdnsp_device *pdev) {
>> +	u64 erst_base;
>> +	u32 erst_size;
>> +
>> +	/* Set ERST count with the number of entries in the segment table. */
>> +	erst_size =3D readl(&pdev->ir_set->erst_size);
>> +	erst_size &=3D ERST_SIZE_MASK;
>> +	erst_size |=3D ERST_NUM_SEGS;
>> +	writel(erst_size, &pdev->ir_set->erst_size);
>> +
>> +	/* Set the segment table base address. */
>> +	erst_base =3D cdnsp_read_64(&pdev->ir_set->erst_base);
>> +	erst_base &=3D ERST_PTR_MASK;
>> +	erst_base |=3D (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
>> +	cdnsp_write_64(erst_base, &pdev->ir_set->erst_base);
>> +
>> +	/* Set the event ring dequeue address. */
>> +	cdnsp_set_event_deq(pdev);
>> +}
>> +
>> +/* Set up basic CDNSP registers */
>> +static void cdnsp_init(struct cdnsp_device *pdev) {
>> +	unsigned int val;
>> +	u64 val_64;
>> +
>> +	val =3D readl(&pdev->op_regs->config_reg);
>> +	val |=3D ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
>> +	writel(val, &pdev->op_regs->config_reg);
>> +
>> +	/* Initialize the Command ring */
>> +	cdnsp_ring_init(pdev, pdev->cmd_ring);
>> +
>> +	/* Set the address in the Command Ring Control register */
>> +	val_64 =3D cdnsp_read_64(&pdev->op_regs->cmd_ring);
>> +	val_64 =3D (val_64 & (u64)CMD_RING_RSVD_BITS) |
>> +		 (pdev->cmd_ring->first_seg->dma &
>(u64)~CMD_RING_RSVD_BITS) |
>> +		 pdev->cmd_ring->cycle_state;
>> +	cdnsp_write_64(val_64, &pdev->op_regs->cmd_ring);
>> +
>> +	/* Set Device Context Base Address Array pointer */
>> +	cdnsp_write_64(pdev->dcbaa->dma, &pdev->op_regs->dcbaa_ptr);
>> +
>> +	/* Set Doorbell array pointer */
>> +	val =3D readl(&pdev->cap_regs->db_off);
>> +	val &=3D DBOFF_MASK;
>> +	pdev->dba =3D (void __iomem *)pdev->cap_regs + val;
>> +
>> +	/* Initialize the Primary interrupter */
>> +	cdnsp_ring_init(pdev, pdev->event_ring);
>> +	cdnsp_add_interrupter(pdev);
>> +}
>> +
>>  static int cdnsp_gen_setup(struct cdnsp_device *pdev)  {
>>  	int ret;
>> @@ -1902,6 +1977,8 @@ static int cdnsp_gen_setup(struct cdnsp_device
>*pdev)
>>  	if (ret)
>>  		return ret;
>>
>> +	cdnsp_init(pdev);
>> +
>>  	/*
>>  	 * Software workaround for U1: after transition
>>  	 * to U1 the controller starts gating clock, and in some cases, @@
>> -2026,20 +2103,62 @@ static void cdnsp_gadget_exit(struct cdns *cdns)
>>  	cdns_drd_gadget_off(cdns);
>>  }
>>
>> +static void cdnsp_save_registers(struct cdnsp_device *pdev) {
>> +	struct cdnsp_s3_save *s3 =3D &pdev->s3;
>> +
>> +	s3->command =3D readl(&pdev->op_regs->command);
>> +	s3->dnctrl =3D readl(&pdev->op_regs->dnctrl);
>> +	s3->dcbaa_ptr =3D cdnsp_read_64(&pdev->op_regs->dcbaa_ptr);
>> +	s3->config_reg =3D readl(&pdev->op_regs->config_reg);
>> +	s3->s3_erst_size =3D readl(&pdev->ir_set->erst_size);
>> +	s3->s3_erst_base =3D cdnsp_read_64(&pdev->ir_set->erst_base);
>> +	s3->s3_erst_dequeue =3D cdnsp_read_64(&pdev->ir_set->erst_dequeue);
>> +	s3->s3_irq_pending =3D readl(&pdev->ir_set->irq_pending);
>> +	s3->s3_irq_control =3D readl(&pdev->ir_set->irq_control);
>> +}
>> +
>> +static void cdnsp_restore_registers(struct cdnsp_device *pdev) {
>> +	struct cdnsp_s3_save *s3 =3D &pdev->s3;
>> +
>> +	writel(s3->command, &pdev->op_regs->command);
>> +	writel(s3->dnctrl, &pdev->op_regs->dnctrl);
>> +	cdnsp_write_64(s3->dcbaa_ptr, &pdev->op_regs->dcbaa_ptr);
>> +	writel(s3->config_reg, &pdev->op_regs->config_reg);
>> +	writel(s3->s3_erst_size, &pdev->ir_set->erst_size);
>> +	cdnsp_write_64(s3->s3_erst_base, &pdev->ir_set->erst_base);
>> +	cdnsp_write_64(s3->s3_erst_dequeue, &pdev->ir_set->erst_dequeue);
>> +	writel(s3->s3_irq_pending, &pdev->ir_set->irq_pending);
>> +	writel(s3->s3_irq_control, &pdev->ir_set->irq_control); }
>> +
>>  static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)  {
>>  	struct cdnsp_device *pdev =3D cdns->gadget_dev;
>>  	unsigned long flags;
>> -
>> -	if (pdev->link_state =3D=3D XDEV_U3)
>> -		return 0;
>> +	u32 val;
>> +	int ret;
>>
>>  	spin_lock_irqsave(&pdev->lock, flags);
>>  	cdnsp_disconnect_gadget(pdev);
>>  	cdnsp_stop(pdev);
>> +
>> +	cdnsp_save_registers(pdev);
>> +
>> +	val =3D readl(&pdev->op_regs->command);
>> +	val |=3D CMD_CSS;
>> +	writel(val, &pdev->op_regs->command);
>> +
>> +	ret =3D readl_poll_timeout_atomic(&pdev->op_regs->status, val,
>> +					!(val & STS_SSS), 1,
>> +					20 * 1000);
>> +	if (ret)
>> +		ret =3D -EIO;
>> +
>>  	spin_unlock_irqrestore(&pdev->lock, flags);
>>
>> -	return 0;
>> +	return ret;
>>  }
>>
>>  static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power) @@
>> -2047,12 +2166,63 @@ static int cdnsp_gadget_resume(struct cdns *cdns,
>bool lost_power)
>>  	struct cdnsp_device *pdev =3D cdns->gadget_dev;
>>  	enum usb_device_speed max_speed;
>>  	unsigned long flags;
>> +	bool wakeup =3D false;
>> +	u32 val;
>>  	int ret;
>>
>>  	if (!pdev->gadget_driver)
>>  		return 0;
>>
>>  	spin_lock_irqsave(&pdev->lock, flags);
>> +	val =3D readl(&pdev->port3x_regs->mode_2);
>> +
>> +	if (val & CFG_3XPORT_U1_PIPE_CLK_GATE_EN || lost_power) {
>> +		cdnsp_halt(pdev);
>> +		cdnsp_set_apb_timeout_value(pdev);
>> +
>> +		/* Reset the internal controller memory state and registers. */
>> +		ret =3D cdnsp_reset(pdev);
>> +		if (ret)
>> +			goto unlock;
>> +
>> +		val =3D readl(&pdev->port3x_regs->mode_2);
>> +		val &=3D ~CFG_3XPORT_U1_PIPE_CLK_GATE_EN;
>> +		writel(val, &pdev->port3x_regs->mode_2);
>> +
>> +		cdnsp_clear_cmd_ring(pdev);
>> +
>> +		memset(pdev->event_ring->first_seg->trbs, 0,
>> +		       sizeof(union cdnsp_trb) * (TRBS_PER_SEGMENT));
>> +
>> +		cdnsp_init(pdev);
>> +	} else {
>> +		ret =3D readl_poll_timeout_atomic(&pdev->op_regs->status, val,
>> +						!(val & STS_CNR), 1,
>> +						10 * 1000 * 1000);
>> +		if (ret) {
>> +			dev_err(pdev->dev, "ERROR: Controller not ready to
>work\n");
>> +			spin_unlock_irqrestore(&pdev->lock, flags);
>> +			return ret;
>> +		}
>> +
>> +		cdnsp_restore_registers(pdev);
>> +
>> +		/* Initiate Controller Restore State (CRS) */
>> +		val =3D readl(&pdev->op_regs->command);
>> +		val |=3D CMD_CRS;
>> +		writel(val, &pdev->op_regs->command);
>> +
>> +		ret =3D readl_poll_timeout_atomic(&pdev->op_regs->status, val,
>> +						!(val & STS_RSS), 1, 100000);
>> +		if (ret) {
>> +			dev_err(pdev->dev, "Restore state did not complete
>(timeout)\n");
>> +			ret =3D -ETIMEDOUT;
>> +			goto unlock;
>> +		}
>> +
>> +		wakeup =3D true;
>> +	}
>> +
>>  	max_speed =3D pdev->gadget_driver->max_speed;
>>
>>  	/* Limit speed if necessary. */
>> @@ -2060,9 +2230,10 @@ static int cdnsp_gadget_resume(struct cdns
>> *cdns, bool lost_power)
>>
>>  	ret =3D cdnsp_run(pdev, max_speed);
>>
>> -	if (pdev->link_state =3D=3D XDEV_U3)
>> +	if (pdev->link_state =3D=3D XDEV_U3 && wakeup)
>>  		__cdnsp_gadget_wakeup(pdev);
>>
>> +unlock:
>>  	spin_unlock_irqrestore(&pdev->lock, flags);
>>
>>  	return ret;
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h
>> b/drivers/usb/cdns3/cdnsp-gadget.h
>> index c44bca348a41..6c45fd3e4a9d 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> @@ -1353,6 +1353,34 @@ struct cdnsp_port {
>>  #define CDNSP_EXT_PORT_OFF(x)		((x) & 0xff)
>>  #define CDNSP_EXT_PORT_COUNT(x)		(((x) >> 8) & 0xff)
>>
>> +/**
>> + * struct cdnsp_s3_save - register context saved before S3 suspend.
>> + * @command: Saved USB command register value.
>> + * @dnctrl: Saved device notification control register value.
>> + * @dcbaa_ptr: Saved Device Context Base Address Array pointer.
>> + * @config_reg: Saved configuration register value.
>> + * @s3_irq_pending: Saved interrupter pending register value.
>> + * @s3_irq_control: Saved interrupter control register value.
>> + * @s3_erst_size: Saved Event Ring Segment Table size.
>> + * @s3_erst_base: Saved Event Ring Segment Table base address.
>> + * @s3_erst_dequeue: Saved Event Ring Dequeue Pointer.
>> + *
>> + * Stores the controller register state that may be lost across S3
>> + * suspend/resume. The saved values are used to restore the CDNSP
>> + * operational and interrupter register programming after resume.
>> + */
>> +struct cdnsp_s3_save {
>> +	u32	command;
>> +	u32	dnctrl;
>> +	u64	dcbaa_ptr;
>> +	u32	config_reg;
>> +	u32	s3_irq_pending;
>> +	u32	s3_irq_control;
>> +	u32	s3_erst_size;
>> +	u64	s3_erst_base;
>> +	u64	s3_erst_dequeue;
>> +};
>> +
>>  /**
>>   * struct cdnsp_device - represent USB device.
>>   * @dev: Pointer to device structure associated whit this controller.
>> @@ -1388,6 +1416,7 @@ struct cdnsp_port {
>>   * @cmd: Represent all what is needed to issue command on Command
>Ring.
>>   * @event_ring: Event ring.
>>   * @erst: Event Ring Segment table
>> + * @s3:  Register values saved before entering S3.
>>   * @slot_id: Current Slot ID. Should be 0 or 1.
>>   * @out_ctx: Output context.
>>   * @in_ctx: Input context.
>> @@ -1447,6 +1476,7 @@ struct cdnsp_device {
>>  	struct cdnsp_command cmd;
>>  	struct cdnsp_ring *event_ring;
>>  	struct cdnsp_erst erst;
>> +	struct cdnsp_s3_save s3;
>>  	int slot_id;
>>
>>  	/*
>> @@ -1510,6 +1540,7 @@ int cdnsp_endpoint_init(struct cdnsp_device
>> *pdev,  int cdnsp_ring_expansion(struct cdnsp_device *pdev,
>>  			 struct cdnsp_ring *ring,
>>  			 unsigned int num_trbs, gfp_t flags);
>> +void cdnsp_ring_init(struct cdnsp_device *pdev, struct cdnsp_ring
>> +*ring);
>>  struct cdnsp_ring *cdnsp_dma_to_transfer_ring(struct cdnsp_ep *ep,
>> u64 address);  int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
>>  			    struct cdnsp_ep *pep,
>> diff --git a/drivers/usb/cdns3/cdnsp-mem.c
>> b/drivers/usb/cdns3/cdnsp-mem.c index 5d8cdc91927d..0be917f52bbb
>> 100644
>> --- a/drivers/usb/cdns3/cdnsp-mem.c
>> +++ b/drivers/usb/cdns3/cdnsp-mem.c
>> @@ -394,13 +394,6 @@ static struct cdnsp_ring *cdnsp_ring_alloc(struct
>cdnsp_device *pdev,
>>  	if (ret)
>>  		goto fail;
>>
>> -	/* Only event ring does not use link TRB. */
>> -	if (type !=3D TYPE_EVENT)
>> -		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=3D
>> -			cpu_to_le32(LINK_TOGGLE);
>> -
>> -	cdnsp_initialize_ring_info(ring);
>> -	trace_cdnsp_ring_alloc(ring);
>>  	return ring;
>>  fail:
>>  	kfree(ring);
>> @@ -603,6 +596,7 @@ int cdnsp_alloc_stream_info(struct cdnsp_device
>*pdev,
>>  		if (!cur_ring)
>>  			goto cleanup_rings;
>>
>> +		cdnsp_ring_init(pdev, cur_ring);
>>  		cur_ring->stream_id =3D cur_stream;
>>  		cur_ring->trb_address_map =3D &stream_info-
>>trb_address_map;
>>
>> @@ -696,6 +690,8 @@ static int cdnsp_alloc_priv_device(struct cdnsp_devi=
ce
>*pdev)
>>  	if (!pdev->eps[0].ring)
>>  		goto fail;
>>
>> +	cdnsp_ring_init(pdev, pdev->eps[0].ring);
>> +
>>  	/* Point to output device context in dcbaa. */
>>  	pdev->dcbaa->dev_context_ptrs[1] =3D cpu_to_le64(pdev->out_ctx.dma);
>>  	pdev->cmd.in_ctx =3D &pdev->in_ctx;
>> @@ -989,6 +985,8 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
>>  	if (!pep->ring)
>>  		return -ENOMEM;
>>
>> +	cdnsp_ring_init(pdev, pep->ring);
>> +
>>  	pep->skip =3D false;
>>
>>  	/* Fill the endpoint context */
>> @@ -1094,28 +1092,6 @@ void cdnsp_mem_cleanup(struct cdnsp_device
>*pdev)
>>  	pdev->active_port =3D NULL;
>>  }
>>
>> -static void cdnsp_set_event_deq(struct cdnsp_device *pdev) -{
>> -	dma_addr_t deq;
>> -	u64 temp;
>> -
>> -	deq =3D cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
>> -				    pdev->event_ring->dequeue);
>> -
>> -	/* Update controller event ring dequeue pointer */
>> -	temp =3D cdnsp_read_64(&pdev->ir_set->erst_dequeue);
>> -	temp &=3D ERST_PTR_MASK;
>> -
>> -	/*
>> -	 * Don't clear the EHB bit (which is RW1C) because
>> -	 * there might be more events to service.
>> -	 */
>> -	temp &=3D ~ERST_EHB;
>> -
>> -	cdnsp_write_64(((u64)deq & (u64)~ERST_PTR_MASK) | temp,
>> -		       &pdev->ir_set->erst_dequeue);
>> -}
>> -
>>  static void cdnsp_add_in_port(struct cdnsp_device *pdev,
>>  			      struct cdnsp_port *port,
>>  			      __le32 __iomem *addr)
>> @@ -1224,6 +1200,36 @@ static int cdnsp_setup_port_arrays(struct
>cdnsp_device *pdev)
>>  	return 0;
>>  }
>>
>> +static void cdnsp_initialize_ring_segments(struct cdnsp_device *pdev,
>> +struct cdnsp_ring *ring) {
>> +	struct cdnsp_segment *seg;
>> +
>> +	/* Only event ring does not use link TRB. */
>> +	if (ring->type =3D=3D TYPE_EVENT)
>> +		return;
>> +
>> +	seg =3D ring->first_seg;
>> +
>> +	while (seg) {
>> +		struct cdnsp_segment *next =3D seg->next;
>> +
>> +		cdnsp_link_segments(pdev, seg, next, ring->type);
>> +		if (next =3D=3D ring->first_seg)
>> +			break;
>> +
>> +		seg =3D next;
>> +	}
>> +
>> +	ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=3D
>> +cpu_to_le32(LINK_TOGGLE); }
>> +
>> +void cdnsp_ring_init(struct cdnsp_device *pdev, struct cdnsp_ring
>> +*ring) {
>> +	cdnsp_initialize_ring_segments(pdev, ring);
>> +	cdnsp_initialize_ring_info(ring);
>> +	trace_cdnsp_ring_alloc(ring);
>> +}
>> +
>>  /*
>>   * Initialize memory for CDNSP (one-time init).
>>   *
>> @@ -1235,10 +1241,8 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>> {
>>  	struct device *dev =3D pdev->dev;
>>  	int ret =3D -ENOMEM;
>> -	unsigned int val;
>>  	dma_addr_t dma;
>>  	u32 page_size;
>> -	u64 val_64;
>>
>>  	/*
>>  	 * Use 4K pages, since that's common and the minimum the @@ -
>1246,10
>> +1250,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>>  	 */
>>  	page_size =3D 1 << 12;
>>
>> -	val =3D readl(&pdev->op_regs->config_reg);
>> -	val |=3D ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
>> -	writel(val, &pdev->op_regs->config_reg);
>> -
>>  	/*
>>  	 * Doorbell array must be physically contiguous
>>  	 * and 64-byte (cache line) aligned.
>> @@ -1261,8 +1261,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>>
>>  	pdev->dcbaa->dma =3D dma;
>>
>> -	cdnsp_write_64(dma, &pdev->op_regs->dcbaa_ptr);
>> -
>>  	/*
>>  	 * Initialize the ring segment pool.  The ring must be a contiguous
>>  	 * structure comprised of TRBs. The TRBs must be 16 byte aligned, @@
>> -1288,17 +1286,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>>  	if (!pdev->cmd_ring)
>>  		goto destroy_device_pool;
>>
>> -	/* Set the address in the Command Ring Control register */
>> -	val_64 =3D cdnsp_read_64(&pdev->op_regs->cmd_ring);
>> -	val_64 =3D (val_64 & (u64)CMD_RING_RSVD_BITS) |
>> -		 (pdev->cmd_ring->first_seg->dma &
>(u64)~CMD_RING_RSVD_BITS) |
>> -		 pdev->cmd_ring->cycle_state;
>> -	cdnsp_write_64(val_64, &pdev->op_regs->cmd_ring);
>> -
>> -	val =3D readl(&pdev->cap_regs->db_off);
>> -	val &=3D DBOFF_MASK;
>> -	pdev->dba =3D (void __iomem *)pdev->cap_regs + val;
>> -
>>  	/* Set ir_set to interrupt register set 0 */
>>  	pdev->ir_set =3D &pdev->run_regs->ir_set[0];
>>
>> @@ -1315,21 +1302,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>>  	if (ret)
>>  		goto free_event_ring;
>>
>> -	/* Set ERST count with the number of entries in the segment table. */
>> -	val =3D readl(&pdev->ir_set->erst_size);
>> -	val &=3D ERST_SIZE_MASK;
>> -	val |=3D ERST_NUM_SEGS;
>> -	writel(val, &pdev->ir_set->erst_size);
>> -
>> -	/* Set the segment table base address. */
>> -	val_64 =3D cdnsp_read_64(&pdev->ir_set->erst_base);
>> -	val_64 &=3D ERST_PTR_MASK;
>> -	val_64 |=3D (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
>> -	cdnsp_write_64(val_64, &pdev->ir_set->erst_base);
>> -
>> -	/* Set the event ring dequeue address. */
>> -	cdnsp_set_event_deq(pdev);
>> -
>>  	ret =3D cdnsp_setup_port_arrays(pdev);
>>  	if (ret)
>>  		goto free_erst;
>>
>> ---
>> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
>> change-id: 20260723-suspend_resume_fix-bfd5327d52aa
>>
>> Best regards,
>> --
>> Pawel Laszczak <pawell@cadence.com>
>>
>>
>
>--
>
>Thanks,
>Peter Chen
