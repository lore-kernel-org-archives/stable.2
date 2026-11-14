Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794672875;
	b=ZUoGtR1b4VpUz/WCDns0CJd4lrCVwFwMt+1Xa0kRiuDthZYg6uJTCXX+rj+nqtlJHTKX
	 SoiV2nJpcb5iZ6GimKVT8ay9zFUP6CUyMThMhChKZDVhyAvufSArGQ5fhsK2bFWL8yNxW
	 2p5NoJ3dbOq15oxH46ZW3BWFGpSr5RauHZYRJ9h3xYkz8J1/DE55UJflEop3ZhyD8gCa2
	 20+f7x1o3eL4fJ46DzrEfEiJwt/HlMi7pfQWY0KbhTqc860MicjLB8xbNreAGnWK1Ef+E
	 DPMtVftC/LkskLM2mQymdj/OxShkQLzKBfN+3ziFyOcIMM6cGGH6ay/K/zAhxYB42JA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672875;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bzVqtTZ0pN+Ud/YWYMD657aw0fzCjxTKJ5EnPDPBcEw=;
	b=5f/vJK0GjENxgOeLCoYFPUO3UjEW2NGx9K4/sQ+3yEx8SetuZjFYiI20P+SkuA4jXLYb
	 jeX5McPieBHC7XVkTwPZyBJYzONKswERNsi+SdBYFISmCksfyKcOqzmdcZebi6grhNRWd
	 dvQ4fg9f3HJWKQ+kH2uCMyQGflzixzkBh5UlYlLZzRjHf8ARrhM32Qb3prPs3puigwm/R
	 Rnc0Q1cmy7QUgEVJcJVOoGsraIRUGp3pneg+dXMipvKnw99NAGE17nZwBMAxdSzE0LTEr
	 uxCU/WpoPriMYKsDwbBGeURuE6mXbL+8765tCosdUW9XYl1pvSJKQcjmrGZNPxBoDXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=p86+R1OI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.16
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010016.outbound.protection.outlook.com [52.103.23.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D20606A333;
	Sat, 14 Nov 2026 16:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D20606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=p86+R1OI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnzOW8CRUs0aizmcpEckEnzS9iXuN+Xs5bAQ17X08yn4noXL5L40fenwb9T9P9yVBVZ8loQeFSLXnvfhTpJ+uuUf5k/o07tgxH2fLHfTGRmxL0nfKZLrnkQVU3zTAtnKf5sjW5sg+MAmW5nqQSpmDxVeUbyGr2ToUnHfJ3ODCG6zVLQDIlECBbEBwsnZmAitWmWv3ywcAtgxceG9C2DfgE9O25VUbhcbuE8aiDjKXzCEDqCPiusNzWil62OdmQn360P+SOp61fNDMTyFalk+PYj+j7XeQtM6bx9I6S1ZbdoQVkHbK1RsMmcbOSEJ6smzE++CyRK4MoKVPsZgTLDgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=bzVqtTZ0pN+Ud/YWYMD657aw0fzCjxTKJ5EnPDPBcEw=;
 b=VyU0oZ9F/y5/AMZv7Dhg8gmoCQ0IvXwQ/b27fBie44QHpWIjwf/j30onOOihooLuzrdbOxBfM8Nmhok3pFiGdC6jgw/QtSFFtLUTE8d6Al5mkn72GlpF1Cdr8Y3Os00YWbr+88tum9oFOyAwQ6zTnu84kn/GPmqJqxA6CeIqm/vfgMJbKem27CzwzNcCEPWNZIPxSIL7J9BP7V50Ekrc6U7CD8LhAi9XZUmeJyncnh5w1/hAzxtJK/g2nWR0HQX17GrFLr/ILg19oPWhsT0Crgyfx8p1vPUxsM53OP+jx1uNGwY8xshzL+ZW3wWLlTWkjQDoFlY9XIygM5pYUyexAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzVqtTZ0pN+Ud/YWYMD657aw0fzCjxTKJ5EnPDPBcEw=;
 b=p86+R1OIGaTp5graRqexSKj67Cc41XYJ15EJIcjR9WbNgIHV2v3u6zdCHR5jK8/9RY3c1DBs5dOjdnJizTNB3v1t/0uWp1//soU8y/g3Q7vJq7aMi/JnFc7q0o6vXN4C02Cc33RkBbukj+nOWQfjdCTXKbd/gS98r3Mh9ceirLb4NKPEw0GPsa3Tvqdyx549q7vkdat5HvsvncthXDB5/5bXxeZ6q6dshzedAzD8gXEkAN+/JraDKBrFCfRAK8gw8RdtESIpUjWmRLEswu7G5kbhYUFKNQxcM5TtyYUhdGYUK9tRvX7Teb++3RaBaGeK+LkN8EwJIoq7F8wWuAeR0A==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by CY5PR05MB999471.namprd05.prod.outlook.com
 (2603:10b6:930:128::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 16:12:35 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 16:12:35 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "gang.yan@linux.dev" <gang.yan@linux.dev>,
	"kuniyu@google.com" <kuniyu@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "matttbe@kernel.org" <matttbe@kernel.org>,
	"martineau@kernel.org" <martineau@kernel.org>, "geliang@kernel.org"
	<geliang@kernel.org>, "ycheng@google.com" <ycheng@google.com>,
	"weiwan@google.com" <weiwan@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Gang Yan <yangang@kylinos.cn>
Subject: [PATCH net v2 2/2] mptcp: avoid wrapping blackhole timeout
Thread-Topic: [PATCH net v2 2/2] mptcp: avoid wrapping blackhole timeout
Thread-Index: AQHddFL2PWggbVvm20GMWHcq6JrRTQ==
Date: Sat, 14 Nov 2026 16:12:35 +0000
Message-ID:
 <070c69fa36f83fe47a5eb6d1434f543dabe930e7.1794672619.git.x-professor@outlook.com>
References: <cover.1794672619.git.x-professor@outlook.com>
In-Reply-To: <cover.1794672619.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|CY5PR05MB999471:EE_
x-ms-office365-filtering-correlation-id: 3c632368-98c7-4754-4319-08df426a1896
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|38102599003|51005399006|8060799015|8062599012|19110799012|24021099003|31061999003|25010399006|24121999003|4140399003|15080799012|22091999003|40105399003|102099032|30101999006|440099028|3412199025|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjE4SjM3SHBjN2RoK0M0amxKTllsdkZFMG1NSVVDZE5DbkorOGd6VFdSc2dn?=
 =?utf-8?B?NnQ0NGRBUmU4YkFSN1U1YSthRmJHc0h1S2FOUE5QWTlvUTk2SDZ3OW9iNC9P?=
 =?utf-8?B?VWgyOE1zOEtFM0lSaU9VcUE2SzYyV2NEWVRUcjM1YVUrQ3pzUXp1MnNiSFNI?=
 =?utf-8?B?L0FlUUdpL2Y4UU5RS2JZTmVpaFRMWnlqTkl3dXNVdXVqLzNydWFtY29WRDBB?=
 =?utf-8?B?Vzh6RStybVNoNm8vUjBpd2NRaVJTb1ZCbDlQa2hwbTFlQmdWOWtBTVFKTkhU?=
 =?utf-8?B?S21lSXNuVGF5T0swbXFPcGw4QzdHSm83M0cvaFFOZ2x0K1NWbzlpOXBZbFhk?=
 =?utf-8?B?NEUzWVhsVHh5SnVqSFg4TFVaM2lqSFRadWt3dDMwRGxSK2hMTzMxWndVRnF5?=
 =?utf-8?B?TVpscmR0TGdHS3AwdlZuZ0dXVi9VN1RMajFNT09YSXFUMkZDQjZBdklteG5J?=
 =?utf-8?B?QllCQU9Xc3p0UFFZYTJQS3kvQ2M5SzE4TE9XcXRubnByWmMveXlIWmREVXJq?=
 =?utf-8?B?QXMvYjRXbWNUMThKTmk3eEFNZGthUjljbkJpV2ZnZTV0cWFQZHdLVk5kS3hN?=
 =?utf-8?B?clViZTZ0VXJsOXU0anR3eTdqZ1grakFqZ0FsTDlzNWVCVlp2Tk04WGdaVUFG?=
 =?utf-8?B?cExoNDcySzJzcDBUdW9BK0g0aURGMldRRU9hUFRFMktwZWFQd043cXRSOE5P?=
 =?utf-8?B?aGJ2RXp6OUQxczU1VVlZdkZ2QjZSVHhqWVRlQWhRVG5tcm9wY1JLSmNrUGQ4?=
 =?utf-8?B?MzJ4V1h5UFJBL3p1Sno3c3V1S3dMT0g4VG90bzBrYVB0RWl2WEMreGgvdXBS?=
 =?utf-8?B?cVk3Y09VNVRXbnltNjk0Nm9XSUFHUDV4Q1ptL0FFWHJ2eEhENGd4MHMxWTBN?=
 =?utf-8?B?WSttVjEzMXNmMnI5SFlLUW84NlhZUTdVQTkvLzNUVHZ4b3ZxczJ6ZnM3cFFF?=
 =?utf-8?B?dElBakRXaEVTb3RaL3UwV3gwRXpKWVc4Z01mZENRbWI5YzRBdTdNSHZmN25G?=
 =?utf-8?B?VkZkOEp6N2xQNE9lTXcvb01zYTZCdG12b1FybExwTTlwbzcvejE5aytlUFRX?=
 =?utf-8?B?UzB0dHd5MVQzVUVyTmhwOXJTSlc5N3ZDdDYxTU91MFI0dTJDNy9sU0NKZGZo?=
 =?utf-8?B?YkdkZ3dUUkN0V1dObmJOdFY0MHpkTFJEbTV2UUF5QW1kVi9BNWp1Mll2NGdz?=
 =?utf-8?B?VXA5dnZMYUVuMWxpMFRNbVNSeEhlUGlMd3AwdVNXaVdtam1CSGlIelZTdlNy?=
 =?utf-8?B?THVrQmJ6ODZ1dU02Z1RWbTg4TWZYU3hJT1BHSHd1S1owbHVyWFk1Z1Rhc3dr?=
 =?utf-8?B?VytkQk5keExWY056RFVLa3MxaHo5RmFjajhPcHNTODlnNTEvc0ZaTzNoakMy?=
 =?utf-8?B?NVhPVlVVQXo4ZFVoUDBXNC9PMkhodHIyeGE2QVlJNnpHRWg0dzVBd3Zua3Ba?=
 =?utf-8?B?S2ZqL2VlbXdQa3QrMEwyckVzVXI1Wjd1SEhMTmxqRXJWeFlVOHRsNURZdWdU?=
 =?utf-8?Q?T3J/XiGDOCkUb7l9kHlD4H/fHwW?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnFna1B0MytxT3ZNVDVvM29LZFIwc3l0T1JJckFDSmNtUzhZRkR5ZTUxTHdl?=
 =?utf-8?B?U0RvNWZtRDFNYUtzMHkyTm5aM1QxYkVlMUhCUWJ5MmlzNkNZTFg4czNsa0NE?=
 =?utf-8?B?ZmZrcFBGdDl1dmZncmpkOU5ubjZwanNWYWU4RGlwcFUwYmcvVEhXcUszWk1S?=
 =?utf-8?B?a0MwSUFJa3pTVS8zaWJuMEUwRHRHaitSMThhR1J0MjZWbHNhYis3SUExN2tG?=
 =?utf-8?B?NnRWYWhhck5KUHVXcWNrT3FVamxmRGx5blgxdXYyVkxRVEhZVXBXcTVSRnRp?=
 =?utf-8?B?NkJ5ZTdvN21VdmNLdGxiOGJpL1pacTRTclkzdUNKNXlpMVY4NUJyOW4razUz?=
 =?utf-8?B?K2QrRnV0MnlITWg1NXlobnZzWjVQSThPZ3NtN3ZHc0NTeUFhdVdLa2YvZ1FE?=
 =?utf-8?B?VzAyVkFCa2JSejB1UHpteWQ4U3RPNEdWbG85WXByVkVSSHROSjJ4SzNSMnRn?=
 =?utf-8?B?a3JHamp5dDVLUDExK3lIM2I4WElWUDE2bkZpQmVkZTg4eHp1b0wxOWNFYS95?=
 =?utf-8?B?YlpQLy9FRkRGVHE5d1dmUDduN2VBQmxlNUZBYTk5bVk1YVlncGNpNUVld2J1?=
 =?utf-8?B?ek1XSlU4SGM3N1JFa2taUDliNk5KMCtmMytJVjRvUk4rZ1M5K1RTQy9iMFFl?=
 =?utf-8?B?THdmWm1IS0RaaFRwazdtQzNKZy9zUm5iTlJCdWNTbElvNFd4S1pqQjZlTy9x?=
 =?utf-8?B?OTduazJjRlBzZ0pEcnREbW5EVWl3ZkJzdHRxQ1dsQTJ6VWVFTW5ac1lEQVZM?=
 =?utf-8?B?V3RyUHhWTWpoMTlKWVllbVVOZXp0TVg1NEVVL0o3dFdrNkNPMGFTVHAvRmVT?=
 =?utf-8?B?WHBsTzUvYThBWmtadFZka2ZKMFpLSzhwU0ozK0RHRTNpbWxPSlRCM0lJN2Uy?=
 =?utf-8?B?ekRaVzc1dTg2UHExc3ZNL010NWNhZndpZ1ZFVzNQVVZBMlJpQ25xS09odnUx?=
 =?utf-8?B?enh5amVwRG10RjRCYVYzVzMrZDBHV3RYTi9FbVJLYlUwN3hQUXNhUTYzdVFp?=
 =?utf-8?B?aGIrNXZrQ0RzOTRmZS9IVGc3UCs0T05HZ3lheWUwK2ZLSjZmdzVObFhsVk5m?=
 =?utf-8?B?Vks0OXVJSGRsTmtBaVhaZkFtUnE1UTIyNGlPS29CS3FWVDVERXJaMk41SmIz?=
 =?utf-8?B?V3dPL0pJN0NxMUU5MEphbDZJdThFTGJvYjRCUTM4Q0FwMFpUL1JhUEcyVVFQ?=
 =?utf-8?B?MmJYQVZtd2tCTFBMSm9sTFhTTDEwZXRmbkxPV1F1MUFJSE8rcmVKUVNOVWhi?=
 =?utf-8?B?WVY3TEZ6SS9VajhiYkh6aG91eHUzTU1KNFk2QWFnU0VUblVRdEZtYVdkMCtw?=
 =?utf-8?B?RnNuNUJ5RjFnejhNWlkyaktBU3llem1UbWYzaDBxallFaEMvNWlSNnl0QTRM?=
 =?utf-8?B?NVZpeE9OdVFZVENXbkpzK245S1dBWG5abE50djdwUEFueXBmVERhdXQzRlRT?=
 =?utf-8?B?R0ZEOFVlRDM1RDJEQVh4Y2RCZU1YVFVJVG5sa0lvMVNPbFBXQUI1VElWV2lv?=
 =?utf-8?B?SjQwU3dKTUFBSnVLaWdQQ0ZCVWROWHhPcHJuSjk5RWNZbytJV3FWYmRrdmVN?=
 =?utf-8?B?L3VDYW55MkV3a21vQXloTGRhSnQ0UG1nRm04WVdkcTN3S3pqc1prUHp0ekN4?=
 =?utf-8?B?R0s0aklraFVCcnVFVEczdDNrQ2ovZkRBUUVSaUtDbDlIdktuOUhBeWhmVmIz?=
 =?utf-8?B?SitPZmFITGNnWExWNjVGbnJ1TVlzY0dSbkkvdk4zVnlQU3c4RHZjbHRZUlcy?=
 =?utf-8?B?U0R5a1N5L0ZLZ2hxMks3djhJT0JNcUJ6UXFNY1ZwTkNZaHljUitUL2RNWll4?=
 =?utf-8?B?V2tWdEdVdGZUVnovRTR2SnorTlh2RjExZm9JQXovaXpKNzROdmY1RXVOZ3h2?=
 =?utf-8?Q?jZ3ZMlWk0Yx6y?=
Content-Type: text/plain; charset="utf-8"
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c632368-98c7-4754-4319-08df426a1896
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2026 16:12:35.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR05MB999471

bXB0Y3BfYWN0aXZlX3Nob3VsZF9kaXNhYmxlKCkgY2FsY3VsYXRlcyB0aGUgYWN0aXZlLWRpc2Fi
bGUgaW50ZXJ2YWwgYXMKbXVsdGlwbGllciAqIGJsYWNraG9sZV90aW1lb3V0ICogSFouIFNpbmNl
IGFsbCBvcGVyYW5kcyBhcmUgMzItYml0LCBhCmxhcmdlIGJsYWNraG9sZV90aW1lb3V0IGNhbiB3
cmFwIHRoZSBkZWxheSBldmVuIG9uIDY0LWJpdCBrZXJuZWxzIGFuZAptYWtlIGFjdGl2ZSBNUFRD
UCBhdmFpbGFibGUgYWdhaW4gd2hpbGUgdGhlIGJsYWNraG9sZSBpcyBzdGlsbCBwcmVzZW50LgoK
Rm9yIGV4YW1wbGUsIHdpdGggSFo9MTAwMCwgYSB0aW1lb3V0IG9mIDY5MTIyMTMgc2Vjb25kcyBh
bmQgdGhlIG1heGltdW0KbXVsdGlwbGllciBvZiA2NCBzaG91bGQgcHJvZHVjZSA0NDIsMzgxLDYz
MiwwMDAgamlmZmllcywgYnV0IHRoZSBjdXJyZW50CmNhbGN1bGF0aW9uIHRydW5jYXRlcyBpdCB0
byA1MTIgamlmZmllcy4KClRoaXMgaXNzdWUgd2FzIGZvdW5kIHVzaW5nIGEgc3RhdGljIGFuYWx5
c2lzIHRvb2wuIEEgbG9vcGJhY2sgcmVwcm9kdWNlcgppbmR1Y2VkIDEyIE1QVENQIGJsYWNraG9s
ZXMgYW5kIHdhaXRlZCAxLjIgc2Vjb25kcyBiZWZvcmUgb3BlbmluZyBhbm90aGVyCmNvbm5lY3Rp
b24uIEluIHRoZSB2MSBhcml0aG1ldGljLW9ubHkgdGVzdCwgdGhlIHVucGF0Y2hlZCBrZXJuZWwg
cmV0cmllZApNUF9DQVBBQkxFLCB3aGlsZSB0aGUgZml4ZWQga2VybmVsIHVzZWQgVENQIGZhbGxi
YWNrIGRpcmVjdGx5LiBUaGUKcmVwcm9kdWNlciByZXF1aXJlZCBuZWl0aGVyIGtlcm5lbCBtb2Rp
ZmljYXRpb25zIG5vciBmYXVsdCBpbmplY3Rpb24uCgpDb21wdXRlIHRoZSBpbnRlcnZhbCBpbiB1
NjQgYW5kIGNhcCBpdCBhdCBNQVhfSklGRllfT0ZGU0VUIGJlZm9yZSBhZGRpbmcKaXQgdG8gdGhl
IHNhdmVkIHRpbWVzdGFtcC4gVGhlIG11bHRpcGxpZXIgcmVtYWlucyBsaW1pdGVkIHRvIDY0LCB3
aGlsZQp0aGUgc2VwYXJhdGUgY2FwIGtlZXBzIHRoZSBkZWxheSB3aXRoaW4gdGhlIHNhZmUgamlm
ZmllcyBjb21wYXJpc29uIHJhbmdlCm9uIDMyLWJpdCBzeXN0ZW1zLiBQcmVzZXJ2ZSB0aGUgZXhp
c3Rpbmcgc3lzY3RsIGlucHV0IHJhbmdlIGFuZCBiYWNrb2ZmCmZvciByZXByZXNlbnRhYmxlIGlu
dGVydmFscy4KCk9uIHRoZSB2MiBrZXJuZWwsIHRoZSBsb29wYmFjayBibGFja2hvbGUgcmVwcm9k
dWNlciBjb21wbGV0ZWQgYWxsIDEyCmNsaWVudHMgYW5kIHRoZSBwcm9iZSB1c2VkIFRDUCBmYWxs
YmFjayBkaXJlY3RseSBpbnN0ZWFkIG9mIHJldHJ5aW5nCk1QX0NBUEFCTEUuCgpGaXhlczogMjcw
NjllN2NiM2QxICgibXB0Y3A6IGRpc2FibGUgYWN0aXZlIE1QVENQIGluIGNhc2Ugb2YgYmxhY2to
b2xlIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKUmV2aWV3ZWQtYnk6IEdhbmcgWWFuIDx5
YW5nYW5nQGt5bGlub3MuY24+ClNpZ25lZC1vZmYtYnk6IFlpbmdqaWUgV2FuZyA8eC1wcm9mZXNz
b3JAb3V0bG9vay5jb20+Ci0tLQogbmV0L21wdGNwL2N0cmwuYyB8IDEyICsrKysrKysrKy0tLQog
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9uZXQvbXB0Y3AvY3RybC5jIGIvbmV0L21wdGNwL2N0cmwuYwppbmRleCA2M2M1NzQ3ZjBm
NjMuLjBiMTBlOTRlN2Y0MyAxMDA2NDQKLS0tIGEvbmV0L21wdGNwL2N0cmwuYworKysgYi9uZXQv
bXB0Y3AvY3RybC5jCkBAIC00ODcsNiArNDg3LDcgQEAgYm9vbCBtcHRjcF9hY3RpdmVfc2hvdWxk
X2Rpc2FibGUoc3RydWN0IHNvY2sgKnNzaykKIAl1bnNpZ25lZCBsb25nIHRpbWVvdXQ7CiAJaW50
IGRpc2FibGVfdGltZXM7CiAJaW50IG11bHRpcGxpZXI7CisJdTY0IGRlbGF5OwogCiAJcGVybmV0
ID0gbXB0Y3BfZ2V0X3Blcm5ldChuZXQpOwogCWJsYWNraG9sZV90aW1lb3V0ID0gUkVBRF9PTkNF
KHBlcm5ldC0+YmxhY2tob2xlX3RpbWVvdXQpOwpAQCAtNTAxLDEyICs1MDIsMTcgQEAgYm9vbCBt
cHRjcF9hY3RpdmVfc2hvdWxkX2Rpc2FibGUoc3RydWN0IHNvY2sgKnNzaykKIAkvKiBQYWlyZWQg
d2l0aCBzbXBfbWJfX2JlZm9yZV9hdG9taWMoKSBpbiBtcHRjcF9hY3RpdmVfZGlzYWJsZSgpICov
CiAJc21wX3JtYigpOwogCi0JLyogTGltaXQgdGltZW91dCB0byBtYXg6IDJeNiAqIGluaXRpYWwg
dGltZW91dCAqLworCS8qIExpbWl0IHRoZSBiYWNrb2ZmIG11bHRpcGxpZXIgdG8gNjQuICovCiAJ
bXVsdGlwbGllciA9IDEgPDwgbWluKGRpc2FibGVfdGltZXMgLSAxLCA2KTsKKwlkZWxheSA9ICh1
NjQpbXVsdGlwbGllciAqIGJsYWNraG9sZV90aW1lb3V0ICogSFo7CiAKLQkvKiBQYWlyZWQgd2l0
aCB0aGUgV1JJVEVfT05DRSgpIGluIG1wdGNwX2FjdGl2ZV9kaXNhYmxlKCkuICovCisJLyoKKwkg
KiBDYXAgdGhlIGRlbGF5IGZvciBzYWZlIGppZmZpZXMgY29tcGFyaXNvbnMgb24gMzItYml0IHN5
c3RlbXMuCisJICogVGhlIHRpbWVzdGFtcCByZWFkIGlzIHBhaXJlZCB3aXRoIFdSSVRFX09OQ0Uo
KSBpbgorCSAqIG1wdGNwX2FjdGl2ZV9kaXNhYmxlKCkuCisJICovCiAJdGltZW91dCA9IFJFQURf
T05DRShwZXJuZXQtPmFjdGl2ZV9kaXNhYmxlX3N0YW1wKSArCi0JCSAgbXVsdGlwbGllciAqIGJs
YWNraG9sZV90aW1lb3V0ICogSFo7CisJCSAgbWluKGRlbGF5LCBNQVhfSklGRllfT0ZGU0VUKTsK
IAogCXJldHVybiB0aW1lX2JlZm9yZShqaWZmaWVzLCB0aW1lb3V0KTsKIH0KLS0gCjIuNDMuMAoK
