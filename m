Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500771;
	b=zMrHzvPsM4qcy4sBVb5X+p0yM12dsDKtChpmiuWm3ft0PDhjKsxFfK+2Pi2ue1IZ2vm0
	 9nwkPROgo1czLNKmTD0r6b0utjDixppGQv+APRmPL4owTSNFxda2qUVpAiMyWV1JXGvi7
	 XM1u5PA+hpd+a6rWgeEK8nQjerOUR1Ok+0aOxOzAYsdKoIBiWgzsUmpboXagBwQKeHdut
	 bZaTjk6Bs7KJfKRzQZ8Ypwuycxa8o6VUsKp75iH1f5QCHj0tMOlN3SSyw2iljjKA6TeIv
	 mZaKywvuvWmRsPBjjUsNpCxJlMxQ7ApG5LooBGsQ25LZlSo7RrZH53QL1jXbAWsYSWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=twTTzwJyohkqmY5h5Pq5sCK9c2e3ondYs5MKDMe3E9g=;
	b=tQso10D1Y4SwuafYhjR4wCPPCspdOdpFxSp+3WWdzT4tZOezFARJm5Tr/p6oH+Ch01zW
	 CwdhK/GNEqsmpvK3/EoTDsigdlXqfnh+IM6MnWKND83RZXPJnjvtZCM2eFg44qP6wBlEa
	 Vq0rq/5aKJxvaQoH9yoFyP6baiEcJhqJrgcYbQ3iOADGAIhOcG/KI2s7ftLnPVFDKEKMP
	 c/fBLtKJzbYhwfWrwbsyOXrOuII07Bpn6L1aOCF1eBspB3mXt1EOGizQeKcMQGbHVUomS
	 4G4R8J2B2Xp3XCHbfXDXwva4Z34BGvQbGwDLrhp57ZpXnvx5K4Azwa8caDFlhdkTpNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rAZBy4Rw;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0EC60A2612
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A0EC60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rAZBy4Rw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1e295b702so25087405e9.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792500770; x=1793105570; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twTTzwJyohkqmY5h5Pq5sCK9c2e3ondYs5MKDMe3E9g=;
        b=rAZBy4RwI2oKKRFrXuJb9L5Y5sqTLhVxwh7q9vKAAEUAcjYluTMdtPkFntyadElm99
         wS6n0q1gE7DvTDlkL4DvT/xysRy0hD3jrYfSnDnp0S8SEz5SibK5yPkI9LD+uu2xUX5r
         /25UkjAwX0Wa2oyxEW9bJ9qcT54oDSUQ94Rrtl54adKGfIt8UDLwq4/s8oafXO93AEa2
         x7v0gKJzXuacA+zJ3edFCeJiwjOwylCIMW82y/EtImV4ZXzEfCEsGjzrkE3sBffyPZ+Q
         EEQfoG6mOsMI59Y2wjMRRH777yQO4auWwZZoS5EFanm7fsl7eXd2XHqyz2dY4QZEASzW
         g8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500770; x=1793105570;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twTTzwJyohkqmY5h5Pq5sCK9c2e3ondYs5MKDMe3E9g=;
        b=1AGeXlomrDNbgTLIZvDhkTyBTxdRnMEGq8algffu2/6rRmbnu4SaMlTx3NMRVUcByR
         1L0LR8p6GbuAsGBAvRiPWeVUL9s3wDK0O48lPBH/w7luwzxnFlFHtaNIti1xjLeuTR5d
         4kWzaOPSJOMznEO23Q1uINTgR/7pVPzawl3StYhNhEed7JExLdv861bw24xtVYN1gCec
         wgcvydPXKKHQDdBHAbA7WfLvcBaZW1LWVxkwPOuyxyMvRiw3ywdZW3w3oMETn9JTKHL5
         kdRr4iSjHP6Ix7oPfiLu+p2VIQewF5PkPOfb1NJGB+A/dOtP4mKHHo5pIGT3wcDSSV/d
         VI6w==
X-Forwarded-Encrypted: i=1; AKwUvBzDrw+zz8EkqaC3/9Irhj6F3GxcndpfW7/WlRvR8K1iHijzWkr4by6zSdTchJQ4Sz1DyCf0Jmw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6fYEYhj/O8JsfzjyQuPP0/j+B3kR6wih7y+q2BJ3fyH4T/TxP
	rowsUjDjGp8PLfBJZpw5M7E7tRU89L3aEHF98CgNDvf8q9lFcVtOo0N2LZZzGmwQnVti2WM4m3t
	fXHQCp4jz+NypRMND6g==
X-Received: from wmbjl20.prod.google.com ([2002:a05:600c:6a94:b0:4a1:b6ba:c116])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c166:b0:4a1:f736:79f3 with SMTP id 5b1f17b1804b1-4a1f7367b83mr29948805e9.5.1792500769489;
 Tue, 20 Oct 2026 05:52:49 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:52:36 +0000
In-Reply-To: <20261020-rust-workqueue-v3-0-ea7c74d02068@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020-rust-workqueue-v3-0-ea7c74d02068@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=cu9swDUAudCFGY8DwC8UzyHKwP4kDBpF+chMRvCQCzM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq12QexbxCjcu2Wo2ay7NV5FNOmmXPmHBuNFLAj
 tSKLW6Qk4CJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatdkHgAKCRAEWL7uWMY5
 RrHcEACW50D0Z9gpH08aYI8t659J1oF0nr1u8qkpdLSJiypTSr8j9G5EizatBWz7lKOknLXDSky
 vdqeQi7Y2psQH7h17PWdgscmq491wvrGNoTJvjgcdomUdmYJHic6q6uTY4XRH0x8ppJC10YORNB
 wNVh27niy+f3fGhrxJxS4rD6vouZeA1fCiKgX+iVtZCoe11yUxZHxzqyWv/cFXTOMjx7StcSZbu
 Y1RDWk6Uij3Yn9QaUGsZDDcYKeCTjA+elzh+Z4yUpCsC1RsYyyowd0pwZxe4oh2oRuuIIxKollV
 P+XqHK1DMhHKB5u11B0LFCxHQzoJLhlgwL3Qw/mEINi7h58GMOc7j39Tp8WqduQsQjeSE9Myls9
 GR1Uog8fOeVv1djYPy/OU6KD+Pg06cSWrUkdSVnDAE4f8xzXGvAmpMnkToq3UT2ntF0UL8nJdnL
 WbODwXiE7FFKeaMkSx63vjfZcEa9ULbqnGopB00nX09uEZtpcui2J5Im3DvAG67Wr5JaCPRpsPq
 kEZCR5weFnUauKBXEss1kYmPNActmBbx7aKFBJZK1KRWzw+1Vv6R0yuQzwCeOu8IXwtEFQaU5+8
 Jv/WRCE56rfhXEzRlGnDyUTRnTiiiawidJYVUuoVRD6v6P/WKudX9iZ42FdCOJYURZZQ+gKj6Ej XZ0yDan7yX+M3eQ==
X-Mailer: b4 0.14.3
Message-ID: <20261020-rust-workqueue-v3-1-ea7c74d02068@google.com>
Subject: [PATCH v3 1/4] rust: workqueue: restrict delayed work to global wqs
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
	John Hubbard <jhubbard@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When a workqueue is shut down, delayed work that is pending but not
scheduled does not get properly cleaned up, so it's not safe to use
`enqueue_delayed` on a workqueue that might be destroyed. To fix this,
restricted `enqueue_delayed` to static queues.

This may be fixed in the future by an approach along the lines of [1].

Cc: stable@vger.kernel.org
Fixes: 7c098cd5eaae ("workqueue: rust: add delayed work items")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Link: https://lore.kernel.org/r/20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 7e253b6f299c..aa8a472f4547 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -302,8 +302,15 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
     ///
     /// This may fail if the work item is already enqueued in a workqueue.
     ///
+    /// This is only valid for global workqueues (with static lifetimes) because those are the only
+    /// ones that outlive all possible delayed work items.
+    ///
     /// The work item will be submitted using `WORK_CPU_UNBOUND`.
-    pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::EnqueueOutput
+    pub fn enqueue_delayed<W, const ID: u64>(
+        &'static self,
+        w: W,
+        delay: Jiffies,
+    ) -> W::EnqueueOutput
     where
         W: RawDelayedWorkItem<ID> + Send + 'static,
     {

-- 
2.56.0.212.g129ede20d9-goog

