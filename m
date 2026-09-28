Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE631D757
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571302; cv=none; b=OZrBt9OFRo/tjZNMtUKcsD7vTnekJNPCyYMGtp/p3gCLbSb26soPULfKI3CutcKF7JY22xZ7PU7MXDtNLcb55LbhlMQuRylYxKWSVwkiGWgSy/a8KkZ9GfPEClAAo9uw2PuqtW35r5FW1GqnhVXwlSH+Obcz+ZYlgG/rluXc0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571302; c=relaxed/simple;
	bh=bC4SqqSr3IJPKQYcprE7TOLFqYlzYggv2a8S+aFZi1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icn6g2CxzEh85x+a8r+Gve7XUhTkdh+Cb8rMHh2Ogj/yx9jh0DYmVVdNGOX6V7oRnFeqv2j9hc6QI7+Ylb2EAUoz+lCKr4qGkoiu4DnbVya5dotQVZl3oFaxD/Et1M1Cczvwkm8c8F0MGeLxc/+CVzWbUvkQaxpf1LkyPqq4p4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAe/5uzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAe/5uzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DA71F000FF
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790571301;
	bh=/9HwzDg0np3qStQYEZSHfzJXT46+IW1tRSt273TKSsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lAe/5uzbg0orL6uWT0CI5RsoK4+PB0xS51g0DCDMo/beS38o0HYb5WCUjo9375vOW
	 hnytZZm8AE5o4s9CjdC3xAK7ywz3NH2eic+gy2yMJg/HSwYa3Ur/oRX1sOEv1gchg/
	 0WKTvaYWw7OCv072+to3cTAjyb2vj6+rFJv5L3NjYrP5/FG6PYd7Ljx008oM3wngJ2
	 FyaFzc1+m/V+2UEL4EQyJMpuirl2uyoIZ4xvCEVeu3nu9MJhtbjcmPSUIvU/bRGR8Q
	 zD7AqgoNaxef7JWP4yYyPEc2NEgyGHjiZyjWx/+lHT3xJE+qSrfeA5xfiVZgRydDqq
	 fcFZA0bH0cUww==
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dd363f57aso61119366b.2
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 21:55:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByJXk6sw4rEqdJq9vvE0dQMfBHH2osVHbxK6myDH5YbxjIZwECmOh/3LsE3qtjNwoEbvO3cVYY=@vger.kernel.org
X-Gm-Message-State: AFuF++mFC0V6S3k01dGrmoBrRMyEvBhQTm7EGIAFQzLnXY3hqhOSC7bT
	WL1BJhfPHrM9/Y5hjzs/9/uInQBJjHsKhZhkHYp8WaWZw9W/raCv7cUGVtNXYZGSATlL1gpRhxl
	HSQhs6U5LYsNXzs4hDbJ2Wtl7u9LBr7g=
X-Received: by 2002:a17:907:7b9e:b0:c29:4970:abec with SMTP id
 a640c23a62f3a-c2ac24cb86cmr1021730066b.19.1790571299622; Sun, 27 Sep 2026
 21:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927063339.1731061-1-zhangdairui@gmail.com>
In-Reply-To: <20260927063339.1731061-1-zhangdairui@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 28 Sep 2026 13:54:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8eaM2iANsAOTTHe5CLdFWBg4nws3w74e3pVbi6ioYXwQ@mail.gmail.com>
X-Gm-Features: AclHuK_MFl91cj9FmUBRIXALyMi5ag6c3FdBoNJRKPQokRULAz_45Q6sxrBjKBY
Message-ID: <CAKYAXd8eaM2iANsAOTTHe5CLdFWBg4nws3w74e3pVbi6ioYXwQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix OOB read in ksmbd_validate_name_reconnect()
To: Dairui Zhang <zhangdairui@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Paulo Alcantara <pc@manguebit.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1714,9 +1714,13 @@ int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
>                 return -EACCES;
>         }
>
> -       if (name && strcmp(&ab_pathname[share->path_sz + 1], name)) {
> -               ksmbd_debug(SMB, "invalid name reconnect %s\n", name);
> -               ret = -EINVAL;
> +       if (name) {
> +               if (strlen(ab_pathname) <= share->path_sz ||
> +                   ab_pathname[share->path_sz] != '/' ||
> +                   strcmp(&ab_pathname[share->path_sz + 1], name)) {
> +                       ksmbd_debug(SMB, "invalid name reconnect %s\n", name);
> +                       ret = -EINVAL;
> +               }
This change adds path length and separator checks, but still does not
verify that  ab_pathname starts with share->path. A reconnect through
/srv/b can therefore still accept a durable handle for /srv/a/file
when the requested name is file. Please check the share path prefix
and component boundary before comparing the relative name.

And can you check Sashiko' review comments ?

https://sashiko.dev/#/patchset/20260927063339.1731061-1-zhangdairui%40gmail.com

Thanks.
