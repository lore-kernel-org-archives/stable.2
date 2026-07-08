Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1603382E1;
	Wed,  8 Jul 2026 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517009; cv=fail; b=pitBFWmZY2+UKjOO9Djg9vVS9xCpDL79SCyq9g3SkuYcWzU9K2z8hD2ONiF79+tWHUU38iAck6MEbxbee9MoNbqTgg5KqJLFEdr2OBhXJb1mt/gOTxEmZesConu/qKkLAmeHAYHEIit47Vt09kgNQstKnfc+EIybwnxIycAFlDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517009; c=relaxed/simple;
	bh=b3qz4kJJ9glbnAPDOoXaoQVHt7nJsC4DfHWudCypMtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5J7wKXd1aG7Zsj6Ij2wl3txiJdPuzqT9/j8VfbSlROHveusjAmCvb0KjbJmtcfdoTO4YhQ4qyq/olvaGoLTF5yAEwNFC44Add/F1TKfuaciK5aHSJ1ipd2G/5dcucZbxyN0P7CNDZ2s70N/CsfjTdqd+4a08zj/HlEkJwfijzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=xtFcssA4; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=fOt3Ie2P; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="xtFcssA4";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="fOt3Ie2P"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668Cl0KE1290777;
	Wed, 8 Jul 2026 14:22:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=b3qz4kJJ9glbnAPDOoXaoQVHt7nJsC4DfHWudCypMtA=; b=xtF
	cssA4dBrXkIz861sQ+4kUoqZ/pjN2WsIih8oDMo32XZvKi8ucfD5usauf5XgtqPi
	zvCxrZVNKNW54p1kVQl47lmunmNDWyBd817jsNtFeRorbEN1D6p1FturpyBeZxsC
	3zVFhhLkl6CKyU0LDq3nqy+tKpHwZm6mPf+lsxR63c2D+AoAdvoEsHrtYwdcf9C6
	t0qFDAd26T88vJZQ31Yf3Kmu2Hv30YIbwrZTqNxxNA3uavKAXaitaR7miHf+A70t
	gZlmujxfRwKoOPwIb07sjW4AOyy7+qSmPnU1iv4XFmU8NxzczHz/B3PMnxaaGrG/
	6U4iIBgUpiMc4kemHsw==
Received: from cwxp265cu010.outbound.protection.outlook.com (mail-ukwestazon11022120.outbound.protection.outlook.com [52.101.101.120])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f6repkr8f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 14:22:47 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntkAjNjC/507EJq+Z+g3gpZlM1NMVTEtg8+EFIBVkXEM41KRMMT5P5s/6HMx75/+rDExykIp8XgOrdMg/iEGIrp87sFkGZewdScVrXRZxHWn/A5ZzAwruUt3RIpPjALXP3/808gkCPDLRvDlSUxy7MTrp2pImMWWU/bEIK+McH7oaX13AKWb7ms/KOnQDuLHfg/1LGUwJu+UKcaYCNoz5vOXvZUgxfsFt3dfAsyQ5+r5kjOtyZPZ+aHi6fc5hUCQkK77H+pF85lVwwFYnzWkf7mFeTrBejHEPBHcXxlaayefcd61YcY0sAp0qgq7sqLP63PT4cuP343tO1rg0Q29AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3qz4kJJ9glbnAPDOoXaoQVHt7nJsC4DfHWudCypMtA=;
 b=UeppqRqjDqdGPRr+boc1dIXtOs0UuImve4KTVzBQsyWY30H78Y+8eJN7DEgnh8R9xHQYIPYU7Ng61S1tw6KWA4oY4mZvDfQSSnSnb2t5kLdUZRiPmBIcriahgEIJGUP0/ljGah6UqQCsOdiWew3GsQvKwnyTX2djzaan4+WYO8Fc0I+pPLwLbvjF1qweaF+ipGchVJ8E+zBG9TiFNfuDgOIkHo0FYM1Fuc4V9OeQAlc2m4BxZNZ80P0R0HMFbu7ew6FmuZOTGb7xJuMmpU+gzdaq4boN/972zWpwS4AJ4yZfaHbt1TunIZgbUtAhee013NO1DeAh6yNLM7l/uwMWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3qz4kJJ9glbnAPDOoXaoQVHt7nJsC4DfHWudCypMtA=;
 b=fOt3Ie2PdKSeQ55do3JoYCh73o1yWMuxukIa182//BCaEsekeRObG5DMpllXuVy72SWBc5MB8KU9NCrva3PvxUMhvBDbKkpryup0RZWYXZZcCYdvgOFm41hdQgnn1oiMTWfYjC5aXefv159xLrBtque6xiVKm0A2h4E6T3ZwD00=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO8P302MB1416.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:3f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 13:22:43 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 13:22:43 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>
CC: Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
        "tzimmermann@suse.de"
	<tzimmermann@suse.de>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Frank Binns
	<Frank.Binns@imgtec.com>,
        "boris.brezillon@collabora.com"
	<boris.brezillon@collabora.com>,
        "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Dadu
	<Alexandru.Dadu@imgtec.com>
Subject: Re: [PATCH] drm/imagination: fix error checking of
 pvr_vm_context_lookup()
Thread-Topic: [PATCH] drm/imagination: fix error checking of
 pvr_vm_context_lookup()
Thread-Index: AQHdDiPMcK9D1JxW102x7XQwdMuDSLZjnWsA
Date: Wed, 8 Jul 2026 13:22:42 +0000
Message-ID: <fbcad7c8285c255cb09b31e39303fd88e7de3bb2.camel@imgtec.com>
References: <20260707-staging-ddkopsrc-2435-v1-1-24e160d44476@imgtec.com>
In-Reply-To: <20260707-staging-ddkopsrc-2435-v1-1-24e160d44476@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO8P302MB1416:EE_
x-ms-office365-filtering-correlation-id: f27f34f4-2c5c-4371-13ff-08dedcf3fe10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|38070700021|56012099006|5023799004|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 5A2e4+YaWXByxjFC5GmSR7S8Xm9jOL1xZDnnuEy4FRiMp/cM9kRMYybwe+/W3jUSSLxheglsoRO0pJvPvqpA23gCZdlWHTF/bm09MMOF8Y/6ymjN2/Dzt6QYget77sv2cEofZ6AcdmklOhU2ZC27WK8rZ/vWAyi3hOUhf8SzN6mxaYz8UKegxw5VrY0P1jOwDVg5mWuN+gr81CF76GbjZqiGsXUgatel0Bl75jE70lrx4WJmvoKGvD/MTYkB9BaBcOzLPxnsV6Yiox0tWi4Z1IVSPWfVp0idAKboNExauMarwbM3zgDUXJiIJYbWpO+b05bCHSL6eoxwSfIDFkhuVXgY759IgZypizOwBH8nAFeKGBrqGr8kuR7Ug9PQuB7SKt4tYXZ24el3NVaKKPyfTIDsC/pNOqx4yLJ3gc7UCY1SsuQGIab/whtMe7nu2sVBxNL5fTOufs5nwjPzAP/MMMvXhdME/4Bo95q69rqMA1IaV0DXMUYqxSlcD686OmyO/hiAH5Tds+Z5UzqG3ak9UPDHMfSghCpnqQUjevr9ay//AmZ1jS+I6Gst9mWP/9lBegpgD4rBDA/aGH+o5DP9HKbvwmdgVKPP/6btbRw6SROzhKsJsh5HtpEm0ug1vJNlluNEsHlLlDZSikrGv3fXnoOYEurQxzPqhdEChAqk/hq8fZr/V/1nB1PVtYFDfPgTFbmhHmrtTDIiJ+KB7TQdgMaGLTcddp4xoLuVn68siKg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(38070700021)(56012099006)(5023799004)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnFwb09TOEhvRWJYZCt2NDgxazhRMFU1T1AvTjFMSkNSb2FDRTV0L2tEL09S?=
 =?utf-8?B?ZWllQ3VMOXo5ekg1dG9GZms2UTg5UzBGYjNyajd0UEZKanJGeHhUaHdDcmZR?=
 =?utf-8?B?UFNhd1J1T2JUWGc1T0poUXRIVVFwREVjTktkSjQ3SXh5TTdRYWZBV0UzRlBW?=
 =?utf-8?B?TVpldVloYkh4WE9Pbjc4MHZxTkxvdWNQQzhwWFdPTUpJWk8wRis2SlN2ZjN1?=
 =?utf-8?B?RVZnaDRMQ0hHeVRkeUdyb0hQYnUvU0V6NVhwY1VnNlI2SEJ6V21GWmVKVHVF?=
 =?utf-8?B?RUJGc3ZEaVhhaHJ5MWxQTVcvVTB3UGlPTkpCdWc2ZjUwRkxudEMrUC9IViti?=
 =?utf-8?B?dXlLVHdxNkJRMGkyeFhlWXhxSzZiTHk5TkpUYXBCc2JCbVhBR2pOSTYyL3R6?=
 =?utf-8?B?c2p5Vy9Idjc5aDVQOFBwd0pCcHF1SFlUalF2V0ltdXk1b2xsUUsrRzdmbEhZ?=
 =?utf-8?B?WnNqR3RZaElUTklJOXRMYU0zTTlzTTR6b0x3V0JJSEV6TmFNQUwyV2pGU3A5?=
 =?utf-8?B?NldKM3I2dUl5eTg4S25HZkRSNXRRL1UwZ3RmNGtEbW9yZ1JXY0lxcWRxRGdY?=
 =?utf-8?B?Z2wzQ1RKaXZ5OENDcEpTMW1TQzRFZlhKbjE3QUVnR1RRQVp6RksrUFJuVEhE?=
 =?utf-8?B?OVM4ajdidGVXOVJjWGZPcGZNVkN1WGtvZWZlRmVMSXE0cVl2ZnZqK0g4blpD?=
 =?utf-8?B?TkNKTmxPYXVyNERMUCt2VG1SZEFRUWZmbUZEUnFiaUN6VlZ1eHlKL1AxTDlW?=
 =?utf-8?B?WXZsMDRWQUY4R0pOV29UU1UxM2tKQWREcXVUVVNMNXoyU3o5WjI1NzdJUHZn?=
 =?utf-8?B?aFZrdGQvOVR5RW9iVEJZcWF1aEFRRjJaYWh4MGRLbDVmVXduYjU3L3hGRE5x?=
 =?utf-8?B?Q00rL3hYeC82bk92LzZhaFFLVDdsbGkwaHg1VzVnQWthVnBBYnc0RXV1ZkxL?=
 =?utf-8?B?eU1zSnMrajRWUnFycFlEZTdYMkpyQnRrcGtvbHNHUlpKN0l4VElBRmg2NHN4?=
 =?utf-8?B?WjM4QU9GNXpUc285dHlnVkxvVHlFN0IvVXA0SysxckE0N1JQVUpQckd0Z3I2?=
 =?utf-8?B?bjdPcFBHUmJkRStLSXVNNFpwZnliL0lWdEFZZ2o5MVpCZUV4VWlBK1FqL0RH?=
 =?utf-8?B?N1VaZndSeVcxaXFOREtvUG9Id3FaRHFYalJpc1YzdUlKMHpCVmhaSHpXejZp?=
 =?utf-8?B?Ui9KbHpoQ2llWHFBQ1dzQkFFTUtXMlFxSHhnaUIwZU5oUVJuN3pFQXkzYVdG?=
 =?utf-8?B?cVNtK1VMeXl1d1YwTHhjQjB4eW9zMkdualBIanB3OE1NMkY0ZEFLOGdXM3Zo?=
 =?utf-8?B?eSt3ak42c2JROXl5cjFtQVFlc2NhaXhaQzJ5M2xyM2tqc0xYd0YxY3lkU2sy?=
 =?utf-8?B?bndTdEE2Rm44RTNnbkhsbVV2Ti94bWVRUGhteGhsVTkzMUFoWm9oejlvbkYy?=
 =?utf-8?B?ZGdaUUJWbmVlV25aVzBwRDM4MkxQQlRMK3YwZWEwMkU3ZFB6b29KTHg0Mncx?=
 =?utf-8?B?T3JxRkhPOVgycUxLN2pOdzBRVWtyRkRDM3FUbUpGR0JwemFuemp3Y2o0K1NR?=
 =?utf-8?B?UkVNY1MvZVoxYyszeWxYRitLclF0YlU1bjg2cUxOOU1KVXBnTlFiVDJvUmhQ?=
 =?utf-8?B?R1FhQ2pGOW5rNkcvcUtiQlZhZEZBT2J3L0M3VGpJRTZwdURRcjU3UkhKSVNW?=
 =?utf-8?B?UU1kM2tETDFWTnJvMTlXQVhyTzVRd1o1MVFsWFlYSVhSeVZqWGxwVmhiVWxj?=
 =?utf-8?B?RFNaM3Y4SXpoVmdnRnlCOThWNzB6Zm1FdTdlanJBQ1JYZy9vMGVuTjYrV2JX?=
 =?utf-8?B?ZVpUelhpZ294ZEJBTGlQV2hqODQveExrNkZRc3lVYWNuOWJkMXpwLzZreUh6?=
 =?utf-8?B?NExEUk14b1hjUU1ZNmNxSDFZTjNaY0JCbGZ5V2F3MEtCS3NYbXlVeU1VUm5I?=
 =?utf-8?B?WU0wdVVyU216cVZGV3h1Y1M3WjVXR2lsUUsyZjFocjdQeUFaQmd3RGlPYisv?=
 =?utf-8?B?SzRaTFBwZmJTZTEwdlAvQmZYbyticnJIVmVmUmxKeURiWFVrV2FKSWJEc2ha?=
 =?utf-8?B?ZE9nMlEwa09Nbm9JcVBrVXl0Z2tHSmhQQ2JOR0JsV1RCRmdzSVNsSUt4TFB0?=
 =?utf-8?B?dzFsRTNiZ1o5TytwWDhsZTFZNldzaXhUdW56WDBDemN2Z2doY0t6WUlUS0d0?=
 =?utf-8?B?V1BTaEtaNGJGTFdOZE5GVktHcklDM2lxMkdCSmFURndPdEpCVTVDbmc5Z2tF?=
 =?utf-8?B?VTc3WDFzRUZ5U2lPL2ZkVmVFU0UxcExteFg5UVNCeFVudzFXSXlCWThVT0NN?=
 =?utf-8?B?eXBMMnc0cVRqcUtlMGRHaE5YeERnOWl2VDBiVHZINUtkSCsveTd3UU9EWXJx?=
 =?utf-8?Q?z2AytoqZ9ZTQe5P0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12C80065817E7940B0D7679CE8D809B3@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	S3YLgWSBLYQH1ohu9sn2cs3fcfRjk7xXV5UfcVU02RQr+pYPB2Y9Ua3zW60x6Vg/XBMI9IK2sYywRo0aI2AGFqL3tHmXja5l8fPlDO0KOGMgQ7WgC/QZv/04B8Ek6pFhbfgDgTQ3E51O7j7ic5yszUXbS32Ddjpr6PRUPpuW07UUGTrauh2b2q6ntCOGxUZbX3WljirGvgO6S/VjSupTnyVtWbqqIDpg0LXzxMF4giGYqb3H8xugr/1HQZwK3Vcxl0v3A15ElQ66FLHskNVTpNrC3XIx7JEBk/47S6o/k0nqzJXCbhP31UqqqyjivaK98plqfFFbwCo0SECQmyj0ow==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f27f34f4-2c5c-4371-13ff-08dedcf3fe10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 13:22:43.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LR1Fv+LFefSQoVxPmxOll02OEJlG7lZHgk2fBdIK90512zAAlNFHramGmXxmPSGfkGXOsqtskTdNlh4tVRuSdC3U0OUjY950o5MiMFDAi9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P302MB1416
X-Authority-Analysis: v=2.4 cv=Fos1OWrq c=1 sm=1 tr=0 ts=6a4e4f27 cx=c_pps
 a=tfanM9ScQIhv4mDjZMYfug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=YcVcPUlio9TeFS2f3GUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: XOJCCqAG8yLDoXkLK0E-7wWKcuWMClX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzMCBTYWx0ZWRfX8uD2WJUQLtCl
 BrOUXPKnI414uMNpJw6g0E0BS2SpQcWIJlBzgLzZDH1/KpTQlK0VjinV4z+rAns/3XSm3RM1gJ6
 UhpjZ0myPnEcd/nQ512oYELDr+KAk0jyWjclGZP99SoOdE9l0lDwM6hihwib1LgPqO/I0DDVIGG
 jXClG9XVpt0iQfjZ2bxMnjR2D3MwSBKuu4RMZ4DzDYtBlGY5Dv1RI2N+PTEU1tavteokU3IwLqA
 uX/Ujzlppn3d7G199+Qa8rcbW4g6VyXilqDyOL7NrMxzbzAZJjj5Z4rKPgHPNWF25UJ4S5OsNcj
 2bSb0C+jr0TfbotMnUaoznB2d83w6feLjVa1prC8SdxyidGhhDkQs0MBeovrGlUmLZeLk/4sNlI
 coB1ODwT6+NCex0dtYHIT/2yA6f+b+9RtsBXuUkf2+TYh52KTBUVT2W7L7gBgDbkeb3QOu3aKAu
 GtNvRRoM+QbsQterVnQ==
X-Proofpoint-GUID: XOJCCqAG8yLDoXkLK0E-7wWKcuWMClX1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzMCBTYWx0ZWRfX1be53rJMrM2a
 QbTG2srTNPa+ekvA8ucJ1wL0cfGRuDf0E8yt22uVKkQU1pIXy1R5PoKimz1axzwHVGu26TqeSMw
 +SIzElLl4PqwRZDKzuja7nO+Mg2Yq/A=

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDE2OjE3ICswMTAwLCBMdWlnaSBTYW50aXZldHRpIHdyb3Rl
Og0KPiBTaW5jZSBwdnJfdm1fY29udGV4dF9sb29rdXAoKSByZXR1cm5zIGVpdGhlciBOVUxMIG9y
IGEgcG9pbnRlciwgdGhlbiBzdG9wDQo+IHVzaW5nIElTX0VSUigpIGZvciBjaGVja2luZyB0aGUg
cmV0dXJuIHZhbHVlLg0KPiANCj4gVXNpbmcgSVNfRVJSKCkgbGVhZHMgdG8gdGhlIGtlcm5lbCBv
b3BzIHJlcG9ydGVkIGJlbG93LiBJdCBjYW4gYmUNCj4gcmVwcm9kdWNlZCBieSBwYXNzaW5nIGFu
IGludmFsaWQgVk0gY29udGV4dCBoYW5kbGUgZnJvbSB1c2Vyc3BhY2UgdG8gdGhlDQo+IERSTV9J
T0NUTF9QVlJfQ1JFQVRFX0NPTlRFWFQgaW9jdGwuDQo+IA0KPiBbICAgOTIuNzMzMTE5XSBVbmFi
bGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBh
ZGRyZXNzIDAwMDAwMDAwMDAwMDAxNDgNCj4gWyAgIDkyLjc0MjA0Ml0gTWVtIGFib3J0IGluZm86
DQo+IFsgICA5Mi43NDQ4OTBdICAgRVNSID0gMHgwMDAwMDAwMDk2MDAwMDA0DQo+IFsgICA5Mi43
NDg2ODZdICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+IFsg
ICA5Mi43NTQwMjBdICAgU0VUID0gMCwgRm5WID0gMA0KPiBbICAgOTIuNzU3MTU0XSAgIEVBID0g
MCwgUzFQVFcgPSAwDQo+IFsgICA5Mi43NjAzMzddICAgRlNDID0gMHgwNDogbGV2ZWwgMCB0cmFu
c2xhdGlvbiBmYXVsdA0KPiBbICAgOTIuNzY1MjQzXSBEYXRhIGFib3J0IGluZm86DQo+IFsgICA5
Mi43NjgxMjldICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNCwgSVNTMiA9IDB4MDAwMDAwMDAN
Cj4gWyAgIDkyLjc3MzYyNl0gICBDTSA9IDAsIFduUiA9IDAsIFRuRCA9IDAsIFRhZ0FjY2VzcyA9
IDANCj4gWyAgIDkyLjc3ODc2M10gICBHQ1MgPSAwLCBPdmVybGF5ID0gMCwgRGlydHlCaXQgPSAw
LCBYcyA9IDANCj4gWyAgIDkyLjc4NDA5OF0gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgtYml0
IFZBcywgcGdkcD0wMDAwMDAwODhlZDIzMDAwDQo+IFsgICA5Mi43OTA1NTBdIFswMDAwMDAwMDAw
MDAwMTQ4XSBwZ2Q9MDAwMDAwMDAwMDAwMDAwMCwgcDRkPTAwMDAwMDAwMDAwMDAwMDANCj4gWyAg
IDkyLjc5NzM4MV0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDAwMDAwMDAwOTYwMDAwMDQgWyMxXSAg
U01QDQo+IFsgICA5Mi44MDMwMjddIE1vZHVsZXMgbGlua2VkIGluOiBwb3dlcnZyDQo+IFsgICA5
Mi44NTI1MzNdIENQVTogMCBVSUQ6IDAgUElEOiA0MDkgQ29tbTogdHJpYW5nbGUgTm90IHRhaW50
ZWQgNy4xLjAtcmM1LWc5OGI0NmU2OTNiOTEgIzEgUFJFRU1QVA0KPiBbICAgOTIuODYxMzg1XSBI
YXJkd2FyZSBuYW1lOiBUZXhhcyBJbnN0cnVtZW50cyBBTTY4IFNLIChEVCkNCj4gWyAgIDkyLjg2
Njc2Nl0gcHN0YXRlOiA2MDAwMDAwNSAoblpDdiBkYWlmIC1QQU4gLVVBTyAtVENPIC1ESVQgLVNT
QlMgQlRZUEU9LS0pDQo+IFsgICA5Mi44NzM3MDldIHBjIDogcHZyX3ZtX2dldF9md19tZW1fY29u
dGV4dCsweDAvMHhjIFtwb3dlcnZyXQ0KPiBbICAgOTIuODc5Mzc2XSBsciA6IHB2cl9xdWV1ZV9j
cmVhdGUrMHgyNmMvMHg0NDAgW3Bvd2VydnJdDQo+IFsgICA5Mi44ODQ1OTVdIHNwIDogZmZmZjgw
MDA4MzdmYmIwMA0KPiBbICAgOTIuODg3ODk1XSB4Mjk6IGZmZmY4MDAwODM3ZmJiNjAgeDI4OiAw
MDAwMDAwMDAwMDAwMDAwIHgyNzogZmZmZjgwMDA4MzdmYmNlOA0KPiBbICAgOTIuODk1MDE1XSB4
MjY6IGZmZmYwMDA4MDdmNjFhNDAgeDI1OiBmZmZmMDAwODA3ZjYxYTAwIHgyNDogZmZmZjAwMDgw
N2Y2NDQwMA0KPiBbICAgOTIuOTAyMTM1XSB4MjM6IGZmZmYwMDA4MGE1YWIwMDAgeDIyOiBmZmZm
ODAwMDc5YjI0NzMwIHgyMTogZmZmZjAwMDgwN2Y2MTgwMA0KPiBbICAgOTIuOTA5MjU0XSB4MjA6
IGZmZmYwMDA4MDk5OWU2ODAgeDE5OiAwMDAwMDAwMDAwMDAwMDAwIHgxODogMDAwMDAwMDAwMDAw
MDAwMA0KPiBbICAgOTIuOTE2MzczXSB4MTc6IDAwMDAwMDAwMDAwMDAwMDAgeDE2OiAwMDAwMDAw
MDAwMDAwMDAwIHgxNTogMDAwMDAwMDAwMDAwMDAwMQ0KPiBbICAgOTIuOTIzNDkyXSB4MTQ6IDAw
MDAwMDAwMDAwMDAwMDAgeDEzOiAwMDAwMDAwMDAwMDAwMDAyIHgxMjogZmZmZjgwMDA4MTQ1YjI5
OA0KPiBbICAgOTIuOTMwNjExXSB4MTE6IGZmZmY4MDAwODQ0ZTUwMDAgeDEwOiBmZmZmODAwMDgx
NjVhMTMwIHg5IDogMDAwMDAwMDAwMDAwMDEwMA0KPiBbICAgOTIuOTM3NzMwXSB4OCA6IDAwMDAw
MDAwMDAwMDAwMDEgeDcgOiBmZmZmMDAwODA3NmIyN2UwIHg2IDogZmZmZjAwMDgwZWM0M2I3Yw0K
PiBbICAgOTIuOTQ0ODUwXSB4NSA6IGZmZmYwMDA4MGVjNDNiNzggeDQgOiAwMDAwMDAwMDAwMDAw
MDAwIHgzIDogZmZmZjAwMDgwOTk5ZTY4MA0KPiBbICAgOTIuOTUxOTY4XSB4MiA6IDAwMDAwMDAw
MDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMDAwMA0KPiBb
ICAgOTIuOTU5MDg4XSBDYWxsIHRyYWNlOg0KPiBbICAgOTIuOTYxNTIxXSAgcHZyX3ZtX2dldF9m
d19tZW1fY29udGV4dCsweDAvMHhjIFtwb3dlcnZyXSAoUCkNCj4gWyAgIDkyLjk2NzE3M10gIHB2
cl9jb250ZXh0X2NyZWF0ZSsweDE5MC8weDQxMCBbcG93ZXJ2cl0NCj4gWyAgIDkyLjk3MjIxOF0g
IHB2cl9pb2N0bF9jcmVhdGVfY29udGV4dCsweDQ0LzB4OGMgW3Bvd2VydnJdDQo+IFsgICA5Mi45
Nzc2MDhdICBkcm1faW9jdGxfa2VybmVsKzB4YmMvMHgxMjQgW2RybV0NCj4gWyAgIDkyLjk4MjEy
N10gIGRybV9pb2N0bCsweDFmOC8weDRkYyBbZHJtXQ0KPiBbICAgOTIuOTg2MDk4XSAgX19hcm02
NF9zeXNfaW9jdGwrMHhhYy8weDEwNA0KPiBbICAgOTIuOTkwMTAyXSAgaW52b2tlX3N5c2NhbGwr
MHg1NC8weDEwYw0KPiBbICAgOTIuOTkzODQyXSAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9wLjAr
MHg0MC8weGUwDQo+IFsgICA5Mi45OTg1MzJdICBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KPiBbICAg
OTMuMDAxODM1XSAgZWwwX3N2YysweDM4LzB4MTFjDQo+IFsgICA5My4wMDQ5NjldICBlbDB0XzY0
X3N5bmNfaGFuZGxlcisweGEwLzB4ZTQNCj4gWyAgIDkzLjAwOTEzOV0gIGVsMHRfNjRfc3luYysw
eDE5OC8weDE5Yw0KPiBbICAgOTMuMDEyNzkyXSBDb2RlOiBhYTE3MDNlMCBkMjgwMDAxNCA5NWNi
MGJhNCAxN2ZmZmZlOCAoZjk0MGE0MDApDQo+IFsgICA5My4wMTg4NjldIC0tLVsgZW5kIHRyYWNl
IDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiANCj4gRml4ZXM6IGQyZDc5ZDI5YmI5OCAoImRybS9p
bWFnaW5hdGlvbjogSW1wbGVtZW50IGNvbnRleHQgY3JlYXRpb24vZGVzdHJ1Y3Rpb24gaW9jdGxz
IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTHVpZ2kg
U2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0ZWMuY29tPg0KDQpSZXZpZXdlZC1ieTog
QWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpBbGVz
c2lvDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2NvbnRleHQu
YyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X2NvbnRleHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfY29udGV4dC5jDQo+
IGluZGV4IGViYTQ2OTQ0MDBiNS4uNTEyZjM3MzUyMjNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2NvbnRleHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX2NvbnRleHQuYw0KPiBAQCAtMzA3LDggKzMwNyw4IEBAIGludCBw
dnJfY29udGV4dF9jcmVhdGUoc3RydWN0IHB2cl9maWxlICpwdnJfZmlsZSwgc3RydWN0IGRybV9w
dnJfaW9jdGxfY3JlYXRlX2NvDQo+ICAJCWdvdG8gZXJyX2ZyZWVfY3R4Ow0KPiAgDQo+ICAJY3R4
LT52bV9jdHggPSBwdnJfdm1fY29udGV4dF9sb29rdXAocHZyX2ZpbGUsIGFyZ3MtPnZtX2NvbnRl
eHRfaGFuZGxlKTsNCj4gLQlpZiAoSVNfRVJSKGN0eC0+dm1fY3R4KSkgew0KPiAtCQllcnIgPSBQ
VFJfRVJSKGN0eC0+dm1fY3R4KTsNCj4gKwlpZiAoIWN0eC0+dm1fY3R4KSB7DQo+ICsJCWVyciA9
IC1FSU5WQUw7DQo+ICAJCWdvdG8gZXJyX2ZyZWVfY3R4Ow0KPiAgCX0NCj4gIA0KPiANCj4gLS0t
DQo+IGJhc2UtY29tbWl0OiBmNzYwNjQwMGYxOWNhMDI5MTcxOGNlNGVlZDU3NzA3OTg4OTBlYTJm
DQo+IGNoYW5nZS1pZDogMjAyNjA3MDctc3RhZ2luZy1kZGtvcHNyYy0yNDM1LTkwZDRkMjE4Mzgz
Yg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLSAgDQo+IEx1aWdpIFNhbnRpdmV0dGkgPGx1aWdp
LnNhbnRpdmV0dGlAaW1ndGVjLmNvbT4NCj4gDQoNCg==
