Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35993408626
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390277; cv=none; b=Jzxog88TdRY0RF0/lpGx/CL3S26+T0INcXsG3W6g/ISW/gsAWdom1lswj0tXrOUF3sQA9OCG6WrFF++Kauhfw40NwAhJ5PE55x+oI2j0MnQbhBdg1p70aJWOE8Q2NW7OOa/h3N1wX1Ur/IOYUp76f0KNSGJV7V33vQnG1zToZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390277; c=relaxed/simple;
	bh=oDvoDo0T2I6HN+WbturyDrDiAy+IBnElDq5xWEG4ZUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks9hODpdINihZ3D7LRleoeYVC9DXLToA886Xvi8qoEJdfUI9t6Ig5z4/ofGwfJutI5TKa3bhdlrhs+hfY+uIfjULK15yinkQzDwxvvn2fFarCx4Rb7HhRq3lv1gC2bD6AYXaZdVLV0iHWpmYPGskiwhPonx6S1Gi484My/rHqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZKYDt6G; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZKYDt6G"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso2327366b.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390274; x=1786995074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMDjp/2Kph0Q/Gm3PYQzClsmsJVYRNh1rwgrPz5zZYY=;
        b=VZKYDt6GfLayxUxkFjndr+O1bSXR3ULGa+J+NPBsly4Fc1zW8LwJnxok1eYE0MP+HN
         LIygisQD5CyP5xXkbUTdVq9iL0uLx8qtk0NxDcCIx9n5Pgv2E5YVdBk11WxqcnTEc5XE
         arC7b/F4dsbTdCGhOisVu+8wv+NgG/AYDCrVaOm8kly4EiODHwM8VYF+Ub5X81sEkryH
         aRUf3pFamOezMU9oJDe0gygbqU8sUI2mKMH1KKPYBWA77zaArnnvwdv+sw0Iyrwdyj6O
         fMGM9UDam84/q0X7h1WT7XKcBHufkWLZTYWR+KXvQ5O1rYyZUQYiuX5n74+BgyumEB3q
         PLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390274; x=1786995074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMDjp/2Kph0Q/Gm3PYQzClsmsJVYRNh1rwgrPz5zZYY=;
        b=EdGlqoRtyAeXsin5rVCzsAqdcF4bhSYkn0uIn6raPkOQVT4lp/2vBQixK9UYDfFRQ+
         QGqioRHejaA5lZRxzp87dZf/1QUMFzTlaBwJbKl90AOYFc8EWJHalPwxtfEO6/6z1PHw
         vyUGPeVO9wPf+LQtcfRjeG3mKj5KcISwk1aVqu8klYQyqgm2xc+cZjgc+Ka7FA1z8gpt
         3lxO+Jow3izfoTKRK3QuE6n3JapkNxyqeDN6q3rUXqJsjV7DL8ILmDwqBy+MWnrCh2cc
         R1m4I/3z9CQsmYvAu8BNOKKnVnN3U9qVfJzOYknzA4EOljELPgahRaAkL91817lbxMAq
         aX3Q==
X-Gm-Message-State: AOJu0Yzuxra9FztVqDyVT5jdNIR+vlI6DdLiF9vQnthCuYCsoXNV8UR0
	5p5UDn8wzgm7QbG8YPgrXTTgPUblr2xuyjmOpCqVFuqe3ASQ6qBwZJTu
X-Gm-Gg: AR+sD12x/ubywZ/CrEN1k6LEZCvKD/uJ82wFoVMnVXh8FQohClHIZCl2eDdEdmDQped
	RIKll6hTcUiuErHTOf8keKB7x8cCoBTa2/t8VExyp/L7sBKMLrZoje+VW4eiVdtWsk8JCo6cKFE
	L4rbxerYyXin/+0vLyw/4TvQyW1gomWOoQJvX6xAxjINoXvXlqnLJCD65qd0ba/Gia4kqsyD0dI
	RGUbRypzBZdlAW5xg7f6ilP+BCFUlyjrw6tEsyJtal/qvENI8NQRnjGn689JnhQn7IUq0X0Rh4b
	Kd/Ed2+xjsfBhQP5zzvtRsYyP/f63+lBmgjKz2UongeyxTcaU++MGP3A0QYSlSVBpxDBMLNwOqH
	5l7FfC05kzet2ut2Z9q8H9+d/XWIfsyVaiaOkyx8C4qsWBouGZCbX7HBxxywTL6htNg7v8k1Vcv
	cui7l+BXC9jqwbljug47FxUR2JnJgSuRc7M9cP5YSfS55doZ5aC3ZZanIaJvsnOJxVlzJrKhS0Q
	Wph3Dhr3mjtEj9LdMEAopD+kcudgvY=
X-Received: by 2002:a17:907:1b13:b0:c1c:4fce:6518 with SMTP id a640c23a62f3a-c2039e0b575mr2177781766b.24.1786390274027;
        Mon, 10 Aug 2026 12:31:14 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1f4df3165sm3665532a12.10.2026.08.10.12.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:31:13 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6/7] alpha: invalidate the local context in flush_tlb_mm()
Date: Mon, 10 Aug 2026 21:24:50 +0200
Message-ID: <20260810193055.3286239-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193055.3286239-1-linmag7@gmail.com>
References: <20260810193055.3286239-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_tlb_mm() has the same caller-CPU omission that was fixed in
flush_tlb_page(): when the target mm is not the calling CPU's active_mm
nothing happens locally, and smp_call_function() handles only the other
CPUs, so this CPU may later reuse the old ASN together with the
translations it still holds.

The active_mm test itself is left alone here. That path calls
flush_tlb_current(), which loads a fresh context through
__load_new_mm_context() rather than issuing a targeted tbi() against
whatever ASN happens to be loaded, so it does not depend on which context
is current.

The uniprocessor implementation in asm/tlbflush.h already has the missing
branch.  Counted over a fork-heavy run, flush_tlb_mm() was entered with the
mm not this CPU's active_mm 2934 times, and 632 times while otherwise idle.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index a5a42ae4a7d8..988e397b0b8a 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -649,6 +649,9 @@ flush_tlb_mm(struct mm_struct *mm)
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	smp_call_function(ipi_flush_tlb_mm, mm, 1);
-- 
2.53.0

