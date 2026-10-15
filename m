Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075974C9DFF
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052250; cv=none; b=pC72m598ljJO5hoXlb2CW5ZfqB6Hero5e4lwDlyMe3d0dg7ZrfPPGQrnx+/0UVVx3EuB2C+DBYcDjtbfg+NLCVeXRfCzuw5k685XeumSXTe6l05k1BLrAer8o9Udx2+9M//88nHBcNEvQfDxqkLSTmlj6vJjBDyGzE9tKMRL35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052250; c=relaxed/simple;
	bh=UAAC7eIPCvw0Uq5Y++kV7v57o3dN8as0hM5yRQi71oQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mrw8CArZgQuSg+BKwVF/ujG2ASk81d1iIx/9PEq3QGlxm1ZBu0ftL+hZNO1vMiFXra/SIP1ktAoTHsehoOyRXeocVSxvExCutK2uprHb8bPl8EpzUoxEMf6cbz71aMVX5U8+xliZ35P8w7CggkS8bVEJjOT+yeNEwM01wnzyNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5JwSOc9; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5JwSOc9"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so26698455e9.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792052243; x=1792657043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIDkyGArz1wCtL42JSCEMaPJ5U6gQLe+G2a11MG+L0A=;
        b=q5JwSOc9LTruwD5yFmBxovKhf/vHzK1VIDWvad4C4Tp69WaKJMgk19wk7BqoQOowmy
         kCR1+Zo9wB9ngT+kH1mG5AK+iQkmn6Fejr2auCU8Vso5B/kulYNOTOio6J6OEAVaQajj
         NmnKrcESKL0km1ZF+ntU2/MVDRn4hOx/YMZFMLLR5T/hgK2ps5MBYQ4z27ZhMUbkYmyB
         /cRAqChEfy0fEL2eOsPqyh7Z01288oX7/lppWTsfI8DFitLqqMXrZe3XpKSeA54j1VID
         dA2vWr7UxeNfVPtZAWDCxQV//u3h+8/NUOBrNrXp8qxWHGr+qXBEF0jEC/84c2MfIi9l
         e2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052243; x=1792657043;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIDkyGArz1wCtL42JSCEMaPJ5U6gQLe+G2a11MG+L0A=;
        b=Wqa7CqWD2KzBMMXbrfUgxOk1SY2h/zmwHHtHqgFeSMQP6yNF93FEyxJ/86auxMeVUx
         NowxtWoN+Qyq18NAec6gh/Lw3w/KX+UUsbmvw8SQyVEsYTo0Ur23FA4Ol3fn085xXrKE
         gMYu8nAlZhwHFDcuVB/YuheopFKWRX7DxA4FJvBOZN2Dc84pkt48oNR/QD0mJt+NDlvO
         xxG2IjbCPRTihwZHd7XkR1jMGnVaPRECMXC7Vr4/JIJ5GaO2+Zhif3sePZWAZzPlRHlA
         286RbTO9VQzvuD+aE/NmNP4VMbHjNxf/jZixlEZTNX8Mq/P5GnWpNTIzK08q/KkUQ9Kg
         SnTw==
X-Gm-Message-State: AFq9FYIalXERNaC6+a+4kPUVIZxFXzC5dk409OLiqgrptYAwiNa59xRT
	IOg1sR2alnR5AGkBHo0cUzWOMRAijCqB2nSo9LFZD3zuDMda6ZKp6xQpHUiQSDzY2KAIxaL6Twp
	HTfIINy0fZ+BO31+1aGHJfHQAgm0ko9Cpp4qj/X6SD6LT5j/UteYi0VPmD6k2F4bCxLsGj8caMO
	rkCwozgyjH47SzLm38l3yQq47ZJDhnIFUERmQweh2tUEpdHJWKPQzb
X-Received: from wmix22-n2.prod.google.com ([2002:a05:600c:e556:20b0:4a1:97d9:2528])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:1:b0:4a1:9438:71a8 with SMTP id 5b1f17b1804b1-4a1943873cfmr250948855e9.26.1792052241527;
 Thu, 15 Oct 2026 01:17:21 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:16:29 +0000
In-Reply-To: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CPEpwMEdhdPLwug24AETWk6W40fZAJzCIAxZG+5sTok=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq0IwJh1Kue9ag2toIQDvZsSYmgjaBM5AcOCKnh
 HlzraHpGbCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatCMCQAKCRAEWL7uWMY5
 RpRdEACU/fTcwxRgFN7PGMNAdgz98vuGY2IPUeLvE13JpdYpX/TIVAgOwhNBZX6zl++uIbVmgPT
 jBKP1U0loD2qdNQB/fudPqZhG+lWrRryWNOus7qZrztudStOt7MdT2B+xPSyA4EupjkGDA/Jr4h
 D9C228+xhY/h40HpC3tLt4ci966ERY54/AOW0EOAIqsA9EY0ApQOWvlXrna/sXCvPh1S69c1ZPK
 h/RPalV8MtYuNW+KhxYzjoPKXlnUc8npdZScRrpxATXim74VR/hsNgasVLcZkpXULE2o335wGz7
 ltNwWm36QJq87L8B8CtpM2kZevVEgNQJiZ/fOC/WrONPG3iGciRpn5EDS5/caBm1/A7mqhXpk30
 KwWbKurop/Gt40BiUVY1OGUX689zsaS3BU5OK01m9gWBDG28wUwm8egwRc1VGupdji3iZTur8Qc
 r1AJkhpmNenED5GmKhLW/qBRDNAQM4EG7BBBsN8U0RnsKDprAV9fjU/WMPhWsnjWdOHYjXFqD6D
 CN+VlBLZgokrC8vabdq2shZ7cO6KvvMwYpHAZg28SJ0THQNSohNEY2xxMD5JTY+7JF4sgwDeUMu
 zecGFjWleVBubqztV86WF2gGnEwDXohStTDJ62fmX1aN2nVDW4lwrD5sGSeDiXitob3QuzO38bT PbnSlr+56u6sF/w==
X-Mailer: b4 0.14.3
Message-ID: <20261015-spinlock-irq-6-18-v1-3-72c58975994e@google.com>
Subject: [PATCH 6.18.y 3/6] rust: helper: Add spin_{un,}lock_irq_{enable,disable}()
 helpers
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Boqun Feng <boqun@kernel.org>

commit 78c998b04ef53492f3502051349e55615681e00f upstream.

spin_lock_irq_disable() and spin_unlock_irq_enable() are inline
functions, to use them in Rust helpers are introduced. This is for
interrupt disabling lock abstraction in Rust.

Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260807070218.27144-16-boqun@kernel.org
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/spinlock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 42c4bf01a23e..7929d59bca89 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -35,3 +35,18 @@ void rust_helper_spin_assert_is_held(spinlock_t *lock)
 {
 	lockdep_assert_held(lock);
 }
+
+__rust_helper void rust_helper_spin_lock_irq_disable(spinlock_t *lock)
+{
+	spin_lock_irq_disable(lock);
+}
+
+__rust_helper void rust_helper_spin_unlock_irq_enable(spinlock_t *lock)
+{
+	spin_unlock_irq_enable(lock);
+}
+
+__rust_helper int rust_helper_spin_trylock_irq_disable(spinlock_t *lock)
+{
+	return spin_trylock_irq_disable(lock);
+}

-- 
2.56.0.385.gd3acb90ef8-goog

