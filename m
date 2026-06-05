Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CC3E5EDB
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672618; cv=pass; b=LfN76SYAo/RsVwtnp35W+f7hixlUtw60VOug8czVBjoEhCE8Kp6v1/vuy5M05rFlPtW08sm435bZW4m7gCOwAECV5Mzp8BTdZYDG4qxI4HKrfyXMDwRbdnqapEaENeFbb656gFf2+vxZc1khTi+ZFhcVIFT8mSPVCGX1LPBDyuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672618; c=relaxed/simple;
	bh=M0Ti+6+2fGXFk+cKiUj9GFmw1ywuOZbs7swH9SSB+IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPuYem638cmGwiTdZLH9KwlynqNEYolm2lXvmhD4qGUD8XoPJc8xdWVzmZ9iXb6pPtXcJQxmH9iPbyHEJiUjwg30SGYnIpZ/3gPIPaomOpcBYKVpuZJ0vpoxgZyi9ml07Sqwe8pDPFN01qzDbWxBlh7RoKatSlKseEQ1HDjFUKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhNFfJLm; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhNFfJLm"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so12700a12.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 08:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780672615; cv=none;
        d=google.com; s=arc-20240605;
        b=RDb+ufSOTSK/O5DoKY2DHF5z36l+60DGHTZlhHENdrkKuQ7i1eNbXNyGhcPHBbmf2T
         3CYRliPHvrsYL0sJCLFYszKlYDz0J+uYEkpNBn+fGr7812um7Y2I1XxD4uSq51WZkJ9i
         IgGB5/2wi8CTgY+fNrNHoiAWL0i4WlhSv/vz0k/TzZPYGzcNGYgb8KWeCwB9wrr/o587
         A0sy86h4Z791joXx/aAq5AZHH6lVC+K+OtjOhRtOrEDntXzqI/3V8F3Dibc1QahUBkRv
         QVdbHMzmJWo6Ane2TuWtywRsf5zBan/3t9H++eV48F2MxWQonojFZUt2CEM1pFY+c838
         DlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4P/dDdhLfcmxlWjGtS/G4l/JMEkA2smtkmUSE6BkJ0=;
        fh=op1E105GsXa31I6XQbeg3hduXr3jSy/WH4v8n2b+WSU=;
        b=IBk7aVmLEKq5pxPgmaGJByzdUUWfse/Ym/Wj1OUVh9Lt3iV88Sp+KrvUzQct3oS88u
         63PtwXoDUSlOy2J6oS5xoRNjn16M1QkotbparScsVUFka65POYCb0EbSPRd1am02cMe/
         Q6coZLPWNz3Rv+kaZphZ7flRe0xOYrhRCdOO0p6lv1gXQnOhwqJl7t2h+B7Vj0mVXC+a
         Ge4ecPhZO6qoWZ6BSImrJDD8ObkTDn3+dqgqDqlOL8kC7R2MzWsr0GDFKQKLtawkocPQ
         1xFJoqI0N9FhEycJhCOyswJNy7Rgb/h7RlB3Bxs4MccUHxgTda4ylf05u2A/qVTeJMwS
         JwGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780672615; x=1781277415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4P/dDdhLfcmxlWjGtS/G4l/JMEkA2smtkmUSE6BkJ0=;
        b=hhNFfJLmnqt/iQr+F/XeLC/WBq/wu3saXAFeKu89CH5f48b9PLtcaUalOxoYFeQkx3
         2vsyIL0WSOeuO69Gly4I2iaHplP6bOhhmO9BJ43AtgiCVJNkQkX+KWI6OcYFgYqosCH+
         z+7M1Mlqm2kjpXdVYDAuh8zjmvI3qaTfY9CHJMqnVZCMxXdp8TNO8ByzrPRM6DDSW3wX
         JRSSOQLyNVnwuEfAwofqv7aNleE4FHYqtuXslAcu6QCO3efFt8yIU/AmyTu22F3X71tv
         wN5llQcC1gKNmDt1iDaSkghRFYv9EYFjFooyLx2Udbt73SkxeR6LP72OlGPnFBX5ujQE
         6uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672615; x=1781277415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4P/dDdhLfcmxlWjGtS/G4l/JMEkA2smtkmUSE6BkJ0=;
        b=b2f6AgAVymlAGOfb+jASQ4yXm0PeYzOqKRdffuN8ddUKKwyymfh15HY37FcMWdarrK
         udr534Tmcw1cdqxXT3AzleWNo5omtLvosfZJTiMzDylp9j4OzyY8dF4oVPJFMeRAbkuE
         r6gbsnvaDF7bJoebiSsky/TrylAu4eNQMoGGURy1JIfSncPLv9D4xNKjE6d0lvPrKbeA
         w6tVClo5JGHxzrY/+ybWfnp5VXKTVQnkd3jOq9yVMY0WbRhzl27/os0tcMskrzDSSCcW
         ywNDBuIAkVEGCB3UeEWku5I8b9cnZmOQxnu7zCFScV9HEMuqh0+meYRmG3TnODfby5Gb
         kosA==
X-Forwarded-Encrypted: i=1; AFNElJ+vgEpmmO8yFAic3cEqXj8iy5WifBhfvgXYKmJZDy+o4as0y2aWmHE+QKKHkoOsSAALfG6P5DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyehoxt8/GtjuKlXnv+shnW4Hn+ilzN2NOI+aj+jBJ4tJb04NBZ
	i7QOvA9VKii14ckPd6oPjtV3kK9ZXNtbyi2cf/eyDxXZm43aCVow6g6vEc0ClFY9eA1psNb6Oc3
	esaNoDAU0C/32Q2YS8Zkx0NsUODrfgmHLvh5UJzG4
X-Gm-Gg: Acq92OHtEtxmYabOHocrN2A0D9HV8+y2rrJcCrVpQZB8kISv6qz9ZXPjIyGD5pOpEF+
	Lq3cfnxlxohIlKaqkgPZ1Q2se8vqUg53QmLG9NdQSl3V3gqgZ/LPfWbLQVfgjhyEHgPvZ9XB6SF
	D+0eG8pTk8/mRN6BILexV8DN8nHwCgkJDgOTSQ+9HPRMdISUQE5jLvGJFRiCO5O9n83nTPYCKfh
	udvZNgNNdsIkq67nsYMs0r3KUl6p1locCSenXw+ctGnnGR+x/DbVP5j4g7+aTs114w36PC7Q2Kr
	r3w5hCLfTIinC3k=
X-Received: by 2002:aa7:c413:0:b0:68f:d41d:ca5f with SMTP id
 4fb4d7f45d1cf-68fe927fc75mr43411a12.13.1780672614649; Fri, 05 Jun 2026
 08:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org>
In-Reply-To: <20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 5 Jun 2026 08:16:17 -0700
X-Gm-Features: AVVi8CeQw3smwcST71LMGAGTwkM2lHTSl-GXkozY0EakrBxGEKMpmYz8YpNBi-g
Message-ID: <CABCJKud4OxJJVt5eTaNqpGqLrKbF2teAd3FERoeg+sG-G2Yiag@mail.gmail.com>
Subject: Re: [PATCH] cfi: Include uaccess.h for get_kernel_nofault()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>, 
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>, Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 5:33=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> After commit 0652a3daa787 ("tracing: Fix CFI violation in probestub
> being called by tprobes"), there are many build errors when building
> ARCH=3Darm multi_v7_defconfig + CONFIG_CFI=3Dy like:
>
>   In file included from drivers/base/devres.c:17:
>   In file included from drivers/base/trace.h:16:
>   In file included from include/linux/tracepoint.h:23:
>   include/linux/cfi.h:44:6: error: call to undeclared function 'get_kerne=
l_nofault'; ISO C99 and later do not support implicit function declarations=
 [-Wimplicit-function-declaration]
>      44 |         if (get_kernel_nofault(hash, func - cfi_get_offset()))
>         |             ^
>   1 error generated.
>
> get_kernel_nofault() is called in the generic version of
> cfi_get_func_hash() but nothing ensures uaccess.h is always included for
> a proper expansion and prototype. Include uaccess.h in cfi.h to clear up
> the errors.
>
> Cc: stable@vger.kernel.org
> Fixes: 0652a3daa787 ("tracing: Fix CFI violation in probestub being calle=
d by tprobes")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
