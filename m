Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433E3769FD;
	Thu,  3 Sep 2026 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476927; cv=none; b=Zt1fnFbCaB7tJ5fEhcG1xyaAdd8TGb3Ui1ZXNsGmHx2YoBf5NdH990po9v1aPiWLPRRSflZWKm3/4S6S8nDJfUvvw3HL5WLLgDp2S1mqgMs6sl7ty+oI3zxKSryB54w54ZipCAP+S+rUj/qN3AaaaiS2+n6MNlh0u8d+sRniqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476927; c=relaxed/simple;
	bh=18DPBe0iwWQ7yGhF5eQtvhLFjh9Wglm6olsLtIjVhKc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NFQLBksoXsY9lwjXq1f8BDCmUHeT41zH1MV90dJEC8RpJFwFNeHkRtU4SpGxd+37AHSSYBwnmcFZyswPucyfYa+bNhQoCzkbHLSU+pNwovYv/XtV4cQbecT6mzDT1nzQ0jw50hlebmTv6Puv16l/oR9g+YJ8UkME0m8Q7/3nwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGp5qUEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGp5qUEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1631F000E9;
	Thu,  3 Sep 2026 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476925;
	bh=hHj79ivnCIVQ9oSllj2cnlRWSVM8NqFq3uES2gy708g=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=MGp5qUENaJhoALBIifj9MxMBnpcVab85xm/plvjj3SBjz5XgEeG0DCEqwe68cAhTS
	 Udfv3C17JKhGtkpIN09P+mqW3DSi8B1xdzsGoQpir/j3E+33Qsc0brhii8U3YWy661
	 y/1LO8syJYXy1c0UsiHlTuLVa+gQdOlkodGyrbGNbbqmvlsFY8sNrhSEtFQxZkCUKo
	 g5SkZFC7b8Xrh2/72cbvhQUlG/1Po41bUVpJl+FTJ6r21c0P32Xs/MZo2jeoyzt1IA
	 6mt/aPoofbJ6cmMpgRR8Ynz7Sv+Vo+WT3RoT+JvsfYb7j9YeMBhr8ASsammssxEpo+
	 hz1hGSxTa8H7w==
Message-ID: <12ea8eda-403b-4932-90ba-beadb1354533@kernel.org>
Date: Fri, 4 Sep 2026 07:08:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 stable@vger.kernel.org, Wenjie Qi <qiwenjie@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: drop pending discard commands before
 reserving device alias
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260903161031.1280195-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260903161031.1280195-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/2026 12:10 AM, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When reserving a device alias via f2fs_ioc_reserve_dev_alias(),
> f2fs_reserve_device_alias() bulk-marks all blocks in the target device
> range as valid in SIT.
> 
> However, if the device was previously in the released state, stale
> pending discard commands covering that range may still exist in dcc->root.
> When f2fs_issue_discard_thread later processes those commands,
> __check_sit_bitmap() detects valid blocks in the discard range and
> triggers a kernel BUG().
> 
> To fix this:
> 1. Introduce f2fs_drop_discard_cmd_range() to traverse the discard rbtree,
>     drop all pending D_PREP discard commands in the range,
>     and wait for any in-flight discard bios under dcc->cmd_lock.
> 2. Call f2fs_drop_discard_cmd_range() in f2fs_ioc_reserve_dev_alias()
>     before f2fs_reserve_device_alias().
> 
> Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
> Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
