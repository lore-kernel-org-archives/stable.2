Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A1328631;
	Sat, 30 May 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154848; cv=fail; b=PgfrxM6fYrwDLZN5RZN8gWKPtDYj9rDMhEDMGdOQqN+GBNYt36/HRGjbyks1707/6E+qu6Z3bFe/04CnZtO59o113dYHurV4LPPs9BwZkOxM/4CcGVuu+cQNDF9JzE6FNwiQE6PxQu7aGYRFhi7hxotwFRRkpQUlwpEbnrzfBuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154848; c=relaxed/simple;
	bh=jaInLz5fX1493qEcVkh9JLxHwNbY6ZaVIqkamwZMfqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FmqMTLjGXmVsfytM65Ic93hb6xE+i9e/Kq+JcGRsW847X5r3IzzOjE/IA53/zh+mwr393DYuHGzlf0x9nzS5XfbyfoYs81d6pXitI4PyYlBbbCMG5/1fourEFVVQY/IT+Q/BuBMuN1b1T3yvZpHdrAyrl7/MyYBXkfd1zCVtTC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=QThQcngO; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="QThQcngO"
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64U6F95s2151677;
	Sat, 30 May 2026 10:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=j
	aInLz5fX1493qEcVkh9JLxHwNbY6ZaVIqkamwZMfqs=; b=QThQcngOLujYeDD6t
	hmLzesRodpXpoFrB2oWNlAIPFWLMD18BnKxIUVWGhMWt/+hXrRI9o0QMaJbt7r2m
	wXwzweB1NKdaSw8wdjVwWCMKdGOGeTJK7Dq9kANVj86V8mjq//xtb/ZHevLQK2ad
	L6WkMYuHDB1i7lJBkxGZ9qJqFaL1lLGeLw3k1EWZpIi4CmTIwUBR/F9mzsCF4viC
	y8Z25BdMbbewGOP5T6hbBv4LdzSGc38HvUnZkU3kDSOklAbWSqGQC3u8gR0+d0MA
	waNAoOSAFTj6LL8lnW2HEMs8aLH7QAxz+Z242IxlHc5RgpfdoD35HVTuFRs0BTBu
	cIAbg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4eftf20tr0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 30 May 2026 10:34:42 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UBOdTK2008671;
	Sat, 30 May 2026 10:34:41 -0400
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4efv8djv4b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 30 May 2026 10:34:41 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3++P/YozfWUvTiT7ybX6VK91DYZw1sc+rxFHnkLfa9SYkqhqiylR/nVMsgZEKHMjB1pgECoyyjNT0iN6n6fOaFsWtjSBQpMdShox/sxNll9iLg3riSvQbxsC+H/vDcwdrxpTi5sTX2dAUCoQcWauHXrMvLix8+k84h9MIJBftwj9jgMQ9bM0Frzdqx1LtTYs+TQSand+ouGsuwv5wOCzw1MdjPjoMIdl/nAORlvFMbl4NvytHgINI5VaBgRBuH/hUGePhoPFjkWYeuxnciX/EPQOOSGB+3ZVde3P9dVOQ/WNYjNePa0fKVpcIyz2aeEAc3rbaXQO/Pvl4doAGkLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaInLz5fX1493qEcVkh9JLxHwNbY6ZaVIqkamwZMfqs=;
 b=PBSdmK5PGhHS83d1cAA6UdapjkLXQ5Pq8sWlmSaAiGox0swjjKN0U4VXFYdao4TQNBb1NhVan2hzucFsmQAd9WIwOmkWjscsUCbTwx2LsQ0UfTgWhVo0R02XzFBg2zwvfUh1slr07kI+l0LTGYV0z09VvZX68lbyJJoiS0qP9zBpw8hE065hQ1J+0xe9bVLE7C3e7KK5lujemxN7NBHN3LVMF50UUR9FNNeWcVzRXryD213Gn4ehMvgyUHn2D+NQLOKhSfW/2ICGFuTqw42t4d5xG7QCQRNmIdKxTlYJwg7DS3pbGQW3y+qaaRObebw1O2retwBt/h75Z//QfjjBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS0PR19MB7696.namprd19.prod.outlook.com (2603:10b6:8:f8::5) by
 SA1PR19MB8972.namprd19.prod.outlook.com (2603:10b6:806:45b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Sat, 30 May 2026 14:34:38 +0000
Received: from DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9]) by DS0PR19MB7696.namprd19.prod.outlook.com
 ([fe80::9d6:bb81:6340:84a9%4]) with mapi id 15.21.0071.015; Sat, 30 May 2026
 14:34:37 +0000
From: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
To: Hannes Reinecke <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Topic: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Index: AQHc7rYSFc/wmEX1xUeXcN5PEFcVh7YkkAGAgAISlvA=
Date: Sat, 30 May 2026 14:34:36 +0000
Message-ID:
 <DS0PR19MB7696FD43E37F19A597121212FD172@DS0PR19MB7696.namprd19.prod.outlook.com>
References:
 <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
 <b8d1fda2-a2da-4b35-9bd5-941834f26c32@suse.de>
In-Reply-To: <b8d1fda2-a2da-4b35-9bd5-941834f26c32@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-30T14:24:21.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7696:EE_|SA1PR19MB8972:EE_
x-ms-office365-filtering-correlation-id: c9659baf-8b98-4f28-68e5-08debe58933a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|786006|376014|38070700021|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info:
 cmIveXRclod4gQYe5mV9fDAne8oMrIxy6FuqtVJXJ1m7NTzl8Qn6ej9rP36vWvTdCH9zZiLMfCNzxEVR7AI3sI9QLN2PAGxOkxq3N6t5ws0mxR0ztQHeXYYagEGWSgJwO6ECsC3IJARaLd/BRBfYIg2dXcfd+ndCJxNS7DsWP02nlyw7lnMetpD+dYiUmMBgZ4hwiqSSPvFP0yOeFAFRrPcpcTJCQFPD4k+JtceeCvLb3/vF5ORZbrzm8q39iVJQtbpj700xA85p97qiN/rGqNpRjC5c9pbyQhOSNoGLqpt4EKtVI1pmdYo5wKjJdcy2i1oU167KUZnCPXVvmljePO8QknYqK+TTVCXqSyD1Jnn0t+jjhwrk7N6g6tfmCua+0tFQ1ZpykiJn+HAX6XRJXQDwJ1tL6PPRZkXmNVRSm8WZ++4FAwf+RgruArEFt0FmOWp3Z/ieblEBldmQIRDZiq0G7i+kSu0Kw//40ikKY11Zb3rmPp/fw4zOLcabJNzbDKWONvxbgNuV+uY8J92eYnHFQe6vurG2/m1ngp+GrQ0FExg7LzjpgivinyTkSuplR31913EqqNMNjhoxNt09vT/HXs3up2laWzD72XUO4iT/A9aaVak+qLX5deWpRbrjgZT7O2JOYESA16DwhxjdDOKPQdkwDtvkxyrS6P5l9n0A3Aw27+58tSl2M+86Jnflhbr/nxa0E1YeOdPau17zNs2Ej6KDXoDfqP4uGgr6ZA51u+3vwTj31yAvLkEaigAB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7696.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MElPb3dpNjBRelBaOXJ2MUJEbGxCTlF0cWFWeWdkaE1iYTJXYlZXdnh3cVhF?=
 =?utf-8?B?dFJtNHdRWE5IbmlFZkg3WnpVSTRzRUNOWWpzc3NrRFhjRjgxbHFodVB0V3Ra?=
 =?utf-8?B?MHlVQjRUaUNGZ2djaWtHTERhQUorMXBLY3dMSWFGaFlScmxSTUlNUkhkeU1o?=
 =?utf-8?B?NXNxblNPbXVJNFA3YVg4UVQxbzZUTG1SaE5LSVpyZ01lNU5ZYnp0dHN3R1d0?=
 =?utf-8?B?TUVLODNQWTdVbFdhMWkrWTRYWHJ3UFJlbG5PKy90VUhIQmVVSlcvKyt1R0Vn?=
 =?utf-8?B?Sk5VSGo4b0MwV1JpZ1hvRzlrb0w3cDduVzRnczY2ejJYMHJEUS9XajlIZEFD?=
 =?utf-8?B?SlZaTG9HYjVKbGpBQXNtR2JJV1BPWithaVo5UnFLN05KT3U1dnl4UTVPYS9j?=
 =?utf-8?B?VXVXWnY1UXlFdDFCelZYR1ZIRnJJdXo2TmYwb2tjclVXQVdyVDRvald6bnFr?=
 =?utf-8?B?dkNFWG0yQ20xNGZFT1E2RWllZStwenA0bnBJYTdySnRWaXVWMElHNXRJajVz?=
 =?utf-8?B?RHo4SGc4aEE5MXFEN3Y0bXpCV1JxdUFUYzcxaUNXMVFqUFRoYUpqR3dKTVdI?=
 =?utf-8?B?Mlh5L3lJdmQ2aDRDODNPWEh4MGtHQTl3Wk14WDJBRm1mRWFNU0tZVkZHZXZs?=
 =?utf-8?B?RFA5L09XWFY4eGR3RHkxbzVrVVh6YWxHWWp2UW9qN0FmUkM2Nm8vaVZidklT?=
 =?utf-8?B?V1UzNzRPN0h1WmFCUENENVFFaWVNR2xNNUhEUEV0ZFJhK2JOTld4V2wvenRq?=
 =?utf-8?B?ZXlNRlJYdURiOHhxZUxSV0hOL3FTb3JPS1Vsck1KOEJkOElkQndYZVdNU21H?=
 =?utf-8?B?cXArclFzSE9UVjFIcG13L3NKN0s0V1lhQnhreG1HSndOSWhrWldPV2ltQ09L?=
 =?utf-8?B?emM2d3JqVE85d3VYSnFXekE1SHZlbVVTTytGNE4rUzFjNFYzVkkyWnJNTEhW?=
 =?utf-8?B?dE9sVXM0UGh0aXh0YytWb1lqY05vdUw2WHlJN24zeE9IMmdaSXVWZTBnd2Rs?=
 =?utf-8?B?SEZDSUNCZldiVmE3M0FxYjNBVGEydWEyUnc4Y0dQVi9OMnpZQkZld3UxREcr?=
 =?utf-8?B?aTFMd0wxajdaaEptbWdKVUxXRHdHQ1ZSbjZJNXFWMmxjNlk1a3g2amJJaVB6?=
 =?utf-8?B?cG1kTzhYSlZ5cXVaeDJYOWxzaWRnaW53YWh0SGpPRmNIR3U3QmYrNHVLUGJU?=
 =?utf-8?B?RkVwQUhnbmRvOUpUb05TaTZmVkpQV1kwelcveE5Ib1Vzb3JLOHFBMVI5YTRP?=
 =?utf-8?B?eG5Lck4vVGVrN0wxS1FLbXRaenhGRTdkMDJhVHlqN3p4cVdWQy9Db1hTdVJ3?=
 =?utf-8?B?VFNwZkN5bDh5dnAvQ0p5aTlIZGJJOUFvVEczRHVlb2RmM3h1NFp3RVZpUVZM?=
 =?utf-8?B?a0pOK3JGQVdJTEIvekMwTnFEc2xWelJpZEEzZmxWK214MG83NDhmSEJYTkRo?=
 =?utf-8?B?bWl1bGlBbGpDNktzaFVIRDZWNWl3d08wY2FxMkNPNFJ2MkdjODFEaElMeTRr?=
 =?utf-8?B?QW5DZGxQWTl3TXRJZGFrQnA3VkdDdW83NVQ3K1VvcW9XNVJFVmZKZ0VUajBt?=
 =?utf-8?B?UktiNUFCZFZkSndYampEMUptSCtYdmhDRWhMQms3Mmd0V2xUVzc2ZUhnWlVR?=
 =?utf-8?B?SUEzclhLNDdvdkE5YWJib0p6aExESWQ0clpzVThnSlEvai8yRzJ3UjFsbUp5?=
 =?utf-8?B?WDhTL2FTQXBSK0JhajVoaUU3Yk42bkhsbi85T1R3Nm5vcU1GcjR2aU9LMDJZ?=
 =?utf-8?B?aTkvSlMxUDF3d2lOOWNqMjBmV2FtNmFmZ2RtbmJHT0dBdXdHT095VTVQY01G?=
 =?utf-8?B?N3ZwUXU1SUlXSElOK0hxV2V1YjFVa2twOGlJQ3FmRUZyVGJnaGlmRU5nTUcx?=
 =?utf-8?B?WXpHa3gzZnhkQ1E5Z01wdDNPR3Y1bklwS1ZVdFVKdDFnMGNqUUVRdGhNV1di?=
 =?utf-8?B?b04xOCttaVBWWmM3RnkzYVNib2JjTXBzdEJVNWtNQWZmdDVvSXgvMGtlYWx3?=
 =?utf-8?B?bzNXcGd3dUJabDNEb215RzJDTDRTQURIbWMwT2QxSkJVZ2NYOXVqS0p3bDc2?=
 =?utf-8?B?U3dnOURiSGltVGYxTmZJeVk5NGQ5NytHWTUzbjFVR3hvWmllOFRxckxEKzky?=
 =?utf-8?B?ZFUrSTNQRkVDUjJnQVhrWlNUUEUzQjFsQk9yQWlQTXpvZ0UxL292dUF4L0do?=
 =?utf-8?B?dFNPa3dUY0ozRWFRL0NjWFFpcFhneVo5S2JiRWhXdStpRDh1NWVwaThhTURz?=
 =?utf-8?B?UEVTaXNkOE5kdGswVURtVlJrZGtsY05xK0FuaElrRkpxWENhbENXRkdjWmVw?=
 =?utf-8?B?MDZvOTJBQVZwQ0VnN25aY0h3T1FTay9vUXJSbVJhZ2N1QkorWnFEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Inl1n/HY1dgju/UDqPgkzwv/HkCt60jEAcG/lPYJphTSZVKk2NpJdGs0C/kPWXtppKbgrCBvRMX6zGuxMi372k9EjhTUzjh9+emzzQztKAxQU6fNR6lAJ/FVu7EWmcypxReCnepdyb2+YlJaOzleNBnH1ATzL7F96yn0XLE02TPWPq4cW5efe7rkMob4JuXvIAL8QYHP26gcy3tBZQRQbzTNx2DZfRx4CU/d8S02ROT1B072nQLspNM10nRHS1/oI/mCt6hk5+92/DW5ONrf9XtbR2rK0++TLIt2KolQE0R6gU0b+zFgNi6l4xsvc+6ch0ewLjLI1QaidqAME0YezA==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7696.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9659baf-8b98-4f28-68e5-08debe58933a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2026 14:34:36.9109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aujWylkdOL7Vn/ntmJgEOVb0xstPM+rsFSPjxAP/oe+aJXaAzt3RWibHiQkrzOhBhOkDLjuXJnehdPwBTLKxCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605300157
X-Authority-Analysis: v=2.4 cv=bqN8wkai c=1 sm=1 tr=0 ts=6a1af582 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=gLxAKuEMs0EQMVFiDJnH:22 a=la_CUVkIMUBp44nP8LkA:9 a=QEXdDO2ut3YA:10
 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: fXcIydSMUj3u9W7HQEvYZ2nAGcG_cegM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE1NyBTYWx0ZWRfX6Qf70qflPmV5
 ckJCUyzHQ2eY7WNaF9apPHqzFQf/p5cbjApf++GIuH20C+8h1MbxZxnoPF+Pw3RO8NAHJBiyR47
 lQDy7Mohba+JkuVrwDk2DQNEbHCXxPpR0i2wwv7r15DsVNA9ibrJKhHYG5ulA2zMIYY+SG6VogF
 IR3yfKHlI/pjazd6OMK5011lwgw65R1AnJoZrkhY0nFUMPnwObSzSbCqIIS0RwtEl38o/tLo5I3
 ezEkcVuzICBUBqqrc9T0f3VWt8Z2NK75SaLysX2cGaOQWVUi/QXCpaGdaWVGLHf7IV0nFJWCofv
 iODMtcvmupCXh3sUTpjMVtghxR+5ppyEm4IgdEESBA20we16Hp0lZWxEtcH87EpaVXGwGfoe4i0
 +Opm7oq2LiHCkRlhMea3cas828ziAsoRIoQQkPlntHYMcukPmYMquGMdwzqNdfNLlwRhDbWwU/Y
 uSxquPNpZzs1nfgRtYg==
X-Proofpoint-GUID: fXcIydSMUj3u9W7HQEvYZ2nAGcG_cegM
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300157

SGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiAuLi4gb3IgeW91IGNvdWxkIGludHJvZHVjZSBfX2Jp
b19zZXRfZGV2KCk6DQo+DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jpby5oIGIvaW5j
bHVkZS9saW51eC9iaW8uaA0KPiBpbmRleCA5N2Q3NDczMjBiMzUuLjVhMjcwOWFkZWVhNyAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9iaW8uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2Jp
by5oDQo+IEBAIC01MTgsMTUgKzUxOCwyMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYmxrY2dfcHVu
dF9iaW9fc3VibWl0KHN0cnVjdA0KPiBiaW8gKmJpbykNCj4gICB9DQo+ICAgI2VuZGlmIC8qIENP
TkZJR19CTEtfQ0dST1VQICovDQo+DQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgYmlvX3NldF9kZXYo
c3RydWN0IGJpbyAqYmlvLCBzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2KQ0KPiArc3RhdGljIGlu
bGluZSB2b2lkIF9fYmlvX3NldF9kZXYoc3RydWN0IGJpbyAqYmlvLCBzdHJ1Y3QgYmxvY2tfZGV2
aWNlDQo+ICpiZGV2KQ0KPiAgIHsNCj4gLSAgICAgICBiaW9fY2xlYXJfZmxhZyhiaW8sIEJJT19S
RU1BUFBFRCk7DQo+ICAgICAgICAgIGlmIChiaW8tPmJpX2JkZXYgIT0gYmRldikNCj4gICAgICAg
ICAgICAgICAgICBiaW9fY2xlYXJfZmxhZyhiaW8sIEJJT19CUFNfVEhST1RUTEVEKTsNCj4gICAg
ICAgICAgYmlvLT5iaV9iZGV2ID0gYmRldjsNCj4gICAgICAgICAgYmlvX2Fzc29jaWF0ZV9ibGtn
KGJpbyk7DQo+ICAgfQ0KPg0KPiArc3RhdGljIGlubGluZSB2b2lkIGJpb19zZXRfZGV2KHN0cnVj
dCBiaW8gKmJpbywgc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikNCj4gK3sNCj4gKyAgICAgICBi
aW9fY2xlYXJfZmxhZyhiaW8sIEJJT19SRU1BUFBFRCk7DQo+ICsgICAgICAgX19iaW9fc2V0X2Rl
dihiaW8sIGJkZXYpOw0KPiArfQ0KPiArDQo+ICAgLyoNCj4gICAgKiBCSU8gbGlzdCBtYW5hZ2Vt
ZW50IGZvciB1c2UgYnkgcmVtYXBwaW5nIGRyaXZlcnMgKGUuZy4gRE0gb3IgTUQpDQo+IGFuZCBs
b29wLg0KPiAgICAqDQo+DQo+IHRvIGF2b2lkIGFsbCB0aGlzIGNsZWFyLWFuZC1zZXQtZmxhZyBk
YW5jZS4NCg0KDQpUaGFua3MgSGFubmVzLiBJdCBpcyBhIGNsZWFuZXIgYXBwcm9hY2ggYW5kIGF2
b2lkcyB0aGUgY2xlYXItYW5kLXNldA0KZGFuY2UuIEhvd2V2ZXIgaXQgdG91Y2hlcyB0aGUgYmxv
Y2sgbGF5ZXIgKGJpby5oKSBhbmQgd291bGQgbmVlZA0Kd2lkZXIgcmV2aWV3IGFuZCB0ZXN0aW5n
IGFjcm9zcyBhbGwgYmlvX3NldF9kZXYgY2FsbGVycy4NCg0KSSdkIHByZWZlciB0byBrZWVwIHRo
aXMgcGF0Y2ggYXMgYSBtaW5pbWFsLCBudm1lIG11bHRpcGF0aCBmaXggdGhhdA0KSXMgZWFzeSB0
byBiYWNrcG9ydCB0byBzdGFibGUga2VybmVscyB3aGVyZSB0aGlzIHJhY2UgaXMgaGl0dGluZyB1
cw0KdG9kYXkuIFRoZSBfX2Jpb19zZXRfZGV2KCkgYXBwcm9hY2ggKG9yIEtlaXRoJ3MgcGF0Y2gg
dGhhdCBpcw0KcmVtb3Zpbmcgc2V0X2NhcGFjaXR5KDApIGVudGlyZWx5KSBjb3VsZCBmb2xsb3cg
YXMgdGhlIHByb3Blcg0KbG9uZy10ZXJtIHNvbHV0aW9uLg0KDQpUaGFua3MsIElnb3INCg0KDQpJ
bnRlcm5hbCBVc2UgLSBDb25maWRlbnRpYWwNCg==
