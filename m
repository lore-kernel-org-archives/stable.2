Received: from mail-dy2-f23.google.com (mail-dy2-f23.google.com [74.125.229.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E73EB10C
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851634; cv=pass; b=VVTi1t7OhhGxMOA/1cKQQcsu2k9YNTeJpffLHoSAX9k2YYpClYlVT0sMm6IM9qcHzemJsLONsiTCfA7YhIgd4CXVOco4CFclm5EgVKjKytXMr5J1L6WlRMH3N9auqLuj2GJMiP4K0BKUUq73qPb0ggknmAX6Mwf9JdjoPt2k/88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851634; c=relaxed/simple;
	bh=Sk7RTOQcN4cidxedcRYIVkGub/oGpNeLEskr9NMZ1eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPMLRhInMGdCq/S6W8WVySYvi8G6nsj81Nf5ykuSIbtXz8cjrbxL9/ztzU9t87PENYx+QzvO+kD/L3OqssraHTA5OeUpOjY5FXh+Ha1gJB2Q+dLdmN+sBUtGJDb9sEFVD+6NxRx8j9eDDvAYjQV2xKFnR5mWzuZADoQZhtTtZUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVLuSdq/; arc=pass smtp.client-ip=74.125.229.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVLuSdq/"
Received: by mail-dy2-f23.google.com with SMTP id 5a478bee46e88-32be7127c64so737547eec.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 03:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790851632; cv=none;
        d=google.com; s=arc-20260327;
        b=jwOVdyrZz/cbqcJcGHR98kyKSTJW94BIoLxeBsrcB6UHOUA+hy2nG5oP3z4F19vSy6
         ijwO9hBonY/IbnjvRst+O13RwpsX02/tr3ubtbZ2VJ8yUiktLfw2joZ0l2QaNUedm5Q2
         5wG7uNuZx4eKb6YNN15EOAfCmWMuQ/fDWTcgDv+bzhP39yvaROCEAXTNpL1rtGLN6zct
         M+v0IRJ6dvOIEdHfdhQQZL/yImzNeUAM5Ws3GLjVAaY1A2fRN3EggFot3FpuZzrKEq+Q
         2e+HwGjBferfMDMOshsef7TV5QCOAwOtC3Vea/MXKbnJa7RbQe1XPRZZ9XAGs6rQ7vzp
         htBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xZGQWu5F+L+LnhlrlKnJBt7Q9Qa/GJcvQeTn5kUBy+o=;
        fh=QgdSEN/z8eAIcVIY4QXvXUPEITHo+atDBqbnOvrXAVg=;
        b=sg6HK/gXAm/5lRkhlfEURmN1nDo0K+XahUJuS88Oxit1llLFwK3TxdeD3wnhlQx/ij
         7pcs/3mdRJ2Jl5DiLjGu06P4qD+iUaqNKHTbTHdRPhbwBGNfWJZkMoAxu0BLiTuH/U+V
         tU7m7edzbr5Huo893q4NYjWVBVj1G3TiJYLhN49d39Um7hwkhfbTXQXdlMqJkbiAI3hS
         CgIL6hJwziTRVJ0tyxmB95jRv6JdtXASL2szOJkgf6k8j2cMmrPdg3FWjFEUe7LY5WJ3
         X5uJ+SpYYc70tOnfPWJukm6oGYK9yjnhHlV4HYyqqmgDSslXjFNNziBRlJLW4UtW456/
         xENg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790851632; x=1791456432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xZGQWu5F+L+LnhlrlKnJBt7Q9Qa/GJcvQeTn5kUBy+o=;
        b=SVLuSdq/5miDqsF3OehTAiZGkWSLw1jUF43HwR6I34Lu9xE1axu6bwF9gwcJNTA5kF
         U8vPKBE1vUqFRqsFA7AE+q1OMVuz02OkhFEFW5+uHjRa4ok/8IohGfkZfLXNBqhQlxh+
         3TZnW+atvLc7QhFxOLfUzwM/dAeAyXSLnLn0eabti8ybR2VijI9vivWhlSGusAQe4RI8
         Ak9CLyn6BjL7OOer0dA4AJepj8TIJ205/WBR6upqEiX4LzP0QiGiPrbn9fK06Luua7BH
         uHvzvoDfbEXHs2glbii7vHe7tSKb+hHy9LdvyUdBEcnYecBbZ2gk1gXQcfXpRgYt3sKe
         bk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790851632; x=1791456432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZGQWu5F+L+LnhlrlKnJBt7Q9Qa/GJcvQeTn5kUBy+o=;
        b=IZyqCi/xj2pseQst3LbQa3hUrPrcRWLLtfL9KB5nyrwqsBdGSeLn81vN7pqTAiw7Wh
         tK2VFGGBrANfSwAe6nCovE+8hv7gjgSn17Wn1vYwscUB6teYwRPtoEZV6TafrxrXr1yJ
         txkZVTuuYes8tTKqdg5q7wUmuFDCdGdUka6uA32xzVaY8SOPAx4lqw9lh14mazH5Ld9B
         4fULjSNTM3dx2u/u20mW0ufOdD3m4RJEQMx5aOm2WHiFSMJgw3wJxQLDkw4eOYFXQe0i
         x/26AsXW+zJsdxTmJ5cpVE1zZtxnBg+Ho8xEdy4cb4z7cE5iKNLp1reVvRlFEP8EO8F2
         dxCQ==
X-Forwarded-Encrypted: i=1; AKwUvByhsa1TToej3tOnAThHZi0rdccY2Khk2qwdKH+bd5CJYoW36Bb8fyAAi52Y9ywieDEmMvOo49s=@vger.kernel.org
X-Gm-Message-State: AFuF++kO2UbdC7JNfPzYRQ5gFsvP0aV8k6711NxQ+OaCfmEzVYLsj93q
	9DM+kXNtoFNnIGn/ULgGAMcGyW61VIaIIxjaRYpBwDaWP9xARZI7dJXEPoqZdaA8IfqligfQitr
	H4zBGjLor/OPzcQwPU/4URbhWbxBEYeM=
X-Gm-Gg: AYBFou3B9KHtbotF1qQ+cezhE4qi0p2FbNGITmDaf/EugIuTuQUBvZZIeWg8P/vHcRS
	MtIrW6HSf3Z2n1IUVIkcOEQqbLq9zTHfrUp3AMSbNwIljg/Hc63Xopl4TokYbnf+Kis5MkQiWa9
	quJKEO4RE1abIGgsj5Mez3TZ6Kxw8Th084+393AR0uMDVyCzm5XM9mCksQU49MZZtd/ssVlqdet
	ZmBqdPtmvu8ebbYZHdFHi4zx8A6yGexgcAHlR5x2RWOS8Gdq3JhtJiHOTSai0Pbf+IkEP7ysYkL
	9JRzWqLYwwm/79GLB3iMimtprnOARkYSPkcx8joWXdA5beI3JqCrIu2nAIdjn2HDnRkff91HulG
	gDpfU+Fytt+kXHqq2CAcKmb6hdVa/kEbMobj02/uYwiw2Cq1tnZP1k0CnVTZ9FNCeo+YU9aiLSR
	TCulFRjXJUhb/3XbSjHlxlm/Rbuzj00+PS3ZyeWeOxd85wbWFayzoTvk8BrZV0tQ==
X-Received: by 2002:a05:693c:8085:b0:34c:f181:85e4 with SMTP id
 5a478bee46e88-34cf1818b1fmr7262875eec.1.1790851632033; Thu, 01 Oct 2026
 03:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001042942.109012-1-chenhan0017.work@gmail.com>
In-Reply-To: <20261001042942.109012-1-chenhan0017.work@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 1 Oct 2026 12:46:59 +0200
X-Gm-Features: AclHuK-fHM8iJEVkEzuvz_ovqF_dLYt_Qxw_QJ6A0Z4myKEgiMjsoUcH2rpEiKc
Message-ID: <CANiq72kjGWVk_9hR-gn4vJT-pgBsGWEvThMd9dF6-+GfBZseOA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: time: make Delta division and remainder fail consistently
To: chenhan <chenhan0017.work@gmail.com>
Cc: rust-for-linux@vger.kernel.org, a.hindborg@kernel.org, boqun@kernel.org, 
	fujita.tomonori@gmail.com, frederic@kernel.org, lyude@redhat.com, 
	tglx@kernel.org, anna-maria@linutronix.de, jstultz@google.com, 
	sboyd@kernel.org, ojeda@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, tomo@flapping.org, 
	georgeandrout13@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:29=E2=80=AFAM chenhan <chenhan0017.work@gmail.com>=
 wrote:
>
> commit. Correct the rem_nanos() parameter name to divisor as well.

This seems like it should be a first patch.

> Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-58=
69573842
> Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-58=
69925737

The discussion is small enough, so I am not sure why we need the two
Link:s. They can be useful if you want to reference something in
particular, using e.g. the square brackets notation [1] to point to
them.

> On the MIN / -1 safety question: div_s64_rem() computes a quotient even
> though the caller discards it. V1 already checked this input before the C
> call; v2 keeps the guard and makes the representable-quotient condition
> explicit in the SAFETY comment.

Yes, that is fine -- what I meant is that even if we had the check,
the `// SAFETY` comment should still justify why it is not UB (please
see below).

> -            // SAFETY: This function is always safe to call regardless o=
f the input values
> +            // SAFETY: The divisor is non-zero and the quotient is repre=
sentable.

"representable" is a fine way to succinctly put it, but I wonder if it
would be better to just spell the condition.

In any case, safety comment need to explain *why* those conditions are
true, not just re-state them (otherwise, safety comments would be a
repetition of the `# Safety` documentation of the function called, and
thus not useful). In other words, the point is that they explain why
something is supposed to hold.

> -    /// Return `self % dividend` where `dividend` is in nanoseconds.
> +    /// Return `self % divisor`, where `divisor` is a number of nanoseco=
nds.

"a number of" seems to be added spuriously -- please try not to do
unrelated changes, or you do them, please add as new commits (e.g.
this one wouldn't be a fix to backport).

> +    /// The divisor is an [`i32`] because `div_s64_rem()`, used on 32-bi=
t
> +    /// platforms, takes a signed 32-bit divisor. The dividend remains a=
n [`i64`].

Do we need this in the public documentation?

> +    /// Panics if `divisor` is zero, or if `self` represents [`i64::MIN`=
]
> +    /// nanoseconds and `divisor` is `-1`, matching Rust's signed remain=
der
> +    /// operator even though the remainder would be zero.

Not sure if we need the "even though ..." bit.

Thanks!

Cheers,
Miguel
