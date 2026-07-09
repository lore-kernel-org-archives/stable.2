Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9DB19AD5C
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573273; cv=pass; b=aX/48ld1imTfjhIZGvxkWuxSh3457giUFpvACsqumG24iW7f04NxAJ0ObfK/l6yJbmmxn614C1bCFI7V+8NKtTgxcQSMcfQYfJSGGVs8Pw4cD32R3jgMyfrRGbgGuHgC/5gBI0otXxipqsD35NkDu4IGBpyo7FO9lBb8TuZY4HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573273; c=relaxed/simple;
	bh=PE2w4MndJBd7nMcxqSOA8zuq4uvBlrhJX9KZ4PJ6jyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKTd8PTDYq+Pdax27WavO3vkbbrDMBavtQouwEXX2sZ4IJkBH3Fzp3lF8BrtDM2CsIyFnQFJFmnCs8cFhcJWUWWBbZaCGF5yhYNSlf/YnKYakNqHolp4ooNhpmvJ9KZDPg0FwiY89QV3DJjr+WrmMI+Ty93YAhBhmQeqBMHw8Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlnkIQXv; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlnkIQXv"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-448b89f700fso715006fac.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 22:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783573271; cv=none;
        d=google.com; s=arc-20260327;
        b=f4PFt3mFErGM7092ZWZW3BptE4PhCDoF9ra23S3/BJsBowk6PklMS1PoWsWJLlDIsQ
         FnA/emzCfzDTIxkuwkr9vbCaeeAlkcPTu+RnTSh6F7i7yGOmTK3IUKk8R3Y4iZcWbm/R
         29l+WzGpAkKHghyBqWIhZM2mfYpyvi3BR4QNwvznKrdgf3h3W3lCWqkaClkb53B5CGJf
         n4F009O1MT9TKVa2LScDrYEloLlx5qNBxlynehvtOHX2jp/UhV5Mvs6bUZdQrgnEnBr6
         XlpgP6uFKufdMSM8RggEkSmkzXKN3SFiEwNvrKSZPJVVI89ukkOQXSwLcnlUsde81Tjz
         uSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I+YN7IrDVlSPz87t4MbjMgkDzmRT5Xlf/Rvnd4pOdf0=;
        fh=dXxqX59BUfmpx8yn2NPsIwXQdlMreKUpqDvAen7GCtk=;
        b=BBADKT/mirwhtlBkQazboSpG+NaT2hrBx8QfnQks2nBKCP9wMMyC/Qma05KG9cSgjs
         9oqhlvCPMUdre1FHLeUMj3jsIT9CBZMfiImXafCWWbAhTR4EOnFCPFH/sR8kW7PD4XzB
         CGGYSyxisuY2FrDx/jUonevcRAj3/jW1rwUOXEjxWGc5VxZup5227YwBuAuXe5C2fM8Y
         3kYxl+VmYxljb5RzB1T4Urlr6LyacyipWoOHnhkyu9LW7miNp5srMkTR4YGFN7eB8AWj
         /i7rCxj9t0MQNBwMVcuC6tkq+xMe+LiKM85iqJUsJQ5lubF8G+kN/oG+bRV9M6m4+wFq
         P00g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783573271; x=1784178071; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I+YN7IrDVlSPz87t4MbjMgkDzmRT5Xlf/Rvnd4pOdf0=;
        b=FlnkIQXv2zp8O9EKxby1oS64M5Caio34pn/cHYf2a40i8cVxdEjwO+Cxvpx67HrU4E
         63bAdIkGXuhE5wWSSYMMUZqGDXpFJuNXX96zm4GIReQzszzgiMT5u69KZS76ARAGye9U
         8b3PwjXzC49JyOPhUGcuOEQFaTRryof9hx2Fv1/gbyY01ykkqLGnTPCbTGXF38nQEWIq
         O+YDaZwbrBEb6X9LGAp3YVUG1d0/E7+ViDzoLaKZ4ZYkJ5npkxjhCJ5UwfQRHvOhjFZO
         V/xDXYdWRknT7vQCJsrp2EDBDKYnmmsyKFuAKnoQfJsLyBudyMq3vl/8LjpqPIsmpFlm
         ydSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783573271; x=1784178071;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I+YN7IrDVlSPz87t4MbjMgkDzmRT5Xlf/Rvnd4pOdf0=;
        b=CsvwaLESewargrR/36/ngLZokvFWaz+y6gKx9icFFDo9fQFMg2qik+frSxNEyHPqE6
         iK8oj4uVCYvKll773VaiETKN4koDE7z5qGHIhnRLlRqZAR+qgbzymLZkr7appgP+mkdS
         tXayBPyLFXG+Flu/cyLJBC7lyW0pB1hlBGp4a9+lypLgtZ+1lx70+1QqMYrhutUtc+15
         fSD4hsa6mzptCzMcw9zHtGhgbWDo/yd+2MMtkLj8P43O8EluPc8npnK78KOKRGz2qFSG
         /1MScHpqSV/nGVbCQISHuTNXKeDtcPBnhs9UUTvG2akxJskfM3Ycw2K2jxb+6d1KR56d
         kSiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZL2+1pLdinhTUYTY6bmHIjJKMTC+3DSNxlxH50IHsWTPkynCkH53owIrJQcIQjpYmBWdufTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrEqXPp0+cmdghzbZwUX6ZY+9+fpqW49N9UZf3hdl4pZ/1E0/
	v6cI7xs/MBCTgZUMYaYI1SYidHl7HrCacu1AHgM+HFYCClPvxEyis2bh1XxedTU16IvwQM5RckL
	HPOhdY58fbi3VgA6MjHnl5crANr2bk5zmsBVr
X-Gm-Gg: AfdE7ck3/LH2dntlWE3r8b8v1Wo7nEf+DVanJdzCrY6ic9aiV5y0AJQORD+7vnyzfUJ
	JCjWHpvD44B/Ak0cWaalVmpI3KZNKcfAvqxARsoKeEM3yojJE9mtlTwPp4QpqlkLfU392kMrbUF
	i+WtuoCK8H0eoKkk8dQxINXt/mauvnC5xSmrKljGqnLQw61A/tf4t5k75pnZsGZJCqurWKrIzsW
	7KcOwLfqmJLg3bolayJUwKPF1UpU3zbJPMQfq21B/JwpGiNFJTGwuJhwlEveAYwL3nNRKK89Qr0
	e/FtnPT+A+tgfeIQqmUjqv0vuQA=
X-Received: by 2002:a05:6870:224e:b0:447:7ad3:329b with SMTP id
 586e51a60fabf-451637acc50mr3647116fac.6.1783573270844; Wed, 08 Jul 2026
 22:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702103453.348056-1-devnexen@gmail.com> <akd8E5jr722oTm49@zed>
 <20260703221651.41669d55@pumpkin> <aks7usxfDajS-W_5@zed> <20260706104652.GB66892@killaraus.ideasonboard.com>
 <20260706133956.39a11738@pumpkin> <aku6R_EI0kLUqD8e@zed>
In-Reply-To: <aku6R_EI0kLUqD8e@zed>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 9 Jul 2026 06:00:58 +0100
X-Gm-Features: AVVi8Ceqropzkzn8RnLbgejAAhagC1QQAIVbnG6fcB1AFDIdAI6RGSiuDbLVYQM
Message-ID: <CA+XhMqz2oTTy2kY_4uqvJRnoXb0am5h6hXnLFM4EPQ7Yb6N-pw@mail.gmail.com>
Subject: Re: [PATCH] media: mali-c55: Fix unaligned access of AEC histogram
 zone weights
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dan.scally@ideasonboard.com, 
	mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Does it ?
[...]
> seems to clarify this is a non-issue ?

I think you're right that there's no runtime fault: arm64 has
HAVE_EFFICIENT_UNALIGNED_ACCESS and runs with SCTLR.A off, so the
unaligned load doesn't trap. It's really just a C-level thing - the
(u32 *) cast is UB and -fsanitize=alignment would moan - rather than a
real bug, which is why v2 already dropped Fixes:/stable.

> I still see zone_weights[] at offset 10 which is not 4 bytes aligned.
> What have I missed ?

I don't think you missed anything - the union isn't trying to move the
array, offset 10 has to stay. The idea is just the __packed member: it
makes zone_weights_32[i] an alignment-1 read, so the compiler does the
right thing (a plain LDR on arm64) with no cast, no get_unaligned() and
no memcpy(). Same 240-byte layout, and it also avoids David's KASAN
concern about memcpy().

So if you'd like it cleaned up, in mali-c55-config.h:

      union {
              __u32 zone_weights_32[56] __attribute__((__packed__));
              __u8  zone_weights[MALI_C55_MAX_ZONES];
      };

and index zone_weights_32[i] in the driver. And if you'd rather not
carry the uapi churn for something that isn't a fault, I'm equally happy
to just drop it - whichever you prefer.

Cheers
