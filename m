Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798835;
	b=GrCI9rnHjZiXLJUB3/OFp5fhGbxvA0BYMpeY0vpBrWZ8BvSrTux7WMkvKVrojtBsBrU4
	 oEjIaM1ALW3CRlTGP4JNFYPsvXc9wAwbkfTuwpgW334stpok0FQIHs5bSvZ3hgiK6Mt7M
	 2pcPwGFkoqNiOfiQJ0HyooOyy6HN3CG8jjAwe5qt28RoBI41MvGv4smkJsgOdQc+gzVlw
	 d8AFNdJOsuk/MrB6hW8wQ1q29aGhljOF3hWpbZaJE+/eqnaDg2TL/bndZdGh8JAj22NvC
	 94f//zI0TUmVe+sAwW6iVAMeG4pMaY63IOCWX/5RNTsDRiPRWmBHaH1k1vPOhY9accQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798835;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hhq5EOa6Odz+K2vaBaOuOYmvWaBTRJ+kEF4fefMeYnQ=;
	b=ImZqE1xlzyUT7WXcb66Oq2Uzta4kmUjz4/4qLCg3eVT8Q2KwcFAYJAwBxpZUkemGeN/U
	 WlNjqapEc7W4vWLlUxQuBbDy/GdhyUZd17L2M0wTk9fwSfqv0vqrQMzOcrqO3xHelZww8
	 WEN488s8pmKDnqxG5zH1FQbmP5MrD02YgdAMpsbnstQ4nS9Vy6O7U095VBzvM5BnMGAvf
	 CrSdri6+VRoUEIoJryynZUggjY/lR0s4plA5IqKCrA288O9AeUnJK89OFng7s2Ok/ZFX/
	 k2B/qWhoISIw7AyOuYSKqMvYL7LBXbGxUebrEOMWrANqacy2vr/JzjXnsZ+Hbj48t3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=LokHz1aa;
	arc=none smtp.remote-ip=79.135.106.100
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch [79.135.106.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095B606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C095B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=LokHz1aa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793798828; x=1794058028;
	bh=hhq5EOa6Odz+K2vaBaOuOYmvWaBTRJ+kEF4fefMeYnQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LokHz1aag6PaSNFE8C27kBJ0WZ6M+UPGHXO+rQSR0cNM/2otH80f1ijoMEGuR55gW
	 b4QL7QYt40r1A8rSZ8mzFMAVGBkEd24hvQwLCMm6b9DUZ6oO38XXyaeHg/Zqg/w9Mr
	 Xuzjd10Gz32YbH9HD3+dR2GhiETXDW2tWFiKkRse7s5HA+nLsh+tlNfkFT6xTRz7OH
	 B7Of+E4TFuHrasbBSkEP4d0F18omzemN55swOa82ZMF3ORRlcHiCmy96DQ2IPNw7RB
	 /58u7U5RPNRi7lV3nvfCIDzzkKizj1Kur0hi39lOpH+lVckEaQkoQjOVtZalGAswbE
	 M2/BI/0Nr6GVQ==
Date: Wed, 04 Nov 2026 13:26:56 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Paul Moses <p@1g4.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, longpareto@gmail.com, oss.patchbox@gmail.com, phx0fer@gmail.com, physicalmtea@gmail.com, sergiiushakov@google.com, shubham@octane.security, stable@vger.kernel.org, stjepan.poljak@gmail.com, syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <boz9jnakQM6uAhZfWbN75Fy90K5NZ8XCEXBRlhjkqDryEgBVXwJzIPrq1giWoitEnsZPiK4FyKlYBVHioGorKSw4JzSVd8kxw9RIhEz0-kE=@1g4.org>
In-Reply-To: <20261104081535-mutt-send-email-mst@kernel.org>
References: <20261104081535-mutt-send-email-mst@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: e60a96041563db78786d8f092c9f5e833f03cb84
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
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 06:56:40AM +0000, Paul Moses wrote:
> > On Wed, Mar 11, 2026 at 08:00:45PM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Mar 11, 2026 at 02:12:17PM +0000, Paul Moses wrote:
> > > > >
> > > > > Indeed, seems legit, thanks!
> > > > >
> > > > > The only thing is that I dislike two error handling paths here.
> > > > > So I wonder why isn't this as simple as fixing the double free
> > > > > directly:
> > > > >
> > > >
> > > > That works for me, should I send it out?
> > > >
> > > > Thanks,
> > > > Paul
> > >
> > >
> > > Please do.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Oh and I forgot
> >
> > Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
> >
> >
> > >
> > > --
> > > MST
> >
> >
>
> Considering that this pattern has occurred in multiple independent source=
 files,
> maybe it is worth it to make intent more clear? What about this?
>
> >From c3b9431dc736cec60c0b288b13d9fa718341f46a Mon Sep 17 00:00:00 2001
> From: Paul Moses <p@1g4.org>
> Date: Tue, 10 Mar 2026 15:23:58 -0500
> Subject: [PATCH] vdpa: don't free reply skb after genlmsg_reply()
>
> genlmsg_reply() hands the reply skb to netlink, and
> netlink_unicast() consumes it on all return paths, whether the
> skb is queued successfully or freed on an error path.
>
> vdpa_nl_cmd_dev_config_get_doit() currently jumps to nlmsg_free(msg)
> after genlmsg_reply() fails, which can hit the same skb twice.
>
> Return the genlmsg_reply() error directly and keep nlmsg_free()
> only for pre-reply failures.
>
> Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Paul Moses <p@1g4.org>

I like crediting people for their work.  Let's do this. Pls post as a
proper patch starting a new thread, so all 0day tooling catches this,
and I'll apply. I'll then apply a rework removing the duplication, on
top.  Thanks!


> ---
>  drivers/vdpa/vdpa.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 34874beb0152e..702d3a7772219 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1352,15 +1352,19 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct=
 sk_buff *skb, struct genl_info
>  =09}
>  =09err =3D vdpa_dev_config_fill(vdev, msg, info->snd_portid, info->snd_s=
eq,
>  =09=09=09=09   0, info->extack);
> -=09if (!err)
> -=09=09err =3D genlmsg_reply(msg, info);
> +=09if (err)
> +=09=09goto mdev_err;
> +
> +=09put_device(dev);
> +=09up_read(&vdpa_dev_lock);
> +
> +=09return genlmsg_reply(msg, info);
>
>  mdev_err:
>  =09put_device(dev);
>  dev_err:
>  =09up_read(&vdpa_dev_lock);
> -=09if (err)
> -=09=09nlmsg_free(msg);
> +=09nlmsg_free(msg);
>  =09return err;
>  }
>
> --
> 2.53.GIT
>


It's obvious now your intention was always to diminish my=20
contribution. This really only reflects negatively on you.

You or claude didn't even disassemble it. It's slop. My
patch is objectively superior both in human readability
and performance.
