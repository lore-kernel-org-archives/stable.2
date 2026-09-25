Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B7409272
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366801; cv=none; b=sd+GxGBVY9pZa6n3QyMX6Z6vDJwi4fhwQq/Azn6nIRSWkvaif0YgeC1/QD2cR2nmQeKiX4z9QygqLwE/Kqem8EOxeaBgZfGZtxbr7D1Zlwcy/N6h8yRHwl9FVqLZR7dcQxoLz+LnRQyqd8upqRch39ZlOXVUdtLS8DJPJCuRkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366801; c=relaxed/simple;
	bh=NEuCVKYpXaXTglhJheHiFNsL1MQDxePE9zq5IU7cI+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bv6CdGYV+90feW4WpKYGPsv9AWoMzVTs2gEpoIuNMS/Czuv/xc/fJ4+YF2xFxCqqPNREk6+sWP8Lzlr4s1d3MD5Jqc3pDuXoKUsQmlUocRH8HCaZB1js0EO4XeOsWGZqRSnxJFvVdu/RUX+UuzdDOzQppvXwWcZ3Nl0938mMMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jllMzOMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jllMzOMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BD31F00899
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366797;
	bh=PvjIw4Gs04yENhnrcbPATTUQJ8DYxFb6SwPViZKQF2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jllMzOMsRcewmmqSXsblf+UxIBx5k8QdJm4oV2wnL4SIPttjrGGRMYUH5shiyHVlH
	 wGueA3QfUnlrfcebBKXlfueCb8IwDothJnWl2mNQKOu09BDnAnBm9S2JT9gy4sfD/w
	 NbEw8H51BE94R3JLA+s21zfbiWxRPZgsHrtqDfqmpsvdDhledZuu7detQFrq90+Q4o
	 dsHbWgS/jACUkC/uaxF5v95gD3FsqLEkZZyEwgT3bLiUVkvy0csh+F5fHYJSo+t7qJ
	 hAa95kNEeNyPyX26Mk/V2HL9QMwGf/PrDb0ACnvbBCmvy1bdLjDAnWQP6DtOswwnWE
	 jDU2iYuR2WH7w==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8e6ec4dd4so842139e87.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:06:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByTKE7pjzYPo7ApAhJ1VOH1/bFtEwgnts0CLbAiq6m7uBU5znh6j+BGDwtocvPYV+/xSig7iI0=@vger.kernel.org
X-Gm-Message-State: AFuF++ngWE5zbsFSMSEGPnRXl/1gFh8OT7J99reBBALbgqRwRNei7KAF
	PwLjFBFE/nF1nD6v0GkfLby3/4wIxzfoUJyNflh+m1bYD/WBJMLG9cAsTKxQOjUnmNx7SwbPXmM
	4UvRcVKsXsQgUVnASCmCOC8Mg4a4ikJw=
X-Received: by 2002:a05:6512:12cc:b0:5b8:e716:64e3 with SMTP id
 2adb3069b0e04-5b8e716662cmr1316403e87.31.1790366795556; Fri, 25 Sep 2026
 13:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922081052.321581-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260922081052.321581-1-fanwu01@zju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 22:04:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jJ4-2kRtozUzQY1K08uw2wnjFBMadSa-gTrYEAHmM-ow@mail.gmail.com>
X-Gm-Features: AclHuK8KWMJjQNWo7EjI7Q-RsAPzdXQBOdtga1f-vYg85MK18pnUSJR1Qx6NV5s
Message-ID: <CAJZ5v0jJ4-2kRtozUzQY1K08uw2wnjFBMadSa-gTrYEAHmM-ow@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix use-after-free of perf domain in netlink doit handlers
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, Song Li <songl@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:12=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> The doit handlers dropped em_pd_list_mutex before dereferencing the
> perf domain, so a concurrent device unregister could free it while the
> reply was being built.
>
> Encode the reply from em_perf_domain_for_id() callbacks, which run
> under the mutex, and allocate the skb outside of it, like the dumpit
> path already does.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL =
spec")
> Fixes: f2d2946eaa5c ("PM: EM: Implement em_nl_get_pd_table_doit()")
> Cc: stable@vger.kernel.org
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  kernel/power/em_netlink.c   | 122 +++++++++++++++++++++++-------------
>  kernel/power/em_netlink.h   |   8 ++-
>  kernel/power/energy_model.c |   8 ++-
>  3 files changed, 87 insertions(+), 51 deletions(-)
>
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 4d4fd29bd2be..1f68d456a713 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -95,41 +95,62 @@ static int __em_nl_get_pd_for_dump(struct em_perf_dom=
ain *pd, void *data)
>         return ret;
>  }
>
> +struct em_nl_doit_ctx {
> +       struct genl_info *info;
> +       int cmd;
> +       struct sk_buff *msg;
> +};
> +
> +static int __em_nl_get_pd_doit_fill(struct em_perf_domain *pd, void *dat=
a)
> +{
> +       struct em_nl_doit_ctx *ctx =3D data;
> +       void *hdr;
> +
> +       hdr =3D genlmsg_put_reply(ctx->msg, ctx->info, &dev_energymodel_n=
l_family, 0,
> +                               ctx->cmd);
> +       if (!hdr)
> +               return -EMSGSIZE;
> +
> +       if (__em_nl_get_pd(pd, ctx->msg)) {
> +               genlmsg_cancel(ctx->msg, hdr);
> +               return -EMSGSIZE;
> +       }
> +
> +       genlmsg_end(ctx->msg, hdr);
> +       return 0;
> +}
> +
>  int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
> -                                             struct genl_info *info)
> +                                            struct genl_info *info)
>  {
> -       int id, ret =3D -EMSGSIZE, msg_sz =3D 0;
> -       int cmd =3D info->genlhdr->cmd;
> -       struct em_perf_domain *pd;
> +       struct em_nl_doit_ctx ctx =3D {
> +               .info =3D info,
> +               .cmd =3D info->genlhdr->cmd,
> +       };
>         struct sk_buff *msg;
> -       void *hdr;
> +       int id, ret, msg_sz =3D 0;
>
>         if (!info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID])
>                 return -EINVAL;
>
>         id =3D nla_get_u32(info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF=
_DOMAIN_ID]);
> -       pd =3D em_perf_domain_get_by_id(id);
> -       if (!pd)
> -               return -EINVAL;
>
> -       __em_nl_get_pd_size(pd, &msg_sz);
> +       /* Encode under em_pd_list_mutex, like the dumpit path. */
> +       ret =3D em_perf_domain_for_id(id, __em_nl_get_pd_size, &msg_sz);
> +       if (ret)
> +               return ret;
> +
>         msg =3D genlmsg_new(msg_sz, GFP_KERNEL);
>         if (!msg)
>                 return -ENOMEM;
>
> -       hdr =3D genlmsg_put_reply(msg, info, &dev_energymodel_nl_family, =
0, cmd);
> -       if (!hdr)
> -               goto out_free_msg;
> -
> -       ret =3D __em_nl_get_pd(pd, msg);
> +       ctx.msg =3D msg;
> +       ret =3D em_perf_domain_for_id(id, __em_nl_get_pd_doit_fill, &ctx)=
;
>         if (ret)
> -               goto out_cancel_msg;
> -       genlmsg_end(msg, hdr);
> +               goto out_free_msg;
>
>         return genlmsg_reply(msg, info);
>
> -out_cancel_msg:
> -       genlmsg_cancel(msg, hdr);
>  out_free_msg:
>         nlmsg_free(msg);
>         return ret;
> @@ -148,19 +169,6 @@ int dev_energymodel_nl_get_perf_domains_dumpit(struc=
t sk_buff *skb,
>         return for_each_em_perf_domain(__em_nl_get_pd_for_dump, &ctx);
>  }
>
> -static struct em_perf_domain *__em_nl_get_pd_table_id(struct nlattr **at=
trs)
> -{
> -       struct em_perf_domain *pd;
> -       int id;
> -
> -       if (!attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID])
> -               return NULL;
> -
> -       id =3D nla_get_u32(attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN=
_ID]);
> -       pd =3D em_perf_domain_get_by_id(id);
> -       return pd;
> -}
> -
>  static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)
>  {
>         int id_sz, ps_sz;
> @@ -245,34 +253,58 @@ int __em_nl_get_pd_table(struct sk_buff *msg, const=
 struct em_perf_domain *pd)
>         return -EMSGSIZE;
>  }
>
> +static int __em_nl_get_pd_table_size_cb(struct em_perf_domain *pd, void =
*data)
> +{
> +       *(int *)data =3D __em_nl_get_pd_table_size(pd);
> +       return 0;
> +}
> +
> +static int __em_nl_get_pd_table_doit_fill(struct em_perf_domain *pd,
> +                                         void *data)
> +{
> +       struct em_nl_doit_ctx *ctx =3D data;
> +       void *hdr;
> +
> +       hdr =3D genlmsg_put_reply(ctx->msg, ctx->info, &dev_energymodel_n=
l_family, 0,
> +                               ctx->cmd);
> +       if (!hdr)
> +               return -EMSGSIZE;
> +
> +       if (__em_nl_get_pd_table(ctx->msg, pd))
> +               return -EMSGSIZE;
> +
> +       genlmsg_end(ctx->msg, hdr);
> +       return 0;
> +}
> +
>  int dev_energymodel_nl_get_perf_table_doit(struct sk_buff *skb,
> -                                           struct genl_info *info)
> +                                          struct genl_info *info)
>  {
> -       int cmd =3D info->genlhdr->cmd;
> -       int msg_sz, ret =3D -EMSGSIZE;
> -       struct em_perf_domain *pd;
> +       struct em_nl_doit_ctx ctx =3D {
> +               .info =3D info,
> +               .cmd =3D info->genlhdr->cmd,
> +       };
>         struct sk_buff *msg;
> -       void *hdr;
> +       int id, ret, msg_sz;
>
> -       pd =3D __em_nl_get_pd_table_id(info->attrs);
> -       if (!pd)
> +       if (!info->attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID])
>                 return -EINVAL;
>
> -       msg_sz =3D __em_nl_get_pd_table_size(pd);
> +       id =3D nla_get_u32(info->attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_=
DOMAIN_ID]);
> +
> +       ret =3D em_perf_domain_for_id(id, __em_nl_get_pd_table_size_cb, &=
msg_sz);
> +       if (ret)
> +               return ret;
>
>         msg =3D genlmsg_new(msg_sz, GFP_KERNEL);
>         if (!msg)
>                 return -ENOMEM;
>
> -       hdr =3D genlmsg_put_reply(msg, info, &dev_energymodel_nl_family, =
0, cmd);
> -       if (!hdr)
> -               goto out_free_msg;
> -
> -       ret =3D __em_nl_get_pd_table(msg, pd);
> +       ctx.msg =3D msg;
> +       ret =3D em_perf_domain_for_id(id, __em_nl_get_pd_table_doit_fill,=
 &ctx);
>         if (ret)
>                 goto out_free_msg;
>
> -       genlmsg_end(msg, hdr);
>         return genlmsg_reply(msg, info);
>
>  out_free_msg:
> diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
> index 583d7f1c3939..bc98a3c278b9 100644
> --- a/kernel/power/em_netlink.h
> +++ b/kernel/power/em_netlink.h
> @@ -12,7 +12,8 @@
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
>  int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
>                             void *data);
> -struct em_perf_domain *em_perf_domain_get_by_id(int id);
> +int em_perf_domain_for_id(int id, int (*cb)(struct em_perf_domain *, voi=
d *),
> +                         void *data);
>  void em_notify_pd_created(const struct em_perf_domain *pd);
>  void em_notify_pd_deleted(const struct em_perf_domain *pd);
>  void em_notify_pd_updated(const struct em_perf_domain *pd);
> @@ -24,9 +25,10 @@ int for_each_em_perf_domain(int (*cb)(struct em_perf_d=
omain*, void *),
>         return -EINVAL;
>  }
>  static inline
> -struct em_perf_domain *em_perf_domain_get_by_id(int id)
> +int em_perf_domain_for_id(int id, int (*cb)(struct em_perf_domain *, voi=
d *),
> +                         void *data)
>  {
> -       return NULL;
> +       return -EINVAL;
>  }
>
>  static inline void em_notify_pd_created(const struct em_perf_domain *pd)=
 {}
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index e610cf8e9a06..a76089e2ce8c 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -1031,7 +1031,9 @@ int for_each_em_perf_domain(int (*cb)(struct em_per=
f_domain*, void *),
>         return 0;
>  }
>
> -struct em_perf_domain *em_perf_domain_get_by_id(int id)
> +/* Run @cb on the matching domain with em_pd_list_mutex held. */
> +int em_perf_domain_for_id(int id, int (*cb)(struct em_perf_domain *, voi=
d *),
> +                         void *data)
>  {
>         struct em_perf_domain *pd;
>
> @@ -1040,9 +1042,9 @@ struct em_perf_domain *em_perf_domain_get_by_id(int=
 id)
>
>         list_for_each_entry(pd, &em_pd_list, node) {
>                 if (pd->id =3D=3D id)
> -                       return pd;
> +                       return cb(pd, data);
>         }
>
> -       return NULL;
> +       return -EINVAL;
>  }
>  #endif

Applied as 7.4 material, thanks!
