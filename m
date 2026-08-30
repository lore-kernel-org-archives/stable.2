Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8032F3621
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788071145; cv=pass; b=YV+wibfSZR7WHnRS6jPX63YbCYb3/OXPYFdMD7/FtAEdXlgn1bCEb+hj5uKuMCQdUluCivAFyYnLcsZgVAyQ+hK1aj7CY+GSuCnCvxna6ScmdmiCvZQ3FpOOHWxfxYpZ3LAEwt7PYxmDE9VNE1itoJ/dhYcFlSKw7Yd7243wbn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788071145; c=relaxed/simple;
	bh=GalG5KeewwDo5F/yvEnnWSTdgiJ/XKsm/a64IaDoohc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlqZYrypKfGaFrXmY+6fk58s5bIpP676MDnaJQ8bk5/+33I44IQhZ7696Iv3tf16IRqh/EXjNuC+SA8Bn2EC3bcWaOIGXKKnMnRE0XrNweOZ157tAvMYOlvvOLEqAItAvjbZN34w9uR1Zc+NKxcvsZub3aLSbFpYEvmSJgTIxqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpQOb0eg; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpQOb0eg"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66d0743503aso3440970d50.3
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 23:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788071143; cv=none;
        d=google.com; s=arc-20260327;
        b=cZWANNqsaZ1ZrY5mqpUYv3pqKkBg0QbLYDBBplOhfkgVXKexUZNREF6gPMRniySffH
         4RBlCNFEc0W2qspvKzFXzJ9SG6IsyroU1w73JX56g4jZg90zzZaRiA3wBOCoEfighxst
         PUX7Bbvhhnt4sbDmS66k/AZCkzPJHKzUb3kebQ0DkaPxKN1J9LZN3fptmaMoBN/LSNKI
         YOGeeFlUyfekLExHd2bhXZL21ymLFg+MogLN0KO6Zdc18UDSis01RmYhi9rXJr0pTCMX
         2Srds+Zp4Qr6fVDQD0cuHX5m1cncpufabPKS3KJFANGSh/NYhAfFinVvbisgR83+ClPx
         SHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
        fh=IDtR4XLhUNqRwZzBI0yN03pSVczY2yOM8KGsnAHGB38=;
        b=PiGFhuwHB51xLe33O5+53Ox7fI2tl9QISjbi4hvjthEtlegX//dKlWFb/sHP6koEbh
         1TIIfrvo70GE1+KQqfXZr6aPJOWck1stal+e60VY0e1JRPDl+0Y+idrOxb3yYHT5FsNj
         t8S+bSJMQv/cwK8owRvxUaOn0O86zRKxonSfAgn8BXP7Vdh8yibWkAjceNKfi6YI7D8N
         D2FcDJZcxgAhTDFtPWHYjPPCm+K8MtB4tNWj9J0G1KO/B79UGmTDSfBi5calZuzgWA1o
         6dFPF/KkfDus+A3UdLd+VdLasMVnRxZ9oz3hrDgysL+dLIiHJQ5pvSMFdE6fAUTa+65a
         cCag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788071143; x=1788675943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
        b=PpQOb0eg2Gla59JRcMDKsW5dzbrkjlT0LCsL8mbWFGXTCIqO5ZXs6+MSNQgmRkl5Ep
         tVlmrk2rZucczL42ZdKfLCSYD/K8cya4PuGKPvulQecTdM5ftNbh98xylPln093PHjQv
         m/o2ctNWXfK1a0a204PLSD7On2HIIPDNvn76X2tdx4bbazlq1Kv+0IRw1UNw2bc7PEMN
         Z0UHdKYaRRtocYddTl6KCu8A4Dd25ee5UyUjGFBBF1xqG+KKmAbKbaKApecBliMRfD1I
         NQZkigV5Z/b6mt8TAvuU0wDLKzilxXpkXJWzI/Iv+FDMxVvkczH/tZkdHk8YchEJ6jTf
         oGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788071143; x=1788675943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
        b=rJOzKZxCJt+ItQSRjd3jOdOBaAb9xvyayb7GWVnQdN4Ckx9TxL1/icIZaFPwSiBSR9
         y3MIrfxBz4BThU+tjgWTkjqiEPb3zEQitFGtpGyszFLY+rEsP5djxx3TYLAJGDqJ/UTf
         pjFURodJQvrE2z7vmXyV3zFAC+qadRZbeTCQt0Ubun89efNbmadwmZFJtvHp1hE4PXea
         F+5lJZ35sDPHvaRMxmYTxCNM6h7jImOM27xsuQb3v8K3W4XRi32tghj+WjQ0L8SQdxc0
         B/nNpCRHHMLddrmgzq/7d87KjBiC9nZ6Y/Q9vjSv1V0HxH8ysGcpuNO8QGa8ydp1DFTO
         BOgQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6tmrDY9e5MJn6pfkkKgRN8aROfS6YlyqnxCVwEC4buFmR8NFX4YiZZIbv2s9DDnIjotoh/j4=@vger.kernel.org
X-Gm-Message-State: AFuF++lKjnk2l1Dljxzchqq+6ONHxFvTE5hnFSQF7Pta/eazZLy9+3Kt
	f27mGG/Hlx/cPO+nIZ49uDa6QtzCEodmV+WAEQmSyITtG2K18CiHTytr3UbXHmr6NmRa6YHVxDO
	n1UQ//LuxNyD8qaBIXn8sY5oPXrHAFko=
X-Gm-Gg: AYBFou06tcgK0LCnlcGpW9nUGdJazYbge40tZvBN4nabu9f/FEppjCXYANWQ5o/QnQ3
	hA3rZ41JKzkhhh5TOQugE4JqiStw4oKpYcLRMuvj2YNoH8UaWqkKKUxoRvDhAPdzsqzx7Hi9Mqn
	bDlt3igoe+j9x+nLtYNcc5WQMLruEyW5NkCGCIlsW/p7MqAxYAy8jAQBgDLJw1EkYA+wW3+iK2t
	WsXgFm+cmxHY/AhH3IEcOuxbtLN3VNJEhMuscoYpSzAgk1PHxT9c6XLrWrJypb9M/AYJZe/rX2Z
	Gh8oGC5032tt2IVDrb11kVcV1EMTbDazQriKcsQpFz+ggR2mrwB+V0aZ+rb2SHqJ2utseAXftKv
	RzDEzGTqSDzQpveJhuSUqvjp8u1huEbs/TA==
X-Received: by 2002:a05:690e:480b:b0:66e:61be:b280 with SMTP id
 956f58d0204a3-66e61beb351mr919322d50.48.1788071143285; Sat, 29 Aug 2026
 23:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813064902.367504-1-kartikey406@gmail.com>
In-Reply-To: <20260813064902.367504-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 30 Aug 2026 11:55:31 +0530
X-Gm-Features: AcwNN1Uz1IASuABwBGrNzT8vqscd8g3KsyTVjcnjYQteHxWUUv-5lbfRLHAaf4c
Message-ID: <CADhLXY4YXGWUi8JcfdYMJ4HhKMKS2RLg2WvnZnku_XK45m4-fQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: Guard against NULL driver_data in i915_pci_probe()
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, 
	simona@ffwll.ch, krzysztof.karas@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 12:19=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> pci_match_device() can return the dummy pci_device_id_any entry
> when a device is force-bound via sysfs driver_override, in which
> case ->driver_data is unset (NULL). i915_pci_probe() casts it to
> struct intel_device_info * unconditionally and dereferences
> intel_info->require_force_probe, causing a NULL-ptr-deref.
>
> Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ddb96c5ff032f4292a8dc
> Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2: Drop Fixes tag, this isn't a regression from a single commit -
>     the unconditional dereference of ->driver_data has always assumed
>     it points into a MODULE_DEVICE_TABLE()-backed entry, an assumption
>     broken by the generic driver_override fallback path, not by any
>     i915-specific change. Add Cc: stable instead. (Krzysztof, Jani)
> ---
>  drivers/gpu/drm/i915/i915_pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_=
pci.c
> index 82415af47d54..2f03f95945f1 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>                 (struct intel_device_info *) ent->driver_data;
>         int err;
>
> +       if (!intel_info)
> +               return -ENODEV;
> +
>         if (intel_info->require_force_probe && !id_forced(pdev->device)) =
{
>                 dev_info(&pdev->dev,
>                          "Your graphics device %04x is not properly suppo=
rted by i915 in this\n"
> --
> 2.43.0
>

Gente Reminder. Let me know the status of this patch .

Thanks

Deepanshu
