Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCAA3B6374;
	Fri, 12 Jun 2026 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295437; cv=fail; b=JNRZHXpGxpSwkmY1GDyZZW3EgvGUHF51mFw05eSJLjVqvDItY8gG1iqzJA2Tlwm9wrpwXROpLLf7C3m83jMHWoyoxlvukHX0ksogneRVc4ukFu+D7wqXrbsC/yCNJsKzTz4cO7m1BteNqc5zgWk3ctydCEQyEFOjQZoSCXBCnuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295437; c=relaxed/simple;
	bh=Otp6PdwsnU7rdNoLqfgo32iVydQZaCJhgOC4oHcChtE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J9sXXHGvvokamvS/B/n/WghGQwqx25S6wfOJkLa+hRQOGavcTawgiJzukjxqFVdOvVnJ9Q0s/em8NWTmXzBHBl80aKFTgO/Y6TwiVE17RIo9rvSkqkZsF0LWPz+RxEYNuM99BldYdQunPcgWGPDCFj5RU8bqljTjjlsgPEs/0W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=y35l1vmS; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=EAfssDD4; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="y35l1vmS";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="EAfssDD4"
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CK735q4127035;
	Fri, 12 Jun 2026 13:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=tATRHtFsAIN3U
	JUbO61Z6cATBIcp4Ym4k0Q6E4hF+Qs=; b=y35l1vmSQmuylxnwtp671ool9jodi
	Z2AN5QhX/Ou8LDxvZCgGxQRFVsbe/752JM4Mg9ZjcZrDGFb7sCKp9h9jQf/iOIGY
	yB0bFUPklMvsD8/AJ36eCV47725w6HBUm7rXGVTqNamz15Y4g3KM/O8JsCwyZwRu
	svKD8tdgRTFXp9abl7g/atrXSXNA83W1sc/AgzrzNkBko7K7ye/Kj263STve8FZJ
	A73EC4je+f8iRzpi3r3t2ahs464BcBw3REHm4uhDpP8oGVttVTY0yEYi9YdJb90X
	nXYE954O3/9KzSFCyVQ8dhzSquv6Afh3j52H0nl4Aa3GpmCnEReePA1ww==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023081.outbound.protection.outlook.com [40.93.196.81])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4eqe5kx925-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 13:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/QRWcagUj+xV6tYy3rj9HiBVDeDtYPxHrbjzGg5p+WNAXkmR+/y+VopdeX0hiSuWNRjOSwOjjpwZBFilDgcw0Rv1XprlF9Uyt3Pl/hWJVEZow+MJ4ICJSYRlrh4DNNZQ/rROViojRpWOiF268TgyXswphR71vxzDWBd3uJvFpwKXXjvqiiL9zTpl6xOL+EuXB/VRVOhGs9xOWsMlBu6KW7lHO2UYSjpxVJIVYkGfGuJJXqsfHHLJz8jwGDf5R43Af7bkGCoTNMQqA9mqm7xnbRoxgmZMzW24j0zSTJjENtoUHOhj+uDl7m0tsGKzU7kj5/v8JUqHha2cHUWR5Xazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tATRHtFsAIN3UJUbO61Z6cATBIcp4Ym4k0Q6E4hF+Qs=;
 b=h+Y0JQ+qCtr9oxN3sWNjWO7mwedUwwkWCuzHMXk8ClaQpCgJYUYdGDMWWRjrPHhRODIjBzS3oFQdeWKnOlAwZvlW6uveDazmzDD/CEk0DieY/wwdoPh4+ReDTIaP824qRy1xyf5kgxW3F71HhMr9Yh8sZ2vcndFxLpojCK2alIBal0GjYg2+WMWvv649rXecz5MT7vAIsrfu36BzdYIpzihyIMMq++N7x9z5jS54sST+hHB0+rfTCkqTwgvL5AySRX9Kja6yMTO3IrODCTEuoWtzzuTWs+UwruPGHeereFv5AWyKAPuBOqxvwf8Pfk0P1S27DZKuNf3uteeusb+zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tATRHtFsAIN3UJUbO61Z6cATBIcp4Ym4k0Q6E4hF+Qs=;
 b=EAfssDD40AXm410Vmw7b/zhNXf/t5rILUfywCTWl3eimQD7pd5c41yDaiQewADaLjphmCZpWc8UVDStsHCfh6NuAZ2ckxsPObu+5YIvVjdtwKMdfGMPVxlP+hTP4/5bbzgv/8vO1hR4DcqSSvm0JXgKpf0zR9dCRBi93VVPZgoNEjMNjBPN5ta7OA8EdWhTx9ugtuR1QfqPxFNzf0OWHmc8eD+I5uXSyr8gsVYMejCGQtNc2IJXcoE5ZFkQYOmHQsbUm/qW6uzP7XgNUiKQnbOP0Gz4KnfKIk0QDJ4d9Hh/yexj8T9ZYS/hQvBzbx4bYJQ0mhBCswbfTBFj9UE8MAw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CYYPR02MB9841.namprd02.prod.outlook.com
 (2603:10b6:930:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 20:16:21 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 20:16:21 +0000
From: Jon Kohler <jon@nutanix.com>
To: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: jonmkohler@gmail.com, Dongli Zhang <dongli.zhang@oracle.com>,
        Chao Gao <chao.gao@intel.com>, stable@vger.kernel.org,
        Gulshan Gabel <gulshan.gabel@nutanix.com>,
        Jon Kohler <jon@nutanix.com>
Subject: [PATCH 6.18.y] KVM: VMX: Update SVI during runtime APICv activation
Date: Fri, 12 Jun 2026 14:10:01 -0700
Message-ID: <20260612211003.2503400-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0171.namprd15.prod.outlook.com
 (2603:10b6:930:81::17) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|CYYPR02MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: a5114eeb-7456-49cd-8a8a-08dec8bf7847
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|52116014|18002099003|38350700014|921020|6133799003|56012099006|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info:
	BKEzh51+bglhQzhqQ7kAh3h8nXntlV0xByQ2YwaH5qd7HFiYm7Fxxjju1wyRBs/bJ/+FdhZp5MVocOmGYgu0nqAknNh+f+KokORPC4+KBFxxEV2DvJpl4RS9N9i3nrRfvxvoZOsXJL9U/sVhtZ50l6h3bTA525kmOiloyltlBIv4mP2oW1+ssAGV7StsnSzYuE4hQbhMTFWcyieW8Z+p001tNn+H6rZp0MQ5982m7/F4JRtoaL0zgwJFZoXRRcKNI4zIFTv6mE7qBZ2c3/5a2jRyk3K7UnZSH1FP5Ps5F1rLWGAwkO9n5D254bvveVhc8OQdkh70+HuEw+L8+tiG2f4A0ahdDqvgtCL/+SV8JRD2nCBz5g6bteXTR1Uw4R1U1Il3uoxwZiMyoTTgjceYJiEstK9+bFdX9ku+/h8qwnlDKiVNIaQYF8M978NyY73XjmILQTX24YTQTV62ZZoFHFL5PrTGCVHl2ru91bCLbXRNnGuAzaejBGDCmT4pZQmvGRNEXjMrU0BkBKhuQ3H8UC0ZvP6SAheI2SNWK+imggHG6S7KBg7OVhJqYennXaHOqf4l5GUVPd1FqBcY2FYCijmLuYychZQUT/OhkmNn5Gjl2e8iz4dWSgcRG224kQl6ivtZG/PgNyP71kGW2jKtTW/TAhUEIt5EhZOcxnuxGXNrloMdnKiSZm+wE3+c1ws0r3jXV2TfRmdxPeUNsvIcTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(52116014)(18002099003)(38350700014)(921020)(6133799003)(56012099006)(3023799007)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnR0eks4Z29PaTRCajVIZ0ZrNkZxSnVaUWtDNkRmdTd3cDhuWHNqYlk1N21a?=
 =?utf-8?B?WWtvblBzbmlmUVVzMi94UVlaN25QS1RjL2x4dUdGK2VaRVlQNWlxSW5HODho?=
 =?utf-8?B?M1RKM3R5ZkU5dnRNREd1ckNTSnJiTHZMeFZMNi83R3kyRjJNbWVaR2FGOHRv?=
 =?utf-8?B?eHc4aDR4NG44T0hkL0d0VC9ZQnBSWUNYUEsvbnlMNVpyT3VOelR6clMyb3dC?=
 =?utf-8?B?c21JaDFFZlJoQ1ZUU2t4WGhwTy8rZ3hta0JnNExMSUZJTzVoUjlZSmRhOWto?=
 =?utf-8?B?VXMvNGEyVm5mdWkxdnVWUUF1RElteGpzcTllZllIcThXRGpFditYYjBHY095?=
 =?utf-8?B?Zkc3TklKUUdWLzBxUjRiRGFISVloNVZ5TWJXRUlYS3RvcjI3ZGYxcERWVkps?=
 =?utf-8?B?TDZYM2VPMjhwVm9Ka245NTV1T0RvdnZhdXRRQ1ZwRU1wSUpkTkpYRC9TUmw4?=
 =?utf-8?B?blBObmk0RFZjZjBOL0ozcTZqWGg4VktzaHgzZkUydFRLODdyKzM5QzhiYW9t?=
 =?utf-8?B?YWZXYXdQdXJmbmFLUEtEK2YxTVlXOG96TTRzZHZWcnkyOHkvZUlBZFk5UGdv?=
 =?utf-8?B?WE1OSnlsbFhTOVE0amIxcHh4WUdIb2lxdnJrQkg3VEpCQ05iaW9SeElsY20x?=
 =?utf-8?B?bXNiZ2lPcHBUTHZYY3hPWEhvU1NpRVB3VU5xd3NiR2RUNnhqYnZVUEFDbUky?=
 =?utf-8?B?b2ZCR01qNmVHaDRVSE9RRnY2UmNYT3NwZU9UR0U1UHNDMFpKMExmSWh3Wjk5?=
 =?utf-8?B?Z1p0YVBONEFHb3RVZTZNSVZUYTFqTkVQcFU1QnJZSGd0bnhVaXZOcmsrSUVy?=
 =?utf-8?B?Y3dndzVLcFNsN0hBRmxodUdtclV6bnpxdzBzS1BQSGRWL3dCYURFSEZEYTZV?=
 =?utf-8?B?Zk9Yb1pzRVI1QTE0Q3pUdWQyVHR0NUZiK1ZaVlNZcVhYRm50QWoxNzNkOFB6?=
 =?utf-8?B?ZmZodUg3aCtLNlFQcmxzRnRzUDFpekRLcVZ2YUduOW55ZjNCTERYY1RHcjBh?=
 =?utf-8?B?THZOSmFCMkZBTmwzdkhETytPZXVtRndnczZjL0VQekJrTTRYOWVkOHBIRS9w?=
 =?utf-8?B?TnJRd0ljbWN2QmZHblVscDFrdjc5Rnk1Qk1semsyMk9ybWVnbDZ5TE9PaCto?=
 =?utf-8?B?QUFoZ1BQWUNHZGs3MWlPTFFabW52SGsxajJhUUpyWmsxYVErMmxEWUYxMnho?=
 =?utf-8?B?QUZlMUIxNEE3bjg1Y3o1aHoyQlVyZ2svRGVUbFp3SVRiRFhZSlFkT29uRE5w?=
 =?utf-8?B?dVVpb3ljRFNoNklnQUxhOW1kSk9TbjdsVkJ5bUNvUUZPd1BDY0NzV2xHU1Jn?=
 =?utf-8?B?TktyWjEzcXpwQ0xzZ255YVliOWxRYk16OHczYWlDczRJTE5ER3YvczRLY3dt?=
 =?utf-8?B?aC9hTHkyYndSaitNR1MzU2l3MGs1QXc4akYzOUhKSEZvUzJOVzV2dmpzTUQr?=
 =?utf-8?B?VzJYaFM3cmVYb0pwdFV0b0pndTFBMGVBY1hYbnVQRFdOaXkyVXhiMGFaTW1U?=
 =?utf-8?B?UnFmMkFNNi9LSUZqR0R6eWR1NkJKTnFHbFFldmoycDJuMFNBeStlTHhoZ1gr?=
 =?utf-8?B?R3BWa3JGSXNEcUJiRVhaTE8yZTBzOFArWFNCMjJYTW5kNkFlWE82cjNGYjZh?=
 =?utf-8?B?MDF5TU1sWjU0VGt1Z0ZES3oxOUh5NTNqcEdLTFQvSTJXVGxnWGpJS1pNdFZ3?=
 =?utf-8?B?UXcyMmFFQk5HRGFXMGNRbnpqd3lrS0F1SnZJbzFkUWx3RCtaQ3FkWFhIcEd1?=
 =?utf-8?B?VE1WS0E0TnN5MVl3WEpJQUhhZDJrWU9DRkRNa3lSa01TL0EyODFDSWk0NFBn?=
 =?utf-8?B?djJEU2xubk9zT3o2MUh6NWIyMWMvM0xYazJMYVNEQmdob3h2OG94VlZYWEVL?=
 =?utf-8?B?WEpvNHFFUFZ5dDhSZEMzMFhKTWZEdzFPMVM4U01wVVZHZ0oyQ3d5UXJtdW5C?=
 =?utf-8?B?MjRWdkU2aGd0RlpKRlhjMmxaUnlxMmJQdk1JQlJHelJmS1p4MWN1QjNxTjdH?=
 =?utf-8?B?L3BMSUhKR29JOXdiSU1HMU44eUFxM0ljZy9wd3NYY1RQZ1NYMDF5T1pEUDdJ?=
 =?utf-8?B?VnB5Q1lUajNrcy9RUFJ0QWFWSWJQMENQdkRWT09NUU5TeWs3aTZteWdCZVIz?=
 =?utf-8?B?anQwQW04SXBQVTl1SjJPSW1lOURxUjlqOUZyZXByelRjYkRVMUJoeENsRkZC?=
 =?utf-8?B?UWtjMkpFL1VlU1JWRlRpaWpJaU9Yb3NvMVlNaEJSaG04VlZqSzlaWFVmSVRI?=
 =?utf-8?B?MktYblEwSE1rTmZTL1h1K2FCK0V6eTNyR1BCQmhwN2ZIaVRCMUl1T3VyMDV0?=
 =?utf-8?B?bkplekk4YU8vT0hWT3RCV3R2WmZvR2tMczJIZngwNW15cGxLRFZZRTJaKzh0?=
 =?utf-8?Q?nXCKVqxmYXJkwvdc=3D?=
X-Exchange-RoutingPolicyChecked:
	FGvlKbZTAQqs6cKJPkexpSThPS6QzZkiXx8ZWhiu5Gi4ycn5OGn6Eqgb+MbA2dSOCAEwQ6Lb66q9F00V6JTu+7o7e2x+0cIUfgaaFslEjKtgtluOGWpGMQb2XQxUnaDUuR14iGkZBZ5rtG7xeWra5MWn+Rxv6gum9gP7D1aT00nJlYrQlg1QZ5LHLOi06SdSIl3F04U+wXvDxV8v5bu1ZFNaP+LgATpwR0A9sGJrbid848iW3n6qNrKjGdo6x/hKM5z06acv+34Xjgn3ugu7Sf+yV4SXaf/137yHO8l/uRl1HnrG+ZM6Mw3sDizkffVF9tvjJWmYW/K4cCYuMNprWA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5114eeb-7456-49cd-8a8a-08dec8bf7847
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 20:16:21.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fp/0EgOP1DC/CJ2YRQHImC3J2OLj4MeK5MUF/6TS86bBNMTKZcqJ7Qk7VYuTlOm8zbFKi3l9J+aaK/lAty1R0jh1VLZDvOv+JSUarKRfXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9841
X-Proofpoint-GUID: B1uG-Y4sSkVLVoqrT27U407p-5Npnavq
X-Proofpoint-ORIG-GUID: B1uG-Y4sSkVLVoqrT27U407p-5Npnavq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE5MSBTYWx0ZWRfX72w8xs8DTjwV
 EkAvaRzbA0L0SraoRh/keN3j4ayemOS90AD/C0lFHwdZjij5HBLXtGcjzqAvNBYuoTfTHJ8/kpH
 RfsQgFZxU1NYE5n0hDXbpQX/54nHlQGWR2qMrH2l8fe4wRaqbfoc2uEhMaCU8FVhdGb8o++lUOt
 pKxaQQsHs1e9+iFKgeG0UObfXogzPWPYekYJBlYS115fukFNEFpm+MHxk3bQThg9//dsvimvZf8
 fiCTJ46sQBCVYeBaTKwskD0Mu5CXZN+5V6XCgBsVfScWs/R1gaEUiARK3GVqqyGcoI/PZCCmDnU
 E0/mr29J8flRw2IbsLLfmXNRmbZuYVPdM6vAiF4/3jjYwbUegG1cKSR9+nD7m6k4LErOcN/nBOk
 CyADCW46uzx7ih/CcHbLo68xBQaVaGPWa2SstvByndsVzXnmIhZk3DWHrVNGuQbg6lGqdxlmuJs
 7EFj+6B2AVNO9FY7DTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE5MSBTYWx0ZWRfX2rc/FJ7B8pdR
 Y0NLBOJnHP4OHra3jdOOsElXt9N2Vpjty8ANxJylvOaqTaoSSVy0aIg5IWuXBQBkYaJbSYLomU7
 i4g8YAYmzHT9z3P93J9Hp2FjS6ykukw=
X-Authority-Analysis: v=2.4 cv=TuvWQjXh c=1 sm=1 tr=0 ts=6a2c6918 cx=c_pps
 a=EI6zmuMIMY+nXR31EdRrtw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=bC-a23v3AAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=Y4hSQ5e727N7Tz2TztMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

From: Dongli Zhang <dongli.zhang@oracle.com>

commit b2849bec936be642b5420801f902337f2507648e upstream.

The APICv (apic->apicv_active) can be activated or deactivated at runtime,
for instance, because of APICv inhibit reasons. Intel VMX employs different
mechanisms to virtualize LAPIC based on whether APICv is active.

When APICv is activated at runtime, GUEST_INTR_STATUS is used to configure
and report the current pending IRR and ISR states. Unless a specific vector
is explicitly included in EOI_EXIT_BITMAP, its EOI will not be trapped to
KVM. Intel VMX automatically clears the corresponding ISR bit based on the
GUEST_INTR_STATUS.SVI field.

When APICv is deactivated at runtime, the VM_ENTRY_INTR_INFO_FIELD is used
to specify the next interrupt vector to invoke upon VM-entry. The
VMX IDT_VECTORING_INFO_FIELD is used to report un-invoked vectors on
VM-exit. EOIs are always trapped to KVM, so the software can manually clear
pending ISR bits.

There are scenarios where, with APICv activated at runtime, a guest-issued
EOI may not be able to clear the pending ISR bit.

Taking vector 236 as an example, here is one scenario.

1. Suppose APICv is inactive. Vector 236 is pending in the IRR.
2. To handle KVM_REQ_EVENT, KVM moves vector 236 from the IRR to the ISR,
and configures the VM_ENTRY_INTR_INFO_FIELD via vmx_inject_irq().
3. After VM-entry, vector 236 is invoked through the guest IDT. At this
point, the data in VM_ENTRY_INTR_INFO_FIELD is no longer valid. The guest
interrupt handler for vector 236 is invoked.
4. Suppose a VM exit occurs very early in the guest interrupt handler,
before the EOI is issued.
5. Nothing is reported through the IDT_VECTORING_INFO_FIELD because
vector 236 has already been invoked in the guest.
6. Now, suppose APICv is activated. Before the next VM-entry, KVM calls
kvm_vcpu_update_apicv() to activate APICv.
7. Unfortunately, GUEST_INTR_STATUS.SVI is not configured, although
vector 236 is still pending in the ISR.
8. After VM-entry, the guest finally issues the EOI for vector 236.
However, because SVI is not configured, vector 236 is not cleared.
9. ISR is stalled forever on vector 236.

Here is another scenario.

1. Suppose APICv is inactive. Vector 236 is pending in the IRR.
2. To handle KVM_REQ_EVENT, KVM moves vector 236 from the IRR to the ISR,
and configures the VM_ENTRY_INTR_INFO_FIELD via vmx_inject_irq().
3. VM-exit occurs immediately after the next VM-entry. The vector 236 is
not invoked through the guest IDT. Instead, it is saved to the
IDT_VECTORING_INFO_FIELD during the VM-exit.
4. KVM calls kvm_queue_interrupt() to re-queue the un-invoked vector 236
into vcpu->arch.interrupt. A KVM_REQ_EVENT is requested.
5. Now, suppose APICv is activated. Before the next VM-entry, KVM calls
kvm_vcpu_update_apicv() to activate APICv.
6. Although APICv is now active, KVM still uses the legacy
VM_ENTRY_INTR_INFO_FIELD to re-inject vector 236. GUEST_INTR_STATUS.SVI is
not configured.
7. After the next VM-entry, vector 236 is invoked through the guest IDT.
Finally, an EOI occurs. However, due to the lack of GUEST_INTR_STATUS.SVI
configuration, vector 236 is not cleared from the ISR.
8. ISR is stalled forever on vector 236.

Using QEMU as an example, vector 236 is stuck in ISR forever.

(qemu) info lapic 1
dumping local APIC state for CPU 1

LVT0	 0x00010700 active-hi edge  masked                      ExtINT (vec 0)
LVT1	 0x00010400 active-hi edge  masked                      NMI
LVTPC	 0x00000400 active-hi edge                              NMI
LVTERR	 0x000000fe active-hi edge                              Fixed  (vec 254)
LVTTHMR	 0x00010000 active-hi edge  masked                      Fixed  (vec 0)
LVTT	 0x000400ec active-hi edge                 tsc-deadline Fixed  (vec 236)
Timer	 DCR=0x0 (divide by 2) initial_count = 0 current_count = 0
SPIV	 0x000001ff APIC enabled, focus=off, spurious vec 255
ICR	 0x000000fd physical edge de-assert no-shorthand
ICR2	 0x00000000 cpu 0 (X2APIC ID)
ESR	 0x00000000
ISR	 236
IRR	 37(level) 236

The issue isn't applicable to AMD SVM as KVM simply writes vmcb01 directly
irrespective of whether L1 (vmcs01) or L2 (vmcb02) is active (unlike VMX,
there is no need/cost to switch between VMCBs).  In addition,
APICV_INHIBIT_REASON_IRQWIN ensures AMD SVM AVIC is not activated until
the last interrupt is EOI'd.

Fix the bug by configuring Intel VMX GUEST_INTR_STATUS.SVI if APICv is
activated at runtime.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Link: https://patch.msgid.link/20251110063212.34902-1-dongli.zhang@oracle.com
[sean: call out that SVM writes vmcb01 directly, tweak comment]
Link: https://patch.msgid.link/20251205231913.441872-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
(cherry picked from commit b2849bec936be642b5420801f902337f2507648e)
Cc: stable@vger.kernel.org # 6.6.x and above
Cc: Gulshan Gabel <gulshan.gabel@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---

This issue is pervasive and has been observed in production with QEMU
as the VMM. One scenario where this occurs is with Windows guests that
use the AutoEOI feature, which inhibits APICv
(APICV_INHIBIT_REASON_HYPERV).

The observed sequence is:

1. A VM is actively servicing vector 209 while live migrating, and
   before the guest issues EOI, the VM is paused and migrated. The 
   LAPIC state (including ISR/IRR) is saved on the source. Until now,
   APICv has been inhibited by AutoEOI. 
2. Upon arrival at the destination, the LAPIC state is restored via
   kvm_apic_set_state(). At this point, MSRs are not loaded, and since
   the inhibit is not yet in place, apicv_active is true, and
   vmx_hwapic_isr_update() writes SVI=209 into GUEST_INTR_STATUS.
3. When MSRs are subsequently loaded, the Hyper-V AutoEOI state is
   restored, causing KVM to set APICV_INHIBIT_REASON_HYPERV. On the
   first KVM_RUN, __kvm_vcpu_update_apicv() transitions apicv_active to
   false and disables VID, leaving SVI=209 stale in GUEST_INTR_STATUS.
4. When the VM is rebooted from inside the guest, kvm_lapic_reset()
   zeroes ISR/IRR in the virtual APIC page but does not update
   GUEST_INTR_STATUS because apicv_active is false — SVI=209 persists.
5. During the bootloader sequence, the guest clears the Hyper-V AutoEOI
   inhibit, and apicv_active transitions back to true. The stale
   SVI=209 is now live, causing hardware to block the delivery of all
   virtual interrupts with a lower priority.
6. In the observed case, the UEFI timer interrupt (vector 32) is
   blocked in IRR. The guest later reprograms this vector. When APICv
   is subsequently inhibited again, and the software interrupt path
   takes over, the stale IRR entry is injected to the wrong handler,
   and the guest panics.

With this fix, when APICv is reactivated in step 5, the SVI is
recalculated from the current virtual ISR, which is the expected
behavior.

Past that, we do also see this fail w/ selftest vmx_apicv_updates_test
which fails with the following signature before this patch and
afterwards it passes nicely.

./vmx_apicv_updates_test 
Random seed: 0x6b8b4567
==== Test Assertion Failure ====
  x86/vmx_apicv_updates_test.c:88: x2apic_read_reg(APIC_ISR + APIC_VECTOR_TO_REG_OFFSET(GOOD_IPI_VECTOR)) == 0
  pid=154616 tid=154616 errno=4 - Interrupted system call
     1	0x0000000000411e41: assert_on_unhandled_exception at processor.c:778
     2	0x000000000040593d: _vcpu_run at kvm_util.c:1664
     3	0x000000000040595a: vcpu_run at kvm_util.c:1675
     4	0x0000000000400d1a: main at vmx_apicv_updates_test.c:131
     5	0x000000000042e9f8: __libc_start_main at ??:?
     6	0x0000000000400f3d: _start at ??:?
  0x1 != 0x0 (x2apic_read_reg(APIC_ISR + APIC_VECTOR_TO_REG_OFFSET(GOOD_IPI_VECTOR)) != 0)

 arch/x86/kvm/vmx/vmx.c | 9 ---------
 arch/x86/kvm/x86.c     | 7 +++++++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c084f48e2b0b..b7798ced7b50 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6886,15 +6886,6 @@ void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 	 * VM-Exit, otherwise L1 with run with a stale SVI.
 	 */
 	if (is_guest_mode(vcpu)) {
-		/*
-		 * KVM is supposed to forward intercepted L2 EOIs to L1 if VID
-		 * is enabled in vmcs12; as above, the EOIs affect L2's vAPIC.
-		 * Note, userspace can stuff state while L2 is active; assert
-		 * that VID is disabled if and only if the vCPU is in KVM_RUN
-		 * to avoid false positives if userspace is setting APIC state.
-		 */
-		WARN_ON_ONCE(vcpu->wants_to_run &&
-			     nested_cpu_has_vid(get_vmcs12(vcpu)));
 		to_vmx(vcpu)->nested.update_vmcs01_hwapic_isr = true;
 		return;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ad2b7158b9c8..a21ebe04aa23 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10950,9 +10950,16 @@ void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 	 * pending. At the same time, KVM_REQ_EVENT may not be set as APICv was
 	 * still active when the interrupt got accepted. Make sure
 	 * kvm_check_and_inject_events() is called to check for that.
+	 *
+	 * Update SVI when APICv gets enabled, otherwise SVI won't reflect the
+	 * highest bit in vISR and the next accelerated EOI in the guest won't
+	 * be virtualized correctly (the CPU uses SVI to determine which vISR
+	 * vector to clear).
 	 */
 	if (!apic->apicv_active)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
+	else
+		kvm_apic_update_hwapic_isr(vcpu);
 
 out:
 	preempt_enable();
-- 
2.43.0

