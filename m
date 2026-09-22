Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE334EE85B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120564; cv=none; b=KZnT+CEgro+6zwPUJ19gjSUCA6/e3B3+VhNg0mAwPJyZDiPjsdmI57DAOkS7Hl8nh1L5NAl5nzrxK/zTP+lCr1L/cgSRQvHdqp0u2aMaKYzvgWTaVVlWK/JcKr3DFEraDtFRY3tWfY4LPGkxARX0mqmjDcF8tDUpBeFanCU/T1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120564; c=relaxed/simple;
	bh=Tm5Q1x/A1C9qLPGuuJEixa/lYRMV/+fSTph2SixjdSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q80RSV4FBDD2RVIv751NVXyrA2+MEAL94Zg4pDA10QF4ThDzcKuJj9HGb0lFIZu83ecZXsyDzdwFrWleM2GGOu1OWJ5oupXBzPDg3x+CpIDkq98VF8+5DJEwDHJnPId/f4bWMjg2NinubwDKc47iORrB6jyYP5T9/VuPv1nDflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nUJazm6F; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nUJazm6F"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so41598266b.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790120554; x=1790725354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6QEQxoavMoQIndMMFiVqJDQ1ivheIExybb74B+VtDiU=;
        b=nUJazm6F17ssn9doIlAiR6ItVQHdioeVXvDt1azF2ucNq/m7i4Xpt0enBIQOoxpeSi
         q+VP5d5VavHoiL3PIVWLE6URltbvi6HjQdvR+Yv8zNKhj1PvcxKUKRYjiNigYbggQDv8
         6pGvhgwKJUA0S98hEo7RoqB8N+TeN/z63a6Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790120554; x=1790725354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QEQxoavMoQIndMMFiVqJDQ1ivheIExybb74B+VtDiU=;
        b=WOx82jJYsQmBU/8eM7RKY1V9xIeexSKhQYiRNug1/wJMkg5g9tBJtWm+0CHW7yLLtR
         FnmwcOa3Ye6cOhn3jV5HXIeaBsinQsqnsMcYaTAbwlDUAECEG2ioOAN0b4UQqmQOZPck
         jVnw3OI2w0V7cijZjjCYLxgDBfaVKwEiBVddpjxdQ+vZ1hkibeh9H0Oii4F7TOkwQm/d
         hboEi9mZbXd5gzJEJDA5x4XeHznhcyU6ea73ins2oBU2n0dlqY8yVq4ul9BjeftBUcOj
         nSBMqQu21uaaddYlF6UlWOwsGeUwZpQDea1INdS5+031Nd9JcFTbEOHHGndQa4Ml+8AF
         y+mw==
X-Forwarded-Encrypted: i=1; AKwUvBzJnsAkJ3Zz8ASLo0hRwU1d3X7ywxSVpFK3Zi/TUh9uR23QR1s1lSVHUyK/ghgKB9eD4LwL8V8=@vger.kernel.org
X-Gm-Message-State: AFuF++lAW7uB2xg9hViams0w+8CzV4ntJfnBvUoI2pcgMbXVAwuAweDv
	XsbVQ/4nS4Ib9Xc20XIKRA9S/QjXw3NAJkq3cJhCjZTFeQ10kw8XkBh8y7j97v54bHRG3hgYhIa
	6f6ldYQ==
X-Gm-Gg: AYBFou3xhjdkd/A18ofLa3qixLURg2tvkO0EvO9y3W1wnSTIQlNE7A8C6tUwaMQA39M
	g/mBv0UvH/m+d2XbvU/mxGVJK3nDSUK0w5cWxtVJtCuHFei1Hhiq3ZFfWdx0JnT1oSIL7+JnAMV
	Lqv+flpAxZuEATyVT6f6QCVNrepBnGnU7wau7HrFha9fJR0Eeaxi3eQFPqUNt9D7x40o4LPZ5LY
	zhuhfK2WGxFXE45czz6/iXuRKDK5eonBDSOEnf8+v1s0Lgma13PFJL2gQwjqj0RJmGXJchJCO4W
	OOTBr4WPYnL0dplo/WFPllz1/TP9EnAg8hm6cWY2pAO/lnXOLU4hO329jq5uNlq250UCHnIPHbz
	BVI1OwWxYScZ4iC++/zAKBAzWiVmW/MpQj7Ug4UNkdkdVcl/pF5cQNM65O040nNU+5IKEpgsLbj
	TLWhe+PKDq0IGBa5jLjRQyx5CgMNNqqIFO2kxKvFntTIO38FNvJNhHxieILnssYN8EI130ep4Gu
	a8GSLINmHSFcNDW270A+SOegQa6Jdz+ARrAzw==
X-Received: by 2002:a17:906:6a1f:b0:c2a:8b27:325c with SMTP id a640c23a62f3a-c2aae2d019cmr57335166b.24.1790120553814;
        Tue, 22 Sep 2026 16:42:33 -0700 (PDT)
Received: from mail-wr2-f30.google.com (mail-wr2-f30.google.com. [74.125.225.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae658569sm25836366b.37.2026.09.22.16.42.31
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 16:42:32 -0700 (PDT)
Received: by mail-wr2-f30.google.com with SMTP id ffacd0b85a97d-48439feca17so359842f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:42:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxsbkzIAEAefBJLrD1HAUxLq0u/LuGRR+v9q1NT06km2GkyMXc/AwniSeLusdFa9k+jwFMu5zY=@vger.kernel.org
X-Received: by 2002:a5d:6f06:0:b0:487:ff2:12f4 with SMTP id
 ffacd0b85a97d-48867095bc9mr1161089f8f.40.1790120551055; Tue, 22 Sep 2026
 16:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922154907.90535-1-fangxy@xiaopeng.com>
In-Reply-To: <20260922154907.90535-1-fangxy@xiaopeng.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Sep 2026 16:42:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UDqPUAWw+h-t4Jkno0Sy0_2T8xfXZgfjsVMM1fTG3JkA@mail.gmail.com>
X-Gm-Features: AclHuK-NWZIE87V6rWLLln_WhNGGFfao7sLjyvoRWdgPG1M9Jc2x8BXnX1LZRPc
Message-ID: <CAD=FV=UDqPUAWw+h-t4Jkno0Sy0_2T8xfXZgfjsVMM1fTG3JkA@mail.gmail.com>
Subject: Re: [PATCH v2] kgdb: Fix buffer overflow in the 'M' and 'X' packet handlers
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: jason.wessel@windriver.com, danielt@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 22, 2026 at 8:49=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> write_mem_msg() passes the length claimed by an 'M' or 'X' packet directl=
y
> to kgdb_hex2mem() or kgdb_ebin2mem(). A malformed packet can claim more
> data than was actually received, causing the decoders to read past
> remcom_in_buffer.
>
> Record the received payload length in get_packet() and use it to bound
> the decoders. 'M' carries two hex characters per byte, while 'X' carries
> one byte per output byte except that a 0x7d escape consumes an additional
> input byte. Pass the packet end to kgdb_ebin2mem() so both reads are
> checked against the received data.
>
> Keep zero-length 'X' packets valid, as GDB uses them to probe binary
> download support.

My analysis shows that the above isn't true and that zero-length 'X'
packets are no longer valid with your patch. I haven't tested this
myself, though. Yell if I got it wrong.


> @@ -43,6 +43,8 @@
>  /* Our I/O buffers. */
>  static char                    remcom_in_buffer[BUFMAX];
>  static char                    remcom_out_buffer[BUFMAX];
> +/* Payload bytes get_packet() stored in remcom_in_buffer, excluding the =
NUL. */
> +static int                     remcom_in_len;

I don't love making this a global. Can we just pass it down? ...and
maybe for functions where you pass the length you also pass
"remcom_in_buffer" as a parameter and stop accessing the global?

-Doug
