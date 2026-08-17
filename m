Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F042AFAD
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977970; cv=none; b=Z6B4yuj4rL4m3D95imYN2vHGBoXqCeLr8UkK9ZYQ/NJuq3Ng9jLHzx7F+cCN1ivIvrT8vLJAAQxyvfRkSMPTQ+F13nFKFDCPgBUS+LSMMnddcrM92ZNhAc/ieIe6g+4UhnqYvW8NA2TNVj1mGGf+JW1DGAyjKcZ+tgiLGsHMTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977970; c=relaxed/simple;
	bh=MduWm0piicCPLJVaVl38wmTVcawPChLXhJfFlKqq6ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBJzcUo3PkyDCrJpWLkcuG58FsKZ88TF9dk1BXdWGDKGDG+rmPm3KBieFZXyklw2SMvg0Agqr7UtNo4+wvfcvLBhvf4IOgGbkw7/iMNpDi2YBWxE6fSEGiY6QwcVr80VAPOHSmbGXh0LkoPZGcZI7PnfDccW6XjXRVr22aMmdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qisWjA9i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qisWjA9i"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so25412345e9.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786977966; x=1787582766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5WfvTCVMtBGFuD0i/SGJKcgjjeNMofzdUgLOwyahACM=;
        b=qisWjA9ivd2ZLBUXkgosoRe5OmPsDC9ILM5SoQBvy5SzGtaFGloAqgkijWKqUHD2NS
         VzeLcrCyqWtme4rRjsrknJdh/wOUnQ+JFj0asaUTTenNUkrUligumOinA+iOKPO7gcIN
         KJlCJu1Ohmo2cXg/2UZID0LjzptSuTB42M0IH6C974OmItfmPdtgVjo1MG+tSzHceFzP
         PAhjKfO3UhHRLaDJVnamRvtOvYcBcOH58mZK7+n/dgysiClYlkDNd8xVOPUDAVApqb6g
         gxMKRi6YUMTKIjrT+4ewYFASVJdiuZqIIO5uGOtx6HH8AcEyouG7YM67qrUYB7w/owcv
         78rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977966; x=1787582766;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5WfvTCVMtBGFuD0i/SGJKcgjjeNMofzdUgLOwyahACM=;
        b=A5PrAcdX+VCBN1PeQYYU86p73FGor+EiPRWlRP+6vY8I0/R7zBKCln0YUHhMWy4fqJ
         uxNknjo3TX4zaNTZce/e4CbDV3+r7MArqHSdY/N/Xp9r+n0omyA2uxag5yIXdgZdi9Md
         vtWIpWlU+BltkpOBLqb5TGSUmm4Zyo0G4XBKfgjOQ7Y0F16tjbJPLNz00oaXqUJYrwxT
         zMsqWO/zmHNXam1Ul19LAHQijr3qkpngj7FU5Iv1mEolqjtbBcNpFYnkiu/3h+E+mjZG
         G+2A8FmTVfQWIUr1/Cg7iJgiytDp0Wahuc2tVda6QUCmGCn5HbByFR6sT2MGdP9MIjf1
         C0Xg==
X-Forwarded-Encrypted: i=1; AHgh+RoSXOE4QaxNMw/xJKphkgz28BjoxbSmjJebqCg/l8cVs4+CJ0oIysvRF4hTsP4YXXj6373LHvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0EAeXaiCBFqgiYFImSZskTxjyVTlpOtoo7b57kJi9RTau7daL
	DkO6svWoOxOV7di42JF4L2KkcI39xs0L/8n+amNFWrtAEOzAhQHSQPlP
X-Gm-Gg: AR+sD11M86x+x2EVoswvPTkjA/t6Dv9aXrGvy7HTFztt7O2FYKxr3yZPNKUSwxvZzD4
	ahcZLQW6nGwTRkOdPw2df6ICkUPedIFQJ5m1Y5kEXAGecZw/WN+06wrtJTuQb+s878gFv7NVZTZ
	TtfRsSMw2FxYIbofClH841zh3uS1o0WKAj6VN2poEzurBNYey05seqaUY42cgL6GfqbVRv+1LQz
	xV0NQkOxrWE1v97xUgTA3fgW5AJBe5La22ux2XwyOUoRPv+fViZyEEAoRbs22aKFXGcOCtKBGzC
	5duUn7QeHxP0oE0eJ76xSQCHmkebyI+BQzbnn5Pr2mkS8IKnycJHL8hgyIhCwVC8BMAvl0cblqY
	rj+1TCeC2gHTrfZB6RDx3RDq2zOFnFDJvYYgt644k1IsBk7Adl+S1FdA8nPlNEtePpVGfCWVBiw
	Kl9lhvg8b7dzRyUKrwzcUv/kE799MPgGIW9CasN3wDy1dlnBe5zGGXT+mkIV1lL2GatyjOFVaQY
	+OqHPYdrzyIPwAd1wsyhVzwBQ==
X-Received: by 2002:a05:600c:4704:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-499922f4c82mr209964585e9.0.1786977965797;
        Mon, 17 Aug 2026 07:46:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0788dasm41047085e9.4.2026.08.17.07.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:46:05 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:46:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Zimmermann
 <sigmaepsilon92@gmail.com>, Peter Korsgaard <peter@korsgaard.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, John Keeping
 <jkeeping@inmusicbrands.com>, William Wu <william.wu@rock-chips.com>, Marco
 Crivellari <marco.crivellari@suse.com>, Ethan Tidmore
 <ethantidmore06@gmail.com>, Kees Cook <kees@kernel.org>, Chris Wulff
 <Chris.Wulff@biamp.com>, David Sands <david.sands@biamp.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: do not copy_from_user() under a
 spinlock
Message-ID: <20260817154604.70427ed1@pumpkin>
In-Reply-To: <20260817061141.82597-1-gonglinkai@kylinos.cn>
References: <20260817061141.82597-1-gonglinkai@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 14:11:41 +0800
Linkai Gong <gonglinkai@kylinos.cn> wrote:

> f_hidg_get_report() already copied the report from userspace into a
> new entry, then called copy_from_user() again under
> get_report_spinlock. That can fault and sleep in atomic context.
> 
> Update the existing entry with memcpy() from the copy already taken.
> 
> Fixes: a139c98f760e ("USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
> ---
>  drivers/usb/gadget/function/f_hid.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 3c6b43d06a6d..e4621e5a0b69 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -667,14 +667,9 @@ static int f_hidg_get_report(struct file *file, struct usb_hidg_report __user *b
>  	ptr = f_hidg_search_for_report(hidg, report_id);
>  
>  	if (ptr) {
> -		/* Report already exists in list - update it */
> -		if (copy_from_user(&ptr->report_data, buffer,
> -				sizeof(struct usb_hidg_report))) {
> -			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
> -			ERROR(cdev, "copy_from_user error\n");

How about a patch to remove the ERROR() from the earlier copy_from_user()
error path?

	David

> -			kfree(entry);
> -			return -EINVAL;
> -		}
> +		/* Report already exists; data was copied before taking the lock. */
> +		memcpy(&ptr->report_data, &entry->report_data,
> +		       sizeof(struct usb_hidg_report));
>  		kfree(entry);
>  	} else {
>  		/* Report does not exist in list - add it */

