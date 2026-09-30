Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA794EB846
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780902; cv=pass; b=gK5VVU2qk7EwwR5gFS3zHY2drpdVGOmAYaaKerzft2sbCZdg14imdn5Q+0xhdontuAcwqTYYtezBgVsH4ZoELmiEtyfque8N60OwkeD/uFdT49/e3lbgpg9HdNqb1Mga+62BP+1dpNHCcTy0Sb6yvemE/IHcwk8gVWTKu8xEGwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780902; c=relaxed/simple;
	bh=hT6uKFtdqOcRXKAyppkXaaDZAfO63Yhh/JoACrj3WRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0Sv5AsBls1D79rL+FO2Bv0lkybuOuMVlw+jzRnvvErNq5S51TZFcPvrIUGknO067HJwub+G9Olh7bHg1cvS4Zn7OZH3PRA5MPaLaVSXYzXaV55xVBNLnKfT8u96R6qlG4p3KVRuFNXFYcIrzmbLqWVWqYmCI8RudE5uZQ57Kbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJlmgC4A; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJlmgC4A"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20ce3c118aso305647166b.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790780889; cv=none;
        d=google.com; s=arc-20260327;
        b=Vw+/H4FY3nRReIbEEAHsP1SF2AReETtsq5CaAoGeIITeQuWg8nEcgROkxJF6197f/9
         Hjm1pM/+h9tmohoB9WS5sTaKPzSxLTfQi1AVb+uGEb5bdNTheIMPx8awE737FGf4G7rx
         9v0ITlToAWs+2KjiRtpdP9E3uo1fqu6j3WW7pnCMVmH7cKE0nR6wXH3RO9JQI1LQCIa0
         cJGhANcceRidsqz2cTu7Uea09Vcg/DYJdKHzGv2fdmQsSffUH0NM/omaUKww5r0ICHpM
         3fhYfpTYd2o8AT2KqiO3eUQcBBBVNI0nNZs2rYbZXLGVIxql+c1aOS1/LieQEvjTQXhA
         eHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        fh=vaUqu1g79prZlnW8F47DW1EaCM2wH4Lpxq4NMIm1PCQ=;
        b=nbHf+P0lAYDNT80wZ5okvQIqT2joBqU06j32SMa+i9kqwzsuwc649509FKgXEc7sIY
         GzPvKgeKjfUGuQmoI/c4LzflZddf8UhNsrPrKgXwde2SW1PrP01OQ8xRR00R0WjxwKkm
         JvkbYaS08tjxf5+mILuXlhxKDFgN/jqikfoS3JQUOXhe00Oa05jNP87gB4KcEgbHvi/k
         Hm8x+rgIjGA3DEry5Cnhz4NkqDKvRBzW+3WXc6vLs3JnBNzd3PCkDHpAYYeP+mDA5dQ0
         S85Mav1TWFpVunthrYSK7To8nwLz/QfTZpnBKnk25SUiMNgA901IIuxCF6K1GrFKYqqi
         pkNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780889; x=1791385689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        b=iJlmgC4Az06kmQAbbfD9zbPJsV9/ylzCsEQbvsJ+MV/8PIGfPayTaXW9kb5f/Cuuhj
         OapNpxXGKNN8j0TVKGWz9pUZ9a/ykvwHM0Xhp/eUCDxmg1lENLal5MakTWShYfY1qqC9
         hheETli6dYI9nX7Q5+/vL885hOk4VnPYxwQXENBb6h0LiSl05+3TOOO5mtCqn3YUu7hJ
         BGoH1+SDzsktVDBoNzAkZtg+3jltOvrm+SpWuD3ec7b1HODqB5zQPML+TWOm4aFBWCWZ
         7GU9zjOwFGOfJDhiH3BRJq7VaDK9Ubfen/30XVS+O21N/Wp//+Iq87oduyO0KdZ8wnS9
         kKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780889; x=1791385689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        b=2y5gRECie48SjMXEGz6moBXfrNFYx5AkJmLvZ3JSEpmVKfeT9xDPLJshMWoRDjpP4s
         teqqakveSqKxM7bXItZ4wM5U9GR4+ByZbBDCqaFvBhoQXEvIO18JTS3oWccv1XJjFAHa
         OYBgd7Rq7KVpLRlLmNgOVrnb3ZBf+X1sqqVw0w60KR9p1pmojwT1UFAb73htAvXHDTvN
         OeKnn4Cl0Fyo6DpnLDRxXYc5tAcDrDbJY34tqKhqiJ5TzjXaDvPUeqKHBZGoV/W/RVAK
         eG6EPS9tNWqpzL59eZYB5/4nnUTTeY9btALrXwWLhDJRMDU+5Os8O1BYzzT5XvtDrR9R
         hr5g==
X-Forwarded-Encrypted: i=1; AKwUvByeTG65vufgFMVsC9zjEohUbK8oOLTl7WiltU0ebqtN2Bvds2AldCdP68kMso1ze+sCphDYExw=@vger.kernel.org
X-Gm-Message-State: AFuF++kVt/BT9tVIUKR1mdXMHJZRfO+aMlO/M04qoI/GlC98XL00tvhm
	+wGO/PNJavI26YqQbZrPvk0dJlQBkWui+EwknG8IKewd0JnLbHNcDWCnLVCdDe5CRW2YCgvfnRZ
	TWpBDhWyCOqtwQvD0KT8MI3z/5EWr2H4=
X-Gm-Gg: AYBFou3vOiMiyVIktuIOuhdc+Cy2vOTKM/JXgBj+mRvU4gHOK9+muC85ixOZTARLE1D
	zu8JPpXCYAsBr3aKzo9aBiXe038ygKj+CrgYvcNbRIMyPlwapHu/YiL4YxbFuuLh+nTgMNtAxv2
	FV9nRhgpo/07BfQZNxF03veH3ZUpq9K14JNaCZifS+JuLSBT1uOQcDrqtR+nR9GHHF4S+52xIro
	kbQzKKi/NHUOoYr9L58N4uZaOKPR2Q3ZjruBTP1UInFkbaMfbXcAF6OpD/6fRf6I1/D5y2DYXbG
	DYrggDXIPLt39ptaevuuMLWkwfLn5+Cz3d6bjt6DqyrAXgC9Lfeyt7rw
X-Received: by 2002:a17:907:3e1a:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c2e23d9558amr152172866b.19.1790780889315; Wed, 30 Sep 2026
 08:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org> <20260930-work-mount-fixes-3-v1-13-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-13-be34c83956ae@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 30 Sep 2026 17:07:56 +0200
X-Gm-Features: AclHuK9qZXCPpQtL11D39UCo-F3cSnL8zEaPtult057jKkP0CoRv6AK3ktwziVg
Message-ID: <CAOQ4uxgJq_UsqfAxJGtnyeyyoB=2XD=UTXp1Lgr-Ze+XNKPVEw@mail.gmail.com>
Subject: Re: [PATCH 13/17] namespace: remove the fsnotify marks of a mount
 namespace in process context
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:32=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> mnt_ns_release() drops the last passive reference of a mount namespace
> and removes its fanotify marks via fsnotify_mntns_delete(). That takes
> the mutex of every group with a mark on the namespace and the spinlock
> of the connector. Fine from process context. But mnt_ns_tree_remove()
> hands the reference the namespace was allocated with to call_rcu() and
> so the marks are removed from the RCU softirq:
>
>   BUG: sleeping function called from invalid context at kernel/locking/mu=
tex.c:623
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper=
/3
>    __mutex_lock+0x113/0x24b0
>    fsnotify_destroy_marks+0x11b/0x3d0
>    mnt_ns_release_rcu+0x57/0xa0
>    rcu_core+0x6b6/0x1e40
>
> and lockdep complains about the connector lock being taken from softirq
> context. A fanotify group with a FAN_MARK_MNTNS mark on the mount
> namespace of another task is all that's needed. Root in a user
> namespace can do that for a mount namespace it owns. The task exits and
> the namespace is freed with the mark still on it.
>
> Remove the marks in free_mnt_ns() before the namespace is handed to RCU.
> That runs in process context once the last active reference is gone. A
> mark is added through a file descriptor to the namespace which holds an
> active reference so no mark can show up after that.
>
> Fixes: bf630c401641 ("vfs: add notifications for mount attach and detach"=
)
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 0a7d50db228d..3c90d853e091 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -130,7 +130,6 @@ static void mnt_ns_release(struct mnt_namespace *ns)
>  {
>         /* keep alive for {list,stat}mount() */
>         if (ns && refcount_dec_and_test(&ns->passive)) {
> -               fsnotify_mntns_delete(ns);
>                 put_user_ns(ns->user_ns);
>                 kfree(ns);
>         }
> @@ -4279,6 +4278,8 @@ static void free_mnt_ns(struct mnt_namespace *ns)
>         if (!is_anon_ns(ns))
>                 ns_common_free(ns);
>         dec_mnt_namespaces(ns->ucounts);
> +       /* the last active reference is gone, no mark can show up anymore=
 */
> +       fsnotify_mntns_delete(ns);
>         mnt_ns_tree_remove(ns);
>  }
>

The question should be not if new marks can show up, but whether new
fsnotify_mnt_ events can show up.

I think the patch is still correct, but maybe change this comment or remove=
 it.

Otherwise, feel free to add

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
