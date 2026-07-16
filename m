Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D343BE643
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217571; cv=pass; b=gdiiNE+c2cGR5+LNII5yUqzzbL8okbqU8x2vv107p66I011ENZn9DbrHRWz/MAxy84LjqLNiZcTQWOGYLrtM+qkq/PWJ0XTCp35SkZv+RA5VtIB860u07R4msLUe9ysF+OGZZlsdR19qDPEiihBG12MkaCKtXde532+GBCDWnoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217571; c=relaxed/simple;
	bh=zJu1dwF9TbUJeBdkxNZLeYjiqmyBnDs3aAO0ElbitLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsxlcLsvluNBHDjeq+mOlDE5SyDJwMXWrVa/mPDnKj9WAP8LtGF6PIBTVvcdIePTQ6F7c7R8+u+qpJfY7UqKI+OpqD2YBOgahdR+VFZsLlWGTXjVawa5j7NZFZLsV4RLPMF0m8DKK/nDh4YCPcVvPsyJs4NNrkrxhSOIAhKBE4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoCG3A2B; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoCG3A2B"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-380f3c1b087so639970a91.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 08:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784217570; cv=none;
        d=google.com; s=arc-20260327;
        b=bIlDSBcGB8x4rJwC3UgeZ4SxeK6pMRJ8nDCJ/UAEuIf5ac2ljdQ/saY9uz9k93RAf5
         GQDWs3SdbTmYcDbdLyCRbIYLHgbSpcWZJo5pr+rr54dM2P4Z0UTJPPwHPCrLhSumQOyS
         jyy9MuTOWaP9zF4yfaHKYUuMt0wbC5CFCn2MgpzqWWU/4CHHRX7EVTuugwz+BFK2d/u/
         0E+jSIvyEhZNqb80M0GqrlptY6BMLS/okBwcc3OrHlQOsKuB1kOjEyxfj8PX7MA4PYCq
         wWgV+9B+XkMRvKWyMya1Red/yrORFeyvG9Wj9rUEia414xDI28zbEpG6/dEgNHID7oL9
         Ra5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hlQZxDdSml0xDMs0XumFP9JBpvcKv+l/SOFfHugqC8I=;
        fh=MMeMReNoLytCn+VqdW2LNqgjWNr+nrBhxOYfbZz2qDg=;
        b=TWTLnuuYySK6CZ8OQB+LsLwJoUMe57gAAaRcI/URXxJRIp+wvWcfqARRzYyUlO588v
         0sTH9/4RFaj3bxYzzcW5V8h4mEnayQo6hub3fpOh/q6WBThfNWfU/ich7KkTBNkA6/Rc
         nHLzfvd4wRvfjFeS0vJ4ZGTcb6tw0TeaKQ4SUCVHyqiDfY9qHI6rjHMe5mypxr+YFUvd
         ztDuZdRLPsgyEbZoniWAIz2k/qQ/lrAs5e0sA/9Whp0RQ7AxOEJ07H2xshv4RwjCQkoc
         LFmsrWrxMvIdZEc6MmcNh1jv5/nJ8OnvigqB6R0/GuVi3BSEQXLPSpjktqDQJhYznJ9M
         8Wug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784217570; x=1784822370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hlQZxDdSml0xDMs0XumFP9JBpvcKv+l/SOFfHugqC8I=;
        b=OoCG3A2BVBcO3PuWdc1B8h4Y9cdYJvI69VN2+o50OApcdqCT1g2FvX8x9f5XUKlkbZ
         2/d1YXIiGqnrNGlEQFFb/lk9mTK/9+0dJ6SOBo781c7A34IQIi9CXEuWo07j+aF4eGYg
         8em/Hy7dlMaaK4I73Z66tlxqTKrlGHXpdZjAwp0UKM9EVE+8xH7DNiC9duYWx/gmjphT
         LFClLVSxhrbLbdR9p/LXnEHYUcCuAqqWYWFLJPSgaZMnKrDmxTNC665Kd6hphzW5xNid
         GQeCKwxgWK12JGnwwcGDJQAKYETMcWfTrOyZ3KW2hT0x2Sw+MEDb2w4JwcHXkiobWuyj
         s3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784217570; x=1784822370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlQZxDdSml0xDMs0XumFP9JBpvcKv+l/SOFfHugqC8I=;
        b=WkOGlOWCecf8eym3SuirwyfLXPuw/Es0tVgky9gXIWuU6Zb+5NJTUWgz+Alz+69Fgk
         FCfXU2EX70S5CXWqjEvYukE1mWgyOd9ad5xNHWcE7ucWVQvShPC2FuYnu8LU4j3xUJ+O
         1/AKoOBNplu4YyH9gw3JnTv1WZw9KvCLx5NZe0wImECvthbzgaerJuMY/R/NMdrxE9rO
         J0GL1k6coLWa0YzhBr5mSuxfPEmuNOHeixibwDzRe99dXw9urmSZKB2aI/4K6Ikxt6Y0
         Df3wK2RU/VSuG/quXlTZSnWVYT9pT+SpGxTW8KLb0pCoRE9OqBeUzvLKVTe+J8aiD0sf
         Yp+w==
X-Gm-Message-State: AOJu0Yycte3MdYJqUPKRwgx6VcsTxYcqH+H+La8bT7p4BuEhaR+ck/EK
	lxYQlLoTiQsJl1q4+XXNO44Wm1VoZhCx1+f8nsu8cnjbf0eZwkCCdZaD3Kd3A+ypIenOhTqA0Kf
	T8RHOkSK9XYH40t4hKaop0HZKa+c5VkFHWdCT
X-Gm-Gg: AfdE7cnOTXfXeqbbdO04EaFBgrW0yprmxLVe86yJar8EqjJA4KEU3P6NoDq9Z73UkKP
	FWzkf9pGKCgjla0Ms+O5d9QYFGnpPJwJa9IlfLv6BpTRnOQAvRWT8MYxMxq1tdMxfMGagztMJcQ
	UjzVVagKKf/6tXKGgHKAHAtfqSkXV7EJyF5qG7mHDo4Oc9kytrQUE4UbVFqU+LTd30MZygaSzQW
	/etewMmETOYeWXm27EtreQB0AXiroUhGNWgU+WjpPj+6Zk0+NNaGmAXdUc9AgL8XVuBJn5uP4BI
	HmvukWN24FhtK7LVW76LRmjxEpYOHHA1rFL1tOjLwliAEdYwaFH3UWgGP7hYax20nm/vUvw7r8k
	rLhMebE3msIw9
X-Received: by 2002:a17:90a:d408:b0:381:2d9a:447b with SMTP id
 98e67ed59e1d1-38dc7b31c40mr16876897a91.4.1784217569550; Thu, 16 Jul 2026
 08:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716133044.672218725@linuxfoundation.org> <20260716133045.571209187@linuxfoundation.org>
In-Reply-To: <20260716133045.571209187@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jul 2026 17:59:17 +0200
X-Gm-Features: AUfX_mxLnnJrZtnA5wfceOKKnG8J4B2XqBcU0ceGtgBPWuUPMBS8hEfS_Jd8uI0
Message-ID: <CANiq72m_6Xgc5WA-xwEjYf51FjEKH-cC20zv0iEHpbHB58kRmw@mail.gmail.com>
Subject: Re: [PATCH 6.18 040/480] rust: Kbuild: set frame-pointer llvm module
 flag for CONFIG_FRAME_POINTER
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 4:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> [ - Adjusted Cc: stable@ as discussed.
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>   - Added comment with link to the PR, similar to what we did in commit
>     ac35b5580ace ("rust: arm64: set uwtable llvm module flag for
>     CONFIG_UNWIND_TABLES").
>
>     - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Ditto.

Cheers,
Miguel
