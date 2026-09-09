Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03C560AAF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960945; cv=none; b=bj0bmBxIbyuClhWDimPXJStaW9CNCJ7ty0f+dJzFvlj58KIdmLv9Y2RYdoTaj7oy5Us4sNbTM2aLFGwDduKkpIr3ev1DD/9HRjUINHJ++JbMrsLXNet6REi9f3oNq2wLqHvb7YU03bwmrMslpNQeyfngDrJ+10j8XiNHmif8EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960945; c=relaxed/simple;
	bh=/XarJqaidtKwPXvzAKvSjEriRpNBJ3rNVln7BkD6g7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSwRr5JsyOL/vSdLmwrceOmS3VJU8lgjXxXICpeVkLdz7QB+bTiFbSiOXkG3AZKFiSIpf3EutfxPEsBDN7P5oIANJ8cnV+RpiS/sXDvUpvfawWaBcgGFX+oghlY1jBcq8Vc94JNoEYT98v3AOHHJ3h/ommmFOD159BsVbYVtpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nv52IRfq; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv52IRfq"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so8011675e9.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960942; x=1789565742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vGs1Iz2RvOpA9bZt0H5a3fcHsY9R+8hYXY78RMOjPmo=;
        b=nv52IRfq3RIcNYYAYnt4eaoCyitGzOaK2n8n31sCNJ/AhEO/XHNhrBqycIXW7dtVXE
         QRMaePrm+s8TGODGWdq/9Upbxu2hBcyHz0Wo+ivlObD7p51f4iywTY6enzxRwc/NPjAF
         5Ay+QRC8GjaXhdWubMCx2uHWLaSJKVTh6N4lyKWkcK2/qgnVRLNhWUqAo80dG47oj68J
         P/A4rpG5pku7LrizPMOl+zhni8mwgZmWFgIK3f8/j8K+TViPfshChVwl75BCoDzw29aC
         //dDKnbfauHU1VEjecBiml/6/YTkz0p2ELZgW61ugVFPmrnPzi1BKWwBgWq6Cvn7ACb4
         R6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960942; x=1789565742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGs1Iz2RvOpA9bZt0H5a3fcHsY9R+8hYXY78RMOjPmo=;
        b=pbSYRaESmZRHLBpvlSrJX42/26bHPNhMVxEeH3CmM1UHRI5AcDR5z312YvC2OQ0yKd
         z+IcQCBED4CSzqP7x3cbqyhn84uwMvrUaycVTOdaWY21SRc4T9+YUGEW+FFpVMvQtAef
         XqCXIepy/Sxp0vUnK8cM+pFdS9yASoZsVmEUxuHinFNlD3P/NkeT74CmKDLpO8/zD9Ea
         SqANEaTooM4fs5/LiRBccYWT0YCgJoKY2TH0lTUnGJLjKzQC80oZ7ydxt0A/qyHKN6Su
         xAv5KAa2w2eN4T1EvpAnK7/O7AmgaAZVwETolNjJhy+K5+0vjDpjY8bssMom8m/ER9uC
         q4fA==
X-Forwarded-Encrypted: i=1; AKwUvBw61n+AP+GZIIrrJoKUmhF8eBkPxw3sQw6AUTSmCeuozDE5c53rpMDZ7pTHdirnfpK+SFosvTw=@vger.kernel.org
X-Gm-Message-State: AFuF++k1foY2JjkT1lGoij6toAKlp23+r/vFETMT4Aa+T/B2A5M4e5j8
	0YZIwSlbRc2WB3SQdqQ+eYrVMnGZArtnW39siLs38X1b5i9Z9R7gPRPL
X-Gm-Gg: AYBFou0WXGq0RWEkQTre+3/LpHwI0yqi23d3IjfUjFRcQCACs0OS7/yePNgSBGNEAax
	KVD7wnY37bbWjackRRt+CXACZNb/vgy87KVzTGcjfwHGBb5hT97/irw1GGYGcpV2mnJvgWuQaum
	LfGc79iZP8S57V/96ztd+NfU79yJPm1b37EXQSwjt5hkoG6wke7s7ap93WHbuOM8Eo5FEMrp9Sg
	20Dop0LO2spEQNqkWXF6zlg5JvgdNGUBe889cEB/maKcTWQdZoKX3u51vwuXvChXphb5Etwmo1+
	kRQWSq0XZRczdQg5dseNY/1GgJYLLDvoQ4NI+TQnQHdbLTk5X4p+vnsz7DagSH1m43nqffiY5Yr
	AldmwTbFM9Fl7kobTLKu3yvdLYsuVKe4hGpO2ynoncnTM8TTGm8Yv6L0dsd91rAc4NbVNKytbPj
	+RN9d5bW15mkOqqSUXcUn9QMDAVM8cHCkapSvA3i6lgYjEJ46QyRNiobFl/xuwFiHW
X-Received: by 2002:a05:600c:1908:b0:49c:f13e:e4f with SMTP id 5b1f17b1804b1-49d1757b03dmr121676015e9.12.1788960941385;
        Wed, 09 Sep 2026 06:35:41 -0700 (PDT)
Received: from egonzo ([2a01:e0a:971:4ea0:d8ac:7292:29a0:e246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20dae82csm39596435e9.3.2026.09.09.06.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:35:40 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:35:39 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Giorgi Kobakhia <gkobakhi@asu.edu>
Cc: mrkobush@gmail.com, linux-kernel@vger.kernel.org, xmei5@asu.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpib: agilent_82357a: fix null-ptr-deref in
 primary_address
Message-ID: <aqFgq0zOgANj00uJ@egonzo>
References: <20260908195736.1554837-1-gkobakhi@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908195736.1554837-1-gkobakhi@asu.edu>

On Tue, Sep 08, 2026 at 12:57:35PM -0700, Giorgi Kobakhia wrote:
> The function agilent_82357a_primary_address initializes usb_dev with
> interface_to_usbdev(a_priv->bus_interface) above the guarding if
> (!a_priv->bus_interface) return -ENODEV; When the usb dongle is
> unplugged, disconnect() sets bus_interface to NULL and the NULL
> dereference is triggered.
> 
> Commit 8491e73a5223 ("staging: gpib: Fix Oops after disconnect in
> agilent usb") fixes multiple NULL dereferences in other functions,
> but this one is left out.
> 
> KASAN report for the left-out NULL deref:
>  Oops: general protection fault, probably for non-canonical address ...
>  KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
>  RIP: 0010:agilent_82357a_primary_address (./include/linux/usb.h:752
>   drivers/gpib/agilent_82357a/agilent_82357a.c:922)
>  Call Trace:
>   ibpad (drivers/gpib/common/iblib.c:466)
>   ibioctl (drivers/gpib/common/gpib_os.c:1507
>   drivers/gpib/common/gpib_os.c:675) __x64_sys_ioctl (fs/ioctl.c:51
>   fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583) do_syscall_64
>   (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>  Kernel panic - not syncing: Fatal exception
> 
> Remove the faulty assignment.
> 
> Fixes: fbae7090f30c ("staging: gpib: Update messaging and usb_device refs in agilent_usb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Giorgi Kobakhia <gkobakhi@easu.edu>

Acked-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  drivers/gpib/agilent_82357a/agilent_82357a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpib/agilent_82357a/agilent_82357a.c b/drivers/gpib/agilent_82357a/agilent_82357a.c
> index 2468a471d175..7abe5540ffc5 100644
> --- a/drivers/gpib/agilent_82357a/agilent_82357a.c
> +++ b/drivers/gpib/agilent_82357a/agilent_82357a.c
> @@ -919,7 +919,7 @@ static unsigned int agilent_82357a_update_status(struct gpib_board *board,
>  static int agilent_82357a_primary_address(struct gpib_board *board, unsigned int address)
>  {
>  	struct agilent_82357a_priv *a_priv = board->private_data;
> -	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
> +	struct usb_device *usb_dev;
>  	struct agilent_82357a_register_pairlet write;
>  	int retval;
>  
> -- 
> 2.43.0
> 
