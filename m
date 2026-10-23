Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792783899;
	b=nGcYJF4ZJv9w/d56W8AZsQxzG7FRCZSAivcGxV2FqPiqw8BmEdEEakss/Jp+aWEZeHJN
	 Bfn5XOByoTlqutaHKr6NCyzgHg2l0cHbIkX6kQeS380ULNia4+WoamP0tU/VFeLAhJ0ZI
	 gvLbhimscqvylo0LcZJwenwA3rGDn7QeBO5rDqMR9OodgmycgagUDdBpWXP6ckdeUFayS
	 fRTqKFEQN5JveMhG5vM1rJPGNd8PY+zljfPqAlIStswCBqxHE4eEaiu9TzquDZAwWsNDS
	 mOpBK5OLjyJeS7e4Fd+c6y+bqqpoZawAb01VZZ+p0yEdXdnO8KOBJ73AfSntRxZs1JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ssiACCz8iQhHfav075HToQsQkWyrJS6OaxDAqF1b0sE=;
	b=SGBUI8ZvHU/CkOX5WHKC+kIxcbkFmiUV+mn8yxgL6RXH6uUZwpreWDeIXyjqVH50jxmv
	 /8LKJDuV/eMw6DLoxDSPKJxj4SUgfIyRA/MXjzTAVNgIqgbJYXXbBLg6eC1xsa85muyGl
	 63+iyXkLtDonYoreNfHwjwEVDBoEhwp7np7XVluhInIY4tthGzTOg7oGlMX0onnqTSe+P
	 PzhT5nHv6Mv2LLuamZ78/jBpY5D4v/JHl8YOgtvG8flpgz5gbWL08Wt+woswrBH41THoj
	 +uM8vHIz8M2cafvh9HSbgXccTRFBJlO+25HLfOMnUrbih64YQUBWTXKQjLLoLXXXlJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fM4pp+17;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2A606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF2A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fM4pp+17
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab35e31f6dso19860831fa.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792783897; cv=none;
        d=google.com; s=arc-20260327;
        b=G+Ex2GtkCsefPCwtH69jJt3bcd/jR1wRUbvHbX21lYO0u9eAywHwg5Fn1Xaju7ixr9
         /1bD/oa02TqhOZppA87h8alTIAuSQqEaz9ETm21m/nO3vb52l1jzp/A4Yd4hwCg5TnBo
         h3GkCjywUpdPIWgHwMY4w3ojW6peTWmyFSyez/Qzg4kSvjKsKNTzH2nl1FdtjwRAgVJN
         0PfBpXSsJ7ki3R0kuMR99nYymyLznmgJbUu8YCuB70Svucl/KhVvzFixtm3ezrEYBkUy
         Ljm/kboGmbOg7otyu6fXFk5OJOmY8JtDAfotz5uJZbWKul9mHSBVDRSynmnE9qtuBgGA
         Sm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ssiACCz8iQhHfav075HToQsQkWyrJS6OaxDAqF1b0sE=;
        fh=b9iKsdonHL8Y6WddW0t/j42Ne9/WOnJRr/dMt5655Es=;
        b=Ddv+BSS4sYjoMJ45soXTnZtc5bo4Ll9xNzh3vTZUyNg6y2TAOlCjto1pF+cGNxUeUw
         iNiB8SADPcOr2JkoqcZ+aPe0i7otA76r8mCWcWGV3dsd9D7QQKLhrFDJABRZKb+7h7zi
         PQvcL2STxd7muP6yG1urHhIro0zNz4qhaG9C3XCth6VJ/iCL52zLylKqvFxjBVGa6CuT
         GRqEuTGw+ecbN+Z2VArr29/E14fuYCuzBTZ9h0/apLbkf2VbpiVTXhO9z4Ux0Idzqt5+
         SYODfWVKokOkhB5xq7vG+f+6BGJre/r27LTYjIyTIUbXBCZ6IR86J1UWwmadVzXKcrAz
         Hd5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792783897; x=1793388697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssiACCz8iQhHfav075HToQsQkWyrJS6OaxDAqF1b0sE=;
        b=fM4pp+17mA2W5prd1gKXs4asXj+KvPItU/RBUMEhZBpKcMtyDq5558E6+66GTgP1fG
         yPKZv9p894NBLrzFa+5RYs4AFfJXQb/o7xpkKp32dvCtr97FsbmkihOmGUCCLhtxuu1r
         GOGGXG96BmHYxArM9K4Fp//exMojM+ADNW4fYADcQBAlhhRKIiP/l9p7o5PkEyYXoz7m
         qHoycI7yEMC3U6Gxb1Tx/tM5ah1iu1duxm7tAK9BOKyejnzdQSUs7CjT1DAzuiaeHvMo
         R9tUcZKEYc8478yFiI0J5VyfsrV2pe3l7c8HGdX6rJqgo9USGvkieX6t5SEIUHqNk4Yl
         DTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783897; x=1793388697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssiACCz8iQhHfav075HToQsQkWyrJS6OaxDAqF1b0sE=;
        b=lXaM1iYlqyLY9csKX55/996DOHMy8ejoMuNYAlOGHbU6EeybxAM23mD9pHiHUaOQV8
         VKBkwsCD9mN2+UcVM99WrmjMlQTQnXR/Xd8ESVcm5hbbSYCV46VeTNUSrei62onN7MbW
         HEpmIFoEROqMxOMIrnKp49YtqQCbUZj70RkYYUnEukOgZTxy6d7U8HvGI4ozeVrtwRJT
         qqBU8S04+ckGtFadpToUEqXSEUrQzP4RxGIliVNnapG8qq4Yzk8sv+h+l7WMYDTlrIZY
         txBvkCNmhBY/aVLiJv0MhopEFYh/Cf0meoIViDRhNv8ju2wiPkOQwTYFu1tBHXgVrsCq
         1mVQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3eyad3iv0NIH3kjV0THjTs5XBi5pD8DsOY0JAJOV9MvWl40ib5vq7jC0XORcrYzcvCn4TanM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaVAUEhuwTnoaUt+tepdNR3y5C5wwpfu4D6lsX+bH2V6dC8aWX
	GGaJePXZV+Lr1sM077RxpBSZwh/vV3A6W53TDXywkZjFOBs2NCYFa215ipsjhgJY/7wlbqrqNkV
	xLGlkpeCoU6XTIRU5AGCi5PExYsN8SaQ=
X-Gm-Gg: AYBFou0Vkjm7DWW0hRMA/kIu13KjNnSbas0Nh+ROMz5tnL8n0YX0J23CtxqrUQBRLO3
	3VMI+z9EmsxC3V1K8Ts0iyqAfX53qIlRqHtyVyfYc12lQKeyKY7VOQp1VNB0AtwLO1lDPngCvTp
	dhA6qug5nSNFo+ghtGxYLX1W0WUQyANHodPPA84pq6PvxItHNmIWSs/7K5mYYzsgt+BZby9oeR/
	zFnd1/9h2u1I8sMOd3bQHqDSpKgHQZDK/7dna446oRPLiImLCyqdtwwlvXkbEOd+bfk1ht9Tha+
	phJEjQa/WcOGrUmFKSCuwOEesViNDHuNMxiqYMJp8JdBdVCrtSPGC2a6/wW3mhqOSmr01agSNeV
	5Vq+bRZGnAvR6I1ATCsFLTdQnU3DffTEUWk5FHamSI/NWx71wmJN/7z4+hSOhkRxVZSObOUxeA/
	ZY43v/c5Sq2+GKaQ==
X-Received: by 2002:a05:651c:31c2:b0:3ab:1dcd:934c with SMTP id
 38308e7fff4ca-3ac6fde7f59mr484421fa.1.1792783897356; Fri, 23 Oct 2026
 12:31:37 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023174015.54793-1-igorpetindev@gmail.com> <e16930d5-375d-4d61-9e37-94dc9a83ba64@rowland.harvard.edu>
In-Reply-To: <e16930d5-375d-4d61-9e37-94dc9a83ba64@rowland.harvard.edu>
From: IgorpetinDev <igorpetindev@gmail.com>
Date: Fri, 23 Oct 2026 22:31:27 +0300
X-Gm-Features: AclHuK-4Gcg0KL1Ua0F-idU5uezV--PxQTbQwTM_ejfi3csX_24NMPyMrJpzCac
Message-ID: <CAG21Q80vg9LdTRmFMC4aq7j=uEPWpEFNr3+1MLLUw_UU_cjd1Q@mail.gmail.com>
Subject: Re: [PATCH] usb: core: hcd: cancel giveback work synchronously on stop
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

Thanks for looking at the patch.

I think the bot caused some confusion by talking about stranded URBs.
There are actually no pending URBs left on the list at all. The driver
properly killed all of them.
The issue is a race inside usb_giveback_urb_bh itself. The function
usb_kill_urb() unblocks as soon as __usb_hcd_giveback_urb() drops
use_count and wakes the waitqueue. The caller immediately wakes up,
finishes removal, and frees struct usb_hcd via usb_put_hcd().

Meanwhile, the worker thread on the other CPU is still running the
tail of usb_giveback_urb_bh(). Right after __usb_hcd_giveback_urb()
returns, it tries to access bh->completing_ep, bh->lock, and
bh->running. Because bh is embedded directly inside struct usb_hcd,
this access hits already freed memory.
So all URBs are already completed and bh->head is empty, but the
teardown path still needs to wait for the worker thread to fully exit
before the HCD structure gets freed.
Would calling flush_work() on both BH work items be the better way to
synchronize this without the concern raised by the bot?

Thanks,
Igor

On Fri, Oct 23, 2026 at 10:15=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, Oct 23, 2026 at 08:40:15PM +0300, Igor Putko wrote:
> > When an HCD is stopped/removed (either during module unload, driver
> > unbind, or an error path in probe), pending URBs are unlinked and
> > completed. However, for root hubs or HCDs with giveback done in BH
> > context, the work function usb_giveback_urb_bh() may still be executing
> > on another CPU after __usb_hcd_giveback_urb() finishes.
> >
> > Since the caller may immediately free the struct usb_hcd via usb_put_hc=
d()
> > after usb_stop_hcd() or usb_remove_hcd(), the running worker accesses
> > the embedded giveback_urb_bh structure after it has been freed,
> > triggering a slab-use-after-free write detected by KASAN.
> >
> > Ensure all giveback work is fully flushed and cancelled in usb_stop_hcd=
()
> > by calling cancel_work_sync() on both high and low priority BHs.
>
> Sashiko's criticism has a point.  If there are any URBs still pending on
> either of the BH lists when usb_stop_hcd() returns, something is already
> badly wrong -- that's never supposed to happen.  Whatever it is, it
> needs to be fixed in the driver that submitted the pending URB, not here
> in usb_stop_hcd().
>
> Alan Stern
