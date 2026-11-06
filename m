Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975894;
	b=kPKcCCo+Dlx1HiU6bW/CsQaxgWoRRVrqY6DxktbbT6bb5owhX6K90ZfNxO2W+rYSKq5j
	 tsV8CSarvMO2a2pe65ANMrm2IFBjiGRIVtSd/EWx4jDra7m+mZ8C6vbD69NuZEdQRitSG
	 UMHfRhV5IXXu00JV6toiZpoctEnn3IhwBCBljNmPrGX/5uvokyJGXOJr4Mm37lvqV13bN
	 sKxgfD7LZDCVKGl06JVbHo6y0LXBhVUt9HLgQyNXz3yvxfq47hRlcYAdLCEU2eI2O0qi9
	 Zw+r58NEi9N8VG4qfpinqwj/6FFAR7onOb79GxyWao4rgLIITLC3xe9eroys7bakw/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9M3mR6gi5e12thTH8juQiMm7sFaEByFVVI8M+Tj36p4=;
	b=HHEif2OoAbWSdSYaENVmd7vIZcgXkMn43Opi6J7X3hvQUbIfSuwBgMtwpoU03Hp/y5Jq
	 PTrOIAodngjUEgWHtWDdA/S0j6WU6W3tUHEmwNKd66s6xCWwbSFROqnjG4W2sAy742a7D
	 Wvlf7K/A/uG5TzBMJKZibVRt1QFrIp9iQxlePWxpqlFXJogbbxWx12mVJdh6GUPaqvFRP
	 9aS9FU3s25xmk3NA1dj2hNm3Ytwb9MgNkxlYIjxp3ThgX6lU9ZOjXMgQ7r7iql/1JPLg+
	 xQZJLrjEFmIwo3Oitq9Na+v7Nl4Qd4S3S6HUq2+Pk+Gif86JYG+fiDdIkPVZvFyC54Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlZxvt42;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD01606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlZxvt42
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D3A1F008A3;
	Fri,  6 Nov 2026 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975893;
	bh=9M3mR6gi5e12thTH8juQiMm7sFaEByFVVI8M+Tj36p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hlZxvt42NUo9ugmHOMu+xYoHg8+l7oDRWUu+1WuiiJH/kbgaxqV0ogaLER9T0Rzom
	 PTk0ZLA+J6LXqlKwfGCXeNIJ5LgZMGzOBJqb97riGTU9rRPOFSEdPuK9elVCLLcgjZ
	 pds7CHkTXBhA465yVfNVY4/J8HgxGZpO4ZAlXzrh2TcKCm8+L9hhGc/sRD+WMvaHHn
	 yaStX3gC60eA9zgdI5tO5kwU7NxR2j+KA6Hc02i5ukb8D7Zmb8wXyjFJsfIJ6bB+Df
	 qBOgI39kLMZyNKb/sC4MgDXnnvQOOCOoTNE7WkOZwDFMxyORPwXjGohyEOglwVWp/A
	 +/i9z/zdohs/A==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: aliceryhl@google.com,
	dakr@kernel.org,
	gary@garyguo.net,
	ojeda@kernel.org,
	samitolvanen@google.com
Subject: [PATCH 7.3.y 2/2] rust: dma: declare cfi_encoding for dma_data_direction
Date: Fri,  6 Nov 2026 15:38:02 +0100
Message-ID: <20261106143802.27907-2-ojeda@kernel.org>
In-Reply-To: <20261106143802.27907-1-ojeda@kernel.org>
References: <20261104201749.480655-1-sashal@kernel.org>
 <20261106143802.27907-1-ojeda@kernel.org>
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
[ Adjusted insertion context. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/bindgen_parameters |  2 ++
 rust/kernel/dma.rs      | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 45f6eb56a1f7..5bab3cf06336 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -29,6 +29,8 @@
 # enums that appear in indirect function calls should specify a cfi type
 --newtype-enum fwctl_rpc_scope
 --with-attribute-custom-enum=fwctl_rpc_scope='#[cfi_encoding="15fwctl_rpc_scope"]'
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
 
-- 
2.56.0

