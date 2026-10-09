Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F221B983F;
	Fri,  9 Oct 2026 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505664; cv=fail; b=VGQlHY91tGtlg6W5h5JS3fO1UtfW/BpZWrsN2QV5PShDZ7KC6KWOdcHwGHmi1KYHUbf4y//rG2uIcZz1fFBr0mfNwVTkIfpSrT2piUT0w9jB8gtTfI3OhNOiR5fq76ZEP3xv5atAahub4PwV4aQvQtNeZzE9QUfasf7iJeh2pHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505664; c=relaxed/simple;
	bh=awQyd3/5sQv/osorHw4iRHGEOvbUDlDc4Bf7WH0Gj7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvenHBJXdnuik4nXSoKyskhLisLQO1FF2A6tIbw9tGOxMdUsQ+sX7YzSij/yWATjSG55kKHJc0VQtaSR48273rslYMEBInf6VC9wYKPWduvRcJl0coSNLjQOR8npbZyV/psoDMAJ6czj5jQsMVIzViKe451dXbkoW6S+XonrQV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W/ZJwUMR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R4ot3sNp; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Uwjb4NEp reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W/ZJwUMR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R4ot3sNp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Uwjb4NEp"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698L06i42680019;
	Thu, 8 Oct 2026 17:27:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=awQyd3/5sQv/osorHw4iRHGEOvbUDlDc4Bf7WH0Gj7M=; b=
	W/ZJwUMRztl43C4invDfL0p+9YE7A91gTZXaxm/HQKnWIWhwVeDeVvK/pD2IS8JD
	cSxEarBSh3pVawM+1Xu6Va/QXEyead5xq4nyqpNzhwUFcPfZRaI/hIABIJQt/1Lp
	yBParOJrFAUceeR3aDXF9JAW+8yl9dl+typqRaUyN6WyguAUSIrP7awSVLk985VV
	Ouoy7509+/YeErVdVW5sMYY3dDsHB4R9tsqlYAnpBpgsgMYyTSMD40a0k4s0lIcu
	BUKOFE/6xaulxprLB4et4VuUueEevyD8QoIBs5WSNzsS+uodc5wM5VYGf5B/it9h
	DguZ3cmJEEZ/Hr3JPH6Kjw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4h6jp9167h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 17:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1791505650; bh=awQyd3/5sQv/osorHw4iRHGEOvbUDlDc4Bf7WH0Gj7M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=R4ot3sNpk+nO/n9Ko1csEIWHPjRPUSr15Z5Ud4a6XtpQv+RMAyz9p0K0Ht/enKUYk
	 hFZY65TqpCfOiiH+tehUbXo8rM25lJgNU0BmZHUF038tChqzLrfd/VzHn6lyE/YIZZ
	 psv8ZuOWFxWbXIl4DO1R3YEN+c0qcD81gn4D0syg3Cax6Dj0G3tkRgIFObQt2E/w7b
	 h79QXIAk9Txvm5zaZl2VU/RyfqnGnuv1BC44fvpMGt3NEA6xbeerzyZrnVntg9+ivg
	 rnlez9YgSScY2n5DVW+dqSa7yaWCnEohbf+C4ZqroNwPbuSIj1TN9ImXlsBIIVTINw
	 6CnetCSd2T6ug==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7DC61401DD;
	Fri,  9 Oct 2026 00:27:30 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 52E91A007A;
	Fri,  9 Oct 2026 00:27:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Uwjb4NEp;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00407.outbound.protection.outlook.com [40.93.13.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9AB994024D;
	Fri,  9 Oct 2026 00:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmwdBSwFrQ5VHg84feUmugFZn32rtmNXVLWxUh9Mxt5+MsR6M7uiMjmN8yCe9s9zkPPVjpK5Kkg14H0Zv7mHdNyJBtRSG9jN6WDVGyQ94/rOz7CFtH/7IP93LVP5AJRAPAZBRO42pUiwrLQIh1FRdaoT2L3+YDQgPZ8PbWWIdC/hwwjC4HyV6bRbpx2ZuDiaujEuVZPiY0unA0KxkqxhhoC0ilzpGS5UghOCb7ubBcCMF7vf2qFyF/x99Zcc5OL7rYMBSsM7Zx9Vvs0MLW2i5Vh353be4R/qvGIhG7sEpm+7NGZrS7cy/PrtxBGpCwEFmEDM+LF1csepal5Eni9CmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awQyd3/5sQv/osorHw4iRHGEOvbUDlDc4Bf7WH0Gj7M=;
 b=lssshWRglACThQb1tI0IUsKQif6Tb4u0CYU0rnxNbGE+xUHVrfdeo6s5En+qNGwMLAfBKLhSrqYnx4dImoM5yiEc9ufRUdgZIhaF2ExPXjFEN2jRe6lKJfNEDgGqkF9xwBOX6AdDTH/f2XadjAB9muUpe3OfdlfwyU35fF7E7/AgXVd0dYHJ208Qp4jU2u+UYCOrdQ+9caZ54266vQLjLNeWh0DbNcG7A1yBGq0WVjNna1lA1YyVEc+rWE6EbN8RlVXHLpdyfRici1qWhHUPfSdPYgtus9hCh7nFMZY/3okAzXrBUmpRK98yR3p7z90VPfuwtWPpmvrwquP1O/9u9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awQyd3/5sQv/osorHw4iRHGEOvbUDlDc4Bf7WH0Gj7M=;
 b=Uwjb4NEpoDCuiH6zD4KbXpqonuPuA/1odztFj87MxyMtHagPGQZt/WYWfm/ql06fYTLfKi1IHZgdKIoDGOngWwA5N8sxMyyUSWmfDS9jytoHYko6WMSoHgc19jt3CWHKLhpNs6g+Qx3oD3aUo+OJvzdYOid/FTR36992E4SnGaI=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 00:27:24 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 00:27:24 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "pritam.sutar@samsung.com" <pritam.sutar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Index:
 AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCAgAS6jYCABYeXgIAAj9uAgTzV/YCAB0WsAIAAQgCAgAXz24CABaAIgIAAq3WAgADGm4CAAATnAIAAo2GAgABNrwCAAUxggA==
Date: Fri, 9 Oct 2026 00:27:24 +0000
Message-ID: <asglyrMYkopr3EOz@vbox>
References: <arsnMM-GvuXwBKCX@vbox>
 <5d7501ea-4579-44a5-9a7e-91ef1f10b2bb@samsung.com> <asBhDmy-3DymDKQH@vbox>
 <3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
 <CGME20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6@epcas5p1.samsung.com>
 <asWmW1jmzedIV5SP@vbox> <ff5d6900-374b-44d8-967f-0af16ae53437@samsung.com>
 <98f16da0-5e24-4dd1-8f9f-79a1a5e7656c@samsung.com> <asbJfaj5OIhHBunD@vbox>
 <bc43e3f5-ba0c-4f91-b765-ee35021bf089@samsung.com>
In-Reply-To: <bc43e3f5-ba0c-4f91-b765-ee35021bf089@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DS7PR12MB9476:EE_
x-ms-office365-filtering-correlation-id: 2b8b9f1a-de5c-44a6-97dc-08df259c174d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 UJ/MgMT+na9dcGUc41SSxuo6J/Rd3XvSk4ECptLNhz0iWhhx9hjSwxFiuDkgNIfDIORXJ1MfHlagkwRV2lzXvCF3ZhzDC3ukyFMFAcXgfH4+5K1qdW/9MZmA32DTnW+bQiOv0X3e80ATQZJCdEqZnyCbTX81l2Ict7RdAyI+V6cAykey9Zpb6Vt2y7zisrIQc8GX2bFuOmoFumac4gwb++xsR8Fg9De0IPVd2X+oXQ0sEJy97cdbS5yQqJ9gqvcTp5Gro4aooEBAFUY/uC+7WmQi3mJh/tXAXFwflSPjyCsC/sD5fi2t80UjXGIC5TafdDgN3G49GVY4rym1Z015miZgfSKtxSoeKvDxBpH83mERl7KXqoKFvkuQUci9OcpdUbFslU9nkOhZYMzpW2s1Qw3BKW/frTeC4tHBoU6oXsrW/1K4GYZ0ut2EzNl4IFnTiJlda1MYD2ihPpwtGqBq83+OkTfMp60cQRP9RgEXOFsHC+pRTFbPRsmEc7hx4FVB6kVBXE8++GhlTPfhTidF4lCKuWT3I2freO9cUMGHlKJJuvTjM/TzudcXrLwM/vbTlUq4HeVNnPkFykKaAKTbs2XE/y6wNdjo09y9dYLCQOuYXKAn1qMtezwvhh3Z0jREV1AJb5vOG77/kv9Sah32nEp06Af85hgfrWRfTmuOmobhie2gg4lMWBwaJFOdQdn0rjd1Q5z73LkF0OMGXiMWKfmpuKxXznf6cBVbeRqnTIs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MS9uSlk1MERsczRzbnM0RnZuSnB2Wktra21oK3RmWEVjYmpNcDdjS0Q3RWxC?=
 =?utf-8?B?NjhyV3hGSmJJZFpnZ0s2aExYMWN1aG4zYkJnZEE3Q3l4VzNWeVgzbFJJYU9t?=
 =?utf-8?B?OE40NXQxS0xaZTMrc0FDZXhFOUdraHpxaW9HQWozK21mYmc0K0lzVGZJdE9P?=
 =?utf-8?B?dmIwNENkdVZxUVVYMGNSWEVCZzFJWGRYVXlKOFVBQ2t1cWJtbDRWWVFtdUND?=
 =?utf-8?B?bzlaUkprVENiZWNjNTN0amprdUJKTXNib08yWU9lT25kMjFGWG5iSzc4cFVL?=
 =?utf-8?B?bjlIb0NyWlBsY2o3N0ZYeVF1a1JPRURpSGp4RWJRZC9qaVRpN09qS1h5a0Zo?=
 =?utf-8?B?Z21YakREUVgramx1cDk3aG04QjNQcHJwaE16eW5XeWVDUjlHVWt1d0pMcGh3?=
 =?utf-8?B?c2FwQUhUbDJVTDhMdkFyWkNieFZXZFRzOURYRU5jQ29zSWJOdHRkdmxVb2V5?=
 =?utf-8?B?cGdjOHNJVDhQL05SQnJ4a1p0ZCs2UGptdTMyTkZaWEp3S3RQZEF1aiszaXA5?=
 =?utf-8?B?bHJNZm1QU1p0citpRi9mb1loRERQWVBLNDNwY3cwaUdVMzMzTEhFcGRlMXAr?=
 =?utf-8?B?NzAzRlhQYnRESVg2MzEzbWJlb0pMMSs0Mm1EYmk2TlVSemkyMmYzUGdvVTgx?=
 =?utf-8?B?cjAwNExQSEdQbURzb1Exa3pBYjFMalhoWkVUTHZ0VEZJTDkxME5EWU9iYmlw?=
 =?utf-8?B?VXdNeW9lZUFuRjZ4Y0t5aVhvNXlFVjJwbk1tYXIxNWJOc0R1TGpreDVYZjQ3?=
 =?utf-8?B?SXM4Mkc1VGQyRjhvQTVXQlREZnQvbUxCM0dqY1JjSjhZVFljU1UwZFg4dGEy?=
 =?utf-8?B?K09HMEcxTEtCKzVYUFJNU1gwT0JIQXdDSnpkWEN0QTNob0Y0dTN0Ryt1K1VB?=
 =?utf-8?B?Ym90MHNoNjhZaTUwQUNCUWRGY3EwVU5EUnNudEw0bXc0ZTk0UjFNTzJqT05K?=
 =?utf-8?B?VDZYd1FNY3Q4T0w5QW1DMHdBZW9Md1VkNFNLakg1UjNPamVsRjVpZHhEeFRh?=
 =?utf-8?B?M2xuRTFrZWJYcWRESlo0RlQyNWMzMVdzcW5KdlJWeVFnd3FaOVgyTVg1S0Z4?=
 =?utf-8?B?T0xHUVRMQlg5cEw5Vk80elhIOTl1STZEOXVQU0JkZFNuWXYyY2FJVEYrYUU2?=
 =?utf-8?B?VTJxcVlwVGJvQjRML2RTQkdteS95dmJjcmxFUk1KQkt3YkRqWHBNcklIa1Fo?=
 =?utf-8?B?R3lWOEFQY1pmSlErcUtRVWF3U2tsSFhPeDBOS2YwdmsreldITzZBVWp4aHRn?=
 =?utf-8?B?RnMzaUYxZVB2c1gvcVJkT2VzVXhrUnlrMWdRRTdzcmJ0T0Q5RXdhbDJNak16?=
 =?utf-8?B?R3g3dWxuTVY4UXN6WUFKWFJWN1FMTStnN1Y0TWpONjBzSmgvUWtVMkxrQnVP?=
 =?utf-8?B?T2NUUWtEeEVmWVV5TjF6Yk9GR2swWThZVjZ6TVBuWTM2aisrQ2NWSFp5WGFN?=
 =?utf-8?B?azF0SkNJMTBqZ2JNckFheEFZMlZIN0xnbkQveGxwTDRWMFgyVHEraThuNGln?=
 =?utf-8?B?REQ0ZWVPTjlFSXRLTWNvVjBaSmdkQVRkeFN5L0ROSHBIMkQxVWFwWUtTUHRn?=
 =?utf-8?B?cXdlVGluaU9UWDM1Zk9EeDRZSDZEdkZjRFNLOHhhVW1yNVIrZnhVeVVjNjBq?=
 =?utf-8?B?VGNFdUgrNS9mUnZ2am05cndiSEwzQ2QvdzZWSll0a0MweHdnZTNBelBKVGJG?=
 =?utf-8?B?bE5hVG5seUgzcEk0SjdsVXREMEptajZnK3FIbnBxR3R4S0REdVpvT1pWZmxl?=
 =?utf-8?B?RlkwUXpGK21kWE45U1NuM1p3WEpEdzlsNldkbUNYNVdzMHFKUHpRVXBycVF6?=
 =?utf-8?B?UWRJTWp6cmFmb242clpIRjJmUHZvNU94d3ozQU0xdjRWQmh0dEpIRXRnWUE1?=
 =?utf-8?B?TDdPNWhjd0VGdU9vcFdtTWxKQ2pOalNYbjZNaEJVbWxsSlpJa2g3cE4rK3E4?=
 =?utf-8?B?Mk1uM05Hc1RYVWJhWndPV1RrbDBZTDBRSGg3d3Q3NmpoejlVcEc2dll5SXRS?=
 =?utf-8?B?ZXJGK2ZNYlFCWnJyWVBRc2o1T0oxSDFvM3A5bVRtQ3p1aUN1WEtNQ0lBclhU?=
 =?utf-8?B?aENibTBUNU1jUkF2a0FxZUViemtxZmhTWWIvZXNJU3NDdVg5azBwNmo4eng4?=
 =?utf-8?B?cGxmMmdkZUFCL0pKMjB2ZmpCQWZIN28yWEtjZGo2RjJadGtudHR3cmUraTg3?=
 =?utf-8?B?WFVWZ2pveTJGeVcreGRjWjJaRDlSYm05cUgzZGNEcjZJVnc0azRBOWZKQms1?=
 =?utf-8?B?UXdTcDZxV1VWdHF3VWFMNEkyMWpEOWFBdDIyTXR4U3dkU1VMQ3JTQ3ZtU2Jj?=
 =?utf-8?B?WHVXUlNOS0JwcGpzM1NaSWhZZzk2cEtOU1RFamlsdXpYMlFmNkdzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B559926F00B2F747818EA212A9FAE67F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	F+jiwfR75lfkK7+yw/XHu+cvp0qaYefkwyqRQBszrW7JSejxpuaHLtALoYbtYqjPiyLJEbn3qCVXKShR3hUStjHk1/wOY474tjgFdYDUPSZUVUvU2BTWoA6c1YmIobXJdGCABTCiwAo/TLcpAyYuaHZbw6OZltbdBOZNS4zECihW9h1zS69BZri0ZvUT5+Ow8/jwyCdcz4MBzBAJIxLFffc2YvIGvGeooZx0LdqKVz/fNepaylrGGz6r20ALka8I5KFzG8USES946ZESGud3s9ynoIIilcE+42cXPYSGw9HF1w0YQohgN494qS3M+8ipr8IR/D3PjpI+sfo43QU+mg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3KYSyZ6aVUwC+fgDxaZHqwVUFtp+cjSCa+IcxRmc97aBRrTBsRLNyVoZVKrfS3NvfsrA3nDo2yol+vKnhqrPZ3V+tT5WkdT1gMM8bY7EEt0raomSPHeAmp4v2D8Gh0msc2i+3MfhSUPlBEVZ85VtQZ9qLlRqjqDMdmareKMZQkRL07AS4rpzBQNzrpZJXEs3n9cDJuIwFex8DjpxlaGoDFUN7JvS5lkRwa7tnKFtGyi2MV5lE/vDWfFZB4i3saD2FbaH48POg9hvzuDy/9FeD5c3uZ+4ZkN3jXXRMKy2o32DKZQ/DoAP2RGZhacScUgVGpvVaX7N44XK8wIUyq9EjINi78+lBT3oXDM3CcIIQIngkx34IHeGXg7vbK8+gstHnkq8UjCc1pgw9qNZVlvhMphSneT4WDcyqNIjm7RSE1TAw8GLLpaBfnNgpYzT34nPWcqcPDqLd12l0Xkj4cyzN9f4nnD3rdYohg9iRyQhaol/yjJ9+NIXF85KOQ9IfmVHBW/qOzCztoDUD9tnPxlCdxDJkz2DUpMlc9d5ue7Aru7JfHhHNW3CW1fz8ZFdkCTs0tOO8G8T0UxoqAVCEMp8dISSoYvg8ESWbkxHDAdxPSB1NxUuYlXsg7dRnatHkPa60MyclSr6OU1MRn/Ct1yAIQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8b9f1a-de5c-44a6-97dc-08df259c174d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 00:27:24.5790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +c3txvsbn0TpQ3f+blUsEenB1u0HKnnlgg7/PxJxoCRDnRAAVVF+oxJWFKgso/vSxH3Mmu8f1szOcZAIC/+dlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwMSBTYWx0ZWRfX9Ck4YpgbN9Pd
 /0kROIJV6dLi2EOoqcK61bYzYt5V2P0zNB4ixLVTU5iaXyLZ8NJCLKpaUhA2BeeAzv71w9iSIBH
 4G0wvlIUgwDnGNbZUQh0PztVfQ5Yk3A=
X-Authority-Analysis: v=2.4 cv=fPisTpae c=1 sm=1 tr=0 ts=6ac834f3 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=D6tFmCF0y5yqwYFQiDsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BW2vLoO9l0rtUEZHbxYZmOmeQ4j3qhSy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwMSBTYWx0ZWRfXzr/1QkHTwlWT
 o36eB8xzQ7vntQDqBStB0QdIK6WLUBh6sJP+Uao+c0SioOIwzgQxPCDgSTxOsYBQeBkwigIwAsJ
 fBQ4fvWspNq8AuV9Xj0n6K9pfB5b0K/cthQ2N5AQZCCF/SetwGJrdfenMML1Ki6MH1ItT7nj4vh
 gagfvWwTVOjuwuphH39ngtfnwG95i74HCMRCAb/vZa510ZQsNEBFR03bNyus1AAmlMEWAQxQoyO
 O+wMynFlvCDgv4huc+TmUs5OKahaAbT6rK4E4Jm/oxy87C/++YIsv/eesBGbUIRoN1wplmraFsP
 S4gpYteD/0Fvjpo06u5b6PZGXnPXJcmdE//Z+yB3lHjyt5yZlm2ty2YbS9kA0q+RVcwT4FqYRT/
 mGBpp5BN6aVWzyQopWxlG0NJS/3WVaS8d1RIRiPVOdjmng8tDkOz/orhGU9OHfBu+VruifCM0Ig
 nohoWLd6zo4eYkkm3zA==
X-Proofpoint-ORIG-GUID: BW2vLoO9l0rtUEZHbxYZmOmeQ4j3qhSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610020000 definitions=main-2610090001

T24gVGh1LCBPY3QgMDgsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gPiBU
aGUgRW5kIFRyYW5zZmVyIGNvbW1hbmQgbm90IGNvbXBsZXRpbmcgaXMgYWxzbyBhIHNlcGFyYXRl
IGlzc3VlLiBJDQo+ID4gYXNrZWQgeW91IHRvIGNoZWNrIHdoZXRoZXIgdGhlIGNvbW1hbmQgd291
bGQgZXZlbnR1YWxseSBjb21wbGV0ZSB3aXRoDQo+ID4gdGhlIGFkZGl0aW9uYWwgY29kZSwgYW5k
IGl0IGFwcGVhcnMgaXQgZG9lc24ndC4NCj4gIMKgV2UgaGF2ZSBjb25maXJtZWQgdGhhdCB0aGUg
Y29tcGxldGlvbiBldmVudCBpcyBuZXZlciBzZWVuLCBvbmNlIHRoZSANCj4gdGltZW91dCBvY2N1
cnMgZm9yIGVuZCB0cmFuc2Zlci4gSXQgYXBwZWFycyB0aGUgY29tbWFuZCBpcyBpbmRlZWQgDQo+
IGhhbmdpbmcgaW4gdGhlIGhhcmR3YXJlLCBhcyB5b3Ugc3VzcGVjdGVkLg0KPiANCj4gPg0KPiA+
IENhbiB5b3UgcHJvdmlkZSBzb21lIG1vcmUgaW5mbyBvbiB5b3VyIHNldHVwOg0KPiA+ICAgKiBJ
UCBhbmQgdmVyc2lvbg0KPiA+ICAgKiBjb25uZWN0ZWQgc3BlZWQNCj4gPiAgICogZW5kcG9pbnQg
ZGlyZWN0aW9uIChpcyBpdCBhbHdheXMgT1VUPykNCj4gPiAgICogSXMgdGhlcmUgYW55IGFjdGl2
ZSB0cmFuc2Zlcg0KPiA+ICAgKiB0cmFjZXBvaW50cw0KDQoNCj4gKiBJUCBhbmQgdmVyc2lvbiA6
IDB4YzEyMDrCoCDCoDB4MzMzMTMxMzANCg0KYW5kIHZlcnNpb24gKDB4YzFhMCk/DQoNCj4gKiBj
b25uZWN0ZWQgc3BlZWQgOiBIUyBtb2RlDQo+ICogZW5kcG9pbnQgZGlyZWN0aW9uIChpcyBpdCBh
bHdheXMgT1VUPykgOiBZZXMgaXRzIGFsd2F5cyBPVVQNCj4gKiBJcyB0aGVyZSBhbnkgYWN0aXZl
IHRyYW5zZmVyIDogTm8sIFRoZXJlIGlzIGV2aWRlbmNlcyBmcm9tIHRoZSBsb2cgdG8gDQo+IHNh
eSB0aGVyZSBpcyBhIGFjdGl2ZSB0cmFuc2Zlci4NCg0KVGhlIGhvc3QgbWF5IGhhdmUgc2VudCBk
YXRhIHRoYXQgd291bGQgbm90IGFwcGVhciBpbiB0aGUgbG9nIHVudGlsDQpjb21wbGV0aW9uLiBB
cmUgdGhlcmUgYW55IGFjdGl2ZSB0cmFuc2ZlciBvbiBvdGhlciBlbmRwb2ludHM/DQoNCj4gKiB0
cmFjZXBvaW50czogVGhlcmUgaXMgbm8gZHdjMyB0cmFjZXMgZm9yIHRoaXMgaXNzdWUgYXMgb2Yg
bm93IGR1ZSB0byANCj4gaXRzIGxvdyByZXByb2R1Y3Rpb24gcmF0ZSBpbiB0aGUgY3VzdG9tZXIn
cyBzZXR1cC4NCj4gDQoNCkkgdGhpbmsgeW91IG1heSBuZWVkIHRvIGZpbGUgYSBjYXNlIHdpdGgg
b3VyIHN1cHBvcnQgdGVhbSBhbmQgcHJvdmlkZQ0KYWRkaXRpb25hbCBkZWJ1ZyBpbmZvIHN1Y2gg
YXMgc2NhbiBkdW1wIHRvIGludmVzdGlnYXRlIHRoaXMgZnVydGhlci4NCg0KVGhhbmtzLA0KVGhp
bmg=
