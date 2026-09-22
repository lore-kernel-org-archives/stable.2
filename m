Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B593B895A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062883; cv=pass; b=e6KZnTGVjQHjJ+c7u/3BtOIpLiO4Vf7EE7CqUGmOJFcrJtdgoVW3K3FRBV+36bagsfbn/0wqXUyMxXv+cP87yrmdOom7HWlliWvlhSJB/9R3xBhRnhVqbjDa0h6sk8Q6GMo5VrvxVgHe7MSjRBAUM/LPopoXTHne4kTYAClCw+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062883; c=relaxed/simple;
	bh=8dO5H5NH2RszZryttcomG76BD17kGA9isNzAWX9CjXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhnduBS6zGc8VzQERWNOTADSswoqTmdMgmIrq0Jw3yKjfZcSJuCMzeY625jFGTJDWRmHB6vHWUgb1Xqlmnmzk9IFFJMjiVt6fWCKuzIVF6KloWucbbCS+wMUDpox6Cs4hp7PQNWD9o3Y3WslbtyUzCPCzCj5oaI1c3d43+QV67A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8hiim9z; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8hiim9z"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d4ddd179eso31560507b3.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 00:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790062881; cv=none;
        d=google.com; s=arc-20260327;
        b=MLFQ/tlzaxjYolQb4jSIW1AbFpVVXR8zwg3xk/2OuY9yVU0K4OhegHtnVYT/S/KDTa
         iqwHxngPLoPuKu6o722Uz9DGqW0uHg2Q5a6COn+TOegs6ABPEVz5k0VFjgUoBbuFAfFm
         MpsH/9lw1BytgvBobWGlxF+Ak8LMO/3GouvmI2l67Bz1Wg/MTmT8oPwt34nhn4gOY8ik
         t76ad5xDRGNTp12iAxMubCGwK4bupxe7DDlxwP8oT9LwJ3MStXIiHmXCH61D3etFrTpp
         wZwQpRL8XcILgHuf08wm/F6El7hg3UXYf2aB3/J8ifb7ij1etA/6H+bplVe73zmpwACX
         4SJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=io8UjoxhH2lPg3HQUAyI0U/34+pkdRwtw5UyaKVMvYA=;
        fh=B0EuFmfMQvN60htGU4xcd6KW6m5oM6pGVvJIIi4s+P4=;
        b=gTL6B0jljlmVddSfDEguAw+jTGCPBxEavQDjvVJ/HLuiog0JfSHU4PU4cADydCosWk
         13sqGrkv6vAKaRm7Eq4y1WSE6ZNx7hR/Pwb38dZNG6NTJghXJET+xy9qsoyaKzyj6uuZ
         PTRR36+g74vWRA3/QrjgdhqgViB07sqtXOHxSqcxBWBLZioCG8086uU1x99hkdLKIlZT
         srqhBseYRHQsrivcsZQ/LBboxhDwqnhpMptDUPQS+ZCbtZ2XCId3Mcb5G4fOil/7pgHc
         /EUlXbP9lRHtgDisoqIiPlBuzeujIBFSm8CUSVDI0m7kQUA71vgnO2NViBbP6c1iKnde
         4E4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790062881; x=1790667681; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=io8UjoxhH2lPg3HQUAyI0U/34+pkdRwtw5UyaKVMvYA=;
        b=S8hiim9zmeIQ/4AZ5jWWarKAVusTDFtb+fpzXuvoYezS6czOhrnxhjnB6abMz5TZrA
         kHa4F+xLAjINy+kW3J9OysC+49rKPyR7ovGXMpQF+61JZjxbDjiODB4O/PcT8HtU+QYM
         br+pIa/g3lJaNPruAVocrtxr9churnOXKnEAjNSBPPXlK4khPIwV2FkuH8llqZDFQXKJ
         TmwMR5awpDz5CMYIarx0+ePNvSFpXEbFR4LbbHMHmZyJAAoJtc0v55nyCIoZZQx0qBRE
         IYqXJr2FHStQQywC3hmA5lKqOXQ13EUTImKzbitTMk4tzrGxESspGViaNHY7vYnxkFjO
         MW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062881; x=1790667681;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=io8UjoxhH2lPg3HQUAyI0U/34+pkdRwtw5UyaKVMvYA=;
        b=k9D9b5oOjK6HH6+UAyWsiaeWELzE+lHfX/AtdIT22kLF+xlYuTVEWOY9rOVZLc2uPy
         QN0MU2cNBNRjYcJMopzvJaTygUb2spU2jpBPYVPtHFj+uFaklmJOUAGZ8TYhlkgZUWQE
         lY95QCoIL4OTWPgxfSUik1/fm4HW2MlralO5KLXiCMHE/oE49QXzuk9quTuzZOEa3xzT
         BehdBEDak+voqynNmDvD1D0zhvFHoTQf89u0O05hQ22gYGmxWKgplDf2+aZeuyxU5Anv
         zyp+cN6DhreOIdC1Pfl9BWp74Wk5TuL0yWzC6jzHkOYb4rE6vdsQztkJBiuDWEJDv12T
         M1zw==
X-Forwarded-Encrypted: i=1; AKwUvBxlbmqhwGjlPQpdl2TzwUPhMBotZuvf+Eiy6rF/Ry1tDEUInfg4d6/GZFprlTzoXhyb7oXKI6s=@vger.kernel.org
X-Gm-Message-State: AFuF++nyBvTbxnV/MZQwqE7JacAliSd+aaeJTktzyUdfJNhimET2admN
	4FbGy4FimioFarmYfyNwImhGmwB9G5mUedRJ6XXXitKKZjEAGmFrUPYQs/lv8OM+mU7k4mi181N
	3oZLAneLKKVUFrbf2r605tlzbLvdwXvs=
X-Gm-Gg: AYBFou3yE9mdK+k8za2uqFt7bGbwspk3WunfjYt/p/AyJWIiFivZJI9wBliq5c69R2O
	7DWVPGYnH+TWHPdzteCZdg2W3Z+d5Shd5H8Sow4886oAci7Y/R6ye9lNivHMeX1B5sT/V6qPWX+
	Af5ZAAwILyUvTaAgzkz3YRwLu79mxPvOF8JRFbYInlvkED+gEwO4YDGQFJf7MC5WjkBkGlV9uCj
	o9Jdcff/itEBRiGfV1QocfUzzvXtSsz8Q7QtGLNWZGal8fqoTe5i81RjGr/+QL1MyXWwE3EXIqj
	QbSztE30+kxYnGZ/n/UZASOu+WtmdbsizgP1L5SnkDmNGDqn+7/dx6oKEw==
X-Received: by 2002:a05:690e:1913:b0:66d:2cd9:91d with SMTP id
 956f58d0204a3-6717fd6bd3amr4742587d50.50.1790062880773; Tue, 22 Sep 2026
 00:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918031323.3376849-1-lgs201920130244@gmail.com> <aqzqvfbeh653jUce@ashevche-desk.local>
In-Reply-To: <aqzqvfbeh653jUce@ashevche-desk.local>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 15:41:07 +0800
X-Gm-Features: AcwNN1VuZPbV3cKT7eLyi5Ad-zawrqaD9RbQUP_M-BL5VAYRTq9TxG7WFCvCE54
Message-ID: <CANUHTR9ipEFUGteK4TTpnpN0yUmxjop1v783aOhyq6AE9cwO0A@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpc: remove all initialized power domains
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wentao Liang <vulab@iscas.ac.cn>, 
	Miaoqian Lin <linmq006@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

  Hi Andy,

 Thanks for the review.

On Fri, 18 Sept 2026 at 15:39, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 18, 2026 at 11:13:22AM +0800, Guangshuo Li wrote:
> > imx_gpc_old_dt_init() initializes all power domains described by
> > of_id_data->num_domains. Its probe failure path removes all of these
> > domains, but imx_gpc_remove() only removes the PU and ARM domains.
> >
> > On SoCs with more than two domains, such as i.MX6SL and i.MX6SX, the
> > additional DISPLAY and PCI generic power domains can remain registered
> > after the GPC driver is removed.
> >
> > Remove all initialized power domains in reverse order. Keep releasing
> > the PU clocks immediately after the PU domain has been successfully
> > removed.
> >
> > This issue was found by manual code inspection.
>
> ...
>
> >  static void imx_gpc_remove(struct platform_device *pdev)
> >  {
> > +     const struct imx_gpc_dt_data *of_id_data =
> > +             device_get_match_data(&pdev->dev);
>
> No...
>
> >       struct device_node *pgc_node;
> > -     int ret;
> > +     int i, ret;
>
> ...and no.
>
> The result of the device_get_match_data() better to be checked, in some cases
> it might lead to NULL dereference.
>
> It's better to split semantically different variables, also naming 'i' is not
> good, num_domains is better. Besides that, why is it signed?
>
> ...
>
> > +             for (i = of_id_data->num_domains - 1; i >= 0; i--) {
>
> What you are doing here can be written in a shorter form
>
>                 num_domains = of_id_data->num_domains;
>                 while (num_domains--) {
>
> > +                     ret = pm_genpd_remove(&imx_gpc_domains[i].base);
> > +                     if (ret) {
> > +                             dev_err(&pdev->dev,
> > +                                     "Failed to remove %s power domain (%pe)\n",
> > +                                     imx_gpc_domains[i].base.name,
> > +                                     ERR_PTR(ret));
> > +                             return;
> > +                     }
> >
> > +                     if (i == GPC_PGC_DOMAIN_PU)
> > +                             imx_pgc_put_clocks(&imx_gpc_domains[i]);
> >               }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
How about this:

 static void imx_gpc_remove(struct platform_device *pdev)
 {
+       const struct imx_gpc_dt_data *of_id_data;
        struct device_node *pgc_node;
-       int ret;
+       unsigned int num_domains;
+       int ret;

        pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");

        ...

        if (!pgc_node) {
                of_genpd_del_provider(pdev->dev.of_node);

-               ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
-               if (ret) {
-                       dev_err(&pdev->dev, "Failed to remove PU power
domain (%pe)\n",
-                               ERR_PTR(ret));
-                       return;
-               }
-               imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
+               of_id_data = device_get_match_data(&pdev->dev);
+               if (!of_id_data)
+                       return;

-               ret =
pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
-               if (ret) {
-                       dev_err(&pdev->dev, "Failed to remove ARM
power domain (%pe)\n",
-                               ERR_PTR(ret));
-                       return;
+               num_domains = of_id_data->num_domains;
+               while (num_domains--) {
+                       ret =
pm_genpd_remove(&imx_gpc_domains[num_domains].base);
+                       if (ret) {
+                               dev_err(&pdev->dev,
+                                       "Failed to remove %s power
domain (%pe)\n",
+                                       imx_gpc_domains[num_domains].base.name,
+                                       ERR_PTR(ret));
+                               return;
+                       }
+
+                       if (num_domains == GPC_PGC_DOMAIN_PU)
+
imx_pgc_put_clocks(&imx_gpc_domains[num_domains]);
                }
        }

Does this look OK to you? If so, I'll send a v2.

Thanks,
Guangshuo
