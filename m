Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020123.outbound.protection.outlook.com [52.101.196.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8B42D77B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558353; cv=fail; b=ch7uVYh1jEMUfbQlJET6nSJ3oKQHzPbDFNcljLWSGfYn6RZPxu0GitAw9Y4/GDToV7w4+1DqNRJ1QGXQ5Oi8G9ijQHxgzH6F2zc2l6tGjtBfFK/4jT7weGAfDei2CmHOEXmAt4jZG36kEttPvcNTyHIhP3LUf0DspHQrY6B0FRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558353; c=relaxed/simple;
	bh=NT+Gm2qcF4wb/bG7SiPPzjaX9zOTErHKBnJB/GXX5Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUzPDjQyfe1Z9uJF5mpSE3KxzVEJqT+yK6110FRL7vVo70Ki1OjldPv1b3u9xhnz7Psqc8Dcxh2hLLmTOO2j0mLErgThumvGnrzkRjU2FoeQUBSXRAWUM5K5PHtpnFeDatw6ozs1L6CpPbZ2OKn1BjdM/oCQbszWmAVaSg+f2Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPclumVCNuPfAX1n0jZMvg41IaArw1w1pBd0lIDXzwiSSlXhad6UaRBoZScuB8JUNSOtjSgCV2Q8AhyGruCjS5ZGOWLikVHMxcnrEVoPVqVhOAcAvxaf4WS8WEnB0aoa5jTCZuOLSP4T+scoSYxOT1mU+dNq8IyhSMv4xr3WM0SE/00efFuCfcv5R5ror6ND04U+oFHXBZEckqfbATavrA/4lctQKoyuQMLq8VjPwA26AE5pakOeaqlLxMKPTRI7e9a/u0/bJl33Z89PDqjbZsJt7eWVpygzZ1s/IiQq/15tfRo1mbvd8HBoE1J8NKlsFW7BLjUBMrJLCzl7UKEo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=D7v3o2gNRtOOOi0WSb+K4ubxzG4cLFeNhVqQzkFgrfM=;
 b=TKKA2nBlEq8dESo9KokWu1hcrJNIBntc2cLxWZKs9b66Br6TussOiztyYPexKaNJcsuHCkLkYpypkzU8c6NHKlgSPTL/UCtplNPRvXbNk2r8YfTIFetz1UoUoOabyyQH2tHLKxSzi0DD5CbirrkonG8pbvIWjqqGFTfWvB+ZyuEPUHeilksxuj2vyeN5oKFF7mqx1PB+wJiGP/BIIBGP6yWTqVy4p2n3V0CmWih1yLFT7TLHDexj/37q1nNLCiVLsdcYB5od5xMB6mKYaUv1Z0kUj7gldwhQX9Vf4lFWF7lD1TWO/MeNLu6yjDM1KTBVuM47SAOc76LwJpCmGL7kYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB3946.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:39:08 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 14:39:08 +0000
Date: Mon, 20 Jul 2026 10:39:04 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org
Cc: tsbogend@alpha.franken.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mips: sched: Fix CPUMASK_OFFSTACK memory
 corruption" failed to apply to 5.10-stable tree
Message-ID: <cowmxekbtrbygr7ab4imkowftfckfa6grimu2qxtwtxeqxjqc7@c2xitsozx6sf>
References: <2026072000-riveter-snowsuit-903d@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026072000-riveter-snowsuit-903d@gregkh>
X-ClientProxiedBy: BN9PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:408:fb::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB3946:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f49034c-ff8e-4ad6-ef69-08dee66ca7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GyZiYUHWUmjhwh946nL9QZfezEj17IoNjZINpNsHMGA3BH40XCKlZtcTJAvKvYPGk0+PfL+ZGjhUeV+Lyw+HRkF5wu1gbGC/fqisgEx6AgBY4m2/iO5iKslH+rtAgNTf7i5XH5sTUvOamn6EbGaWqiev4xgZhazzcx15i7El3qinzKRUgX/WQWFyZVsf3svrPSpcXW/kVNUb273NGx1IY7Y6mwrtG+i7zWqfgYbtPbZpSqzneNXNPvGDnQOlzBJ5CZNdIbvyWIaEa59VJ5/1I+xcZH9ZDcNJC+pDDkdPc61sjmnaqhJoclvGpccoD31ib7L9V694RkaqxpeJuiWLB21BNU6LSYYmUCaDsrTB6uCJk/DAD6IdZbwueAc+LA1mQl48xMp5KgsBF4R7eVRDq8U2tU3eAOw76HV21nxcuQWOcHCzu1hVPQKJGu4mM2Q7/siHyr9XFT1xA/RLp4Q45ZgNr5sSPX2EgAuefp0Wz7dq4U5nAFVMIyI87XZnJ6fB/1tEeg+0sDpLYx6kwmYBX7SM9d8gBkJWJlTl0finpHF6ePXF7xVf6Jqt5Ekzzj2hJl6GHT6l3ujvq4k8MwxUqr7PeJfmlc7c/atNnbM7/3SNVYOFhyGzkKOGxetMoOtVO0TrNqIlFBusMb+oniAEK5oBIFcU22oQjy+5ewXtwbw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkRFRDl2Ulg5RHVnZTdkdFlpbzRPcGlyUDcvSFVvZEhMM2ZvTkV1cEtnYy9N?=
 =?utf-8?B?M1piakVqTDJzbEZPYjJWUUVWckFmRFVnSGluRXJGcTFBbkVVWFRXT2h0dHlB?=
 =?utf-8?B?YWY1Y3puWkpycGxyZnVHWTVaMDRhQW5GQ0ZiZVk4ZVZvMVRGVmd0Q3FvMldm?=
 =?utf-8?B?VmoxNmxKbnJFL2o1UXR5SUp4L0E3N0tERElVVnV3c1VFM0ZiaDllWks4cWxv?=
 =?utf-8?B?Z0RLbzAvb3NvL0tMM0VIbjUvVXVWM2lFZjYzRGVuNjhlV284N0dRQVV3ZmVO?=
 =?utf-8?B?aER0Z3QrVXY4eWhKbHllYUxBK0Vxd0JmMWJTRjRlRHhNZmFNQXlJQzlTZ2Vx?=
 =?utf-8?B?b0wyemFITzRjdHNBZUVaRi9EVHR5cDF3aUdPOUtNcGNTNDViVVBicUNnUGhI?=
 =?utf-8?B?ZW4yRlVsMEFUS1liQ0hyTG9oUlBOcUsrK01CWlhYejlyV0dsYXd2c25RYk1O?=
 =?utf-8?B?N0ZMbEJiSDFnS2dqV3N4UWY2WU9aQTNnUXN2Skp0UFNyaWRhaEFoS0NsNThW?=
 =?utf-8?B?T3NPWVloSmloZUVma01PYWN1djZJVGR4VHdFVkV2TlE1ZmlsRXpYaE84N3hM?=
 =?utf-8?B?L1VoeHFZNnN3a2tjbUNYc2RISjNWWG9JaHJNQmhuZ3NMcTMrSDlsTm9pVDNR?=
 =?utf-8?B?UmlzcEh0WHZqWlErSk5ieU1KU1lHcThaMXZKL29SSnFuYldPZGJINTJiOHE3?=
 =?utf-8?B?aFZoa2k0N2svd0J0WU0vZVViTmJZMlJtU2ZaUlR6YWk4T2ovRk1YYWRNVTlt?=
 =?utf-8?B?dWFpNlRxRGpqc2ZWRm9HNU51bFh0SHlSdUZlbnd1ci9wSkhwend1MWdhYi94?=
 =?utf-8?B?L3dPc2U2WTZpcjkzVFkyK21DWkQyZ3RsbkI1cEFCTWsxY25zU0lZK1U3OUQ2?=
 =?utf-8?B?UmFpczdlSE9ySlBDTWtMRlpLM25DQVhNa21JdlpldHBoRHNLUGQxZ2c0eTEw?=
 =?utf-8?B?TFBIVHZOa0E4aDZSbXFlZ2o1eXkvTnNXSVVhcSsvRHQvdDBMeTZaOVNhOXRa?=
 =?utf-8?B?NEFVRW5LR09jZHpoWHZ2ZEZMT3pSa3c5d2l2Z21ua0V2RjR5S2FldU4vOU1T?=
 =?utf-8?B?ZWJhZllvRTFGUU1qU0QwcEJOY2Y4YnhreStkaFlnR3J5bnBGbExvNDREVVM1?=
 =?utf-8?B?SWxVeUlrV1h1WklCejVqazE4RVhPK01tRkdTM005Z3ZwVG1ZRmtWWFF3Zkk3?=
 =?utf-8?B?MVpyNVZIQ29SYzMxVElaaW16VVRqOVl1eVBLeWZySnVOVWdoVWxGaUFSZ1pw?=
 =?utf-8?B?cUpDZGRYSnVYZ0lCemYvNmh2UDMzZjZkYmQrUFQ3eFR0Z2V2dWVqaDlGUTFk?=
 =?utf-8?B?cWVad1crL1YvNlNVK05GTHhIbDZadlNUZTJ0OHd1bUJTQXdLQmo3UUJTTHcw?=
 =?utf-8?B?MHVpOWZ5VWN3OC95aGtPN0luN3hVR25VU3pMRlowY1ZkZDdXblpUa1ZnVzV3?=
 =?utf-8?B?dEdML0VVS1E4VFdCa3QxRXNOREUzWDVNWHBod2Z0S0lxZHExcTZzT3NVTkI0?=
 =?utf-8?B?dC9QQkxzblBlUEJPdjVsVDlmWGZFb2VvcmZoRm5TRjFQbVFUQi9KdTltR1RR?=
 =?utf-8?B?OTNZalY5eVlHcjZXVVdOS2ZxWVh4OWNOSUtabmxzY2pvTEdpNS85K0NFK2JT?=
 =?utf-8?B?OUZPR1BCVXdKSUxBWEJKK085eGpZUTFXaWlXYkFjNmI2M1Fha0VXY1VETXAx?=
 =?utf-8?B?WWpDZUphemp3cEorc1F2L1BmQmR4OHppT3lEQzFMU2Z0aUl3NHV1SlVuc1NN?=
 =?utf-8?B?ckNCcjJteU11R0ovOGJqa1VIZXJNek5FTytMWGlCRE15Q3RQVENTVmRseld6?=
 =?utf-8?B?RzVyY3d0TVdYajF3dXBaK2J1NnpLUzhXcDBJTXBxM3pQWXdTQUNIbS9pRXM0?=
 =?utf-8?B?U2lSTDNmcmZhdXA4UkZGQ2Y3NjQ2MHRvaU91TkRhdTJGRGVtdzF5eUlVMkFv?=
 =?utf-8?B?dUFGUnF2eUtFb1ZYQy8xaGJ4Tzd6bHA0V05LL0FBVU5LdU11R1EwV0ovT0ZT?=
 =?utf-8?B?NXhsMXFwUG1OYWdSZGJBWkQ4ekN0Q0lEWGdvMVR1MTQ0OURTTTFXOFpleDNs?=
 =?utf-8?B?bkhEQUIybnlsQWlSZ1RKRjlndUFwY0pwNndMTXcvNFdkZUdqSHBQSWZ3Wk5S?=
 =?utf-8?B?OThtUVExY0hKZzN3eDRKYVNNUzJ6cThqQ3NVamFHNlJNTDNhMW4yczFYMXZr?=
 =?utf-8?B?VTcvZ0FpTjNlT3orY3V6LzZ5UkpodWJNRE54NCs4RC9NeDBuczRLc1A2emJp?=
 =?utf-8?B?eUdDaExPUFIvbC9iTW9YVUpoR1EyTzNlQ3phS2RCRHBLQTdwTjZNUGk2WnYx?=
 =?utf-8?B?SU02NS92ZXpvREpUbTlhUEY0OW5rR29WNFB2TGpyZkVTSWNFZG9UUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f49034c-ff8e-4ad6-ef69-08dee66ca7ef
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:39:08.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXjlHQqkVPmlwa/WhHYCToxMchufO9b8N2JvWrIs63qjVASV7Gge5D1CDGuSdud49eNL7mkAGvvNTPh41ntO8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB3946

On Mon, Jul 20, 2026 at 04:28:00PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 98e37db4a34d3af3fb2f4648295c25b5e40b20e3
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072000-riveter-snowsuit-903d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'
> 
> 

Hi Greg,

I will handle this shortly.

Kind regards,
-- 
Aaron Tomlin
