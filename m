Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60483DEFE7;
	Mon, 19 Oct 2026 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390054; cv=none; b=moi4juwjuDjBsolkAhdBsn4Ixdp6zxKucOcgvQpjpEWoiiK5+cVxzSVMootLAM2apW25JpMQf+4Nn78fl140qx94h+AcvOUBzTXN/uKqeQCc9PNBBtDoxMo5J4/ZioZgmotsEPN4swuxTngxo3/tZLH28ebEWNg3pJcnuyF2jc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390054; c=relaxed/simple;
	bh=AvT53PMABdsb43o6hWFTIE+xK4Rnt0EPhbzo4DeuB7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2ifjLSBCYfwrnw/gRoUlVEwWXCpChI1RM7KTdkFgRlze5LyUuaHcaqt6RnCmT+3+OE2N626hDaKWgvPS+AVrz6moxIZ4OVw7hLUfBRcsOtZ+UwtcKRDKZzJ8uNEKZNR5Qg236sNV9Yb0uxtsbnHttJ/gWkwMqOb1nBJ4YIcs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L3jvcvKY; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L3jvcvKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=O7dLuUHOhpFB0NeM5YAIx1ljBT5t+fuvLu6iocNmoPA=;
	b=L3jvcvKYYoM3/yaZmbO8ORqbomVRtYAnlo0Smcj5T9OvoY95cxKH0xiUW9ve99
	/F2UTI+Ogxgzdhuj5PevPRLjIv4fEjtznQ8e14pUVxHBISHszr3qyD1bZIhJalec
	umBrLFNz23C+zD717rh3xR4HEQLvckCBU/UE9g7nIddqs=
Message-ID: <b8913bb1-6f1c-4346-bbcb-8dc2fdaea9ad@163.com>
Date: Mon, 19 Oct 2026 14:06:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exfat: fix reading a directory whose FAT chain is longer
 than its size
To: Hengyu Liang <hengyul@cs.unc.edu>, linkinjeon@kernel.org,
 sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com, chizhiling@kylinos.cn, exfat@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261015144934.1800240-1-hengyul@cs.unc.edu>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20261015144934.1800240-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD37wl+s9VqmcVtAw--.22387S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyxtw15JF17WF1xXF4kCrg_yoW8XF1xpr
	W3Kw1akrn0yay8Grs7ur10vFy2krs3C3Z8Xr1kAw1UCwsagr92krWxta42gF95Awn3tw1j
	qFWYga4kZF98GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIZXwUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+B8cuWrVs390iQAA3M

On 10/15/2026 10:49 PM, Hengyu Liang wrote:
> Commit 08cf4a8181b4 ("exfat: use exfat_chain_advance helper") made the
> directory code walk the clusters of a directory with
> exfat_chain_advance().
> 
> However, exfat_chain_advance() returns -EIO once it has walked as many
> clusters as the size of the directory says. The FAT chain of a directory
> can be longer than that, because some cameras stop updating the size,
> see commit 1e5654de0f51 ("exfat: handle wrong stream entry size in
> exfat_readdir()"). As of now, opening such a directory fails with EIO as
> soon as the chain is two clusters longer than the size. Reading a
> directory that has a FAT chain after a seek past its end fails with EIO
> too.
> 
> The issue can be reproduced with an image in which the size of a
> directory with 200 files and 7 clusters is lowered to 2 clusters:
> 
>      mount -o loop exfat.img /mnt
>      ls /mnt/d | wc -l
> 
> Before commit 08cf4a8181b4 ("exfat: use exfat_chain_advance helper"),
> the result is:
> 
>      200
> 
> After that commit, ls fails with "Input/output error" and the result is:
> 
>      0
> 
> This patch will make exfat_chain_advance() follow the FAT to its end
> when the directory has a FAT chain, as the code did before, and keep the
> size check for a directory without one.
> 
> Fixes: 08cf4a8181b4 ("exfat: use exfat_chain_advance helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---

Thanks for pointing out this bug.

Reviewed-by: Chi Zhiling <chizhiling@kylinos.cn>

