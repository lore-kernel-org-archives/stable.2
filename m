Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686833;
	b=PkL+tz6ocpRIFBipcsY8PgjSh/KlfCy3wwZ2+RpYdW5RdsuNkr4E0E1cJtRXb2i82qMi
	 rrw5pgLQQGbYFmnHMxZpqSQYRUHQf5wAz31+IC4j/D7eKYPFMNpFB057MvFaxZ97txxv5
	 iq04FM9nrwTrNtTD+V0efpkEO4ioqXANGCfwFC6sDpZuv1puHQQ2CMDEhp7GT7E94Ak7t
	 02Rh74/hyxIfCzDE0Pv+JK8D7ICkN1NuEkPMu6XScyuzPkxTyEBcKznUGFZioKvf5vA3w
	 N/ZjVpakGY4METMlF78Pcyzu+S0Zj/XSrcf+g3QfPXxBC7c5fhro/tzgHLmqdxe/EtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pdTN5k5ljISeX4Y7RP4qX7eVJP6sJ2SABjzpm0RRdMI=;
	b=OH7QN7t2H4+8DD7Gz6RONLY72lpWr9yNucmRE3tSlGshWKwB+RCiUjv967Z7v49B+e8q
	 cIesUV0i6MVkvTjuIhwkORjS0G4rsHQt16TCV4LK95ply1t7w/zN1kdPwSx9yaln7+QYt
	 qL3Vf+QInU22PBON6GWimbLMqP6RuQoSZIl+KRWeQWbUvQektrybGFYWJHRLU9FCC3zh3
	 Hy9gNlrrxVFZr6Du4VkNlB5V47yZS2QA7YHJzZA3q1iENUP79qXL2OOVvjFpdP1J+CNQR
	 ys+RancMXiAx96A4doexz4aXIluKgzKSa/YVel1x2rzTUMue3hFbjMLGOlqH3qb1jIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KxK5CpM8;
	arc=none smtp.remote-ip=209.85.208.198
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F49606A69E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F49606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KxK5CpM8
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3acd67793f2so26228781fa.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795686831; x=1796291631; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pdTN5k5ljISeX4Y7RP4qX7eVJP6sJ2SABjzpm0RRdMI=;
        b=KxK5CpM8Uy4nT8ZmGA3aPQ3diwW6+siEZpmqsdyTnIjDLbUasIReNR8GUKpiARIKjw
         hieUypXR2ZZnmnSUN3KNltr4SOQPWokU7x99HG/VCZEqxYCH2UPu25GX9OY8O+HOV1J0
         P07riwqXkmevaoK2BNItAHTCAl63d58fXFoFQ0bV91j4aalTOIN1MjtzzCKPor8osBXX
         qcWUnrH3VfVBNnWBphBTXVWhYp4cfEVDfu6jqWtP/Z9kESGg/jcQ14GXWdeyXqeJ5z8T
         fB23OTsJ3XkN3snMWi4lShbagEF1t0FRY74SShIkH/murUkiWHkJBFItAFuOSwERXyT6
         r61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795686831; x=1796291631;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pdTN5k5ljISeX4Y7RP4qX7eVJP6sJ2SABjzpm0RRdMI=;
        b=inCJPuSLjHZp3q4iq9Xs8/pGKsZlFKCvpekgE8DydlTCayWeprHlbFAGeRNHdvK/rd
         nPykirDSYEft6MYQwq+1m02gdat51W6fBjR/tDoq8EFdFr3404ThEHbA1EFW6ulaUPOQ
         Is6KY0doJWQEgu2OpFY/OHEH00RCC9nOnv09FD/+/U+hWCS1EYebS/yJLiBEWvJwIGwQ
         zNMdkcy6ckjoix3p8GIPaUTY39LGNZbKlOScV4SPwXln5QeSsuy1tYSZBbRQKM8gxVSo
         uYkfaTaUOGG6Y/2V8SKL+o9DN/KiOURWsIP/dhnlKnDtiWVt7x5fjmXxhLA9OmIBrYLE
         mDpQ==
X-Forwarded-Encrypted: i=1; AL+hErFMK/XU0EWeBSyzgIbCI0jxmz5LxpNpsh25sHiDgqyW4rnjNDegonA3SFMKUPJqNyLupbTLCIQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SvXItJBJVJtRlTjCg4YAikg74lPvCHRVs+dfFbzd3OqilcLq+
	AUcSeobPIomSmaYhyxUu4639K61wG9Dj1a+SOhemJaDG0DW8KbcJpilHdJtLHQi0fP0N/JX0TBi
	4Cypm7UBQkvnnLALu9Q==
X-Received: from ljis24.prod.google.com ([2002:a2e:9c18:0:b0:3ab:1b6e:f31f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a2e:a98e:0:b0:3ac:ee2a:ce63 with SMTP id 38308e7fff4ca-3ae7fa13056mr60047371fa.18.1795686830885;
 Thu, 26 Nov 2026 01:53:50 -0800 (PST)
Date: Thu, 26 Nov 2026 09:53:41 +0000
In-Reply-To: <20261126-binder-32bit-fixes-v1-0-22fc21baf6f8@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126-binder-32bit-fixes-v1-0-22fc21baf6f8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=RlIYXXPHdukFDAnF4wZCL+AIuLeA7xeGITe8j6jhzlo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBrCAGqr4I2163inFA/Zi3cpPfSdhO3k0/n4Genc
 N5kn7IOOPKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCawgBqgAKCRAEWL7uWMY5
 RhF2D/0fBgCYQx+auxYq7WhW7zTx5GvnMYrqA9l4lwwthI8HTWYwb3ygn+VWkl30lZOME7m2sJL
 8JQfQFpR9pgi7s2N7/h/wI7aYE4kDSfr2taVYlbPUkB0JHIe2bcm84RS9Ag5mFdfOOSGREmrCAR
 uNALZ593EIEpChdkQZ2Hiik73Qxi6nv1mx5nma6l47Xuf+SW7Ppok3YxG7+Ha3PmCMGLw3b6FSO
 EWdckukNuXKiAol2qCAu1nhpJr7uK5UlV86M/4h8DFz1zO45iqZ0Sp40/uwRolWiL1eHX1mO50K
 w1MA9xJU0O3Q6dUv+gYUGT+RA+rwgTrOQw6uDlkCvTza+1ZBZb1zZG0Ju2XSVrn//LP9yt5TWRp
 xv6gVPLBzMHiETa3r6LIwOGj3jU2GH9nCpJcr6z8D8MiBXEDPHjvfJue3OU7DyMpNiQgQkpRDAs
 vv6J7fw41cEzDGVENE9T0YJeZGZ3U1uPxUhrPpFBOK5H5r0JpeZKNP7pt1fRSYokxwIA7OJvvNd
 VGO6TkR2iZvfVSWFtQcTL8b0Awym/N0ArUDvFNfL5FQ0CKUcHze3tW3G+r1yHyD/AVUuK75wq1y
 ASCcZpWwotsngV0w377NhSaR7dWY+7cowdqLb2I/nZTMApByOiqELlUo5aSYYq6rhqnvAhxNWoK B/P7NtQwkYRXiYA==
X-Mailer: b4 0.14.3
Message-ID: <20261126-binder-32bit-fixes-v1-2-22fc21baf6f8@google.com>
Subject: [PATCH 2/5] rust_binder: clamp write_read buffer sizes to usize::MAX
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 32-bit kernels, casting `BinderWriteRead` buffer sizes to `usize`
silently truncates lengths of 4 GiB or more modulo 2^32. Moreover,
`Thread::read()` subtracts the remaining writer length from the
untruncated 64-bit length, inflating `read_consumed` by multiples of
4 GiB. Thus, clamp these buffer lengths to `usize::MAX` and compute
`read_consumed` from the clamped length.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/thread.rs | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 54a208caebe1..8357313875d5 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1520,9 +1520,10 @@ fn oneway_transaction_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> Bin
 
     fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
         let write_start = req.write_buffer.wrapping_add(req.write_consumed);
-        let write_len = req.write_size.saturating_sub(req.write_consumed);
+        let write_len = usize::try_from(req.write_size.saturating_sub(req.write_consumed))
+            .unwrap_or(usize::MAX);
         let mut reader =
-            UserSlice::new(UserPtr::from_addr(write_start as usize), write_len as usize).reader();
+            UserSlice::new(UserPtr::from_addr(write_start as usize), write_len).reader();
 
         while reader.len() >= size_of::<u32>() && self.inner.lock().return_work.is_unused() {
             let before = reader.len();
@@ -1592,9 +1593,10 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
 
     fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
         let read_start = req.read_buffer.wrapping_add(req.read_consumed);
-        let read_len = req.read_size.saturating_sub(req.read_consumed);
+        let read_len =
+            usize::try_from(req.read_size.saturating_sub(req.read_consumed)).unwrap_or(usize::MAX);
         let mut writer = BinderReturnWriter::new(
-            UserSlice::new(UserPtr::from_addr(read_start as usize), read_len as usize).writer(),
+            UserSlice::new(UserPtr::from_addr(read_start as usize), read_len).writer(),
             self,
         );
         let (in_pool, has_transaction, thread_todo, use_proc_queue) = {
@@ -1654,13 +1656,13 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
             }
         }
 
-        req.read_consumed += read_len - writer.len() as u64;
+        req.read_consumed += (read_len - writer.len()) as u64;
 
         // Write BR_SPAWN_LOOPER if the process needs more threads for its pool.
         if has_noop_placeholder && in_pool && self.process.needs_thread() {
             let mut writer = UserSlice::new(
                 UserPtr::from_addr(req.read_buffer as usize),
-                req.read_size as usize,
+                usize::try_from(req.read_size).unwrap_or(usize::MAX),
             )
             .writer();
             writer.write(&BR_SPAWN_LOOPER)?;

-- 
2.56.1.839.g22a8290db9-goog

