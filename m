Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792525983;
	b=nPL2/CJiThEO6SQhOWQEIqUVlOe0iJaxagT9fdZLxtZhhsiwfjAsaY9yIDTwtuJDfyIz
	 HviqrMEJocrzaxLbmmghEwrnpGZ0k4K12dHVrvzpBLzjeiAhLWtQrqpibVxlnLpKcB7Sg
	 9vH0f99H/CJSYjCeLrdL3RJ3dE3eha4lR+nPB7DiTrSiWOK9N3ykCW3yCe6oyLCvsFlNP
	 +SKMqZs4bNXuC3+Zo1DMvyTIfkQa1KEaj0y1f9c0/NeQzpZQOiXJmeREnUcdgdlet5Noy
	 4TKopLNjdGM4C7sHL8fHI1/9SW7BoICBt/NZUWFWNIGyNZAvvpsB7aqdVghbEMGsfxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525983;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=HaPGnftu0tiUnY4qxX0V3xxFJB1u3I1dtOKp161OL0w=;
	b=1xGAo1CJ/Q/vVshMcnF/2zeb7J97UOve456J1DfeZW9IDh+uonC92uRW+oPe2RsbdDzk
	 txCQc69UhIA1CkNYm48yXYrqhirg7hvNzwzPOa4zHtzOvq9dfcRSHX4WXS2WEzK2p3dhH
	 1JBulbj3XB0ARefl7+p2uTpBKfY3Q9ki1iX/Y8CbCM/NMHwooiSAukvftPQKBgFU9MeOi
	 Jc5KnbREQF9jGNRTFHmMu1j8FcdMnZH7jdmGbcRxf2JEPLiez9ktGEoeunchap+Bsx2lF
	 KUsW0f8duwEkZQMAufSUohq5AOeO/jd5ARoJR4pyagMdisZqIGVzXq0hLf6MO/0apGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WA9RW8Ze;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.57
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD98606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DD98606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WA9RW8Ze
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxaUTd4+VD9pG+l2iQP450q++xp5F9UCeF/hVKhTNfcoWo798JZcTzVnYyLr4rKX8bFFQd7jtLazPya9CV+b2AO3a5/Ah3Xq8Ey3HEOjXYMBEEtwMn4ys6uBHVX0DVXQJdEHVGbEjbn14JHfPI14cAZFIlnAjetXQGhTdT4/8pDGFH0O6K4JG2dFcerk7vIB9lPt4lfvR16hxW9kXGhrbcSbzw0OSmerMZ4i4NmlMzARuMjtXv6pqRdUZJXSsiG4VOP2h7WQAIkaodtJmnXG34qB9aD2fl1r/BmnAR4t1gQVYybMglXyKYCkDf0wWWyaQw85gEKSjBtEFKAPt68zMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaPGnftu0tiUnY4qxX0V3xxFJB1u3I1dtOKp161OL0w=;
 b=Bg7QRnaPy4CiJMufnnbSEsEfhnKdBMdiqJdVOgbr/5Ja3AVjFzqOvKW509Tic2/oeHyitJTPp42iEFQZIUdFLFJFebiKAE3rmG/1dB0otOtYYZfD/GNO9BnEhGicFBFyXZf1acWZLDBum07JYomwplib2RUSI6X9qmI62hwQtsjox1ShRZj9qgFoo7tLxEP4dOS9tiNCZOk6qyGwYP1bu7HXEAn2/5nNerDGJZxXMGn+vny5DvvY1CmKrTFrIqi8BS/FniJP1bP+zJKr6pc60+2szLecT9OG622/UJxhr678kRTT9mGtkTFzp6F/MYwLkZV6BMMBRcc5ijeUl/B1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaPGnftu0tiUnY4qxX0V3xxFJB1u3I1dtOKp161OL0w=;
 b=WA9RW8Ze1sQ8EMKP4+C65ZbjIf5rcSfNNsVASrn0AQIXYSolhZd4JfK3Afj7A1jtq4QjTGl06dj3Q7Cn6WR2fhKhm5AAlMW6r0GxkCkpzh615CR6tI3ZBtUn1wQRxqHmux+L+K6A7rh/PvG7g9OXqawEesZOoocYcj/PiRhRBJc=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 19:50:54 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 19:50:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>
CC: "Liu, Leo" <Leo.Liu@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: cancel idle work in hw_init failure paths
 for vcn/uvd/vce/jpeg
Thread-Topic: [PATCH 1/2] drm/amdgpu: cancel idle work in hw_init failure
 paths for vcn/uvd/vce/jpeg
Thread-Index: AQHdYMoJmO0M3982CEa7eLzc8TKvHLcG1FEQ
Date: Tue, 20 Oct 2026 19:50:54 +0000
Message-ID:
 <BN9PR12MB51466AE18098D65FFB7FAC0AF7672@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20261020152701.18355-1-leo.liu@amd.com>
 <20261020193212.19760-1-leo.liu@amd.com>
In-Reply-To: <20261020193212.19760-1-leo.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-20T19:41:19.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SN7PR12MB6789:EE_
x-ms-office365-filtering-correlation-id: a70a7323-f3b8-4b47-a54e-08df2ee373d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|260925022911599003|260925021311599003|260925021911599003|261009223327099003|11063799006|4143699003|261009221227099003|261009221727099003|261009223027099003|261009220027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 w8F2NNtdQXmCyDxg7l/GtMThYby6eVlUe4eOqTaUmSIzK0zvsCIioTwNwUMLIAF6bUOX6K4GuPt/F1sNjgN0BdfSnjrGi/qbD0A9T/OapXIdyY5kJ/P4zHlUiTOFPBkLg7nE6lmt8ir3XT/DMx0KYRHxqbKJu1B/dr8Y96lAEAViOxF4JvDwQWN3dZa81dB1DfvK+EvWWAm4Uc0A92x3m2zETn4qrdB+pejDbB5OgDsVyUj9GE/cUm4K1EnHR0KAMzzgvmHiGWbtdthbAupupI6ndHC3SdrMLCMufEXfOLG2WTyYD9PRylejDFy0n8Jv/Wn3U79maqCSxZY5w5S3e8ECC9bM3yFNJ+Ls9gG1KDLOlRB3ttwhuNIDf9Blb79LdOqmgAZ/yyBTx71Hr/za9yE0dlcUAEExhWY0luvIWfDL4CNhFdBZ4tbreS0Fa4vn+wVVlmtdCZmyZJPydCVFgEp5oSpWlMmSvDF5onYt8N/Fet+qmteL8jqxIWOxHeX/XHIyo8OAhxVJ9aHdLvUk1dxXFnYqclxSRlxzQbg8LYc2M60b3sSyHfkA2ric/xiMRajOtBcDt8qiPQcEGctg2kLzTxW6ud8mv4d7V3OXHJFx9NeZzCJ0m4NQCeyDWk0c3pJ3HADqtI+gO9uhkgjBkMQtYzOF05hf923368vdF63RqrSVbD/2p1BM+JsXA/yzlY7G4N90J59rwed3rkzSxJW3E8KfJKgYTM92v8WqqvY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(261009223327099003)(11063799006)(4143699003)(261009221227099003)(261009221727099003)(261009223027099003)(261009220027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?og2XUkQyKLCAP3d1YL6rvL1qRhJtRDbLUgVuwXl9fA/mFiSyGglGn39sZmLV?=
 =?us-ascii?Q?fSPi8A2Nne8JwCw53X1/cQhvNNkYXeC2YspGVSfoy34h2+GBf3W0dcsGLEL8?=
 =?us-ascii?Q?rb94SaWHRSFnlMW6YalOm4Ytb2pQcnP23ldfHDSlnzkaXA7PAlj6v6HM8Kmi?=
 =?us-ascii?Q?a05SXE83OnaojbSvWlZ502DA/xjPAmkGKezkR3g5zUhzU9KqVXXO7yzQCvI/?=
 =?us-ascii?Q?K5/+HJNrlePWvWPHkQatG3MuQN1Fa5kMKUfWywdhmbk8cJow/mlfePR8iOnE?=
 =?us-ascii?Q?QUkTpclG5KLkdfsKh7+WLKu001Z4qcGSDX6oS5q89mJfzO/ulN0ecnYk83Iv?=
 =?us-ascii?Q?23m8B3SwEjcpwTsPw990iXHAyVziA+PkmdL6UsXhxNLKXUzmH8K9KYJ2nW5H?=
 =?us-ascii?Q?Rrsl81O6nYUlCjZlAOxzvF9+fECpeJcvwYdO5v/IAwRbFjvQvr648YeGP6TN?=
 =?us-ascii?Q?me6XEGLgkh/S8HdIll7nbAJOERey0ma5jZeNhn4kcArCfFlSUM/1NKfIBY2t?=
 =?us-ascii?Q?/5NjqpQx7xPQ3rwsZGgpDgp4D25Wc2XSDzjHOju7DnEbFHuWd+HO81hoK5G4?=
 =?us-ascii?Q?CNJOgqaHijADdo89xKEFGWSECcGr6rZQxpzP4Um8yWIwjxia4VIV39mXo221?=
 =?us-ascii?Q?zbfP8EaaJQQ/+4yM+VK+RvG714JCn8B+P5H3TI60tJMVtQSvnMZ8mMFnDhk2?=
 =?us-ascii?Q?T+L/Fw0BuawT9soLhELe0vLKlfSmfQqyWVRewCjoOAzU4d48qQNHljqY8yqQ?=
 =?us-ascii?Q?aekuA5L0cyTQ29Fo5KxOptnLNrsC5QDw7h6I0XPctjqCmiBBpm+HwmLi6vGR?=
 =?us-ascii?Q?1t+cZUK8rIZfUSvG/v4SIopwOh8+d5livAQmbXkRFSyQNJx6mT/1LX9eCm9E?=
 =?us-ascii?Q?0zMrr5fvlmkk8FwYj1C+p4lJnu7867dLnUUF7WeCffiEW+vzx73XR9f0mOdf?=
 =?us-ascii?Q?oBhfxbk1o/nGkkdioT9UJRpIZR1NM1Wk4mWjkkUAhc/fpmi0V4e1OrkCr090?=
 =?us-ascii?Q?CmZy4hiIfFMgTDo0WOEMi75hlTZA/zS/xqe2fHo4nTRtZHKftF61VbVe0IXS?=
 =?us-ascii?Q?OHRYAUKX08EV63S18wiw0F3mYA2uKl0TxeAH+i7CgNZqBGL8JBYx8dkOVXYE?=
 =?us-ascii?Q?6lcf1W4r1yZhpgQJaSkqZCd6GrGZMcGVsCm1QdqJsMsLM8mzVKYj8FpbVaw9?=
 =?us-ascii?Q?LPfNTgLS2jo4OWfgrrvANahYcJNFyQ5qKGl67x7+WvxsDRf4z8379Qudy3ed?=
 =?us-ascii?Q?8/DSmYiuQPoCe7YSF8qP3YlWza8Ax8DfH0IQ37FG23v/NptEiT1uQJorUqrA?=
 =?us-ascii?Q?01qST9x4jIXwpzkXO/bAYpN4HaBYilIBPkwBn9PLO7TBclPnG1RiLkkV+Aaj?=
 =?us-ascii?Q?FtarBb7W1ibhOxnbdqq7313+HcusTC0Io2ft4FIruVyUCivqaZjODo0AZSi0?=
 =?us-ascii?Q?8RKytmQYDvWI76PR1qJxyltAbieCVXRFxoz66XwTrJbSpay09vb8Ij5cA9Hk?=
 =?us-ascii?Q?Nc8KdzmlxjspUzL/5rL7tdiNy5XRm9jDhz49YT8EGItxCnKxhnRKUr8SXrH4?=
 =?us-ascii?Q?HUw5EIHz9Ji543UTOd7DYheAjIiPoHHCPuM8jgLzGrmgGGyh5PE/jycAmwTX?=
 =?us-ascii?Q?fkz8YTk4JWraxshFg3qjJ+f1gYOIvcDxopyDzgQghFLjGD2NoK6iMzFBF8Jz?=
 =?us-ascii?Q?mLGnp9npc7Pbn815ZBmcSUV2jhD+FizD6CycZBK86AH3ZPkU?=
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
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70a7323-f3b8-4b47-a54e-08df2ee373d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 19:50:54.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aQ27xQSlsNg8Q8A0Kvyifk1f1KTAKBRjTrVhOcntjqhFdOWPMIBAaK4RzPWMTSYV2HlAe7KUq1ad5tJfOg1ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

Public

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Leo
> Liu
> Sent: Tuesday, October 20, 2026 3:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Leo <Leo.Liu@amd.com>; stable@vger.kernel.org; Liu, Leo
> <Leo.Liu@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: cancel idle work in hw_init failure path=
s
> for vcn/uvd/vce/jpeg
>
> From: "Liu, Leo" <Leo.Liu@amd.com>
>
> When hw_init() fails, amdgpu_device_ip_fini_early() skips hw_fini() becau=
se
> status.hw was never set.  For VCN, UVD (including UVD ENC), VCE, and JPEG=
,
> hw_fini() is where cancel_delayed_work_sync() is called.  Any idle work
> queued during the partial hw_init() is therefore left pending after sw_fi=
ni()
> frees the adev state the handler touches.
>
> Cancel the idle work in each hw_init() error path, immediately before ret=
urning
> the error, so that hw_fini() remains the sole cancel site on the normal
> teardown path with no duplication.
>
> Link: https://github.com/ROCm/amdgpu/issues/234
> Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant
> cancel_delayed_work_sync call")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  6 +++++-
>  29 files changed, 142 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..7ce3396b1431 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -159,11 +159,15 @@ static int jpeg_v2_0_hw_init(struct
> amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> +     int r;
>
>       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>               (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -     return amdgpu_ring_test_helper(ring);
> +     r =3D amdgpu_ring_test_helper(ring);
> +     if (r)
> +             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..46293664fd28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -221,10 +221,14 @@ static int jpeg_v2_5_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 564e40899df2..361d0f4b4bc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -174,11 +174,15 @@ static int jpeg_v3_0_hw_init(struct
> amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> +     int r;
>
>       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>               (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -     return amdgpu_ring_test_helper(ring);
> +     r =3D amdgpu_ring_test_helper(ring);
> +     if (r)
> +             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..4e8eed2b62db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -204,10 +204,14 @@ static int jpeg_v4_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..1925d3092d02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -435,12 +435,16 @@ static int jpeg_v4_0_3_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>       VCN_JPEG_DB_CTRL__EN_MASK);
>                               r =3D amdgpu_ring_test_helper(ring);
>                               if (r)
> -                                     return r;
> +                                     goto error;
>                       }
>               }
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..a1496412810c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -232,10 +232,14 @@ static int jpeg_v4_0_5_hw_init(struct
> amdgpu_ip_block *ip_block)
>               ring =3D adev->jpeg.inst[i].ring_dec;
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..1a4594d5d952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -173,9 +173,13 @@ static int jpeg_v5_0_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             return r;
> +             goto error;
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..efdc537ec81e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -307,11 +307,15 @@ static int jpeg_v5_0_1_hw_init(struct
> amdgpu_ip_block *ip_block)
>
> VCN_JPEG_DB_CTRL__EN_MASK);
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             return r;
> +                             goto error;
>               }
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..eb3dc9558e0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -280,11 +280,15 @@ static int jpeg_v5_0_2_hw_init(struct
> amdgpu_ip_block *ip_block)
>
> VCN_JPEG_DB_CTRL__EN_MASK);
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             return r;
> +                             goto error;
>               }
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..0cbb2b8a7e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -156,9 +156,13 @@ static int jpeg_v5_3_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             return r;
> +             goto error;
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index ff7128a11cad..97c265daa2bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block
> *ip_block)
>       amdgpu_ring_commit(ring);
>
>  done:
> -     if (!r)
> +     if (r)
> +             cancel_delayed_work_sync(&adev->uvd.idle_work);
> +     else
>               drm_info(adev_to_drm(adev), "UVD initialized
> successfully.\n");
>
>       return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index cf304b489d87..90b57a08d6dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block
> *ip_block)
>       amdgpu_ring_commit(ring);
>
>  done:
> -     if (!r)
> +     if (r)
> +             cancel_delayed_work_sync(&adev->uvd.idle_work);
> +     else
>               drm_info(adev_to_drm(adev), "UVD initialized
> successfully.\n");
>
>       return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index 564d8fb58905..aa75b2691d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       amdgpu_ring_commit(ring);
>
>  done:
> -     if (!r)
> +     if (r)
> +             cancel_delayed_work_sync(&adev->uvd.idle_work);
> +     else
>               drm_info(adev_to_drm(adev), "UVD initialized
> successfully.\n");
>
>       return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index dcb8487e22b1..3016227cf0ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -515,7 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       }
>
>  done:
> -     if (!r) {
> +     if (r) {
> +             cancel_delayed_work_sync(&adev->uvd.idle_work);
> +     } else {
>               if (uvd_v6_0_enc_support(adev))
>                       drm_info(adev_to_drm(adev), "UVD and UVD ENC
> initialized successfully.\n");
>               else
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 46222fc30be6..48eac56f758e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -583,7 +583,9 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>               }
>       }
>  done:
> -     if (!r)
> +     if (r)
> +             cancel_delayed_work_sync(&adev->uvd.idle_work);
> +     else
>               drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized
> successfully.\n");
>
>       return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index b1428f5bbc81..0ba9bab7c921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -651,12 +651,16 @@ static int vce_v1_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>       for (i =3D 0; i < adev->vce.num_rings; i++) {
>               r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       dev_info(adev->dev, "VCE initialized successfully.\n");
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vce.idle_work);
> +     return r;
>  }
>
>  static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block) diff --git
> a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index dd870ecac2a4..20a4cb6d17fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -483,12 +483,16 @@ static int vce_v2_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>       for (i =3D 0; i < adev->vce.num_rings; i++) {
>               r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vce.idle_work);
> +     return r;
>  }
>
>  static int vce_v2_0_hw_fini(struct amdgpu_ip_block *ip_block) diff --git
> a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index d5adccd3e689..7637305df7e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -482,12 +482,16 @@ static int vce_v3_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>       for (i =3D 0; i < adev->vce.num_rings; i++) {
>               r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vce.idle_work);
> +     return r;
>  }
>
>  static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block) diff --git
> a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index ee445d8abe47..4e1fbc7b50f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -533,12 +533,16 @@ static int vce_v4_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>       for (i =3D 0; i < adev->vce.num_rings; i++) {
>               r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vce.idle_work);
> +     return r;
>  }
>
>  static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block) diff --git
> a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 76793a5caa70..b3e63d6e79a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -252,18 +252,25 @@ static int vcn_v1_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             return r;
> +             goto error_vcn;
>
>       for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>               ring =3D &adev->vcn.inst->ring_enc[i];
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     return r;
> +                     goto error_vcn;
>       }
>
>       ring =3D adev->jpeg.inst->ring_dec;
>       r =3D amdgpu_ring_test_helper(ring);
> +     if (r)
> +             goto error_both;
> +     return 0;
>
> +error_both:
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +error_vcn:
> +     cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>       return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..12ac20484396 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -294,7 +294,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             return r;
> +             goto error;
>
>       //Disable vcn decode for sriov
>       if (amdgpu_sriov_vf(adev))
> @@ -304,10 +304,14 @@ static int vcn_v2_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>               ring =3D &adev->vcn.inst->ring_enc[i];
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..fdd0b85a1aa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -481,18 +481,22 @@ static int vcn_v2_5_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             return r;
> +                             goto error;
>
>                       for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings; =
++i) {
>                               ring =3D &adev->vcn.inst[j].ring_enc[i];
>                               r =3D amdgpu_ring_test_helper(ring);
>                               if (r)
> -                                     return r;
> +                                     goto error;
>                       }
>               }
>       }
>
>       return r;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst[j].idle_work);

You need to cancel all of the delayed workers.  E.g.,

for (i =3D 0; i < j; i++)
    cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);

Alex

> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..f4b79611639a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -417,18 +417,22 @@ static int vcn_v3_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             return r;
> +                             goto error;
>
>                       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; =
++j) {
>                               ring =3D &adev->vcn.inst[i].ring_enc[j];
>                               r =3D amdgpu_ring_test_helper(ring);
>                               if (r)
> -                                     return r;
> +                                     goto error;
>                       }
>               }
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..dabab58d4042 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -349,11 +349,15 @@ static int vcn_v4_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             return r;
> +                             goto error;
>               }
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..56fabca78ea4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -395,11 +395,15 @@ static int vcn_v4_0_3_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             return r;
> +                             goto error;
>               }
>       }
>
>       return r;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..93d12e1b9050 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -303,10 +303,14 @@ static int vcn_v4_0_5_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..891ef2232c3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -267,10 +267,14 @@ static int vcn_v5_0_0_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>               r =3D amdgpu_ring_test_helper(ring);
>               if (r)
> -                     return r;
> +                     goto error;
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..b35db4cc6aee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -342,11 +342,15 @@ static int vcn_v5_0_1_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             return r;
> +                             goto error;
>               }
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..ea76fb20d4f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -257,11 +257,15 @@ static int vcn_v5_0_2_hw_init(struct
> amdgpu_ip_block *ip_block)
>
>                       r =3D amdgpu_ring_test_helper(ring);
>                       if (r)
> -                             return r;
> +                             goto error;
>               }
>       }
>
>       return 0;
> +
> +error:
> +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     return r;
>  }
>
>  /**
> --
> 2.43.0

