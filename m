Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FE4AA006
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457114; cv=pass; b=F1wA0ai0/lGDef3HbIuj5dq0CPpXktDi6JgSWLzr9jRuDB1BbZD9sr4FJlZO0ullBYkTlPZTx7fDGp3pkjRWyn/9pMLDx0lsQJydsVuuL0xg4HBUc4qWB36Xny9FkNn1hm1m6G/ZGws/ayvxM4g3cVPc+OUgaN0MnnN6ThAk1p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457114; c=relaxed/simple;
	bh=kDhO9eCDSYIcU+ETiHPF7XOel76grgIayQQy1Ge9nUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pl5Wk/D0tl116x3tJkrCSTDvI+cYxHXNYzcWi55RNKLqslp7EbI73+dkc53IBid6KZvu/td+tvTU7AKUo0ZQmai2eqbbnccpoqBnDxy4KnY99tmX0lWnkVi6FPbwC5tYdTQWr7Ai4VWKiwLxlNyDI5s3pq+0vnUQr4yJsZL9zhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV76Rm5r; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV76Rm5r"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-396affa9420so4593a91.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 10:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788457113; cv=none;
        d=google.com; s=arc-20260327;
        b=FTxVGtrJO3WX7eHz5gYNpExgNiNx2EN59/DrUfa0CLRXpE/ApvpMNOg/ghEHQ2cGYA
         DjF/UNB7wH+ZRibAoBPCOiS7G/uyShGXJ7Xa+eyhspbdRNyo39LACRjRx1LrPk/YEOzW
         iDzvd+AnG4ilhL+LWOFhkqOPQUFJ5sdjYNx+HIn+kdQX8tjqO7x8magmBFquwe873D8r
         Fbcw7m0Q3kedhO46yQcHVBN4Ph6gptLjMjthub96eICFiE3U+tMmP3e3uuouX0yU/ppk
         GC0vkvM3CAsKbFsNrRvy6jqtzHtRgfSbq2ODrPYxnLz5sw9jaCoNSss2U4TRfF6ZpjuK
         Yzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=St0ZkzswC4K+v9xPtQf7duMogwOxIF6lu6w9VcjP9JI=;
        fh=Jvf+U3U67QcZtKRunj/ftM5gHS7WiJQ7e4/TvMHrsJo=;
        b=P1b3hB+5TbUXO3ig/fhZn6V/S5quSoLKo+Xi6i64UsUayXp2oAp8zQNgkf13ha4VnN
         9F8ad0PBaFvnZ7SN7CAQp2vC8r3PrGUSi7wdyIEJ4GwgEjl1ewonFzlyF2X+vEWwI2jk
         cA+K1hFNRE3cTZnIK/ZySKsP7PVuTrwYZB6H3/cCxusxEuzr8+w7n5yZqgNYdbJDszE9
         lgMm1Bk508Fbgls+2j9tBmTus7AvyvfkWr4vBFpGpjyZHSpoKAMAoc6CV2+ED8bNy5c4
         mZ+T03KcInn2uSxB0ui9JnBArWJPQSZzRvMYczCQDw7WfAIE9ML3SVPlIValCEbnnUw8
         9SjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788457113; x=1789061913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=St0ZkzswC4K+v9xPtQf7duMogwOxIF6lu6w9VcjP9JI=;
        b=EV76Rm5roNF8+tpp9Byk4+NmY8SMaycFBSnEPAw44qNPK1xnD9LlUk/MzvPfN2UhWD
         AracbXRI/1paRpAs8axYvjccZZJ4YmFM42xaXucLDN/kyCIREDbgul67keee2LzICPCJ
         bk+ace3PBuSV5xo8RrmOFHNogUlE4j59IHhOZMiszf3M9Ce31n9fMkaLZezIMOxvK8uB
         pwngQ3NnQzVpYRHN/eBe67eiX9uFH0j35CzjfBMZsSyrB5CHMEcZfd1e3sxG8wKjcJ3W
         WufkeGCVgxhDNbhww4VhQMutbc7y9GKVH6aBTurfLdPbqmOx+2QjO2TQaoHCVGP3wAkX
         5GtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457113; x=1789061913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=St0ZkzswC4K+v9xPtQf7duMogwOxIF6lu6w9VcjP9JI=;
        b=EAgCij5tCL5URK1SFvCX3Z6LfcbLH5gvBrj6Bw8lmKWC8x0Q1544iMQ9+BxwqEX/gZ
         cXnHoQceZsNnH6KZIHZg/ZfEz65BPlouP5dXx4zoZTFREwmVD+VvqSf0+XwZXnIQ30wK
         GMsvWJl4kfq7iKVOOsbaaDhTzgNpSMTfIlAvEEfdIANLAd2tc8KDD09qgdsExmhqSGIT
         r3GBkZVyAKDXc+kQ9ytp6ZYkcdSuocgucLlr5DqccFxDxn3QjjNXkktRXl37j0INuhN8
         lEvmemZGkA34tQTtZRcmpmvSpmXqXTT+k1Dc9yNe/Wonq3vx+Zr9e4u40PhP+fF+0A7Y
         JwZw==
X-Forwarded-Encrypted: i=1; AKwUvBxSjAzE5jfYASSd9iS83mqUbJhwRYO5Mzwxp+ZBwG5s3qIDwBKCmplHRHbThnorJYmjXjgU5Zc=@vger.kernel.org
X-Gm-Message-State: AFuF++lVHNROB4qD70JIT4rGCFeh9BYkS0WeEYYCpp0D28yDKuh/egJC
	oim8W94isScR8i0SljwkBhDjJqXJyhbL7ZxiMHzNOuD4Ma1cAByq2oJ0TgZNWuT5DQfhhZigrGz
	I8YwVvZrWEhwDh4Qehs8e3Zg5zRGC990=
X-Gm-Gg: AYBFou2qYzUVlpYul2Jk7AZPk3tWrnVktGsPLMsaGLIzjw5Pb98NJmwrqr6/9VOkH9c
	whIGnhkMklCzlP/+hFnPgZaQKS17gqPV0Ipz/KfIsBP4TKmsmqphURUubVqT1PTNFYILcion/+d
	u9uS1Ny8u5A1qMxSNIK4X3uHBDQMb9e2bq41UjZFqz3ZOybC4WeEDgojcdcNNs89563JuUf/9mB
	45i/Xcvh9xOyOABrltVMw6VzvKBsbP+V2NWgrML1I2HPwPdlvo9/yMYNpK7nSsQWgI1U+Gi5+kW
	q7Yb0vmX1Ne39MAdLTb68M2OEFpLMIOvpQtxKHATGabHBv1SQm3CbSFxbL1pBjlSkZ4LeW7GTaU
	7PJoMTNsbpUB6arDzv++T9i6RSeQmbzh35hz6ZFUsNYH7iCqJJK5g+wiuZi5Y
X-Received: by 2002:a17:90b:530d:b0:396:63a8:699b with SMTP id
 98e67ed59e1d1-39b263dcec4mr17500a91.1.1788457112615; Thu, 03 Sep 2026
 10:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090323-sculpture-footnote-46b4@gregkh>
In-Reply-To: <2026090323-sculpture-footnote-46b4@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 19:38:19 +0200
X-Gm-Features: AcwNN1U9wo03HJnJcjGyiy8kP0ibW8GbtCKFvoXvGwSgcYfLGcgXOgxVere8pRo
Message-ID: <CANiq72mP2VNQ_JPH4otU3tUwnsgx-H9ytK2euyv4THmP7CcL0g@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust
 function for Rust" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, aliceryhl@google.com, jpoimboe@kernel.org, 
	peterz@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:43=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 16861ca3508e0deac70d3bcacb6dcf435b49d9ef
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090323-=
sculpture-footnote-46b4@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

To solve this one and the related ones, please see this sequence of
cherry-picks:

  https://lore.kernel.org/stable/CANiq72kmYx5GBU7VL3z8h3bAWB=3Dvw-TX+ptskDO=
0k3Ro-F450w@mail.gmail.com/

Cheers,
Miguel
