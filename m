Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012011.outbound.protection.outlook.com [52.103.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26B3B38B1;
	Wed, 10 Jun 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085798; cv=fail; b=CHneaokWNwkdb6pYLIC0eGmx5MtJmrCdMZI9UG4LHXUiWatM+1Tll8e2u5fq1Tc0/k6FAQcNzhIjNhXM89kHMWMf07ikY7z4k02VU0/p6jVjcGZx86NZfC6F47vSlT4VFxCaewwrgSxcwBc8KuXzd4OqYwbpzaMdp0hCs60Iigo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085798; c=relaxed/simple;
	bh=uY+plNNbMTbtgH4EPrmAJdFzp+QKWCeqP4QCmE8v/To=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=a57kwr6st5LC0SN2QBMllcxSmLeqpOEH0ITVpgC2+3QxQJcIWrHEhji9jZaAIYc0LKvygUZMIvRueZC/HVJ5B021mbGBMF16tFqorDBH8k7m61CiGVAhorWSLh30bCaYtiWq2sF57IGaipFVGo5yt0lNkY06OmWQcjv7JlcbzrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HGdnLQAx; arc=fail smtp.client-ip=52.103.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HGdnLQAx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6aJ7wwy/jJS9eYWlaTzeSB2Z6h9H4t/JP1mMz6iTu71BCZ1FjdXWChNhTaYFMMhc1FESU+EyKGSiSN4arpsQMslxfVelWFovbZJfm4Xokeel8FjX/VYDPBenOx3ytYFLDRzixl8Js3Ta/wP2EXvw58inca7+8TDcKvd5zABJ0D8DRVndG/4zMpNRb+c+ud2XqNH57lJYfAiQmxKb7SbkL3UfMLkFeXsOaqXi/iadpLV0nMVkGrj8wLAxe+JJnAkcrqE9YEE8SePzo4wIZZtW7T9Kmc3DKqDOxmXEdchAlobpyZbJofLwahj+n8uOng0N/SdJkPrpTmkIuB9UGLL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mhuymo737O0Zw8Xo4zmOC+9uMPt7hG4hYTLKKQ/Dorg=;
 b=m1hNpphNkPoCMFi4xJh1w5e85itTBV5ZN+dYTK0cDxqWj3+BTEVT35AptjPsV27m+31ceArCFuAire9pnyQzxFV3Y+f09NP+sfV6HZAQRB+In5rCP+j9M1OwR8/mFAWu+k9/Xiz4eTumYrdV93r0Rn+8i6LUlOOu3n01v1t0RsJvf1dO5WwkT3QY9OoreOQFAs6jsxgu679UD++5aqK6sxjIViP/bDSQVcuboFftIO/WOOoseqO9iZg0kQAyQ7RTTIB/1djRS5GmgRnHI2C3bpP2TGRNiR7rK1ptuuikFiIGgRbN0eEeB7Jlhe3hXFpHKk1jfzSynDqnQGtPh2FQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhuymo737O0Zw8Xo4zmOC+9uMPt7hG4hYTLKKQ/Dorg=;
 b=HGdnLQAxhYwtXGBKOxkafzrPSvYvZKPLIDh88TOPWCY5I29bsj4BKq6makCZXw1QDTiVt98S1rgk4UNxiQNxue1agCHtzmf+sJ7j7Jnqbucq6EcskbAWC6XOr4j1psyJj8+F3e3acltW616TW18t2y2qWUMLA+kXAxM0T/ghXX3FGpaIBJo6GowCqvxtZaPIuvVo37jByIMy12AWwbUHpEJ3on8GfkK8IRkDK5H/BtcGKttJRcPm6ADnUZKWNaYNMGw7TKBi0hNYbkofYWx3oDSGPEEDLJMafXDOmS1j7MpY2BK2vtOeoO+oFz8gmb9kwivtdXDs+ttpa6Vx38dLXQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY8PR01MB9096.ausprd01.prod.outlook.com (2603:10c6:10:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 10:03:11 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:03:11 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Wed, 10 Jun 2026 18:01:28 +0800
Subject: [PATCH] drm/nouveau: fix reversed error cleanup order in ucopy
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881484D91A6F80271415F71AF1A2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAPc1KWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwML3bTMitRi3eQkE0tDIwuL1CRzQyWg2oKiVLAEUGl0bG0tAHe8wMJ
 XAAAA
X-Change-ID: 20260608-fixes-cb491288eb71
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=uY+plNNbMTbtgH4EPrmAJdFzp+QKWCeqP4QCmE8v/To=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLE3T7+Lri7Mdjj/d+1LpJ1fqySxmVeO/LNvK4sXjH
 P/fKi4qetlRysIgxsUgK6bIcrzg0jcL3y26W3y2JMPMYWUCGcLAxSkAE5nIy/A/vYpP226CkUo8
 99nNPmY2zyd+/9a1rb9WL+9gy8Wayi3JDP+MNjy+d9Q46uomibpTfXNWy/8zmqEgYCC40OOz4Ia
 9D1awAgB+I0u5
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260610-fixes-v1-1-81f2c42d9134@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY8PR01MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0e00c6-aff0-44d3-c21c-08dec6d77a54
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOD3JyTmjEWWrIkIQHjHROOxAlFDNPTg8SH30C7I19ibkA+H4SXu69RRgaYqv4WcLEVdwCIu+6IuzCkO5HFJ36pSckLfhgAdTVksMnF1dGxeqYZ8gm3KgHv2C9aVBDxT5/janiuXPN8S2Pf8YuxT1ZY5kHVa3f8Rilw2SatJCyBVyV1O3eueadkhb9lh39EwlbafkVQVmkWZgmUgDj8GGKDyyytPOfFR6ynQ5bSwUufVRHSP0DMj6a9WgZuWLubgRlEdx8/Pizxk/zxqHuQJjY8M14DJATgeXGS+SITSoVgnh5VGOG/0xcPCornxScdbyhP7SN4W4NIHKcRt1zDIj3EuQ6RmnaE8o0rAwiZAYLkGhmysKgcV/xKEvmWMb+6mPmDEcHzvS4JbWKBFF+ypopRxN2wxB2bDBSwx9nSSudpPZzRjhNeTiCjtFA91c9lkIRd7K/ZT+cXWGzEmRUrsWXzm4bymOLNQLlfkuaJFnyKivNtW7MWxQTEHpHjCeLosVl3U57C+I3y2yW8wUlYAz1YSYu+dBEipbECHnsH/Sd3lh5wN5ySFizQ7Wl1OvfdYviCIB/3eZmBVLuF+AtdwVwP4fmj0+HbnBucHgsYicC7pB5C9e1Nn2IXjRPPJ2GW5n3LN1G0g3+sQb4qK4KAuSm5IdENKfKyaSAHH7TejFSv6PfUXvC6CUA+9n062yDrKEWBXuHWM1+JqrzfLnwVzg6JKEwZuweANFAzvvSoeWho00=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|24121999003|22091999003|5072599009|23021999003|19110799012|24021099003|55001999006|6090799003|5062599005|41001999006|15080799012|53005399003|40105399003|3412199025|440099028|12091999003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2cyYUR5YUVFak1rNXl0OUExNHR5VU5oSmdFazJVNW5tdHNXQlY2Vi9mcHls?=
 =?utf-8?B?NlZMdFN1RTBtVnVkZDk3UjFKa1ZuYkxSdXhSWHhqSWxJRnQ5aVdGK3pHM3o5?=
 =?utf-8?B?TjhlbTVFRlFaajArSEVsYllac3A2TFZDYWRhMnhUUDYyY3FwRGt1aE5NdEtH?=
 =?utf-8?B?MVBtZ091U2ZBb3IrVFdqYmdNYjRYMnZPRW5YTGhEdEd2MUl0c3FlWTA0bFdB?=
 =?utf-8?B?bkR4WG9sTXdacmV3K1RrWnhiMEFZNUZZdUR4Z1ZlbWEvUEpSMVJCK29UTzhX?=
 =?utf-8?B?V2NyR3ZSUnNaMzlMN1dKVXZWcmlHbU9MWkRMZUxSeFdVRDZJVjdlKzM3QXRZ?=
 =?utf-8?B?K3RWL2Ztb1NtT2d6MisyK3R2NUFBekF2R2txOFZqWlc5SkRKREpOUDJJcEpp?=
 =?utf-8?B?RUZneEJVbFZ1ZEw3V2JTYnM2NHdrWXJYcjJZNFdsV1gzMHd2ckVSRnVLSzEy?=
 =?utf-8?B?OWRGZVFzR0sxUkd2SWpBbFpReUtVM2NwMVFwd0wxSEtRdFhkTmpSN0krbzRz?=
 =?utf-8?B?QXo4eHVERTMrVW9XQjB6dXgxbytvMzNoZmRhdGh2R3N5dUNLK2ltWjVsOWNu?=
 =?utf-8?B?cTFIUUFucnZWUy9DNE1lMS9YSllLdmNxZnRXdDJCd2xZODZCOG1hV2lEdnQ0?=
 =?utf-8?B?OWFRcE9ORE5KaG5GSHJkdk45eGpzMzFjZUZmODFBelVKREpWajVuVlBHblVv?=
 =?utf-8?B?enpSMXhLbjBXYjkva01uMHJ4dU5UT3psR2tpUmplNE5HaWV5M2Z5dlN6aUM2?=
 =?utf-8?B?SDBtdUcrKzNzQXlRaGRxWHFlUFdWMGJlaFd1RzF6SDVJNkUrd0RaenZKVmFi?=
 =?utf-8?B?UnQ5UHRvdkVBTHh6eE43YWhkQU5ZWWE3alk2dUZyWDRRT2NmMmZUTU9vVlhO?=
 =?utf-8?B?MkFBTktEcGZrbEdJZkJ6ekJ5NTRiby84Ky9OYWQyRFQ5dGNKNmFNclVuMlVJ?=
 =?utf-8?B?K3N3ZWVDQnFESUx3SDdSVGprUkpuNzJFeW5ZdDFmSVh5NGtEeSt5aWJwR0pS?=
 =?utf-8?B?djJuWVJCc2Y1MzZkZG4wbHUzdDJVZEt1RUFYTVBHd2VpOSt0VEhwdzBMaGZp?=
 =?utf-8?B?Q0hGNTVkNVgvOGhDZklJcU5BRzI3Z0Y5VzBlaytjVmFybEFtV1k2eXdWLzRN?=
 =?utf-8?B?T3IvaXhnTGVLV1pFeTRZOU12alc1ODliVW12bEl6TzBxNDdOeFJzQmVwdjNt?=
 =?utf-8?B?aktkV0wvMzUyaHFmdFBJZjZSRE1ydWZHWW5uUldPYW5ZdjllaWk4NDZjU2RM?=
 =?utf-8?B?WDAzRldvUjFKWFY4TTh0TGtsT1JYcEJCRVRTM1VuTW1oUnBpSEZIL1YyR2J4?=
 =?utf-8?B?NmFuK0g0U0M1UkxVZDZleFhLUzF5cXBSdngvWnVLc2p5SnU4Q3Y3SkdTWUlr?=
 =?utf-8?B?K2l1cHBtcWVBUW9mUEE1RmQyOUxtMlhQK2JnVU4vSmdqYVBsY2NpVXJGNXNZ?=
 =?utf-8?B?YXY5cGxIazVXZ0lGVjVseTU5clU0Y3Z3NEUxNzBTSmkwQkRBakFRaGhWZmNn?=
 =?utf-8?B?U2c4NTd0UWVLcjFSbG0yMG1hNzJBeWYrYjgrQ2djS3hWSC9UNUJMR3lwTktT?=
 =?utf-8?B?Vk1kNjhvRGM4ci9jeVBsUXpEVXdJY3o1WlJTT2ZYOTh1VkNVcDFoTS9ITWxO?=
 =?utf-8?B?SUY5cGlmaFBkUjJpcUlTZ3VrbTZBaGc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0Y2SjRvUmJ0OFB4ZTZyU1ZJbGo0RXdLMmxNaVJPNjRBYkI2N09Jai9vMTY2?=
 =?utf-8?B?Um9zRldpMU5JaDljUTl6QndIcE9iVXlOUG9UQVYzRWtGKzJwM2xudE5senA1?=
 =?utf-8?B?ZVprUEl0QmlMRzlCWjRoV1hCMjllcXRBVnZjVG5rSmFFdS9rbkJ0S1AyUjc3?=
 =?utf-8?B?NWx1Z3ZtaG14T1d2Q2gxQklZclU0bGxBSDhBTTM4Y0Jub2hXVGJaMThuYnJR?=
 =?utf-8?B?cDZiMERGYjA5dVRZVXV0cnR3cVJZWkhyVEhFT3cyMzdlbzh1YmNWYnAwQ1Zi?=
 =?utf-8?B?RmRVWGYzWXlpUUh2aEJsNUk4d1ZKS1lUK0VjZ21PMm00bHMxME9abExNZS8w?=
 =?utf-8?B?Z2JHTXljbEpzNjN0LzJnbk14UlhJYTNtR0w5VDZScnBJZHZFYUp2NjZCUGln?=
 =?utf-8?B?SFZWbWZPa3lrWU9NUjArWm1nZytNV010UE0vUGlmbTlGMmpkcXphSnRZSjBo?=
 =?utf-8?B?Y0VyVUhVYlFudE5TSkVJdWVkbFhRK1NHYkJsa2wvUVZLSzNhZnhvRnBKMUZK?=
 =?utf-8?B?YWV3aHpWcjhLNG1KWk9HMVIxOHZyK2tUcWNkbzRzOUdzWGNZa05yZld4cHJD?=
 =?utf-8?B?N2tCcHV5eXlOcUpmZ3lYVUJjU25NUytjS0tHZU1FRkNWY0oxZHhRaHgrS0NP?=
 =?utf-8?B?OFV5QVhQU0dycUxvWFJZSTNvOEgvd05LblBNZEtLbm92UG52SlMwcnBuT0JC?=
 =?utf-8?B?OVIwVTJLTUdKeEs3SEphTmZrajFzaGF0eHYxclRGVTlhZkpiNVN0ayt4ZG5U?=
 =?utf-8?B?ZG1taGxmRTViZE90NU44ZUtud0ozREYwbTM4NUVnMzg2UVdoSXlYdDE2TkFw?=
 =?utf-8?B?UDQ2M3UxTHpUdWRzM3NnVXdJM253WnVjN3ZiV2c5blExR2gwdlJMVDIrOFZQ?=
 =?utf-8?B?dWM5Rk5mWjNkSVhKcFFDVHlOcnRrakFoSUtEdFpXbk9tVDdGdjcweGR3Tk9M?=
 =?utf-8?B?UWtOWSt3azgrSC9nak10T2ZndSsyenBhNDNZeHRacWY5MmJaWXYzSWRYZzZh?=
 =?utf-8?B?S3BYY1ZGaHcwUWw5Z2t5V0xKbHZSb0hObWFFWmM0QWl2WlZOS2FPZm1DUjl4?=
 =?utf-8?B?bHlTZzNzMEc5Qk1vdDdKbzA3OFczZWJuaEM1UExWRVJvdHlYTlBEUWwzN1lF?=
 =?utf-8?B?ekxocXhNaGZmODcxcWV5ZDg2RGNNZzhkZGxybmJKQ3Q4dzNJa08yWWdPaTJR?=
 =?utf-8?B?NW1mM1J1dkhMU2V5T0pxcEkxWHJpaGhmaHFUZFJoTnJWQms3Yk9yUHB0aUdP?=
 =?utf-8?B?WG1Yd0I5Y01taWdJR2x1ZVRiVUoxbFpTWG5uR3N5K0ttc3ZoSjMwSGRheEpy?=
 =?utf-8?B?UGswcG8xbXFvQmdyQW1TY3VBV1hOVjAwMDQ4TTgwV0tEcnBrZE9sTm5kV3dD?=
 =?utf-8?B?ZHp5WDVWdzRTZTNDSmhreGwzL0tLRC9CYkYra2g1WkxnNS9ORVpuVGRrWTRW?=
 =?utf-8?B?elQwUWluUm01eHgwUmFhRU1rWHFkZm5jZmhsaXpPWlVKcXZ2aSttUVBmSENO?=
 =?utf-8?B?NWNDbWhGeVkxT01HK2MyRThJdnJJcm1FNzFHNXpQbFlwVXNibWNHbWFVZXhr?=
 =?utf-8?B?NXhlMEVScG5XaTFpWTQ4TXNEYTVBUU1GMSs1MkNOVlNMTXViSjFMVW1SZnFW?=
 =?utf-8?B?dk5LbFl0bGdPK3ZkQkNvOWx6aDVjZGNkNTAyaEcvZ3N4b01xUVlVWUpHL1ZY?=
 =?utf-8?B?TGhaMlpxanE1SkVueVhEYXhvVDhsRzBxZ09BR1JTb25sL2YvQzNYWGhlSTV5?=
 =?utf-8?B?SXAvdTJ0SnVGQWM4VnRjaFJjRlBpMjJ1VFAyR1l2bnl2dmhpQU0xSHVoSnlC?=
 =?utf-8?B?bmpnZDY3KzVYZlZGMWQ4SHBlK3gvc0hCUnB0dDFTWjh3REF4RUx4ZlVjTFRC?=
 =?utf-8?B?ZGo1VnZZZXlDMTMwZ0EwOGR3R09XWEFVVXJIK0tnOEt6Rmc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0e00c6-aff0-44d3-c21c-08dec6d77a54
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:03:11.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8PR01MB9096

nouveau_uvmm_vm_bind_ucopy() and nouveau_exec_ucopy() place their error
cleanup labels in allocation order rather than reverse allocation order.
On a u_memcpya() failure for in_sync.s, the goto to err_free_ops (or
err_free_pushs) frees the first allocation and then falls through to
err_free_ins, which calls u_free() on args->in_sync.s.

Since args->in_sync.s still holds the ERR_PTR returned by the failed
u_memcpya(), and ERR_PTR values are not caught by ZERO_OR_NULL_PTR(),
kvfree() proceeds to dereference it, which can result in a kernel oops.
A failure for out_sync.s instead jumps to err_free_ins and skips freeing
the first allocation, leading to a memory leak.

Fix by swapping the cleanup label order so resources are freed in the
correct reverse allocation sequence.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/nouveau/nouveau_exec.c | 4 ++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index c01a01aee32b..a08ab1cfea9b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -331,10 +331,10 @@ nouveau_exec_ucopy(struct nouveau_exec_job_args *args,
 
 	return 0;
 
-err_free_pushs:
-	u_free(args->push.s);
 err_free_ins:
 	u_free(args->in_sync.s);
+err_free_pushs:
+	u_free(args->push.s);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 36445915aa58..f5e4756b4de4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1779,10 +1779,10 @@ nouveau_uvmm_vm_bind_ucopy(struct nouveau_uvmm_bind_job_args *args,
 
 	return 0;
 
-err_free_ops:
-	u_free(args->op.s);
 err_free_ins:
 	u_free(args->in_sync.s);
+err_free_ops:
+	u_free(args->op.s);
 	return ret;
 }
 

---
base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
change-id: 20260608-fixes-cb491288eb71

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

