Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911D36196E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516165; cv=fail; b=L6ZZ/jHe3pq+grHm1lf0aHVZyLjjkLcdR2ocoB+408R2bCqnGdKNUVD34hPh+vN7Z/020JKx7hKOsYqhrmg9FQko3SlvHI33r/9PxG9obouYp8exSf4kkXWdvet9M/KMPu0VvwTo71FQc3Uxsdl7Yyr4YjrfZKI42Gv4KMed3y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516165; c=relaxed/simple;
	bh=nXSGMvKDDADjsX0xonqE2YrAnF3KHQEE6lWGoHdt8UQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=US/AJbY7P7XCzh/AlcOnwSIklmk6auVmq+c6FSO0Fq32WsJjqn8FyILNQVGxqzyjhvDXUqFDKebuJLkFHp7g3xTH9QR7VzV0jwV3NecADoEDpmBWrwAQxPmzDPlX+wkL5w1zNxofghcuKP17kzmK7Sgxuy8hejLaJ/00tqFyqrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XUw3g1RT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WFv/asEI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XUw3g1RT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WFv/asEI"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C10X7V3602618;
	Wed, 12 Aug 2026 03:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hycEw+UbzRRtXJJwEeCUgSy0FnvI8XZw1W9+VPee1w0=; b=
	XUw3g1RTgty1pIu0LTGofz8HRclbgugW29rTrJOgOLe4w/PEfDKkhUYPWewxlole
	aobDBtrRkE4TuM4mt6qYuGIUCJpeaCQJ46SGUDGaH8AqBeq2dNrkQh5BQKVfQJ/6
	1oDjBcDYV07z3fXnfxnphamIjNJn85Uir3Xl3uIEYBbkGj9ubpv1snNKaxew1E1J
	veI/y28ch3s92LGXMuo340XiG85yResnVsV6B2Ux3EzOByOJ1OICbPOtFy+xnGjL
	s+Xn7M9Y/cnISHZ/SjKP+/9O8w0BAJpI1t/S4t7AwWJNhG3obp5gesUWpNBMzDli
	sRr2A5T9j3o0p/SDg3vk2g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fww0sx189-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 03:07:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67C35WVZ005039;
	Wed, 12 Aug 2026 03:07:16 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtws8kug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Aug 2026 03:07:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZjI44XyERDqHCATUdVvmrd68VVy+k7J8spxPHfobhCudz2hSs+TgrSjZ6UFUp1juxbgIxy16IfSbheROnfuyg8sLqv4RcI4Q6rz5qxJFOWL4206aUi35tb+cfc7nyF4qfQIolxwGvWou5LMG7rIKII4g2p8JVto2mjmsebs5DF2ziuHAiHIlMIl7Z8BVSrDgZAFne54MDRb5EToHsEBOWsDmHtbEZ1foj6viSpT1tohjGavD2BPDCA2savEFeZBqAvlFRpVYSLM0c7X/gu520m19f39YykSVZQ82YGA3MFoKxwNKUtMbxswjFsNd1Xf8Wi6loWtGjxOIdnKiMLd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hycEw+UbzRRtXJJwEeCUgSy0FnvI8XZw1W9+VPee1w0=;
 b=d9WYL4eA9HHat6qmlTzkFCTZywwNDNVzOOdMoEx9Ug4x2u4w+I2x7LCBXsGcgMy4mIM/yKXrXhFANdDOB48lOH9N0jxmEzcKvE7nRYrIMUP5aOgAGJlAkYXikCAsuXAyyB21PwdasyxcPabOTLd8v8By0W+dhO2zWsXjIHqXHoFzkfK6ZFTKZJtAXBfZVxiz/cejNdOBXddq8bG6bdpMs54gCVKbnMlvoEEgAdHoMbHhEt6dkbNL0KsLRQOXGGVm0+tr/2c4gPEPU+1DqVG7gX7fGr8qjipdrarI62g7L8d0BuWzt7nX04C6kxNkOMA57eyjMWfE70v3pq6JK/D/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hycEw+UbzRRtXJJwEeCUgSy0FnvI8XZw1W9+VPee1w0=;
 b=WFv/asEIie4PREIgS1icRY8TbK0X3V8Q1oWGvbdsVEd+T7XXL94vNgdVCnlwFUR0aNrdmc3n5P7ycmYBn4sB4L6Y3sZdt/cIMhsLO+pOGrPRnvc4OP9nSmefNEc9CKBL5X0CFXyJmO7qEKN4d4vRdvDaR86ivZvfdP9vJoKqzmE=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by LV3PR10MB7746.namprd10.prod.outlook.com (2603:10b6:408:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 03:07:13 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 03:07:13 +0000
Message-ID: <7b89b098-61cc-4788-b7b6-69bd232f770d@oracle.com>
Date: Wed, 12 Aug 2026 08:37:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Question: Why don't I see FAILED patch notifications for commit:
 622ebfac01ba4f9c0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        vegard.nossum@oracle.com
References: <5b4ec416-804a-4bd6-aa12-5c317741977c@oracle.com>
 <2026081210-lugged-bleep-94ba@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2026081210-lugged-bleep-94ba@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::17) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|LV3PR10MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d32a90a-a768-498f-dd28-08def81ece8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	et102INNegFfXRqkB6rIkIKA5cBJzdjsY2rbB6rHNLgMWKdsLOEh6rovHQTTA6oYGkNrHW5LXJmz3zz71hPjrRyXZ4ztLH3/VZ1cI0xtcIZPB0eEJJlS/PPCJyYRvxW/+t+7Ef6PMIaqDPp0R4hkHisdQyMRvegPm/ZDuOXe9654xcQ2Wjx41VPXtowpPT9oFSJlohHAKq3ekRUB5Fga3pQpSPXBbeBaEDJeH76brdCMKQpTMPYIbfA5ORkRloqEAcfcdr1Ald7UjEIEwwnYPfjTfiEZwCyPViimB+727EWF3mQ4ugnQJWN49l+314J+AD+AEE//PTprjANPnYf0XRJYJiZjBGGZqtrBIYQyqqInOWHP+2nDka1KHJAKjgwTRWxCWFyNqVUvYKfKj4ECpmd45mUD0dTrB34nXUq6p1VT7G40koZhWqAFjJlzUfODvnlmNb9p9ZmwZ+BO91Ir868Z6nIQV57U5c0yJFyQZ12XLxg6BuTkjxp9SZL1Drno10arIamio3Ja6TS23i87BigLqmmkLfrqejrQKnpvf9ibmOLR+BQKqMgDDAg7yTTIshLOIu34yOuWKH1LWpmkzBxr02MQEKWJCT+IhNeqW7Jf6PWF0UjymFlk3LF1XVKO717z4NWuuMEov7aWdxOemO5rP63vkPmkPa7MK9EQUXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qll5UHBRM2RuWHlKWlMvd1U4WUVsQThJSVR2RUNRUFg1bWxQM1c5QVpHekxj?=
 =?utf-8?B?NGpObDc1QzlVSklsUWZzMnVySUJyTDRYTW9JYXMyL1hyRFNOY1ROSEZpRHZX?=
 =?utf-8?B?TFlYbkM2MzFKYTJwT3JEd3hNZ0hNNzNCcFVVZ0QzOTNscllvM084UHZRK0s0?=
 =?utf-8?B?a0ZJdkNGNFZkZDh4NitpNlJ3MHdZcDNmL3BITmZmT1htRERyclFkMWYyQjZ3?=
 =?utf-8?B?dGxZdE9XcHMvanc3ZmVzdDVNdFlqWXVHQnRIMnRyNHhzVlEySVdDZnpnR0Jw?=
 =?utf-8?B?OGt0cDg1bmZjV1JaRmxmRXVlWFhpWitsTTJmWW9WK2E5dkdPcnd5dDFZZDFZ?=
 =?utf-8?B?dTB0ejgxZzMwQVZaMjZWdlkvSEhZV0k3UWo3aHJFRXpsUlRWemYzeWE5K0Ns?=
 =?utf-8?B?T2N5clRYa3RSc2VYTUZvMFExOTJQZWtPb055MmFVcUZTekJ6MUFocEpTS05D?=
 =?utf-8?B?cUF6T1NIRElrMEU2VHc3cTlzeS9QOU5ra0NxODFocG84a0dLZ1Ewa3dMd2Fq?=
 =?utf-8?B?VEkvZ3Rra3ZhUW1ITFJpU0lKMzJoeDlRK2plVkxoQ0JWbVdSUGVjY1VPaHRm?=
 =?utf-8?B?YXhwU0lTN2F6M05NN2JPTTl5ZE9RZmFwK3FLQVNYZGY1dzV1Q2lTWDVYNTVq?=
 =?utf-8?B?NHBtVHlJc0l1VXJ3UGNjVFNhc2w1WDBBN2F3UXRTYnlMak1vaHNTZWpKdnFh?=
 =?utf-8?B?dzJKU3RRaUp1ZDFlc3Jyem1EaEJOam1QZDlxL3Fyd1pXM2liQ21hWSszaG4v?=
 =?utf-8?B?Z2dWMGZBbWhhMEsyQlhSMVBucktVOW1CanZQMVVkSDNucmZYZ0luWWZuZVpk?=
 =?utf-8?B?a2FDL09oSWNmWUIzcWhBL1NWVEd2MzlucFM3M2s4QW84N3FXNm5RSkRoSVN0?=
 =?utf-8?B?c2NsK2NUdmhWcGswc0s4aDRDQ2txcUFDR3VSVUluTlcveFg0MlpSV3pCcTZM?=
 =?utf-8?B?bWl0MGRmWk5kVmhUZHBxTzNVNXNOZGhGRDZHR1ZlK1JwNWRDUVFvMVdDaFI4?=
 =?utf-8?B?SjRBdWZoYmhwTjlyRjlGY3kyOS90V25QSTF4VS9ITHplYzd4anFJaEhyRlR0?=
 =?utf-8?B?bFdpZjJJRXhKdXMyS1kvSmZrYjc0WFozZnNJYis4VUQ5S1RSd3BqbVFRTEZG?=
 =?utf-8?B?c3hBRlVmRmNOcyt5TlhHaDZ0SFlVR0lNU3JxSDlGVXdnRjBwWDh4MWNDMXNY?=
 =?utf-8?B?c09XSkJRRHBjQmpqZy9pa1czZERIZ0oyeG5TUWJLUjRLc0dHLzNmdi9lQWov?=
 =?utf-8?B?T3VPaVVSV05MMU1xMGFBeXpuZzVsdTM0cFhSdU9pMThvbW9KRTVoeTF5KzFo?=
 =?utf-8?B?NG1vZWdtTTJpdHM3RnluQ2cyakZoMzFxYmxzY200cHN2Q29hMnk3NDJOeEo4?=
 =?utf-8?B?SHhNWkE3K2tTUW5LdE1FZFRnUFZaSGVVZTEvUmVneDhNZU42TFZRWGx6azBS?=
 =?utf-8?B?OVNZU1NRZGMwby9yTU1UWk5tZ0IxZEw3OVNCaFFjQ0poc2hWT2dHQmRqWXdF?=
 =?utf-8?B?MVJvem1FSmtPQjBSUXJuVmc0YVN6T3NUcytsRFZvZnZhNGpqdGtaZkpNQjdz?=
 =?utf-8?B?U3l0UHFyMGxLR1RvTldSYk0rRldmaVVkYVAwaWJuWEhrVXlrWk05V0tqU1Y2?=
 =?utf-8?B?aS8rQ1FWbktxclhZQ3VaRGtNSnplU3hBdytTSmp2Ni9zY0d5NEFFenVkQWZQ?=
 =?utf-8?B?ZzJuSnpibVNxbVdyTWhEN2oyZk13Y0lFdG50NzJDbm4yTlBSWDBIR3lZRnQv?=
 =?utf-8?B?TlZOVUhSK0xMWlJtKzNiQ3NscUUvcWFubk9EblJmTWJENzE5TGtUL1RIOHpm?=
 =?utf-8?B?c1R1QWVQeVpZbWRXN0p1ZzhISVQrZmZuTVEwQkNGcitHU0VYdnl0UzkrbCtk?=
 =?utf-8?B?SXFhR1M2UVQxOGh3Z1FFc2hONmo2cEpRRXdqaDZtTXQrN2g5UHNNN3YvdGd4?=
 =?utf-8?B?Vlg1d1BqMXQ0R3JXbG9WSzJrYVlXdDRVMWY4WkdOa25naFFMd0x3elN3ZEdF?=
 =?utf-8?B?VWZpRE0wSUVlbEdCWW9WTVppaVJvYm8zdTR6USttZmVhZ3IxUDBhZFJpNjJE?=
 =?utf-8?B?THlvSC9ISkFLeUFvUlpEcHdPcG02c1RJUTV4YjdVbkNNK0NCSi9tZTZ1RUFR?=
 =?utf-8?B?a0IvUnFnVm1CRm1JcXlYYUZJdmYxYkdiMkJiajBIcDNLUEltSGxrSi9SNTI5?=
 =?utf-8?B?YkZTWWRqVGE1U0NsSzVRQ3diNnFvWG9UTGdPN0k1ZHB0ditid29xWEw4NENr?=
 =?utf-8?B?eWJJZUkrdUpFM2ViTlpjcGdpRnNJQVNvcnF1UEcxSjlWTDE3V1lML28xZklC?=
 =?utf-8?B?ekZUR3Q4R25zeHc4N2hFMjFkaDRYRUF4M2xZaFFCMFk1dnhtc0dxMXBuOSs2?=
 =?utf-8?Q?iUl1M7eR99DMri5YNf2usU9vxB9F1EgaWVAXQ?=
X-Exchange-RoutingPolicyChecked:
	lEhcKp/wkuvhgV4MPrF7uXaAaYxu1p9Q7id4B1JUpOJ1/3zNGS9kkPNp3dGGuCi4NlRSlQCTQ0Aj/d0uCINU9LVZ27K9NXUzs6Re7RjgcCkFhQjaV8IbBQmCJ8Jpp8VVEa37NnPDsWt/LnpduBwKSDypS0g+PZnodRusYYvzGuHcGflLrQKujNNtyhQBGTpJMlHQTwjzD5BY3DzdF9bZmhXQRbrzk7Zs+NCgB5c9D43graIL6Pi77QmrmDZ4TmV7v8r6r23YqE0/dEoovnojQbJSAoeEtx0xTvPknC+U6pwCHaGzgsMl6CXch1DhiVFwHyr2qZiEM/xLaeANGFE+3Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xfV/q877L/llu6+lMN4gRQAJRmE34WV9tasuM23hLg5KM2UberqYt5Efa+8XDmrWx3MCwJ2NWUuCA78ZsWE1SaJfLaJFnaka7k2EK6ObT1S6HEkHtNeN7Crm1JsJf4dbhwsBJkNfNd+2Q5PmzpuyTqKBrsP24WzWikhNNopkC0gfTUFU2hXGSGuQRgPeszHqDSKZIu91RyOxYya0+UhtMbeqP2xBId6duzYPWbgkkaPM3nRrgGN7eUp8jXXbDW1OOxBm+fxxDG5KZ2OdOL64yWyEVq/QSO+9m/eW+B37nhsLdoZHovND4wpDs4DKaA7ozjJb5Sy0v0ImSwK/gTzP8uMJLvRRjakPtPX6Liu8FFkk17fOYiKMBAMjPWGelSvFmrBc4vDoyl48c71Y1/By/bAG9gEPzTNJs7n0JMFYfX3G95XgRQjRF/3OuHEvDM5ohTaJEgn8yUcaFgMVmtVEK4riQUAICWWa7vCEytFwHHbBDPh8pdKE3JWcYT4svzHW3tfcCplpzy7G9v/JEJgtjKfL2oKlgbqJdXb4XRh/j5ZS+ihm156g2w18poDYfKhO2a2q3veD34OxROWFzr+9piMjaBMvHgu92wf0fW6MNek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d32a90a-a768-498f-dd28-08def81ece8a
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 03:07:13.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQmXApUFTkpEXGt7AlU13iF6L0GByxuWARbZp9PT+7iFeU6WzXweqdz0It3iwGVkzTgZBsFBVCEPn/c6/9LQha+7LEQgAmp3YUhdIpIyvGr64ckGTehuPJgYOo6b3x8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608120022
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAyMiBTYWx0ZWRfXx7VzJYcR+wsX
 ev24PrB+p2s8zUHDLj/u+JFWv8FEyBHlbZllJiekhGJSMDekCRgZ0D7mb38tB6xLSu6MIWNHyKA
 Wv1ZimwvBubt3yxrfD4rvDsj+OWQ7GsuypxWj4ojpqJ9cik5aGvR
X-Proofpoint-ORIG-GUID: ndFNTghiiXMdewUt7555k8PG1WWz5yng
X-Proofpoint-GUID: ndFNTghiiXMdewUt7555k8PG1WWz5yng
X-Authority-Analysis: v=2.4 cv=FcAHAp+6 c=1 sm=1 tr=0 ts=6a7be365 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=6kOAOWsrWpn3sw8y:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=VwQbUJbxAAAA:8 a=Orv1OnrxGu5lBtMAI7wA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13509
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAyMiBTYWx0ZWRfX06JphX8YiLLW
 oZVo5MOnDyElalGbnPpw6BtAnTsOJ3t2Rai4hBAggjgGGF2Rfx3eYFZJ4Z6FjY/zefLJdiDM44h
 kinLcmTz+o0D5uWWJGfvVx6M0BtWPhzjxj2dDrEZqc/qdX1w6QmUurGeGmGcPWxPU80Ajzvv0Q6
 QbNmeHKMdWFvSZJUD2Qoed4wKU3cb9yp0O1zZJkLAwce6HnXpDu+0AN7Kzo6BaxhALcFGXJla5D
 LTjq1qiw7JW1pBx+hMTfjYtFj/oIncoBG643lC3mpc9LeuyB8qRvxqyIKlWybYEwiOhb/QnuCrO
 htpeKPoQ7VBHvV6bUUc+xYnel5zIhwCIfE4Vyhhu2t0/hJtqovucOwhYkZKDAJN9kkJVIIa5rDO
 3lqqpO0CPQTwg9+yIv0usR3Rey0993Us6X8VH1MDuTEsRwdQySJxR63Lyx4EU/OWD+PzztrZzth
 C6K6H8nayQudIB+mOJIqsP+GJ4rTk6TeddRBRszQ=

Hi Greg,

> On Tue, Aug 11, 2026 at 10:36:25PM +0530, Harshit Mogalapalli wrote:
>> Hi stable maintainers,
>> 
>> I am curious to know why I can't see FAILED patch emails for:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=622ebfac01ba4f9c0060cebd41257fe46fc4a0b3
> 
> Why would you?
> 
>> the broken commit is in all stable trees:
>> 
>> Commit Data:
>>   rev              : 355f4fb1405ec29d0fac49b4d41fcd78cbd455d5
>>   subject          : kvm: nVMX: VMCLEAR an active shadow VMCS after last use
>>   stable patch-id  : 67a5f1f0e5c07f4d579e84e2028f04fa5d0a393c
>> 
>> In Branches:
>>   mainline             : v4.9-rc4 - 355f4fb1405e kvm: nVMX: VMCLEAR an
>> active shadow VMCS after last use
>> 
>> and the fix has a CC: stable in it.
>> 
>> So I am wondering why FAILED patch notifications are not seen on
>> stable@vger.kernel.org.
>> 
>> https://lore.kernel.org/all/?q=KVM%3A+nVMX%3A+Hide+shadow+VMCS+right+after+VMCLEAR
> 
> Because it is in a bunch of released kernels already:
> 	6.6.148 6.12.101 6.18.42 7.1.6
> And queued up for the next 6.1, 5.15, and 5.10 releases, it's in the
> queue.
> 

Very sorry about this.

I made two mistakes here:
1. I should have specified I was looking for 5.10.y and 5.15.y, 6.1.y
2. I should have checked stable-queues.

Source of my confusion was it got applied to 6.6.y+ kernels on August 
03, 2026. And we had a stable kernel release for 5.15.y -> 5.15.214 on 
August 06, 2026. But I just realized that we can have few urgent fixes 
queued up and released faster.

thanks a lot for explaining. Will be cautious next time.

regards,
Harshit


> thanks,
> 
> greg k-h
> 

