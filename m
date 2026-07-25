Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB32D23A6
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785006257; cv=pass; b=oftF9F0Pzi1scDJWIu6kOCKX9zy0yRJ7IPXXk0iWS4HmJrJiqZq2i6kP0BOYmuhTuTDtG/jrFQ0JMqXbmut9LTfc8M4D1fWh7iS4lfhtZU0+zNvO3KaSFLkxzF/v0NO6JoEe4FRxG/VjMFAh3KBPYZNhZhEJRNF6G3ffIP4+T4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785006257; c=relaxed/simple;
	bh=0QbV69kmg9DsMNMBVld/5Gpugq8FwkJ+JSjN3cbkwy8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlpwfDD/qaZt0gPlaXXX30N3nktLhvi38SZE6M3t4ZLbc0liEAMz3FZIekGzlLT/F+9AbPbeBMmcv9Yw17fm6/vCVf/rnrk7JLKJIS1GHSZ3vQpAuTAqPz3+D6xl2WilYXljaNcgx7yD86EpPAzcKeNAlrrdlXZ1UCM/XGzuyQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Q8gjHBks; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Q8gjHBks"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso16613135ad.1
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 12:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785006255; cv=none;
        d=google.com; s=arc-20260327;
        b=VudgN6byzYvTVI20tgNYt3Ml3v6qT1mCkJUgMjprgYm5RBFtY4/iCAuJid/STVwXpZ
         P5qK2AeWtCOpR+5aszRFWHzAIuDv5iWrkCde270BuUZbDot/FXHI5EWV5BRDdPINMMPZ
         L5yJY95xGZMj+DzZ6xcPPGBDcJU+cy9Th4tWqbPe3809EVvQQJc0xC3IGOFpTB4jvgCu
         yNqCI9Tw3eMAgLIofN3zAkUKK6N7+kvIPxlNU9tfa4mWtH8JmZxfQDs9OoYKBF6iigHi
         FL60nX0ScYVotOFc8loIGNJsFzGNwk4fFdhlm2JAcB9ERhdFUyVal2F0XJETWR7sSpW1
         fKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=0QbV69kmg9DsMNMBVld/5Gpugq8FwkJ+JSjN3cbkwy8=;
        fh=KkIbniaelheAF8D7TCIrjml959qDFyfsChiZQdZiIoQ=;
        b=dJONSXDnsxKSZgkqBUDHxowpC7hXJjspcdQQz0bVzg3XChpMONwqYagfJvvOQslJE5
         MFyIeg3Tt0WcXQzUgqSvbEo4SpJnN7SmZtWv5IvmoTsT4+bOUvVjooHHdoeKZG4raIQg
         /JTma3yJd9Juf0GUqksZFLv7LN2MEqCy0sXql8hF1o7hlLOWgDSx/zR+5UlFe5vn6zCJ
         sGv/rxay6jXhBngu9xvUxbaEpf07MF+pF+86WBfC9GpKcaGrRZwTsqjqTdYXQi5ObS6Y
         kpC5eWf8jm0XR1SIc6CLzObUt/uoDHa9J2+iu0ks1Y8xUn5noLB/7gr/76n/AyEdL09W
         J6iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785006255; x=1785611055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0QbV69kmg9DsMNMBVld/5Gpugq8FwkJ+JSjN3cbkwy8=;
        b=Q8gjHBksorpKiaN7Zd13V0//oyFYmYMiW2PmrC/pWW6GLnr0iwb8FxjkIMqyTL0r07
         pjGB0EieUSeTwVz4TD7QnR7+vk9LGlzwHDUaQ6nOwVWU1El9CO//uf61Ke4JbBLf4ikX
         CorNCtkbqKKRa7VDIpIDGdAteZ3rXfhAwGydVK9k6SoEw4JRd570LnjGZVe5H3f5N7pb
         JwNwHG3OBP2uerIE/8WgNKKDkfzdQEIAwl/lpn+Ualq1CWAIuOkBTLjNxBVDTIWwNp3x
         d1dxcLOSthmpnvNgPijmzdWKA1sD7oOVTD8tdUu2rn7qds47dcwJ8xH93315Q18WLBaX
         UxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785006255; x=1785611055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QbV69kmg9DsMNMBVld/5Gpugq8FwkJ+JSjN3cbkwy8=;
        b=dHvv1QU0nrL/BG8uRaaNWuwfZxfu1EqeRaUJ24ifA6gC6IuWKk3IxZWUQQZbWKl/0D
         fN3Fuda+8StW3mt6yQLXgFUPnUPc6Zy2gnsQvKBhwdt3h4HlvzOfBpQF4OWEIEagWKhr
         cqKvyO+8z/CoIsVkfKGKXlK6k/onaYkCC2zLHogHA8K8h7KzH4Upe/9j3Z1GfAg8ZjNN
         dzxaT6wEVrJnoJ9Fsk87eNvAOdhlK67DYAqjoOeP2KD8wgKmCVhgy0odBzMoH6Zf9GZu
         WBT+9aAEl8QObmm64ewac3PgdwA8WLq3k7o+d/lRDIWXEdBREVqInFOVgns54Q9QNMGS
         vm7Q==
X-Gm-Message-State: AOJu0YwPkoYpIIjvTJ/e6SeydZYQgi49jVlg62pJ50UGJa2fk01xbgKI
	ZdHUKZ87PRYipx3HtEt1Ay2s83Q/fR8QvJdyosdK8pmRgaN7vfyumfNxzYdyb7iTlUKcY7LXxC2
	vBf/2UigiSMgqBbLF4PA66zM6lyn/nvemP2jvI7TfYrYX1EZwas2APw==
X-Gm-Gg: AR+sD102kerla8Pz7A2dY/1FNMR6CbNQBY7iqy2SGEzRpdxM/cFq7BSpS3syB4M23KN
	1aeCI0YyQt1JlNNGUz97XFCOb5MjJdIr7//hSaOH6r89OznHP3G63prcBRVxxrlA6GSKrRCWEbV
	8z6QfGrQVy8sPACuavjHh5bOChlWkQmZCtAwBzEh+sBW2psfIG7mhy/caDR2+ovc4eLFMq0NMwL
	l6gCowsqJ/UvPHtIHOv4AUyckONlOWqjNaPohbeT0G/7T5uDQ8yjdxmywOiAG/pdnly8m3IoYP0
	I5vfzcidLr6kJMKra7lEvnrKuDmkt4bg2FV0PlcKTF0YkQa02jh1BgrBHw==
X-Received: by 2002:a17:902:c40a:b0:2cc:61e8:5fba with SMTP id
 d9443c01a7336-2cfde866e46mr31930735ad.32.1785006255341; Sat, 25 Jul 2026
 12:04:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 25 Jul 2026 14:04:14 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 25 Jul 2026 13:39:24 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260721201114.0012-stable-reply@kernel.org>
References: <20260720191525.15450-1-doruk@0sec.ai> <20260721201114.0012-stable-reply@kernel.org>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Sat, 25 Jul 2026 14:04:14 -0500
X-Gm-Features: AUfX_mwhjhnX5X-sZz0Adtxt7J16oeGm0EsNu5BzNSH9sAPFEWmfSUa4z711gRU
Message-ID: <CAPdMp1rzVAk-bq8wU6wTozXz=2oe1yW2muvoE5EwCa50gsx+3w@mail.gmail.com>
Subject: Re: [PATCH 6.1/6.6/6.12.y] crypto: rsa-pkcs1pad: Don't WARN on an
 empty digest
To: stable@vger.kernel.org
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

Sasha reviewed this as matching mainline=E2=80=99s no-WARN/-EINVAL behavior
and asked for a crypto-maintainer Ack before queueing it. The patch
only removes WARN_ON() for the user-controlled empty digest; invalid
input remains rejected.

Would you be comfortable Acking the attached stable variants?

Thanks,
Doruk
