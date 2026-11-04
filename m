Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810072;
	b=IHwWV5FaG/WZHLWQ6RjENe4LVZGGnA0rW0S6+Lrdd83VYe8kTq3lihbGGvclUrKZ/EjL
	 h2G4BtmyoppmZXZv3zFPFTqRne347PHerS3qiHaAPIQ9I3h5MfMocwuoGj3UyjtDSnzup
	 NR/1jcAaVPchcuC9COxIlUlGrTvxC5xOAYb7MfFLZ5QHXA+FZ+0dRrC8/D8rrH/w2KJkM
	 rt8meNW0oZmAd+i9/kiYtXSFps2vEDviWzC3P//tB8Rvy/u0J1IWNH2DnoZ/wxipyUCJM
	 H26BUFoBiUqkG1lJFEDA1s3F/4V0eKyu4uZMd6tZlDfbUnV0TcI9TCoUROfSbdnZLKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=2luSXqGaMFEbJZIPO87Oq4zjPba7p3fbczRKY5RBYMQ=;
	b=GRVnE36gfM93WIvi3S5nU7Sl1QEaW7TU5zqmpJHLn78v/fh37Vkw5E4VFkTTzuplS0h4
	 TXyiQuKdw+mM+tPnNMhqXRx6CShU2ONzYDduRS5Q6254E6K/jQC4SsbKL8rzuX8vWC9Gh
	 qj4eD6iYiSv1+S4ZmLmir+hD0xfcWv4cKgcxTsN/aLr1NpqQOZpJv8nvwk6T9n8WPVTDG
	 qCJRV7Ek6ZBA+J7qv/Ha2wNffT02U/eOe5Du8tvQnLK4Z0KVG2DU6PF+qKfBi8UFxAc/b
	 i3aLgameUY21351kVbTDdHdK4povfYKHPpUMwwMAGONOqkHuMjppJnYAijZ0CiD3bQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zfu3hJPI;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B1606A334
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F9B1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zfu3hJPI
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e5378b281aso5766075ad.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793810071; x=1794414871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2luSXqGaMFEbJZIPO87Oq4zjPba7p3fbczRKY5RBYMQ=;
        b=zfu3hJPInROrcGwhTCH4qAf8TYKQqLCXkZvvY4+z4EWjyCDUcwqCdPpochYFHDjpbW
         rL8kj4qnZkP6J7DEBPOKo5Xsfhmbc3b/jLjOa1M72H3OmSNW8FYsJoyfLV3JzGUoHHyp
         7MmHcI48gitd2mYbrJejrZ3YRQ8GVDlh+P9eTT6AvExiNWRQBCmZNzDRBE7R/8bWBDGb
         y8cm9lv135IMRicWDsh37m74vVwP4IYsrS66K6qs2JcQiLPrvH1cSwAjbeL2biW4aCnq
         m62l4NVhwIC7e8U2K870Va5T6y54iF5uYPWRSR74+UbSLQSkH/5SDObJoHn8+GGEusy/
         x6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810071; x=1794414871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2luSXqGaMFEbJZIPO87Oq4zjPba7p3fbczRKY5RBYMQ=;
        b=lDUTD3C2us8mwOUWc6UVmkGQCA0+M5rc7nz7hSkMmqIV9V00WPWx2fvsnwvL/u8ONF
         R5kuEu1RxYrwH8HTxAwLKImvedFT/69whiQxOo1pqsCGbSS2AiIV12gOIX+QvyCvP5D0
         lOWhyY2O7JLkLpKJBoLmP0/WCJTs2AyvK9O/IucMYvWjzh8eEPEk5dmRFdAqgMo3/JbK
         lu5xqsya8YgMLlS93sVWOWJY+80YyHBiFV64sDSfrhSQxPrAY/pgRXDOahWRvNtE3Wtq
         keYrl2z3vgxjzV6qkuD3Ee7O6Ck+gU+qmOqhbKTgbyLp7IbEwm9L8uDOXSe0lHD/KhK2
         h7yA==
X-Forwarded-Encrypted: i=1; AKwUvBxzcke7dW8Wq8PV6GFyshKT19bcwHeVfCM2eIG3o4JsD9UFRaLTc7OAGp2tO7tQxGIWfbRD/E8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/d961WrrOJFZbQ73ry1BhSrmLVaiBQ6GjQ7kYVtxXgkw2FhLP1
	eZ/DXHTFNx5p3yomEqXSuTvzgxA3Mxodh9azxiyPMhJF91+nM1JtyMjjyOMKgehZqkE=
X-Gm-Gg: AYBFou1IoT6Oav6RqoiravBQokZFdXjLTQCubv8onamk8F4JR/JiVkBNdlMFr1C9GS/
	rQRetIDqTtdl3XjwanosWJOhLLB1sUh8j1Tkmk0w538v1MECW8RezUjW2bYVVQxXIGcv1UBjvOx
	GMfXJMnsMGd1L3L3VN111HSWVaayz9q+M0fyrhYfuHxH6IWrBFCjoz+2R+SJeFATrL3rYKwS90V
	qcEZuhup5g5/UrJw+FWk38Uj3I0rL37BA8ifk0ECKk1ZjyIx79eEndDAhMKY589n0o4epK0RBoE
	7lkq3SnvFrmYccesxbxvLalLmPCkjwuN/3IjxG6I5F0F7tgz/WKU4kO99+XzHtUXun3r8JeWD/Y
	AIpBoUdnfAALzEDB4i6NhgoE7Wb4oYnVdcOl/XrxyuU0DnsivTCv0L6anLJjq7OSOrWtt0FDCgT
	6TGS4Hy0C4UZqBtT8N01TtiIbUhU74YNahuu20mESzn8wKuyTkpgyycZhuc4JeMadAds+nLSBuw
	8XKo0lMj8jHnO2RgBtRzP9mcOQa6TN2sgEROsViEz3uZXMhv2Iixv9W0dE1qy2Nd9U8qkn7u5Dq
	Jrzs0czii4dtp93tfJbyqEHinYzPZ7g=
X-Received: by 2002:a17:903:1b25:b0:2e9:6972:54d2 with SMTP id d9443c01a7336-2eb3649bc17mr150573595ad.12.1793810070851;
        Wed, 04 Nov 2026 08:34:30 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:bbc3:cdac:2cd9:7fc5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed088a624esm10252335ad.0.2026.11.04.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:34:30 -0800 (PST)
Date: Wed, 4 Nov 2026 10:34:28 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: core: Do not put the device when
 device_add() fails
Message-ID: <autelF5ReC1j7C5Y@p14s>
References: <20261029130037.5505-1-izaiahsun@gmail.com>
 <auoLrJPq9eRAbeQa@p14s>
 <CACdDPuwmyAjC3kje+nYJ3yz7RePg8JzXsKGkzx-Ksxb=-_CZ8A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACdDPuwmyAjC3kje+nYJ3yz7RePg8JzXsKGkzx-Ksxb=-_CZ8A@mail.gmail.com>

On Wed, Nov 04, 2026 at 01:47:41AM +0800, Yuqiang Sun wrote:
> > Unfortunately I do not have the time to read through and digest what Claude has
> > generated in the changelog.
> 
> Sorry for the long content.
> There is a human-written summary about the bug.
> 
> > The documentation for device_add() is clear, and looking at the implementation
> > of device_add(), I understand why put_device() needs to be called here.
> 
> I agree that as documented in device_add, the put_device must be called
> if it fails.
> 
> But in st_slim_rproc_alloc() (drivers/remoteproc/st_slim_rproc.c), when
> rproc_add() returns the error, the driver calls rproc_free() at its err
> label, which is put_device(&rproc->dev). With the put_device() in
> rproc_add(), that reference is dropped twice, and the driver uses the
> rproc after it is freed.
> 
> The same happens in every other caller: xlnx_r5_remoteproc calls
> rproc_free() too, and the other 23 use devm_rproc_alloc(), whose
> devm_rproc_free() does it.
>

This is the kind of information that is useful to find in a changelog.

> That is why I did not change device_add() or one caller, but
> rproc_add().
>

I agree with your assessment.  The problem is that both success and error path
end up calling rproc_free().  I also agree with your (or the AI's) fix, but add
a comment in the failure path of device_add() that explicitly mention that
put_device() will be called in rproc_free() to avoid reducing the reference
count twice.

And please stop using AI to generate your changelog.
 
> If necessary, I can send out the full document and PoC on
> how to trigger the KASAN.
> 
> Thanks,
> Yuqiang
> 
> Mathieu Poirier <mathieu.poirier@linaro.org> 于2026年11月4日周三 00:28写道：
> >
> > On Thu, Oct 29, 2026 at 09:00:37PM +0800, Yuqiang Sun wrote:
> > > When device_add() fails, rproc_add() calls put_device() and then
> > > removes the character device.  The reference it drops is the one
> > > rproc_alloc() took with device_initialize(), which belongs to the
> > > caller: after a failed rproc_add(), every driver frees the rproc,
> > > either with rproc_free() or through devm_rproc_alloc(), and both drop
> > > that reference again.
> > >
> > > So the rproc is freed inside rproc_add(): by the put_device() itself,
> > > or, with CONFIG_REMOTEPROC_CDEV, by the cdev_del() that follows, when
> > > the character device drops its reference on the parent device.  The
> > > caller then uses the freed rproc and puts it a second time.
> > >
> > > With one allocation failure injected into device_add() (failslab
> > > restricted to rproc_add) while st_fdma probes, KASAN reports:
> > >
> > >   BUG: KASAN: slab-use-after-free in slim_clk_disable+0x38/0xf4 [st_slim_rproc]
> > >   Read of size 8 by task insmod/69
> > >   Call trace:
> > >    slim_clk_disable
> > >    st_slim_rproc_alloc
> > >    st_fdma_probe
> > >   Freed by task 69:
> > >    kfree
> > >    rproc_type_release
> > >    device_release
> > >    kobject_put
> > >    cdev_default_release
> > >    kobject_put
> > >    cdev_del
> > >    rproc_char_device_remove
> > >    rproc_add
> > >    st_slim_rproc_alloc
> > >
> > > followed by use-after-free reports in kobject_put() and
> > > refcount_warn_saturate() from the rproc_free() in
> > > st_slim_rproc_alloc().
> > >
> > > Remove the put_device(): the caller's rproc_free() drops the reference
> > > and releases the rproc, as it does for the other failures in
> > > rproc_add().
> > >
> > > The problem was found with kbound, a static analysis prototype that
> > > checks whether callers rely on an object after a callee returns a value
> > > for which the callee may have released it, on v7.2.12; it is present
> > > in rproc-next.
> > >
> > > Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
> > > warnings.  Run-tested on QEMU's arm64 virt machine (TCG) with KASAN,
> > > using a device tree node for an ST FDMA with a SLIM core, so that
> > > st_fdma_probe() reaches rproc_add() without the hardware (no clocks,
> > > MMIO windows only mapped), and failing each allocation in rproc_add()
> > > in turn with failslab: before this patch every failure in device_add()
> > > (9 of 9) gives the reports above; with it nothing is reported, and the
> > > rproc is released once, by rproc_free().  Not tested on remoteproc
> > > hardware.
> > >
> > > Fixes: 7dbdb8bd7c02 ("remoteproc: core: Cleanup device in case of failure")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: Claude:claude-opus-5-5 kbound
> > > Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index b88bf179507d..e4f44a3c8b4d 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -2309,10 +2309,8 @@ int rproc_add(struct rproc *rproc)
> > >               return ret;
> > >
> > >       ret = device_add(dev);
> > > -     if (ret < 0) {
> > > -             put_device(dev);
> >
> > The documentation for device_add() is clear, and looking at the implementation
> > of device_add(), I understand why put_device() needs to be called here.
> >
> > Unfortunately I do not have the time to read through and digest what Claude has
> > generated in the changelog.
> >
> > Thanks,
> > Mathieu
> >
> >
> > > +     if (ret < 0)
> > >               goto rproc_remove_cdev;
> > > -     }
> > >
> > >       dev_info(dev, "%s is available\n", rproc->name);
> > >
> > >
> > > base-commit: 82d0bbd67c42a44f0e18b0b7b0da0f3ace0c9527
> > > --
> > > 2.53.0
> > >
