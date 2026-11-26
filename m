Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686837;
	b=TILGPUmJqkJgzojxZ9/KkMvX6H6SGiTVExZg06x3DdqREs6HJAUDlfCjoOC1l7QL5zX5
	 WdG7IC1q8W5mX9HJqdm2M3wgNGqh5JZLNrU2D+6V7NTc5GojKtrS6gzjPuLD2vXRkrVo5
	 M7pfQKFFU0q8FJBoSADCY+xNv9yFktyJSwdW5GCYsxhXC7QcVKgX3XEpFyeILrSnzyinf
	 fhPOQyyMjn1jDGXtqgLUD4nwd7Wb3i3k2Mxz0zwlM+XyCieVY2b46K1WEh5wtXKu30468
	 dDTX5S0IiRa3w0L/MYISU18t6Z8bG1m33jkP4p9TafmkhZqp/T6cSjX6kNE1ERXh96g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=u48y0OLqOodJSHIQV9V4i+aU8NY40KHRYStELJqdcHk=;
	b=E3eSKyMCMrtYOqfRzyJVmNxjfohm1jiG8BlHB3DaL1FyuzrfMpX6GQqiDNj6LiLVwcYP
	 t26GtNFCLus2/XuD+sprw5QKkvem6q3F1jM8F1qIetB4ijooSoI9hdpRcl1d0dO1IWnJE
	 Cqhd33GAT78gXX3B/bGS2Rn3f75uo2p25QDiQyuDuk4BENyvjvSRZnR1tt5Y18vRsheIH
	 dS71qXIYjV9wKMAxPWTP1Dskuc4JG/BWztjnPSYIawOzJmRRDYHtsosLOcJlI0XkFUJol
	 VyD9vq0V4JSiubAvTpfzI3S+scPv5T7WEDkBimNAsYrCOiUQnkWsl8uwJdBVrnN8NnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nTdItjeI;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C67606A6A6
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43C67606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nTdItjeI
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c504b52eed3so662469166b.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795686836; x=1796291636; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u48y0OLqOodJSHIQV9V4i+aU8NY40KHRYStELJqdcHk=;
        b=nTdItjeIIq7zynFdd2iwVMgY5acmN/Nbx4/SNYy5A/aHZczcWNzvjggwfhzQU5LIxk
         QKWhMOWnjKx7s1hElyCjwd5pVTEoFv+5qDkoK0XGoNBFtgD7glZ++6cbS/imYIAz8yjF
         IsFcKII3M7Buunrpm3kZn4ETj0Lbz4DMoCDHXeg/pS2jb0JglmXVpDCgwHIpCiJeP67b
         F4+2obXBC9pU8R2MHX9197YWh53G1tnIKY1njf8F7Ztnl//R37D27vLUMZlzjy+rnaF0
         DMr1sNmNNWHUVf3c1rzSGCvl0AmE7q+i49kOV7CoKuLEWmeiVI+6wDS1tCSiG5sNsWzy
         E/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795686836; x=1796291636;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u48y0OLqOodJSHIQV9V4i+aU8NY40KHRYStELJqdcHk=;
        b=WC+bLsV3MBxlvStM7qXNppSnizIT5RPmzyGCcmUSYrCBkkcbduoXSaugmYcBDBPLBQ
         9nwk1HaOveckpCegrKymvhelIYRsHw40Vo/MmGpHFQASpWepl1qsP6ZWCmazsHayYoR/
         CGDViHa8wBmTwaw1jE8x1s7U/o+/pA6HDGQu5ALD3B61GqXksGlRax6Msiutq7ACZi0T
         xtYXRYLvNTdjEZGHivuGJvZr0keMTvQlzrS8kEkTgdh0ZtKm1NwH8SOLElKoFllWR2cw
         V+t24ePqVA4O9vxMfnJnGpHONUM0SZbcqveLCuTu8yTwnaeHbtcVo2oHDcp/SD4hfNlg
         xwgA==
X-Forwarded-Encrypted: i=1; AL+hErEqyQR5B2RUVI57CqkRNuFbJI/kimehKgXds697WAO/1CC4QLLF6PWMj0/mhP4f4TKGVFbFCq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9n1Ocjdc/yiX9wWod2sH1TCfDTbTrplZ7mMFZYjMjKC75b/KTR
	DMVsITBakTffLjNgM3EzWxrdid5Ud9XpNWXRTglIMxDfksXYT0TXAoGTGLPGVMPSoRxDDtS99yV
	m2tUe677QZqaFWGLxTA==
X-Received: from ejio6.prod.google.com ([2002:a17:906:2e86:b0:c40:3bc8:4248])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7d91:b0:c49:a539:aa45 with SMTP id a640c23a62f3a-c513aad1ab4mr1477760966b.42.1795686835314;
 Thu, 26 Nov 2026 01:53:55 -0800 (PST)
Date: Thu, 26 Nov 2026 09:53:44 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4594; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NCx9UhreO0GUK4W4X8+2LoSw4QFPKnkYLrS6rvNN26c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBrCAGqv9gsyLc/RqHfKhmc6uMit22B7FH23gCGk
 UyovOQM5eSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCawgBqgAKCRAEWL7uWMY5
 RkU6D/4qKjckxUIRjlavMiF0XC3J49TyV0c1QnvMLFjf4Maq0gmtaqDOVlAV9DfZyENNDBIsW5P
 Zgq7UoOR2iw68Vfd2WL1hP31HoW1NE+zZnsrifDS+Mkkour/yJdJL7atvB20ZAoXdyUHzjIZn/G
 1Ma4IHhscKT+uGHFtBzaX+QHfmhZoTKy7M7WRiSrMI2gwTjEZhGISzIr6VXRXUvA3Al+9qiKHQk
 2whfHhiRrfH+at9g5meajidboJ2yPL5d+xAJ7wegtE/XrxD0XRsk3a06bKfgpX1eDwWOoNRUD+t
 cIgK89icu1qFTl70E5BTXv58/4yBc+xJcRkEd6Qt9N++A+Ax+TFLB3CLlAqMEot+eOizjHShgMI
 //j8W8Gki4gbm3Sk54i2y9pGaUwbr2EZ9PsqmWjrDENaiJ414aT2qBx3uj6o9Ob/6pl75YxOCLV
 YASKf8OpcRRysLCLjBvqd/LJgcgyzUDUPiD43vIemH9+S5Sp7fAtQdYG8pXSw+3AP2AITNWqp16
 FXd8uEwtckiP4YAHGXHHGZ2kmOYlQ3pjfWK+W93a6+ON+YwNXOzrkpzdS7ZkrbM7p3GI4SRLx8X
 MCdaAynSKnej4JqeQvfl8Q71wPndV7m9YY3LtMhzp78dKjo0kGWMQU/+23RbTm9A+ACz68z1qTb 9L0hT12AG1jSyQQ==
X-Mailer: b4 0.14.3
Message-ID: <20261126-binder-32bit-fixes-v1-5-22fc21baf6f8@google.com>
Subject: [PATCH 5/5] rust_binder: use u64 for node and handle reference counts
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

On 32-bit platforms, node and handle reference counts currently use
usize, so an unprivileged process can overflow them using repeated
BC_ACQUIRE or BC_INCREFS commands. This triggers an overflow panic when
overflow checks are enabled, or wraps around and corrupts reference
counts when they are disabled. Thus, use u64 for node and handle
reference counts to prevent overflow, and saturate the UAPI counts
reported via BinderNodeInfoForRef at u32::MAX.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/node.rs    | 22 +++++++++++-----------
 drivers/android/binder/process.rs |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index b27554aacc95..33547b8e71c5 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -129,7 +129,7 @@ fn did_push_strong_zero2one_wrapper(&mut self) {
 
 struct CountState {
     /// The reference count.
-    count: usize,
+    count: u64,
     /// Whether the process that owns this node thinks that we hold a refcount on it. (Note that
     /// even if count is greater than one, we only increment it once in the owning process.)
     has_count: bool,
@@ -409,7 +409,7 @@ pub(crate) fn update_refcount_locked(
         self: &DArc<Node>,
         inc: bool,
         strong: bool,
-        count: usize,
+        count: u64,
         owner_inner: &mut ProcessInner,
     ) -> Option<DLArc<Node>> {
         let is_dead = owner_inner.is_dead;
@@ -506,7 +506,7 @@ pub(crate) fn incr_refcount_allow_zero2one_with_wrapper(
         }
     }
 
-    pub(crate) fn update_refcount(self: &DArc<Self>, inc: bool, count: usize, strong: bool) {
+    pub(crate) fn update_refcount(self: &DArc<Self>, inc: bool, count: u64, strong: bool) {
         self.owner
             .inner
             .lock()
@@ -519,8 +519,8 @@ pub(crate) fn populate_counts(
         guard: &Guard<'_, ProcessInner, SpinLockBackend>,
     ) {
         let inner = self.inner.access(guard);
-        out.strong_count = inner.strong.count as u32;
-        out.weak_count = inner.weak.count as u32;
+        out.strong_count = u32::try_from(inner.strong.count).unwrap_or(u32::MAX);
+        out.weak_count = u32::try_from(inner.weak.count).unwrap_or(u32::MAX);
     }
 
     pub(crate) fn populate_debug_info(
@@ -808,15 +808,15 @@ fn debug_print(&self, m: &SeqFile, prefix: &str, _tprefix: &str, hashed: bool) -
 pub(crate) struct NodeRef {
     pub(crate) node: DArc<Node>,
     /// How many times does this NodeRef hold a refcount on the Node?
-    strong_node_count: usize,
-    weak_node_count: usize,
+    strong_node_count: u64,
+    weak_node_count: u64,
     /// How many times does userspace hold a refcount on this NodeRef?
-    strong_count: usize,
-    weak_count: usize,
+    strong_count: u64,
+    weak_count: u64,
 }
 
 impl NodeRef {
-    pub(crate) fn new(node: DArc<Node>, strong_count: usize, weak_count: usize) -> Self {
+    pub(crate) fn new(node: DArc<Node>, strong_count: u64, weak_count: u64) -> Self {
         Self {
             node,
             strong_node_count: strong_count,
@@ -857,7 +857,7 @@ pub(crate) fn absorb(&mut self, mut other: Self) {
         }
     }
 
-    pub(crate) fn get_count(&self) -> (usize, usize) {
+    pub(crate) fn get_count(&self) -> (u64, u64) {
         (self.strong_count, self.weak_count)
     }
 
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f23dbe98d688..719e794757a2 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -231,7 +231,7 @@ pub(crate) fn update_node_refcount(
         node: &DArc<Node>,
         inc: bool,
         strong: bool,
-        count: usize,
+        count: u64,
         othread: Option<&Thread>,
     ) {
         let push = node.update_refcount_locked(inc, strong, count, self);
@@ -579,7 +579,7 @@ pub(crate) fn debug_print_stats(&self, m: &SeqFile, ctx: &Context) -> Result {
 
         {
             let mut refs = self.node_refs.lock();
-            let (mut count, mut weak, mut strong) = (0, 0, 0);
+            let (mut count, mut weak, mut strong) = (0usize, 0u64, 0u64);
             for r in refs.by_handle.values_mut() {
                 let node_ref = r.node_ref();
                 let (nstrong, nweak) = node_ref.get_count();

-- 
2.56.1.839.g22a8290db9-goog

