Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222AA4BD34F;
	Fri, 18 Sep 2026 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722492; cv=fail; b=jz9mYHfoiU4zfHetMJdFUCXdG4RUeBLhj0MzfN66bGkFnjWE8ZN4+Y22z42+7lH6R8n7q81eolM/wRkeOhL5wj1oEoH7OVFCnyJom9IFE1JWPpfnIaKDD8rCwTgxr1bdqf8utrKWhG0kj14OWxUvy/9sWhzu0J05j5mYS6chdPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722492; c=relaxed/simple;
	bh=1TzDiXwDqKNYWKr13CPOXrjSAjGlqBqdKC3pBt5zFqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlspbHSTCLRWPLwNALJXm6iviGI/pX6R0TrDe4QD+mliWU6x8lgfMYz4qhLTLFYzJHZStabiXkmJ4BQnLToGfXODnP4r70WjbZQU/Djw4HU6KBdeh3GN+ts3BN/wBUoPS6vGjm4m6vH8NTLywATjDzTdfJc7AtPpw9la9S1X+Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=FpqwJPR4; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=mUZk2W6u; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="FpqwJPR4";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="mUZk2W6u"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xdMN1292252;
	Fri, 18 Sep 2026 10:07:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=1TzDiXwDqKNYWKr13CPOXrjSAjGlqBqdKC3pBt5zFqg=; b=Fpq
	wJPR4QOABBsnQeIijei5IECFrfH6J6w12TfRflhegInVjtECb7slz307I5Uw9wJT
	L+rZBaqV+svUHJiUOsq1Ts+I6UTLZ7MApN0fifPyHilAkVBRojRi4Y6IkO4XqeIt
	9Dv+ntBnjAocEGkw7m/ezooUju/DVsRocReLYTwdOrxmqq5TIwgfXJ+/j73eiBhk
	knZxeB11ce7OO1rpMA/BB3XqcWl8cHQCOH+FKK6G95ho8QMZ4LPdQkJhEbe38rFD
	fHBFGocBCuwYKlwobDkCsHxx/GKL+Pi+vBa8rzucjOgwh+2jyYYdomiCXN+K60LS
	OyLLBQn8kE7eh4FNUyA==
Received: from lo0p265cu003.outbound.protection.outlook.com (mail-uksouthazon11022110.outbound.protection.outlook.com [52.101.96.110])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtuneqh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 10:07:50 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk9e1z6mhu3nTbairMqjOV19hyIihcaMEz0Sg/rswqds8MGqsL2NQoUniCfSRbloUcJjXIn1+IRq7TDbG7rldEaHWIPesWsDxstfFf7NivGQAdVBujJH2H7z0U3jT4cKvFEmJM3oxSJeSl97Z7vyyHJ0H9+OAXhgM069XSljp8ojpqloGtQJQTMndC3drz5unhM3aS1F96qbMvA3M0bF7SzeRumFYaSgqGeTeOSQpKVbIvahMh3RpqtXYqNROiflRFP7IvJy7r+p1hXUHsFkFp9WQafeapZTAAIeqwWRjK+Tsbncv/I9jmsUGY00syx8IwWDqvcWUYXyvp3DxvPaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TzDiXwDqKNYWKr13CPOXrjSAjGlqBqdKC3pBt5zFqg=;
 b=otdYw1V8cQe5kbFQWEMnwH5uOlnbacSfK71kb/BTb2fmU4keArv5WXhg7D1WZIcXsQXQPd/5SbwBM+1MtwSDv1Mc3D2uQAwZWeCLq9Gq9xgO8NfBsZ4u7wOH1+6I9Si6RpNDIp8Y5b0oTWQmWa5LNkQppz6GNLe5Mp5mMTEhn4EI4R1nbrLoX/34JE6tJl67373ZHstrnvtKaNsz/Npecml6RigAIEWGAuk91VxmgG6DEn4BU4++TV9DFRiwWiKXfKPjki0AJrYJWFFt2d2eI9LfCg7qlgzk55NKdwrFU6ccMnN+hhWaffe8tOGt8YuQ8iUgw+MChoapoleiN4y2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TzDiXwDqKNYWKr13CPOXrjSAjGlqBqdKC3pBt5zFqg=;
 b=mUZk2W6um9yqI8YmFNG3Xdl6RyqU5PUJKuHOKww6abUXk+aNaQ7eFooOV4+KuVVAVpzzldwI+OcuwDRiinuurZQHdG1kPqRty3cl1l7z/n8AByLWwjX8zQhDW1fJBpiBb3C5ncrFQBwFsH3j/5folmq2Cur8uGIxYUhAXbCAgFs=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO8P265MB7702.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 09:07:43 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 09:07:43 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
        "tzimmermann@suse.de"
	<tzimmermann@suse.de>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>,
        Brajesh Gupta
	<Brajesh.Gupta@imgtec.com>,
        Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
        "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/imagination: Fix page count for page table for
 map() interface
Thread-Topic: [PATCH 2/2] drm/imagination: Fix page count for page table for
 map() interface
Thread-Index: AQHdOsFPMFnpwfeotEywU5H961j+N7bUJM6A
Date: Fri, 18 Sep 2026 09:07:42 +0000
Message-ID: <d0af551497354ae987e738f96fc3ba15a28b0af8.camel@imgtec.com>
References: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
	 <20260902-mmu_fix-v1-2-c55a23fb7cab@imgtec.com>
In-Reply-To: <20260902-mmu_fix-v1-2-c55a23fb7cab@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO8P265MB7702:EE_
x-ms-office365-filtering-correlation-id: 83769436-45da-4ac6-cdf8-08df15644c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|6133799003|18002099003|22082099003|9063799003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 4mADgrkYtFcm+kDvjAJ4zqZ/0EKgNSZeIAvAkCids6KMtToUULFJOIqs3ZSiTSH98s1OVd1pHojLBCGOO6J52NG+ZIg/OoIRPOhL16UdQ5YbKM789uXR7Q+N+VayF6atZVuwDTZa192w8b3bMlMjLfI7n4xKv+rBpsJtRPfn5/WjKnDaf8y52GfZaU/AzZoGuaDzAdf7Xm2/2EupaGrgcEYUnIjDPG69ZNsVIoZSRnU7E+z99I3EJQ+RPxjExMJAheNuTfP7HK8dI1E96yyak32IktLJi87MrPFxsdqjrFJlmflEDVNtSNSoy6HRhHzzI6M1cyg17LnHWD+FwhWY6lPaYlsz5oLVYnZ0SYNHEXZ/DAS33NE+XtlpokRV8cgnOECOOY4JlT7Nz1j/hpEeGt1K6gaRa7VgadtrE9xmmVotb9jc/6rwX9iGI5oLB6gzU2oKrzdJgNq0FMa/KLkcuxMhkjFgiKbERk4gEaV9ErOKb4ae0xEjKkZkK/z9WEpLUnhK+kvRnfFm1MNm3wS+JbS9cpkiHxApSWhF7Q8EPc68Nos/0JLaMCqdFSbYEo9j89wWz5ubgo3NMZ50b3DKuZZsg3BxY8g97jJpz11yU1x2bX8v3H85G6bPi5zKsJZZqn8mjCxXIDf6iDLzxP/JrqZr/uASH6/al4sdGSbLXFwfo2dXpS2CuPKHeEIX4VamHI4EMXBxmbEgnhWUB2ZhyHu1sLKrd0wLOoXc8F3qk5A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(6133799003)(18002099003)(22082099003)(9063799003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmVKVXc0QWNRMmpFZWtuR1U3a3p4eGppYXNUSEd3MTdrc1pkYi80SjdGQVJn?=
 =?utf-8?B?eVF2aWR1SWNkUTlnUzE0aTVBV0JyVlRFc2FmV0pvNXhrYTlTckNWM3FzZ2hU?=
 =?utf-8?B?d0h2ZXVLY3hKY1NGVzczekVwa3pPUlpZSFdlRlFvdHduc0pseC84T3FUOEdP?=
 =?utf-8?B?b0NKcVBxbzhtR2pzNWRlZ2JNdUZlZE5taEN4SXNybzNxZ0xKM0k1MlNFb1hP?=
 =?utf-8?B?bGJYeG5pVUNGSXdZS2hFRUg0Q0dteXlwU0xRNlpIR3pEaDNLK2pCOHUzb3hp?=
 =?utf-8?B?TVB6SElrL3JQNlNtQ083bFk5MDJIZW9Ldi96dUNURmNGemZEb1BQVlVOcXVa?=
 =?utf-8?B?dUVPa3RvM0ptQXoxVnhZU0lWSk5qNUpVNk9seUFnTnpjSDJ2OUpDTjNNb0VW?=
 =?utf-8?B?bmVVdWdTN0d0bFlya0U5ZzZyRkVDU3BnNHlzYXNKb1Q3NVpwM3cySXVVVk52?=
 =?utf-8?B?U3dPd0tBZ0ErUzNZeXp2TFlaOUd6YVZOQU4rMzI4WlJnWnR1V1Q0bmdGR0xK?=
 =?utf-8?B?VWdGekpsVmhieGhVVTF5UkNKVm9TWTQya3ZxV2NXVjVCcjJDMno2RlpQZEsw?=
 =?utf-8?B?T0lmYXVtZjBsQlVITVp2ZU44RGFRWVFNakIvd3JxODNOUHdVYmlOVE1hZ2pm?=
 =?utf-8?B?dklIMitMYUMrTnRIYzc2Ly9QTFU1VGFMdUF2Mjc2TnR0YTgydWM1cTkxVVNF?=
 =?utf-8?B?ZlZxYUt1TS9MalUrNFlkcVpUWlZ3VVVzaElyQ0xHWHhrSkNTOTFzUmRmTjZr?=
 =?utf-8?B?ai9LVGphWTJKUTJWVXVvYnFhZmgrR3lONXYxNS80WG9vaXJVRlYvb0E3SDd4?=
 =?utf-8?B?ekplYmFZRkczU3dQVk94N0drK1lSNzhob0FBVjd3dU5vbkd0ZVcwRUtoUTdW?=
 =?utf-8?B?ZFozdDBDVHQ0eEpGdWY4UlpCK2taZFQ0T2VnQVhQNXBneC9jOGNlNER0YmYw?=
 =?utf-8?B?Rmg4S3VvTS9oQTg0a0lKVEc3aWFHVzFocTFPZk94SXN6NnFMdDZjb2pvalFj?=
 =?utf-8?B?Rk1FU29JR3M3aDFyVTZ1Nk15NDgxN2o4djFCVmFadFRNWmlrdmNINlUrOThh?=
 =?utf-8?B?SkxIdGlCUUdSUWRYeGhzNGZ0S1dyeGRPd1Nkc3ZDS1ZjdnFxN2xVUnhPN2NT?=
 =?utf-8?B?ZkZuclZIY3V0YnRVaXExL2ErZS9SeVlseWNQR1I3dEp3VTRrSWpTNDNDWUxC?=
 =?utf-8?B?SlFoSmJMMkFUQmZtSm1RR3o0WEYzUkZjdFVLSVhwcGpWNEpJK1NSMENEZi9h?=
 =?utf-8?B?VjhORnlobGlUM0VDZlFzcDAwRnUrYllXUnY2Q3REVkMvTmllLzhhSXMxWXNa?=
 =?utf-8?B?S3N0M1JmOExjYnVOMzV2cmZtTjFFMEc3RUN0WWU0R2xpZHdOemNqMnV2ZFd5?=
 =?utf-8?B?QUxZNHJsOGdvQVlYaEhid3pjWXBueG0wUVdHNkw2emNDOUE4MDU1dHpQSGZ6?=
 =?utf-8?B?Zk9oNDV5YXRzNnJEamc5TFRaOWMyakNZaCtlRXNkUFJKUlJocUxUTjdEa3ll?=
 =?utf-8?B?SFVESDFYTUxjaS9haTk4SWVSYXZiNm5Td084ZjRtNjBSTDlNM2h6QVlLc0or?=
 =?utf-8?B?YzVnVFpONFBiWk1aWEN4aWtXdDJrdjBkU0pDN3N1RnAzNHVlQndmMDNValBU?=
 =?utf-8?B?ZE9WN2RKTndralEwUFpKWjU0aVJFTmoreElrYU5qZUNVcU81VUQzNkQ2Vlhn?=
 =?utf-8?B?MldHMGhNRG9VUmlqaVBsNlJCT2FQSGdQSHpHQXd2eUJJS0Y2RnlMZjBiMnp0?=
 =?utf-8?B?QjN3NnpPeFhLbjZJS0dUWmc3aGdZN1F2SHNOb3RCSGQ5TDh1d1hSbkFPYWI1?=
 =?utf-8?B?NEVTQjVUdnJyMDBHa2RQMlMrcXp1cUFuV3ZTbEEvTDY3cVRWeVF6dkxKeVly?=
 =?utf-8?B?L3MzM1VuSS9DOGJZa05NTE9TelJCU21KNktkN2pnUFQ0dFp4b1ZYbGI5Z09M?=
 =?utf-8?B?OEN0bHpRaGRNTkxWTE9BUkxkbG1qSExTZXhoUDB4S3RLdFd2YW1XK0pWU01P?=
 =?utf-8?B?SDZlR0xGVytCY25HZ3RlQnRpQ254N2FCWlJURlFmVXUwNGp6MmVic3BJdzcy?=
 =?utf-8?B?SHU2QTNZaE4xdkJoYmxYZ21LRm9PUURpTlNYUzFpUCtMVUd4cDZJelR4bmg1?=
 =?utf-8?B?QmJaTHFadGpUcmM1Nm5wZHE5aFcxM2VVUFJ4Z0xyUGN3MmFYMDU1MzVsUUZj?=
 =?utf-8?B?SkVYbUtBK0tVTld6Q1crTE9NQU8zWDBqUTc0Rzl0bmJidWU2U0ZOMTB1bFUz?=
 =?utf-8?B?ZTExeVdCcEl1Zm9sQ3M5aDJvVkErcEEzbm5tRS9obkNUekxsUTl4RS8yNS9O?=
 =?utf-8?B?N2VHY2lhWkxQODZZdFRXeUZoQWtMMW9qNnc2dEZJbWoxbmhpbW1CVVB0Nndi?=
 =?utf-8?Q?vzb7Cuo2QY6TVKiY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD4441BB19F6F7469EF090876AB0EE91@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	J77ahBK33FNAvxd3IWKFPd6TjPQa/VvwFuhujzu2ZHaXalx+7qaj58sO+yt1d5BlHMA2cjcdi2iH+C+ueFTK29ShUXO5OBHnd/4JL/SIAgjad58DLWsdefay8ADbn/4+CKo1+SR++/LbRJ+dur1Uer2iyJtoslrYGpPrrN+RMjDObi4Z/vpsts0MZhT594IvT/D6ZZKr8VU4gT6jp22jGDMYVPLNalnuaeY4QpaoXBsSu0uvAl/+w0n0/7qfF32UeH2gNGzxEy3AiWRxQ7VNGe/Oey4albml6GIrdXrM5wmXEUe7nkSNuBJwkl+InL6NhzmzcsLi/Sx3zif44IapgQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 83769436-45da-4ac6-cdf8-08df15644c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 09:07:42.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0smxgHTvXAG3gy5Rr3Te66C0Y421hDFcPnpvGH+7Yn+eM7vSYwdOb47EdX8UyzkDESZjODBiKPZv17ciXVBHojbT6Hh0EzfjTIwsuSwuh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7702
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aacff66 cx=c_pps
 a=MIvDDvqsVNCIihL80LubzQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=_tnsCGDjb9EecRV9e5YA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: 8IHDwiUoicrBDnlTMVHiVdhf0hLVFFoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyNSBTYWx0ZWRfX7NRH3b5PF3+7
 bX6NlGtb+9Ois5vnZ3gCckPLh9fHoc5Tc4d+GoGo4sBtAbk/BUe7eWw1q2ITG8KepB8qhh8aZ5d
 v2wHwz6k8dVv33MFIND3YyPOUvDeKkYrPuxn52KatlN8A7ymDSPu3UYQBDdISWH9aXAcw+yZ8DT
 EeSOp71+9APCMBMHXQNih6JH/J2gta2mqG+MKX/0RfL2ElE2YM03WNWRoRQukKB42jOj/3fDYad
 5vLF59X8ujQl8cpb3HkH2rFLlcRD4Bj4NciYwXt+Xkauh4/9QfiKTJ5mBkYMN6GGB1Mt1Py6vQJ
 DlgpJ7Z9f3Ol/mE78SqPCQHSY9EJtvkD1ZHhrZ7LbBnQvEoUf/vvl/JJrP0+myFyJhqnuvAN3pX
 PL9eBTRg2JKw7pNubYlLpDgJtLJmieXvqsqc5tni2mECQaW7GVxhrtXHI6IkUgLnVB33l/y2sBS
 lu02XLtIW2F121CFuTA==
X-Proofpoint-GUID: 8IHDwiUoicrBDnlTMVHiVdhf0hLVFFoL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyNSBTYWx0ZWRfX0WGklKWjSBkP
 Wu1OZeI6qVKIyev26AtpSEc9dmh7we4V/dKXVulL2qI66BddBEDmWCoBooNIAqNbZY9EvVZp0cy
 oxpRgth5rYABdb208Xy2p0dqU8c/7Os=

SGkgQnJhamVzaCwNCg0KT24gV2VkLCAyMDI2LTA5LTAyIGF0IDE1OjI1ICswNTMwLCBCcmFqZXNo
IEd1cHRhIHdyb3RlOg0KPiBHUFUgdmlydHVhbCBzdGFydCBhZGRyZXNzIHdhc24ndCBpbmNsdWRl
ZCBpbiBwYWdlIGNvdW50IGZvciBwYWdlIHRhYmxlDQo+IGNhbGN1bGF0aW9uIGZvciBtYXBwaW5n
IGFuIEJPIG9iamVjdCBpbiBtYXAoKSBpbnRlcmZhY2UuIEl0IHJlc3VsdGVkIGluDQoNCk1heWJl
IHRoZSBvdGhlciB3YXkgcm91bmQgY291bGQgYmUgc2xpZ2h0bHkgY2xlYXJlcj8gZS5nLiAiVGhl
IEdQVSB2aXJ0dWFsIHN0YXJ0DQphZGRyZXNzIHdhc24ndCBpbmNsdWRlZCBpbiB0aGUgY2FsY3Vs
YXRpb24gZm9yIHRoZSBhbW91bnQgb2YgcGFnZSB0YWJsZXMNCnJlcXVpcmVkIGZvciBtYXBwaW5n
IGEgQk8gb2JqZWN0LiIuDQoNCj4gbWFwIGZhaWx1cmUgbGF0ZXIgZHVlIHRvIG5vdCBlbm91Z2gg
cGFnZXMgYXQgTDAvTDEgbGV2ZWwuDQo+IFVwZGF0ZSBwdnJfbW11X29wX2NvbnRleHRfY3JlYXRl
KCkgaW50ZXJmYWNlIHRvIHBhc3MgZGV2aWNlIGFkZHJlc3MgYXMgd2VsbA0KPiB0byBhbGxvdyBj
b3JyZWN0IGNhbGN1bGF0aW9uIGZvciBwYWdlIHRhYmxlIG1lbW9yeS4NCj4gDQo+IE1pc2NhbGN1
bGF0aW9uIG9mIHBhZ2UgdGFibGUgcGFnZXMgZm9yIG1hcHBpbmcgYSBCTyBzdGFydGluZyBhdCBh
IGRldmljZQ0KPiBhZGRyZXNzIDB4ODAwMWI0NTAwMCBvZiBzaXplIDB4OGNhMDAwOg0KPiAgICAg
ICAgICAgICAgICBvbGQgICAgICAgbmV3DQo+IEwwIGNvdW50ICAgICAgIDUgICAgICAgICAgNg0K
PiBMMSBjb3VudCAgICAgICAxICAgICAgICAgIDENCj4gDQo+IEZpeGVzOiBmZjVmNjQzZGUwYmYg
KCJkcm0vaW1hZ2luYXRpb246IEFkZCBHRU0gYW5kIFZNIHJlbGF0ZWQgY29kZSIpDQoNCkknZCBh
ZGQgdGhlIHN0YWJsZSB0YWcgdG8gdGhpcyBvbmUgYXMgd2VsbC4NCg0KPiBTaWduZWQtb2ZmLWJ5
OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRhQGltZ3RlYy5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYyB8IDE0ICsrKysrKysrLS0tLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5oIHwgIDIgKy0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYyAgfCAgNCArKy0tDQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9pbWFnaW5hdGlvbi9wdnJfbW11LmMNCj4gaW5kZXggMTc1ZjBiYTRkOTkzLi41MmQ4ZmJjMDAz
ODQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiBAQCAtMjMz
Niw2ICsyMzM2LDcgQEAgdm9pZCBwdnJfbW11X29wX2NvbnRleHRfZGVzdHJveShzdHJ1Y3QgcHZy
X21tdV9vcF9jb250ZXh0ICpvcF9jdHgpDQo+ICAgKiBwdnJfbW11X29wX2NvbnRleHRfY3JlYXRl
KCkgLSBDcmVhdGUgYW4gTU1VIG9wIGNvbnRleHQuDQo+ICAgKiBAY3R4OiBNTVUgY29udGV4dCBh
c3NvY2lhdGVkIHdpdGggb3duaW5nIFZNIGNvbnRleHQuDQo+ICAgKiBAc2d0OiBTY2F0dGVyIGdh
dGhlciB0YWJsZSBjb250YWluaW5nIHBhZ2VzIHBpbm5lZCBmb3IgdXNlIGJ5IHRoaXMgY29udGV4
dC4NCj4gKyAqIEBkZXZpY2VfYWRkOiBWaXJ0dWFsIGRldmljZSBhZGRyZXNzIGF0IHRoZSBzdGFy
dCBvZiB0aGUgcmVxdWVzdGVkIG1hcHBpbmcuDQoNClR5cG8gZGV2aWNlX2FkZCAtPiBkZXZpY2Vf
YWRkci4NCg0KV2l0aCB0aGVzZSB1cGRhdGVkOg0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxs
ZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gICAq
IEBzZ3Rfb2Zmc2V0OiBTdGFydCBvZmZzZXQgb2YgdGhlIHJlcXVlc3RlZCBkZXZpY2UtdmlydHVh
bCBtZW1vcnkgbWFwcGluZy4NCj4gICAqIEBzaXplOiBTaXplIGluIGJ5dGVzIG9mIHRoZSByZXF1
ZXN0ZWQgZGV2aWNlLXZpcnR1YWwgbWVtb3J5IG1hcHBpbmcuIEZvciBhbg0KPiAgICogdW5tYXBw
aW5nLCB0aGlzIHNob3VsZCBiZSB6ZXJvIHNvIHRoYXQgbm8gcGFnZSB0YWJsZXMgYXJlIGFsbG9j
YXRlZC4NCj4gQEAgLTIzNDcsOCArMjM0OCw5IEBAIHZvaWQgcHZyX21tdV9vcF9jb250ZXh0X2Rl
c3Ryb3koc3RydWN0IHB2cl9tbXVfb3BfY29udGV4dCAqb3BfY3R4KQ0KPiAgICovDQo+ICBzdHJ1
Y3QgcHZyX21tdV9vcF9jb250ZXh0ICoNCj4gIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoc3Ry
dWN0IHB2cl9tbXVfY29udGV4dCAqY3R4LCBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwNCj4gLQkJCSAg
dTY0IHNndF9vZmZzZXQsIHU2NCBzaXplKQ0KPiArCQkJICB1NjQgZGV2aWNlX2FkZHIsIHU2NCBz
Z3Rfb2Zmc2V0LCB1NjQgc2l6ZSkNCj4gIHsNCj4gKwl1NjQgc3RhcnRfYWRkciA9IGRldmljZV9h
ZGRyICsgc2d0X29mZnNldDsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+ICAJc3RydWN0IHB2cl9tbXVf
b3BfY29udGV4dCAqb3BfY3R4ID0ga3phbGxvY19vYmooKm9wX2N0eCk7DQo+IEBAIC0yMzY0LDE2
ICsyMzY2LDE2IEBAIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoc3RydWN0IHB2cl9tbXVfY29u
dGV4dCAqY3R4LCBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwNCj4gIAlpZiAoc2l6ZSkgew0KPiAgCQkv
Kg0KPiAgCQkgKiBUaGUgbnVtYmVyIG9mIHBhZ2UgdGFibGUgb2JqZWN0cyB3ZSBuZWVkIHRvIHBy
ZWFsbG9jIGlzDQo+IC0JCSAqIGluZGljYXRlZCBieSB0aGUgbWFwcGluZyBzaXplLCBzdGFydCBv
ZmZzZXQgYW5kIHRoZSBzaXplcw0KPiArCQkgKiBpbmRpY2F0ZWQgYnkgdGhlIG1hcHBpbmcgc2l6
ZSwgc3RhcnQgYWRkcmVzcyBhbmQgdGhlIHNpemVzDQo+ICAJCSAqIG9mIHRoZSBhcmVhcyBtYXBw
ZWQgcGVyIFBUIG9yIFBELiBUaGUgcmFuZ2UgY2FsY3VsYXRpb24gaXMNCj4gIAkJICogaWRlbnRp
Y2FsIHRvIHRoYXQgZm9yIHRoZSBpbmRleCBpbnRvIGEgdGFibGUgZm9yIGEgZGV2aWNlDQo+ICAJ
CSAqIGFkZHJlc3MsIHNvIHdlIHJldXNlIHRob3NlIGZ1bmN0aW9ucyBoZXJlLg0KPiAgCQkgKi8N
Cj4gLQkJY29uc3QgdTMyIGwxX3N0YXJ0X2lkeCA9IHB2cl9wYWdlX3RhYmxlX2wyX2lkeChzZ3Rf
b2Zmc2V0KTsNCj4gLQkJY29uc3QgdTMyIGwxX2VuZF9pZHggPSBwdnJfcGFnZV90YWJsZV9sMl9p
ZHgoc2d0X29mZnNldCArIHNpemUpOw0KPiArCQljb25zdCB1MzIgbDFfc3RhcnRfaWR4ID0gcHZy
X3BhZ2VfdGFibGVfbDJfaWR4KHN0YXJ0X2FkZHIpOw0KPiArCQljb25zdCB1MzIgbDFfZW5kX2lk
eCA9IHB2cl9wYWdlX3RhYmxlX2wyX2lkeChzdGFydF9hZGRyICsgc2l6ZSk7DQo+ICAJCWNvbnN0
IHUzMiBsMV9jb3VudCA9IGwxX2VuZF9pZHggLSBsMV9zdGFydF9pZHggKyAxOw0KPiAtCQljb25z
dCB1MzIgbDBfc3RhcnRfaWR4ID0gcHZyX3BhZ2VfdGFibGVfbDFfaWR4KHNndF9vZmZzZXQpOw0K
PiAtCQljb25zdCB1MzIgbDBfZW5kX2lkeCA9IHB2cl9wYWdlX3RhYmxlX2wxX2lkeChzZ3Rfb2Zm
c2V0ICsgc2l6ZSk7DQo+ICsJCWNvbnN0IHUzMiBsMF9zdGFydF9pZHggPSBwdnJfcGFnZV90YWJs
ZV9sMV9pZHgoc3RhcnRfYWRkcik7DQo+ICsJCWNvbnN0IHUzMiBsMF9lbmRfaWR4ID0gcHZyX3Bh
Z2VfdGFibGVfbDFfaWR4KHN0YXJ0X2FkZHIgKyBzaXplKTsNCj4gIAkJY29uc3QgdTMyIGwwX2Nv
dW50ID0gbDBfZW5kX2lkeCAtIGwwX3N0YXJ0X2lkeCArIDE7DQo+ICANCj4gIAkJLyoNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmggYi9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5oDQo+IGluZGV4IGE4ZWNkNDYwMTY4ZC4uMmMw
MmQ2MWJhMGEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X21tdS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmgNCj4g
QEAgLTk5LDcgKzk5LDcgQEAgZG1hX2FkZHJfdCBwdnJfbW11X2dldF9yb290X3RhYmxlX2RtYV9h
ZGRyKHN0cnVjdCBwdnJfbW11X2NvbnRleHQgKmN0eCk7DQo+ICB2b2lkIHB2cl9tbXVfb3BfY29u
dGV4dF9kZXN0cm95KHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0eCk7DQo+ICBzdHJ1
Y3QgcHZyX21tdV9vcF9jb250ZXh0ICoNCj4gIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoc3Ry
dWN0IHB2cl9tbXVfY29udGV4dCAqY3R4LA0KPiAtCQkJICBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwg
dTY0IHNndF9vZmZzZXQsIHU2NCBzaXplKTsNCj4gKwkJCSAgc3RydWN0IHNnX3RhYmxlICpzZ3Qs
IHU2NCBkZXZpY2VfYWRkciwgdTY0IHNndF9vZmZzZXQsIHU2NCBzaXplKTsNCj4gIA0KPiAgaW50
IHB2cl9tbXVfbWFwKHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0eCwgdTY0IHNpemUs
IHU2NCBmbGFncywNCj4gIAkJdTY0IGRldmljZV9hZGRyKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfdm0uYw0KPiBpbmRleCAzOTZkMzQ5ZmI2Y2UuLjg2N2E0YTQ0OTU4YSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYw0KPiBAQCAtMjc2LDcgKzI3Niw3IEBA
IHB2cl92bV9iaW5kX29wX21hcF9pbml0KHN0cnVjdCBwdnJfdm1fYmluZF9vcCAqYmluZF9vcCwN
Cj4gIAkJZ290byBlcnJfYmluZF9vcF9maW5pOw0KPiAgDQo+ICAJYmluZF9vcC0+bW11X29wX2N0
eCA9DQo+IC0JCXB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUodm1fY3R4LT5tbXVfY3R4LCBzZ3Qs
IG9mZnNldCwgc2l6ZSk7DQo+ICsJCXB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUodm1fY3R4LT5t
bXVfY3R4LCBzZ3QsIGRldmljZV9hZGRyLCBvZmZzZXQsIHNpemUpOw0KPiAgCWVyciA9IFBUUl9F
UlJfT1JfWkVSTyhiaW5kX29wLT5tbXVfb3BfY3R4KTsNCj4gIAlpZiAoZXJyKSB7DQo+ICAJCWJp
bmRfb3AtPm1tdV9vcF9jdHggPSBOVUxMOw0KPiBAQCAtMzE4LDcgKzMxOCw3IEBAIHB2cl92bV9i
aW5kX29wX3VubWFwX2luaXQoc3RydWN0IHB2cl92bV9iaW5kX29wICpiaW5kX29wLA0KPiAgCX0N
Cj4gIA0KPiAgCWJpbmRfb3AtPm1tdV9vcF9jdHggPQ0KPiAtCQlwdnJfbW11X29wX2NvbnRleHRf
Y3JlYXRlKHZtX2N0eC0+bW11X2N0eCwgTlVMTCwgMCwgMCk7DQo+ICsJCXB2cl9tbXVfb3BfY29u
dGV4dF9jcmVhdGUodm1fY3R4LT5tbXVfY3R4LCBOVUxMLCBkZXZpY2VfYWRkciwgMCwgMCk7DQo+
ICAJZXJyID0gUFRSX0VSUl9PUl9aRVJPKGJpbmRfb3AtPm1tdV9vcF9jdHgpOw0KPiAgCWlmIChl
cnIpIHsNCj4gIAkJYmluZF9vcC0+bW11X29wX2N0eCA9IE5VTEw7DQo+IA0KDQo=
