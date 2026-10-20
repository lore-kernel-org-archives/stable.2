Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484931;
	b=F20Fx7fy9c/aTvdur0ECvb0F9ZzR72z4G5czI/yieQ1SyOeeGVBcaUof69AbUjA7odFh
	 Fbin9ntWWPrJN3BA3T/7Y4HVtm8hQGTdmyEq2DLjOxoQsvf2C8bKDKU1IBX9xaAXEUXqm
	 f+7tPSmDV7cFFcH34COeL+5q804CV211uLPdxMvjTQMbz6uk3F2YEbpM+Tg2ifJPD5p/V
	 d6pqlELMunCH/gKiZPOlUPFrDqUgErdaRMtE+lW4uv66TU+a/cPEYXkAHiG8YGhUppMEY
	 YFCPkSWtP6EsItEIcaJ1jNnB8umpgmv8t2ddpO5GCM4YlGVgiyoLgNBQFfbvemns/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=V2g7pl//bRYOezc7U12uFpcQJT5vXcVW3O60hvJjYx8=;
	b=NhufA7wTQyli1THp+cTea1vR2esPe6DMWIfl7hQEsFlYrooP8BYxcj6ElFBJr8c8nXaM
	 4D/e/0idrXC6XRDRbzxvjCvgLUe9lScokSKfJFEJxEXQa1A3Nqxo4sz/JxKMS6h840Zt4
	 /9b01hBkRqElFgV+Sp2OHeStOvGz4WPLoDkmNL6DsfUoTLva4yBuH4Cg1IF3VwfHni6ih
	 REX8Kj6UeMNEG9nhR6TGgwOYsZa1m49dK/zv1QO82DHAOvGKpAm8+ciDobtnhx18qmgYV
	 frPgba4hFj6rFeryIffxHeY1KpEsFW4uY5i0mnZiCtMJXkNc9+Hw1Tw7KUJuBsIvNMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aWx7wiq+;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D8606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D25D8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aWx7wiq+
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c3613c35145so317841766b.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792484929; x=1793089729; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2g7pl//bRYOezc7U12uFpcQJT5vXcVW3O60hvJjYx8=;
        b=aWx7wiq+/DasFoQT5M8519XstD7g7rHGmFqLXXHdq8UD18VN9WqjYyA34BoF3bviQk
         B4vvUdvpU1nBOVOREmo/lGovnmsq5GOEYTlp0gi0+dCNgmjND/0tELpEXF5B6CaDrOzf
         6GyOIQnac4Qor8u0mLpD7RGet+FS+RdigYT7YL8G1kXru0m6uwW7tYVoApw+/OUZP23T
         2YEeef/FlcNPtoqsCNMdJ8DYahu+lJYagijueQiyz3REb+omSUsWSIy1dn2sIZHMIbV6
         achWG0sNI5isjwq+U6cbpUGIycUIMLysuIq7Nje8co+27sgva0Rmu4jk29uFVT3Fwr+B
         mk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484929; x=1793089729;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2g7pl//bRYOezc7U12uFpcQJT5vXcVW3O60hvJjYx8=;
        b=v959Zb3WKC9re8zR2SvyqliFU77OLmoMm3zU9eKt6y1Sflqu6EUq+EfPcJ4VbiBr0B
         jcbq0uy+TLnLNGdBE9yMVHxVoNC3GvXoDyHqn5sqMApvuXIc0C4xMSJ4o+987yu/A/c1
         u4u7Gqzoncs4DSPbPcn9N4PQHurh9fxkVCuKHm+Qm/F6f1ArFvadPqeUMyazblshvJP6
         sd3S1YwRarP7hTIypErqgO4TpXqZKcAImq/IBjeFJ9Eov60YtiK2P5BMXBEKW798u7b1
         D64TYnxm2kqvKHx7XXcChFtSfDQd9vlDzIi1e9PJR+wJtAskqEqBtRGluHfh69riBiCd
         cX1w==
X-Forwarded-Encrypted: i=1; AKwUvBw28QaC7GoFbgRdPspf9yZuLq9XHYtepEONoNN4aT3CfDJr/uh37oK6x4RoRd6/phIMcLT1i8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpWcbzUYh73gccb3Ww4DQQdlCAz0GxjI+K73fC5etmY3RDm58F
	55hzz4ktO4RwLPcgLhsD0R4Wuld9LELfpGgeupjRB4j7J+zBAK+ukb68SB6x/5cvkHU0i0rw7K7
	+4WJAdt8WcWFUdPNeCg==
X-Received: from edqi6.prod.google.com ([2002:aa7:c706:0:b0:6ae:1861:6a4b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f583:b0:c2e:52d6:1fb7 with SMTP id a640c23a62f3a-c419e63d14fmr694939266b.22.1792484927900;
 Tue, 20 Oct 2026 01:28:47 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:28:37 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADQm12oC/x3MMQqAMAxA0auUzAZihQpeRRxKTDUgVVpRQXp3i
 +Mb/n8hS1LJMJgXklyadY8VbWOAVx8XQZ2rwZJ1LVnCcPO5IQdFibzPGhfsqXeOhTx1Hmp4JAn 6/NNxKuUDO8/rdmQAAAA=
X-Change-Id: 20261020-fwctl-cfi-encoding-70766ce0a03a
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Rk+J0lAUscPPohWGJvG/cv0f/YYZw8raSTrEMula37c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq1yY6KvWn2YmrQl+P2uToSiXlz+Tw9B8f8Vp2f
 JJ4S+QCG+eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatcmOgAKCRAEWL7uWMY5
 RmKpD/9vmUdmYXdWFu4sxnhmjYGpEa/8KUAAPN5eTas3arHAO6iEHKznNk2FbhezzCVJ+g51T1y
 tqavjmoRtuwFxTQiSSsMKuWrS22j9AjOZIrbIGc5whhovmn4ZgSIXl62woNPbtd6xhAzU67u/ag
 TYAa1bgpObC1VJyQfVuPIFKkpF0QyUnGI8pEYvUIWyJnQ6KrfpzK7zTD2rWGIEMQH56IdGWqVjD
 vmS06VZGJ4aLLuNwfxLv81UbJLp/yVDoB0+nvbzRLXwgHAk6n1uaRLPSCrLiEcmVMIM+eYlIy5Z
 MnAbuv+95H4EWHTQuyrADqknsijLkCoaN3Mwaw154jKjxMqZmpI7H8CrpxXgJzfZc3LQatk/Uci
 YXwA7tO/eiWxGGzusDNnL8BAEkmJpat2f/I0OI+YdcKCFgoVtv930Wh2UGT9IY8rDAHUbQLcojW
 JfFbCXJnhA34sq/tInGOpTWYNNdCJiFO/gTbxvEUQyGPfguALE0PIcE2VCct1jBK/rNg9nQphLF
 WIe8S5uSBIVEs5P60gf0ICdy54Y6uFRLF3vuVzD3xIKytasfcvYN7D51cxxoL5gc3bgx2kYgvEU
 jc+eQzDxXXf3ZmkzDW4l3G7vk8ipfZFJWCox2JKuaaGDYWXy1nuVGA/tO4E8aGHThjUSaI74UCl 19zcIugQEmSgilw==
X-Mailer: b4 0.14.3
Message-ID: <20261020-fwctl-cfi-encoding-v1-1-ebb30d1500df@google.com>
Subject: [PATCH] rust: fwctl: declare cfi_encoding for fwctl_rpc_scope
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, Dave Jiang <dave.jiang@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	Jonathan Cameron <jic23@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, stable@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Currently, VTable::fw_rpc_callback() takes scope as a u32, whereas C
calls fwctl_ops::fw_rpc with enum fwctl_rpc_scope. With kCFI enabled,
enum types are encoded distinctly from integers, causing every fw_rpc
indirect call into a Rust fwctl driver to trip a CFI failure. Thus,
generate fwctl_rpc_scope as a newtype with a cfi_encoding attribute and
use it in fw_rpc_callback().

Cc: stable@vger.kernel.org
Fixes: e052daab94ee ("rust: introduce abstractions for fwctl")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindgen_parameters |  2 ++
 rust/kernel/fwctl.rs    | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 8402b0c93545..e4f8c07743a8 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -27,6 +27,8 @@
 --opaque-type spinlock
 
 # enums that appear in indirect function calls should specify a cfi type
+--newtype-enum fwctl_rpc_scope
+--with-attribute-custom-enum=fwctl_rpc_scope='#[cfi_encoding="15fwctl_rpc_scope"]'
 --newtype-enum lru_status
 --with-attribute-custom-enum=lru_status='#[cfi_encoding="10lru_status"]'
 
diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
index f29244fb0d1d..b7778e4d5ee0 100644
--- a/rust/kernel/fwctl.rs
+++ b/rust/kernel/fwctl.rs
@@ -53,13 +53,13 @@ pub enum DeviceType {
 #[derive(Copy, Clone, Debug, Eq, PartialEq)]
 pub enum RpcScope {
     /// Read/write access to device configuration.
-    Configuration = bindings::fwctl_rpc_scope_FWCTL_RPC_CONFIGURATION,
+    Configuration = bindings::fwctl_rpc_scope::FWCTL_RPC_CONFIGURATION.0,
     /// Read-only access to debug information.
-    DebugReadOnly = bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_READ_ONLY,
+    DebugReadOnly = bindings::fwctl_rpc_scope::FWCTL_RPC_DEBUG_READ_ONLY.0,
     /// Write access to lockdown-compatible debug information.
-    DebugWrite = bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_WRITE,
+    DebugWrite = bindings::fwctl_rpc_scope::FWCTL_RPC_DEBUG_WRITE.0,
     /// Full read/write access to all debug information (requires `CAP_SYS_RAWIO`).
-    DebugWriteFull = bindings::fwctl_rpc_scope_FWCTL_RPC_DEBUG_WRITE_FULL,
+    DebugWriteFull = bindings::fwctl_rpc_scope::FWCTL_RPC_DEBUG_WRITE_FULL.0,
 }
 
 impl TryFrom<u32> for RpcScope {
@@ -539,12 +539,12 @@ impl<T: Operations> VTable<T> {
     /// - `out_len` must be valid for reading and writing an initialised `usize`.
     unsafe extern "C" fn fw_rpc_callback(
         uctx: *mut bindings::fwctl_uctx,
-        scope: u32,
+        scope: bindings::fwctl_rpc_scope,
         rpc_in: *mut ffi::c_void,
         in_len: usize,
         out_len: *mut usize,
     ) -> *mut ffi::c_void {
-        let scope = match RpcScope::try_from(scope) {
+        let scope = match RpcScope::try_from(scope.0) {
             Ok(s) => s,
             Err(e) => return Error::to_ptr(e),
         };

---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261020-fwctl-cfi-encoding-70766ce0a03a

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

