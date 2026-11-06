Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961947;
	b=SXBIcI2tEAtY5AFsNqh4q4ArXPJo2L1PvswTi2Rg2JFIpzJidN7ol73op/mRB3BBRRte
	 njZQfQpAJuLxeLGU9BSWjdLdXU+WZHxXNJvCPjXJjw17JNlrQ/w9XiX9YP0R8zksrjBZo
	 ytOGgKuQk7ytE9uM9SaspYbatdiDJY1D3qHdMV9kKE/CVF5tsi6MO7UV9SvmvvW8T28vU
	 cZf93BjKUbnpVLkO6KGhlvFX4aQ9G2LtWcnWJhllIrTpfKozNeZdjLUc8yhYH+Gpd9hpu
	 qwZGjTmZfggfAOxHN/Gnv1Mt/mL9i/+AFi7JZjRloT1bPW9VrgacpiqNbsagDtn1fIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9d4zmqowzFyjpS1+CWDAo2gFvDOoR0tDmX9/Gr/o+TE=;
	b=j/DOe51eALRi54M/TvxTA6GU82d2/PBpC47OiCvWjejc+2wy/AsDciEgkXzkxnB/x2dt
	 fqxzYl5HHsMM2Cw4OJXQGLaDkJ+JgYCdkcfOxrtHTWCOWH8xX0mCRJECy3EtD0VeXzMav
	 zaPxkk/Ow6CS8RfdK/6uGmrkw+SBoqYxhjIRRTQkbjPOHK/CmgaNT7YKeABHQU0PAX67Y
	 BtjkCN48pBjyrQ1pU+y6bZB8KVKKG4NxmqiVkwDbsrbk5AVG52Qe5VhTQrbFzz+8gyrk4
	 f4beZaIRTrzxL1NdzJJOGwaFoR+yvpf1koVDhwb1hucSM7Dbd55+3vDWLE41z6fIADw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KFsoFxbm;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160E606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 10:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5160E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KFsoFxbm
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b5e0ce4132so513126a12.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793961946; x=1794566746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9d4zmqowzFyjpS1+CWDAo2gFvDOoR0tDmX9/Gr/o+TE=;
        b=KFsoFxbmSg5jZA5zlPMYhng49X5QiS/f2vRe9N5cbn8SAyS8ftNLN/yEbDeWRDzSsr
         boE5ssBINTSCH2JQA1dFQvMYotEHwHab7gurMySBUQUG9KtYmqtI4xzUz1mryg4Q5ZP6
         XyJb4YNV5n1Zd+3g18qYKvesUEnS3YDmS1X8g4KbzzkWJsFYfjm6OSSfleLKcpS5bdm1
         qpzhHgG/81nSyr2wAlrTJ2VcTZU2TwtSwzB36iCq7IKfxeZ1l5bblyD3yI5ApwMuNhiG
         pz1qLVLsKZxjmDsEUuR3YI9OkbDqPapjNAHvgfWq8h4wZLk95M9k1Y4dsPJEWnc8GYiA
         u+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961946; x=1794566746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9d4zmqowzFyjpS1+CWDAo2gFvDOoR0tDmX9/Gr/o+TE=;
        b=17tUeDm3xSWmhNkzk0vCTfaLyQeRXZBkJrhFKI5WR/RpZ1kQAd0r+Fz+yJrT3fF3pW
         fOK8cEzWGfN7hA33Sq/GbtIJAwEpZUUcikuBKEKeI4HhVXoBXbZcG8i6vshZnbm/CQe9
         IUL0gHyihM3tFI9zCox6yH13iuz3sghycq6dfNhl9qsLXybbvaLfiCCWigOXg70xFhKD
         IRqJPK0C9nDuXDYaZalUxWDlr+tW9h+lsHOM0g1kG8s8TDWpIvkvuqLLwqSpe9aEptz2
         Wi6iEvVuPMEf/Cq/IHJTta3UD56/RP6ks7kBXENeSp3zhVf22H416a0z02RLzvea1EpP
         oikw==
X-Forwarded-Encrypted: i=1; AKwUvBzRi0r2yMfKbCHPQF5zqN712RUoSBJVQSNlpztNhilG9Dpo0PUI8XbReNF4YrhbPxOloZdIpRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eESmKq+dbmJbBwrmZiBb++4EyzWl2c1UR5xvBiKKWU7SZU/eN
	v9wp7mJ0h34CeUrfyJbKu6Sca7PJ9N81gKz0XEa4FyimmLFRYQEI12iLNCVXjqFxjfaUEYpfZ2g
	mJDq9lqGnGuyU6rVf0w==
X-Received: from edqi22.prod.google.com ([2002:aa7:c716:0:b0:6b5:8cd9:f07f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4014:b0:6b1:ce0f:eb6b with SMTP id 4fb4d7f45d1cf-6b59780db99mr1761923a12.31.1793961945470;
 Fri, 06 Nov 2026 02:45:45 -0800 (PST)
Date: Fri,  6 Nov 2026 10:45:42 +0000
In-Reply-To: <20261106063745.87864-1-ojeda@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106063745.87864-1-ojeda@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261106104543.2297426-1-aliceryhl@google.com>
Subject: Re: [PATCH 6.18.y] rust: bitmap: fix intra-doc link
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Burak Emir <burak.emir@gmail.com>, stable@vger.kernel.org, 
	Yury Norov <yury.norov@gmail.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 06, 2026 at 07:37:45AM +0100, Miguel Ojeda wrote:
> `BitmapVec::MAX_LEN` does not exist in 6.18.y, so `rustdoc` warns:
> 
>     warning: unresolved link to `BitmapVec::MAX_LEN`
>       --> rust/kernel/bitmap.rs:24:25
>        |
>     24 | /// This also matches [`BitmapVec::MAX_LEN`].
>        |                         ^^^^^^^^^^^^^^^^^^ the struct `BitmapVec` has no field or associated item named `MAX_LEN`
>        |
>        = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
> 
> Thus link to `BitmapVec::new()` instead.
> 
> Fixes: 37f45fe068e0 ("rust: bitmap: restrict bitmap length to at most i32::MAX")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Another option (cleaner but a bigger change) is to cherry-pick:
> 
>   f5535d78e126 ("rust: bitmap: add MAX_LEN and MAX_INLINE_LEN constants")

Both options (this one-liner fix or cherry-picking f5535d78e126) look good to
me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
