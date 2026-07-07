Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342B42E8C7
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437895; cv=pass; b=dubaEEOL2R790GGbL3GQTMlmnN79dEepyk6rBFLpFbPy9qqub3C/wvv1DfntpgYV1b6AlSU+5hkwuMe8nPehK705mzkI8ZLe5ixBGV/l/T3o96R8mTLNSRMMAQfUklxAAvjRy+2edVRqAY1OxffAGyGtzIscIBVTAsaIfj2K11s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437895; c=relaxed/simple;
	bh=0njRmYSn4poVC/mArPlC/fR3QLIUbG65yqc9jFtPFNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTEJnT3+f8hDjtw6g6EM2KOdIWKrHfRaZ74F9BgE9/MgaG+Ol6kA8PimWvRSJ1ayP29pE2fnmIbDSNCk0UpmypSUAm1u+H3oWiHdsonY+yGP5BK6GJeWGM1DXYWgMBHHkZpPN6wZP4ARA4uziTqE2s6F/QKDv0Qplf/7WfbkmcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyJhP/in; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyJhP/in"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664ce3000e6so3655484d50.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 08:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783437893; cv=none;
        d=google.com; s=arc-20260327;
        b=RYPh29cPHa31BiUfsQaQ9cvfI5bGomZ6MOkbUPnkjQVgkTBaHCevQklK9B83zOQMyB
         yIcshauLTxSXXPVMXI4n9ruXKQxUY2Orhxlp01pNfz2IIb7UC2Es6kGhuwpkChadLv4R
         G5MqLvFyXGdpzqdxqqfbjuFvZIfxKBuG7hC1Hf4GekGnPnULyKfsW14APs07TgFdmkNd
         0iMkailv0fTyMLMqQqBhD/hWcOrO0/hOpUfqnbCKAv0atifjhOxC78yKozU7Uu+pywna
         DCjn3Ah0jlt9lRAf2YDw0wiIQT7jjwkOfZOQTke21yzwb9hXCItgooN22cBsZ8cmlSqG
         aAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zr16SPndHGc73+Bu8u8Xgo96h3SOtHbZhzKK4VPFL3g=;
        fh=y1sEBgn4ja/XKqDwORbuLe/YbtYPJGn+SnDN7o8PATA=;
        b=Kwf0tX9308eXJYxdOcBBKXvUOOYzVeNd+msqG9YqvbjiRo87vdom6uUHsIIxNLzRM3
         /KPPkZVZ+II6uRPlZRTOrxKtOFpDblorpnGeKiZHrYhF8V9Lu0NO3g/JAEWGEJyd6or7
         q12Q+z/H4Apo2WurGvfwpatTtX7SeXywhjno50r335J7sgjiyR1nCOUQKIRV01I+oPBW
         hr3Asbj4vUVryslQ4Oz6Oe4rNf2T15mW/lh1YIoKVgQWInxHcMkjgyI+Vt+jBIG/7Xjv
         5B1DFfDAzxrIYq6rrk6KcnFPQ1hL6xY2alfJlzt4xOYu/bHENsa0s8hyxaoYuRSbDvRM
         v83Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437893; x=1784042693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zr16SPndHGc73+Bu8u8Xgo96h3SOtHbZhzKK4VPFL3g=;
        b=HyJhP/insW/J8beX7sgofJ814t3vsN7LMdaZ0wkxiq9EsbQA5PDjxLTACz+PiyWBym
         oNB/BQ8OAjkaBGbS7sGG+QnZea4sEyAY/zTzEYVeJG9YDIArS/kSQq0Ge0TK/DYcyYRA
         l+w9fJCKtm9TXBHMeoDLwIREKdR4bGQrMcDZOZyVLT9LwVbU0qOPLjUKNcxYBasEQZES
         HgOg1zqZcLOXHnO4CAQG50E4yBG4gD7cxKEjIfEc/n1J4YOvc/08N70nlFPuT7bAYIaV
         IwCdaNyXOZSnwi3lvrFAYOo3mh37VomZ90O2M8cIz7CEOfuGZiTlOooFcocaaLKE7fKo
         XwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437893; x=1784042693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zr16SPndHGc73+Bu8u8Xgo96h3SOtHbZhzKK4VPFL3g=;
        b=qaFU8eMFmadhM08nXPbpJ2eQS9Dk3kVtuKwooLh6X32dYlLoed3m2esjIOv9VBZASQ
         ioyj+tXAJkMmEeMneBpdalxNnW1wXoSmCUi5J995GW5dzpzewtF3OhiWyGjBC4JOmPHH
         y9k28UGJ7+gdfmOnCAUJafO4PmZDnoZTqnwpuvflE5EU0qnuzcuIf0xxRs4gFOHjTXcx
         pzllPym1QkQf3XdmCRjP8N+LVTUT4FIpjAnBL8hnclH/ToopWyitFuIcjcl8/ABlANOx
         TTiYUHhPqMdaiKPEg88GRhkgT3rrW+82Mp2vMP7o83kA4hDKFQO6urt/gSum5IgUce8b
         rCcw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3wmUtSsvv1e+OinKGzQE38m6XfJX7ijhPfxAlKO6b9MnuRTyhDNbLnE4Pzz3oSmFGnVXJgBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZqYWaU6Ow09Ncx2jhyCNR8ZFjAMiHBZRW/Ti94D878OyKyPE
	4bcu3pSuIvoJGh+xQ/jGCRb7kv6Kz+xFgZ7gGAyF/GC6mwkUFC+XZHN1uqyHicVd6weN/aREwBu
	csr5Gn5zkQ2lBrkCKv1J+NGxL9gJh7Og=
X-Gm-Gg: AfdE7cmkHm481H3HoPAyw3M9RV4MzDH3DULijcJ1V/dTyg/OX7c9XkZ95+VnFMI96qc
	8YBhvhJ3OYUPbMhvKJiG23II8CiQYKVgoSy/aLI9tiYpw5phBCR+t2iTKovpg4M0Qh3Sq1WqHm1
	rVkDkLWe9k6uhZ6m9lfQ5AYGyGr1qeBgAz0QymIfBULIfLNZyK0pDDXUUovitwAmLLl4zRda72k
	Sp1zvJyWKAEjJ+Gi21K2VHnKin/oN3CZIQZw04wAHllbFXxttNqAZtMaBCuPNn9tzvyRST97J9b
	1kTPoB/NVL/PlGHUXPhSXCn8XZpaRB/48zCvkoK/sxDSWScYddCKiIwgfTc=
X-Received: by 2002:a05:690e:43cf:b0:664:ae6a:ef0 with SMTP id
 956f58d0204a3-6677fde0a83mr2583709d50.78.1783437888639; Tue, 07 Jul 2026
 08:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707072955.3093138-1-haoxiang_li2024@163.com>
In-Reply-To: <20260707072955.3093138-1-haoxiang_li2024@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Jul 2026 11:24:37 -0400
X-Gm-Features: AVVi8CdZEiVUSZgzA4k-tWFUHnxIdsPOK0Oc2mjU0zfxCwAA-C_N3ia-In58D3Y
Message-ID: <CABBYNZ+Bjs2U-gsWFisYG7vHKE2JCFDJmRyBvcGM1c7fC=4BiQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: virtio: Fix HCI device unregister on probe failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, mst@redhat.com, error27@gmail.com, 
	yangyingliang@huawei.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haoxiang,

On Tue, Jul 7, 2026 at 3:30=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.com=
> wrote:
>
> virtbt_probe() registers the HCI device before opening the virtio
> Bluetooth device. If virtbt_open_vdev() fails, the error path frees
> the HCI device without unregistering it first.
>
> The probe error paths also leak the virtio_bluetooth structure after it
> has been allocated.
>
> Rework the probe error handling into an unwind ladder so each failure
> path releases the resources acquired earlier. Also close the virtio
> device before unregistering the HCI device in virtbt_remove(), matching
> the cleanup order used by the probe failure path.
>
> Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver"=
)
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Rework virtbt_probe() error paths into an unwind ladder.
>  - Free vbt on probe failures.
>  - Reset the virtio device and unregister the HCI device before freeing i=
t
>    when virtbt_open_vdev() fails.
>  - Close the virtio device before unregistering the HCI device in remove(=
).
>
>    Thanks Dan for the suggestions. The blog is very helpful.
> Changes in v3:
>  - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.
> ---
>  drivers/bluetooth/virtio_bt.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.=
c
> index 140ab55c9fc5..c063c2391c5c 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>
>         err =3D virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info,=
 NULL);
>         if (err)
> -               return err;
> +               goto err_free_vbt;
>
>         hdev =3D hci_alloc_dev();
>         if (!hdev) {
>                 err =3D -ENOMEM;
> -               goto failed;
> +               goto err_del_vqs;
>         }
>
>         vbt->hdev =3D hdev;
> @@ -383,23 +383,27 @@ static int virtbt_probe(struct virtio_device *vdev)
>         if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
>                 hci_set_aosp_capable(hdev);
>
> -       if (hci_register_dev(hdev) < 0) {
> -               hci_free_dev(hdev);
> +       err =3D hci_register_dev(hdev);
> +       if (err < 0) {
>                 err =3D -EBUSY;
> -               goto failed;
> +               goto err_free_hdev;
>         }
>
>         virtio_device_ready(vdev);
>         err =3D virtbt_open_vdev(vbt);
>         if (err)
> -               goto open_failed;
> +               goto err_unregister_hdev;
>
>         return 0;
>
> -open_failed:
> +err_unregister_hdev:
> +       hci_unregister_dev(hdev);
> +err_free_hdev:
>         hci_free_dev(hdev);
> -failed:
> +err_del_vqs:
>         vdev->config->del_vqs(vdev);
> +err_free_vbt:
> +       kfree(vbt);

Sashiko flagged a new problem regarding the code above:

https://sashiko.dev/#/patchset/20260707072955.3093138-1-haoxiang_li2024%401=
63.com

>         return err;
>  }
>
> @@ -408,10 +412,10 @@ static void virtbt_remove(struct virtio_device *vde=
v)
>         struct virtio_bluetooth *vbt =3D vdev->priv;
>         struct hci_dev *hdev =3D vbt->hdev;
>
> -       hci_unregister_dev(hdev);
>         virtio_reset_device(vdev);
>         virtbt_close_vdev(vbt);
>
> +       hci_unregister_dev(hdev);
>         hci_free_dev(hdev);
>         vbt->hdev =3D NULL;
>
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
