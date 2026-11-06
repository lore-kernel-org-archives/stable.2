Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983906;
	b=PlTVllOPRjZkpK2S4h12BmNHNT0t2BvxvgKthpazK624s4GoO5Uh8BqUlNIGiyFUtCOT
	 ZLLAf/De+GiOVZw5r3ySEraARWphbxxNaPG4lVv6Rz54BxmF+X/zF6iHtleyX++UlQctH
	 hnA89hxVDIAytnG3fnpLvpJZAUWpde0fH/9zLjrKQbqWnAiu4x3muFqLS7I06uj8LJ3Os
	 fsGXn2S+ieKZpaM6q77OdDPTAwd1EdrRNcZoeUiY9TfFDr3SuDGLBumShFRhqBIEM/Fxd
	 WAIL7UYj62rTgpSAUyJ1F+qPxuZ8T0j5Ip37/EWsB+F4f0pEIbymG1Xmvo8+QKf17xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983906;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DL+t5M+6m9m4dizZAtMS9S7UHs94KJieOAfqHM7FpvI=;
	b=twHzfFDWgMFMut8M0z59jtyrvLvgqrsaBv8Q7qNBnGRPJM3qt8sPKPTwDm0fwjoBUXrg
	 tAAZaXDq+rogkudIatcabHui8H5SuOQR6BTmYMWL03Kv6gcFjPyv91M2apm/r1WpHMMHZ
	 IbOHTSssz7dj5xwjIKHzD20FnmLkEWzRIpDWxTu+jCwaRKgQtqXMnQLs9oOZLZWh4vL/B
	 HHpR3KcBixsSGT0qurAd1+yT7jmgt6WeaN/WO0RZJ7ZjOdkDXI/o2P3TJYWsneydSJApA
	 UDSrZiUIb27cXgPaJ+zfTqrncAL0dpocwwAMwwWM21tbSWBCXPRDH6e+sPKQCLudorQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VTenp86b;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=BwwzO1P4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612AD606A329;
	Fri,  6 Nov 2026 16:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 612AD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VTenp86b;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=BwwzO1P4
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GQC1U3531806;
	Fri, 6 Nov 2026 11:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=DL+t5M+6m9m4dizZ
	AtMS9S7UHs94KJieOAfqHM7FpvI=; b=VTenp86bhMAV16j6m9gFyLc3Ged2uxof
	5Rx+QyR/n6q2bSBVl0YVngNdY8gm9sksn8wc2DPJhZZUKlEiuk0J6Ix6LiFi4mht
	Lsu64QKWCSYdBB3RxPWXGBOoFyD+OoIJU6aJD2S1ioYz8Pmxp6mFN9ZHj2RxcybT
	tQanRdRxoicKIGhLbmx2OLQVjoQzoDzJ8k3PjFtpPQqAuVjWOOzS/63cIkovdmii
	sCaF8u0eQTgapZSsePRn3PgD0+G0ZToyFD16vguepeDD6ZcWAoL3Wi95DAB/K8Kd
	ejYKx/c3NCo4PQ3KJ9RUcDhm/Xy/asJjkT4yyveC/fOhceg5Z1GEvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DL+t5M+6m9m4dizZAtMS9S7UHs9
	4KJieOAfqHM7FpvI=; b=BwwzO1P4DYgg6/u2B0/bPUZ2OGKedqa+Pu6VUP43gU4
	A9z+TmDH6mmWhMmMYgGhbOieuX27AXufJFXwavhVfsot2kfurCKTm+O93OMfCO+u
	ovQvZxc9GoV3KPRqmG4Rrgoji+m51YqtWS4AleWjjohTBucaS+K2Yt+gU09EH/rP
	8zNNwsAPlLz/50gujkoFA0nf4/73bYjoWmR4LOaRkfnnBkl9XTYMLRMGkGcaCsLX
	k7FvStwgERMBQtJZoETBB2RGTVTTBG97d8rBy7CCuSqFoN70CZ79k63oENx0sOFm
	2ZSRHj79ktem1AWAP1IMUKeXLwcnSUevCk4CV2/EhsA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hsjdrg3gy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:51:42 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXuu3Ox260Dr7CnjnPMUcCGrXE15sdkoNYAIOuzS8E74BWA165HrXIDWtiCWx7JdTXg7893UuW9zNLqQKoToqAQIOtqLpzFJJOUbCJ9svToYrlOaZusMrpsEKCjE0XG6BHpkk+W//D5entRRA/5hA4FHBJRHBjeiwUrFCob7kmwfdcjku2vr+T3CpGOloqD52BdTc5HAVjHz/UHG2IowH8ujPuz2MnuLjqIQ18akqBWZ9Po8SKSi5mCiOGudqmD1FbkDX7ZT62vTddMe4MKttEVNsYt2qcnEF2ZLq4o1WBs32XyZVzZMJH3GuTa4HdgAoOgYs/I1Ai4e2NUNiUMkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL+t5M+6m9m4dizZAtMS9S7UHs94KJieOAfqHM7FpvI=;
 b=T8pXSVIUM9DThOfv9E+t7UzQpOnbbcX1bI3H3ul4Jcz7Y7BcCwB92qCuCLz370wLce9Uv5w3jGvSyusUILLve7FFYFVb9dlXWEkIG1TgEgWI76W/NFIbTVZlG8TYKyBEC62QJr+bpPeen0r7tc2uxhD4Gp9CB/SyluSP2Ly8Rpe7yM1yuM/x8r3t9qSIJZlNMebpCtbPpchjyVmDe+EJl3i1tgqaRympNHUWw2c94I6Re6seFJV4bGfw5Ie9iyTbVIulvFPJNN1Cj9gmG19xb6T3ximz1EXIuMHemr7CTz+V6nY5H5wiEb1+UjX6K/Y68UmLFqXjSbbHU2dBcDRHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CY3PR03MB8125.namprd03.prod.outlook.com (2603:10b6:930:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:51:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 16:51:39 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 06 Nov 2026 16:53:00 +0000
Subject: [PATCH] iio: buffer: fix bounce buffer use-after-free on
 unregister
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-iio-fix-possible-uaf-v1-1-1bd8b94e771b@analog.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDuQKAbtVUoXSTrRkWIkoyIE7
 95Ulx+892cQSkwCzypDop2F41ygHxX40c4DIX+KoVa10VoZZI4Y+MAlirD7Em42YNc2nkwIvXE
 eynVJVDZX9vW+LZubyK//FpznD1eKNIp4AAAA
X-Change-ID: 20261106-iio-fix-possible-uaf-853ce6ff96bc
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793983984; l=2608;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=hYPPeh62SDXPBT2Vb7izsZvO9nWDAB37p7qeLJC4QlA=;
 b=YfoYEiOsvhghqWIjfUlOYqZg+qUU3Rr9LtQQtIvZ42b56cGcZNquY73oPHlNtdiDMDNCAp0gY
 I4fDCofPemWCPDH3nddBvav0f1Fx2YZyqihzGPQXvn5s13tKSWMV0ID
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0066.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CY3PR03MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bb04f1-c3d9-40fe-33f9-08df3c2639c1
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|6133799003|10067099003|56012099006|11063799006|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261022075727099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
 s4XinuqZbKEdAy0IK1J+Tm3qH+28RR+xkOPpVOxn2I++27cgdLL+7XMH29QCiPI31G7DT3Sih4LYkksYg1jnL15bKIDZFnQD1KGh3pDqOO83Ivc9B2x388RjZNdFPeo6RdcQ3o0xUCxmau/nQxLw5hVigIAJHN4xc2ReSt6MmOfSkey3ZK5+F6K8QKhpfwKuX4CtMG5LVOojqeFKKWVOZ7dm9U1LSd0bFSR/ziYJlWJu736x7npfjRjeuXE9LLy81faeHWcB7m6r73uzc+bNnznNjjShoUy9RJauuLQE1W4rDsGzGPWutN0tHfbtzSUVxJc0zKrOlMpReAgd2n1W+qyl0+uIlnp//S98UuQgvmzyNH3hFa/tp6GHnTy9FwIFWUI6P7WpzltRknVgjJdBbQIsgeoFECSQpNsqpumOwwY5WC/VvDOnExOf5E1FYoyRNlB4QFFLM4rxZ/vCapYiLNRRuDw7+uJAVJ7hqdi0qSOc/CNws6dhBm5A4PU8vn1JXrZx5breNHm4v36P6kgSH5KE/4YoQ8oFSpqUhgxkxOrd5lpV+IJm3p0+X2KGPIx1aCHudt3LOzdaPeK9LDqejCvYCVdXz2HcYSuT+nWGw3Il9DON6Je+kYi8VQMm9IF/YKTH0Keq5U55cK0NHyZw3LlXVxiXH1BGmSm9pwAQzsk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261022075727099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q1ZxYmZNYmxsK3ZmejhyZmJwUkdXYUY3VkxwTVRNY0JnaHlUQ0dUVXZ1UmFS?=
 =?utf-8?B?WWRHVnhodUIvaVFpMzB2VHBrSWxYdXdXQiswNHpKT0xxL3FhN2pyVGtVRHF1?=
 =?utf-8?B?ZURKdlg4TjdQZWsxdzRwWXBFQVJCbnZJZ0Y3VmkybUhQN1hWOFZkdEZJTE9U?=
 =?utf-8?B?bS9kcXd1dFBWYndnNWIrV05oRHp0R0J6eG1DV2FmVDM1Nmx5YWloSlRCVllE?=
 =?utf-8?B?YTVmYXVDTjNzTkFvL0w3ZFA5bkNLRXhSWm5XcG5ocjdGZmJ3cEY1cERIWHAx?=
 =?utf-8?B?WmJqVi9GYjBHTDZ3QUFYclgxUm1JNFRxeVpsd3lnTjJTK0RMVnRrWW9mLzRP?=
 =?utf-8?B?VGx3L1QyWEkzZkxGRXBQdWFoRDB3MjJ4WS9kUldOb1lVMm1lcVFLaHZnLzFT?=
 =?utf-8?B?Q2JyYitFdk9VeTlqcStVdTVKRUlKNVFTa3Z2N3E5eW9WQ1FMYy9rZ0YwcVdO?=
 =?utf-8?B?N0FRdzBjRE5BVzR6YzkrZXlZampHR1U2NVFVcnZzbW5OUHVPZWx2emtjeFRV?=
 =?utf-8?B?eDNHRWI2OUlvN1hQQzhRN2xFaEsva2dnVVVweXVMRGhaK051YWVRWlFNZWJj?=
 =?utf-8?B?QnE3VXozOVU2TGZQdEUyU2xhRmFpdGFjZ29vekFpb1VzcWUwT0VpYzBEdjRz?=
 =?utf-8?B?TytVZWVwK3BHYWxBdEFqQXRkci9mdnZtaUJ3T0NOZ0hoYWY3Y2tqTjBaVHIw?=
 =?utf-8?B?bE5TSkxQTDF6Z2Judi9Nd05aNlE0b0VZVXZqc2ZKb21sUVVUT0RBWm9UYTZn?=
 =?utf-8?B?SlpTSVp4T0JTWlBxQzgzVkliZFRMSFNPUFRUM24yMUx5ZnQ5WTBoYjVlTHRi?=
 =?utf-8?B?TWFlN3R1R1l0dmpWWHJZT1UzZi96elhTOEE3Vkk2VGhVVGhDYkkyQkFkRWNT?=
 =?utf-8?B?U2x6am83ZDhNa3BKQUZRTnptajZVQUN4SVd5RzY3Yy92aSs0Zzg5L1VKS2Ra?=
 =?utf-8?B?dVJhY1BiSzJ6VVJ6SUl2c3RnK3JlOXBpOEpWVzJEWW1vZ3JQWFFNTE9SWlM5?=
 =?utf-8?B?SFdSZGlnK25Xb3F1ZjREVzlOdmc4T0NRZ0N5dHZlUWFiN2lTUTQyM0orcUdQ?=
 =?utf-8?B?U3RBRVBKbTdXUnBrSnJoNnpWT1RqS3ViWUlCQXZkdFc3NkVhNlNibmJTUm01?=
 =?utf-8?B?RXBHL3R1bE9iVmNVYmdFYlNUK3dKcnJYY0dxblJxdW5qelZGdy9iTWRxaldH?=
 =?utf-8?B?anVvalROdm4vNTQ0SVBORlJvcUdReGF2NXNnWTI3WTd0bVZwc2o3YnFoN0pB?=
 =?utf-8?B?ajAxU2N4bFh1UjBaVXg0RWIxZnBiYXRMZEZEbFYvNnJOZzhrNHRId3dhZEJL?=
 =?utf-8?B?MDRZSWx6R09scEc5K3VkWUV2T0diUXpKL1pRNXY2Z05PMi9XZEozVVVKdFZP?=
 =?utf-8?B?Q1NFYmJhSHR3YXlVY01vdks3ckxYcFg4YXNHcWwrL2pDcDNHdjZ5S3VXYVdP?=
 =?utf-8?B?d1VjVmxvY2FmVGhRUFRqSkxGeHA1OGpUNGZkeDg3NzM2TXg3YUFRRTZKTVh6?=
 =?utf-8?B?eHEwQm50TjhmK1Bybk4yaklGemtDUDAxRHVUdDF4QjdhaEI5cEtrc1FBbTNh?=
 =?utf-8?B?ZU9MdkJUQ3Z3UlF2ajR2Um9Hcnp4MXZHYk9WQTUrdTQwV1VQYkhtNjZvankw?=
 =?utf-8?B?RVArcWZpSWlPMVcwWFp1VXczeXZEbTVkS1dtUXpLYmtqZ2JaaVMwNHNvRGlj?=
 =?utf-8?B?cG5VNkQvUU1FbUEyd1dubWM3b09BVDJNakNkQ1FKcGNGbWhjb082dlRaSVFB?=
 =?utf-8?B?WlZxdklabHpXUUh4QXNsY0lKU1FRZXNEVmVDMU85SGJyUU5HZHNvSjQralNr?=
 =?utf-8?B?bnJLejkvQnhHVXpQWVVHYUFCTU5yd1pFOHhCczA4QU5wSFNqYndaQ0hMb3Uz?=
 =?utf-8?B?a3Npd25LZ0E0WmFRQ2xSK1dvblErczZDdEM3RHFNRkYzVGx4c1E5cmhkWXZL?=
 =?utf-8?B?MlJrWlJYUHM2UGUvMytOc3E3aGZRMDFabmZ5akRwMUpLU1dVWGJZd2VNQWpi?=
 =?utf-8?B?a0pUTHBZM0VrUVFYNVAwNGtOcU5kcmhyWGdxT3RhM0FmdWp0Si9nZFRiRmlE?=
 =?utf-8?B?K2wwOTBycFZQb2VOeVJRbXhsVmRncU9rL21lQmFrRTg1YkNHOVJWTXVaVWI5?=
 =?utf-8?B?YU9BSWZXV2JncWZFUnArM3VUYWFyMzk3QVdEampvTE5KVGIrRm9VcWw5dGZh?=
 =?utf-8?B?bitqM2pLL1VOYnBtQklmbFB0dzZpRkVZU1owcjBhSFJmWXkxT0ZWWVlJSWRO?=
 =?utf-8?B?U1Y1aG5SR2p5anNaRFh5NCtkaW14NW9yYURpeXUrNUhoRWg1QjJYRnB4cmRM?=
 =?utf-8?B?elMrNGNJdVNwQUZYWUZEaXN5bWxLLzNLNVFwcGNaeVNNOUJKZ3kyQT09?=
X-Exchange-RoutingPolicyChecked:
	brJzEDjc0HbeMdqdn09WI4dMrbgG9kwOkrFDf/1U5Y/8YNTWvnbejzh4PgsA5naBF4u9ZophO/OJZZZLdt2YI72xSrCOX0qL9CGDtc5SeYuIPBhFUii0YWoZ14+pzbOX0aSXeq/ThUsBXhfNwS+8iSZm3TA05087SvCpD9KBhKcYk1K+bFdYeabbb0LvO76eqWB3+t3ZYqziZb9EW7rWEnt34v1NuvnPCMMZaY6hy1ZRwkh88eblHXkQIZhoU06rXmiRN4pjncz5JRIAlq5I56Ofnhm3UaoeOAzr5/dCEnV09c5UfE+PYd14kNYhzT42c8+RsQAMUEPyVtdZnlhK+A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bb04f1-c3d9-40fe-33f9-08df3c2639c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:51:38.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR9n7tZKgJKloz4BrJLomf5ORLfZa48IZ0mXdmReSwy/IZKavmdvvTVHy8o6zsYB6F4neL/uscBfEQgJZaBCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR03MB8125
X-Proofpoint-ORIG-GUID: DOzi-FnkhpM3ywxVYfyNpQsFlkRwZd_Q
X-Authority-Analysis: v=2.4 cv=BvsIUoX5 c=1 sm=1 tr=0 ts=6aee059e cx=c_pps
 a=OswsEo8IlqVTC7zrgcx7Gg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=rbRm_Pg0xx8gA9ylw-cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DOzi-FnkhpM3ywxVYfyNpQsFlkRwZd_Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NyBTYWx0ZWRfX+4GagBtXnLiE
 arYtnO2bJjiaCFSteBXigXaf6t4oBbpWZ6S+Fk2Qf2g+GUBwEjDfXmCTCSww7WkMsddMPX3rRi1
 Tb9NldlYMHNblwg+60ArS8/gyf3xF9U15Hz5oTAXYZfNrMK+e7D6dFQVRpr7bAokLmaJcKop6sZ
 Ut3z31vDluKrVOEv+VSe7OlDYkEDR6leI7Cc9ob2LGypQfYy+lH9zkBJP0nQOFCZTYUJw0R+KdN
 SOtHD3ZK2TcsqFZsu2oW4/TIUyWkim1+JWfDIi6ByDIiIWdCaSGVwOhpPNJgnW4tgn0SkPpYPdH
 WntrgE/xve8LXW5tXGX2WmuKF3mrJupM67qI70Dbp8gqMOt3034PBCap1Fn94AHVppIQBqMKTgQ
 6tTDJAFtxuhNyrtJMDKTxuIdpWXHR90jhTZ68cZIl5qDCv4+b/09CLIRCVPtm1PrXyNRETqi6BM
 HFRCDaYMazftbSu5kBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NyBTYWx0ZWRfX3qmbFx4DdVGD
 GzmKCXb0LVD5Osm5TsBhGd8EIEn+AE7sQZmrp2KT4MyVqGMiCc7G2vwroFApH9IP1YHvJ9v8l7t
 IUQ64vJtjFbogYUaTEgXA8GnmBYExIjIdsJE+0X6Mh7qcCdds9MJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060067

The bounce buffer used by iio_push_to_buffers_with_ts_unaligned() is
allocated with devm_krealloc() against the IIO device itself. Since
commit 699fb50d9903 ("drivers: base: Free devm resources when
unregistering a device"), device_del() releases the devres of devices
without a bound driver, so the bounce buffer is now freed from
cdev_device_del() in iio_device_unregister().

At that point buffering may still be enabled, as
iio_disable_all_buffers() only runs afterwards. A trigger handler
firing in that window copies the sample into the freed bounce buffer
and pushes it to the buffers.

To fix it, allocate the bounce buffer with plain krealloc() and free it
in iio_dev_release().

Assisted-by: LLM
Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
Cc: stable@vger.kernel.org
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Found this by accident and do note this is just code inspection. 

I tagged the original commit supporting the bounce_buffer in Fixes: but
to be fair, the original commit was fine. Tagging 699fb50d9903 also
looks bit odd but maybe it's the real one to blame?
---
 drivers/iio/industrialio-buffer.c | 6 ++----
 drivers/iio/industrialio-core.c   | 1 +
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4294101810fd..cc5fde0f5191 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2464,10 +2464,8 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 	if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {
 		void *bb;
 
-		bb = devm_krealloc(&indio_dev->dev,
-				   iio_dev_opaque->bounce_buffer,
-				   indio_dev->scan_bytes,
-				   GFP_KERNEL | __GFP_ZERO);
+		bb = krealloc(iio_dev_opaque->bounce_buffer,
+			      indio_dev->scan_bytes, GFP_KERNEL | __GFP_ZERO);
 		if (!bb)
 			return -ENOMEM;
 		iio_dev_opaque->bounce_buffer = bb;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 825cf7f32059..ed097eb8d799 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1727,6 +1727,7 @@ static void iio_dev_release(struct device *device)
 	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
 
 	ida_free(&iio_ida, iio_dev_opaque->id);
+	kfree(iio_dev_opaque->bounce_buffer);
 	kfree(iio_dev_opaque);
 }
 

---
base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
change-id: 20261106-iio-fix-possible-uaf-853ce6ff96bc
--

Thanks!
- Nuno Sá

