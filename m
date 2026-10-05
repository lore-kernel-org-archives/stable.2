Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF146469820
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193673; cv=none; b=LFnv7SD19hqrWEeX3q+2WAd5ds0d4DQqN8YddLgWh6D5Ouxq/Pr6pvJy7jLSvLorlFPiMMKyYleDHDrf6CeZtJT50TbUORkIKD9OPBvxHIIfN3xgyGdK5y6IgwQFt9XNZ9bJ/wGy++mVENjg94VMfwKj/zvkormAi1x47X8BWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193673; c=relaxed/simple;
	bh=28uiTWIIABkfwULio8qpodsyvAtD54gc+3tq5EFHoJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a0uiGvpopcdtVeuaXHcaqmv9s4SNdLZf0tk0iduilEagoF4vewqtjHLAhoe6Q/MDLKWxCzqqrGF36tpRVV2ijcVmQWcNntmaRhPfgdzE5vwoBqux7hckOm0k+TYXMFyOrgym6WhTwBZeVNmY82xW+ZhqJK2T28vhqu2MEz4GOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ppyv0vLx; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppyv0vLx"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a0101292baso17551655e9.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791193667; x=1791798467; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jMEn+uojeugEvTLf+dfsz2SFwaZUIeudYt/IVuG/qU=;
        b=ppyv0vLxx9Pp2WNjtrD40LZXZyU8AuYCb5OSo/lIThuYpJRgoSKYvroSFwLDGeudRS
         qXyAQiDE6jA09G2yaRi+jxme41H5WP5w1csEEkMrFYRTNl+laWIfcBpc/rxcAI+szjjg
         uGSKUeCCW6THHI1wfHL+OaJgJPNc3R76RiB5Toioz+6BvBx+X3HE2TttSojJ/8stNGdR
         IrGcylA3IeU2TtCNYh780BDgkTNaX4IiudRSzBDEix/gqyLCpdv8mRZ0sO05MBgLFYBS
         fh3u2CaG/GGKeopTKB7lT3kSqygx6hy9K5l9j9rSjqqqkUOLSdAxvrM7/h9x2yRuTraP
         Q5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791193667; x=1791798467;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jMEn+uojeugEvTLf+dfsz2SFwaZUIeudYt/IVuG/qU=;
        b=aTidL8A+1DDyJEOgbwCXAUVX/l+vuGrtuB3x+lhHJ5WtSsN2W/M7wskL2L8vzuWER0
         DJZ885dBYcrbwoedDT8pYQVAVQ83+s3eIPaqeUYNrjyIL718UdjQGe0/c7zWWR4QZIiR
         r1P9eHfzWU1G4ahXfc4hgtzvRbL0E5ObtAYwYnmSQ96x5+DchVNS4lmwwT5ILKe8kEu/
         4DvR1oX1V8dCgxyo6Snb5yBmi6iuKGSQaWkQc28G/O5LV/nLMDs4HwcEABYYgzBDED42
         UqZYzByqCcXogQVuPFcpwHNJL+rmReDktqQ58gtammqmPDAyhInDdetsM2qAsJv79ZCy
         M9sw==
X-Gm-Message-State: AFuF++m/E25NIX6FEqDXI0MqAf+SlhnNbIQh73s8+qWa8WTKHleEoTE4
	RubB0ykXCeb3Syaw/NvOo+//tyYhklGyPxVFDTAFGpqQxf7lcEnutpZqlZ9ik7Hzqbe7WrtIQ0u
	ZuREeZOrOp3gkexZHMVF5dT2EYw4nVGJow35QM2edp3bnPMh3IEniAWO9bioGAseXnshCr6E8zb
	ngUgd18vJVlj30NbgDRd8hZP7bONh+V2XKZZQTQRLhgeUEc+tM6hN0
X-Received: from wmok21.prod.google.com ([2002:a05:600c:4795:b0:4a0:2845:31c9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ec6:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-4a02756637cmr181239935e9.9.1791193666905;
 Mon, 05 Oct 2026 02:47:46 -0700 (PDT)
Date: Mon, 05 Oct 2026 09:47:29 +0000
In-Reply-To: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005-devres-6-18-backport-v1-0-06dcf0e592d5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7I4O+g3s8+7UkGcF3WGN5dLLRIwv6sGTRiTYgZQAeNk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqw3I6z25lJhoxLkMfeGvQ3dP+jgpGUCfhYI96v
 goLu5RRKzeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCasNyOgAKCRAEWL7uWMY5
 Ru4CD/9vz3AJzlCzvqxa/3mkfoBpYmcTc1JCDPk3w1aMhCzC1FtotJKcy2S5mrXiz+rrWigrSTq
 iXyTPoF6/KXur8twcF63idkdC75PuHlvuW85UM76Kz13xd8hDcTrHZbZwBNtufxtT56WZZFEWsS
 YPYwChI67vhUqRLSti8BPuVTWD3dUuuugI+hghsgUR1zuZYc5rmove2UGibFEmfP1YOgt60fsaY
 McUj4+YCthMIrErLl2QF1c3OHNy6YXhwRBvBJpIhU7gZdL4uNGVfBj6iL99iZzJUVXr0Bs38ASt
 Ic0fMzxwZ+LoSaYSFRN+x4ejYoMxKszdmUTBU+wBaNTgh0ODrVB5pEgrf7YdJwj1jZgW0w83sD4
 u7PjT0PiksnaXt74Q35hUm+CTOsp0aPoma3C4qLIqdc1A3XaYMmOJugk5a046CsSxcVwUT6UVGE
 mBcmNycTTLqfQqu4qPrc1GxWWym9FipycnJJNUyVE1p58nVXclWOykaht0Qa66ons3rWHQ8CIPM
 H2f7ojJ433PvM0/pCU5LWT91L21Bp/9vWMwm4kUz1/sXhuTfdkIGxHYMDqrdWx9ktPDcCbJRsSk
 eTmdobXTbNnXYH4sjjt9GAQY+NQbQaDtQSpPZZRxQkZsT2a3QaIZZroW+7qINd3DFWVz0o41v8c 6VKI2tUPiKPW7vw==
X-Mailer: b4 0.14.3
Message-ID: <20261005-devres-6-18-backport-v1-4-06dcf0e592d5@google.com>
Subject: [PATCH 6.18.y 4/5] rust: devres: ensure revocation is complete before
 device finishes unbinding
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
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Danilo Krummrich <dakr@kernel.org>

commit a10639966fd72fff8f7fbf3c8e733307daabd38f upstream.

Now that the revocation Completion is in place, also address the
symmetric case. When Devres::drop() wins the is_available swap and the
devres callback loses, the callback returns to devres_release_all()
without waiting. This means device unbinding can complete while
Devres::drop() is still executing drop_in_place() on another CPU, which
is a problem if T's destructor accesses device state.

Make the synchronization bidirectional. Whichever side performs
drop_in_place() signals the Completion, and the other side waits.

This does not reintroduce the nested Devres deadlock fixed by commit
ba268514ea14 ("rust: devres: fix race condition due to nesting"),
because that deadlock was caused by drop waiting for the release
callback to return (the old 'devm' Completion). Here, both sides only
wait for drop_in_place() to finish, which completes within the current
call chain. The Arc<Inner<T>> keeps the Inner allocation alive
independently.

Cc: stable@vger.kernel.org
Fixes: ba268514ea14 ("rust: devres: fix race condition due to nesting")
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260628200304.2365598-1-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/devres.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 02916f80db5a..fc0d8b2cb7b2 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -173,6 +173,11 @@ fn data(&self) -> &Revocable<T> {
 
         if inner.data.revoke() {
             inner.revocation.complete_all();
+        } else {
+            // Devres::drop() is concurrently revoking; wait for it to finish `drop_in_place()`
+            // before returning to `devres_release_all()`, ensuring `T` is fully torn down before
+            // the device finishes unbinding.
+            inner.revocation.wait_for_completion();
         }
     }
 
@@ -261,6 +266,8 @@ fn drop(&mut self) {
         // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
         // anymore, hence it is safe not to wait for the grace period to finish.
         if unsafe { self.data().revoke_nosync() } {
+            self.inner.revocation.complete_all();
+
             // We revoked `self.data` before the devres action did, hence try to remove it.
             if self.remove_action() {
                 // SAFETY: In `Self::new` we have taken an additional reference count of `self.inner`

-- 
2.56.0.360.g66cac248cb-goog

