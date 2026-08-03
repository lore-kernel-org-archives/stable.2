Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12435233928;
	Mon,  3 Aug 2026 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771334; cv=fail; b=kkMiIoCYMg6nkgpcAROs8HrCpMTgmnz2Ro/72rQcxbgoK+014yMaGKpBEDiEAgzJVpXb8fY1a0kkaSn6U3G0Xan/dt93vzYmoZJ5H503gn0sNbF/O9Go035vGiiD/fnIy1eYU0dOxcgQ0cHBdaYDxUEke12xBsX3gsIBjssOcms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771334; c=relaxed/simple;
	bh=L4AHQ2/BQ8vHEMKddL2eJFhplK+7QtlVPOl8MjijBCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uaVlr7tRiCAtdPRKuCXabqFgrvjleSQqexgUanEdzPNC4lyAlFD+Ld+gAoxjwVG6ZLj+tW00pe1uOsSVWeZVOYcphtbquvQWnZSNLb1et/pJo0u40UG4eWg034TRdc19b2zFFrDL0vUmF9ILx0wk6VJrX6W8aqf6GC9c0Cehl50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=H9cvlz/W; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="H9cvlz/W"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EBuCX1125616;
	Mon, 3 Aug 2026 15:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=L4
	AHQ2/BQ8vHEMKddL2eJFhplK+7QtlVPOl8MjijBCo=; b=H9cvlz/WmeRSAIvXyg
	6D93nTD5NnvaaPAhyquZFu5v7Td1bJWA6bbXksHTG00nyl2Ds4Maros6RlYyqf6m
	7HQLUQEqk8v8vnCk3+k0cRohHa79Z4wkMST8ZgUI+AwGjyxnjIsT0Kc8oMr+Ieug
	HHT69IO3CTFFvBfrzknE4OEifPZ1+cOMtac9E2vQunUwISIF8UAXiqeSk5I25DJ2
	4bLvUAukEdpjkpel3VDb84lTqRspmFkmkkIadjbQf/KYP3n3sUhilPO7H8YirVwv
	3VWuS+pofFhuX9PcKm8rvy9rBMHbxoXwlTgUUW0oSKqU1K1TEOr3mMsUIP2f+bTE
	YpMw==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4ftv79a75x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:35:13 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id F13C6147B8;
	Mon,  3 Aug 2026 15:35:02 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 3 Aug 2026 03:35:02 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 3 Aug 2026 03:35:02 -1200
Received: from SN1PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 3 Aug
 2026 15:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZlNgxg4iNk715MX1lhZPJ1UG8uxi+CGOfHQ3v52xtt5nOpl3xSBdT//n1fd1LY9sCjgIa9WLMwxz6H7u2Fs426HHRPhYwX7g7489PNR2MzPyGktuBqW4KT/FUd57XWU1jDXAjkC1OjcYuyXQXvfwEAOMjxZn2P0iQ7zGt/G6hWKzUuCemdv48UsTgOOjzl0EfCqQff4QH0MW5lZJWgVyrglxzHnT8HPWoLoJ0u8Hs35rm6Q9PqfXiQJ7q5nfAHQoCyJnDfA8b3263Vn8Hc8T3OkLr16q99rNi+AIMTVQmPsSgH6W9hM6BbyjwqGItxJUmvjDBm/kjH5kSKpVEk5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4AHQ2/BQ8vHEMKddL2eJFhplK+7QtlVPOl8MjijBCo=;
 b=DE9bpf7XTXn95iZqmGSWEwQOMUOtnloYsyLIbkvXyl8lpOCLGuH7ZcBXhlS3BYrSyXBpefxRsT2RFTgphOvGzCM6G4C9L1jFb6nfTTGWGNa8xNTC3uU+aZDxruU10vOHWgUYU0BS9L2Hvfbd+cxRSkKuZJEp8bF266p9MMuM1giN19JF5jMedzyOEbrjxVeXha9h9SABeNi5czwe16+yQUb3ZdqSFfbqIhOIu0aEvBtsKDNHjAwC3ImBmZcs+6heNfxs+zSQJ6fft1B4SmqfwJ5CdrWeSpxCvoumxe8ysYYNtc6gXCjelkZih82Mdfwh4ifiTC0fMFXTAgBhNZxgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DM3PR84MB3714.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:3d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 15:34:55 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 15:34:54 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "liusizhe5@huawei.com" <liusizhe5@huawei.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "yangyccccc@gmail.com"
	<yangyccccc@gmail.com>,
        "zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling
 and clean up trace start
Thread-Topic: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling
 and clean up trace start
Thread-Index: AQHdI12iY0NetzggsUStYKI78MD2Gw==
Date: Mon, 3 Aug 2026 15:34:54 +0000
Message-ID: <20260803153435.148569-1-sanman.pradhan@hpe.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
 <d558a593-ca12-4237-a9b0-5f20441c9d52@huawei.com>
 <cfe4614d-5c09-4f51-9c10-60bec2bde5e1@huawei.com>
In-Reply-To: <cfe4614d-5c09-4f51-9c10-60bec2bde5e1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DM3PR84MB3714:EE_
x-ms-office365-filtering-correlation-id: cd705a83-d463-419f-02cc-08def174c481
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|5023799004|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: oPalZKY8B/jN2bEC8CTUR5VtQHjkH53DxlYgS1Lu6SYwwjxB36NVX66O7LiNClm9kbS6hckiyqpZafBIcGZnSPFInZZVNfOpoPN/333Dk8YDG1EzN1DBMX1Dp+yb9d+QmZBYnMGKScGkSaTbcCHCKFbuQsXBXEHJHp3cY6e4rytsRZ3l4Ft1mJsH2r/j+xVKuGApOWwNwSxtJrR9VqL6EyVMxSBYvV5Mv5ixIfw4n+U9RG43cL/9LzelmjnPc8ukSF+7JQOATX09ALE8nua9v5d9qC8EjdHNiQXlN/soG474H+O0YZEzMPiCqrBzf8rNa8Y1LncBsqiudDvu7VYXlwms18tjNBkjLhWh0cgKtvYIph2ZInI2cdW2+iLVv3T5gsd4BSHrvEFnWPcKf/fERDbynCd+HpzosM3Auv+YoN17McwRE50u4s2Zt11eB5aWXzGw2TT5WzchgfNvuR87fyXHXb2aMh2/hmk+a7jwLZeOvenkEDC2TdP2vvZiuyrkGU1FO8CpnV4qyQg8rxsrWeA9PNzppcqg82BSH7Us96xLj2WwzIWKfbVI/ClBWyF9SXEYOIrnKQnVfNMtxmYLQPvlJbN7xtbHZiHvPdQDb/gVN8jqQAe+zqQ/aXFOkLgx0i5JK5jXXDo2T2i1x8QdV8SXEH/CtHDV9APHWIHkIzvaf0qjC3BPe9if6U2hnhAwm/F8Lvbx2YB8llfnl0xWn6N33l6+ilMcV/iDY484DDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(5023799004)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnpYLzE5dldjZEJIa2lxM2tGZW5zVjNIV3Y3NTN0RHgvYzhUZVQzQWd4N0d1?=
 =?utf-8?B?QmdxMkU3clFhNHozVG5KSkJSb3U2RDZVUy9NWmhpYUluTDFkbVFWU0pxQ1c3?=
 =?utf-8?B?dW9Md1dnUXhFeXJlZzFsSnBZSGlHQU1OMWxGZDQyMHJLVytBZnkzMkJDNXJP?=
 =?utf-8?B?SVh0SXY0Vnc0SnJXK2NReW1NRFBiL2RnbzdDK1NQSW1EQlVMbjIzd1FQRjZM?=
 =?utf-8?B?TGtRaWNyVitPRFIwSXJUOUdDckNBTHpFT1hhdGxRZDV1aExtaTFNRllqU0tr?=
 =?utf-8?B?eUU5cE5RbUdLQnB6NEVPNFRoNE9sckVpR09HRDNwdDE0WklFdWVXWVZDV214?=
 =?utf-8?B?d2IrRkhkYVI0NE0zeTRzM1B3Tjd4dnZacU1EaFlhMHJ4aWplb0JRZWVRUGZn?=
 =?utf-8?B?THdkaGZtL1NQQnN6bVVqVHBMdVNEaFRZUVBDTnNhNmoxNTlDVnZXb2Q4Rno0?=
 =?utf-8?B?WHpPWVRad3ZiYzdHWitHRURMYmVDWlU0aGpBZjJ0aTFSQzJ5TW5odnJuc1dt?=
 =?utf-8?B?SndPMmRmeDNUbUg4b3pEemoxQ3Jsa0djMCtLNnZMamgrckV6cEpva2dueXMw?=
 =?utf-8?B?R3NMZStmVE9jcVFuc09ybWRMdjQrZ2RCR3lROUo1SkZNcjFrclNwci85R3A3?=
 =?utf-8?B?eWE3TndNQ2VyVE1PVWljcFI0MFZoRlQ1WkcvQ09pZWtVS2F0Mk1ncG9GWnZ6?=
 =?utf-8?B?emxTT29nRXE1Y3lUbDRYbEVTdDhwdEwxVzZqVW5DRXRZWFhFUjNsb1ZaTWN3?=
 =?utf-8?B?MHJ1eHBPbWFkQS9OWkFqdEhJWnJnaDdzdEFER2NMQ1BEc0M5RWlOQnc3RHox?=
 =?utf-8?B?TGkzbzBGUWlMbTJrbDBpcW90UmtLcFhLQWxoMEtQbHdldlpyUDZobFFWSnlF?=
 =?utf-8?B?NzcwZmNES3dHZnh1TTdXWjBiUm9VbHJMWUQxZUVUcjZaUDRFVzc2a3Z5R0pu?=
 =?utf-8?B?djlVOUxwMVdpQmhvTE9ybW5OWWJMN3g4TXFaQUxsNkNhNll1NmtnRndWY0FN?=
 =?utf-8?B?ejcwbE43aEsxZWhxVTg3MmhST3lpVEJwUk53TmpqYWJwSjhoRy9qOEpXSHJl?=
 =?utf-8?B?VU5ENUFRdFd5SkJIUHYvSWEyRkJLMHVxVlRidFNQbWIvL0hyVmJzZXJTdUl5?=
 =?utf-8?B?Mlc2eWlKVFhTRDRpNkc1ZmFuOXYyMGxmcVpiZTl6VW9qd3JDdUhGMy8xcjhO?=
 =?utf-8?B?cjdUaXpXRmo5bWpOS0U0eHRRczJMSVJLZVF2MEIrMm5CanM4WTFQOVF5WkI1?=
 =?utf-8?B?V2UwQTBvWjIwY1ZWZEFPVjBGdjZZTm44bnNHZFFxbnM5Y0JjQUhLenJjMTl6?=
 =?utf-8?B?cEc0OVlTVDBJUUtqaElEUXEydSt4aVQrMVlabStTdGErbVFFYUpqWU43b0hW?=
 =?utf-8?B?ZWo2cnZXWFR0YWJCTGZiQ2pSYytQMlYyYWhoZmJLUWlCUm9iTmVra2tycXlZ?=
 =?utf-8?B?bW9VdHJ1MVFjL2VkZ3grSUNJRlEyNVcvNEJuMTBXendnQWdMTUhFL3AvR3N2?=
 =?utf-8?B?Rk1SdjJHRk5zTyt1UmJzejBLK0lpb0NmMS9qS21uTFRzd3lVVHBGUkwxOENu?=
 =?utf-8?B?WVNvQU5oWm1hK2RQUmwzbXVBMDJrZEs2ODd3SFNFRlBrVm1JemRSOHIxNmQr?=
 =?utf-8?B?Z3M3bXhyTXUwUlZEZFVSK1crVzEzdjArRnFUVlpHY1Y2SU84aG9UdTQ3QnJh?=
 =?utf-8?B?RlZrRDh0T2pkQmpNRnpWcWliRFVFLzI5a1VyVlVBOVUwU2dlQzArUExsc3Rw?=
 =?utf-8?B?K0V6alcwQXFnK2dWdTZTN0J2Ti9wNkJlc0U5ei9ELzgwQVVnU1IraGZraTVE?=
 =?utf-8?B?cTFkdyt3ODlMZjkxaFg4WEh3a3FJeXJRamVjc2E2SnB2T2t2M1c0ampXVHJM?=
 =?utf-8?B?RkRNM0FsSjF6MkxiL21TSkRGdW9FR05MdERtWW1ibjlTSkNMbHFvUWVEYlNr?=
 =?utf-8?B?Z21oL3ExWFFCVFZKa05FTDFpU1pLV1ZyblM4NkRJVEtJZmlJcWdHUEJOZnpx?=
 =?utf-8?B?S0NpY043WlNDUnBTeDNPeFJCd0dBY0owb2NSQWljME5GRFBhcDVCMWprT3kv?=
 =?utf-8?B?bjMrNE1TK3lYR3JwZlg3Z1ZoVy9lcXRmVDlPeERyRTMxTVR1NXNERk43Slkr?=
 =?utf-8?B?Rm9TSi9zVGhLUVRNQUVWbDlDREZLVWxraytBQlpHZStzNU9jNkhEU01DZXVu?=
 =?utf-8?B?aXAwMlZGVWVQaDVyMlhiak9vNlh3RVVVOXJlaytmNUZ3Z3M1c0VGOU1hc3NT?=
 =?utf-8?B?eWxXU0QrTXVvMmxvNU5IaTJ6UjkvbFZnYVg1aEpOcmZUcklrYzk5cGdRcWZr?=
 =?utf-8?B?OHloYmdCSVVndzdlUEg2ZTFvcGZKWk05TXhmK3ZwSGNhcHcvL25PZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ti4CLe2eIUjLL0DHs8MVpWtPXXh6VtoLdKbFVYvCo0MxRSPw2Qk52YsBUqFSdAvg/LM8PWVelhR2NrStPxHM8ZKYYvZmB8Y4MiwL0x8+BPOZ1K4RUHxKWo0aX7uacF0szMeYFD37VtViMUGh3Gojkh0UAk2QcreezfI77TMm1tdorKmzZgNDltO0ydCGg2fbpSfBMUXQGhvMozFt5/godMNfEZipfGuabsP2WM7CvT/+qFIPbWwNJzF2DTatrpzZmOUxGs36xQ7/DknbmfNsRDd2PYuU5Fe74hACo8lxtfFeYR559B1YVMVQ5J4HGIjEaZmaZhaY1tRC5sdVyTTlYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd705a83-d463-419f-02cc-08def174c481
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 15:34:54.8376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SAubJbpake1KXjST3fhmsqPmZ3mrVwSVXlAHa263QyfJd+17c+/KRdL5gPiqv+rQKAuknDDKeZ9H4r/q5Xcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR84MB3714
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzOSBTYWx0ZWRfX1u/4qpsO0ay/
 +NwBSQlE5sVLjTORTyf2KfV9nT+yoOYs0NfmbeYzy/FXUL3fb4m6B88sqo5FJMvbhyFkL3NziVW
 4EC9KFkyVjm+4y9EQVEmaVQsLedYAjI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzOSBTYWx0ZWRfX7V6quv0KtO26
 XE5QbSS4JPjBKPfGNBNzvFhg6r2FQ8OgWBeVQ53ypHsdqSMc/VlpgVgm0HIb9QSatqoT11VR+ba
 WXL1An3/xh0B1lhia9SbetwA0XBPQvyQxr5TdBgmw2qlnw6AmuiU6EYkBzKzZY8RMe+ZfiVBG0X
 U0g1C17TPeADEetughXhoskEQjB7eMrpRF1NU5VdDkwXc2B773y5mW8hK9izHZqKsW6+kZr10DA
 Qs6nzduNmwjIpmqVrl3mtW+23RjWGLaFtBYjsSEM+cipYnOkw4dpRMS9iym53ysNEV3UOqL6N4s
 /4ZuMHdicIlTo7WpR1C1hd/l8T1lSqEC4PJXGC4G3vvGSo5DgOxRXgySmvzNv4JUt47jKa6lVyi
 SPQen//CS5eg1z5Pj0p/fzpIOveoouWbG46cEyusFxDiNmul8eDqTGbguFd3hhCL/tY6u4im6rz
 90uDFSJSZNl97x8p8iA==
X-Proofpoint-ORIG-GUID: JNX1m2xCS_mL_SleTwwU9wzb28Of9RSH
X-Authority-Analysis: v=2.4 cv=dauwG3Xe c=1 sm=1 tr=0 ts=6a70b532 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=OUXY8nFuAAAA:8 a=BLdr-Mp2vhD176eGpQEA:9
 a=QEXdDO2ut3YA:10 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: xq_SNnYGcbY2mD0intN6b9AFvErFek_5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030139

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpPbiBNb24sIEF1ZyAw
MywgMjAyNiBhdCAwOToxMjozNCArMDgwMCwgU2l6aGUgTGl1IHdyb3RlOgo+IEluIG15IG9waW5p
b24sIHRoZXJlIGlzIG5vdGhpbmcgbW9yZSB5b3UgbmVlZCB0byBkby4KPiBKb25hdGhhbiBhbmQg
WWljb25nIGhhdmUgbGVmdCBIdWF3ZWkgZm9yIGEgd2hpbGUsIGFuZCBhIHBhdGNoIHVwZGF0aW5n
Cj4gdGhlIG1haW50YWluZXIgd2FzIHNlbnQgYmVmb3JlIHRoZXkgbGVmdC4KPiBJIGFtIHdpbGxp
bmcgdG8gbG9vayBhZnRlciB0aGlzIGNvZGUgZ29pbmcgZm9yd2FyZCwgYnV0IEkgYW0gYWxzbwo+
IHdhaXRpbmcgZm9yIGEgcmVzcG9uc2UuCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDI2MDQxNjA5NDIxOS4yNTI1OC0xLUpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbS8KPgo+IEJ5
IHRoZSB3YXksIEkgaG9wZSB0aGlzIGhlbHBzLgo+IFRlc3RlZC1ieTogU2l6aGUgTGl1IDxsaXVz
aXpoZTVAaHVhd2VpLmNvbT4KCkhpIFNpemhlLAoKVGhhbmsgeW91IGZvciB0aGUgY29udGV4dCBh
bmQgdGhlIFRlc3RlZC1ieS4KV2lsbCBrZWVwIGFuIGV5ZSBvdXQgZm9yIHRoZSBNQUlOVEFJTkVS
UyBwYXRjaCB0byBsYW5kLgoKVGhhbmsgeW91LgoKUmVnYXJkcywKU2FubWFuIFByYWRoYW4K
