Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837356;
	b=hlThPZyo/+CeJd/G2G7wgXRnMkj6NjfHyuCENBdI2ssJvIyG8D9TjmOLq74fkGr6fBeT
	 4lKfCuVa2SF6akPsVJmNhE1AQeW3k7Zy96uugRbZddO5c05Iz0Ad5NE7Kk2PdWReNFj+y
	 nLphR1w8ZT0wA6xyiPrN0oXCXuGAY7P9QMaA/gZrXV1aXmFkwUsKPFy2CdvrYNmKE6u//
	 Xwlt3sL1h2ovdrGTZUvua2w1+W4lbDW6XImk57XZdGt78xYJriBfHMnswuIg5D7YwFU+F
	 7oUHtAZNYbYweXfKvvdjhKtFWv2NI2jTfoMme/zJ0NJYKJoTDFMGJFfFPY/px1H6u8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HB+BFMHFfjLmudpcNjOWqHhQxCGm0P7UzEzu0uzUFsw=;
	b=obO5wzS0z8mbxbRcEsPwQkesNH/quTfYBosYsiHZEpCxrW9EUUgS2mqnYW6G+zRT0gXX
	 pU9JzQ8fRTa54nxxr9RXLjYiCZfee9CLSIW1FLLvtdrnD4b+NlbWIoQAJuqLzOKYpwKoG
	 xheV70boSMSpCuogbPmobjJqoEQuatNikvxyxD/haitiU1lcaqjmyOJ6d9BLfcj0z+cHl
	 X5/Q0izTFTtLefNbgtyf266n4gfdQyPNZwcjRiwEvtWYwwmKikGPoK+VZBm55z9QN1/Dn
	 PDqy7I24DR9IbXdslMq3fdY+7wJu5FQ92Bunh8IzhW+PpNy2PqwZjQimCjqzPy405sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QXaIFH6n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3B606A332
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A3B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QXaIFH6n
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9f6a16afcso13285ad.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 16:09:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837355; cv=none;
        d=google.com; s=arc-20260327;
        b=Nqs0SRGKdRTELUkH74Oirq+THI4bhhmNnbbYPzX7kC2IrA7Fo5Rb/bMvWszo29YIf1
         GY5NrD8avwGNJPD68f4IDzrNups8c4507GGI6Fq9vsC+gtzPR9lgU6Fu0FB9jy444/Lw
         SbvPTsPAHzaveDxTRHFGYqOWhRHwpupXSeQxMxR/tkK4hQHPjIxYGSHeJWWlwXKtGwzy
         t3qu0YKAB4qdq1q0A53xK/mc24onlxR0GFXBW05lHQN4ciPvBFmynM6/k0P5AKiWQPOr
         oPVXMXyJuPQyzmYlvV6F9EOl5QS3t0vIWEIPev7utct6wGU5nQ/CR+OAym93ntFiTXaN
         JcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HB+BFMHFfjLmudpcNjOWqHhQxCGm0P7UzEzu0uzUFsw=;
        fh=riyVc7RfEG2PzVvZEZcJRM8E+oWV0l50kK+lts1Mquo=;
        b=DL2wSpU76Wd5cbYX3ZuMgGLEqphZdEG+FG5o7WhFdhIeO27vn5j0FgLVhMYG4nj4Pv
         k7ajPfB7nDeYk8yBiL5gZwTzZpUOP1atKqDC9Ru6xHBmLAS9hO8cRiwN8f+HRHjz/UdA
         UkwknKw0lTgQSSHBSU5Ux1fYV/ZOfhvOWMrk0/FJomSNCde873SLBejSM2vLcOoJkLHm
         neYliCQiDIHucYUeWE3UU9qV/PrV6QGTtvyOPvNSQCIL2QK0iBmXphCRgfl1Cl/6UPmU
         5CP3yzTveDbQW4fw8KioZzK56hL9VVp6nFLRN0cG1dsvTog+shSU9zKo6Z7vbZsMazID
         BCjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793837355; x=1794442155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HB+BFMHFfjLmudpcNjOWqHhQxCGm0P7UzEzu0uzUFsw=;
        b=QXaIFH6nvmIEpsYVHjgTv9wsJb6tDyNMc4WjxLp++EaO8Y4wKyte5afOw7KHG+4lIv
         l4znz9VzF81N7EuyqY+s4/BgMvgHQSZmi1yC34kb1lS4W5yZGnXVX1wmRO0XBLSYx2gy
         /acNcmtqotpkuHAf6vYOSQxro3wRjNZgKijJ5GAygdiELdsFI6DTL20MdwtaVDmdxAmP
         mu/uXk2dGQSy7280xtnyFGNAMlmy5Td+epcvzlusPsFo916i03FGi/u7nmHRzR804sa0
         YwoUSS2qnNUoZxeMpJIEcMk4r4/2pBYQNuiO02rAH6qluGOfa0eZ5OMItTP7TDMo07kb
         YkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837355; x=1794442155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HB+BFMHFfjLmudpcNjOWqHhQxCGm0P7UzEzu0uzUFsw=;
        b=FpB7IK+nqd3tt7ZqqmGz3hI4IMwi6puXjVGCL6WvegXlHWITROkiZbxZ+6pYGRlAOV
         3AcMC487MQXVAPl5QsLs/NAzAEwtf9ON5gnwRuuQZ2nQkAeoFGqP0HIQdAksbER2wWQ7
         dN5pLRhFiGlevLs98HaAGmlXs/bdMO24uyoqRmXzpwPA1emcUCmfVDLdum9LIaR87Z7o
         48iYrBWoXzr5/+DwXG0zk1S0knLcy3a+seQjYhDTFHVlTGU61KEo1bWCtGl/2mQmEd28
         iA6swVzZIb3Ex0RUaZjdnXRu2+4pr28RhuHME6bL4/z+uRsNhLDdklt7pQSmDUAonkK+
         rz5Q==
X-Forwarded-Encrypted: i=1; AKwUvByE593138/vTA/5eb6XUhmV3J0HVRlP2Hi1z3Rm09OcSc25FUh4bNzT7LYm3cEhzpSWxFiYRtU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CzFWEyWTENGthcWNbz7qZZOfqXtQifm9SYbOQaNOH2NeJCFfy
	MsavPgcNuBZn5q9VQh93Bal5sIt6cISuaf8PlmTIFzoPbnFKOBhpC4MYZo2ysTSkgw+8McG05Ff
	weVnKljhbAOvS0JdatxO9whU197HZIGNh3lW9ysMc
X-Gm-Gg: AYBFou0uF59eL9SLw6UxQIzBaYH/zp44AscWUAhYnfiQWiJSbJj9/E+s90gqU2pjqRJ
	asQ4BVL8vuRU0sTpnadHLZg4l/QTFkHPlqfeSQ4oa3TNwL0gaS3/syutzfIxjQIitqIuUbGhIIS
	se4ByBka5dww3a2SYnB3jU2/BFKcDmunUN6MqhfHN0vRG41J7qRe8+jmBSMyro4A7chaM/RNRoa
	38X25TJPqR/YByxw3lXoLQ0UOO7eLulEBq25uJjPmESIolMsz3HbDWSFRrU1yFj+Rz609JQJ7qr
	n8eRQtN7Hcee1eSmdIwQasqZ71k4oKbA8XkiOtuzSFP6QMaetvM/SxZIEvdeFsdhkIbUhutaHQg
	rBJVfwn9AG1YG1XLNXO4yNnXfquOQsarajPZPMAXHBhW0gLd7pEJM97AY+r2f5FR0xeTDM/2PGA
	oFHUIfxaQMQwiP/vIsby55Vg==
X-Received: by 2002:a17:902:da4d:b0:2df:96ca:d7c7 with SMTP id
 d9443c01a7336-2ed27dd6f44mr1503915ad.10.1793837354522; Wed, 04 Nov 2026
 16:09:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Nov 2026 01:08:36 +0100
X-Gm-Features: AclHuK9OZgoxGPef6pQV_HsS-hU8I1LV2S0BG0Ux9234a4e7Z7um8wA7D7hSN74
Message-ID: <CAG48ez3=6q6hqMcN-=q6qNrghHjbpXr+i-Su_s0siw25reBkWA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 44/51] proc: sysctl: resume readdir after the
 last name it returned
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 8:27=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> proc_sys_readdir() counts the entries of a directory and resumes a
> listing at the number getdents64() stopped at. The entries are sorted
> by name, so one that is registered or unregistered in between shifts
> everything behind it by one. Listing /proc/sys/net/ipv4/conf with a
> buffer that holds ".", ".." and "all" and registering a device whose
> name sorts before "all" makes the next call return "all" a second time.
> Unregistering one that sorted before the position makes it skip an
> entry instead. So a listing that takes more than one call shows a name
> twice, or not at all. Even the 64k buffer of ls needs a second call to
> find the end of the directory, so a device that comes up right then
> repeats the last entry.
>
> So remember the name of the last entry a call emitted in the file and
> resume at the first usable entry after it, like kernfs resumes after
> the node it stopped at. The entry itself can't be pinned across calls,
> unregistering waits for that. If the position was moved by a seek in
> between the listing counts from the start like before, seeking to an
> arbitrary position has never been better than that.
>
> That also takes one walk down the tree to resume instead of a walk over
> every entry in front of the position with a round trip through
> sysctl_lock for each of them.
>
> Fixes: 77b14db502cb ("[PATCH] sysctl: reimplement the sysctl proc support=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
[...]
> @@ -756,8 +834,11 @@ static int scan(struct ctl_table_header *head, const=
 struct ctl_table *table,
>         else
>                 res =3D proc_sys_fill_cache(file, ctx, head, table);
>
> -       if (res)
> +       if (res) {
>                 ctx->pos =3D *pos;
> +               sysctl_cursor_set(file, table->procname, strlen(table->pr=
ocname),
> +                                 ctx->pos);

sysctl_cursor_set() is called here, when the output buffer is too
small; but not if the proc_sys_readdir() loop ends because the end of
the table was reached and "h" is NULL?

Doesn't that mean that another getdents() after reaching end of the
file would observe the last entries again?
