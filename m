Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013077.outbound.protection.outlook.com [52.103.46.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688D27AC4D;
	Thu, 10 Sep 2026 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001261; cv=fail; b=rkkz5XXSoKn1b+SJxrjtmZ7bwSNS9512WH6k/REAuOIDTC0NL3MJFA/xQXH/ixsW5jEe0ha0VplpqwS8UiT6Zc4Ve0HTqaN2FVYetN6/KFYQNdJBEZdEdoBMMDwRmaDoykpol4+b2VKL/ybXEofWzlebV6JW1iiGZYbox8Pb9ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001261; c=relaxed/simple;
	bh=hZM408lgly2Ads8t79bOUsRZQq/HhMsIvp0O/OOqDJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8FwrQkRcYcAJuGWwKnrIbvq7cJFzbjUWPcz/wud+mjJk5r231ExlzjGplXT2BoPDCIzAi842/wXJUCgFsvnwNxq8Nm1qWtbeIxS/InR27smII5T7Y2RPBHOHY30TxsW9WBqI01qlwqEIXQGQ41UUvknGClWFjUsdz3Hgeei7zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=mFHNHc8/; arc=fail smtp.client-ip=52.103.46.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="mFHNHc8/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDePL7quqIYm/sVPboD/G8qqruFuOGIAJhVvHV6J7auHQG5sQ0ISPrYYuLUGKRszfbFksD9NFCoee3QosxKaaV+u9P4AFDCswhvPLkG6+doWRfdSDQpt7rbg7Ztt1V4UvJTa1fAZBsBbKddfymMo12/frSqOwA2HwV0C+q5OhUcHFmNDEoqeM49b4vwiWkRjj6xJV4/sDrSAEJYpOLnOkJ0MrbbfVq+BAUx6JngZ0DV5OR/d8tlVPlyel/2d+JhTZNVLtzcLihIRhCWECwORjYmf3jekYItXzbQ7dPYOml1XGlJPTRDdUTrEmLK4rcnc5pNQlAkqYR76Rn3ZVLSaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZM408lgly2Ads8t79bOUsRZQq/HhMsIvp0O/OOqDJI=;
 b=fxRpwlRDMtQ98c1p+TI8xbn91QIUeg9b0Wu6meHVEEnYRP6nX3nzoQluSUrI+l3ll99KH3PFrOrh3YGlFqTPRoVunselk7dxL/25M7B1oz6wxLp/1Z5cm4DvV5ErjwEc44zkO9vIuusVtIzJbBCx+JyZ9/8iEg1NmU6DX8gehcJK97ZYLfTKRW7mQo9qAkC0IC+FydOqHZ6ZmnD0YAJYWdR33oek1/U1Z8XBrb74OFo+ojiYenDLWnusrAAE4AxSf0aCA9vqZI3FOh2ajbWRysKWJbNJwaBCMmlGsmy4Avusj9KjQR7PLDk3l1O4azLeabn6nmlxdN2ICXRZz2FYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZM408lgly2Ads8t79bOUsRZQq/HhMsIvp0O/OOqDJI=;
 b=mFHNHc8/izNqr7d5XpGJOjPjQop7tgXF8MGdhDfHt5H4CkXJH7tc1yweQ6QuJSF72PtycQzbPsQ4TfIYzMkBeN/Przz6tML2E/j2NPRN1PzWK5ikk63uoauhlmbPSD0nAijrfTvdkFyeMrxhCM3YnjUkPPukmVEspzYbmh+GLO3MusgYt4c1gVbYwHqTJeTxne5/XTYI3fygo0JdtXeSdyb/dvFeonCZwcB8OGF2KgtzPnDwcAV6STN2mH80h7ApwlRWt8VSmVE2AYdKrqJtlWwqSIl6CrBp+zRo/Tj+joXgJ5LiOY6POBCsL6HTX/eQyJAWOqfUjdWWWLltUolbtQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AM9P251MB0110.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:415::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 00:47:36 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 00:47:36 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Drew Fustini <dfustini@oss.tenstorrent.com>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Kees Cook <kees@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: tenstorrent: Assign .num before accessing .hws
Date: Thu, 10 Sep 2026 01:47:31 +0100
Message-ID:
 <AS8P251MB000160067A8B595BB9D743E8C8BF2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <ce401b42-9dfb-4c8e-9051-7ba08c107382@embeddedor.com>
References: <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM> <ce401b42-9dfb-4c8e-9051-7ba08c107382@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0121.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::18) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260910004731.32818-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AM9P251MB0110:EE_
X-MS-Office365-Filtering-Correlation-Id: d23f1479-d026-452a-d9b9-08df0ed51ba1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|6090799003|25010399006|51005399006|37011999003|19110799012|24021099003|23021999003|55001999006|25031999004|8060799015|19061999003|26104999009|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnlDc1RHbzM5RGFXNmlvcTdGS2VEbGwwYlIxWE1vYyt5QTU0M0pwaGovZjFU?=
 =?utf-8?B?b2huSS90VUxjYitzSDN2bE4vb3hNUmdlRGZnSFBwVEQ4ZytRUHpkVHVKOTJp?=
 =?utf-8?B?NmJnV1p4Z2xWbUNObkw5Ny9TMmVIc1dGT2x2UUNnWHlKOTI3NmgvM0FwWFgx?=
 =?utf-8?B?SHRUNWRxdWVrZVpVdHRQZ1QwcjA2clNzdUg0RmhzaVhQSHh1Y0RsdXFsV2Nt?=
 =?utf-8?B?SmRTRTRxTzhiSVFCYzlPYXFPOUIveWkvOWxvNHF3UU55S0NlSktLb1NzTVh3?=
 =?utf-8?B?c1hDUUlhajI4M2NxMGRBVnpuYXFKTTE2am51U3c0OG9pZDl4WEVuNXBQZExF?=
 =?utf-8?B?WHZNTis3a3Q5empTQ2pwOVRrQ1VEemZ2aW1KWDl0TVA1aGczRmhNYTRKZ1Jj?=
 =?utf-8?B?OEgvV1Z2SkN0UGhIL0w4UW01RVBUejQxbG5JbDdoVXVWMWN5ZXB0Tm5FREZj?=
 =?utf-8?B?OWtBa1V6aEZ1YnJGRXBmSEhUUzlkbDF5LzJKZXZQU1dEWWo0b01TTS9DRVBQ?=
 =?utf-8?B?SXlxOVdYeUhKa203Z0JUUkU3dUVQZ1gvU2MwU2N5WXN6TXRSY1Yxd1lqRFU5?=
 =?utf-8?B?clNhRGpvbkw3VDhmbXErenMrdCtKTzZFSHgvbjZmMW1PTFJkSnhLU1pEN1Qx?=
 =?utf-8?B?SUo3RStJVm5ZU0doOXdyTDFubTlKTUR5RDlTWTZLL3R1U2Nvazl4aGU5UHp0?=
 =?utf-8?B?WnF3SDRqV1hIUDF0TElnRllxZE5STjN5NmRxQ1daSGNCZEpwczJxMXN6VmdF?=
 =?utf-8?B?M1F3dFF5K2FUdWRBVkhpeGR5NEZyRzJGMFJTWkptMkI2bmp3b0JHdEhhR2pI?=
 =?utf-8?B?bTBwSnNLRGJRK0NCYW9xMXVHazJScDlURE5WTzBYRTB0cnFCS2F5WlFUS2k1?=
 =?utf-8?B?SWYvRzF2VCs5eTFUVFdWb0dEbHRPQldjUzdQVnBhdWsxQWg0MkN0RldKVDQv?=
 =?utf-8?B?WmVWZHVaSEZ0QTU0NEdVMjZjMTBqWGNzeThEQTVYQTFKaXhkSittWE1CSmpp?=
 =?utf-8?B?NFQ0OENWVEo0bGRTUVFtbWE4bkpwSFQrcVFGekMrSEcyR3VMLy9DbmgzWGhy?=
 =?utf-8?B?Qk5RekxjQXhDeFI0NDM4ZDl0eUVMQ0tXSExtNThNdmczVU5YUW5WK0ljY2Y1?=
 =?utf-8?B?amxHVUVmaE1JWGVJajA1NFRRUzFOTDVlWUNTTXVnelZNb3R0NC9vVW9hdUF0?=
 =?utf-8?B?RWE1SWU2TXRPWmhZVU5Eb2I3ZU1tOHF5cDZubEZnK3o2SndKeGxiWEhFcW9J?=
 =?utf-8?B?MC9xUkJydVcwVVRyd3ZZOFFRWGZ2a25oL0kwcXZFQ2xBUnRvT2QrV1dvMEhx?=
 =?utf-8?B?QVh4OFN0bzIzbWNDNk04UVVtSVpIU09rejV4SytJYkxKVnB5T3dTdVBOcXdO?=
 =?utf-8?B?emN1SnFKbU1XVUNYSHhkbWxFWDUzMzBZVnF4ZzZYTXNBWWEwcWdiZGVsZ3Bu?=
 =?utf-8?B?SVRkYnJ1UFZZZmdYYWlsZTRCdVhMS0ozVC9uUzF6OWpsY2M3VVJGTldoMklE?=
 =?utf-8?Q?itd7w42bAt6eSD1KmWCOGLE4H6s?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVk0MDFDdk56a0pZSkxya2FBaWFWMDUrdnJFWWRXWHg4NVlORDN0QWhvWXdX?=
 =?utf-8?B?YjNTbWZsdEYzUmp0TjdKYkVRWFR2RFpBaGdFR2NsdXd5SCtMLy9UdGh5OUJY?=
 =?utf-8?B?ZCtjL2h3YXZibGRhL0x4R0k1UTVEQUZ1Zm9OSUFsREtvVGUvcWJZV0JuWUZK?=
 =?utf-8?B?d0wyREhtS1diUHJjN2hCUGRmVkZxMmt5ekphVlFLeEdBVkxuNG02VEZOaDM0?=
 =?utf-8?B?MDhqcThqK0VXbzJVRkFoWmJ0N1dYVzJUU2hNZStuekFMTTBMeFhBb3FLTVJC?=
 =?utf-8?B?QlF6RVUyd0xlc1BBN21McHd0cG5uUUk1Ly9UU0JDQ1RyMFhBMmwweGZocGZ3?=
 =?utf-8?B?RmV1RlN1U3ZzU01QRXU2Tyt3NFdHMVRhNkorRTRLcENPdHM0NWlIU2UrQnM3?=
 =?utf-8?B?QjhFWmFzQzVzeWNuRkRoTC9GaDdaQWtTMFVhaTYweW1qQTNGNzdWZzR3ZWJL?=
 =?utf-8?B?bnUzR0J0aXRqdTU4TzhGTXpTeUFJNFR2Zlo2UW0rQUtsZjlLL3VuOVFFZ0Y4?=
 =?utf-8?B?YWQ0THFhY3psazVZYlpwNWJ3am5YRW1KdzFsdlJDbXlhMTBVekYyVHYzTEx5?=
 =?utf-8?B?MmYxMU5HQmVmTmJpM1IvMjZ2YzlJdDIzN3ZNR3MvN042UGxBRE1zS04zSFdZ?=
 =?utf-8?B?eGE4aVhYeHUyVWVlaWszSlZmQk1xSCtsVytKQXF6T3R0SjArcjRWZlhEQUZt?=
 =?utf-8?B?alppcGFSWWxRWE4ycDF3NlhFVjRYTXF3SmZnbTJrTDNnVzZadGRlK3ZObTBu?=
 =?utf-8?B?dnF0aFIvLzIxQWdOSHRSUVFBMVZnRXpZMEF6c0FuRWRCOEx4bWRzNVdsM2lk?=
 =?utf-8?B?cUVQa0ExUUdMTjhmRE11UWtsZjl0WmJSb0krZXRQNU41NmZXM21wek1JNm9p?=
 =?utf-8?B?REJPSW1xVWF1VE44ajFSR0hWWmEwNWtIWlpqeThRZU5HYUtURzd1ZXN6Skhy?=
 =?utf-8?B?ZzBFRFNidTlxUE9jd2E1TUR0RERmUWV3bnN5SDU2dy9YRzg5bjJFOE8vVHZC?=
 =?utf-8?B?KzNmb29HRDJFaTI2UFNJUDAzM3FDb3ZTZHVVTHVJVXBwSXZGM2thcG1wMkVD?=
 =?utf-8?B?QnJOV0k0RE45dTlUdDlxSGxSWHl5ZEJZUzMwWTM4Z0o4SWZHSzQxVmJxT3Q3?=
 =?utf-8?B?MUxSMjM1RW9JS1JFa2dVMHFiM2d3NG9mU1IrUGJJMTE1S0VGbFdNeHdqY0pW?=
 =?utf-8?B?V1BwWUVUM25BZmtXMjJHbUZoRHZNd3JHL1BhQ2UzWnFVSGl0aDVSWWVHbFAz?=
 =?utf-8?B?MTl6NEZoeStmdjYyemtKNlhkRk9ONkVhUDZxSndpWWpLeFh5U29HUFN5cTQr?=
 =?utf-8?B?M0t0RWg4MXFRQWozMytHYmJYSmlpV204TDdDMXpHNWZGbHNtMDgyRGg3TDB2?=
 =?utf-8?B?azBsT3B3QW1YRHdpYjl6dHpPRHlFWUYxMzU0eXZ4ZE42Q1NjYXp5WjVnYS9i?=
 =?utf-8?B?UnBPbm1vTnBRdUpaWUExNjRMaUo0YStHMm5CZXFsc0hMRUdaaUhZcjFuaHZ2?=
 =?utf-8?B?REN6dGs4dDFOTGJMeDVPT1B4K3ZOakMyNkJ1dHNjYkQyVk4rSTJpRTY1eTY5?=
 =?utf-8?B?bGJBeVNMWWl2RFdPcCt6RmdESyswTGttcm52WkJtNzMzNng1MENRbnJ5aDRx?=
 =?utf-8?B?VVhGSHB4Q0V4T2VrdWtWb0Z6R1g3aDVlU3R1dVFuNTBaM1J0OGdXSmI2Sitw?=
 =?utf-8?B?Uk1sMzQzeTJYWlFPTDU1cDJKZGZCSmUrTmpPaGxPdDNodWFUZVZ3M3htSlFr?=
 =?utf-8?B?WEtkMTVVREpoYlRZTTFSWXVPMzN2K3JWMU9oUDFwLzliL1VsRDczOFpmL2VH?=
 =?utf-8?B?ZTh5akFLSXlDTnpwdit0MlVKV2VNWUpHSDdIamQ5eHlyak5XYVpLMi9PdC9q?=
 =?utf-8?B?NjFMWjgvSWdmc1JrMjRFSXpUb29HaURla09RbTI0a040R2xtenFzbWR2Qmwv?=
 =?utf-8?Q?IvDj+zps25/16mJWYb49pAeyMdAR8dOD?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d23f1479-d026-452a-d9b9-08df0ed51ba1
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:47:36.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P251MB0110

On Tue, Sep 08, 2026 at 11:56:12AM +0200, Gustavo A. R. Silva wrote:
> Looks like variable num_clks can be removed entirely, and just do:
>
> clk_data->num = data->num;

Yes - it is only read once and data is const.

Thanks for reviewing, and thanks Anirudh for testing. For the redundant
variable, since this has a stable Cc, perhaps we can keep the diff
minimal here and I can send the cleanup as a follow-up once it lands?

Kind Regards

Aamir A.
