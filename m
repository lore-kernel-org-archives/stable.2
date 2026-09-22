Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA57377ED7
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062501; cv=none; b=AccekSdaGEtJsFYCHJRzYujEsYAa5N+C5+iBugzMUlhvm2kJuhDHlbVB9PxVaLdy9jkYHwUyjP0B8EXvFhAiLiyFAC6uY8Y5cnh9W5EtpXS/Xv4J9lLArKb++qo4MIIQNNjwV0N2DGjp37peGUNj62swUse/I3UBnAzlJmNeoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062501; c=relaxed/simple;
	bh=ScYuWtPXF2fnvLspbMecGJNGtKANeNNCzpWG2nb8vjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjJDKqMI/Pmg9atzoi6fFCf0m9wKDT7ZxM+dc70CAJh26oNI8dJbQuht5dnQo2dgYCDf6hljnEi1xWt/f9ZeJK6Tft7MUAhpSBvj1syMpJwKGJUZcbzzE/GHY0bYF97qpKnAkMcqsDIyvpYQJEtqlWtGXax3vBGCG4qxKlmcoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mpVf3d6s; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mpVf3d6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=kE55ttdNodJ5Ejl7NpD1hyTOjVbCZT8pzaMy+lf8i90=;
	b=mpVf3d6s3I+U5DfljluQjr4GQ9G3B8yB6/c4QUTYbrpowwe7VRTlTHjZougDG9
	H3/3q0GnDh3fcoraCm6rZKGmKDs3ye5qJd/fqCwHrgOjIOGSujVgva0PctXyoeV9
	6r08odRomHN+pzl+ARcU8HtpWqSoqSP/9czqEfSV1zus4=
Received: from [IPV6:2409:8900:1ee3:222c:420f:a5a2:eb51:8645] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnv+V_L7JqH6dMAA--.22501S2;
	Tue, 22 Sep 2026 15:34:25 +0800 (CST)
Message-ID: <333a1499-f678-4905-9b97-08defe5805a4@163.com>
Date: Tue, 22 Sep 2026 15:34:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs: validate attribute-list sizes before allocation
To: Hyunchul Lee <hyc.lee@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, stable@vger.kernel.org, Robert Morris <rtm@mit.edu>
References: <20260922-fix-attrlist-size-limit-v1-1-c7e10b6c5656@gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260922-fix-attrlist-size-limit-v1-1-c7e10b6c5656@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnv+V_L7JqH6dMAA--.22501S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw13Xw17tF1UKw43Wry8Xwb_yoW7Xw1DpF
	9xCFyfKr4jqFyxCan7tanxWa48uw1UWF129ry3uw1IyFs8Jwn7KFy7K3yxu3s2yr98Xw10
	qryDWrZ7JrW5XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2-erUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gEz-WqyL4HSJwAA3m



在 2026/9/22 14:18, Hyunchul Lee 写道:
> The NULL point dereference could occur when an on-disk
> $ATTRIBUTE_LIST size was truncated before it was validated and allocated.
> 
> To fix this issue and prevent excessive memory allocation, limit the
> $ATTRIBUTE_LIST size to 256 KiB.
> 
> The following existing implementation and Windows test provide evidence
> for this 256 KiB compatibility limit:
> 
> NTFS already treats 256 KiB as the $ATTRIBUTE_LIST limit in its
> attribute-size checks and $MFT attribute list repack/expand paths.
> 
> For additional Windows testing, when $MFT's attribute-list data_size was
> above 256 KiB, Windows attached the disk partition but did not mount a NTFS
> volume and target access failed.
> 
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Link: https://lore.kernel.org/ntfs/88468.1790006025@30-10-12.wireless.csail.mit.edu/T/#u
> Cc: stable@vger.kernel.org
> Cc: Robert Morris <rtm@mit.edu>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
>   fs/ntfs/attrib.c   |  2 +-
>   fs/ntfs/attrlist.c |  2 --
>   fs/ntfs/inode.c    | 21 +++++++++++++++------
>   fs/ntfs/ntfs.h     |  2 ++
>   4 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index d8dd40526c3b..333b3371acb4 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1775,7 +1775,7 @@ int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol, const __le32 type
>   	 * $ATTRIBUTE_LIST has a maximum size of 256kiB, but this is not
>   	 * listed in $AttrDef.
>   	 */
> -	if (unlikely(type == AT_ATTRIBUTE_LIST && size > 256 * 1024))
> +	if (unlikely(type == AT_ATTRIBUTE_LIST && size > NTFS_MAX_ATTR_LIST_SIZE))
>   		return -ERANGE;
>   	/* Get the $AttrDef entry for the attribute @type. */
>   	ad = ntfs_attr_find_in_attrdef(vol, type);
> diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
> index 7c09d02fd941..1bbd2bc62c58 100644
> --- a/fs/ntfs/attrlist.c
> +++ b/fs/ntfs/attrlist.c
> @@ -14,8 +14,6 @@
>   #include "attrlist.h"
>   #include "lcnalloc.h"
>   
> -#define NTFS_MAX_ATTR_LIST_SIZE	(256 * 1024)
> -
>   /*
>    * ntfs_attrlist_need - check whether inode need attribute list
>    * @ni:	opened ntfs inode for which perform check
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index cadf623d54d4..99232a94cac0 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -805,6 +805,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
>   			goto unm_err_out;
>   		}
>   	} else {
> +		s64 attr_list_size;
> +
>   		if (vi->i_ino == FILE_MFT)
>   			goto skip_attr_list_load;
>   		ntfs_debug("Attribute list found in inode 0x%llx.", ni->mft_no);
> @@ -827,11 +829,14 @@ static int ntfs_read_locked_inode(struct inode *vi)
>   				ni->mft_no);
>   		}
>   		/* Now allocate memory for the attribute list. */
> -		ni->attr_list_size = (u32)ntfs_attr_size(a);
> -		if (!ni->attr_list_size) {
> -			ntfs_error(vi->i_sb, "Attr_list_size is zero");
> +		attr_list_size = ntfs_attr_size(a);
> +		if (attr_list_size <= 0 ||
> +		    attr_list_size > NTFS_MAX_ATTR_LIST_SIZE) {
> +			ntfs_error(vi->i_sb, "Invalid attribute list size %lld (mft_no 0x%llx).",
> +				   (long long)attr_list_size, ni->mft_no);
>   			goto unm_err_out;
>   		}
> +		ni->attr_list_size = (u32)attr_list_size;
>   		ni->attr_list = kvzalloc(ni->attr_list_size, GFP_NOFS);
>   		if (!ni->attr_list) {
>   			ntfs_error(vi->i_sb,
> @@ -1955,6 +1960,7 @@ int ntfs_read_inode_mount(struct inode *vi)
>   	} else /* if (!err) */ {
>   		struct attr_list_entry *al_entry, *next_al_entry;
>   		u8 *al_end;
> +		s64 attr_list_size;
>   		static const char *es = "  Not allowed.  $MFT is corrupt.  You should run chkdsk.";
>   
>   		ntfs_debug("Attribute list attribute found in $MFT.");
> @@ -1978,11 +1984,14 @@ int ntfs_read_inode_mount(struct inode *vi)
>   				"Resident attribute list attribute in $MFT system file is marked encrypted/sparse which is not true.  However, Windows allows this and chkdsk does not detect or correct it so we will just ignore the invalid flags and pretend they are not set.");
>   		}
>   		/* Now allocate memory for the attribute list. */
> -		ni->attr_list_size = (u32)ntfs_attr_size(a);
> -		if (!ni->attr_list_size) {
> -			ntfs_error(sb, "Attr_list_size is zero");
> +		attr_list_size = ntfs_attr_size(a);
> +		if (attr_list_size <= 0 ||
> +		    attr_list_size > NTFS_MAX_ATTR_LIST_SIZE) {
> +			ntfs_error(sb, "Invalid attribute list size %lld (mft_no 0x%llx).%s",
> +				   (long long)attr_list_size, ni->mft_no, es);
>   			goto put_err_out;
>   		}
> +		ni->attr_list_size = (u32)attr_list_size;
>   		ni->attr_list = kvzalloc(round_up(ni->attr_list_size, SECTOR_SIZE),
>   					 GFP_NOFS);
>   		if (!ni->attr_list) {
> diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
> index dd56894762a9..9557a5c36b81 100644
> --- a/fs/ntfs/ntfs.h
> +++ b/fs/ntfs/ntfs.h
> @@ -80,6 +80,8 @@ enum {
>   	NTFS_MAX_LABEL_LEN	= 128,
>   };
>   
> +#define NTFS_MAX_ATTR_LIST_SIZE	(256 * 1024)
> +
>   enum {
>   	CASE_SENSITIVE = 0,
>   	IGNORE_CASE = 1,
> 
> ---
> base-commit: 444c7dc82415a353b57e43189f276124cc5fd785
> change-id: 20260922-fix-attrlist-size-limit-a2a6a02feebb
> 
> Best regards,

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

