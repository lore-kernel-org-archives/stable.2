Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C563AF677;
	Fri,  9 Oct 2026 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550557; cv=fail; b=S27RO2zmvKc116gN7nlRQWMGnzz1nZJC5tpE7xDVeVazucZup2OiE1ruLcgedycGb1cySci7AXJ5X8icELjwad3TbX/nyylSIo9Qbp5Jk7kTXGLneF/VRlsGXC5ppmRwsfAanQRyr0/pawXdEO7cxzyxoBKQX0mrZmBySLnN+HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550557; c=relaxed/simple;
	bh=RULxs33bSWeNptQRZP8ZvomacjKuzbHus1+y68ob6S4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WKD7P0Ey1czH44gV4SLnNBPB1xZiW32Xs4UKNXNz6g2EDNrLVHvojRTvAlR2dIJtHYOmQh3NBspXXUczDrNVIMqol0WhZRBSuNvJ0w1kh9svI+7WUd3vkN/guGekDQuYQbrK1nEmI3f2KmXSDYemvlBZZVVykhMUYJ0xf73g7g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sYvuE4+i; arc=fail smtp.client-ip=40.107.209.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sYvuE4+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBTznZD5izy8uy0oAX4JVBb5/vOTY4Utus21q0exd7/uWst17BKPMCV2pB1mha0JLGdc0Glg/fnZn4yY22tIh6Mr7N3BxwEl0HP1xfuVCgUylu+bvEsWy1yt2qom4e8TKCbrpsEQIZskvxWQYAaWAnpafPFmq3zff3HwReMTYDZ5g+3n+ZdaCNHkHk4wYcId6aZ7ENZ4xJjI/WI/k2ZQOZkAICFcme3bxpaJdaP7JZUx6LaJjsbne6M4PcyroA0f2xTE7J0zCR7zzisSPWNOV7ii8/Eb7i1wtVVRm/IKI+6umoztG3tS7ppst1XT/NZ1eiDeK5iFNeNsIC6Hcy7JoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX7ALfI8gxSmjEl4HlZ3eE+XRvQ+3wtKk7KNgg7ttWA=;
 b=ohHsE+t7D/7DC/+NY+kztaxBG7xc5DrF0xq277pkq8aZ3B6RVZ60mxYe1EA/L/qJ/KkVVRprNK/quJhRW2nhrADhKWYhbFmBGlSt7IIDNz2+gZfFZUM4rujQIa9XZAYPjHJtk3NKpXs3Ky1J55gxYthVUWmJzMX/i31N2Gyu0aUgKGrJUxttkh6Y7DdWIJEif7QUq5k3uhJQrYxxQn9gpEE05mUA2hG80zWzQbS4pmyo3I7QeHxcKhoyxRsi50ZO1ZerAw48ecXNWptYkssHnuyI7MLQkrvAn5Yz0B9rBUWj42fdVIsWtvJrcFCbt+VS6vLLZvHT7rdr/b/KHWbVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX7ALfI8gxSmjEl4HlZ3eE+XRvQ+3wtKk7KNgg7ttWA=;
 b=sYvuE4+i9k9JFxAHRW9/6Z5NSviYKHIc3o73lJJQPlvL0oSAZpMDhPzMMH1KXJnKpcQffX1pKyQd5NzcF6mBcrsfTl+TdmLhclpd2+wx7yLwNsvMOq3BfFc07u0jYt0at8wxMVIcXNXjXYPepo0BEOh2993dC8jj6a56dkCtlb8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 12:55:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 12:55:48 +0000
Message-ID: <843499c2-20d0-4c1d-9d8c-eb82c2bb186a@amd.com>
Date: Fri, 9 Oct 2026 14:55:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dma-buf: Annul dmabuf->file on file release
To: Matt Evans <matt@ozlabs.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, stable@vger.kernel.org
References: <20261009123601.94079-1-matt@ozlabs.org>
 <20261009123601.94079-3-matt@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009123601.94079-3-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10)
 To PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 67291a9c-d028-4cf9-104b-08df2604a3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jGMlvWxhv1yYzeI5UpEaj1tAye9dW+3c6nErSnGrcN4Jlow0y6N1WkMvrBaawyy0UzvmDfhL+Hg61k/0JbtRDZB00NPUkipYcLDSeaJWURFWs+6kQyGqEDVb7lkN/CycP1c19AKuysK0XG8aRQC0cZPa0ck+Uhte3wnubkeFrxZ6Il7XjB6Xid8FHLLSbTcuykNKE9BEtmP+DPMhVKikd7/nmvlp8f7KsNRgwshD1cgsLhak9ObS+OTZDYUO0a1ksIlge5cePrmJb+F2KIG5v5RIf8KCYYtKdhlf30xnyXHKxAac1V24SlcDf+u2V6P/ag6dCvdgIUHM/i/wpFAc5foTgqocbh2k9tk8KZgCte2Gbru8uobJ2agkucIzh5nu3w3TmiooQcx5s+MbYM4zJ6rCQM3rs4YHx4n6gaMGyqGwP5NX07PJxF6FMXMYas6ut9kwxjkMBGO+hcI4p0E4hUHWrxq0WYKHhfNaS283TtCsLRNWsn42ZIbvgnXN8WbolhEe+0F6HCwOGFPh7r+vQcOLPxlppjrXhRIZfvhxnai36ZpkngLgL69qr7XTfCYJRDxdlUkGB1gSWxq8vOo2TNgNQnc5lryDexhoWg8M/gJFtmPum0TyOjyOhDPu+3zIuvQtbnoEuWmfp9JmvXCpYQizBD1CJcNr7U801lwKabI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enI5K2NOTU9JRkZUb0dob04zOW5QZDZ1OFI1YUVvV3pmTkd5eU5LNjhNMXQz?=
 =?utf-8?B?TElvdFVCaStTZFFWQkpURWZmR2xWVllDTW9xRFlEaHlHVVh2OE5CYnJGVHFD?=
 =?utf-8?B?d0tLMFVPaTRLTExCZ1kxclhmUzVwak9SbC83N2ZLV0pmMUZCSzR4a0JQbTNu?=
 =?utf-8?B?MEpVOCs2QlVyWk5tYzhhYjhLbXRYZkRIcFkyWkxIejNidUNwL1doaHY3bVVI?=
 =?utf-8?B?Q2J1eWNhQlRhNEt5dW11bkZsM2tuU09YM2dOVnRqQmVQMXZPcm9HRVYvVTl5?=
 =?utf-8?B?Z3NUSkRiVE5MN1NNNVdidFFmKzNkOFgyNmtYOVdVTnd3djYxQlNkVGxzaFJD?=
 =?utf-8?B?VGJoT3czbXBJN3hQdTBaNWZva0x5THFxMXh2TWJtUU94OC9qTWlUaHZ4dFV2?=
 =?utf-8?B?Z010T0wxVHZTUDdQRFBDUlhMbEVkOVBGRVpPKzExQ04za0ZhcnFGMUtUN3pi?=
 =?utf-8?B?OHFUTWkvOXF4clExWnZnOHRDb2pWbmN2bTk2WHlLM3ZGbzlpeHJVZkZiRVZn?=
 =?utf-8?B?NVZFcGVieEF4LzR6S09XbnJteExSUVhjekpzMWpTMVNrVit6b2FJYmN0NTZq?=
 =?utf-8?B?d3k3TDdWRDZxWEtRRk9BUTZUQU5CbXR1L0p5bkZ1UkFmeDliZDdCTks5M0Y1?=
 =?utf-8?B?UFdaSTdBSXUzZXZ2TDIrVENzWTArQ1EvTUVMaDJBY1hMMm52VUVmTzIvZkJ3?=
 =?utf-8?B?RUZ4aXpIajFBMkxZSTZHdmx0T25DU1p5bkZWN0dnV2pPUkdXV0tpNTIwV3Nj?=
 =?utf-8?B?WmVodno5YVBvNEhJS0lWZnlkbnN1M0VJMk1tRXM1ZnNuMzdiMmhFd2JZYVZm?=
 =?utf-8?B?SDlmeVJORU9hUEhZd3B3WHpJdUQ2NTJEbElZSEJmSDhDWDFxci9ZQjRyQm4z?=
 =?utf-8?B?OXpaVlVIMkFIV1lJUUhSV1d4RG1NL1lmY0tRSldaQVRibUllZTRnV2V4YTc4?=
 =?utf-8?B?dXFHV0JDbkMwQXhSZjg5OUh2VE5lSCtFOVYwbElQSVNFTDR6cTFZRzUzRVdC?=
 =?utf-8?B?U0dXbFlXSzhtTGtsQWVjZW9SRlpENjh5Qm9SQnJBV2JwQlg4V3NKVjF1eEJH?=
 =?utf-8?B?c3krM3V6Q0ZzK2hlN2NpMGttSjZheU9QL3lMTWFMRzJxVkVzK0RjV3lYVUc4?=
 =?utf-8?B?ZkVNSFpvbEptNHRXdjVvZzZNSWw1NStqQWRaUkNSeXU0YUxBdGI2SlF4b2Mw?=
 =?utf-8?B?K0huekhEcWNOc29EMG4vcEZGT0lMVDg5bUVnOEc3Myt0UkRMZHFZeU5xRnRi?=
 =?utf-8?B?ZXhMdFdSVXAxakdJbVZCbmMrWVF3R05YVFBzYTlRdXhKRUhzN3czUDVZOFBW?=
 =?utf-8?B?N2E0cTc3bnhxY25mb21hdXpVc3diZGVFOXRZMTJ5TWppVW5tYitUSk41Y1pz?=
 =?utf-8?B?Q3Y1dWZ4QTdGaWZKb0kwY3BXOERnS3cwQzMyY3JBZGZkL1kycUI3a05kM1JR?=
 =?utf-8?B?N1lhenhlUFBtRXBjQVJPRXJ0djliUStEUi9rYUllSDZuWkV0azVjanpoOTlL?=
 =?utf-8?B?L0VjU2dVVWpKazJ5V3ViMjhCbDF6QnlFbG80RGdJUUxnNVluTWtGY3hXSm1O?=
 =?utf-8?B?RFZPRW5FdTZuUElqakMyYTQ3cmFsR0c5Z2U1RU8zZ1ZJaVNRbkxnaFFVZ29L?=
 =?utf-8?B?ZHltUWpPZ21XU3M3WmhTcjEvK3lJNnFFMHkvZkRSVlVIbDRrd0R0WEZOK0ly?=
 =?utf-8?B?eGYvNHhmeHNxeHNzOTBFT2tCQ3NHTUF1aHBqN2oyZXdPanNFTzhuZHBZL3BU?=
 =?utf-8?B?WHUzVFNMZG1yZ1lBWGpLQzB3MHpSMFkrNEFFZWVYYlJ2WUs1djVIM0EyYWpY?=
 =?utf-8?B?OU9reWVsalc5K09JbThmSm5nVXhmY3RuWGlVT0M5ME5aZ3JPOU9IR3cwbkR0?=
 =?utf-8?B?STNqWUVXMURFOXR4WEF4b25KbUczenVSbDdqSXFDeE1wb2xTWC93Y2N4QzBV?=
 =?utf-8?B?ZzRoUDVrcklhMVFYQ3RiZWd2OTZuSDUvUmorbFBFeUVrTUZMejJ3RDMzekll?=
 =?utf-8?B?SnZiRUw4QWc2S3JOeFJ6aDYrNzZuQTVDaWpYcmZpa25nSWtHRzhiQTlCM2Qv?=
 =?utf-8?B?Q29ZWXI3bEV0UndCZGtzKzFDMDRBbStKTGVOMElBcG50YXRnbDNWSjQrZzJD?=
 =?utf-8?B?L3d4U0Y0QytRMkdZUXVaa1k4cmM4YUV1cU5SdVBkMUtHclZ5bGZoeW1XUGlO?=
 =?utf-8?B?SjN0cWg5bjdNR1dhS2s2bXlHdXlwOUdXQ1VGTFFvM3pnTmJmV044c0kwbVRV?=
 =?utf-8?B?azVZcnVudDF4Yk1KR2lDQUFjOFpUcHZ3RlBrVGxRY1NHbDJRQllhMW9SRi9B?=
 =?utf-8?Q?zgsohNnrJHzfyVzQR2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67291a9c-d028-4cf9-104b-08df2604a3b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 12:55:48.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgGiSKidzVRlkaJdzZUsJBBR2+oLutKev7SwaBD9cZkpAehcWC7SsFgjM7R0S6zY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894

On 10/9/26 14:35, Matt Evans wrote:
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
> ---
>  drivers/dma-buf/dma-buf.c | 21 ++++++++++++++++++---
>  include/linux/dma-buf.h   |  4 +++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
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
> index d15b2b31d3c9..9f3c92c71c29 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -303,7 +303,9 @@ struct dma_buf {
>  	 * @file:
>  	 *
>  	 * File pointer used for sharing buffers across, and for refcounting.
> -	 * See dma_buf_get() and dma_buf_put().
> +	 * See dma_buf_get() and dma_buf_put().  Exporters can use
> +	 * get_file_active(&dma_buf->file) to safely acquire a reference;

Please add something like "* when the exporter holds a common lock with the ->release() callback".

Apart from that looks good to me.

Regards,
Christian.

> +	 * the file could otherwise be closed at any time.
>  	 */
>  	struct file *file;
>  

