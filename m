Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA03352029
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276717; cv=pass; b=Pvgc4MCfLsWevYIPeoeOCEc7Zgs/G2QPjJsxEpspBN/yHg2KUQ0EsWxUzKRATX7eEb5bIAUtdK6TOh2OywVDXMkwHROQm0s2F8UT0a/zwAPRz3Hp67BBPoM6SNoQMQuHRQPpF1xNX7ivDdd1L8heuwO0SyNVTbn3b+gsqt4eqbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276717; c=relaxed/simple;
	bh=GalG5KeewwDo5F/yvEnnWSTdgiJ/XKsm/a64IaDoohc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpxI6WnIt+H1qgOJwpMszX2hh3thMhKYiAAb48FfGYWZIdLyKVyqtY6iKx2NKQYPDjt8f8nzYNP5aZ45A5nSUa9bVkb8V5ellT/4rYHxu457x37JUSeamZlvTITJppuPkk2SuVjziJKfzOFkzRinBEGs6+Sz4yZJ42YiHpRycWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDvpS6AY; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDvpS6AY"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c70d73210so582743d50.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787276714; cv=none;
        d=google.com; s=arc-20260327;
        b=eErIhYO9mbWa2YmT1DilSDYjmtVhpcuFlyd5ugQAdZsocFvd//kKXHiFbAF13cRq8d
         ezeOzSwCAhVePD7HK4b+If6ynk56jn/Yj+33SmrSkFEBGykuMdlsoCneELIRoIrIsiPX
         kiD7E6BTxWacFu81ih17ugUH8YwGA4hJXoIuk9LzZAq0Rh7uyGlqYqYDRp9nWPqi4JGx
         YhdqmbiPewvS+r2AQphQEiFS2aTe3vkKm2B48iyU1n5UuwoOHloany8qhC0GyLKiKv+c
         /qKkznO8wH7yQSXjNeDwXQF27Y5OkM8TmvLztXvs1VYzyjU7zoTzQ9Wab8PVmusjMRVw
         j77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
        fh=SiOGIuEav5nD6gszWFaWgnTu2cu/hmCdubXQm8XLTSA=;
        b=bkfomhY+s+Xa5sehC7A85+XCg8ZCqWZ6Su9qqQmD8BhiEv9qsWC1zw9jVweR6udxeO
         Adi/wvX/14vbfKc3WePkBdw7ALUJXu6AAKDBycCntIB/t2DvKGBALGWMo7A9Qc0eXF90
         cZ4hITMd/Qo7HyrS2CxFcWbCB7+Qimm2Dl0ie/CpYtVhpbjwOBOzqCb5MWeh7n39bQDF
         FLvOHSiteLgbV+Aws7nqHewWPNS72yQn/jykTavRyJKBryOn9bcyVUKscG9D0p+A4ofV
         rQ9azyswTwwon9r1DZZah3pl+lCW2EUhi1CngI4tlwuI4XTR4+nVRO2SNQRIdAF3e0eS
         ZKPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276714; x=1787881514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
        b=DDvpS6AYoxwjfQbd68vh3RBexhASsJezUyeqhYO5LD7/IbyNTT2eEiRMt2mYVPEmL+
         K96IeHJLXoMxhTyL7dSNoPpBfs5skoVabKmMBBoXEoRuA7IYvuN+M8NQS+MDiajUpRTx
         kAZyudxViONPr8iE0Bs4LiYMA75CnNOcRN+xfhTLqu3+7+W6yYwcosJPiGTyN3D/kjOf
         CQOp9ilduqYHtjbwXjmJ27hHjLeRo49g9QUQEck72ekbes3oaFeyTEqF9bR0J3i4Dlcx
         yVd2/lsPR5n533oemKwcHDvBN1ncU34eY2NRkg89CDjY/l+PBry3auJygd+2hMO/Vz+p
         RzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276714; x=1787881514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ie2zZl8YsHAeQXHgNP1pjeAs7NQ+FFglXIo7DLINxR8=;
        b=qifR/tpJioBR/ObG5mCKp+EDMviRzPBhyK0Qbx2pwN4N01UPozMuFwQHnv5PonBdfk
         GXCiGaQsOqPJIRDAdLZgzvWfi8rRk3iHYf++L7QRKbl1kEOO8WPPGDH4YU8C1/SngJhC
         P+/FhPbWCjr5CTt6lRWtTuE9ZbLR/O8oMCfgmGA/dpriL4piLhUROLledmui0p/+3Tar
         DmCdYtdw3EQn6wQkT3v2xkISR/QvS0YBU1rhQA4iDd92LO6Q3nhtFZXJYvz3MT4Bcj5x
         KMnSNtIj3bx5l5zKsskjZOJuVJWAQwfOV3O/N/lwUzCaDxBvsJm4CloHuq75fl9LtoTN
         7owQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqm9sefdlyNL2BtZi3VnRiJmJ9r0BLB5TH7CRrmGTJG0wjDJOYpaOTFYCzNqgWiHz0Ti0u2yVk=@vger.kernel.org
X-Gm-Message-State: AFuF++kALS8TkNCWAJFAOBUaoontKqqMBP998RTdEtHlpPWI7FiDP27D
	Rf/WFux8NTGRwRvhjaKccKPFckLLQZGkbuYjj/YrCoVGxTKiWzSCTVMnzD7ximh5P+6G2DUkP6J
	EGRzQkfZYccdt5KixOT2s5qUiW5oSUhI=
X-Gm-Gg: AR+sD10WwPl8M6F5IGRYigqUGCW6znGTV8IrkFBqssVHIL56sgy+eHW/zJafyQvq46J
	6K0alP34nqgAbX4Hwv64hPBaMsb1BGCqQQA4o77ifE+C1PEsoXh4bpgmHNuOO1XM1JGtnaa5A74
	1g1GUkZBwPl/b6yli+YPZbbtggulO5RT7CaqNyzc4fMx5czMCHQPUtrENGut1fSd6ghPolV0iFa
	8qCKiypERmpfOMqrZw2EsQQYyd5ulifmfztuaGEEeO1mnGSLNdtjKWl4q/bkx+OJp747KvDJZwK
	P66lcSVf4qkSBuAHQGjYkI+9PxeO+XYyWbHYNMc4KtJJJMDphFk7Rz5k+XjH4nimZ6idK+ZDxQ5
	Ge1QdxDee4XpQNVZEV+nLkk+jOMrvphzDbw==
X-Received: by 2002:a53:c052:0:20b0:66c:c998:f9d3 with SMTP id
 956f58d0204a3-66ce49a273cmr1032714d50.5.1787276714075; Thu, 20 Aug 2026
 18:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813064902.367504-1-kartikey406@gmail.com>
In-Reply-To: <20260813064902.367504-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 07:15:01 +0530
X-Gm-Features: AcwNN1V4dmKKGjPji2yVJLBTkyyZSgMh7TnOyiEqwl6nQbzA8cc22mdo1kQ-CyA
Message-ID: <CADhLXY6zACn7j=hSfj2jemjV7eFnVeAd4Dk_CVK4OKGu-KPX3g@mail.gmail.com>
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
