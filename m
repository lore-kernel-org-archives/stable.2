Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335737;
	b=qJekxm/vLKE7eYHnmKpZXKQBJ9Qioa1EWtF9VXl4TtHTLvKbeaLr12QwHecZfBvjmUE2
	 RZ5/6uJ7Wn35iQfG+Ih66q8cR6OeWjUUT2cV1FLWeUOXExCudnbEn9nYTRuB8XCdpSXWG
	 jI+xusBTuyKyBZOujuLiWPTeGBZ1WpZ9ylShA0907zGTVhtHvfrdLh/SLmkBPo8+mWO8A
	 i2NP4ce1XCpuuGUAbQu4ylI5hZHfgNS+TbXNhHuT1wcjSxrA6A6GZqERzm/iDJ/iMH+Ot
	 aPvhvyQ8yb+eOH/y/Tx4Lrh0zrvqKmFXHhB6JBWSBJqXcHFEW3KHZZGP/N1n4bueEVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335737;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GkJsvagFiiGiCV1yQMzpw04QPTuIxpPgFsylQnGG2BU=;
	b=FnCOYx5qwkn9TmUuKDnPBFvHtgU1P4A1Uw8LuaG4aFhTAHD37yi0ptdwzzBpOmaGvUpv
	 COGqrgqkxI25UPw29uUw+p2GsV6pfzKUGy6BmmNEacNkVvtFpnkqvk0sAXS/oR7/EOhAQ
	 F1NmBIBmTuf70U30++MKWp0AwWcgvKwZzRCEqhYrfNTo2ig+9Vq+2RenSuY8jcIPZewu5
	 KZRt3sgnNX0Ud4hvqyiQUiNK7LD6Xnmi0j5eRJGA5RHm1+jRncpbeW2MNPCYGD+C7/Uos
	 FsliOJp7PuRvrASV/Q0RozIY9GKihXCLvQFUmo0inEyKo5GSmvlUvi9yEMVZWAd05Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=rfaVVqYn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC25606A31A;
	Fri, 30 Oct 2026 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=rfaVVqYn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8341F0093A;
	Fri, 30 Oct 2026 04:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793335736;
	bh=GkJsvagFiiGiCV1yQMzpw04QPTuIxpPgFsylQnGG2BU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=rfaVVqYno2k2gjo0esKiYXrOGDG8DVjWD0VVMtRY9cU2PDjAxz8JP0Mfl5CNmna7B
	 Tu1Ke9vNnez2bKCz2s9bCFBg5X/aZDhmDs2ZVSiDewGqD6sBrc7K7fGx1txfTiVVQK
	 PhO6/PsGxESIzJ9/ARxEX+74teoDnQyQREgl7NIo=
Date: Thu, 29 Oct 2026 21:48:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Keith Busch
 <kbusch@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2] lib/firmware_table: validate subtable bounds
Message-Id: <20261029214855.2e701d85caea73b491a6154d@linux-foundation.org>
In-Reply-To: <20261021150159.399043-1-yaojiale02@163.com>
References: <20261021150159.399043-1-yaojiale02@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 23:01:59 +0800 Jiale Yao <yaojiale02@163.com> wrote:

> The generic firmware table walker dispatches matching entries after only
> checking that a generic subtable header is present. A record whose
> declared length is shorter than its header or extends past the table can
> therefore reach a handler before its bounds have been established.

Then what happens?  Kernel go oops?

When fixing a bug please always describe the userspace-visible runtime
effects of that bug.

How can this situation come about?  A messed up firmware table?

> Once a complete generic header is available, validate the declared record
> range before looking up or invoking a handler. This rejects zero-length
> and truncated records while preserving the existing behavior of ignoring
> trailing table data too short to contain another subtable header.
>
> ...
>
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -172,7 +172,15 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  	    ((unsigned long)table_header + table_size);
>  	subtable_len = acpi_get_subtable_header_length(&entry);
>  
> -	while (((unsigned long)entry.hdr) + subtable_len < table_end) {
> +	while ((unsigned long)entry.hdr + subtable_len <= table_end) {
> +		entry_len = acpi_get_entry_length(&entry);
> +		if (entry_len < subtable_len ||
> +		    entry_len > table_end - (unsigned long)entry.hdr) {
> +			pr_err("[%4.4s:0x%02lx] Invalid length %lu\n", id,
> +			       acpi_get_entry_type(&entry), entry_len);
> +			return -EINVAL;
> +		}
> +
>  		for (i = 0; i < proc_num; i++) {
>  			if (acpi_get_entry_type(&entry) != proc[i].id)
>  				continue;
> @@ -186,16 +194,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  			break;
>  		}
>  
> -		/*
> -		 * If entry->length is 0, break from this loop to avoid
> -		 * infinite loop.
> -		 */
> -		entry_len = acpi_get_entry_length(&entry);
> -		if (entry_len == 0) {
> -			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
> -			return -EINVAL;
> -		}
> -
>  		entry.hdr = (union acpi_subtable_headers *)
>  		    ((unsigned long)entry.hdr + entry_len);
>  	}
> -- 
> 2.34.1
