Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795721773D
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101532; cv=none; b=buFG2OEc20fCw80/1rbrVp4Bwm1nWPoQLGdwoW3UyUWL2NyJmzK3R6/azMEqIgqMa2NZnt3Kc587jkirWv2cfDO2d2sgrALZFWrH1KPkb7yRZ0RgV+eDajbus0ZePGmeA8SChCGCcJrXaDeQMuEqtZRYUoR8gRqzEECypbgGfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101532; c=relaxed/simple;
	bh=vaifN4C+m9pkGn36KU2G6y01s4Md8XqGC1tkRg1XA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz137ik6l2+HEeG9rRPzBW6UNlt1MpT3zsqHwZ4AhSsu6w3JGYNVO67VTYboMPyxPkF8biV858QvGHF+Wqw/B1P56n1TRXs1D9iwIQVptOCVkz+z7r2GCppQ+ZtQ1GA3hjwwCyqMz/b7jq6VWcbPfinjx3agYZK2hlUng+dewTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IZ+YSbkD; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IZ+YSbkD"
X-KPN-MessageId: 6f7230c8-8939-11f1-a5a1-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6f7230c8-8939-11f1-a5a1-005056994fde;
	Sun, 26 Jul 2026 23:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=PkNII37eO6z0YhZ/U5eAl8Xy/QnR5k8d8xDGrIaXLVc=;
	b=IZ+YSbkDfUVGBYjZ5ffc99Rspi3hp9ZHSotxJqJvkLew3Qxd7tqw7GOynLdETTM5eyoIOqOvzSE6t
	 iV+ISRrMmPAhwx2hm05PCt+4KFp2dWqLoYmmDAXo6ja51rjsQg5hwRtsbBeCT+qlXd0PJ5S45hky+9
	 CRmQubnfsMP8R1XxQFMGBznJmcBwilBiGv+e81vj+5XC2vqmbyEkGTUJMMeHkeRPF4RKS81dzRmKDS
	 t19JQ+ixDDehP0EzvY/I7jL+hNMoyPmQdeXQU1RRMbP2Zf/i27PNJHDfHmgwVcHB4eFZesPrX1LzTV
	 8N5FTYd3pz2cldhi/fPbr411i/fHGkg==
X-KPN-MID: 33|ePywlr9eTYlMvTqTjSYxNkKt3vApC3vdIBki4AA3+u+ExLsBWIXRMRTdpybsUwv
 Er4RFTteCCX6Ix8ZETA1GgMsNFZsmUrKyn8urNLQhtzI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|REqvLpPbt3J1YoMQY/wV9jGu/6UaarOQDY78tgetYwDvcQ72xIyjW+u3bL59oK7
 zUBV2SbWd9YTASBjDo56e/w==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 6f2bd4b2-8939-11f1-8dd2-00505699d6e5;
	Sun, 26 Jul 2026 23:32:00 +0200 (CEST)
Date: Sun, 26 Jul 2026 23:31:54 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 01/24] binfmt_misc: restore write access when removing
 an entry
Message-ID: <amZ8tfX77B2ey4Hn@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-1-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-1-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:02AM +0200, Christian Brauner wrote:
> Registering an entry with the MISC_FMT_OPEN_FILE flag opens the
> interpreter via open_exec() which denies write access to it for as
> long as the entry exists. Removing the entry closes the interpreter
> file via filp_close() but never restores write access, leaving the
> inode's i_writecount permanently negative. Opening the interpreter
> for writing keeps failing with ETXTBSY long after the entry is gone
> until the inode is evicted from the inode cache.
> 
> Commit 90f601b497d7 ("binfmt_misc: restore write access before
> closing files opened by open_exec()") fixed the same imbalance in the
> error path of bm_register_write() but the actual removal path has
> been leaking the write denial since the introduction of the flag.
> 
> Restore write access in put_binfmt_handler() before closing the
> interpreter file.
> 
> Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary handler for containers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 84349fcb93f1..de50a7468b07 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -162,8 +162,10 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
>  static void put_binfmt_handler(Node *e)
>  {
>  	if (refcount_dec_and_test(&e->users)) {
> -		if (e->flags & MISC_FMT_OPEN_FILE)
> +		if (e->flags & MISC_FMT_OPEN_FILE) {
> +			exe_file_allow_write_access(e->interp_file);
>  			filp_close(e->interp_file, NULL);
> +		}
>  		kfree(e);
>  	}
>  }
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
