Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EF04EF14C;
	Tue, 13 Oct 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893623; cv=fail; b=ar9vTaLwxpcBJzOwm3sEaMB9M2Oj1IpxfyMKSzjoKr0MozHr0aqEEgchgyajBrt/MdfjVdly1aDVK31l52a3IutNF5z5g5ScnzIehTOxRwQGonN24+hZshRibcbS3NGg7NSRsiA/bDsQoQp6VQY2nw/yzK0lJrXdPcoJglH04Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893623; c=relaxed/simple;
	bh=nASlrNDzaz1FqdO6WadmHRLLnzv0Mv8JuQEpNfu9YXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u6cPeiR5KvqFhWqy7om4NDENtdw/pEzC88nBwq68SwThBOwInndgCmuzaSTMEzwZyi3wdW+3n8CdVtw8o3wCbpXJvRfOUMDlqMfQX/i5vf+yqookExHmFXciZTbCWlAPSAIjO7qxKZ26Vy0VJ9iob1beoSHSVIIq1v9wjcGnAfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vTgZB6jw; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vTgZB6jw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2FTiYOGzs/HIDtifNom2flkFH3XXM0l0x+KvXpHBHqhPGRl53AwWM2WfXnNlC/uV2Prdqf6Gv4D5ssi8klmV3O7ZzNOUjMTToUoui5FyOQX+7lEaEQ/LuI5LQdcw+8HrNbFQ2+XzxiHL/dlkce9JGB7z7PgH/jGXTTVrIEvcEkP1owfjP9QHNJjVUKiUDKp1MGPOV7z2vG1urmm73br/tgek7xv6ufQN0w3t+mnlrW7gewEAlsrmdeFUHRPwRCfxckqDoeNqiEeozbAGgNlHj8Z7amYjYQpwWc5Dx6ntLIU0i83Xduplv29J6AeXnPOW0DpgsCpbLGnL+9LBZgc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpRoEh7vBlY9soQ1DXe54XyrmWydEWufoCt+y7zZXiE=;
 b=IwyjIWl0Acae/ab7PuW5LOBhiuAmP4rnwhZjGtxXaVFa8UMMnVQKkCLMSZGGUzPaaZt5oi9kThIhfdshZnX5scbnRtPwapJOQAccLB21i2opHO/mPn5JJ4vgDurF5xO7dk6adlOxp1kKf8Qo34dC0uQ1RGspp5W0jGplo98pR9Cg/+ROcyCx/6Qf6+VtVMA0Dnc/O/RMG06Aaf3qrRHaNhZZ8EZN0tJijzNUEe/c/DkTxFUE7jVk7WgI6g3A39K4dnkPf0KKxoX2COCJeS5ZY2dSv5n0Wxpi/BWeOJ+WBpiIMTRDMIPXjn9haq2GBzvkTkzNkI2FAFXqW87ML9fB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpRoEh7vBlY9soQ1DXe54XyrmWydEWufoCt+y7zZXiE=;
 b=vTgZB6jwwQmHCwiTLkvmx9cHW78+iX/gmJUPgb8jtpaYefn11laNSRgdNS5lgaAsWfKPAK/nLRqad9l9sxtfDxqofTfpXltb+sBUNVk8OezqU5j1O9FojRu6jm1VVlLi41NpsTUD5iF21maNsR7txFFlrbCca7q7xS9y77D7d30=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 12:13:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 12:13:35 +0000
Message-ID: <3e3e0974-20f9-4aaa-a6b8-a7fb4727ad8e@amd.com>
Date: Tue, 13 Oct 2026 14:13:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dma-buf: Annul dmabuf->file on file release
To: Matt Evans <matt@ozlabs.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Zack Rusin <zack.rusin@broadcom.com>, Zhenyu Wang <zhenyuw.linux@gmail.com>,
 Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Alex Mastro <amastro@fb.com>,
 Alex Williamson <alex@shazbot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, stable@vger.kernel.org
References: <20261013120211.135807-1-matt@ozlabs.org>
 <20261013120211.135807-4-matt@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013120211.135807-4-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:36e::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: b42d11c1-c03d-4004-8b46-08df292367e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261009223027099003|10067099003|4143699003|11063799006|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	IqkspwH5TVRROaQgH1IA4ezGQkXt9+2yxuddTWHTRy8uQhLioL/9WGAYwpCuqXyfjnzBy0UHwMDW2lpWBU+2E9BWVaiseVAcKxZHPzOLQwm+hVTeluIOkVRMN1RLq/WjiGHaewUcVuK8f/wZNM+1ANd6PE9PSm0YmywOVIh29FyYT07bl8uPIMJI373cEpSB5Fr7dIkvX/vD8bDHugC99kSxbal7Xn/2mqpqbHNE4rkljXNPsJyPo5bpFj0Cs88qJHtEefOr4n5qlp3MfKcC/K+OzlMwt11p0ZpaGttpVgx0TqDNXrixFmzeg1vie1HLnNK2ohYtMoOmzxX6s7B3C+/qltA/36h63dKHlwUw5y/pDsfso41lhPo5R0icHdCRd9UJbnSQbaYbE3wyIwLJmbFau9TrgvYdLRBbcxrvEcYQvBcohy4tbzE7e8ogfIb9tkv6cIjLMWfQp7z5jeoNg79r8O1sgRbHyuIBWOSuPrr+/ZW4xniNk5YasK5KPoAmQeMgOp5CpzwFgF2bd9WxDe4bo6NDNfEVpqndPrThZkK2g+u1Y8tte+IzPfjxNzQ0EY13vnwMvPiPch92ldsXcBQ5KQDjIx5gvUNhv1r7a5lLNiUEgC7uPy60BkYcuKddoSK/yWTZWze+DZ3BBreI+c+ttq6zf6sU4gQl1zWOaoc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(10067099003)(4143699003)(11063799006)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGQwc3dVZERtK244dFMxWExjZVREeFRvTFFiTFNSYlduYmVYdk13cHJWSG9z?=
 =?utf-8?B?R2dHYzZub1ZPYlh0bG1nSHVLUytGMitHQTl5REtmWVF6aGNaUEc2cUNBMkNq?=
 =?utf-8?B?ZjcwRVJoTWxyd2RCKy9nQVUvUm5qWThZTlgzL2dRZ1pwWGE2eGNpWmpVbDFk?=
 =?utf-8?B?VTRJSEE1a0s1TFBsVEdrQ3hRU1lBa2tDc3UyN3B2NDZDdzIzVlZlS3dSNU1r?=
 =?utf-8?B?SXFDSGp3dlBzcVFsSEhMWVkybnE3Lzd2cHRXN1FlNHNFclpLUWo3UlhtaVJu?=
 =?utf-8?B?ZDE2UU5YajNVcUltcHNqa1RwYTlnWHBlbGNzQWJKVDBnMDNBTHZNRmhVSERM?=
 =?utf-8?B?M0NUdEg1QW40Q3ArZVFxalYzVHpKTHJzVGhZbXVKUGZVQ0hCdXFCNGl3UnpF?=
 =?utf-8?B?dFU2WjJMWlRqaE9tTUc1bERiQThUVjVURFQ2UXdXTjg4YUFNZGFFb2hMd0Zz?=
 =?utf-8?B?M2hhQ0xVdURCQ0NuRG1VOXV0SXl2SFFqWWVxYVF0UlJ4NmtwWDJ2SFNtMTJM?=
 =?utf-8?B?dllxYTZwVFdCWUh3bTh0dGJ3ZUtjRUxVdXFiYUZDK1ZER3lYY2dEd1AzMnNX?=
 =?utf-8?B?VUxkN1VnVnpGU2gwZGVPMFkvcUNqYkMrelVjYkFFbDRqNlVjWWJBbEZnRW43?=
 =?utf-8?B?RGlDbzkxTXpkWmJsSWJkeVBLYUxiWjd4ZHVzVEY5RGJyWlYycy9DOWJTdlgv?=
 =?utf-8?B?Vi9YNjNldGVtd0RGSzZUZ1BYaUhWcnRCUVVOTWcwcndQWXNNT0xxNVFUUHZp?=
 =?utf-8?B?S1VSWW9FWHdGRzRTRXZuSVZvcWZBOTM3L0xFZWJ6WE5aS2pLdHJSVEoxMVJX?=
 =?utf-8?B?WXY3MGgxOVp3NnBLVFJqZmhmZTVia0p2R3h0Q2ROdTVKU0NtbVRxcU1JbmM4?=
 =?utf-8?B?cjJCN3FJeWhoMUxreDhtZStEc2hORTJrRlNIRHZKMGo1Y0dhYzFoRDlaaVdi?=
 =?utf-8?B?NlNKaTdZMnNWYkx4VFRvUEtpM3QwMmtaTjk2RTVMYXh6WWxkSzE4Mkp1N2Ru?=
 =?utf-8?B?RXJ2OElEVFlzS3k0Z21DeFZIQ2Y5MCs2bW9iaWNkRlZ5ZE9admlnZk1paUdz?=
 =?utf-8?B?eUhCeWNPOUVhM2kyVk5YQVZUU2lVTlRvZ292aVpmbFdoRnY2ZTZrT2R4aUJM?=
 =?utf-8?B?L1E5Ui9oUUpSVUtvbkpSMkdEc0RJYjFPYlc2cnBjWVlIbnpnMzZvcjNPaEhV?=
 =?utf-8?B?TGZZYSs2b3pVOW9Db0gvbmZ5SlFQdHhycUxYa01HM2ZRL3JIMml6Z3pOSktE?=
 =?utf-8?B?NnA5Q0FyRGMyQ0Q0NjRkcXlOZmJPZlpza1RPb1NaYk44dWJlOS9wSDgvaHIr?=
 =?utf-8?B?WGg0eEZjS1ZzcmIyd3NsTSthVkJMajR2STVnQ2dQMGJzT21WdkZ5aXVGTnlN?=
 =?utf-8?B?dnVtbU85cEJIKzlSQ2g1QXI3SFM3eU1ZSDFkeHY2TXhYUnY0bUphRXZ1TWlW?=
 =?utf-8?B?WCtkSXdlZ2svOEQvajBwaERVNUxuN2FCb1hoUEdmZURkWG95ODh5NitscU5Z?=
 =?utf-8?B?ZXlPZnppUXhwMkxKSlVUNng3Q1FkR3NZaXc1enFPVHpzMi8yWHJQNzZUVThZ?=
 =?utf-8?B?UHJkQVFMWUl1TnRMWXRTV2hxZVhOQWFPdjRRQktYUmRnQ1g2Z2F4VFBhSzZL?=
 =?utf-8?B?aU1oQjJDdEljUEd0eFpGaGdMWTdqb0FkOGdsNWs3Y2ZTSkhQRHFCN2RaS0N2?=
 =?utf-8?B?RDRYYndpZGpucHFPb1UrT0pVbnFpY2ZmUnBkcnBNLzc4SW16Wm9WeURtcnVa?=
 =?utf-8?B?T1lYcVZLb0lhZ1FtQzF2Nkg3ekpIZUd6ak5GbjlEaUNURCtPRWpzcWRTeHpv?=
 =?utf-8?B?T1pieWEvOGZGSWhhUzdzekRPaElLaWV4U294WWtQUTU5aTR6eFpUTGw1SU5Q?=
 =?utf-8?B?ZzV5NHNVM3RBeloycnRLUXBLSGkxcEpVZWdIOFBCd2dvajlkQVk5Yk9NSEdR?=
 =?utf-8?B?eXZpdzJWTjF1cHdPNkdkU0ZQV25CenhHcjdQTUF5VTJrY0lCelpkVlc2WUVV?=
 =?utf-8?B?cGYzMGRWZTI1aEZaTWw5U3dlVHNoMG9MaFJIa1RqMXFDbDF4S2d6Y05CaHdq?=
 =?utf-8?B?NktLLzIwOUtpb1NDVEpkK0JDUzhwNFdCZ3NQWmx3KzF5NFBjaUlMLzhTSjY0?=
 =?utf-8?B?c2dYMDJpLzFKUEt4YTJoRnFneXIrTS90dHhzcWtCd1k2Q2lpRnNXZDNxaUdN?=
 =?utf-8?B?QUoxZlF3Wm8vdkl6Y2hWYjRkdEtMKytJQ3JWZmo4QzlZQ0JqUnBuMnNhcVQ5?=
 =?utf-8?B?WjdsdW1RL0JIOEFjK2JXYnd1T1BOSWZrdkVjUHhzeXVGZ3Nsa1cyV2duc2V0?=
 =?utf-8?Q?Trtz72dQPk+9v5CP8j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42d11c1-c03d-4004-8b46-08df292367e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:13:35.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTiUhL505bf8TA7ulzdfazprRn2QrEaaOc6d+xBg3XREfxsvRx/UY+hYDh7G9KtC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903

On 10/13/26 14:02, Matt Evans wrote:
> The dmabuf release path is split between file and dentry release:
> dma_buf_file_release() is called shortly before the file is freed, and
> dma_buf_release() calls an exporter's dmabuf->ops->release when the
> dentry is freed.  However, the dentry can outlive the file (for
> example, if opened with O_PATH), meaning .release might be called some
> time after the file is freed.
> 
> This presents a window, when closing a DMABUF file, in which
> dmabuf->file points to freed memory yet .release op has not yet been
> called.
> 
> For VFIO, if a buffer's .release has not been called it's considered
> still active and subject to move/cleanup.  If so, it attempts to
> get_file_active() on dmabuf->file: a file close with dentry held open
> will call this function with a stale pointer, a UAF.
> 
> To make this pattern safe, set dmabuf->file to NULL in
> dma_buf_file_release() to reflect that the associated file is now dead
> even if the DMABUF is not yet gone.  A get_file_active() ... fput()
> sequence concurrent with a file close then only executes as one of:
> 
>  - Gets the file before file_ref_put() (dmabuf->file valid)
>  - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
>  - Observes dmabuf->file = NULL (no file)
> 
> Originally, drivers could assume dmabuf->file was valid until .release
> was called from fops->release.  This assumption was no longer valid
> after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
> dentry_ops"), which moved the callback to the dentry release (by which
> point the file might have been freed).  With this commit, drivers must
> still consider that dmabuf->file could be NULL before .release.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/dma-buf/dma-buf.c | 21 ++++++++++++++++++---
>  include/linux/dma-buf.h   |  5 ++++-
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4c9add51f9ef..61485fc28b8b 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -193,11 +193,26 @@ static void dma_buf_release(struct dentry *dentry)
>  
>  static int dma_buf_file_release(struct inode *inode, struct file *file)
>  {
> -	if (!is_dma_buf_file(file))
> -		return -EINVAL;
> +	struct dma_buf *dmabuf = file->private_data;
> +
> +	if (!dmabuf)
> +		return 0;
>  
> -	__dma_buf_list_del(file->private_data);
> +	__dma_buf_list_del(dmabuf);
>  
> +	/*
> +	 * As the file is being closed, dmabuf->file is no longer
> +	 * valid and NULL replaces an otherwise stale pointer.  If a
> +	 * reference to the file isn't already held, the file can be
> +	 * closed at any time, including before dmabuf->ops->release()
> +	 * happens: dmabuf->file _must not_ be accessed directly.  An
> +	 * exporter should use get_file_active(&dmabuf->file) which
> +	 * atomically tests and acquires a reference to the file (or
> +	 * returns NULL if the file has closed).  The barrier ensures
> +	 * get_file_active() observes the store before file_free()
> +	 * frees the memory.
> +	 */
> +	smp_store_mb(dmabuf->file, NULL);
>  	return 0;
>  }
>  
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d15b2b31d3c9..a31eb0ab9ecf 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -303,7 +303,10 @@ struct dma_buf {
>  	 * @file:
>  	 *
>  	 * File pointer used for sharing buffers across, and for refcounting.
> -	 * See dma_buf_get() and dma_buf_put().
> +	 * See dma_buf_get() and dma_buf_put().  When an exporter holds a
> +	 * common lock with the ->release() callback, it can use
> +	 * get_file_active(&dma_buf->file) to safely acquire a reference;
> +	 * the file could otherwise be closed at any time.
>  	 */
>  	struct file *file;
>  

