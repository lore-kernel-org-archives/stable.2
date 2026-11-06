Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793970051;
	b=thg51HKee/2qq9TOdPww+WkzrD2LTZPR85ABu2BvnkdQIrmFsJipWCnkh4cCTvdbXcDo
	 e3fPjbEc8LRkkKZRF/lUqtYjQuz0X+qE+7tZTDOczjZLf045aG5wm3BawQ4Xb1t3xGdz5
	 l3pAZ6wKIMISk76URqK7ppdJNqVhU0tl8npubCQZXCu+ZDWauyoHq8RFsdgf8XBEgc2ih
	 LUcTbJ8Vz6rAx06KABmP5KNLNruq1t07e++ZLE+tztbURgw0irwFCayoKObe6HPwKf27t
	 eAlK0yW+o25JpM6Q2RY6sqSXLOeVYKO84MhM7SP94UdfoX0gISltxZfbjUbRbpe4n4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970051;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ugEg2CgEldPz3rLxkStboYnwJox//NiUHJP/ZKQXe6M=;
	b=SUT28ZXGGDZBuYK3MHkvkswMDAdfGNJDSC2ovefOpUi4bV6FdgE1BiPaM7xrhCv0zcw8
	 QrYTxsm9IBIQTtVq5Rm7MyMbXWydRg1Yg6K9yUhKoMosNJOy0KjhOZo4HFBMDv+EEswUZ
	 xowAOiRUsNiGsEjGPHlIK7sCGf4N0QYSPaVjZu4BIc+dmbA54nlt7th47sVceuzcve+Z5
	 vg83zSqnk02fXltXYtRlkYo3qU/0LFKZrc2mTPDIsRAzTn8KxwiRDw4DK6RYT7kzBDsUm
	 x7KubKqhozyiCvtLurRJe9Rasa9ydGKzIbq+LHoUqZ2TFWX3m7uzl9F0coBupPe0Fhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BYgvfPLc;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CSM6TQqe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08F606A329;
	Fri,  6 Nov 2026 13:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB08F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BYgvfPLc;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CSM6TQqe
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AQK4H2477158;
	Fri, 6 Nov 2026 08:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ugEg2CgEldPz3rLxkStboYnwJox//NiUHJP/ZKQXe6M=; b=BYgvfPL
	c/xN02NKm9gP0EWG+1uX04B57QOIzmaOqgrUXjy24JOzcfTJIx0+S/WU168KGuMp
	m1O5+e7SHE0JXWfUGQ24ExBI8UCmGBKJFD2UPZNlscsDR1uMHMFc4HQnLDr9CgZK
	xfjUNdElPyOn65KbminUZorZxK1YdtyJCpB3HXI1UzOiiRy6NWTvAKxXmk1cAcsy
	Zi9Q5pePup2MOI+BE2C9Eqtis02RVspQ6atuJWwDMT8g/UjCuMqHUl2LqfJTlM74
	wdKKbmaAh9ciVfIx4DrhvhX7FvBdqBllB5eGe+H3OCrRRnEp5N8iE6gZIwmi5a1F
	16nBNYN4jpHyU7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ugEg2
	CgEldPz3rLxkStboYnwJox//NiUHJP/ZKQXe6M=; b=CSM6TQqewNHBv1bWaO/ax
	+L1gYvgIwiURsecIpENJrQfYkTfZ1HZa9XvjldAQcZ8Dy8Eg2JnYvxS6n6N4lqbn
	MocU2ClbAOwCZ3HaJJZzpd6TQKb4Rs/OT+pEFYhAijP8Pi7UOSE7d1FgPWm8IIS5
	O9UhITIPLXrCmAd9QVshQUVE3OXA+8dtVlB4MYhvKxXFmsNeN2vryX7N5b0frefh
	qnC4aytzeKWbjOMpleTsSJVcwnxUuSQgmYikZafDfpXPb/v8RzjJPuurCwp/hhj7
	s6fQmU9Q87McKc/XD7r4ljbX/YLYYX8oj2mCk23ZUvpS5Dax0kOBvRVRCePb2Ack
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pwuqfq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 08:00:35 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLka7PmqWDLnWHA7bqQMWLbm6hqd+tcrPW3DniX2TDYLdyIfDq8/TdUzH092EbYXfhhQHSyft6ujcnj3xbCJaW95t07kqPNLoz5HvfEaNRq9rRfgPRNKvBFJeQ7dPJ9qWfGdVe6ls6vp/AyGmew1B+LoU25kN9HQgHJLv8KG70D72DrxQxZRkoAg+v4vb3DrRECd5Zsjmxmlgx5jJGxU+1UiYithypwSdE7xs8MSl8zulHOqeMkijFPjmg6mXKa8S4CHLa/EeWZBhDRBidi24Tuh93fvlGSFhW9UcX4KTAxDe5e8SZCiiAv2s8W0cbab03RzlLfxqmQmmO0cgg14Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugEg2CgEldPz3rLxkStboYnwJox//NiUHJP/ZKQXe6M=;
 b=ViEkvJcNUnCLK8ZaMMrU7ULogD4KzyoxYqmzUcpNDuvxpheVau5wVFM25Sb7fu+WodSTXs+tFM0C0CcgKnh3lJr6tag3V04RNkfVPmZuVbSp3o3NzOOAXFY2Pr+L625inxVF/+7b1scl9wa2uABl2gLD9bfX+RxJct5dddvAFqMD59/10LEs7NLBXk7YNGWLFB+k3KmqqCJeyAnIFji0yNfsg2ysctn2lWNeC9dok3svHRU3nxBFUNa6R7mdmpEFxR9UvJONcgRV0Zb0Ol3VHRiSbKKkpvQs8OqbQa9av9+bGMbfxhkGCsqSrR6eHSirOK8PGG+Sd5YMEBwGup3AHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MW4PR03MB6427.namprd03.prod.outlook.com (2603:10b6:303:122::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 13:00:31 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 13:00:31 +0000
Date: Fri, 6 Nov 2026 13:01:48 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Lee Jones <lee@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Drew Fustini <dfustini@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/8] pwm: axi-pwmgen: Enable clocks before accessing
 hardware registers in probe()
Message-ID: <au3O-Fwf3XEMol43@nsa>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-5-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105143847.2559586-5-lee@kernel.org>
X-ClientProxiedBy: ZR2P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MW4PR03MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: ab519a16-c82e-463d-e462-08df3c05f031
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 xJrl5A/ZZFwtlhgt3WYiOHmscm46vF57ITDwOkYyKFeIP/deH3062Xz1GwaAhgP6SCXCv8V3YNSsyCp/mKxC3DfmS3io4045ljZ7HXWTiF4QSzqLnSfM/cyhJf4DEtwmm74blMCgqA6cv/mvhC78i2cXZbgNyKEoSAsqEqUflC3UzqXKfL42/l40hcv6968r6gtMkeZyZtjP/7BqPd+/+WTrrp7AXMN/d1l3EhsHbcdMtjBqW97iI5M945IIwJbpwrqplFCNdLKPFnHE45ssmdrqdpV1H80fbPOsJm4228fKx52bozRIUYAlmk9MFg6qvkVI0hgerEdQT0jkeY2MfZqUeHF5gbpCFbg1vFKMQTbSkOInl7+hmxtopXKQNNhpbO8Ykz+aaJmEPhoEsrIV+E1RqbenaPYnRwGsNP1i/ZZ+nwJQ0ahPqrzVyL8WbfyI0c/DiLBE9KAFP/KwBQ6awbnMTuvyTsAfo86k4TVvHDZuQErznZ2hiTYe5HXZZPLvxNv0hBgktRVxOhNy+FTZNMoh1AQJBVK3gbr/otbS4EA7EbjnylaS/k0hD6nenFNJRPh3JtrnrpfCYc6zp5L8pbm6XtNgMtHxAMHU4o2CiiU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WFBTMXIxV0tTNThqSDd4a1o0RGl2VDVNQmFQNVgwSk4rdGJWU0RvTnAzbHRH?=
 =?utf-8?B?QTUrTk5JU2pHUE9KTkgzVlhCZEpGUkNud0Y5Q1ArdVZta1BYdmNLQXJmTUhR?=
 =?utf-8?B?NFNnaEFORjQ2cGlHdjBLZGlQSTJDSG5jTGxOUnJqWFo2aXlJZDRIaGU2ZEJs?=
 =?utf-8?B?eU5IQUg5elhwM1Uyb1kyblpsVWhuaGlEOHNTclUvMjlqNXJlWGZFS2xLcUZO?=
 =?utf-8?B?ZGxabjVwSFpJazF2bVpDVGVWOVZpa2JoazJZcm5RMTNRT293VlMyTklZdnJE?=
 =?utf-8?B?cllVVmt3WXFXUlNoTkMxTWxzcmRSaEVRYkJISy9jVkNJaTVCVTNtcUhjdmpP?=
 =?utf-8?B?a1pJMm9ucnI4eEpqekxIRDB4Z0sxWHc0S0UyY0NIUHBWNDBSSmM5YTVoaEZV?=
 =?utf-8?B?NzBJazdjcTdyVWlxOEdqYW04Zis3dWFvdnEvelVPRTk1TTRtd1NZajBqeFJl?=
 =?utf-8?B?ZDVEVDhqZktzU05iZkxOcTRzeWZsczk1aEh3TWJvVHdoaWVRQytFQW02TmJ6?=
 =?utf-8?B?ODhVLzI2U05BREhENVNRVDJKS1lGOHlsQ3MwdlYrVHdGaW4yanczTnNnazJS?=
 =?utf-8?B?ekZ4bGNNem5BNkhHN0xDWTRHcDJMTVZleTYzZlE2ZXNQK21Ob2pnR3FIZzZ2?=
 =?utf-8?B?RmZHdVNqRTRPN2U2ODVvbmRZcUJFMzRpWUNYdmcwZ1I4QnNlVG94cTF3WkxG?=
 =?utf-8?B?bzhIY1grcUFZZWlHcHZDcVM0dUo5RFdYWFJ6M3hpQnJ3aERqNkRDK1Fma01C?=
 =?utf-8?B?MHlGQjdENmlQYkpuSUdFa2EvQ3NxckowMDhDY0lGemlrUjJQMk5LTUIrcVJn?=
 =?utf-8?B?OERUdy9YQ3ZkaVZkOWxVR2wyRlF2cjdPbTF5RXlGZnR5VHBrWEZIdnExbW1S?=
 =?utf-8?B?TnhhQXQ1T1Y4ME1TRXF0NnhuWDhkVXlJMmMrUW5raUlWZEZMUFV6NkQyOTRh?=
 =?utf-8?B?dExEekgweWtuQVpFZEZ2eEJHZExSckplWEpzY0FMeTU1K08yVEg4TFdDaS9V?=
 =?utf-8?B?L01tUDFGbkRHMHVqRXIwUkI3aVF1MDlaak56TThYR2ZTd3JSR04vcnNacE45?=
 =?utf-8?B?c0dsNmFlMFE2OHVJQnlsckI4Y1IrNlkrSTB4cHZhTG83bVkwWWY1M3gwUzdJ?=
 =?utf-8?B?N01iaGo2TVRQSWh5OCtqNnlTZ1B5MUUvYWhWaE1GbzEzZHMwOW9sMEdkTUFh?=
 =?utf-8?B?VjArZUpWMXJHdHVjUjA1aHFEUU53RytQTmkvN2JXbHE3YU5TT2NzRms2NitV?=
 =?utf-8?B?bnZGTlFDTm9STE1SamFMZDFKM0lHSDdlaXJtNzFaT21hbTBZeDVBZXBuY2Vn?=
 =?utf-8?B?dDBDNUFlNUpzTGFvUmRlTU9DdGp4bnJqU1pTam9MM3dKRWthdlNLbmdOajAz?=
 =?utf-8?B?c0d3NER3UEVmdWRBT3Y0UGlJYUdzSkNBcFB4SlcyNHptbWtTZVBwYTN0VExN?=
 =?utf-8?B?bmI2ZmQzNkJEZGFIU1YzTE5qMGhjTmZjeEpacW5UYitwTGE4U2pQR1M0VnVS?=
 =?utf-8?B?bUJSbUdkUzg5NC9xQ1hRZnNVM1REMkl1RUd4aWJGVW5OVTNJZkhpZzdNaUo0?=
 =?utf-8?B?OTdYcm9lOXJmS1JnTjJGTmIzVzVZa3hqZ2JMa0tMbWxHRVBSTk1DVlY1Nngx?=
 =?utf-8?B?MnVaVHlpdHpPL1hkS1YzRTVYZk5FSklubWN5Ti96dXdOZnZkR1RBMVZmcXNa?=
 =?utf-8?B?ZDkrOG9oR2ZIeTFJTkdLUDJsREtucndwc1FhN0V3UmNVd2xkWHBndWJZVnIy?=
 =?utf-8?B?WTFQU2dSTXg1L3RzckNsS05jc2ROd05OSmZFQ0FtOUl0Wk1xbVdmekZkL25p?=
 =?utf-8?B?VjFFY3lSWEkzclVEd05FV0hSQWErdEFRSGlad3J3dEdQU25xR3VqLzhUc3ZM?=
 =?utf-8?B?Z2dONWhKbm9VZklWaGNYbmlBalBZdHFkVW9pcjBwbUFoSTRZTE1ZaXMzUzNu?=
 =?utf-8?B?dlNSY3Uwdmx2N1FvSVhJNVZ0MWM2eEZzNUttQWdjdUswZmwzZ09Jek1PaWp4?=
 =?utf-8?B?bWJGajFpSHB3blIzK2hwT0JtdWo2cTNrdTA5L0xiNGZXTVdMU21vaVZvc290?=
 =?utf-8?B?VlpvQlVwbEVXMXQ0NHk2enJCNTBWQVpvV3FISEw3V2VTKzI5dkZ4dWt6MWRD?=
 =?utf-8?B?K0ZQSVhSaGVMWWZtdVhGMXk4cXFIdlpKK0tTR1lZK2JmaXphRjJUTlJlaXhX?=
 =?utf-8?B?anFib0JscXNRcWxCZTdyWTdFMUtoaHdpSHQxaWszSW9XcUY4Qk0rOHlxeGZR?=
 =?utf-8?B?VDRHQW5VZU5nc2NabWNVcEloeDJaSTRGZTZNYzJuTjN6a0M5R0lCeTFDSGNh?=
 =?utf-8?B?WkNwMnI4ZGE0aGIrYmhjQnFxYnRnN2taREJEMnRYcCtlaHNhcjUvZz09?=
X-Exchange-RoutingPolicyChecked:
	4CNT02keCmix4GDBxm5HlGvadqEyLxzTk+TvIVxaZfOpl+D4bJRQ8Yyt5JOpzSFfvDM0xZ29jWDA0Zb43hyOSlf0n408O91sn0H/CpPvcIZn+EcSiFc7YIbDEsJt1etU846wSYrkZeDpaXWKKFSFCpquMRKl3I4SpMYXiebXoDpDMEUNqQaIyrK4NCJvq6otzFGDyuDUYxReWnBbuhczHQzcY2RJrya1A31UeWh6OPtIk5dqmpLUlKFPeP29s8lVMm0OsB1hrykx947mMihsAvi63AlfZRqdWXSWcwRLzywHTQutcjgmN02mYgSeNJS607T940Xlj1CJJCMaV+u9ug==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab519a16-c82e-463d-e462-08df3c05f031
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 13:00:31.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7icFSq6PzwKL5RjkJzFhr/6Hcjx97f/6DINJZstzvORfg+pKnY+uWGeFQ1rNqiA8NgQ3lN1cQ9dJznvBpm7+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6427
X-Authority-Analysis: v=2.4 cv=UYnE26SN c=1 sm=1 tr=0 ts=6aedcf73 cx=c_pps
 a=Ftf85+eZhIav1RrYVnHJVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=PnLqodUGBHYneNrmSFIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: FjzlY5VBGAO0dJ7GkegEdxfQdnXTErov
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MSBTYWx0ZWRfX2Lwl5+zrFARL
 4mufA5FYb4Gd/OKuWH/KsujnmTHUZZo00/sDDfFaiISmd21Q3BAAvXUMhfJanm1e4hztTKXFpxe
 W49hZJftKPVm5WX3LbrpyUYRuHfVusHvrqNJRdwbsWxMBiffxeDD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MSBTYWx0ZWRfX6albbbeFdKDH
 fXZC5GQaQ8bSonW2ECuJweUd5fmEi5U9YQy0vPb/wF2zJcu9kYoKopQe0g4LCmSqb7p/FmSYaF3
 ODckHAi0z6HzOUCv02PtVRkLp/1zSWRV2Elv3JTpmxu+uxihDpuSW+4eJ7DBuLbvtN6As0NGtfg
 GOUOCRa21q3ruI6zxiEPyEG76C3j0rtPl2VbTLDy+s8D+L83Qv4IQxAdilqFbzN7c+aQGUQkfic
 +4JOAEPTnP4LGcKChQGx+hwWoTAz/nBMJed4a+7pAS77/KnXhc0UJ93cVs4DnEYuGMwnNquky/Y
 l1BGhibDWwJqwbAUXAutoo5QZlF7SPtAg9339zpGlM9PXGxlKXmD0rAMU5xoFIxe5RHy+J431ZO
 ktYaFj7qv3zFksKCVgjmOvVsc9TF1gwlE1Keq23aAvee5s+qzZmx5iKa8z6h0md/JgEsISjBEoH
 wftTMe658TwhtIhPYog==
X-Proofpoint-ORIG-GUID: FjzlY5VBGAO0dJ7GkegEdxfQdnXTErov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060051

On Thu, Nov 05, 2026 at 02:38:06PM +0000, Lee Jones wrote:
> axi_pwmgen_probe() calls axi_pwmgen_setup(), which reads and writes MMIO
> registers to verify the IP core version and determine the channel count,
> before acquiring and enabling axi_clk.  If the bootloader leaves the AXI
> peripheral clock gated, accessing the registers causes an unclocked bus
> access fault.
> 
> Acquire and enable the clocks before calling axi_pwmgen_setup().
> 
> Fixes: 41814fe5c782 ("pwm: Add driver for AXI PWM generator")
> Closes: https://sashiko.dev/#/bug/linux-bc988dbc-7b12-4785-a164-b6dcab29b86a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

FWIW, I think this is a valid fix. Likely never happens because the AXI
clock is mostly "assumed enabled" but we already had some edge cases in
other cores related to not having the clock enabled. Anyways, LGTM:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/pwm/pwm-axi-pwmgen.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index b40522f01002..7c1b38124787 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -270,16 +270,6 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "failed to init register map\n");
>  
> -	ret = axi_pwmgen_setup(regmap, dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	chip = devm_pwmchip_alloc(dev, ret, sizeof(*ddata));
> -	if (IS_ERR(chip))
> -		return PTR_ERR(chip);
> -	ddata = pwmchip_get_drvdata(chip);
> -	ddata->regmap = regmap;
> -
>  	/*
>  	 * Using NULL here instead of "axi" for backwards compatibility. There
>  	 * are some dtbs that don't give clock-names and have the "ext" clock
> @@ -305,6 +295,16 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
>  
> +	ret = axi_pwmgen_setup(regmap, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip = devm_pwmchip_alloc(dev, ret, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata = pwmchip_get_drvdata(chip);
> +	ddata->regmap = regmap;
> +
>  	ddata->clk_rate_hz = clk_get_rate(clk);
>  	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
>  		return dev_err_probe(dev, -EINVAL,
> Cc: Drew Fustini <dfustini@baylibre.com>
> -- 
> 2.56.0.398.g882cbad275-goog
> 
