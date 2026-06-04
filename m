Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA5405E7;
	Thu,  4 Jun 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568202; cv=fail; b=UhBPXYhuR/VdilSaPZRWzczSLT2lYQRX/Wwi/R89683uhYw3zTWLpTaOp8RqwS779gZeyoNbn++bWKaErSWMxAulKaMem6GGQ7HNauzKVrhZ5VuLfzo9ZfcCIMc5G3E4wUr9y62LpykeeqFgRmawB6mpsTFqjUMzFwQRHdvE3OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568202; c=relaxed/simple;
	bh=DwQYRUGOp14AOSIZOqb9SOMbyUqeGXUooWvD3RAiB9o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y8vkfv3xhh5H09gJ8WB6gYm+hCxZDYTHhE+CmrBhraUW/DADkxsEXbaUTaC35nLYTEQJI9Pdlcwffym598FMAhB5sclGFkvYWddA47OL4TmAm/JCKyx1Ps3g0ck0S5sZSVG7v7oN6JZtcbACwG0CItb68UVVBEzvcVrEFhGqcIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=lx4q0qad; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="lx4q0qad"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65497cRn2576020;
	Thu, 4 Jun 2026 03:16:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=YeWEconWW
	ny47oUAJ9q7JMbcp3YsluoiHJsDcq7E7X8=; b=lx4q0qadXqLiCOlDXSUHbFQio
	po3+kIQiYh5rS3Yh3t7/WIrGdFj7VLlPYkWv7flDOBcBxN91fInMvg662XAozjFD
	QkuK/S1yFp6BOzx9X3sJujDihHUHEFtUparTk6R5Fapf7+wa0L+7Y1yEcbXiUT3b
	hVpk1nc1G/oR6WRyoU+OSTpfSIBTiLK0cfEeMChMJXfMU3eNs8LlvHXpzykmPepE
	Djfgm/WjBp8NDtcbGUesp2RXa+pjECh0RIbyPBp7OC4IhMHMdv3qsjlQw2YpD/cP
	w+oDZfuDYBD+18Ix1yfhPmdaa+pd81hH1lfjnlghGZzUd/M1i8Fe95p/02Wqw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ek5m3044t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 03:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBAjBp55MeNTIC0ZnTsK2tzqgLnqqvCnE2Qhc4xPpuk1mPknnTu5+e+4SZXwJs06uqi31uR21cYLi+iDVRmuistJ7Dnic2mvBNiSzIMxWb6LiCKCtxWKmD1kOY7rKBlmbJmIIbwIm3GNpIYWkkoQZvjSbWqPh8cCowMYu4mdJybQC6hnG122XAxOrOOl626DwQUpIk1sQTVjlI78L+7hH2XMdHMtCNuG37WQvLvI/LM6wOJa5y7vdzFJrvPmpM+szTgQq+p4jq76Zy3/UefozJ30Sn8vSOKRcdiQJSZEBI/Pzpob18/rQnJw/IAoMxkKroCBO2On1G7bos08UUs0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeWEconWWny47oUAJ9q7JMbcp3YsluoiHJsDcq7E7X8=;
 b=fJ8wHgrrVYr1H4jeutMgsFWIWByAFeT1FqGu1dtDlvTdoH6YZVy19T0ZJTDgK1h366IJRlRyuKQvGCfH4XOD90lrJf6KFMupT8YBkF9ng4QSrXAEJnDys9/ElpxYIOBgPxSOR+fhfMtawA5yD1bmmunqYPR3M0ycXBPjFf+tGJ7FJ3dC5UoceNgmjVhD6M4arQzTqtiFv/P8Ie0Q6CI6lxM5oZFFQ74t7W5YP50Br88re49ax1ylLDnBlPaU22O+DfZcbN5rahPwCrY/AmT88oIAkBxqkL4MsLl7ACuSGASxzjoU2vvZk22kpUXDe+1UhP9mDO9rE34hvO7mEStJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 10:16:08 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::51d:bb3a:29e9:3e68]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::51d:bb3a:29e9:3e68%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:16:08 +0000
From: Bin Lan <bin.lan.cn@windriver.com>
To: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gnoack@google.com, mic@digikod.net,
        Christian Brauner <brauner@kernel.org>, Song Liu <song@kernel.org>,
        Tingmao Wang <m@maowtm.org>, Bin Lan <bin.lan.cn@windriver.com>
Subject: [PATCH 6.6.y] landlock: Fix handling of disconnected directories
Date: Thu,  4 Jun 2026 18:16:18 +0800
Message-ID: <20260604101618.939488-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|MN2PR11MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: f280c0e2-3bc9-4d4e-6664-08dec2224b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014|18002099003|6133799003|3023799007|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	D5sgtGPiCGxcJFenhxoYBAo7wEpvXOD9IbpkJcxdDWgdtcy+0AYHOz5RuS5YG1itGHHGhgddSqB0MAYxaqs2p0YOIENr7WNJcbf2XnSBPMW25sE/r0itZuCw2ZaMTy+DN7Rx//62njzklZO+OrYK69zXH6ARHaEnlgiOOox0LdnO42VYrls59NcYWmPzBhY6hkprJRxJj72qF5eqOKqwNJPZvUPRuu5u1DrUnNVm0X+1QlEpk4lhTnl5WF+Ge4078VY+c1w8YmhlT9MtYvrD/KqpcOdOa1aP7sWP93LhMIdSYG0yJ09X7KUsoV/NZZveYJmz/E0Wmks6jKLqtg+jWLZNCOca7jj8mOz9a1gZU84u2JC1V5i7fFNtmmJA7Xbe3gJ1PLFiRnFijFE3FaJHALzhWsC5k8uwK/5abVxKWCJlI1s6jF6O6g1/Rf/rl9rlF2m9SbUoQlU08NFs9H4qtwJWc/UlpAKWyuxfFyOb+luKdIFO5cjmyKgF9yq00fhUVF798UIs3b6XUo4djdx/tGMMcKmKu9r6pvMCXqqJIoLkVraA22bjw/zdydkOhQ1sNPJlsdIjonZ1Hzrgi6AXLpMp+bDcp1+v8NGJMAAH2mhDlFVEIIRWIknoCTxCEfaU0AHtX2nhMlgbB7YLjqOzbVbff97jQp9iTEfBP5B/5OCoYZcBLDDdeM7Jp3Ier2pAl/EfXkLxGJZbK+5c4iNczA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(18002099003)(6133799003)(3023799007)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1R5NjVWdmNOb2xObUNydjZHNTFOdURwRGlSTmpsUGt3LzNtV1UyN2V2bXVN?=
 =?utf-8?B?eE1hR3NmRTBNU1NqVEJHUzhmUVppOGF1bGdLb3FwVWUyaHNjMXprblRtanp0?=
 =?utf-8?B?bVR6d01ibkZNam9IWXg2ZytGeUFJa0NlNEl4RVZYbXM3NlBuZUY3WEQzQ2I1?=
 =?utf-8?B?ZTBja3FzMHRoVUxOVFZ4ZnF3ZzNKblovbCtTSis1WXBmbTYvbGdIek5IVTdE?=
 =?utf-8?B?VXY5SDRQdmlnN215RmUzYW9vVHVONE15QlQ0TXBkWjFGU1NUcVozck0yeE4v?=
 =?utf-8?B?R2Z3NXRHc0RVakNkaGQ3cFFyYmRYL04zUXpOaitBVW1XSVlGNDV5Yk1Xd0Iy?=
 =?utf-8?B?N0h1SlJjUnpQT2lNbmhuR3NWUDlOc3ZsYXhtcGQxb1pqZGZvTDNCaUhoVlVL?=
 =?utf-8?B?WmpoRFRoOXJOMUQyaVE0TmxkVlR6dSs3YUMzd0gzemFqSmhLVVptTDlrYTQ0?=
 =?utf-8?B?bnp3VnhuV0djYW5Xem9meVVicGFqVGpzbzlDOWlKM21OYXpMRnZsL0dPMzMr?=
 =?utf-8?B?VFdIS2NVQzlqZjFQQnVTUm4raHhHRGtTZmkvMGJuQTVrWTlUVU9mVE9YWFkv?=
 =?utf-8?B?Rm9CSkRTditSbVF3eVpob09xeU0wbVBkUmtsNGFGTWs2TnRrdmR6d0FUOW9P?=
 =?utf-8?B?RE9lTFFUd3VFWjVOWGd6VHIxb3BwUlZ1enpEQVljUnVHZFhpdWNDRVJwb0w0?=
 =?utf-8?B?YXFyRWdSbDVuN01kWFBFbGQ0Zk0wMlJuTVRsMFJkUHorQVVqM0dYVkRyZDh1?=
 =?utf-8?B?R2J6TG5jU3VSeVZOMFZleW83Tnh4d3pLTFo5NG9RWWs3bWhTS2FXUEUrZFly?=
 =?utf-8?B?VGdmT2Zkek9xOUM0cXRpdDJGRGt6ak01TG40MlQxVnB3NHlEc0IyNW4wUyti?=
 =?utf-8?B?Smo5Nnc5V2RsbjJWdlhRdWt1T2s5LzlaU3dJM2E3dHVMRnpiT3BOOFFYazla?=
 =?utf-8?B?RDlmSHNnSkh6RmV1WHdTU0FXRWQ4TGZLcm9RTDQ0dEpaV1QyQjFPSG5TU3JP?=
 =?utf-8?B?OHVPYmxRVXhrT2xTRnlWODRuUDNsTGJyVTNpdE9IK21aWjlsbDFWK21SUHBw?=
 =?utf-8?B?UkhWUFM1bTlqT0U2c0VFa0Y1ZlVhNWs0K3pHcGVRNHAwZG9XQytPOW0yMnVK?=
 =?utf-8?B?Ry83RmFuNURzVXhCZlU4MFJhLzZLU0l5R3ArL3pkSWY3R0N3ZlpMMkFNTnAz?=
 =?utf-8?B?Y1pzc1NFWjYvaGN1UllCZi9RWXdBNFlkMDU5Q05sZks1S01NT25lOURQZlU4?=
 =?utf-8?B?aVNGZGRnbmlrcFFPNnNOOEI3MlJkU0ppK0ZLMjdtdXcvWFFwTXdLcys1Mk1s?=
 =?utf-8?B?Nk1LVS9lN0x2TFY0by9SVW1LUHNjS01ZWURWTldPdGVldFVTc1BHYXV3MGFE?=
 =?utf-8?B?VjRNb3puSVY5WFRZYWNzeVVRV2h1Y1pUelp4a3dlY0tFbUljRzJ0ZWJCQ3I2?=
 =?utf-8?B?MTdIMWpKQUdCWVRZMlpkODJCV2FLdzN4azZpOGVSU1RtQlIveEFxaFhhS1hB?=
 =?utf-8?B?V053dE5UaWJ2OWNLWmF0SkMyQyt1NjJ3M24xVDZ3RzBJZU5nOU9JYktrL0tq?=
 =?utf-8?B?aUtKRzVxK3hVY3djYjdKTVp3U3gzazViN3ZwbkVRTmxkZUJWUHVUeGdmR2tw?=
 =?utf-8?B?T1JmRm0yMklNTDNsTmV3UVVOeWFqQVRMWEdTa3dwNjdPbUFIc1BoM1lmbE4v?=
 =?utf-8?B?Z1BJdnRSL0MrSERCelRld1dFaUhEc1pkZTVmMWl2TjMrRE40emV1a0xnWnRr?=
 =?utf-8?B?QW9wUDdvVS8zK3lWY25BQWJrSnNmQkhmWS93SE9SSlpKd2p4a0lHT2FxVGpp?=
 =?utf-8?B?RU1FMzZhR09pbytkdzNxQWZCMkZQNzNxK1M5SlBXRzhsUUpNMVIwNXRLd2tv?=
 =?utf-8?B?K1JaZXhER016TXNjYm5UM1BWMU1rUzBNUVh3YUVidEpwMzFkWlhaWkNDRnRZ?=
 =?utf-8?B?YVBWcW9QUjN0cm11QnBBT0JTU3YraXBHcStOaFIvK3YrZFpuOENDMjZvYnA4?=
 =?utf-8?B?bTM5UUpzWlEzbElFNWZqbFJhZVhjSnhnNm5PR2FFZjkvTnNkeXp1dlRVUkYx?=
 =?utf-8?B?Ymlyam1wYW9FTkpoNWs2NTFWL3lGZGhZcFZlZy9FOVI5ZTBVVi9Mc2JCVzVK?=
 =?utf-8?B?cXo0YmtzUWExdkhsb1pYdUtldnhYY0VXNkVKd2pjYUlTWFByeTI1dHNkaUtr?=
 =?utf-8?B?cGdFWnluaEl4cnpoYWNadFA3RXZjV2VTeGJKRTFWNC9iUzh4QmJaUWNxNFJB?=
 =?utf-8?B?ZG5XUEtya3Zvekt1WXJiUXp6VlZTZWd1MzZESUNucGVOYVRZNEFScjVzQ2E2?=
 =?utf-8?B?K3VrbHNvdDZCQmpDZkxxNHRlTmRwejJaa3ZTOEozc3BsQmdoNzg3Zz09?=
X-Exchange-RoutingPolicyChecked:
	jLB1LZzq0uoXZIWyt3fxWwjnMyUnyezaLMj5hVjwBYox+FiuYJmdg/wn1ciXnP0X6e7wH45K1NYCaPao6gUngFg4Fa4+bIwwx0rnI/c9o1pI8zen9UQkVDHXIfd0ICN8mC0Q1vP5XwkYTTEzKLErq80RDy29acYEW44qBGgTN1hj2wnwGsrbsaCMhucgoUwflmIIxwpj3gmzWSTaCOw8VMupte4ZLLMPjNZhFmXJLUC7UpsCg4mfXNYYMcKCkFgzjPr3q9lu89SwXtMhw1wznxBCFVeIzWme8+veQ02cvI2aPsdmEnAnUCZYLPxrK+CxEx2sn+e2b7cpRFkXWX5DQw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f280c0e2-3bc9-4d4e-6664-08dec2224b61
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:16:08.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26TzyRJfUmPcjVSGIAOpQOk48k4GEM2U1RTzLirse4o/WL1ceCBTktqniLUHg/CGJo8/TApmBD0rGIpdt3MaZrZp/qLHDqkVGC3lN22XX5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5OSBTYWx0ZWRfXxFCXj1peIUYw
 rhpjwq+UIZyq2CQtt701lrLPmu93jXPEiln6zHDgi2y0So3QfRRoCa65ko/fWcHMYZZMwhK4OkG
 Py8VItbWYO45LJcZFNuxHPu9NQS92GTec4RJUPKqPfjttx2/ZrN1zNrwyhr4ZTYmruYQ57GhyFY
 MJoRSOGasW3pZAsD66+M4HCM3KlRePHfVfcRWu1SpSn881EqNvFMZ5SF881uYnRBiIGhr41NnpI
 vAgkR1PPjie9jXD914yiCD3jFc7llggPXyHDinTKv2DjNZ0rTC839mI9D0ZPEDMn6aThy4S1/Qj
 L0tmJD7/WJFtbnDdfWD7fA1XjX5NbXaGYVz8LeEO7i0acCSPfOZsvPbbrawSZp8XAR5EPQXiWfK
 WTCASEyMf61luy0MY8P26cmak/XvzeXZUX9YKuzsjUoC+wLOpTzguhpqeT5RtgBKX2uQpouN6Wh
 Kthn6CEyreCOdXkp8hQ==
X-Proofpoint-GUID: SpPSc6GSN3PwUawo9cVPbJJiyNqLiaWl
X-Proofpoint-ORIG-GUID: SpPSc6GSN3PwUawo9cVPbJJiyNqLiaWl
X-Authority-Analysis: v=2.4 cv=CPsamxrD c=1 sm=1 tr=0 ts=6a21506c cx=c_pps
 a=GpEVYLJYGEqcjCz3zNP7Sw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=VwQbUJbxAAAA:8 a=NxYbweiWAAAA:8 a=edGIuiaXAAAA:8 a=1XWaLZrsAAAA:8
 a=t7CeM3EgAAAA:8 a=fmEbUGbFIR8ilvkB_wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=m8HnLGj7c6ka2gUKDros:22 a=4kyDAASA-Eebq_PzFVE6:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040099

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit 49c9e09d961025b22e61ef9ad56aa1c21b6ce2f1 ]

Disconnected files or directories can appear when they are visible and
opened from a bind mount, but have been renamed or moved from the source
of the bind mount in a way that makes them inaccessible from the mount
point (i.e. out of scope).

Previously, access rights tied to files or directories opened through a
disconnected directory were collected by walking the related hierarchy
down to the root of the filesystem, without taking into account the
mount point because it couldn't be found. This could lead to
inconsistent access results, potential access right widening, and
hard-to-debug renames, especially since such paths cannot be printed.

For a sandboxed task to create a disconnected directory, it needs to
have write access (i.e. FS_MAKE_REG, FS_REMOVE_FILE, and FS_REFER) to
the underlying source of the bind mount, and read access to the related
mount point.   Because a sandboxed task cannot acquire more access
rights than those defined by its Landlock domain, this could lead to
inconsistent access rights due to missing permissions that should be
inherited from the mount point hierarchy, while inheriting permissions
from the filesystem hierarchy hidden by this mount point instead.

Landlock now handles files and directories opened from disconnected
directories by taking into account the filesystem hierarchy when the
mount point is not found in the hierarchy walk, and also always taking
into account the mount point from which these disconnected directories
were opened.  This ensures that a rename is not allowed if it would
widen access rights [1].

The rationale is that, even if disconnected hierarchies might not be
visible or accessible to a sandboxed task, relying on the collected
access rights from them improves the guarantee that access rights will
not be widened during a rename because of the access right comparison
between the source and the destination (see LANDLOCK_ACCESS_FS_REFER).
It may look like this would grant more access on disconnected files and
directories, but the security policies are always enforced for all the
evaluated hierarchies.  This new behavior should be less surprising to
users and safer from an access control perspective.

Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
fix the related comment.

Because opened files have their access rights stored in the related file
security properties, there is no impact for disconnected or unlinked
files.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Reported-by: Tingmao Wang <m@maowtm.org>
Closes: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org
Closes: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Link: https://lore.kernel.org/r/b0f46246-f2c5-42ca-93ce-0d629702a987@maowtm.org [1]
Reviewed-by: Tingmao Wang <m@maowtm.org>
Link: https://lore.kernel.org/r/20251128172200.760753-2-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
[ Adjust context ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
Backport Notes:

Context Differences from Upstream. The patch applies cleanly with minor
context adjustments:

1. is_access_to_paths_allowed() (fs.c):
   - Upstream: function at line ~910; pre-image uses if/break pattern:
       if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
           allowed_parent1 = true;
           allowed_parent2 = true;
       }
       break;
   - 6.6.y: function at line ~616; pre-image uses combined assignment:
       allowed_parent1 = allowed_parent2 =
           !!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
       break;
   Both are replaced with the same new logic (split into MNT_INTERNAL
   allow+break vs. continue-from-mnt_root for disconnected case).

2. collect_domain_accesses() (fs.c):
   - Upstream: at line ~1063
   - 6.6.y: at line ~759
   Same logical change (WARN_ON_ONCE removal, comment update), no conflict.

3. security/landlock/errata/abi-1.h:
   - New file, applies cleanly as-is.

Tested on x86_64 with kernel 6.6.140-yocto-standard:

1. Landlock selftests (tools/testing/selftests/landlock/):
   - base_test:    9/9  passed
   - ptrace_test:  8/8  passed
   - fs_test:      107/107 passed (5 skipped - hostfs not available)

2. Dedicated disconnected directory reproducer:
   - Read file through disconnected directory fd: PASS
   - Rename within disconnected directory (no WARN_ON_ONCE): PASS
   - Parent directory inaccessible from disconnected path: PASS (ENOENT)

3. dmesg: No kernel warnings triggered.

---
 security/landlock/errata/abi-1.h | 16 +++++++++++++
 security/landlock/fs.c           | 40 +++++++++++++++++++++++---------
 2 files changed, 45 insertions(+), 11 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
new file mode 100644
index 000000000000..e8a2bff2e5b6
--- /dev/null
+++ b/security/landlock/errata/abi-1.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: erratum_3
+ *
+ * Erratum 3: Disconnected directory handling
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue with disconnected directories that occur when a
+ * directory is moved outside the scope of a bind mount.  The change ensures
+ * that evaluated access rights include both those from the disconnected file
+ * hierarchy down to its filesystem root and those from the related mount point
+ * hierarchy.  This prevents access right widening through rename or link
+ * actions.
+ */
+LANDLOCK_ERRATUM(3)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fe4622d88eb1..7145162f1e59 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -616,19 +616,31 @@ static bool is_access_to_paths_allowed(
 				break;
 			}
 		}
+
 		if (unlikely(IS_ROOT(walker_path.dentry))) {
+			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
+				/*
+				 * Stops and allows access when reaching disconnected root
+				 * directories that are part of internal filesystems (e.g. nsfs,
+				 * which is reachable through /proc/<pid>/ns/<namespace>).
+				 */
+				allowed_parent1 = true;
+				allowed_parent2 = true;
+				break;
+			}
+
 			/*
-			 * Stops at disconnected root directories.  Only allows
-			 * access to internal filesystems (e.g. nsfs, which is
-			 * reachable through /proc/<pid>/ns/<namespace>).
+			 * We reached a disconnected root directory from a bind mount.
+			 * Let's continue the walk with the mount point we missed.
 			 */
-			allowed_parent1 = allowed_parent2 =
-				!!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
-			break;
+			dput(walker_path.dentry);
+			walker_path.dentry = walker_path.mnt->mnt_root;
+			dget(walker_path.dentry);
+		} else {
+			parent_dentry = dget_parent(walker_path.dentry);
+			dput(walker_path.dentry);
+			walker_path.dentry = parent_dentry;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
 	}
 	path_put(&walker_path);
 
@@ -705,6 +717,9 @@ static inline access_mask_t maybe_remove(const struct dentry *const dentry)
  * file.  While walking from @dir to @mnt_root, we record all the domain's
  * allowed accesses in @layer_masks_dom.
  *
+ * Because of disconnected directories, this walk may not reach @mnt_dir.  In
+ * this case, the walk will continue to @mnt_dir after this call.
+ *
  * This is similar to is_access_to_paths_allowed() but much simpler because it
  * only handles walking on the same mount point and only checks one set of
  * accesses.
@@ -744,8 +759,11 @@ static bool collect_domain_accesses(
 			break;
 		}
 
-		/* We should not reach a root other than @mnt_root. */
-		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
+		/*
+		 * Stops at the mount point or the filesystem root for a disconnected
+		 * directory.
+		 */
+		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
 			break;
 
 		parent_dentry = dget_parent(dir);
-- 
2.43.0

