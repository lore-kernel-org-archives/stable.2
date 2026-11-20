Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172354;
	b=PN178GzSgthoQEfLUMfFi4SG1KPrbV5Uw3mM/Rn8GcL/6P96nIP64mdYIN9klhyyU8c8
	 v0qB/++20Y5SKJUST8JPCE5FPLOpc2DQWkLpDWmZCqxg1VmgXw4kZ9lPFExKqJEhuNFTy
	 1+qB2rFjV6ymNNAg7xSlkQV74DX4zH+PvrGGe8wWVrQVJCgdUgBsZpPDO7h8q2HiYAwdR
	 a/MutpKrIFx61wpgEz3xs0ciMFIuDugOBimc3lwM9kXrv6AjWvEedrxYFmhFhclov2mpa
	 CgBlyVpmrG71hISSoh9vZA88NwelbFiKC58e8jKgPFRBZTCmNX6AWxoruI4yzpZyhSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172354;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DYh3CMUvkg2nGUNvzVMjuU9kLRX4p2gDD8MljsnMoCY=;
	b=Bxp+ggOZjfbIJ9r94kWwebszWhhKr9Ty1Es8WWR77LiFYGcL7ufE+pnSzEPmMWEgGmHn
	 wRRlb0TGv91QkpA8SGHOEG3Ut60qRfpHOv7sKDg0Tfr+zRCVx5gwgqNCPNohCi6XaxeJt
	 fwwyTWLJOaYHM5q0jY85tFi4IeFoypI4e5H0FxXc1nMCVHJsr93si9QKh5gXC+pBqYITc
	 2ndib3xFy0IZS9YibZazM64AaO2ucT5W9xR+T3iTOLNPbkOszosvIJ+R9ivSpNO7TzFoI
	 Xn/tvngHDiMFjvmDDqrL0N8Sj54OQXIzGNaWrrIaOZBx1DQxPL0hvON7YFQOKrJbQbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cDqrG9Pp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50534606A320;
	Fri, 20 Nov 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=cDqrG9Pp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC161F000CF;
	Fri, 20 Nov 2026 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795172353;
	bh=DYh3CMUvkg2nGUNvzVMjuU9kLRX4p2gDD8MljsnMoCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cDqrG9PpDcbzh5ohEaEaeTzjtXotBV5G2z6oQY4XzbCrWW4qg5SJ94dXO3iBDs+qP
	 rQNqphNsRM2qrcBb0QoIt/qmKAktYtcOxUYVHZERFF4rhSltlhHvsTLHJlonOZ2rge
	 ukjiyHTOYfOb8M/FphcrKwi5YEVqoN8fFHyZ3b1Y=
Date: Fri, 20 Nov 2026 11:59:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: pavankumaryalagada@gmail.com
Cc: michael.christie@oracle.com, nab@linux-iscsi.org, mkp@kernel.org,
	leitao@debian.org, skhan@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_tcm: avoid NULL dereference in
 usbg_make_tpg()
Message-ID: <2026112001-emptiness-rewrap-28ef@gregkh>
References: <20260915080523.15979-1-pavankumaryalagada@gmail.com>
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
In-Reply-To: <20260915080523.15979-1-pavankumaryalagada@gmail.com>

On Tue, Sep 15, 2026 at 01:35:23PM +0530, pavankumaryalagada@gmail.com wrote:
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> 
> usbg_make_tpg() can race with creation of USB gadget function
> instance. tcm_alloc_inst() adds the function instance to
> tpg_instances before configfs links the item to its parent group.
> 
> As a result, usbg_make_tpg() can find the instance while its
> ci_group is still NULL. Passing this item to
> configfs_depend_item_unlocked() then causes a NULL pointer
> dereference.
> 
> Verify that ci_group is set before calling configfs_depend_item_unlocked()
> and fail TPG creation if the item has not been linked yet.
> 
> keep this validation in f_tcm instead of changing the configfs API to
> accept unlinked items.
> 
> Reported-by: syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a9efa71b884a23e74153
> Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> ---
> Changes in v2:
>  - Move the NULL check from configfs to f_tcm.
>  - Restore configfs_depend_item_unlocked() to its original behaviour
> 
> v1: https://lore.kernel.org/all/20260914094426.25595-1-pavankumaryalagada@gmail.com/T/
> ---
>  drivers/usb/gadget/function/f_tcm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
> index 9e6d4f39900a..2c2cf1164edf 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -1682,6 +1682,9 @@ static struct se_portal_group *usbg_make_tpg(struct se_wwn *wwn,
>  		if (!try_module_get(opts->dependent))
>  			goto unlock_inst;
>  	} else {
> +		if (!READ_ONCE(opts->func_inst.group.cg_item.ci_group))
> +			goto unlock_inst;

Why READ_ONCE()?

