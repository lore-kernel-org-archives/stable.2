Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90444EF128;
	Fri,  9 Oct 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568050; cv=fail; b=uDFYkdCUnl5BdMTAGNbWhV5vTwJlR2HBr1jm20BEnNUeIX2e9VvYUmoXWe3c3nXvQb/q+bQjxLKCjKkgfBpwZFvGqulrLiUngQnm67IopkIPZFtnVsj4K47JZMzxdFEsBht285CosQOGHepEx+ZpPMm471EHxwdCVwuVj95dBuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568050; c=relaxed/simple;
	bh=7YHj4v6aNue5WQzhBpV3XkwgMXwEr0MiErDu8ZJUOf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b5Amt8XIpgawFjge9RfI8gKd/pdWsOl9s8bqL+6/UAT/c3PRX5OEZC4izxehANRNIZmiCH96tT+gLUJBYLZfakumxiXOS952t47/T+k4Dbe4vAkHxfQU0bW4FklhY2iPscnFT8VcTBcn2qilQwYio1q7OAh6tBH2Lf1ADkzubPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UrYI9eiN; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UrYI9eiN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtNAYJwWvDWv/3qws+tQrwlPlTJ7C1T1CbursGaaegBguDJvEPCeISO4DPuOgIvwZDErY8hS12KrMMsGchghoW4H8KDQthD5glyWoNw6MHZAbOaPZqNr78H7XnADyhW1lk5WKV2uJDxTPCNIFAoA9J91zt8HdCMBdnxOONg2DK2f04+HtikQXdBLHg0qmqqtOXxAf/V1Ag1Mih8K2CVcFZ8fOYXCxUA12Oa4ssL0OgsVLdZeIJx0BEIKxIb5zuwIUybeCBot7uaqIc/1JLEEUgJX2u/fX/pvO6gt+6T7/ar+qSGrY7+Nov404EQVYpBAPf73rYy9yksfIgAkLtcO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NliuYMcgFpOkDcUF53VdUo6McQi+UJOU0PXSD4zXYd4=;
 b=h6gKBDzZII7iw1VVxKkGhHDu9aM8Wlf1uwM7ihiZl0pVQOJyK3JSgwyurJGdu51VmScgYTV5XDU0cX1u5SImALtuKMWT9BmYZryFAcDO7h4GAfAhV1pFmix+HVAKfJ2UvO1SzUtonxwazl5Rqni4dF7BjplitVsk983WX5Nx6qwy9Ni1otw1et0oVJ4uMULgiUaCi+BuQ1g+Cbig0RGtiydwK+ipVRk7K5qUuYkTVwWQXKAAsyoSS68apLeLQQKxsrATxG59lOBrXyHa3qy5x93ywBtOH6OibLSW7MIfGqNu2KKKbgODnnJpcgAxC47RTuF1AziSi7NCW63h+CppPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NliuYMcgFpOkDcUF53VdUo6McQi+UJOU0PXSD4zXYd4=;
 b=UrYI9eiNy6TdrF8ttj53hLf0tviHBryxDHgjOgGrfJtpQ/rKAHMNXCNEWJAaI7Zobk7O/cIs99PNtZGL9k5a+8ts6sHvicUY5804iUWNLVkAy7+ItFURvB/Q2McKZo1VgnkkNYjNzmR13Hwuz9fA6gWm5eqXBG01QYYa6fE+mcU=
Received: from CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::21)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 17:47:25 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::9e) by CH0P221CA0020.outlook.office365.com
 (2603:10b6:610:11c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 17:47:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 17:47:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 12:47:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 12:47:19 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 12:47:19 -0500
Message-ID: <74b15e57-1387-e37c-d343-eeba1de33ceb@amd.com>
Date: Fri, 9 Oct 2026 10:47:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to
 the BO size
Content-Language: en-US
To: Eva Crystal <0xiviel@gmail.com>, <stable@vger.kernel.org>
CC: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20261009032616.432392-1-0xiviel@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009032616.432392-1-0xiviel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: d75d49cb-071d-4aa9-a27b-08df262d60c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|6133799003|18002099003|22082099003|11063799006|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	faOmfbQxLnltujIDyz5ng6bP+VjHhuLDQjiOBb1PtVEoT6y1WD1tLAqoJw2KG87xRU7n/zyd4i5FG7xnm3TWhjior7d7ckkG9bQ/llhVI83Vl++vOkpdpFEDDc/3NIokxS2k6SOSrvLco8pYxVgkS9gadOiEdcTyN8IUSan9kgQ2LufHiNMFp/hYVFXRebyzK0yoBGPpDgxlwHCnoL3ZA/pmD3SpFrcMnoz0hZoQeJ2MawtTB1UAx3xqC+bv+hrlJAxNQQ962UesaZdEdYnmVndCnAr5mern6OjM9a+VICWdAD00PNEzE3fEETREREOXS8YaigzTOYSEmPHGqVueqfnzDLoEdUnvmgdd2bsDe0T1z7fNdIafmoAwElXLgx8k4shOMlX6lKUYbt+p2PyiDDklfijXCfXEgA8lLHMOWSGanZbU5Vn/NEFXKuJ8nc40m8PSUiSFc++Rr8TvGfwfX8mPYlaeqBRhvV8YGlWQJpgNQxBtiJ0IRifGPmLfSSAUxxersqpXW6wN9rs50hVkVWPKYYmUlQoG6cIBcC9Txbpei/Eaq4fd5BH5vUykMqKQ8Cl3SDz4tFzTzQsdwuNRWNok6lksO6xBq4EN9S/CrZoRYx5YrFwULVOa2HDSastMHjBZ0emo2LaV2s4YUoZ+NMX//ErGPQSOlNFZWMnX41vVaB4qvakX8MJycDIE9uiVWf9AHQUVLlyK7JJAgpLxKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wJSYp+optEwK666a8bGo7TOLFmJOit+HZTLIesA/MPH4FQdFVs8poiTlFWjVUrQ597jUrW7kwWTbVBJdJanCtzG/kMi3ypBzRy3uBd/OGnwIm+4dQwFcYLo4poXVH5KzWplj2yU0Zve67zNhegdM9V+Obt8cz/PrIXnOq344NQioffCD9t0tj/Alrci86rw50ROgW4zg+T2Z99FtzIpsT8q2APddImMhXVJzXyj5Ebpe2kasW5EENjjvb/7euiBpSY7UTqT/kP9HlWnbyGe44GmOxDZjF2XXOdXkiaH9VHEvlNUHYKPcYUUf+JswtqtqoW2OPP72cUF1I85Tp6PpCI6VDr/UfpVIqELzIMhDAniWa71FHGMPQCeN/IBkda5u3ZUpgK4dLe3Gs/nRWNA0w8b3a9smAwj2f9Ak0NV7bIl7SrzJjUz132fMJnB98kn6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:47:24.8096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75d49cb-071d-4aa9-a27b-08df262d60c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940


On 10/8/26 20:26, Eva Crystal wrote:
> [ Upstream commit dbc8fd7a03cbc0704e8e558a448015f620547a02 ]
>
> amdxdna_drm_sync_bo_ioctl() passes the caller's offset and size to
> drm_clflush_virt_range() on the BO's kernel mapping without checking
> either against the BO size. The ioctl has no permission flags: any
> process that can open the accel node controls the offset. Any BO with a
> kernel mapping reaches that call: AMDXDNA_BO_DEV_HEAP, AMDXDNA_BO_DEV
> and AMDXDNA_BO_CMD. A DEV_HEAP is vmapped, so an offset equal to its
> size lands the flush on the vmap guard page.
>
> Measured on 6.18.55 on an AMD Ryzen AI 9 365 NPU, firmware 1.0.0.63,
> as a non-root user with access to the accel node: unpatched, an offset
> equal to the 64 MiB DEV_HEAP size oopses in drm_clflush_virt_range()
> under amdxdna_drm_sync_bo_ioctl(), 2 of 2 runs; patched, the same call
> returns -EINVAL, 2 of 2, and an in-bounds sync returns 0, 2 of 2.
> DEV_HEAP is the type tested; DEV and CMD are by code reading.
>
> Upstream bounds the range in amdxdna_flush_bo(), added by commit
> dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap support").
> This applies only that check: an offset at or past the BO's end, or
> an overflowing offset plus size, returns -EINVAL.
>
> Deviations from upstream: that commit adds a feature and is too large
> for stable as a whole. It calls drm_WARN() when the check rejects a BO
> whose type is not AMDXDNA_BO_DEV, which userspace can trigger; this
> fix does not. Upstream bounds AMDXDNA_BO_DEV by the heap chunks it
> spans and flushes only the overlap, reporting no error for an offset
> past the end; 6.18 has one heap per client, so this fix uses the BO's
> own abo->mem.size and rejects such an offset instead. As in upstream,
> a size past the BO's end is clamped, not rejected.
>
> Built from v6.18.55 with the test system's distro-derived config,
> DRM_ACCEL_AMDXDNA=m. The touched file also compiles W=1 clean.
>
> Fixes: e252e3f3488a ("accel/amdxdna: Revise device bo creation and free")
> Cc: stable@vger.kernel.org # 6.18.x
> Assisted-by: LLM
> Signed-off-by: Eva Crystal <0xiviel@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index ca747457cec7..95d04af2b993 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -934,6 +934,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   	struct amdxdna_drm_sync_bo *args = data;
>   	struct amdxdna_gem_obj *abo;
>   	struct drm_gem_object *gobj;
> +	u64 end, size;
>   	int ret;
>   
>   	gobj = drm_gem_object_lookup(filp, args->handle);
> @@ -943,6 +944,13 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   	}
>   	abo = to_xdna_obj(gobj);
>   
> +	if (args->offset >= abo->mem.size ||
> +	    check_add_overflow(args->offset, args->size, &end)) {
> +		ret = -EINVAL;
> +		goto put_obj;
> +	}
> +	size = min(abo->mem.size, end) - args->offset;
> +

Thanks for the patch. It needs to check if size is zero. Please see

         dc1475366424 ("accel/amdxdna: return early from a zero-length 
flush")

Could you help to backport this as well?

Acked-by: Lizhi Hou <lizhi.hou@amd.com>

>   	ret = amdxdna_gem_pin(abo);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Pin BO %d failed, ret %d", args->handle, ret);
> @@ -955,7 +963,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   	if (is_import_bo(abo))
>   		drm_clflush_sg(abo->base.sgt);
>   	else if (abo->mem.kva)
> -		drm_clflush_virt_range(abo->mem.kva + args->offset, args->size);
> +		drm_clflush_virt_range(abo->mem.kva + args->offset, size);
>   	else if (abo->base.pages)
>   		drm_clflush_pages(abo->base.pages, gobj->size >> PAGE_SHIFT);
>   	else
