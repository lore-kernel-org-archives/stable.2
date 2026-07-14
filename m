Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18061365A1A;
	Tue, 14 Jul 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037656; cv=none; b=Selxcggtsye0CnnAjjfR8l2vBYrZxasP7MtZsbIACQ5xCQLQMvl10hAypKyA2o+xguIVfPaVEEOrka6E8FehCR4kDIGVxstAvk4OE01KhqrjyP6h5o9yzFJj28JELynyfU949bHoj0bP2LIxeXDVDU/99uPzl+hxJ4KDuiCKQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037656; c=relaxed/simple;
	bh=pVPhzD1eh8VjrToQ2HKBT7Tb8A3a8JGraswfgJYL2+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqX42opMGguyv+R2M9huZQ4IswfNJ4rvHeEmfSva+QzSt4tWYxAkCBQbH1sy8kkgzBOK0LUs2eclUQbRH1z5lT5e9EGn9YaoGsqTYij4fQ2/2BsWqn6/DQAUfyc95RmGSG8QiH4RWjYov4KKLZbyeUiYRc/3R/C475CsaM/eJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slj+vHmW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slj+vHmW"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7BCFC1F000E9;
	Tue, 14 Jul 2026 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037655;
	bh=3Bnug0ugvPvgrYXSPNVojFqJBf6D2vxnzOlW/MCJf3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Slj+vHmWEim2I8f+C7GynElV80Bu2OqtCy1pfsqCKKmVcqM4TUrrwbMRP9CWffF9j
	 Hx/GW1VzV5dFPYZeUh6o6Y/yedpoI7hmxwTUPC5PVFeyk838DsDKDIfj1VUC3LpUVr
	 aALlZlvAqmrFhdPBi6uOF5y3HxVD2eteYhX7/BRbHozv9bJx7x3PZKjRb8brEuSw7y
	 Wapmw3D7tHollekmSF4shf0NedbrM4Hio2pu+S95LwThbqyH9q1l4W1uGr9RDObVcH
	 tBqejGnzmzGkRga6XKF7iK3xU5N/8oLYGfrGjOtsNlgg2s9BCmqW7XR9By49DAyvuI
	 MsA6JIKOTRZsQ==
Date: Tue, 14 Jul 2026 16:00:42 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Sergei Litvin <litvindev@gmail.com>, miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org
Cc: nathan@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] scripts/tags.sh: Prevent binary files appearing in
 cscope.files
Message-ID: <alZBCoBorSGsCw-t@levanger>
Mail-Followup-To: Sergei Litvin <litvindev@gmail.com>,
	miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org,
	nathan@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	stable@vger.kernel.org
References: <CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com>
 <20260714083331.69482-1-litvindev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714083331.69482-1-litvindev@gmail.com>

On Tue, Jul 14, 2026 at 10:33:31AM +0200, Sergei Litvin wrote:
> When executing the command `make COMPILED_SOURCE=1 cscope`, the resulting
> `cscope.files` file contains filenames with the extensions *.rlib, *.rmeta,
> and *.so.
> 
> To fix this, modify the regular expression in the `all_compiled_sources()`
> function so that only files with the extensions *.h, *.c, *.S, and *.rs are
> accepted.
> 
> The issue has been introduced by commit 4f491bb6ea2a ("scripts/tags.sh: collect
> compiled source precisely") which implemented the parsing of compiled sources
> from *.cmd files instead of using the "find" command.
> 
> Cc: ojeda@kernel.org
> Cc: nsc@kernel.org
> Cc: nathan@kernel.org
> Cc: stable@vger.kernel.org
> Fixes: 4f491bb6ea2a ("scripts/tags.sh: collect compiled source precisely")
> Signed-off-by: Sergei Litvin <litvindev@gmail.com>
> 
> ---

Thanks, looks good to me.  W/o this patch 'make COMPILED_SOURCE=1
cscope' is actually not usable on my system, as soon as some rust libs
are in my build tree, so thanks for fixing!

Tested-by: Nicolas Schier <n.schier@fritz.com>
Reviewed-by: Nicolas Schier <n.schier@fritz.com>


As this is a not really a build relevant bug, I think this should go via
some -next rather than a -fixes tree [1].

Miguel, are you with with it if I take this patch as well as the second
one [2] via kbuild-next?

(I tend to remove the Cc trailers from this patch here, as they are
incomplete.)

Kind regards,
Nicolas



[1]: https://lore.kernel.org/r/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/
[2]: [PATCH v4] scripts/tags.sh: Add support for rust source files
     https://lore.kernel.org/linux-kbuild/20260714125259.78824-1-litvindev@gmail.com/T/#u

