Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793964844;
	b=uDrsRs6wDua8cuzidBCzlqet0FXB0bq6DalMTSmBBe0a4Moe4644Rle8j7Hf6WS7jIjD
	 FYpsUNA5BOnAxP4DWXDvc5K5KCW/3AmBS3ibvj1reDMge56XoMqAmHHjXnyHNMrRJMK1S
	 pEhwOpPSnZzGzChq/oweyMs3/zK/r2c1hf3Gfcaea4ZNnjCeC2AP5wOdFbv8Qx+DzQm18
	 kv9x11D2/5UV/YwhDroRrxh7OnkoQGM84w6DAoNkgP6PyFZHE+a40Kxuy6ooo8ONT9zTx
	 H+YYC0HFj0Lxb35oRuskwEkEJp7qQttuarM7PLWqdm52CNasDgygdP1gAdFHeIXDwHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=yEmGMlO442/bmobtd8MSxOkmFHXwe6d62JQ5dsryEAY=;
	b=SccpxgXt4IaNqy0El8hoXXTdMooPB+bSYJlEqbvVXtctDFK4Tq52U9EY+BBMA+Rs2V1d
	 4KHXrs1dsSyUBJGXvczJc7nvC8unyEL5D+bXU67GKuKwigvZMPcdfoOntNFiZj5FuvS8Y
	 RbX8fRuOD3Du3Kg7TlIG+MnmXvhGYgOlspkCyvQ5ntkFiMFUPLZ/AIm3GPz5dMtQc8zuN
	 h7515TkVBqcoU/Tys3NgnSYPeCMNospYYlw1MGKucHK5DMTg0mlb6abEolq8zH23Ja+T7
	 vbLFFgexU+b3Lmfy2DIOMo8hpG2ls34dTTFsbiYdPg2cpQFHJzsD17nSHWJEwU2vSMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=rRj1XUD+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B8606D80E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF8B8606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=rRj1XUD+
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5430f70c827so5626411cf.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 03:34:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793964841; cv=none;
        d=google.com; s=arc-20260327;
        b=p0Ohd1oWqg2bELk9qr9lBDjWfpqFJw07/2n7KGvGHerXWYD7Pn05TZ1RFrjCZtWF6u
         SH66vC0TG6+nI4ebmWvQNlO76k4pPKVSMfvyWW/Unps2VxWxZv+D4l2rxkDWUM7VA3dW
         B9lxa/icFtVYzs3a9DfoZE0JAO5LA/0d/X1ikhvcgr7Xw+cAU22sQIkfKZV1S8GlMiKf
         gBaCQqibJgcOCAN6W+vW9cH14sPQUSGSQtz49nLKuM1zq8wUpuLx3LPW5Yq31Fs2BuJG
         svSE3rxK+VSopRXBdxXbHxISbFf1HpyN0ISyubeMq6UCuT1bGZesC7lsqFOe0I/B86Ed
         fMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yEmGMlO442/bmobtd8MSxOkmFHXwe6d62JQ5dsryEAY=;
        fh=4rFs4KktxK6teM6qhDrQ3bTyo8+kOnD8UcMCytLSJmA=;
        b=SBSFtkf2Ff23b+owlQWA2/u7U0XEQJjdMRktB3sTLYhNAMEOyXU5FcvAYLtLkZExwA
         8+Ux5IBQjldvUUMw2ibyjqOUzc7GifeJvr/XyaPtVpUqEcH2zJmBDBzgETanVfOmLmEG
         NC+vDyzLt3V3t3NanU7p0zo35lTjgNdl1AzRp/wRnfpIcS0jq/IQn7gxBVrnBWI0M4Og
         1RMYA7PrDX7aO+locSteUKvDUpDLg0TBuXwPWjkUtDAEE8UWtEezihFq7T/waGttozhF
         UElXTsv9YrWIrrunofZTdqiT8euA7bPyas5Hkb7vmFTn8a3ju7DmkE4R+OnwkDfmOsom
         t6ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1793964841; x=1794569641; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yEmGMlO442/bmobtd8MSxOkmFHXwe6d62JQ5dsryEAY=;
        b=rRj1XUD+TjJFwXd0EOIFgrt1Smlyx1gkGXjjCZuYABKTgZWWpwFbzrSTOmGZg7AXMi
         FxkXf4cgQ0n21uN2KgG0pTm+KQ9IVC9vRPCdq6Cbf/qFM3fcZ/h1zTIitWlYHwDL2e8b
         MSmMkkoIGDciUxrlCmVt2MQYMAvjsEpceH59Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964841; x=1794569641;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yEmGMlO442/bmobtd8MSxOkmFHXwe6d62JQ5dsryEAY=;
        b=OvWMAiqrKix9qv7VySY+evVS7MC05PVInXH1tXcJ5th6fWNBKch2OSOCnXR/kHTvSj
         5JdVOdddqxmSZxCPrJkgqmHJBOWlb9UbpeSIWMIAlpgUboawqXUTGTF9pD/ftyWKvxvo
         xl1yd31Ao+ztnLXWXqGMe1NXPU26xopc5aShNAGmit4Fkf8wdeQkUxSZ3g7qpK3l2k+M
         3chvDEnwrRT9uJNoZkyzy4k/Zi1xPl0F9tNXn5rQWWKZxOMhcN9ujhUl2eOl5dY2R6L3
         TcH5kh/JZRWcqVXT3YRA+EtvsO/YsnY8J5ax0CxmKWDGyfjm0Dfang8PSg2l4Fwgcvn/
         T79A==
X-Forwarded-Encrypted: i=1; AKwUvBw31wOdCfnORUlm6N5fD8TGfmBGyrqglXeEr8z1ytdeuPQNOB70rEUdSxRx8IOUqNerDNGdeF4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QabJdopwqWuuCPHDemLT5V2wKrJnXR9tSTJrVnSPqq3ROv/Zz
	1J31X89AuqIgikriprr9fy/vF0C1z8Xq44ZAVDvu7qlkTTt5tyXx7mA5PFGYkS3bvhlYMYg7rJF
	jcm22xl3tfTuoRIcW9y57aoHB0Fij0T4nVJ2ArSlOvg==
X-Gm-Gg: AYBFou2H3Y0C3KOxedmiKAbPAH3yXAgIIArsdO1lt65W/sz9BAH/M1uPgeM+/VN7ZAZ
	wQ1gVhbM8EiycagxPPlmRyU6SD0grqx9hwB4mQU5XjJpNrwC70VvEyaZycY9Ik/99qAvUP6/0dm
	o72UAUSAXFRcMRia8Ne2EeNr9vPbRVVApxzX95Kyd+0yzkwIE4NstfunV2XmGIyaismmABaeA3v
	/nYlVAKDi4GnM5aGFC7WC00ZYxDKiNvYZ/urCp5ECvqMBubwjxAy0ytsVExAHNyvTlk0DbizRwV
	Ml4RiZBqWjh4OtJsZabxb0WWg9rr+E7afKhfiwwx9Jm9WBBvfE71/QoHBcRIFKHPx5Qa2SfSAc0
	0sKsWIOV8N63uUJgYExEXXkwY6OC90xCnhPged8cqpUsixPexKi9qHWE7mSr24NFhxUUom4Q=
X-Received: by 2002:ac8:5dcc:0:b0:536:71f5:5361 with SMTP id
 d75a77b69052e-54e0feea19amr34246971cf.11.1793964841597; Fri, 06 Nov 2026
 03:34:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019125329.17932-1-luis@igalia.com>
In-Reply-To: <20261019125329.17932-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 6 Nov 2026 12:33:50 +0100
X-Gm-Features: AclHuK-A7gQ6M-Qg-M-xE8M7BDOMgO2XZ1t3Ke_Qh_brPD2YLJrfyo7d4Y5WNzw
Message-ID: <CAJfpegsXsZS7CaA-=kAB4_oiyPWeZ8ULpG+kxBNHczM-XHbqng@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix 'inval_wq' parameter setting during module initialisation
To: Luis Henriques <luis@igalia.com>
Cc: mszeredi@redhat.com, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 14:52, Luis Henriques <luis@igalia.com> wrote:

> @@ -62,11 +61,14 @@ static int inval_wq_set(const char *val, const struct kernel_param *kp)
>
>         *((unsigned int *)kp->arg) = num;
>
> -       if (num && !old)
> -               schedule_delayed_work(&dentry_tree_work,
> -                                     secs_to_jiffies(num));
> -       else if (!num && old)
> -               cancel_delayed_work_sync(&dentry_tree_work);
> +       /* Only start/stop workqueue if we're past module initialisation */
> +       if (!module_is_coming(kp->mod)) {

See sashiko review:

- kp->mod might be NULL which will Oops module_is_coming()

- it's still racy against fuse_dentry_tree_init

My question is: does the inval_wq_set() even need to work before the
module is initialized?  Can't it just return an error and it wouldn't
need to deal with the race.

Thanks,
Miklos
