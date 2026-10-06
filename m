Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D438B133;
	Tue,  6 Oct 2026 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325510; cv=none; b=u8R9qzmw38KMyQl6PnBk8xF4oQlgKKcQKCIWRgQhdfC76ZL+GlY5e+8nFH1XOkjw2W0+mdMXNqI4V7POAq8SJRP3LLI396PG31R3M8Lgp1+tG6OJtHmzf5p+BUSN3hhsP22Uo36RKCmELfT+8Ry20ABdt4bMOhk2nt/EDWOKvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325510; c=relaxed/simple;
	bh=b7iWX7b8ZjSGe2dGw8tye9ATb81SP+mmfnV7tOyaSwQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UoijdIgS9VP4Ojv14LnPgtBcJkvXs5sVi2nqcNmetjQLRalgnhhy2aG2kkqN9M1YTUpG2jslPCxFfid+pmUCIzaJSYtJRH2wMzEDt4F4hQhCZbGDp1zN+b+2cTRLwg9gKvIEOf475wP8uvCutpwB9OdezNbG+ZoYcNyw5Wh6vL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2j/Z6j05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2j/Z6j05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA75C1F0089B;
	Tue,  6 Oct 2026 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791325508;
	bh=7Jk7PLs4H0c6txoot5IcBFv812i6Hp1MuAA5BEaXSLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=2j/Z6j05P5TpKNA0tiEvdKOrWERNLzOVj8gMp+a91yu/vEy79GW9LlVJwfEykZkor
	 Q7+x2TrdV51p3YlkUMFOaAMGK+sn1AHvMN1BCyCor9QUt22RQVi7WxKF+KTQQ4jiMP
	 4Eb2F8m+9rDKDl5wmnM51EnnnCWctsjEsi5NxDrQ=
Date: Tue, 6 Oct 2026 15:25:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, David Howells
 <dhowells@redhat.com>
Subject: Re: [PATCH] assoc_array: Preserve full words when splitting
 shortcuts
Message-Id: <20261006152508.ba7f3c7a6661daed4767a18a@linux-foundation.org>
In-Reply-To: <20261006220638.32195-1-kylebot@openai.com>
References: <20261006220638.32195-1-kylebot@openai.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 15:06:38 -0700 Kyle Zeng <kylebot@openai.com> wrote:

> assoc_array_insert_mid_shortcut() copies enough index-key words for the
> new pre-shortcut, then masks off the unused bits in its last word.  If
> diff is word-aligned, the shift is zero and the mask clears that entire
> word, even though all of it belongs to the required prefix.  The new
> shortcut no longer matches the objects behind it, so lookups can fail
> for both the existing objects and the new one.
> 
> For example, inserting a user key with a different description length
> into a keyring containing enough full-hash collisions can split a
> shortcut at bit 64 and erase its hash word.  The resulting search
> failure can also expose the pointer-dependent keyring hash as a KASLR
> oracle.
> 
> Only trim the last word when diff ends inside it.  This mirrors
> commit bb2ba2d75a2d ("assoc_array: Fix shortcut creation"), which fixed
> the terminal-node case, and leaves non-word-aligned splits unchanged.

Thanks.

When fixing a bug please clearly describe the userspace-visible runtime
effects of that bug.  Including how-to-hit-it, reproducer, user reports, etc.

> Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
> Cc: stable@vger.kernel.org

Especially when proposing a backport. 
Documentation/process/stable-kernel-rules.rst provides guidelines.

> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  lib/assoc_array.c | 8 +++++---

get_maintainer coverage is poor.  Please use git-show also:
hp2:/usr/src/mm> git show -s --format="%an <%ae> - %s" 3cb989501c26
David Howells <dhowells@redhat.com> - Add a generic associative array implementation.

Also, as this affects keyrings, grep -i keyrings MAINTAINERS shows the
mailing list.
