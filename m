Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493286;
	b=o+ceEYbTGjOnl+h7A/TnYYbkeAhIGivrr/2q3hsxt03ZGyDwotAKx2Kz06MK2psuViFO
	 p08+BnMcNP5gMV9xqSxcFkazxR0iWkADrMVpfCJ75MIOhahLCkUjo9fV1TUpv/Yuc2Le8
	 Gu98kHZ8x66e40VvsktttSblx7mr2HBTAcDNlqybL/DE8ohtCxyQKW9C82tUwP5hHsmUq
	 lVGFbtjW2z41J3DooTy3pkRfNprRKdUxcB+LsmgnVeVb2pk0PxxEEYcVziw6l4Euwpupb
	 CJGy9zN3AKHeKq7HSkwzvNDl7kXMEVU1qU7IQQdcEpfNs7s2v0S1VhAe6LuKEacv/OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6I3hZn5IrrtMWEjXHuQurKyJm+2cM5wqnfTX9gelMt0=;
	b=alfvoLqANwC2ef37aeshHW8AHEXJk/m/bRWLJTBvQ+zhyIUJN1C75Fx/yYYMs1PuKFTe
	 /0UlRmx/7MRAd8e9VIjYtBq90jCsXkG2FCpNg3PhMDN27O6oqzjUzSv/A+LRC6I1EeGFK
	 fMOPNpzFkmqu5SyKkLWfvpzzABFEuoCWOqpJ8zgCtOZ/LgYCKmdoYfbDXQ8yP6Q4i/FL1
	 1uumZSmfdbJ7rOZHUB0MoWhYhrzT/+uVOk86Mpi/Jg2OZYrNPcdHA7ZV2dAFBLB+A0wk2
	 I1XuEo+A+nsZs5cFJzlortXKWLCGS40NdktBIjWBKz6CbcC+VmB4PW1G/RRQnWUTH2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fiGsEbWV;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163860A260F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3163860A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fiGsEbWV
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35c76e9614aso5750657eec.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792493285; x=1793098085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6I3hZn5IrrtMWEjXHuQurKyJm+2cM5wqnfTX9gelMt0=;
        b=fiGsEbWV8Q8RM6j7ZxuVSvjNOICcG6msaUt4ksLEKv+iwv6d8mxyjI+a+1OU0I2GKw
         F6luj7kc9MNOSHVKmv+62GQZAdeQzjs0durajglBeRLj++pSzmkAq961oZr4j8SXZELj
         JXdXl+6PIKVfjB48KQKvWRtyW8qHoTRIiGHSLRi5EVhek3fVAbfA/y6+onr+iY2O/bHx
         KMmmpB8oRIDXzcsu3MVc8a1X9tfsNan5xDoWsVMKchyzXgoTALcRdTArn7Q0oDFxM1fp
         glTTGMeSvFQkiHXwWmnRf74xc/RdAusZLhgtR0DICZDjNauabVu08HwZiM4jWCxGQ19J
         SS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493285; x=1793098085;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6I3hZn5IrrtMWEjXHuQurKyJm+2cM5wqnfTX9gelMt0=;
        b=AtqMD80/GckneXL6vDRlEA9Pxf8buyKj0fEvAC0BH6raR/qoDsfbP4h7BgtcYF/Ff7
         HZT8ZcjDgzzqzzCILbCjexO0OZlOfpaa1QsGL07Hr+nqQ8xqBw8JCZmU1DAPaOOpIn5u
         MtVUGtG+a7D9jwdHQqqOkJu2w/4gDdjvPj+f75ACp9jIIbdAI/onUCdGA3gqpXzTVN0x
         LERz0sKK3RnYd9QD4LQrGsqhwDtAIoo+6N7L+hbGFTXJ1pOXE5lhkBv4+Oe87yd0V0HL
         onR0Yp20vA+WPORg5UfofZC7cSj3tb1ZhL3XbfqGJK8W1W0GnWTLKj0ugiavNm9ObVqo
         7A6w==
X-Forwarded-Encrypted: i=1; AKwUvBzIFasM10AqKbFjPDk9rHMdJv+Em7Vytm3V+Wtc6ln6WBmD9gaCzJPRUiLqBdZCMeMh18QQ7B4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpiVNZV0UlS5jcwZkiDB9AUyYdZuy4z5aCmP+uoIZ6NKno0pL4
	ob2AKhj54jk8umLE3TlWlYgZJRnUGSTYHuFpEPOr2jIFenQcbvLqakYH
X-Gm-Gg: AYBFou0VdSTepNbRUaYBV2pCDqDlvoLGFJMf3PiMItpuCGSFPbwShsAo1iSHeNaoTfX
	UkDgmBX502QxmfGQNIrCFz5PGvodXynvI3/t6gtrapb2ZqsXdIA0sXqC5wcMu6bVzYJ3f8/d7n2
	hXSiw0O0M6R0l/3WINo4TZIhhhmy3Ks0zyvyAYnZnHiBhvJt1fa4okpOkeWnM4jh0dkJ1OCMpdn
	CE+5PQ8C7HfbNBG7ELYRjjbnN+MwWpOkTJOtMG87xTqcMDChqgWAJL8Xnbuh7JjhIwJ/rIoHKsX
	k7FbO+cb/an+8ci7chrButvXzn42r0WCRo87DY2LyfuoUlYCGyQDUDfe12WzYPhmgVA0Brf5JoV
	CDQO4rRFOiq8O/winYn2ijoBUyd2phb8WahVe0Hqj5escqDpy19nx0q4kivgZrvbRYTt2LbZ/wq
	4lbxxHkKwAwjUE22Wl3niIprxBnsXljDHvMIffIUuhHWaSFBHRyiVK5fm39QGrOQEIH4S5QC3pS
	9pwGzpP2JkrBcQnmoMOyZqbrWOWlRPfTFhSzBuySkotVzIDhw+gCAc+fIUhLSg8h5d/BAI8qhh5
	7OPYMeU=
X-Received: by 2002:a05:7301:4305:b0:35f:227b:f8bc with SMTP id 5a478bee46e88-361a1465355mr13074342eec.11.1792493285129;
        Tue, 20 Oct 2026 03:48:05 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm39596320eec.14.2026.10.20.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:48:04 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Tue, 20 Oct 2026 07:47:53 -0300
Message-ID: <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atcrpTI_R4kRM8pb@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <atcrpTI_R4kRM8pb@ashevche-desk.local>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On Tue, 20 Oct 2026, Andy Shevchenko wrote:

> > +		/* Keep a hook the driver has already installed */
> > +		if (!p->set_divisor)
> > +			p->set_divisor = dw8250_set_divisor;
>
> On top of my previous reply, why is this hunk needed?

dw8250_probe() installs the BUSY-safe dw8250_set_divisor() before
dw8250_setup_port() runs. Without the !p->set_divisor check, detecting
DLF replaces it with the dwlib setter, which is the BUSY problem
described in the commit message.

> In the case of existing _set_divisor, do we want to keep the possible set
> _get_divisor as well? Shouldn't we introduce a respective _get_divisor in
> 8250_dw.c?

8250_dw.c doesn't install a get_divisor, so there's no existing getter
to preserve. The dwlib getter is still needed when DLF is present,
because it computes the fractional part used by the preserved BUSY-safe
setter.

> But now I see that we have same function name in two files. Can we rename
> those in dwlib to, for example,
> dw8250_get_divisor --> dw8250_get_dfl_divisor
> dw8250_set_divisor --> dw8250_set_dfl_divisor

I'll also clean up the naming in v3: dw8250_update_dlf() with a frac
parameter, static inline after dw8250_writel_ext(), and the dwlib-local
helpers renamed to dw8250_get_dlf_divisor() and
dw8250_set_dlf_divisor().

Thanks,
Vinicius
