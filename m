Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020086.outbound.protection.outlook.com [52.101.171.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E3379993;
	Thu, 24 Sep 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255149; cv=fail; b=X9ilKk12H7rmNsoR0R5ggqtfwBSZ8G0nqBy+1HJW+tk8NZ3ol0RPlL2SVu6fx72E+zDIDKXVm1YWRPro+TNvu5BAalPa3zlEfDTZEqrjBxgqqpF5jgEbmjxf4dRDf1+T9rmCq9UnlbkVdhMMzatOuk7vj16ZW5aQsAl0cxeTIl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255149; c=relaxed/simple;
	bh=680kWDAiI51Iip1R77Wh2HeSwXUDsPHiU0q4kj4omMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fSAxKcdCY4el3F+RnF53ArLc+ouN2FFuZkTnhbdAOpCcyjqMDqa+ywu7nzTIg/BaN6PJmDcjSQJc94EMBHJE/rKOaJvE7Dcc08bzTAP9RMb1HktWKmHbdJHpt9jkgBNYiEY1vWyAKwYSgFGaxEMTY6Of1F8QgaD/7+jtJDQFIQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (2048-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=LmpnpQAW; arc=fail smtp.client-ip=52.101.171.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="LmpnpQAW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHMm9UerG8ZToRh9RYVvWDxviLx2a/b4Z10qOnCS8SYKTiDF8R4jpD2ZtG8KzJNDxKUVT0T8sz08w3mXEmgIBzMrNxMRijrOtNoXjKBeSQvnGDGfDywm3EnTL2K/qkICxAeJzQAwhUngiFOoXpdx7nKDrDvxpurn/hyXmqivmR4mpFmCeRY8BbX/KOGjqs8qBfiV+Tu7aPGYZLMCcpejE2BV0nMUUQzEl3yAHfOzSsAO8cR8P/sX9FhmWteFM0bLT4cAnnBe2GQbz9VD0ou3Kp0Hd6IRkMDQI3LzMefdIcgqTRBT2DznIz+zaBmCYfYAkW9QCaeSUnJSW3NmgjUl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MrLZSFATOUY9YYXjeM+cOwsLhoZfmNb3xcbBpYg0cg=;
 b=JiPlQiq/c4PSHh0GRUqo46wEcb78gAonBJUR2CeWoReKJIL4ny3koVxRlzk6fxUlBhrrR6LA46N0tF7OLQc1jTfoFNr8Skt4QgQeKn+qjp2OTpgD7l9KSiDlzUwJjagXo5MqMsGXF8PGpF8FydQ6kjo5tJ2MQD3E+o9xgeZP3tJMyNqwdvNpDfJsr5i7g1Vfig6Z3qOFPr4KXkgU+1m5Y2SVrV8P5Ee0/DRG0uL4FUNxEP7UQZfdgoa0eO0Hb9VWtU/aCrq9n9c76IlEgVEUJj4xuyWCFIrrs2L60rGvnP7kni9odkZ7z5jrBWFrEJ+tWn1VaXSxzrDZT3gwWjHr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MrLZSFATOUY9YYXjeM+cOwsLhoZfmNb3xcbBpYg0cg=;
 b=LmpnpQAW74PEkfSooQj1PmHqiK6XgZj6f4W+3OZO6TI8Zn5jp8f8o9lG/1PfTvyMi8KrDctnbUbioBs/Y68m+huad6ve1AXWGgxCca8f12QFfOjFOhagdNNuLbqKbrYOdjpp9aVZFUSjlqOTmLvIWT7q1YNSzEJ9HZOsFw958faguj/pJkFvFKDghuQntIEPqNN2ZH4Kw3P7N6esypEt0Mzgt5oeIjDQhcqqI8sb3xOrvEs7OUOU+hlOZNIV9nfNTPQzP2dQ2GAWlRBybsmT/DU5dLGyx/0n58WMQOwkO1TtTVsi6bwmEC+UrBni+LE4dY8cynKZbTVdPNXHsd/6pQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FR6P281MB4358.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:05:35 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b702:622d:f947:9d55]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b702:622d:f947:9d55%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:05:35 +0000
Date: Thu, 24 Sep 2026 15:05:33 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Guangshuo Li <lgs201920130244@gmail.com>, kernel@pengutronix.de, stable@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] siox: fix master memory leak on registration failure
Message-ID: <arUeFAzLtzsIQl4G@NB822>
References: <20260919181051.3751829-1-lgs201920130244@gmail.com>
 <2784d61d-99d7-41f0-8c51-7736b788dc6c@web.de>
 <arEpuhA24xUlA-vw@monoceros>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <arEpuhA24xUlA-vw@monoceros>
X-ClientProxiedBy: FR4P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::18) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FR6P281MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 29815ed7-f8a0-4e78-c219-08df1a3c8568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|23010399003|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	4FhIabZQAubYZiVCjGnCalvBeGUwxVEtLW8tikTj8WK6ZWwPJbUTTnJx2SMyV87J2nsujxvXbZ9hfoyETvT2joRusCu+FMeVvN+BpxfiemZy6+OQKPE7L9FuzwIMaV9W6mwVHKhB5OKcUaUCDmd3nCL8nnHhPBlyE6c+aS/8Q4SrMF1KPfwcZ7GofTZKQoUEEiu7qXyJRZE/PcUSY7u1fAz1pkrq4OeZy4fT8FHPu6JL8GxEAAtBqN1xELmXpKfuLVECQ5m9FJKm2lHx7TfoRTkM3ah/8gSZN7OQHoVLZCg8nBYRS4pFv9ykxqEjorPEwrpVnHwjqaRQdyE34jLNo50V1BSjd09XHw0cKaZqUx5pIW3ClCGENPKK2utnTcX++Zb4z7aVuR8HTXaKTGsAEVt5zieEG9Kcv52wvP7jhRsEiA59/z/DOzfsruNBRzMwdVnDQcm95Z4qJ5QL0PNSaaZx5oietPqmufad4KrUePmYSosqXdICg17FAFAzaYwP69sJgqoJmNMGLgKVQK83AeYWZWVdVqjDRdFSsOn2Xalm40LYqa2vLOqLr2UlK+LLzmp3YNhQ6VPlOI1KqeFbYCjC7PE0S6G3A3/ew6ss/B3mGNTC/GbEmR/+CobBXqXHr1XsCobFosg4Tc6lrpNHVL4txRrO7VFf8KvChTOJ0iE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFEwM0hZOTdWempsMldZM3J3YW9DR0oyZERlZUlZZmZvZWFvVHpOeFlIcWs4?=
 =?utf-8?B?SXlEREJibzNDNCsraktIL0s5N2JsNjQzZ1ZLRjExRTRscEZCR2ZvTFpmVFZv?=
 =?utf-8?B?dUZ2WE8zay84RDZyN2N4L1YraFcyOTdIdzFmYStUOXEwZytjZHR1Sng1dWlt?=
 =?utf-8?B?WjEvSC9ZdTJFbWZsVVVkWE8wVW1IZTl1cFBXUVBDZzhlTDg5ZWxOelh2YjdY?=
 =?utf-8?B?UXNSeERPcmtNYUJRZHF0SVY1YlJkQmxLQVNrZTRQbTZqc2ZFeUx4dGUvbWtI?=
 =?utf-8?B?eHh1Q1V0UkliK1dFVS9qR3BFeFE3VmFzNksxaGZITW1JVWVOWU1Mb0xOUGtj?=
 =?utf-8?B?Wms1dHJSZkc5YWtoaFZmRjhLUVB1LzZOVnZzSjhkcGJQSXR0RURWanJlODF2?=
 =?utf-8?B?TmRveFgvcEJOb3ptK2JtbHVGdkxEN2N4cVc0ZlVIOEc2YU5YK0puM2tudHhE?=
 =?utf-8?B?MzBZWllkZlZwNVZ4c3lSSGdTMUc0ZHB4bUtsNkpuY0Z2RmowQktGa1dJaG8z?=
 =?utf-8?B?aHk0NDFxdTJjRVB5ajRtWElWTFIxYzc5TDByQ1B0am1lb0oxemxqOTlIQ2xm?=
 =?utf-8?B?ZkRGSTNGOGVDanpib3IzVEFtSFJzMmdRdWl3VC9jWk1WenpLQStPSlF6QllZ?=
 =?utf-8?B?aE5IUCttZnhwWlJFcnk2S24va21pRTI1WHdjUTNxWHhwcjFyUDB2cUhVdWpB?=
 =?utf-8?B?dWpZd0preU1VaVplK0lwVjFBOWlNRFFVdUo5U3R1Mmt1U1RyMXFzMlcxNGhY?=
 =?utf-8?B?cDVVcjdsa0QrV0RzeVZHVlNONnBFK1piRzYxVUlxenRVb0JJV09Jdjc5R0NJ?=
 =?utf-8?B?bFpCYytXNXZSQVYwOWdEWU16R0J1Ynd2eHYvLzd0RTlZUmNNYy83TjdTWGtC?=
 =?utf-8?B?UmRSeUE5Smc2cXpqZU9MTVlBV2JXbCtCY1FuODZPemZYRHppT1VESnJXVGVD?=
 =?utf-8?B?MDJoMnNYTi9CempBK1JxdmlMMlYyN1YxNm1iSUltRnVwUzQzYlRHL0NNM25F?=
 =?utf-8?B?UzNkaTBiMUE2VFdTZDBLaGFNRFdIVkVXQ0ovLzU4NlRqRWJ6QjlnMElaTGdr?=
 =?utf-8?B?NWxzd1BXeUt6MmxXZkIxM1FjWmI4ODZPZzRzUmNFenRNaXFQRTdBbTM2TkRQ?=
 =?utf-8?B?UVpVclJxWHZCWUFxN2V3NHVEU3Rsb3p5TWdIalBwVWEyd2RxVW92aC9sRE9l?=
 =?utf-8?B?U29MTXk3UUg5b2IwYlE2YUJRWnhwYUVobGdsUFVPbGFnNy91eXFnTlphUmt3?=
 =?utf-8?B?aERnbHdvMEwvSXk1eHJFOGxuSlNpRmp0US94OElZdWE4cU1XOWVYcTYwZnJo?=
 =?utf-8?B?VDlmdDNGUjVrdkgrN3ZSbGVKaGtjcUR0Lyt1c3pmMzZRRTlPdkdaSFdwcjNS?=
 =?utf-8?B?ZC9wbVhCVzBvN0o3d0szMUJFSlJsb2lUb1ppbENFZGdiQUJwTFVCTUlGeWFz?=
 =?utf-8?B?OER6TkpyVy9PRmQwY0dXUDNQV093a2VRNVk5VDhoRk42YXRveUtLQitBc1A4?=
 =?utf-8?B?NWFhajl1WHZ6UnpYQmhwa0VMZnhydURZQWxNWVJMY1IzTFYrbFNCeWpwRE5G?=
 =?utf-8?B?NDZuR2pQWVRKZ2Z5dVpDY0dreGdKK2Rvb1FTMGtKMDNacUhNZWgzT1JlTy95?=
 =?utf-8?B?dXBSNXpDVjQzRGN2T2U3V0x4Y1Q0NGRJQTA0bWl5UTk0WTExYnZnWjk2a2JS?=
 =?utf-8?B?NXFhN2JyV2xiTW5PNzRKRVNNeWduVXFkNWhXN1AwRTIzSHM3Zk54N0p3Qi83?=
 =?utf-8?B?OTUxanlLeG40YzBMTVl2b0lHZFVZZ1pkeHg0enpFZllXZ0dLVEdPWXlMUlEy?=
 =?utf-8?B?V2x5VlMrN0lwSi9ZUGwwUEF4RDhIc2xPdS95bk43NU53ZXViZ21NVW9Gc1JW?=
 =?utf-8?B?NFcrbGEzQlJOc3BIRUhHdTVTV2s5dE4zbWExaEd3b1NVK1ZHczdheG92eDZa?=
 =?utf-8?B?cDJ5N01wR2tIUVFTcmJLMWhIR2xhZXRmZ2xDN0lxSWVLOVU4WHZjUW5rN1Bj?=
 =?utf-8?B?clc2ZVEzSmtLZHV1Zkx0Sm1RZHFYeEQ1eUViWXlEbXJ5NStTem45Wm1kSEth?=
 =?utf-8?B?cklrVTdZUGNiOWhRVklSTjZVaTFQaXZjQlV2eElTSjY3azhVdnZ3MUtHYTcx?=
 =?utf-8?B?ZVdCbkgrMzhjaTczaXJnNlpDdUozYWc1UnhKT21GWGhXZnlMUFNpa21PSm1y?=
 =?utf-8?B?U3h0QjlNQ2llMTJKWnhJSlYxUFhGQVdsN2l5ZVZCNGlYY2p0VFEzcUErdUxy?=
 =?utf-8?B?N1U2ZG9sc2NCdnVVOFBHV1ZSM2FwL2VSODlMMENkTHFQYm5tZzNnWGxzaUlp?=
 =?utf-8?B?MEliek5RTzdDSjhLbll3V0xUMzdTRWd2c1dxRk93c2ZzaVpPNTBPeGpOb1I0?=
 =?utf-8?Q?EnajLFB2wmMHHEY6leKrYQKaTIswnYPC/a9WCqS08hjKU?=
X-MS-Exchange-AntiSpam-MessageData-1: T/xeU7NIN3IjBw==
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 29815ed7-f8a0-4e78-c219-08df1a3c8568
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 13:05:35.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usrjQVWIV3FMwR2Zlp6L4oFVKPhsNRBa8zZuuit6nqCe+OrePYFaxBCtxWvrAa1LKKyejqc15Op065bBeG3kgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4358

Hello everyone,

thank you for the patch and the input.

On Mon, Sep 21, 2026 at 03:02:01PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Sep 21, 2026 at 12:51:00PM +0200, Markus Elfring wrote:
> > =E2=80=A6
> > > +++ b/drivers/siox/siox-core.c
> > > @@ -753,14 +753,21 @@ int siox_master_register(struct siox_master *sm=
aster)
> > >  	smaster->poll_thread =3D kthread_run(siox_poll_thread, smaster,
> > >  					   "siox-%d", smaster->busno);
> > >  	if (IS_ERR(smaster->poll_thread)) {
> > > +		ret =3D PTR_ERR(smaster->poll_thread);
> >=20
> > Would it be nicer to use this variable assignment directly before
> > the goto statement?
>=20
> No, please don't, IMHO it's fine to have IS_ERR and PTR_ERR together.
>=20
> But I wonder if it's sensible to create a function to all the usual init
> stuff such that the error handling in siox_master_register() can become
> just:
>=20
> 	get_device(&smaster->dev);
>=20
> 	ret =3D siox_master_init(...);
> 	if (ret)
> 		put_device();
>=20
> 	return ret;
>=20
> Having said that, I wonder about the smaster->active =3D 0 assignment.
> It's quite some time ago that I wrote that code, but either it's
> useless (that's where my bet is on), or this assignment is missing in
> the error path of device_add()? Thorsten?

At a first glance I'm with you.  Assignment doesn't change anything.
But I don't have a clear view (on the whole context) yet.  The patch
seems legit and fixes a real issue.  Having said that,  it seems that
there is an additional imbalance at siox_poll_thread.

I will have to take a little time to swap siox in and get a clearer picture=
.

Coming back to you soon.

> Best regards
> Uwe

Best regards
Thorsten
