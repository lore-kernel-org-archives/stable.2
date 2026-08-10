Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFD3590A9
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404229; cv=none; b=cwPvsxkZWNf7MPaU4zgW8Fk+HbCDmjACmzraD43Lv0P7jg6QdnzX0El2KNnCZnDuZb+GQDDQNnHemO2IXLIeWGAeXTLAs4IHuN9VzQgQSK2ea1i69SqntNwjwWrNOdzfnGMuhqGnJIAn2SRJFAQCx6uk974sH1eDqwI4avL1vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404229; c=relaxed/simple;
	bh=qumYJBErYHBnlknTR2S5jtbwLJj7iWgwgq6ztFcjW+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAyalVqQL/HM+t2uZw1p5SakTvSzU2PEA4iLXoRPi+OKVntNbf3G7IsYDLA6cIZlRp4tymmWdsecuTjLxg7/tYzJy47XV/7vgerICohwLF5WApJq8dX0F+rbzojZxWH5/0rb6d2Mw3mJ2UKpl4fLW4wGLl/ODhYJMXtGWx9lOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIRCNMkC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbHDCQpq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIRCNMkC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbHDCQpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786404226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvXcdVrrcYWC7Qoe02Nyc3BrgNoZ7f3QNoGWtGrCDEM=;
	b=CIRCNMkCwA0JvpG54/6m8BvCYR2I8A8Gk0oQVhOFBwqtrLvrKsfVgXeZuYhYnShmIu7Kzv
	ZTjZic/avr7U7EPFaDmU3kaXLO2NysGFJMKw6+pnmIqGd2ubJHUL1M6amcaXJgEETp8Mvx
	EBJeIZp/zruUjbbdAkAGerSuWGErxLs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-an5g9HEeP2-_LS8KbgWw6g-1; Mon, 10 Aug 2026 19:23:40 -0400
X-MC-Unique: an5g9HEeP2-_LS8KbgWw6g-1
X-Mimecast-MFC-AGG-ID: an5g9HEeP2-_LS8KbgWw6g_1786404219
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a196857c7aso2649328eaf.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786404219; x=1787009019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvXcdVrrcYWC7Qoe02Nyc3BrgNoZ7f3QNoGWtGrCDEM=;
        b=IbHDCQpq9jfPxrftBbR7J7q38VTX2dRKz+Jf3WN2ywEIibD5JRSJAdn0Kw52xVePmv
         abzI/IyeSy35jsg3Uw3H8lLSg4E4IAS+FrmHD2b7+H3KJq11PYGLOlpIpPvvxXCTUdVW
         38a3maryGaDwT1lvgUgqZ2uApqZrQblM4rTgrXIL8jNrr1O9o+n14/RjAxoOFxbpnOJG
         xcsIg6dUlImMoxj+lqCSw5HceukptHDb1e9xzOcB6n2cRa0N/Gl2nl2NEW4eLKDtc/3A
         KILgFuShFZrdxXezVeXz2wl2KeY7YmWSKnKt7FREHcJ0mY1ilL10NgozqxlzvR17A6Zo
         4bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786404219; x=1787009019;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvXcdVrrcYWC7Qoe02Nyc3BrgNoZ7f3QNoGWtGrCDEM=;
        b=kuRb2PCj4aqK7UqgeXLyLlbOIfMEh1dlx/VFLmDf5eKTpdqKXrH31ScdoPFMMjGLl5
         zqclLmhzyf+/+SpTbeJsDsm/14P4VlKpQ+Aa4d+aHJ02X+in2hTpwdlZ/WHxvlv2zDVy
         aWkL56RSG4AZTZ3bIwqKgwWh61nIktS2lUxcyl6JMDcTnDMsTRVvLKwHBrtxbGauSdT7
         NcEPkhpYW9BEKikh2lVhjtsGA+TYstwa8MUTJ2f3pDW2jgwA7cHrlIOhxNl7uvIV0wop
         CnEOt6D2uamwPaNjMnR9c2coTm/PnUYnNYhFniSQvsMtZaJub8uEtfRuvDl1QcijDDt/
         csJw==
X-Gm-Message-State: AOJu0YxXmWYZHWm5ZxEnvDhnd27pgjAVvrUhJT/qPxfV5Z38YlY6kfn2
	SwFM3BW0rws5N/AX24g7CMBJGoEzF/07jTMO+DWp2K97ksZjRJ3LHF6PDZ247sHo+qE1CIiOJJN
	RRQ+IMnT6JDV2pwne8qVxtMUdF1pv4QM3bccQ8oZuRuTVnQl/tmt6YAmyGg==
X-Gm-Gg: AR+sD12SoMUgJvDtFwYIe0tMdlDVyLPyKBN+C9O8YVaUHEJVdt2GvoaQOyo9oU+4bJU
	G0R8GA9xKP5Nrrm4lR5pVYfcKs17uo0f+PCILHgaJzSYyBV4cx5K9cVZ1G/ygFgF8JlvBN0waz5
	bdQJHIouqpO+1yAAQeyY0UaefjlZa6uVHIWInSvyht3wYs0wP2yQ3Ql1nDBWEfXHJv+FVgh5oMW
	ZxF5gX21zEp2XZuxjOH/oUoW6XgnpZX0Hi30KWf794KoDKXNwQthbrUt5ciKPuSKWToOPP0TJZR
	TUKpQ7Y7Dd5t7mnRuM/7LAVwAf4I/E/Ol5ezWmQzpqHwlpH+auow3H2m7uDXaQvbr6+jsgQedWS
	fnRCNqnlwIeEbSi9iUTSgN3X/FiFt1mkci4bdGUyv
X-Received: by 2002:a05:6820:168f:b0:6ae:9b39:68d1 with SMTP id 006d021491bc7-6b0420d5753mr12437003eaf.23.1786404219432;
        Mon, 10 Aug 2026 16:23:39 -0700 (PDT)
X-Received: by 2002:a05:6820:168f:b0:6ae:9b39:68d1 with SMTP id 006d021491bc7-6b0420d5753mr12436982eaf.23.1786404219028;
        Mon, 10 Aug 2026 16:23:39 -0700 (PDT)
Received: from [10.0.0.187] (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f19fd31csm9718793fac.1.2026.08.10.16.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 16:23:38 -0700 (PDT)
Message-ID: <8fba77ff-8b67-45fa-969e-4009cfe59928@redhat.com>
Date: Mon, 10 Aug 2026 18:23:36 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devtmpfs: restore mount option reconfiguration on
 get_tree
To: Simon Liebold <simonlie@amazon.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org
References: <20260810083438.764684-1-simonlie@amazon.de>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20260810083438.764684-1-simonlie@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 3:34 AM, Simon Liebold wrote:
> Commit cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in
> public instance") converted devtmpfs to the new mount API but dropped
> the reconfigure_single() call that reapplied mount options.
> 
> This causes userspace-requested mount options to be silently ignored.

hohum, I'm not sure how I managed to re-break that - I had cc'd neilb
precisely because I knew he had fixed a regression here before, so
it must have been on my mind.

Looking back to an IRC conversation with viro I think I diverged from
his recommendation though I'm not sure why.

I had credited viro in my changelog, but looking back I don't think I
faithfully implemented what he had suggested. I'd like to revisit that
and maybe propose a different solution to fixing this.

(One concern is approach is that I think it is now passing an fc which
was not "for_reconfigure" to reconfigure, for starters, but that's on
me I think for setting it up this way ...)

Give me a day or so to try to page all this back in again? And sorry
for breaking it. :(

Thanks,
-Eric

> To reproduce, boot a system where systemd mounts /dev with a size
> option (e.g. size=4m), then check the actual size:
> 
>     findmnt -n -o SIZE --bytes /dev
> 
> On an affected kernel this returns ~50% of RAM instead of the
> requested size.
> 
> Fix by calling fc->ops->reconfigure() after obtaining the superblock
> reference in devtmpfs_get_tree().
> 
> Fixes: cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in public instance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Simon Liebold <simonlie@amazon.de>
> ---
>  drivers/base/devtmpfs.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index b1c4ceb65026e..44683dde04377 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -72,14 +72,25 @@ static struct file_system_type internal_fs_type = {
>  	.kill_sb = kill_anon_super,
>  };
>  
> -/* Simply take a ref on the existing mount */
> +/* Take a ref on the existing mount and reconfigure to apply mount options. */
>  static int devtmpfs_get_tree(struct fs_context *fc)
>  {
>  	struct super_block *sb = mnt->mnt_sb;
> +	int err;
>  
>  	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
>  	fc->root = dget(sb->s_root);
> +
> +	if (fc->ops->reconfigure) {
> +		err = fc->ops->reconfigure(fc);
> +		if (err) {
> +			dput(fc->root);
> +			fc->root = NULL;
> +			deactivate_locked_super(sb);
> +			return err;
> +		}
> +	}
>  	return 0;
>  }
>  
> 
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff

