Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E8459ACC
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748671; cv=none; b=g71IqLEmDG+6ADwoq3bhHK3xasvv2OKjBy+XVDaGKHoVu8QKgqMdGl/uaw8oljPIedyeAGZouuyCFb/kgSN4eyRws3HgZACtUUHgmpJIOIXeYEjKbNBLlC48WgxA6Q1NOVN3Vc6tsMz1EK3V7XNokCdJN+9zDo2V37BBh/RKc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748671; c=relaxed/simple;
	bh=Le1SYPb2jPNj5MhF8OuGIlzFKKsBR2rEDTHPqcMQNeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx5Q531ChHYpPYxhFPlEFHewlZkX2B7qgKlfYhgCULWZtQqu8730jkaOUHX7UwVSoGb+Rw0vbxzeDBCnOyXokOMWiYBLb+Oi1gI+5tZ2C89LUalMCAfV3r/E8O/nofUytkg2VXFLttcpM91yF36fAZ+Oxr8yDlGGcMz7Zp6CS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1DXwjwZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1DXwjwZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso194563666b.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748668; x=1792353468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=Q1DXwjwZx0ewCGYTzlldBhwAvBE5AFrZmnFiUCBx4qQIm27xdFd9CxirUs56NxYjun
         Ur4oHEYAn7SBy3slGVOLiEU1iGdv5fAE9yo2QbNaAkaGYMQIYpz8VA4+5jBObOTkpIbQ
         g1gf07nXLAGnZEFljdbRhALTcYoJB0TQQoFM/pwlVtJ2O4UW27SyQOjwy/Frb3+TMrpo
         oJVh2DRQkq4zP6IVGarJBh+/4Ij35cn2xEoJ1cJ3r2Fu2lo1+fh6h/Ci2+lF0iCa1sRG
         jwoE4rpvY+suqOtbQhOAx/jGZTIGKLOmg8PRDB+ZKrs+58Lrby/s4bixVTkt1OBUtfJV
         +bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748668; x=1792353468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=W9LbTuFnr8X3LNRukokucxgZH7iF+7KN3vbsnKkIs/bxjkDvw3dbA6uM0Q9fYnVAGr
         t7mpimaxbsDDmE1SIr8Jo5ksp3I0TUymmYIAO5kbTTTllNRmGCe0XPxkh/MSRw3cYO2I
         1++NCTazSXR1lFvWlt46UmYtIuADX9VaexoQZoF7ZlWuQN/f5A75PKjEVdT7Y1eEt+f9
         d8hgky7ffj+VzNLyj0BqWtIm9EFHHBjSXqdmBBH7YeFm3mi9UlqnmavQvnAD/s7WNbGn
         DmYmx2dSrVRlrhrj+S0ruKsydXbk5qSTZbIAJPchT0jBvZ9LQ4jeRLOrYd4JoSo9ooab
         iBVA==
X-Forwarded-Encrypted: i=1; AKwUvBw45Z8BL79B4skrPwltM/+cYF40ezpkNFUxUk8ASk7M71LXgqtOvlydmYcIHAwlsjEaBt/MA1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEtRG3F8OzdBzfBwCa7bxgXlXhjQqtr3daF5xp0nePBeMZaFSu
	05YFv78lWH+G6pKct5bNHm2QPG5qX09ePG5DukQsBggZQnEQ7s1HyyFu
X-Gm-Gg: AYBFou18CasjaZk0Lt1/hQFbT0dtt9Atvic5iWiq2IwqGekdZJPuh0CnCvgS2bxxD1B
	Ef6BeBhHTGMam4lmh0EiK4+4szFcABN9+wITVmW6iN7QAHjP5pVyz1GUUJhnjrJ5DAeEl8Ei5x4
	bie2JQ9FqArpzFv+X9AM5kU2UgOwY+O6960b6dX4wgUmrjB/1S+fonFjESBIh9nYerTT/e/M0xQ
	2FKB1WW+gVJDd/8gLlkBGruqoURJSdi88p6vhI1ev1MnrijClTLEODrxV8E7EH07Mrgr/m89d4Z
	EQLRj8I+rCfDlSzC6Uil118/Tm4ZGnQiFNzKBeYySPzIgg6JdwmXXDUUPI+HkWTNFcV+nq9Cci+
	j83QmKP/CAaKnyp6SmQW1n53Jng2719iBSAVvhVDhwu8TUeS9tYMO9lArLA9rrb5ag4O637DXQp
	J66Poy2YUIrGHNkirlXIul5mEXP3MyePE+IxRWjlvarm7kpW90my4JQW522SG/zCMHmYnYyyJAg
	6SH/iYXHG0efRGAh31FDgMKfdQ/ohQWFe5gjJkauCCHIZyFUyk=
X-Received: by 2002:a17:906:dc8c:b0:c31:8984:7fad with SMTP id a640c23a62f3a-c31a9feb114mr762553566b.15.1791748668114;
        Sun, 11 Oct 2026 12:57:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:47 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/6] sparc64: return from the generic clear_page implementation
Date: Sun, 11 Oct 2026 21:55:53 +0200
Message-ID: <20261011195729.981243-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
Return to the caller once the clear loop completes, as GENcopy_page does.
This affects processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\
-- 
2.43.0

