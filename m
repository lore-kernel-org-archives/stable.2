Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69048DDA9
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173328; cv=none; b=SEMyaCaSvsGWxbGzpHynA050hit0L+Tggl10eYFjz76C9QrU0oaA230pOXgucgrKUarwwthGhIBycYL4LcwN2YAXnxp6T/qd0V61pAr/nCx7/A6NUS5C5NxkPf1NN8D5lsU7JZyFycG39wyRRdjqRWZl8ICpJfOtAxGpJgilFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173328; c=relaxed/simple;
	bh=icuTFQPXGAsYRe0MUVQcIakHaKWLZBH+fggtc0IRHCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFxe1fwjjhDuYDtvGuOwVDRlyTErmgU32/4fmaR1/cxZ215zx6SPUfDQmkMqLBpu2glivHJgIiSpSTTWTiKkujOYtUWJHaFYdEaQ/gZC3B2uFi/rvCvZ/Ig4w7dsS9glAzUMVQWblXqithsEF4nt0KEawQNUKJ6DsRZRApI78dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/cLEmTM; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/cLEmTM"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139a5f4ca15so3664124c88.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782173327; x=1782778127; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=icuTFQPXGAsYRe0MUVQcIakHaKWLZBH+fggtc0IRHCw=;
        b=C/cLEmTMsM1JTmbGA4eDqKl5Jge8eXjVq8l1UmqzN1eMzw93DGlJWiCOo68x60FIho
         CN6lxWFu/BZSL/0KhhG97Uh8r5QSPdY2f0k1sguTU2L+WRHVRIL6yUVJC0hJZu06rqEW
         AvuZti1c+Pyj+svxCuUol5Joe1zWrmlKJtLwGP25YFkMDnr4thMMq6rQ8SqriECDO7bO
         vSukCt0HokW8A+YYsGocol8P3zI7CwkvSYK318gTdYVS+BNkYPg4kBXnhix+gPH6t5jQ
         sEvLC5DuJIqZB8GTdYk6ccwiIYDJryvnvy/+V9U8pcHeWME7fnbXY73lcX5eqIxhOXJQ
         jHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782173327; x=1782778127;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icuTFQPXGAsYRe0MUVQcIakHaKWLZBH+fggtc0IRHCw=;
        b=e4gCkUUEtFnNpV5F4NXQn6OFQVZliQY03tBhhnDgvojobdTPtwy/0R8BeFLIgYbCX/
         QO6CQTG8XMRzuIEXBMI5B/IR0EUsJcRiCn0NcLlsYG8ALeJCwI5uIJEp2Ey0MnIz/KTS
         13tDwFzrDkpsiaEpx35YKdEdyPcnlux5LUk/kxLP/FHrywLJFj6jJdDxGHgQZLE2ALiG
         3KIhlPbSm8L8e3RMzdIg102yyN+53F2+qocDtLfOkMjxkpcG5DdHSmo4zYgeotTXoj8b
         axE6M2INQclnPpwdQs2FACqt1H2KiI8QVlJJnx9nsBx0VoeN+zmo20yhyvm9VDdONCVD
         aYQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fqeDsT2QKL7G/6Rm6jnm+zNU68HvxJzdJngr0b3uPODjQecUvmMcJRbARRh2yswhQd8V252I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/Eun96016ke2nm0whiW0xbnrVQVJqbMtRWAjSNdErBGhUN7y
	qnnSgkJAfnuyhAWairoJSw73eDPjoGlObTHsSRgnH4BCQFqxetu2KbUk
X-Gm-Gg: AfdE7cnrv8bouvCEXhR3D4oSINcfmm7pRQAy7xI7fdeLg3PvdauqUHXM88+3oZiXQfd
	hcpEwgzJfwQsUB4jPbsudQmev6ylw00rGatENf6cEfd/DfXQXwb2Sn+67S7x4vI2q2sX57sXtrB
	n2j0kdI7fqjrw4+yYCab0WILWxGIWCsfx93a4sBssarllHp5cRwfbxZZcdM+NNoiKsMDDkw+fSD
	W13l447AqjfW6q0vNUD0r+I+jBrVM3K6nk3mYLQlTQL7wNH8LXaMmAshMKTR2KxohwwvHIcen1h
	50UJ3xDmSVa/9uK6iNx3d3vBwuA1BC8aymzrIjjzPlwh0uiLyPmIs3qfygQ4WHiSjoXhxGpOf0R
	Jmd3JT/MZzWkmg6UmH0jZP2nywW+fmTIzvEvPsxS37OQi/mvgv+HXG0msoU4WyCPBqqe81B14aR
	KUFhyOuyrgyuW6k+pOnH3u6G0hkproEg5XJeoK217N+1mNeANieFmAbYoUWwcpfV8epO8mBjtui
	4qxXDvC
X-Received: by 2002:a05:701b:4592:b0:139:c4e3:9496 with SMTP id a92af1059eb24-139c4e398bfmr436341c88.13.1782173326499;
        Mon, 22 Jun 2026 17:08:46 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c4f4:7a34:78e2:a600? ([2620:10d:c090:500::2:e8d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be5c5desm12569328eec.28.2026.06.22.17.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:08:45 -0700 (PDT)
Message-ID: <6c8cb4e03a3c626b0e37c7e4d95ea111e4116e4d.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test for stale bounds on
 LSM retval context load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tristan Madani <tristmd@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Xu Kuohai <xukuohai@huawei.com>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org, 	stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Mon, 22 Jun 2026 17:08:44 -0700
In-Reply-To: <20260622230123.3695446-3-tristmd@gmail.com>
References: <20260622230123.3695446-1-tristmd@gmail.com>
	 <20260622230123.3695446-3-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 23:01 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> Add a verifier test that catches the stale-bounds issue fixed in the
> previous patch. The test sets r6 =3D 0 to create known bounds, then loads
> the LSM hook return value into r6 from the context. Without the fix,
> the verifier intersects the retval range with the stale bounds and
> incorrectly narrows r6 to a single value, pruning the fall-through
> branch as dead code and missing the div-by-zero.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
