Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C940DB57
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571186; cv=pass; b=rWohsVy3TaTbATqFEx2tzbWHz4qZu/HkPG+usVjf118OscIWhtkhuvApcDxPXyXXvbd3VBARv4QH59Hpx0HvzaS0l0000LZ6ziKceKKwaLdrEiqtxe8StbxgbgwVlzic/qf9KI/bw6BCH0jSEidbTvPu4RniZEBn1iR30LwYeOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571186; c=relaxed/simple;
	bh=tG8n7vBiTj9wavffVvqRGON3z89WPyyp3NtwIl6XIng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1OBuCveJXwbNzEFA90oz+yiy0JBvMfSb7rsA8MDI/w5wxYtivRTpUWb8uucLTEf1mG+zdYLZ+POk+wXp5/zUj83Zo7sNMqIc/HS+I3cRU2EXrxWavytUnJ0QGsYkvIx3DJ4il8ECTYsWKVKbahyEA+MUl3nHdz6hyVWalS+y5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxT/hj+u; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxT/hj+u"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d027b7c8easo6609735ad.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571185; cv=none;
        d=google.com; s=arc-20260327;
        b=PQYgn4M7eMI8mlcrfab1qbCqdfZj/sLZTHiD55aGk7iOccqKpDvcGT1Zl5/rhdWzlI
         vylgRpKaU+EW8vrztMP/H6tmIsRa/TB/gJjuhO3nx5MbvlEL42wVhvQtNm4RS0h4X5YH
         oNSxkhMpw6CvHu1GLveWxtaJwKahnPXwUmLtpKvqZzvDHwpbJLqFI88vqLMQ8m1I4q1g
         BmRxkOfLU7iI2/rM9OM49jN/XW6jcD53cU3D+sJi1N1vnbYPrsQ0D7PKjDaFDk+wjhi4
         oCQtuiozQMeAj34smzhSvy9SxPCHGJVTOAjvzURPKavzyWrx1k5mjFIATSit7+/wYJ7k
         UdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tG8n7vBiTj9wavffVvqRGON3z89WPyyp3NtwIl6XIng=;
        fh=bRit4iBof2pY7jS4ia4UycoAOKdyHhB+iiCyq1Q6mZs=;
        b=Ym3XriJe/U823tZfx8GpEERDqPCsWxz3RPitgskeogBwzVUNYQVFfSP1lcM8DVQYKa
         x0DS0jFoJ46sfJC9fWq9ZWzM6+aFZsAGaq2FTZeM5p4lD3thHmgyQsyCl4kediGiuZVE
         xNulEXHBdsTt7KWyl5lbXUJyT1Heexm4v/IrUzMy71fXz5Me1VY+HRS4eW+4HXL+hvIk
         6JT7I4fiUQHsu3JsqyWgrXXCNOAAoGd5tqQ/rIAzFDM9WKO7Un8tLWeiP2bOpbdXp298
         aQNngozsNrLf5pwuyz5LfbqxDqXDhohQcOGx+m3qSmwXCeOJaoCVR1FAwkUY1VWbNBRM
         T6Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571185; x=1788175985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tG8n7vBiTj9wavffVvqRGON3z89WPyyp3NtwIl6XIng=;
        b=TxT/hj+u0YL+X+7sOKBqlsGxhEs9+MMgT3H2TtGpW/bhHmLG484BfgVKRcjQR8QTmy
         8QBc6IpIz4QuqLRJPsd58pcTf/EDtiGtJv8Ldci+q0H6VmiH2vcWU4AnrW4bWpc4tUvL
         clBT5vInSLy5erIuWXC5AGG8V4sQZrFdE6s84sAf7ltasO3STkGmKiFrRmhfcmke3Ec4
         S3YpIu0plNCLWqmaW6lCYCjPBPyU7QtxTW7SCnWPwFnDzbvN3kyc3KiBAyOq4TqQ0ccg
         VvgpWnE8KkylAiTfRmbk8hjaPlhiGz5uyW0EwFkXjjmfke5tyZVtdsokt7bnz/JD+ZpZ
         enUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571185; x=1788175985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tG8n7vBiTj9wavffVvqRGON3z89WPyyp3NtwIl6XIng=;
        b=ASuAT/AbIucVL4yka/u4WUlD9lUh+8B0wFpMGFUphDVn3RNTVwNQ6mFpCuuecYgw2X
         aUoRcYN7QE14bBGDmYLAkOa0grlBRH39ZQ3XWamvKAvV7/1+wUetIiRMrJD5ITR10YRy
         UmOP6GN5uwVQsXDKi6QPXQbKs1YfQH0HkekobhsY7jDuot6xY0ugbW/FQWl7Y4qZNK3w
         d2zTUOAoPNz+9e+5bQSWAUnnJm/7nLZ/e0UkYmbmGXfq3/Sav1S5i+/RY7O1cfI+ePzq
         KnB87JWL69PAQG+/vwHBJUhQ1o7yzz9LXCGzYg599kbMqTi++ri/mfiuE7BFNde2zrji
         vJpg==
X-Forwarded-Encrypted: i=1; AHgh+Rpe67Pyt/CdgKXJ4SgI1iw6r1IE29Zt9fRTFA3b1y1VjvTnB898iSMPEZ5IrRAbYuBnPVLGEKA=@vger.kernel.org
X-Gm-Message-State: AFuF++m9gf9BxnoABv1+F2OYWyXA+1Dasrgg8hxzFuDtdrY1E4pXLa5s
	POP2GRfgvUiSoa3815XIlibIqgb4s1cGiY+hiYTLIEiP62MepBXicwEYvwbYK+Ctb83fzY72Imi
	W/X7mptOvX/J9Di6vgYDSLAI5wAryqcI=
X-Gm-Gg: AR+sD13Gzx5Ixt7/GHYzPkGEa9I9ZheB1XGth89nzvinvbzFmKrWbL3FK2KEb2ykISN
	uskG0kpKJHAHvix9HZ+Sdifo+FKh+DkNKVHm5sH9XYgjgC41EYdK6BwbL83ySiX7OgUpVXQ548w
	6sqErWdU5s6HXtmJKC9nhT1/s32RxxtNP5ZDQBAqTolY9uN1/bhaLsvjYs6DTlXUlPfXZ1mkcZY
	6fCIAVmtX17brjBIQXpjh9Sqan5qD3S3gXs08EKO6uA2lIOQObQcOUT1cIXmfG51Ynl9vgR6RSd
	cNXszmMjvK5+HyW8QL+2taM+Ar+4p7/wA5JRRwXp3mvmP/zyqmWsKNi71pSyxWhWKRbgzpW/ryq
	kXAlINSORzf6sbuaXraDUZklyGJp8A3J4x0ZPeb++9yb7w0A4neYWD2TMOROB
X-Received: by 2002:a17:903:3c30:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d64a9d1a92mr213585835ad.0.1787571184660; Mon, 24 Aug 2026
 04:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822-fix-rust-bounded-from-bool-submit-v4-1-aa780bfe7f30@younes.io>
In-Reply-To: <20260822-fix-rust-bounded-from-bool-submit-v4-1-aa780bfe7f30@younes.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:32:50 +0200
X-Gm-Features: AcwNN1XIFhMoyEK4a3W7pWYnrtK64GCMIjUMwZkmGmILvFq91xYUPrm7yvCJg4k
Message-ID: <CANiq72mOfR33s4y+Ueivd5NrC5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com>
Subject: Re: [PATCH v4] rust: num: restrict bool conversion to unsigned Bounded
To: git@younes.io
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 10:45=E2=80=AFAM Younes Akhouayri via B4 Relay
<devnull+git.younes.io@kernel.org> wrote:
>
> From: Younes Akhouayri <git@younes.io>
>
> From<bool> turns true into 1. A signed Bounded with N =3D 1 can hold
> only -1 and 0. The current implementation can therefore create a value
> that breaks Bounded's invariant. Deref relies on that invariant and
> calls unreachable_unchecked() when it is broken, so safe Rust can reach
> undefined behavior.
>
> The other primitive conversions require the source and destination to
> have the same signedness. Treat bool as an unsigned one-bit value and
> allow conversions between bool and Bounded only when the backing integer
> type is unsigned.
>
> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
> Closes: https://lore.kernel.org/rust-for-linux/OzuVxu0--J-9@younes.io/
> Cc: stable@vger.kernel.org
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Younes Akhouayri <git@younes.io>

Applied to `rust-fixes` -- thanks everyone!

Reviewing this with an LLM made me notice that we should probably seal
`Integer` or make it `unsafe`, because currently someone can
buggily/maliciously implement it to still trigger UB regardless of
this fix.

Cheers,
Miguel
