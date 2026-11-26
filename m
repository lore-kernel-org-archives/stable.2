Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701661;
	b=UZG+to7liruIVIMMA/bnhW3k5Gz4b8c4SlCXkxGKf/BsmfxF3pbbztbw5YcfMwLDX+/u
	 1YTMLcXHAWWO2ma4kg1KGXVLoRov7nD39mcRCSfs4AfgYqfCTZwt1NzQMax/vge5HSI4p
	 B1SsVMKdXm6Qa14vOCfwiWBfw/6mKRBl+FZR7WgL4ELSwhjZ9RLU6knGvaVQuvXnjGphV
	 RNn2mEXK91mkJppQAA/Iez4CV2ny/rEPQ2RZQNc5xy02NhyTshlPE2xuctgZ1Uxfu6xdz
	 MwH5eJk+2Lctitj/bGlQkc5BGkH8uJOkXDqyD2siFCl1TbvNdF0XNZb/ePyhwjMCVsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701661;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pxwgnugQyzNZ4SZJHJTxdTuT4hUHrL/uJJ+EYfhHR/w=;
	b=p6NTtPosMMFcJCN3xoHoI7m7V8OyOb67FXyQVNS5fgBp+ZLxbVqrFZwlTjnfd8aSP7tR
	 DQ4xWOTT/Ysz9dXFAv1rsgC3LTbsl8XedkWMO+QM8y4OHuDtYBdkJelyeSKCWXIznbx4d
	 bMcdPp7w72M/lN7ugREQ+WR0dOHXmVIBlWNQ4jvc5o3kS85BxCN0IMZ5z+92n+hwQ20GW
	 XQtPJRJoy41vkNShB/CMdn26ps6c1Mb9/FDe4/8HYT2gKC0QbD8zLLbmKPt8uFNPldh6n
	 P6qOPVp6amEaNp0UQJy3N7ODxu2Tk4quei5Omzd3CijlhcB3ohLDaUkxm6eW8pKSM2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=z8Vqxfpg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D4606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=z8Vqxfpg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D701F000C0;
	Thu, 26 Nov 2026 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795701661;
	bh=pxwgnugQyzNZ4SZJHJTxdTuT4hUHrL/uJJ+EYfhHR/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=z8VqxfpgcZxe9sSkOlyw68KVGAViZkFb5jR4qsOrMap2K4zU7IDyIumZtUAzn9nOI
	 6c1NNELgWeT+k8vXAzr2yvomtiN+GNiS3T5Kt8FRmq+sdQ1pYxHaEwUT0bWhXELy7U
	 xBGNymr5buBfiMpCE6AVMkbiS0xafI7dEn/0SaRs=
Date: Thu, 26 Nov 2026 15:01:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mohammed omran <sanhokh30@gmail.com>
Cc: stable@vger.kernel.org, linkinjeon@kernel.org
Subject: Re: [PATCH request for v5.15.y] ksmbd deferred file_lock UAF fixes
 missing (CVE-2026-64396, CVE-2026-64437)
Message-ID: <2026112653-glowing-freezable-6955@gregkh>
References: <CAGwSD7Tg+b9H8cGnCqg3Y4iXk5tN5fh2joxVqxTbLVs+65y3RA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGwSD7Tg+b9H8cGnCqg3Y4iXk5tN5fh2joxVqxTbLVs+65y3RA@mail.gmail.com>

On Sun, Nov 08, 2026 at 01:55:13AM +0300, Mohammed omran wrote:
> Hi,
> 
> three ksmbd deferred file-lock UAF fixes landed upstream in June 2026 and
> were backported to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.1.y, but did not
> reach 5.15.y (5.15.225):
>   f580d27e8928 ksmbd: fix use-after-free of a deferred file_lock on double
> SMB2_CANCEL
>   d20d1c8ba576 ksmbd: fix UAF of struct file_lock in SMB2_LOCK
> deferred-lock cancellation (CVE-2026-64396)
>   10f293a07f9e ksmbd: fix use-after-free of a deferred file_lock on
> SMB2_CLOSE then SMB2_CANCEL (CVE-2026-64437)
> 
> Evidence:
> - The CNA record for CVE-2026-64396 lists the 5.15 branch as affected
>   (vulnerable since e2f34481b24d, "cifsd: add server-side procedures for
>   SMB3") with no bound fix for it, while every later branch has one.
> - The deferred-lock async machinery is fully present in 5.15.y's copy of
>   the file (fs/ksmbd/smb2pdu.c): setup_async_work, release_async_work,
>   smb2_remove_blocked_lock are all defined/used; note the file moved to
>   fs/smb/server/smb2pdu.c in mainline, which may be why the backport
>   tooling skipped it.
> - linux-5.15.y's history for fs/ksmbd/smb2pdu.c (through 5.15.225,
>   2026-11-06) contains CommitDate back to 2024-11 and shows no deferred
>   lock fixes; the branch is actively maintained (fresh fixes landed on
>   2026-10-30).
> 
> Note: 5.15.y predates all three fixes, so it holds the original form of
> the UAF (a second SMB2_CANCEL -- or a SMB2_CANCEL after SMB2_CLOSE,
> which gen1's guard does not special-case either -- re-fires the
> registered cancel_fn over a freed struct file_lock, KASAN slab-UAF in
> __locks_delete_block) without even the partial mitigation present
> elsewhere.
> 
> Could you please queue the three commits for 5.15.y (gen1 first; the
> other two apply on top; fs/ksmbd/ path applies to the 5.15 rename).
> 
> Thanks,
>  scofaild23

Please provide a set of tested and signed-off-by patches, for everything
you wish to have backported so that we know it actually works properly.

Same for your other requests.

thanks,

greg k-h
