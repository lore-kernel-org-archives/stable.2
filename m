Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96637DAA2
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765513; cv=pass; b=EXUIhilVii1ljjpZ6P6hkKXtgYgZK7kE2VKrpXUOUmCYUlmkhBykjxFIf4Buwq2XnuXNkpD3SW/5f9Jx+bt+K2eg0kwTXEX0dCQ+iwB5MaZZDW3eInVoQykyZXbEaVoUaADAvt3Hb3bw00Y0XOiMjFsOqbKtX8xItQzsry4tm+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765513; c=relaxed/simple;
	bh=xvQlLrP9VZeFA4X51ntM8S07ewhUqvCn5cruzlZ0VS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbha6RN/Zwnp8baItubtfnaCPVl0njiIxrAQT5dV7pTVza7ArqY4fhir2CpPwS0ZYDtWmLT0+vEHiOouIAc+ygZgKvFotgYoq3kjrGN3nozAvfDu8GEMfdTyQC+RH43bXr+fcMucY3FI37kzbKCSkeemgOEG2rIAQ5y4B6KAEd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b68vdhGZ; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b68vdhGZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52e1f9da948so6357881cf.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 10:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765497; cv=none;
        d=google.com; s=arc-20260327;
        b=oHLUqZpbvVcAbsLE3M1h47Bcx0T3qYEabm1dIkoyc9g0gGRuRVDTQLX7QYTlbVTyqL
         3JUCsY7HR3UHjB8/9KjlnRzeYU3Gu8FF3KIz5NwH/Xob9YiMh1vPT+Tt0E89Lsk7ynEJ
         RtC+uucfZNNYJrJLC5eZdlgGbFhHpSnAkplSL9iEFrUO9mFRKW9dwpfK31KAEHiLSFw4
         effOqX0syMzceYHGVBA86Jb50L2bEExCCK0YEvwIBeIfDxhJL7Fmt12Ld3VqH5q5doBf
         mm20l8BesFjsc7HesDIyebMOuHkDSzUP9fz0uQu58TI+3VdeHerSzHDn9yvkWm7Givl2
         cv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        fh=4HXVuASJP0Wu26DFFIB1TBk9VhUlGjBtiKW7ol0k5uM=;
        b=OAu4ZVq8pqQlCb4UNccAlXFWd4aVdF1cc9i7HKVsUhprNoWUhZa3Dty75nbZUaQxqX
         5GwGYsN2guJ/UKtXkUFPhADWaj9KfnRnh+LCW7BAQ1Bk6Lq3HTCcVL24UAe6F75sDM1J
         1H4y5ynL+5uduw9DlmIIWCqy0G8Ot2moa7kH6MiyLY+yI9m2i9u8Ciigv3tSvO/qkdLD
         HHoFFNlW7uF1XJlx6UcrnC/jwscEPELd8m0eTIkiBbYflaHotMit+BCnJAQg8T+DEoUl
         qk/AQHn0zDDv8c853KuJJQILj5yEmphfARZ4szj6EmcudTaC+Dp0Dri8OMT+nSY5RTPa
         LiXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765497; x=1788370297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        b=b68vdhGZgBqiRqH+9o7YVSMh8DtrwpzcwpovG91VcybnYoOwQrpqPiS91LIp0YEKwb
         JB57gPOmCxXA5wrW4ACQdxIk6cgiMRKRxK/BPeb9Z0OzjVEaKZpjJyLytaHkIDNYhjea
         niHSz1iquDjz1vdhnwlE4SM6P9G0YgnvyxWKY0rUvBru4LsvJ5jXLi7D8T2eJnV7ri73
         aM3b/1FWKTekqo+3gmXuc/Cw7xHEfT4ErGKqYqg+lPMyb7pIf7MMWgwA8Mxwr4d2rYPD
         uAsqhht7lAx9tqCUHEGdI4/cgGjoP9Q2Ah/D80KxM6g3wXN4Qaqh6WQR3ujaxU+AS50A
         IaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765497; x=1788370297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKiJ8YX/Dhk5jdEkQwRVwdmfmTXscc4IZXpiaOIYJVc=;
        b=ih3UtiqafoyesCnQjC2/QIDdvhi6xXwqkXD0Sier5K/rvqNkFr4J9FFlhEM8qaM0r6
         0nc86bZp5700+VP4Wi+rrWU/9GScs43B6c0+hDU1A+MuMZeNeKs5Z/krRMVPn4AXMtKK
         AHtInyMjVQTMvgL2+T54Y0D7FAfhMhVtr1LENZqow7jHKhwlFmNbfU/AImypOJSHtcv8
         n319k6H8/6b2QlPatE89BmDzOBssvnFaXvrl+OZ361kOFxyuocztP6QRLjWxrLQhCh0G
         YyQ2NEaWtkY7xJQYneA+KMeesVOABQH8BYHPjvEl9PzaPR/0IH3zEF0/QLTwgfvJ0L5X
         lDzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFUL4hbsLOenAAf2n3GWF1I3D9bRPaR+T0+JL7cp/PnWDLPYnmA5YPQ7PMSaun/g2s2cPNnCM=@vger.kernel.org
X-Gm-Message-State: AFuF++nqw4ih9qNlP9im8aKcrIr1yxJc7JCdRBUwRVAKtXVL3j082q0m
	JTr+R9jMixdKdzDx0R07AHileY8j085EP4pkKdUiJVEPDbxe/6aZyPQvmjvNaMjEl4R6xRF5ghy
	lKaaXbIJCv8f5KeLhnAhrWr0Et4CoKIdZH3YJ3iXv
X-Gm-Gg: AR+sD12J9HI5BnZhO7e/rfHdHWobWUMdQlUyaeeX6c+Ac37sdNa8GIQ9YOrRI54xipy
	NSycE1Hlw0Dx5H31g0eFDBsACZ/yblsUGXCSgYo0gtgWGk4i2lVwiNTzSs2E1hj1IOiBi1Y3z9Z
	ztYcMnsYSagGAW6OUanM65iQHC1TvITxg8ar96FEU45zoARM/qnW00K+lW4xgE380r5zj2uaPma
	EUUPUMuvL/IRt5ptFQLBy9sJreooWydb0SODA5JmSYZjYnJBVzsHEDfcUI1Epc5E4/SpvxN+DhC
	MnyQBpDbjCTbr6Z6plmcRMZ6zM1Pf1hju0q9100M+d52nPP15sEA+fpfmA3x6bN79q0pniIKf1K
	Shtc6aYN7sqSIgdwTEXvk69CL4aQ/90xfzlFiCZ3I8IYB/9shHgA56FqlZJg=
X-Received: by 2002:a05:620a:2584:b0:934:9639:3a4 with SMTP id
 af79cd13be357-93780439e3fmr788607485a.41.1787765495949; Wed, 26 Aug 2026
 10:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826171344.4133-1-blbllhy@gmail.com> <20260826171344.4133-3-blbllhy@gmail.com>
In-Reply-To: <20260826171344.4133-3-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 19:31:24 +0200
X-Gm-Features: AcwNN1W2Vlibp4Upi6ckUE2YnF-7NI1e62marZLJ6U_CKljSBV7tC__IgHY39vw
Message-ID: <CANn89iK9NyWmpuE8QM5W_t3MK30GZf_Wgbr+JsUVARnXZBgN6Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com, 
	andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:14=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
> get_info function pointer without rcu_read_lock(). With BPF struct_ops
> congestion control, ca_ops can point to dynamically allocated memory
> that is freed concurrently, resulting in a use-after-free when the
> kernel dereferences or calls through the stale pointer.
>
>   BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
>   Read of size 8 at addr ffff888013701258 by task exploit/149
>    do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by wrapping the ca_ops load and get_info call within
> rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
> the icsk_ca_ops pointer.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
