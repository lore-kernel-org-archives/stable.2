Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85C40B6E2
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204945; cv=pass; b=oJBPyl0KGQckhLmDlpDYl2moXk7mWobSken3vbumZuDpOg/qJr7CPikxr2ofRI8+7qB5ot+26afFb8ph7YgZHPmJ4azz+SPk6vvHpbbECFSJU7yRC3h2L5scmdWK1IuDo5eN2ixPLRkSgzv36gLoPzyfOIrBemkaDJhlgoiPFvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204945; c=relaxed/simple;
	bh=aO9zUlhZ/cIsv4TahIImjijy5eZpJLxUISCtfDgt/zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGHZBLZGWNIqzo4CTizTRzesZ6iuKx0nktSjsC/nV+QJgz0HwRR2iVHOLowNfrtt1kMI60YYTSMpbV2WGtfzSoboaQEWEluGk3m8CkQFNqMQ/bDad9d8Mv9S802VaK8Zbb5WEELW8nVLu0jGD+iEIOXAY+nmiH+dsCPvqkEMOps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aan9x3L1; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aan9x3L1"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef19aso7887691cf.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 02:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789204943; cv=none;
        d=google.com; s=arc-20260327;
        b=JP20TWFNPL3nSMTkONyMgts19rMqzPyFwr4sS2Cg4Gv/eNAI7aZvC7+svRgeaL5v4X
         HmQXQ17uRPzrbe/b9/O/hJhkovzGy7IXVlnYP6njIakIjf4IbrQe1agwQpmCQ+pmitMf
         Fk0ixiBY5XUkIGYnzWDcLLshw7/cl/aa04ebKPuJBTC/U0sLP8ir6z7WI3XYqzlK89il
         t8diG36OHJBv3E+3ntsglHuZIQ6WakgzRZOIMiZBl2FwQjcHNGvPlMN8YAsNczoe8bFO
         c/Syi5x6+np1ShpnSKUlMJu0dpXMqR71JC/ucU/HVuEARpdKhuTyG7KVRiqgYl1kz75n
         j5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Po/KtSuUEH8MfPngI4Th6eiOf/oind2PYZNZlItxXP8=;
        fh=6VrRJItRpipKekH3yIf5uCDnnaDZru7ad8f9vvvpgak=;
        b=MwFotimjG3H0RTSpbkZ8H+lZSuf2DktA6HM7r/WeCZFsXhSTiy0PVDMD3G4CCM1DNV
         E80AsXtCq8wM6eEsWu3JmXNLgc/oi2RnF6M7Z8jG0pat/hU+g1WH14AB89PK7b3AExmj
         HTUDHqBdWFABULNQoR8xaGhe+TWV9egaYwRW6kxqS4BzxK4ZAADaUvH68Rsi8W/ZkDZ6
         sdC89+vcGfOjtaiN6SZORgxdgywK9Q1H6rhHlh9/htdgSKXOLyOdpzecqh6NNiVugf6a
         21tEy0FuHFqwNbyVAeWbt8rFArCEeVtcLqzoxSdMtqyHuDnYQxIDi+imIMbnzR/e7x+d
         D7yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789204943; x=1789809743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Po/KtSuUEH8MfPngI4Th6eiOf/oind2PYZNZlItxXP8=;
        b=Aan9x3L1Lt5oHgui16Ioup1xXWhpqxzzNO2wiUMssNcxnhXGG13f9316vSC60/ytw0
         Tnp17vAc6ly0XcjzgytE0uxOjpeEu0RERMMIWn7x4iDgmOS7q/vqpVyY4HZVYtCFQg88
         9k2OcIS6j6Euv2kVxq+jn1v8sQl+T8azF0stGteBQ2ppEsYMFlWUeHi7F89Mp6hYolPu
         t13BGKo9rgnCb0iSQTewddHGq9OdNmnszSnIqvhR/WyDrV6MLvWmSYZKuyi2eMPj7fMT
         /8LE+1K/fOMkWsC6WB2FMaTnBOnhWvWRwWJWKVOnxZ++kxGZcYStPXLkCvpUHcmI6VEb
         RJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789204943; x=1789809743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Po/KtSuUEH8MfPngI4Th6eiOf/oind2PYZNZlItxXP8=;
        b=ZXS5m5bMIM3j+EDy120loh0XWwuc4mfDZUA8kWdxPmKbaEVWWcnO/Bhp+7SqinRrnZ
         v/rASGZAjVwXKZ9cbge+7op5gEq42Zn4qHCVK2rYhCnA09bdNMqtrYIMHSHa+dgMnGlL
         wU9VUsZ5iu1LrgGdfVptBcaSF+7aMoVoB1YT884jwNRqVc6eUcknzSMNXPkYfX+fjxeN
         L4ArH0rpotLKq73VLmQ+flsiWefkR+ayBQDemNbXu/rX+WAjyK6jBwe8Egd0X78Tf6cC
         TSj6Tz2WL+eqVqqFZ3qA9k4mczGCqbVdzIHnRA3FMQKLhxUxvRYG++FG4k+rpKeLAqJO
         iNfg==
X-Forwarded-Encrypted: i=1; AKwUvBxMlj+5xBvt/lMhZ33ZWLKf0p81+XCGQEJSwFAOHI2zeru25wPLe+c+kwvKrbAZnwFMaOwDMlM=@vger.kernel.org
X-Gm-Message-State: AFuF++nCcsJmY50TCMxQ92jAnsAw5o8DGJjEA0nHyWjALwi5CUxaGRGE
	8wgFlUNVku/RYMGmREW8EaggjvaPZpI51NACqA/8Vr7iEydvNqtBx7WRbXfjrgkW6WcEKLJdXp+
	rvKnJvuMpigCUm4ry/BB1yhPe5GwEaK78ZSnPql5p
X-Gm-Gg: AYBFou32J+H6IlCXH9PLxedNVvmkdTfUYBvYhOXRPjjf7PNkJxAlxg1dwMuEZVG6bxa
	UbP4/a2YrNlOKZUeU5Z5CuhMJnmyMkkHleNoJLZ7JLCYo5cOpiNSN/0voKjHcMUFl0D/e8S6ebu
	nVUvJ6WbAJVSKvuprRZtrWN6cmqZuh2MxQfjLNmDwwBwcJJdilqqj+aD/1/i6Gf+/b3zcB3DdSB
	CNpKzJ/o0vWmx+N4VqYni9bB5N2Hl1u7rtS/eGSfRNTsN1/msNLa5K3qGuB7EtdDEaquN/1FbtO
	aU41oh68N/IY3MCNZyakp8bp1oVFHVMcq9EqVpvx1KZIy8JsAd2Mb2R1D0cHsN5F6JcLW65q+iG
	tH39FBsD46UiQaggrc4Rwxh2HDd5GpnpE+QRcxC8C9ghnooy8HpKYeDsBnsT0z4a2A+g=
X-Received: by 2002:a05:622a:13d4:b0:530:e080:93be with SMTP id
 d75a77b69052e-530e0809981mr66816991cf.46.1789204942535; Sat, 12 Sep 2026
 02:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912055304.1415016-1-cnfourt@gmail.com>
In-Reply-To: <20260912055304.1415016-1-cnfourt@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 12 Sep 2026 02:22:11 -0700
X-Gm-Features: AcwNN1V9Y4R_ylpJWfxtuU1JoTDq0Gs2lcrzQUAf6_3bVo65JvmOfd5F0cefuwQ
Message-ID: <CANn89iKk2smjZ5OVJGQBw+F1KJ8DDdfMUmquSKAUq16rMcHg8A@mail.gmail.com>
Subject: Re: [PATCH] net: ip_tunnel: initialize `options_len` before
 referencing options
To: Gris Ge <cnfourt@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Kees Cook <kees@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:53=E2=80=AFPM Gris Ge <cnfourt@gmail.com> wrote:
>
> The following command triggers a kernel panic:
>
>   ip link add d0 type dummy; ip link set d0 up
>   ip route add 10.30.0.0/16 \
>     encap ip id 300 geneve_opts 4660:66:11223344 dev d0
>
>   memcpy: detected buffer overflow: 4 byte write of buffer size 0
>   kernel BUG at lib/string_helpers.c:1044!
>   ...
>   ip_tun_parse_opts.part.0.cold+0x10/0x10
>   ip_tun_build_state+0x116/0x2a0
>
> On kernels built with GCC 15+ and `CONFIG_FORTIFY_SOURCE`, the fortified
> `memcpy()` got 0 sized destination with request of 4 bytes length:
>
>   static int ip_tun_parse_opts_geneve(...)
>   {
>       ...
>       attr =3D tb[LWTUNNEL_IP_OPT_GENEVE_DATA];
>       data_len =3D nla_len(attr); /* =3D=3D 4 */
>
>       struct geneve_opt *opt =3D ip_tunnel_info_opts(info) + opts_len;
>       memcpy(opt->opt_data, nla_data(attr), data_len);
>       /*     ^^^^^^^^^^^^^ 0 since options_len is assigned afterwards */
>
> Fixed by initializing the counter before the options are referenced
> matching what `ip_tunnel_info_opts_set()` already does
>
> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_t=
unnel_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gris Ge <cnfourt@gmail.com>
> ---
>  net/ipv4/ip_tunnel_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index 5168d546ea2f..8fb4742aca92 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -711,6 +711,7 @@ static int ip_tun_build_state(struct net *net, struct=
 nlattr *attr,
>         new_state->type =3D LWTUNNEL_ENCAP_IP;
>
>         tun_info =3D lwt_tun_info(new_state);
> +       tun_info->options_len =3D opt_len;
>
>         err =3D ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, extack);
>         if (err < 0) {
> @@ -753,7 +754,6 @@ static int ip_tun_build_state(struct net *net, struct=
 nlattr *attr,
>         }
>
>         tun_info->mode =3D IP_TUNNEL_INFO_TX;
> -       tun_info->options_len =3D opt_len;
>
>         *ts =3D new_state;
>
> @@ -1005,6 +1005,7 @@ static int ip6_tun_build_state(struct net *net, str=
uct nlattr *attr,
>         new_state->type =3D LWTUNNEL_ENCAP_IP6;
>
>         tun_info =3D lwt_tun_info(new_state);
> +       tun_info->options_len =3D opt_len;
>
>         err =3D ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, extack);
>         if (err < 0) {
> @@ -1040,7 +1041,6 @@ static int ip6_tun_build_state(struct net *net, str=
uct nlattr *attr,
>         }
>
>         tun_info->mode =3D IP_TUNNEL_INFO_TX | IP_TUNNEL_INFO_IPV6;
> -       tun_info->options_len =3D opt_len;
>
>         *ts =3D new_state;
>
> --
> 2.55.0

You forgot a 'net' in [PATCH net] . Please read
Documentation/process/maintainer-netdev.rst

Looks good, but please add a comment on the assignment stating
it must precede the option parsing, otherwise a future cleanup might move
it back down?

Or maybe use something similar than tunnel_key_opts_set() in
net/sched/act_tunnel_key.c
for consistency.
