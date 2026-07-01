Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399034AB00;
	Wed,  1 Jul 2026 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929808; cv=fail; b=iUml6szgtnK4xghVIYd41CJAepJTvyuwFN1sy2XagEAPaZzLWK5BIsqwp2Ae5WouKHxu8Piqebu/LTK4KmaRkE6Drfao9pzLJQ+8IiuyOk5D+ZBPK/nUNiRU1+pnCnm9uGEPr+fNbT8RgzbLplC7JR6vbnKH/iu/R5K+w4PBHOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929808; c=relaxed/simple;
	bh=3SsGnhvwKZ5q/5jY6SxWw0neHxylMF9ntvgrybqqtDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XWN1s6eT3W63PM0UpPFFfMo0mDw2wiv8GuKgDSaeE8MXCm58wQkQtK9o+TuFgpr4le/VaXNMfWj2+70ytqY09N/jPJAAq/wlNlPpks6yFJ+oA40uLW/XWv2Qcetlpyn3HSFGDOG00dBP6EJpMJZRMECVDCUpAdXS2DMje+w1ZxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=WIXpu0hT; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=q959AWzM; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="WIXpu0hT";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="q959AWzM"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661HkBT8557878;
	Wed, 1 Jul 2026 19:16:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=3SsGnhvwKZ5q/5jY6SxWw0neHxylMF9ntvgrybqqtDI=; b=WIX
	pu0hTmAI2NuCY8CZj91jyLU97mb2dDKE7vWpFzsnLqXwzknBE/4uEqsgn1zz+Mop
	kznhkFNj0gTcvOd+IM0YF9BYCUP6Zvkm1yW0qj/ObgYmsurt3JHaAr+Ya/7AGCZ+
	KkN47BKX7VOIX4f/jUVcAoz25kTLcFcmZbEUQfZe0bc6x2BJsARu7JQQfnOa5F0d
	zjTT1cbwVGGrXAjRnPF1srzIT80JNZiAkRl0VoFt1CeKI4I0LCXVpOj7Si/u6/Kh
	Q0sS30gQFRQc/oQLHX8oCnHlI24kVlxsD4eVFDDfmbaop1SFnjBpuyf8jTGXyy52
	J7gpT8nGR+HDM2R4abw==
Received: from lo3p265cu004.outbound.protection.outlook.com (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snv6nt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 19:16:21 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPUzZDWQUNACNB1OP8s6gkc0WDGfH/bOHRIZGLxBGYLAolk6APHYz3hsYRT77EWEfnPmBvo32pE5stfyOyCJXQUZD0lnNjU4UqmRstlLDITcKeuc1zBvKbobQvJx3IXK+qKad+AKXcnV35VwoiL2Wdi3kfFIw6Fe9+kHcEMTG9bmb2EntZMQOMp6p6/7FMOUMYr8TusC1qkZv697N7DYrrxNUwD63V4BXoR4IoLwxjxB0K/a5dNmOMhUsS3uDEFcuNWn9Rc2s3+Yg+re5PifZtw9Bf5jtL9QTwvDvnrFIbZoJRSmVKC6CiWFi6sps9u3+3iJzztOqSawMo4mtiMOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SsGnhvwKZ5q/5jY6SxWw0neHxylMF9ntvgrybqqtDI=;
 b=GPCPLoRshw0kVG3obKr6FInIYntOK1GaFy9xIVtyJGtCIGiD1cXWwqNrseIWj7OPg84UxjScFmNAtAgzVS2M/r2SBuatMW3mrXre9J9sH47kT/F4wXCviq5D/JPc7j1Tgy6LkFzzdMplyvdPmjU7ac2NP1HjIGYGGBREklOj/JDlqphNFHqpDDHV7JBXDdN+eZmsi0CrX3/n7Oa8mWBV4gK64YckSVkzqL7IGjMa4/Z6+6rMy1dMu0GuAtSeO/1lFm7OPCLK39xjedWp4680P+MAyfJwRk1go/ULyHxYjCOEtrHt+RiRTHQC2d14LMU+C1whnx2WErDaUWNoBQaDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SsGnhvwKZ5q/5jY6SxWw0neHxylMF9ntvgrybqqtDI=;
 b=q959AWzMtamD7AIv6dDchFOALynmBmtL5Jlix7i7GKtT/GRo0QQyS7ZwPIq3ZH9QU48IRxrOgWfByguVr50MynyWkXxXwWjBf7ZDoITAk7ALyvpr4pRGxA7elsvk/AxpOBtchUS1crkGJa19DLRi0SaJ7vUTH0+bT7Nme4lFPyo=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO9P302MB1953.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 18:16:18 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 18:16:18 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "shuvampandey1@gmail.com" <shuvampandey1@gmail.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "donald.robson@imgtec.com"
	<donald.robson@imgtec.com>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
        "airlied@gmail.com"
	<airlied@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Frank Binns <Frank.Binns@imgtec.com>,
        "sarah.walker@imgtec.com" <sarah.walker@imgtec.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: Fix user array stride in
 pvr_set_uobj_array()
Thread-Topic: [PATCH] drm/imagination: Fix user array stride in
 pvr_set_uobj_array()
Thread-Index: AQHc/RBq3/nIwfl5q0man2EQXCkArLZZEUeA
Date: Wed, 1 Jul 2026 18:16:17 +0000
Message-ID: <0e06638962a5273bc6dd1639ab2fa7092d8a8a5c.camel@imgtec.com>
References: <178155996993.4848.8618351576278880213@gmail.com>
In-Reply-To: <178155996993.4848.8618351576278880213@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO9P302MB1953:EE_
x-ms-office365-filtering-correlation-id: 1967d7dd-032b-47fa-5d0b-08ded79cd848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 B8ANT+LIEJWoLZtcpfhi9D3uA0gsZbJYId/NxR4MVLmOy7BZhbpRPNYDKnYxsTdU/L3FyCgA9RLKXjEDhWyKMYUJbGyjuU5wT1f9od/T/dDzmokafuo2b7N+5F3mNWWn/fJ8cAy9TL3loGZqVeqHK4J5ASRzcY1w80IyB/qwP63rO88yQZPluQtigtKqXnKpcIqTS7BzpYTXq309QedEMtq2ThQ3fj7Nvczqwwr47ly3spTAn22jAFBaoC4VDbDeIz/0rk1rcvCmoYi54oGorQsFqwQMb0y836jfBcVBiudMJmBjU/WdpGS6Q2o3iUqE8xCeEiVxzkPMz5ke45Eiqa+lURIW151gtiEPsz2qON/Df6S1LTvyArnTjLomhzEdxUza7n/z1u1xZn3rcE8S4Gdhq/lKWw0iCiFLNU+8YxzpWOQu4+O540B/LBjXRao2H3XbzsaCV3ZJrHRhyaahEy1NdDzLkIpRg0smwmhVFsX5QTNPg05km8gDG/6gY5vcGnwvHPl4QCtoRfbebqL/1Qv3FuG3t4qqi1r4zoiHyQTqP52Esk9qlu/eZ/wUpk+atY8DFgVuulC7nDR6hFsB4tTtVOS/fv448mWAIeapVC2CXNNV8JEztikB0EmS+Rpeh5v+bwyc6cv3OPTV/Aikv65/1HtGn+geA1aOmZlg3QwqHwbq6rYKVBk/nw2N5216i3zoUnarpw4QjU0RRsdE9LByCr93cLPb4ADK4JpOpoA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFd0bC9QSkdqWldVQUIreG9wbXh0em9NNDFNdzVYUThReXdTeFo4RGkxVEJZ?=
 =?utf-8?B?K2xGdjJHTVNvcHNiZng4OUFYenp5VmV3dDdnZkJDMVBaZkE0UVZEYitOSFNX?=
 =?utf-8?B?ZXJXOTFNMjdZcE1TQnZVTW5CRWEwbjVTeGF0YkZYSmE4aXRwZHBKRG5DVEhi?=
 =?utf-8?B?aUd4bzdxUXI0YjRrdDJBMS93cVU3YTVtbnhsQTBNVlFsREVBdU9FSm16ZE5S?=
 =?utf-8?B?VFpQSzJuR3BhYkxqbUFqWnVoZlJiaStkaWRUd0l2NU5Pcm5kbWM4N1NySHp2?=
 =?utf-8?B?TDhWQlZsQmZ4Vm0xemtuTTdEbWxUN2RPTHBPdVRQUG1HSTZhekRtWW91ZjdM?=
 =?utf-8?B?dVlpRStVTUQvV2J6SUZoWXBBelVuSkl0SGR6YkZJNU1xVFRSM3RZTkIvRXU3?=
 =?utf-8?B?TzR4c2Jza1FheHVackIvbnRZRHBUT1FTc1pYQm1ZNkN2RFhud0VsQmlLNHdk?=
 =?utf-8?B?b2wzeHMzaEhKZjJwT0xHeGNSdGtvYUM3dWtOM3JoY3YwNnZDSlpTQ1RySytl?=
 =?utf-8?B?Z2QxSHplREFGdHdrN0o2anZnTEV3SFlpbUdSM3Bka2NEOHpRTFZlSFF3UlQr?=
 =?utf-8?B?OUdjRFdHQWtqN0VkRFd5WktsdGh0RDQzQmh5aVBraE9reG1rbE93ZUhJcldQ?=
 =?utf-8?B?UjB3bjFyR29JbkdLN3ZLV2dSZUI3bi82WEE2bUk4ZlpmV2hWUGFrUkd0Snl5?=
 =?utf-8?B?VzRWRTlsbmowM1BUUkxXb0RoTjZxL0ZwMzdPTzA1STR5WkwvNnZvRWp0dEE3?=
 =?utf-8?B?M0RQUlI3Q3dselhKbmhJaXdoRytJV29QZXZxdlJQNlBYSXZabUJOa0dlcVZ3?=
 =?utf-8?B?RzJPTUNmeFI1alJkNVZhckVRV3VuYTR4L3ZReEhRNkFuM1U2V3gvWk9BR3Ro?=
 =?utf-8?B?R0xoS1BybUZydkdvdkI1c1F4bWJyckczNEpRVUpaRkJ3TC9pMWxqYUpjLytO?=
 =?utf-8?B?MUI3QjhHMXNIdFd2OXBvSkMxQnJxdHRuK0Z0MktDK2lMbXZxWFJLQWdrVUFE?=
 =?utf-8?B?U0U4Zy9TbWthV3Q0RlRHUWVnakx5b0pXTzNBOHpocEFTYjNLemphVmVuWmFQ?=
 =?utf-8?B?dUxiM3NPMEU4RWZDbktNeWxFdUxnVjBRTnNjNy95dVNwakFNN1dzYzRPeUd4?=
 =?utf-8?B?bDE1bUo5NlpjbUE5S3FQb0xXU3JhbEZIRXVtbEFiSm5PNkl6bWxUVVVTVHY5?=
 =?utf-8?B?Tm02Q3lGdWxTL0RwekgwZVo2ZDBOWnA4MXBiTW4xbVFNblVhK2V2T2lyVjF2?=
 =?utf-8?B?bEF0Qnk4TjE1SkgyODNqU0xJV2VlMXlLUXNTYWsrWllaZlFzZk51R28ycWJp?=
 =?utf-8?B?TmVRVkMzUCt2WEdvM05sREFFckVRVmx1UEZhT2ltb1V1N01jbEVqZlhRWUxV?=
 =?utf-8?B?N2tqVjFhanlhNUV2YldRa1daUE9QYXRXQTM2MjdhS3N3L2loMTUrcGJyWXRh?=
 =?utf-8?B?TlV4S2R5MENZTysxa1hhb094aXBXeGM3K3lYV0ozMEVUbm10cUl6NTJIamxF?=
 =?utf-8?B?WnZ2QXI1bGdRd2dzeVprZUtSbnpXL2xDU3dxcTN6elZxZWRRNVVNOG9od1dG?=
 =?utf-8?B?OVJ0bWZvUWxHZk9wd3BOZmoxaCttdEZMUzVoc2FGM3dEMVJMVWVQNFhYdXc5?=
 =?utf-8?B?ek9MRHI2K1lOaDdobnhURndIOHVic2U2Y1d6NnVyRVB2T0ZXcmpnb3R3b1Vk?=
 =?utf-8?B?bmtBK1U3bVo3RHp2SjVzb0t3S1RHcWJSOVdCcUswRDBGUktrT2owZ2tEem9V?=
 =?utf-8?B?YzM2cldwdlpTQjZxTC9JZHNzQzdjcnpwcHlGYVk3WldTUUYrajdUZU9ZanNK?=
 =?utf-8?B?d2p4WVVIOURxUDFRcmllMGNydGpCZmU2Uy9oQ3VnVGxkVlMrSTRUSjVBNHRn?=
 =?utf-8?B?TWNENEdjcFFFbnRPRHFQN056UmVRK2JXVjVJOG1OVEJHSTd3Y0QxczlzYzN6?=
 =?utf-8?B?WlRLaE9LMlBvQTVWS2UxdElwcWZiQUx6aSt2ejIrV0ZCSmM4eHhLK0l0MHN5?=
 =?utf-8?B?dVVyaVFaN3Z0Yk41MHJCbFdvMjJMbXBrWmZOa0pHY041QUFZQ3ZHTFVaaU1o?=
 =?utf-8?B?a0ozWUEvZk1VUWNNbzhlZUZkMmNvYndJRUk1Y3ZVV1VoR0M5Zy9SNUY0NXcx?=
 =?utf-8?B?aksrem1JczkwTTd5aUQ3Q3lndkR4T1NJRXkwQXFDNUsvOWIycEd4RldHdkZF?=
 =?utf-8?B?dUJyZXpmYUdrZ1R6REttK0JMb2ZPUWtKYUQvcnNGQXhWYUR5RDkwbXVJUFY5?=
 =?utf-8?B?QkZzVkVFQmZUZTE2MXZNcmkzUUsvS2c5dWJtcmN3bnNwWEwwaXdTSm5QQ2tM?=
 =?utf-8?B?L2R2TExYSTQrQnA4bDg3cFBqWm5xTkJKNkhzRDV1TE9NbkIzUTIxY1dvT2Iv?=
 =?utf-8?Q?bsWW6ML1eN893BH4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89F860297570F34D8892A93B9ED87401@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lTD5l39KdZGQcZJneMDeGkJWJJXV6HA/RMstO/ebN4tYXA3axtYzzKz6qETAYWhfJJ3zm+PpUpNRTpj261Hf3ET2dewdbLasNSBWwDOdYtiSw1NG+oj5WhI1FOJ/uRk0rS2qB2y4TKsvl1ndn11spYJZLBBoaCn2DC68YOVVFENQyir3GLC1w+Fo/U7u0VawvIC5CNJ0je6ZvYCk1E7Qn6bsKGWVtjnjgqGCmuHSAqFbKQwWJebkX02XO41onqDmXJYcui2XPlIqB9ju08PPLogIO5uQ6em/wnKpUxTXzstzkxB1qDyDivRX074BERaY7J03n/CNJcEdaZ0zpW77tA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1967d7dd-032b-47fa-5d0b-08ded79cd848
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 18:16:17.5739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyiXdtn0GqswTHeBhAothQG08YPEsXvMFIkaMdYQ5erf0kY2t0/UebrVZJh3RBPhoyeI3meJiBSYq6spY6/vwSY51gN1EKrEslQqwJPkWJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P302MB1953
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5NSBTYWx0ZWRfX72GVemeUbltu
 cJGitnfDFRfCjTSjMsbQ+ROG0jxR68NPeL8YMSEj6+ohZRg3E2NVkzo84IFdlyRZKwB+LZUuNVO
 9gRT5XQJfJL+VNaWjYhz1O11ysu5Xt0=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a455975 cx=c_pps
 a=/QCTiE6iyTdx+qHPJesQ+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=q8sxnLsx4f2LGRLrC28A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: uiJeHFir34PeQ4lOaxZh-EtzAoHqXqo_
X-Proofpoint-GUID: uiJeHFir34PeQ4lOaxZh-EtzAoHqXqo_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5NSBTYWx0ZWRfX9kf/P7GX7xJS
 210r0a7r73ACa8WGtJb8RBmkTBmw/FzXgJhBz3djAWiyv1W0To4Zf68VPGgqzBKh+aOvOX/K2A3
 BxpZkBKlmffqXI2qBxcjsxB7anqsomz3/aw2gPGx6FJai4XzfyTDKP6TOeLreVkfmsQl1R/4wGk
 4ImB3IlUGXN0R54X6fcpUry4XoydoUH1tDKN/V1DIR3UyPOpkFYNQfpvM61UbTvTV1LrTYw5Uxf
 vQpbhIptC3UBZkas+HEEswz3W6ibXKExlcTSisu3ewHM18/FtTtCwMS5A//eYOfhk6LrCymlbi4
 /9Y5Lb8YLjQDyCGPRYsTgnrty6HI3Ume4Tbx+PrwJTkDxbOEs6qufOCQd/v4XKgoGqnCWBVNx9O
 hkhvh9MIzPUi7EqwmY6g4kQPI4d3w/FyiOmHW7vz2WfBZPLsaAFoi5z5kvNy2lPDvvNuvYnu6UZ
 Dhpho3h9/8LBPzH7oxQ==

SGkgU2h1dmFtLA0KDQpPbiBUdWUsIDIwMjYtMDYtMTYgYXQgMDM6MzEgKzA1NDUsIHNodXZhbXBh
bmRleTFAZ21haWwuY29tIHdyb3RlOg0KPiBwdnJfc2V0X3VvYmpfYXJyYXkoKSBjb3BpZXMgYW4g
YXJyYXkgb2Yga2VybmVsIG9iamVjdHMgdG8gYSB1c2Vyc3BhY2UNCj4gYXJyYXkgd2hvc2UgZWxl
bWVudCBzaXplIGlzIGRlc2NyaWJlZCBieSBvdXQtPnN0cmlkZS4gV2hlbiBvdXQtPnN0cmlkZQ0K
PiBpcyBkaWZmZXJlbnQgZnJvbSB0aGUga2VybmVsIG9iamVjdCBzaXplLCB0aGUgc2xvdyBwYXRo
IGFkdmFuY2VzIHRoZQ0KPiB1c2Vyc3BhY2UgcG9pbnRlciBieSB0aGUga2VybmVsIG9iamVjdCBz
aXplIGFuZCB0aGUga2VybmVsIHBvaW50ZXIgYnkgdGhlDQo+IHVzZXJzcGFjZSBzdHJpZGUuDQo+
IA0KPiBUaGlzIHJldmVyc2VzIHRoZSBpbnRlbmRlZCBsYXlvdXQuIEZvciBsYXJnZXIgdXNlcnNw
YWNlIHN0cmlkZXMsIGxhdGVyDQo+IGNvcGllcyByZWFkIGZyb20gdGhlIHdyb25nIGtlcm5lbCBh
ZGRyZXNzZXMuIEZvciBzbWFsbGVyIHVzZXJzcGFjZQ0KPiBzdHJpZGVzLCBsYXRlciBjb3BpZXMg
YXJlIHdyaXR0ZW4gYXQgdGhlIHdyb25nIHVzZXJzcGFjZSBvZmZzZXRzLiBUaGUNCj4gcGFkZGlu
ZyBjbGVhciBpcyBhbHNvIGRvbmUgb25seSBmb3IgdGhlIGZpcnN0IGVsZW1lbnQgaW5zdGVhZCBv
ZiB0aGUNCj4gcGFkZGluZyBhcmVhIGZvciBlYWNoIGVsZW1lbnQuDQo+IA0KPiBBZHZhbmNlIHRo
ZSB1c2Vyc3BhY2UgcG9pbnRlciBieSBvdXQtPnN0cmlkZSBhbmQgdGhlIGtlcm5lbCBwb2ludGVy
IGJ5DQo+IG9ial9zaXplLCBhbmQgY2xlYXIgcGVyLWVsZW1lbnQgcGFkZGluZyB3aGlsZSB0aGUg
Y3VycmVudCB1c2Vyc3BhY2UNCj4gcG9pbnRlciBpcyBzdGlsbCBhdmFpbGFibGUuDQo+IA0KPiBG
aXhlczogZjk5ZjVmM2VhN2VmICgiZHJtL2ltYWdpbmF0aW9uOiBBZGQgR1BVIElEIHBhcnNpbmcg
YW5kIGZpcm13YXJlIGxvYWRpbmciKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2
LjgrDQo+IFNpZ25lZC1vZmYtYnk6IFNodXZhbSBQYW5kZXkgPHNodXZhbXBhbmRleTFAZ21haWwu
Y29tPg0KDQpDb3VsZCB5b3UgcmVzZW5kIHRoZSBwYXRjaCB3aXRoIHRoZSAiRnJvbToiIGhlYWRl
ciBmaXhlZCB1cCB3aXRoIG5hbWUgKyBlbWFpbCwNCnRvIG1hdGNoIHRoZSBzaWduZWQgb2ZmIGxp
bmU/IFNvbWVob3cgdGhlIG5hbWUgZ290IGxvc3QuDQoNCkV2ZXJ5dGhpbmcgZWxzZSBsb29rcyBn
b29kLCBzbyB3aXRoIHRoYXQgc29ydGVkLA0KDQpSZXZpZXdlZC1ieTogQWxlc3NpbyBCZWxsZSA8
YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpBbGVzc2lvDQoNCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Rydi5jIHwgMTMgKysrKysrLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Rydi5jIGIv
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9kcnYuYw0KPiBpbmRleCAyNjg5MDA0NjRh
YjYuLjBhNjhhOWMzMjM2MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0
aW9uL3B2cl9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Ry
di5jDQo+IEBAIC0xMjUyLDE0ICsxMjUyLDEzIEBAIHB2cl9zZXRfdW9ial9hcnJheShjb25zdCBz
dHJ1Y3QgZHJtX3B2cl9vYmpfYXJyYXkgKm91dCwgdTMyIG1pbl9zdHJpZGUsIHUzMiBvYmpfDQo+
ICAJCQlpZiAoY29weV90b191c2VyKG91dF9wdHIsIGluX3B0ciwgY3B5X2VsZW1fc2l6ZSkpDQo+
ICAJCQkJcmV0dXJuIC1FRkFVTFQ7DQo+ICANCj4gLQkJCW91dF9wdHIgKz0gb2JqX3NpemU7DQo+
IC0JCQlpbl9wdHIgKz0gb3V0LT5zdHJpZGU7DQo+IC0JCX0NCj4gKwkJCWlmIChvdXQtPnN0cmlk
ZSA+IG9ial9zaXplICYmDQo+ICsJCQkgICAgY2xlYXJfdXNlcihvdXRfcHRyICsgY3B5X2VsZW1f
c2l6ZSwgb3V0LT5zdHJpZGUgLSBvYmpfc2l6ZSkpIHsNCj4gKwkJCQlyZXR1cm4gLUVGQVVMVDsN
Cj4gKwkJCX0NCj4gIA0KPiAtCQlpZiAob3V0LT5zdHJpZGUgPiBvYmpfc2l6ZSAmJg0KPiAtCQkg
ICAgY2xlYXJfdXNlcih1NjRfdG9fdXNlcl9wdHIob3V0LT5hcnJheSArIG9ial9zaXplKSwNCj4g
LQkJCSAgICAgICBvdXQtPnN0cmlkZSAtIG9ial9zaXplKSkgew0KPiAtCQkJcmV0dXJuIC1FRkFV
TFQ7DQo+ICsJCQlvdXRfcHRyICs9IG91dC0+c3RyaWRlOw0KPiArCQkJaW5fcHRyICs9IG9ial9z
aXplOw0KPiAgCQl9DQo+ICAJfQ0KPiAgDQoNCg==
