Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346960;
	b=zpsdUSKAJSUBi7rnHQ5euvwzi6331RUUW63FtvILxETtkvceE1XSjmLoikbWFTKxz2gW
	 ZgIYYOBwMWihwKCM1iP2iiC99lVy8IT/suzjRQ78DoEY+QwkpYPM7v7/NaRcYAXy8xE5U
	 rCAIoCV0LNcXOOOCt0NR1L/GYGiS9TimndGTW2yorEj3Zk0YsEM6kmDlUJOF9+OVybcM5
	 MEJ0oCJymvuil2QIT0JfhP8y9BBEU7CBJCpaBne01O2WG0MZ/+KrCU6jOEI8qTqVSXEVb
	 +nVShh9rk+R9p0VJdaf5aSEWtUWqkt3ItHJrHlkwIhv2PXSCmrV44XNEZVA28h5sxdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346960;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/0IJzjD1leWBOmIalg2+9HG6AipukIvLj6BktyhCaOU=;
	b=kMP5zZNssGCvCuuKPlw9sgFKqbh8i6TdrHevj64+miT9XowCGvbpbLuAIEvY88PlxMPR
	 kF6cQSm9ZlopzWmP4qHkmNBUfkLzcdsG4TuSUcUYZA4Iew5SxxrcOwfoNlX4xfsRjLDnV
	 P3ufr6nQb4Eoe94OFRA9tW4a9iEBQFfcITsGLFXE3OqrH7CQzspW8Ekg0ZkMf/57ImeXs
	 5EhLdjF5ieiUobINL914Cwna8fmGnhxrzIpUMFu4/MJl2F0erz5bY5LfxbNW4G1qta3Pt
	 IUfd4VRYHIgsvLiuYpcHHHgAkaZp6GQ+eFJOKiibbf0RU0z49kF+ruhjdQcIDvZeJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kI1YKtnf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EBC606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kI1YKtnf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED6E1F008A3
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346960;
	bh=/0IJzjD1leWBOmIalg2+9HG6AipukIvLj6BktyhCaOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kI1YKtnfZR8F2XwLuz0DIOW1qK6FIIZHFV6VG1RNcVA60MJiL4I+xy/KpmajCNgoS
	 94Yu7FpeHTZlr4N4kGve6rZH9hGddTYItJsx5XE3dKaGGNahzKwjbp+Ibw7hw8pCpW
	 RkS/FPTU+Q/170qepbdJoed//SdQYpCspIfQyBP1VCj2GR3BqjbFrkqPqHMQpgLTUV
	 H+6qzgxXAd8E0/+dqBAS4YYciHZrdYPrsthLYqFMvmgU9WCIuGn7kdrjwBz7sSqyKI
	 JR5UZTi0RoQ+L3A34GBO+ikZBAAG8m2HbPsC03ZwfYd9svbnzqN40Szz2nff8trNQ0
	 FPdmpgj0kTXGA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso2287051e87.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:42:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGA8w5XTBjPuHiq1ZZubfnLPBg20qzTBir1yNL8cvxrMZC7UziqzF9vWT9vA+zMMqvJpZTn+6E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KjWaX1J6B2gF0UXjj+rQ3cT0PeF7e3R1c1ILPVTDyR12KsKUb
	wyIA7QqMXIOnnJgAYjbtc7u+hAzY15ThS/shL3S7/gKFeIDUQ3U9u088EJyXmq6PjX+z+jVHufW
	tKdfsb6Ssths6/RvlUDzK6w+lc5h6Jfg=
X-Received: by 2002:a05:6512:1052:b0:5c1:4e2d:57bc with SMTP id
 2adb3069b0e04-5c15d76aab8mr100084e87.47.1794346959064; Tue, 10 Nov 2026
 13:42:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-gpio-shared-refcnt-race-v2-1-8a0b76e01714@oss.qualcomm.com>
In-Reply-To: <20261110-gpio-shared-refcnt-race-v2-1-8a0b76e01714@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 22:42:27 +0100
X-Gmail-Original-Message-ID: <CAD++jL=DDvyghTwUZ6Be_h6CW==Ni0QtUfPAHLL=5iuCrSu0PA@mail.gmail.com>
X-Gm-Features: AclHuK-NkELi0fVYKm89vk76-m1xiQbJEmTbPyxt3yo0Ro_HhjI5lSEmupk_eDk
Message-ID: <CAD++jL=DDvyghTwUZ6Be_h6CW==Ni0QtUfPAHLL=5iuCrSu0PA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: shared: fix a race in shared desc release path
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:10=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> gpiod_shared_put() races with concurrent calls to
> devm_gpiod_shared_get() like so:
>
> CPU 0 (unbind / probe failure)      CPU 1 (concurrent proxy probe)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> gpiod_shared_put()
>   kref_put(&entry->ref, ...)
>     refcount_dec_and_test() // -> 0
>                                     devm_gpiod_shared_get()
>                                       mutex_lock(&entry->lock);
>                                       if (entry->shared_desc) {
>                                         kref_get(&entry->ref); // on 0!
>                                         shared_desc =3D entry->shared_des=
c;
>                                       }
>                                       mutex_unlock(&entry->lock);
>     gpio_shared_release()
>       mutex_lock(&entry->lock);
>       kfree(shared_desc);
>       entry->shared_desc =3D NULL;
>       mutex_unlock(&entry->lock);
>                                       // uses freed shared_desc
>
> Because gpiod_shared_put() decrements entry->ref without holding
> entry->lock and gpio_shared_release() only acquires entry->lock after the
> reference count has already reached zero, a concurrent call to
> devm_gpiod_shared_get() can acquire entry->lock in the intermediate windo=
w
> and observe a non-NULL entry->shared_desc. This can result in a
> use-after-free and a double-free when the second consumer releases its
> reference.
>
> Use kref_put_mutex() to ensure the entry lock is taken without a window
> in which a concurrent user can see a non-NULL entry->shared_desc while
> it's being released.
>
> Cc: stable@vger.kernel.org
> Closes: https://sashiko.dev/#/bug/linux-30e071e4-4e4a-4b63-bd83-df1147055=
d35
> Fixes: a060b8c511ab ("gpiolib: implement low-level, shared GPIO support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Good find!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
