Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801655;
	b=dq7nzz/4oo0EOPn7Bx0Z/cQVBUwO5+ePMz338pcMMpXhaOtdIe05yAZYUsEeh1Jposox
	 qpJlSyMSUD0XRzcLgzA89kzEHFYvrJ4cswtiMSTKAVt4MjRgOZN2jdFouD6K0IyfJZsCU
	 vID58+4zYWHeY0LNfQZca1u8ksi/EJjucxQhP1PedvnjxBFuIEuMkrr+pIhx69PdRALr/
	 JwZqDK9N+gt9ix3TaPUvujeX4yy/K3m8bSSBvc/U9rDEfevivKp6UiGYWiAezh9kBZeIE
	 5DGtd7izKY9IbIx0OkrpXSNnI2DD4dLO9KD1OyA2mmlFshgo+1+2kQCIEf1sSS1girg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801655;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MPGD7o8XtPK7IccvaW3qzYWKZzgGNWYlioutnxpxaxE=;
	b=k894pPGCliLhkTsHOLnRR2dyaJBHdFDCJ1S26ETsFEUFsycALsKKipPxz9vPEKY+lWOQ
	 aLm2UqEBTnBQxmUhsyr/jAneclbSijD6Z3SZLUxjU+7ACSlGcEySlVPyCxx58XzWM7N/c
	 8O72gmraxl/VC9RAhu9ja/yb0ijvN3myN9brgi6vYbmwClhg9//R9FO5RG3LYYALL9nsX
	 HCt9iAWgodKTpIjvQZ9OYUuFkaE4Bwq9qzjBQpqld1iQOV0+hHQb0qgfuH4usNo+bSVlI
	 GYNWGC3okTMJB2WM945+FJQmEwgsSoog3sI9xGOoRRp/732US5IeM6MsSzzMDiyb/xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Zk7VdADT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5087606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Zk7VdADT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF311F00919;
	Wed,  4 Nov 2026 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801654;
	bh=MPGD7o8XtPK7IccvaW3qzYWKZzgGNWYlioutnxpxaxE=;
	h=Subject:To:Cc:From:Date;
	b=Zk7VdADTkMzF2hs7jS24yT/OBWz2LMf2D/u1EqQYzQLay9bKNkvFsd2jujZ6pNBg4
	 7fZqTotE5womEFnNwaRypbaDhvWN3DBpRjo1jcZbQZnKlOzWMce9IdO1U7KHx8LOGs
	 S7XD09iJ3zZbiH3Mo+dTiiwe6Kvu18qtUdnOWNiw=
Subject: FAILED: patch "[PATCH] rust: dma: declare cfi_encoding for dma_data_direction" failed to apply to 7.3-stable tree
To: samitolvanen@google.com,aliceryhl@google.com,dakr@kernel.org,gary@garyguo.net,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:14:12 +0100
Message-ID: <2026110412-blemish-tinsel-f7cf@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 7d109178cd644268326cd31702ed46c7ac8bb300
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110412-blemish-tinsel-f7cf@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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
 

