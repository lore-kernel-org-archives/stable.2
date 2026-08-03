Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B33A4F2F;
	Mon,  3 Aug 2026 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738884; cv=none; b=l9k3x1/bu985YRLMaxrPY1RJ/8aJv/cH9GFqmiEGN1erKCPBww411VNG5u1XJsAy/+7Ed0VjXyWFgDB3QCuu0SNsXM9F0I0sqphpQRbZPmIf0+b9WKv9gf+g5GYtNsfpC/zT2e/DrVU2gE4XpOWc/mOqWvtnDyHgnQYIX4NXrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738884; c=relaxed/simple;
	bh=rajIQLXyhV8qIEomluIxQ8rbuxL4Ex9MVkwlWveKCZQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=txR8viJel9FAP55D0kIXSRpsKPurUAwEw1ZDSUfMWwbcCL+dgpu7c3qfzXvNa8UN7Mj3yFp0GWsGM0uh/Coj/tQTQHVycmWFDymqsKrMD2Km4y0vkMBMeBwSZx6sMzecjsoTa4PFE/J92ExMJtuep4xYX62EczyP4vhLMp5m2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFKnAWgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFKnAWgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6BD1F000E9;
	Mon,  3 Aug 2026 06:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785738883;
	bh=1xo3QhVa/3N9gRoVOTnoKB8qxDMTYOzjDluERd6gZBU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=EFKnAWgOtmuT+4QF3+nakc7y7eOiN2UZDdvKWVwyy1UzWcS/Ni1vMTBXa5uxbKDV6
	 ZhQ2ttGIBL5RhJDaZPO27DB7T1C9iZIG/lzp6mhcTztSh9wcqjSP2f6Y0KMb245/YR
	 jxdl1TsoaLaYpawiNzMAZtuRytY1zThgtbKDlaex/ri27PJrbV0nUnv3Vv6UqTUjHQ
	 dUYSoTYmp1zj/0kcwK8rtd0Uhp8J+zIOzmZfZHaJsRDkXP6WVqq+N7JTzONvpjR/uV
	 9aSZoq4qfK3dPTGljTAnhmYOiBpq1LPzwGGuceUDP/Pn+Y5mAkKgknp3RhxWWeWVQx
	 GxKdCfiRAjNDA==
Message-ID: <2405e513-c1be-4281-8ab8-bb1ed48bbf14@kernel.org>
Date: Mon, 3 Aug 2026 14:34:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Christian Brauner <brauner@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, Jan Kara <jack@suse.cz>,
 linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH] f2fs: use the mount idmap for the owner check in
 f2fs_xattr_advise_set()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 10:59, Zhan Xusheng wrote:
> f2fs_xattr_advise_set() calls inode_owner_or_capable() with &nop_mnt_idmap
> before allowing the "system.advise" xattr to be set, instead of the idmap
> that the VFS passes to the ->set() handler.
> 
> f2fs supports idmapped mounts, so on such a mount this checks the caller's
> fsuid against the unmapped on-disk owner rather than the mapped owner: the
> actual owner can be wrongly denied with -EPERM and an unrelated caller
> wrongly allowed.  Pass the handler's idmap instead.
> 
> Fixes: 01beba7957a2 ("fs: port inode_owner_or_capable() to mnt_idmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
