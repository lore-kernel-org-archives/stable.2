Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A842B751
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912055; cv=fail; b=AeP0LY156i4q5zpSnATb8E9TKOVf1wm0B2FRhOwU0I9K9Ll9RW+qGxZA3IiAQkX51nW97LvhQ1PHu1ofwl1vHMQVwSdLgw/JC9NLtCXDX00JGQ13QjZDYip96ewhINv3xsQyv2pD1Jl1xrM6hfg7AKpoA+zF7Ho9HpZCGCM0bYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912055; c=relaxed/simple;
	bh=XNUt4Y7zAMuCL/z125usEVIzy6/qsdExAnFSs/sQjhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ilk06aWsCum6wA8RB7dEW8wEDop9gllJ3QyuwCZf6CHyTR+9itbtrBLIPImx1A8H/eRYudIthaGpzm9VvzLr0XMovbOiyF9vxNGcQgUzKgf+Zcsg/ZyH0CtPSLuU8tF0C2L4XoSacbtJbx0d+hrvCqK9FawdZJ0cdA2pFcK7Sr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lnw/jKLl; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lnw/jKLl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQA0yFgzafENWvLE+fEequ+Ew2zV7FkOR/YsDAj8auAerJZJMlti7IUfjxLR6bBByLWiqAl0KJslZ5i3cCSkHFf+OlI3HvlJEBs/yPp7xZ2mGJG7GtjWcKoFI4rg0HREDC6FH2hMe4MxgGy4GEuNv40XnE85R/89QiSB5mmMuClmVd5WPKo3vGJkVz2o5N7S289rCmncVCIH5ZFFD0ohKDAsVdRxydEHMfAxNznOgLwmff/xoxLNV7CwchSXPJxJC0xzjK3E3Axy8HhtYbxOLOtwNrGRVuppuikyxaJL3cI6Jyb2t8nw7JkkuFjPGmS3KEsN23N3GOLu3yqsjH56IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BQROEVzr5r7WqeTMHp8zFRdP/kyEmT5lN0VXJuaIFg=;
 b=qOWjsFxIaAOTznIIbCQtGH26r9oeOCWPHirm3FSYzksGhj08C5lx9/x99Jw3M03TfAZW469naevqsWK1/c8trTMFe0rHlWoomuNUFi4mixMSPlOXrLWlYZlTTpbXWM5EBPcLBaoD7dnK6I3ar4/7x8EQJxFXx6HvZcoBP7B4B4XhpJ/88mZtQ2NNUeD60DsqkDcFmlVrBMTg0hxTBKbvreevZG4jvhRGUcZdCgPQuUtA/eXbg2JaBHe0ChxeJ581kGP23JxL6e53P+ePVumxPKpT3Hp2jvs0C8lYO/IwmHTaqNvYgc7Hx67r1oH20rf3FS9m0zmKl6ZwWQlLWbiG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BQROEVzr5r7WqeTMHp8zFRdP/kyEmT5lN0VXJuaIFg=;
 b=lnw/jKLlEqGI1I1LfDAreBdHIVZk+a11//jnJ68T7ARB4zBJ+dAL2PN8kkWd9HTXdW1rcuIfnWzsw1o6RA9iP8vP/d4mfJYRuEw186mSyXYB6cFPkQgISGKPJo0cb7WlzBdfFznMh9+0mV9m9fKpLepY4Iq+Te3/DiLMDxMFL5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 1 Jul
 2026 13:20:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:20:51 +0000
Message-ID: <b32a5081-545f-4703-ad88-ce54cc1efe09@amd.com>
Date: Wed, 1 Jul 2026 15:20:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Matthew Auld <matthew.auld@intel.com>
References: <20260701062559.3731993-2-nitin.r.gote@intel.com>
 <dfed18b63a7b6cf164b3af7f65df8b4a1b9dbdf2.camel@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <dfed18b63a7b6cf164b3af7f65df8b4a1b9dbdf2.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cccf64-f3c4-473f-eeb8-08ded7739251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R52JA2TIP7Fw85u8fVBzAjBT3/57XzLsYFkogeLjSANkTATfuUFoJhGM7Kcysj9eqpUfI0fc5Evkaqp/wWTaNi4GtWdQ0OFZmTblPg9sPiyiPUtnWhFK42CO0cACX9PjRfbx7NGGlvoXoo2yHIyXf9+jYHnTkXiNTatBDaZDvYRudKs3Xk5rDXvbSVxgkLRSZbXQgUnKuq/EHc4gG5GD6Y6OUWTzfW2IiWUvX+K58ETN64WaoPySFUPW27J+J/52xTFuScbb7n+MeUO6eipx9B1HrwRw/hCcV8CsOQQG9uim2f1JnmIi9krc5O5cLeNKtwj4Gm11//FxCiZZXNTaHTpRzni7btZgYFhCIzWancFhVglsa++ETSqLeYJo2ZU8Ac5OwxxU8qEudF/DcQfmKWOBot3wEvzoohGTzkmOTlz4dzudZxSbzhmoClyEccGOHFCF9d/Bb5cXDcCrjyHC/HqHM5FR6PyMGbMqu2FH11qRjSvtDdxCt7hNSYUM2iPxY1FGSQaa2Z3BnLc0RJub9wtojAuSq1uH8P8DlbEHJCIeItdbqioB4wx2fIo/Kl9E5xU+qmihbOYgldgf4j0nBaZQJx7QseQcCIboeFtZy7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2lQOEJYa0JEV3kvQTZBaUpyOWludXBHTzNDUytWTDIvTkxVNzhESjZ0bFAv?=
 =?utf-8?B?RU5Vc2FSZFdjQWUrbzNhdzdkTjQrUkw2Y1FuRWxDMnlaL2xSSFltM0tGeHlr?=
 =?utf-8?B?Z1lVOTdLYzMrYXduVkc1U1hoWHBiaStoM2d2UmFJbGIyK0tXUElVYVR6V1ZI?=
 =?utf-8?B?K3lVc3dUODlPQzdhZHVWMXpuQmFaL0J2Si9SYzN2Ny9rUGx3ZDhacEh1azVC?=
 =?utf-8?B?cnhOalA4SlhVVUNocHE5elRyNDlyN3djenpCdVEzZGlhRDUyenl5aHNkeWxV?=
 =?utf-8?B?SGJtZE5SMWRRMzZMbmVmbnIxMVVyZjdGT205Z0lrTkszOTJRNTNnVUpzQ3Yz?=
 =?utf-8?B?Z3pZWUpLbmZzMlVmQVdJY0YyVmtaUTBJMG04QXN1MmNMek5GZ3lTUjhVZUtr?=
 =?utf-8?B?ZW9qa0ZFTEhLclhXR3FCa1M5OW1NUnJ3YndSZ0IvY01haXNJU3puQUNYdVIv?=
 =?utf-8?B?TWN2Z25lc3VHamVMRVRuRGQ5ZGgvSWdNT1cxU0RId2tsOVF0U1VJeUtmMGpl?=
 =?utf-8?B?S1lNcTVEaVBvTi80TnhPK2ppbmNFbnNnSmtsREN1MWVEQUpqS2svWXVhakdF?=
 =?utf-8?B?WkdjRWwzdW1mT0c1VDdsUENpVWlhQklMRlVpcnVoYzViUmxSSHRGSE9wbmY5?=
 =?utf-8?B?Z2EvUER1VVhZb2dqTXVQTXg4TG5EVXlpaVVYblhUcDZVMWwrbUFCazVXMmRJ?=
 =?utf-8?B?UjZmT2hCYUhIcDB4M1dWY1Q2QzBtSjBpYThRMHpCOW5OUU9kd2ZHT3N1ZE12?=
 =?utf-8?B?OWNESXlCblcyUytKeDNTSzhTTTRhQU1MNUtQVTJOZXZCcWJrTVJqdThoR1Bx?=
 =?utf-8?B?d09kNGVOcVB1N0JwMno5RG1mMjgxbXlsZU9ObldVK2NteUg3bHlhQmZXTHg4?=
 =?utf-8?B?dFo3RGRpTkY3VjRaS3F2RUNtdWZneHVTeGpJZFdsQXBNY0gvUjRrN0Q3cmRq?=
 =?utf-8?B?K1RYbVRkWjc1YlZBdXAwSG5qaVJuZmsrYVIwWUR0OEhoSkZ5M0k4bnlXUlVR?=
 =?utf-8?B?Z0p1U01BSFQ0Yi9CKys2UURTQUY4d2NnTmZiZXFER3pienRBRk1hQS9paHh6?=
 =?utf-8?B?UmlCNkZpQ1QrV1k0WmRiVDNZZVVnSjM2cWxlU0djTVl3VSszNVc2U1RJdElX?=
 =?utf-8?B?amIzMGthOU5BTDNmZ1RPbi9QdUIxem4xTG16aHNUTURmYjBOVXQ2T0x3ZUln?=
 =?utf-8?B?UzVzT0czdDdUUTUxV2VvMFU3ZzN2ak4rZVo3ZVh6Q0pBaWtXZVZWeHZpYlJV?=
 =?utf-8?B?Y2tiK28weW5kbWcwRVlOOWxReGM2T1BBRXZ2WWpIZ0M0Y09JUnlkbmxjQ0My?=
 =?utf-8?B?Z2k4dDljV1lucTl2cmQzOHh4WUd4UjlTNWhmMXdOaTVaVnlKOXgxeGhSZWtD?=
 =?utf-8?B?b0pEeERZbW5RMFBSL2N2c1FWbS94RHBWUVVxczRhZ245TmFiRU5yaXdPNlNK?=
 =?utf-8?B?cVkxU013WkZYR3NvdEJiWG1jcnlNRnhjaEwrNEtGZ2ZxZ1pmZG0rUTJnaUx1?=
 =?utf-8?B?Z1NiMzNzR1lkVHNWZE04QTg2RDh1OWRiL2FGVjlIU3FLdnkwdDBHZlBHbDFQ?=
 =?utf-8?B?ZFhQMVhFOTlGZ2lsN2Q2VVNUUmhRWk11c3lVUGsxSW9tN05DUlRyTlJ2R3Ra?=
 =?utf-8?B?d05vSW80T2U1czNhbXRPWkhMcklxVzB4cms1YUVjdDcrcXdGcXF6eUQ2Mmlm?=
 =?utf-8?B?NVlScUlBUFdhSFc0eU1acU9NeFN2amdCeHpxU1I0WlZBOGxFU0tXZGhaVzRw?=
 =?utf-8?B?UHpESmMreElEcHptL2llb3UxUWdNZSs0aWtxUTg1NUJIdU5JV3ExTjllbTNG?=
 =?utf-8?B?YW9pQzB5TEVKV1NsUmZ4VDJqclptYWZ4VXEzM1FtMWNpdHZBemJ5NUxIZ091?=
 =?utf-8?B?RkoyTzg1YkZkTVRWK1M5UzVIWWJNMUN0d3pYVFgwVjlXcUpYbDR2Q3RydTh3?=
 =?utf-8?B?elRrZTl2dEFmaCt1anNrV09QcXhLcGF1VDdWallTKzFyY093ZlRBU01NblJ0?=
 =?utf-8?B?L29Fck5TSGVmWVZSZU9nQjRIekZ1QU8wb0dXV0N1MTRHamJPSGFDWUVuS3Jx?=
 =?utf-8?B?L1hrQ2FieE9YSWZvaWphREVTdXhBbTdMUGJTN05sNEM4WXAxSkFSQ0hiZkhH?=
 =?utf-8?B?aTlmSXBUblltRUFMRkxsZWRwNTZqU3BDTlJ0WlhhTjVROVhadFJacjRSakxl?=
 =?utf-8?B?Wm4zMENBUCs3NXZIR3FTbWluZmluR1pTR3AzRHZZNjB6ZUFXRDNCOVlrTHhE?=
 =?utf-8?B?N0V4cFR5dGR6MXZQR3kzT3Y2NWRSK3JwdVFSYUZTZ1pFZElia0YvaDl0ajNQ?=
 =?utf-8?Q?5PSUnsIGQH+8iGBLWj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cccf64-f3c4-473f-eeb8-08ded7739251
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 13:20:51.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HB6O1e31duN7JTCELVPCrVTss6F2t4WfrXAT5mL7Jb8p7FElW/464qK/MhHkjylA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146

On 7/1/26 14:59, Thomas Hellström wrote:
> Hi, Nitin
> 
> On Wed, 2026-07-01 at 11:56 +0530, Nitin Gote wrote:
>> When a dma-buf importer creates a ttm_bo_type_sg BO with bo-
>>> base.resv
>> pointing at the exporter's dma_buf->resv and dma_buf_dynamic_attach()
>> fails, no dma_buf reference is held. The exporter can be freed before
>> the delayed_delete worker calls dma_resv_lock(bo->base.resv), causing
>> a
>> use-after-free:
>>
>>   Oops: general protection fault, probably for non-canonical address
>>         0x6b6b6b6b6b6b6b9c
>>   Workqueue: ttm ttm_bo_delayed_delete [ttm]
>>   RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>>
>> ttm_bo_individualize_resv() skips the resv swap for all sg BOs to
>> keep
>> the shared resv available for delayed_delete to release the dma-buf
>> mapping. A BO whose attach never succeeded has no mapping to release,
>> yet it keeps bo->base.resv pointing at the exporter resv that
>> delayed_delete later locks once the exporter is gone.
>>
>> Fix this by checking bo->base.import_attach, which is set only after
>> a
>> successful attach. The check is placed after dma_resv_copy_fences()
>> so
>> successful imports still copy fences to _resv before returning,
>> keeping
>> the shared resv for delayed_delete. Failed imports fall through to
>> swap
>> resv to _resv, so delayed_delete never locks the stale exporter resv.
>>
>> Closes:
>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
>> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup
>> path for imported bos")
>> Cc: stable@vger.kernel.org # v6.8+
>> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
>> Cc: Christian Konig <christian.koenig@amd.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
>> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
>> ---
>> Hi Thomas/Christian,
>> Thank you for the review. Addressed the v3 review comments in this 
>> v4 version.
>>
>> v4:
>> - Moved import_attach check to after dma_resv_copy_fences() so fences
>>   are copied before returning for successful imports (Thomas).
>> - Removed exporter-alive claim from commit message (Thomas).
> 
> That's not sufficient. What I meant was that this invalidates the
> approach in its current form:
> 
> A			B
> prime_import()		
> exported_get();
> exported_lock();
> bo_create();		lru_walk():
> attach_fail();		bo_get();
> bo_put();		
> exported_unlock();	bo_lock() // exporter_lock
> exporter_put();		
> exporter_free();	
> 			bo_unlock(); //UAF
> 			
> There is no guarantee that the exporter stays alive until
> resv individualization happens.

IIRC at least for AMDGPU that shouldn't be possible.

We intentionally create the imported BO as empty shell without ttm_resource object, so it is not on any LRU list.

But to be honest I haven't looked into that in years, so it is perfectly possible that this is messed up again.

Regards,
Christian.

> 
> /Thomas
> 
> 
>>
>> v3:
>> - Dropped the xe-side reordering approach since importer_priv must be
>>   valid when dma_buf_dynamic_attach() publishes the attachment.
>> - Per Christian's suggestion on the v1 thread, keyed the check on
>>   import_attach rather than removing the sg guard entirely.
>> - Fixes both xe and amdgpu in a single TTM patch.
>>
>>  drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
>> b/drivers/gpu/drm/ttm/ttm_bo.c
>> index bcd76f6bb7f0..9b6341f69805 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -203,15 +203,21 @@ static int ttm_bo_individualize_resv(struct
>> ttm_buffer_object *bo)
>>  	if (r)
>>  		return r;
>>  
>> -	if (bo->type != ttm_bo_type_sg) {
>> -		/* This works because the BO is about to be
>> destroyed and nobody
>> -		 * reference it any more. The only tricky case is
>> the trylock on
>> -		 * the resv object while holding the lru_lock.
>> -		 */
>> -		spin_lock(&bo->bdev->lru_lock);
>> -		bo->base.resv = &bo->base._resv;
>> -		spin_unlock(&bo->bdev->lru_lock);
>> -	}
>> +	/*
>> +	 * Successfully imported sg BOs need the shared resv for
>> dma-buf
>> +	 * cleanup. Failed imports have no attachment or mapping and
>> can
>> +	 * use the private _resv.
>> +	 */
>> +	if (bo->type == ttm_bo_type_sg && bo->base.import_attach)
>> +		return 0;
>> +
>> +	/* This works because the BO is about to be destroyed and
>> nobody
>> +	 * references it any more. The only tricky case is the
>> trylock on
>> +	 * the resv object while holding the lru_lock.
>> +	 */
>> +	spin_lock(&bo->bdev->lru_lock);
>> +	bo->base.resv = &bo->base._resv;
>> +	spin_unlock(&bo->bdev->lru_lock);
>>  
>>  	return r;
>>  }

