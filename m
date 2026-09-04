Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F4330668
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531943; cv=none; b=DkPAfHKvHDw8QKarRZwohfc1TCfQfvBW5E0+MUY9gABxF8I/JFiHPC6738guB7gZ3M8lTpdSuUhu+W3D5SFEezLIFMUtDRCzwXVKnIxraivZ9fKhWaADWNMHI+JgbWYO6kSiBx9Teqfk1cKMmhp0gI50j9RUGChXn8qCq/i3/PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531943; c=relaxed/simple;
	bh=N9jW2D6HI7fwkN6ApOZVSB6j4GuTpaSPSt0vJM4Xk3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehSQGa9Cxyndo+iU/jIL9GT0Xvkzl0YVJOm+v7845gauYqih02eRF27JZc043rAWYH3lm1cu5FWcEszNytiS1UHgvfS3GMVsZrTIpZxDhS5CKbJ3IhU6ZXn7xGjXDAAKRhavYBfkJSGemE0tAlkyKjbOwyWBehd6wS8dzU1/d+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKBvKJVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKBvKJVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCDD1F00A3F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531941;
	bh=U7csAOa67E3z7siGZuNmFuTYGHC8EwJqcv3gDqXHkwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nKBvKJVfIGWjogE4Cvp4W1jk2lMGWC2cdBLBV9kwzsWRnh20g2xoS9ysPfbjoR91g
	 sSbyUM12tD6oYewzqnXsKvanzKTcC3y0j51MtYi2Y+aTRt1+OHuAK5gC/iPNS9K+Ia
	 Ygk593j72g7xbiNw6ChJ8075Bgo7549RVBhrMzLIiP55Dh9aWpVOYFOV+dpowGzxi9
	 LXV6ZrTkP5QsRKRqKv6vjqjEVB/bhwDEhGdszZuWiY2mGewTRcum9porgby/aCI7qD
	 avs/2GziBkoQoSjpUFoTnhrcOz1TzZ8oIWvBp32Tw/ZYKv1Rr/JzIJn7VthEII/Ip/
	 hrIEJyoJCtfgQ==
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c5a818a3d6so888402e0c.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 07:25:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw1BpUSyHYu9zf8kmoCh3ELIqDYCF3B1lvct5zMCUM5IzzQ6O1zV9KlmPRxV58O7R46A0/Pz0M=@vger.kernel.org
X-Gm-Message-State: AFuF++n8bHQcpzU2oxUFvyoS2RX1+NCmtdMzKzv9ElkDNuRn5YQVpaXU
	cET5iFPWOqnlnSFWYAzm4JtxCg/wpX1NDmAXyJHvffPvGbM627+GMioS8sVyLsy0ZSh/FJ42yRc
	c7bFpEM55x182UbuyihT4G5fzwCK3xXE=
X-Received: by 2002:a05:6122:1d08:b0:5c7:7cea:31bc with SMTP id
 71dfb90a1353d-5c7ed6111edmr2892028e0c.4.1788531941014; Fri, 04 Sep 2026
 07:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815090136.88540-2-thorsten.blum@linux.dev>
In-Reply-To: <20260815090136.88540-2-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:24:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hrkDVWpxu1u9KHoeYrt+p0ofz3VOXrRJ9K3ixn+5k3JQ@mail.gmail.com>
X-Gm-Features: AcwNN1UX_ZKJf7rjf2lJ0dnAmgZ3vQLzbWsF5uHRvbB61cyLKvvvEo9TBo3ntps
Message-ID: <CAJZ5v0hrkDVWpxu1u9KHoeYrt+p0ofz3VOXrRJ9K3ixn+5k3JQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: powerclamp: Reject invalid window_size values
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Yury Norov <ynorov@nvidia.com>, Arjan van de Ven <arjan@linux.intel.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, stable@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 11:01=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> window_size_set() sets ret to -EINVAL if new_window_size is outside the
> valid range, but then falls through and still updates window_size to the
> clamped value.
>
> Return -EINVAL immediately and do not update window_size. Also drop the
> now-redundant clamp() call.
>
> Fixes: d6d71ee4a14a ("PM: Introduce Intel PowerClamp Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index bd7fd98dc310..8026651133d5 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -289,9 +289,10 @@ static int window_size_set(const char *arg, const st=
ruct kernel_param *kp)
>                 pr_err("Out of recommended window size %lu, between 2-10\=
n",
>                         new_window_size);
>                 ret =3D -EINVAL;
> +               goto exit_win;
>         }
>
> -       window_size =3D clamp(new_window_size, 2ul, 10ul);
> +       window_size =3D new_window_size;
>         smp_mb();
>
>  exit_win:

Applied as 7.4 material, thanks!
