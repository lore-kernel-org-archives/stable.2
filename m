Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E44F0557;
	Wed, 16 Sep 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556990; cv=none; b=j1XWCdr/Duj3aJS6N6uUe7JjEhkaF+EIuAUf1eS15pxAPcBv8Ofl5a6i/phn104asG2yf/CTHRmDVey5mCiLeVcbHeMIYs3vVQiQ9i/D6MZuF7rETmtJPf/K6LDwDLaoFkLDHn+CZFYe5rQiuBGuaxGKkNd+5HP7gh1uAEoTYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556990; c=relaxed/simple;
	bh=jWFyJpUsRMx7N271rA7Y3FZ34J2Z4Zz1Q0HAcPKstGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UPamcCGkA+R1nhlDAdhaAoZIVfd3CrQ7XBUFBVliwUjrBS3Ls9M2lx+bMUEOg+XlOuencM3PwKX5qdGHGyvUeWpSxGnRGe+sy3LkwCJOdBrNNBTRzEhHj/bAzyFEDcvROXciBIzCJSFRQNWelhi1yYXg9QkcErS3eXr49QiKZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=IA1tzCrL; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="IA1tzCrL"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B1A5A1D42;
	Wed, 16 Sep 2026 11:10:32 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=IA1tzCrL;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E2E6721F5;
	Wed, 16 Sep 2026 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1789556976;
	bh=ufoEiGvDjW56QIljG80uTVBRam+3TD1jOBuisiF5NaE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IA1tzCrL+lVA/N6QpWtyGtTRc0M7NORZXy6AtjScmfmLG3dTcF4pokID7AWKcUhLm
	 h6DM46nA+Vhvu6y5/Goh8SNwri+eNGw3saicGNhGdl/sDLnx82uciQe+BNK9E8vlnS
	 3jFrK4tiIu86GHjrGWExg9RQtKDtNZ58Y5YClgrQ=
Received: from [192.168.95.128] (172.30.20.192) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 16 Sep 2026 14:09:35 +0300
Message-ID: <9294cf71-dddc-49bd-90c0-29fbcbc2815b@paragon-software.com>
Date: Wed, 16 Sep 2026 13:09:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: reject empty iomap before reading its LCN
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<syzbot+4b4ec878e25fafefa70f@syzkaller.appspotmail.com>
References: <20260630211743.50400-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260630211743.50400-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 6/30/26 23:17, Yousef Alhouseen wrote:

> attr_data_get_block() can return success with a zero run length when no
> cached or on-disk mapping covers a read VCN. In that case it does not
> initialize the LCN output.
>
> Check the returned length before comparing the LCN against the special
> mapping values. This preserves the existing -EINVAL result for an empty
> mapping without passing an uninitialized LCN to the comparisons.
>
> Fixes: ecbb433f9a8e ("fs/ntfs3: fold file size handling into ntfs_set_size()")
> Reported-by: syzbot+4b4ec878e25fafefa70f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4b4ec878e25fafefa70f
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>   fs/ntfs3/inode.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index c43101cc064d..a428f03a695d 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -777,6 +777,8 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>          if (err) {
>                  return err;
>          }
> +       if (!clen)
> +               return -EINVAL;
>
>          if (lcn == EOF_LCN) {
>                  /* request out of file. */
> @@ -811,11 +813,6 @@ static int ntfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>                  return 0;
>          }
>
> -       if (!clen) {
> -               /* broken file? */
> -               return -EINVAL;
> -       }
> -
>          iomap->bdev = inode->i_sb->s_bdev;
>          iomap->offset = offset;
>          iomap->length = ((loff_t)clen << cluster_bits) - off;
> --
> 2.55.0

Hello,

Sorry for the delay.
Your patch is applied, thank you.

Regards,
Konstantin

