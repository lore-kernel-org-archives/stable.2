Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038D349CCD
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157127; cv=pass; b=k4WGju++8rb9RIU1nfaZKU8ibDoryUwUPW/6WKX0QW0MIEfVuPNTNtpJwX/D2knzsGIo6DTbqzpVRli1LtvvONXfm0ddelTjbu+COGtDuy7uINLeHlJjR8ULRY8wNvELCPgHCBzaBL3oy56VjWPe4VE39WOHQq8O44gHDSl2EQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157127; c=relaxed/simple;
	bh=mmm23bE6Q07svgFflgT9fYMJRhrLxVXo1n6n80A5h1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF8UhJKnWeQMoO+aO/tnzwZR8TDoMYhki/vsK2B/ZcGPk2hdcKXClsk2NS8pbej/qEOrI6e6ekPZUvivcIXghkqd7/BsY3QuhyUQJzjXMrsPm2+NWKaGI+3ZPRZ7KBPo5V/WrinX667UUTqaoPB5HG368dnnBhxVzPY4kkQnH9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afm6BC6I; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afm6BC6I"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso4184308a91.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782157125; cv=none;
        d=google.com; s=arc-20240605;
        b=Nt5F3tSOM3IC1B51Mu1JkYJqaECQqN6oXLYH8ea0esizOcQOxjovcGjzTElPq2RQB1
         czRHcpANju6Iwk26iiIAszXWD3DJDYTxm9IQJ62YKhorLjsycH+Yp6GNVUbT10W3wKrt
         OIxSWIm1mPTG7x+njk2iKjH3bRaqza7XxOIFi4/b8oYG9mnijXQiYXlGDEESzUMUXkX3
         zjiR4bu/wvHyx0WAoUwFo69VeYrcDSXcZYFZNlJ8ikAo1MH4uJg81YSaJNmNwY0Cynxc
         rM/3XYRN4Ab4caSYLYR20YwhquRs3lSYHvrbKOqrrTNyjqjcCVbIHebVDsu0Tiij1DAo
         A7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mmm23bE6Q07svgFflgT9fYMJRhrLxVXo1n6n80A5h1Q=;
        fh=IxYd6bYhtwfTLhzJvwhYPjK6HNjbryC9f7DdwJuADmk=;
        b=YowZAD9+snvnkn2yXEVJILz34stdkga6MjTkYDu8pXOVdVmNhFTHmHH3b3AZc3+I9F
         PgbrmhBJSicc5A6yqqylSzCuyyaYH/P42z6aqpVzbnd1VsoI83E1ET97bp6eTcjWSjpU
         zmAiudnvYlTWRKXMlBVjtYpqSgnNDgT6g1qf2pwP8LKqZPBTVtHlTFpalK6x3vVzkkQr
         2ScZ3/oxmY7L/9OgR2G6+6qMfwN5+adbadkDTeHEOweMdXlGQQUzuZnTrjoRXJNynS6x
         roy4HcULExtlxZwBliH7oMMV8ytH9ZpO3eJ1THBV08UtYN2jfVQV2Azg9dTdsh7TJ4Xo
         Sssg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782157125; x=1782761925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmm23bE6Q07svgFflgT9fYMJRhrLxVXo1n6n80A5h1Q=;
        b=Afm6BC6I54u72V/ypsC8yEr7BqJH+yg295tGExqvZvk0n/52wc3UH6+ZZNz7SOgCtU
         qsfwPGB0KDY2pJ9JMWKY/4BNRJl5JKhlYE5qLFgKKWberrjEGmDVchfiJ2I91hEe1Onv
         3vPLTBYN697U3lGfTxUI8ysFRj71FIAdv7KD0Qq0ku3rSXUqGkd/dVusinNqViPIEFtN
         x5MEyJy+9bT2GkMBgaYImfG9sELMinpX80xN5XkxZKXzGRKzcn3O5rnZAteeIYQ5oMts
         xi7+t0vx0r1gZx8rNSuFL0Ty6LXJi/cIfUGUW3CEjlukFpMQxQ9Is7nUfp0KUGM9xj2T
         vQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157125; x=1782761925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mmm23bE6Q07svgFflgT9fYMJRhrLxVXo1n6n80A5h1Q=;
        b=JAAu6gm0K3On60RcGyWv82tshlBCjhUZxETTBEpM4XxtE7DI6U3nS1pHuoZWIuP+dU
         qeST3lGrINXOJ40eeNQpB+4wOcGolBIrSUQqdTCOiRoVDP8oVeF3AIjNB3JCIiaxQx4y
         WpaYMEQYV1DBabGFUuX1hy9HzajwJvd4FABYThhmMyqf3uYToaRv/RPIimvHi9AEP8b1
         k5MvopaUizc7wF3QdMEz3h7JX1aMRN/OCUKhG1Oi4uxKbnrrTbXeERD16UZ7CQwd9S90
         prXopl2A8JOuGZSNLQdf5TBZZ3tWDyFMn2XhVY0nWw/gjmp+eHnPiQWSNaUmQeRxz+VI
         qwiw==
X-Forwarded-Encrypted: i=1; AHgh+RoF8LU1Pk2/m7JP3Oa3w8qq7bFiXGRtbt6RAo0c3ftukzMynLM4JnpVymcIpQDnPvz1bi6mSzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVv9yJJB3NYvVJEnPP/4n/bOEUXFRjl5WqWyzCM4ZW8KlODeV
	8/CWuS3Wjax8Wy0oLZqfiiKSrx80/EKBZQ4UMZ6daV6R+3xI07V2lg/i7BZRM56Zp4s1PXIwn6+
	arYxmP+AQ+YE6HSXNl05p90N7/3xA29EHzQ==
X-Gm-Gg: AfdE7clSxj7A/NgL5cr86dAgbjYa6x5DEJxtVuX2jpHHUgj1JiEL84kwcSloV0C0ZSp
	kmbeTe5o3WPPdfdLuZnMbzqiQEUSD2uy7WW/EvoqNRKX/0Ow9qxtIyo+RgwA3AZHdUx3JyTP1f2
	woscPNglOQ6deP4tEh9I8IKatrAJqfv42VnkZL5ohkCj8begTVNjZKXcCj3KUk+tI4Y0YQ4s3/G
	kJ++Cz60mkfhqSFNuLp+xE/sLZJXqZcFr70FY0pLBezPJ94HXOj2nkMkHXOD4I97I9GWEwL
X-Received: by 2002:a17:90b:4a12:b0:36b:3ecd:88d2 with SMTP id
 98e67ed59e1d1-37d1e82fe09mr13648393a91.3.1782157125269; Mon, 22 Jun 2026
 12:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618232149.1780219-1-tristmd@gmail.com> <CAEjxPJ40fKJbDFobsxoos0CvWqi0FfL6Sd5xkpRY=g5Ukyfnag@mail.gmail.com>
 <178215477740.1641401.9370300196381074566@gmail.com> <CAEjxPJ6zrqBR1jXWgCJs0e+7qPnonhWHXUMomDT8gbz4Rm8yXg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6zrqBR1jXWgCJs0e+7qPnonhWHXUMomDT8gbz4Rm8yXg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 15:38:34 -0400
X-Gm-Features: AVVi8Cd3qwaRPEhC0wEk6RyBv4Cj-VHTDocK-wt3iBfoRpbqTiKGawQuzctoIdw
Message-ID: <CAEjxPJ5zGiFHRXTLvPFDuB+H3MmE2zCPOCJJhcxJDXnS2gtPew@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix NULL pointer dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 22, 2026 at 2:59=E2=80=AFPM Tristan Madani <tristmd@gmail.com=
> wrote:
> >
> > On 2026/06/22 10:12, Stephen Smalley wrote:
> > > Is this sufficient, or can the sk_socket be freed under us after the
> > > assignment?
> >
> > The assignment is safe. sock_orphan() only NULLs sk->sk_socket -- the
> > struct socket is freed later in __sock_release(), after inet_release()
> > returns. That path goes through sctp_close() -> lock_sock(), which
> > serializes with the ASCONF softirq path (bh_lock_sock). So once we
> > read a non-NULL pointer into the local variable, the socket is
> > guaranteed to remain alive for the duration of the function.
> >
> > > Do different callers of this hook provide different guarantees
> > > regarding sk_socket or are they all the same?
> >
> > They differ. The setsockopt callers (bindx, connectx, set_primary,
> > sendmsg connect) run in process context with a file reference, so
> > sk_socket is guaranteed non-NULL. The ASCONF softirq path
> > (sctp_process_asconf) has no file reference and can race with socket
> > close -- that is the only caller that can hit the NULL.
>
> Thank you for clarifying. It might be good to add some or all of the
> above to the patch description and/or
> a comment in the code to make it clear going forward.

Actually, given that selinux_sctp_bind_connect() just passes the
socket to selinux_socket_bind() or selinux_socket_connect_helper() and
the first thing those functions do is to grab the sock from it, it
seems like we could just refactor helpers that directly take the
struct sock * and never have to deal with this issue at all.

Otherwise, we likely want a READ_ONCE() here as well.
