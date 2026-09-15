Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA963911AA;
	Tue, 15 Sep 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463057; cv=none; b=Ei7f+RMZ2Z3znuooNTXtgsZRQJ+bNdwAvtCevftyefK+fIu3gNnCOwyVEUc9jLsCxLA//c6eKds3GQnCdbuZmSHX40FeG8uJr5h4emIUGw4avkaEA1NnkyFB7yNqyVEiwSaQZa8iDlockyOZmqIPdCo48CYn6/IXwyQMwx8mXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463057; c=relaxed/simple;
	bh=+6uT7KNWLXumr1rJCVeTkwseFAk+gExUoCACPXn3dOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkKSOKjjF/Jpjz7Snpk9ND1+fIhikgu8b9GFnpIXUrhz7kQapFf/LVXOf30tqieFiebl7DK5DfHjkA0fPo+927qNJ8h2gjGvg3v36ZwzUOeb4UlWMBpJ/JdkV6n5687aCGuzVR9NfoHns5HqUtEK25tbE58hi9xvdHed38EpalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MaQi80NC; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MaQi80NC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AY9gGrGJChwpWbeE4EQDvCCMwlEMRC+X8dbiirpVAMo=;
	b=MaQi80NC+fWVacnAkEOyz5QAodcVBrcNHfDkBzM59uLfx7cP3KkB2XKoDHZtwb
	GgDahk5dJsqgWnKJ0VfehClIXSe5ODcmh3INEfxyupA51yaN+TD3p13vsJYzaTzs
	JYsKwF7oJ+BoHwUswWSDwLwXCjXRqH0C+qFLTBge05T9s=
Received: from [IPV6:2409:8900:21a7:a33a:233e:9c3e:6224:4649] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCn6kzwCalq_3fhAg--.21S2;
	Tue, 15 Sep 2026 17:03:49 +0800 (CST)
Message-ID: <a615a9b3-3d33-45bf-b317-3cffc61244ab@163.com>
Date: Tue, 15 Sep 2026 17:03:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ntfs: write back the truncated range before dropping
 it
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260915062742.750092-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260915062742.750092-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn6kzwCalq_3fhAg--.21S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4xWry7ZF1kJr1DGryxAFb_yoW5WF1Dpr
	WakFy5tr4DG3ZrJrnxua1rZ3WF93yfZ3yUuFyUWFsFkFn5Gr1xKFyYg3yvg39Yyrn5Jw4Y
	qr4DXFZ3WrW8Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6xRgUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6haET2qpCfbwJAAA3f



在 2026/9/15 14:27, Hongling Zeng 写道:
> On a truncate, ntfs_setattr_size() drops the page cache beyond the new
> size with truncate_setsize() and only then updates the attribute on
> disk.  If that update fails, the size is reverted and the data beyond
> the new size becomes visible again -- but the pages were already
> dropped, and dirty data in them is lost, even though the truncate, the
> operation the user asked for, never happened.
> 
> Write the range back before dropping it.  If the writeback fails, fail
> the truncate with that error and keep the page cache intact; if the
> on-disk truncation fails afterwards, the reverted size can be re-read
> from disk.
> 
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/file.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 007d1614b9ac..1417a76788ed 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -283,12 +283,27 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
>   		i_size_write(vi, attr->ia_size);
>   		pagecache_isize_extended(vi, old_size, attr->ia_size);
>   	} else {
> +		/*
> +		 * The on-disk truncation below can fail, in which case
> +		 * the size is reverted and the data beyond the new size
> +		 * becomes visible again.  Write that range back first:
> +		 * truncate_setsize() drops those pages and dirty data
> +		 * cannot be recovered afterwards.
> +		 */
> +		if (attr->ia_size < old_size) {
> +			err = filemap_write_and_wait_range(vi->i_mapping,
> +					attr->ia_size, old_size - 1);
> +			if (err)
> +				goto out_unlock;
> +		}
> +
>   		truncate_setsize(vi, attr->ia_size);
>   	}
>   
>   	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
>   	if (err)
>   		i_size_write(vi, old_size);
> +out_unlock:
>   	filemap_invalidate_unlock(vi->i_mapping);
>   
>   	return err;

Hi Hongling,
   Thanks for the patch.  This fixes the page-aligned truncate case.

   However, this does not fully preserve the original data for a 
non-page-aligned truncate.  For example, with 4 KiB pages, consider 
truncating an 8 KiB file to 3000 bytes.  The writeback added by this 
patch preserves bytes 3000..8191 on disk, but truncate_setsize() 
eventually calls truncate_inode_partial_folio(), which zeroes bytes 
3000..4095 in the folio containing the new EOF while leaving that folio 
in the page cache.
   If ntfs_truncate_vfs() then fails, restoring only i_size makes 
3000..4095 visible again, but the EOF folio is still uptodate. Reads can 
therefore return the cached zeros instead of refaulting the original 
data from disk.

   The error path also needs to restore the folio containing the new 
EOF, or invalidate it so that it is refaulted from disk, with mmap 
writers taken into account.

Thanks,
Baolin.

