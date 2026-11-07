Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065830;
	b=OkAoOs1aTF+UB6wJHQNsfSB3u/9uIZsaUS+yJ48j+MQnAJGZAe2HljN5JUR8HTdvNp4X
	 OJPvP6avvAR7/ukbtKcfaNyOWZMx5ag9dLJhXeBqUhIl29/4cwb1QO6U/wZ5eUGs7V+kt
	 T84u3zgtabBqDWP9eUAwqUId6uAGA+P9I2EHTDcUoW4XSIQKKOUBEZGboT4tAhQ6BiAtK
	 lT7sAkdQWmwFYZHOAXyS9sI62jTx/+Eiw7xijOkLR210fEfyHX/4aT4VdqtLMKG6Hpsc7
	 XFcsS8X8HgUYwbugHIWRMSrOLa/ponniar5COPG9CspDf0Gp3IuAv0JiD+3OjDw1YnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=J+GVWyh743BI2mtlZRPsjRNkfhIGk9NadaOmqEtxftU=;
	b=QGIu7FA2aw5yuHwkHZKVOAoDi1C6PhJeErWsnvffrlQP51XzirDIJ5Rv7oMXOCsee3Uq
	 umXp5BxpCknxk/vFUak/l0oi0Sf0Ju4/1v/k7RKAuHNTMJr5qWJ9YbCh5gg0BjKAEql5c
	 L5C2mzNU9i0ZyD5YE/4FmLajqlQ46Y2ZPGZgsPFAL7XdSnRlgkn9KU7luc/+GN4VFXxxJ
	 SmJ+ijyY4gTwl8P71xclhbrBy61GWtHnGdz0vpP2fC4qaRD3iriuhU919aDiWC1rLpXay
	 +fneZ9pYUdveXGm+hGdWF7FUudHX86RrkyDf+YxlOXY7sMIIqMriJMc8LA8cr2+oaig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ptosi.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EKQQ8Rj6;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD54606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD54606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ptosi.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EKQQ8Rj6
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c41f85ee4a3so155539566b.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794065828; x=1794670628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J+GVWyh743BI2mtlZRPsjRNkfhIGk9NadaOmqEtxftU=;
        b=EKQQ8Rj6k1BbXnV+28Bj3WPrIyyPLgBFhuX7/u8CTgvxcfNqS1kuDUQOaF5639hWnq
         USJGCxBs9yulX6BfwzCoben63erqMn9TNI5jGGZYLDR7NDqzUQxcL0xq9IFMnwvLjiZE
         D1cvvYc87ZzNurs5/PdPsAlW8Klp7rDuQ+p2TzgJp+/U0n4vYjoju0+PhfXJBNivwoGu
         YB4mlf7wO0QYv8VuRrS+DHGm6s1CPLF6DiptRUUrxbEI8zl5Bo0tqjSyXH7FfSWTJT38
         RELr61CkD1WGLTXpZRmeubaG70gVom9Oqa2EprLbJFRqeOR2Lbt7JWeDMVJipnxyaZlK
         0DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794065828; x=1794670628;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+GVWyh743BI2mtlZRPsjRNkfhIGk9NadaOmqEtxftU=;
        b=EGLQJpra34+UMLsT5gH2tPFKy6jE5DIro3TOYSFpXQbj4yXoNyMC6UdwwmOZCZ3z6O
         IlJPtdsr89QMCJe5fOa2i9gNqCJlE7FFYT+hEMv4PsRMg4rzveoWPhn++NZXC5/v4A5h
         kyPWV4XM8wUFn4kJggS4JSqNyUtFW/44qm3k13osIQ1OY7t25PFTPLZz+QvaDYBLRJaC
         Z6OXvdPlaycS/GcTxWSQ+bXypWJ0MclT+nPwI53eIPb009qyNLK3+F+xfetsYgpvGCZh
         37VITKCYDLx9otNcs7If+iWMjoy/to264FtrVYbeWzRIpjIjuV075tUadobr8Di5PKNe
         FTsA==
X-Forwarded-Encrypted: i=1; AKwUvBxhyOhtWkI2KPCU57wlj22nC2RSY7RmGnbyNml9a2o09Uqcik8edoOUO8Z2wnGihlOMyjqtQds=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xgXjbtulIsPcMbBrj1YYsMRbJcBWoMEVLxSyDJoTpfB6zIjTL
	G65H0zRjNKvHKk5AGZF32XMnzcIyBnF/va8PiLqMn9mjboxFkEVwTu7shRUMVVxiRJo84znxF5O
	c2g==
X-Received: from ejbo13.prod.google.com ([2002:a17:906:358d:b0:c31:7cee:94dd])
 (user=ptosi job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:fdcb:b0:c41:53a9:c65c
 with SMTP id a640c23a62f3a-c4d34c1fd1dmr423463666b.34.1794065828169; Sat, 07
 Nov 2026 07:37:08 -0800 (PST)
Date: Sat, 07 Nov 2026 16:36:07 +0100
In-Reply-To: <20261107-mte-kasan-split-v1-0-d84ea5f30f94@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107-mte-kasan-split-v1-0-d84ea5f30f94@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261107-mte-kasan-split-v1-1-d84ea5f30f94@google.com>
Subject: [PATCH 01/24] arm64: Fix lazy TCO clear when enabling user MTE
From: "=?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?=" <ptosi@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peter Collingbourne <peter@pcc.me.uk>, stable@vger.kernel.org, 
	"=?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?=" <ptosi@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On kernel entry from EL0 with HW KASAN inactive and user MTE disabled or
in async mode, mte_disable_tco_entry() leaves PSTATE.TCO set to avoid an
expensive write, as it assumes that EL1 tag checks are not needed.

However, if the thread is in the process of enabling sync or asymm MTE,
set_mte_ctrl() updates SCTLR_EL1.TCF0 without clearing PSTATE.TCO! As a
result, kernel uaccesses miss tag faults until the next context switch.

Clear TCO in set_mte_ctrl() immediately after setting the task's SCTLR.

Cc: Peter Collingbourne <peter@pcc.me.uk>
Cc: stable@vger.kernel.org
Fixes: 38ddf7dafaea ("arm64: mte: avoid clearing PSTATE.TCO on entry unless=
 necessary")
Signed-off-by: Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>
---
 arch/arm64/kernel/mte.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 31f5c6b0510e..d1dd9b80173a 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -409,6 +409,7 @@ long set_mte_ctrl(struct task_struct *task, unsigned lo=
ng arg)
 		mte_update_sctlr_user(task);
 		mte_update_gcr_excl(task);
 		update_sctlr_el1(task->thread.sctlr_user);
+		mte_disable_tco_entry(task);
 		preempt_enable();
 	}
=20

--=20
2.56.0.455.g6c5a503b38-goog

