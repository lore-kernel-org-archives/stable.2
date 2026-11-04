Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801657;
	b=KQLqzCdZcTg+c5A1i1iiLEu/P2WPvxo4hGLMk1unvnCXj8/PODfQpvyLo3BIrtXEY117
	 phqU9g3ghEpP0tTr6IjkEPBhmTh9q7AsW6JMkfFKL+ATXi3rltTA9ybovm5w/HJhNEiwM
	 rrGta+BzuWcLfpxTImnJG8tkBy5NHMomJb/oZCwkDLqrZOLrT1V+xLyUcxAuJriqYZFFT
	 Vi7Ir9HzyBP0jlMZ/l4o//UfcM/aSloXYxwdk7R23bHQR3mTn/gzrIdFgn2jULttYfhMq
	 f3mgHh513I7GQuzGAhs6O3hIubPsZP9qRHqzG5o5c8I9hXcYvlwn6hyGNOScVxhEoBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801657;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+5N4JkAz7Oxk6JFa1uc2/eqtj3bP4tVrTPR/C/Aq5fc=;
	b=LdZMB68xTQgf21I40Frd7l7O/+gpAFiBTMktGsJVHMaL+E70QW0u6SDSNGZpivgrkbyQ
	 rrAE+72FXqIU0bUnZpmlGxcTO7PAUTDSd7rfL9S1k+w5GgbrKT/ts0mr+1T1LPxef+DPS
	 2oBWecbUvwOrOEFsMzS4BkMkmTSeI7AU5sqV6VIuM0zoocG7m7ecDX1kshsoi99ZtaPlC
	 A2faGpQmAmywjOKBHmFvFRLVxvsXM00abHItmEWSdr0TbT1s0Lv0YNaOtCET4nLF8h2jb
	 tuNUcJrN38mwMyFSA1w/cXsI1OZt21jDRuB3B61p2AkdV5u5O08IZs4gndPtbK7o0Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xDLze8YJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F9606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xDLze8YJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB481F000C1;
	Wed,  4 Nov 2026 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801657;
	bh=+5N4JkAz7Oxk6JFa1uc2/eqtj3bP4tVrTPR/C/Aq5fc=;
	h=Subject:To:Cc:From:Date;
	b=xDLze8YJdPX4pWUC/FMf7hB/jHuU69rZvkDmTqhgOrOhW2q2y+m4JRSFOQwt8HDUU
	 MPqCDxAfLsybQ+Ew++pqwvcHZFmxi7NCdqiXPe8TvjrHgjsKxbso2QHp4UOTKluVDn
	 gm7z52RtqHkaFOFIYp7q0DdZTFSmQgQRZYu1gZ6Q=
Subject: FAILED: patch "[PATCH] rust: dma: declare cfi_encoding for dma_data_direction" failed to apply to 6.18-stable tree
To: samitolvanen@google.com,aliceryhl@google.com,dakr@kernel.org,gary@garyguo.net,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:14:12 +0100
Message-ID: <2026110412-idealism-matador-e917@gregkh>
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
git cherry-pick -x 7d109178cd644268326cd31702ed46c7ac8bb300
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110412-idealism-matador-e917@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d109178cd644268326cd31702ed46c7ac8bb300 Mon Sep 17 00:00:00 2001
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 19 Oct 2026 23:34:39 +0000
Subject: [PATCH] rust: dma: declare cfi_encoding for dma_data_direction

bindgen generates bindings::dma_data_direction as an integer by default,
while C callback tables such as dma_buf_ops declare the parameter as
enum dma_data_direction. kCFI encodes enum types by name even with
integer normalization, so the type ids would not match when C calls into
a Rust callback taking bindings::dma_data_direction.

Generate dma_data_direction as a newtype with a cfi_encoding, as is done
for lru_status, and convert DataDirection through the newtype's
constants.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org
Fixes: c2437c43cfb1 ("rust: dma: implement DataDirection")
Link: https://patch.msgid.link/20261019-rust-cfi-fixes-v1-3-9503472ba738@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 6003d5127676..8577e7663e02 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -27,6 +27,8 @@
 --opaque-type spinlock
 
 # enums that appear in indirect function calls should specify a cfi type
+--newtype-enum dma_data_direction
+--with-attribute-custom-enum=dma_data_direction='#[cfi_encoding="18dma_data_direction"]'
 --newtype-enum hrtimer_restart
 --with-attribute-custom-enum=hrtimer_restart='#[cfi_encoding="15hrtimer_restart"]'
 --newtype-enum irqreturn
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2ce09f8e90c6..2ec5fe7d56bc 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -310,25 +310,25 @@ pub enum DataDirection {
     ///
     /// This is used when the buffer can be both read from and written to by the device.
     /// The cache for the corresponding memory region is both flushed and invalidated.
-    Bidirectional = Self::const_cast(bindings::dma_data_direction_DMA_BIDIRECTIONAL),
+    Bidirectional = Self::const_cast(bindings::dma_data_direction::DMA_BIDIRECTIONAL),
 
     /// The DMA mapping is for data transfer from memory to the device (write).
     ///
     /// The CPU has prepared data in the buffer, and the device will read it.
     /// The cache for the corresponding memory region is flushed before device access.
-    ToDevice = Self::const_cast(bindings::dma_data_direction_DMA_TO_DEVICE),
+    ToDevice = Self::const_cast(bindings::dma_data_direction::DMA_TO_DEVICE),
 
     /// The DMA mapping is for data transfer from the device to memory (read).
     ///
     /// The device will write data into the buffer for the CPU to read.
     /// The cache for the corresponding memory region is invalidated before CPU access.
-    FromDevice = Self::const_cast(bindings::dma_data_direction_DMA_FROM_DEVICE),
+    FromDevice = Self::const_cast(bindings::dma_data_direction::DMA_FROM_DEVICE),
 
     /// The DMA mapping is not for data transfer.
     ///
     /// This is primarily for debugging purposes. With this direction, the DMA mapping API
     /// will not perform any cache coherency operations.
-    None = Self::const_cast(bindings::dma_data_direction_DMA_NONE),
+    None = Self::const_cast(bindings::dma_data_direction::DMA_NONE),
 }
 
 impl DataDirection {
@@ -340,7 +340,7 @@ const fn const_cast(val: bindings::dma_data_direction) -> u32 {
         // CAST: The C standard allows compilers to choose different integer types for enums.
         // To safely check the value, we cast it to a wide signed integer type (`i128`)
         // which can hold any standard C integer enum type without truncation.
-        let wide_val = val as i128;
+        let wide_val = val.0 as i128;
 
         // Check if the value is outside the valid range for the target type `u32`.
         // CAST: `u32::MAX` is cast to `i128` to match the type of `wide_val` for the comparison.
@@ -358,11 +358,12 @@ const fn const_cast(val: bindings::dma_data_direction) -> u32 {
 impl From<DataDirection> for bindings::dma_data_direction {
     /// Returns the raw representation of [`enum dma_data_direction`].
     fn from(direction: DataDirection) -> Self {
-        // CAST: `direction as u32` gets the underlying representation of our `#[repr(u32)]` enum.
-        // The subsequent cast to `Self` (the bindgen type) assumes the C enum is compatible
-        // with the enum variants of `DataDirection`, which is a valid assumption given our
-        // compile-time checks.
-        direction as u32 as Self
+        match direction {
+            DataDirection::Bidirectional => Self::DMA_BIDIRECTIONAL,
+            DataDirection::ToDevice => Self::DMA_TO_DEVICE,
+            DataDirection::FromDevice => Self::DMA_FROM_DEVICE,
+            DataDirection::None => Self::DMA_NONE,
+        }
     }
 }
 

