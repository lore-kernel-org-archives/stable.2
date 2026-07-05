Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5E30D405
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783288879; cv=none; b=n8kiCSdmQ0MNXVX0v7dk1t5358txflb/GO/FI3hkxaWwz76cv+iFfj9UtHKIOTCSPXcX5yQXZm1fPmNRnf4VAn2kmO1ORTqJmfi1ba2Doz/5eCandGo+IUrep0HPJjsmvu2YvOE9AyXQRNa8YotKo2PEuYvoxr3vOqpRRF1S9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783288879; c=relaxed/simple;
	bh=J0rC12oZFiLiXQenR8dBOqjpyonB6YKw/xD+6HjT53M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8IM1PLkB56e4CFJkELVRLmZJa4JZE69BzVg98jWJIDlUyIj0Esd4cQfiV+UNp9frEtMcQAx7gleeIuumW0Cqgu0Cem9X+uOtHqDTeE+kT28fK0EdlKE3S7yMKl3FLSMYKvEfYO3vZ1Uc8kESnZbg8WUv3uJYOCUv6uiOhUIZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4HhoaXX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4HhoaXX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b7612475so21032635e9.3
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783288877; x=1783893677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XxSMfy/QlW2tXBP9+Fkc2egYH8UObSYwUBv+zGIFQn8=;
        b=n4HhoaXXeAsn4sxG5XgkRxtXFqIKEYlVLZdcUEf81KOOhkQ7mhyU046yXFwvRKNqWv
         Jql5Q3TnZyE18mEmbyub49GKIA4ioNKPv0BAORNnPTIQ44Ux0tKsfEZ2ViPVQ66XTDFh
         lGgPC4cDMVD+GORFXwQyff5j3yQ/LJ/3WUJFBr330DPjX10Gp3FoK1Og2i6+M8Y7St33
         MvqFgzP5fejKbD9QOjMQGSstb3JDfsu22YdUDwweuzyCqEWkaYap5iy99lfHr1kygzOj
         ZPiqpRiouz5jAnbziztiNr9ZtICf8a0wTuduRQmwBJpDGeP4oICJmBzg+ah2z3tkMzHG
         QA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783288877; x=1783893677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxSMfy/QlW2tXBP9+Fkc2egYH8UObSYwUBv+zGIFQn8=;
        b=Jn3AqJTfBSeXQM5+Rd6I1HC6VolZKEHop2OAOiB0yB+G6OclKeH92+ekLOPpl1jxMp
         qjVCacMaFxUm+eV+mPq+ZvtXmKH6caf7ukBIp+yXei3pFLTGnFzEJf2uEnaXnWgU27RW
         1gxSUKx6kFk0OHE1PvZ15RtZ0VxomRcueN1TmgZbS/EpArjpt+cWaeZlwUrTPj+9z8i1
         qmFZeFmkATgG4MA0pN2QybGg666QnQxULRrZXSE6zF/M9FaKTqO19RTG/K7HzpSh9ize
         NS11puzVxgeN03FMDR0lFEBDRmbWoX6XjeG1ktDeDb5qe4pTEPwN99aVZf1ndsJDTIuL
         uQFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2i1vuVh80RgZEicsJWNDkR7qJxefYSyM2q58V76pWlAR/R4tXz/HPzXZR0TQpZTJs8m31R/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YySzZmS4eTthtfGXFwjd9mGvX+BHul1PVYYethgMPYp0Y2eW1Wv
	w63MvR0bDMlIuv5NhWWM4JFK/MmcAjpBRQT3dY+tjrklYkW3FqAacNHuwfwYr6ZxyH8=
X-Gm-Gg: AfdE7cmqAUT/LG8kqQJhIeLjUohni+pDPZFPHS834R7WMYABmclD8gdR7MdTcw+k+qz
	E4jRIE9tit/WuMw+B1wxiZueks/cw+gjvc3B6Jv5koRV6Y+KOZWAYg/J+xxDNA85b2fKszheonq
	bMc5JqAKdwHU6XgifFAL4jM8v0YCcNhtlpOHbGrYrz+/BSVaqBhoUeAe/L/cUA5ERa3c9xXSYuv
	1wtSC9L6cpRWbySM8UFExPd9Dj1hdiYxn+ozM1utdHQWnhTJmnT5HHVoLyBLueQfJLnr/pCQRDr
	CAuwcXP5NxtPopqhKBkhX3bkbXmLfkKyV18wRdZvEX5YrquJ006S0h0oZy4OkwzQmwRIcHXx82s
	9MsTEGPtl14rcTJYyGLPZjfpdg1dGeZUCbuAEErfJ+qGx2AHmCQ6KyJethRPJsM1HM1kjL/8nnk
	SJnPQ1va/L16+QO4Fwq6E9KZQZfQ==
X-Received: by 2002:a05:600c:215:b0:493:c389:d43c with SMTP id 5b1f17b1804b1-493d11fd6a1mr57996415e9.34.1783288876656;
        Sun, 05 Jul 2026 15:01:16 -0700 (PDT)
Received: from tt.. ([31.223.44.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm544853265e9.0.2026.07.05.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 15:01:16 -0700 (PDT)
From: =?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
To: herbert@gondor.apana.org.au,
	ebiggers@kernel.org
Cc: linux-crypto@vger.kernel.org,
	stable@vger.kernel.org,
	sashal@kernel.org,
	=?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
Subject: [PATCH 0/2] crypto: algif_skcipher - fix AIO IV race in stable trees
Date: Sun,  5 Jul 2026 22:01:09 +0000
Message-ID: <20260705220112.2522-1-muhammetkaankilinc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AF_ALG skcipher AIO path passes the socket-wide ctx->iv as a raw
pointer into the async request. After io_submit() the socket lock is
dropped and the request is processed by a worker, which dereferences
ctx->iv only later. A concurrent sendmsg(ALG_SET_IV) on the same socket
can overwrite ctx->iv inside this window, so the in-flight request runs
under an attacker-controlled IV. For CTR and other stream modes this is
IV/keystream reuse and lets an unprivileged user recover the
plaintext of a concurrent operation.

Mainline removed the AIO socket path entirely in commit fcc77d33a34c
("net: Remove support for AIO on sockets"), a broad net/ cleanup that is
not appropriate for a stable backport. The minimal stable fix mirrors the
algif_aead change 5aa58c3a572b ("crypto: algif_aead - snapshot IV for
async AEAD requests"). The supported stable trees split into two cases:

  - 6.12.y and 6.19.y carry ctx->state, so a per-request IV snapshot is
    sufficient (patch 1).
  - 6.1.y and 6.6.y lack ctx->state and chain the IV in-place; there a
    snapshot alone would break MSG_MORE chaining and a completion-path
    writeback would reintroduce a race on ctx->iv outside the socket
    lock, so the AIO path is made synchronous, matching the upstream
    removal (patch 2). Patch 2 applies to both 6.1.y and 6.6.y.

This is distinct from CVE-2026-31677 (a skcipher receive-accounting
fix); it is an IV-handling race, not a receive-space guardrail.

Reported to security@kernel.org on 2026-06-07 (follow-up 2026-06-19, no
response). As the mainline removal is independent of that report and is
not backportable, I am sending the stable fix here.

Verified:
  - 6.19.14 (patch 1): unpatched recovers plaintext on 2857/200000 AIO
    ops (100% of injected cases); patched 0/0; MSG_MORE chunked output
    bit-identical to single-shot.
  - 6.6.143 (patch 2): unpatched injects the attacker IV on 2296/200000
    ops; patched 0/200000; MSG_MORE chunked output bit-identical to
    single-shot.

A working PoC is available to maintainers on request; it will be
published after the fix is picked up by the stable trees.

Muhammet Kaan KILINÇ (2):
  crypto: algif_skcipher - snapshot IV for async skcipher requests
  crypto: algif_skcipher - force synchronous processing on trees without
    ctx->state
