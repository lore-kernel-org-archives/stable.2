Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793958852;
	b=PgTPZZNn9O0Cf1SfkuwzNcAy6ziHfSqcCowomJnDNW0K2sz9pn3jVrhRuHbbt+QUphG8
	 N7ZvcAwDosEHLIXZWu7IlUKq+K7jQf9O7wfWw4biYJyTpQW8PcIYsbxmCV6uyI+UBk1Hr
	 DqI/w6ijnIRgE3DG+pLI+39pZ8NYFoO9Be/7j9xtUKzAr56ARoglX3A8cURjWSxB0AlTx
	 p9dF1faAhew0zvCa9HQAPONM/Tolxgdbj4KKZtOW4jJQVKEPoNt08VE3vjskRlaBhztnq
	 K/BNpj+JI40RWj47yrnmfC8s6xEe77E/ADUNat62L2jZaftEiO+EA85iznQWR8u36zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/qUBJvia8A4m8j44qWWCxqxQxXk2NNL+JHI+sUxPvXc=;
	b=iqoBuGm3T0ijp7BgH0mjRBycpg+Hgjk8+DnJuVQ5HCOSXW9LyL5L6kxWjK5oT5EQalM2
	 /6XtXZcKcX1ksanEzq6VH+nrb60x80OPeignl5JVPQP2Kzo5xw7M0I4t3L7XcJaVvCYIM
	 nKP2oLhUArGQcse09PuMe0md/2Jpgkr0/SZ4pt+e8RhoWa6z5EmvlAi6SCLQulnAFA5OO
	 684Miq5pcLc7GIR5H7N9sekgv5zhzfhf528YvODMiA46vjTbWErlamssboz8fEnsVJCVQ
	 KWcrSoaac/mGhCpq1Ir3WKm1ljncWuQE+wBZ33IWhBkBIzV/I+Te0ID+D2EkU3W7zjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2GNyqHT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AD606A33D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4AD606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2GNyqHT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso338668e87.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:54:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793958850; cv=none;
        d=google.com; s=arc-20260327;
        b=nPgdtO65dPHUbgfW/NrWarhvYvfrR6op+BH2fMYri88mkAbcFisKa8tIUFvNysLmXT
         Nj8lP/NU/ZEHChImMtkfIBBRWQDfcoGW1lD1c6Kp09FOyulHb1eC0jujP6qpCcVk+i5A
         WSBG2aU7BbFcJRGXsl8mPZ9dzV9Zbf5D3zMGvEd1zIFKCdfVOgpNSXXUuAZRX7+d67me
         xhlU1qLDfeVcPBgqGudrRU55J9EuRgFIwtCemMJwaMNbpfzaKWsF1YwZnTmfMXTqZX5E
         AUNJF4c3lOkGZV8cfpIXSJu6yEsdIRHJ1+WODz6xPADuJ8y3JnpYJ40sx1wPuOEod6Es
         Vmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/qUBJvia8A4m8j44qWWCxqxQxXk2NNL+JHI+sUxPvXc=;
        fh=I8vt3GhB/n+LKOtLSrhCsBQPoV+u0hnEQI8DPlNQO6Q=;
        b=lKzSc5lHq7z6XeWWVHC/dzneL2ggD7F5An6JOZqx10psM2j61Gh+m0KR/BN7zxuz7a
         bCWzSdrJMIuhzAQ5F9JLFuOUssY39xzmzwNCseqcIK5fGkuQK913tUcJ3gQmJYUZWXln
         Dgol9FX0HSmtHQKbzUO9jrqH1A6ZvgkEfZm8pmbWSdcOEKIDG1kj+patchtJYUzpQIEY
         XIOpPpAQnkIe/4L/pMObf3mTkISPkUrizULqM2Os8sMwkvU3Z1ELsiYojUQvI5Sxsqo+
         ayvymtBnklagTff1Mc8DvNV4cgBUSS81Sbf3i2zpMiONRdZfpWyQ4BYjQ9ghvoyz+w2n
         MaZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958850; x=1794563650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/qUBJvia8A4m8j44qWWCxqxQxXk2NNL+JHI+sUxPvXc=;
        b=B2GNyqHTw+bplblnkMuH26j++KRCL/oDDyzsrqB1IxCYAMLGUYggu3gxNT2HsNDBzk
         6E5ynqe9zZI51CA4CZ7J2o0PRN36aP2IXdnJcNRVXbZcG6MeKiFfZKhF29i2YRSmgFQs
         g7R5UdpgjxiTPB/5hvukxDxMhF+d5+9E9to2AT7qKjgCT3iNz8qv7pM25iAPrftwNAfI
         L19rw91YsEZrsLLabtq/odhS9rCw5LlF7vEIsP4+WkK8ZQK3S6BeNJueb9m1Bo6vsKze
         zRxwFuPIgYlpu7mJdcYd5igFvAibYDqAUKXo5sBnWhDU+vtX95zUCXDCm6PkmsxiH+IH
         EKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958850; x=1794563650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qUBJvia8A4m8j44qWWCxqxQxXk2NNL+JHI+sUxPvXc=;
        b=JR0L7geKOXBrNLgJurTBb2Coy/Dj4uM5kbz5ogvQdthv8AQk//hdJujX3jp/QIFHlF
         qXopWkv5Qfl5G725e8Zi3CPZxpSDgN8m/C6W3jALW2EBm8Usiq3YsCMelbor5juuFptn
         uZhFvJ0ClT+qw7fIA7QVh3qEFCDuSEgXv+2I+78LJnsmldKD2xjPc4m0IYUrUS1uDgLM
         XozQVtO5WvaTMJMWgD/seJbwjxi18UlbphphtPspFK7akE12ogsWrJ5EWSc5drU78BUp
         eUdFd+a30tq9oj6pfnwtjOCIRnym4bf9oxkAwG8HoKVr64p1cqJePYk0ImGV0/jzaThi
         ks+w==
X-Forwarded-Encrypted: i=1; AKwUvBzPsxh7ZZy4zr4xzBokz5qH4NgyWf6OWpK8t+seu3//OA1Gr8UrncfINAl6ZL7clTE2GSDeOC0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wz5x94sxIK2gDRaVPNnXyJicKQCQonE5pOX+3CM9InqaqWT8F
	OTDQS0XBfqr1gzdR6BYodSYGsdDpWs7QEMXSSzCDSc8/aI5xAw+mXkG6r++ZJzBoBNzrdckWCST
	YpRzdGkkCx//70k1uypa9MZ2j31vaCYk=
X-Gm-Gg: AYBFou1xLvncK7Xvd+O88xae9Pa0DIW8hAms733EQB+j9CQ/0m95lBvjucrmKJFBilO
	XxcLuOubSPD3PQyfZzxSKBQnUOxHC9hlwdDwpztaXw6d9wNAAOMBkvP0KLM53xewE/AD+XAQ0HN
	sOeeuYcqPqkvymmYXrMFRLIFULX4Vt1s68TXOEK5Q5ZC1CqBIqNhJm426q0xOcaDlx2VQOG4eM3
	W/J+I+36VxgehEEq6mOqpqpcdbB4lheLEFAvhbaxWYf7rIKGQC7mssOl67A6az5hwK8KFSMc6Gk
	lAsrnmQRglJMmlNwCifoJwTtdqyJnHGRP2OfwiKvTieAjIpLEDiZeepjKaAxLU6otuBnU0R7216
	a0CxQjuqKin7V+2zJ0s9UhO2s8VHF1sEQpYCoWHsnxJjwAtTSBacxw99ED7SumcK/nh9q
X-Received: by 2002:a05:6512:3f23:b0:5bf:c239:71ad with SMTP id
 2adb3069b0e04-5c003ad0afemr607795e87.38.1793958849775; Fri, 06 Nov 2026
 01:54:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017030927.345454-1-suunj1331@gmail.com> <20261023115747.2545223-1-jinyu.tang@linux.dev>
In-Reply-To: <20261023115747.2545223-1-jinyu.tang@linux.dev>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Fri, 6 Nov 2026 18:53:57 +0900
X-Gm-Features: AclHuK9nk148RfY2GyVdkkH5dnZpSne9-B4ydq0oLeo4XvcO3mtFibrpLrfrSO0
Message-ID: <CAGwK=3r0LRuhYNWZ1Rq573qWFv9HNwHE_MxqXJa6Bfuc1QtWTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on
 host-writable leaves
To: Jinyu Tang <jinyu.tang@linux.dev>
Cc: anup@brainfault.org, atish.patra@linux.dev, tjytimi@163.com, 
	inochiama@gmail.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, andrew.jones@linux.dev, 
	pbonzini@redhat.com, seanjc@google.com, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:57=E2=80=AFPM Jinyu Tang <jinyu.tang@linux.dev> w=
rote:
> Tested on QEMU 10.2.1 with a private memfd mapping and dirty logging.
> A guest read followed by a write corrupts the shared backing without
> this fix; and with it, CoW occurs and the backing stays unchanged.
>
> Reviewed-by: Jinyu Tang <jinyu.tang@linux.dev>
>
> Thanks,
> Jinyu

Thanks for testing this with a private memfd mapping and for the
review.

I'll include the additional fix pointed out by Sashiko and Inochi
in v2 and carry your Reviewed-by, unless you'd rather take another
look.

Thanks,
SeungJu
