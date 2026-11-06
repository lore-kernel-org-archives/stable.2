Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975891;
	b=3Cb/CJEas1WCjVe0Xlgf3T/SeTB47mH8etrCbNLzTp6eGB4yN6JtaCGzU0yi+IGqgeFo
	 JwOMDZfkHeaDusLmNNTo15FadSZVvQ1tExxcPXNduAOrab5DFk4H4Di5/GFwCMeWDFAY2
	 b6hB3Zer3l/TlzuDd7D4M4+IGugi6unX/aH6Oi/69qsY+fnC8AEepX3iz99EW5O547VJx
	 /eZ+5/2tD9WS1niR3F7S88+RlLKTqXlwE8javaZrZcvMvb6bbSC6ddnMH086TKVkqd45w
	 jHFHve8y8tbqissXVWSiAudG2OnoLqaxb1HKDy2rY3AN7Zw8b7j9zMxjF7Mg46qLbmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975891;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4W/x1MqZiivuhZPbeZ4zbXznODlzGJdzBDNUlaCj8M4=;
	b=xy/akMD02nLUt6MkpRtbwJ0vJLxPv4b4b0UfGEohf+ehBJgsLArbtk/KVz8Cm+agyfAM
	 i8cf4SAqn/GxqkBOgq2Sr03XrEhqA68b2EI/d5tOCrlf2/5r8WuDPHFozqasLPR9UZr5V
	 SceBN3rHu5Rw9L69y26DjEnkSLVIyw0ne7XyAQ/FeCJ1OqS0dfkjjZFbegiQ1GIvyJcZb
	 g4eBXIdO4M8QlpESuYr8DLNvTB1GKkRm/Oa3Md0GOx9GQOZD1FjcNP/qL4B4x9qfhgw8b
	 6OAnV/VEUBV8J4ExELKm9CTKmBwIWmeBWU5yXQP2uqptlaJSqJwh5dB0oNLg/kjn+ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZVDf4if;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC5606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZVDf4if
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BA51F008BC;
	Fri,  6 Nov 2026 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975891;
	bh=4W/x1MqZiivuhZPbeZ4zbXznODlzGJdzBDNUlaCj8M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LZVDf4ifFV0p9oPJG1vNTYFmPSDDY9VgHM1dEmd8tVFk3UOCQDniN2/wsXx8zPPEH
	 deF7B+oj11hp7szv1NiQvigZSmBF/1nDuQ/OIIyvVfrcsbQLMXrO2/2Ayzmr8DYqIY
	 wBzwoOa0kJbTX8ky5dcY8JowshalrYGTpEf3MK923/su/ARFCitmHsp3AvNpyiOdUa
	 OmgY1vImPiuTd/lB+Qzcrkp0ebUVlcvrtsBPI4gMXqnffoyrWVrFw1megqez8zEE38
	 kssGE7lrb0E6nv3wwUVNsgprAGeHhiB9iOiUW/QQWfhe9MmMGzSmVHR+qWSyzCUWsS
	 m7c/iPrihHTbw==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: aliceryhl@google.com,
	dakr@kernel.org,
	gary@garyguo.net,
	ojeda@kernel.org,
	samitolvanen@google.com,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH 7.3.y 1/2] rust: hrtimer: declare cfi_encoding for hrtimer_restart
Date: Fri,  6 Nov 2026 15:38:01 +0100
Message-ID: <20261106143802.27907-1-ojeda@kernel.org>
In-Reply-To: <20261104201749.480655-1-sashal@kernel.org>
References: <20261104201749.480655-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sami Tolvanen <samitolvanen@google.com>

commit 39fe6892fd52faed6325ff7f13a92da01ab35727 upstream.

The hrtimer callbacks return bindings::hrtimer_restart, which bindgen
generates as c_uint. C calls them through hrtimer->function, which
returns enum hrtimer_restart. kCFI encodes enum types by name even with
integer normalization, so the type ids never match and every call fails
the CFI check.

Generate hrtimer_restart as a newtype with a cfi_encoding, as is done
for lru_status, and adapt HrTimerRestart to the newtype.

Fixes: 8a8afe9349fb ("rust: hrtimer: introduce hrtimer support")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Tested-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261019-rust-cfi-fixes-v1-2-9503472ba738@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ Adjusted insertion context. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/bindgen_parameters     | 2 ++
 rust/kernel/time/hrtimer.rs | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index cbc0a302647e..45f6eb56a1f7 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -29,6 +29,8 @@
 # enums that appear in indirect function calls should specify a cfi type
 --newtype-enum fwctl_rpc_scope
 --with-attribute-custom-enum=fwctl_rpc_scope='#[cfi_encoding="15fwctl_rpc_scope"]'
+--newtype-enum hrtimer_restart
+--with-attribute-custom-enum=hrtimer_restart='#[cfi_encoding="15hrtimer_restart"]'
 --newtype-enum irqreturn
 --with-attribute-custom-enum=irqreturn='#[cfi_encoding="9irqreturn"]'
 --newtype-enum lru_status
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 2d7f1131a813..07344ed5fbd5 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -834,14 +834,14 @@ unsafe fn start(this: *const Self, expires: <Self::TimerMode as HrTimerMode>::Ex
 #[repr(u32)]
 pub enum HrTimerRestart {
     /// Timer should not be restarted.
-    NoRestart = bindings::hrtimer_restart_HRTIMER_NORESTART,
+    NoRestart = bindings::hrtimer_restart::HRTIMER_NORESTART.0,
     /// Timer should be restarted.
-    Restart = bindings::hrtimer_restart_HRTIMER_RESTART,
+    Restart = bindings::hrtimer_restart::HRTIMER_RESTART.0,
 }
 
 impl HrTimerRestart {
     fn into_c(self) -> bindings::hrtimer_restart {
-        self as bindings::hrtimer_restart
+        bindings::hrtimer_restart(self as c_uint)
     }
 }
 
-- 
2.56.0

