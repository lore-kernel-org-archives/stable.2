Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632423;
	b=faWQHrCeAcCnl6zbYPT2y6D+2HdzWkBi+wa11cVxEy7r23kxu2WhyEOftc9/TqgCchJ6
	 8XHj/7xkBxyC82dNVuXw+zZhrGCuV1m0OiXacRD4iDH9Bg9CJ80AaQhWK8Th2trmeGe/g
	 L64W8uC+HX2JgVfnDK6Esw1+lRYwb296xw/x0afvyklpgwaEnUt26tLx/THNWS6e5buK7
	 DKKRdszwSP3zJHIJLpHk6EZ5eeZcLYLucsfRBVyUTNLiKj2nCp97u03ZbfsdYhZVR4W5J
	 4JkhwXP8TmAvgYWZ28+HM94GsZCulMA88/PSRJPnhZ0KfckN7ztxOfyVr1HI5+PJOLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632423;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:From:To:Cc:Subject:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=rX8weEz8Yv8z+NBgshyk1QFbABy9Eh8w5Sm+fHbCwhc=;
	b=jR+5Ui6S9oloSOaX8dtMrK319neGJbObvl556M4/z9TDVtXBVydCyIxj4FFZIwo4SkCB
	 ElC2DLK1ZCwuAa8qvh0uD/0LEQdfEyHsuBYbIiKQUPSczzvMRfQjMv8vBJfGCgAcoEVw0
	 3eZoUGzgyJxCpE1iAwgZh7EAw5qjKI2fLfoN6UOTgZgpkBGUXFT0eW6e0ZvSqVB7SbTG9
	 J/ahMQCv3YVXjP5xGzc4ZR85ip9UvwXeonCruHDD1zdbCFC+hgC3Zaeg+4vkd9Bm5YqQt
	 gdYbgRJaFoKK1W8T6ancDGSrt1xpWvhcTadeuAF//atkfvXJW/cmIdaeHkFAqoEznkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=q72MsLi2;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179E6091CA7;
	Mon,  2 Nov 2026 15:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F179E6091CA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=q72MsLi2
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89A484DC;
	Mon,  2 Nov 2026 16:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793632284;
	bh=9/iTNgDcJ7NwEgRWhESBIWPaHYgzHkBYwIl156brGhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q72MsLi2xx0yQOOufyTFJQUdNdT/oAj0UrpKSPvu7M64ta7DrZdffQSIcS6MoTGdK
	 rrS+Y0+YeLtH2uKG1oQi3OO4W32P7yo/LJDO37uYAkUG0rV8OxZYiTiGOvALKd3v3x
	 dXkPcGdGvmv+O8C4AdrkeaWNw5MmNf57D4+ATIiI=
Message-ID: <310714a97367e59064d1b2d5c0665c4f@killaraus.ideasonboard.com>
From: laurent.pinchart@ideasonboard.com
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mchehab@kernel.org, sakari.ailus@linux.intel.com, hverkuil@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deepanshu Kartikey <kartikey406@gmail.com>, stable@vger.kernel.org
Subject:
 Re: [PATCH 2/2] media: mc: fix race in media_device_unregister_entity()
Date: Mon, 02 Nov 2026 17:13:32 +0200
In-Reply-To: <20261102141439.13505-3-kartikey406@gmail.com>
References: <20261102141439.13505-1-kartikey406@gmail.com>
 <20261102141439.13505-3-kartikey406@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hello,

This is an automated reply.

You have sent a patch or bug report that appears to have been generated
by an LLM. The commit message, code and/or problem description show
little to no real understanding of the issue and changes being proposed.

Such patches or reports require a large amount of work to handle. They
rely on maintainers to propose - and often even implement - a proper
design. The probability that the author will learn from the experience
to improve their future contributions is close to zero.

As a result, to make good use of maintainer time and keep the kernel
development process sustainable, your contribution has been rejected.

If you believe the change you proposed is important, take time to study
the problem, learn, and develop a solution without AI assistance.
Answering this e-mail or generating a new version of a patch by feeding
this reply to an LLM will only result in your e-mails being ignored.

Please note that if your patch attempted to address an important
problem, maintainers or other contributors can submit and merge a
similar or entirely different fix without crediting you.

Your contributions to the Linux kernel will be welcome if you genuinely
desire to invest your time and learn.

Thank you,

Laurent's mail bot

On Mon, 02 Nov 2026 19:44:39 +0530, Deepanshu Kartikey <kartikey406@gmail.com=
> wrote:
> media_device_unregister_entity() checks entity->graph_obj.mdev for NULL
> before taking mdev->graph_mutex, but does not check again afterwards.
> If media_device_unregister() runs concurrently (for example on USB
> disconnect), it unregisters every entity and clears graph_obj.mdev while
> this function waits for the mutex. The waiter then calls
> __media_device_unregister_entity() with a NULL mdev and faults in
> ida_free(&mdev->entity_internal_idx, ...):
>=20
>   Oops: general protection fault, KASAN: null-ptr-deref in range
>   [0x00000000000000c8-0x00000000000000cf]
>    ida_free
>    __media_device_unregister_entity
>    media_device_unregister_entity
>    v4l2_device_release
>    v4l2_open
>=20
> Re-check graph_obj.mdev under the lock and skip the unregister if the
> entity is already gone.
>=20
> Found while testing the fix for the syzbot report at
> https://syzkaller.appspot.com/bug?extid=3D54648a6c1187a7ef46a6
>=20
> Fixes: e2c91d4d78ee ("[media] media-device: get rid of the spinlock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/media/mc/mc-device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
> index f8ea7cfe10b2..039ef7d04ac7 100644
> --- a/drivers/media/mc/mc-device.c
> +++ b/drivers/media/mc/mc-device.c
> @@ -674,7 +674,8 @@ void media_device_unregister_entity(struct media_entity=
 *entity)
>  		return;
> =20
>  	mutex_lock(&mdev->graph_mutex);
> -	__media_device_unregister_entity(entity);
> +	if (entity->graph_obj.mdev)
> +		__media_device_unregister_entity(entity);
>  	mutex_unlock(&mdev->graph_mutex);
>  }
>  EXPORT_SYMBOL_GPL(media_device_unregister_entity);
