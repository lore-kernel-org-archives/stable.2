Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AA4FD7A7;
	Tue, 13 Oct 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894564; cv=fail; b=BVORa704wzXM4RLVP26IhDr/TNGNNbLky2ZJG3vRew3GQ5FAqy9yi0G11OngIDDD9IXgchixNQkLShabcL+GOC91BKg1DIWIA1YNBbF6iKNoniKg47Xk6ZYQtcrHzimF9ZhRuUrh5LCm97E4XTpkchyRxC44MmRFuMkEh4WPWt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894564; c=relaxed/simple;
	bh=HMk7qZ47Xn9y0G3k7RUknC9vErzHL70SIaA2FUemgb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Beh8P1TcGFfdyLdsgB3BJGMcO5k5BqV7rmkTslBUllK0YVtUP7UjQhrz6IO2iHNkgSRzl/Lk8f0irGshVoQteWD2zB1S/4n9GKMPRII6+mlGishfd2+yZh8q5GMsOucWZSKNcLSO65Uw+OpazI3kSP5oqBkdiTREu4HyF1iJ074=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=NCvuzc0u; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zY1i3mHY; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="NCvuzc0u";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zY1i3mHY"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DAOkCX787899;
	Tue, 13 Oct 2026 08:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=VqS5HeWaf2UZ32mo4+pXkUbmjj8TA8pIDsNK01qdyvU=; b=NCvuzc0
	uGK8QC4FsAWG+bxY1NGmDcHd2CALYwNL9Qts9Rei3E/jNtUpbVODET3wH1jnMD+y
	ZNHpUuUXDerFqb5AKAqTLMH2vfJ1IxBe3lfqr835jmy7Ddnd2u/G1QbpxaVFUeAl
	ur5oKR8vuLMbOyXShfHVfir/kEF5PGrNdZ7F+DrIEZmOHBDhCfhTuACTG0aCgxwV
	A8ENKUfm4bXCYoS71halX19ZaPs31KTymcq3YeDE/IJ7Qix8J4+HzkYuucj86ijh
	nbp+siRXe0YfnSmhC32H4vY5xSHoXjwdzt7JiomuAlZ6qKXsnuxLeXvmH375+016
	k3Vt6R+CrXhtBPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VqS5H
	eWaf2UZ32mo4+pXkUbmjj8TA8pIDsNK01qdyvU=; b=zY1i3mHYdKVDLsi210DO8
	OvdEVW/ASRZA9praMGA4CZ7fRkzD327nu3N+kEsDaLABMthx784ySaUPpUwRaJmR
	6DZEEutTslWY6rx9UFlfXBtg3zg3axU+xiWPjEoomRgBCLGvUDRYxJEajcgcmNRE
	ZV9cW1Axnof2xP8+I3SGP9v4nro+m19IxbKkKlwPn98In1QRiX7fZQcnaABUjWo0
	QW3V7NWGRpDVywf7XotptxYYiEqeIRmC98Q4rW7YDIV32cLUmiulV2RH6HkZ96kh
	6BXn27YTtOFofT1SKIWlHZ5l2/vH8j5HnZQ5ro7AwOwE+AkOgyFP9rAaJa7Kuh9m
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h90m16ntt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 08:29:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVvoi+q+LlqmNDBAyRx4p/EDWrCJhUk69pgbCgLkPreJs3UGPvjwkp4Y6L2QszFBCOKSkyRNBHiU8fChkJbo22h7d6emOJrPfLGKSaZXgFz57g6A6bAYiXaycnAb75baJFWbzDBsfEsy80y87nO7P+wTFM1O36S4NbxnT3n62TYqUx+h6G3JpWLKQAlGlYrg6CBg8IyFpO+ymfS08RtrdAtQkr2zXEC429tyafblj/bXIk86wziL7KJB5MbDz+o0W7stw3iYj41nK21Op31099wgBvJppZTOfCl/tWg3EJJbyIQXd5kEvmbzd1rig0Ab6Wy1vmly9DCuSpfL+czaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqS5HeWaf2UZ32mo4+pXkUbmjj8TA8pIDsNK01qdyvU=;
 b=UQ1eXEUy+ilDqTCxZki1DiQTIx2ESn+qY852sUIiedwT4JCnN7LpB9NUEPJ9v4tcLTYZBKq8ylJjwa0lQ91A44GDiz+3xyymFTr45yUsuLu0HkoOeYsyeTUWe11C2roYNIPIX8d+mYXuNhDJHmK+n+WGdMLn5vdzTTP6ZJJhtLXbLxCIEAFoAK4HCq3AE8zC+BGJ2sFdzjX+j1wRXXj2MsC/DHcqiZaZxUIw3ScbWwfXWE9oiKxWfxAr7mrP3bpnGuE6TBeetYEDEojf0KFvvYWW6RC4NeSTClMD+xJ7JlV/syRhkicgAFZmcwH75FyCaRe8ZYr1cwBChXKPOXzzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN2PR03MB5102.namprd03.prod.outlook.com (2603:10b6:208:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 12:29:17 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 12:29:16 +0000
Date: Tue, 13 Oct 2026 13:30:32 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dingisoul <dingiso.kernel@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: add missing trigger cleanup on remove
Message-ID: <as4jIPWKMKIo5Di2@nsa>
References: <20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com>
 <20261011191240.5a2ba4f7@systembl0wer>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011191240.5a2ba4f7@systembl0wer>
X-ClientProxiedBy: MA3P292CA0062.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::18) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN2PR03MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: 253a4437-d8fe-419a-e902-08df29259530
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009223027099003|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 oMkfOoobs2xHycogasq8Oi/h7p45hpdtfFk+kVuf28GENaFUbqQPLeR0feftVxR7VckHBD4ft07FdX7Cv9MkSjuhsFwna2CwviyK5mXrKU5A1R5yyRzljwh7barPfUKIgaILIEuPkgmO0trBmGhnYJWM5y3VE2kM4lMFfZaAvS73pfS0Z6yGzI2Hm+A0SoBqSzJCntH3lrOtX6bJcxqpldAqcF+n6CUHJ/wUI4zhKTKbtB8Am9lDN6rlhEsaG66eszgwod/QjQitcvRNgdN1vmjgK3EzUItarAn54ws/uI9uCKGV5veUYBZqghKvPfHzRBBmh7oeraHqssljKfnT4k7uJral0Led+y97Hg0rXnir6uOk/u8mtlVl/l94dTCIPd8T8ebVood39QSLtb7sKEna9wrUYYUzjRwNjsuRqXYzRfA5xc52GqwIQc3D3CbSizOGp1tDWMWyfPwcyA0ASBhKsttBFSTLyPg9RrK3d2cgQanj2nYFbTaaWaKm5Xia4lyAWiWTwNyp5fcyUMzXoIdxQV1N/0lbnYAhcZZCRKN+UbfyZvCdpqWJiTjzd6BJ7t3N/lR3O2r/akKrZxylMCQ0DOWmDFlzkAqSL58RZ7XTlQuK24kHz32IZNo6ntYxfpzXLal+VLIHXwPVEp7BrXyZ+UBJOsd5N1Gk/EpGOJ4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009223027099003)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UE5BRnl0YnE3eHBVM1dkUXg3KzFOc3RFSGJVbHBtak9DbDRmZjNGODVVWnNR?=
 =?utf-8?B?c1VrVGNJVC9YKzZGZTdzUXhDUEFjU2VWUFVmMTlyeXh1VVFEQmphZTB6TEhl?=
 =?utf-8?B?MU12aTN2OGVWaDZoU3BzaCtldnE3SGJrRDU1UXN4ZkJRYTF4VFFvTURhMkxH?=
 =?utf-8?B?dkRSUTN0ZU5qKzA2Y0l4NEhzV2J3ZkxKdDRpcHg4V2hYM1pLVGxFWjd6MjJT?=
 =?utf-8?B?NUkrWXRsUjVzeUtjMEdZRDMwR0I2WEJMRVA2eDZ0NnNCUy9BZ0lFN0t6UEZT?=
 =?utf-8?B?TitMOWtiTkFmNHFkYml4bVFSb09EQUVVUkpOcGJJMXVEbVNvNTRmTkZSWDhs?=
 =?utf-8?B?eVhUOU5LdHpUK2kyUjAyWnF6bkxiV0MxN0gyYkFYMkZzVTArenFQOCtWUlBV?=
 =?utf-8?B?STNXYlZmRnFGc1hRVmNtaTUrQ094NnZVMEs0Rzc4RFY1dCs4STlHanlhS0Rk?=
 =?utf-8?B?NzNGMGc5OEZTVGhYT1ZwT1YxTTVOSmJqdjB2VExpNkhGVXBZUU56VEtoK1dD?=
 =?utf-8?B?NlNFSjVPYnA3TFJ4RXFOSllHZkxvQTR5REZZSTdPM3pZSUtudmQ0YW1GOEUx?=
 =?utf-8?B?MFhKZzJzN0ZIdUUvVFJKckQzeGNsa0tweUVUYWJHc0EzQnFHdWJXRGZ6QW9M?=
 =?utf-8?B?akUvNE5EZW9VYTB3NlBBeXlvTHVQVWEycFVuTlkrRThFbjd0VTlIcm8yNjgv?=
 =?utf-8?B?cjBURWsvdkJRWDZQV1Q4RW1OT3lML0QwbjRaN2YyamRoZzZ6Ri85STA5b0dJ?=
 =?utf-8?B?c1ZVSEFHYkpma3RrT0x2R21mSEFLdWYwaGhvejA2Q1JiVXArMVVhMDBwODhD?=
 =?utf-8?B?UnYyWGthcFhqa2ZaaExya0lHMzBlTUNiRU85dWtZd2hMaTkzek5QT0F5SFNm?=
 =?utf-8?B?NkdtMTRwaTVYUWxqWHhwSjNmRXE3dnlDS2NFU0dkOTg5SzdrSU4xaElPZllr?=
 =?utf-8?B?alBJWXd0RDlKNVJBeUJPRTRNOG1hQ2VkSjhuU0JZbUJuVjNobkc2aUNWc0tT?=
 =?utf-8?B?bTNrVW5DSGxNclorN2FobzNOVG9HbFRUTkdCcHFXWTVzbTRqbk41Z2hxR3Z4?=
 =?utf-8?B?VEJqNTYvVTU0L25ZdzhIN001RWVrZUlud0dBWUU0ekY5MTY4MzZNTFRNVnJx?=
 =?utf-8?B?d1ZmMGlaeHlweDZqb0tPaVB4bEJMYlRsUXkrVkpZMnFNUVNXUkh2LzhVNFZ0?=
 =?utf-8?B?cWQwbDZlcnhKR0JsK1Z5N1VXUXc0YmkrVXJtem5Ha1hIK2N2cnB4enYvenpQ?=
 =?utf-8?B?MUhOOGpJV3JjMHBjckFCaWw0d0VxMGJyNVI4VkVpckFmbUs1ZldMWlVPQkl0?=
 =?utf-8?B?OEVHOGlScnpac1Nua2dqWDVMaU9OQlFqbCs1TURnMjlORjVmbVYxeUg5SUVB?=
 =?utf-8?B?TXRJT1d2dElHZ1BDa0lUNTJrTU5qTXc0R0Q2NU52Z0s3M0ZnWmdSSWVmeURJ?=
 =?utf-8?B?TUVHMlJUU01zVEVGY2QrcS8ydnBGVUtaZ0hZc0xyNisrQjkxdVN4UXZ3Mkw1?=
 =?utf-8?B?WEJ1YlMvMTJVZlVFWUlsZzZ5OWtDTW9nNTNsRktkNXdKU01hcEY3ZWZsRzc5?=
 =?utf-8?B?UmVIbEFzWjJWNHdWRnFuU1RjS2k0dWlwdUpCcGVseklrcnRiaC9MM3ZURzUx?=
 =?utf-8?B?bC90dzBSWXo0TVQ0alVYVjNncmtlRnR1YU9qNUtHbllYYjVpdTJKL2I4WVpS?=
 =?utf-8?B?OGFUU3BIZUFHQVl5Q1laYlBGb3lsSFdIbkdMYWZibnNIdm83bktwSUNTd2pn?=
 =?utf-8?B?TG9XRnJtZWNnVDN0VDY4TVpweDNEQ2ZNNUp1V3A4UUtva1l2OE1JVGRXVWVs?=
 =?utf-8?B?QWR2ODhlVXk2SUQxZFZhVUx2d1MzYVNUa0pxQzNMd0tBSVFIUlczdmN6eWFT?=
 =?utf-8?B?aWxyc2tOa3FJSXdpMFZvcUxncGpuMzJMS2ZPOUNMWDVvbU1Tdm1JanY2M2Ev?=
 =?utf-8?B?UkszZWNnaHJyZ25OYlQ0MjdxK0lrVHRDOTJkcFlDNzBCOFg0ZzB4SGNDTEJR?=
 =?utf-8?B?RlM3SDdSQUZ6MGhzZVNkdTdzWUJlS0s1Q1d2MndlbkZoZzBFRnROaXBrZ2JN?=
 =?utf-8?B?Q1dkR2lPNmdKbzBGTFdVVFc1bUNOQXdmTzQ5OTRiaW1qWTBMOWgrNE9wbDFp?=
 =?utf-8?B?REpCVFBqWmhoZDkxLzRJRkZ1SXZDUnBIa09mOExGd3I2VHBFdWlFQUJTTG8r?=
 =?utf-8?B?UmpXNUx3N1pZZEdzcGhSYnp0ckhwcE5NVDJJMU5FYk9OTHJwM25WdmxybTZH?=
 =?utf-8?B?bDhYL3crbnZuSVFmUWZJS2ZVTU42ZGRreVd4eGFUN0gzNWp5VS9oWmRxbkFO?=
 =?utf-8?B?K3crbkkzZ2lvVmd1VDRWUjdOd09Rb0cvQXZTTDZCWmxzZGNXT0V2Zz09?=
X-Exchange-RoutingPolicyChecked:
	AVZ/lKtFzLcUhFjpXLeFyMdOUCVOJr+ZL2wo3W347gsVqAliFzpXeZ9ZFqe1FyIoZo6o7qoPmpWunFTvDXSJkF57+/heISyQAfOY2rp9HOHvU3MlpyEKyqA+lM4gTphxJwv32ARJkkoieE/RUGVuHDX4j4iZmnBvLNDbEf1enHFNcOywXNhgbhodh5bCmvAIXiw2obov3OLmO+O25kJ82oPWVTOcYWRVZCDAiUxUyAyVvkQ5QR3/hXH1/L6le1VKrbb8AqhWwPX8UwNXVOF9b1fa3MfJmfMMjFoNWg2crTvUQQeJmZ5KhIO0EvcXi4r+1rx2IGZEa/WjwL1F2+NakA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253a4437-d8fe-419a-e902-08df29259530
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:29:16.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuO9U3zQtcE2/hkqWOrOV+DYFc8lU+k277X7RU9pjQ9YX1wcj/I5WLiuYbkRWNBO1/c29ebKs/Fyx88uZB7Dsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5102
X-Proofpoint-GUID: Y_mLd7w_DwXHC6lDtCRFTShHFyJzRXUs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX55xgdEgH36fZ
 CMspNTWvw+MhGeP8QmpdRGQqhgZaOlBNvJu7Sw7WXWn5C5tXoiAQirk3Mc5i9aaoNQcXR9LSlsX
 dgqEio+xh2GfGtCgOpRch7FZKHPyGYIoZlwl+VyZs/3SbFkyl9x6T36Mw8dUQk3OBH0X3f+cPu/
 JmLX6s1I9et1m1HYMYCXcxoiR1W9w9oXT26HC8qq4Hc+47znXw0D8RH38xa3uxRnCvVLDM4+eUx
 tijB7OPS4vmSw7IQbj3WBTOfKp0HB2GA/MWaBt/2D8Brc/VnFHRTRPXK6/ab6//WcQz/u9g//CG
 YMy4IDSsaenPho+ra+Wur4W2XlAPZKNvd4xUxzo6RA3nzS62B5ob2mhYDcbxMNaW5Adpy3xreXp
 SVLRaI3XziRB+IowLNDA8aa/I7k2V6nsDlqa75vDbhJ/IPIwIgfH5dBueLN5cLA0CWPCUrvb7+G
 nIOt1TxBgql07HMF9yA==
X-Authority-Analysis: v=2.4 cv=YLkKWhGx c=1 sm=1 tr=0 ts=6ace241f cx=c_pps
 a=zi9RuwRnjJAIHZVcFFhnlA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=pGLkceISAAAA:8 a=orx8GpCejyvyBGI3xv4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y_mLd7w_DwXHC6lDtCRFTShHFyJzRXUs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX/zJA87IwiG0Q
 ENaIvFCHXAM6633n/3xE1bsFAgAtrvMdlfXJS/hx6CuOILZlLz9Tc+uDnzFVH7ncJa2L/du/9E9
 yfwtBRf9PVdIhHZz0LIGf7dT9jQzBYg8QvSc9U+VRqQIw888xAuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130049

On Sun, Oct 11, 2026 at 07:12:40PM +0200, Joshua Crofts wrote:
> On Sun, 11 Oct 2026 17:53:01 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >  drivers/iio/gyro/mpu3050-core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> 
> Sashiko review came back and the issue doesn't seem so
> straight-forward. I'll probably introduce a local pointer
> and then assign it to the mpu3050 data struct.

Hmm the probe seems a mess of mixed devm with manual cleanup. Ideally we
would move all of it managed resources (and that would fix the issue).
Other than that, seems to me we have two things in play. First:

if (irq) {
	ret = mpu3050_trigger_probe(indio_dev, irq);
	if (ret)
		dev_err(dev, "failed to register trigger\n");
}

Do we really want to ignore the error? I would say no... 
So, if we change the above to not ignore errors, we can assume that, on
success, our trigger was registered. Which means that on the if (irq) at
the errir patch we could unregister the trigger. Not that pretty but 
consistent with what we have :).

If someone has the HW, moving this into devm would probably be the
better approach (but even in that case, we might want the simple fix
first for backporting).

- Nuno Sá

> 
> Attaching Sashiko review below.
> 
> > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> > index 07c0f9011c63..096fd0dc608e 100644
> > --- a/drivers/iio/gyro/mpu3050-core.c
> > +++ b/drivers/iio/gyro/mpu3050-core.c
> > @@ -1260,6 +1260,8 @@ int mpu3050_common_probe(struct device *dev,
> >  	pm_runtime_get_sync(dev);
> >  	pm_runtime_put_noidle(dev);
> >  	pm_runtime_disable(dev);
> > +	if (mpu3050->trig)
> > +		iio_trigger_unregister(mpu3050->trig);
> 
> 
> Does this unconditionally unregister a trigger that may not have been
> successfully registered?
> 
> If mpu3050_trigger_probe() fails (for example, if request_threaded_irq()
> fails), mpu3050->trig is allocated via devm_iio_trigger_alloc() but it will
> never have successfully completed iio_trigger_register().
> 
> mpu3050_common_probe() catches that error, logs "failed to register trigger",
> and continues. If a subsequent step like iio_device_register() fails, this
> code will call iio_trigger_unregister() on the uninitialized trigger.
> 
> Because the trigger was never registered via iio_trigger_register(),
> iio_trigger_unregister() will call device_del() on a device that was never
> added, and ida_free() on an unallocated ID, which can lead to a crash.
> 
> >  	if (irq)
> >  		free_irq(mpu3050->irq, mpu3050->trig);
> >  	iio_triggered_buffer_cleanup(indio_dev);
> > @@ -1278,6 +1280,8 @@ void mpu3050_common_remove(struct device *dev)
> >  	pm_runtime_get_sync(dev);
> >  	pm_runtime_put_noidle(dev);
> >  	pm_runtime_disable(dev);
> > +	if (mpu3050->trig)
> > +		iio_trigger_unregister(mpu3050->trig);
> 
> Can this cause a kernel crash during normal driver teardown if the trigger
> probe originally failed?
> 
> Similar to the probe error path above, if mpu3050_trigger_probe() failed
> during initialization, mpu3050->trig is left allocated but unregistered.
> 
> Calling iio_trigger_unregister() here on that uninitialized trigger will
> cause the same teardown issues during driver removal.
> 
> -- 
> Kind regards,
> Joshua Crofts
