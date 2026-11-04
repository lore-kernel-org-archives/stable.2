Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793751862;
	b=Rws8oxXy+CfePFUuByDpxd5o8KTIdgMXIWh5srO30wQfrsJ/XkEXiILUCpLUHgVDXA85
	 +Gu/p15FwF0gNvRZoEyHndmtnFy8RLLe4Nocm3Qe/Xt9+AoUcUkVnEK3WthSjxEzvfKmY
	 h5foMnTbSmOPeWIv/mJ6LGWtgLG6iXb2HEeywsDrfNWYlta6SM/gUusIVd4eFuEElkgIl
	 AptQ6nL5cmu20VBawihhfB9k+Gk8oadaFWjb5IRTO08FY+MKeJmlc0pDzqXnL0zlNOU4y
	 MEMtHwUyZP5BLSMJb+TalBZRcgDoIaURMK3kyQsM0Ersu5FJkL/USswacvn0RNvR3Dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751862;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:Received:DKIM-Signature:Received:Received:
	 X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Rgye9tum0lzTdfUdjyvmrohUKjPICHcH8+IYLvFRnwY=;
	b=DL/rog21PvzLw2Sy7ops7gzvxls0ELcrbJ6n7LgT/SCKfIJjyBDYktg6UAu4dSxky924
	 SIzroER8QgX8VEBTq4PUbkjRHgkjjE+kcjdhFLYQzG4RmsaxRSH4JYA1LBfXa0Czrt9KD
	 uOfJllhwfwPt5bhTF9eoFU5Fc7yqPNzH5zM9E6alhVuWlZPSE14EDdiz0Q5KjenclCca1
	 /cFPAWWNpH6oqJxeTWZg+Vv3XPEU0sJeodouZbSZKD4986cZ3s2qvd9K2hlbrL8kVjVj7
	 icuvdJhjw7Nl552ZcvWq2bU3Cg7ivW7RQ4JMYhgFmNfIofMLJTAaZvG+oKXLst/bTxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=RfKwq7jR;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=bh6fZAuX;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HqWrLmrV;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B5606A31B;
	Wed,  4 Nov 2026 00:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B8B5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=RfKwq7jR;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=bh6fZAuX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HqWrLmrV
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3NPXTE122232;
	Tue, 3 Nov 2026 16:23:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Rgye9tum0lzTdfUdjyvmrohUKjPICHcH8+IYLvFRnwY=; b=
	RfKwq7jRdIJA0oHZahtB4FcHX8ll3MowpPEMVAZiA+Khn33cM2Z/sVr9/HWrUCeo
	EviPSPKsNMFw68IxIp5EIsa/5FsnQSU0Wk0oRGcsCLFPe78XKciHeKdmMqjoa+aa
	K9/GW5WXbpFxKbD8gfJIjvK+E/LxzfxrfZMfMkiXxDIDgwXxXU1EfFW3Wr71cBzU
	xxjnc4CnXeirb14ygqJgND7EhY4XfZai7g2mNtBS1Lv9jf2YaaRMjNlKij+9H7ul
	162+A5nlF1ZhLUZ1JeB1QMKsx0Eeycx0MsfR4NDemzB+aQX3jgo0Xed+dZmcW8oy
	VvGY3ZGkoEp+gmx+chdMgw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hq5af34gh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1793751783; bh=Rgye9tum0lzTdfUdjyvmrohUKjPICHcH8+IYLvFRnwY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=bh6fZAuX5meJrbD6E6WvVjVp1fx0XKGg5m64LYBj7UmjyERUHtujDTeik7Gc4w6Aq
	 6guoVB6bh0NWWs3sN4E587ordgAfd4g7aV5k4mhW3IsyZe4fUueZkX3Ach8OM4uLO/
	 aZBzDygbX93zQiVHc+ILcmk0Vrc5ewApUCILUq7fcoqwnUa3NSODFrKBiPYb5SW79u
	 yDlt01+bPqyaR9RLBPF+S7gBm3iOjnnz0XbFTb0rtQWr6LIByN0RvWnHxwrygMbRvN
	 lzey87UFzgS259P5RXy8xvXN7syUG0iILJ6kkDaAisj8RUjYsMjOFpz8/QZD5vfv+z
	 /as4LUE1d+uCw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 932FD401DF;
	Wed,  4 Nov 2026 00:23:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8D89DA0079;
	Wed,  4 Nov 2026 00:23:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HqWrLmrV;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00102.outbound.protection.outlook.com [40.93.14.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7791B4010B;
	Wed,  4 Nov 2026 00:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxytrBQjNjxbJ+SIYUodigzRsr/p4PGZPbat/v7UA2MwqottDB1iDXMLG6ke6JWu3ce/4Lw69A7xgWElRw7oEOCkRhhEB/3VN44HgDmW2dm4wEyJIgI5w5X4DVZzBjJwC7yWl4w4MCYb+HvqhIv02SkkwduPu8UwSxBbyGv8ZfSvH59ninqYHz6XWWoWq1/aR7M8Dy9QoY1oVgZuw5Nn0ObQlV7LrIV2Z1bQSnXUUlWzkSSoUxSs3qgViFuPNoo8r7QFyAeuP53FfdOEOKdetmI6TdvHhKlWpzCGiDSRqlBsBUq9QXbYmUflcbxFrFtCVdF29cip+R7/wWN/DzEW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rgye9tum0lzTdfUdjyvmrohUKjPICHcH8+IYLvFRnwY=;
 b=pddM6VA0sO7vmsBNECiMsx9TvdHytaxnHS6UGXFlaSkaHcrerbSGgH0IxzXKiugbYXbR4fA/Fw3sx0Lh11/mFJ8PPWTM4sURFRnxFfUV3F99Am6f1QJjcLnDEVK2l/mAyoFxdRChiY0emkeoQCJ4sMC9QJUdt+mLmjtnkRWSOTvXEXoeeWAGdSuvyu1I6L9zQC/ex6cIZSdmjFePRUoQ2H1EHEL19nvat/6COHayZG912CjIENMdud5wH+sqiUoRDqYplmR9iTKJyJ43MaTl/iQouBmjiUnCUO2FNIZPr5rp4LGb3c/6xw++FkJQhdQPzcc3vgDqcjx8rOKC7KC+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rgye9tum0lzTdfUdjyvmrohUKjPICHcH8+IYLvFRnwY=;
 b=HqWrLmrVKGliVG6QMFds80o5kVSpz0wCuaK+/lsy04EfjhvF5eDPj9t9yrRjW+UFfsAHuZ4AEPFjGIVpwYvfu6xjs2Zw+YG0XG+o+Veb6r9LVJHBEjUJZgnBaaUnFpqoQ7VikqalQuioScDEwWJtNGZYVhaFWO0y5qmbnBIIsD0=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 00:22:51 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 00:22:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] usb: dwc2: fix low power issues found on stm32mp1
Thread-Topic: [PATCH v2 0/5] usb: dwc2: fix low power issues found on stm32mp1
Thread-Index: AQHdWxUBu1DGRXXHEE2aDiS2APoxv7cdLvOA
Date: Wed, 4 Nov 2026 00:22:44 +0000
Message-ID: <aup5XYDfxxrU7cqP@vbox>
References:
 <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
In-Reply-To:
 <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CY5PR12MB6369:EE_
x-ms-office365-filtering-correlation-id: ebd63e16-a026-4577-2e90-08df3a09bf5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|4133799003|261102124527099003|10067099003|38070700021|261102123227099003|11063799006|261021123027099003|261022105027099003|261026140227099003|261021130227099003|261026121527099003|261026130827099003|261022075727099003|261022113327099003|56012099006|261021133027099003|261021135927099003|261028144727099003|261009223027099003|261022115727099003|261021121427099003|261026135527099003;
x-microsoft-antispam-message-info:
 RMbVJccqFZCVUiHYi3dps9GWstsFsnbv0JZPqOjFoUd66TqnK4AY12tqQOrfNoKuL/NR9MFGZIHjBRC7fTvFrICVydfgp/jlQdUfyDJ4GY+sQSZFwDFUcA57O9SVNjRUqpgCLWW3UOR4tcrVaMTnBv4iOYHLPm+6q2oWBvMJQNcHUMOG+WJDwnWNsDFq+K6i1JhhiYZI+KtoVZuzIzgowP5bIxa6mFmUlZ5GRc+X2dSrotGR43pmkcTPZWDBYO+osGSL06jdLr6qeT5b1oNJPSW7vMfLHFkWT/45oeVSFqpuz6zlkRDZhom0GdYs0Eqa9Fq/1kxwgWDgz/ZBz9s1U7z2Tpv5/0dgltjveHu64XColOhpQ8xwCGC5j9+00gw7nEpA1mG9zlmiAItOhfcfGJXyn0/WpUJwULJMTgXaJyngwyKPi0ktJAYXnYc8PJgM+1/TlEmqDK8uJL45Ri+NQv9lJpaQeYR9Z6qqJL5x4kzuND6Wv0a3rWxmgIFiZya42+2vx7Bqc2p0MmmMkIY3/wU+D1qgxOG8yEVG45DRIfWRp5jkg0MokSyhfjyYWZ/EewinMAE3TsC4lVqhX1AqjbpsN/BWmFA+7FQa+hsF7Yi7UKXCS21drksZh8uKi5hY4JZomiOzyrP+zNENSV8LnktFuCVJbGNSWLr1LwAKLww=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(4133799003)(261102124527099003)(10067099003)(38070700021)(261102123227099003)(11063799006)(261021123027099003)(261022105027099003)(261026140227099003)(261021130227099003)(261026121527099003)(261026130827099003)(261022075727099003)(261022113327099003)(56012099006)(261021133027099003)(261021135927099003)(261028144727099003)(261009223027099003)(261022115727099003)(261021121427099003)(261026135527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1didGFDUWkrald1UVhtQitlcWVvNE80K01RSlQ0c1hETkRnWk1OTFh3Rjkw?=
 =?utf-8?B?OEYzWklURTgyMXJ4bWYxc3F2MXpVVmhTcjFRRDNrbHloeWxhaGNVakhEOXV3?=
 =?utf-8?B?WWJCc1BYL3dGSFFmMXhuKzZxZ3ZkY1ppWkhNTDdrV2VUSllKbTVlbUtvMng5?=
 =?utf-8?B?QWcxdjM3bUhMdThpT3FDWjRCMHFCUGxlc3lFemVGTzNZbys2WjVXQzF0R0Qv?=
 =?utf-8?B?UU5RaHRQWWIrRGt2M0w2Z2RESi9ZREM0S3FqUGtHa2lvYUJxMCtoa05PUnlz?=
 =?utf-8?B?Vk5La3h4dGRmZ2UxaVl2cDhQekJiV2w3V1VyQWhhbkVldDZiaXpHaXl4enB0?=
 =?utf-8?B?b2Y2aHRiZnZkQmFpUVpqTE82NDk3bXdMQjc3WEJRN0JBYXJZSTdmTy9keno2?=
 =?utf-8?B?cGx6SjY2azNEYWRuZVNOdGREMy83bWxJRFQvL2laMHFnNmwxWW1mcDY3c3lr?=
 =?utf-8?B?QTZLMFp1cDg1VHdWN25IR3ZiV25WK3ZKYmlnOVFMQXZWUDJoWjdXSnpsVkN1?=
 =?utf-8?B?R2psM0Y5bkQvTm1HOFN4cENHV3F3UldDV0ovNXFPNTM2YWtZTUVsaGdxVG1u?=
 =?utf-8?B?WDFDMjNlSDlXMUFhb1V1SWo2Mm5yclFJbEhMRjg2VVN5MUJUUTBqZzVRSXlF?=
 =?utf-8?B?TDZ6UXJweGRiQjM5RlBPdVB2bHVNR1NLRExwUzRiRzR0bkdRU2IvVlRJU09w?=
 =?utf-8?B?KzlNYThwVi9sOEtncnJINEZVM296blk4NWlRbVpZb1ZzOWk0MnIrdEllVHlw?=
 =?utf-8?B?UE5VREs3U0t0U0hOakJEcW92b0RkTzVSVmQ3bGVTTzhIWVVBbHZVNzhvblQr?=
 =?utf-8?B?cWVnZjA0UFJ3Q2tkZTFUcjhFWnlSb1dTRDhIWndXelNpaWh5N1E4TXdyUTAx?=
 =?utf-8?B?eGR5QkRzbk1CZ0dKNGNOZkdrRnhyYU5WL0p1TEZpZlRrYTVRSlUzUGp3L0hw?=
 =?utf-8?B?TkJBSnltVHB2QzBlS3FnZkpYazFzellWSlQ2czVZbisvRG5ZcjRrUUVnTVNs?=
 =?utf-8?B?WlJEeHU4TjVPazkzKzZ4SEJsZWYvRU5ycTJXNjJBcVdPcER2a1J5RS9aZ0t3?=
 =?utf-8?B?cFBOUzQ0K2ZwVXFURWNWMXBuVGh4YndPbG5kU0paakRHaXVrWEFKc1UyRmRm?=
 =?utf-8?B?cDJHK1F0NVdKMWpjYjFhbCtwbnN6TjVCTjdPVXN0Y2ZIektNMk8zLythVVFr?=
 =?utf-8?B?dFZTeXBZbEQ0T1lYN21vc1hveXMvWmFiRXN3NjZmbW9GY2h3Z3ZibVJoMUh6?=
 =?utf-8?B?U3liOHFYQ0V6K3l0ZWFwWjZidWh5di9FK1RVVG11SENZaVU4VGtLbGo5S0RN?=
 =?utf-8?B?ajg5Ri9zWkN2LzAwQS9qcXZ2QnhHTDFhVUlDWGo5dzc4MHY0SEtKR08xYVZU?=
 =?utf-8?B?S0hURXdicU5ZM0Y0L0ErYVpMZFhndm1tc1JiaExGQTdGTGhsR2NaWDJtRmE1?=
 =?utf-8?B?eU9VNE1pajNtVGxJcGsvRVhENWRyU1EzYjlrTENVc05QSXI0SXN4Umwva0tQ?=
 =?utf-8?B?VUlWSHN1dzhvZ1RiQUVVaDl0OUJiakpScDdHa2g0TTRDWkhDMzRxM2tzWVVT?=
 =?utf-8?B?bXZxT3dRZlVUc3I4U0xaMWZmOXhWVTNnSVgzRk5tZ3NVdjNVSmhzdXdrWm1P?=
 =?utf-8?B?dWxndVFWcktpTmFkOHZQb0lUNHNzOTM3Vy9TS2JnYzNCSENKQ2NRTXdMYVh6?=
 =?utf-8?B?UDN3dUlFVytUSWh0d2RQQjlUUUMzL2lkejNpcnR6ZmFCT2diL3loN0ZINWNM?=
 =?utf-8?B?cWd0SVF3WnpSczRFV29jS1dIRnN0NS9zc0IzdUYwTDlwakxpRGpBTmhSSnZr?=
 =?utf-8?B?RDVaWUlMWC9jOUZKdWZpYi9iWVpkdjRPOTMvSjhCSjhVbDk4ZzdncGxzQTlL?=
 =?utf-8?B?aUdGZWd4dytCWjVGUkVTUVRRcTY1WnpNSk1vZk9HSWZlSk1sRlI3a3g1ZjRF?=
 =?utf-8?B?d3EzQ0MvaUI5RlpGRm9OczRzU2xXb2ZQU01HTDd4WG9aMFBxTG13QnZpZlVY?=
 =?utf-8?B?TlljamtLd2F1OGpMNk9WaHlrelYzTnJDUk9NQkVrQXY0ZWNycWkxcUhJRjBJ?=
 =?utf-8?B?Y1FRY2dhYkNGZWNMWEhVMlNWc0hvNEpUWkNQeDM1VWp4enZvTDNsOWYvOUpp?=
 =?utf-8?B?eThMUHVSL0xnWWFPeDN6WkNCRVNxTitpVEFUa1hLOUFMVEkvam5kaXdPNkE0?=
 =?utf-8?B?UWFwR0RET2FSTC9kdkpGVFZwYlpRNU1kSTZZYXRDYWZpMDJuMnF4SXB5b2VE?=
 =?utf-8?B?eXNDemZON2ZURkJxY0ZEN0twUVVjVThqamZ3TlZEWXlZbjAwbTRQcVZ5Q1NK?=
 =?utf-8?B?djhycWp4dFNEVTVOTUJtZFllL2JsTG4yNEIyNkQ0eXFzbTlUWDA3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33E265737ACD7E4FB0D9D29E61316939@namprd12.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked:
	CJWjm5dcms7pQDze7hZZhyg4mxk5fDxxeOI4lnokJgcFKnWACVaQvT++ck0qyo2S2zm6+tAl+QDYQlcYo21iaXpTJN5+NTM4odSSIOFLEvgYTmP0k2O8DNNOg/wNRi35hS2/L1E+U80wuOcO1ARONVknfefI94N7I3hFhitYDC8+KBqzDwRTI1xK2r4mpNsZ3FdYuCb0wsYz6oIa1kEu92RVtS408ktxn9QvEfQKxxMnMIAjhMu0HdILMurdkrbodN4RzPOyLV46i1gQlX6bnzTsf8qyvYoB5nda0CIvMBheSvZIjgF+ClSUZ6q3InJ6PcaawhlCF0StpG3k6ehctg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MqXYXdW0pWB8nHAS0ckG6mWgrkwtKryM72eox70MNILtBduU3qoeRgdl+qHiEirRoKty+W1MNedX2e/6yS2eYcS6tXXdY9gccvfsCO1fGDLo1TP8/05+nHcT8zNAOQKzZSCiKnl+/fZ8WBGBq+Jv1XJghm3ZXcoJI8iANiVoAnsPzEBiCLOEecXZdU0GCyulVsyynzJPRwObA0pYjBa8SP3Ts6j9QQdLPTTY/koVf6d7M/8Tu72Fvtnk92kaSxKr3uq+DQogw3tKapN7AXXfEhsQOmvory7XkPPnZmQdmu3IIMOkTjgReSqkJ7RmrkAE5VuyOOxB3D4lc/FTsWYeiqcHjW9xHlhC5J2fD6WTWgjc8In3Va7TUZQDY0gRqNmRXn0NYm90anVNr1uEM6CUbTUwwZlnWVfROLKB9UKmM5KsGBmafCR/HFPc42NRNlT5Hxpgz/h5nm3EzYzhrdSevCEThU7+P8cJwDtSjrdCpPs9VdSlDblBD8JVjJ6GmmWxi8dzA91X+pIucQK+9l5wrLGn+pbrp7/eNjLU4gKjioNAZv7F4lGxKj3bkATV7RcWVGbWnlVujBbIYB8e7rRXzlZJ15Jxdoyxmvm9fOSo1hiT1pVcjcuoPVdB0h/FrHFuM0Bv5dWIwra79/E3DE3laQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd63e16-a026-4577-2e90-08df3a09bf5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 00:22:44.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSudi+Nh4zcGWWLK1z4d/oeu6udrnEkEHTX0Iwuq1EcZvq6NkhAGBArbom1GGTqVBSUtJUsIvAWyI95guvohVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
X-Authority-Analysis: v=2.4 cv=XN2l2ghE c=1 sm=1 tr=0 ts=6aea7ae8 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=bC-a23v3AAAA:8 a=8b9GpE9nAAAA:8 a=hPHaCvcmtyMyOhY7hNMA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwMCBTYWx0ZWRfX+xKJXKDc543n
 1jrZENNB2ukfiAf7kI4yXEVFlX/yQ01Io69WQ6zB6IFKaRt/av/ARtND7gEGF2vBZESp1jZGDz5
 X4Sjov5txa49bMQc8kcXE7yDbrakqlA=
X-Proofpoint-GUID: P66FNG4zitKXDAvdfPEbMdt9NBVOYafU
X-Proofpoint-ORIG-GUID: P66FNG4zitKXDAvdfPEbMdt9NBVOYafU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwMCBTYWx0ZWRfX4FlUlbC37qtx
 9obL7cwieoX9jDB9Ae6fWUpGFUWmq7rgPnL9NIqXQM+bo/pdmjYB+WZ+fsWXTZQ2TuAOh8aqRio
 yiAUFsHKmnwQvWPsO0RSuvkw9wG9eYb2CjYul7a36xBIR43L/mCLrv43ND/VRTbax+pTpJoaAfS
 SdK88VEAj1Q0IShXx9aj1nqvxwNyv+eCWNU2l6XR2JLCuOKuRutgw+wlyfZb/QeRnOrW5ZkBDCk
 C6u1dItHvc+pq/3LPIrym1KKE52bEMp7g8nzwDSNviA7pZsfe9MVqhbtem/JcEzgZIRhXa74ZvF
 89ZWSt6RLWQQibGgw1eFL8j75P+fdoyMvE/vIzSFYagiVjGfJXcnWalDeewOtUJ6zsgP732ZCLm
 ltBAMhQh7v3yvM1uicvXGxdNRJFbHdHwt4e+kuNkbPv4yvcmSlAp3KRy1HcdS9+hNidl8fesurb
 5dGMS5uSEhmnyb1ytZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1011 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611040000

T24gVHVlLCBPY3QgMTMsIDIwMjYsIEZhYnJpY2UgR2FzbmllciB3cm90ZToNCj4gVGhpcyBzZXJp
ZXMgYWRkcmVzc2VzIHNldmVyYWwgaGFuZywgYmFkX2lycSBvciByZS1pbml0aWFsaXNhdGlvbiBp
c3N1ZXMNCj4gZm91bmQgb24gc3RtMzJtcDEgd2hlbiBnb2luZyB0byBzeXN0ZW0gbG93IHBvd2Vy
IChzdG9wIG1vZGUpOg0KPiAtIEZpcnN0IHR3byBmaXhlcyBjYW4gYmUgcmVwcm9kdWNlZCBvbiBz
dG0zMm1wMTMgREsgYm9hcmQsIHN0bTMybXAxNSBESw0KPiAgIGFuZCBFVkFMIGJvYXJkcy4NCj4g
LSBTdWJzZXF1ZW50IGZpeGVzIGNhbiBiZSByZXByb2R1Y2VkIG9uIHN0bTMybXAxNSBFVkFMIGJv
YXJkIHRoYXQgdXNlcw0KPiAgIGFuIGV4dGVybmFsIFZidXMgcmVndWxhdG9yIGFuZCBzdG0zMiBk
ZWRpY2F0ZWQgZGV0ZWN0aW9uIGxvZ2ljLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmFicmljZSBH
YXNuaWVyIDxmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIFNldmVyYWwgZml4ZXMgb3IgY29tbWl0IG1lc3NhZ2VzIHVwZGF0ZXMgc2luY2Ug
U2FzaGlrbyByZXZpZXcgKHNlZQ0KPiAgIGNoYW5nZWxvZyBpbiBlYWNoIHBhdGNoKS4NCj4gLSBB
ZGQgVGhpbmggaW5zdGVhZCBvZiBNaW5hcyB0byB0aGUgcmVjaXBpZW50cw0KPiAtIExpbmsgdG8g
djE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNoLm1zZ2lkLmxpbmsv
MjAyNjEwMDgtZHdjMi1sb3ctcG93ZXItZml4ZXMtc3RtMzItdjEtMC01YjMwM2RmNzYyZTZAZm9z
cy5zdC5jb21fXzshIUE0RjJSOUdfcGchY2h5NXNpOW9Nb2pUdjBfMGxKMGlBZXdzUHJjZk96M1dP
MHNscklla0h1OTdXeUlRMXZnZkR1aUUwd19Wd0dWVDFsZXFFZU5waTd2aTRUMEFjVDdqaWJsaHo2
Q3p4UmxBJCANCj4gDQo+IC0tLQ0KPiBGYWJyaWNlIEdhc25pZXIgKDUpOg0KPiAgICAgICB1c2I6
IGR3YzI6IGZpeCByZWNvdmVyeSBhZnRlciBQTSBkb21haW4gb2ZmDQo+ICAgICAgIHVzYjogZHdj
MjogZml4IGEgcG9zc2libGUgaW50ZXJydXB0IHN0b3JtIG9uIHN0bTMybXAxDQo+ICAgICAgIHVz
YjogZHdjMjogaGNkOiBmaXggcG9zc2libGUgc3VjY2Vzc2l2ZSB2YnVzIHN1cHBseSBlbmFibGVz
DQo+ICAgICAgIHVzYjogZHdjMjogaGNkOiBkb24ndCBkaXNhYmxlL2VuYWJsZSBleHRlcm5hbCB2
YnVzIGJ5IHN5c3RlbSBzdXNwZW5kL3Jlc3VtZQ0KPiAgICAgICB1c2I6IGR3YzI6IHBsYXRmb3Jt
OiBmaXggc3RtMzJtcDE1IGRldGVjdGlvbiBsb2dpYyBwb3dlciBtYW5hZ2VtZW50DQo+IA0KPiAg
ZHJpdmVycy91c2IvZHdjMi9jb3JlLmMgICAgICB8ICAgMSAtDQo+ICBkcml2ZXJzL3VzYi9kd2My
L2NvcmUuaCAgICAgIHwgICAyIC0NCj4gIGRyaXZlcnMvdXNiL2R3YzIvY29yZV9pbnRyLmMgfCAg
IDkgKy0NCj4gIGRyaXZlcnMvdXNiL2R3YzIvaGNkLmMgICAgICAgfCAgMTIgKy0tDQo+ICBkcml2
ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMgIHwgMjI4ICsrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTI4IGluc2VydGlvbnMoKyks
IDEyNCBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBiNjM0Mjk0ZjQwMGJjMjUw
MGRlNWFjZDljNDk2MTY0OWM4ZDkwNGM5DQo+IGNoYW5nZS1pZDogMjAyNjEwMDctZHdjMi1sb3ct
cG93ZXItZml4ZXMtc3RtMzItMGMxZTVlNjhiMjUyDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0t
ICANCj4gRmFicmljZSBHYXNuaWVyIDxmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb20+DQo+IA0K
DQpDYW4geW91IGFkZHJlc3MgU2FzaGlrbydzIG5ldyByZXZpZXcgY29tbWVudHM/DQoNClRoYW5r
cywNClRoaW5o
