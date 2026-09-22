Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E441BA61
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065226; cv=pass; b=dnCHo2HRFDS0Jm+XnN16qRpdKqWxwxcP70kwJ3DhVAhKvYBjIQgge9kLjvmOpbod558/xl1qLc2oP11WIFqZ0Wk/2P0C3iV0Itk9h1tIGeZltmUu6YXXO9HeNL+mAntM2wTxrS5JryG8h94z0G6evfKlo85UZ3SjsMrPNrh9q6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065226; c=relaxed/simple;
	bh=hM0EaCqPsrA1hAcKzwMcf0Q3QOnu+qe7h0GMMmXoql4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1fXvoaGkm7VgbKk5mJjEm/MblNqkxk9w+x1xfOB+f7c3ACmJQFo6N8LL8Ju5ofmBTUUNpsMxHuJCpJzN/DHgaXVUFuIsfiVLzzGQh2KZSCUJ5MajoIQI79IdU7EcwTgLoO53KeNmGaaNBNxUIuzpYFIMbbDXkNtpF8Uf9JIcg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBmhKwMq; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBmhKwMq"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc02279so3045027a91.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790065224; cv=none;
        d=google.com; s=arc-20260327;
        b=B5I5OpAVW6YK6ZMmPGzmbvcRY2bG+HynRbWD+Q9WN+ZgqobNBsq//EDcGrR7gC2BrY
         LtaVbHMhzm3sRooDbbX647E7ma7kJNmGeR07BoWIhppUAGsnQUNkyI8smnrPXtcWJ3Sq
         YhT2qNyyFUrDUszRWLFEv8NhS+jqaeZJJfNrTkqw8sE1RVihXNuDD9tXgeoQSG6+q77I
         YVdU+YPGLGu4NXTHFQ5B3PmRFWGywVi+FTiaMKg4J9PGdAC4BD36KACVRjsWCnfIKM4N
         lHsvTRF+K4QiCZs/pzm2L8eraVAvqHRSxs8tlsl+9z2mCpn94vGEQtslG8H6C1ABafOh
         STng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etyNrSdg7SELADqdNG6OVH3H+CXSg23SDODY/D8rF+4=;
        fh=xPJz+HaRlzP/WeNAWywZFjd7QQIxtYJuEtwoqGbvFng=;
        b=FNG5AnCuATx9wDQ8uHgTuOTQBxjk6J7acQk0Hrv8BHp7lmVlINFOlejRyOtGkuE5Y5
         f93HBL68lDPs7gbstoIRN40X6gGQnIKmSZMbbMz7H/+UJwBWkbwMRJYlFHh0u+a/is5/
         Al1rwMcMZiLhRwbPUyyAe8LTnGctq1M2FVnKZQZLpFIQH6sCNBxX1lgMB+Va7bEsuEne
         fh1ZLKM1TVfd10a2UblLWwxCw7liMlD8LN9tLVmbhAAl+H9ahQL1pkeKalO572rQC6+Z
         1Dr+pAf2V0WrxgImw2yXj8kbU6sNmmZmJKwuojbAZCxTTXnL1KirgimtRpf/f5AgCQ1J
         CfKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065224; x=1790670024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=etyNrSdg7SELADqdNG6OVH3H+CXSg23SDODY/D8rF+4=;
        b=WBmhKwMqI8+7VIgKMApl/5FozsahuYbt3mZUF9jH7uuvf9TSGL+z0jgchG6iBxoy0/
         +Cb62Vc+vC8FAJXtcoW4VdJUFs9SrT+54X3nEmI7+s7eMHBcYwovk/wR4lrZase1WBlc
         MRDoKKyMflBhmrvjzyt3MV7XXXYz5q8D6CsCYJQxBskzziC+UNYx2Ix/5svtl8Od5aJW
         5rVZGgMhkgOFqo1dEkIHLhEEU/A3lPvmIzzLRiWeQk3d1QPCqZMwqLqCq70lEEeZfaYL
         gQ6BKcDnMnQFAyYF/f10++L3ADTmsjWH/2uQ3QvVcuW+Hd4OTsDd8yoYsYAxU3MgrkiW
         4Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065224; x=1790670024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etyNrSdg7SELADqdNG6OVH3H+CXSg23SDODY/D8rF+4=;
        b=K5xAhfh6a2viQJ7z7d104/WjaRE1SHzvRDIomqZkaAwcLpgSUaZmzktNqD4D8EaFCW
         F+ZTFLTUeTjZmgBXnYROX4mO/lq6d3oxvZZ6FnWrAE4w3onx6BVhdU9ihVw7nOloT06j
         OOjKWDrL9cwiDfh8e5A10/piUffMXlGBtjdENOCX3IIhqR6NSTdTdOZ+CBeVS1Xt8P8q
         PS8xJrbf6ovJtYHEMf/0hA+Ih2Pa18DUKXYLkaJ7S/H+dYxgA/NgnTAjd89yd4U4jo+p
         GzGFqSgtnZHi/5X7F2mJk77KQiIl+yqTROAf49K+lW7ISJYoXhND4CWxT9hkT9cKaU3E
         HpIA==
X-Forwarded-Encrypted: i=1; AKwUvBwFbKkDUdtF5TQUXpcjzQey19W01TMMLI8HIdRqVcsMBrwVKc7jaxqC452TvsVfL50O5qIeXeQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kNxBjDiE59dPcsP43NgsnejKuAvvfY/uudBjLJsI9qIhfmFksH
	gboG8mER5lfgjMcu+4/MuyN9FkP2bWPvHwpF20vUYP3TqVsPLkxrPmngjavo33I4pkWkmsQ+bZo
	Br96bv9KXjzFLgFfsS2PrVY4fKBvMqvg=
X-Gm-Gg: AYBFou2GZIDcAPNFmxAJ0dlOe2B3FqHHH25o3zXDmvMueLF3fFnM20m7rvygD1Yd4e5
	C5BSJXczpR3Md6HNSQu/R7oGyugsh3mh1umLDF+nF8qZ+ImPKQpJOmyRmtpKwY+vpeWTbj87mq6
	tv+fHugCR0pFvpHleZtHqdQzKEiDPtKz8thGAyzv3N9Zaf5sy9sZ85+kl0ZHwqhQGw2XNAinQ6q
	vHxvSNCt7kwiXoq29fGjLga5s8AuJb9TISBUwMQS3ffg/mCv2Zv5tYitZe7PQM6byZIs8XX44JK
	GdgOROV1OKBRVBZ1QBJ6HUT1VGVPUZl9/mrl/bOkKAKQZ1jbTsND+z7P73s=
X-Received: by 2002:a17:90b:4e85:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-3a07309e835mr443959a91.6.1790065224306; Tue, 22 Sep 2026
 01:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919175925.3739806-1-lgs201920130244@gmail.com> <4d1536a9-6836-430b-a84d-aaa19f6af9c6@web.de>
In-Reply-To: <4d1536a9-6836-430b-a84d-aaa19f6af9c6@web.de>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 16:20:07 +0800
X-Gm-Features: AcwNN1VeRLDrIbQQKRLeG1AyUpioVwyENSebpLtVmqJsNEPTYC8bee9d02XlHxw
Message-ID: <CANUHTR-um24oLb-446LRtHLFBGtJ7h=QwEksSjvig-SFonJpRQ@mail.gmail.com>
Subject: Re: [PATCH] dca: fix provider device memory leak on domain allocation failure
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Kees Cook <kees@kernel.org>, Maciej Sosnowski <maciej.sosnowski@intel.com>, stable@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

Thanks for the suggestion.

On Mon, 21 Sept 2026 at 19:30, Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> =E2=80=A6
> > +++ b/drivers/dca/dca-core.c
> > @@ -368,8 +368,11 @@ int register_dca_provider(struct dca_provider *dca=
, struct device *dev)
> >               raw_spin_unlock_irqrestore(&dca_lock, flags);
> >               rc =3D dca_pci_rc_from_dev(dev);
> >               newdomain =3D dca_allocate_domain(rc);
> > -             if (!newdomain)
> > +             if (!newdomain) {
> > +                     dca_sysfs_remove_provider(dca);
> >                       return -ENODEV;
> > +             }
> > +
> >               raw_spin_lock_irqsave(&dca_lock, flags);
> =E2=80=A6
>
> Please avoid a bit of duplicate source code in this function implementati=
on
> by using another goto chain.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv7.3-rc4#n572
>
> https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/dca/dca-core.c#L=
335-L389
>
> Regards,
> Markus

Do you mean using a common error path like this?

        if (dca_providers_blocked) {
                raw_spin_unlock_irqrestore(&dca_lock, flags);
-               dca_sysfs_remove_provider(dca);
                unregister_dca_providers();
-               return -ENODEV;
+               goto err_remove_provider;
        }

        ...

        newdomain =3D dca_allocate_domain(rc);
        if (!newdomain)
-               return -ENODEV;
+               goto err_remove_provider;

        ...

        kfree(newdomain);
        return 0;
+
+err_remove_provider:
+       dca_sysfs_remove_provider(dca);
+       return -ENODEV;
 }

Would this be the preferred change? If so, I'll follow Krzysztof's
suggestion and include it in a properly organized series for v2.

Thanks,
Guangshuo
