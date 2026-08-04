Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101F3D090E;
	Tue,  4 Aug 2026 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805697; cv=none; b=GmpHdJi5xewcEKgl5Mwm3lmTiRlZACtCi2EcWlC6AUaJLoV+6slHjOl5tFYcKuvIwcnml/XMxUjVEyNWiHp7F0J5Cnc6CA8glmJggPgTxxp5HEgkvimkjNCyhakfxCiorap/kT8rvbrt4p7y1FZ2/53Xr9sDVgKaxKDaWWSuwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805697; c=relaxed/simple;
	bh=5/bvErDhzFm+kQaeTRq6uxU8JTrmV1hMzzh/dq/zyUQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bWIAbbdVVkWScCPyYAbUvrPo5CA1TgQjATYnPv8K49YkRfKd4MKHjuirHK5Z1AIFLLL4PUqOEZfk41KqFeW9FqO2YKszashAaj28wUmDhZqP0Wuzx4kb+JJdsc4SL83rAeZJMazyiwZSgWFQespvlXyJ6vOp2wvoFxtK/cIK+Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgJtHwk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgJtHwk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87EB1F000E9;
	Tue,  4 Aug 2026 01:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805696;
	bh=oO/QqiHM5COrVfZG+imXes33nJ7bxHczWxw9WoEHN3c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=WgJtHwk9SCJ5b6fwh5xtUMdYnQITCVxX9mq1acJTmBnFbQIw/xxu8PtQkktfmvxoz
	 HuMOfmaX3dXuARiIWxgXF6diqtbdkfNADGNF2Jp6LTV5SN+mHqHTZcDHuPCx6CC53i
	 7FXBFPwurK0pAJBsBdgne9JJhmAFdXrAF5nghPMEeGpDlTfUJpvlDkONQSZsL+ffKP
	 Ittpf5mMPhgvC+jq1xfvG+QUevSlG2b4DKgviaYB2xjFagjYDSpKUCZhSTEBbWossW
	 ZHm3+2q3CKCN5dT0kIV5obeZMn8l+Aewr+AFpDuy/0zNv2eAiUoG76BW/vJvk3fgEz
	 Gijm6Ob86a/Hw==
Message-ID: <6229b2bc-3167-410f-a1ad-659aaab07928@kernel.org>
Date: Tue, 4 Aug 2026 09:08:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, ccc194101@163.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix valid block count leak on data block
 allocation failure
To: Chen Changcheng <chenchangcheng@kylinos.cn>
References: <0b450e92-b9b0-4a55-bd16-ad106245d7e1@kernel.org>
 <20260804005402.13026-1-chenchangcheng@kylinos.cn>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260804005402.13026-1-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 08:54, Chen Changcheng wrote:
> In __allocate_data_block(), when allocating a new data block
> (dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
> called first to increment total_valid_block_count and i_blocks.
> If the subsequent f2fs_allocate_data_block() fails, the function
> returns the error directly without rolling back the
> already-incremented block counts, causing a permanent leak.
> 
> Fix this by calling dec_valid_block_count() to undo the
> increment before returning the error. The condition
> old_blkaddr == NULL_ADDR precisely identifies the case where
> inc_valid_block_count() was called.
> 
> Fixes: 7d009e048d7c ("f2fs: fix to handle segment allocation failure correctly")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
