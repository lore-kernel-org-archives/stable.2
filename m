Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801662;
	b=GK83MHAW+wVLU4pMaFTSRo1lccCHybaXBlsp4nRs9wr7+DZUspTq82BQ/ze0e9LywJ6q
	 xGB/M2J2Qwbpgb0Q9FTqlT/JoJEo9bN9baOn0KR7Tr4x2WlO1JXjolj1M/0YQCKY8ANFo
	 oDy7nmi1Bncx3d0OmnivpqdT5vCmYw4mluW2ywveIW/fg9krMLFUySgXYNQWi2FdnXfP7
	 24uCyqIVb+7JpaH2a0Wxsv5oKrFuYa9On5H74qAE8j9Hm+OM3z9uGUhQpxyJ3T0VkP5Ln
	 K4E/gsgFjqOq5u61gvxf4W3jnQD6t0YqEodeZpZ/4JpRnY5eOJJ+B0PiEMPBEzlGPMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801662;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TCD1igzNutY5QMI9bYGZTIUEhw0x1KFwSfJfOgQTsC4=;
	b=3fFk6LUb8dN4bPYwIaaK8zAiDogMqYqSfoWkZxV+bZIPGvpECKUTucGpVD37Z55ZoYOX
	 LoWMwqEN40QMOjUVIkw4Ufyy1y/RWsPsZlFVyAbbGS7yECD9YollUUU631tsrRxf9mCbb
	 fX1x397KhY+krQElzbHq699kGudvKJWaslDKJyh1TpQmVUz8HGeonL0Coqun/JstG21CR
	 a9f80mbTcRMEZc/xUQvAmGjASb4HTt1E4cwJAbnZivRk99rJGmab7nvkEPJN45PuLN+Oh
	 PhQqwfP4uwBqPqw/kOVtiG0ze2F9JM837QUjo+2cfLCxSb/ym9xMe1eDqxxoiwHVOeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QFGo2zfp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70267606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QFGo2zfp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB4F1F000C1;
	Wed,  4 Nov 2026 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801662;
	bh=TCD1igzNutY5QMI9bYGZTIUEhw0x1KFwSfJfOgQTsC4=;
	h=Subject:To:Cc:From:Date;
	b=QFGo2zfpHmAP7DYSsjrq5ZZ0T0ePW9cDGc6mteMQCmtspdR84HxzYx9PW0SRPbBYR
	 WHgrRGLW+rot5Bm/Hs0n1tmgWnWmUdMPE6/dggRe8YqkFe1AB6gRfE0bfRmBjcPJ//
	 LVLhSBpKxjglTUF1skaaz9vTpVbjlNK1teX//tOc=
Subject: FAILED: patch "[PATCH] rust: hrtimer: declare cfi_encoding for hrtimer_restart" failed to apply to 6.18-stable tree
To: samitolvanen@google.com,a.hindborg@kernel.org,aliceryhl@google.com,dakr@kernel.org,fujita.tomonori@gmail.com,gary@garyguo.net,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:14:16 +0100
Message-ID: <2026110416-donut-counting-ca1b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 39fe6892fd52faed6325ff7f13a92da01ab35727
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110416-donut-counting-ca1b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39fe6892fd52faed6325ff7f13a92da01ab35727 Mon Sep 17 00:00:00 2001
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 19 Oct 2026 23:34:38 +0000
Subject: [PATCH] rust: hrtimer: declare cfi_encoding for hrtimer_restart

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

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 5059cc74cb3c..6003d5127676 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -27,6 +27,8 @@
 --opaque-type spinlock
 
 # enums that appear in indirect function calls should specify a cfi type
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
 

