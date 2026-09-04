Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4573F4101;
	Fri,  4 Sep 2026 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564664; cv=fail; b=X8oGlcmxBH+JPAzbK4L1/ObAW27kGwh+h8qn6QsGXzBbXcBiRzDlog93igj/lXV8JoRHRDvwoctIwg7tPIGgJpyRa7ZlgRtnWAH6XN6KQFOaZO3hz8O6XK07BDtU7kxC16fFQ8Bliitk9pk6GBSCyTOh3qLx2lOLjSkHbZGJ9wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564664; c=relaxed/simple;
	bh=q6AT/ldcWS+y8DKF9ghqU/4UAT1+whT9QYreP76HQIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=co68ueMCBc5quSYtBqXFO+ihisjCbR8Q54i/JyHBiEwr2SJEeqq45OLxuRSJZCJuOn64rUm52w3W4+Qhu77EC70cH0WqPKImsWlW5svw3FTiNHLarRdiTWD2kpdoaA0lgJtUhZY2E7CFbzIi9lfdxwmnCcIjaOX4NSiE2tkPuuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ju1SUn3C; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Pzmev0ZE; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ag0bysjE reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ju1SUn3C";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Pzmev0ZE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ag0bysjE"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Kd3mR3795209;
	Fri, 4 Sep 2026 16:30:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=q6AT/ldcWS+y8DKF9ghqU/4UAT1+whT9QYreP76HQIQ=; b=
	Ju1SUn3CXx8dpHals5AQEYobsn62FTXG3Aobnr77DmZOt/FSNh7OnkzeW31G5cUe
	r/oqi2AglfdTbQ0N8OZRt/f/sOQtnJvd1GflYz3PP9wzXOnevawDjbDzYyR6sxg6
	D0JUqODXsH7Eo3ywMb27hYrkERvQrsJYhWI7SsfUoizY9IcxhcK2fMBu8hj/XzhD
	0Pf9UcKiaxKb+L2qbE+pYZmJwOY1+wvyEMKDs2fGDkoRvwqffpz11NRdKKVI1rvf
	D5Sl9nWk/Rg/MYJmrChKt3X5lBYFL7+aXXbWjb8hTj9S4mltXczxj/li4I3VJE0L
	eMItqwpE1IGmYdyT+QAOxw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4gg076c0ay-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 16:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1788564648; bh=q6AT/ldcWS+y8DKF9ghqU/4UAT1+whT9QYreP76HQIQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Pzmev0ZEGvMKKCtg1Yfp0pr8WR7+bgn02oHUgM6sqA0XNcxAvoMh67VaY/0kb3WdW
	 vEd9P+BUa63HqNFAW/KPVQeynCAIQWvf4RDgsnNVUcJMKVrBLPA+/mV8KAbGc9ut3T
	 OHfhm/aR/UdrZAZFWNYaA+Y0Gaqpxg09WDeQ46pRneR8j3SVlQWqw6eGV0Ks8rQtjD
	 W7QIT/kTshop7w7tf4/jyN6TnwgenciETYvKxhR/veSfS2CciTG49DAvucrvby8ulc
	 VTo7Buzi/m66NuLEdTwAHq7whQib96pPEGn7VJsadSKoRLN88+Y/jaWn1OuPL1zMSM
	 B0U7/C+S3QQow==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7DBF44035D;
	Fri,  4 Sep 2026 23:30:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 51637A0E63;
	Fri,  4 Sep 2026 23:30:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ag0bysjE;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00102.outbound.protection.outlook.com [40.93.14.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E443F401AF;
	Fri,  4 Sep 2026 23:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElYbOJxXFfo6WQFiYOXOZp9sAU7CDNXK/pnuP+QXdEEf4sZMd6k5RpMQ2SmAy/JgpnWFZZxenrSk277anmX8HvebD63wWdGYaMpjaXxreR7SC7uVj3P4TEjo+J3L0M9os8WEY7UdGz8vN8IreJzAairqTlTR4DyUCWCTRCjTwAFAPw1FPiahUXNi2lX/78KMODz2enp60UTd311FH33n1dNwLQuq7cVrBsaS8roXEcn1IxODwYzRRRaSLndIBwQVV7wBDMgGwZlei9Mm1gjzsJg+AmubRyeydAbbn7n+GDQQcwXp1USombnf42gs2AQAnFq7KSOFMLNltxx2C6n9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6AT/ldcWS+y8DKF9ghqU/4UAT1+whT9QYreP76HQIQ=;
 b=LzvNd0DVE8tVMAzcIgG8+4mZDE9sbHkO/8KV57/mIreRkFbS3A0k4Om4DasXWzslKiXvl9iyk/ngaREK36/VWe0lEbdFK6hH5jexm3SjqcOM0gvpnG/GAciXxXZgogJhFWdLsKEW3HLDALFfUVYk6bL5LhvszMfC4qZ5G5R8F9Kno6hXxWyd1CoPe9R30g+t65teyqeX7kFXGh8s9tLZH/y+OOzA5zFf9bkwwH5kuBWTprLPNwrzP0zJPaiVkolq5iXSORYic7UWu9sruGRrzTO9tJ9/YMyMRtN/M0l/FFvVUHPiG7JBkwC7C+D9LAEZmJxe0vA6VqmRghB0f/VQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6AT/ldcWS+y8DKF9ghqU/4UAT1+whT9QYreP76HQIQ=;
 b=ag0bysjE6B09mMpVRByazomKs9W6KOzeZDxaO22TOjbXic7sbcAjlq0Jg9/vWlHd2w2G0PBBYSfToy6xUO2Hcq+R8i5S9Ntywd+wwEYN8s106dZSc0/bHL24q4rgqi9NddBXsfcPJYVb5JqIqrGMHlBHjJmtqnUTk91NC4kvKwA=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 23:30:43 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 23:30:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Cole Munz <Munzzyy1@proton.me>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: don't error on dequeue of a
 completed request
Thread-Topic: [PATCH v3] usb: dwc3: gadget: don't error on dequeue of a
 completed request
Thread-Index: AQHdPKgQ+cX+KZ58+0ydJDDAkiBvpLa/EX0A
Date: Fri, 4 Sep 2026 23:30:43 +0000
Message-ID: <aptTU3JD0xPMPmfL@vbox>
References: <20260904161344.2191362-1-Munzzyy1@proton.me>
 <2026090406-unrevised-stays-4832@gregkh>
 <7bef11b63feb88f89b37bbc86323ed3dba794f43.1788541086.git.Munzzyy1@proton.me>
 <2026090413-hurdle-puzzling-aadd@gregkh>
 <a0cdcd76b7a6a3c841b7957a2b761ae71ceb46fc.1788549031.git.Munzzyy1@proton.me>
In-Reply-To:
 <a0cdcd76b7a6a3c841b7957a2b761ae71ceb46fc.1788549031.git.Munzzyy1@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|CY8PR12MB7755:EE_
x-ms-office365-filtering-correlation-id: f2e74196-4ab0-4b9f-9ad2-08df0adc89fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|4133799003|38070700021|10067099003|4143699003|5023799004|11063799006;
x-microsoft-antispam-message-info:
 6LIFou7Rl+/i+m4ExvZcOdH5DxTmTOav+ADInBVR+LbarADkjAshuRz9RxTSlgJHkrw/Rx14J+AvCaSdd+qVWvTlOb/kSs5Ve/sEKyiijjPZZrBnBQ9ZjTZeSksI2+OuYjnTJyaecuIld6OBUCtxkEROdj2RQZ+94CoLNLN5iyMlcZD5odeVo0/zUWYH3Apoa8+7UuadSiJg8RGJKecfNQG+J8IQp/IhWiqLbv87gbNmJUnepaDOUWB0yJc8SQ+DrOqGLyUGot4e7HqP4hlunxXBG8ACZiFMhGJR0jIhW2ivaqnGgOmA49FEtkSdq2AMrxOvIpKsVnRbmMr2DaFLwnN3HJQMn48q1Wade9qkPUZDoJyOJax6RJr7JOsUIk3NrnEiRnI7kzLXb81uEALnC5fdFHI3htUxW+7P1g64yvmSaHfQZYzsFvtKvaFBUmM5/yCbEy3EBVOMK83Y8LRwbWzLk9FIMI0C8fVIetqUeab7x2dMTomfKS6QwKnZnYfx0k1mfPVdur29XSAha9gO79dCZigxeEUTMAFa5Q/BsBDq1y00KJXdNZqpTsIhHZw+MYxoeYP6fznYEhfbEsgT9aNFLSBxVLOKn4+8x2Ua9kZEju3pFqhyvxtmxVJvVyqpoPkRq8R7rn5qDjLMzRDsU9Sjb2TB//O914YTbCHZROqCGX6j0xi2Bx5kRgyze3s/6WN17myMW1tDABoPT4LY0716rQZkal1m2QK5EE1txqM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4133799003)(38070700021)(10067099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3B1RnNXZ3FUdGp5VHZMU3N1NnpZT0tncXVoNFNTb0FNSy9XVWRRR1RzNUtJ?=
 =?utf-8?B?dmxpdTAvM3BTNXZLeXFyTXlSZEwrNllWOHMxbWhzNVlWeVRxMXNZejFqOS9t?=
 =?utf-8?B?OW1sakp5VVJBWkZ0YXNYY0cxSG1HZm5yQW1OMHNWT0FjeFl0eTNKS1E1c3p1?=
 =?utf-8?B?ZndybFdWa0VDU1JIbHZOUC9uSktFWnhvMFlrUEJHMzBMSnRDOWRxdFlIVllU?=
 =?utf-8?B?T3ByeTBHSXQ1RTg3SnZsb2JjRWQ4c0NHcmlMSzhQcGVKQXdaSC9SbFlZYlpQ?=
 =?utf-8?B?YlAvV0x4TlJqeWt2NFNMWExuOEFMZlphS3hheFJyalpKbW9NNUhjcldZSnRK?=
 =?utf-8?B?dFNXTThnN3E5UnkyMFlXcSszYjhOOGVPR2xLa0hwTjFpZmlRL0hPMWZEWDB0?=
 =?utf-8?B?b0JwMVltYmlFV3ovcHNyTVhhNWdBdy9kSmVlaVZ6ZVVKTzJiTjhYMHQ3cXV0?=
 =?utf-8?B?bmwvZnJoK0ZzMkRWRVhESVNTR3RNT2hPYTdsSGI1ajVhVEZ6OEYrSkYvUTZI?=
 =?utf-8?B?Qmd5YzQ2MW83dzdXb3BLaDlnK3BWRDEwNTgySXl2ZHJhMDJ5U0dadHpmdHRV?=
 =?utf-8?B?LzZQd01pcnYxMGFIMnd4eFk0YzV2NFBaTHFEZ3NJckJSdXh5Qy9FcjFCNXVq?=
 =?utf-8?B?SWE5QW1pWG15dnhQRmtaNVUzTEh1bkgxbGsxcEVmUXZsZ2puMy85azRhMUVK?=
 =?utf-8?B?NU5DVnFvY0JsK2QzUE1uNnhnUzR5cVpYZVdrZFJpb3EwUUtQU3BUNUN3TmFQ?=
 =?utf-8?B?ZGxvRGhZbEtTVUFjYjBCZ2Uvc3laUGVVcTV6bFlFNTN1T3kxS0tldC9zTFkw?=
 =?utf-8?B?S2crQWtNTTNCWGFlTVczUXlaWlc5YmdUVFlkb0t6YytJd29FZkFsRnB5SDUv?=
 =?utf-8?B?bmZWbExWSWd0V2F4MXFiT2tuS3djNjg1RERvMUZOOTRNSUV1ZEhpWDRKYysz?=
 =?utf-8?B?ZVFhQmZxRVhocUJlbzU5ZGVNTUQ3M1g1aGo5eXRGT0xFck1TU2FXWHZldDZC?=
 =?utf-8?B?WDZFMU1jNjZhTkZKNmFKUlp2TzRoaFM5OGpvWTFHWUVMWE1nZi93WS9FQ3BO?=
 =?utf-8?B?QzUzYVhqcEhBZXlxb1I2TVNEUFloWVJtTFJPSnU5cWI4MlAySHZ6cC9xalRZ?=
 =?utf-8?B?Z25jbXExaEhDMmdhdHlkcEhSampqbXYwMVVWSFh3NUI3ekk4NXU4WlZYYjJK?=
 =?utf-8?B?cTNoOUFpMk1wVEFad3hsWVo4ZkJoQ2JidVQ1YkpYNFRrYU92L3RYdnJ0TGtn?=
 =?utf-8?B?a1FGRlVneWc2d0dpdmhPck5MMER2YWJHcWdQRys1LzZERlVsWTgxUHp1ekNE?=
 =?utf-8?B?RWVGME1VaWZ4WVFRRWp4eDZ4d21BTVBBb2xRaTdQZEtUUEZsL0lLekNqc2Nr?=
 =?utf-8?B?VTRVYnpOTGN6b0lpYmtLVUtCVXJ4V1RHeDJZQzg2RWh0SFZaR004bGNaVjV3?=
 =?utf-8?B?b0VRclZpS1pScG45MXRoemlYZ0VkUzEvWVJqMEl5Y1F6d0tyOERxbVdCY1d5?=
 =?utf-8?B?bmFMU2ZGUEdGRDRiUldNOVU5bnpsUktFcC9hQ3JHMit6R29QNjJDSUJGZEtP?=
 =?utf-8?B?ZGhJeWNBSGVEVmN6SnJPakd0YndEVFBNbEZzUFg0SVFIT3BWdi9qaWgrd2hX?=
 =?utf-8?B?dFljNXBEWEVjcDhGTHVwZVczQitzb0hjUEk2ZkpXQnlQbHhvc01ySys3VWpN?=
 =?utf-8?B?cy96ampPT254TUVoeElBRURvTkF0UG56Y09vK0k0TnFwUEdraWduQnUzRkcx?=
 =?utf-8?B?c2hVV3pzSVZTczhtQ0QvTFdZSmg3amhvL2JzMjgyQUtHRmpZUG9sZTFQdlNY?=
 =?utf-8?B?dlZvNnp3TktRTkN1L05ITCt5SS8yMTdjRkNrb3hMenhjUGZSeXdnbWtwbFBO?=
 =?utf-8?B?ZEJ4MWg3K2xyQ0hXOHFsNEpKOXk5d2JJZHNMc0FyQWZybTlrR2xQTWcvWFlj?=
 =?utf-8?B?akx0bHluMXZLZW5kUlFGRWFGSHR6YmZRRllWUEJ3MzgzT0pGVEpJNUFIU1Bj?=
 =?utf-8?B?d2xDdi9saW9UdEFlTDZ5Z1JBVWlqVTJjRDVhSGFHcDV1NHJ6RVRSQ0R6SWdY?=
 =?utf-8?B?WDZ1cy9DNU9CWDQ4bkxaQXZLZTNWRVVLL0FGN0tpVDAwRzNtak5xYVVXa1JI?=
 =?utf-8?B?ckRha29QTWl1RFIzSmNDWFozbTJXQkROMG16THZjSW10c0k3bEVTaHdDVEpK?=
 =?utf-8?B?R0xyTWx3UUwwV241UDJEaWdRU25LNytLT2VkdWpDZ2NWS0J6RnIrUlBrY1E0?=
 =?utf-8?B?WkUzbmZZL3U1U0YraVdyc2hkNXVvSUtmdDRvdnE0T0RpYXNINDBMYUZqVkFJ?=
 =?utf-8?B?bGw3TktrMmJYeVVPMk9vS0JiN3NEZHVrNHRVYTRmZ3JNT1NWNy8ydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0284D41CA4C8A14B993DDE78852245E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	4t0ldK0GUvCa5eXmMN7atQ+rkXMZtDuce2rovHLu46T04k9fcijMZKmm3Rg2Otv5RthtH6NP0w1qZyJa4Fg0HTXeGn+8D+E2UK3zla1O97K9TUDA9y/mDhDeEH3evnCy/kQaYjVMVXlx/PX3TPnV1Ps5pSzpXpyJE1qQ3Uq3Yj9dPp3swTIrYB23d4hklXm5zGSxBUcMONSSV88S6oLSE6etI1VwcGuLQgrYhLRLsoC1AqVIUF7nUalBT5Sc/lNZXXh7jutdaNopNzgzIvIiv+O6bvuUVyb93k+RqsLu8k4g/RZ1al3rwH2ugjPNKIFD+dacrou6CdnyIyRSUjCvxA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	erFlfp6DRp/7ttWTJ3WWDH2/Zdb5yqKWHed6RqFgM3K+SA/WJdoW3EhofiZ8C2gH2XWgqoJMaiMwPlhO5NoKtRQkdutE0NR1OIjZEaoXlfh8W9XNqsKI5hV+FQ96CgT7T39XV+UV3y7gxhjdAY/GoQISQub1RNJQ6xjpR1LaAPv0Lmut793Zanc6ueAbT8RAOUP8I5YzhpefCK1ZrT/bKmX5fE/2XulPBCFErINbS2T0Ssno1ezwFRT3PzRscO2cesaymSFVoD/2DalQ2g5U03ip+pE0CEuibLm84dPnQfZ0nYoicyE9jbjUPxL4mHFVAaVseJzRnr7kEbDRukA4aoBcJUtPlIHUbR0fgwXWMhC9HKvoan5Ujszc+e1ae9aR3QlX9XCKdEIpkDesZmuOgc0+odlxKh3JbUKtfxIVuxc+nFZmkt2TmsvMyIWZwjqc33aT3SoOzb9TAMfxT7qNWIGedycqFzxCivkEy8dxZth3IhbbJQJs0iRGR5L4AEJJ2lBg40TGrh257Eq6ltgLZhMf8op6GOMTDunkg0cyf7oFGh/NrlrmkH6XAlW5V1u+Wb+5kqVV0uvHrKT9QM2/WuDnGU60TiSSSb+hXcQ5RlGyP8fqEewQu01l3IeISckTbyDLGHq/IQG7yzubu0jCNg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e74196-4ab0-4b9f-9ad2-08df0adc89fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 23:30:43.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLiBKpKyweWHbSYKVLovPYL9sLfa+MALfzHnFfmBqZ9fd6aA0MOHtZWQcfvt9rrfVtgCE0UEOVEx9VzMFl3OHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
X-Authority-Analysis: v=2.4 cv=P+cKQCAu c=1 sm=1 tr=0 ts=6a9b54a9 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=JId44VA2xFcgUWbvUOYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIxOCBTYWx0ZWRfXyBBpFed2ORNs
 ekrU4d7xyZMn+GildO1oWvxAnalZYbsUd/uDx/4rM0+yuRW3vtB5Ud8w8HV81hMsoMKpR0k2KVL
 8SBXzRV9x/wi/oBk+p2H/Gr0wXfTdjaWyNeInmNIggcff0g9QVO1H/SF1YayuggMr0IjSaNJ2O0
 SNMT3gwTj+l8D0+xUb2lip/cSJVEip1kwaxnqkKIpGkvksKuhT6pB2oDXtYzoJ1c7qgCGzmPi/S
 Y3B07LtGu5eDthbWVilJ7sVsJwtjnMSBGNQWVTSsmDBIudq8dVZ1p+bAJkKKdSsp3Tl9SWXDyEk
 6lNg4W23bHkHrux6tHdHTBmcSLDaR5jdEsNN/0vdtX+hS0W0qQ9Ayk4tLgS+1rNzMewOotL5Rsg
 okz5OVv9cHYBPmFzS4KceUqb0Tr8L7b1NZWq3j4F/CZP71OkqQuqfkazMDSwR2hmzhqKrGW9zB4
 nCFnSwYz/HdZbnrxvgw==
X-Proofpoint-GUID: QVkPSZH2ExwRTDau_UrooZHv3xanoVO_
X-Proofpoint-ORIG-GUID: QVkPSZH2ExwRTDau_UrooZHv3xanoVO_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIxOCBTYWx0ZWRfX61iZxAwEYqVI
 dHV8o6uRUEqjoK+X/Pzsz/Dz/J+FdBpDjs05rfFeThiykc9AmKUldeziiK620Ok07BeznfXZDQE
 ZflpAdTKlkAtgxccVpvxXYs1WAejRjA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609040218

T24gRnJpLCBTZXAgMDQsIDIwMjYsIENvbGUgTXVueiB3cm90ZToNCj4gRGVxdWV1aW5nIGEgcmVx
dWVzdCB0aGF0IGhhcyBhbHJlYWR5IGJlZW4gZ2l2ZW4gYmFjayBsb2dzIGFuIGVycm9yIGFuZA0K
PiByZXR1cm5zIC1FSU5WQUw6DQo+IA0KPiAgIGR3YzMgMjMwMDAwMDAudXNiOiByZXF1ZXN0IDAw
MDAwMDAwYWQ5MmYxYzQgd2FzIG5vdCBxdWV1ZWQgdG8gZXAwb3V0DQo+IA0KPiBmX2ZzIGhpdHMg
dGhpcyBvbiBldmVyeSB0ZWFyZG93bi4gZnVuY3Rpb25mc191bmJpbmQoKSBkZXF1ZXVlcyBlcDBy
ZXENCj4gdW5jb25kaXRpb25hbGx5IGJlZm9yZSBmcmVlaW5nIGl0LCB3aGljaA0KPiBjb21taXQg
Y2U0MDVkNTYxYjAyICgidXNiOiBnYWRnZXQ6IGZfZnM6IEVuc3VyZSBlcDByZXEgaXMgZGVxdWV1
ZWQNCj4gYmVmb3JlIGZyZWVfcmVxdWVzdCIpIG1hZGUgZGVsaWJlcmF0ZSB0byBjbG9zZSBhIHVz
ZS1hZnRlci1mcmVlLiBCeSB0aGVuDQo+IHRoZSBjb250cm9sIHRyYW5zZmVyIGhhcyBsb25nIGNv
bXBsZXRlZCwgc28gZHdjM19nYWRnZXRfZXBfZGVxdWV1ZSgpDQo+IGZpbmRzIHRoZSByZXF1ZXN0
IG9uIG5vbmUgb2YgY2FuY2VsbGVkX2xpc3QsIHBlbmRpbmdfbGlzdCBvcg0KPiBzdGFydGVkX2xp
c3QgYW5kIGZhbGxzIHRocm91Z2ggdG8gdGhlIGVycm9yIHBhdGguDQo+IA0KPiBOb3RoaW5nIGlz
IGFjdHVhbGx5IHdyb25nLiBUaGUgcmVxdWVzdCBpcyBub3QgcXVldWVkLCB3aGljaCBpcyB3aGF0
IHRoZQ0KPiBjYWxsZXIgYXNrZWQgZm9yLCBhbmQgYm90aCBjYWxsZXJzIGlnbm9yZSB0aGUgcmV0
dXJuIHZhbHVlIGFuZCBmcmVlIHRoZQ0KPiByZXF1ZXN0IHN0cmFpZ2h0IGFmdGVyLiBUaGUgb25s
eSBlZmZlY3QgaXMgYW4gZXJyb3IgbGluZSBpbiBldmVyeSBnYWRnZXQNCj4gdGVhcmRvd24sIHdo
aWNoIGJ1cmllcyByZWFsIFVTQiBlcnJvcnMuDQo+IA0KPiBkd2MzIGFscmVhZHkgdHJhY2tzIGVu
b3VnaCB0byB0ZWxsIHRoZSB0d28gY2FzZXMgYXBhcnQuDQo+IGR3YzNfZ2FkZ2V0X2VwX2FsbG9j
X3JlcXVlc3QoKSBzZXRzIERXQzNfUkVRVUVTVF9TVEFUVVNfVU5LTk9XTiwgYm90aA0KPiBfX2R3
YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkgYW5kIF9fZHdjM19nYWRnZXRfZXAwX3F1ZXVlKCkgc2V0DQo+
IERXQzNfUkVRVUVTVF9TVEFUVVNfUVVFVUVELCBhbmQgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKSBz
ZXRzDQo+IERXQzNfUkVRVUVTVF9TVEFUVVNfQ09NUExFVEVELiBBIHJlcXVlc3QgdGhhdCByZWFj
aGVzIHRoZSBlbmQgb2YgZGVxdWV1ZQ0KPiB3aXRoIHN0YXR1cyBDT01QTEVURUQgd2FzIHF1ZXVl
ZCB0byB0aGlzIGVuZHBvaW50IGFuZCBoYXMgZmluaXNoZWQuDQo+IEFueXRoaW5nIGVsc2Ugd2Fz
IG5ldmVyIHF1ZXVlZCBoZXJlLCBvciB0aGUgZHJpdmVyIGxvc3QgdHJhY2sgb2YgaXQuDQo+IEtl
ZXAgdGhlIGVycm9yIGZvciB0aG9zZSwgYW5kIHJldHVybiBzdWNjZXNzIGZvciBhIGNvbXBsZXRl
ZCByZXF1ZXN0Lg0KPiANCj4gQSBjb21wbGV0ZWQgcmVxdWVzdCBzdGlsbCBoYXMgdG8gYmUgZGVx
dWV1ZWQgb24gdGhlIGVuZHBvaW50IGl0IGJlbG9uZ3MNCj4gdG8uIHJlcS0+ZGVwIGlzIHNldCBv
bmNlIGF0IGFsbG9jYXRpb24gYW5kIG5ldmVyIGNoYW5nZXMsIGFuZA0KPiBfX2R3YzNfZ2FkZ2V0
X2VwX3F1ZXVlKCkgcmVqZWN0cyB0aGUgc2FtZSBtaXNtYXRjaCB3aXRoIGEgV0FSTiwgc28gYQ0K
PiB3cm9uZy1lbmRwb2ludCBkZXF1ZXVlIHN0YXlzIG9uIHRoZSBlcnJvciBwYXRoIGhlcmUgYXMg
d2VsbC4NCj4gDQo+IFRoaXMgaXMgbmFycm93ZXIgdGhhbiB0aGUgY2Ruc3AgZml4IGZvciB0aGUg
c2FtZSBjYWxsZXIsDQo+IGNvbW1pdCAzNGYwOGViMGJhNmUgKCJ1c2I6IGNkbnNwOiBGaXhlcyBp
c3N1ZSB3aXRoIGRlcXVldWluZyBub3QgcXVldWVkDQo+IHJlcXVlc3RzIiksIHdoaWNoIHJldHVy
bnMgMCB3aGVuZXZlciB1c2JfcmVxdWVzdDo6c3RhdHVzIGlzIG5vdA0KPiAtRUlOUFJPR1JFU1Mu
IFRoYXQgYWxzbyBzd2FsbG93cyBhIHJlcXVlc3QgdGhhdCB3YXMgbmV2ZXIgcXVldWVkLCBzaW5j
ZQ0KPiBzdGF0dXMgaXMgemVybyBvdXQgb2YgYWxsb2NhdGlvbi4gR29pbmcgYnkgZHdjMydzIG93
biByZXF1ZXN0IHN0YXR1cw0KPiBrZWVwcyB0aGF0IGNhc2UgYW4gZXJyb3IsIHdoaWNoIGlzIHdo
YXQgd2FzIGFza2VkIGZvciB3aGVuIGEgc2VwYXJhdGUNCj4gZXAwIGRlcXVldWUgd2FzIHByb3Bv
c2VkIGluIDIwMjIuDQo+IA0KPiBGaXhlczogNzIyNDZkYTQwZjM3ICgidXNiOiBJbnRyb2R1Y2Ug
RGVzaWduV2FyZSBVU0IzIERSRCBEcml2ZXIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtdXNiLzIwMjIxMTE3MDU0OTE3LjMwMTA0LTEtcXVpY191Z29zd2FtaUBxdWlj
aW5jLmNvbS9fXzshIUE0RjJSOUdfcGchZXhCU2ZieE12bjAyNTZKbk05WUdaSFJ1REhQZmdmMVg0
Z3JrZGFERGZZR3FmYldUYzlvQlpzbHY0S3ZOcGpBX3dtV005UjlyWHNoNTA4V1gxWWFCb0pzJCAN
Cj4gQXNzaXN0ZWQtYnk6IExMTSBzcGFyc2UNCj4gU2lnbmVkLW9mZi1ieTogQ29sZSBNdW56IDxN
dW56enl5MUBwcm90b24ubWU+DQo+IC0tLQ0KPiB2MzogY3V0IHRoZSBibG9jayBjb21tZW50IGRv
d24gdG8gb25lIGxpbmUuDQo+IHYyOiBhZGQgRml4ZXM6LCBDYzogc3RhYmxlIGFuZCBBc3Npc3Rl
ZC1ieSB0YWdzLg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA5ICsrKysrKy0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBmYTk0NDg1NmY5NTYuLjlmZjZhNzMzZDNjNSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+IEBAIC0yMTgxLDkgKzIxODEsMTIgQEAgc3RhdGljIGludCBkd2MzX2dh
ZGdldF9lcF9kZXF1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLA0KPiAgCQl9DQo+ICAJfQ0KPiAgDQo+
IC0JZGV2X2Vycihkd2MtPmRldiwgInJlcXVlc3QgJXAgd2FzIG5vdCBxdWV1ZWQgdG8gJXNcbiIs
DQo+IC0JCXJlcXVlc3QsIGVwLT5uYW1lKTsNCj4gLQlyZXQgPSAtRUlOVkFMOw0KPiArCS8qIERl
cXVldWluZyBhIGNvbXBsZXRlZCByZXF1ZXN0IGlzIGEgbm8tb3AsIG5vdCBhbiBlcnJvci4gKi8N
Cj4gKwlpZiAocmVxLT5zdGF0dXMgIT0gRFdDM19SRVFVRVNUX1NUQVRVU19DT01QTEVURUQgfHwg
cmVxLT5kZXAgIT0gZGVwKSB7DQo+ICsJCWRldl9lcnIoZHdjLT5kZXYsICJyZXF1ZXN0ICVwIHdh
cyBub3QgcXVldWVkIHRvICVzXG4iLA0KPiArCQkJcmVxdWVzdCwgZXAtPm5hbWUpOw0KPiArCQly
ZXQgPSAtRUlOVkFMOw0KPiArCX0NCj4gIG91dDoNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIA0KPiAtLSANCj4gMi41NS4wDQo+IA0KPiANCg0KTkFL
Lg0KDQpUaGlzIGlzIG5vdCBhIGZpeC4gVGhpcyBjaGFuZ2VzIHRoZSBkZXF1ZXVlKCkgYmVoYXZp
b3IuIFlvdSdyZSBicmVha2luZw0KdGhlIGRvY3VtZW50ZWQgYmVoYXZpb3Igb2YgdXNiX2VwX2Rl
cXVldWUoKToNCg0KCUlmIHRoZSByZXF1ZXN0IGlzIHN0aWxsIGFjdGl2ZSBvbiB0aGUgZW5kcG9p
bnQsIGl0IGlzIGRlcXVldWVkIGFuZA0KCWV2ZW50dWFsbHkgaXRzIGNvbXBsZXRpb24gcm91dGlu
ZSBpcyBjYWxsZWQgKHdpdGggc3RhdHVzIC1FQ09OTlJFU0VUKTsNCgllbHNlIGEgbmVnYXRpdmUg
ZXJyb3IgY29kZSBpcyByZXR1cm5lZC4gIFRoaXMgcm91dGluZSBpcyBhc3luY2hyb25vdXMsDQoJ
dGhhdCBpcywgaXQgbWF5IHJldHVybiBiZWZvcmUgdGhlIGNvbXBsZXRpb24gcm91dGluZSBydW5z
Lg0KDQpCUiwNClRoaW5o
