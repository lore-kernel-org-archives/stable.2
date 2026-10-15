Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5853FD21
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082772; cv=none; b=C4ky02wDDP6/lUrZzP1kqVls+8Fv6RzrP6D4LnnGxUNwudLxz+ztS121STYAVRs303Bg8xhCXG5qxPDHVZ+qRT2l80O5/MxWV2ccotiJlSmZxIg5iJch75v+GofLt/lid33kscP4F6fkaZv8vPq6j8AZlrFDsqFFZPpaMSoJnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082772; c=relaxed/simple;
	bh=5GwnoUTEvbdzFE7IbprEwb0I68ky+rVNwWoDiIYbLp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOGKb8A0oy45iGl/mOFj0rfzGzOY1sS6U4icw+6o0W6o8uKw8IaIatA9K92fwu5PmepQMn/PY0TWo2o7z4aqe+RnM/4oDPVrOR6m0MMBnqUXe0mhvz1EWSKnRGMPdHrwW5vPlvjjTCMSzIXO5K6NKwswnRHxwfhov/AQVZdV7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E/NBTi35; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E/NBTi35"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso850969a91.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082762; x=1792687562;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vKZAL7GCaxNUB//luY04416Ubt5iQBwrEKKIgVKRXfE=;
        b=eiC95wRTvt2iVI3cfqy+tV9fdpbPxeihfJy2u1JoSSiVz4vrj8qH+rDwJ4eKZNCgkO
         bSDX5IVCp+X/1RD9ZYAa0MB0tjCYwRawl+zqkmVoEml6++V1UZad+JEPYQ8sDikAwpMo
         baKXJ2DUtv6KldFAn6Y7NQoXs6YRk7B4LjVQOic/jZQGk2L8P+7bVNEZY7yi+WR2c4lB
         hf3xXfnZVVWuUPNEJU6LkUvTm+skePsXFaMix+AApuA5HXjrp2D1jpiLZRz3vznQkVUJ
         GMaEDqH0F16A9hLFcM1n5j1wQ1YlF+KPtbNZwp+E/ByXnvYiuLv1oeIAmSMevRIJ6sem
         jdAA==
X-Forwarded-Encrypted: i=1; AKwUvBzQqezCsRzfk+CJK/LjNrIaj/oIpC3SrkJdGZwAD61rEF1TPPsOa0HTyUFJzxK6Lx0vmuLS70w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoSkAKwnVwEEPTv1j2fB/T/S0ZHf5lrQ7ymzrR/DEfpvsCnU9j
	ZDsiOmWf3hB4T3fMKkfaaw9SstwTcVLjvMTExRsZ3fr6MkS62aqlLoMYPkwrBQD3efE1YJGizJH
	DaRg3wTO7DTdM+IzbdPQMFQMMkmB6g+qiP7NCGLQQQJUQnZRkoANEOdFXfcLiG2o+EagGDYhvNt
	ApWqDbwpe0vliN61VR4QCJ5yD9+AVBsjUV4lUEHHNZM6aV0/I33WQtzhSAVReRPcUaf5YfTFUxt
	e2YHI9F
X-Gm-Gg: AYBFou1tsZMqeg/7BFHWuZqWmjkQJoqmwoqcVLNtss7OHDIyoyWRud5jWWcIIh+EV9U
	KI7RfT33s/M/YoSWId5476qQYc4K+PyPLR/Vvs/mkKih21rBe0OMxaZAZBLJ8FiutIBmvyo6bIH
	NG49MOGxP4zq5L9G/HRtxAjm+45NksNXDfL8kfwbC+SC4Y0VV1YrkSMJ2QuEWLWf2rTT9Pa2w9v
	peqUKXh8Jn5YmntW+DUgfGP4vUSVg0NXIw/XX0I5Fr21nXTDAKA/C1A8OXeGEb3wHSWyTvgxfOV
	feqamz/ezbh3IUwtD+MEA/jp4Z6AdxFOedAEKUvcLd08g3oaKpZKfl+lEjAWbTyYIGfjfpPVrwB
	7WsCfY7SqR/nk5bXtcQTbfZWGcv0I8AP3Gn3dvw80mS9nByY2OT1ahd91Gi+B41QKuQ8OQUaH8b
	K7xJrdT+uiJD954q3cgvrvBqffGQ9IOifZD2I=
X-Received: by 2002:a17:90b:518d:b0:3ac:9c37:9429 with SMTP id 98e67ed59e1d1-3ac9c379aa3mr2846806a91.52.1792082762078;
        Thu, 15 Oct 2026 09:46:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac947badeasm1953028a91.8.2026.10.15.09.46.00
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 09:46:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-359b81ad4e8so3311468eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792082759; x=1792687559; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vKZAL7GCaxNUB//luY04416Ubt5iQBwrEKKIgVKRXfE=;
        b=E/NBTi352xcB3a3XwlYxOETRjW9TvQ5+QNsSpw3fnsDV2LVlh5v4pYXvWmzcypPruq
         qOM0+Cw7r8MtmFqrCD57Szq2L8SVShbUP22ukpESpZPvOCMKqkay5yiyB/ImanCUwE2V
         OOiaSgUA/uPkzSMP0b/uIlpWhdZgwRL4shhMM=
X-Forwarded-Encrypted: i=1; AKwUvBxIbwT6dhtfq3hj33KUa4XmvR2s7TjmVW9qW7OnbNdfQNwrrIcqb6OpPDy/HgN6lq4+Fz+P7Q0=@vger.kernel.org
X-Received: by 2002:a05:7301:78cd:b0:353:5908:36fc with SMTP id 5a478bee46e88-3537dfa8c6cmr25184466eec.17.1792082758899;
        Thu, 15 Oct 2026 09:45:58 -0700 (PDT)
X-Received: by 2002:a05:7301:78cd:b0:353:5908:36fc with SMTP id
 5a478bee46e88-3537dfa8c6cmr25184392eec.17.1792082757800; Thu, 15 Oct 2026
 09:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013120211.135807-1-matt@ozlabs.org> <20261013120211.135807-4-matt@ozlabs.org>
In-Reply-To: <20261013120211.135807-4-matt@ozlabs.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 15 Oct 2026 09:45:41 -0700
X-Gm-Features: AclHuK8gEHzRL7o1P7PbsprYTPQIJqIPg_1G1oX-C1t78VeDlarF5hWwxG694Uw
Message-ID: <CABQX2QOis8GJK4Mm8FEuH8UtrXF1NbeMoN8vQD5j4Hwcdk8JoA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dma-buf: Annul dmabuf->file on file release
To: Matt Evans <matt@ozlabs.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Zhenyu Wang <zhenyuw.linux@gmail.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000490629065de3c8ac"

--000000000000490629065de3c8ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 5:02=E2=80=AFAM Matt Evans <matt@ozlabs.org> wrote:
>
> The dmabuf release path is split between file and dentry release:
> dma_buf_file_release() is called shortly before the file is freed, and
> dma_buf_release() calls an exporter's dmabuf->ops->release when the
> dentry is freed.  However, the dentry can outlive the file (for
> example, if opened with O_PATH), meaning .release might be called some
> time after the file is freed.
>
> This presents a window, when closing a DMABUF file, in which
> dmabuf->file points to freed memory yet .release op has not yet been
> called.
>
> For VFIO, if a buffer's .release has not been called it's considered
> still active and subject to move/cleanup.  If so, it attempts to
> get_file_active() on dmabuf->file: a file close with dentry held open
> will call this function with a stale pointer, a UAF.
>
> To make this pattern safe, set dmabuf->file to NULL in
> dma_buf_file_release() to reflect that the associated file is now dead
> even if the DMABUF is not yet gone.  A get_file_active() ... fput()
> sequence concurrent with a file close then only executes as one of:
>
>  - Gets the file before file_ref_put() (dmabuf->file valid)
>  - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
>  - Observes dmabuf->file =3D NULL (no file)
>
> Originally, drivers could assume dmabuf->file was valid until .release
> was called from fops->release.  This assumption was no longer valid
> after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
> dentry_ops"), which moved the callback to the dentry release (by which
> point the file might have been freed).  With this commit, drivers must
> still consider that dmabuf->file could be NULL before .release.
>
> Cc: stable@vger.kernel.org
> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentr=
y_ops")
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/dma-buf/dma-buf.c | 21 ++++++++++++++++++---
>  include/linux/dma-buf.h   |  5 ++++-
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4c9add51f9ef..61485fc28b8b 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -193,11 +193,26 @@ static void dma_buf_release(struct dentry *dentry)
>
>  static int dma_buf_file_release(struct inode *inode, struct file *file)
>  {
> -       if (!is_dma_buf_file(file))
> -               return -EINVAL;
> +       struct dma_buf *dmabuf =3D file->private_data;
> +
> +       if (!dmabuf)
> +               return 0;
>
> -       __dma_buf_list_del(file->private_data);
> +       __dma_buf_list_del(dmabuf);
>
> +       /*
> +        * As the file is being closed, dmabuf->file is no longer
> +        * valid and NULL replaces an otherwise stale pointer.  If a
> +        * reference to the file isn't already held, the file can be
> +        * closed at any time, including before dmabuf->ops->release()
> +        * happens: dmabuf->file _must not_ be accessed directly.  An
> +        * exporter should use get_file_active(&dmabuf->file) which
> +        * atomically tests and acquires a reference to the file (or
> +        * returns NULL if the file has closed).  The barrier ensures
> +        * get_file_active() observes the store before file_free()
> +        * frees the memory.
> +        */
> +       smp_store_mb(dmabuf->file, NULL);
>         return 0;
>  }
>
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d15b2b31d3c9..a31eb0ab9ecf 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -303,7 +303,10 @@ struct dma_buf {
>          * @file:
>          *
>          * File pointer used for sharing buffers across, and for refcount=
ing.
> -        * See dma_buf_get() and dma_buf_put().
> +        * See dma_buf_get() and dma_buf_put().  When an exporter holds a
> +        * common lock with the ->release() callback, it can use
> +        * get_file_active(&dma_buf->file) to safely acquire a reference;
> +        * the file could otherwise be closed at any time.
>          */
>         struct file *file;
>
> --
> 2.47.3
>

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

--000000000000490629065de3c8ac
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBCL
84tfrxmEydRsa1w33yx6kN2PzfUL8NyJllPrxqdvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAxNTE2NDU1OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGzG9yKhRrbn4VGJFWDcPw20WJoiE/6KD+Cg1KqC
h6BS1xXVufGiY5gvfwlaKaa0uX1BMOOXBkCA2l+qN82gilIQSEhXBk0XzvoiE1up8Ps0m3ncoAKn
F8e87A551Eyx/OFtw+fVvLeaVYj2kkn3b+8AY/mVE7puKUU67aQ4nz3A80sIR2S5KfvnuxkXndSA
+inJYcHuzXJG2OlbN1wvw38nsQCiVR+XbeSCih3eal0TAIO/c2oIUGF9TH5rjMn0ieVUtp1Mcn4J
3/gCN7TwPt6dfmultyHXyj6LJ/ImFSvZarTc+BRxJziqjHIqJmdez6sAKsbQU4XBT0G8XV42JZE=
--000000000000490629065de3c8ac--
