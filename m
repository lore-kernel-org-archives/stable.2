Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D8328B62;
	Thu,  6 Aug 2026 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983978; cv=none; b=QudLZp4McyG9BRiMEPPrmbtYl1+KeYERDXzMS9d44r/aIuZo0r/NcdqwDvIVlX6f+j/x4nF3Dj3G3kkv1nLm2QuY5gImpZftCrW08455obiqUL8v9TtOmZFzkeFbpxVAQc8X6B0R4jdL6HL+rc/SWmCTUVB5dbFx2khyGT1Ove4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983978; c=relaxed/simple;
	bh=znqWYK+kJAzSc8m8nkMxWv3ngkK/sEbvSqXnY69TPSQ=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=tiJaoLczJ4h5vVR/sBAcWb9E0uNpa/xGNzdGGxwfND2ROiPiGL9WlI7ly4NLtnFpuQroA4/uIjRoKjq3ogtaGU59JAR8DAb2DhIpUum1diPzYK6i8QY/k/8bCuErjtc74COVDp+j39RsaYETM5hM7QWaxz1m0d4t4/g2pgsbGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=K8S1fIKa; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="K8S1fIKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=DSfIgg5NWZj0se3kV3wMvKcY8bkrdATY3NQzbPHbp34=;
	b=K8S1fIKaHZNPGyTjy+0tDqocW2ItjaZ5gv+o+UfHg3HBgi29TfvKS6Slu21t/3
	Hm0/UbqchQRE35Zf5MVtCKKQS5v2WrA3KkQdzZTjHe8TUVZGMLvu9gnp7CHtp0TJ
	6fpECjWoEtN5Cbko6LbHi7C2pcF0bLdmZCLaKMwDBrRmE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDXT1y983NqIc8aEg--.60829S2;
	Thu, 06 Aug 2026 10:38:54 +0800 (CST)
Message-ID: <6A73F3A9.7020608@126.com>
Date: Thu, 06 Aug 2026 10:38:33 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linkinjeon@kernel.org
CC: Hongling Zeng <zenghongling@kylinos.cn>, hyc.lee@gmail.com, 
 alexandro.calo@nozominetworks.com, ntfs@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ntfs: fix name offset validation in ntfs_non_resident_attr_value_is_valid
References: <20260806013903.8526-1-zenghongling@kylinos.cn>
In-Reply-To: <20260806013903.8526-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgDXT1y983NqIc8aEg--.60829S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF18trWkAF4UWF1DuryDWrg_yoWrZry7pF
	ZrGryfKw4Svr1xXwsF9ws8X3WF9wn5ur4jqF9rtw17CrWjq3W7JFy8Kr9Yqw13ArWDWw17
	ta15Xw43G3y5XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jajg7UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrx6jdGpz874ofwAA3l

Hi:

  Thank you for the review. You're absolutely right on both points:

   1. name_length is u8, not __le16 - my mistake.

   2. Moving the check outside the if (name_length) block is better as
      it covers both named and unnamed attributes.

   However, I have a concern about using ATTR_COMPRESSION_MASK here.

   In ntfs_attr_update_meta() line 3610, the actual conversion check is:

       if (sparse && !(a->flags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)))

   This uses ATTR_IS_COMPRESSED (0x0001), not ATTR_COMPRESSION_MASK (0x00ff).

   If a malicious MFT record sets flags = 0x0002:
   - Your check would skip (0x0002 & 0x00ff is true)
   - But ntfs_attr_update_meta() would still do the forward shift
     (0x0002 & 0x0001 is false)

   Should we use ATTR_IS_COMPRESSED instead to match the actual conversion
   predicate? Or is there another reason for the mask that I'm missing?

   Otherwise, your suggested approach of checking:
       attr_len - mp_offset < sizeof(a->data.non_resident.compressed_size)
   is much cleaner than checking name_end + 8.

在 2026年08月06日 09:39, Hongling Zeng 写道:
> ntfs_attr_update_meta() performs memmove operations on attribute names
> when converting between sparse and non-sparse attributes:
>
> - Converting to sparse shifts the name forward by 8 bytes
>    (name_offset + 8)
> - Converting from sparse shifts the name backward by 8 bytes
>    (name_offset - 8)
>
> However, the validator does not check that name_offset is within safe
> boundaries for these operations. A malicious MFT record could set
> name_offset such that:
>
> 1. The name is positioned at the very end of a non-sparse attribute.
>     Converting to sparse would shift the name forward by 8 bytes,
>     writing beyond the attribute boundary.
>
> 2. The name overlaps with the mapping pairs, causing corruption during
>     conversion.
>
> Add validation to ensure:
> - For named attributes, name_offset is within valid bounds
> - Name does not extend beyond the attribute or overlap with mapping pairs
> - For non-sparse attributes, name_end + 8 fits within attr_len to allow
>    room for the forward shift when becoming sparse
>
> Note: name_offset validation only applies when name_length != 0, as
> unnamed attributes use name_offset = 0 which is valid.
>
> Fixes: 7e2a1c554bc4 ("ntfs: Fix min_len for compressed/sparse attributes in ntfs_non_resident_attr_value_is_valid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
> Changes in v2:
> - Read name_length directly as an 8-bit field instead of using
>    le16_to_cpu().
> - Restrict the name forward-shift bounds check to the same attribute
>    types that can actually be converted by ntfs_attr_update_meta().
> ---
>   fs/ntfs/attrib.c | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index d354c3b0fae1..ffd08633970a 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -693,6 +693,9 @@ static bool ntfs_non_resident_attr_value_is_valid(const struct attr_record *a)
>   	u32 attr_len;
>   	u32 min_len;
>   	u16 mp_offset;
> +	u16 name_offset;
> +	u8 name_len;
> +	u32 name_end;
>   
>   	attr_len = le32_to_cpu(a->length);
>   	min_len = offsetof(struct attr_record, data.non_resident.initialized_size) +
> @@ -706,7 +709,35 @@ static bool ntfs_non_resident_attr_value_is_valid(const struct attr_record *a)
>   		return false;
>   
>   	mp_offset = le16_to_cpu(a->data.non_resident.mapping_pairs_offset);
> -	return mp_offset >= min_len && mp_offset <= attr_len;
> +	if (mp_offset < min_len || mp_offset > attr_len)
> +		return false;
> +
> +	/*
> +	 * Validate name_offset for named attributes.
> +	 * may be zero for unnamed attributes.
> +	 */
> +	name_len = a->name_length;
> +	if (name_len) {
> +		name_offset = le16_to_cpu(a->name_offset);
> +
> +		if (name_offset < min_len || name_offset >= attr_len)
> +			return false;
> +
> +		name_end = name_offset + name_len * sizeof(__le16);
> +		if (name_end > attr_len || name_end > mp_offset)
> +			return false;
> +
> +		/*
> +		 * A normal non-resident attribute moves its name forward when
> +		 * it is converted to a sparse attribute.
> +		 */
> +		if (!(a->flags & (ATTR_IS_SPARSE | ATTR_COMPRESSION_MASK)) &&
> +		     name_end + 8 > attr_len)
> +			return false;
> +	}
> +
> +	return true;
> +
>   }
>   
>   static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,

