Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0702E7393
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298588; cv=none; b=IFX0lmC3wIMsRGqDsk6BipUh7cCOE8uvLI56ulCAsgjQDRLpF+bVMwgD6w97/HKQqZtYbXKhNHVYGLfG4jE3Owcw0PTFqjY1FuzcA6GUOt7EKoxgDvBot1wWxsdLN6L0moFEnLEasB53NSKx0q8J7aCLZCVjnEhKvf/4omXqjMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298588; c=relaxed/simple;
	bh=OAskSojY9S9GzYSrZYLXDAReXtrR+BnRjCU+yWxpozY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlKxZyO1nwXkpUl2rqzaWvYF/y9jf60DHUEr/qqoiFvY4t1JH/hmqGNLAhDOOAKfVMaZO8ThiGHH6pIPEbQg7iPcfNkCkXtEl2t3MRX/IT6Vw6kdqIwMess+EFGSHKPz1QHOqk0ZXoowYMfxFwyqnlsSewnc8117hpPcujJfy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8ZOZqM8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8ZOZqM8"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69532288224so1709163a12.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782298585; x=1782903385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVpUsPMcOUp7aStO4/HxyiJ7/oBFz2LYmxiU2GOTN6E=;
        b=o8ZOZqM8yDNUIzsT1xgrKYsFpdCEV3AEUZWzxfMBIYg7cQun8KkVFzFLza5IVsXUo4
         a1/6ArEMuiDf+rCm5yKbQ/kXWx6ZlNDd9ajtEItwOs4nj6whYfnPj1EVRzwbbL8b8CoC
         YsEI3JDhqPyFPImO8QU1TqEahjU5bu8QB1Cfg069iiU9TbbBkQLzHt78n8Qxp96YFN0F
         ZNyD8uNRuVERP73BKnCCUpuPf4DIEnyh2pcTDX7agTbx72B/fR9qy6Uy3AfbdWLPeXTE
         X5LwOFKPCXM5VYEKkrFY1sEGNNgYV1LQ66KHR+ncLzlPzYkboKa3dsz+WabLEZeDTj9C
         lmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782298585; x=1782903385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVpUsPMcOUp7aStO4/HxyiJ7/oBFz2LYmxiU2GOTN6E=;
        b=ifsaMFxA4bLo6V44E4bVNiHCZF6H/hWNiosNAYKtSpLPi1+XdeMGXALIP9cjZdRxts
         +4NWjjCvcqk2DKG8kZFPXSt1PCgyBeotULOWJzIC/vyzMGzqVsQa8hNObVjfXvSQ0uMZ
         RjW0WRYp6HIwDuqBXcPkCZmrBWBWI7S7eZ2f5Sxn8nPXAPM7h3yil8JN+O4KGPe0Hs/1
         HbwoYcmZV/C91WaOCEPL5QsI0O84m/yogiSkLO9njb3THRty3j2PVLBgStMQxwjgZGKZ
         e2uEpdlXeTd6evgtAGwaTl+jRa8bQrYLyZeXs4bj8rLJVy+SDA35ZNCHdr7oPFT4rYx9
         pMnw==
X-Forwarded-Encrypted: i=1; AHgh+RpNISTAaEjT+byYiZYVsroksQGHLE/01xp9Jvptl+GuZoYOwEemNBvVI+U8g7SbyC7pQ4UqYYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItaZy0HH/lXGuLsToz8Wa+rP7EykmTrFKRueI6ZazmmIVLW/Y
	lBkUWCjGXa514EmYy99Cg6pg8/xiEsLjzd81btyuvGaVDek4NKapbkWr
X-Gm-Gg: AfdE7cn2eqsusTO7UkB4orf91Bod4Icf3AGq+bLDjuv4AXpnL4zqNEYuFL/4+jTgicY
	d5zLDz13zn1HeSMSjUO2WdLe11tPN15tW+WnBHfyir1ieO7g9ZkGh45hrhseF6lF/+wkijC3Pbq
	Br4vlrTTyvqdJign1QvLgYRbg51JTlIziGGJ/lk3JRi99UYw1ifgvTLKToMdzthKZSy50hbCIeL
	tC73ATESOCk8h2UZd3BjHZ++HosdNxJLTHOg5OS4bQn+Rqq18cai2ewWs0MgIwP8oY1GzCGZOWG
	Yw5bnPGeZEroYv6YcO93H2G64Iy6hJd138j1hGEZLXYYfOsGkgQYMPkz6V84tIgR+yDdq6dTN1F
	GwNGDVz8FaI/ykTz78jWFT66IMXqyLWVEQBvIUXCzABNCZU6ofK/GBS2fFxgeUCyb5YvywcOGIu
	MC0F3IUkb/
X-Received: by 2002:a05:6402:3218:b0:697:b10a:35ce with SMTP id 4fb4d7f45d1cf-697dba620e2mr3554762a12.1.1782298584851;
        Wed, 24 Jun 2026 03:56:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac5df0sm1005336a12.1.2026.06.24.03.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:56:24 -0700 (PDT)
Date: Wed, 24 Jun 2026 13:56:20 +0300
From: Dan Carpenter <error27@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yangyingliang@huawei.com,
	mst@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: unregister HCI device on open
 failure
Message-ID: <aju31PkIMuvyIcCR@stanley.mountain>
References: <20260624084333.2885144-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624084333.2885144-1-haoxiang_li2024@163.com>

On Wed, Jun 24, 2026 at 04:43:33PM +0800, Haoxiang Li wrote:
> virtbt_probe() registers the HCI device before calling
> virtbt_open_vdev(). If opening the virtio Bluetooth
> device fails, the error path frees the HCI device without
> unregistering it.
> 
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/bluetooth/virtio_bt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 140ab55c9fc5..bf6827431bb8 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -397,6 +397,7 @@ static int virtbt_probe(struct virtio_device *vdev)
>  	return 0;
>  
>  open_failed:
> +	hci_unregister_dev(hdev);
>  	hci_free_dev(hdev);
>  failed:
>  	vdev->config->del_vqs(vdev);

I have written a blog about how to write error handling.
https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

Originally this code using One Err style error handling where every
error path just did "goto fail".  It's also using ComeFrom label names
which don't say what the goto does only where the goto is...  Ideally if
hci_register_dev() failed it would use the unwind ladder to clean up it
instead calls hci_free_dev() and then goto fail.

The beauty of writing a normal kernel style unwind ladder is that it
writes the cleanup function automatically...  Let's look at the cleanup
function here.

   406  static void virtbt_remove(struct virtio_device *vdev)
   407  {
   408          struct virtio_bluetooth *vbt = vdev->priv;
   409          struct hci_dev *hdev = vbt->hdev;
   410  
   411          hci_unregister_dev(hdev);
   412          virtio_reset_device(vdev);
   413          virtbt_close_vdev(vbt);

I'm really uncomfortable with having the hci_unregister_dev()
before the close.  Potential use after free?

   414  
   415          hci_free_dev(hdev);
   416          vbt->hdev = NULL;
   417  
   418          vdev->config->del_vqs(vdev);
   419          kfree(vbt);

The probe function should free "vbt" but it doesn't so that's
another leak.

   420  }

So this fix is fine but it's also only a partial fix.

regards,
dan carpenter


