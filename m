Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFB3B95F6
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357424; cv=pass; b=JDOQoZy+/msJ6OWvhrBFxh9rfF2r7DeKPjYwL16O0TDp3N7LoqwNzLcyaknJOI3JHFgudIt0n5U0eCYnJ/clzzAg4Q4NUbi8kQwpuHF0+SPCUa3mFL8Y2IgDza4zaCKs0gShgKF5dYsTBbRxeysX840yxwiwDyl0CuA6fuOs0AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357424; c=relaxed/simple;
	bh=sy4euGKBU3TEPf4QWT6CSFR+72tO/gBsp5c0sgzskUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXjCHWRTGy+UU7o8pI2vNdw4aJnhXQ/3+8lzAMRRKMAIA8BrSx9+WXeUSmFJbVVRVzS9/FRCdk7g2LDut9T7f38NpC0XLhs5IO9KWKQ/82/2zYc41xHq8Pif38G8Xr3p4DkmjoBmp+yQU9i9JpM2XoV9FvquwpBzX6E2jA44jKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V7mwHvwn; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V7mwHvwn"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44856d185bcso1185780fac.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 03:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786357421; cv=none;
        d=google.com; s=arc-20260327;
        b=bKspba33alQSMSgi5KfGR9ye4ESZmBFy3fsMycuIeZiR3PCWkv3qVeGDVCwqj+bgC5
         e5iiHvsK2Gk2Wz46/SUen3nXS2XWqmsGM+wltCXEovE4PVkToRY4yeyqYYtYqsodHVcp
         QMpwuJuMiQr81g4vcnAqH3Y/4iQFq0/BFzaHOzHiB+7UsBVl9GoVdz1Hf+nD9vgeOrqu
         v7r9P6IriK3gOWUmLKg4K1hEZuPl+2ibogHjkTPfKyR32NtzQTXBQ2pqctNO35VEDucP
         +AwqilqEEHg/NEh0U5bR9LpwGjRy1u1iJTFfuisRlYgEJxrdgNqDuf5PFdG5wa0oKNll
         NMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BdyANCjCkJ+TfDWbmGMzYzdTHWuRlzmp/fLdKDSudAw=;
        fh=8and/EN03Jd+u+nEKSDVs0NYAlEkqdno9WD1ISS0eW0=;
        b=Yj0gAy3JMINOYwpOKq9kAJbdIk9PnBpAnSYddjubueeFw1H8SzvChLO8CpYJKGEjMm
         h4wnWAKRsUEa7UwKeEg5UvbqVEjAeqn34aoGorctXpTIBXSIeQbvCDRiYa36Tbx1EY9p
         lsGR4bAhyHETydKYtfJOh9pVkiMMaEe9BCYaGGbZ9cAotrCyZoDXCviX/P66oTjI82w9
         x7jH8p5FWsmHtVRCMJl2vDX/D6qGygUk/oI/DTanDXFzSD8tyLUplXgRUFimcAkUH0UJ
         LdurZkxvF0mjvvzo0SiUt7SVWSlcQTJhj/ceNhc7zaFDQtfS4nWYwIs1WsfDaN5glZW0
         7uZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786357421; x=1786962221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BdyANCjCkJ+TfDWbmGMzYzdTHWuRlzmp/fLdKDSudAw=;
        b=V7mwHvwn+DdvXf+ve1rCQ9H0xh4w5HqepJtBfyv3GzDCJEKBM7Yg4XTXGKuEYs7yQE
         nlYl43cz27qzCig76ANNicjOJWbVD+zEyCl1J7+GdCgkA2yiW1bKRN+Km890XMG9vo0N
         1lLSrZRFzE0LLgtEkdgw46QR1mIF5++bksCWgsdcT2V+LwAS9nbqmRpUIUNQnQuf+Emk
         T5K1TcEgMpZBR81XRaQLJ+Tg7RkH+8QtUJdgpMzXOKg4TAEolr6DAdJnfCgb0L3tF4jh
         GUSIpzwmepAsTTJDGgaFi+sOd7H3ZCJzConWjuoCMEMIhEFLhbKwrET9enyzR2h7cZLe
         XwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786357421; x=1786962221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdyANCjCkJ+TfDWbmGMzYzdTHWuRlzmp/fLdKDSudAw=;
        b=i1nSfKiiz7cuzSjSkoY+k0Y0T/Zmt6q7YlowzeagjvbrS7ZdBFb2aQkn5bLf457NYW
         UfiHbSDfgIJq+2MFgcvZZ9/23LuTID7Tuei9kVISOxs5lAfGmnhPkBQzTeOPs8NfmcqH
         9SPtEr5xU+m7/y+XITGwXM0yIaRqdIFaOLJS522rGbvhKmYk+y4pBNCIlt3YZ0lwN1Kv
         A7LYuAfwP9TOIvcN/h9gtHiFDaIUSwEU+rvOdZhYZQ99h8n9zlChEK7nVD/fyEXlF7ZX
         ys6cIiMGkj+VYdXdBBqRjtGYJ5lV0zHBkhIuczMhV2bho2sPLxkyEGWiyp4i9ecdbYQ2
         TiSA==
X-Forwarded-Encrypted: i=1; AHgh+RrmEuAeL8KFav925g0VnsdVu3AGCmGuAHSxiP5CD3AnGHcvotTvDnEuhY1cguUZ8NkuPgsAjRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBeZ6wvSaY6d0y9TYLZklN/UkU1Xjwc0ScL6GGIBsmpKFLqzG
	4soQUL1K+82hk9aTJWoOjxXjKZ4/a7iluVrnRONIEr+vM1d5PPDfiR5f5s+d5sGBBikqfzRerqa
	3BZqxf4h/rc4dDjzo/962mhDgljROgJe+oUD33HoR80t5LfbbHapfsDJhhA==
X-Gm-Gg: AR+sD12V7KP1v4SuU4dAWMOQpHcxn+MY0872bfds+7sIwpwrlrYkgTkTsTWI53LuYmY
	zF5PYyFEfJu7r6l30PKbFMAahA9t4atpxWGz5lswQefmooCgSIgTEkAjVlDPZxHmMdMJ4GTiYvO
	UbOTVyJa2GjtknTpXGBlZ4kJpPBX3KUBD2r/5Frwrc7HXr07ayyBXSbQYQpAkANM/KVGUO6tqp0
	qz/0xJA1laLf18vJ+4rmkBXfWPK8lAF8FQk2Dr+XhMiJWZIglNRCDXhOEm7tDLdXzfExdUPy6kg
	j7xUYq0eabcqDntVQTXanhVQvYh8HM24URRTyat83stplJU=
X-Received: by 2002:a05:6870:2d1:b0:456:b63e:658a with SMTP id
 586e51a60fabf-459e391213emr14978663fac.18.1786357420845; Mon, 10 Aug 2026
 03:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608025043.88087-1-cuiyunhui@bytedance.com> <09ee2ea0-c93f-406c-b5af-1fe3a50c8989@kernel.org>
In-Reply-To: <09ee2ea0-c93f-406c-b5af-1fe3a50c8989@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 10 Aug 2026 18:23:29 +0800
X-Gm-Features: AUfX_my63ARI2eXUc2-yPXbYwqXPFzXgw_p2nJJNLFoZTC92nBcJ_eHY1Chb4zg
Message-ID: <CAEEQ3wm8kyDSScYsAMTf6jdEqnQzQSi1xykqH2Z7vvJzQNc8Jg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/gup_test: fix race with
 PIN_LONGTERM_TEST ioctls
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, yang.lee@linux.alibaba.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Jun 12, 2026 at 3:36=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 6/8/26 04:50, Yunhui Cui wrote:
> > The PIN_LONGTERM_TEST helpers keep their state in global variables that
> > are protected by pin_longterm_test_mutex when accessed from ioctl().
> > However, gup_test_release() calls pin_longterm_test_stop() without
> > holding that mutex.
> >
> > This can race with PIN_LONGTERM_TEST_STOP and let two callers operate o=
n
> > the same pages array concurrently, corrupting the test state and possib=
ly
> > freeing it twice:
> >
> >  CPU 0                              CPU 1
> >  -----                              -----
> >  ioctl(PIN_LONGTERM_TEST_STOP)
> >    mutex_lock(&pin_longterm_test_mutex)
> >    pin_longterm_test_stop()
> >      if (pin_longterm_test_pages)
> >        kvfree(pin_longterm_test_pages)
> >
> >                                     close()
> >                                       gup_test_release()
> >                                         pin_longterm_test_stop()
> >                                           if (pin_longterm_test_pages)
> >                                             kvfree(pin_longterm_test_pa=
ges)
> >
> >      pin_longterm_test_pages =3D NULL
> >    mutex_unlock(&pin_longterm_test_mutex)
>
> Okay, thinking about this some more ...
>
> I think what's really required here is that we have two separate "struct =
file",
> because otherwise release() cannot race with unlocked_ioctl().
>
> Which is something we didn't expect when we added this functionality.
>
> I think the proper way to handle this is by moving the state to the
> "struct file", to actually cleanly allow concurrent usage.
>
> So instead, I think we should do the following (untested):
>
> From 29e3d6fe00c4bd843d11bb548efa89bca478436c Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Fri, 12 Jun 2026 09:22:25 +0200
> Subject: [PATCH] mm/gup_test: keep longterm pin state per file
>
> The pin longterm test currently stores its data globally, shared among
> multiple concurrent users of the interface (multiple open file
> descriptors -> multiple "struct file"'s). That makes
> the gup_test interface problematic to use concurrently: two users, such
> as concurrent selftest runs, can interfere with the same longterm
> pin state.
>
> While this has not been observed as a problem so far in practice, let's
> just handle it cleanly. There could be a way to trigger selftest
> failures by e.g., running the cow.c and gup_longerm.c selftests
> concurrently, but we usually run them sequentially. Let's add a "Fixes"
> tag to be safe.
>
> Fixes: c77369b437f9 ("mm/gup_test: start/stop/read functionality for PIN =
LONGTERM test")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/gup_test.c | 93 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 32 deletions(-)
>
> diff --git a/mm/gup_test.c b/mm/gup_test.c
> index 9dd48db897b9..16916056677e 100644
> --- a/mm/gup_test.c
> +++ b/mm/gup_test.c
> @@ -8,6 +8,12 @@
>  #include <linux/highmem.h>
>  #include "gup_test.h"
>
> +struct gup_test_data {
> +       struct mutex longterm_mutex;
> +       struct page **longterm_pages;
> +       unsigned long longterm_nr_pages;
> +};
> +
>  static void put_back_pages(unsigned int cmd, struct page **pages,
>                            unsigned long nr_pages, unsigned int gup_test_=
flags)
>  {
> @@ -204,23 +210,20 @@ static int __gup_test_ioctl(unsigned int cmd,
>         return ret;
>  }
>
> -static DEFINE_MUTEX(pin_longterm_test_mutex);
> -static struct page **pin_longterm_test_pages;
> -static unsigned long pin_longterm_test_nr_pages;
> -
> -static inline void pin_longterm_test_stop(void)
> +static inline void pin_longterm_test_stop(struct gup_test_data *data)
>  {
> -       if (pin_longterm_test_pages) {
> -               if (pin_longterm_test_nr_pages)
> -                       unpin_user_pages(pin_longterm_test_pages,
> -                                        pin_longterm_test_nr_pages);
> -               kvfree(pin_longterm_test_pages);
> -               pin_longterm_test_pages =3D NULL;
> -               pin_longterm_test_nr_pages =3D 0;
> +       if (data->longterm_pages) {
> +               if (data->longterm_nr_pages)
> +                       unpin_user_pages(data->longterm_pages,
> +                                        data->longterm_nr_pages);
> +               kvfree(data->longterm_pages);
> +               data->longterm_pages =3D NULL;
> +               data->longterm_nr_pages =3D 0;
>         }
>  }
>
> -static inline int pin_longterm_test_start(unsigned long arg)
> +static inline int pin_longterm_test_start(struct gup_test_data *data,
> +               unsigned long arg)
>  {
>         long nr_pages, cur_pages, addr, remaining_pages;
>         int gup_flags =3D FOLL_LONGTERM;
> @@ -229,7 +232,7 @@ static inline int pin_longterm_test_start(unsigned lo=
ng arg)
>         int ret =3D 0;
>         bool fast;
>
> -       if (pin_longterm_test_pages)
> +       if (data->longterm_pages)
>                 return -EINVAL;
>
>         if (copy_from_user(&args, (void __user *)arg, sizeof(args)))
> @@ -259,12 +262,12 @@ static inline int pin_longterm_test_start(unsigned =
long arg)
>                 return -EINTR;
>         }
>
> -       pin_longterm_test_pages =3D pages;
> -       pin_longterm_test_nr_pages =3D 0;
> +       data->longterm_pages =3D pages;
> +       data->longterm_nr_pages =3D 0;
>
> -       while (nr_pages - pin_longterm_test_nr_pages) {
> -               remaining_pages =3D nr_pages - pin_longterm_test_nr_pages=
;
> -               addr =3D args.addr + pin_longterm_test_nr_pages * PAGE_SI=
ZE;
> +       while (nr_pages - data->longterm_nr_pages) {
> +               remaining_pages =3D nr_pages - data->longterm_nr_pages;
> +               addr =3D args.addr + data->longterm_nr_pages * PAGE_SIZE;
>
>                 if (fast)
>                         cur_pages =3D pin_user_pages_fast(addr, remaining=
_pages,
> @@ -273,11 +276,11 @@ static inline int pin_longterm_test_start(unsigned =
long arg)
>                         cur_pages =3D pin_user_pages(addr, remaining_page=
s,
>                                                    gup_flags, pages);
>                 if (cur_pages < 0) {
> -                       pin_longterm_test_stop();
> +                       pin_longterm_test_stop(data);
>                         ret =3D cur_pages;
>                         break;
>                 }
> -               pin_longterm_test_nr_pages +=3D cur_pages;
> +               data->longterm_nr_pages +=3D cur_pages;
>                 pages +=3D cur_pages;
>         }
>
> @@ -286,19 +289,20 @@ static inline int pin_longterm_test_start(unsigned =
long arg)
>         return ret;
>  }
>
> -static inline int pin_longterm_test_read(unsigned long arg)
> +static inline int pin_longterm_test_read(struct gup_test_data *data,
> +               unsigned long arg)
>  {
>         __u64 user_addr;
>         unsigned long i;
>
> -       if (!pin_longterm_test_pages)
> +       if (!data->longterm_pages)
>                 return -EINVAL;
>
>         if (copy_from_user(&user_addr, (void __user *)arg, sizeof(user_ad=
dr)))
>                 return -EFAULT;
>
> -       for (i =3D 0; i < pin_longterm_test_nr_pages; i++) {
> -               void *addr =3D kmap_local_page(pin_longterm_test_pages[i]=
);
> +       for (i =3D 0; i < data->longterm_nr_pages; i++) {
> +               void *addr =3D kmap_local_page(data->longterm_pages[i]);
>                 unsigned long ret;
>
>                 ret =3D copy_to_user((void __user *)(unsigned long)user_a=
ddr, addr,
> @@ -314,25 +318,26 @@ static inline int pin_longterm_test_read(unsigned l=
ong arg)
>  static long pin_longterm_test_ioctl(struct file *filep, unsigned int cmd=
,
>                                     unsigned long arg)
>  {
> +       struct gup_test_data *data =3D filep->private_data;
>         int ret =3D -EINVAL;
>
> -       if (mutex_lock_killable(&pin_longterm_test_mutex))
> +       if (mutex_lock_killable(&data->longterm_mutex))
>                 return -EINTR;
>
>         switch (cmd) {
>         case PIN_LONGTERM_TEST_START:
> -               ret =3D pin_longterm_test_start(arg);
> +               ret =3D pin_longterm_test_start(data, arg);
>                 break;
>         case PIN_LONGTERM_TEST_STOP:
> -               pin_longterm_test_stop();
> +               pin_longterm_test_stop(data);
>                 ret =3D 0;
>                 break;
>         case PIN_LONGTERM_TEST_READ:
> -               ret =3D pin_longterm_test_read(arg);
> +               ret =3D pin_longterm_test_read(data, arg);
>                 break;
>         }
>
> -       mutex_unlock(&pin_longterm_test_mutex);
> +       mutex_unlock(&data->longterm_mutex);
>         return ret;
>  }
>
> @@ -371,15 +376,39 @@ static long gup_test_ioctl(struct file *filep, unsi=
gned int cmd,
>         return 0;
>  }
>
> +static int gup_test_open(struct inode *inode, struct file *file)
> +{
> +       struct gup_test_data *data;
> +       int ret;
> +
> +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       ret =3D nonseekable_open(inode, file);
> +       if (ret) {
> +               kfree(data);
> +               return ret;
> +       }
> +
> +       mutex_init(&data->longterm_mutex);
> +       file->private_data =3D data;
> +       return 0;
> +}
> +
>  static int gup_test_release(struct inode *inode, struct file *file)
>  {
> -       pin_longterm_test_stop();
> +       struct gup_test_data *data =3D file->private_data;
> +
> +       pin_longterm_test_stop(data);
> +       kfree(data);
> +       file->private_data =3D NULL;
>
>         return 0;
>  }
>
>  static const struct file_operations gup_test_fops =3D {
> -       .open =3D nonseekable_open,
> +       .open =3D gup_test_open,
>         .unlocked_ioctl =3D gup_test_ioctl,
>         .compat_ioctl =3D compat_ptr_ioctl,
>         .release =3D gup_test_release,
> --
> 2.43.0
>
>
>
> Can you review+test that change? Thanks!

Sorry for the late reply.
I tested your patch and it works fine for me.
Tested-by: Yunhui Cui <cuiyunhui@bytedance.com>

>
> --
> Cheers,
>
> David

 Thanks,
 Yunhui
