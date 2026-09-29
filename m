Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9C2E7397;
	Tue, 29 Sep 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713944; cv=none; b=lwAgA8ZUxfrpQO/lkFRNM/62Xx9sioDYIitv8dhKo2oFFGnu36iqgpLdGBtE33O99vQ28XCENOKBVEwG/KwLI7Kevx+rEDStCsGYCut41CVooeOKG5Xm+EUEImGlK/5COSfsS/DxSK8iWXIyjjdIWQ7Dwt/8rkNIzbWnwYk1crA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713944; c=relaxed/simple;
	bh=SyRbOsqp7ra3/hOFVINyjtCpID/Psn2PVKspaO8Y23E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DusxXkPJcnnW2B0uN2XdxT6BQwr1mLYLx5A1N9GFwQWN12pfuwJRCdYjorAUaaUtFiqLdYUfiNBl8kLUXumC7o9kRU7Fmw7jxhDFfUo19sy8Nz8df78wVknWRyLwr2KebhDzXCOrht5FBkjNaJwBdsSb/gVRDkNyIQzs6IEVSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=yWMFwYSs; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="yWMFwYSs"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hvVGP72jzzKp1b;
	Tue, 29 Sep 2026 22:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=MBO0001;
	t=1790713934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aMO1TFFilty1lMotj3PlOLCIGv6KB3kYrfoPUAD1Z/c=;
	b=yWMFwYSsvctbfxkt7eVRBy+y+3biYN91XB5dSY0SloUoKQlZO8CDVN9xzIlQj6p2L3Dl/z
	bBc4kwbeJ7ae2K32oenVkhiBhdVpZIMqK0pkfPzo7+tOcXVvPAPXZ2ohk4pgQ0ln3344qL
	OEA0eXMPu33AEt/EoiP0d+XoVZNsXfNpQLqn2wM8ZrPN4+TfX4tWMrmjfHsrUD/I29eoeW
	DsgvEmUm93vJoij0jfVSpUPN5efHlV4+9RszhD1Tx2YSu81CMQqe6/N5VgF4RD+6/qjcH7
	35/MTHeaStrsEYMSZ+W19ydqgGH0u87DLIhN5QP8cHTt+LEeZhM+BBgOtMYa8Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of gabriel@krisman.be designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=gabriel@krisman.be
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>, hughd@google.com,
 baolin.wang@linux.alibaba.com, akpm@linux-foundation.org
Cc: brauner@kernel.org, andrealmeid@igalia.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] shmem: fix unicode_map leak with repeated casefold= option
In-Reply-To: <3a57ec70731165b4b1244fa89bba95c82a666df8.1790712330.git.med08elkadiri@gmail.com>
References: <3a57ec70731165b4b1244fa89bba95c82a666df8.1790712330.git.med08elkadiri@gmail.com>
Date: Tue, 29 Sep 2026 16:32:08 -0400
Message-ID: <878q4jyf1z.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4hvVGP72jzzKp1b

Mohammed EL Kadiri <med08elkadiri@gmail.com> writes:

> Each casefold= option makes shmem_parse_opt_casefold() allocate a
> unicode_map with utf8_load() and store it in ctx->encoding.  When the
> option is given more than once in the same mount, the later call
> overwrites ctx->encoding and the earlier map is never freed.
>
> Reproducer:
>
>   mount -t tmpfs -o casefold,casefold tmpfs /t; umount /t
>
> Repeating this 50000 times grows kmalloc-32 by about 50000 objects,
> and kmemleak reports them as allocated from:
>
>   utf8_load+0x21/0x110
>   shmem_parse_opt_casefold.isra.0+0x65/0x100
>   shmem_parse_one+0x368/0x510
>
> Free the old map before storing the new one, so only the last
> casefold= is kept.  On a normal mount with a single casefold=,
> ctx->encoding is still NULL at that point and utf8_unload(NULL)
> does nothing, so nothing changes there.
>
> With this patch the same loop leaves kmalloc-32 flat and kmemleak
> reports nothing.
>
> Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
> This is a separate leak from the remount one fixed in
> https://lore.kernel.org/all/ba38f80f629fd093c77f3a49fdab7b71ee7bbc5f.1790687276.git.med08elkadiri@gmail.com/
> which Gabriel has reviewed; I found it while testing that patch.
> The two apply in either order.  Tested on mm-unstable, alone and
> together: kmalloc-32 stays flat for duplicate casefold=, single
> casefold= and remount, and kmemleak is clean.
>
>  mm/shmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 07b2855dfb7b..262f1bcb6144 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4731,6 +4731,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
>  	pr_info("tmpfs: Using encoding : utf8-%u.%u.%u\n",
>  		unicode_major(version), unicode_minor(version), unicode_rev(version));
>  
> +	utf8_unload(ctx->encoding);
>  	ctx->encoding = encoding;

IMO, nack, this is not the right fix.  There is no point in accepting
multiple casefold parameters and we shouldn't allow it.  If
ctx->encoding is already set, we should -EINVAL and fail the mount.


>  
>  	return 0;
>
> base-commit: 90ddfbd1963659ca4a5d3d7f20717a4222682a8e
> -- 
> 2.53.0
>

-- 
Gabriel Krisman Bertazi
