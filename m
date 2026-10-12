Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6608421240;
	Mon, 12 Oct 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835618; cv=fail; b=aEuq92p0v9aFfLKtzygh/Pp2RBRbqH6x6PJz70X5PFFXTJdkm+1uwufpj1FjMVqxYQSQFqvEs2mxEHUCweD3CgNJvncw4J2WjBBpne41cyqNmLjf+EZi+mIpgkLsuvbPRr9jUJ5TQxT2qrGvxAQY7SaLWo0BqXlWNCzlZSP1Tro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835618; c=relaxed/simple;
	bh=oecym9HL3OKN5XGCsJTVBovVW3OC61K58waSVMr1a6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvoqgGY8AMbf9VbmK2iBDAUE5APwbGh8B6qYOstNRCSuK2hWz+BQxYl+h3Lzjn0o6t5ZiY7u5P8qwnhdihP/C/0Y+ARrNZUJd7ooLUQIsZDPSsR9EOMgTudbeA6IR312CnnJ/P6SH4+AX+zLuKxoIr7UJq5NSv+YQJka+2l/cIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X/kHv6JV; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X/kHv6JV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzwZDJI57mRUv0pmvY9YFmM2ofRBpnV1M9fi6/YeYhpHuTuOhWhtKNuOUvEQv53y6LJ4VA//evzwO7hWPbR0DAvqEo8j0IQErX/vX3AFppKekWNwd27IXr8lW6Z49tH8V020X6e++7TZPkiNOrMHygsEwTPqysbMxcgGtlvD3+CJmNgcqqIt26foQTmVRQgsYsmzArQXNOtrf7neK5LU2VQtoL9/QRn7dji+kenPztXttLZZwzxyZu98+N09WPpje2wBnMWI9NRZ1FTmb4Zn25YiYEpCrbxu2v0GzuBkgyTGAIDXKIlkbBXYzWCfG7ZZGgXvhOfK0OvB8LTEo8CWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asQn9FT+lvozQJSTUztr9sYKDDXy0SK5yZRbrvnfzHI=;
 b=scGp53bcBg9C/yetv8k8Qcdi/HuCPDln06nl3rUDhJrLJ/DCzBUkUPgawCmwzD+QfQB3VrhMWP5vKhK/eDVFjBw6SvoCJzxKCpT1WhPOBUmg7qySBGbXFfzYKf3ZJ1gPz0usjGM08zo4ajJZqoRfi8ZJ9Xnqlez/TMgrpaxkRC+TA3gfdMydq4gFrfcSEj0b2UYDTC0ugZ2j11vBeIi75j7rZm/tGqOd37UmZRqATNSKmhn5hNwaCc2G6ZSWDbixXK83efTcrGsXbQPxUGhy42Zy3cA698oODKjM3k9/z7wkIIIOpiNYXkG8E6SdmF2oNS23z9TdrtXwl97vPo0dgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asQn9FT+lvozQJSTUztr9sYKDDXy0SK5yZRbrvnfzHI=;
 b=X/kHv6JVyANG3mfMB85WcnQWYQ/xhx+VJIav+yRn+m9Cnh48Qd629b8mSs2MYi1zZWvbUVzImpl47cR5++jyJilT4yRstxakyXyuPHNbJIP/jWDhdBkUQntzmHFMiIaaT62X3T38BEcCEGEcrngRqo0EHZtI1du2o8cP47BtCZU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 20:06:49 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 20:06:48 +0000
Message-ID: <797bb933-adf3-41c6-8421-ffc3bd6948f9@amd.com>
Date: Mon, 12 Oct 2026 15:06:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amd/display: keep custom brightness curve in
 userspace domain
Content-Language: en-US
To: Andrei Rusu de Castro <arc@empyreal.works>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 chen-yu.chen@amd.com, ray.wu@amd.com, stable@vger.kernel.org
References: <20260902-brightness-cover-abf809f2@empyreal.works>
 <cover.1788388049.git.arc@empyreal.works>
 <8ec5dc8922407924f771d353cb7f2dd1846553ae.1788388049.git.arc@empyreal.works>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8ec5dc8922407924f771d353cb7f2dd1846553ae.1788388049.git.arc@empyreal.works>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:610:75::9) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 88baf530-c640-4637-bccd-08df289c5916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	JehVaGkBe55/EnQr2N0iiUgKy0HFQdhEzaQQBJW+Dv4aK+maKO1BNg7ffMhowH3Li1cz9ULfvMCcPOpErwaQ2PI439yMZKrzs8OUTjLrRaJNI3t7A2cPvhflgQZmYgv+9w3AVVMMpB/KNxh7lp9VhMmQ0sLL4Sgeq9clTwX8mPO6l14//YgAJkylWq5CsL/A0tH6xISvG4Gfjr3AD//Py7SK9iN04QPk3f6shjfbadMBnM3eFvSPd2JF25xcF31BGmBJEzpoX9/OyRtbeUtXQbgbgMX9l0xAhJABC+4cVeZGexeCtuGRbfRBXtOfu6oFiwOh92m3+ghVQkiJeqmjDC1V+HO23sIweXJ1TOWMvavv0wWH4bmyQnxkCYB+/KfhtFdXapjWuxivAdgIYB+G/tsXqBPYJ3v34CqmfLMgM2iMHaO5Fvh7Ktwy0kNZhrcFCOPZiywmhSA1yaBT3NqG8bkKfbrY88w7riRqYYdxhrkoNrgUwXmCgd6QEk4Jx+X2K4jeIs4HCoAzJDZ7veqsv7K1FOWTarZr/0wPtejBhzSMknbWmStCHikwweCpMwknzZ+4yar6rdmUOUzBszx3fAhfVCwDjhFfmj0C+rtNMrE75vmG+DW+G9HuXg+DdScJAGyEJV2EgoCghQ53S6ogTZaHh/GiYfxK+oxo7gYlj3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0p5WVZWdnhjVnYwVW9Dd0tDcldZREVsSWJHVXJWQXpVcENJdGFzTnBlTVEr?=
 =?utf-8?B?bmlqeW9uQ1JtSzRPdkgwR29NNWg0SmpnM2pUdmZkT3NTdCs3Z05nbVlqSU5Y?=
 =?utf-8?B?dUtaZlBlSFgyeWd3dUhpNTRjd0pWNnAzTDZaYWZFbTI2eVRpT1VjK1JlblNU?=
 =?utf-8?B?NHpNVE03RVhIZndEZ0dTYkNKVnA0R1dZRTZLMEROcEtRdGVhZlBNVW9rUEpQ?=
 =?utf-8?B?emhCbGdlcTNQTS9TNW5FNlFyTUIyWW1SZ3BlcnRsVERhV0lWRmhMUkxITnN3?=
 =?utf-8?B?bll5a1FoSjgxdlpISTVhcytkMXZUUUg0UFNoSnNic3FrT29vdnQ0MGNGaXBh?=
 =?utf-8?B?Mmh1czhqcTNiWE5VTXh0STV3NjVuV2JpL1gyZmZPMTlaL3cybDFQamtTUnZZ?=
 =?utf-8?B?dzZ3UWtkSXhuVWN2cE5WcG5GZjM3TnNCckUrOHZrOUJZdjBITmRUdFNlNnpv?=
 =?utf-8?B?dUVJTjFrdEMxUWtZRGcwMWRCdXFJeGZpeDBsbjc1WE9jcG00Y0dRZ2xqR1Fs?=
 =?utf-8?B?bzNyYlArZ01DVUVuek14cFFxSVF1QzV3dFAyWE5SaldsQU9tZXJtNnpyWFNS?=
 =?utf-8?B?QmlWMlRpWHdEbTJjdGRGbWlwYWM4TXZRQXdZeHRWaUlyTmF4TXlnb1hlSU9v?=
 =?utf-8?B?ZUIrWDVrWkdoWVdPaUd5eXFrbTI3ZlhnYjhQeloyWTNhTXl3R2dJZXcxdDNj?=
 =?utf-8?B?WUtTcFZoQ2VYWWVJVTRQUGY0TW1FUXM3VFlkSGR4SUdDL0lITzlGdUt0UjB5?=
 =?utf-8?B?TGxuK1lVRFlRbjlzaXVPUEpmYUg1YzhFOUtrYVdadmJPeWpHa0RPTmRYa3A3?=
 =?utf-8?B?WlFTdGlRV2NqSmtwVkV5RjRWQW9pMFhQN2VmbU5zZGdhR1ZXYVNPUHp2YlUy?=
 =?utf-8?B?aUk2SERsK0xRMkk2VS9zSUZyek1iUWJLS0hnN2kzWVBmbzdZRlU0Z2VUeVJZ?=
 =?utf-8?B?ZjRZUnU4SUJyZjllbE9UTDZsYU50bnUvb2FNMUZNdVhzY0t6L0p4c0d0RnQ0?=
 =?utf-8?B?MkVUeEFWbmd6YjhsM2dKMUZSSFZSNU13aUo5RkgrSnpmN1AxRmV0YVo0TnBM?=
 =?utf-8?B?NEE2Q1lJaFBQWVE5d0tSeXBRY0Z6ek9Qb1BuUmNCNFZ3ZGtNbUtWWFYxUUxm?=
 =?utf-8?B?N09YOFp3QnhkakE5ZUVoUVBLa0J6eXhxbUNZQ1F2SXV5anRSeG1NZ2NRRkdu?=
 =?utf-8?B?d2tHbC9BQ0xJdjMyODdzYzhnejd2Q3BHMzN6ckd3ODA2QXBMaTQ1TDh3NzEy?=
 =?utf-8?B?L2FBM0tsV01iai9RbG1sU1ZGRFBUWGEzMVIvVXc2OFI2WFF6MVZlNTd6UmZS?=
 =?utf-8?B?QW5mbkV1elgrSCtjdWpRektSRldKSUFvWklWL1R0N0hOd1hrc2JWZERxVTVK?=
 =?utf-8?B?VGdCKzhGMHNSZk5vYXF6U0tZSFVNSE91bUxSYlNxRmRObTY0M1VGNjlFSlBJ?=
 =?utf-8?B?VVNqS0ZpMVpEMmhrb1M5eFdVK2VPdWtkRHdjM0k3eXlxRHgvUUVEWDBENXZF?=
 =?utf-8?B?eFRzbHdrOWpUOFdVTzY5ZDBDdklrdTgwNW9keE16ZytCK1BhWWxVYTBCdk56?=
 =?utf-8?B?UHhxbUhjSTFjWG9kTC9ZVDZtZ09Ja05PUlhHUlBlaGsxWWlHRTQ3dCt5MGFO?=
 =?utf-8?B?b0NPSlYvSFV5OGJkNVV4YjhuRVA4bTBRVUE4ekZXWklnSTBscHZwckVBSmhy?=
 =?utf-8?B?SFd1ZXU0elZKREdyaHZuUHl5WkJ1TVRqMEVIa0ZNY0duckJGRUV1OHFQVEl3?=
 =?utf-8?B?SUU0b2g5azJXbnZPUGRRN2dzVElMb1ZBQklJNTczK0Uwa3dRMHJ1a0F1cGhq?=
 =?utf-8?B?aUhYZEJGaHFxeXZMT283U1RIMTJhelEyYkVIcFRHVjZiaWpNdzV3aG5zZUw4?=
 =?utf-8?B?R3N3ZXZITmJGRnMyTVJVbkFXZFVtZm03QW9JaDFxV0I2U0xyem9FaXkxL21v?=
 =?utf-8?B?em9CSisrQmkxWlpFVWpkU1hGdVZ6NG5Zb05yWG9IMGNMaENIRzNPa1BoTGlQ?=
 =?utf-8?B?NU9NSHhialQ2RytnS1NsZTZWa1d6Qlo5cnJBSE5jV0E4ZFNqZlNwcEF5TVNK?=
 =?utf-8?B?Nk1wNzNTWU5hcEZUbFJGL0NtNm84K251NkF4ZnBwa0pyVkw1akFxSmpYTEI0?=
 =?utf-8?B?SENCd0cvNk92TDNZTVp1YjNJREEyMkduK2JwUi9LZUhUdjFVeWhRaGRjb2Fz?=
 =?utf-8?B?TXlQdmtWMlpuNDlIOHlUL0kzK0I0TnJMNmtOTGhyZGRGekpEYVVLczBPZTNp?=
 =?utf-8?B?MWs3Z3hVdVZ4WkZuUUprNzFFSHZOTmFScVhmY1ZNNSs5NG5ZUUpsRGxyTUNY?=
 =?utf-8?Q?UFetiQ4PArnrcnnqEE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88baf530-c640-4637-bccd-08df289c5916
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:06:48.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiI5HcgMBkOisAnCM+74lon6AMYJaXxj0vcfgeIXGOGYY5Bdo916QjheBV0kvhlMM4QmTh+lSQN0ourZwKW7+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734


On 9/2/26 17:31, Andrei Rusu de Castro wrote:
> convert_brightness_from_user() expects convert_custom_brightness() to
> reshape a value in the userspace [0..max] domain before the caller maps
> it once into the firmware [min..max] domain.
> 
> Commit 8dbd72cb7900 ("drm/amd/display: Export full brightness range to
> userspace") instead made convert_custom_brightness() call
> scale_fw_to_input(min, max, ...). That helper adds min and scales by the
> firmware span, entering the firmware domain before the caller applies
> the same span and minimum again.
> 
> With the default PWM range, min is 3084 and max is 65535. A zero request
> through any custom curve consequently returns 6023 instead of 3084, so
> the darkest 2939 firmware levels are unreachable.
> 
> Keep the curve result in [0..max]. scale_fw_to_input() then becomes the
> inverse of scale_input_to_fw(), and the caller remains the sole owner of
> the userspace-to-firmware conversion. The linear path is unchanged.
> 
> A later patch removes this helper from the PWM power-module path because
> the power module owns that curve. AUX panels continue to use it, and
> stable kernels predating the power-module refactor still require this
> correction on PWM panels.
> 
> Commit 6fd83a1c2cde ("drm/amd/display: Scale custom brightness curve from
> full range") fixed the corresponding input-side domain error. This
> completes the output side of the same conversion.
> 
> Source and arithmetic analysis identified the duplicate domain
> conversion. KUnit coverage for a non-zero firmware minimum is added
> separately.
> 
> Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
> Cc: stable@vger.kernel.org # 6.17.x: 6fd83a1c2cde: drm/amd/display: Scale custom brightness curve from full range
> Cc: stable@vger.kernel.org # 6.17.x
> Cc: stable@vger.kernel.org # before 7.3 this code is in amdgpu_dm.c; drop the header and test hunks
> Assisted-by: LLM
> Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>

There has already been some competing changes for how the power module 
integration handling works in amd-staging-drm-next.

I wanted to see how your series was on top of it, but it doesn't apply 
anymore. [1]  Can you please rebase your series and re-evaluate?

If it still makes sense (in your view); please send out a v3.

[1]
Applying: drm/amd/display: keep custom brightness curve in userspace domain
Patch failed at 0001 drm/amd/display: keep custom brightness curve in 
userspace domain
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: 
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c:112
error: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c: 
patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch

Thanks,

> ---
>   .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 13 ++++----
>   .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  3 +-
>   .../tests/amdgpu_dm_backlight_test.c          | 30 +++++++++----------
>   3 files changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index e61bbc310f33..424b33573a73 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -112,16 +112,15 @@ static inline u32 scale_input_to_fw(int max, u64 input)
>   	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
>   }
>   
> -/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> -static inline u32 scale_fw_to_input(int min, int max, u64 input)
> +/* Rescale the firmware curve's [0..AMDGPU_MAX_BL_LEVEL] back to userspace [0..max]. */
> +static inline u32 scale_fw_to_input(int max, u64 input)
>   {
> -	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
> +	return DIV_ROUND_CLOSEST_ULL(input * max, AMDGPU_MAX_BL_LEVEL);
>   }
>   
>   STATIC_IFN_KUNIT
>   void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			       unsigned int min, unsigned int max,
> -			       uint32_t *user_brightness)
> +			       unsigned int max, uint32_t *user_brightness)
>   {
>   	u32 brightness = scale_input_to_fw(max, *user_brightness);
>   	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
> @@ -179,7 +178,7 @@ void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
>   						    (brightness - lower_signal),
>   						    upper_signal - lower_signal);
>   scale:
> -	*user_brightness = scale_fw_to_input(min, max,
> +	*user_brightness = scale_fw_to_input(max,
>   					     DIV_ROUND_CLOSEST(lum * brightness, 101));
>   }
>   
> @@ -194,7 +193,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>   	if (!get_brightness_range(caps, &min, &max))
>   		return brightness;
>   
> -	convert_custom_brightness(caps, min, max, &brightness);
> +	convert_custom_brightness(caps, max, &brightness);
>   
>   	/* Rescale 0..max to min..max */
>   	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> index 07b75064847c..90bed0ea5d00 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> @@ -67,8 +67,7 @@ ssize_t panel_power_savings_store(struct device *device,
>   int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>   			 unsigned int *min, unsigned int *max);
>   void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			       unsigned int min, unsigned int max,
> -			       uint32_t *user_brightness);
> +			       unsigned int max, uint32_t *user_brightness);
>   u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>   				 uint32_t brightness);
>   u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index 7ca17f803f9d..1fb171fdbc3c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -1033,7 +1033,7 @@ static void dm_test_custom_brightness_no_data_points(struct kunit *test)
>   
>   	caps.data_points = 0;
>   
> -	convert_custom_brightness(&caps, 3084, 65535, &brightness);
> +	convert_custom_brightness(&caps, 65535, &brightness);
>   
>   	/* No data points → no-op */
>   	KUNIT_EXPECT_EQ(test, brightness, saved);
> @@ -1057,7 +1057,7 @@ static void dm_test_custom_brightness_debug_mask_disables(struct kunit *test)
>   	/* Set the disable flag */
>   	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
>   
> -	convert_custom_brightness(&caps, 3084, 65535, &brightness);
> +	convert_custom_brightness(&caps, 65535, &brightness);
>   
>   	/* Should be no-op due to debug mask */
>   	KUNIT_EXPECT_EQ(test, brightness, saved);
> @@ -1100,14 +1100,14 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
>   	 */
>   	brightness = 32896;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * Exact match: lum=50, brightness_scaled=128
> -	 * result = scale_fw_to_input(min, max, DIV_ROUND_CLOSEST(50*128, 101))
> -	 *        = scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(6400, 101))
> -	 *        = scale_fw_to_input(0, 65535, 63)
> -	 *        = 0 + DIV_ROUND_CLOSEST(63 * 65535, 255) = 16191 (approx)
> +	 * result = scale_fw_to_input(max, DIV_ROUND_CLOSEST(50*128, 101))
> +	 *        = scale_fw_to_input(65535, DIV_ROUND_CLOSEST(6400, 101))
> +	 *        = scale_fw_to_input(65535, 63)
> +	 *        = DIV_ROUND_CLOSEST(63 * 65535, 255) = 16191 (approx)
>   	 */
>   	KUNIT_EXPECT_TRUE(test, brightness != 32896);
>   	KUNIT_EXPECT_TRUE(test, brightness < 32896);
> @@ -1146,13 +1146,13 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
>   	 */
>   	brightness = 12850;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
> -	 * Then: scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(20 * 50, 101))
> -	 *      = scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(1000, 101))
> -	 *      = scale_fw_to_input(0, 65535, 10)
> +	 * Then: scale_fw_to_input(65535, DIV_ROUND_CLOSEST(20 * 50, 101))
> +	 *      = scale_fw_to_input(65535, DIV_ROUND_CLOSEST(1000, 101))
> +	 *      = scale_fw_to_input(65535, 10)
>   	 * The output should be significantly less than input.
>   	 */
>   	KUNIT_EXPECT_TRUE(test, brightness < 12850);
> @@ -1190,7 +1190,7 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
>   	 */
>   	brightness = 32125;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * The function should interpolate between data points and produce
> @@ -1233,7 +1233,7 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
>   	 */
>   	brightness = 56533;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/* Output should differ from input (remapped via curve) */
>   	KUNIT_EXPECT_TRUE(test, brightness != 56533);
> @@ -1271,7 +1271,7 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
>   	 */
>   	brightness = 16448;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	KUNIT_EXPECT_TRUE(test, brightness < 16448);
>   
> @@ -1309,7 +1309,7 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
>   	 */
>   	brightness = 32125;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/* Should remap; result should differ from input */
>   	KUNIT_EXPECT_TRUE(test, brightness != 32125);

