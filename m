Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795006799;
	b=FqfX55//7EXFflZjy6/qPJZoKOYA3CaAB3ElSWtIQQ2FCM7eI3V8YCMS7wpdiG2waEHF
	 QTT2hBhRa1wlRUQAuqnH0Xjx/hw11HIfogxskZL2jGjifkYvM2SuvUYqNOMcWpPY3NJ0o
	 No/IPUTObdw4eupwVasjsKM1CEdRCSS4ceHBwVk6W37SyQJW7mR/z8Uxrp0Yv25UQuXf2
	 KraN8X7Qrp/9wzJNMteWWTUPcgNGcuXaw/H+ks4Jcjq5U9SIHoRZaiN438mlMAuNXVu5e
	 xMZZJZiyjvaov/5DPiC9Eq2rP+OXx7TZgmXXn5CLipyYBburvMTACnOhEDk6d7XI/VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006799;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MVbmPmt21hu49Hi9l9jXCR4W1l7BvoSk/TB3u3Q1CwY=;
	b=OP9fjCAQQobJxSWWoAAEDQA+bO5PQcJKWsWJJYFUxxt6KPyg2cMIZQHdFPty7wtn57zd
	 qI4gMSPnIqiTDKrA5olnLdVqaWtoWI5bbw7yaFrNIcF+ms1Nlm3lff5EWm8NkeBv6Q0uv
	 mRo+SsP1vqDZPGiuf3ciKmS/p771s+dL9vgqknMlYeun4LIywn5n6QpwQ4wj1hU9j+WtI
	 ej9Ex3iNre+RpRgw6P/YE6uZVQKuRq1lG48Gt/2mWLrzg7MzWa2flfil/h0m3kuiDyhLH
	 mjb+BhT3VyRugfT+YwTteGwfS7iJcz/UTMZr/U3LqB8bLCOWcp+nSgmJgWNP0jDLq7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=gKWxDcn4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.88
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020088.outbound.protection.outlook.com [52.101.196.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01603606A31C;
	Wed, 18 Nov 2026 12:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01603606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=gKWxDcn4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVOcrlrMgwlVmgioxaP7ITL/VyX9RcxRHJ1G3Xg5gqBIQp5iOWUxz3PkDNmxmhPW57eZm6O9ihlQnlQbvmCtCZlhkoti+8IbywH0xkyAnNF40VT/DwuDLzJhbFljYAHWIWkQUOkL0c686f7rEPr0NgIgrNXviwHasR9ZFEgz2eoiHL82wGbGr1ukFR9A7hzgr8ZGuC9LytIX9ftN/eOzrw2Fv8pjWJdtxYvYIi2tS2pHisC+1RrCegNbw0gXNpcG8X1kPyo3UjNag7UhtFllKOEIxJe94CYX3czgeL6Cjoawt974lbrjsyPczMQR4Zcn/dTp54OGgY2DA4kTpNZDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVbmPmt21hu49Hi9l9jXCR4W1l7BvoSk/TB3u3Q1CwY=;
 b=iWR+g8UnHS5Y8oLGdVwLfkTpEZbdQ9e7/ldeA0rRzgoJJYXsN9pTWloE2Xkz5L71UtwN/iQt6Nct75dBymSH2gixTelHBnjYzlpFheDedH0c1A+VJ3/+i9BxdK8SBBHezo9/9WT/Szj9v/I2SNHNIPTyJxkDqACwp6MxP0bhz5w+l5CgBwIEs2lgudC3LY6KSHBao+Okau401VSGLRzP6dya7Hfd5MCVs2gzUm7+BXc1pogeKkVrtH8k0TKhy2AVaxPVeAlY04dmZn3V58gf3JDYhIq7rpa0mrdH9wB9qy4uWi1McrOIYqFg1i91U44hNwak5q7NAtMOdDNZy/YNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVbmPmt21hu49Hi9l9jXCR4W1l7BvoSk/TB3u3Q1CwY=;
 b=gKWxDcn4CF3H0bUV8P6wN6N2WugZkaHjO63IEnM6LI3lZDgykaPMx4oQYi7ryQu6gc1LGJ886oKpJZiITMs/q7uHJNlP8MQefNVIK7AVkBk2qGhYIdL0dtAoBO67g41nQGXYUZbAfSQmpQbarn2Ni+SW1zHAHj8HfWNeVbfZXGE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:59:55 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:59:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 12:59:54 +0000
Message-Id: <DMYCSXNA6VQ9.22FS1PMBBYWRO@garyguo.net>
Cc: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] dma-buf/dma-fence: Prevent misordering for error
 checks
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Simona Vetter" <simona.vetter@ffwll.ch>,
 "Chris Wilson" <chris@chris-wilson.co.uk>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
X-Mailer: aerc 0.22.0
References: <20261118110914.1471416-2-phasta@kernel.org>
In-Reply-To: <20261118110914.1471416-2-phasta@kernel.org>
X-ClientProxiedBy: LO4P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::15) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO2P265MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7471df-f403-4fe8-4891-08df4573d7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|10070799003|921020|261102123227099003|10067099003|56012099006|5023799004|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UlE8NYcCkVhOBLGjRHKwe+hD0sQzQe89CmQro/4mFozGNJaLhth28PqonKHZJXu5bqFlIVXmSphhxBsJEPU9nuwPI6OSkcxWU7DppPrmwdJaP3g8JZRvIizrgvbj4CXA2g/HzlLXvtJDe+fNsvNWqTQXjvfCwF29+HKRpxq4clPwSx7ZPSsUo7TFn83cPT5smjc4ZB+Fp4EgjR3j0sZJX0QwvJubLvqWbV9YjNT7+dOMOCf/zCdxzso4lDwmdvaJIxgOv+Gc1/y4GBn0gMzLP0nK28DQt96/tBLOiE/PbguK4PcqKUU8mKbV771BZNwrXSEtLpN684j7Gsie1n6OhIo5IFAcJaDnfwWBtbWCPHnpgs5U7JdZW3ISSFRs3Eho6BM5KFuTaKvJxvPEMypnhaOF01urc8t0eYpmdvb3AOuBVuFeEiQ56lLtBu6bDOVQHtimeg73VtHnTezoj0JgmO2nfR/4T2isnIOfS8M5jaCT1R5uEsXnkeIaAz5Zg0ETAaq5C2rmI+jBPwWv+SMNAhmXY7qnt+ZR586dYs+n6IOmS3wzQf8cELOhArrIc676lrTu0o7SDSfTrU/Ru/vh6zLRELt8VF/Ehf9/N4I0C105B3NquC+QXdJLljKXYcc8zwcwjxkmi9ltGEIFiFoSZ0wpV585R63SN/C5xOHqS693iPO5PnWoZVgX2ZRgcvRv9agvNvRysQev/uaGJu1SOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(10070799003)(921020)(261102123227099003)(10067099003)(56012099006)(5023799004)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dityN0hsNzB3RTlrS1c2WktZR1FORVAyKzhGVTd5aWo4TG5NNDRKSWdKTUUr?=
 =?utf-8?B?R3VERzhKVGIwL3czSFBMKzJ4enNMUk0rdDRuSm82a1BHRVFBYmd3UkI4cXF6?=
 =?utf-8?B?T2tqMWJjNWRZa09tdXA1QndGaWU5TFRoOUxZSVRGMkdMSGd1QnNiM01XeGRy?=
 =?utf-8?B?TFRXam9qbEZxT25SUGMvTjRmYU0vTC8xQ3dyTzR5L3E1SlFwdDF4UWltUXZI?=
 =?utf-8?B?eXl0bFFIOTlxaDVnZjMySTFXMHdsVDNvcXQwbmw0S1NwTzhuTEIwWllFMGdZ?=
 =?utf-8?B?MFkwajFidkJwWXJyQWxiVHVDeFVvcXBxV2pZbVpqaytQRmdHQmlzcmcwTUJW?=
 =?utf-8?B?WEFsRjZBWmdYMFhDNDNtOHpOcFNITzVla2RWcnEyM2k1MEM0SFZsVXFEdmdJ?=
 =?utf-8?B?VkkxK252aU1hYWEvbWtyOE93allJS0t0UEk3L2l0NEtXTXhaYzR0VnowV2hu?=
 =?utf-8?B?NytFRE04dWh0RlFZN0h3MmhzRlZjZjRjaC9JcHh3eUFRRDk4TTR6VGpjY0Nm?=
 =?utf-8?B?dytmcHhJakZ6KzErUE1Vc3hRck0rOVF2blp2aG5sOHY4a29tOXRCU0FERXd1?=
 =?utf-8?B?d1cvMUlrcWlKdlNUNUEwTmhoRHh1U0ZBOXJIKzhsWEZYejlaYVVjNzNqM3Js?=
 =?utf-8?B?N2ZIdVpGZjhUYnNMWmJjU1kySys4ZmdlM24wbTQ4cTJENk8yV29VR2NYUm5U?=
 =?utf-8?B?ajZlUkJVNEtjY1BPcEpYL2lWd1BWdmx6MWw0ZDZucWZjM05PZjU2ZUpRS256?=
 =?utf-8?B?Q0VSMnZGM2FQZW95RUdyUDdhZUNPRXQya2lvR2hydTBzV2Jvd1FGUVg0MVZM?=
 =?utf-8?B?MlZrZ2Z5N3V3ZjNydGwxQWNlL0tFYnBzMjlCZmZKSnh1empxTG5ocFlaNzFJ?=
 =?utf-8?B?QWk2S0R2SDhvTHY4N2tLZHJncWNQOThPOHl2SFAzT3lqZW11R2dUcUMyT3hJ?=
 =?utf-8?B?MFVTNG1hR2VIMEJoL0JtM2w5TVAyaHpPWEpqa3pSS0NJM25pK1BRNG8wbWxx?=
 =?utf-8?B?VGN2ZmxhdWpRSnc4VGhzakNnTEtOUEFYVzJnRmt1MHM3VmF5U0c1TUdyd3NS?=
 =?utf-8?B?MjRMQ3dQWjgxZ0NSaXB0UFNpWmgwcVRTSWVXT3FSOHdDWUU5cVFIYmM4WG42?=
 =?utf-8?B?aHpma2MzQVRBRFVJLzZYU2RIVTkyQ3U3a2pEemU3REd1c1VEbUZDdEhuWlBO?=
 =?utf-8?B?VEZmS0dpOWNUQVllRStlZVNHclhqRzdXbkhoeTFsM1ZueDdLZGk0R21FR3Vs?=
 =?utf-8?B?YmJ5VVhNU0pjZTFaNW85bzNaZ1l2bURqSDBlSWh0Zk9VNVRaMWFvSGdsTEZx?=
 =?utf-8?B?OCtYYk1DU1BaMkxudWZScm9lMHVwczZrSk4wWWFhVzNNam9veVE1bEw3SkZv?=
 =?utf-8?B?aGVKYnVTUTZBMGI1dDRpYVdXTFR2Mm41THpXTlhOVXA5dU1kUS8wRkg2L2c2?=
 =?utf-8?B?dEc1cFlCNXo0cHp2NzRST0E2N2pwdlorcWdQN1VpazNXai9UdFAxNkROT2Zn?=
 =?utf-8?B?Nlk3TmMvS0l3d2E3UFZKUDUvUVc1OGdlS1RBWlZWZkNIL2VsRzZ2dDllRG9M?=
 =?utf-8?B?NGtWNUQ2cnhPYTNXN1dDbXRBOHl0dGFFUTBIRklRakU1WU1hbkJrVnhuNSsy?=
 =?utf-8?B?b2MvblFPWk55OGRYWkNKZmFVUldmZmx4MW44MlBxZkIxcTZiYXhTcDh0T3gv?=
 =?utf-8?B?dUtzVHphcGFmNWdwQ0h6OW1ZSEtCTytFenZtUDdUYjNMUDk3N2hiZGU4WTNz?=
 =?utf-8?B?U3o0OHMvUE5oQ2VqaTNnQmlwcm5zUzViYlY3WGptNXppM2ZUdzd4aEVwN1JS?=
 =?utf-8?B?MVFETUV4aDhWaHFhMFR5WkR1aTZ4SkRVU3libXJsMjM3OERrdkk3VGdESzlJ?=
 =?utf-8?B?U0prYXZGQ2tsMnB1K2hRMGxrM3Z6TzQyZmE5bnZmSGVjSjRkNEltc3BRVjl2?=
 =?utf-8?B?V09oSUxGc0RjelZJMUh1SURHWmJvVUNNQ0xOeDUweVFhNUE4eVBROXIwZ01j?=
 =?utf-8?B?UCtpRGhHU2ZUWmFydGdCUVpxM1M1QU80ODFxdjRrYkxQeExqQVFlYkwzVWVR?=
 =?utf-8?B?aVVNTzNmQjYwTkdCVnp5RWY5WHlvNEVLZU1aM0lvTUlaMnIrdzNzS1NVZFlp?=
 =?utf-8?B?K1lvdG02cFhqbS9sanIxUHN2clo2V0YvcUR0MklkY3MxUlVjZXBtdFNJaHZO?=
 =?utf-8?B?S285bFFqQ3VzTDBqMnpLdUJRQ3A4ZEFobFdCZTk1SWE2NnpDK0hVK0NtT29G?=
 =?utf-8?B?Q3ZBS3RyU2cyZkcrZ3A1RWlnRFkvdnJlYjhjTXBuUjVkejZKYk5OQXdaNi92?=
 =?utf-8?B?ZUJsNkd5YTVOY0Era3NwVUV6OWk1K3JQQ3FZeVhFSkYxd2xKV1FJUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7471df-f403-4fe8-4891-08df4573d7d3
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:59:55.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S55BFsM8+ERYXPTKJ2zze2tFKiGl0cXPJOi07fOap5rbr0IujMfj/K8a2ZT2YHqCToY+qOycqcteM/mUhxActQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5183

On Wed Nov 18, 2026 at 11:09 AM GMT, Philipp Stanner wrote:
> Many users of dma_fence do things like:
>
> // Thread A
> dma_fence_set_error(f, -EINVAL);
> dma_fence_signal(f); // <- Takes lock, which orders against the above.
>
> // Thread B
> if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
> 	pr_info("err: %i\n", f->error); // <- Can be loaded first.
>
> There is no memory ordering between reading of the signaled-bit and
> reading of the error code. This can result in outdated, wrong error
> codes being evaluated by the user.
>
> Though dma_fence_get_status() does take the fence lock, it is equally
> broken because the misordering can simply happen within the critical
> section.
>
> It's not entirely clear since when this bug exists, but at least since
> dma_fence_get_status() was added, which is why its birth commit is
> marked as the Fixes commit here.
>
> Ensure ordering for everyone evaluating the error code centrally by
> using test_bit_acquire() in dma_fence_test_signaled_flag().
>
> Cc: stable@vger.kernel.org
> Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Changes in v2:
>   - Use classic C style comments. (Christian)
> ---
>  include/linux/dma-fence.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..a3fa1341765e 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -496,7 +496,18 @@ const char __rcu *dma_fence_timeline_name(struct dma=
_fence *fence);
>  static inline bool
>  dma_fence_test_signaled_flag(struct dma_fence *fence)
>  {
> -	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> +	/*
> +	 * Best-effort ordering of the locklessly evaluated signaled-bit,
> +	 * especially so that reads of fence->error are not misordered.

I am not sure if this should focus on the error, or it should just provide =
a
general guarantee that anything happens before dma_fence_signal is visible =
when
signal test returns true. I would lean on the latter?

> +	 *
> +	 * The release counterpart is typically ensured like this:
> +	 *   a) Error codes must only be set before a fence signals and
> +	 *   b) The fence's spinlock's barriers effective in dma_fence_signal()
> +	 *      ensure ordering.

Spinlock has nothing to do with this. The only thing that guarantees the
ordering is test_and_set_bit in (c).

So probably easier just to say something like

    /* Pairs with test_and_set_bit() in dma_fence_signal_timestamp_locked *=
/

Best,
Gary

> +	 *   c) For users of dma_fence_signal_locked(), the barrier implied in
> +	 *      test_and_set_bit() should do the trick.
> +	 */
> +	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>  }
> =20
>  /**


