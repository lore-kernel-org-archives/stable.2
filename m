Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34043F7882
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567637; cv=pass; b=u8T8nSCTJYhQtoHCKtXzjfvESNQfGwVXM8z0yNcHCPk0P39fJ4PMCrGEVH8NR6Wa3Wb9Zzp4tkcNRMoDcfMu3Bu9uR50qQcwkiTr4Yh2CjC9nc52l9fVNx3t04vvimW5xrEky8LznOWQpwgn6VAjqzRqVR1l0j+iPXkiNm9dQM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567637; c=relaxed/simple;
	bh=rTsk7zAhD79ApS0/sKWkLliFhDHabfK66J0Rk8Rj+zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmHdk5ZGBDhJz8lIxKHOgE/jODpluK0MBv/oxPAlm9zH4A1GFo1dj3uBofq+2aB8YccYKqvy7xoS/Z5yq+X7fwO93H7uz+iCy9jbMSAPrmvsI1iBnGtKUNFhElxvKe080a2V54BrXlM4n2YHt6904MDPkaibUZOQj5aF8IUVcd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QulusW1J; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QulusW1J"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d319b84213so4303675ad.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 03:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787567635; cv=none;
        d=google.com; s=arc-20260327;
        b=P2KDkDJwvSRqerH/lxSrSyCxnPdra7/QZyEF1tweOg0y8pfX0YxdFgtQkRvH7qt7ee
         m7tm75dYkTgaK0GgFkq1MXZz7resbNDebFgEo17CnLS3FP5k2ICew0gIq8Q5nC5+0XSk
         xwRztE5VhhabiQHqxJwwHY4nSDzznte+hl7je5gOjrj/h6043xThxJJtYw0fy2fYZG1R
         jSeusDaJTIt9SQjzixXkq/PLqJQ5q4kDHHzlFE4rGXfWCBLKO2o18LSLLJPO3Rdn/86P
         dmZ7SoiAUwLxSE3J/x+cQQjWmaELXkQBxTHFNnGjgK74wc7a4Z/mREBBLXufHrPbo6LA
         URxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Sxqv7JcbCSLDzUPku5fhjtOE0dghfe3mxOBWPzMEpk=;
        fh=PK2F9RESyhvnfnAhVHmEUjcGN+3+VVAfa/moZWdGdfM=;
        b=EpyHD6tE6tSEOSTEeTHh4ra5mttafDujo/qDvN3w0QZ8WI9Y52fTvZ5hFdzVVh9rf6
         aYVCHlQj2QH0uF+4kHGKMtOjRjUvYjI7jwENwqeBkXNDpN6Z8ldwy6ZS/ionpoeRd5IG
         l5b0QJDHqdA9Nec8ZLDaTtkhq7TO7APYJT9SqEVX98OjtkReUUWlA/BvKqqE71KrWUxD
         3Dqhnd0Su1PisZusoo6IdFOtTB58nPqo7BzjClRbpkOYC8tWYKMfYwO3lgWVLGFwCjAX
         P5gP3uE5hy9S53V8B3fCVWq9DvhCaFHjuP9qoCGpcitPWj5+5nAf24fB/46W1zihKLDF
         yZLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787567635; x=1788172435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Sxqv7JcbCSLDzUPku5fhjtOE0dghfe3mxOBWPzMEpk=;
        b=QulusW1JRP++7Bg5FKks8SIRgRBjw05QfmLWOjf86PEGu/25FoRfYgne2kTZh5kjsU
         TtJdA6AxUyf6TJ/to1jFsgX1BMk2ArJA5rqhp0OcUQSA7AtlOes5qOoagnPXu6j8cYJi
         AL4IaDaWBqYs3azjZch6k5F8JOl31M8lwbZn8WfKdW8MzWD/S35YFatxvdwg7Xn6Xa5R
         kia/LAtRP/bijM9+tOEpqAMsGerS2TOfH3072gOA6w0T+HsvBYeIJYV7TisdxuEUHyPI
         MiX237+bE0hiM8Ff7KNtqGTxDCDIjbNVs1WOZ4LSXkYPOIWX+0Xwz3SIR8lCbcZBpsBS
         mhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787567635; x=1788172435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Sxqv7JcbCSLDzUPku5fhjtOE0dghfe3mxOBWPzMEpk=;
        b=EBHnecbfk/eY7YjkTqZzZq+++vAv6ORw099owZDEug2Y3lL+A54Twm6vmH/KUFWD5c
         ElakjLA6f3BvDddJeYj+/da24o6Mz0OAnS9ENF8ymR2+i9cfawyaDKjUKPqrIOdJuhpu
         nsvq3fMdBjKFpoJ67zCV354g1Snb3ac9opHFXU63IQKc6Lf4TiYbSTL3MPbAwTBh7Oda
         hSs/OwMR3ue9NHvv1CX5IHi1wfgijsWRDI6PVTCZkD+HYsUR1aQZFIudz2RC9S5SjgZc
         C9zpjvkZfyvWtWxkJdhcVNRDq91hsY0Q9btKk4LJmf2f1tQHalC3ijFVe4hn2643HR3O
         n88g==
X-Forwarded-Encrypted: i=1; AHgh+Rp5bv4gMa0JkXUBuSeI1AYKTMfP/DQA6n4jUbj/8rIqr3V+lGo4pEOsi7JuhWHqxm8Exm9FZsg=@vger.kernel.org
X-Gm-Message-State: AFuF++lHZ25z21/ecMnWCwzqjJr1nN1ExcIMGS2GxEOFiIQrbEO+klat
	mopcv0TKeMSm+8sRW2DDBIeuNlkL9+izWBAf2URMx+3Ay50XQwR/RcG31UrcSW3J8xchyUV1umP
	suyjU9/k8PXo9moeCG8EEaCIgCMJQyZE=
X-Gm-Gg: AR+sD10xosoeoM1i0kCBAR8SuFFih1LoVBbFuawCEdzDnR8dcNXYx/t5CooOeMyr1TS
	JmNYTqKWEDUNYDBD11IKafQS6JDsSNEWWkW+reoF3qknZFUhh4Rtyn+fjp2mOucZtg45n63YqB0
	U1GXp+piiTw4oZXcuVfQlFQ8rAdY+9nhKJPz+aIIyOZ6FRJT3SRYxrTxcIdAkE/9uZCoNSXcpik
	i0ppIQCEy+ldfb2XzHIhY5zCbX5K3c+pMY4JZq+8LwiFVHLiPYfTlSE/12aHX4g2y8kO0UwMT4C
	zSY+Auve0Xw898y57b4jEuSiplsCSr6Ty3RWa3RBVggbV3n3Yl8mabsQcoswgGWCn42hYXG2dY9
	GQXxKWPWU/uyxkRukBvb98iJtGxjdf5CqLHe77SrpBrkS/INhnRX/y2b3eiIN
X-Received: by 2002:a17:903:b43:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d64b0d7b26mr223449495ad.2.1787567635111; Mon, 24 Aug 2026
 03:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816133233.197500-1-ojeda@kernel.org> <20260816133233.197500-2-ojeda@kernel.org>
 <20260817181212.GA1249844@ax162>
In-Reply-To: <20260817181212.GA1249844@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 12:33:42 +0200
X-Gm-Features: AcwNN1UQhMeA17Nam-JDCwmn02-8UCEoZ5cc2iWtmyDKrZlCDreN1zPgzdBNxyQ
Message-ID: <CANiq72mAy93vnGZJ+wfwh2epJqSpOhF6XBK7K9XWC6mVEcPT8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: rust: keep Rust objects out of Clang LTO with
 inline helpers
To: Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Matthew Maurer <mmaurer@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kbuild@vger.kernel.org, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 8:12=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> I am not sure we can use '-mllvm -trap-unreachable' for C code, as that
> would mess with manually inserted calls to __builtin_unreachable(). It
> has come up before:
>
>   https://lore.kernel.org/CAHk-=3DwgPCbZv0JgqoNWMOO+p=3DN772YW16xYk_pmb1G=
U7aeuPFA@mail.gmail.com/
>
> It is possible the '-no-trap-after-noreturn' avoids that particular
> issue but I still think the "compiler inserted" vs. "user inserted"
> distinction that Linus comments on is likely still potentially relevant.

Thanks Nathan -- yeah, that is the kind of "intended" thing I was
wondering about in my note above... It would be nice if there could be
a distinction between the developer-provided ones and the ones that
get inserted for other reasons.

Ok, I picked these up to fix the immediate issue, since they only
affect the experimental mode and only the Rust side. If there is a
better approach available in the future, then great.

Cheers,
Miguel
