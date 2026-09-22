Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE44078D7
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064813; cv=pass; b=TgL4fxI7yF4AFUFbiccvvQh64nYMYbaE27F2ANi/0jItdT7aW8QX3zCRkZT315ezr7h2o8VgeyQoAHCYvcaNd7uHlUK0Va8cjsO1LOsizmrgOZisc8D3Wg9Q5nBya507DOcfhWrhyr/DkdSNb1kbf/qA7uhFQO6XqeJH6urvwDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064813; c=relaxed/simple;
	bh=z4yJ4d/PQ9eEbkDFB5YDhTveMk44MET3fVjIGIItEhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdG6UtsbtUBgGTEjfKe6/UqsDb3Qb8u4xJIzXRLlLjUkUYNsG1v9M097cvP63rx68/yp4NwtevAY1KC/saf3qb2LS47GwN7OpVmQArKodX3CSnqlCFEx/6bgq4d2AM6FL8zLQjpBOs89Ff2GEFPAavgxqAnHJQnt3WApCrv/5So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CumDQ3+V; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CumDQ3+V"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4aae3147so2750202d50.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790064810; cv=none;
        d=google.com; s=arc-20260327;
        b=NSUHJu9V/gehfEf8reLbGFEVfIcD4x0/RlPK2UEOytnT5TloEZKx12yadpfw04SOyX
         sLJMgQszP2xbGkITLBdfKTAbaQToVypPIiB+SQrG119rBGSjnHN/yklDHV3ODWAp6IR8
         /gDnzSMJhULuK968bFPrcf6VMcM4E2ybK5dJuq7Lvan0nY8KonQhYiOWIP13ytEPMbxc
         fZ4P+BV2HHc6TELMTSWCfqqNO+SUrukqQMZaBnvR4d8FAckg8N2AaaDbBbGPvotznlWi
         qtPHg/LseH4wbFvz+iCxIguANH1puKui71t/vxv2mOau770OZjdu+Bm0fzbrK/CwLTjS
         QoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vi+eaHvPeGF3Sdq7zvAZY/QjCGqMSzvenzOG4HC773o=;
        fh=natqZR7D/gz2haYYz5cQpXOsUJrQsGIbYwjZt25QfJE=;
        b=VP9wRPv81uuKNO8w5TMWZYbbzN1Em/L3NiWuaNUWHWoodK+Q3aKpUK+YsW9b8l96hm
         IIQcSYUow6Zdy0NrjX9ErzeNiV0Wdca84kHaKeaUddSs/lKh+eK9ONR3bDjHusfHApJL
         PT8Xu9ryYp3h2wU7B/SZbChL4tE1gYYPjGbT7ZMD7V3Vl7eiVRmiDnf0FsaDgX2mB2Mg
         XBAkC1hDcotsweR/as9YjitctHxIZj+QSwZcQvFDvlFDQcfuhdK7suB6wg3hFy/Aw345
         +F79RlX3+XK8T7THjY8AGJwNxVxdSZN8CV0xwR8k683o6TU5t4t57pPLNrUsqnCNbYPD
         6b2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790064810; x=1790669610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vi+eaHvPeGF3Sdq7zvAZY/QjCGqMSzvenzOG4HC773o=;
        b=CumDQ3+VaWCfRAs+HRcvq/AzKHnhOr/Rj0MD+YQk4F3cQ2sJB06TZPqyScRcjdLmr9
         JVzPilfNhHcGu6dZNJkcW6VNxmV+O7fzVaYssQJX9X0BTtmzbJD5aZiS7/wbGMJ83D+L
         6rtop9AoOuw8RoLC+pDt0JQFtekfmuRGrEMO6u1WFDm7Tdt2AJ0m3nfKsD1m9izTA1eB
         lfRlB0wWGy0J0f5bzLREieD7wOVb1ceQy6ckjeUAez0B1Nbf2gfbGbPeE9NK0FpGbIpo
         kmKMAR4EERHXZchyCoNI6DbWYm2QijgPOVF6H4bEIjibkOF8gUd4js+7LWTPko3UIQJe
         02Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064810; x=1790669610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vi+eaHvPeGF3Sdq7zvAZY/QjCGqMSzvenzOG4HC773o=;
        b=EDBvCxsa5DytFgJagik1CknGaoVsNvK/z0RfaDij2CSnLf8SDTZ7vyzMLiHRuJg+Sj
         b9FgE5kfUQznzHQjG/BjTg7RQz2bBQ9cGoZwxsnMhQz6HqFlnLrtjb2VY231lGLqQyKa
         3FtXLiA3Kq0NsuYrboz15yfWrY5UjMfgSgD+DKRNE/Cna+4G/C+lzXBUnKA9x9VFjE5F
         hzeDXMp1ncy8vtyKEywE7GtPrhl2AjgegOPbZVJkcXKfXY02SYAiamEQsJMOOqe+/zWk
         fPHI81hgm7xqtnT2xZyssDAl2J2Mc7XlfQeY1avqin6LlGRr9mXK0aa+PBciDlYl4yVT
         J5Fg==
X-Forwarded-Encrypted: i=1; AKwUvBzQSI/FEHjzdsl50jd1elWbBx83/BhnzWwjNP4qmb0SU+2ESC1EZGtNSioegzxXk08CGRuU3zg=@vger.kernel.org
X-Gm-Message-State: AFuF++kPkLJmc1feNt4bWx2yYwRsw2GCR4G8Q/SpqBXepE1MotpwqK+s
	Iqfb2zXIv0+fl5aIuyvhsWyPJJtlsSBtC9lfXqXqGoSrTKzKQBq1v1m5XoN8Z7fQd3BRB5t8ll2
	KNps5Ot03RLWbh1Cv7GIEQetbs/FEca0=
X-Gm-Gg: AYBFou0PyaUYJq6Gi5Tgmlk1AvG1wfNQR1Fn2fcdK0vtdYMupVXcaxAPKXVg/2rPeG/
	hyyUSXH/mD670tkZaVzF3qreV+aQRWakYvhinOSv1oFuuEKpm9Ip0hJEBKprWnVcimuXXmqYVdk
	f32NvH6diSgvJH/l2nwyYFDnLzfYgxPZDdtcns+lz4NWKBYXYxzEKEkd4pEDAMcGIIRYTWLswem
	Em/Ffu4epLyve72DTvBZ1qRqH98IRGGAb94s8Yp+/8cK3V5HewFFei30FYJG/hSp89lSJwME9ZU
	YJOso/+i+AxdvbdcJ37/B+ettUhIEyy3HDKL2uRQwekP5nmuQWBzaGTofg==
X-Received: by 2002:a05:690e:80d:10b0:671:1a13:99fa with SMTP id
 956f58d0204a3-6717fcde0a7mr2703957d50.27.1790064810342; Tue, 22 Sep 2026
 01:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921075312.120983-1-lgs201920130244@gmail.com> <cdb67eed-9e75-4310-ae4f-21ca67f20bd2@web.de>
In-Reply-To: <cdb67eed-9e75-4310-ae4f-21ca67f20bd2@web.de>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 16:13:17 +0800
X-Gm-Features: AcwNN1WgyEuKR8AButHilBQBtiaREfERPd_f4BSEyPirEeQ1c0aH3J078-wD1lE
Message-ID: <CANUHTR9+rLuPrd1aifKws++POOKSm+2jxBaJaC1iF5z5x0e13Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: simatic-ipc: fix platform device leak on
 registration failure
To: Markus Elfring <Markus.Elfring@web.de>
Cc: platform-driver-x86@vger.kernel.org, 
	Bao Cheng Su <baocheng.su@siemens.com>, 
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>, Hans de Goede <hansg@kernel.org>, 
	Henning Schild <henning.schild@siemens.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Tobias Schaffner <tobias.schaffner@siemens.com>, stable@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

Thanks for the suggestion.

On Mon, 21 Sept 2026 at 18:10, Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> =E2=80=A6
> > +++ b/drivers/platform/x86/siemens/simatic-ipc.c
> =E2=80=A6
> > @@ -118,8 +119,11 @@ static int register_platform_devices(u32 station_i=
d)
> >                       platform_device_register_data(NULL, pdevname,
> >                               PLATFORM_DEVID_NONE, &platform_data,
> >                               sizeof(struct simatic_ipc_platform));
> > -             if (IS_ERR(ipc_batt_platform_device))
> > -                     return PTR_ERR(ipc_batt_platform_device);
> > +             if (IS_ERR(ipc_batt_platform_device)) {
> > +                     ret =3D PTR_ERR(ipc_batt_platform_device);
> > +                     ipc_batt_platform_device =3D NULL;
> > +                     goto err_unregister;
> > +             }
> =E2=80=A6
>
> How do you think about to avoid duplicate checks and variable resets
> in such a function implementation?
>
> Regards,
> Markus

Would it make sense to share the cleanup path and rely on
platform_device_unregister() handling NULL/ERR_PTR, like this?

+static void unregister_platform_devices(void)
+{
+        platform_device_unregister(ipc_wdt_platform_device);
+        platform_device_unregister(ipc_led_platform_device);
+        platform_device_unregister(ipc_batt_platform_device);
+}
+
 static int register_platform_devices(u32 station_id)
 {
        u8 ledmode =3D SIMATIC_IPC_DEVICE_NONE;
        u8 wdtmode =3D SIMATIC_IPC_DEVICE_NONE;
        u8 battmode =3D SIMATIC_IPC_DEVICE_NONE;
        char *pdevname;
+       int ret;
        int i;

        ...

-       if (IS_ERR(ipc_batt_platform_device))
-               return PTR_ERR(ipc_batt_platform_device);
+       if (IS_ERR(ipc_batt_platform_device)) {
+               ret =3D PTR_ERR(ipc_batt_platform_device);
+               goto err_unregister;
+       }

        ...

-       if (IS_ERR(ipc_led_platform_device))
-               return PTR_ERR(ipc_led_platform_device);
+       if (IS_ERR(ipc_led_platform_device)) {
+               ret =3D PTR_ERR(ipc_led_platform_device);
+               goto err_unregister;
+       }

        ...

-       if (IS_ERR(ipc_wdt_platform_device))
-               return PTR_ERR(ipc_wdt_platform_device);
+       if (IS_ERR(ipc_wdt_platform_device)) {
+               ret =3D PTR_ERR(ipc_wdt_platform_device);
+               goto err_unregister;
+       }

        ...

        return 0;
+
+err_unregister:
+       unregister_platform_devices();
+       return ret;
 }

 ...

 static void __exit simatic_ipc_exit_module(void)
 {
-       platform_device_unregister(ipc_led_platform_device);
-       ipc_led_platform_device =3D NULL;
-
-       platform_device_unregister(ipc_wdt_platform_device);
-       ipc_wdt_platform_device =3D NULL;
-       platform_device_unregister(ipc_batt_platform_device);
-       ipc_batt_platform_device =3D NULL;
+       unregister_platform_devices();
 }

Would this be closer to what you had in mind?

If so, I'll follow Krzysztof's suggestion and organize the related
patches into a proper patch series before sending v2.

Thanks,
Guangshuo
