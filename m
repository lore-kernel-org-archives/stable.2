Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CC331EB5;
	Tue, 23 Jun 2026 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196727; cv=none; b=aMn+779ENDpO21mfZRMD5kHuRKyPU0CPWoBub41895wQ7ahh9bIB3LBrLHJpRAdbErCCh4kBnLUiCsuY1p/X2kh8d0YdFgDfbVyQp9Zxj2n8DvL6g0pz/uonYy0B8bxApCvVY6FQMmvI7rPk+Imep1OPydVvQldcBd/8bX3bomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196727; c=relaxed/simple;
	bh=/JsyBfxzwzzP+pjXRqdXd1zFotKrebTK1svJAxc2/kg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gAZSVs6lJKsdWilsOGnFgdrNV9kIKvsFSNgWdG55qVpr8SY9xCfOUjRfh/vqXzzK4pv7zFnAYmvoqF1YsGHg86g38QiHX0FAGIWxD9ILmE7djEtwfEl/hsjaHcsYuxtJu3PIS6Y1wfupBdaTlUwLPvoeCph+B+taDmnNUYD4SIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYiEzcMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYiEzcMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9AD1F000E9;
	Tue, 23 Jun 2026 06:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782196725;
	bh=AZWDb6IeOrOj74EeRXqPcDcvK6g2drp7a/Cr1Fkr8gE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=iYiEzcMcfi/Na3EuA4mMeUgBOgfKeKMMAgPp3YDWIx+BwkMVnDp+0ILESuyhZblvi
	 uftyzMNgCfs04Ojl6QLv066M2f1HDYl9GpwUL36VmSt41+9/5DCy/kU1CG6HladTAL
	 cPekegzkX6+M+wahN6aH5fVW8tlMlgnuW9VNK3dOAitLXYdxdSsRLOF+DIYsJfe+UV
	 d+2ezGRQyvKTfhgSP0S+bDfMhplC3B3Ns9yY9VgjH/bz/SH9/hqrhwZJ/w9OFeBjhG
	 RIFUGABg5Yxx6CZ1Vh1dlmGMvJ3lruwb6pBkUCE+1WqD+Zz22+eH5uDfL6b57VfiyR
	 7wtQO0CoLvl5Q==
Message-ID: <2b98ff5d-e66b-4c31-b718-000eca3dd467@kernel.org>
Date: Tue, 23 Jun 2026 14:38:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: dirty directory inodes on mtime/ctime update
To: Joanne Chang <joannechien@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260623063428.222361-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260623063428.222361-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 14:34, Joanne Chang wrote:
> Xfstests generic/547 sometimes fail with mismatched directory metadata
> before and after a power failure. This happens because when a directory
> entry is added, renamed, or deleted, its mtime and ctime are updated and
> the inode is marked dirty via
> f2fs_mark_inode_dirty_sync(dir, sync=false). The sync=false flag means
> the dirty inode is not added to the global DIRTY_META list. Therefore,
> subsequent checkpoints skip flushing these updated directory blocks,
> causing directory timestamps to revert to stale values after a sudden
> power failure.
> 
> Address this by changing the dirtying parameter to sync=true during
> directory entry mutations and renames. This forces F2FS to immediately
> queue the updated directory blocks on the global DIRTY_META list,
> ensuring timestamps are committed to checkpoints.
> 
> Fixes: 7c45729a4d6d ("f2fs: keep dirty inodes selectively for checkpoint")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
