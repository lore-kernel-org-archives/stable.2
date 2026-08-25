Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9316DEB1
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787619588; cv=none; b=Ow5tU5T+U7zHNV5xolsNobBu8jXwdw8WbmuwXWkM/zqe89vZl7yWMBfSiaaOLZ8w4V7c0kGoiuUZ4BGJRLAeQyFFbJNjH0/e49qB9xLak9z5tk1McN2QpvsSJfsKM6BiMrzcqW+VcN9rbt0qbi1W2+42GUuJO46G97NpkCDYCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787619588; c=relaxed/simple;
	bh=shNeVnxgPhWMkYieAjhk/IVt3GNRZrYxtX3YDmzS3TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mey3N3CRWOvqMpu+V0FjOuFuHMS8yX0s37OnFGRPQU6Rnb16lMQpE2PKH3fwM5tYrmSWiXNkuvaqTMsbBGfT+V9OPXAZkSpITNTqEYdISN8NJ00xhV283EnHtzwVwJukBjTTJjvzz52RNpWA/0Qf1Z3hmJeAOo9Nby+Pf80oj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxmb8oet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxmb8oet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DD01F00A3F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619587;
	bh=fEeLpys/hVxa2Jf6DKcJxfPsS9WWpLFcb2O+9vN9MkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Kxmb8oetXSejwPYEVUZNzSsP7fdn8JwkSIxNElr+MVyTl3a6HQxRI9qlQrOJLJ4yz
	 7jlHi8HBA7corydH/dC2A7Kp3UvKeq5iBlmKlOYifucpSTploEKc0hi/hwPdTCFwGL
	 01FmNAkqoSfCYrasifgepyTYZCgRuNGbzcTESOJidoXHgAbXUyKseSDQ5Y3SYfBKYA
	 wbBFQvruiJj6UUKKApHPSaXEQKf1C08PUSVrYB/NeiIV9+oz2QSkQpFkpc/OUhIErY
	 YRfLo5CzrGpus4IOO4hnXjY6eVQGltHTcexo5zDyhNBvrj/QDjlDoumfO6Nzo4TdaC
	 gE1Ckfrp7yanA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15f020a223so614295766b.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:59:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpviHNz7dwMioYBK0veY9b6z+LlkK4ySWQBGSs6YvRF96XU3fAe0chRc0BCGecDtdZKgkx33Yc=@vger.kernel.org
X-Gm-Message-State: AFuF++mwI84hhGpf/x7h0s9b8B03z1U6T4a315hTqlTHPa7xwqMezK6K
	8EbldevNtmFB7NxNQiKmEnk0ewvagSKF76SK8l5APz+XRgNfzrptnSupsRBDjc8NN77rGi2Jwqi
	+1uaQZnuPzybgH3GWOIeS2nWsgECkOiw=
X-Received: by 2002:a17:906:5183:10b0:c16:84dc:9607 with SMTP id
 a640c23a62f3a-c246a704562mr2696668566b.19.1787619585652; Mon, 24 Aug 2026
 17:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824231030.3502884-1-sorenson@redhat.com>
In-Reply-To: <20260824231030.3502884-1-sorenson@redhat.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 25 Aug 2026 09:59:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_E2ZGzXzRJWCu4knD50LjXrC+dn4JPr8jxNMi5daWLCg@mail.gmail.com>
X-Gm-Features: AcwNN1Xsc64SaR3a-QfPBo5enA5iYQb8CTtqMRRw6llvE8QowJrPmHoHeU0QLKM
Message-ID: <CAKYAXd_E2ZGzXzRJWCu4knD50LjXrC+dn4JPr8jxNMi5daWLCg@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix OOB pointer arithmetic in cifs_to_posix_acl()
To: Frank Sorenson <sorenson@redhat.com>
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, brauner@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 8:10=E2=80=AFAM Frank Sorenson <sorenson@redhat.com=
> wrote:
>
> In the ACL_TYPE_DEFAULT branch, cifs_to_posix_acl() forms a pointer
> from the server-supplied access_entry_count before the size check that
> bounds it:
There seems to be still oob issue in this function although this patch
is applied.
Should we also validate acl header before accessing ->version ?

+        if (size_of_data_area < sizeof(*cifs_acl))
+              return -EINVAL;

        if (le16_to_cpu(cifs_acl->version) !=3D CIFS_ACL_VERSION)
                return -EOPNOTSUPP;
>
>         pACE =3D &cifs_acl->ace_array[count];     /* count =3D access_ent=
ry_count */
>         count =3D le16_to_cpu(cifs_acl->default_entry_count);
>         size +=3D sizeof(struct cifs_posix_ace) * count;
>         if (size_of_data_area < size)           /* too late */
>                 return -EINVAL;
>
> The pointer arithmetic is undefined behaviour before any bounds check.
>
> Add an access-ACE size check before the pointer computation, matching
> the existing guard in the ACL_TYPE_ACCESS path.
