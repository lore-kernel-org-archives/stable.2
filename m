Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45F16A395;
	Thu, 18 Jun 2026 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781822038; cv=none; b=L4ZZiatG3XWhjztv/di+f4+4HfppRopg5Zo1EpcJYqKBfXIptMpGSa6Pgmj+MY5W4SETaIOqtSStFndsDrGvc+ee/g303xU8x9XilNjt+CwN6uVx3CUtozGRPrFhVKzC3ZWqAdVv2dFanfy+edERsciCgg1Fm2yjtdW1eGhCu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781822038; c=relaxed/simple;
	bh=vlIYjSHnlyNG6j2OOjTKXO4tNQv3Ofi3wlfSC2Q7YIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRkvKudcOWc/tWq8f7KdU85gmkUgCdcwoRyfK/CwFwhLkZefCJTA/gHCChnu3bSUyAi+L90mCnBr5cFv+lPap+jXL9x+qsXuxyUwuD+Npq8NVBF5wUthgAeK6sZnoMPhvnr6G8JiVCdobNzXXCGFJ5iLh4mWpyJQ8+XuTREWnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KikaDvOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KikaDvOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9221F000E9;
	Thu, 18 Jun 2026 22:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781822036;
	bh=PPgfy605O5o8wvAqk3cdPprH7Am+AzKEG+a0zKEq1Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KikaDvOnp6q6azmzQYrvAjN9G7VxPXQh/JfFYdDXecMSolKUO+BXwR9FoMgWg4Lwl
	 Lo7g3WypnXW8/NMt4nRrwQtmS5Jlspl/C3zPrYFlpGx85bPoIvX6l1FHKuJ0cyxD2y
	 hNN36/3LuHC0V/4cuzfXy9w21zZAunrhT1FW4zmcXFX6n2Il/NaILzdhmW5kTPRWOo
	 mf32lhUCEd7qcv2rJD9stWXMwIkAnMMl2xJfTi/zDjp2QBF+ZXa29ThvWG9JSc5s8i
	 8T9eStCYPNC8xnHtaQEf3DgOLjfxMfDrGLS+a8nPzFYSCy9JWiDPN++LpyOUZDmvNw
	 sc8j6K9E+mQtA==
Date: Thu, 18 Jun 2026 15:32:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Subject: Re: [PATCH] KEYS: avoid filesystem reclaim while holding keyring->sem
Message-ID: <20260618223224.GA23294@sol>
References: <20260614150041.21172-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614150041.21172-1-med08elkadiri@gmail.com>

On Sun, Jun 14, 2026 at 04:00:41PM +0100, Mohammed EL Kadiri wrote:
> __key_link_begin() runs with keyring->sem held and calls
> assoc_array_insert(), which does GFP_KERNEL allocations.  Those
> allocations may enter filesystem reclaim, evict an fscrypt-protected
> inode, and reach keyring_clear() via fscrypt_put_master_key() --
> taking a keyring semaphore of the same lockdep class and closing a
> keyring->sem -> fs_reclaim -> keyring->sem cycle reported by syzbot.
> 
> Wrap the assoc_array_insert() call with memalloc_nofs_save() /
> memalloc_nofs_restore() so reclaim cannot recurse into the keys
> subsystem while keyring->sem is held.
> 
> Reported-by: syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
> Fixes: d7e7b9af104c ("fscrypt: stop using keyrings subsystem for fscrypt_master_key")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>

My patch "fscrypt: Replace mk_users keyring with simple list"
(https://lore.kernel.org/linux-fscrypt/20260618221921.87896-1-ebiggers@kernel.org/)
fixes this lockdep false positive by making fscrypt no longer use
'struct key' keyrings to keep track of user claims to fscrypt master
keys.  That eliminates the need to clear such keyrings during filesystem
reclaim.

So this patch to security/keys/keyring.c isn't needed, unless there's
another reason for it.

- Eric
