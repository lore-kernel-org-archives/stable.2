Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215299;
	b=JKVxaX5mXb7iWpEphqlN1oSdNh12f7RgPbFzgDogv8+AIUgvdYoUC7H2DnEHIRccjRft
	 L+soDJr7TK5cqEIq91hHUmXrBlnAqciZOaya1QAIPuvvEj8Nal7D4dgF8ji6Iy/CJA7HR
	 349pO4dckpqHslxKU5bZl9J4KJ3TUx1RQH83gjY8kVHivyLFqfs+3FYOZ2rPqUFg5KSSg
	 +XLHTqcM/SOTJwlhN0siJSEzSCIgHJAJ1wPsyM9ktXCfXLcEGXEr4qlbMokusSJn40r/z
	 ami8VJLNXnll/sv/fSJz6w8nTh18hoXrB2VC7SAQQ+k01xwVgOeLJ2gx5rY37sZgtmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215299;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=WNYcEhnvU8wcHU8zemgPXvta2itTQnZpRv+qT216orI=;
	b=Y3xTv58d0EL/88fJxAgb/g1b8FixWp/KUQ9iarB+1lHiUpATMHHZP6ztNrYka4AiGQn3
	 QuFAhgD6XlMQWmw/pBvIIiGYEOYMTDsa6pT9RACu/MJkLRGtY1FqItGp8YUi4frjkkyQf
	 OFEA8SnoE/OgxYjZVrwx+ypgoBAFXF0/kxDOoZNTlzI91FEdRGdzKs78q3COgEYfjGI1S
	 6ImhvApYZiFfo4jyBiSnLqUZ+mySRcDL0waifTGpbrnECSGWrDlqEmjyKtCsoABWE3Lag
	 z2ru2+WhzkMw9Qi365xAYuh39ys4ZYXGxF3Bl4YJEVINhvXzjre6zWQ5B92XpfzfA8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.46
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3B606A31C;
	Mon,  9 Nov 2026 09:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4jNP7h5QBLzpV8h;
	Mon,  9 Nov 2026 17:07:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id 7ECA14055C;
	Mon,  9 Nov 2026 17:08:07 +0800 (CST)
Received: from [10.221.98.11] (unknown [10.221.98.11])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0AmB11vjfFqZ2IPAA--.4181S2;
	Mon, 09 Nov 2026 10:08:07 +0100 (CET)
Message-ID: <98d6c26c-3dc4-4659-8284-a7ab0629bb40@huaweicloud.com>
Date: Mon, 9 Nov 2026 10:07:48 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] evm: fix TOCTOU heap OOB in protected xattr reads
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261107230514.1108379-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20261107230514.1108379-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:nRC2B0AmB11vjfFqZ2IPAA--.4181S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy7ZryDZr45KFW7trW5ZFb_yoW5Cr45pF
	90kFW3tr45t34Ikr9rtF13Aa4Fk34DXw1Uu3yxG3W2yan09rs5ZrySgrWjgryxCrnrXwn7
	Aa90qFnYkw1qvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASDWrxOrk8KAACsT

On 11/8/2026 12:05 AM, Jérémy Jean wrote:
> ima_eventinodexattrs_init_common() queries the total size of protected
> xattrs, allocates that amount, and calls evm_read_protected_xattrs()
> again to fill the buffer. This creates a TOCTOU window: if the
> protected xattr changes between the two calls to
> evm_read_protected_xattrs(), names and lengths are written without
> checking whether the data still fits in the target buffer. This can
> yield an OOB heap write that KASAN reports as:
> 
>    BUG: KASAN: slab-out-of-bounds in evm_read_protected_xattrs+0x15e/0x280
>    Write of size 20 at addr ffff888002c59bcd by task init/62
> 
> Reject fields that no longer fit in the target buffer. For xattr
> values, also check the length returned by the copy before accounting it.
> This also handles the case where a size of 0 is treated as a length
> query.
> 
> Fixes: 8314b6732ae4e ("ima: Define new template fields xattrnames, xattrlengths and xattrvalues")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
> Changes since v1 (after review from Sashiko):
> - Handle the 0 case.

Hi Jeremy

I already sent a patch to the mailing list to fix the same problem (it 
is similar to yours):

https://lore.kernel.org/linux-integrity/20261029142707.2602008-1-roberto.sassu@huaweicloud.com/

Thanks

Roberto

> v1: https://lore.kernel.org/all/20261107194909.1061154-2-Jeremy.Jean@oss.cyber.gouv.fr/
> Sashiko: https://sashiko.dev/#/message/20261107194909.1061154-2-Jeremy.Jean%40oss.cyber.gouv.fr
> 
>   security/integrity/evm/evm_main.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index ac8328812e6ef..2ed0b67b9109b 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -389,6 +389,10 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>   		case 'n':
>   			size = strlen(xattr->name) + 1;
>   			if (buffer) {
> +				if (total_size > buffer_size ||
> +				    size > buffer_size - total_size)
> +					return -ERANGE;
> +
>   				if (total_size)
>   					*(buffer + total_size - 1) = '|';
>   
> @@ -398,6 +402,10 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>   		case 'l':
>   			size = sizeof(u32);
>   			if (buffer) {
> +				if (total_size > buffer_size ||
> +				    size > buffer_size - total_size)
> +					return -ERANGE;
> +
>   				if (canonical_fmt)
>   					rc = (__force int)cpu_to_le32(rc);
>   
> @@ -407,12 +415,20 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>   		case 'v':
>   			size = rc;
>   			if (buffer) {
> +				if (total_size > buffer_size ||
> +				    size > buffer_size - total_size)
> +					return -ERANGE;
> +
>   				rc = __vfs_getxattr(dentry,
>   					d_backing_inode(dentry), xattr->name,
>   					buffer + total_size,
>   					buffer_size - total_size);
>   				if (rc < 0)
>   					return rc;
> +				/* A size of 0 may be treated as a query. */
> +				if (rc > buffer_size - total_size)
> +					return -ERANGE;
> +				size = rc;
>   			}
>   			break;
>   		default:

