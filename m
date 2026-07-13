Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D6309EF2;
	Mon, 13 Jul 2026 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962490; cv=fail; b=iwRYJ4T7fmHkI4WHVD2rspsPS8pcekDGyLYUlkip5g7j7aXmPxXE6XOarML1d+USLNFTeuwMpueW2vmK992++pE98sl/BBN7eNR3axzRtFN7jjuU/MZw6zWFHOvNFk6cUhOJREajlyzn+jvwQybigKFLg2cfOusIgcmfzZnh/1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962490; c=relaxed/simple;
	bh=r+Wc3tslfU2dOrfSvrnYB1Jbnv8ctzVCOE+0T4+hb2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IxnyLn2u4PFYmG/hSSldqXZviK5OppTH0ppV6BSSfWzurr+xJ6gGrb4xByWJ70fHLwBdg6qohEwPiIz+jlC3FW9nKbBwX26OgfsxASuaWqwTNb7Vib0tRTqk6WvBd6osuQxHIAdaPkcjhtoBLUD2EA6waS8mfvCFMZr262gfwhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=FL6xMqEZ; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=A0hekrMn; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="FL6xMqEZ";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="A0hekrMn"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DGh0jP2017755;
	Mon, 13 Jul 2026 18:07:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=r+Wc3tslfU2dOrfSvrnYB1Jbnv8ctzVCOE+0T4+hb2k=; b=FL6
	xMqEZz0ocgJfhiikEzbY5MMYSzr7mtobZ8Vv96l/iM6q+RH3Ensmv+nd8R+hXubT
	OWZ3EF+VrX+iqjHmsFUwfpTFv3g6HRZY1JwqIzyP5HTUFzCBV9BGek1GV5+6XgPo
	AqMiNNM6ofjK2lDSbyrU+XJwupgY4RioWKLaoIgzBX+KNCEXRtFrDytGrR/Bqafd
	BJLy1Ps26VmiC91kMZGEvX60zXzDCh0MTX7qFsPredSz2wk1VqieGx6ot8f8vNpK
	epzY8gkLOy2QZEGpanu5H3X1M10XtZXkJgNgErKGKNKCZPJBG6GKHK/AJ7XJ5hRz
	oCr51iPG2/t7bLHpqHw==
Received: from lo0p265cu003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fbcp79v6c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:07:38 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnOOTZNlAck72S4B78WiOC25HVpifViO4mtEUFtyJ9t55TsdF4wq4np5yAiuSkjj0viGzMrLgDgv8pCqkoUUDVqx3wxTKHqnSifchk65w6G7cIxd5HOE13fr3h83cSucXjLNFXWoygbmfXmPQQt7rxbJpP+DbJqV3nWlhDTh9OlEesckZyLx61Hc0zfgN6b5sJJQaRKN2kUBPE8l71QJ7iVkahSVdCQQDvDFcEtwFldfMtvSFyiTpaLcitQ79zm5oxdbBmsggSpRhd+YJVQgeOiNksDT5+mOpN8HC4Acyzn02RUKhdjeU5iA6IvA2p6vfc8CYlQ055bb3FNfy6OgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+Wc3tslfU2dOrfSvrnYB1Jbnv8ctzVCOE+0T4+hb2k=;
 b=adbZP0Coe51uzWqivLWkzA6MONj1SgT1U1nCW9EuWfgsZ8ewe3E/fcoKawGcME0w0jiAxATwH9bRjc/NshmQLCwd3+U8ZaZnoPl3yeWbYGJtksGZyyRFA3UsYETysSxfjmUfw/FYA5qhfWoByPTHtOMSB4miRLyAkQUc3r1EJJo7SsLG/v6rDbN339iJKx9qLhzwedKDgSrP1jTBL4lTBNkus/BC8faaa4kScFWxaQaKKStKDvz9xxhBXF7+8skVaTE8qoGSfdFvhl3xf8B93/UKMiVrGidFLqOU8/vQJmZMqLLBg3FIj+HOXF+/QZHT+TK6YUyi3xh0unR5JYZEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+Wc3tslfU2dOrfSvrnYB1Jbnv8ctzVCOE+0T4+hb2k=;
 b=A0hekrMnvonSLWnBX/yGJy1lY5a5YN0dug/Qjc2N6cWDHeqFJDyjaFJmZAm7P+NtkjjhtsuNj2NQnC+0BaK8QulqAVIajqD2EL/Mu9fBmBe7JHkY3OKJi/6Z6fNOBXwkDNPYgUic0D2V53SPQeLnjsIr4ei7AUXJ59ASy+CgIqA=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO8P302MB1323.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:07:35 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 17:07:35 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "zhengxingda@iscas.ac.cn" <zhengxingda@iscas.ac.cn>
CC: Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
        "airlied@gmail.com"
	<airlied@gmail.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
        "simona@ffwll.ch"
	<simona@ffwll.ch>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "uwu@icenowy.me" <uwu@icenowy.me>,
        Brendan
 King <Brendan.King@imgtec.com>,
        Frank Binns <Frank.Binns@imgtec.com>,
        "dakr@kernel.org" <dakr@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        Luigi Santivetti <Luigi.Santivetti@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping
 memory to GPU VM
Thread-Topic: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping
 memory to GPU VM
Thread-Index: AQHc0bhnpqlNzjPeDkKjIGl0gYZv67ZsMMAA
Date: Mon, 13 Jul 2026 17:07:35 +0000
Message-ID: <c35ddb85f9818299ae83cd16850a33b0df3a262d.camel@imgtec.com>
References: <20260421175748.1989002-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260421175748.1989002-1-zhengxingda@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO8P302MB1323:EE_
x-ms-office365-filtering-correlation-id: f8960fe9-71bc-49de-44a9-08dee1013c43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 /xzUVyMis86SR22bxLU4y59jWlq4+dSWp92M6yQiToCFddRiiOijcwjqIQRDuBBCO+It48mn0jMxCHdnbWCIGxWpFNPMV2Jcr6oMXJcf/auVDf+yIxOsSQhWbUWpLpeOD+CsbQSzdaruI0sYIhTqjB7Z3SOaKpvWaUojfAOaM+AKWZMr0OTHx7LI+FuNeeOyIiZvHs2C9paD67lEUgaUIqBvPVf8l7XRliuWHMyr0xyvrRvsDE/fjUWOJxJNB5tUUxouoygvfFT41I7NEJlxT2YqB8Tie1CXd5iCjSmmTGmQBR33Li8eCAtEOflk5ICqVADUSmSapfK+0LrMWVkU92tFLnwenllYfdMMlW5Edcicus8dIIDKrg29q+urJePfki+CA4NNi+7SrwjItZGImv/YF54cpe6fLYFoxV3+PdypwcWQQwOBJCHwR3PBX5OQUBG98l+NsHh6nHeMPNVjIXaVAJFTy+NMwvGlsZNmPK3dOEvH7yeO10Ga9YWM3yb0KPo1e6s5VnbjnqeZNvAPV/8r7ido89q9dOZ8gDtBs4lgM+GK8CMIrKH1AIc94/LCayVhzjQ46cfRHJbrjSTTVc8JtWoHpQabk2JbKW1u016AXfhfeIqdnvdW4tuvwrU2tl0LdaLYTwVhjtwrJmShUNBb+jQ8invkLVRQ/Q/pFu3Ib2m7q9Z6J/56RdPEa9pvgX7JwS/v2g9QutwktSmr4Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWRNMVpQOXFhdVBldzF1UE9QaTNpSDFRMjBScDFQam4wU1ZzVjRHR3A1QnEw?=
 =?utf-8?B?M2RsM0QxWGdGb1MxcUl6L3VFL3FhVy9Eb1djZ2w2WVhPbnVKVVg4R053T3ZN?=
 =?utf-8?B?UExvdlJwaTAraVRlWElsS01HbWFlOGdaRlk2b2VROTBycFpZR2hsSkJPR2cy?=
 =?utf-8?B?ZUs4blVkZGlSMFRaVHJTWUZBWEdGanRNWUJJQi90eXJLeUF6V2RSMXI2Vmk4?=
 =?utf-8?B?QWxNLzF5ekoyU1RhcnZWaWtVN0t1YXJSMEFNT0lKUEg5dUM5QlZSV0NoMzR3?=
 =?utf-8?B?U1hyYWZHc1d3RHlLSDdlWm9OeWtLTnRxZko0b3pxRWVvWnpta1dpR1dEZGpx?=
 =?utf-8?B?Tnk3U1JSNWFpUi9RNGd5VzVFOTlzZThqeW8rZTIrTjI3enVzYncyaVgzS3Rp?=
 =?utf-8?B?d2JhOTJjNE91NnVVTnVVcWpOb0o2aVJEZXMvbzhUQnIzZjNhUHRvdnNWKzJI?=
 =?utf-8?B?bk1Ma282OVg5dFhIeElKSGtPS01kUW9WUk5ISlFyVmpPT05VMVZ1ZCtiTDJY?=
 =?utf-8?B?SnYvaEJSMVQ1MHh0bHNPQXJ6TEEvQ1paVksvOC9CQzBpVjVwWUxZTEZNY3BO?=
 =?utf-8?B?cG9sZlRIMzAzZUVWNHdMaXdFeENtdWx1ZmF4UnNIdjkrQ0F5dHJmRXVuL0to?=
 =?utf-8?B?L242MSt1MEg5SGFZU2JPL3FjeDhMenBlakt0ZlIxU2Zkc2x6QjlQTDRHVisv?=
 =?utf-8?B?ZWk0YkFURWV2eERwcjl0MWZubW5YaUYvenY4ZmRhUzFmdE83c1VjSGhoQ2xE?=
 =?utf-8?B?a0JDc1NQSXJpL1R4Y2xGVnJlRUF0bGZSay8ydHRndkZUdDBDVWV5MFc2VVBt?=
 =?utf-8?B?TFVuUEpaMGcrTXhocWhIeXEwc0hUV1AyeUJEWmkrNndPOFd5WExOYWpVZlE2?=
 =?utf-8?B?TjZtY1hzNFRrenZpUlRIdlI1akxqNS9COXVmUHc1V0g3bEtidVVneTlBSTIx?=
 =?utf-8?B?ZGg2UVRPZytmYzNud1h3Q2NOZi84b1g0UWI1Q0FVWlZjdGdWcUJBZHlUVDIz?=
 =?utf-8?B?NzlTTGRzczNNcGY3ZFcrTjVWaG5SUGJTTjc3R2piNElGMVJvcEF5c3lNaUhj?=
 =?utf-8?B?WUo5WmVMUUVoRmxGM3dORGJlZUFJVUJoWTFud3ozQ2xISXR6c2JUUlpOSlVt?=
 =?utf-8?B?QmIyY3p0NUxhcUlIU3R4Y2k1VWlMNkxrUnNVM05nOXdOampVdHhpeHN1eTFC?=
 =?utf-8?B?QXhOVzQxcjYvWm5SNlZIbUsrdUNGVUs3YVhEeEtyeXMrT0srUVFxQmVyTUFG?=
 =?utf-8?B?SDhKakRPUGd4Z2ZKRHh0SmVXc0dPUXBmaHpqNnhLTi9QdmpXNGpWZWpLcERl?=
 =?utf-8?B?QnV3ZWhtQTd6MmJnRi81MGRoZEpzUTQ2WjlNZnFQSHZlVUk3S0o5MjlyMHo1?=
 =?utf-8?B?Z0M3VndNUjJzSGQyVDBEUXdTb25NSEhCa2EwS3RFemZHNVBmc0QwTDNMMUFk?=
 =?utf-8?B?MTR6YnpQTWZQaHVFRyttTmhnREJRbWhVVnVSNG04d3dCT0FEQU0zL1kyNlFh?=
 =?utf-8?B?dUlsM3NUMTJ0RmMxWjNJR3NBQkZVSmJieEZrSjlOVTdMMXVzb25VL3F0WXda?=
 =?utf-8?B?ZHZrRmRsZnBSVDZCV2wrV0hBYndXdGhNUVVubnRMcDIyMmhkeU11cC9mSFVh?=
 =?utf-8?B?dU9QYS9qQXh0N1VSVzJvNWpXZDdWM2RDWCsxOENCMTlIdFRQaGNPaFgvcnNM?=
 =?utf-8?B?bXZHR25MMUlNMTI0YWlua1RDdTB5cmZZR0ZidmFqQUlqUHd3bjQ1dENRTU93?=
 =?utf-8?B?YWsxaDJEenVSYjRFNy9GV2thbTBLaUZQVUVJaDN0RlB4NXBxbm1LSHlnWDVn?=
 =?utf-8?B?dXVuKzQrVnhKNUJKb0ZNSVlJYXBENUZpTTlYMjFrWWo3L3VGK0xRTmdweU9z?=
 =?utf-8?B?V2RzUm9LSktlbjFXbytzZXBqRE14WGlzV3B4Z2M5TEtGMVZ4NU1XbzZqWHlk?=
 =?utf-8?B?MGR6VElIZ2FzNGd6d1pQVkwzRXRYOXFWSFdvNEhWR2cxQmpRZkhjaVMzZUZ2?=
 =?utf-8?B?aWFTbVZFQ29tU1FodWxSK21XZWE3cTJlZTNwZVpLVUF3emdob0w5UFM1dFpZ?=
 =?utf-8?B?blBQVmRUb0JEVTJnOGFva29KdGticS9OSlhkdDFmbWRqY1NrMUh4cCtCejZG?=
 =?utf-8?B?MnVRL09QSXZ6WUo4Q3h1VlJaL3l2VGhUamJXZm5WYWVVR3JmdWc3Q3JySmxK?=
 =?utf-8?B?T0Qva3VwQmVyZHRqWXUxc3FicUNrQlplczJ1Q0ZSOE85U3QvRjZWVnhPWERa?=
 =?utf-8?B?a3NYeHhZeGdScGhQM3pidi9VaTBsRFI0QlNMWDBtRFF6dGt6cERicndlVzZ4?=
 =?utf-8?B?TzgyOTdnQWRpMW0zZFFKRWpuYTFJaUF6cW5EZTFRMmlPbmFIRGNZeDhJTStX?=
 =?utf-8?Q?uDnFCPMHGGpHihEw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0AAA140EC18A64B8255B8214079F91B@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	f0sqlSrC2GHi21MMFzWZcL02tOc1w/m/bURyPSb3F07GBxSS8zz8IdXQGciGjU+zeHnqdCqEy4n1i5wjFZQCszz9Qfj3KFcTaeCY2pc+O4gBfdyyoWQ6TdXVKM6Lw4ySVwgxgd0zGSUNAEH5NtDf3HQp65x6yWIXmQ7lzoUm7ghhBU90SiBFXJ0WHoq4kLBY322jVJQsD/HMfee/Xe/73s9RSSg31kvO7KT3rRmUeLC/mG2uzxIrgMM/kOfLUDPAPRsyLD8AkbkNPk2MRXeWkRG6S9bcYmOdDXkVM2dN/fm22aJ+IvisV9XRb/bpPg/VVWEhAX1X3cfrd6FYnOLOlQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8960fe9-71bc-49de-44a9-08dee1013c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 17:07:35.4806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmqgG4qZzFxH2fydGaBx8Xbo0hWTcAme96+ZIXPJYpImchbykpRqsI5SJmZtlYHFIDZEivgOuenqKlF126e3z6haUqnFp1OIuILsY/KjnE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P302MB1323
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfX8Dh2rHWqDnlP
 3iO65+7r8gXCD3IBVxJxZl9V5Diwl6MvVZ1PY35B1aVTJBZDWmptTfIP6aaS4EVHVEC0hyCVuq3
 nuKUY8fg3/FHbKiEFk9aVdJSpz6NYBI=
X-Proofpoint-GUID: prs6io-h7kuNhWXZde1nT9RMBSaKsQNW
X-Proofpoint-ORIG-GUID: prs6io-h7kuNhWXZde1nT9RMBSaKsQNW
X-Authority-Analysis: v=2.4 cv=AYOB2XXG c=1 sm=1 tr=0 ts=6a551b5a cx=c_pps
 a=91ribLxN1HUKDA2zppeunQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=-RzFVXMwt1eXrVUYxrUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfX9O9Qik7jc66N
 vwCr/8pmWHSNn4b9NEPIjw7M4hiBX4irTmhCjalV2CchUEoBFJhj0C+MSeiM0NObY9ToYPEwnea
 g227qjEetB0bLAzp4UXb2mdTaMzqIZMOSHFx96su1kE+e21EXWGfzSlZ7Dttth5JoRkkV5K47F0
 J8erDUjI1bf6A7jP42qNYSBqFhnXbCUcsQ6Pp/KVvXm7jkKJcyyi32rqn272hEtNJZhE2ADLoEt
 IhhW7uOiQM7DVgenNBcYTc86yTSWN1rBuOxunNIe2noZNbD6jsx24jKzY0xDjb8rLPcahMg9LGh
 sSk6zKo3X0TKgSrfetv2HEd+ejqpEpOOC2pcZgBAA3xdFdi7SP0aNtKI24mCy8l3QbRFCimyc8g
 oJMXNlJiVXO3sglf2UwR+NKWgYlUp8AWb2W0PpMSKZBGR4id0dkNGIBMzTlvvqZVoIaNGZQHcrW
 qV3IGbrv7DmF+uBk7Wg==

SGkgSWNlbm93eSwNCg0KT24gV2VkLCAyMDI2LTA0LTIyIGF0IDAxOjU3ICswODAwLCBJY2Vub3d5
IFpoZW5nIHdyb3RlOg0KPiBUaGUgZHJtIGdwdXZtIGNvZGUgZG9lc24ndCBwcm90ZWN0IGZpbmQg
b3BlcmF0aW9uIGFnYWluc3QgbWFwIG9wZXJhdGlvbiwNCj4gYW5kIHRoZSBkcml2ZXIgbmVlZHMg
dG8gZW5zdXJlIGEgbWFwIG9wZXJhdGlvbiBzaG91bGRuJ3QgaGFwcGVuIHdoZW4gYQ0KPiBmaW5k
IG9wZXJhdGlvbiBpcyBpbiBwcm9ncmVzcy4NCj4gDQo+IEFzIGFsbCBvY2N1cmVuY2VzIG9mIGRy
bV9ncHV2YV9maW5kKigpIGlzIGFscmVhZHkgZ3VhcmRlZCBieQ0KDQpuaXQ6IGlzIC0+IGFyZQ0K
DQo+IHZtX2N0eC0+bG9jaywgbWFrZSBwdnJfdm1fbWFwKCkgdG8gYWNxdWlyZSB0aGlzIGxvY2sg
dG8gcHJldmVudA0KPiBkaXN0dXJiaW5nIGFueSBmaW5kIG9wZXJhdGlvbi4NCj4gDQo+IFRoaXMg
Zml4ZXMgb2NjYXNpb25hbCBOVUxMIGRlZmVyZW5jZSBpbiBkcm1fZ3B1dmFfZmluZCooKS4NCg0K
bml0OiBOVUxMIGRlZmVyZW5jZSAtPiBOVUxMIFtwb2ludGVyXSBkZXJlZmVyZW5jZQ0KDQpEbyB5
b3Ugc3RpbGwgaGF2ZSBrZXJuZWwgbG9ncyBmb2xsb3dpbmcgdGhpcyBidWc/DQoNCj4gDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiA0YmM3MzZmODkwY2UgKCJkcm0vaW1h
Z2luYXRpb246IHZtOiBtYWtlIHVzZSBvZiBHUFVWTSdzIGRybV9leGVjIGhlbHBlciIpDQoNCkFz
IGZhciBhcyBJIGNhbiBzZWUsIHRoYXQgY29tbWl0IHN3YXBwZWQgb25lIHdheSBvZiBsb2NraW5n
IHJlc291cmNlcyB3aXRoDQphbm90aGVyLCBidXQgdGhlIHByb2JsZW0gb2YgVkEgZmluZC9tYXAv
dW5tYXAgb3BlcmF0aW9ucyBub3QgYmVpbmcgcHJvdGVjdGVkIGJ5DQp0aGUgc2FtZSBsb2NrIGFs
cmVhZHkgZXhpc3RlZCBpbiBjb21taXQgZmY1ZjY0M2RlMGJmICgiZHJtL2ltYWdpbmF0aW9uOiBB
ZGQgR0VNDQphbmQgVk0gcmVsYXRlZCBjb2RlIikuDQoNClRoYW5rcywNCkFsZXNzaW8NCg0KPiBT
aWduZWQtb2ZmLWJ5OiBJY2Vub3d5IFpoZW5nIDx6aGVuZ3hpbmdkYUBpc2Nhcy5hYy5jbj4NCj4g
LS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gRml4ZWQgd3JvbmcgY29tbWl0IHByZWZpeC4NCj4g
DQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMgfCAzICsrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfdm0uYw0KPiBpbmRleCBlMWVjNjBmMzRiNmU2Li5lZWE4OGU3YWQwM2MxIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jDQo+IEBAIC03NDcsNiArNzQ3LDcgQEAg
cHZyX3ZtX21hcChzdHJ1Y3QgcHZyX3ZtX2NvbnRleHQgKnZtX2N0eCwgc3RydWN0IHB2cl9nZW1f
b2JqZWN0ICpwdnJfb2JqLA0KPiAgDQo+ICAJcHZyX2dlbV9vYmplY3RfZ2V0KHB2cl9vYmopOw0K
PiAgDQo+ICsJbXV0ZXhfbG9jaygmdm1fY3R4LT5sb2NrKTsNCj4gIAllcnIgPSBkcm1fZ3B1dm1f
ZXhlY19sb2NrKCZ2bV9leGVjKTsNCj4gIAlpZiAoZXJyKQ0KPiAgCQlnb3RvIGVycl9jbGVhbnVw
Ow0KPiBAQCAtNzU0LDkgKzc1NSwxMSBAQCBwdnJfdm1fbWFwKHN0cnVjdCBwdnJfdm1fY29udGV4
dCAqdm1fY3R4LCBzdHJ1Y3QgcHZyX2dlbV9vYmplY3QgKnB2cl9vYmosDQo+ICAJZXJyID0gcHZy
X3ZtX2JpbmRfb3BfZXhlYygmYmluZF9vcCk7DQo+ICANCj4gIAlkcm1fZ3B1dm1fZXhlY191bmxv
Y2soJnZtX2V4ZWMpOw0KPiArCW11dGV4X3VubG9jaygmdm1fY3R4LT5sb2NrKTsNCj4gIA0KPiAg
ZXJyX2NsZWFudXA6DQo+ICAJcHZyX3ZtX2JpbmRfb3BfZmluaSgmYmluZF9vcCk7DQo+ICsJbXV0
ZXhfdW5sb2NrKCZ2bV9jdHgtPmxvY2spOw0KPiAgDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCg0K
