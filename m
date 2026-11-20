Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167128;
	b=WOLtLs9TIBYQf/rU3aJg26YiORJsNyy6h/dIhtHRElp2T9oDbZd8Fi4+812aS0QVw/Oo
	 0dQrkX57qcTbdInAiT8+DkhsnaVcQtaKw4Efq/VsRFcQsu+1+hhTK9uAwspaxjtbhCAnj
	 PE0mAYCvkb++89E4Srfke1cnpdTDn6b06aNYFvPDhtUAboZZPLP3WNu/daGTtj3nHVIoe
	 KkrTd6QcK20CGmulHGPhcx8kNrFHAPDkj519ik7WD/53xJLV7p2Foa7o3wwYjaU2386Ry
	 U9NbvF8qJRJtO53GOmyTc5oKU7ut750Vb2XZb6s78oOQrslCoKM23kTYA0ZIXi/3Y4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167128;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wVe0Usempxjar+lAqrDu/n8jOFLpinRObKNv1oKh3uw=;
	b=J6ehqwrIHS2NX6kASC9LR672akEdL9OP4EpLUetbwYWivl3Ei8D6hY+uzOenlMTchotR
	 Bf+3rA8TltGbv1JSfHiyeO/9FFg0ma3PS0gvPMJ2Y48P1FKziGLuSa3nvaGzaD70eMpS9
	 HB6ViOGxOjUTgsDUmJ1ECJLaIjnTCgNdhhiK2HCTBftykwQz8Ug25dYe74q5qBaf8I/SC
	 c/C/YgX/NiFAIrBRVFSdng5p3YolHChFalDCH0ndJisWPjG6znIY6EVmRAtdXPzsAhYOM
	 KMhnTBQ6qfucAg4oZMrCjQiKKXuGLCehs/FVdxB7Mm+X8rN02ue6j8OmrzTl7o2Gybw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="hLg/jahY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.53.62
Received: from WA2P291CU004.outbound.protection.outlook.com (mail-polandcentralazolkn19012062.outbound.protection.outlook.com [52.103.53.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA4606A320;
	Fri, 20 Nov 2026 09:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1DA4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=hLg/jahY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0p9nNg0TPkrloSlDfM+EhREj4W1WarSeEU7VOMIsSWhC8CNhGs49Y7reDtUkR08TLwBO+fACgi4wOmoMIbft19Mgbyjr1rw69AbEF6pCyay7TigyEP5KziQt7KDJ8G41wU4Uf7e+ZNAK9AikE3DytnRrQ2ByCm0zfqMadCVlHealQI2XkM2WuK/LwtUgdqGNQq5ZqT4EzIdwFxXVP0uBgIfyumsLgCc1ksL0M4RdaPY+EAo6oLL7LI2BSjdKz3HcDTRHdxu8ocwLL1aRxYDSde5B+iVbOeCz/UNE1ple8WCgJy51ZIkiDdyOSUG2eXQDvMFAmbq8psLdgN/ymMw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVe0Usempxjar+lAqrDu/n8jOFLpinRObKNv1oKh3uw=;
 b=HPcb7XSArVcAHQSe7VXSai9cD072542bwvJovgRbjAoqna+jHgDZFuhkm7vYAHLLsP1yLKWEsSgpJwM+N4PdAJx51vO7oJQSjTX81E3y37V5OBSamivROcK6MphR0qwyZvUHAQHJhJbxop7HoYzflNieTgWOZUDzGAJOzxYpUfn8ZTHoxjATugVJk3F7zZUk8uNAo44K0q32u8tjLzVGv8ysxmUGO4be1jUgwJYGF3kAkSpAhC1KCCCDgM+0kS3fFJnMTJy+koLg9H/1ScnqeWBpJPDx7uRw+gtOsGW71BZH4TPmzjnm1mmEnxc/8kSVNriphuhYeJSgmTEzRSKayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVe0Usempxjar+lAqrDu/n8jOFLpinRObKNv1oKh3uw=;
 b=hLg/jahY80F6++zlEiCCseVI42kcO0Fw44sKvVJAwiO1FD+jyF0M4XLTNjR9rWVeZBqsUvXuaqVfcOddFKLmc5h/Zii//+xb848QMCfxFeXXxhZrvsJ7TDFp8VSArtM4TW1JAfsAJqVzAfT1E1yJES/7WXpjFEpTlOlamQr+GBpyhHSc0hGIXO723nEg2spePr64tJ+hydJAp3pElXJVfBr/zpFo+2F5pbogrjR05A05zZPjrrGwRMmEe94A5Oq9gzoSI1yV+hUgwURne37aD5ereZnaMTN+dx7DlWzfRwbQ1/tRDwn4+p9SmQbArpIGHLryhDzgIGtUPTrW7vLQdw==
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:26::11)
 by WA2P291MB0263.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 09:32:04 +0000
Received: from WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404]) by WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
 ([fe80::996b:1617:ce96:404%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 09:32:04 +0000
From: =?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
To: Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+fc3a448093c17a792368@syzkaller.appspotmail.com"
	<syzbot+fc3a448093c17a792368@syzkaller.appspotmail.com>,
	=?utf-8?B?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3] char/hpet: Fix missing TASK_RUNNING before put_user() in
 hpet_read()
Thread-Topic: [PATCH v3] char/hpet: Fix missing TASK_RUNNING before put_user()
 in hpet_read()
Thread-Index: AQHdeNIAcEgMjrKjnU+JKhj9cCZxtg==
Date: Fri, 20 Nov 2026 09:32:04 +0000
Message-ID: <20261120093145.134095-1-habilerenturker@hotmail.com>
Accept-Language: tr-TR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA2P291MB0187:EE_|WA2P291MB0263:EE_
x-ms-office365-filtering-correlation-id: 9090c39b-8d90-4fd5-e4dc-08df46e9233b
x-ms-exchange-slblob-mailprops:
 cn60g5V53KM6CoYXTTNjh34iAhmnTq1H8u7OFZ8iNXoreJ706Ogwr5ooliISzqbLuIAXzcDuUoL9hfQUozHBwHaxbTLjHT9XvPGKjsJQMtYaiq78SjoPkwBtyW4pkwzrCbrMgj2gbDQogoy+untRluazXKifTi+u5DaCiXDErCQCtkSRsgb/oARGqzfQ1ZJsl/SBbKFQjb4IG9gJmq+05i9hVF1qR+clwqsxg7DS0ODF5p0+hE+ptWnHFlSpqUxhK2/ishDWT3kBOisJMqFkVFHZol52laoLElKq+uCOhYNaoIOLsojE/XI7suXTEboZsNgrESk/3P6PLk/hqAMxS9G0fCH5R001ljZOqWFepe/ADc4LbjmRWZBw0+9W2zU0MpXzYqfgoJ18tLpl/5pVAqtU0j+uXJFKXtDWdX1U43KhPHVBWogMKQKZ3WfwRKyQVQaHyoxSKXymm5n0yWY8e8GZEoXav9zgJmeArkgcAN9FUFo53v4df7pXpaSEoKWtUzRaoS2RSN5O+6tWUtjtLBxPndLOUb7D1l8nchQ+4Eou9WdCjuDriLmt/VCoYLZ/AfNOWaJ4sAceA0tIvzJ1Kkk0RumqAyJN3lbkMGPveAZPnn5mHXxlq+2FQKbVX9yJDgbn5yeDRCIrC/w5zLXs4Fz8NRKGoCvueapkAHcLO79jA6NGTy7O5dq/anS5P73/po1kv3YmzGdx4ZaOPs5K8yrTd7T9wAOmAbNpjjGIOYqYgj5zvO4eL6P10SiYUDSI3sJ8rJz5jOFaKyz1oG/D79xo9F0aNTIZ2FFuTiR3JR0Yb+sLzmvuS6x22iU8rQpUXUp+pwfSx3QIMVyaJrmog5/CliI88vXb2FkHD7+lBzbDcXc0OyYYpQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|4140399003|25010399006|51005399006|19110799012|24021099003|55001999006|2604032031799003|31061999003|8060799015|8062599012|21061999006|15080799012|5062599005|38102599003|1602099012|10035399007|40105399003|102099032|440099028|3412199025|4302099013|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXEzR09RdlE0VjVoTklRa1JJNFhFUFJuZmtieW4xUU45YzZ4UVBNSGxmcXhP?=
 =?utf-8?B?dnJBSitIQjUwelZQSndUSFZYQ3VUUWQzdlY0ZG5yRGVQNFh4QlUwcGo3Z1ht?=
 =?utf-8?B?SDluYXNIbHhuNXh4cHpIbEo4VnB6T1JBb05Ya0U5ZlQ2UXdXRUNYcTgzR0U5?=
 =?utf-8?B?S2lWVWtuZzQrUkZKazZBcmN3MUQ2VXUvc2hOR0szSUZvQXRLYWFPSnBGbFp0?=
 =?utf-8?B?VWZwZXJUYXRub09nU0NvS05PcDBvWGhuNDlnYzhmK2loZU50VTFYdTRNSVRV?=
 =?utf-8?B?a0JoVGQyaGIwbjJ4STMzZFpWNEppbUY0UUwva1h3NytMRzFoMWdEaElEY0tv?=
 =?utf-8?B?b2gwR2VyTGJWOE5jTVErK1J4RlBLNGpKNUtROTJaRXJ3RUVVMkdxelpEYmdL?=
 =?utf-8?B?RnlZUHhPWXFUUUJWdSt3K2svcG50Z0pINnFydFpoN0ViRmhYL1BEcnBYRG5D?=
 =?utf-8?B?WHhZOWFHL2dxU1JWZDRiUTNTYytKYnZiWlI4N1lpeDUzRVFkcFBDRHRkVzZW?=
 =?utf-8?B?ZHZiK25XbUJXQnJxUXBIaWN4eXFVUklqSnZLMG1Ua3g5akdObFF1cjUzQlV6?=
 =?utf-8?B?Q0FZTnlzRXlmMjQ5ZHljU0c1N25EeDBSNjYxandHTmNhMkdlRWYrd1Q1VW52?=
 =?utf-8?B?dW1Cb09Kc2ZGTnJrK3ZEbC82dDBhc2FveXlRa1hNYitIV3JFWCtOei9EQXJS?=
 =?utf-8?B?aVRLUUs2TzBYeWRSSlZxWUdWeGJGOGJTZnp6bEVUcG1VeVhaNWFEK1ArT1F5?=
 =?utf-8?B?N0poWlZucmQ0YTFES2l0aFJycDRWdUV5T1lqRXB1S2V6aktNN3QvRE5lK3k2?=
 =?utf-8?B?TmVIOHgyT0RYUjQvVmRnUFVpS0xvejR6Uy9PYkFLQXJNamcyMWZsbTZkSkNu?=
 =?utf-8?B?YkszWjN3a3Jsd3JEWFo0NFM2SW9WSzlucFFsSEtJUks1SUxGMGhkRmkvdHZK?=
 =?utf-8?B?aGRyTmhseTh3ODRBQ2VmTTlYemVyaU9xYThON3pyNjhoMnJOblhXVU1SblhU?=
 =?utf-8?B?UmE1dGVDQzZHWjgzRDhrcFVzbXp0UlhDMVV6N3JJY3pPMzhuWDFGQ2ZONEt1?=
 =?utf-8?B?YmdqWnYzUzVYd0svUlJlbDR5aFl5NnNEbDlUS291V0kzeFJlMmRGTHBvMGVw?=
 =?utf-8?B?SzZDM0c0d3FndTA4U2oxY0tzSk40UGVNN1gzcUw4UWFiU0M5Vm9JWDdWcHR5?=
 =?utf-8?B?VENpZ3NNRTdIMlk1aEdIUlBLamhKM3VmclVsUFZ1NW4rUlNqRDhIUGxmSG02?=
 =?utf-8?B?S1h4L2w4Zy8vWmMrWGZoVFpkUms2MWh5RDRCektTK3laY1B5NitMc083UGxY?=
 =?utf-8?B?ZXNycTJBL0V5R21SNU5iaE9EUFNaOWs4azFLVFFjaGl3Q0dOZU1UWGhHZmV2?=
 =?utf-8?B?K1V2TVNxVUgrU3J6RWdYWUJWaU9UMVRaM1Yxbm1xQytNRzVodk1ZN1pjSm80?=
 =?utf-8?B?RzBzMnJReGFOYms1eE5DeDVmd1JxYXdNc0hYVDVtMkpxNFRKZDNQc1AxbVRm?=
 =?utf-8?B?cGRFaDY5bWhkQm42UVBqNGR6c0VyaHhSa0hDRTFmRGdOZm1VZlRMdGdpYlNv?=
 =?utf-8?Q?0YfxfjmAuo6jxo+chPg/AZqds=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NC9nSy9uUU5KUld6cmdreHFJSEIxNjhPc1BrOW9jWUZLVHArTFRnQ3VSQzZM?=
 =?utf-8?B?MEVycGRTSTd4cXAxSnVmZ1A3WEhhN0RnTnpjSXpZRVUxOHRUOUY3L0FKalV2?=
 =?utf-8?B?WXZSNGtZL0hIY09YQk9HKzAwT21DVDVLbzg0NTZaZWJWNjRncjlUSUdpQ05V?=
 =?utf-8?B?aGV6dlNYMjFjSXlnUEQ5dXdBcDJOM2NSRWc1dmFUWG9BWVg3L0R3RzNYSk5T?=
 =?utf-8?B?VlVlMTd6YTZSMVRmM2tuaWJoMDcvVW1ydWZFdlFNK2xIYjJhVDNTaGh6VklL?=
 =?utf-8?B?SGRoWmNBWmJzbW1ibzUyeWFrbHJhZkZJNzRCS205bmo4clNaY0c5ek5LM3p1?=
 =?utf-8?B?STg2b1BRV3lHMXFpbFF5ZjdWcWVySE5sa2w0ZjhwenNSSERhSmVyNTkxNElZ?=
 =?utf-8?B?SlBzZjdPSjd6VlZhKzcwY0xvUzMxdWt4QjBjbmc4U0dac0lpbEdaRWoxc1R5?=
 =?utf-8?B?ck9IZVN3eGc1TU8vdkh6UVg5Y0ZMSDZuSmtlaEJXUzlCbWxwbEFvSXE3WDMw?=
 =?utf-8?B?WmNzbGF1ZzF5WXFzdDVCNGtmTlBIR2RWdUkyZzNhZnc0SWJnNUpnSnNXZVR4?=
 =?utf-8?B?cTFoSmVJMkw4OHB3YVlONHg3STZ3NUFKSDNKT2YrSmF2bnErWUFnNHVsdGxu?=
 =?utf-8?B?YTUra0pXYzZPVGlNVUhrUmJFeVZ4S3hSNXQ3YUl4QVMyMDFNdU9aSUpDazFE?=
 =?utf-8?B?T3NFQ2t2SXh2eHFhVmF4K3J3QXBIT1pHK3JyWlNwMU5FYS9kZVQ1V1dqQUZq?=
 =?utf-8?B?dDZMWW9UeSszU2NVaW5QTStuN3lqYjVqYXkxdXZOb1EyWU52Yi9yNWx1L0l2?=
 =?utf-8?B?T2tUOFk4M1YwS0hvNk1vMWF1L3pKMEo5V3lMSmhLcXl6WHhLVTB5N0hHWHFk?=
 =?utf-8?B?alBSS2xtZWpmUUMvbEhvSy9vWitDQ0QzZkJpbHZSdW9PT2JSR2lzbFNWMURY?=
 =?utf-8?B?ZWswamRMaSt2NGNweSt4SFBkUUI2R25HVEMrc0swbVNTUGZmR0N5RUNQMXo0?=
 =?utf-8?B?RmhMZThyOWJmUDQvWVM0ZnBrSExuSnQzMDIxU2lhNXlURTg4VnlIMUtZKzdW?=
 =?utf-8?B?U2hHeERnVGEvVnlTUmY4UzlVT2w1RGNuQTZUcUJmUDArR3hBaUNBQW9Ic1Nz?=
 =?utf-8?B?bjl2aWN4V2ZCdDdTeWpzMlpnbnBKZE1qd2NaV2pwRWtSMkFvUDBJUGExM3Y0?=
 =?utf-8?B?TzNLWldKamowbzlrWHlXZWk2UDQzenN5MWNNeGZyNUVLcXI4U2hqTkZXTzU0?=
 =?utf-8?B?ME9PSVFKOUJtUGx5Z2lFdUlFbFF2eVdvcjhSUGhLVjZmZUs2K1Q0RWo0d2cx?=
 =?utf-8?B?NVIvOXRDR0pzakFDTkpHWlNOS3J1cVQrMEdLOXQ0bnlhaGlHeThuZmxVWXVm?=
 =?utf-8?B?cWtHaE94NjNSVytDTjUvM0E1bmFsNndRVm5RQjdkVDhkUm01RDRwZExPTHJv?=
 =?utf-8?B?TnkrdXJJekthMGpudjdSNTgzZXdrZHcraHBUVUpLc3k4Q2JxRHArL1hMa2hY?=
 =?utf-8?B?TFVROC9lOTRKQmFZd2VCSk5lRkhxSVZQcFNacE1idHdQZ09oc09HYzlBcUJI?=
 =?utf-8?B?OHE5bU1uOXlhdmw2TFlTbm1WWk9hcUV5NWVqTFFObzdQRlAwUnB1alFwWWtO?=
 =?utf-8?B?UjVoY0c5enp5N3lGQmJsaTBKclpXcnVNV2c0UHJoRDlyT0IvajVkek1YVnMz?=
 =?utf-8?B?aGp2Z0VFNFI3a1cxSDgrY2hrajJWOXRna09URUlhZmlXcnpOS05DK2ZGOTkw?=
 =?utf-8?B?QlI5UDhWVzVwMlpXUTRqcGcrSWVVTU1WL1JYclJ3djI0MTVHNUlYV3RER0hG?=
 =?utf-8?B?YmFKZnd6eWNaR1VjSXFoNHRodzYzdGwxall0WFJ5elVXVzVZSkwxU1Q2SUox?=
 =?utf-8?Q?ige1Wg9Bsktxi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <078DFA1FA32E9149A7267CF9F45F98B3@POLP291.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-2112e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: WA2P291MB0187.POLP291.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9090c39b-8d90-4fd5-e4dc-08df46e9233b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 09:32:04.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB0263

aHBldF9yZWFkKCkgc2V0cyB0aGUgY3VycmVudCB0YXNrIHN0YXRlIHRvIFRBU0tfSU5URVJSVVBU
SUJMRSB3aXRoaW4KdGhlIHJlYWQgbG9vcC4gSG93ZXZlciwgd2hlbiBkYXRhIGJlY29tZXMgYXZh
aWxhYmxlLCBpdCBleGl0cyB0aGUgbG9vcAp3aXRob3V0IHJlc3RvcmluZyB0aGUgVEFTS19SVU5O
SU5HIHN0YXRlLiBUaGUgc3Vic2VxdWVudCBwdXRfdXNlcigpCm9wZXJhdGlvbiBtYXkgZ28gdG8g
c2xlZXAgZHVlIHRvIGEgcGFnZSBmYXVsdCwgd2hpY2ggdHJpZ2dlcnM6CgogICAgICAgIGRvIG5v
dCBjYWxsIGJsb2NraW5nIG9wcyB3aGVuICFUQVNLX1JVTk5JTkc7IHN0YXRlPTEgc2V0IGF0CiAg
ICAgICAgWzxmZmZmZmZmZjg1YjZkMWViPl0gaHBldF9yZWFkKzB4MjFiLzB4NmEwIGRyaXZlcnMv
Y2hhci9ocGV0LmM6Mjg1CgogICAgICAgIFdBUk5JTkc6IGtlcm5lbC9zY2hlZC9jb3JlLmM6OTE4
NyBhdCBfX21pZ2h0X3NsZWVwKzB4OTQvMHhjMAogICAgICAgIGtlcm5lbC9zY2hlZC9jb3JlLmM6
OTE4NywgQ1BVIzA6IHN5ei4wLjg3My85MTI2CgogICAgICAgIENhbGwgVHJhY2U6CiAgICAgICAg
X19taWdodF9mYXVsdCsweDhiLzB4MTQwIG1tL21lbW9yeS5jOjc0ODAKICAgICAgICBocGV0X3Jl
YWQrMHg1NmYvMHg2YTAgZHJpdmVycy9jaGFyL2hwZXQuYzozMDkKICAgICAgICBkb19sb29wX3Jl
YWR2X3dyaXRldiBmcy9yZWFkX3dyaXRlLmM6ODQ4IFtpbmxpbmVdCiAgICAgICAgZG9fbG9vcF9y
ZWFkdl93cml0ZXYgZnMvcmVhZF93cml0ZS5jOjgzNiBbaW5saW5lXQogICAgICAgIHZmc19yZWFk
disweDVkOC8weDhkMCBmcy9yZWFkX3dyaXRlLmM6MTAyMQogICAgICAgIGRvX3ByZWFkdisweDFh
Yy8weDI3MCBmcy9yZWFkX3dyaXRlLmM6MTEzMwogICAgICAgIGRvX3N5c2NhbGxfeDY0IGFyY2gv
eDg2L2VudHJ5L3N5c2NhbGxfNjQuYzo2MSBbaW5saW5lXQogICAgICAgIGRvX3N5c2NhbGxfNjQr
MHgxMjMvMHg3OTAgYXJjaC94ODYvZW50cnkvc3lzY2FsbF82NC5jOjg0CiAgICAgICAgZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgoKUmVzdG9yZSBUQVNLX1JVTk5JTkcg
YmVmb3JlIGJyZWFraW5nIG91dCBvZiB0aGUgbG9vcC4KClRoZSB3YXJuaW5nIHdhcyBhZGRlZCB3
aXRoIGNvbW1pdCA4ZWIyM2I5ZjM1YWEKKCJzY2hlZDogRGVidWcgbmVzdGVkIHNsZWVwcyIpLgoK
VGhlIG1pc3Npbmcgc3RhdGUgcmVzZXQgd2FzIHByZXNlbnQgc2luY2UgdGhlIGluaXRpYWwgR2l0
IGltcG9ydCwKY29tbWl0IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKS4KClJlcG9y
dGVkLWJ5OiBzeXpib3QrZmMzYTQ0ODA5M2MxN2E3OTIzNjhAc3l6a2FsbGVyLmFwcHNwb3RtYWls
LmNvbQpDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD1mYzNh
NDQ4MDkzYzE3YTc5MjM2OApDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5
OiBIYWJpbCBFcmVuIFTDvHJrZXIgPGhhYmlsZXJlbnR1cmtlckBob3RtYWlsLmNvbT4KLS0tCkNo
YW5nZXMgaW4gdjI6Ci0gVXNlIHNldF9jdXJyZW50X3N0YXRlKCkgaW5zdGVhZCBvZiBfX3NldF9j
dXJyZW50X3N0YXRlKCksCiAgYXMgc3VnZ2VzdGVkIGJ5IEdyZWcgS3JvYWgtSGFydG1hbi4KQ2hh
bmdlcyBpbiB2MzoKLSBBZGQgQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgc2luY2UgdGhlIGlz
c3VlIHdhcyBwcmVzZW50CiAgc2luY2UgdGhlIGluaXRpYWwgR2l0IGltcG9ydCwgY29tbWl0IDFk
YTE3N2U0YzNmNAogICgiTGludXgtMi42LjEyLXJjMiIpLgoKIGRyaXZlcnMvY2hhci9ocGV0LmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2hhci9ocGV0LmMgYi9kcml2ZXJzL2NoYXIvaHBldC5jCmluZGV4IDI4NWM2MDM3NDE3YS4u
OTQ2YTM4MDZmNjY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvaHBldC5jCisrKyBiL2RyaXZl
cnMvY2hhci9ocGV0LmMKQEAgLTI5MCw2ICsyOTAsNyBAQCBocGV0X3JlYWQoc3RydWN0IGZpbGUg
KmZpbGUsIGNoYXIgX191c2VyICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90ICogcHBvcykKIAkJ
c3Bpbl91bmxvY2tfaXJxKCZocGV0X2xvY2spOwogCiAJCWlmIChkYXRhKSB7CisJCQlzZXRfY3Vy
cmVudF9zdGF0ZShUQVNLX1JVTk5JTkcpOwogCQkJYnJlYWs7CiAJCX0gZWxzZSBpZiAoZmlsZS0+
Zl9mbGFncyAmIE9fTk9OQkxPQ0spIHsKIAkJCXJldHZhbCA9IC1FQUdBSU47Ci0tIAoyLjQ3LjMK
Cg==
