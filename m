Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735B3A3816;
	Tue, 29 Sep 2026 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716190; cv=none; b=dCWaz09Y8AIne29ttnnXwHGUZZdUB+HDNmC0IKERf6g1a5VjuQt23xBkL4hMinvuwrA3BrrYxPQxeAZOjY9ZjQJ60Tji+ehKDvNernKx2B2BfymtHI5MzLYaxupegkIFoyQtoy+Kjjlw2Etsv5oNjxZgjpZt7SofPAAMEWKK45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716190; c=relaxed/simple;
	bh=XxN5huqpoJJint406QINQeJZYnsGPKorEDTaK51k60U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWPEvS+/T3nO+btWXyK4sNlh1MWPD83IaGUWrJ1SWfU6g37r1nBog2O7quM9XKKOTK/de8Q57erMB/hPtnPYtlkwxdlJ0g4qQTj3TjD4oR2/lmSJ0KiHZ8FG1OvrcUF75GK6Yb/pl0Ca0X0sTQfbQCSDXDsubY0bGx8qIv/Hv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=VOcC2k3+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="VOcC2k3+"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hvW5Z603DzKp6M;
	Tue, 29 Sep 2026 23:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=MBO0001;
	t=1790716178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oiLYfNLi9fHUv/AIARCPOZejdDUsvSdtLFBSFLvIThk=;
	b=VOcC2k3+l9mwIjlQmluaLAMj3QcSsEaHRsJCDEDf/X6QqEOr/Cup/qfRLOpiG6HEFPsfD4
	mOfdToOqRiPUn6IpXLxZAMZRMgBmmxGqdRKKUAakHzrGjAZS5yiULaMBvtMyLE+Ycd/XG9
	OplZoxE+fXU+4+z6M29312v0ZyO4pxqH2eY/hOnP4bqC4Kyhqhjd/ellBnlI+WTAhOx8CO
	iHhpkSQlDGlVHlvdJCwPORM4W2VUoItohk+YX+wgHixx4oUgYo85m3XhdBb/E2PIkkApgI
	VamztEsMrppgs+aR6E7mdQDLiZ9Jz5ziSvtX69zdcClghz/lWFdkb578D0puSg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of gabriel@krisman.be designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=gabriel@krisman.be
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Kazuki Hanai <hnkz.64@gmail.com>, hughd@google.com
Cc: baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kazuki Hanai <hnkz.64@gmail.com>
Subject: Re: [PATCH v2] tmpfs: fix unicode_map leaks in casefold option
 handling
In-Reply-To: <20260827152516.805622-1-hnkz.64@gmail.com>
References: <20260827151426.796843-1-hnkz.64@gmail.com>
 <20260827152516.805622-1-hnkz.64@gmail.com>
Date: Tue, 29 Sep 2026 17:09:34 -0400
Message-ID: <874if7ydbl.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4hvW5Z603DzKp6M

Kazuki Hanai <hnkz.64@gmail.com> writes:

> shmem_parse_opt_casefold() stores the unicode_map returned by
> utf8_load() in ctx->encoding. The casefold parameter can be supplied
> more than once for the same filesystem context, but replacing the
> stored map does not release the previous reference.
>
> The final reference is also leaked when an unmounted filesystem
> context is freed.
>
> Release the previous map before replacing it, clear ctx->encoding
> after transferring ownership to the superblock, and release any
> remaining reference from shmem_free_fc().
>
> An unprivileged user can repeatedly set the casefold parameter on a
> tmpfs filesystem context from a user namespace. This causes
> unbounded kernel memory consumption and can result in a local denial
> of service.
>
> Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
> ---
> Changes in v2:
> - Keep Fixes, Cc, and Signed-off-by in a single trailer block.
>
>  mm/shmem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 89a1495e55f7..62440caf2df5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4508,6 +4508,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
>  	pr_info("tmpfs: Using encoding : utf8-%u.%u.%u\n",
>  		unicode_major(version), unicode_minor(version), unicode_rev(version));
>  
> +	utf8_unload(ctx->encoding);
>  	ctx->encoding = encoding;

This patch fixes two bugs at once, as shown by the other patchset that
does it separately. One is the leak during 'mount -o remount', fixed by
the second hunk, which is fine.  The other is when multiple casefold=
parameters are passed at once.  I think that fix is wrong.

I can't think of a real case where it makes sense to pass multiple
casefold parameters, besides user error.  even if you are trying to
outsmart the kernel and handle cases where a new encoding might not be
available, giving it a fallback version, a failure in the first
utf8_load will back off the mount.  IMO, we should just reject the mount
right away instead of silently swallowing the first table here.

This hunk should have been something like this instead:

diff --git a/mm/shmem.c b/mm/shmem.c
index e46bd4fc7e41..06503858dae4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4506,6 +4506,9 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 	struct unicode_map *encoding;
 	char *version_str = param->string + 5;
 
+	if (ctx->encoding)
+		return invalfc(fc, "casefold parameter cannot be specified twice\n");
+
 	if (!latest_version) {
 		if (strncmp(param->string, "utf8-", 5))
 			return invalfc(fc, "Only UTF-8 encodings are supported "

> @@ -4976,6 +4977,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	if (ctx->encoding) {
>  		sb->s_encoding = ctx->encoding;
> +		ctx->encoding = NULL;
>  		set_default_d_op(sb, &shmem_ci_dentry_ops);
>  		if (ctx->strict_encoding)
>  			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
> @@ -5073,6 +5075,9 @@ static void shmem_free_fc(struct fs_context *fc)
>  	struct shmem_options *ctx = fc->fs_private;
>  
>  	if (ctx) {
> +#if IS_ENABLED(CONFIG_UNICODE)
> +		utf8_unload(ctx->encoding);
> +#endif
>  		mpol_put(ctx->mpol);
>  		kfree(ctx);
>  	}
> -- 
> 2.53.0

This part looks fine.


-- 
Gabriel Krisman Bertazi
