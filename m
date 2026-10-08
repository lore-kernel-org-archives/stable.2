Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259283AFAE3
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438193; cv=pass; b=gHDTGthivgzT3UCnA7P6/J0ZtO8xpD2Y9hOynkIcdo6o4Av8ZvXQg6LqxrwQ+95uHu4wl6J0xMHnRdHi0x+0L+fdHNYplrmRxxwfFp8/YMUIFluG3XZj6f5q5N4mofyKN+06PcOQU93JPi/TF7mkRm3UsRXV8cLv9PPwxxu8o7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438193; c=relaxed/simple;
	bh=HZ7ucweag9Bj3u4dkisTXz0QU0GWHhGPnKE9QX/3n9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR0Yb4Fu6miPhlX1tQ4tiiwi5hqDMBE1glCxaqdUoPtRB1A3RY1QndSJ4ecjJx2GNEaC+DzHivo0ojIH/rZI4Vs/wC/Zy1WwNdAccikrMSRmTUPmsFk2w/XT4/bxy7cfX6cXtHizsn55cmvFclLuJWygmtbwYrF6jtC+O3Tt6ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aNMSaC+u; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aNMSaC+u"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6af9befd04cso6458291a12.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 22:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791438189; cv=none;
        d=google.com; s=arc-20260327;
        b=RP3zuc7qdEBIbAYJ16GLX/a/y8GI56jnAAULog82GkIFspQAXsAL0c8WZdE/YOewMQ
         ULcg6UEkMIekRWAroJxGxprXJDXMtoNFoZCAzu5XwrdqVx6gnR6UvyS+CZ2fkFr/cgSs
         SWJUgSrQhrGLlEx0A/FzI4nY2J069a1AQewv7FGAjmNArYRshNH3AuzLS34Np2Kj1lBU
         sgr0yLk04gM8ymhlzEP+4LOlV9fyEwYKCb7hsp7HKqym95wjiqUwCPzDcS0h7AGZ8Ukc
         XIxWA2iITm7Nmzge0d3JSrKATDagX57Y59SIjlDk0O+R9sbi6NZ+Dry2ZDzZCeMbq8R8
         Me7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oFQVP3Icf9nV+7X1cbKmKKwaGAM1phqqNnkrhrVM1G0=;
        fh=4BpTtji2XYWQZ/K21lw3SROlQSgAxd5XKMrgw/yt+uY=;
        b=gKcS8F8V01D5k0W9xChsyS6A06013y+ulZgRE7RIYObORywuQ1rrTpkRgJu1DCY+rB
         y3yF+KaZ2JllLUUGnUzsWvsR+JsxHjlrQbah9ibRJtwEBxfR2P8FleZOhgodJhyCd22h
         WnqCCz0dLnOBi2dsdL9BVYaWAOLkHO9QAUJb1GS0NdWjAsmVmpGMNRKoWPy/yIsh+Kjk
         5gxo1D7chOfbZmQMQC01tPWUfgGrRjHZeetlgRH8gylhxasPGOfTkwhIGsBbeD2wBwCO
         azz1Vc7AwzMa0zlbmgJU1Spk+zu7MbHKty95tbwXXNhA6FeBt+Gyp8xHe7MekRi1CMV7
         edHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1791438189; x=1792042989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oFQVP3Icf9nV+7X1cbKmKKwaGAM1phqqNnkrhrVM1G0=;
        b=aNMSaC+uO68npw7cj4BtbssEo9lXieW4+XhkHExJfmh729+078KVeZy3FrPhV7B8MH
         tNnYFUekvMltLyYehfh/szzDcnc9DmqWlZfYxB19iEfv/BmVeB+zFmI1mXow2emoPYJv
         uAm5IPAb0dwErT6ogt8IRxNTx9ghQr/+htAqKN1pDea3B0IStx93pIND30J1sTfkDS3n
         1E+Y4Zunb8ZtVK+NuEOEVdB1Xr/btA98vktwpjt8t+jCTZXHRjbW8iE/bHDq50b9YIzt
         6P51VvWKNyrVmVNXH7tQ9yNPItMSKlA+17gWSv3jT1PvQf9Fb6AawDTjpJBe3R+hf39O
         nbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791438189; x=1792042989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFQVP3Icf9nV+7X1cbKmKKwaGAM1phqqNnkrhrVM1G0=;
        b=i2hshSMs+GT8ciFJlMnHIdv4rE9YaizqMHnVcUOEGsqDc/acgjWrTrOnyqMbP3Zzo/
         uqMCPlvrx9uzLEJd8ChsuEPxgEhNsNfRdTh0/Ixj+s/c8E0r4lkSdBbMGC2pptdJ4Qhm
         8GaSrswpV+r/k52ukXGal95vs5x1q3irsMXV08hbxpsT6InD3HtUn2cY/EJbLhx+Ii9v
         nVxK6GDA/7jc7RlM6PugxUNLAleGjWkikIkBYkJkKZ0Pg/yKXOq2w4Ha0u8don0w0v30
         uA4qfeMvE/W4CAOlTKNQtfSRyX745im50lbPynPXpON9HDaz4LXDlddSvpsnBueFjc/q
         AMIw==
X-Forwarded-Encrypted: i=1; AKwUvBzLprD3nMJteq6XEviJR1ZMoXGcIDJyytLwDsZ8vd/6h+0wQqk4XIsgXM/zcLjktrwkkFRy5So=@vger.kernel.org
X-Gm-Message-State: AFq9FYI40O0IOf8VQ/YLTvrRfZ45dbljqWrp303u/LdY54bQIeGQj8FH
	xPErIDfZQ5DM98fRbPlNsCmFhrmPjRltPGsgDKE1M/JnDvD34qFI7ZItlS6mqVcNDK0Hv8NTFoP
	zhWMwQ93EDRjjpLtDDn84O/2h6ybnrij1R54BKgI2uA==
X-Gm-Gg: AYBFou2A6FKw4ExKJ0c16jEj9gdi8my+uf24QjmF6nLkU+vtND67Yeqrw6lu8ttSHS0
	LZW3JcQ7hWk4qORZeIU2qS+oV02OCkt/tKfU320sBt+YQkbshDnamey6oC1+bJ+CLoUCQ11t0ge
	eMibYlUnxP3isga1yQIl0/ZbaPlugK63SfkY3cLxitcFIA8awYELA4YhyNj7q/qVN8kKYxrvlWL
	2mGldO6WrcHAqi6LHsQ2xWegGV5pNlwANEukp8Z5ieuTyGcLfD+7Jg6yYsGWDZVMMoZ/2QPZGBD
	RPArJ01n/1F0KJmSqWS4OXCn+mD4wmmnNYadsAYi6j2l6WaPtgaRydBAXg==
X-Received: by 2002:a05:6402:3202:b0:6a7:ee54:f897 with SMTP id
 4fb4d7f45d1cf-6aff294e101mr4619974a12.27.1791438189378; Wed, 07 Oct 2026
 22:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007155748.291814-1-samuel.holland@sifive.com>
In-Reply-To: <20261007155748.291814-1-samuel.holland@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 8 Oct 2026 13:42:58 +0800
X-Gm-Features: AclHuK8I8WkGAy6FEtsbDPDqp3rqkxyTvnVbvD8DrWWrlvwiZCF72K8omXYE7co
Message-ID: <CANXhq0qVzjx+WOZNZYTt-X=aEut4b1c6Yp9S0rQXN8+z1hrZVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: cfi: Bounds check restore token before swap
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Paul Walmsley <pjw@kernel.org>, Deepak Gupta <debug@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 11:57=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Currently the user-provided shadow stack restore token is not checked
> before being used as the address in ssamoswap.d. While an invalid
> restore token will be caught and raise SIGSEGV, this happens after
> writing 4 bytes of zeroes anywhere in the address space. Check that the
> restore token is at least a valid user address before the swap to ensure
> we do not scribble over kernel memory.
>
> Fixes: 66c9c713de59 ("riscv/signal: save and restore the shadow stack on =
a signal")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/kernel/usercfi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index dec0ba5eff5ea..23c4d6d9d8cbc 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -206,10 +206,13 @@ int save_user_shstk(struct task_struct *tsk, unsign=
ed long *saved_shstk_ptr)
>   */
>  int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
>  {
> +       unsigned long __user *token_ptr =3D (unsigned long __user *)shstk=
_ptr;
>         unsigned long token =3D 0;
>
> -       token =3D amo_user_shstk((unsigned long __user *)shstk_ptr, 0);
> +       if (!access_ok(token_ptr, sizeof(token)))
> +               return -EFAULT;
>
> +       token =3D amo_user_shstk(token_ptr, 0);
>         if (token =3D=3D -1)
>                 return -EFAULT;
>

LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>

> --
> 2.52.0
>
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> branch: up/cfi-fixes
