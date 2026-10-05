Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311646C4B4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193667; cv=none; b=nGkX9GeR0zJ3O197g+IR9aCy0B5nsDBs0/QPIjDQQP7gg9+yh1Pm4kCvR063svLUIDiZPTkpP+XrN/nOthiIfaZ9K/nItbtU8y9aG3DQJUhowml76+5TXG+LusXj6DdSOdL5M8VgLXHVp3BtrUBl+VWT44xhznVza+yov1boUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193667; c=relaxed/simple;
	bh=jez5cvLg5M6QCwEypwjinUKE7cBicx+kQk3Sr+v+hmM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sbqj4cV2dpvZorGdpdDBtcZjPp1u1kAPEsp32me5AC5PBWJikwt2PvXpbD1w67VGIR3FJU7aARxaqOYCHeBSd072IBcc/CMlvNNcUvlBQJt4121xsXlSgnnF5JQvxlUn1bxUyLVX3nUgMKgrxKLD8ctdQaqPnoJ4bd/uhxWnPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c4XVnEpp; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4XVnEpp"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6ae551724a0so1105175a12.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791193661; x=1791798461; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9xpO+kIfVg4CssUid2j5d0pr5jUTY53yum22MQL1sGE=;
        b=c4XVnEppfBBzVSlrWhDNke64e5ofBuvQZvlnkXLAQ0vwcDCtzElwvQrKoATZty4PnD
         cBrGZTml3w2GWB8hCw5XrmdF3XZgYskLpSStXCn1UJU7zuVMBjiRJdVdKQ3zA7JEDcJL
         Fpuz0kDUdYNKuX+s1FHsuQm7iKoVH5ZLQtI37RPn5+u6VwHserrVHRdD+YI9F2b9WZiw
         puYBSicP5mQGo5LhPRTvml83y4EabMtEuBJcxN2U5uYiIXaCYThhI7w8RXv7W8bAjdND
         V82L6AGpj88i4cu5vqjf2vlvXl3bhAkt9+izdft5hJYO7IpjRgioRc6K3xdMNcZumuVo
         exZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193661; x=1791798461;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xpO+kIfVg4CssUid2j5d0pr5jUTY53yum22MQL1sGE=;
        b=Ey3sAPPQ80/2HNhYQZ0m6kxAvQ5sLPdQb15EP7amCz8EdEia26oggtf7z8uS/BjXlD
         mc5WuaB+9sQpbpx9ug+n5nRkq9DjbE0SiV6ypTdxNyLIgbTCC0oUMF/YAfj8+ksjTo5I
         482OmvhwnT0ttzmkRBa3F0hPfbkgHt62XjGzsA+UQneitALOKMzceSGlXzhyoLLAVeMn
         F1cRel5xpv0gxwkfRh21TpbNNrz1GlGRKt1FiLVi3mZ7qeS3hJmB9bcgQ4vRp0N3YmhQ
         ljR6obOfJrNtmCYUUIFWdiLNn+Ve0qfMoQkyYi/SfmlJkY6beLVZQw1A1EOAJwpjYzqb
         5fwg==
X-Gm-Message-State: AFq9FYIiVTI2/aSBLnQdPrwcBz6rHtqyuiwlU5vj/lCc1JIo9gDFX/zC
	d8GF091yqqH5Qv+SgKDCG0P6DN+t5VT8kaf7XqALg5KQgHyHA36ImewPq8pqc3MOZd6uOPo5vm/
	ZgY8/axFUjv2rhkhbvQWJY5vKTQUjlH/o2xfKgMDYuWB5t3OtlpSdDfm/1m+iSAsm99YF4F6HYp
	/sBwCHDNw6TmYIKc57Gg6IPQEtoqhFx7brOf1W3x43/etk4emYAvV6
X-Received: from edxw10.prod.google.com ([2002:a05:6402:70a:b0:6a9:859c:d64])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4028:b0:6aa:e3f3:c9df with SMTP id 4fb4d7f45d1cf-6af9e2ea896mr9490442a12.20.1791193660578;
 Mon, 05 Oct 2026 02:47:40 -0700 (PDT)
Date: Mon, 05 Oct 2026 09:47:25 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC1yw2oC/x3MQQqDMBBA0avIrDuSxDYxXkVcRB3boaAykaAE7
 97Q5Vv8nyGSMEXoqgxCiSNva4F+VDB9wvom5LkYjDJW+UbhTEkookXd4him777Jgb5ZvLPOvca ngZLuQguf/20PttZtfcFw3z/6gl+7bgAAAA==
X-Change-Id: 20260930-devres-6-18-backport-93f976775b42
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=jez5cvLg5M6QCwEypwjinUKE7cBicx+kQk3Sr+v+hmM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqw3I1VsqS2HemFh6IRNHlT64s8tzATUTpiQL0k
 9FAoikanV6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCasNyNQAKCRAEWL7uWMY5
 RreSEACQg5g4OQunQHQMRACVp1TApLHQy5Jw1KxRPb+/33XwkRBvr2VdmcAVs1tXkLkqxE0MLzs
 r9uDJtj59GX2ZglNeONQkFZOZ9KvvK73rb42lTQeLxeAzF6UNBQOvixdHbmog3fDyXJwjC4F7Iw
 O0AS880Odl2q1aGkipJLbPRkSCZ9I5A+xBBTK0OyZ/lUZz1VnBUXStYBk+nfkLy5AC/PorPfLpp
 SRAwaD93LvJoqLINt4rmvY2uZaRAoY0poZ2pcvD+v6OjbFT/fTz/vI+P2R4PIE0lIKsoh2vvQmL
 AoS5AHutcZxNyerrnNABzg/7H1pLplD6EoyYMzZSwiLbE3E3bi3vSOTSCxWvyrLZGeSBWsIukD6
 0cxrdpDliGVoGEYKmjcECKncPsEdHnsQ2TGnrPVraVyb+9ERp97iNx2nDVTD4Jo+wPAhH4TpPUW
 313oQVkl+kdjWhLxe5b5fJaaCSnppeJBNRzUacY4tjHTYomk0p7eq/iMyByzbWfKHH8wXsTHivC
 7Z0JiPR7UAIrNdCX83hpTJr6qEo8y7oCPMx6LXSPFEx30oplP11/gfaxqjxjbaJIGAMKO+3VkuH
 +Dv9w8V0u38pP2+ijqo4F81skLK07FVZp4iBA31FHiMooCmiklPyHY/mbk7UJ0kUi4k7oJvnr7M q3KY9bbIWcexULQ==
X-Mailer: b4 0.14.3
Message-ID: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
Subject: [PATCH 6.18.y 0/5] Four Rust Devres fixes
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Eliot Courtney <ecourtney@nvidia.com>, 
	Gary Guo <gary@garyguo.net>, Markus Probst <markus.probst@posteo.de>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

These fixes were not picked up because of some conflicts and/or build
failures, but they are important to avoid deadlocks and races. Please
pick them up for 6.18, thanks!

Unfortunately, it turns out that backporting these fixes introduces a
bug in the irq abstraction due to the fact that it makes Devres
allocate. This bug is not present in mainline because irq no longer uses
Devres at all upstream. I included a fix for this as well.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (1):
      rust: irq: pass RegistrationInner as cookie to request_irq

Danilo Krummrich (4):
      rust: devres: fix race condition due to nesting
      rust: devres: add 'static bound to Devres<T>
      rust: devres: fix race between concurrent revokers
      rust: devres: ensure revocation is complete before device finishes unbinding

 rust/kernel/devres.rs      | 164 ++++++++++++++++++---------------------------
 rust/kernel/irq/request.rs |  89 ++++++++++++++----------
 2 files changed, 119 insertions(+), 134 deletions(-)
---
base-commit: 1b357ecb321392158d507b04672ffee57bfa071d
change-id: 20260930-devres-6-18-backport-93f976775b42

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

