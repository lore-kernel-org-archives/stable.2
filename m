Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0318483BC6
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286753; cv=pass; b=DZXkX9a4BN5SyMH8r+Ohe9DA8RdgkStjp53t6Tyh9wLTMtgiwtSAUpDG+6XvyTrdLL3gdaMw2zDzqz9xBYnWBUddikEi+mGTYUQYodl110+SzFuL0TdUdfmSe5HDGuB14VKlo7RRdajjZmbS533D8/arQB/MuNr7afx7JGssK6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286753; c=relaxed/simple;
	bh=aiXPmqm6ixM4oT72vI39xuRbdKB8n+b5PJa9G0aPnp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI0Qtgf9NNUKpeSvOsD7dMol8SqRT2JKsp/YRrUIoOBa0tDqlL0B0DGeqr6+dbXkEl44jzwOSHkql7mrgQe0sky2auW08Up45dp5a3arIXw/A6jmierHtAFPnVuyUr+7/2Zu3Bq3D/tpuXCnY7CJTo2W1hB4jyreTKUgWs9D+MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzK+BSKH; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzK+BSKH"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c254f9f0b20so34034666b.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286749; cv=none;
        d=google.com; s=arc-20260327;
        b=qk1uAHY7QCIw3YHEuKl235oOAZN2SAmKgxEnSy5YTb7E4Cn5urs9JjhSeUe7kcTP4S
         95ovtAqdm43FYlWvZV8Hlz8JEIZ6C47Qc5SVl/BzRZgPXdgGciClWB1jvh5G/YoHil6B
         8I9jIQ82wHu1RYunh3wCl4Qxw8kjwqH8kuakO0wFFB9NZJ7GpuQaEZCjtXYWp50qpWCf
         ntUHvSGTuvUyGIheTStpVXdkuSPR238zaEiytHil3MfapUAa/75P38k9Ff6TPRvKcKY1
         8R0Tkbkg5Okcq2u0pbGBGoZ1EoOwjFmfjD5yhxALXvohaYq20GBetuusgwVrVMCC4XSV
         6wbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=emy5clvpUK1/PyZ+N1ayFgkMRs2DcwUD8nISbx9nKIM=;
        fh=XiXRdengZ7vDDvgMHHAyjbW5lc+ckraonPlit3N4Pdk=;
        b=jDhSG+8jiQ59AqEEgNX/TX8Qb4+W50lgiCLVPu2VkR71ybZQbWH16NuErI1WA1sL9x
         7M1D83Y5z7E5Y33J1VhTPuSG0LiQdtRCPfDCed7yTSH2KPNFX+vlqMsU/XNyzLFm1KnO
         j05HzVqoEau58DoMjdoItf8VkSsvkIMYrM/kxUT778hhd1ziEqKRPrEPgLGRG45HSjm9
         70EmqBbqyAOPG0HhVhL3DEvjlMTiL8+zWO7LmJyAkvjOM99YeV8jYQvvVo6dT1m2hCVD
         pey2HDFEKyvM274NiSzA9c7bxEVljpOF3T4Zs4t1uQpZNsyUml/SWMkKqzuPphTRRLCT
         xN0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286749; x=1790891549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=emy5clvpUK1/PyZ+N1ayFgkMRs2DcwUD8nISbx9nKIM=;
        b=XzK+BSKHBGFZ0wETD2mM4OVeCch76eqxvGzeOGGacAwv+lWt1feA0FHo1619hNIKa+
         6mgGbqyjQN8VUFbDzJmkrIz/SgWpYq5knrUKjoisF1vAJdK3tFP5g8igzySm+mcvAUU4
         vCZdnqoeoetTK8LXLO27fMJJfQ6ZgDJ2QkaJkH0og2fhFbu+18DdEGWogs1ci9L+OP40
         ETgSQQWD+R3yO6HhetHFW1iI0VVLpEj4KDW9yRIv9//7xisDow20fb1d/2CyPzZAKZpg
         2ho3nWBdDWAkDEM7bBMoFhjwmrKrh7xqTaZCb2HDbGfrLnd99Auq5ixBqXliBtEXMYZg
         wuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286749; x=1790891549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=emy5clvpUK1/PyZ+N1ayFgkMRs2DcwUD8nISbx9nKIM=;
        b=Cv5Pm53Sot99Lwh9n4Uc2Bx2sL3HEj2LPRud/8fcpv5klC7PCzNcdv6h41KkbZuIdQ
         X6XFhoS6TLwB+ZHg1Ve5aTS8Xcmkrjn8D0usQCIUr4RWDzhVaZBuTNG7BE6P01U8yLGE
         XIyLFdmBjWL+QYKguBNIU/8b2jwfwUL3RGKtdR6hx6gQhSAioFmV9swWOO39Uqe/jfhe
         rTYzSPJeaLIQODE3N38WOJJkHe5tINhN97i5kkkYcAKd7nELtbLRWgaws2Y4Oq3eWKss
         1OeWEgLEyVua4chzgsKOhCoVKW/ybIgyZHItGXAKGJRYpSEPpeOzLDTWIoZ7y0YnBDv7
         yxqg==
X-Forwarded-Encrypted: i=1; AKwUvBxL+z34ou2uzcJD/KEGD6WDdjQgA8L02jWwgHUx59hqyGvPanMs6s/JbgFfuVM+pO8A7BMRuU4=@vger.kernel.org
X-Gm-Message-State: AFuF++mBuNK7/3Y+BcMyUqH2eFykqffDoDJn/PT3MC4OxtCA3CyTwqL9
	w2WC8ZKgFKOsAM3N8AgWltCLa/5WdsfN/8VKEUNy4YjL55S82jn0BjX2RCcAdW5YAhc/6/HzDQi
	kVRShF4B+2aZ/pHHZ/ZTR11Q4MsBCXw==
X-Gm-Gg: AYBFou2wZQt6IJOrFNnBCK3Os5JSHR+AOwQDrlegfgU0lTBpZEAXbvxNQWv91sqdpW2
	8mmhQo462ZIFdq4AAHnZCMiLV3HiG3gnDkfcc58ODgqMYj+swko1Xqzk19IFqiMjg3t2DMa96qF
	Qk6u1BskkT9E/gzzoGbh+P9Lhn3YK0dQhpgFvnPgkv1EL05+KvMbOe5YBB6mEcwJt4S+pccICse
	hHsoUZH0AudzghwIbJZXbY8ARINN7IEd+PnwwpkMIv/80BdEo6KWBsrUXPPZlU4mFDKV9dbUNkv
	+UqTlG0oh95/mG6ceu9ggaHNDB1POpwkpK0RitTTUwXL07lQ6NH60AwE5Lr+sDMB/wnpja8o6bA
	46fTq4E4TMVQ2DcKrJ4IJOqqPuw5aryZWHJTixcu0UcutLufnbdiWYJZpgbetSuSOymUgEDqyNx
	vFH1o=
X-Received: by 2002:a17:907:6c17:b0:c29:f5d8:9c71 with SMTP id
 a640c23a62f3a-c2ac223e35emr345128166b.32.1790286748921; Thu, 24 Sep 2026
 14:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923051950.89403-1-mhun512@gmail.com> <arOb_IrqoVq9FAw3@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
In-Reply-To: <arOb_IrqoVq9FAw3@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 24 Sep 2026 17:52:15 -0400
X-Gm-Features: AclHuK-3uW9w-DLBn4AytG0kNFAgoJ5Et803l7IrNKM_RHggnHA0eqjf0DULHjc
Message-ID: <CAGEsz8H+WhAoet36WaDvK18pV5gPhHXjDoSgHd1K=kWEcu30Aw@mail.gmail.com>
Subject: Re: [PATCH] media: amphion: Stop mailbox RX before freeing the
 message buffer
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
Cc: Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ming,

Thanks for the review. I=E2=80=99ve incorporated your suggestions and sent =
v2
as a separate two-patch series.

Regards,
Myeonghun

2026=EB=85=84 9=EC=9B=94 23=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 5:44, M=
ing Qian(OSS) <ming.qian@oss.nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Myeonghun, Ijae,
>
> Thanks for the patch.
>
> On Wed, Sep 23, 2026 at 01:19:50AM -0400, Myeonghun Pak wrote:
> > vpu_core_unregister() frees core->msg_buffer and clears core->vpu
> > before cancelling the message workers.  The fifo keeps its own pointer
> > to that buffer.  The core workers read it and queue inst->msg_work,
> > which uses core->vpu and may send on TX.
> >
> > vpu_isr() fills the fifo from the mailbox RX callback.  i.MX MU
> > free_irq() waits for that callback, not for the queued work.  An open
> > instance holds a runtime-PM reference, so remove can skip runtime
> > suspend and leave RX active.
> >
> > Stop RX, then drain the core workers and the instance workers they
> > queued with vpu_core_cancel_work(), while core->vpu and TX are still
> > valid.  Free the buffer and clear core->vpu after that drain.  Drop
> > the runtime reference only then: runtime suspend frees every channel.
> >
> > Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/media/platform/amphion/vpu_core.c | 28 +++++++++++++++++++----=
-----
> >  drivers/media/platform/amphion/vpu_mbox.c |  9 +++++++--
> >  drivers/media/platform/amphion/vpu_mbox.h |  1 +
> >  3 files changed, 27 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/=
platform/amphion/vpu_core.c
> > index 85cc4a14f8ed..000000000000 100644
> > --- a/drivers/media/platform/amphion/vpu_core.c
> > +++ b/drivers/media/platform/amphion/vpu_core.c
> > @@ -299,21 +299,23 @@ static void vpu_core_put_vpu(struct vpu_core *cor=
e)
> >       core->vpu->put_vpu(core->vpu);
> >  }
> >
> > +static void vpu_core_cancel_work(struct vpu_core *core);
> > +
> >  static int vpu_core_unregister(struct device *dev, struct vpu_core *co=
re)
> >  {
> >       list_del_init(&core->list);
> >
> >       vpu_core_put_vpu(core);
> > -     core->vpu =3D NULL;
> > -     kfree(core->msg_buffer);
> > -     core->msg_buffer =3D NULL;
> >
> >       if (core->workqueue) {
> > -             cancel_work_sync(&core->msg_work);
> > -             cancel_delayed_work_sync(&core->msg_delayed_work);
> > +             vpu_core_cancel_work(core);
> >               destroy_workqueue(core->workqueue);
> >               core->workqueue =3D NULL;
> >       }
> >
> > +     kfree(core->msg_buffer);
> > +     core->msg_buffer =3D NULL;
> > +     core->vpu =3D NULL;
> > +
>
> This looks correct to me. One suggestion: please move vpu_core_put_vpu() =
below
> the drain as well, so that the whole release sequence sits after
> vpu_core_cancel_work(). That would also match vpu_core_suspend().
>
>
> >       return 0;
> >  }
> > @@ -700,10 +702,18 @@ static void vpu_core_remove(struct platform_devic=
e *pdev)
> >       WARN_ON(ret < 0);
> >
> >       vpu_core_shutdown(core);
> > -     pm_runtime_put_sync(dev);
> > -     pm_runtime_disable(dev);
> > -
> > -     vpu_core_unregister(core->parent, core);
> > +     /*
> > +      * Runtime suspend frees every mailbox channel, including TX,
> > +      * and is skipped while another runtime-PM reference remains.
> > +      * Stop RX first.  vpu_core_unregister() then drains the core
> > +      * workers and the instance workers they queue, which may still
> > +      * send on TX, before the fifo buffer and core->vpu are released.
> > +      */
> > +     vpu_mbox_free_rx(core);
> > +     vpu_core_unregister(core->parent, core);
> > +     pm_runtime_put_sync(dev);
> > +     pm_runtime_disable(dev);
> > +     vpu_mbox_free(core);
>
> This part, though, I don't think we need.
>
> The driver assumes that all instances are already closed by the time remo=
ve()
> runs. struct vpu_core is devm_kzalloc()'d on the core platform device, an=
d
> inst->core is just a plain pointer taken in vpu_inst_register(). So if an
> instance is still open when the core device goes away, inst->core is left
> dangling, and the next ioctl - or close() -> vpu_inst_unregister() ->
> mutex_lock(&core->lock) - will panic. get_device(core->dev) doesn't help =
here;
> it pins the struct device, not the driver data.
>
> As long as that assumption holds, the existing order is fine: the runtime=
-PM
> reference is dropped before vpu_core_unregister(), so
> vpu_core_runtime_suspend() -> vpu_mbox_free() has already released RX alo=
ng with
> its irq, and vpu_isr() can no longer fill the fifo. So I'd drop this part=
, along
> with vpu_mbox_free_rx() and the vpu_mbox.h change. That also keeps the fi=
x small,
> which is nicer for stable.
>
> That said, the hole you're pointing at is real: remove() can be reached t=
oday
> with an instance still open. I just don't think the right answer is to ha=
rden
> this path. rmmod is already safe, because vdec_fops/venc_fops set
> .owner =3D THIS_MODULE and an open /dev/videoX holds the module reference=
. sysfs
> unbind isn't. So how about closing that instead, as a separate patch:
>
>   - .suppress_bind_attrs =3D true on amphion_vpu_core_driver, and on
>     amphion_vpu_driver too - otherwise unbinding the parent ends up in th=
e same
>     place.
>
>   - WARN_ON(!list_empty(&core->instances)) at the beginning of
>     vpu_core_remove(), so the assumption is stated in the code rather
>     than implied.
>
> Regards,
> Ming
>
> >       memunmap(core->fw.virt);
> >       memunmap(core->rpc.virt);
> >       mutex_destroy(&core->lock);
> > diff --git a/drivers/media/platform/amphion/vpu_mbox.c b/drivers/media/=
platform/amphion/vpu_mbox.c
> > index b2ac8de6a2d9..521fd47f1d90 100644
> > --- a/drivers/media/platform/amphion/vpu_mbox.c
> > +++ b/drivers/media/platform/amphion/vpu_mbox.c
> > @@ -88,14 +88,19 @@ error:
> >       return ret;
> >  }
> >
> > +void vpu_mbox_free_rx(struct vpu_core *core)
> > +{
> > +     mbox_free_channel(core->rx.ch);
> > +     core->rx.ch =3D NULL;
> > +}
> > +
> >  void vpu_mbox_free(struct vpu_core *core)
> >  {
> >       mbox_free_channel(core->tx_type.ch);
> >       mbox_free_channel(core->tx_data.ch);
> > -     mbox_free_channel(core->rx.ch);
> >       core->tx_type.ch =3D NULL;
> >       core->tx_data.ch =3D NULL;
> > -     core->rx.ch =3D NULL;
> > +     vpu_mbox_free_rx(core);
> >       dev_dbg(core->dev, "%s free mbox\n", vpu_core_type_desc(core->typ=
e));
> >  }
> >
> > diff --git a/drivers/media/platform/amphion/vpu_mbox.h b/drivers/media/=
platform/amphion/vpu_mbox.h
> > index 8b7aea4f606c..a934fe61b294 100644
> > --- a/drivers/media/platform/amphion/vpu_mbox.h
> > +++ b/drivers/media/platform/amphion/vpu_mbox.h
> > @@ -8,6 +8,7 @@
> >
> >  int vpu_mbox_init(struct vpu_core *core);
> >  int vpu_mbox_request(struct vpu_core *core);
> > +void vpu_mbox_free_rx(struct vpu_core *core);
> >  void vpu_mbox_free(struct vpu_core *core);
> >  void vpu_mbox_send_msg(struct vpu_core *core, u32 type, u32 data);
> >  void vpu_mbox_send_type(struct vpu_core *core, u32 type);
> > base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> > --
> > 2.47.1
