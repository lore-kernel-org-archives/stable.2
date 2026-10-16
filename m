Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F737F735;
	Fri, 16 Oct 2026 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139925; cv=fail; b=dliNZtuBQGgU3eiZjj2WbfhlT+6l0WnW32Ea87/W9fW7di3JT36eJdys+rJnIetVW/QbzVxn+nCa9d/28b8X+t1N0mkUrkkaBx462lBgsp7LkAjHNJMrSzSjXgFHP7/88QK8vUZCblA9v46u7UVa42hCvDURqVsZ83kLBhlH+ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139925; c=relaxed/simple;
	bh=+R/vszcwWbBTo0gYpfVZsDS2WmCa2d3MW68DFUCqDPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ckOevVqrdEdkqpAoUOhzCTOPgmvxct5tiWrxH1nde8C72FRfN+cV2Tubz3cF1ztp9Lk+qAs66RklGdLLRsS8dL3znxoHk9v3j60o8X8AMAGDeb04VPiBmI5wM4NVhkpKblmGIZ/LhOvPEqx+fY6Bqpz+5ZaSO8MV8+5OZLXE9gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=RNeY8aTR; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1DE8wDO3; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="RNeY8aTR";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1DE8wDO3"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8BZ4i2077197;
	Fri, 16 Oct 2026 04:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=AY2JjtLXDHiPg3imS88DPdWnaS588c7qG9eTASqZ7l8=; b=RNeY8aT
	RWbN4YYAme7noH/Ahz4dfuy2n51OoGlbcUEIMGF222EJNbG6/TCfU1xnPRXD2DOs
	4fc6FMuMHF/ne+VA/Etz5qicr0Iw/bMZu19HgeJU7vDh5F9y9sNGHWFHEl2m4f8j
	COK2xuUGHVXUiF2gKIJqRMDGHKbNv8EXd4XPVFBJCrGC9RlkjuR55MDdqgFA1jRh
	5+M5Zo/DO0dUYzA4OuSSF99ilxUb2Z3vosaOBaYMKqbRsiN/snTSkok6pbF3Uy2x
	PBZUj7tY+J4D74VqPQlTU/QW+8dbBeK7UMCxnwkVHRE5LOHowep1aBIInq8eeOFO
	Mz5nWOR5QGn41dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AY2Jj
	tLXDHiPg3imS88DPdWnaS588c7qG9eTASqZ7l8=; b=1DE8wDO3cg8q1aO04eT+k
	6PUZteLHyPx37/9oLaZMwIUfueSayURIbGwK73GMZb8gfd+PY7wr0nOQjfY9/nGo
	d8YCH4jQhG6bVSSO07rmObbzUuzzZjS1j9pACrHTqDNupnngkgoqkHPc8vERnlmI
	Xk0ng1xMZFGTsVIVlD+kF6Y9BLb6MN6Hm9NNlghp5JvpZdaY1wg3VOchtgeQxW20
	wYtcl0URXugV9waAr8lIGRIngcJqbFQmw/EEbukeEuniKMMJSRUR2RJaqBSCdr21
	nQwzxEiHoWk51CWiyQdkz4/TJLhk39Q8tHaoGDXb3bGL5PAA7+4e3bb3Qlnhj/hv
	A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4havj3xa66-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 04:38:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKfB0Gl1gH1qXuabO42LlpUiIMtIL4yLHQ6/AxFAxezfyHgJthXcjx7RoEsU3J3N42jBQ8TNO32NpacVOdXb4pHI5Hl1ynyBpApjZw3nHRwd4Z1qGZhnL666e15MnN1lXgZedCuqyQM1jGIcDgOIe3ndjCv2RA/SMNG9rpyu1NZzJ8xUXrARzA65MhNPJMwLAplSHl6YPon+kWs0wu8HQOgworItPaoI+C0W3eS3dCvYoC9an4moomD+EyNma35N5yNuymksK6Hl1snYE2zUDWTAPyXWQ6ZnLZwlZoKo2EIvUXDAyldE7sV46HKdwUBaSRSFjYDDgPUrDqX2Mz7M5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY2JjtLXDHiPg3imS88DPdWnaS588c7qG9eTASqZ7l8=;
 b=TxWtDtpbzUM63ogjKPRLO6uHfeQMV/e3OA1YYagQ4o327qsKdIt/LLTGnPHoQqmwptxuSUt0vS9mQGZLHA7MAxaFEKztQOH2BKofJ+rzc1on/fO4noMsyWoDzZGfDe203ISo11M0jV+Rgbga349ZORiDh6GoCw51c5kHDuBPjgzHi5lG+U4c/JT5z0tiZNQbUv1xRXovqzGSZCutZ02zOJ/BHakpsKExn4LWKN8pfrz1a13r/nDwYym4QiKPljnM4P4lbG8P2+3AeoG39T4nbJ5ppguyPa6oGxrA547+w80/KbEv1yhLZ4trgrjHI73PvbFolI7daW9mQvvA2JdC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS6PR03MB628070.namprd03.prod.outlook.com (2603:10b6:8:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 08:38:30 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 08:38:30 +0000
Date: Fri, 16 Oct 2026 09:39:51 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Dingisoul <dingiso.kernel@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <atHinTYMtjsY45wY@nsa>
References: <20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com>
 <20261015221818.09527ff6@systembl0wer>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015221818.09527ff6@systembl0wer>
X-ClientProxiedBy: ZR2P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS6PR03MB628070:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ac14b0-cf38-4076-d628-08df2b60db40
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 ui0s7ozaPFA8kpCljwcE5NPmecXgF82dW4/UCyqfJ+AcDqgn1UCSIoszfaUuat7LFyT4WpclJIwFioclsZnfFLqLpZFBAu03yp5/+yMNSXlew0voz3f5lXcbdDQD6jgsNnl7XQfq6WnT2Q+pD2txSZime9DAehDyhucV5oxS/cGRha0jMK4DlfhILUljwRu6O/xG223Gyy6B4B5JKXyBIk8K7ui+o/IpZuEcD+v1vL6jXuOpSP94pCNlzfAFOqAToOQqmnI6US6YCkKb7O76+opSTf015uAkoucfJ9ApkrSfCBQERc91AWAW3uQrUUlInpih0d3uxpT8Et+NGDi9b1EgFloHw1a4dgFu4cgj9iXAtvHBazqFq1lTLjhvUyV177gUmjgqX2Tus0TvxZ7A+JHdpU3f+D47vbUX/rFcOSnLjDRPJxnl0HNzUoktqbVNUyrAmP6VezDqmvX2wZmUZPHqjTvFKdYOkbD4397ZSwoxRKAFiz3s+JAMWe/xio0P06ALpCqMtYqyDmUPAQi2geUCW3fJc0AKBRnDuNPbYlY+1MxPaEIbZv46w2HfskJCaXXJkDRzLWDptigLbVKa8ozSm/sJKoSZfReDMhQoo/infVVee2JgECacS4FzZeMM
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QUExTDFxTEI4V2E1SDRDZGlMNzJqcDZDMUxXZVJTMlpXVGZLY2hJRWZZSEQ3?=
 =?utf-8?B?bDNGREdIM1hhVTkrTTRjSU1PV3FyeVErRFV1U2V4cWhTa3VrUGNzNzh0OW5Y?=
 =?utf-8?B?MzRJaWcrTHhEbzNiTFR1c095TlZGaEs5cHVVenhnQmdza3NlU1ZuTytSVjF5?=
 =?utf-8?B?bno0UXBTWnhRMXJxNEszZW9XckpWT1dEWUJFbG9wNzJ3bk1peEl4U1Bma09y?=
 =?utf-8?B?c1ZXNm5mZmRJZm12RzFKUjZqRDRMZXhINFJ1NHNuUW5adnNuSUg0bVExZnBR?=
 =?utf-8?B?MG9GaURGdy9JNDJBdlJ2cTFtVk9CTDJIVndxbkV3NTNBRUtMSThHVDh4Z2I1?=
 =?utf-8?B?c055aGVqUW1NTGk4YTRpU2k5Rkx5UFJlVDlnZmJodE9OclRZaklVTVYrL2Vi?=
 =?utf-8?B?bE8wbERpSnN6b1JtWjd6b28wOW5LL1hjUnZZcUVRV2h6YlVFMTdOM0pzejhu?=
 =?utf-8?B?YzVNbXUrSys4UzNkcWNrdHZFM2g2Q0xlYzBFcXI2SXBqZ1U1cDBVOWVXcVVm?=
 =?utf-8?B?MDI1WmRxK0hCbk5XWEhEMTA4UUpBU3E3MnR2cW1USmcxSlkwTGNYN0FZREdl?=
 =?utf-8?B?MERIMGNHbjFuZVgwK1FVMnJkM0JpSjBEcHpDcFVzR2tHYmwzZHV6YUZLRUg1?=
 =?utf-8?B?UHdPSVQyN3RUZkZabjQyT1hKNDAzcSt3dVFOT1c1TjMxd3RGajdEY2Z2Z3p2?=
 =?utf-8?B?RVY5V2NSU1lXNjAxRjdEeCtFMHBGN3ppendHNUZTWG5tK0R4dEtIY2poYUg0?=
 =?utf-8?B?andPbVUvcUpNS2FFTGkwTjMwUDluV3pmOStHQVVCVUNZajhFV2pnVUs2V0Jh?=
 =?utf-8?B?bVNXc2RkbU0ycUljRERCS2RxUThTeElCU1l3bU1zZ1NubUhDcm1lSUN4RFdZ?=
 =?utf-8?B?WlpNNWw3bk5WSWFBWUtpbEF3WUUvNExNREU1dEtHVGtsTitaNmEydFl1T1RY?=
 =?utf-8?B?OUdzMEdwNHRzMzJ5cjN6b0xSNkltNW9hU1dvaHpyQnVXRlF4QXVZTHNQQzZE?=
 =?utf-8?B?Z3RjZENoMGxvSmovd1JwK1pWMXZWdlBHck5nSXM3ak1EcDNwVSt0eHdicS93?=
 =?utf-8?B?dHVNZjkzNzNTUXg0b3JlN01lMVNadXlTRUVPRWYwNDVYdk5UV2pNRGZxMWxH?=
 =?utf-8?B?SnRzWWR4UUJQNUkxdXRhcUZMREVKYlBkTkJHT25OQlFrZUFvMFZqeGZVZ0xF?=
 =?utf-8?B?MDZWamxzL0doRXVLOFZWQU1CYjJLZjFMTXUwQm50MU8xU1RaTzlid1R0RTY4?=
 =?utf-8?B?WTFibjN3KzdVZW9NRWU1YWRUTTRKWHVMNU52ZktxN2ZwQTJ5bWZiaDVaSGoy?=
 =?utf-8?B?MVdZblZHcXFyL3N5bkVFTTBrKzJ2YmtmRTJDY1lRY3Q4MVJiWXFNQ0xOM0hs?=
 =?utf-8?B?Q29sdWJwVFNpc0NNUlE5b1o3bzk4RmViZGlQSnNZTnZaOWh1VEVja1pEckJX?=
 =?utf-8?B?UkcrSTJtZUZZMm5wVkd0SnZBcWpqOFZ2VWFpdXZPb0tmVzJLN2E5aHZoQ3NO?=
 =?utf-8?B?cS9qZXIxUktxSE1yTHZLQ01kd3VtTUxOUXVka3JDL2VDaGMrVnNXY2NHYytX?=
 =?utf-8?B?MlQ4T1RpRGZHSzVKdzlKODkwVmVCbXZpWUJ2Y1pwWU9DQjFZdzRmNEhCZ2Vy?=
 =?utf-8?B?cTgxUDVOWDlqOTA4S2dVaXhId25YWmdGd3p1VnhVVjBYT3pZeDl4RGtoMysr?=
 =?utf-8?B?S1NNTlJsa2pQYXBjeTBMbHpRUWVjUGo3VVlsNElYREZ4NStsNnBnTVFicWR0?=
 =?utf-8?B?NDdZSy9ZN1cwdWQvQlRZOGV5VlQzZ2cxa1FaM2lKYm5uT0d3cXJZZEhKcWtY?=
 =?utf-8?B?UU5QS1F4UnJESm9Mbm81ckdlZTBlcVdYRXBwR0NSNng3bVBVSEh6ZHBURkdp?=
 =?utf-8?B?TEkxT0VQQXR6MFQ1eVpkbHExakZkV0ZMMGk2K3NRczlwVUNVaVJ0cllsUUFI?=
 =?utf-8?B?eGdTYy9sT080cWluVk9uaGErNHg2dnhRbWFYMFlLeFMzc1B3MnpzNFVxNmtj?=
 =?utf-8?B?T2ZEVlcxOVpDdmNmaldDRzNIbC81a2s4ZlAzY0tNdnRQT2VKLzV3NHNMWHMr?=
 =?utf-8?B?VHVxbDl4cHV5Y2N4Uzk1QnQxOVNJa1NzeDJnV2RwQmRSQWxVWnZwSkhHdVFr?=
 =?utf-8?B?MHdPWFBHSnFRUDJkUHRlbnJXdlJmbEl4clFvVGhsbk1vak54d0VtSXEvT2Nv?=
 =?utf-8?B?MUtaTUl5dkJic1hBSDJZemdGajNsZ2Q4VkU4WE96aWVoVmNTa3IzZ0FUTWhU?=
 =?utf-8?B?NW1BTjZmRjF2RVZMb2tzSW9EZmN1TmI3Y2pTNktkZUdWTVF2c0xwVkgxcFdl?=
 =?utf-8?B?c3V5V3lqOUlaS0RBYTRlL1V2c0VMNjQ0R1J6QVdUM3NkVndQS3FTUT09?=
X-Exchange-RoutingPolicyChecked:
	HKhc5xAGAm7poJojmMe1iJdaZl3APtvicvXRGMZZSvCTBHPTXbNf7L+UC/ZlVoDLVQahy/eICmxAmmspj52dYE+q60zC6zOKQbJzcJe30OFwDwJZlD/HYSBOOiaGvEzoN41+y1PgjwLgK/J9q2Qlw+8Lna6+dWHB/OQoetlTjsvNlUPChPCZJZCoYjy01QW/aHa7J9M9iIPA/qzvArZrvPKOUdTNRIUbFXwA7+qgZSK+KvhTNFnQoYv5XbcKkODVowX8d9AunnqWWWr9fU8EqbDqGvX3+ZBgfHAAlt6YLWThPgNNpcgwz09mEnzQfH05lzyHssd3I6veDUldwAduFg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ac14b0-cf38-4076-d628-08df2b60db40
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:38:30.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPKqfMZrqyrAgU+bJoc5tEb+67Tn4SVtyx62Sp3sOI6G//+cNNt5miZQvgJ5cplM3D4U2GQMNmWT2t/Oi/O8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR03MB628070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX7HyYUAWHcs/T
 lg+/+ADy7Fqz4aZammclv+7ZFgWCsOKtRxkP2C/LjO6re/XSZSvTLGHdVxGbs/tMqBbvBUFEssB
 6PKIKqs6GvTYKseakfydWLSaW+o2t9zplhuuWnCH7myUV5Dpqwo2+oVLSamycNVOqgsaV2wMURR
 JbpSQLYi/84+sCENtMEMxYij/2WsAZql6sDcaNZ/UqA5x/Qw//y0dhmhDD49AGJKlXJqPj1eDIH
 mpGh0/zD7O4aAo/br4VWXGPxGUXws8OU1m0+YF6/KBXVahZc1mtOpI2G5tH6Q2AdAzG8qU5Xcvw
 cr2x/3TMxgsBwVAeSFXQQVacq16iBod34ffp8y0xYOdv4POYk+0IRePC31frmqYgkm14rdf3+mm
 LpbjqOpbL9yDZ3Xq2idwksc8mWakiKw+dh0wYiyLG5vctnV7kUAjJHPDfx9vMi1D+BJsOfcqafR
 x9vtSNbh5PVi24T+PQg==
X-Proofpoint-GUID: 0txR0_gjqgy-5rJKdfqgHqUyzdETT2i8
X-Authority-Analysis: v=2.4 cv=Wtu+otfv c=1 sm=1 tr=0 ts=6ad1e288 cx=c_pps
 a=jolozQ03zpjfpn/maDJ7eQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=K8vO5ToQ68yKeo0veR8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0txR0_gjqgy-5rJKdfqgHqUyzdETT2i8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX3sIsYfE1hKg7
 NRE0z3wjSYPMCo4L8BEXhIAyyhyXhxF15YKFziFVoXe8wiCDHH+yrWX2oV92u6Ec9/ULQT2+W8X
 Uj28D/SDy62zyNMp3uafVyDaCCZgUHbhLQFqsCxIs5pGPz6lGC/L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160034

On Thu, Oct 15, 2026 at 10:18:18PM +0200, Joshua Crofts wrote:
> On Thu, 15 Oct 2026 21:58:35 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > The mpu3050_trigger_probe() function registers a trigger but
> > mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
> > to clean it up, causing a use-after-free bug.
> > 
> > Add the missing iio_trigger_unregister() function. Additionally, change
> > the mpu3050_trigger_probe() function to assign trig only after it is
> > registered successfully to prevent a null pointer dereference using a
> > local struct iio_trigger.
> > 
> > Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> > Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.kernel@gmail.com/
> > Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> 
> Dingisoul, any chance you can test this?
> 
> Q to others: better to leave the driver running in this weird
> polling mode as it is now or return on trigger register failure
> as Nuno suggests?

Don't think it makes sense to continue if the idea is to have trigger
but something failed when dealing with it. At the very least we should
then drop the memory we allocated for it.

- Nuno Sá
> 
> Thanks.
> 
> -- 
> Kind regards,
> Joshua Crofts
