Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD3519E05
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109833; cv=pass; b=pXF+zIjQL2mEdTDbLcCRAnWA8YwjVuoxH/B/qcAkeUShfYxYaauFiOHLEet8xWR/m6YZ1SPw5PvpzpRdqudypB6kDK/hL6H87TgDEnTfstJStQlP8vcxEfZ57zQsySiDwWcz+wbHCtxp/HH1TTiHDq9MlUG89Kp8CUcMX3Mmv5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109833; c=relaxed/simple;
	bh=p21WGTeF5sTqb4Jtihp5eAQjvRYAP+4+Ui1owmVnpJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV+qWgnN6Y8Ji8HTaD9GcZRVguj7mM5uL8LSig0y7H5vedPZ+nEhr+L9/Y2wypdU7ubJId96o4bEAOJeSJQ1CuZu7DbbfiVSsYvaVnDzPUkkoYY9FTsPypXzEeatFXp6zLi2oEBL33IzpiJtuVnHPMNEOERIhjVg2XaG2Oyuk1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KahFfhVA; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KahFfhVA"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86212a185dcso266371b3a.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109818; cv=none;
        d=google.com; s=arc-20260327;
        b=EExZA54dbE8PJS3MofYWRdL8TwH8j6mXi26mbFclyeZYi0nl7DvfwNxatSh6nEkAHL
         d4OrAdrBkQLVvx6NqCKqr8K6uy9kX9EdzYgWwnuV+5D73i3xXo6RgkEFGJogoZmR58yl
         TpWLcN52PtuJHxSqpKczYSQMbuMo6NGYT3O5lE/MR7IE2sEbI20a3+SGJN54cWtqqM8t
         6+xqu6RGdc3jwTlNL8hxoRJXllNeH/ezO4nUtZY0/RMRW2V4cokfRGEMJYe4UxV30ife
         xIBDe7L2HW5bFevrOUVGKmM5j+LmMLGE49IM26hrpkuw6xWQ+KZ7BiipzrHojUEZHvpQ
         deaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MfcOIqK9du/rFNRW98A9Zkgq23mL6C9Bh17nvMfYECA=;
        fh=SAtqawtTloZF4jSbIFZGxnY3W5ALPixoXuDGpaoBRpA=;
        b=pQg8rY0hlOcvusxGroW4xhFGOzwb2a6LMNkKffPeC2RSUcbe5ENwM778VBfisrxUmH
         xRKj0+hGIIJhCcrIsYHXDuiX5IXmjy+88EwPegHex87GjyFJY4ubJn66jXao1GoeFLiK
         55ZKVhGY3ZHV/zjBhGhYZlv8Wkc/1Y8nkvW5ScL9BDhc68uIHFGd4iM4zqDyOfnGe1HH
         QPArtCjMq55PmC1kvL5JGrHg+SSaH9a7QYsuon5lZHxHInhWxY8iU3c2FrP2mUUz5DIi
         C8PQ+86WIqOYgtRZHRRpUfR11emv/gP4zjsHI9GNvMkCXCNicevzLOQUdBiWLUxKKvjf
         bZpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109818; x=1790714618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MfcOIqK9du/rFNRW98A9Zkgq23mL6C9Bh17nvMfYECA=;
        b=KahFfhVAl1zOli4/f84UtPothikHnIrypswEjYPe+dRdYAEigooZilfTr7SFP9NFUG
         7pep1gMTIXj34rHWMSZ5GI6UT8oTXrSoIT0PijLBS8zex5XIjVb5qKW4uYBPPedAZvpy
         PlygzzcRzt2eGe3feCBETaFYJkp/EIL5QycMtiFt1oufRbMFM9vLY0etZfyS9iMe3XKb
         8AUndaKPeR3Vay9BNHBJBtSb3YqnZHNBW52bAzwrga4kt++tF/JHKctz7RasW0GxlM/s
         oXlajhtzwgqVaodFrbCS0SpKJzdl0YMzlW/4qY+CnVqmSUVS9AQLkWn929LbxCLOHYni
         gvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109818; x=1790714618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfcOIqK9du/rFNRW98A9Zkgq23mL6C9Bh17nvMfYECA=;
        b=lbqQ4nHPxpaKF+0qP5N4F0NnT/tI0MZ5jS97VhCJYOcN9WYULGQTQXj5rV/CPR0qB5
         OyAmVaLE4noXE8pqve3A93KidPOIxbyCaWdEL1uIn5atKtoNTqzAq9D/y45xq0DXv0Lh
         nHblUMzaFgcsa/1SoY7hxHxM9bCGRAi729N+TaTSGlpvvwxXwRBqiM0XefLV6SLqLjVi
         +hd2deGe37Fde7SCy3v+Ubk2Uj4kY8e4rNHvYNWiMRB1QgeSIokJNKTbrmLNa58IOv9P
         uQBsIdxbMVKdf3DgSAMk0PX/RMWDFaJ8b8bRuJvppb/kokOsGfJa3R3qZ7JIxc7P4sYo
         zPSA==
X-Forwarded-Encrypted: i=1; AKwUvBwZuj85zXxNQRg+Zlo3V1tVHeLuVs+tF29P/LzU6oaOCo5NsJvh316NcQHyPVUr5DAbupZUWA0=@vger.kernel.org
X-Gm-Message-State: AFuF++l65Z4NR7HeFcBJthVCbIo44LXQIWcqbnYapiufnmGgMBRWg3Iu
	/Bmd/h7DB7B5ttGf/FioadNlHnvUj2IPOxW7TvOgIP9jun1CgY2sa+vdaK6goKoAOZm86I6/IK0
	ksUgLEv8MFJuzqxnF6lURLBVwohH9FKk=
X-Gm-Gg: AYBFou3M8p9UsjxJqqesOP43PoOOqGsiqqEowQfWW7sEGtE1au37Gi0h+SRBx2sCoeI
	YrrE+xuQM3L1Uqo2lKWd7FFcdTf2wnpauQ3alrcGsnF/Bi2K4VqJJtTFpw8szTD8PY2NctgpO2A
	e+4SlPpszj4YZY45X/gd5+72RhFqpai1Ud/y9Y1hL6BkTL+OmEqVsIAX5JitaVfUV/RFRoVpnLP
	61jefTMfZWnEAR9QNXoSNPVIVUwxHbyfSSzZZlLsuDT8HCpc83DvZm+f8EzL+8xlkVUX3Rbecv8
	X8Fsc8MibS0+vy0oVnxiR4q51AFRvtTNyxkoajKADjb5Ra2EnoaIlQNtT5vi0mpmeDaDJg+Xrv3
	iIvwHc7AbO/hgoyutOGT/1k0JfxR9FaplXflXMym7lDoUAAM8pDFCSn8RaYqOTGZ8
X-Received: by 2002:a05:6a00:3d4c:b0:873:2525:9a00 with SMTP id
 d2e1a72fcca58-87d178966c3mr805402b3a.0.1790109817966; Tue, 22 Sep 2026
 13:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-6-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-6-i.maximets@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Sep 2026 16:43:25 -0400
X-Gm-Features: AcwNN1XXS07Kn-HMsx7mvoCbQqlPeyYonKF1juQSv29HAtUDdVHgyk--e7m0r5w
Message-ID: <CADvbK_d1zZp6ajv9p8S_AaWZpH2aw7WPF5=TomCFxX3yioVw_g@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/sched: act_ct: remove 'add_helper' dead code
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> This variable can only become 'true' when the connection is not
> confirmed, but it is only checked when it is confirmed.  So, it can be
> treated as being always false and just removed.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/sched/act_ct.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index e72143d36b119..f62051ec9d57d 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -986,7 +986,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb,=
 const struct tc_action *a,
>         struct nf_hook_state state;
>         int nh_ofs, err, retval;
>         struct tcf_ct_params *p;
> -       bool add_helper =3D false;
>         bool skb_is_ours =3D false;
>         bool skip_add =3D false;
>         bool defrag =3D false;
> @@ -1096,14 +1095,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *=
skb, const struct tc_action *a,
>                 err =3D __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC=
);
>                 if (err)
>                         goto drop;
> -               add_helper =3D true;
> +
>                 if (nat && !nfct_seqadj(ct)) {
>                         if (!nfct_seqadj_ext_add(ct))
>                                 goto drop;
>                 }
>         }
>
> -       if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helpe=
r) : commit) {
> +       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
>                 err =3D nf_ct_helper(skb, ct, ctinfo, family);
>                 if (err !=3D NF_ACCEPT)
>                         goto nf_error;
> --
> 2.55.0
>

Reviewed-by: Xin Long <lucien.xin@gmail.com>
