Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F53CE4B1;
	Wed,  7 Oct 2026 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409134; cv=none; b=RtCwR9kcawg5WmFr4pk4ZxrHkaaWoChrXk0FImoiFdjsSWYvwfVcX/9ZccfAT9btXd7Sxyz9sAte1QJyVgdKDqnGGqzgcu0+2jKs5I+UT+U3/eoFlCkIojDE2BIJIZa16NkOj/+BEprYAkdjn7jz4yWKNQah1ipeVjaLW5FcIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409134; c=relaxed/simple;
	bh=GkUIrRr1ppBry+WpUtDYU+DIKizszRyQMXBou7OYEvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Anm6vAQIVUzyj/UBQ51+zIy7b6kk3w7bWbWo4piw5qXFsxjQ7Zaf2uekBBdNABFhrWrA7hWHaPDhm9CTgvvWff/591C3ACr4vCyxNcCZIKcdTlMaYH6vgn9hy1LSrzzE1HpBFjTFD/Qf3D4aBRcAa5XBKEwlF20VDAWrhWw4NHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=QcLFVHu1; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="QcLFVHu1"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 93ABE32C;
	Wed,  7 Oct 2026 21:33:10 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=QcLFVHu1;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E6F7621D9;
	Wed,  7 Oct 2026 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791408738;
	bh=QwUzb8TDVEWRLuySkAhiKAopW46J6Jzx0gohNV2JJ7A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QcLFVHu1To/MD+JaRxrK61im3FaIw67Kg8JATNoiZ5davwIhQy9sHe75gZLSkWi1T
	 uH/4tVqdrap/I+QgT+hJEgmdKS2C/QxVTOK2DquyM4f3qcJlPG+TfEoRou7soFTjP0
	 a9Q1xMOjfZh1xmqR+wL1OYiBTXBsMspII1DXWCs4=
Received: from [192.168.95.128] (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Oct 2026 00:32:17 +0300
Message-ID: <33847e79-7ac8-4e96-95d2-4b8a3cda14b6@paragon-software.com>
Date: Wed, 7 Oct 2026 23:32:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: validate that EA entry size covers its name and
 value
To: Your Name <qwe.aldo@gmail.com>, <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260723221045.529665-1-you@example.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260723221045.529665-1-you@example.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 7/24/26 00:10, Your Name wrote:

> From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>
> ntfs_read_ea() walks the on-disk $EA attribute and checks each EA_FULL
> entry for consistency.  For an entry with a non-zero ef->size (the
> offset to the next entry) the loop only verifies that this stride fits
> in the remaining buffer, and then continues:
>
>          if (ef->size) {
>                  ea_size = le32_to_cpu(ef->size);
>                  if (ea_size > bytes)
>                          goto out1;
>                  continue;
>          }
>
> It never verifies that the entry's own name (ef->name_len) and value
> (ef->elength) actually fit inside ef->size.  A later reader trusts
> ef->elength unconditionally; ntfs_get_ea() does:
>
>          len = le16_to_cpu(ea->elength);         /* up to 0xffff */
>          ...
>          if (len > size)                         /* size is the user buffer */
>                  return -ERANGE;
>          memcpy(buffer, ea->name + ea->name_len + 1, len);
>
> A crafted image with a small but valid ef->size (e.g. 24) and
> ef->elength == 0xffff therefore passes validation, and a getxattr()
> with a large enough user buffer copies up to 64 KiB starting just past
> the short entry -- an out-of-bounds read of the ea_all allocation that
> leaks adjacent kernel heap memory to userspace.
>
>    BUG: KASAN: slab-out-of-bounds in ntfs_get_ea+0x2b8/0x3f0
>    Read of size 65535 ...
>     ntfs_get_ea -> ntfs_getxattr -> vfs_getxattr -> do_getxattr
>
> The zero-ef->size branch already computes the same struct_size() to
> derive the stride; mirror that in the non-zero branch and reject the
> entry when its declared size cannot hold the name and value.
>
> Fixes: 0e8235d28f3a ("fs/ntfs3: Check fields while reading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>   fs/ntfs3/xattr.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 04814dd29375..57114fb726f7 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -155,6 +155,24 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
>                          ea_size = le32_to_cpu(ef->size);
>                          if (ea_size > bytes)
>                                  goto out1;
> +
> +                       /* Check if we can use fields ef->name_len and ef->elength. */
> +                       if (bytes < offsetof(struct EA_FULL, name))
> +                               goto out1;
> +
> +                       /*
> +                        * The declared entry size (ef->size) must be large
> +                        * enough to hold the name and value.  Otherwise a later
> +                        * reader such as ntfs_get_ea() copies ef->elength bytes
> +                        * starting past the entry, reading out of bounds of the
> +                        * ea buffer and leaking adjacent heap memory to
> +                        * userspace via getxattr().
> +                        */
> +                       if (struct_size(ef, name,
> +                                       1 + ef->name_len +
> +                                               le16_to_cpu(ef->elength)) >
> +                           ea_size)
> +                               goto out1;
>                          continue;
>                  }
>
> --
> 2.43.0

Hello,

Your patch was applied, thank you.

Regards,
Konstantin

