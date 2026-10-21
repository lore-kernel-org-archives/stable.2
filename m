Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=148.163.158.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792543652;
	b=0QyyaPs/3rTl+gP6xZffI7o3rMSQVQx9Kt5QYQjk7wUE7woQJtCEs+KefRbVUj5ccerz
	 bJskbRCK9SoR0gGb7mPyaUuylh7O4KoyV7ftZix8dGA9FMI1lxRL0KWfscOXvKsxqXiKo
	 9LBrH9V7u57e6+JCY5vSpphuZTjXL57+2CWrUhQa+h7Mkv56YDaOnQKbaqSm6DO9id2RK
	 WX2q4ogtV9Oc5fCAPxV6r3bkl9e34n+HAgjJtV0uv52M4Tluzg12qrAzIx/CEpMTy7FxO
	 E+dPRC3XPpQnlQv5m3JgJJueEtSjVuAE1tCrKMWyZ/TFCRlzuu2BZH3aZgI5ApSGo8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543652;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:Received:DKIM-Signature:Received:Received:
	 X-SNPS-Relay:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=a4zz6zumxvWBulJVLdt9OTQ1mONFBMsWZXv6kq3I8jY=;
	b=H8vBf1tbMm5eP02dgx1W0GZr8/wic6jv84GxgGHEV8o5gAPSXptXNG0XXeHHGhVCZCDW
	 Xch6uGxdQoNdMHpus5GiyLjxN1O4IjkYE5H20V4Jw8gnNK6MEQYaTi5oupE1utQfl0cXK
	 zBGI899AiGD4g/gzVD5KzG51H2md4iE8lcAJt6mxfKD+FpzQJhNbVU+mIopTkjevd9kR/
	 3gXq+B4WK26mKh0ZkCylbi8PBPbSHjVRk5bvJohsYYKnRbfGfecpknnWkHfVLEQqRznBX
	 sGPOw86Fd76H0zZtpQqgeOr1pL+wKcfRbQCoKm/72ZMKlklK/YdTOq+mPTzr4zsssGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=H7MhljJp;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=eWLdzgyN;
	dkim=fail reason="signature verification failed" header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nfS+isr8;
	arc=fail smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14F606A319;
	Wed, 21 Oct 2026 00:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA14F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=H7MhljJp;
	dkim=pass (2048-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=eWLdzgyN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nfS+isr8
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKvoNV2052396;
	Tue, 20 Oct 2026 17:47:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=a4zz6zumxvWBulJVLdt
	9OTQ1mONFBMsWZXv6kq3I8jY=; b=H7MhljJpTZH9PnACqin/XMGZ0QSMb04gc92
	wGFEkRnhuIgw6C9Lk+nhowFMbvSX5sqwyD/fiYTHg9ngl+7P9yNMNID/XF6bTvyH
	6fMZ+Red+EdkaS0bWJYw7DsIoSjMwpEAdu/wq3AiVGHM33QpzPFPy9Al8Ngg+7Hs
	SQv50EPK/1jvEwIokFQdSv8ypZjj9Sa74vle6PYkizyCa1LAFEUsIucZZHNkt+4h
	djLbs8vH3HA7mwWmhlr6irXgS3Okmt9XaSOsf/EDiwva0oj6AOSUyOmLeoDvEj07
	fj60+BKF0ddf6WQkTlIH2YMtzMuCaRMElb8LUiPb/IktRGrmKMA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4hdw6v8fww-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1792543646; bh=Fjqz1O4GdKIOJMbRuePbi4TlrdJYI070MxxDdVAhNqs=;
	h=From:To:CC:Subject:Date:From;
	b=eWLdzgyN1C4e19NHEwEApHA2kCxUqERocno3p4uVyFw5Q06wD1V1/4VLiTbsfhGJ3
	 dfQDy3rhDir2kyrlS161SVpqL4JSviSshbVY6SmZZNG3NTJLzCQRw7chq3QzaiVDOe
	 Cs09mEUs9uaxZNMTZRYJDsfVIZe7KGqNluwvQnNBwe5+TuBPSV+6kJ7gdK8bL4Zod7
	 V8bhvTvWhvWHvSK/hrb+1hfLkHp21+jA4ROVE2hM13LGQ0jOeOj+1sdJS06xw20NWw
	 5uqVXCCTEfFqdAyifcOpBImD7uo9PUuD9XXSc7XiwcqVwesR6fiHckLsQGQF/h1K/i
	 /KCeP6Uuo5okQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9DAF9405E3;
	Wed, 21 Oct 2026 00:47:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 724D5A006F;
	Wed, 21 Oct 2026 00:47:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nfS+isr8;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00106.outbound.protection.outlook.com [40.93.13.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 22136409C6;
	Wed, 21 Oct 2026 00:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9fvskG+vra7BwGhZfRnaBJjVJeBtjPdyfXcRg3WJZKZ8zeDS30dYbtpJcQWFmAAufc4BfhIHyuGbFA6go7A0lTgAjQ0rs2J1u+KPIUkDvgsLS23wUChpFL6q1QzkDKlS8MNJ1QLFXoGK8xbbP88uapsMJxWnXQpSXM7cXgmc/BXR6hpKQ4XnDB5rVDBtO9riB3Sf/mnjo5uZ5aBZaaZT03gnAYReYm7WQFNozzSq6kfjldCMvQTmyejZuZZaWK/qh18i92ozDm15+CFBHk1aOIOmVWsVnDWnUfnWlLfG+8/N9Nwdfou491OEnRLBlBCb/ZU0TPliIveOmIj/Ex0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4zz6zumxvWBulJVLdt9OTQ1mONFBMsWZXv6kq3I8jY=;
 b=Kb0W0fwrWykM3WmC9uz7gk8GXTL15OkA+AscDBB9btm9HaahHduBNIL4GhYQDvgQZd3qV51CrTkJqIUb8KR5R/BoQfLnTWPmN0tI/yOed/O8V/y7R5bp9qrZxnksjd7oz2c7jbXiqQlD2qnq7Wo4GpHJ07sNo+wmIPv7xhG6YD0gr/urIJxgRlzkQa9ckn0+AAxW+qhe41Wh6aSwlN5IUOVkGO/YASnGOKW43GIbkkXTS7nE9w2+mtSJVirXLllaeAM6z/7GD0FbXO9Qu3Fv3tsPdlzNYGuEgMshUWU1DvSdyChGzhkYqEYmu32nTW6Qn5v9v9dOsBvkzMpyFCe1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4zz6zumxvWBulJVLdt9OTQ1mONFBMsWZXv6kq3I8jY=;
 b=nfS+isr8tFst/9CuC3IrlEqVtjYHHHFfPSlEI0dTLtfGYWRf8K2Q75LprXXQ41JfNQA2o7AEeXN95L4LOng/6/3n933hl10ZgK52IMqW/EKUjxpGfgb7KFKmFJxw8rrlA1FDW8snEzCT6c0Gy7UdAUcXxs/Zv+eXT6Fs/1NFlFI=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 00:47:17 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 00:47:17 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Prashanth K <prashanth.k@oss.qualcomm.com>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: trace: Restore request name assignment
Thread-Topic: [PATCH] usb: dwc3: trace: Restore request name assignment
Thread-Index: AQHdYPW463T5/6tZyke2fN7/PY+KzA==
Date: Wed, 21 Oct 2026 00:47:17 +0000
Message-ID:
 <8bd045b136bfef8ce5de79f1fa2f09db639f0707.1792543567.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|PH8PR12MB8607:EE_
x-ms-office365-filtering-correlation-id: 52d0466d-5076-4be5-2602-08df2f0cdb60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|11063799006|5023799004|261009223027099003|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info:
 QDVurswu56I5zC5dV4QecbT7GUaWExmgpLsR0Rsc8ZegLvOffc3lgi5Vs8yFr7tR2YGc2imqwXk2MrB7I11M3lKKRWzC+1ARMrtQRPgZoFYEve2PnfxViIaBg8OWV8Qbqd9/Goh1P3MhuFC3zTJsagIPrTtEu/iDjUUiEjT2eUF7sXq6fBS3+vfCaxSp3x7vB755ZScn653wKeW0OnS+OLc3AHy7pB3RRY2/UTdYkM8Wf6gQJtpSs/HLYM2Cjle3efkDToCLGcIGeNcTwBJjcHdlqtKoS7DY8UlY+02yjmBO9ZyHrbUb3zkbHS33Eo52O1zzIZtyITjm+RCbrVVz0y6liStvzzFODHlrpZFSoBuIzTGlXzhHNmnmLS/GhlJBRqqNOkgWIJ+X0XAAhUmOue3J1Gz4B8c9QEmqncD2EUihnbbDJgwwUSBsfHmBSATxeFBxoQBUt2HKGW8G/fPQltnZWHSXvgzXioajsYwnaT9pysB7kMN3vHjBtRb3r5eRkjYGXDYCmUDeQ1CZ5KrZ754fr1Wl7dt/O6DD17hajlVSmsxtBlz2mvB8HZHk7OlWdq0rXrOr7H0NadaEjh31BdxwnIYY7sgbX4OZR/ELXtqUykA2qCb17uUOjUZjBX67fnRZLaL8+JRnUWk/A9ec5PhNNoE3Meq6wHZbxWMSJDKdWoOPK+28atGgHooXL22ZHZsVmWPJltukCnolqaX8t2Z91moYxFhPlBnly+JfHWE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(11063799006)(5023799004)(261009223027099003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aYTCIP9wkYtjmsjM7p2+MxU9pboG80W5pOUu6zuuy40fE7+wDOZR2vwqKX?=
 =?iso-8859-1?Q?nM4cCUYlR8HsGWhZT3AQxqU0GiPm7kHPyHd6PWtA4e91l1tAUZUOSGmNis?=
 =?iso-8859-1?Q?cszR4U+039A8XU2deeCUNNrGiNZ53VfcSkvQWqDWs0cQTakUpuQBYwH410?=
 =?iso-8859-1?Q?56PUqvt9PAH25meq3viaP+7/vjW9FizHIb6amkJzCG8BK73/n9BcqtRmJ7?=
 =?iso-8859-1?Q?J6UFg+El4kSqbUC3Ag3M+kXA7Mzsh00pRxwEuxaj9J9zCioEM9aA7XDN7q?=
 =?iso-8859-1?Q?ZXlCy0sZWCnz3zyA/O4vE0hdBt+KmojrS48qzrbD6R7ruedyiFyZ0zKuOx?=
 =?iso-8859-1?Q?mUWhfiHOamfWBX0uOwFJErtew3WTdBMOvuniC+jsZ4126Gntz9YNWGGE/E?=
 =?iso-8859-1?Q?QEn1FLFzpauz9rcnL20zEquFmpaSUuGXnhPTDJU+gehcxJ5OWocIigRJjl?=
 =?iso-8859-1?Q?mcwAVY04cR/d+jQXKNmqbUYobWDF1264PBcoqwhZVGU325XpJK8apcfuwN?=
 =?iso-8859-1?Q?tRT36HBj4xMVOsNgNkrD7ZQl0AmFooimZsHfwxWZFDklAxWLb/FB2NWT3B?=
 =?iso-8859-1?Q?X8jR2EGY7ZB0Qlo2MncmEJ4trgz+BeStb+dQm3mhyAg23E1OiaD2fNqUwk?=
 =?iso-8859-1?Q?gOPJQFc6ousEcmpdtWuh3oj1fHhn82YKdzf/p1uqHTpZ0BM2AxESZc66v+?=
 =?iso-8859-1?Q?TvYrMpVwT5gbqcjXPY8ZOx/ltGrrZCCI62kyzi/0PG20ASK7rnOCDGi6/r?=
 =?iso-8859-1?Q?T5TAjdzEtHDDfHPWM2YpHZdhXiMfhvKrTck598DFV0gkADeYN1+PTK6BdP?=
 =?iso-8859-1?Q?okm6u/g2ktJo2vDNrVWV+6cTt9CuMgXznl8LmG/mxiRYye2E18sE4s6Mrd?=
 =?iso-8859-1?Q?K00anGx2Zu/wuVFQd4/Ce5N2ZUm9RPBsvbLkIonLGvXZJpJaYnidcH5k0G?=
 =?iso-8859-1?Q?nyH5ipuPznwD8uIbnb/VWUytxKElY8EqsO0bzwi+oX8ZfycMuVR7tQBGof?=
 =?iso-8859-1?Q?iV/+YacdTgnu4mRwlwBpVYNJJcCcs13GXADvzyoEA7e/eLG965By6n2Yk4?=
 =?iso-8859-1?Q?ptJPzaRTfgvmD/DbY2rw6ZkdPYA6OH9u4HiSr3DTGKaTqxPchXRpebfdaz?=
 =?iso-8859-1?Q?MipzXD8ZoMtoGd64kdJ+Yck93WVfXtRUxVCxKhmgW446mvYOp3DKmNYx4I?=
 =?iso-8859-1?Q?eeWOZX7byvGKliv9kkkMDLELJbHcx2GOWioozmONXHO7nivEt1Di1/m3eT?=
 =?iso-8859-1?Q?BZiAhPXFrHZD8q6YAd3UVl+Tv/HVHgSg0sZuOlJqT+Z6KrpPgVGUKCefuI?=
 =?iso-8859-1?Q?4+TnYPbi217HVakTE7hrLi9nf8fF1Z9WXVmUcVziAxkh1gGlynGmPa50Ze?=
 =?iso-8859-1?Q?lq3L7QqHpy8GRvoS8BjSneaLNhIYyCVbGeUE5p9mGCd7aicnkjrjDf/AWC?=
 =?iso-8859-1?Q?upj/Fom7DgdWlvf31tT9+iJ37hF+XnNlTxCJ+ySojr7khWcyDXYwIT4EWH?=
 =?iso-8859-1?Q?yBKlznfqqRZ1FVh3GkqUPwCWJ0BtJa9NKhsJh7Q/ylEZ4K1bg/m6EMnttI?=
 =?iso-8859-1?Q?wX+GhHpasCu2iw7tPzgCFA4unqcwzBYyOceobvXmLNgxoZZeCw6d5hswxO?=
 =?iso-8859-1?Q?tGvBRDnp8hX3bCkjexVkT+Idplrj/doaWgiC8V6aio7X7vWE9iaM/qMXCC?=
 =?iso-8859-1?Q?FB43WEW6a8iJNd8lr+XSFlzySZRIKMSM5D+4T59xrey0l0i2Lt6DqMyytr?=
 =?iso-8859-1?Q?h68rlPIhvTn+yB3q0a6j6efyHlhHUKTxk3erpTqChKfLT55WzossmgHzfF?=
 =?iso-8859-1?Q?obtD1OVgVQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
	IRyzOvfsOa5+J947i4CywHGXwJtWpUHGUolNaLEIjjaq5OzWKmJPangQlo2Z5B5GHxoLhTHowbIT1sINy0NcIxAqlDuvRk63nnFz+SPjGz8bCIvD08/kePz+rcsiAKwbu7a+KAojqiWB0IWD5Cn0FWGLRT1cRHwQ530KNbEvYNNSR5GRKscaudv8/ZbfShcmaoLW8ZoYJSZbzynHMpclDsdiOgGcwMfg1aIZ0beaN1hR64qT88kZWrwZkRzSXef3V5QqVMM32u8vAaUJuTsIuwjgbweRaM5OlMLwARif3YYyxhSDk/co/pGqjRs8gys+uLocMjM2zUz0osOxg5Mpvg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uZ3bLbJLEvg4S+tp31BUeQ64oHRnWigQz1nU/W1KZigPpZJfuNWjKCnxl4fIutC2NqhgX2Fbjlr4qb9nN/jo0NMMzbPPutGOmm0QMUZuzTudXsABHkE2W11hj8vRKLGn+5QFwn/HvS55qV4mDMHE5moXWgEpHewLyxpwpnhbgtwaxDXJWnFjAC911TGCp7Q5tQJJ0T2Mpovr8Qb5iD2BOFVjJsoMzb8ZhtHhdP1u9maCGi61rh+8ccLeLO6hGH1nOIKHjwV1idnaoMphF8qxuGYMCuiSoDbTg9V1CPVyBVXtg94nxpJeMJZf+y6oOqITlIWgl1bgyLgTwI8oDbzk0xQsxjrD9U/Vbsv4KyrZK6UvJJiNscgmDH2HgnyYGkxeQ8U9K7DgK7xx+LXzgbfXe0VQUoLVoTHWnOHycpVTc5q5yg4IrFirLtzjWOND3wVx1+eq5pZlXgl2Fb3ne4kAXpjg6D8SjKAV47r8OkzE9zIZK/B0YtA2eha1jGbCPfY+JkA9kqfXHpktNYzBTpiIDXid0c4B3NsFiyOdvlvPi+CN6JrlvxLz3YFwWXZzSCmUNYx6354r7R6TAO4y/NS2xBG0Tq0rDUunAMfgBRPOsBtOOPMzK9yDWT5RDMmXuzQQzGtlt3aVzQa6E1h1sA2UFA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d0466d-5076-4be5-2602-08df2f0cdb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:47:17.5418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANmHZWLQ2LlOLtQ+s6AG6T3IoEIpEUIYnAo6slvcggBqkkTbZtLlUDqfcBCjMAxvvD7aGzjryeatIfTXcJ3GlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMiBTYWx0ZWRfX7ZlRLJ1e2crZ
 mPwX1E739XeYk2Om2S0Ovikr4/U+UXXJXXA3xaUPm+g3+6lpZuyqF+BrE/8DDqWZef4ydGS6Q2e
 UEl+RsxYz5suCQJ6OkAybFgVQodMrEE=
X-Proofpoint-GUID: dhEXalP_gH-wufb9IHaqWMNtW73pXHL0
X-Proofpoint-ORIG-GUID: dhEXalP_gH-wufb9IHaqWMNtW73pXHL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMiBTYWx0ZWRfX8UfTHKy8KWsS
 Ocb+s54+IoFLcs+Mcg/+4Zgg/eKMT4g/Olq0UCD1SE2VkxSh47FDY/kFl/49fLfWbXikOE7Q9SO
 WDvVMDwX6eOejqdpPelzEPv32QnW6l2t9QtsBFKJk6jDJO8JCM8Bc5IND7fbvk+ilJ+k4bh8EWT
 Q4uV0t/dFXrdyR3fulb8+LNe9QITVufuPCy1U7sRfKA6uZN1fLpAYFLtYr81K6c2+m5Pz7Bzu3D
 ceZ4F2wdJuVZ0lEUIr+AwvDk+9z7tIgcPx2b4Sdc4gynP9PkU67+mLkhJ84K7itYqUDOsWpgo9V
 VOyLxzfME54Q/pzSk6CIR+q2rQ9hW0R+AwknNZJTygzKlm0XiQeiA865oBWPSZGolPYKQnsoOv6
 dD5tkO6Fh/O1vihapjuDOygcns6qnR4b5VvIO+e0rBfC4CdgMuMzoGB+Huhu/gYxZGULzLaTDLL
 sOQe2njFq17b2TlYDYg==
X-Authority-Analysis: v=2.4 cv=LK3z05W9 c=1 sm=1 tr=0 ts=6ad80b9f cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=T96V-a_VsoqNSA3s5O8A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610210002

The commit 0a06917432a7 ("usb: dwc3: Log dwc3 address in traces")
removed the __assign_str(name) call from dwc3_log_request. The name
field still exists in the trace event, but nothing fills it in, so the
endpoint name printed for these events is leftover garbage from the ring
buffer.

Put the __assign_str() call back so the endpoint name is logged again.

Fixes: 0a06917432a7 ("usb: dwc3: Log dwc3 address in traces")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/trace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index 5253da23d8b0..0caaa0b396d1 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -141,6 +141,7 @@ DECLARE_EVENT_CLASS(dwc3_log_request,
 	),
 	TP_fast_assign(
 		__entry->base_address =3D req->dep->dwc->xhci_resources[0].start;
+		__assign_str(name);
 		__entry->req =3D req;
 		__entry->actual =3D req->request.actual;
 		__entry->length =3D req->request.length;

base-commit: bdf12cde30830d46a8ef1ba93986356f1164b4f1
--=20
2.53.0
