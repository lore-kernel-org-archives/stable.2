Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807917;
	b=tBOx8QylAUDoFjRHZCAsSYuBmw4oh4RvDeTS4UdlsX5ETwW8gx/lr7r7i1RKggIC/K9l
	 VmaHjlId2r0QMzxr+LT7xldY7I9bfkKXxTLBoqJbnjmpK31dy1cV6S+ikyz0R5lp1AqSS
	 mL+WdqF4+Z1fIzEbZI4/4eGqECsrAKZ23d0Oaeb4nGpYcfB2Y09o8pS4eMymyVdcgUL4o
	 m9HEiiVfJe8cfA+mu4J+y0I2KvqzJ7y8n7lWHJELT1UzxGSQFb+MhS5nqy8LbU/MjpxGD
	 IprfX8JK10eD7nB7tB9m6K877nsd8wA39auEPxM8Nf6yVmmGDg/plZRFcsWeub/EkPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807917;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=DlYOD9hMcXr56Km9vp4rav8YkGW0jOvqpBWkxZ8AGzs=;
	b=bs8EwAM3MxA4c+uQ/hI92qN1JATPfkvaOqcEzyCEY3rqWoKlUZ9f+Vw0nzpZQL6UK+EW
	 ZkQqqAfLSu0PLFrTSUEO3mpTg+sqnG0YiElev5YrHSRB/1bxwZt8g5d0+p/L4VCxRdZe1
	 1s8KU2it4RNn+GWMukjCfgNINito5ZxpK7Xp3WWkrEGE4frJw/xNLUnpmGvtb/vu8sIFe
	 +nzFIREFLggZALozWAfGCIuMTVkQlYJ7xsEERrhfV/h8I9ZOv/vWsjYylnZVtPUcNcADS
	 AqtNOo1X6ODcyfJNjpCxi+GS+oZJ38FQ0RUTqTv4wxuYlDBXJD4qX2GFS0QvHTNXPFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kkJhy1m9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90309606A31B;
	Wed,  4 Nov 2026 15:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90309606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kkJhy1m9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUcCFvAYELpr3P9HZXeQAKxKrS8eKY1oIkvTGoLeVXn0qymM+O7vmg/P//HLG55KSShTO/plCcOpXVKjWVgmJVP3HgOk76QNjYi0kS6RuIiGybjeQ+iPL0+v/fUrYKEsyUekgHrr4e46eWIxgtu8sEHN4l/8yKok4kk5KLdBeCA9Ua/wR7IrmkSR4gkJaljw58x40hfXmYCaIx+P06ZUDDuiF9gqfaSvgyzWoiVOmOwcEQ8+PYFALOxR5WSb0SwIKECvu++rHPKd/9C2Vm9dd2tg2PW74iHAo8W+cgCyKOPi4ZvB8RyuB/Joa1u4aNOpMsoReb/vR22xIYtJNzqKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlYOD9hMcXr56Km9vp4rav8YkGW0jOvqpBWkxZ8AGzs=;
 b=UERa/spYBzl/Llv00Gw9A2R6guj7nL0Q6kzImJ4KChU9pz0MVlAZHTPz+TLgQ5t+c7YuLh7ZsRU3RxyohDWDGILdBlpRujDXj5Qho+49Hxav7kYI5EwCuBygJI4NFw6+kiF8odUJ0myWSW8+iI5ibPWZ27zm6xRWzL/mmmywV7N/6vcIld6zCn3+JQ7vk10SZ7t0WNW3ct/mvm3BG9p+sNL8N23Ak92qOyBDx6TBGwZdhzclCJ80GNeoVqtOP7BMc7z81IDD8iRr6cUTvrj4CqD8T+NYF3XyfJ/XSDhrP9J/MyDIErDPqDf9kYF2oloR6BCRZ28RwkWUzVDC6DahsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlYOD9hMcXr56Km9vp4rav8YkGW0jOvqpBWkxZ8AGzs=;
 b=kkJhy1m9OCal9sjyJjMcHZliB7ChVEOhe+L5KkFoErG3RriS2tUvMTiOmxOLJABL2hAqbZKQp+Pe7OjAyYEX6hkDBDpP5DEnjIR4+xWlBsZJ1eXqZ8Fr/CtHRwWkQZIKwGuZjb1xKo0TaEuBX5EdJ4icN8DjFkM7bt5wySzI1bQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by IA1PR12MB6650.namprd12.prod.outlook.com
 (2603:10b6:208:3a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:58:30 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:58:28 +0000
Message-ID: <d54c0de7-cf16-49e4-a106-aad5648b074e@amd.com>
Date: Wed, 4 Nov 2026 10:58:26 -0500
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH v2 0/2] drm/amd/display: Keep FreeSync flip timing across
 plane resets
To: davidralphhughes@gmail.com
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261028-freesync-plane-reset-time-v2-0-545a0f9b17df@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028-freesync-plane-reset-time-v2-0-545a0f9b17df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::13) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
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
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: ec12fbbc-dc9f-4fc2-5a36-08df3a8c779e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+JIxTMBaWxS/wsoG+bj4WKniyiGYOWt9iScTRcxPMI3uuXteQIlLsUDEwxdvZFiNHyWxOcyegaOEHDij6I8T52N05nC2vdUebOMRXbaaBiQdNdXswcTu6wM9t3J9BTCd/IUKvMX4fw2zDPlT3fKCBJxb6rE07EpRED5phbMJM9Ys902ROoeQWaAiOr2mFvhjOdE341uY44IQKZjx/xaEGOvnf5Aix/vlXWOK11Mpqg5KFeZz6duKrpk9ajmdYkwm/uaT4hfMAweVPGBhe9tYQN+T1AZZmgWF+vDeXj0BliRhZe1USrieT8bDj7lh+DUDBJCC2Q8H3To3zYeaSKEWukADsbfNBoR15jt+c3I4fwddgdCtZa0ddegH/6d9JdmfrpCNH4NfJeuy/OJTBzAOI1zvHAlVLVJzch3pZ7zafFID2t6S6TLu9JFA8A2dtHXZD8Fl7vgdfDOmYEP3UnaKLgs2rKgomeUowJVAD1o3YuGR9OfRe85jtHweaJ95xxpzdHHkp1Zzmw6K5/QOUdRwPsGkKMNtEFwGQsfanisdcYshykwzWR+e3oHCSrwLl1cdBq1HSSqMDnGC55erB0ITexKZBojWqTQj4TZ6q1cPhVBKt5u0vFFphU0Lptea6Em3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA6PR12MB893085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE1tVWxQSVp3anE5dU5Ya0JMak9WRGdNNVpza05TWEMxanViV3o4ZTFGY0gx?=
 =?utf-8?B?UXN4VGE3endUbzJQaG02REVaSHpHWENDM2c1SmJKL21pM0RNZmlIZWMxREpm?=
 =?utf-8?B?d0h2L3EwT1FhelhqR0hoRVRMd0dCS3l2S2RoV3ZJc0s5VzNLb2lVdzU5eGFm?=
 =?utf-8?B?RncrTk9OTEtXRmJmMVp2WnZKaGNPbjhZMU5ScnBFQ2Y3WW9JTUFYekZCemlL?=
 =?utf-8?B?MHFlekxBVGU0aW5nTWVxZm1peW1LamhySXFNNEJzSW5ROHNoRGZDOEk0Vytr?=
 =?utf-8?B?dGpVNythNW9HTlc1NGN6WmQvN05GVkI0UW80WU9tdkFvZVBHU1kvQ05OVGNr?=
 =?utf-8?B?R0NBNy9meGEvRUpGbjRTTUYwV0o3T2N1dEpoS2dCUWNWRTRpZzlkUWszSEM1?=
 =?utf-8?B?OFQ3enBZMU1MOTlZQ2lLZXNQY1ZOMUNuREhPd2IyRWp1L3FMWkVkeFRML2Ri?=
 =?utf-8?B?MTJWcVBhMzZodmJqMjF0bkNSbUlMZFdGNC9CQmQ2aWkxVXRNV0xwUWtRalBz?=
 =?utf-8?B?cVZkWTZ0NnhwRnloV2h6amV5Mks3TndKT1JJWVRoYVpNQjdnQ3lwQUVKbFRI?=
 =?utf-8?B?NkRJdVQ2U1QrZ2hwRzhtdHV1NzJYNzhPOUJ3UmlVTUtnS0gxbWxSUDBNOU9p?=
 =?utf-8?B?N28zbTl0NUF3bTQ5eEREa3BBNWlhNFEzODZSUHJySG5oWUN1YXFlRHc4M01i?=
 =?utf-8?B?K0pUcm1FNGlLaVFIZnRiVnFMSzYybTlEbktrT3F6b1NLOVpCYUQ2Ukx0MXpP?=
 =?utf-8?B?YjVBQ1BmMEZMLzZGM1RPU3JrQlJXM044dWs0WFZucHllcjBGS2Vtd0U1WXU5?=
 =?utf-8?B?MDduTkdoakJtR1JnNTh0QzZHblB6RUF1MG5NR2JoNUcrTUVEWGJaTHhZdHhm?=
 =?utf-8?B?T1o5bGdkZEtHNXk5UERXRmtKY1ltSGNoZzVZVTFBVVZhV0lVbFEybkdlSDE4?=
 =?utf-8?B?RFh6c0Z3VWZ3c0JuaWJFWjdMNEh1Wm44M0dvYUREMm1TR08xS0wxQXp5bkdX?=
 =?utf-8?B?b0hMWThpQTFnK2xrOVF6UTA1dmljZE84ejNFV2FTL0ZGbHErUW5tVTI3QVhv?=
 =?utf-8?B?anN4MmxUOGpHZU95bjFFSEpwZEVOb2RGRnBuSkZrSTh2YTc5aS9OZFFqWjRh?=
 =?utf-8?B?NnM5Wmw2VVNuUHE2cVlNOEROMmZRVEl5a00zT1JFa1hEaEcwZUhpTk1OS093?=
 =?utf-8?B?d0UzcTd6eUdUNWRGdk93RU16YnJpemdlVGRWUGgzOG9MRzR3b1NsOFhPZFEv?=
 =?utf-8?B?eHJ6Ly8rL3dLZlZwWTJuTCs5UXpYL29ObHB3c0ZTeUoyRkcwM3JrNUFQR2Ex?=
 =?utf-8?B?ZitkdjBxeXMyeFRHTS9SWlA4bDR1bCs3WWtITmZKRDJrK0hFQ3UzcnRZdFFm?=
 =?utf-8?B?cE1sMzlzZ3I4RWx3M3E0YjYxK3hVY21zL2t3U0NwRkVKTE1HTkt0TVl0djZZ?=
 =?utf-8?B?NkdRa2N4UlROMGJLSE5LRHRldWtPVmpaUGdubmJETGtZWjY0WkRBdCtXaTJF?=
 =?utf-8?B?QVBtaFNKZ2ZubnlGcGhjMlpTbW40Yk45VExUTlZHc3h1STRtR0JrcGwxTllr?=
 =?utf-8?B?bFRKYnFWTFJGRnJ3RXFLNmUrV3NWZG5xRE5LU1BjeFc5MjVJNWdSYUMrblMy?=
 =?utf-8?B?bjA3WGRCR1E3Q0hDVWpHSjRDUlpwTVJKUVMzbm1WOEZmb1F2VTBOM1JaS3pN?=
 =?utf-8?B?bzE1YkcvVzE2Qk1ydnI2U1JzVS9Jc3NPcXA2Yi9xbWJTanl3NHlEbDZzNVRJ?=
 =?utf-8?B?cmxCVE9IVllLU3VwZm5XQXZVTFgrTmthMkdsUExCVUdydkllS094WFo1bmJN?=
 =?utf-8?B?b0tiMDk4V1VqK2ZmV2ExTkhLSjUxcWhpaUErZmV4UGNaSkpFVjZyRUZrZ0hj?=
 =?utf-8?B?VFlPUDgyTXBLMzRLTXFreG5lZndUeDdFMFpIenVlQk9LWXRYeEZJNnlyYVpZ?=
 =?utf-8?B?ZjQ0VGc4Z0RJZVlndmJVZjZvejVIa2JZaVFlcGhqWVR1TmlqUHVSMGNZN21N?=
 =?utf-8?B?emw4KzVrVkdWNGk4b2taYmVUZjZKYy9LY04rT004S2dWRmFpVkp6UmIvSU1n?=
 =?utf-8?B?cVUzVk9XbUIyTzhTS292SWdKcFBKOTRKb1krTEMyWnA3L2I5ejJlRi9IY3lx?=
 =?utf-8?B?bVV4L0ZzNE5Sd2ZrN3loZFZxUFAyUkFVT0phQWhxQXZ0NWszWFJhSmZqbk5S?=
 =?utf-8?B?Nkp0QWVmRGh3OW1rVjB2Nzhma2RCS0lWczg0VkJQZHdzMmNUSGlzc0p2MFYx?=
 =?utf-8?B?aGhmUjJZdy82eExlKzlJeEZRZzNDUEY0RjJWa1RCenpCb3JMSmFNZnl1VGli?=
 =?utf-8?B?ekZtN0VNYzVWeGNuOVllaUpxNG9pa0tvSTA0UHEza0pjdm1DaGZYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec12fbbc-dc9f-4fc2-5a36-08df3a8c779e
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:58:28.7731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbB3+cNl71pW9diXxkgCBuAtYglKWXD31KX73PlgUvhvfd6m+WrzFn3q47lKE+5b9t9Mt6YuMhvxXsG9C7nEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

On 10/28/26 18:54, Davey Hughes via B4 Relay wrote:
> On a 48-165 Hz FreeSync panel, fullscreen clients under KWin with HDR
> enabled and color accuracy set to "Prefer efficiency" run at about 51
> fps instead of 60, with flips locked to the 13.45 ms BTR mid-point
> grid. That grid drifts upward at the rate expected if FreeSync takes
> the 32-bit microsecond timestamp itself as the last render time (3.46
> us/s measured, 3.45 predicted).
>
> KWin replaces the CRTC GAMMA_LUT blob on every commit in that mode, so
> every flip resets the plane and the new DC plane starts with zeroed
> flip timing. Patch 1 carries the timing over from the old DC plane, as
> DM already does for flip_addr
> (amdgpu_dm_plane_drm_plane_duplicate_state()) and for the BTR state
> itself (dm_irq_params.vrr_params). Patch 2 adds KUnit tests, kept
> separate so patch 1 backports to stable trees without the KUnit
> infrastructure.
>
> Tested with KUnit (UML, all AMD display suites pass; the new timing
> tests fail without the fix) and on 7.2.11 with a Navi 31, an AW3423DWF
> over DP, KWin 6.8.1 and Mesa 26.2.5: 60 fps content now flips at a
> steady 16.65 ms instead of on the 13.45 ms grid, 30 fps content still
> gets BTR (30 fps, no 13.45 ms grid), and debugfs shows
> color_mgmt_changed=1 on the CRTC in every sampled commit. Not tested:
> DCE, overlay planes, other compositors.
>
> I am not sure of the current AI disclosure policy, but I will freely
> mention that I used Claude Opus 5.5 to help debug and write this patch +
> tests. I have tried to do my best to match existing style/procedures.
>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> Changes in v2:
> - Copy the flip timing in amdgpu_dm_commit_planes() instead of in
>   atomic check, so it can't race with the previous commit still writing
>   it (reported by Sashiko AI review)
> - Skip the copy when the plane keeps its DC plane
> - Add dm_plane_inherit_flip_time() in patch 1; patch 2 only exposes it
>   to KUnit
> - Check the whole flip timing struct in the KUnit tests
> - Link to v1: https://patch.msgid.link/20261027-freesync-plane-reset-time-v1-0-bb43b501faf4@gmail.com
>
> ---
> Davey Hughes (2):
>       drm/amd/display: Keep FreeSync flip timing across plane resets
>       drm/amd/display: Test FreeSync flip timing across plane resets
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  23 +++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   3 +
>  .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   | 188 +++++++++++++++++++++
>  3 files changed, 214 insertions(+)
> ---
> base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
> change-id: 20261027-freesync-plane-reset-time-5db657eebfde
>
> Best regards,
> --  
> Davey Hughes <davidralphhughes@gmail.com>

