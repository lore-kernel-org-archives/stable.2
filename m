Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680621;
	b=cbNPGpsIPNcZbagHEz4MVA9rz7Vy8IneQtzVBMnZhTERE+5eZGfdZsBpEN9FZkXKjs2h
	 sS5mdFsXWV3vpIj1TdRE2uSM8b7pPL5e1oVq/J72vis+qsldrOEX64Yuh06ZMBS+XYowp
	 ksABOtoEw83nhHrjvnLX2UzcpCY4bIa3EfDZiuzeb4dAJkOPHaipMyrbkBUZjhOnn9kVJ
	 hmCM0wxZJt0FY1RBezXWz9RCMYHObXhAQfbWzIL2XDHANmkzhMBmdnHbKV0DsUYXd2Iis
	 T+7y+Sgd40tWT6k4Wi6yz9CWIH5B+x0rPeIsyG9aeyUwqQE+v8R83XkycWy/wgDTdyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/pEzeyppoE46W1mZEvMY+WnIf+I5XRxOy5A4cmAgaOI=;
	b=ysSXd7VqUP1ER4TNSR8xCPnXXyd/l5VWtri99IUNwFVKOnGL2C+T6CWq+U9F85v6ou9G
	 JZk17kmvUXo33Lh8QvnsqcYOqJw6M9GdhfQnnI+AsPyhqnSduo5Ar6G5Qi+rdyn6wKwva
	 674KLkJu+cixIUwR1WWm02rpD/kSGoUC9pdW9D/dYNFuxTxZXtTHZzzFC4QPmN6AFNzqJ
	 OUFmywuc1wwyzmLmOQAdBBBRx6FHGuIKSKsXbHD8+YzbrxG6pbjizDoszYaVoFLIyca4Y
	 DWHY0CkfG2NQ0YcmNcexjkzz+59yYDKRAkj47P5lpkyP4m2X4WiQg1vtT4+EywE3WNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Xy1IQxTl;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48859606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 04:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48859606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Xy1IQxTl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso24310445e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 20:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793680619; x=1794285419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/pEzeyppoE46W1mZEvMY+WnIf+I5XRxOy5A4cmAgaOI=;
        b=Xy1IQxTl6ZVTrl3Vui9Z5bCFjO9qFMooyElAgm9BfRbdTDTdcxtdLdAQG834/dw2dZ
         Vc/Z3NtC8rNxLHXAFy7tqJkaEqeiQx0AbKpsStajWYZJg/0R1VcFlIoWcgQgH80LGB8b
         xi5k2PPo5Av0AyMwLad3HQgtGaIWslFnZg+V3ygcpybGO0Hye35nJvoVQdXGIfcVxSCy
         9n5FBeYuUEexs0SjxxDLOfKbqG856sdTPUyYMvMHBepNzRfs3XUVy86UMrdFBKL8F7uU
         ZubUxm5AF55Wws16Bk0F4S8CS9wc6PtmEeIW9jC4IZZGi+tr1LeNYDL214Q845xmb7oc
         Nxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680619; x=1794285419;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pEzeyppoE46W1mZEvMY+WnIf+I5XRxOy5A4cmAgaOI=;
        b=SKowrYsL2pxAYPDlfH1hNTy9VkhmHWndYY+0wH6OVajEZpwz8V1l/iTbzi8yL4ms4x
         nDDv9D3Pu7uPMFEt2hreW/rx/c7ryE/nxXg/qC/tOwIMRsNozjl4Ko47A+Xs29X0g5fI
         tAkhx97z0tbc+xn+SGJs3BSdy75BtfGMTkw8+WSsbmi0gsuwKqVlSQiewnSWo946+Y/D
         TFqp2qbUPFXJQcBqDs8tsPxxKp5xYR2E28h6DqZLegbzCp/B9DRp2ReDamqNHBHdRb/z
         jxK3iamKVn0MLgJ6GSUqtz0Js/tC0TuI1/ZgRRmvEm0i0cZKvFey8BhsUn4HT79Jpix7
         TSsw==
X-Forwarded-Encrypted: i=1; AKwUvBzvNhH+ntGg3UNgF9kmr2ckDp0nuPlbqM09qJsk8wgjMPF0txzpe62JcJkcJRQ/xr8I2BvvVj8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqtcPdvTUwLzwkvjirpv65/4IIwwIt7duhOB0sSZSB3aGMm4/7
	IM7u4VOLCohUetIyI9XtlvUSH2fJ2O40U6ruETwESw6Bl1xm6U3QDUttXYBIMvJlOIE=
X-Gm-Gg: AYBFou2+QStXluBb/yPP8+GxmrZdwa86E+ZkRcERPJypMPa8snrVmPPhCzBXmV7GeOE
	DZhYaSJBg4ahqb0fRmYAoOX76MGeBnIeSxh9j8RH+X4p8b5fyYOaHsrrD5HYU3Vfk4Q9MjaxQpa
	3MAP8p8cxMTgD5RSZwhPLRnyFbN1df7HJzVO1kNw8bAiwaeLTSC54DFnDIKCEh6lVKY3GwY50Cc
	UxCnPElWXFjj1jUWKvxRulQ01G9lMdgIkh8xHcD9f6EJhW4/OhImr00StMG8+FSs5043pVTsQHt
	9ohYL5bFER5SgWOW6K5OdlY2SzUuO22c4s1+3QJ4yp7TILRteA/Q7CQYl+G33NSI+dLmbuc13xu
	9gajEbrXCob2azKn59YuI/tRj4hve5F7ixalCkc9oENnzeJ+l45lisyuR7B3jK6KAadNDwaQqOp
	Pt3XsaSUjvWJd00murtxqlSZx9kegxinJrGe1M+uBKQgAuPq8XdxZWKGAqmtsDYPb5GWcasTp9I
	9ZGzh/fUSbLlLdjigPe2I/HADGdvDeHaRNihCNhDpxE6gNH6AA1fYuq/xFRpkJVOx7rqa//BSPe
	0S9cUVpM6MyAca5JDUqbyxO7whmfK1ZRr4Ww//9iOg==
X-Received: by 2002:a05:600c:4e14:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4ac187a80bfmr275505455e9.30.1793680618644;
        Mon, 02 Nov 2026 20:36:58 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36b13bd87b2sm2675989eec.28.2026.11.02.20.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 20:36:57 -0800 (PST)
Message-ID: <0e59bdd6-1d30-4337-8933-59c9d2082b6b@suse.com>
Date: Tue, 3 Nov 2026 15:06:50 +1030
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
Subject: Re: [PATCH 1/2] btrfs: tree-checker: validate qgroup status item
To: Siddharth Mishra <smish149@asu.edu>, David Sterba <dsterba@suse.com>
Cc: Boris Burkov <boris@bur.io>, Chris Mason <mason@kernel.org>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261103034932.1790235-1-smish149@asu.edu>
 <20261103034932.1790235-2-smish149@asu.edu>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <20261103034932.1790235-2-smish149@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/3 14:19, Siddharth Mishra 写道:
> [BUG]
> An image can have a status item with SIMPLE_MODE and a super block
> without the SIMPLE_QUOTA bit.  On a kernel with CONFIG_BTRFS_ASSERT=y,
> the mount of this image causes a BUG :
> 
>    assertion failed: btrfs_fs_incompat(fs_info, SIMPLE_QUOTA),
>    in fs/btrfs/qgroup.c:411
>    kernel BUG at fs/btrfs/qgroup.c:411!
>    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>    RIP: 0010:btrfs_read_qgroup_config.cold (fs/btrfs/qgroup.c:411)
>    Call Trace:
>     open_ctree (fs/btrfs/disk-io.c:3789)
>     btrfs_get_tree.cold (fs/btrfs/super.c:2133)
>     vfs_get_tree (fs/super.c:1943)
>     fc_mount (fs/namespace.c:1282)
>     path_mount (fs/namespace.c:4337)
>     __x64_sys_mount (fs/namespace.c:4542)
> 
> Without CONFIG_BTRFS_ASSERT, the mount is successful in simple quota
> mode.  The first data write then adds an owner ref.  The write-time
> tree-checker sees the owner ref without the SIMPLE_QUOTA bit and gives
> a WARN_ON() (tree-checker.c:1782).
> 
> [CAUSE]
> The tree-checker does not examine the status item.
> btrfs_read_qgroup_config() reads the flags of the status item.  For
> SIMPLE_MODE, it calls qgroup_read_enable_gen().  This function ASSERT()s
> that the SIMPLE_QUOTA bit is set and that the item contains enable_gen.
> Since commit f2363e6fcc79, the kernel does not write SIMPLE_MODE without
> the SIMPLE_QUOTA bit.  Thus only a damaged or crafted image has this
> state.

The easiest way to show the cause is to provide a tree dump of the 
offending leaf, and highlight the offending tree blocks.

> 
> [FIX]
> Add a tree-checker rule for the status item :
> - The item must contain the four members of all versions : version,
>    generation, flags and rescan.
> - With SIMPLE_MODE, the super block must have the SIMPLE_QUOTA bit, and
>    the item must also contain enable_gen.
> If a rule fails, the tree-checker rejects the leaf with -EUCLEAN.  Then
> btrfs_read_roots() cannot read the quota root.  It ignores the error, as
> before, and btrfs mounts the filesystem without quotas.
> 
> Fuzzing found this bug. An AI tool helped to analyse the cause and to
> write the fix. I tested on btrfs for-next (d6f76ca0a70d), with and
> without KASAN and CONFIG_BTRFS_ASSERT=y. Without the patch, the kernel
> gives the BUG above, or the WARN_ON() at the first write. With the
> patch, the tree-checker rejects the leaf ("qgroup status item has
> SIMPLE_MODE but SIMPLE_QUOTA incompat bit unset"). The mount is
> successful without quotas. There is no BUG and no WARN_ON(). A clean
> simple quota filesystem still mounts, writes data, frees extents and
> mounts again. Its status item passes the check at each commit. The
> fstests group qgroup has no new failure (34 passed, 3 not run here). A
> crafted image and a C reproducer are available on request.

Drop the whole paragraph starting with "Fuzzing found".

It makes no sense. And tell your agent to write this rule into its 
memory file.

This looks very chatgpt, and so far I have no good experience with 
patches generated by that.

> 
> Fixes: 182940f4f4db ("btrfs: qgroup: add new quota mode for simple quotas")

I don't think this should count as a fix.

> Cc: stable@vger.kernel.org # 6.7+
> Signed-off-by: Siddharth Mishra <smish149@asu.edu>
> ---
>   fs/btrfs/tree-checker.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 61ea8f42c..0d75cb537 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -2083,6 +2083,38 @@ static int check_raid_stripe_extent(const struct extent_buffer *leaf,
>   	return 0;
>   }
>   
> +static int check_qgroup_status_item(const struct extent_buffer *leaf, int slot)
> +{
> +	const u32 item_size = btrfs_item_size(leaf, slot);
> +	const u32 min_size = offsetof(struct btrfs_qgroup_status_item, enable_gen);
> +	struct btrfs_qgroup_status_item *ptr;
> +
> +	/* version, generation, flags and rescan are always present. */

I don't think the comment adds much value.

Tell your agent to keep comments at minimal.

> +	if (unlikely(item_size < min_size)) {
> +		generic_err(leaf, slot,
> +		"invalid qgroup status item size, have %u expect at least %u",
> +			    item_size, min_size);
> +		return -EUCLEAN;
> +	}
> +	ptr = btrfs_item_ptr(leaf, slot, struct btrfs_qgroup_status_item);
> +	if (!(btrfs_qgroup_status_flags(leaf, ptr) & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE))
> +		return 0;
> +
> +	/* Simple quotas need the incompat bit and the enable_gen member. */
> +	if (unlikely(!btrfs_fs_incompat(leaf->fs_info, SIMPLE_QUOTA))) {
> +		generic_err(leaf, slot,
> +	"qgroup status item has SIMPLE_MODE but SIMPLE_QUOTA incompat bit unset");
> +		return -EUCLEAN;
> +	}
> +	if (unlikely(item_size < sizeof(*ptr))) {
> +		generic_err(leaf, slot,
> +	"invalid qgroup status item size for simple quota, have %u expect at least %zu",
> +			    item_size, sizeof(*ptr));
> +		return -EUCLEAN;
> +	}
> +	return 0;
> +}
> +
>   static int check_remap_key(const struct extent_buffer *leaf,
>   			   const struct btrfs_key *key, int slot)
>   {
> @@ -2475,6 +2507,9 @@ static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
>   	case BTRFS_FREE_SPACE_BITMAP_KEY:
>   		ret = check_free_space_bitmap(leaf, key, slot, prev_key);
>   		break;
> +	case BTRFS_QGROUP_STATUS_KEY:
> +		ret = check_qgroup_status_item(leaf, slot);
> +		break;
>   	case BTRFS_IDENTITY_REMAP_KEY:
>   	case BTRFS_REMAP_KEY:
>   	case BTRFS_REMAP_BACKREF_KEY:

