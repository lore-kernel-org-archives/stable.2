Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32EE47F79C;
	Wed,  2 Sep 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350615; cv=fail; b=aM6+epW27h0QhpY3n1d+Fd5Ho3luCjAcsrSOQmM+4oTc7es1VOr+7YMSic45hOnlBxu8MI+OIr+WglJAsPkQbcq9a43RqMqy3XIT4VKyjFVLJJHJSmhWXv6Jq8iUZqDoPJU53nXVlbE0/MHOAFaMTqRCMz3ln2kN9X1KWmt/Et4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350615; c=relaxed/simple;
	bh=qRSJFAPVucL+zhzt72kR9bLOKYdJya1rzlqhGg+o+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hFZ9pPE9wsiou5jrywPuTj65xr/45C/eKuaCNk6vgybspMsotT73/ESm8PJidFkbUdQOVfdL74fCKMCfF8ha11QJWJtWxKyWUqstrpylZp/70MKkaIpvT80Vv4Ymmj0lHO3euUkeUQcB9oeRyPwJ69Pcopp6qHGaUY7jL0hg30g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=THX54xcB; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="THX54xcB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojMYXou5EYV+67DGEFtx0Efz6Jwby/6N3mSGarNAJK0CvPooW7Jd4MU8/xUTHIbm0QTk26uvdZeF7T6aLe6+yLrU2/uyvepOODU4LSTjP7Zu6c2n0HI+Zqv/OeojZu8gN9B0gDlFOopoE17nbGm0kKTlCTkf7hfZNJOIauf411+IIHxzLJ0uEr/DoM8kD/rrQM/P7hKslvxvchwXLfjugEft2aMuiTf82YdXNzkSg3032r8WTd8hyzm9PZyqhP5ndIzoUphCesUiObM2NcZNxeSOjCyboc6//gQefa00dD0SlZxO5RCsl/RFPSvfWAZPWY9hfo6Hox/DRLq/00stSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk0xjYcH116U+Cjtgj2XnbtnW52fS2CDQEcXmBTCjAk=;
 b=lYEDePWh1L4cvF+CyfN3ko+ELNXpxRSgSCH9AliUTOfQCA6Wm/1QP7H2jwjhfTKUoq6oqTE3ZnI/E21PoFahjnX7Vsi0Zukucv8QNHD3ca14b1+t9J0fRnSnO1P8Ns4Rtv+ccJaYz6M4Pcbwy+MRlI1b6X+R0+GMN+FFX2ZFXnkWJTI+quJ/iL4tskOGcaHo0mFhhvI+ZsMCUadHaIfit2SjD5mAIcFaDdgMI5iA0EI4m1VWYauIYRGdm3eUdZtecU3V5esTEcQfXXPx72QgNVrWdzOaHbDx84AMSh4+NNRkKZWvYxc5uWqcSfAi/2CueD9/n+g8ePvFhc+BJntJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk0xjYcH116U+Cjtgj2XnbtnW52fS2CDQEcXmBTCjAk=;
 b=THX54xcBoOWfge0jzMhyDAWX1CO/xAPQEn+Sm2Eo/gjXhUVqRLPeYnNAm8i7+bN6V+X7eMQXGzKDnCPv1UFsfSnKngHPM0Ibxes6a6iI1RwjPP0zTUs1qWr0Yav6asIXL+qUKWPCuzE0K7fpJRcfojhITuikIPUMIciHZL6Z8qNH4tsffs+dC/BmUppFFmYwrvvh7LmCI/DTiLSaaRtieWTTMi2W/P1JbkGYCcWvFUmeXmqywTOJGhHfEWJ9ZAN7E+GBwcrwhModEIzgA0WctYmFG2b/fANjvCqoVO9AoPba/BQA3T98Fs28Ecr5++9iMtws2buZeQ6mHu8CumRWyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:03:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 12:03:12 +0000
Date: Wed, 2 Sep 2026 09:03:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org, alex@shazbot.org,
	ankita@nvidia.com, chriscli@google.com,
	david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, jmoroni@google.com, kevin.tian@intel.com,
	kpberry@google.com, leon@kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolinc@nvidia.com, praan@google.com, sashiko-bot@kernel.org,
	stable@vger.kernel.org, viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Message-ID: <20260902120310.GA3370894@nvidia.com>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
X-ClientProxiedBy: YT4P288CA0082.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 5016f1f7-4fcf-46f7-9270-08df08ea2929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dkqWNi4Agh8Jj6YPuFzddLtZxUr+hDIkhrPUbWCV3TCC78Ck0vTGj2fTFeHmQYcoRYQNJG9PeCzlZ7QxgjfZikbERYaEWmPEzdDA8wkjhg66PHHCSzSRP0E1ZGjiPZDDUe2lQKpzT1g27NM7tTRY03Gg8VYx1LJGQg0FwHTzp6Otz01GUW2hzVkaHk1A6f1HSJgawqYeAWgiiyP+4OzK3ombp/Y4r/2R3b9gsjIvWbmnA6s1Rcrg0gBRUrAy9Xi6d/fOj3oe9Uiii71/W//6/yrb6/57RG2par3uYlyfZ5SKhunfifGqN8GktuR9Pz+ko7kkI/6N79Y7JeycCdpvfVO1zIA/Gc8UB49TqRM6AL5g80P+tBRse7PkAKpVwaaqofYVVbrfEqSl2fn2jRD7ZS17Qw99aAHUwMzlC6rqCXhPy1a/t+av1/HIhhg4TNqn0N4CbCUH8zeP/G1xbRFTqvjoZTQAhTMMLoQclmGgOt8cRxUQD6r44pofSoLGrzIADTsTLIMQC8NgBLuntz4agGT6Y6MCDwDpjhhZbkMnyfI4qQqLoXJOROtLIFvnnP1QQxZgAfzzVGretGmUPFJLGzDT5mTxlQVe9RgbLGrCuv0TU8xKC1lSvDCSdiL5fMnGcXtldS4WeXGhbA3yMhAeD3213h7wRF3PZpFvZuQM93o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFB3Y0pXbVd6OTlNMTFYekRxSDlQSjRPN0JKQ2huQmVId1VSTitLMUtBSEZW?=
 =?utf-8?B?N04vY2hxcXBwaDBRaXNYRm51VzB0WEZLV3ZrVDBpdUF0S0IrWFdrVSt6SGJr?=
 =?utf-8?B?Y1RMVmkzaXRPOHJ2ZisyR1hnelA1d3lTTlZjL3Z5ZTMvUU9GTmt5MGFzK0lJ?=
 =?utf-8?B?MlRGblRERTVVTTEyUlFXYkJyLytyV2s4UUNLeVVjQ1BYc1d5VW8ydG5pTFZP?=
 =?utf-8?B?SnZ1OFZES1ZhV0krNHh3TFQ2Mk81VmZ1bXM3Q0J3eXJpTVM0d1RQbmQra2ph?=
 =?utf-8?B?MHhqY1pDYjVpWTF6WWNtUE9rZmY0MjJKdU9FblJCYmN1em42Y1pzcDl4Z2d0?=
 =?utf-8?B?ZCtadCsxV0szU2NZN2NQQXErSmZKTUJ5WEc1UE4vaFd5R09xM1JWVDJVd202?=
 =?utf-8?B?bFBVbWsrbUNFbWh0Umd3OEYxL2hEL0h5U1JqQnM5dnBkalc0cmJibHQ4cFZO?=
 =?utf-8?B?TkRkMlh0cTNVOXhCdGJnWWhUdmFuTGJjWUdlQkFaMnVjN21KQjRwRG40NHYv?=
 =?utf-8?B?ZEJRNUVzdEpSek1WdGRmdG5KY1BhZ0NPa1hST1N4UjdmeTFxeVR6djFMNHdn?=
 =?utf-8?B?QjlDd05MN3pZVmVlcUlSYVpCRENpVlZKcU4zRmxnNzgwVG1Ea1FhZExnYVpn?=
 =?utf-8?B?c2hlTFdNblVuT3FPLzlPeVNFaXorcGdjMnFJRitCWUJxMTBsSWE4RFFaTFB5?=
 =?utf-8?B?ZytSQUpVMlcrOHl0QTJyakN6SHI1a3ZCRXZOUE9rK3BEbENMZjlLZjN5R0hL?=
 =?utf-8?B?K1VBSmVGOXR5S2hwUEtDNGtnTlgxYWhPMHZxaFJ4emhIaldVVWhRSmNPeGVq?=
 =?utf-8?B?U3B1QU5pYlprc1VWc0xxSFhGcEdYRERPMWNpNDhVS1hJMjM5WkJVY1hJenUz?=
 =?utf-8?B?U2M2dlFxUHBYZ0VKOStFUHNBbE56ZHpNRzBCRW1RNy9nQnd6YnhDSWxWdXVl?=
 =?utf-8?B?eGh3NCsvYktNYzFBZWY2dnlNMHBUbFVDdzJWUXBWME94UlFya01pL25rNTdH?=
 =?utf-8?B?MHFwa1B6YThQcEZmbGFPMG9YeDdrc1Nweit5dE4yU2czL1dxUHlXeXlXSi9Y?=
 =?utf-8?B?NVN5VWJtbGh5QjNSQzdzLzgxc21RbzVTODUxREVqVU8rd3lnaU80RFdIZDVY?=
 =?utf-8?B?bU9yRlhzNnJseVBKNC9Vc1dnY0lON3VrMFpLOCtadEdCQXk1WEFxRDJMQngr?=
 =?utf-8?B?aE41b0ZuWDVvRUg5RWtKZ3lpazRMRmtBQ3NSM0k2ZlZVdXNZNjBRTkxOeFJO?=
 =?utf-8?B?c3BOZU83S0svMEl1M0NLNnYrdStkdFpraGFaWHNHRmExd2RIVGo2VTI5alZI?=
 =?utf-8?B?anRhU0s0RGpRYlRrQVhuS3dqRHpRSFVYWmdJaWdoUVU3cXN0YzZWZ0hjVWNz?=
 =?utf-8?B?dG0zV0FiamY5cS83M3lJWWpzblFoM0hKaVBBWGF2L1hueUFhMFMyNjJiT3Zy?=
 =?utf-8?B?WXpaSjQxckZSTnFPSEtGaHZBdHFiTE5EZWMzR3BQWGVvZFF4TFdENHpwQkdW?=
 =?utf-8?B?dTlvNVF0RkpoMjZtSUJBcWIza3MrblJvU2FXaHRwQXNlaXpTcDVac2YyV2ZB?=
 =?utf-8?B?QytDT253V2VjcE1GWmZsa29GOUdEWm83YktnMTBISFBjaEFDbEgra1B1Q2Zq?=
 =?utf-8?B?WDBhbC9BMTQ4MUhaWXp4TEtEallQTkR4SmVsTGRzNmVwUUZJL0N3dVo4Z1lC?=
 =?utf-8?B?NkROQXJ2UVVpTUI5eE9OZU02bXhpREY0MU1xdmsrL09mMHdXTk5haFN4K3Jk?=
 =?utf-8?B?dTY0TEdlM3k2NWh5OERWcDdDUFVzbzRVMUNMSFhKRE1XWE1lcnRCZkpnS0Zt?=
 =?utf-8?B?TGlNN1hCNEwvODJFd2IwejJJVmRmSnM0TlJMM00xK2kwUUMzdnFUdHJ3aERl?=
 =?utf-8?B?dTI3TXFTKytpUFdIWWdpSXVZbC95eXA3TXVDM1k1K2l6SENGdk94R2hHd3hs?=
 =?utf-8?B?d0dIZDFrRUdjeEVCdEQxYkJBUVdVaFF2ZVM5UnRFeUlEelFuN21UWFY5WU1h?=
 =?utf-8?B?bmNQaElxVThvV1pWZjlnMldwTnI4L1BzSUs4ZHRPZDQ1Yldwc2I3NmxCeTR4?=
 =?utf-8?B?ODViREFsL2Y5VW5OSVpmR000Nk9PRjBsL1FHL0lUNkJSbE03RWpXT2VURHk3?=
 =?utf-8?B?N2d3VTczVW1kLzJKYXk5Yy9JN0EwMnN2RlZWeXNZZXR2T3VuYWpKTTJHa1pw?=
 =?utf-8?B?b0pBUjBDMlpiN3p6MlJTYllUTm40OE0vWitsVmVjLzNhRFVPUU1mYUFIWnZ1?=
 =?utf-8?B?YkUwU1JYSW1YM1NvbUZuSC9HeVhnUllYTDRZNzZmMUdpUytxeWJEbDNHMlM2?=
 =?utf-8?Q?enpq/MjdENtVZ7G393?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5016f1f7-4fcf-46f7-9270-08df08ea2929
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:03:12.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30lwjZNiTFNLuyPF2pb5tQKWP5E8Dkc3NnD6oWaqgClRECIx9BUy+DTrvAqP8fZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
> On 9/1/26 19:08, David Hu wrote:
> > From: David Hu <xuehaohu@google.com>
> > 
> > This series address two related issues in scatter-gather mapping,
> > specifically for the MMIO based dma-buf mapping. The fixes ensure
> > sgt mapping is correct, and proper for large MMIO regions.
> > 
> > Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
> > (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
> > phys vec to sgt)
> > https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
> > 
> > Patch 2 Splits sgl by largest page aligned chunk
> > (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
> > https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
> 
> *sigh* such issues are exactly the reason why I didn't wanted the
> *dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.

So you'd rather have these tricky bugs in every driver using dmabuf?

The scatterlist construction in most of the DRM drivers is not in good
shape. They should be converting to call these APIs so they can do it
properly.

> I'm going to push those fixes to drm-misc-next now, but when there
> are more issues like that will mark the code as abandoned and not
> maintained.

Code that is getting bugs fix is not abandoned, please be reasonable.

Jason
