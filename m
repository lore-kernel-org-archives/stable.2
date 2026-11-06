Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976455;
	b=hr19S9vIZTpdAYLp4lydDZWRAYNvQjtRVk4WQheZaxz3wdovwVExBDOD11WD3mRS0EAc
	 cyK9icllM1CMXQCENV76Qw4m6liOZxQ36uvbTB5un0N/wN3j7ZTZpQy2kQ7rl+XwKlD14
	 MPgRlaTobboABuNff02be0WPyAX+sxyzZArfEkHurCsBiyenq7p3vHYEA6iiS8ejILEKu
	 ARC7v2y4xaaNRmaaON4aKIFY1g+BFIwvgB9YjGQ5CquOW5quNz+z3hvh92Mnc2zujO8LM
	 ezPt73vu5rRgqhEoPQLMHAgk//UI2K5vE1dYydZNieEt6EmzOKcvgAlPGPvUYP7mTzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976455;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xqAuwY/TL+BcedBckgp0tv6REgFwcmgVuU2aavyOybQ=;
	b=kEFLH16zJcQTsquddCKzC/GvcBsfU7hbCQpx9EMP4laqXGyQQaZ7fuHDBopIhEa+gEvG
	 IQQYbB+3n8gzk9qTQ7/9b9gzH5XXg03mvSZheBRNbOis6uatsNXqqWYO2u824KQvH9gPb
	 G3dI9vIAckfQkaL49wXxZ9xWumGqJl1qVpZKw23x/KDiFMSobQtMozNpvXPv2hONI7KEV
	 GcsgqS6Bys+7iyJm7zggQPntumLenFYeixt77/aRfzRsnq41oAwXI6fW/prmtlUpM/CZ2
	 0FgndlcvC8O1FbT+OjgAqLuFXrrt+EvRABxvEWSj/euA8zkPwzFuqG/qk3lVnYrPKUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOEFGPjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3A606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOEFGPjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D991F008A1;
	Fri,  6 Nov 2026 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976454;
	bh=xqAuwY/TL+BcedBckgp0tv6REgFwcmgVuU2aavyOybQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TOEFGPjDTkwvNeSldgjmu2DhGoJlnXUB81c7CWloKT25XSBLaMVR5u8cIylQLh9gG
	 U5Y5w78PYPqlVEl/cDUUkw5V1XatZ44qW/fRhu1MDYxGbQ/oIeXcbHbsP19wcNqesp
	 proUv8HFFZIo6PA+++RM7WBDy2BjDsB7unMbDDV9CAG6kIsdzoqVIkzRaNJuXsurUP
	 y56X6qfnomr93NfmCLmhNoiQKt0tytC9PerqcsLjBVLfIEfB3p+FuBvTjUbbprpKhP
	 MidxGyAnS31C8f6ClNbcDZY4+/ZlTeibqR5wZf/Nno/Cz9koQ27hKitbm82pftXu7L
	 MSYcGkF+Y8L7Q==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: aliceryhl@google.com,
	dakr@kernel.org,
	gary@garyguo.net,
	ojeda@kernel.org,
	samitolvanen@google.com
Subject: [PATCH 6.18.y 2/2] rust: dma: declare cfi_encoding for dma_data_direction
Date: Fri,  6 Nov 2026 15:47:21 +0100
Message-ID: <20261106144721.29080-2-ojeda@kernel.org>
In-Reply-To: <20261106144721.29080-1-ojeda@kernel.org>
References: <20261104223318.627233-1-sashal@kernel.org>
 <20261106144721.29080-1-ojeda@kernel.org>
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

commit 7d109178cd644268326cd31702ed46c7ac8bb300 upstream.

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
[ Replaced bindgen's custom enum attribute option with sed
  post-processing to support older bindgen. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile           |  1 +
 rust/bindgen_parameters |  1 +
 rust/kernel/dma.rs      | 21 +++++++++++----------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 3f1abad648e6..d6429e68949f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -368,6 +368,7 @@ $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
     sed -Ei 's/pub const RUST_CONST_HELPER_([a-zA-Z0-9_]*)/pub const \1/g' $@; \
+    sed -Ei 's/^pub struct dma_data_direction\(/#[cfi_encoding="18dma_data_direction"]\n&/' $@; \
     sed -Ei 's/^pub struct hrtimer_restart\(/#[cfi_encoding="15hrtimer_restart"]\n&/' $@; \
     sed -Ei 's/^pub struct irqreturn\(/#[cfi_encoding="9irqreturn"]\n&/' $@
 $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 6f76fdcffd58..a5d547dc8e8e 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -24,6 +24,7 @@
 --opaque-type spinlock
 
 # enums that appear in indirect function calls should specify a cfi type
+--newtype-enum dma_data_direction
 --newtype-enum hrtimer_restart
 --newtype-enum irqreturn
 
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 4ce9e5d7f3dd..b6c73db358ce 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -267,25 +267,25 @@ pub enum DataDirection {
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
@@ -297,7 +297,7 @@ const fn const_cast(val: bindings::dma_data_direction) -> u32 {
         // CAST: The C standard allows compilers to choose different integer types for enums.
         // To safely check the value, we cast it to a wide signed integer type (`i128`)
         // which can hold any standard C integer enum type without truncation.
-        let wide_val = val as i128;
+        let wide_val = val.0 as i128;
 
         // Check if the value is outside the valid range for the target type `u32`.
         // CAST: `u32::MAX` is cast to `i128` to match the type of `wide_val` for the comparison.
@@ -315,11 +315,12 @@ const fn const_cast(val: bindings::dma_data_direction) -> u32 {
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
 
-- 
2.56.0

