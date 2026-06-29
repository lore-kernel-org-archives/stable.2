Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA53254B3
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741425; cv=pass; b=GPSm/bmHYSGKbEraYb2ei5rGhepBiJHZD0vPoV2D3KXvtIHpWoQjaAjxhgX+M0dPT2okY8m1ixqV3TbGWOGHh8n9cmAM7140Du1AIVTu5BR2AJXvzxJcUgzXTpeI4VKbC8d92HnXgyHnFyaEDgjjb5vpTnmY2n8n3ao8XbZgbGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741425; c=relaxed/simple;
	bh=dKZ/kI3igm+Uf0v6Mfx5oJ0dXQBWLZQZ22xBHXjULZE=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9v25PmR15sWzCWvli//B6bNCJuiEbMr+5mzbuQKR4zWtIosx2SfkBH3bX8+E63zOnbTV5ZfN6YsohGcaK5DTnmclPO/Dp2S2jAOS7ZJ9c4bCwgDOV7zyEBGbF3flhFLdatAj6r1cUeEsRuOtAl6fkO1G+tOXwKWRR3QccKoDaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGmfbFuz; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGmfbFuz"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80dc4a68e4aso11338337b3.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 06:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741421; cv=none;
        d=google.com; s=arc-20260327;
        b=ft+1sp5Nh+lLUWntbvo0QS9oQwE9ozM8JLzgdsmcEVupATHGFYZZEDfnpVup9rrzuh
         E8TdGEQV7MSfb+420xPitoRw+PYuutH/HFTFQqjFsHUQdT6XQJvq/GZJ8WPR8aDCLWo8
         a1hGnoWWqKCKnromFd9vFFLCeD70QTSZ4YkfzBnlR9DiGTUQuZSYB20AZ9Obq6rYYfJG
         to+UDXm79vNTwN3Sab7kZIEzSfPuQmKEiUT1NVtMm5w0PiWJg3QBEyTzMky4ci/1gG4I
         TKau/KkMKCKIQb6ed7Tdr4ZpkyJaB38pKVDhmXvD0WWg6HJtpOIsgee1zPYUXn1mcerC
         9HtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=dKZ/kI3igm+Uf0v6Mfx5oJ0dXQBWLZQZ22xBHXjULZE=;
        fh=dhLHnaQ6D7ltDxITbVBZYQ13s/6eIVQPRK2wKbgI7Gk=;
        b=qpAQeBIiqNhGii1FUkwQ/CPrLnEW0lfUcY17zBnF90COuWfDGnXKlU9Xuv7KMkwvds
         WY+VE+SJsUC0CYfRqigyQh3JhnQZvWSeYUGsGJTy1EZIjyVeNWEtnnn/C7+SnbYqAcrE
         XO4Bgco+0zthuiUBc1/i3JSS1YbeDR8gfdci93gtENbTxFqpwXyxD6wXxGh7Lk8p60/Z
         T9WTOeB52Rk8qzH73wOPycNqhXh6arci2JyD4MYNyH2J9peA0rhO+ylHX7Tkr3zn3DY/
         POvT8wcg+Wrj0TvrcUrs/E4MJFgUoc8dxWqnB9qeskKVcDU1BINqdySzO0XbKhyY/U7r
         ipUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782741421; x=1783346221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dKZ/kI3igm+Uf0v6Mfx5oJ0dXQBWLZQZ22xBHXjULZE=;
        b=RGmfbFuzXvf+0pI50i7A1LVIEwtbHPW4Wqx5kMZ9//669OjPsbOPDSJCIgArU6XT3N
         KyUa8rjxJDctt3B4k3YLi2kWDZPamnTBbekw+EeHmHwaEgv/H7JMqrsA7gZQijKxsbv3
         NJ/Y1wEUuuTFDdiPOd+cWwkwidAFr0l5RU5ekUiinSUKUsbxXCPcTvH6OxYS1YWPzlZe
         2ZZf7kjQQSshkmldWh6WWBi49DTgjg89XrCILK+rJIHMNfuRpPJjUBw6NhBkAxUbLnXt
         JtfY1z2DxeiOMvOntmF7qrAV60AJxbeIBnYt33iT+MJWOABSnNgHHKWgXsM5cuprkK/8
         Tb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741421; x=1783346221;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKZ/kI3igm+Uf0v6Mfx5oJ0dXQBWLZQZ22xBHXjULZE=;
        b=lECyQ8IF9CGRj7yvn5k9pg7pEbMgONQZH4cgzL9hmc26qF0jRO76pLCk3AKpxGBuzS
         s6xgDIQYyUStG0ow99aYj9QscCBEJfgfQXXyq3ruqfjsk7AlGhEltayMa3Yog2ezv9bY
         S2Kt7yrhLb2q7D+Fnn3vrjN1WHxC5VoePGkkR8s3d7GhqEpgtYlw7H7KbiUYJyl7X8Ao
         L9MLR9nUOg2EshVV213cVY6ByOgZybMcZvO+1Ni8zEmtIaXhqag70mBj9S/HGEmn8vD6
         AuOg5R3EKp1/ca84v62BSOzxI8seLR3v1zZ+AgD0Vm65NmmF8ZVswvAdjno+n0/GkVYC
         YzCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rro4Byp75LkBVPMSOdrdIvPtmQpWfEqHgpF23NDdbScwlfL5Q4ehFMGGdM/HclxCUNxIkSByhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pSFumBtn7XasvfMOt67sUGNgurcswbsD7mZuCCejTES4pqkt
	ym4a0lY/Tdt8nz3Nfc4K1azb+AgzjRDxi2XVwPAVZ4cnMww0xTtcAOONvV3Ac0y4/JyvOq5Y1lT
	DEN45jnbQi1zBm6/sChW0PNBG/QkyBJU=
X-Gm-Gg: AfdE7cknzJBn6rkPqcV7t7ZTWKmKqGUOpxWNf/7whBVgwYj0a6BrnbzoX9MkESVhqDz
	NxOSXpWVhfePNcFmF/19JqnUYS/pjF0RCJ3T4tXou43Z5HA5FEs6bi3UwVnIvqQDqTa8K6N5lZ9
	F0oRyCezFHQ/U5m1x6j3sScbTqoWKv3JiC+9mE/MRDKlOHG299MFDSqjj2DzC6Y6a6TjYxuVWhQ
	FloFs307RFfidKovmVfWzY2nBabifxv4Ec2I6aM1wNms08BQijC18mTIrbojj47B1AkCtrf
X-Received: by 2002:a05:690c:4911:b0:80e:46c0:68b with SMTP id
 00721157ae682-80e46c00f8fmr44749937b3.56.1782741421163; Mon, 29 Jun 2026
 06:57:01 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:57:00 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:57:00 -0500
In-Reply-To: <e0c25e65-8e07-41bc-a165-ae5e770a71a2@kernel.org>
References: <20260628003103.24832-1-alhouseenyousef@gmail.com> <e0c25e65-8e07-41bc-a165-ae5e770a71a2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 08:57:00 -0500
X-Gm-Features: AVVi8CfWrtuoNArMwAL3BnQ6SsE9tzXzho3wecw4lTja28mSW2h27OdwFScYINU
Message-ID: <CAMuQ4bVtXU8pEzc39GfGXvxAxJTUgZpMOZd-V0Y4ncgbTj43eQ@mail.gmail.com>
Subject: Re: [PATCH] media: em28xx: keep device state alive for registered
 video nodes
To: Hans Verkuil <hverkuil+cisco@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Abhishek Kumar <abhishek_sts8@yahoo.com>, 
	stable@vger.kernel.org, syzbot+39ff299961a7c07f00f0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Understood. I had not found that series. Please drop my patch; I will
defer to the broader lifetime fix in series 26968.

Thanks,
Yousef

On Mon, 29 Jun 2026 09:45:34 +0200, Hans Verkuil
<hverkuil+cisco@kernel.org> wrote:
> On 28/06/2026 02:31, Yousef Alhouseen wrote:
> > The V4L2 core takes a video_device reference before invoking the
> > driver open callback. That reference does not protect em28xx state
> > because all three video_device objects are embedded in em28xx_v4l2 and
> > use video_device_release_empty().
> >
> > If initialization fails after registering a node, the error path can
> > unregister it and drop the last em28xx_v4l2 reference while a concurrent
> > open has passed the core registration check. The open callback then
> > dereferences the freed video_device in video_drvdata(), as observed by
> > KASAN. A disconnect has the same lifetime gap.
> >
> > Give each successfully registered video node references to both the
> > enclosing V4L2 state and the parent em28xx device. Release those
> > references from the video_device release callback, after the core has
> > drained pending opens and existing file references.
>
> This patch series should fix this issue properly:
>
> https://patchwork.linuxtv.org/project/linux-media/list/?series=26968
>
> Rejecting this patch, manually manipulating refcounts is not the way to go.
>
> Regards,
>
> Hans
>
> >
> > Fixes: ef74a0b9ff56 ("[media] em28xx: move video_device structs from struct em28xx to struct v4l2")
> > Reported-by: syzbot+39ff299961a7c07f00f0@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=39ff299961a7c07f00f0
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/media/usb/em28xx/em28xx-video.c | 35 +++++++++++++++++++++++--
> > 1 file changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
> > index da0422c65e5f..4274a9bcb432 100644
> > --- a/drivers/media/usb/em28xx/em28xx-video.c
> > +++ b/drivers/media/usb/em28xx/em28xx-video.c
> > @@ -2289,6 +2289,31 @@ static void em28xx_free_v4l2(struct kref *ref)
> > kfree(v4l2);
> > }
> >
> > +static void em28xx_vdev_release(struct video_device *vdev)
> > +{
> > + struct em28xx_v4l2 *v4l2;
> > + struct em28xx *dev;
> > +
> > + switch (vdev->vfl_type) {
> > + case VFL_TYPE_VIDEO:
> > + v4l2 = container_of(vdev, struct em28xx_v4l2, vdev);
> > + break;
> > + case VFL_TYPE_VBI:
> > + v4l2 = container_of(vdev, struct em28xx_v4l2, vbi_dev);
> > + break;
> > + case VFL_TYPE_RADIO:
> > + v4l2 = container_of(vdev, struct em28xx_v4l2, radio_dev);
> > + break;
> > + default:
> > + WARN_ON_ONCE(1);
> > + return;
> > + }
> > +
> > + dev = v4l2->dev;
> > + kref_put(&v4l2->ref, em28xx_free_v4l2);
> > + kref_put(&dev->ref, em28xx_free_device);
> > +}
> > +
> > /*
> > * em28xx_v4l2_open()
> > * inits the device and starts isoc transfer
> > @@ -2554,7 +2579,7 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
> > static const struct video_device em28xx_video_template = {
> > .fops = &em28xx_v4l_fops,
> > .ioctl_ops = &video_ioctl_ops,
> > - .release = video_device_release_empty,
> > + .release = em28xx_vdev_release,
> > .tvnorms = V4L2_STD_ALL,
> > };
> >
> > @@ -2583,7 +2608,7 @@ static const struct v4l2_ioctl_ops radio_ioctl_ops = {
> > static struct video_device em28xx_radio_template = {
> > .fops = &radio_fops,
> > .ioctl_ops = &radio_ioctl_ops,
> > - .release = video_device_release_empty,
> > + .release = em28xx_vdev_release,
> > };
> >
> > /* I2C possible address to saa7115, tvp5150, msp3400, tvaudio */
> > @@ -2965,6 +2990,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
> > "unable to register video device (error=%i).\n", ret);
> > goto unregister_dev;
> > }
> > + kref_get(&v4l2->ref);
> > + kref_get(&dev->ref);
> >
> > /* Allocate and fill vbi video_device struct */
> > if (em28xx_vbi_supported(dev) == 1) {
> > @@ -2999,6 +3026,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
> > "unable to register vbi device\n");
> > goto unregister_dev;
> > }
> > + kref_get(&v4l2->ref);
> > + kref_get(&dev->ref);
> > }
> >
> > if (em28xx_boards[dev->model].radio.type == EM28XX_RADIO) {
> > @@ -3012,6 +3041,8 @@ static int em28xx_v4l2_init(struct em28xx *dev)
> > "can't register radio device\n");
> > goto unregister_dev;
> > }
> > + kref_get(&v4l2->ref);
> > + kref_get(&dev->ref);
> > dev_info(&dev->intf->dev,
> > "Registered radio device as %s\n",
> > video_device_node_name(&v4l2->radio_dev));
