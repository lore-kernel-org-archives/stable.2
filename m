Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97ED476CDC
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454678; cv=none; b=rsg/VyZWKD2g5ammItHmGGdXWkYKgz9zSzXsCEjOZEC1P1uIlDF4qv6dLD0DO0ecoK9wR06KsxSDF0vPm0FUW3iR7WXGVuG/EwcQ8wrZVk4Vy/tD6Z5oLO43LbiXG/c7HaOLvvR0FXi9ucgnlVjoym2J2/etaWyE0uQ47G0h49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454678; c=relaxed/simple;
	bh=mfEoOh7OlkRlu5acKyPr/YxBMOBzAf91Z7JV8VqlT8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwf4srn5qk4Qr9BW/VhEgewOBT4yiv5TKnd5bSMJyKRq6LSHKpRUDqC23igFq6aINWnZd9LpjxatcJqXCn5qtKQclnu518ZBgUq6vQFZYAM6vlzcSiE5NWkGxv+08cUUyUxx+aozLsuenCkmLZTNSlOj4u/pDXcfhLmRO0u5iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTLwXRto; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=izIxoMrI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTLwXRto";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="izIxoMrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785454675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C45f6c51+m57hpeZ9zwBgTF6eOfqSwMmzmRci27jKDo=;
	b=dTLwXRtogUZikx/NS/gkP2n2lu0rcs7lKc4W2CxW58yzTh0AH0YcrZPGjHnYIVTCFFXz1a
	5ASR6rz4XjkJgDc5l7mHr9w/LrtN6sUlx+9an/2bhCX3tPK/RF0TDO4BnjLLCXG044z8dR
	GhlTn2upoPiCzVnyQr3a54NbVhYhQQk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-5kdDwXOTOdiUBphKgBIxHQ-1; Thu, 30 Jul 2026 19:37:53 -0400
X-MC-Unique: 5kdDwXOTOdiUBphKgBIxHQ-1
X-Mimecast-MFC-AGG-ID: 5kdDwXOTOdiUBphKgBIxHQ_1785454673
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f5a972b0eso178403f8f.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785454672; x=1786059472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C45f6c51+m57hpeZ9zwBgTF6eOfqSwMmzmRci27jKDo=;
        b=izIxoMrI1AP7x3jEwW8qVU/Kr0a9kWrGNpdJwYfAGtitCOcvtoCw5V1ngrY/OI+qRz
         oW7AjxKhSARgTk3WBwtAjXu0N7j4BRtw6hTmtkBWBAX2KQwP0QovttLlQrNC9xR3KZfy
         W8BlG7JZQyIUTJ14sgVgoq+7JRa6GZ78zT6Q4EZQpvdNbv6YSgnFs9U/7oASamezVvlF
         hVizemMJLgRNl8YbuSoeMTx/CgHYL8PuQcK5xn1QtVcxUSGQBZvDjx7xW12zt84Abr7J
         m1cbu044dzvmbZsaAOVwbXVWE+tuGbGgU3C/dkTYfNtPwIUUKLNvInewJW0c0CCoHhDv
         km+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454672; x=1786059472;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C45f6c51+m57hpeZ9zwBgTF6eOfqSwMmzmRci27jKDo=;
        b=bJdRi2sEvtvCSUpeLKdcwudVCi8FYdJwimvjbO7ejTqpEmDf7IY2wR66wZ1qAbZPCg
         pFaGGsnhJt8Aqxr8odrjhbdXZp95CqSumsxzROwBtgLihTGyc9yy9NGzjQelYmMh/Shi
         MeOHN7Nkt1+2OdFfSJPnbXovXloJ5W7xpEjT/06DARHUEgeJsbHL3M1GM9NhFVVIznY0
         j4PwpeauUQHN0QFcSgI5msdGA0hxi/DCb3OZa8pG4Sagl+HS19sKfkDMwQb+P6nAyk3N
         cYFra9AAQTOJ/r/Zl2fEaaH7y7Apys/XZ3BCFn1l/4QV5RZsQSpqZIbou5RevfALey7l
         BcbA==
X-Forwarded-Encrypted: i=1; AHgh+RpUhXCl4nP/9M+Rz7hZReR8DlJXwuBeNT/G16hKopLwvGYUqj+k5xnPg24vptWy7JPU91pyt/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjV8UgHB9/i7OW/0jdhQU4kSQ7MK0JieXiimF8n5X6EcZjrTN
	E6kA8vnqAz8/99LRXlkUaDGQz0a6IieXpQX/g/kWhjyXW6k0rS6qETVz9e2Ex2g535SL8N6zx1q
	hC8LaT4e2wY1W6jdSapn2OzwC+T+DObCOWL0TZ4oO1TvoKQcxX+SV+pF9YQ==
X-Gm-Gg: AR+sD11Se3U1iKFBA6TyDFhaqFQkfUil6iiY1yWqKVJQW7Yu1oNzqVrOim3cO6ezvGK
	iPW7/StkZ3lam9SZiUp6NYcBHoXhs6i3k/K+sSmb/dWCXKdYvDq30L1A3+8ADYvvm84pVpuYQcm
	RNz9povzzEN7HJP6UPjuft+51tB3xwc+AhPFCy98JM2B6RmghEpjF9k9SO0lkCiV1j6f+ksz4m5
	/Y1jfaoB4IM/eaVGrMuy29S0HIgR5c6MWDMI52KbHWcSnfgEnUaBZuz5AxP/CcMF0SZhF9kF7NN
	8h+zY66piC8AUrNZPMqzfBUmjsEjxww4sqIKnoqz5E7ggDeCDHn4cGfyTPWVZEtx1xez2CJlX9y
	7AMyPaKsnbVAP21dMS95615M=
X-Received: by 2002:a05:6000:40cd:b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-47fc80cc992mr7021621f8f.17.1785454672623;
        Thu, 30 Jul 2026 16:37:52 -0700 (PDT)
X-Received: by 2002:a05:6000:40cd:b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-47fc80cc992mr7021592f8f.17.1785454672234;
        Thu, 30 Jul 2026 16:37:52 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc892cc5fsm8222264f8f.24.2026.07.30.16.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:37:50 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:37:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, yangyingliang@huawei.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <20260730193717-mutt-send-email-mst@kernel.org>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
 <ak-T4SMxr4rw10jP@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-T4SMxr4rw10jP@stanley.mountain>

On Thu, Jul 09, 2026 at 03:28:17PM +0300, Dan Carpenter wrote:
> On Thu, Jul 09, 2026 at 07:47:45PM +0800, Haoxiang Li wrote:
> > virtbt_probe() allocates vbt before setting up the virtqueues, but some
> > failure paths return without freeing it.
> > 
> > The probe path also registers the HCI device before the virtio transport
> > is opened. Since hci_register_dev() makes the HCI device visible and queues
> > power_on work, move it after virtio_device_ready() and virtbt_open_vdev()
> > so the transport is ready before the HCI core can use it.
> > 
> > On failures after DRIVER_OK, reset and close the virtio device before
> > deleting the virtqueues and freeing vbt. This also cancels pending rx work
> > before vbt is freed.
> > 
> > Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> > Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> > Changes in v2:
> >  - Rework virtbt_probe() error paths into an unwind ladder.
> >  - Free vbt on probe failures.
> >  - Reset the virtio device and unregister the HCI device before freeing it
> >    when virtbt_open_vdev() fails.
> >  - Close the virtio device before unregistering the HCI device in remove().
> > 
> >    Thanks Dan for the suggestions. The blog is very helpful.
> > 
> > Changes in v3:
> >  - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.
> > 
> > Changes in v4:
> >  - Move hci_register_dev() after virtio_device_ready() and virtbt_open_vdev().
> >  - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!
> 
> These are Sashiko warnings.  To be honest, I would feel really
> uncomfortable blindly applying them without testing.

sashiko is right adding bufffers before driver ok is a spec violation.

>  If someone
> can test, then great.  Otherwise, I would probably apply v3.  The
> stuff that Sashiko complained about was all pre-existing issues
> even though for the last one it said it wasn't but it was.
> 
> regards,
> dan carpenter

