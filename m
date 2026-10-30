Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355454;
	b=ybPvLQU6h4OrdjtI2Iduo90Z5zz7MQqQQVdJbcH9uBvIl3WtE2K+XiBaais9LpFEB2el
	 vL56ttJzUhV5ojCK/aSq2CY0AU7V1qH/rQzNNtVGgP+ClK+E8h/4gGGYR/aDq93oYFG8U
	 EqNXM913mnx7BP1GsNUMFE7AAziEPAmd9OJhdGj3QAHmOZvhcaKyFiVitBYggmfunEmbN
	 WQrAVfU9XwBUyXzsWg/xwXrVfjkkdDrNQ2xSE/Ip2CyNbR2RscEv0QeWZaAhmkdskTHp0
	 V5IC6LKLKyLnAwLmSIP+JnB46DqP8PukT29q/lb35WqLjwDT5ASVgA5DINH5uNVZt4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355454;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vBUdzf9+5JEYchc3xTK4SAZrJeZ/Y/pZNpI+PW7VW+8=;
	b=y8mDV7sSlViY9JJ7cNRG3u8ZfdPJOfePzhH8qmXWllQZXM0X3ZaCvSxxwuHAUKiyDNgO
	 teAmW6rNlWd0mLvzJnfwrhBVSNb/V98BG9ld2GLoBdmp73FopbghRRsWB9n7sAwYm3JCt
	 UwB1+6BJTtLlhXIQ1x8QpXRcdkAf3mYADKv52anC5JhOTwFZqvFL61GZe+tarALqBPLI3
	 ZLJ8gQ6/hiIYeCBpqa+69JdwS8TWYu1m0qD5qSWYJWcVIgMpit1wVK/k17sgrXniYZLpU
	 Z6qAuN02mHEqL3numXvlNobWrwzrcuYpGY3XADtBLzgobSbhhAHS7jlWGbXtkkUZokA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=xE3hhwbP;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b="R9/wjDkI";
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CE606A31C;
	Fri, 30 Oct 2026 10:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 372CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=xE3hhwbP;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=R9/wjDkI
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 2F31326F7664;
	Fri, 30 Oct 2026 19:17:31 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793355451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBUdzf9+5JEYchc3xTK4SAZrJeZ/Y/pZNpI+PW7VW+8=;
	b=xE3hhwbPnUR6Adh08DWezV6Sdi+AaNLuOV+2m885QzRQHj8ZvqVeFkMwtQ9T2Cs3/SyTPC
	xsHpH6sJATFlX0dszUeU5YQJANFPLryWgYDClAaQ9R5Wpyd0h148cfOBd8I+4qvKRLBk3p
	zKTViRXzbkOx4hjpdDzSAOvlvfoumZ/HCemY9CP+GtPCqnPrdoPu7QmTRqRF++vicvjZup
	sCkgzJDYjEf/IdfMG2tIVxJihEY1QYnTSXIAjx3sRRLTSpQUOA15fxWmaEX7jCoTa9BIs1
	qR14yVgI11VW68PPZxnC+UAXwhdCk2GqOd2imtP1WC4d6NQQ74A7WQACrVrxzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793355451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBUdzf9+5JEYchc3xTK4SAZrJeZ/Y/pZNpI+PW7VW+8=;
	b=R9/wjDkIRCnlWtZI+4jrh2V1/worsDuJfBQ2thxeDG+QvCpuqe2PSdoXhCZmjoWzgclbH1
	CY+iZjrBJIrSO1AQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id A8B51E006A9;
	Fri, 30 Oct 2026 19:17:30 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 9FFCA22001FE; Fri, 30 Oct 2026 19:17:30 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: brauner@kernel.org,  technoboy85@gmail.com,  teknoraver@meta.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] fat: check for hidden entries before overwriting
 end-of-directory marker
In-Reply-To: <20261030090205.279419-1-hengyul@cs.unc.edu>
References: <20261030090205.279419-1-hengyul@cs.unc.edu>
Date: Fri, 30 Oct 2026 19:17:30 +0900
Message-ID: <875wyjsdad.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hengyu Liang <hengyul@cs.unc.edu> writes:

> Since commit 6a2875517c77 ("fat: stop reading directory entries past the
> end-of-directory marker"), lookup and readdir stop at a slot whose first
> name byte is 0, and fat_add_entries() reports corruption when its scan
> finds an allocated entry after that slot.
>
> The scan stops as soon as it has enough free slots, though. When those
> slots include the marker, the new entries overwrite it and the allocated
> entries after it become visible again without being checked. A name that
> lookup could not find can then appear twice in the directory, and removing
> one copy leaves readdir listing a name that stat cannot find.

Yes, it is true. However, first of all that state is already corrupted
FAT filesystem.  And there would be many cases like this on corrupted
image. If we want to detect as possible as many corruptions, I guess it
will become finally the something like online fsck.

So I think we should not add additional sanity check has overhead
(especially to normal path) if it doesn't crash the kernel. Simple
sanity check is ok though.

Thanks.

> For example:
>
>   mkfs.fat -F 16 -C fat.img 32768
>   mount -t msdos -o loop fat.img /mnt
>   touch /mnt/aaa.txt /mnt/bbb.txt /mnt/file1
>   umount /mnt
>   off=$(grep -obUa 'BBB     TXT' fat.img | cut -d: -f1)
>   dd if=/dev/zero of=fat.img bs=1 seek=$off count=32 conv=notrunc
>   mount -t msdos -o loop fat.img /mnt
>   touch /mnt/file1
>   ls /mnt
>
> lists file1 twice.
>
> Before using free slots that include the marker, scan the slots up to the
> next marker and take the existing corruption path if one is allocated.
>
> Fixes: 6a2875517c77 ("fat: stop reading directory entries past the end-of-directory marker")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Tested on x86-64 KVM with KASAN, comparing mainline at d89e1d186ec9 with
> this patch:
> - The example above: the base kernel creates a second file1, which is
>   still there after a remount. With the patch, touch fails with EIO, the
>   error is logged and fsck.fat only finds the dirty bit.
> - vfat, three-slot create whose free run ends exactly at the marker:
>   the base kernel exposes the hidden file, the patch returns EIO.
> - vfat, one-slot create that leaves a zero slot after the new entry:
>   succeeds on both and the hidden file stays hidden.
> - Valid directories on FAT16 and FAT32, msdos and vfat (creates, deletes,
>   renames and mkdirs, then filling the root): the same entry counts, ENOSPC
>   on a full FAT16 root and no FAT-fs messages on both; fsck.fat -n exits 0.
>
>  fs/fat/dir.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 35bdb62944a2..ab99d53a719a 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -1318,6 +1318,32 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
>  	return err;
>  }
>  
> +/*
> + * The free slots chosen by fat_add_entries() include the end-of-directory
> + * marker.  Once the new entries are written over it, the slots up to the
> + * next marker become visible, so make sure that none of them is allocated.
> + */
> +static int fat_check_after_eod(struct inode *dir, loff_t pos)
> +{
> +	struct buffer_head *bh = NULL;
> +	struct msdos_dir_entry *de = NULL;
> +	int err = 0;
> +
> +	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
> +		if (de->name[0] == 0)
> +			break;
> +		if (!IS_FREE(de->name)) {
> +			fat_fs_error_ratelimit(dir->i_sb,
> +				"allocated dir entry found after end-of-directory marker (i_pos %lld)",
> +				MSDOS_I(dir)->i_pos);
> +			err = -EIO;
> +			break;
> +		}
> +	}
> +	brelse(bh);
> +	return err;
> +}
> +
>  int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  		    struct fat_slot_info *sinfo)
>  {
> @@ -1351,8 +1377,14 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  				nr_bhs++;
>  			}
>  			free_slots++;
> -			if (free_slots == nr_slots)
> +			if (free_slots == nr_slots) {
> +				if (saw_eod) {
> +					err = fat_check_after_eod(dir, pos);
> +					if (err)
> +						goto error;
> +				}
>  				goto found;
> +			}
>  		} else {
>  			if (saw_eod) {
>  				fat_fs_error_ratelimit(sb,
>
> base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
