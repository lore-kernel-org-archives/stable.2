Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FB3EC83E
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517786; cv=pass; b=ANR+qlUrT1xRC7VwtOQXdunVWpaRXoSAE7rVcnwqXbiw7HE/jT+3/GD5dUnsB4td5Vr57BzmMk1M7vFAjcXilClFn0tILhjAqUzvyQ5ZhhsuXa1PRXqwRX/FrkUy3jYW4kJJF5AK5rMb6snMRHK+FoMocx1xeLiRmHthCayVbcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517786; c=relaxed/simple;
	bh=SGnU8ndmqc2cOQNVQijYcEoZB/mRA29TzSUInrx/7fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9DmU5pQtVBIhWlIXzZ6o/RZGBHgMjh43KM+YWz/HHzTMqLn7JkIPw4Vl6uXAgcRjEosDM9PfylYhDZvOROv5OQq4mkFJuMrjH2rH7OiiW3yP+WoFaxjo/TqfNj0a0+ilhKTvfQGUcxcd6zR9+Loe8Z5LdPNGtAPXdJN/86hvjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soKMoDtn; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soKMoDtn"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so128a12.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785517782; cv=none;
        d=google.com; s=arc-20260327;
        b=S/rNeSZqErKgxxcm60f52P+S3cFfcVLLkdYINhpEu8lrvChkdMkhg7SRhqZzvaFBjj
         PRUc/9P3AoY0EqeB524yYyqh0TIcMzAO+UURtK8N5kHkgHqxp7YVuF+ZVtUurjbx2uj6
         Ht1oy/6+naffJk48ZeXTb9AlvO+6Jdvphj3CdIszHwzZ8HP1jMVvV1mRAxF4SNxS5MXX
         Bs9QXEW6inYauc7o/3hS14+M4ChfeSJJ5ba5kPHlJdtgoJGlrhCCYSmjKdnBTXJnQyVM
         +pq48BtvdBnlOPPKeQmRG04aXSHwZwfE6r57zLVFXLRb2IZ+aveQ9K72dDqk9XDQ1dt6
         82vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dAd7HPjjkQI/SIGWOZj/gTVuJd8LLOcZPRtgUcY8yWU=;
        fh=zG7a49fMtvhnJmLlnjf0mwxDQl9vtG0eCatJrqjMV3g=;
        b=NDDKTt+yJL7wJQAA/ubKNkVrm9SoUCNejdY3fRYLjn3m5dJw4gvsV1cHa64MbRqBcm
         1GLgSBAoy+sJPomNerPw370QV+av7zPNr7D5xsnSVFILi/usPf9uqzpE/O18ZWlhDX05
         0QT5eoGjiXpWZEKxpAtySy99kFymEk9YY7yPI4JVqlGaDto1AuWJlqfCb+JVdwD49nFB
         kdmSUE7/X3zPqAMzpWZQzXUcEG+KLb743HvnZAzOt6s/8uQrSZ31Mg7qeeMb2WU/9Hl/
         YyKOxDt+8DStyghQ4rmKFJ1BxVU3ObT/pA0+EzNllkeVjn1Ntrs1J33qe2b5YRkOB/eF
         WBxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785517782; x=1786122582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dAd7HPjjkQI/SIGWOZj/gTVuJd8LLOcZPRtgUcY8yWU=;
        b=soKMoDtnCFJrGNUZq/nMDvyucFeYoEFOYXsYj/g9MEm1aAUuctMKzsDrpxiLwjGRSS
         OXnxGLASfVuTKYefqPmd1CQxcm4GfehlAnU5yJbeM+Y8SGroHcSWpM2CRYxYVLgMJqWo
         d/rnTtOLOf3u2BUc4zCpMdd/8avZM78XMrOpt9L8WXKp9Zj8uGHrHthd4K5tA0TAhoGn
         5dmT/gFvfbzKt9SKOOeIXOPktAEHgQmb67vfXLoB1gJgLX6dit/zucKrVDsxOZFQTapV
         Sj5ijXoB2ZJCb9VwCP1/iRaRrEAbNL+W866kIgbmVM6bm8tp/BVNP+DtkvGzU2nFr8k9
         jO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517782; x=1786122582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAd7HPjjkQI/SIGWOZj/gTVuJd8LLOcZPRtgUcY8yWU=;
        b=F3Xg+DJnIDSFy5qlqn8pMqGH7JkER3cfLmBhrFDacHvYRhRYjwDoKwipYpAqwkiI8Q
         f9wW9CF0cA9HiFhsktdQK/XxeuKc60dzVHiAhnEmTs3QUB0CzQOEKRJjgn/lwWC4XN/b
         r2LAXK4/dFHya3tYrtNkeDOLTkWL2ke3MAjPdBdGWuiLuXrIjSleLfjTFVPaeQ5ghJ50
         Ub0tPwS2aXUbPsm6wt/1T47av+z5UG9j0SWUYmvahNgUxrjuroIfZXxyJfkDwYNTxEsU
         FD04cpDfq6uQ7uOCQMQpg9UvGoPwmGT319CkRpu2re12SoPytl3QTKDYUODyl+Q08xAx
         RxCg==
X-Forwarded-Encrypted: i=1; AHgh+RrJ2CenjHMvGncEwXV1WZlvmXhMu4fay0vNwtlZ26wezBpdoi+iaFoIYjp5astUadKa+/chKzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXbdXBqDLVZwBck960OYBXXxtQNJL+jNz9xVZezUxEn5BYlhE
	BMG61ZRfOEXZIKxSxZXS3AXyMUTPVyjKL6MwWp581tyO+vmwseF8SfX146MldqGpvbfUdxAAkKk
	4coGCEHLodrgIzYIlHOEwFm0mIC6jypjpIIyQvqX6
X-Gm-Gg: AR+sD12celmHm4xCo2QxMO9F+UoDm3JY3njrIPlh1qsX6c6gD6BkdMF6fZNfDs2UVhQ
	QoQXVQ1Z1aUFCN1tVLWXhpKyGmjzlVRJ4JqFhY4IL7iYTAtW27JA4ppH53DJE6rv7rOjDo2fSmL
	mBCPtqhQi9Cq4kXBhc0vklKRIt3BL90W7vOogWXrYXP8GOw7XXsdpwRsgZ+Hn6kGdQsepOk+Hvj
	1lHFRRX/nh2pOQvHfUG0IKTU/u2wBuU2s4xJ1gHBhNOggVXGMIUo9T/axIsBMxAOfsXUD/jiyxS
	u810ZxxK/KGPQ7UkKs2Brm+k0FKcD1UaBv/MsPJxGeMTeKdWr5Gg3FPW/bfdHOxGpUps6v7njIw
	=
X-Received: by 2002:a05:6402:2026:b0:698:59af:fb08 with SMTP id
 4fb4d7f45d1cf-6a0a84739a5mr1867a12.4.1785517781953; Fri, 31 Jul 2026 10:09:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com> <20260730062645.233148-5-shoubaineng@gmail.com>
In-Reply-To: <20260730062645.233148-5-shoubaineng@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 31 Jul 2026 10:09:29 -0700
X-Gm-Features: AUfX_mx3Qaq7BDuII8fTCRVTL26nO0JrgnBnCyuW4BamF3HcDjaGYhRibygRVek
Message-ID: <CABdmKX1bd4qsTqM5C+a83TmtgBKJ=nOefuhNr-SnyqAZMsh99w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
	"Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla <srini@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:27=E2=80=AFPM Baineng Shou <shoubaineng@gmail.co=
m> wrote:
>
> Add a test case that verifies no file descriptor is leaked when
> DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails
> to deliver the fd number back to userspace.
>
> The failure is triggered by placing the ioctl argument in a private
> anonymous page and flipping it to PROT_READ (via mprotect) between
> the kernel's copy_from_user() and copy_to_user() calls.  With the
> buggy kernel the ioctl returns -EFAULT but leaves an extra open fd
> in the process's fd table; with the fixed kernel the fd count is
> unchanged.
>
> This serves as a regression test for:
>   "dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"
>
> Suggested-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
> ---
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 115 +++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index fc9694fc4e89..bd58e5b06c8b 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -390,6 +390,118 @@ static void test_alloc_errors(char *heap_name)
>         close(heap_fd);
>  }
>
> +/*
> + * test_alloc_no_fd_leak_on_efault - verify no fd is leaked when
> + * copy_to_user() fails during DMA_HEAP_IOCTL_ALLOC.
> + *
> + * The bug: dma_buf_fd() called fd_install() before copy_to_user().
> + * If copy_to_user() then failed (e.g. via mprotect), the fd was
> + * silently installed in the fd table but never returned to userspace.
> + *
> + * The fix: reserve the fd with get_unused_fd_flags() first, attempt
> + * copy_to_user(), and only call fd_install() on success.
> + *
> + * We trigger the failure by placing the ioctl argument in a page,
> + * flipping it to PROT_READ between copy_from_user and copy_to_user,
> + * and counting open file descriptors before and after.
> + */
> +static void test_alloc_no_fd_leak_on_efault(char *heap_name)
> +{
> +       int heap_fd =3D -1;
> +       int fd_before, fd_after;
> +       int ret;
> +       long page_size;
> +       struct dma_heap_allocation_data *req;
> +
> +       ksft_print_msg("Testing no fd leak when copy_to_user() fails:\n")=
;
> +
> +       heap_fd =3D dmabuf_heap_open(heap_name);
> +
> +       page_size =3D sysconf(_SC_PAGESIZE);
> +
> +       /*
> +        * Place the ioctl argument in its own private anonymous page so
> +        * we can flip its protection independently.
> +        */
> +       req =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (req =3D=3D MAP_FAILED) {
> +               ksft_test_result_fail("mmap failed: %s\n", strerror(errno=
));
> +               goto out;
> +       }
> +
> +       memset(req, 0, sizeof(*req));
> +       req->len      =3D page_size;
> +       req->fd_flags =3D O_RDWR | O_CLOEXEC;
> +
> +       /* Count open fds before the ioctl */
> +       fd_before =3D 0;
> +       {
> +               DIR *d =3D opendir("/proc/self/fd");
> +               struct dirent *de;
> +
> +               if (!d) {
> +                       ksft_test_result_fail("opendir /proc/self/fd: %s\=
n",
> +                                             strerror(errno));
> +                       munmap(req, page_size);
> +                       goto out;
> +               }
> +               while ((de =3D readdir(d)))
> +                       if (de->d_name[0] !=3D '.')
> +                               fd_before++;
> +               closedir(d);
> +               /* subtract the fd opened by opendir itself */

But no actual subtraction?

> +       }
> +
> +       /*
> +        * Make the page read-only: copy_from_user() in the kernel will
> +        * still succeed (it already ran),

Huh? copy_from_user hasn't run yet. That happens inside the ioctl().

>            but copy_to_user() that writes
> +        * the fd number back will fault.
> +        */
> +       mprotect(req, page_size, PROT_READ);
> +
> +       ret =3D ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
> +
> +       /* Re-allow writes so munmap can clean up */
> +       mprotect(req, page_size, PROT_READ | PROT_WRITE);
> +       munmap(req, page_size);
> +
> +       if (ret !=3D -1 || errno !=3D EFAULT) {

This looks like you meant &&, but I think we should just fail if ret
!=3D -1. Either the mprotect is broken, or dma-heap didn't actually try
to copy_to_user.

> +               /*
> +                * If the ioctl didn't fail with EFAULT, either the kerne=
l
> +                * handled it differently or mprotect raced.

mprotect is synchronous, how could it race with anything here?

>                   Skip rather
> +                * than giving a false pass/fail.
> +                */
> +               ksft_test_result_skip(
> +                       "ioctl did not return EFAULT (ret=3D%d errno=3D%d=
), skipping\n",
> +                       ret, errno);
> +               goto out;
> +       }
> +
> +       /* Count open fds after the failed ioctl */
> +       fd_after =3D 0;
> +       {
> +               DIR *d =3D opendir("/proc/self/fd");
> +               struct dirent *de;
> +
> +               if (!d) {
> +                       ksft_test_result_fail("opendir /proc/self/fd: %s\=
n",
> +                                             strerror(errno));
> +                       goto out;
> +               }
> +               while ((de =3D readdir(d)))
> +                       if (de->d_name[0] !=3D '.')
> +                               fd_after++;
> +               closedir(d);
> +       }
> +
> +       ksft_test_result(fd_before =3D=3D fd_after,
> +                        "no fd leak on EFAULT: before=3D%d after=3D%d\n"=
,

This is for the failure case, so I don't think the "no" should be in the st=
ring.

> +                        fd_before, fd_after);
> +out:
> +       close(heap_fd);
> +}
> +
>  static int numer_of_heaps(void)
>  {
>         DIR *d =3D opendir(DEVPATH);
> @@ -420,7 +532,7 @@ int main(void)
>                 return KSFT_SKIP;
>         }
>
> -       ksft_set_plan(11 * numer_of_heaps());
> +       ksft_set_plan(12 * numer_of_heaps());
>
>         while ((dir =3D readdir(d))) {
>                 if (!strncmp(dir->d_name, ".", 2))
> @@ -435,6 +547,7 @@ int main(void)
>                 test_alloc_zeroed(dir->d_name, ONE_MEG);
>                 test_alloc_compat(dir->d_name);
>                 test_alloc_errors(dir->d_name);
> +               test_alloc_no_fd_leak_on_efault(dir->d_name);
>         }
>         closedir(d);
>
> --
> 2.34.1
>
