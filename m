Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D8423EAE
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822623; cv=pass; b=PfapC3j6p+nLaQqqGY1kYhfddMAXCEvWoobcjdivVeJCDTj8Fcq4r8Mn3tKzDegQrAnMatocuDJd17fIUxjzKuSAxy9FxiEW9yu6ss46ew/4pF0LqqGdAO3LrLEOjpvkhJKMmJ19IlW+Npf3cFlztOB6dxYY76TY9iF2w4GNtNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822623; c=relaxed/simple;
	bh=DBHBD4i87XSNXLCWnW2smU6A62RZ/Q1PR1qnDwQ3R8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1lPmG9Wmfcg3hZ2mGUhRztfv61J97tWWPpbNoGTF4NXUll7JRbjjS0uRF9HZdbowQvgkwniv3hlBQhkFV9TFgpq2zaV6jL0KBvTGDdHApxSqyMFDCCINj20NPBtd9+zooDVVGzwvZT0OxUPw9gXuCtDZHmWuLjUf2xNio0SKiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=N/9CXmyH; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="N/9CXmyH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c20e70a0962so63921366b.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 02:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787822618; cv=none;
        d=google.com; s=arc-20260327;
        b=BL8m+xndG9ThcxvwbgExxG4rcZHtlR0vq6OJaAugnXbi/qA5gUkY/i0Q6rdb/3RWJS
         +w7RgUFzPjvbbylb1aP3HAi+grtZQkWQrOhyQ5LAQ2OhiF0PGMv60NUwxtXs5K0vyrnN
         CjEfK8nmSCjtROsFRLcZNT9XUfuHbIR5Z9kWDKU/bWSLJsNH0T0l2LOt7x66FIYLkhxI
         3qenx9+zQVePcIp2VUUvAIFKfAZdGKpHYavI4lRnQ0C+ErH4uf3EDWNPe9XUF5zPN+W/
         CAS0jILhXn3dZOCPFt7WopawbvL3lVOovEebbkWcjMp30jTdPzWp77lGsFukQbuWuqLI
         w07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fph5DeMJCI7nJtUOB89Y9QP1q6g7bQDJlAzprLWOYQI=;
        fh=aguHuBrMgTQdW/P+GRpaYNlKAoLBRmR1HLTia6lfSEs=;
        b=VQCxkQ3RO6r5n5pUyLAPUK510tyCGoOWJuKqJ/3mPymOIWh/qSGoD7V+777Z30+uzo
         YnJK+h4YfzxraFxR6PYejqC6IfDfWouq7b2j7M3r0YPY8ZGqONOwuvBgsciCmKrGx7pc
         bnwA6lhYoyHWfCaL8uTT727QXNv/Mc9rdg9oRLaDQLzy1Wh8/DiXE0TmiR5su/UZck2m
         TynjlGc9TjhV//184SLKjoETyc2S60FJRL7ZvsLGhdUrqioRUGhWvtuQlJ3GM+leSGgH
         1RB8L1ITfrMkcRGNTJ+3ilIUNHyDcjKgGuHW4y6+VF0nwFow+TO56sU54cKQ5PKMpc1n
         Ev6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1787822618; x=1788427418; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fph5DeMJCI7nJtUOB89Y9QP1q6g7bQDJlAzprLWOYQI=;
        b=N/9CXmyH5ZA3yuT5sWoq6ccqE4jFAIAbKZDuYmufvz5csYrdBvAypgbiYduatTIWAH
         r+9JZ1d9Z9/oCn7vHw8hxEaHnVfvTFowEBFqSxV/mMvLuXMgvv8Y+9ECu6DMx0ldMvwf
         rrDwNy13uSIX9WCQXL31vz9UIXDnOGZNg01x7FInncPFC6kMNEiRJPtf0uU50/91Ujd7
         5j1LaTrWgqY+prhgPpQyiwuf5fDijvlTELVYj9lcYnK5lWdp4KvgLwRyxC/n2a167PHA
         F9nwX7EVvwZXFi0e92O8t7Hfr2ygUN6aZ/rgxy7SzjNEqJNDd97Jisv9/LTzAAAGm0c4
         hJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822618; x=1788427418;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fph5DeMJCI7nJtUOB89Y9QP1q6g7bQDJlAzprLWOYQI=;
        b=f0a1ZiylR+DYubFEl6tAdkU+QkQuhr+X0+aHdH8hAf9AAaE0uip0vsMcDLaikOphzo
         STwrBFaSE9FFqr0mDAnG6LYg9iXoyWDAfvy7p7s/slHyWxjRORVApo1z2VizPe7qS0xi
         naSgv0j3oIJs622G+GyG+fkUv3eRw1j8Axo5TOO9tlvuhB/1oBnNwgKOJLRJRkY7rFPo
         5ryCMPWM18JnXcrgTWp8v0sPolKSjSCG0y/yeXRcVsnU4NMrwoaDhn4Qef2Gyvb7Ewc9
         wKuNL6J4XmXsdOSVyMoJ5R5YSXR+bwVmuVFfFZl2xCRWVZ66XQRCIFyjrkGjq3U7zd7+
         3rDw==
X-Forwarded-Encrypted: i=1; AHgh+RrfsCvK+ZzawtnOi48CRSl2ITtkR1jhc+i+rH3luxx2DF1BW+iXEZEqbLcaQsF3fx2fwevocjY=@vger.kernel.org
X-Gm-Message-State: AFuF++njeV7Tw/IlQgEnzs3qnUw93VFKf3J1TaLLg0age1tUzZPSPZ4+
	3JafEc4ozBhslH6u3WjOLWT5Yy6P2+YKW950qmYgz6V9f1grweMjTy83/eIsVsnpRIv2W2An9Dr
	ph/kZp0eYgNmRtHs/NBtwbxguqi4AhVOVkTn3oStIlg==
X-Gm-Gg: AR+sD12wEeJ0X6pHp60if59ukSqQTPoSFlMRf+0nd1H7mtkyWCawM9qGo1LhpapllXn
	V2HizvkigeW1SC5PQjrGGn6wmeZ5JkZ3OOvbq5hpuc8WtVlZ8tCxvbHiwJIxJOjFGN3Vq/Fbb+r
	t5cQ9l7C5kaP8dwho1AZPxZdoEZ292F6YgNMicjNP0cTflHP3DjcT3cavAneTJhRXkS15hxTZ25
	jttu0/jxZvsru5zkK6FliEsyBXkqTVpZn1t3+VufHFbYKMIQlRecjesdBRq0aAWVced0wF+xItA
	pDIIlIClanwLXCyh3/3WcgEOOhFF4hyuLOzIg4zYw0lDRZ6xdBnlwl03
X-Received: by 2002:a17:906:9fd1:b0:c25:362e:fb8b with SMTP id
 a640c23a62f3a-c25362efe10mr476489366b.7.1787822617738; Thu, 27 Aug 2026
 02:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824164707.225547-1-max.kellermann@ionos.com>
In-Reply-To: <20260824164707.225547-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 27 Aug 2026 02:23:24 -0700
X-Gm-Features: AcwNN1UwIC-FqqFXy9MiN3M9lqUGjoxGkQeIpqgmUwjYu1w1OyWgOlMiaP06l8k
Message-ID: <CAOJNxR+vqTNU-1k5tCO1XPBbaVYi+GK_X+x9M5cOtN+BFvecdw@mail.gmail.com>
Subject: Re: [PATCH] ceph: lock mutex in ceph_mds_check_access()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Mon, 24 Aug 2026 at 09:47, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> MDS session OPEN handling replaces mdsc->s_cap_auths under
> mdsc->mutex, freeing the previous array and its strings.
>
> ceph_mds_check_access() traverses this array without holding the
> mutex.  A concurrent session reopen can therefore free the array while
> it is being inspected, resulting in a use-after-free like this:
>
>   Unable to handle kernel paging request at virtual address 003aaad64b2c8bb9
>   [...]
>   Internal error: Oops: 0000000096000004 [#1]  SMP
>   Modules linked in:
>   CPU: 56 UID: 2953037534 PID: 1253231 Comm: php-cgi8.4 Not tainted 6.18.45-i2-ampere #1146 NONE
>   [..]
>   pc : ceph_mds_check_access+0xd4/0x550
>   lr : ceph_mds_check_access+0xc8/0x550
>   [...]
>   Call trace:
>    ceph_mds_check_access+0xd4/0x550 (P)
>    ceph_atomic_open+0x138/0xbe8
>    path_openat+0xa24/0xfa8
>    do_filp_open+0x94/0x158
>    do_sys_openat2+0x88/0xf8
>
> Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/mds_client.c | 4 ++++
>  fs/ceph/mds_client.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 3c692ad02c85..0348e8b848ff 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -6532,11 +6532,13 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>         doutc(cl, "tpath '%s', mask %d, caller_uid %d, caller_gid %d\n",
>               tpath, mask, caller_uid, caller_gid);
>
> +       mutex_lock(&mdsc->mutex);
>         for (i = 0; i < mdsc->s_cap_auths_num; i++) {
>                 struct ceph_mds_cap_auth *s = &mdsc->s_cap_auths[i];
>
>                 err = ceph_mds_auth_match(mdsc, s, cred, tpath);
>                 if (err < 0) {
> +                       mutex_unlock(&mdsc->mutex);
>                         put_cred(cred);
>                         return err;
>                 } else if (err > 0) {
> @@ -6558,6 +6560,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>         doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
>               rw_perms_s);
>         if (root_squash_perms && rw_perms_s == NULL) {
> +               mutex_unlock(&mdsc->mutex);
>                 doutc(cl, "access allowed\n");
>                 return 0;
>         }
> @@ -6572,6 +6575,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>                       !!(mask & MAY_READ), !!(mask & MAY_WRITE));
>         }
>         doutc(cl, "access denied\n");
> +       mutex_unlock(&mdsc->mutex);
>         return -EACCES;
>  }
>
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 0ece4c9e3529..8774c7d7d18d 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -603,6 +603,7 @@ struct ceph_mds_client {
>         struct rw_semaphore     pool_perm_rwsem;
>         struct rb_root          pool_perm_tree;
>
> +       /* protected by mutex */
>         u32                      s_cap_auths_num;
>         struct ceph_mds_cap_auth *s_cap_auths;
>
> --
> 2.47.3
>
