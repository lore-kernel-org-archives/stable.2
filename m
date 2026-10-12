Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455347043E;
	Mon, 12 Oct 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797079; cv=none; b=ng9QM6+tXNaGgmPnPIfvBj9Fr8k54eKLE67ymtvJ51PJERSSSxMM03lRsUN00zwLEv3rGGwgbYTRYrMGvC5PSFglyM8QTzd/HBh1kOHMR+5aEcM3AYopFQggpY4tcWYUgZk7h7ooQUU8QnuCVKn9YS4st/7EGYJo56ACNIsFnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797079; c=relaxed/simple;
	bh=rMzvUhZfnJf77GR/1JzrflBpRbX3BSl8iOkHwhcID3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mRqh9sYagwI3JumtQSunI7gKgMUXeF3+SXLffPLhmkGe/YQdrOFqtsmt6iQYGjpnAMK5TPgcGalPIcwNSXJtUab32I2OXa4lXMTkfb8LktFzpOCMNIpKQltMSDpt+JzHgLTRjihuN2K/mw3ZTX8QkRbHDvoeOeZfpvQxfezapOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMGkHUYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMGkHUYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365A91F0089B;
	Mon, 12 Oct 2026 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791797076;
	bh=M1/m/qtUDDLY19nWrHaMU7JoKzidKShEHRKqV/Cj+zY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TMGkHUYQfpKjxMgR0K2ALYdrhppHBxYXd8yRrwpARq6hXGm3dJ0E9dl0bHA9IgURn
	 qMoUcrQalA5xlRTCDq9F76vDMXxGIPSZCEWkIuk+D330dK6UJABitB1fYLw7/nTKIL
	 1bTVw3dwXrINFLR5nlIIMKmngczY9ZDi0PY+Cb/A132oqT+KBihCnH6kj1AETfWsoY
	 UN5ih1VuDkQZoYCzBAvLBH30ZNw0fTw6+7l/fyMqheI+TotSI+Q6cY/6dZ+zFdKXKT
	 98Sfby03oZrNGeQj+5uHbK5T3QnFZWDRfMI7cRytoIwIIAveNPZ7/LsGk+Zzzy6xzC
	 XHAcNUEmJvRkA==
From: Christian Brauner <brauner@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Bjoern Doebel <doebel@amazon.de>
Cc: Jan Kara <jack@suse.cz>, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261001082411.1493072-1-doebel@amazon.de>
References: <20261001082411.1493072-1-doebel@amazon.de>
Subject: Re: [PATCH] selftests/filesystems: Fix idmapped_tmpfile layer dir
 ownership
Message-Id: <20261012-kennst-sattbekommen-wolfram-595fd09c32f1@brauner>
Date: Mon, 12 Oct 2026 11:24:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Thu, 01 Oct 2026 08:24:11 +0000, Bjoern Doebel wrote:
> The recent idmapped_tmpfile selftest creates a new directory in tmpfs
> owned by user ID 0. It then idmaps the mount as caller [0,10000) to disk
> [10000,20000). The original uid 0 owner does not exist in the mapped
> range. As a result, mapped_caller_creates_and_links fails at the
> O_TMPFILE open because inode_permission() rejects MAY_WRITE access:
> 
>   idmapped_tmpfile.c:145:mapped_caller_creates_and_links:
>   Expected fd (-1) >= 0 (0)
> 
> [...]

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] selftests/filesystems: Fix idmapped_tmpfile layer dir ownership
      https://git.kernel.org/vfs/vfs/c/9ba6627ef6b1

