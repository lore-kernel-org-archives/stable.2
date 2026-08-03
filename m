Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CEB1F2380
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736771; cv=pass; b=YOLNHoOsV5DbcuFvseqpFNbNj/ncrx1IK0oFiLa2K6CXyMCo50ReWzipsRYZ8EueWtW1TCt3Y3qCCtakHJ14OgXvC4Aip5wralNhBmHnMdBckEJp772y3BIjI8miYoyvUHFaULJeY59LtGlmtnPpeIDWTg0GSzK4wNGCfUoAXJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736771; c=relaxed/simple;
	bh=u6bP/qobKEFgmg4MAmuD9F/zCR1J43W5ZKFxpuI6hSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhyVt9CvnTHx1Q2LTssVmz7+jffAs0Uv6Ka2FEEbTOW9OJDH3vUaY6za2mXuPH/EQcLP3ZxrOvOdWtPYOJugY6qclHz5X1iAUralCpfY1Syfpn1enCNVF1xhHeWXbtLIR5Xz1kTOYGbN1Cj54vRd+78P+a31PnN9j8lsTz0Ye4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPLvUGOp; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPLvUGOp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so14980855e9.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 22:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785736768; cv=none;
        d=google.com; s=arc-20260327;
        b=Tjj7pGEEQwLh9C6Uaw9UkqhhAWzHnobaWLGdeU79KCgNMg87AuKObzM4FUvr4IBd/3
         SntMpStyetSF2O0vBBb8uhFtjSMAiBgDZqGUT7TbutbubiigGerWJjsvwSpGVKmrkP05
         ovEjUTHYfJq37u2Xq33pvJrDc6WVyL9xofSdsRmtqEZgcBBiMBDR1FXbVh+uTIogvGGB
         sXuWrnmIUfgRcytEJT5WKxTu8udaj6oX7KvObP5XV1MyYsGkVDb6asrW9O/ZMgdClDfF
         gXsw5k7WljjnHa3yiqRnZcm4vaYW1+CZ+WSAPXvVA2I6Ei7aGmYxjDDEq04ZE3MV0hlo
         uz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u6bP/qobKEFgmg4MAmuD9F/zCR1J43W5ZKFxpuI6hSQ=;
        fh=eyFnPeL1yrhdabePsoO5KFUGQnMqUQaQ2yfwM1E6rHw=;
        b=MBUS1lG13oH51Lft/D3dmSlIO5/cLhIEkFbquYgqem8MQuMjbIA9cSsZdjIVK0Xd3u
         GYgUiyQ2n9/LsVbrBuq5RfCnsOnbqUZE9MEBDM2WDtsWZAJzDPeT7+tKfFBgp5WNz7k+
         97ECWSWb6kXRLsCUbgyKHjQhNkP6lC0hKY42uFkxzHEWvyn+EJW2/XUGtCv/VAQrUiOy
         rBw4PPoXeQA9cV1ELciJ8o+1Xpv2//DpXnwyDxybcIVvNHHZlZXGgaPR387DJUx/ATsa
         wSov4objxJLWcjzHA5If/aaKAhBlNMRU5Qb5/i56yaw0Vr9wUexvwbpWKOO2tp1p2mEW
         DavA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785736768; x=1786341568; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6bP/qobKEFgmg4MAmuD9F/zCR1J43W5ZKFxpuI6hSQ=;
        b=jPLvUGOp8CRUjYzsDsaoLxW6oFeGJ5HIlEQ1eikWUbfjop7unuFSzLzjZbDGu59FmE
         4meYQ0oNfxiyKaI4zRaycb/dWhxL2Y1gPePnaj1rWNFsx2HkcP/0UGzmnB+6BmpAqQrB
         w+P0Zi/8VdjPPzzdi0hJECkVK8NI9Y+l/huX8Adn6GeSCMxIgg9djc1ewKE1ww9uj8lQ
         F33XeH9dABYDdby2+LAV1ln4kcbR3B5vwwegWeCVq9hIPg7cHwcsAXT3eE6r2PXit2q+
         Q+RLaRnooB7LnxkRQhtSKfaFB8OWt5ywUiyyWKB+Ej7FAuC2Wfm6bMDgIQHnbdQzFVWz
         I+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785736768; x=1786341568;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u6bP/qobKEFgmg4MAmuD9F/zCR1J43W5ZKFxpuI6hSQ=;
        b=Adkv9qMysp8Q6qGtvyDM72pRPWZXT0vivxfth84ABzd2A+7sbyyzNjPZx/1BbnWRWG
         NekQ4tmDhjYQH8EpRPWRpOTGpJRzna/+oY7xwj76MAIIi64pEzrsaucEsWSx//5q5kkT
         sS86sdVlnP7VdUQClOs0XcqB/bmgT8fbpa5lQnrcY7TxbiS4CorqUtPs4ptrISNeY4mT
         lzl243EdL7ZpohAq5Jjgi9jwLrGbdw/6t/TlyE7U7KVZinaVhfkXSbh9yq95K+6iaA4u
         cCbrA/V6Fkx/hy3hd973JLnfZlt5snc8Je66nUcxPafv4mbCUoFNExTWe3CEULfUN8mm
         ea0g==
X-Forwarded-Encrypted: i=1; AHgh+RqawF2E0krenWaqgoIQvMIieSvYjizW54IoMu6McmocG1rHkqAzppPX9UhtLQfb6T0ei3z3QmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRv3mvkIqmz8/hB6iQaw6lmaTUtZaiJH7dDrNQc1h3PeBUmZh2
	1Lk4vG5to0ugBqUe5W7JY5r8r0tmjJMdng/0cHneVnTC4JHi4ZEQ9ykSjNQMfbP2jwQRq3QhfDU
	NE95LaDr7BhGpd4XKxfYzzYO++pet0Q8=
X-Gm-Gg: AR+sD12ZdzwrVaW9CUcvt5sutX4o5iUmCMEFRi1WQgG9kHmhGDdhGX+Uu+z7BHBTzzO
	byen5Nakmemz7Cr6MaR+N3rSyJ0Pp3L6F/wGPu9vHz3eWMApDzvNGzpJuI8p1k+mmIE6H5UTDsc
	hl9GufYGWN2veNIxFFj1CGfCani0/3cpK7qsftI3gzwxTEejlp/aG+spnm4G6dNip2B5qYTiy7o
	dwG6bfiCoohhAl36NgBdN/VVG9RIBFaKfYMbEhOOPin9PD/OBgxPXIeR2aCj9NThpyrG5kA0AQh
	/A8gN+Oqa4pXXb5lrNM3rZSIfCneTW8V90pPySjtntt4vvJW9+hyyYaQgpm0IorEYMy2cueex8j
	4gat0vNh4/7WVD257lR2B9wvPyWdj+pVnhKShgKr+Oo6AFoaSnrPPkAoGOH4MtiRDPqL12gVRdS
	N5mlp2TbAHN1ICALRJhGNYRXt/Wx/nztxvDrq2Px5IHM4fqrTgEJsu7U9HVZtgCH33ooG7QyWKT
	/hbCbP/Gzs9kfs52Hag94JNmr8nMv2oE6OXHL8=
X-Received: by 2002:a05:600c:33a5:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-4980c66d95bmr127096415e9.7.1785736767790; Sun, 02 Aug 2026
 22:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730135811.1498-1-joshua.crofts1@gmail.com>
In-Reply-To: <20260730135811.1498-1-joshua.crofts1@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 3 Aug 2026 07:59:17 +0200
X-Gm-Features: AUfX_mwngWZS0ENLACe0n5Md1emZnsHLeqqNDxr9A158H0w0RAP4p88ETr9aR-A
Message-ID: <CALoEA-yuzdD9=gBy0s0VFc2yD5Kwga57LjECUWTTXdF2SHed8g@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: midi2: remove default configfs groups on teardown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jul 2026 at 15:58, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> f_midi2_alloc_inst() creates default configfs child groups for the
> default endpoint and default block using configfs_add_default_group(),
> setting their internal refcount to 1.
>
> However, during function teardown in f_midi2_free_inst() or EP cleanup
> in f_midi2_ep_opts_release(), configfs_remove_default_groups() is
> never called, therefore never dropping the refcount and leaking struct
> f_midi2_ep_opts and f_midi2_block_opts.
>
> Add the missing configfs_remove_default_groups() in the afformentioned
> functions to free the structs properly.
>
> Fixes: 8b645922b223 ("usb: gadget: Add support for USB MIDI 2.0 function driver")
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eaa106d192c9daf37f95
> Tested-by: syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> Aside from testing the fix locally with QEMU and the reproducer,
> syzbot also reports no issues after running `syz test`.
> ---

Hi Greg,

Gentle ping on this patch.

Kind regards,
Joshua Crofts
