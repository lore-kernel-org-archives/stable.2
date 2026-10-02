Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6846AA95
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983811; cv=pass; b=Ls6hrLfaHAwkO7ocQdj0OM7S/pIKGvAc5yqCNXf5DUfTeCRAhyPuT05ovsziX0s7ZoaosdUduKH3EFSlPBYq6RRC1xEFbSd5bnN36MZJMyA0DJEL6V+zX383pUg/u1VXhcX4eGUWATat2ndFjX+Q4WNWMYZiiv3whfexwiU2ctA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983811; c=relaxed/simple;
	bh=snqRonrcNq5P7WTqs9GlYErkgGy6D6z56m9XMyLBhs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovWR1xkHg5U2nL6ULPQbHZkzRCWRqCouxEC+tKY/vhMm2XEZGVl+Gv90/gDUTFUdRhGerbtK/Jw6FT2jHHwd1n52OcD7BcvWp7YqFEk0eUO+uiixCWU5G2hC0/WGZM6uuWlGou1VfKT4w9Yc3QXBQ386985C2lKfBSGntcsarO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThgtdGLb; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThgtdGLb"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93ca4dd64a6so6117985a.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 16:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790983809; cv=none;
        d=google.com; s=arc-20260327;
        b=DBZYVO11c5OP2OWbBBeV8utK9cFx8mICLIm7OYCsX4ohNJcNg7IUUkeVh7Nd83ziWl
         kB2qk0P8U48HrcQlfj4q+WwjK688OcI5Sm2ozFppAy+JMl44Bp0/ab/RDQvaCloGU930
         h4qDb2EgMHrR07aBeF1q41yu5iV21F/HkmrpgpC3n6tGXYTZZZjME+Cp8P/EyO58/Kh5
         G234ydozeqx+l8weP+GRKa0/sP6oQkTzDfnikcowotww0YyQw2jlHPuBmRISn73YKEXy
         0ac4ZbRk0bnQm6j2NxMzv2WUiXRRMKfC/BNP8gC/G0oU8IH1ZCkFYzEc5KS9kR178B8P
         K8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Bovas2WAEGD9Xsa1cngl8uKLJL1gfGRL2y54+LLnPkg=;
        fh=RXKl8FBXkhr4a4dxFhsOp7H5kQdbETfL9gE/UcuX8cQ=;
        b=UG4ZKNw5I3ZL2CTPtA1F8qkir74Se/LUDYfvwRm7SiyTHAQ2AsrUEpkosS7zu/M8g1
         S+VmBwFZHkM/jTBIZ6MlfL2uba4tojPu7n2mylsQJ8my7FYtfsoe/H/Zt9vowt0RRsbD
         gJUm9AdNvtjk4OdBB755ulSjft7A/LZtAWOJRj4ISJkf4Ui8y3fkEM4cYrmTywjJ4N2o
         Rcu0Zc31zCPyXTYFriX5f472QvzD2ud/kEyGsEWu7HcBCAs8tIYu29KX6ihv0GVZx/Xt
         m54LSHWLcOcw6MV+9zElKs1ULyFgCMxieig6sqFLb7OZN8SsZsNgsYtYluPunq2an+Op
         CyEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790983809; x=1791588609; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bovas2WAEGD9Xsa1cngl8uKLJL1gfGRL2y54+LLnPkg=;
        b=ThgtdGLbjSS/19VNGE9inkEYExs1vtu60gAuUZ0Xsjm1xkJIRq8s9BvM1r8//t1tmh
         8K+kFvIa8MlqDbuWOIZnMBMpClflIc9mm3aGZRm2fMmdE9A/xs0MledfePOYDUzGqNEK
         pTOfIcXOGgj4iBxm14vCough+b5LZr9iSuAqViBsNxOIU32NlPhX4viTeJesOF7XuxrB
         eSUh6YTIyqR8jRXBCXURnbm33kNKwDiDxOnIqPKOq65gE7I7LMjyTaAJ8wDWxEle3pWn
         H9dIjM4hkR9mn2bI1dO4/P+HNeFESb/Yq04Pnm6a0EBhJdcfsV3R9xJcVjTmZAj8WZii
         jq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790983809; x=1791588609;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bovas2WAEGD9Xsa1cngl8uKLJL1gfGRL2y54+LLnPkg=;
        b=C4mSi74Kw9xVT8Dkxdh/WYtLXhX92wGfCNiR4S3sBjqDeYKqs0e9ufVf3N+sqIsXgY
         51i85EsXV+y0nRWArEUvNgP4QSeXCTqYBIFYO5VFZ44xZvvN5eDjmWlwefrUmnvIYfn7
         VVpIM5+lG/ZRnEeW4CcTt6oskKgoCX+ce0fNvQkAks9QuU1svYLuh8MBR7tq1G6XINE3
         SUF4pZnChZgy3k/IWEi3YVTmr8kYMzAJSJvmvCb2oBYQGNs0rW2syC5uSRyNavoNA5DC
         6GKw4z6WBM1EllWzjhYGSMPrC4StzQQ4xznfThKC183uKK0XPkaCU4e8aQ50GQBLgHMN
         MhqQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+fm02Ggbj8simBBAuKP67QtBXSwEaHkUoX8qEbMu1nU6nBQEJbEmuAD6823ovk3hNT5FiyXc=@vger.kernel.org
X-Gm-Message-State: AFuF++muLKYGR+x476sYo2hGH5FgXMYBl0qVx0cvDu0FaiZs5xNbokbO
	EfGL84FGJwQWhSPFfkM1977GH/fdsSqv0zK2Nvs2lKCiyZAmaxAYvFQsrGJdyccREq+o0kU94Ru
	cw1crgbLORB0Y9uWU4xv2vfP7B+/c2lg=
X-Gm-Gg: AYBFou2aeKcmqzju7UKixhFGmujrogyqvxKZUSgBfdOvXFr2K+/gz68+DXpr7hHO9Md
	IS+iRIw2bm8CaObrZGut1W6qxp/O79W6D5fyrSCGH9H51XS2YYo1dc3Lni3GAV3L+WnpG4CSddP
	AlRjsfrTqzNbwMaFD9K/nRJIxaIS2OGIiM4dcpM6AGr5XfXPJUws0jUooz5Z5QwN8Cz8epdYZJU
	Pyou5pySzdn/6NJvjTe+OGOi3GgifxO9AorNmiRoCBbE2WJw5vkoEumPoznyhmC5mwHZYzg0KLy
	r6GUxZFvfhQ0d/xRWoUUwfFIc37w7GXi7FlKELu56L3YJvTXhKCZIVROjgz6+dkV5aw5mnyFKZn
	YsfN/fq5IECC3iQ58ZgP7pkczC8Y2eGv6gEGvIxEndQ==
X-Received: by 2002:a05:620a:172b:b0:93a:2e8:5afa with SMTP id
 af79cd13be357-93e50feb9ccmr188518785a.30.1790983808980; Fri, 02 Oct 2026
 16:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002212833.9674-1-fzeruhn@icloud.com>
In-Reply-To: <20261002212833.9674-1-fzeruhn@icloud.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 3 Oct 2026 09:29:56 +1000
X-Gm-Features: AclHuK9rjOUUMpjG387IHnEilLqBy4AfDp78Y1XLf07vnG-EkqsHFL56vRwAE6c
Message-ID: <CAPM=9tw91hPiAfwRP=y6Dr=CFgYboO+Z94_1dVwt41exGokj5w@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: keep MOT set between messages when no_zero_sized
 is set
To: Finn Zeruhn <fzeruhn@icloud.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Oct 2026 at 07:28, Finn Zeruhn <fzeruhn@icloud.com> wrote:
>
> When aux->no_zero_sized is set, drm_dp_i2c_xfer() cannot use a bare
> address packet to close the transaction, so it clears MOT on the last
> data packet instead. The check only looks at the position within the
> current i2c_msg, so MOT is cleared at the end of every message and each
> one is terminated by an I2C stop.
>
> This breaks E-DDC reads of EDID blocks 2 and up. Those are read as three
> messages: a write of the segment pointer to 0x30, a write of the offset
> to 0x50, and the read. The stop after the first message resets the
> segment pointer, so the read returns segment 0 again.
>
> On a Pimax Dream Air (three EDID blocks, native timings in a DisplayID
> extension in block 2) connected to an RTX 5070 Ti with nouveau, block 2
> reads back as a copy of block 0. The checksum is valid, so nothing is
> reported, and the connector only offers fallback modes.
>
> Clear MOT only on the last packet of the last message, as the commit
> that added the option describes. With this, block 2 reads correctly and
> the native 7104x3840 modes are listed for the Dream Air.
>
> The same problem was pointed out by the Sashiko review of the patch that
> sets no_zero_sized for all DisplayPort connectors in nouveau.

nice catch,

Reviwed-by Dave Airlie <airlied@redhat.com>
>
> Fixes: f0ddbb1eed18 ("drm/dp: add option to disable zero sized address only transactions.")
> Link: https://lore.kernel.org/all/20260827015758.0B4FB1F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Finn Zeruhn <fzeruhn@icloud.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 488fd123a01a..7676285c19f8 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -2192,7 +2192,8 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
>                         msg.buffer = msgs[i].buf + j;
>                         msg.size = min(transfer_size, msgs[i].len - j);
>
> -                       if (j + msg.size == msgs[i].len && aux->no_zero_sized)
> +                       if (aux->no_zero_sized && i == num - 1 &&
> +                           j + msg.size == msgs[i].len)
>                                 msg.request &= ~DP_AUX_I2C_MOT;
>                         err = drm_dp_i2c_drain_msg(aux, &msg);
>
>
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
> --
> 2.56.0
>
