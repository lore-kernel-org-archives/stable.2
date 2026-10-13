Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CC4E4C35
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891834; cv=none; b=Gjw5oU97Sd9hJ94p9ddNreD5YNZ+nu78YaclRVaDs4mDjCD7ojhva2NPpOlRB62Ash8zz5D0jemcfdWxwJEUU2xoKTFIK+LCUfttgkBHMmErNPABDp2q+JhTLEqv0GPSVvbe58mM0OOMAj4QhASpO8NLLHA4aerAOPtsHJL52TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891834; c=relaxed/simple;
	bh=0I2WSfhpD2vNef4gRrNMapVa93mmVG72XRrRt29COh8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bnl7QojUDjMWdsrYj+7aZgJX0L9CyHbG5DcHQb/p2GaoPY8ZAQTW9FEQUwBWWrysZKHI/rAcvtEQM1Ky+pwSiyUubgG5Cay9BSHwiPhb9Ae5tW7OxBYglZzAEvz+7/nNmVgkMC1Sluh5DU1NkR447Q7Azl7AI6B28JuHMQfrS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz/4qzLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz/4qzLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CDD1F00893;
	Tue, 13 Oct 2026 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791891832;
	bh=WYqP17YR8Fnv2z690xmACFHdaqhjm09/Y/uZ/X3/pZc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=Pz/4qzLr47zKazdpyX/o7xuvU7HgouSJ3+E1/HkpjyGc0QwVUgU81QDIrM6kRoyQU
	 jKVKTvgdNBU9syYmaSGbHPWB8GLf1go4sf5+oUkvdZU94fB/HMbch7kKUVXjE9c3Rx
	 1awkIstap36u4wVYfHzyewkhzZR7gMRCpusNTIgVM/6I9Rli/iR9OT5oGoVBzJBJoY
	 rJcGojwAtCGSXfFAeJyZ8qy/Hg+icOOT9Xnzoer6W9zA+J/b0GeepiQZxy/2EFomda
	 aocvKVZeJEX+K5PXDbRH/08ewerEQdabFaFYgiQvIBRJajNKcoL9Vhva4F+PJISf7G
	 JMMDljCknwpCA==
Message-ID: <ff9241ab-c017-4b15-a0c4-4d5b660130ba@kernel.org>
Date: Tue, 13 Oct 2026 19:43:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Barry Song <baohua@kernel.org>,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: read i_size once in f2fs_vm_page_mkwrite
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Daeho Jeong <daehojeong@google.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261013105628.869156-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261013105628.869156-1-zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 18:56, Nanzhe Zhao wrote:
> f2fs_vm_page_mkwrite() reads i_size twice: once to check whether the
> folio is partially beyond EOF, and once to calculate the offset for
> folio_zero_segment(). But a concurrent buffered write can extend isize
> and cause the following race condition to corrupt data:
> 
> buffered write writes [0,3500)
> 
> CPU0 (write fault)                        CPU1 (buffered write)
>  ----                                     ----
>  f2fs_vm_page_mkwrite()
>  folio_lock(folio)
>  if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
>  i_size_read(inode))
>  /* i_size_read() = 3500 */
>                                            write(fd, buf, 200, 4096)
>                                            /* writes into page1, does not
>                                               wait for folio lock */
>                                            i_size_write(inode, 4296)
>  offset = i_size_read(inode) & ~PAGE_MASK
>  /* i_size_read() = 4296, offset = 200 */
>  folio_zero_segment(folio, offset, folio_size(folio))
>  /* valid data [200, 3500) is zeroed */
> 
> Fix this by reading i_size once and using the same value for both the
> EOF check and the zeroing offset.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261012030315.978375-1-zhaonanzhe%40xiaomi.com
> Fixes: fbfa2cc58d53 ("f2fs: add file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
