Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048909;
	b=m+SEvswsvhI6VhhMYreBLLlr5fU7MZ7eEtt5at0pgK0e9f2WDyKMx1S1gArrnCvu7F9B
	 I9l6d8Mg5Sgmo8KJAoaNDmPb40+h5DajpMk+PHRPUkRngAVOI6YAk7c+UDnWWHrZNvm3c
	 pJhituZGxW0PyoFHv6D5zxQGtnlYYRaNDkDzJiE54YJgkSMKrK6LoSbMvsRHJrAP4j2C7
	 YBcG4WfagXpX8KPdBpmkyEdGTTbk5tIXte2K7SrDkmkfr5g05pqvkuENOGjhtLsajy23H
	 Bi41eMDO1ByoODnM3BvBkOVCsXXmc2EFZfnl55BlpdBkvitAuSL7I2O4mBn05daYKgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048909;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=aZY6emueEsceME7nXNq6gUfKhqrQcT2cFezDIABkUGw=;
	b=xODoqTUr3/OUb5DaLnAJnSao6m2Zb+T3LoH0kUXvvOJipi6O+MCJa22Hsp1+A3tO3LlB
	 qO8IQ+pjqM94IyVyziMPHTnPQM3KRBkbZNeVh6Wq2OP13fygrLaKqervJXxPwWIwdriaZ
	 6Fzus9Wbstfm5xf3V984UOfXKp1zK0ClT2BP0FbGGG9cDgkeQ3eYUKSz8Se2riljuvrCa
	 ZMYaLboIqL9j+u/jBbXB1waOEoUZbCpEjG7hHWGQXtzBTVnN9GIbcajNSyBHdAkkge07R
	 0fdJ+7gYi52qVwp6GIsagW2Cc9uhpK0eh1/25XkGmGFgwUFaSVy54WIUct/hbR9EbBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hwhsj8kN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D763606A31E;
	Mon, 26 Oct 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hwhsj8kN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4DF1F01828;
	Mon, 26 Oct 2026 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793048908;
	bh=aZY6emueEsceME7nXNq6gUfKhqrQcT2cFezDIABkUGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Hwhsj8kNM/003xoVUCIY6kkGhTMwCG7vilt/Dph6Rs2EcwYc9BgMFYtM3gSdCLUv4
	 I+tMEzKtq5KAbamFFvZx7+ti1rXjRJsMZjvz0qerVCMxXjC93hhuyyMUiLAmtzc1/W
	 LR4Z/+Pq0jLyAo39zmyDSxqVjNIeiDuZTxpYCVfdxa8mhWwNuCyhOz1ppbvUAknygE
	 3GYifpJYvEc3MVOEyQZ5/oL5Xo0WCWkoroRzPUaoRpTDIFj7D2vLbekCufU0BWV8ka
	 oeA1q6H6o0L+DLOpROZC2NULQUuPdxHZ3YYT75nxwHQAPF+Dr37k+z7MxY7tkjCqzh
	 wc8fUODq2yO1Q==
Message-ID: <5d441cff-ef78-4bdf-b727-9eb697ca7478@kernel.org>
Date: Mon, 26 Oct 2026 22:08:16 +0100
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
Subject: Re: [PATCH] hugetlbfs: enforce F_SEAL_EXEC on chmod
To: Samiullah Khawaja <skhawaja@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>
Cc: Jeff Xu <jeffxu@google.com>, Daniel Verkamp <dverkamp@chromium.org>,
 David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261026205555.2918396-1-skhawaja@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261026205555.2918396-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/26 21:55, Samiullah Khawaja wrote:
> F_SEAL_EXEC prevents the exec bits of a memfd from being changed once
> the seal has been set. F_SEAL_EXEC is included in F_ALL_SEALS, so
> userspace can set it with F_ADD_SEALS on hugetlbfs memfds just like on
> shmem memfds, and F_GET_SEALS then reports it as set. However, the check
> that rejects the mode change was only added to shmem_setattr().
> hugetlbfs_setattr() never looks at the seal, so the owner of a sealed
> hugetlbfs memfd can still make it executable with chmod(). For the same
> reason, MFD_NOEXEC_SEAL provides no guarantee when it is combined with
> MFD_HUGETLB.
> 
> The memfd selftest already covers this, but only the shmem run passes.
> When run as "memfd_test hugetlbfs", the test aborts in SEAL-EXEC because
> fchmod() succeeds on a sealed file, and none of the remaining tests are
> executed.
> 
> Add the same check to hugetlbfs_setattr() that shmem_setattr() has, so
> that a mode change touching the exec bits fails with -EPERM while
> F_SEAL_EXEC is set.
> 
> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  fs/hugetlbfs/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 01c4d6f44ebe..56e0588d295d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -842,6 +842,10 @@ static int hugetlbfs_setattr(const struct mnt_idmap *idmap,
>  
>  	trace_hugetlbfs_setattr(inode, dentry, attr);
>  
> +	if ((info->seals & F_SEAL_EXEC) && (ia_valid & ATTR_MODE) &&
> +	    ((inode->i_mode ^ attr->ia_mode) & 0111))
> +		return -EPERM;
> +
>  	if (ia_valid & ATTR_SIZE) {
>  		loff_t oldsize = inode->i_size;
>  		loff_t newsize = attr->ia_size;
> 
> base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651

https://lore.kernel.org/r/20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org

-- 
Cheers,

David
