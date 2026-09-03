Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F794FB9AB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457065; cv=pass; b=X33n2hbiY2u48Uj5iC1pZPOYGb+fantoD2tV+YCuUbEr37lbFO0AR1JaIsz+Q6J8hLIpNBYURzToAuSs9eLFQUu3aha/yxvR4whVr76fL5vndbd40h31JAc50y/OeToY2d9DQ6ctVd45nCKhF2xq1UdzF/KGGhuY5wyvY0wRdt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457065; c=relaxed/simple;
	bh=3t+Obp2LbTtAgMnoOWQPVzvNthoJ4LjdYSCyGmWxyto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jva0jQX56xYFHistYrJ41lltBJ2aQfMs0iPMdlAlrZG63mzfQa0zbI8sE/qmvAttX4xIZtgsKs+93ZNhE0o5y7iEyvul3PJ26fEy1llttoXOvPnFs/YSDWNYGXYJVby/X5tuZORDN8jwPhaVkZX4+v3rD8i2FquiEcPXnKC5oOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMzLbqBz; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMzLbqBz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d70066b704so89595ad.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 10:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788457063; cv=none;
        d=google.com; s=arc-20260327;
        b=V5q4BKwM4BXs4CgGQYDTb4P52kvdo466wan8Cvap27F/BXmbWrG8JHrnSvZ2V/5uLK
         FNh+QRKehnJoimYWzMcV4LGOdVhFZtnjc8Kf9S21LFIBf1KiOXXbnC3CVOZqkKvrpK30
         B0GIdTDLVfxU5nKr3IXGfdrCsp7wO4sRnDAyjox/IXcbVwPbSX3iliAjDUuPvdc6RKel
         jY908z7QJ7SJpR4FF+kfVcBtVMDjSDCwuUBD1gaxhvLimohuBYdhfhpMPfVtben85isO
         1XDcH0FHqFkYXw9VyapzHoS8kAqsYVU/BuPWlrAfYSNtDL3G3MjlmOe1PkBb9Lo0knfa
         yKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0P/2DlLOR1VS0lt5zNUWqb1PSnBg5Y/NXdiOshIcuM=;
        fh=EEJc6nxG0sqTVj3OmihTGy/F/Gew4pJyNBAjN/1rnU8=;
        b=AuX5a41MW6+hlqWeS1JPNGgzB0vhc0HOU6RhkB+y4E1ghp1l3h0bvE5zE6AvS1v/7N
         Q6SmvuGcezxgOoKiwCsJZs+i7KbHnod0viZ3dpGN+9sfDDQRNRAtd7UGuCqgb7UP/3b6
         DFav0H8IDkhk5qb1ROKPr3rmGkQSEEZRaafVd/76rfcnmQkl5vdOKuuhvxATzvuYuzBd
         l7pu2ZzaYoBVyl0L2PSuF17TLw62FpQNlfByncdEOmRCBtRZbZSg1EOeyaSkpOoT5xU1
         4QUO8IA+DLAn1R4Fe95L91d5z22Ex0IxysiDAj7NsIX+NRKOwp+p91k4aSpBj7JRnkx0
         zuow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788457063; x=1789061863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d0P/2DlLOR1VS0lt5zNUWqb1PSnBg5Y/NXdiOshIcuM=;
        b=TMzLbqBzNsfU5VOqilx08pDxxmr5SZgRPHjgwbDrlwTGxGeTxCVVUBDVhZ0io5h9pG
         0j66/SKUJlez/iBHF9cF4wGYhYdS4lEMQte6QMQnK7wh9Kn18t1gnTl8Z6rF3ljwQi0E
         m5JAL12U6TerOrCxEkOk3XvUXx8inlfPWrgss2rLcxW/JXG6ZlOh5KYB2BJxKEX3ZA4j
         6Ilu8cLoCJvMGzjQ1b7+YYyFUyrP2b883B6gxJLEK+2U8W5aBbIjOf2GvaP/d0+KyouZ
         sPxTAHkwQqW0FsOmmRqnK4cwJwgpDDOuln8haLZSioHlZRGHGjrh3bTSgFMNV06GCl8M
         T20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457063; x=1789061863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0P/2DlLOR1VS0lt5zNUWqb1PSnBg5Y/NXdiOshIcuM=;
        b=hWJgv6YXiCURCKuhbGjgij1UwOChkyP7CONexonzCgxue/k/F7a/i/xpJdKfKxqjty
         k55sz46ruLydJH0nqitUzFMzasTWFltTzmPQSaPxnYH5qnEjMz9WCmwIHoF58PV1+Mez
         0GBWuRYIa/TdTE1dfKGCDc0Ta+PA4z9P0jeiT+9ESoJFZa+EI/+HLddN2QCEjG4fN6eB
         G7yF3P7SMWxRPtUfdsqfzXswmSK/8HP3eb3G9i4sh58fW03+vmzO6JJRy4OFORP5a717
         bC9y+Co3dJJnFXA9QetTuXV7FsvbUNyXtZLshvVKB3XufcEb86ZYssNqhF3WcnIw2Qe4
         rw+g==
X-Forwarded-Encrypted: i=1; AKwUvByssoLwMeoDz3quM6TWtclVd8P6tzpjxaL8zld/ElmLH7nRuVOEVIL40LSTu/qHyTmipoImkcU=@vger.kernel.org
X-Gm-Message-State: AFuF++kYUR3OOV4tzMxQwW6W8UkI95O+A4UUd8vfOUtbMxwsDaIZTxRT
	v4mQpzoMNBFEG7oqBV0EkmoqeZtCDcjHHjt09RRC0pF87UErEAxvQJ48P6z8GtvGB1iUhj9NcL9
	aHvy7EBWTU+or7OM0e4TbDqthqGNAqhA=
X-Gm-Gg: AYBFou0TfdQTf8jBgt+HLqkj+Ha1SzSx2gkcsDg1zmY4tnMyg2b2RFS5D/iit2cfV5B
	MuPZ+zG9TJItz3/M26I3/E+qaYtilO/kcosOaW4nhCv9wP7ea0JJ6CUaU/V6OCCtR55MsHlUgez
	0qBdMxc0WD9qJsz5wZNXLfD08mfg4nj9SnW7wPE0lEfd1sQtNWN2U88Ct9Y2bgi6usyz9nUzr6q
	FNUu/cRJZlIoY3xvjDQEM8CCEc4qaVITTcijp9F80t+RwDP6HkKtQQAmAjQngsBAtlL9ay5Qf/D
	hO28lqhqvzFng7A3zLGdJyjvCI5EgvNacYP0+9LI7hFucD+Ldhn6FRwakuq/xB5sAITL4syHICB
	JZ37JpG993vBiGQoAqJxEbOXZLVdZXlxgEy2ozfcH82uTCAyfsT1tYgPxsW1O
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr14129676a91.3.1788457062736; Thu, 03 Sep 2026
 10:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090324-constrain-truffle-09ee@gregkh>
In-Reply-To: <2026090324-constrain-truffle-09ee@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 19:37:30 +0200
X-Gm-Features: AcwNN1XYPl1Pa0DMy6K3F7CLU1MCRj5WftJfidyE5HTivD4ABKdhPXHdXTDqCAQ
Message-ID: <CANiq72=LmNrGNPtLr-eZqAL7cHaoFRaXRNUhOLXWGQB=-Q3qHA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust
 function for Rust" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, aliceryhl@google.com, jpoimboe@kernel.org, 
	peterz@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:43=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

To solve this one and the related ones, please see this sequence of
cherry-picks:

  https://lore.kernel.org/stable/CANiq72kmYx5GBU7VL3z8h3bAWB=3Dvw-TX+ptskDO=
0k3Ro-F450w@mail.gmail.com/

Cheers,
Miguel
