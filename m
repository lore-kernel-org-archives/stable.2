Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428F33B975
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356827; cv=none; b=NgQGgBiS80PVH0mRWE0EuN0iRhwiY+mznBFPiOLB0JMvBEtoMJi6FJIc+DaMJxzRQmUfP6kc0Wg94f9rNoxkZQlt/nToVaBYAQn/wvQ/F89mrzuKKCo2UYZGj/X78hJuoD1QkZl/L/uKFE/Ak9OXnbwGoK68C618b9fVmcAHEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356827; c=relaxed/simple;
	bh=Ca9661q42loOjY/SxfLzuH6ap5pj05sGUcjFoGf9AtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCl8O/f0nxNaGd/38+FX91b2Xd+0AHgEziN4pjIuXk7XD+53vKm9Ge5ppg36UfnPgFDUCHoHxhOA8vX2c21e4APE3tvLerPsUV5HYtuEJ0zztSPTnJ/s4LOmtWTtDmax3vMSljb7BDg2TEcalMF7vW0TqDhI3hpYafMUfJyKWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=BY1X/3Eo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="BY1X/3Eo"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1356809a12.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787356826; x=1787961626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lXZS+aF1DKTBisMUhU0/E4N+p7Xfb6c8bhgMnFtNcU=;
        b=BY1X/3EobkWLZuFHDHUWZIhdp8QmZR4leUehnAW2zGx5cbHY8icbhCC5XletXs7eaI
         wz3puLR23Vrv9ucncEKW6ZKqJj9iU+2eX68Uqpqfpfk4SDYzrq2hIwXoGqQTRJWbH8XJ
         OV67UUXgpg3lc4WFLMJhPAWpyV08XUaw0q/fayMW5NoZ3PXMCT3mnNycU3HRcrMn6OdM
         yyZiHG5dyK/tEzZxnOnEiO+VeKxSe7ggLocRHDySnM9BB6HKDXWcQi8dCIjK7lSYZ+Bx
         on8xX0hPzRNJxoyDLsih100MzC3omfRS5hlNsoRGakkpkqotGyBptIAEnNW7Frw1x8nF
         BY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787356826; x=1787961626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lXZS+aF1DKTBisMUhU0/E4N+p7Xfb6c8bhgMnFtNcU=;
        b=cwyb7rdb/2m3nscLEhxBbGvmqW1g3SJstE5TM9YqJpFs8ra4aG5n3ZYlP6t+doVp/A
         NnH5tfJVi2hXlvCdyomJ3RRnztQdutxtooryOtTBbjJkN7dWrPd3VPDJyPDfjGJPmGwE
         4aDERPvXVsqkRhUW5ObjD/96jXyVRnWuYfKktT0e/xvVZxLo0O44qIDy3+AVFeb4NPw5
         nB1AMtNfQmdYYGVuU6VUwNeONqGamS3fzs19Tj8360cgTCqhL2JxzPRJGSIP+D9QIcKT
         7BF2ZB+YPZ6Tbdcmeze2Mf6FP3VZII6vOCY6jtG+pdzFJqcFYX13B4+MdrEZxNwQFhva
         njqg==
X-Gm-Message-State: AFuF++mqq2yqZlK6OTl/5/FrggoAooT2lmyYfeeo6aWKHJBKzlQ+KYGb
	Eglt/I7TXjzXpsdORaIS97aNLzvc6/UtOldwcSxpJQ6o1klSQWo7xXdMYz1yfH0TrtzMheqokLV
	WLA7A+wI=
X-Gm-Gg: AR+sD13Ue51gz00wGiGsOs/Siab2d4EsSJpd2scmP9IyK0Kyi0p3xofzgNdhkfwGtI3
	v/dF8IKiXHHZwQA079cQZ7IC0gN8XtOUkxAuZhJFeoRFOHZwqhXrw6SwmG1ln/xGzqFb3oA6Te+
	y9c3YSiwO+ImFh8VFKXMPbEvES5u9JGWCe++/LfkgGAr923FHAKd0vlDXqh579rksa28e48A7WU
	gn4Dc5iFKTHVTilEfVTdzcC4r0iDLe+A4sMnhq/Iewn125iGNOqhSUSRq0AFsco37foThPafBzQ
	LnuVu4Cnsk6+23pM/p5DrkIx7ta44ieABq1lb236G3yCEjDOKsCXvZTYX5X9qg4IbSG49tJbrFw
	MbtTEYvTThV6QT3yr7ZXb0/zWnBG5CWmxC+AfyDaW3uv1d+4HxVfAor/N9xUTrpXkxoBJ2qDK/2
	gkEbAxL4bvo72YzVfV9z6f3JmdbdbTA3VYErSv1vwizMyzpl0doxWB4jaV3w658tihXwrDPy6Jz
	Qc5Kgj33lvySQR3gqQfJkY7oQeACrEfCtOet1aQPE06gCuabjv3kpjehSR0GY4=
X-Received: by 2002:a17:90b:4a4f:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-395a044f22amr20593370a91.3.1787356825699;
        Fri, 21 Aug 2026 17:00:25 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:fc5e:9d66:f144:bfe9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm1743425c88.10.2026.08.21.17.00.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 17:00:25 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: [PATCH 6.1.y 0/2] tls: fix data disappearing from under the TLS ULP (CVE-2025-38616)
Date: Fri, 21 Aug 2026 20:00:16 -0400
Message-ID: <20260822000018.48130-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please queue these two commits for 6.1.y.

Patch 2/2 is the fix for CVE-2025-38616. It is already present in every
other supported stable tree: 6.6.y since 6.6.103, 6.12.y since 6.12.43,
and 6.18.y and 7.1.y inherit it from v6.17. 6.1.y is the only supported
affected tree still missing it. The upstream commit carries no Cc: stable
trailer, which is why 6.1.y was left behind.

Patch 1/2 is a prerequisite. In 6.1.y strp->msg_ready is still a
bitfield, so the WRITE_ONCE() added by 2/2 does not compile there:

  ./include/asm-generic/rwonce.h:55:32: error: cannot take address of
  bit-field 'msg_ready'

Backporting 0844370f8945 first converts the field to a bool, which lets
2/2 apply and build unmodified. 0844370f8945 also fixes a real bug that
6.1.y still has on its own: a lockless read of msg_ready in ->poll. It
is present in 6.6.y and later, so no newer stable tree regresses.

Both patches are verbatim upstream cherry-picks with no adaptation.
Verified on v6.1.183: both apply with no conflict, and net/tls builds
clean, including with CONFIG_DEBUG_NET=y.

CVE-2025-38616 was reproduced on a KASAN v6.1.182 build; the patched
kernel survived 1,000 rounds of the reproducer.

Jakub Kicinski (1):
  tls: handle data disappearing from under the TLS ULP

Sabrina Dubroca (1):
  tls: fix lockless read of strp->msg_ready in ->poll

 include/net/tls.h  |  3 ++-
 net/tls/tls.h      |  4 ++--
 net/tls/tls_strp.c | 17 +++++++++++------
 net/tls/tls_sw.c   |  3 ++-
 4 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.43.0

