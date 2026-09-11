Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6A44F56D;
	Fri, 11 Sep 2026 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113409; cv=none; b=LDEHlzsf1YZCo05CGoLyNSfQ45oZHO6zw4ANIPBRECMDwD9f7MNGLsYuAeJT4PP0ERS/ZqbqHRm+HNjge2d5dy6oBN6SxGMHRsahHi62BfQxoYXerJByoVu7d/5K6aiVfB52HV5SA2wuHDm1u0H6217DuUn93XntuPFLBe4YykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113409; c=relaxed/simple;
	bh=whmqP0QuzSq5AYKOjknJYrgw4F/lPYPUHyjtu5l/kbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwpD5ZxVNr8Ph9VrY+QEG8JMgpWPnzXfqtlrtoEpTZjVqT+i8TkF1UIK0JFnyKNlllW2/so99o6fXz3oDlwbzJy7LfrzwunXxGwV06GmAPn/wIdINqFAsEC+NH5206Pkxa8sOF0tElI8a7B+bL0TAzHd25DeDvznZ6UozfRQYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QUFCyVEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QUFCyVEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF841F00898;
	Fri, 11 Sep 2026 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789113406;
	bh=T1GavebbZPTlqgOqGrxwDHBzaNM5E2me9jwDkKwEGKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QUFCyVEvv4cjyOPDS+Zihp4utdN6Y2N1j7KFqz+R+kCu1MT4QtyO2bUlseKo78Lz1
	 B6UPCDplYuhAagW/RVmVguo5d1SfPgDxK1ofpFXrN8Oel1mPR57wK3zl8qmm6gD5sM
	 sZH5Xpz9sxupnd6fGDi69bZi3YOE75sOLfey0j5s=
Date: Fri, 11 Sep 2026 09:56:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: henrymei <ljp1205831794@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: keep DLCI 0 object across mux restarts
Message-ID: <2026091139-recess-refute-e373@gregkh>
References: <20260911065826.3515170-1-henrymei@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911065826.3515170-1-henrymei@tencent.com>

On Fri, Sep 11, 2026 at 02:58:26PM +0800, henrymei wrote:
> From: Aohan Mei <henrymei@tencent.com>
> 
> gsmtty_install() takes a reference on the object occupying the
> gsm->dlci[0] slot, and gsmtty_cleanup() drops a reference on whatever
> object occupies the slot at cleanup time. The two are expected to
> balance on the same object, but gsm_activate_mux() breaks that: on a
> mux restart (GSMIOC_SETCONF with a need_restart change) it
> unconditionally allocates a fresh DLCI 0 into the slot, orphaning the
> old object which still has install-time references outstanding.
> 
> When the last of those old gsmttys is closed, gsmtty_cleanup() then
> drops its slot reference on the *new* DLCI 0, driving its base kref
> from 1 to 0: gsm_dlci_free() frees it and NULLs the slot while the
> mux stays alive (dead == false), and the old object is leaked. The
> next gsmtty open passes the dead check and dereferences the NULL slot
> in gsmtty_install() (dlci_get(gsm->dlci[0])), crashing the kernel.
> 
> Keep the DLCI 0 object in the slot on reactivation when one is still
> present: it can only still be there because open gsmttys hold
> references on it, and gsm_dlci_free() is the only code that clears the
> slot and only runs at kref 0, so the slot identity can no longer
> change while install-time references are outstanding. Re-take the base
> reference that gsm_cleanup_mux() dropped via gsm_dlci_release(), clear
> the dead flag it set, and refresh the per-object config fields exactly
> like a fresh gsm_dlci_alloc() would, since the restart may carry a
> config change.
> 
> This also restores the invariant that dead == false implies
> gsm->dlci[0] != NULL, making the NULL dereference structurally
> impossible.
> 
> Fixes: 6ab8fba7fcb0 ("tty: n_gsm: Added refcount usage to gsm_mux and gsm_dlci structs")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>

As sashiko just told you, this isn't going to work.

ONLY touch this file if you can actually test this code, AND you have a
system that uses it.  Otherwise it's not needed to fix up anything that
a LLM might "find" in this file, see the mailing list archives for the
full details.

thanks,

greg k-h
