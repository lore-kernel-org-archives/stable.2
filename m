Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D196346FA7
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154783; cv=none; b=PwewTewEMjjsCj8/pyyz+I0RQOeEZaLH3xLs2Y7rRaXHbuLAxEYx1HC3Jh/5XN0KrDkcOjnz0k7OMQ0Ws6uKaVRSS/fG7/oeSGLbgBxH4hgxE3SUOD/RHATsn4K7S4Wpze7B4c4YE9z53etQDI6zZXjkKbCHhFVGvfym7z6MpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154783; c=relaxed/simple;
	bh=gPDvbjY4yqlX02GxThsdZXOqsHN6+5dT1OAzP9r96A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRIIljka0PHElRmhxIFuPSsxiS60EMNTBJFFCA2LSDG21A61scPGYYPnVdqBNXDxFpMqsDWWkJzbZJxlZ7aKJsAiRk3mUbeuui8+5gqATccCbA8XvIwqe/l7LL4I3B8oedzmllPyfwUZXVbmVxUKHhoEkbo4yRFeddZRBfSun6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCfS+Z2U; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCfS+Z2U"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so1360585e9.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782154780; x=1782759580; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPDvbjY4yqlX02GxThsdZXOqsHN6+5dT1OAzP9r96A0=;
        b=fCfS+Z2UwrFokyxqp7xJKMr/bUqkQXIetCKA8fjS1/+hggXOy83qHuZQOdYDUraI8Y
         XrclIepiSfIHIa0lZHYZoKTGZSUhlXfE6x7bCDiNcRe8EiJoOqzSZE0SRPh+SxjzV2/S
         UHGvG3fTgmJYriXiIxgLxSF1nmUDbovMUzjBRV7am2Gwt91Sc+DSPiEj1WjNHxdUVckI
         i1sgaTVtz+5GvM1LnVJirGs736KN6SxBHYXGvFlSNBD2vyNl7lflNdTc0Al9O4ykNBsT
         pUzpO1nAN+pxu1my2F5H21zxjd2QIMDkC6FvRGeXfH6IZNi9f6Jsg2ymUZCTijtEJOdn
         hZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154780; x=1782759580;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gPDvbjY4yqlX02GxThsdZXOqsHN6+5dT1OAzP9r96A0=;
        b=J5qKKA4xokBxmL1JzlGaIg/l9Rub19mmqPBqEjwZ+uw3vTN/fRYFF7fuCGyTVnf3bG
         soL+A+IoMxM8aTduQyh/45eLYHqZ0Shq0BCJw0tVRuTuE6qSjqwY+h/I3CQIYDZH5wyu
         yNCCt7VUjx+kdN1/n1KsIzTPNHgfNP8AHynn9vCEH2/XU5X9k12r3YHNA+4ANIOc3feo
         de7ZSZsvMc4ZbuvYR0LHvVhde6Ib5fro0bp9AZ/7Cn8dM9dJpaPVpNIF7m/4m42z8Zf8
         X8VscrXFggoXDT1kyG6igP+N8elXQJnHqJE7wNr6sgKKmZcDe+r5yenWQKuMAKgj33ff
         PchQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Wp71RJSW1fIgPCknQgUNX7jYN3iYKE8hIAWrh/sl+FCERmG8FA8c6nxKckVLVMn55P7G3Ktc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNSQTJuOarsyrZrlrR1HxvqXOcO/83LUp+8MMwJoARGpMyob/
	+QGCUxpg67/BUR9TO2WfmcuXyP6GOQ0TCAd+do0ik9eVUf2ZXvlQxmmkIrC+MLY=
X-Gm-Gg: AfdE7ckLET8Fc0Dkk6qGbqjU+CJu2/ioB+MyV7KH56AcjUaYZRLJpjOPXnOra55v+3M
	DbN4AmJRAh7EhIfzRWby6y338Q90cOcWzq2GGaqIuzc8wx1B6S8FKQwSldmRweVNtmkJfBXqGn4
	QpCkjFYgbVmUW+AvmI45uJGZQJFaFSC+6CphtGErND4xaD2oi/28MS76lL4T+PcqmIOOyeGLnVB
	ODuUDHRxdTTc/yMCnobteswArc+C1on9OJNtSK6+u0U3gerPinO55GqE1SXMkS9R0feIIS6crUN
	77Y1OVxZF30/PX18Jy9P4GrBX2mSvKUyZm+ttbTecvZyAu3lQmnsuovMBM7zMJdLmpzz9rpYnNb
	TfzkQp3+fdMdCujVRBJLiLOXB/glVAbK3gopjaSTyORKQYGHxwRakGnCusIjtsiNUhz5W92lyAW
	EAuBzYf5XYGqGOfqm2Uc3FbQ9v/5Y=
X-Received: by 2002:a05:600c:6285:b0:492:4a1a:a96a with SMTP id 5b1f17b1804b1-4925a0b587fmr10548515e9.11.1782154780210;
        Mon, 22 Jun 2026 11:59:40 -0700 (PDT)
Received: from kali (88-170-213-78.subs.proxad.net. [88.170.213.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm355121775e9.5.2026.06.22.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:59:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] selinux: fix NULL pointer dereference in
 selinux_sctp_bind_connect()
Date: Mon, 22 Jun 2026 18:59:37 -0000
Message-ID: <178215477740.1641401.9370300196381074566@gmail.com>
In-Reply-To:
 <CAEjxPJ40fKJbDFobsxoos0CvWqi0FfL6Sd5xkpRY=g5Ukyfnag@mail.gmail.com>
References: <20260618232149.1780219-1-tristmd@gmail.com>
 <CAEjxPJ40fKJbDFobsxoos0CvWqi0FfL6Sd5xkpRY=g5Ukyfnag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2026/06/22 10:12, Stephen Smalley wrote:
> Is this sufficient, or can the sk_socket be freed under us after the
> assignment?

The assignment is safe. sock_orphan() only NULLs sk->sk_socket -- the
struct socket is freed later in __sock_release(), after inet_release()
returns. That path goes through sctp_close() -> lock_sock(), which
serializes with the ASCONF softirq path (bh_lock_sock). So once we
read a non-NULL pointer into the local variable, the socket is
guaranteed to remain alive for the duration of the function.

> Do different callers of this hook provide different guarantees
> regarding sk_socket or are they all the same?

They differ. The setsockopt callers (bindx, connectx, set_primary,
sendmsg connect) run in process context with a file reference, so
sk_socket is guaranteed non-NULL. The ASCONF softirq path
(sctp_process_asconf) has no file reference and can race with socket
close -- that is the only caller that can hit the NULL.

Tristan
