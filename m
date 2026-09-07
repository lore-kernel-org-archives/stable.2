Received: from mta1.migadu.com (out-117.mta1.migadu.com [95.215.58.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05201A6806
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759492; cv=none; b=V2uyFbQz7Wn3QfLauhPhfNioUAy7b5ZuVR8RxdJEzuaCAF+7vI+pWiHdGjYVPcxmJiRzCmUAscpsS6rxffLCY5G1tvoGwTFjCbTgY7wjuuSd5HzoeOS5QL5y2FxjsOlXhJZ7Ffd2xG+meug+LCC6Ej302HkHtISDMPQ7PC1IfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759492; c=relaxed/simple;
	bh=74/oe6rBOJwZLfV0DTAGZu1Xixz00uAR28nQ9xy/CJo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XKwdP3hgcokgfCt68X4XvCHply9Q7Z5Mc5zQnY7zkCL63lOXaN+HIs2wA/GeCWBxjx2P4I6rjjptUiK+BSNKbVKeqFr9OHX+0UC2qKuIbO4nxem8/QjkfbdnIQXilKjWlaWilVyoBfXWmnxHta2YypATOs0UBgx8gW7RccJPh4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YGwNPJya; arc=none smtp.client-ip=95.215.58.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YGwNPJya"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=74/oe6rBOJwZLfV0DTAGZu1Xixz00uAR28nQ9xy/CJo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788759488; v=1; x=1789364288;
 b=YGwNPJyaWFZKmF58gngpp8oB+VW8DTrC2O7vpyW9reFALde57LhEvLw3MUet2n+/nJjbj++E
 ZsgvGzrqRWfmvCiggSm1L8ZTsciUEz7pG+7VlBGa+9dSM8+fjWoTQY5BQKfk51/j2aYfH3vfe9L
 kkKnq+V15s1+OUio9QdLmMso=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6b32810261b4e1a4;
	Mon, 07 Sep 2026 05:37:58 +0000
X-Mizu-Trace-ID: 6b32810261b4e1a4
X-Migadu-Flow: FLOW_OUT
Message-ID: <73236c69-bd81-45e1-8195-59775a34475a@linux.dev>
Date: Mon, 7 Sep 2026 13:37:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, andrealmeid@igalia.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] ovl: clean up dir on casefold mismatch
To: linux-unionfs@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com
References: <20260907045517.1347518-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260907045517.1347518-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/7 12:55, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> In ovl_create_real(), the S_IFDIR case checks after a successful
> ovl_do_mkdir() that the new directory inherited the expected casefold
> flag.  On mismatch, err is set to -EINVAL but the directory that was
> just created in the workdir or in the upper layer is left behind.
> 
> The mismatch is reachable: ofs->casefold is fixed at mount time, but
> the casefold flag of the index dir can diverge.  With index=on, a
> pre-existing "index" directory with +F is accepted at mount, and every
> temp mkdir for an index entry inside it fails the check and leaks one
> directory.  Measured on an ext4 casefold upper: 100 directory renames
> left 100 "#nnnn" entries in the index dir, one per failed mkdir,
> growing without bound.
> 
> Clean up the created directory with ovl_cleanup_locked() before
> returning the error.  All callers of ovl_create_real() arrive with the
> parent inode locked (via start_creating()), so the locked variant must
> be used; ovl_cleanup() would deadlock on inode_lock().
> 
> Fixes: dfc7da402ccc9 ("ovl: Check for casefold consistency when creating new dentries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  fs/overlayfs/dir.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 7beb0af26498..4e451bbd8f97 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -188,6 +188,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
>  			if (!err && ofs->casefold != ovl_dentry_casefolded(newdentry)) {
>  				pr_warn_ratelimited("wrong inherited casefold (%pd2)\n",
>  						    newdentry);
> +				ovl_cleanup_locked(ofs, dir, newdentry);
>  				err = -EINVAL;
>  			}
>  			break;

Sashiko pointed out that the casefold check can crash on a negative
dentry (https://sashiko.dev/#/patchset/20260907045517.1347518-1-cui.tao%40linux.dev):

ovl_dentry_casefolded() evaluates IS_CASEFOLDED(d_inode()), which is a
plain dereference, so a negative dentry would crash before we even get
to the WARN_ON(!newdentry->d_inode) check below.  And if it somehow
survived that, ovl_cleanup_locked() would rmdir a negative dentry.

The NULL deref itself is pre-existing (dfc7da402ccc9), but the cleanup
call makes it worse, so I'll fix the ordering in v2:

+			if (!err && d_is_positive(newdentry) &&
+			    ofs->casefold != ovl_dentry_casefolded(newdentry)) {

Negative dentries stay on the existing WARN_ON path.


