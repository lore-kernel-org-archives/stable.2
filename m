Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1153CA86;
	Tue,  8 Sep 2026 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870796; cv=fail; b=Tum9TetxvJCdnN/kBF6JRkX/M+3EBZdKhQ4EooH6ZWbAV8j6n2PGNKtl6rOmoPRmVy0NmvDjaUetHWar0KnY/BPfQZl5wJPxJy60I+8i1kCgTaon7aG9C6BP7dwtU2fOoKQ4JHjxOz88w5SX1ScX32WzYrxVEaxXqdtA610nFGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870796; c=relaxed/simple;
	bh=2e8UEVMTs4Z05tgLfTTfUHlPrFdtJhFxroW1pveVbNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Az48+71+YZk3jNW1HavoZGeygdlwM4silT3T/l2nsjPDHBgchigdJoq2aV/NqcGRbPZ5krfkxRaFOk9I4SpMU9WhK+hLGQKRFe4xpvzfAZWMd+UetSifwWzTPYB+1quYuWvirk6jrSGyo1zHdw92tXrR54F4neHKsfIySOqHwUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=Z1S9DFLd; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=XyvesWh6; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="Z1S9DFLd";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="XyvesWh6"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688ABSGN2359579;
	Tue, 8 Sep 2026 13:32:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=2e8UEVMTs4Z05tgLfTTfUHlPrFdtJhFxroW1pveVbNI=; b=Z1S
	9DFLdZEPmtfbF2bob+PicorvX+01g9/dAeQpaL51mqnbmPssJ3p/ApiJOoz+HmJs
	Wn4tap3Iyk1dTZdMzTR0c33KSzYyK5XBaMHjlcaaYobclfyEoQT1BQmW40H3ew4X
	Q7mbhhxOyp7c3a+K1/8Op5xzaylEj9GPtkAKjeofjDVg2wwzjkmCVvt4SaSc4Kki
	Hy3NxjZsEI5+KlwixpfEhNnOWP9SLgXmDuWjP5Z+8ubB9bxyyPs42HDuUHvdlRs9
	4utbg3bAMe4Qey3vk5fgJFSTI3KJ+ystGJunSgxrcXEl2PFFHmQbFlT0hLdbDqM6
	XDhKnezNoayW8cc0+wg==
Received: from lo2p265cu024.outbound.protection.outlook.com (mail-uksouthazon11021072.outbound.protection.outlook.com [52.101.95.72])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gg9brjdep-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 13:32:41 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa/plcFQ2a9ucqkPfJNJXJ3JnsfCjvNBtxobguf0w3UDWrilQFrrQCUjs2Gm3I4iRfNQZURmJOInpswgd7Z35iI/lK3w+dOolQjewE8Nn5/KsvWJLd+zuwqeuvnpygRPUTIplCVX1hLUHi4X/H5yDD9/dkh+Drsb8XKKL4jRNhYA8eolFDlxZf4hD0cJxeowFAQBH047cQzoYof3hvfiSCgZkJEFurrU6yY0dzy3CkzFWW1Bl10YWELq88V1O0wG2jzeKIn7q4bO7Xu0cIwd3UkV9BrA7YKr+MS6irmv++4se9sUU9v9HJ7jhV69SnhjIlPbB+peFbNljrBRCp0o+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e8UEVMTs4Z05tgLfTTfUHlPrFdtJhFxroW1pveVbNI=;
 b=UHYkC0TP08mwhTZUIY2gQbjXZol9Ur8OR71DLy0sJ3+HrhWrev6Q+pwA3CV0dGK+OhJ56GCT6Oa2v64bzbZa308PvlzaOqoBtUBP2rCW1mq1NF4KDwi7R4W4kaQA2jxRlHHr03uua1TZr0jhWXQybbMRaIlD/pPUI5s6l1s3cmuur/+R1u+XeChLmlMzzI27Pb9aePcUoxUpFWfovpIgYvX+HNFIVYXaqcD5aTfVZROxlGyiPvRZ7TxrYO1TS06s10HNlfCmIZCAoF6NhpiMGSg3P5MV2cbodVIJUuGtYJOe9z7f+J/n12XDVP4eRX9MtyCsJfYEz+EMDYKDYp4WqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e8UEVMTs4Z05tgLfTTfUHlPrFdtJhFxroW1pveVbNI=;
 b=XyvesWh6XNSEoFNRR5aKO/vfzF0eiupbez3Z57Lcjtu7ldfJhpJPMbCffXQMBU6gOzzWx0Qj+lI7UvKlYnzeIDGyWpV62RcIq9tfNJPHTfOZ/KF/+OYtrxT1M/mz2InBrnda1cCwZjlllL9UDUGrv5Now5tBKevRIpYOg+ij1L0=
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d2::14)
 by LO6P265MB5968.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 12:32:38 +0000
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b]) by CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 12:32:37 +0000
From: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
        "tzimmermann@suse.de"
	<tzimmermann@suse.de>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        Alessio Belle <Alessio.Belle@imgtec.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
        "mripard@kernel.org"
	<mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/imagination: Fix page count for page table for
 map() interface
Thread-Topic: [PATCH 2/2] drm/imagination: Fix page count for page table for
 map() interface
Thread-Index: AQHdOsFP0WwKGQh2B0KmGSaX+zq8F7bEpr8A
Date: Tue, 8 Sep 2026 12:32:37 +0000
Message-ID: <94ae84cc542d3ce6dafc495c99144e64fb244aad.camel@imgtec.com>
References: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
	 <20260902-mmu_fix-v1-2-c55a23fb7cab@imgtec.com>
In-Reply-To: <20260902-mmu_fix-v1-2-c55a23fb7cab@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB2913:EE_|LO6P265MB5968:EE_
x-ms-office365-filtering-correlation-id: 2e1e3419-8dff-4698-9ba2-08df0da5443f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|10067099003|6133799003|9063799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 AYxMp97/6vrpOPjhVScP7jk/ZBBZryn/1137nCv+0UGGXSC9xt8WE0VCE2mMwDen/nu/oI0lcIswAOV2HVMgAHswDXw0qknPHxXSC4gdWHlFBhuk5AV7E0jRD6wE2cFF+mvrdkI3w0mBa5CIgCi+SliV4RWq1+K2poD+hM/6tEfrlzCtuh2JKoyJaqtp+bkyIq7eNSUSOz6ljVvst4fQYpyMHBv6ZrOKNh9wogfojnY5axtq0hDSSGR86l6FlRLq7z4cCdR5i4klRy2VbWg0pt+uSWwD31PTa1jmUjtMdT+2dbfByIIOPtNbmAvCIf6+y0+ogRXEPx6+uBoTKxkmO+uIjKItSaJvFlKlxyPnQneC+VwjrM9AVbX4DpJeyyjAR7Ax+mokxjiSb3nmz5WPd9BgrdtT5NEAJWm0emGkSBc9uAeyUBcAyFSfRdJHmgb2jfEnsbsBouX1ZmU4nCsEHY+7awTC5QNQliHo8WyqHGfRAbBPwEGchUI11XzX5Rdq+zoi7S0pgHQJBnV8ZKV/V7LLpqUOTnPJhcttKzMnUUXDaGYj1eaLZnlHHZ2YgMRdC0vTAwNP9VSdgMQnTI8yY6NahJvVMdPDQ/Cj4f1WsEwQcW2OqyYtFVgsEWLjlsir7tWLePgOctzon3id5roLLeOftutqhNXOxyX2HF205kiZfaiX0svILnkg6nhUUAdRihogIqFqUKXHE6bk2GuoE2RWTQhQDfJkoxnyhQuqRtM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(10067099003)(6133799003)(9063799003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym1JSVJvYkQ0eGVRL1Nwb2pFanIwdERIVExTSVhORithMXJvTklvZmlGRkhJ?=
 =?utf-8?B?MWZDcmV3UjZyemJ0bGlha3hpajBvZi9BaUpGZ3FlZ0hOb2hzWnZvbk5OaWdZ?=
 =?utf-8?B?OTA1aVlINUhraHdIWUY2c1l1SEtzWVh3OEtjSzJwVnJXUUZYWTRKeWphcUJj?=
 =?utf-8?B?VzZCUmdHN0NxeStZZzZ0bS9YWXZLTllyeTl3SlZuK1JXWVl0dkpER09NdHp4?=
 =?utf-8?B?Q3FCbE1MNVFJTUl1VENlQjE3dlhEY3JzT1l0bVNCRHN2alNzQUtuRStXRi83?=
 =?utf-8?B?ajJlM0pLYU1meHRnSi9Ba3FVdC96S2pZNWtyRUJHTHQzelYxQzJuWmE2bGpL?=
 =?utf-8?B?aHdJQlR5LzkrN3YzdFJyYytvZTdJeHArRDNWRklUdDVUZEFKOVcwSXU0MC8r?=
 =?utf-8?B?ZHV6OCtqK0ZiRStVOFdoNVNxOW1qZHBRajN4U3QzejJwTkxzWXZqcWVQZlpp?=
 =?utf-8?B?ZEtNNGNWUkIxODdTWEY4SlA1MXdYbXJFS0loQkhHNTFnd1BOVlJlblA5Rlpk?=
 =?utf-8?B?b28zY3dxWXdFTjNsU2dMUnFGd3RHZ1RpbE5QMWdtOEFaclZiTjU2MktRV0JE?=
 =?utf-8?B?S0g1SXdTaE02Qllsay9kT2tRdS9DT3lvZk1ZUkNLc2tDalEzWHoxUGQwcWc0?=
 =?utf-8?B?QjNQeG9BdlpkWU5iajZQdEdodEVUL3BJRWJ2cWZQYWFLTlN6Wmh6MXZhUCs0?=
 =?utf-8?B?WU42L01KKzEvNFlBdEFaWmpaSG9hT1JsalNOeS9ORkgvUllYQU9VZmFuTnFQ?=
 =?utf-8?B?c1hKNXo1SlhsbEpGOTU3aHdvQjZETG1XUkdZV1N3aFlKVmpDLzJPd0FVQUFr?=
 =?utf-8?B?MUZTemcrZUQwNVNVWVR5djZJL3hQL044Tmd3Z0J5WHl2c29PUmVRbkFqM3hn?=
 =?utf-8?B?ZGFSTXBwdkhNOXg2VnB4Y3NiTkdJNHRGcWVlaS9FZU9ZVjBSUWdTdzBha3FF?=
 =?utf-8?B?T1ZIc2FUcWNYL1JhNEpwWHpTMUJRT0tiSUo2T2lnbW4rRS90dTFPVWFUcnNq?=
 =?utf-8?B?NmY0RGwvd0NzeFFTNlpOeFF2RHY3S1dlanZBM3ZVSVFRZGlCaDhpRnNjRW1L?=
 =?utf-8?B?aWZhejRxWGVuMFUzTDlOYjdnM1FORzhpRTNZa1M1ZkFFcFVsRnhYOGdyRm9i?=
 =?utf-8?B?a3UvOHpwZUNTYTRXbFJSTHNnVmcyTTg1MEdCNXYvN05KeUJybkl3VlZFR3h3?=
 =?utf-8?B?YTBLV3RjcXNhQm9TTEJSYU42bk9ENUsrNXpWTE50U2l1N24xYzJOY2QzVi8v?=
 =?utf-8?B?c2JvVjZNV1VwMWlnaTg4MHRiR0hRYXI1TG5VTDBEZjkyeWpQb1ZXYzg0TXIy?=
 =?utf-8?B?QzIvOGN4MStob004N0xBejhYQXEvQVZ4M1g1MWhZTFBxTkp3SHFwbmdHVTNF?=
 =?utf-8?B?ZEFGQkZVWFZwM3E5TkVDNUxZa2NyL2tjMnl0UU8rU05BZEpVWFBrblJmSkVn?=
 =?utf-8?B?UEwzMWVwclVuVWw4ZWQxRTQ0eVNnU0xmMm1YRjgvcmtJOTFFbVBvbjlUckJ4?=
 =?utf-8?B?NDR0amdRbHU0L1RYZDB1OEZjdVhuc2lCK29wY01WZ2RQajArYXBvZDJNZS9G?=
 =?utf-8?B?dnJGaGtrMEFVZWMzSlZwMXVvK0habTVjZXFyVHRyWVIzUHE4UWx1aHUxaHQv?=
 =?utf-8?B?SDAxcjFJTlM2Q1NYM2tKUVZ2WTFnSHlVT0tHckt6d2VlUnRUSzhJam94Z0Rp?=
 =?utf-8?B?dDArM0w3RkE2QTlZOEl5TXo3VUpQRk91VHh5Qnk2ZXVCM2VSWFc2bzhrQnAw?=
 =?utf-8?B?SGZMaEp5K3JjVU5COXhoemVzaE8rcFhleXhJeTh4T3AwYk9ySitSMjZ6a21R?=
 =?utf-8?B?RURoUGFwY3pJdnVMM2VqM3J6cVQvK0t2R0FkU0dwNzAyVlhKKzJaM3ZyRkFr?=
 =?utf-8?B?Z0dmYzRVQ0xtWlo4ZVRVRzgrc1o4amc0UVhvTDZ1UVk1YTcxUHlXQjh6cE9N?=
 =?utf-8?B?WWNoSnNtemFVcm4rK0hOeklPendWSDdqTTNBTEtrUHhDd09IRHlVRGVuQytH?=
 =?utf-8?B?WXZhSnp3ejBoQXIxUGRnb2t6cXZkMXNxTzRyTGhzWDBDRzlEa284YTF4VGRs?=
 =?utf-8?B?NVphVVg3S2x5MUlYVGkwWnpNODE4c1o5SUhteThLNWFlZzNhWEM4UXluVzdG?=
 =?utf-8?B?Qk1SK05yL3dMV0U1MGVuWkFyNFBYMkhxbzNsZzMwNDIzM1ZxZ3EwRHl0ZmRq?=
 =?utf-8?B?a0swbFJxWFVkZXdYRDk5WCs4UFl6U3h6K2F3djB4bThDdmtOR01zcHJkbnlx?=
 =?utf-8?B?MHNHb25aTGhkSzFaK3pzMXVuRDkxTGFZdnlKaENRb2U4TnZtdTRBeGR2UlN6?=
 =?utf-8?B?NStic2VSZFRCUUdUcTlWVmMrVzFCdG00TjFUNGFhM2hMMGtpdkhTU21Ta0Fa?=
 =?utf-8?Q?EgnFOPkJKcgpj0SE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <471BE3F6C0A5364296C987151876BDA3@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SwRpbnJdoIdS1Om8ZURmHdP+qiORqUHKTCbRSR+UFFaweE64G1gY9o6OWmoiB0XkpSNwRU8oIuLxjqDg4aM8cLTZMWL0taJoP4ZFPUN3DiboMZXo3SHQYiH4KcQKeLluGCgauztSbysYvd+EW4bA99J4pgzJipEZyoegAietc1EGRk1ZxiLqRjaSMVt3qtfJqLBEjeDEX2xznzrSh0cCux5YcP39Ue12vc4IQzpUmY5iwBU2x2e+yPADKoqLEmQhkHBWJ+lG8ogamim9db8xrpIfdTlry1VDSItHIGihVTnQTdgIff5FWilxHhxPpvJcakB0mS8XJmbDYC6ensrgrQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1e3419-8dff-4698-9ba2-08df0da5443f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 12:32:37.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFf2cjbKlHF5VBvF0LV/xqjZwEUo5zzBoepKq8V1eRTCMNGfiludTOXxYZX6qJVGkK7QIq5UQzxL7NpbZ9oacRbs1AXTKbu+7dIGwkuA14Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB5968
X-Proofpoint-GUID: 4ygc8xVFrdSdLFnHUm5rC18h4Kz1k68a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEzNCBTYWx0ZWRfX/NCTAGhVvElj
 vkRMLVmqiav2+qwE4Ye7t9GH5+3PFHYBJvTiOArRw6yHusYTXm8SwAVhZGPRvTzYwqu0PLb8ZgD
 kqCLs5mKeR5bO3a4gHnUG8lCIxriw5Xe/qaOXc5qzfsPqNpWTw1A4WZTikYKOpTuaWMZ7nfqY3V
 kXcrT1IMqo/SUdzjdwaZWwUV2/95+sVzOXj2s3NVcPAtVy5Xxbkod2QZEkmGiwzX9Z7h3zN6y8f
 4/ePZhgLfrczxWP/4pS8ZjvfecE13sPLKiAFAcmhOBi9HDlcGFRrwY7P1/PJwDYRlZRjetKs8Ey
 kxyuwF/GX2kHlByvOiCn972u11H4jXvW4hK0okbzqrsIDWxh+U7JGKvKRlGFKsnqICUHX4Lph+p
 2B9r7oMU9rxnGuczNi/Var03LvYGQOmnGvFVMseDlh3JLmer8Dlg0rYiunlMKKPoishjmGGomna
 MUmyXhpIktTGFXaPAIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEzNCBTYWx0ZWRfX+cZE1diJ1mjh
 FxmTL0HgZ08Mw4MWPAK9wpZlDXEQTEaeEklRYFdRxNH57u6E0EmWbppjRR9K34KDoxji5ivrtwL
 4PYmbIgl/hHMCrqftLEgKNM1egOZENM=
X-Proofpoint-ORIG-GUID: 4ygc8xVFrdSdLFnHUm5rC18h4Kz1k68a
X-Authority-Analysis: v=2.4 cv=ePQbHnp1 c=1 sm=1 tr=0 ts=6aa00069 cx=c_pps
 a=MehfaShGWuQHChpsOzY9/g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=MP3e3iAGoLiz7Vb86GUA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE1OjI1ICswNTMwLCBCcmFqZXNoIEd1cHRhIHdyb3RlOgpI
aSBCcmFqZXNoLAo+ICoqKiBOT1RFOiBUaGlzIGlzIGFuIGludGVybmFsIGVtYWlsIGZyb20gSW1h
Z2luYXRpb24gVGVjaG5vbG9naWVzICoqKgo+IAo+IAo+IAo+IAo+IEdQVSB2aXJ0dWFsIHN0YXJ0
IGFkZHJlc3Mgd2Fzbid0IGluY2x1ZGVkIGluIHBhZ2UgY291bnQgZm9yIHBhZ2UKPiB0YWJsZQo+
IGNhbGN1bGF0aW9uIGZvciBtYXBwaW5nIGFuIEJPIG9iamVjdCBpbiBtYXAoKSBpbnRlcmZhY2Uu
IEl0IHJlc3VsdGVkCj4gaW4KPiBtYXAgZmFpbHVyZSBsYXRlciBkdWUgdG8gbm90IGVub3VnaCBw
YWdlcyBhdCBMMC9MMSBsZXZlbC4KPiBVcGRhdGUgcHZyX21tdV9vcF9jb250ZXh0X2NyZWF0ZSgp
IGludGVyZmFjZSB0byBwYXNzIGRldmljZSBhZGRyZXNzCj4gYXMgd2VsbAo+IHRvIGFsbG93IGNv
cnJlY3QgY2FsY3VsYXRpb24gZm9yIHBhZ2UgdGFibGUgbWVtb3J5Lgo+IAo+IE1pc2NhbGN1bGF0
aW9uIG9mIHBhZ2UgdGFibGUgcGFnZXMgZm9yIG1hcHBpbmcgYSBCTyBzdGFydGluZyBhdCBhCj4g
ZGV2aWNlCj4gYWRkcmVzcyAweDgwMDFiNDUwMDAgb2Ygc2l6ZSAweDhjYTAwMDoKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9sZMKgwqDCoMKgwqDCoCBuZXcKPiBMMCBjb3VudMKgwqDC
oMKgwqDCoCA1wqDCoMKgwqDCoMKgwqDCoMKgIDYKPiBMMSBjb3VudMKgwqDCoMKgwqDCoCAxwqDC
oMKgwqDCoMKgwqDCoMKgIDEKPiAKPiBGaXhlczogZmY1ZjY0M2RlMGJmICgiZHJtL2ltYWdpbmF0
aW9uOiBBZGQgR0VNIGFuZCBWTSByZWxhdGVkIGNvZGUiKQo+IFNpZ25lZC1vZmYtYnk6IEJyYWpl
c2ggR3VwdGEgPGJyYWplc2guZ3VwdGFAaW1ndGVjLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvZ3B1
L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMgfCAxNCArKysrKysrKy0tLS0tLQo+IMKgZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuaCB8wqAgMiArLQo+IMKgZHJpdmVycy9ncHUv
ZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jwqAgfMKgIDQgKystLQo+IMKgMyBmaWxlcyBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jCj4gYi9kcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX21tdS5jCj4gaW5kZXggMTc1ZjBiYTRkOTkzLi41MmQ4ZmJjMDAzODQgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmMKPiBAQCAtMjMzNiw2ICsyMzM2
LDcgQEAgdm9pZCBwdnJfbW11X29wX2NvbnRleHRfZGVzdHJveShzdHJ1Y3QKPiBwdnJfbW11X29w
X2NvbnRleHQgKm9wX2N0eCkKPiDCoCAqIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUoKSAtIENy
ZWF0ZSBhbiBNTVUgb3AgY29udGV4dC4KPiDCoCAqIEBjdHg6IE1NVSBjb250ZXh0IGFzc29jaWF0
ZWQgd2l0aCBvd25pbmcgVk0gY29udGV4dC4KPiDCoCAqIEBzZ3Q6IFNjYXR0ZXIgZ2F0aGVyIHRh
YmxlIGNvbnRhaW5pbmcgcGFnZXMgcGlubmVkIGZvciB1c2UgYnkKPiB0aGlzIGNvbnRleHQuCj4g
KyAqIEBkZXZpY2VfYWRkOiBWaXJ0dWFsIGRldmljZSBhZGRyZXNzIGF0IHRoZSBzdGFydCBvZiB0
aGUgcmVxdWVzdGVkCj4gbWFwcGluZy4KPiDCoCAqIEBzZ3Rfb2Zmc2V0OiBTdGFydCBvZmZzZXQg
b2YgdGhlIHJlcXVlc3RlZCBkZXZpY2UtdmlydHVhbCBtZW1vcnkKPiBtYXBwaW5nLgo+IMKgICog
QHNpemU6IFNpemUgaW4gYnl0ZXMgb2YgdGhlIHJlcXVlc3RlZCBkZXZpY2UtdmlydHVhbCBtZW1v
cnkKPiBtYXBwaW5nLiBGb3IgYW4KPiDCoCAqIHVubWFwcGluZywgdGhpcyBzaG91bGQgYmUgemVy
byBzbyB0aGF0IG5vIHBhZ2UgdGFibGVzIGFyZQo+IGFsbG9jYXRlZC4KPiBAQCAtMjM0Nyw4ICsy
MzQ4LDkgQEAgdm9pZCBwdnJfbW11X29wX2NvbnRleHRfZGVzdHJveShzdHJ1Y3QKPiBwdnJfbW11
X29wX2NvbnRleHQgKm9wX2N0eCkKPiDCoCAqLwo+IMKgc3RydWN0IHB2cl9tbXVfb3BfY29udGV4
dCAqCj4gwqBwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHN0cnVjdCBwdnJfbW11X2NvbnRleHQg
KmN0eCwgc3RydWN0Cj4gc2dfdGFibGUgKnNndCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU2NCBzZ3Rfb2Zmc2V0LCB1NjQgc2l6ZSkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU2NCBkZXZpY2Vf
YWRkciwgdTY0IHNndF9vZmZzZXQsIHU2NCBzaXplKQo+IMKgewo+ICvCoMKgwqDCoMKgwqAgdTY0
IHN0YXJ0X2FkZHIgPSBkZXZpY2VfYWRkciArIHNndF9vZmZzZXQ7Cj4gwqDCoMKgwqDCoMKgwqAg
aW50IGVycjsKPiAKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICpv
cF9jdHggPSBremFsbG9jX29iaigqb3BfY3R4KTsKPiBAQCAtMjM2NCwxNiArMjM2NiwxNiBAQCBw
dnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHN0cnVjdAo+IHB2cl9tbXVfY29udGV4dCAqY3R4LCBz
dHJ1Y3Qgc2dfdGFibGUgKnNndCwKPiDCoMKgwqDCoMKgwqDCoCBpZiAoc2l6ZSkgewo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogVGhlIG51bWJlciBvZiBwYWdlIHRhYmxlIG9iamVjdHMgd2UgbmVlZCB0bwo+IHBy
ZWFsbG9jIGlzCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGluZGljYXRlZCBi
eSB0aGUgbWFwcGluZyBzaXplLCBzdGFydCBvZmZzZXQgYW5kCj4gdGhlIHNpemVzCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGluZGljYXRlZCBieSB0aGUgbWFwcGluZyBzaXpl
LCBzdGFydCBhZGRyZXNzIGFuZAo+IHRoZSBzaXplcwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogb2YgdGhlIGFyZWFzIG1hcHBlZCBwZXIgUFQgb3IgUEQuIFRoZSByYW5nZQo+
IGNhbGN1bGF0aW9uIGlzCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpZGVu
dGljYWwgdG8gdGhhdCBmb3IgdGhlIGluZGV4IGludG8gYSB0YWJsZSBmb3IgYQo+IGRldmljZQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYWRkcmVzcywgc28gd2UgcmV1c2Ug
dGhvc2UgZnVuY3Rpb25zIGhlcmUuCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ki8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1MzIgbDFfc3RhcnRfaWR4
ID0KPiBwdnJfcGFnZV90YWJsZV9sMl9pZHgoc2d0X29mZnNldCk7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29uc3QgdTMyIGwxX2VuZF9pZHggPQo+IHB2cl9wYWdlX3RhYmxlX2wy
X2lkeChzZ3Rfb2Zmc2V0ICsgc2l6ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29uc3QgdTMyIGwxX3N0YXJ0X2lkeCA9Cj4gcHZyX3BhZ2VfdGFibGVfbDJfaWR4KHN0YXJ0X2Fk
ZHIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHUzMiBsMV9lbmRfaWR4
ID0KPiBwdnJfcGFnZV90YWJsZV9sMl9pZHgoc3RhcnRfYWRkciArIHNpemUpOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1MzIgbDFfY291bnQgPSBsMV9lbmRfaWR4IC0g
bDFfc3RhcnRfaWR4ICsgMTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1
MzIgbDBfc3RhcnRfaWR4ID0KPiBwdnJfcGFnZV90YWJsZV9sMV9pZHgoc2d0X29mZnNldCk7Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgdTMyIGwwX2VuZF9pZHggPQo+IHB2
cl9wYWdlX3RhYmxlX2wxX2lkeChzZ3Rfb2Zmc2V0ICsgc2l6ZSk7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29uc3QgdTMyIGwwX3N0YXJ0X2lkeCA9Cj4gcHZyX3BhZ2VfdGFibGVf
bDFfaWR4KHN0YXJ0X2FkZHIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0
IHUzMiBsMF9lbmRfaWR4ID0KPiBwdnJfcGFnZV90YWJsZV9sMV9pZHgoc3RhcnRfYWRkciArIHNp
emUpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1MzIgbDBfY291bnQg
PSBsMF9lbmRfaWR4IC0gbDBfc3RhcnRfaWR4ICsgMTsKPiAKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLyoKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9u
L3B2cl9tbXUuaAo+IGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuaAo+IGlu
ZGV4IGE4ZWNkNDYwMTY4ZC4uMmMwMmQ2MWJhMGEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9pbWFnaW5hdGlvbi9wdnJfbW11LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2lu
YXRpb24vcHZyX21tdS5oCj4gQEAgLTk5LDcgKzk5LDcgQEAgZG1hX2FkZHJfdCBwdnJfbW11X2dl
dF9yb290X3RhYmxlX2RtYV9hZGRyKHN0cnVjdAo+IHB2cl9tbXVfY29udGV4dCAqY3R4KTsKPiDC
oHZvaWQgcHZyX21tdV9vcF9jb250ZXh0X2Rlc3Ryb3koc3RydWN0IHB2cl9tbXVfb3BfY29udGV4
dCAqb3BfY3R4KTsKPiDCoHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKgo+IMKgcHZyX21tdV9v
cF9jb250ZXh0X2NyZWF0ZShzdHJ1Y3QgcHZyX21tdV9jb250ZXh0ICpjdHgsCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc2dfdGFibGUg
KnNndCwgdTY0IHNndF9vZmZzZXQsIHU2NAo+IHNpemUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNnX3RhYmxlICpzZ3QsIHU2NCBk
ZXZpY2VfYWRkciwgdTY0Cj4gc2d0X29mZnNldCwgdTY0IHNpemUpOwo+IAo+IMKgaW50IHB2cl9t
bXVfbWFwKHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0eCwgdTY0IHNpemUsIHU2NAo+
IGZsYWdzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1NjQgZGV2aWNlX2FkZHIp
Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMKPiBi
L2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYwo+IGluZGV4IDM5NmQzNDlmYjZj
ZS4uODY3YTRhNDQ5NThhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYwo+
IEBAIC0yNzYsNyArMjc2LDcgQEAgcHZyX3ZtX2JpbmRfb3BfbWFwX2luaXQoc3RydWN0IHB2cl92
bV9iaW5kX29wCj4gKmJpbmRfb3AsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gZXJyX2JpbmRfb3BfZmluaTsKPiAKPiDCoMKgwqDCoMKgwqDCoCBiaW5kX29wLT5tbXVfb3Bf
Y3R4ID0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdnJfbW11X29wX2NvbnRleHRf
Y3JlYXRlKHZtX2N0eC0+bW11X2N0eCwgc2d0LAo+IG9mZnNldCwgc2l6ZSk7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcHZyX21tdV9vcF9jb250ZXh0X2NyZWF0ZSh2bV9jdHgtPm1t
dV9jdHgsIHNndCwKPiBkZXZpY2VfYWRkciwgb2Zmc2V0LCBzaXplKTsKPiDCoMKgwqDCoMKgwqDC
oCBlcnIgPSBQVFJfRVJSX09SX1pFUk8oYmluZF9vcC0+bW11X29wX2N0eCk7Cj4gwqDCoMKgwqDC
oMKgwqAgaWYgKGVycikgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaW5kX29w
LT5tbXVfb3BfY3R4ID0gTlVMTDsKPiBAQCAtMzE4LDcgKzMxOCw3IEBAIHB2cl92bV9iaW5kX29w
X3VubWFwX2luaXQoc3RydWN0IHB2cl92bV9iaW5kX29wCj4gKmJpbmRfb3AsCj4gwqDCoMKgwqDC
oMKgwqAgfQo+IAo+IMKgwqDCoMKgwqDCoMKgIGJpbmRfb3AtPm1tdV9vcF9jdHggPQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUodm1fY3R4
LT5tbXVfY3R4LCBOVUxMLCAwLAo+IDApOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHB2cl9tbXVfb3BfY29udGV4dF9jcmVhdGUodm1fY3R4LT5tbXVfY3R4LCBOVUxMLAo+IGRldmlj
ZV9hZGRyLCAwLCAwKTsKPiDCoMKgwqDCoMKgwqDCoCBlcnIgPSBQVFJfRVJSX09SX1pFUk8oYmlu
ZF9vcC0+bW11X29wX2N0eCk7Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKGVycikgewo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaW5kX29wLT5tbXVfb3BfY3R4ID0gTlVMTDsKPiAKPiAt
LQo+IDIuNDMuMAo+IApSZXZpZXdlZCBieTogQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRydS5kYWR1
QGltZ3RlYy5jb20+CgpUaGFua3MsCkFsZXhhbmRydSBEYWR1Cg==
