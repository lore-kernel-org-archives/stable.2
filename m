Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794838785;
	b=f8WwLHz7566Xnfw+FIRybJe5bS/vK3lsl87Ezm78MkslXgO7kW7lNN4AHA7Zj6Bh7d+w
	 kpBBsN/XubkEsmySjtvA2e6zCnOlgN4lfTBIIpeFXnLNKXmElC3MmLRhJsCeu3x8ve2Ry
	 MJvXyY6P/uT0qAd0SO9vw4cN4eUp01uzn504Esm6qi3CYhG+PFtUY2IC4AXz4AqBxmsPF
	 eKo4gm6KdglA+GXp7VLve23ZBCg8xKR9UUBfNhO5Kb1PUSsQZGGh60geJ9cRDKnc+EIDH
	 bfGjAou33tF70iYE3b0vwVidQxZJkeMHGIgiDmWrk7AWRk+PIjpTO0lJznLhUOLi4Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838785;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=692fYLXXW/IttoQdj6PpgbKpKZgMx47xSGwezkEHYHY=;
	b=Vc0Mzx4iGjktxsR1me4xaka02QIkHPkTs2ni6owdKLwxNVFy2fqNpqG/WXXdyCZhjbhm
	 cwhYiBdqUVzrFpLexESQ4bV8ZZ1Ox3aonR8lKVV1hHJx88roebM5FIIPj6G53JZW6USqd
	 +ZN55fmNzIZQUIsXwPnV+tcAs0t+82wXjDpA64JBGmGueccnP/zPKwZXUnMNIC6rjfvXK
	 qaLPXqsjwPeTjVRDQZmV/zoWo/mtYlLnuesOlkm4FTpEPxQeAVuq3UIWtRKJC4cPLGzCj
	 ELNox7ZbWTAAuPRNnKApGhmtP/oqVL7+Wmyn7VIfPSL+MPU/OC6TqagA+Bv9YyvMTdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Ck5rgcMT;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="imig/YKf";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1B606A32C;
	Mon, 16 Nov 2026 14:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB1B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Ck5rgcMT;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=imig/YKf
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGBxQvc1793680;
	Mon, 16 Nov 2026 09:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=692fYLXXW/IttoQdj6PpgbKpKZgMx47xSGwezkEHYHY=; b=Ck5rgcM
	TjelOXJu+7UEG+pLXzJ6C3mKNj5i95JPvvr8Dgk8bvTDjq2YS8CksPvy052IpB30
	qOOkX8wCpT4VainCs501oFzUhbqq/4h708cHRtOrhARDrWMrk0X5xSLlLG/qEcBB
	KzVmNDVpjCcDMMOV64c3dFN4WgXhmT9XahqKKviyeHkKubl7Y77wMTJAIyA5P30g
	c/j0TGGKXKL8cGlzWtN66g2DahJk5LBlsd1IBKjYMqSO8UJDxVCM2I45sTMbSOUW
	j1s5wP4u02rAZ3VPchGX8ri9tXa92FPeXPHM9jkw53qkrzoRqZu0L0akgsaWCb2M
	GwrgQ7GjClaPfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=692fY
	LXXW/IttoQdj6PpgbKpKZgMx47xSGwezkEHYHY=; b=imig/YKfQSdpdfiasWdEo
	z93D8CHyJlIEqDJocjCP+xApXasD/aF93FPNULSS24IyJypmY5VQ4b8B+yTavfZ7
	fivMQQvT3JsnKVWMgiOLoT0OlU0SV1IfKUkDei6kIyx/XsVYzoPDblXlnAPSozkX
	3BeMa8uaVCOGDywfAQqFy9Ze7t6fGG6NwohnMQSZFwRwrhkAA/iuwxbb0RH/cY6T
	wZGbcgo24RSJlbxaSV5yM8u/vhwGjKxV57p4qxdCZtudQe7uzuDrT8zn9tiQCBwb
	ev+pjGr+ksrDqDGe8lVMpL1qpeEKrZ3SQIwwVhLrJMX1iGy2aIcQ9v4smrwAOqlM
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hyrc8tax1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:19:40 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RljXLqFgowVW4T0rOuPpfWy/94KTMi++VnNNUuimHuHVUaN712CNwvotivA/xXV+NJTMeTxY0uRXQyyMFxspjhOGdAPvPwr9Os6QyrfOzFSUbj3IFqc1UhBTPihwQX9F+2np+NhR2TOkuyukIgYrjdsVFHmAzZRB5qC8ZEUbTjYdgJcNFuxThC75u64hSu6KvyOnVymGjOyqyeRYN6kJRRStslb15PaN5wd6l9xFTvnrXMTN3ZyeoMEDCd4kZmM6aajGWR+SLY2Zfr4QTAe2pLtw67j26Y9vX1yjCkUjXlovb56O2SyDA3y8VZfDViIsD/ZI2XRhzbDQFR3SupdgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=692fYLXXW/IttoQdj6PpgbKpKZgMx47xSGwezkEHYHY=;
 b=n0cUaqhfstMDwiOD3HSU/IyHSXYNf86RAlbuOeqEgBxhu54DsTqpdrRZ/KAlZ1rZ4yXd0PRoiTae2w4OIz3NGlHGFug4utkUC4bxOi9RzfOoTAb4Pfys3v/cPIpBaRNQ2o1WLGRmjY+lz9P8SlpGEq2ikBOCM0uUzStQKREh9gxvnmZ6E1BR4XrioWrqN3VEwNWxiA1gGdUya353f3iQr/P/wfHCNyHizIxEy4CGL+g2F2GViTxZDlJb8mX85ml7ds9vW8tdaGz4MU/mz742iR9DVLnQAP0CZCW6NFU9DjT8IZygLi/WjWauFLtpA8BR1pR8RCmJ9Bp9sBLczpVRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8325.namprd03.prod.outlook.com (2603:10b6:806:45f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:19:38 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:19:38 +0000
Date: Mon, 16 Nov 2026 14:21:05 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: fix bounce buffer use-after-free on
 unregister
Message-ID: <avsQeLMDwrZzF9uY@nsa>
References: <20261106-iio-fix-possible-uaf-v1-1-1bd8b94e771b@analog.com>
 <20261115004100.0effe1e4@jic23-hlaptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261115004100.0effe1e4@jic23-hlaptop>
X-ClientProxiedBy: MR1P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a60c12c-0b99-443d-97ed-08df43eca5c5
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|260925021311599003|260925022911599003|260925021911599003|56012099006|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 0I04hBP9yB2Zmgo21dAW6T7rIpPdUNzV0Q+RsyZBEZl63PBT8M95JIQnMxapCl1cF0SRXQ2yy02jtfFaH6J86j6q0LJ8txI83qbqnZWbV9TWd/EYCWOz0qgirZ3DtKcBihRrt3uU2aOBumPDEHfg7jp+MsEYp06/+Hrx5Y2T4DdbhkTPlWSlk+TRxOZ8YDEmHQxv02m+o7JQMiPaEMDTptn3l7mHOEk7KtRgOjk1u0JtM4PH5P5XqexxYCZJzQOxuFO0OZBZv0vxvco9mQzdBGVDrrwGxeSaOpqG0+1pSdGb7V1ri2OxDliA7+AQjCEErC8zdQ/60uYGVMgFsRkaBd1R0PD9E/Oethv6qYOxDYjyDATvPD2BcxNI9/URqlg0Ht/NmPRZF6U6FG6cqDlfp21522uILSGYxRonc4FcsDuO8GyS1yV+mrYZxJA52rpc95Ay/2jx00tvzFa/fEAcWjhBokpYAWj5S88a/202vz8E98cCFuJER1O+tDVw0eNy8oK9egR5tJ4garmoBLRCrVdokV1UYV5D5uSRm9IfUaK9msWjpezfEmP1/CX0cpBM6vefwJg0KghKMJ0ES8gTFjoHFWE3zcaas2311HojCHH41r1DLv3XjUT+sZzvzAuks1bJYMwJ+XJKPOxkQERpa9pyx+l4mmxOihRgm3rIv04=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cmRRc0Q2MGlDZEJ0NDltOFpHMzQwc21OTmFadHA3Y3RkcUkybDg0NThDNEtC?=
 =?utf-8?B?anR0Qy92Wi9YaGpUNUpyeDlFMm9DT3JwWHhsK3pyc1VjNERQRUFvUDhHajli?=
 =?utf-8?B?aDJRVzZ4L08xOHc3d29zeGFJNHd3K2dseG4wbzFRc0RHRWRodkZhWVFYWXJa?=
 =?utf-8?B?eGFnMjVab3ZUeEU0MnJBeGZtS2VBa1h4VE9zeFpuWTNiZ2tiNDJyWEd5ZWVj?=
 =?utf-8?B?UTN1VHpYMlZ1dWkvSTN1amZuVU9qR1Q2QW5yZGZhRkVzekh0cHZQVVZlWElo?=
 =?utf-8?B?NWZwUDdyQWJNaDZuQlNMMVd4YmI1empnY0hFRGdlYzNPenFKM2l4WkZXcDlh?=
 =?utf-8?B?eGtRZEZnRk95U2dIVVBMUStycHVrODJCSnFHQ1EwQlMwTUZnZ3R2UXF6TTV4?=
 =?utf-8?B?clo5R1VGZU9oQ25SN3pGZ2VBS1dLeEpuMjJtaDJ4ZEZmNU1ZenBPUXVBS0Iz?=
 =?utf-8?B?UzJBcGNCa2JGVXc2MXRRbmFRa0lsOTgrTytzeHpndjRhVytxYkpNT1pMYWtC?=
 =?utf-8?B?YTZqTHpuZU0vREdJSVJQbzJ2NVNtUnZvQm52cHNtQ1pOUVFnZStiMC90Umpj?=
 =?utf-8?B?QVVpRGhobE1CN2lLYjRFZXBZUWFUU1NmbzFYNHlXU0lyQmNVVnh6VFpZL2gy?=
 =?utf-8?B?dnlOS2F4TmdmS2VXQWU1a2Q2cjZRcHFMdVBDbW9KT2QxVmJCUHRmcW1sRm5W?=
 =?utf-8?B?RURqRzI4aVZMbGp6RHRGY1UrYzlBS0hhVTJrUExpZk9BZCtwNVRHakxHRHYw?=
 =?utf-8?B?UXpHdXppZlNWd2ZGQmhuUGN4Y2k4V1dmSHJhdlFSczlVcTJhc1JwR0FnY2hD?=
 =?utf-8?B?UEhhOFBrVHplbGNKYmJVdEpHa3g4UVV6R1ZSQ0J0SEF3YmFBWi9seHY0RUdS?=
 =?utf-8?B?dWF6U010RUptbUdTRVJwWElYSTRRUVluVEtXcVVJZm5HZVVwd0ljR3VZVGhq?=
 =?utf-8?B?UzNaTVNUZlRNbEJPOHducGlOL20wb3IvNDBGYWg0U2k3cER3ZFVlaDVNaktW?=
 =?utf-8?B?NERUNVJ3TnJ5K2pyWlZGWTE5OHJMYUFGa2IxUU9uSmxQZDlwdVVqWmlvRmxV?=
 =?utf-8?B?d25WTTBTM291OFE3VmhYMEM5cnM1VHVsT2pIaXg3Uk9wcGdMNU84RDdHd0NJ?=
 =?utf-8?B?STBMRC9JeGJVNjBiYWFHTUpWV1NCeCtoQWZHM0tkdXpWN1B2SE1LM2h6YzVM?=
 =?utf-8?B?TVp4ZGJFSW92YzNVVXpTeEVNVVRqYVRzWUkzY2ExQWtCOTF4L2dEWU5uWWVL?=
 =?utf-8?B?MW9NOUF1RTYveU1zQmtpWmw3dWxZbitwQnVmL3NLR3VlbUhoelNPRzZhZ3NV?=
 =?utf-8?B?OFVrTlR4anZUbUc3QnZaOEY1ZWViMmRTQitWMUV4TWhhRTBlZ29STE1WckJa?=
 =?utf-8?B?WnREUGpUVXVDcE54aGV2dnJvOHduZGF1ZUNhcGUxUnZ6TngvTWRVOUlaNllL?=
 =?utf-8?B?MUpUaHIzK0I4UitsekNKd1kydm9iN01ZUVQyZDNyYisvOFA2a0N1d3ZYZkJn?=
 =?utf-8?B?K3QzV1M0a3NKeENjd0lkZzBaN09FcVBTZ2Q5YzI1d09HNjVwSTk4UTdTU1l5?=
 =?utf-8?B?MkVhb3BzQU5Xdjdtam56blFIUXNwUG9hMmNoaVJUSUpoc0M1RFNEOEE2UGJD?=
 =?utf-8?B?cVNDT0QycEJuRWJSSTRqOEU2cmZSMEVkWTZYVXZTRS96aFNuVGNXMXhPWDRZ?=
 =?utf-8?B?YTczcCt6UFU5K05wL3pXRjg3aG0raGFhaDR6dWRXNHFTYjFRZ1NCQ21FSUNh?=
 =?utf-8?B?WFhqMDk2N2toSGNvWStZUFNxZE1qZ0ppNXFKcVJma3NQMk5UL1laWDFXYmlG?=
 =?utf-8?B?K0lkMmNIbWZ3eFpmWnNNSnAxMy9ZMmNEWHNVYXlPOWtqelRJMnpiQ1E5Q2xj?=
 =?utf-8?B?dEhEcktGWDJrWFhPVEdPZEJidk9BSmtSczlncHRiQldkZlBBWVY3VGFBQ3RS?=
 =?utf-8?B?M0c2OVR4dU0yamV0YzJWRzFwSnlkZzN3NjBiSGticjBWUkRid3RicHB0QWlH?=
 =?utf-8?B?KzQySnllOFBEUW92TVE5T0x2bW5MTUtEZXk1bjNMNjNiQ0ZTR1NncXVHdFky?=
 =?utf-8?B?Z3JNK2VSdHlqUWhqM0FGWEEwWE54QmY5ejgrM2Y5a21NU1NKd3NDZXR6SU8r?=
 =?utf-8?B?STFXTzJkT1M5VTlRckRNOW5XK25NWDd0R2g2L2pmcWJmdzlIelVyU3M2RWVL?=
 =?utf-8?B?TmFia01RU3FlOEFzSEpUK0dzTmgzSm9zSUVSOGpwR3NJditoV0pXU3lFVW1W?=
 =?utf-8?B?MFdObkRzMkFtdkdETDc1dWxzNVhTR0kyaENHWmVGZEJrTzRvVXVTamtwazhU?=
 =?utf-8?B?REJMRDlRcUhWenZpVHl3VmYzQUFpdnN4aFFhdFJORC9jdEFsUjJ3dz09?=
X-Exchange-RoutingPolicyChecked:
	4jKsUNTo22/bQEKXKryaR8L5jJSA75bcdD3neKL/Q07gT08AoLejSi13cqiO9LWi9Q6qiuye3BLt7U1Pvo89ApYtvC8T2y/hWYFCZwMl1SoSz7cSK07Q1TVAx57tXXY4oDeI9+qMLZU1Bwih12gPYpAY/jok1Gn2ixlT2I6VLaGIhQu5XjgrLB/zYgde2EzfXDDxKwXZYmuUU5K3uH/zWRpoU9Q5yXL8ojgLjILNLq5vmDT5IdpJ79e3iCiZStvAR2/w9135KNe2LeV+Y2GCuWvQd/PBM90e+5DaKCsNz4iePlGtGEBsZxbVlu8BXdQCQQU4P8jBRLYRz1P4v4Revw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a60c12c-0b99-443d-97ed-08df43eca5c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:19:38.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkuqM+6yhOvvMxMPy2lVG+ySo5IjM1RGaNB97abLsyWRKajoQi10fET6lfrTjzEOisoIYikzrDMQHgdPtlXiAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8325
X-Proofpoint-ORIG-GUID: 556SYuzqTT2g9nzQU_QOz7CsgvizmHiW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXwnKzA+pL3CAv
 +jofg5U3D7FWKTw5AgX59/RrVpXGUyoEH42Lh+6vCDgbhDd7QSwOXjinvvtrtLIHIg8ZpTmjTsk
 u3O3tJ1S9JSMdJMzamPkg1DDjQdRI5H/z7kX3DCq3vMAuf+prVjKLZOyr+zGezdGn8V8aaEkvww
 wENNuu2fSdEGW5kZEDsZcEzjj5a0Jz15Kc2lIZRd+a5bhD/c4lEi3fkoNRjlHDl8O3eKhUHC0Or
 73GAk/lOkeXFrL9vVu5+onqheAx0FG3c1Dr6uTatjrhK+YQjTOQ7L0yAQUDLVt0L7BtYIka5JOg
 YREOJEq0WPeNsJna+NF9yEaUV1Cf5O/wgVk9T2BhN7TFZXxhmf/Pudzn106oMbCZPBU/MCRXQji
 1z1KxQsfFiOlDxEvjefzMrYw6IQ6ZJ3z8EVWbIDeTa4RFgLtROqiHcFYJBwdNMDe5U12eTSnWUc
 HTIEQadsQunxI2Wj5RQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXyw040YeliY/9
 6IgqsMB+qqQuMEckccbvcd9igu9WsF8Yo4qmN2gTvS+9YCqJfGPUMUpO84HQkhHyVpx7DV023oH
 IFvbfv+bEFHxS376h6boCFKIu2sf6O4ZNRRZHdEUQrgQ28L7/O7t
X-Proofpoint-GUID: 556SYuzqTT2g9nzQU_QOz7CsgvizmHiW
X-Authority-Analysis: v=2.4 cv=EKCTQFZC c=1 sm=1 tr=0 ts=6afb10fc cx=c_pps
 a=gd7JxMPBqN93mtTmHvcGFw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=vkty-4jWHNCpOqP-rpoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

On Sun, Nov 15, 2026 at 12:41:00AM +0000, Jonathan Cameron wrote:
> On Fri, 06 Nov 2026 16:53:00 +0000
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > The bounce buffer used by iio_push_to_buffers_with_ts_unaligned() is
> > allocated with devm_krealloc() against the IIO device itself. Since
> > commit 699fb50d9903 ("drivers: base: Free devm resources when
> > unregistering a device"), device_del() releases the devres of devices
> > without a bound driver, so the bounce buffer is now freed from
> > cdev_device_del() in iio_device_unregister().
> > 
> > At that point buffering may still be enabled, as
> > iio_disable_all_buffers() only runs afterwards. A trigger handler
> > firing in that window copies the sample into the freed bounce buffer
> > and pushes it to the buffers.
> > 
> > To fix it, allocate the bounce buffer with plain krealloc() and free it
> > in iio_dev_release().
> > 
> > Assisted-by: LLM
> Rules on that changes (again!)
> So dropped it.

My server had some issues to catch up so I replied before seeing you
already replied...

> 
> 
> > Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> I think your analysis is right and even without that we should never
> have been using that device for devm.  So good to clean this up either way!
> 
> Ideally we'd get some testing from someone who actually has a part
> using this helper?  It is rare which is why we probably had not reports
> of this yet (and remove problems only show up sometimes as many users
> never hit that path)

I see this is called in adis16400. Unfortunately that drives fairly old
devices and I have none with me. Might see if someone can get me one but
not sure I'll be lucky.

- Nuno Sá

> 
> Anyhow, I think very low risk and looks good so applied to
> the fixes-togreg branch of iio.git.
> 
> thanks,
> 
> Jonathan
> 
> > ---
> > Found this by accident and do note this is just code inspection. 
> > 
> > I tagged the original commit supporting the bounce_buffer in Fixes: but
> > to be fair, the original commit was fine. Tagging 699fb50d9903 also
> > looks bit odd but maybe it's the real one to blame?
> > ---
> >  drivers/iio/industrialio-buffer.c | 6 ++----
> >  drivers/iio/industrialio-core.c   | 1 +
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 4294101810fd..cc5fde0f5191 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -2464,10 +2464,8 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
> >  	if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {
> >  		void *bb;
> >  
> > -		bb = devm_krealloc(&indio_dev->dev,
> > -				   iio_dev_opaque->bounce_buffer,
> > -				   indio_dev->scan_bytes,
> > -				   GFP_KERNEL | __GFP_ZERO);
> > +		bb = krealloc(iio_dev_opaque->bounce_buffer,
> > +			      indio_dev->scan_bytes, GFP_KERNEL | __GFP_ZERO);
> >  		if (!bb)
> >  			return -ENOMEM;
> >  		iio_dev_opaque->bounce_buffer = bb;
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 825cf7f32059..ed097eb8d799 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1727,6 +1727,7 @@ static void iio_dev_release(struct device *device)
> >  	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
> >  
> >  	ida_free(&iio_ida, iio_dev_opaque->id);
> > +	kfree(iio_dev_opaque->bounce_buffer);
> >  	kfree(iio_dev_opaque);
> >  }
> >  
> > 
> > ---
> > base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
> > change-id: 20261106-iio-fix-possible-uaf-853ce6ff96bc
> > --
> > 
> > Thanks!
> > - Nuno Sá
> > 
> 
