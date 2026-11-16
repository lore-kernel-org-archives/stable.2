Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821576;
	b=2fcS+6WCpikOphCvZ4rtRUW1nzUgCrELQc9YJsn8CL+2GnWe3G4jfmQ0FOt/FGQ/Jbi3
	 i3mDdtFUM8xbAWLdDlVwSkw4Ubq1TUNgprMINly4o2Hks6tHThAHhRqa1eY5lil37DFf5
	 dNCBfBAN/PNe0KW0/j7KAuOxQo7qnqSKX0Pp7TTbuB9tMryjMw3tl0y3nvcBprQl5mON8
	 vEUQGeCUlt2jjJ39trV5O6tpZwvQaNMGvcikBsE8ZDwI/KFFbRXEUNmoXzvJbNDou3o2+
	 sOuY52HXhOmrkrxG7uC3msRjgb0og9y9+ga5XD/mBBlqEsMcLlzXgSAGA0d0+fpuiYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821576;
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=n6Wspcrsv++c3yxsRTxMtnwXhq/BdiWKQfIgi/gYHck=;
	b=Q/AjNTivdDxgihX9xOZvxUVUQKGCeNTxCpkpbuD85WY2lA79TjCV/U/SbL3nXNxlr+Ff
	 HKQ6QWBUGiQDugBw9EfT1o+3YA1yVk7nUu/msoIt4+LW76vPMX/i6DTlWIj2+QkKJ8mUt
	 FPIMwedrE8mq/A9b80YtPYorQZYOvm0gzf3+gGAwPXKBKwNKnjGDrdvDRSP7TSgSEMd5H
	 RNVcNVMNWE4koDUPORU7rLZHcjKMRyRfHnS/YS0ngea6giqcvhPZsPtAfRbj2NG8ZtpCY
	 0TefUtcgZSFT6MQiAsjjgRhDmOsKVvLljHGQgmqvuWhU3clbxF+N/e2YBccrudIRgOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=PcEoRoXT;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PnXv8LEV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AA606A323;
	Mon, 16 Nov 2026 09:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4AA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=PcEoRoXT;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PnXv8LEV
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7eZE52894306;
	Mon, 16 Nov 2026 04:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=n6Wspcrsv++c3yxsRTxMtnwXhq/BdiWKQfIgi/gYHck=; b=PcEoRoX
	TrjPMK8QkQcmH92MQj5GwrLg0WGAhAYNP916oKH62zVvjRLZdZCiGj6jMmClFcb0
	wdhzyvLXWEVsTIHEiiw5/P3HvtpOKQEGZD7i3duSMumWUGuey9axi/EAqt7GafhC
	qoxEaWWnB+WBhZ0zzOa50BjurK8XG6aT233Ncf4HizUE0qHZpqy1fdIoJv4SNK9/
	e08KAX1MsG7klvf6iL4WQ6TMoiVZHTFrFp+hVm5/EP+8PRjC5VUS47O+FXrrM6RA
	uPBFrCp/OJ72FOcE3QFg2HDameMS1gou4Gs5Vz71m7bH2TC2NuKCSajss8J+Qvy0
	wvwgn3Nw5qkWgKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=n6Wsp
	crsv++c3yxsRTxMtnwXhq/BdiWKQfIgi/gYHck=; b=PnXv8LEVHtrjIFKFAQVHA
	cozBLLYQKkClNAP1LWS5nok3XrN7Ow/qp7JeJNNZm9XufLtK98D5KieFWX4oum6K
	lDGwjR2xGkzgnTg7Tz5mfQu6tw2PD3lCZdSN58nhsCozZrpkl9lI8JIBdWYES6De
	p2YB7dVnt8vFDWy+Ig0i2KFB7kfxSUyqiDwHu8l0lQ6UU0FXevcFTeI6uUpn4389
	sqQ1+bgGPprsQRW1bmQNsXTfBHS1Fg79qEBLCa+XHMs7kLuZI36XXayYtWkgSSJF
	vys27BxczF/x123K6rRgtIkaKWbXXN8jzkwT5RGMrys6SHIPDxJwrCl6U5Jcd8Ml
	g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hyuc3gr5x-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 04:32:42 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARrDwsRq7kc6zUEsfa54HeOKMr3GtFBHvoeLn9Ds8Fpz+39RB1bdlhYE1jdvq/nJyZjlIMGUVh7n9z2ZnxycnIDI3UOWDELNgzetA7Pfus94tJIebQGq0f3Jxgv/sOflhDl5dGIDOyxbWWXuG4Z5VvzeMnSc295j43X+O5lbiD2IOEWmDMkaYynNA5JPWbCh0K7JiEKwa6NwNgsmIRkf+5j33qKOL4V5xrtMMdHpyd/1i17SyEtHyFWgOwCe3J1lfitxMCmd3cKt2a4asDdBoEVnoIRRDbul15hOORT82z0aVSkfvrL0v5cTu1sKO2/b4Pb8ZDFnkD4OP7ykdZh5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6Wspcrsv++c3yxsRTxMtnwXhq/BdiWKQfIgi/gYHck=;
 b=ljw45QfXBWMHjFVKmc8M2huxAhTB4mh5UzuD1mToyMwPJhUg7TL4dfJ8tz/QSU2TNTnZZM/LGs/H0GMOqmjYoQycDcz4HmLJjhwkJhELipPDznBo98V50UROVswdJsRSgNGD/eGp9tcVRhbGzk/V+eND0+zpxWoES8wZ87dyvqR7KfCcEp9AUagjvUBRXoiH7AR4dtEUgG1jQd9WgMAWD0h3TkSRz8Qjw1Q+HOIJDZBjsyKtj/lOEQI312/XzVaStPEfbzZpFrsT0MyHN64wSlSisuJL0hQ3uJ9VGSp7SteT5n/KkQKvq7wClacelQMqY/rRvNl4127dl4D8DgXGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by FT1PR03MB244572.namprd03.prod.outlook.com (2603:10b6:170:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:32:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:32:39 +0000
Date: Mon, 16 Nov 2026 09:33:55 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: fix bounce buffer use-after-free on
 unregister
Message-ID: <avrN564spY0seOze@nsa>
References: <20261106-iio-fix-possible-uaf-v1-1-1bd8b94e771b@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261106-iio-fix-possible-uaf-v1-1-1bd8b94e771b@analog.com>
X-ClientProxiedBy: ZR2P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|FT1PR03MB244572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd392e0-16b4-45e5-8475-08df43c48e5a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 SuRWgqGxyNowW4zPFUvc6GMg6ijGG1mAacGqf9GGsDpP/ZtV56Jjnf3jRI9rQtXoyPHr8BZVk0Pe5JfpgcrMsgDrzuNiSGsLEOQRWIUhfByNch9BlYtT2oHFY6dPviKDIR6y2I50DrvzuxLtmzaoi5w2mT7FXLe16/8iCmgXSihvfXurj2BZcxkKoz7upCVgNsoTK2etPttFzbs0dArDSOxmQhJDGqxL5qw5iOrqY9a/0CPhHmOgoyE3ZRCftHRbp0RKaF/9inuN+P8Zz4FQxxoLIZ4hOQcJ3pKuHABP8mjTvSIiAuhg8vevBU1A2063/hel3FqKrnXY8Eb3AoFJEPn/f9H0IE2h35s9+J315OdxRGuyLl+Q3kjvvtD+QadQGbg4Og7zBct/lx74MldjFqNvGIUfLgv6nxdFixlg9C+qO51vAgz/eR60MSPbhC8XTd9Njg6gPFAJGd83D70gSJkfDTxW4cC/tnLFg1ZJlBKBPo7AfT/KeeBoHfS6zx4XGuUcNmo6ZQ7kZBGMv60Y1MnETYwtT/Uw4vbNFl3sv49E3eUPrI0ptWqNMAE2hACPD0FFbVmdx7e5rNQH1bwdnNAmjBmzm8I6O07pEM50t/bTkwhqRGR2/NgMv7Sv8XBpTNbh9I7Hb04BWUz1ac+pgYHFj1IEo6P3erW7HDYCtuE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q2ViTncxYTJWdlE4ZUQzcmYweFBRUEFLQXRSR3UvMWR6L2sxYWlHMUxpWVNK?=
 =?utf-8?B?Wng2akZkalpqSkU2SFc0NDBhbitTak5xWWtJRVpDS0lPZXc2ZG5ZaGdNS2wx?=
 =?utf-8?B?djhxMll1L05IMDFLSkVHM2JTZkNuczIzM3lhV3BpVjdVNXBNYVU2Q0xXRU9k?=
 =?utf-8?B?OGFudWlrTUhoLytMUk1hQlFxTmxCVzdBWWs4aVFuUld6UUlWbkNJR0xOWUtV?=
 =?utf-8?B?aHJ4UnlMWUtiSjM5T21tUGtzRkFtMVhjRTA3YTFDR0daNUIrMnBBeURSUDRK?=
 =?utf-8?B?eGpNZ0d6YTQ4dWgyekFBK1JUbXlvNk9zRkd4K3ZUcW0vZHU0czRTSUpXa0hN?=
 =?utf-8?B?bnU4ZlF3ZVpxa1MxMGxFQ0h5Smsra0J4WDNPcmhNN3lDWC84TFhqWXNsN2FJ?=
 =?utf-8?B?YTlNVWRtSUJnU0MwY0Z2RzFNSGRMMlZYTlRFd2xJbWVGR1YzSEF6dzFQRC9y?=
 =?utf-8?B?eE5HakF6cUZ2MHhKRWJyS3FoR0ZIWnFUSEYwVS9FaVlNbDVCMkdXZDM2ZGdS?=
 =?utf-8?B?L1ZjbXdLMndMdTZheDJSeGVjRGhaSEJBMWV1N1liU2xHOXNVMDV4dTZJYWRp?=
 =?utf-8?B?N29zOG85TUxCVFNKdGVueWVqM1o1d0c5d2VUdVpIUHp4am1mQ1JaaUFFemw5?=
 =?utf-8?B?T01YZFFUMlFkMVN5a0w5TnFveWpnRS9Dd2lraHl2YklMcGFMYTJlZDhyYUo2?=
 =?utf-8?B?QW44VzBsR3NxTDZtdmJzMDYxN3prVCtlck9qQzAyQ0tEQ2hlNEhSVDlhNUJR?=
 =?utf-8?B?VGpmeGJhWGdUVFBpOElJNWN6amJSNjVseWVDakI4VCtTVzNlTUtJa250RGo0?=
 =?utf-8?B?aUtDR0F6c2NrRi9ZZ3pnSTZJVUxjTlNPNGppWW1GVlNsbkVwOFpIZnJrY1NH?=
 =?utf-8?B?RkpvdnlGeGJsckcrWWhWMVVBUHFSY3dkQkVySFNqRjZWVDBOeEcxeU1aenVx?=
 =?utf-8?B?VFpjQmxQV2xMWmU2bWFQRkNPRW1WelRZeFR3TjUvUXhIUUMvdXhRKzRFSHJm?=
 =?utf-8?B?WmRsTGtyckdDMGVwOHBpS1RHVXlmYmFERnhxVzZMUEpqQWZpSU9hVkFubUll?=
 =?utf-8?B?VDBBOXRVbXA0czhpWkt5WFBVZUFzbDJwR2xBYk9ORjFiVk5xNEJITVVaZi9q?=
 =?utf-8?B?VklNelhseC8zQ0Jqd1dZMnR4OXNkWFRzRjFGTFVwZUo2N1RlUmx1Z0Z6eXpJ?=
 =?utf-8?B?ekZmQlpvRXlqbTAvdjVidWFIZ1IxMkxUWjBBbFJDZVEzOEdnK1UwdUFOMDBh?=
 =?utf-8?B?ZVJUcGRjS01YdTNzemZRZFp3M2QrRlFoNVh1aGpvRlUxN0pyYjZLMW5oZzlv?=
 =?utf-8?B?U3d1czFaSEFTOWhzZk02S3BMdlhiaEFleSt5aGZ0bXhYd3JlZ1hoVDh1VUl5?=
 =?utf-8?B?YUVMRC8rS1NqRy9UN2gwM1dlUXV1NXByN3phOWgvKzZFekxQM1F2RUhhclp0?=
 =?utf-8?B?dk1keTFLdVNOUlE3dVBwb01LeWVqZWk2Y2hZZWJZVllldnh5VXRvbHVpR1J3?=
 =?utf-8?B?REZrRVlrQmlUUTdUTFR6eEhTcGxCcWQxZGJ5VXhpdHozclpDR21FaGUyM0pW?=
 =?utf-8?B?Q1FwSUY3c1ZDY1JIUEN4cFQrTlFITDRMc2VVSldXSmFicXRYVFRidXlZMTd1?=
 =?utf-8?B?UkRRa3pGV1pJcGJoK1hMMVlDMEJEV3pYbXJycEZyUXZKWDNZM2RJUVlQWFNu?=
 =?utf-8?B?eU9GUU5xNU5tbU5QOW9OZnQrRnk5UHhqTTFPNGF6VmtTMHdoRFhoTW9VTFFv?=
 =?utf-8?B?aTJQQzVoZFJtOVlCSXRpejZ5Y1h0TVlqblV4S1NBTDdFZTVXN3hRRkRhWlBB?=
 =?utf-8?B?R1pERytYZnFUbXMyMG1UdU5vTk1RcVordHIyZ3Bwai83VC8vOHQ2dDcvSWc4?=
 =?utf-8?B?QUo4UTJ6QXdSK3hMd0F2UEVFN2lXbmtSRGhFNGcyR1JGN2RTeXhxZWplKy92?=
 =?utf-8?B?L2hiRE8xdFRUbTRjeDI2VVc4VTM1N0dMZU85akdEUFV2MmI2K3l3OW9qNVpw?=
 =?utf-8?B?aHlvaUxHUWJYZTZaRUw2VUFJZzhvcmwwcnhkV1BEQ2xaejZBWmkwUnBVcmZM?=
 =?utf-8?B?dklFdXdGblpxK2VZV3hxVkJpWHpnMXNnQkVsemNTc3ZuMVhZNkgzemhVS0h0?=
 =?utf-8?B?QVVmMHhLbXNwQXdUaG9RVXNIQlEwczh4dXlYNk5QVkJjZDI3WThRQ09oYzJN?=
 =?utf-8?B?TXlkVTlFbjBNSmZlRjdPd3NGb2plWGJOYVE2L2t3VWtFWU5HVnRPOElGUFo5?=
 =?utf-8?B?bHNEcXFIT3NOR1JBMlZzSUxnMkVkbnoySDRSZ2F5b3YvZ1R1NWl4YjNQT294?=
 =?utf-8?B?b293dXJYdTZ2UjN2aFhpQytQditqZzNnZGJhYnJvU1VkVlVIbEN3Zz09?=
X-Exchange-RoutingPolicyChecked:
	qspwkdqmoBafkYMQhsFEmERK32uypdXbjMW675L5aLsK8INuYs7G2cCIyXNPcThqTp+Cd93qiNJ+0EXWu6RJpYADHIeLgIySwB3UHeroruTiBvYrYbIL7MoVQ553+UR58Ggi0WgPrd6Lp5erYJyxPAexF/lxCkD6Sxbh3+l33Mvt77kb3+Wl1XSE6JrbWSG0kXaxreE9Qknw3h1F/kM/SPID+QYzwYixb/mNkBw5U0h0dZ0Zp6vg62lrroKXv1MNZENkAwAY6zfjXaFb95zvPHVMHD9nNnK7wDK9xR7YccE3bj4nj4DXXj0rmpYalkRCqxqbzPUdeE4ZD7qC+BJE6w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd392e0-16b4-45e5-8475-08df43c48e5a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:32:39.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXsuyBvTu/FiWBNPDZ2NTo8swcy/DFBynMyD8YtmZyVcUWviehpMyTdjvTdhP/6qemDAxY3hcTC5ijr9Yq0b5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR03MB244572
X-Authority-Analysis: v=2.4 cv=Id0Symqa c=1 sm=1 tr=0 ts=6afacdba cx=c_pps
 a=NwWuzY5ekLRC++Nx77IK4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=CwG3jFcDm5JwjTP9pW0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BhcYFSqAM0kGyYQh4Y_-CowJaOI8_JOi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNyBTYWx0ZWRfX+lAFkNCSfTeh
 q2vtSKTDDO5R09Rm4vdQEKnFGsoSO5dV9UrxqmRpgBwEHL1sI6STEjsUVmH1CShJIhCCueRoLaM
 yt1y05wwR+PDUm0sLo3tefAlUf5Od0o1+bh8hkC5El+Sf/HI263B
X-Proofpoint-GUID: BhcYFSqAM0kGyYQh4Y_-CowJaOI8_JOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNyBTYWx0ZWRfX1J2pB5iRpFZL
 1EYTYCxVHGoM/7eG9hDvnXJgd5FM7zB5pqvK9Ic5gpN5ERdum8HuC4iSq5ONd+Hv75xliCG3caR
 nOPyjOpqEApyvU5uSPc2WW6lQuurQP76Ei3v5upn3GAX7Lfg2lBSEz3Ka6bOEnL93qkyJ+Nta26
 qXojuMUn9NhJnKVpN5ief4TIK9zazN03xnwIFUvVfgfTkA3SUEaOZSqBU7ReJX9KDiF9BOT0QY8
 97few+ehDjpFCwLW2yuDI+pXfXhlUnBppBxXskNyOFXsfMv1z5pe13dRNa6gGWGC7ZUMS/mFwC9
 0MOpCVi+WKwwo+C6AbJ4vA+SarjpuWFFPMOxxTgVT+MN3I/d63F1zhXgcG6JtQcHSa1aAgkWXa9
 +lRI1POu+6Vg5h2B6RSGi7E2pYWCSg1M6GW2WrGIEjIKtupqD6l8sWQDtZLtkfgX7TMBzj3Y4Ek
 tPGfWIKPnfmpiXetQWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160037

On Fri, Nov 06, 2026 at 04:53:00PM +0000, Nuno Sá wrote:
> The bounce buffer used by iio_push_to_buffers_with_ts_unaligned() is
> allocated with devm_krealloc() against the IIO device itself. Since
> commit 699fb50d9903 ("drivers: base: Free devm resources when
> unregistering a device"), device_del() releases the devres of devices
> without a bound driver, so the bounce buffer is now freed from
> cdev_device_del() in iio_device_unregister().
> 
> At that point buffering may still be enabled, as
> iio_disable_all_buffers() only runs afterwards. A trigger handler
> firing in that window copies the sample into the freed bounce buffer
> and pushes it to the buffers.
> 
> To fix it, allocate the bounce buffer with plain krealloc() and free it
> in iio_dev_release().
> 
> Assisted-by: LLM
> Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

BTW, realized the other way the LLM tag is already outdated :)

- Nuno Sá

> Found this by accident and do note this is just code inspection. 
> 
> I tagged the original commit supporting the bounce_buffer in Fixes: but
> to be fair, the original commit was fine. Tagging 699fb50d9903 also
> looks bit odd but maybe it's the real one to blame?
> ---
>  drivers/iio/industrialio-buffer.c | 6 ++----
>  drivers/iio/industrialio-core.c   | 1 +
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4294101810fd..cc5fde0f5191 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -2464,10 +2464,8 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
>  	if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {
>  		void *bb;
>  
> -		bb = devm_krealloc(&indio_dev->dev,
> -				   iio_dev_opaque->bounce_buffer,
> -				   indio_dev->scan_bytes,
> -				   GFP_KERNEL | __GFP_ZERO);
> +		bb = krealloc(iio_dev_opaque->bounce_buffer,
> +			      indio_dev->scan_bytes, GFP_KERNEL | __GFP_ZERO);
>  		if (!bb)
>  			return -ENOMEM;
>  		iio_dev_opaque->bounce_buffer = bb;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 825cf7f32059..ed097eb8d799 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1727,6 +1727,7 @@ static void iio_dev_release(struct device *device)
>  	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
>  
>  	ida_free(&iio_ida, iio_dev_opaque->id);
> +	kfree(iio_dev_opaque->bounce_buffer);
>  	kfree(iio_dev_opaque);
>  }
>  
> 
> ---
> base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
> change-id: 20261106-iio-fix-possible-uaf-853ce6ff96bc
> --
> 
> Thanks!
> - Nuno Sá
> 
