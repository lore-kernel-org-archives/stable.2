Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DE4F3EA5;
	Mon, 21 Sep 2026 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017097; cv=fail; b=qoyz619WCM0zGk3HDe33t1BPWSFX3FJ28VdsU0aD3v4/5yOhT0e8hfTZAqw2zX/myWeLp7we6UoeCTseBpSd8ohZMmmiQZtnA8G8x5lDYd6qBZ9IN5JmiV4T5Ure2rjYt9OBTWro8zFC7ifXQMfaf99zPaaVuKpPguyZA60SS9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017097; c=relaxed/simple;
	bh=6/B+jZEGMbqcwGXOOh9Xn8Z4pQzHUVJzb2jAsX8OA3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AKagbOUAK2H58HSHEeC670/nuywfjEp9AvDrRmuQtZnrB2egx5a84+eJnhDcLMwdRrD1Tv85C+JQm11/b/q49Z/16gtwK86MU2gfrNSoncGpBwzQJyZNFD9cAtcvgqXeFAzcRcXPHA7hSQycCQxIbUL+U7KLWiKCV2iz+eb69hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FSh+ZFM/; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FSh+ZFM/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCLdL0ILc2dzb+S4yfjXcVotHqYxETfPHL/OFetFaBV+eJ8IEn4MGxBfq+/0ojRrTPUSk5q6hZLGifkxujBY0KczptgOi5lKfpOaxmetpFG02EvjNf3lCdPDOEFuJVTWOSm+HxyS+on5d7hHpNKmHj3xmj0UY5iCsWHgg1Dg3WI3elf0oJBctaniL/6Ry31Lfh35fOQFDhWvGvBBvZopPyXJAAd446rWrD314DMhVjaDGI+k0QyjWmBwvha3uKlF6U4Li66WiOID26dSLRWsAeeir9b4EO74YMlQnaaLwosDkigKG/rsb2GDRBw1Dffi0mhuSC2gE+uj2noYpXHAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLhe4EoRTAgOSSg3PTbpKMzqI3dpv4yj6tzZGPmrH9U=;
 b=qe6RGWcEyqsVPGCutbAFpFmUxQcYs0VnhuvlTQ1vVyj9+OWmE+yuFqeIkhO/3uk7rohYjdBMcZXD1ypZq192isix+w5TDGkZIwOst+mq+ua6Qu/QNE7EwHv2IXiqQ2sMzcJY3YZnuunHxDxmqimNaJbuHF2ky+34v+j1BH51SZtWVJf5+Yaj3bdYQJGnwaCHSeDLY5tuU4nnQB+0i7m1gTmDl+7U4lhG8XSc6FsO/N6I/ejws0j66ZwhnsE23wYmdUx2xu8bjrPLhRpsfaF06z6TUR9j5erQLHBOexG8eNu8a2z6nSvCRy8HX0ZK2Svpqjyjyfj10Qe5u+9voQ/+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLhe4EoRTAgOSSg3PTbpKMzqI3dpv4yj6tzZGPmrH9U=;
 b=FSh+ZFM/ALJpg0Ax3k8xeEJ5L2UzBiiCXThZzfz0XrGXPEPu+JV/etbj4gVuR2WW2dHAaqUs/W7Vn96PdhQVAOBZJ42LuM34fckHxku+x9JYL63pXf2ggyqZ+/uG8lyVqT9vyNzjeg0DnhfNgzp4hh9hxTQ2BEBr9HleeSTA7Ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) by
 CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:58:03 +0000
Received: from DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e]) by DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 18:58:03 +0000
Message-ID: <83dc952f-82c4-401b-8eed-f7aea38dc141@amd.com>
Date: Mon, 21 Sep 2026 11:58:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ionic: free VF resources on remove
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Kees Cook <kees@kernel.org>,
 Takashi Iwai <tiwai@suse.de>, Vivian Wang <wangruikang@iscas.ac.cn>,
 Shannon Nelson <sln@onemain.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260916053117.2906446-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260916053117.2906446-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To DM4PR12MB5389.namprd12.prod.outlook.com
 (2603:10b6:5:39e::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6d83d0-ef73-47ff-f911-08df181243d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|56012099006|11063799006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Up/b6ZDilWJQnEy7KJO3gCI92kxOl8kXra151iAqnuesGl0hvujSFuSu3p30W/z8LeaawlDhv1lEgeSKey345RO+SPLuUZD07vxV2N9+80UqJRJ55eG06s24O9WUxozy7X5D5DHWmnIvVCWc0e0uwBti2jBVaaSMH6ni80HySA0BRDb1tz0tIctMq3A/sYkUTGt2oOO1MpS4Lw2wSMZtmib3pgiMY0n339+sDSLKjKg8CZ7JMljZEBaorHY46TB86uHYHgKH2xipyXBb3+T2BVukoyaZRU5FG3dmeq8RgpFVQgHs+CodCOGDK9di8Q/plWAPXlXYF2F/naDJ67jT0Rw1WT4/iqwt0RtLd0zb7Q5+YOiz5eEPX9xwcnYIR/4v4CgoN2mCxx1GcY/c8uyCvkuFUhA5UVZmJIdmw/i+8TZkQyY26tYKyHm3gqqkbIxtd2c2EiVacLAmyBmQrggiSalNo/AblP3pcs50sLaj23nFb2iWgiCEu6epaa6xHNwdxCfREkXpwqObhy8Xm6XCMmY+P5DHyAKMMusIh9cCGwUp7YiI3io6izb/VxkDJBjinWdwYNAV2HwjIZLAciCEftLubFmZucVrKyZA/3phNx6yznWTizRelYZ654nPyTCzOBlUI5PgUM9dsbQjeHsHVcvWPjI8PqvpHGjnjrp3GI5iamveYni0inNv+hUl0oLST+U9K0vnvx/0wLj9Dql00w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5389.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFJzbDFNTjNvZmFiaFdzQmdVVU1XTFBnbmFyR1RJTWluY3hOQ243LzRpSXRo?=
 =?utf-8?B?WmtNUkVJSldWOG5nT3dtdXRURW0weEhPOXpFZjFYSkYwSFVYVC9HTFFJbkF3?=
 =?utf-8?B?WGxvWnY3T3RLTVhWdTRtUnN3dFYycDlNYlFuYWRNbFVpVU16QmV5OUNOYzRT?=
 =?utf-8?B?d3p5SStSTnRHQ2xLVVcrelh4N0tCV3BUZzJ2UVB6ckI4UVBXVWVPd1ZHVGoy?=
 =?utf-8?B?THIyZEZ2RXVZY0ZvbXg1YWdQeXhuZkxieEdLYUFTbG85TVJ5SEx0UUFGK01z?=
 =?utf-8?B?cUF4OXZQVEhxclo4ZEF1ajFXNG53ZjZtMnNJN0tTbnhGUGRtQUtia2JTZUgv?=
 =?utf-8?B?eTdMN2pKS2l6VGlCbERRUFo2UmZzblJQYzQ4d0hCOHMwOFJNOXVOMlBGVUFM?=
 =?utf-8?B?SEgyY1dPYm92TjFLWk8xc2JaZmpYejFjYzM1bFV6NmFrbFRKd3UyWVg0R3Vz?=
 =?utf-8?B?WTNFZWtoQzBJd1d5aTZ2K0d3ck9WU2xPeWwxcnRGOFQyUkVlZ1pqbkIrcW52?=
 =?utf-8?B?NnBPYWJkam9FdVpmMGJyZ096dWZ4UXM0aERXQjZWdW5BMzdpK0JwOGZDclp1?=
 =?utf-8?B?OWlPendWdjhTOWFBSUZ5R0lwZnNwNGxZa0dJMXRiSXo5bitBdGlqNmlZR2Ex?=
 =?utf-8?B?Z2t5ajFJZW8zaDlNdFJoaUVGbTcxRnp1ZWYyTkpkMUxlU3FCdUtlaUxKYzI3?=
 =?utf-8?B?ZEZpWXhNV0w0MElkcUtaSWo3eWUrc3F2NmJpTk94d2UwQlBrTWVXd1lRYkpP?=
 =?utf-8?B?QUE1NFN5RFV1MEJueVJreTRHTFV3RVNHNS9KdFFrYmszT2ZkTFdDS3J6UWE1?=
 =?utf-8?B?enJGeTB5Y2xiMVpIc1lMN2plWDMyZWx4OC9sRmw0bEVycitYZ055aEdJd2Ft?=
 =?utf-8?B?TWtUUHkyT1VVc05DZ2tOKzJIRFdyL1BnOFVpNGEveGNOa0ZlUnNVdEZmWnhF?=
 =?utf-8?B?anZyTlNnQTZLTStjR1RHWWtpL2FwZDUxanNENVRSQ0VwQWsxb3NhS3pIS1dw?=
 =?utf-8?B?RzhONTMvMDMxUTNWZkxhYzRoUVVHWnBnbXh5ZUdhT3kzZFB5MzF3RlpnS2ty?=
 =?utf-8?B?UHNsTEQvZ3BsOTdCQmlWSktaWmFsM0NvK0JNbGRMN1hDWVRLNFg4eUpyNDZO?=
 =?utf-8?B?WC9uSGhQUTlRK2VVUG1ScjY3dk82NzF0MHNxaU13c1U0ZnArT1BwS0tIa0ti?=
 =?utf-8?B?Z21QT0dXVFI1Vm5oYkpya0V2OUtseHdFaU93VWhYNHdmc2hoSk5qNTNvK1lK?=
 =?utf-8?B?Y0tkYWdIRm4rZnBHY3BDK3FsWHRMc1NjODI5QVRla3BtZ2NKeDloSmtEaWF0?=
 =?utf-8?B?b3FtOGlORUp6dUhnVXNuZGpwSjlTdStBRVZMZW4zeU1sZHFWTXFkdFJQNXVo?=
 =?utf-8?B?WjNsejBzM2w1VDJ4bGJpNlc5NXRiNExUSVJYNDdNUnZCNG4rcXlhc1ZnbS92?=
 =?utf-8?B?Wis1QkdHbzlXR1h2blZ4NGhZN2wzMk1FbVNUanVoV2RsTjM4N0MwdlBQRE9S?=
 =?utf-8?B?ZWlUNWVVNE5MbWlEZU03YzBPM0RLSE1KUnMrMlhkQXVjeG5Nd0pmdnBSMjcz?=
 =?utf-8?B?bXhEeFErV0grRFlWK3lpVlVtbjhCRU81SXNhamZtT2lITWNvNkE5dnpNOURk?=
 =?utf-8?B?S096ZENqa21xOXAxSjJFM0xNbS9MTHI4S0VuVEMvT0xpVEpna1NvZkhEb25Q?=
 =?utf-8?B?Ly9qdFpLRktqREtSK3hMTzFiNTlnY2EwYW16UHRCVE9Fazh6TWZPZEZZUkth?=
 =?utf-8?B?emlJWHBCQ3dIVVNPRk1iWFdBUjU2RjRRWXQ0VDJReUxsaE1FNWtMZEVkUmFB?=
 =?utf-8?B?dWJuMmEzb0xBTk5NSGhMU0VBa1FTcjFRaFljR0dmK08veTd0Q3VNZVJJemtm?=
 =?utf-8?B?d0o0L0Q0UnVkbFJUdEtGV2hjanJFQ2hJOUpiRmVOdGcyTmpGUnd2TnhQcURS?=
 =?utf-8?B?Tlh5ZWZGQ2RCL2R2UHRTOU9aR1RMcnZkTXlvT0tnUHNYNkU3dE9rT2EwRXBi?=
 =?utf-8?B?eTJ4UU9STTlIM1BlaDVhU1dySjgwcjJWNDl1dXJ0MDR1bnBhNjl0OVdMZkhO?=
 =?utf-8?B?UWt4NnQvNm9wNEY5ZHZ6aVNhWSthZjljMDBET0d4aitBSHFNM293QW45N0hm?=
 =?utf-8?B?d1VpbGxBOS9DNm4zMWcrbTE2U1hUR3ZqOVhYT0g1N3BWRm1tREc2UVZoZkFE?=
 =?utf-8?B?MG9ENU9lNjJXRzYyaXJFNUozMjB0ZEZlczlZLzlVVHNIOENtMWs0dktLRll1?=
 =?utf-8?B?NUczVGJQYXNwV2taUWxrUWVhcHB0b09CVHc0VU52VVRYQStFQkZJOXBNbUNv?=
 =?utf-8?Q?F/+AehUCvMadwbAih8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6d83d0-ef73-47ff-f911-08df181243d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5389.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:58:03.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdZstdn03mQEYBeUDTcXPJWD5opJo5pBbaKgIM5H1uo8Oxmximec0STZNCdp7vx8NEIMJ++bWtQUtQNR1k1r+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458



On 9/15/2026 10:31 PM, Guangshuo Li wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> ionic_probe() allocates VF tracking data and maps a statistics buffer
> for each already enabled VF with ionic_vf_alloc().
>
> The probe failure path releases these resources with
> ionic_vf_dealloc(). However, after a successful probe, ionic_remove()
> tears down the LIF and device without releasing the VF resources.
>
> This leaves the VF tracking allocation and statistics DMA mappings
> behind when the PF driver is removed.
>
> Call ionic_vf_dealloc() before deinitializing the LIF so the VF
> statistics addresses can be cleared and the associated DMA mappings
> and tracking data released.
>
> This issue was found by manual code inspection.
>
> Fixes: fbb39807e9ae ("ionic: support sr-iov operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 05f19489ec5c..666efe972de7 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -424,6 +424,7 @@ static void ionic_remove(struct pci_dev *pdev)
>                  ionic_auxbus_unregister(ionic->lif);
>                  ionic_lif_unregister(ionic->lif);
>                  ionic_devlink_unregister(ionic);
> +               ionic_vf_dealloc(ionic);

I meant to respond, but didn't. Anyway this LGTM, thanks for the patch.

At this point it's not worth anything, but still:

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>                  ionic_lif_deinit(ionic->lif);
>                  ionic_lif_free(ionic->lif);
>                  ionic->lif = NULL;
> --
> 2.43.0
>

