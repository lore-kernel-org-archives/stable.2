Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795116792;
	b=sBZ3vPYrOdjnvonvXf1OTGvCXhNudepsLxLGefZJd+YL+X43Vtw1vxaEuDQR58T7gTuD
	 QlWQZPBEJR29+jp8T2xoWc1J9YBFzoBBEqWrcnUaligw5mZplmJlnfvXjy9ZSFvV1a/A/
	 0atzIemchk2MShOyjDQI8LJjSAqREd4nlFOSbO57Dcc9fdEsoxu2QcCLJRPRMGfqYo1B5
	 zpMxarhKX523xhm8uMblCXL6HLAvFYqrM1/+FipC2u9GJSZMawZ2uKRmv61ePLDb5eh1K
	 U6i9jnos8sTHHqgEubAzj9fMuDLnuvRArXDMrihazpeOzSUAG/sq4cqQuHTXgwmproA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116792;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WGZIV5m2cbvbePOeiIg+KiTHMRAB3Uic6UzxfiVJO18=;
	b=pLiB/NIvWKx5LwDdfYncM/CIDVviV5Ri5/JkfrOhaonwMjKk5Ub9Ei17jRU29rhQ1Ee7
	 aGwAVFOxySjZUZLVZLwsnC94LPUhTyLhxNGlRVEkrlY/FppuHCQ0SXRI8euoNcaWlJBFB
	 2AVy38jLFkNPiw5pPDFoT5Fxs5mOsRihizNtYjQLnGdTWJPUK/KazMGc+A2YxLdQexnod
	 zohE3MYV/BqM9t4BQwix6qoJxA7E8fpkc9dnq1stU1UWfydf/Shhq8tpXQdYxduyHWk+V
	 7ESSa3d8gCKxSTduvPHvtlHRWjMkvffWIG7oARXA7mE2M+OLLuwnl1uRJ2DOOqkkY2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CucyDZlR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03908606A325;
	Thu, 19 Nov 2026 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CucyDZlR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795116791;
	b=JzzkP1wU0sD+uxGw1mbgpzGvG4568neK3HJVNpKCRrH9XT1Qj1hnyQ0UyYZK6PBOVJGQ
	 EJsQ0Mxl2VCFLiqHN89rczLHvLUyPaS9kl4fOniH6XxDsVgX0rXYs09WYFzKL9PIr9rl6
	 f/VpisBKl289ljpvKGorjy+V7ZcFb3QjfZBE9QC0oagjQKhLiXCugIsxNk85+U2LubAId
	 ikmkFHSmoBwqr8phCXdDd6ll+KAi6RuBRWcAfPtJoeGZ4an4S7ehU9ZOwuHhHIpUO5sDq
	 7+dy40+iNizBBptQIi1cuxdzXY2IegtyxJWNHmaa1wYQ8bs3pI4epvgvBGOLZkTMeXw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795116791;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WGZIV5m2cbvbePOeiIg+KiTHMRAB3Uic6UzxfiVJO18=;
	b=tT+rAAw0mCmFvg2DV4NoO4i+vYCerxSxAivIBSRhmDOeKwSOUmmyPcW/zcjMUEoQlcWi
	 Fu71meN9Ro8p5GTqGPWxYcWwMw8ta3SZ7S7/CiXlzF+FKKoR1S4WF9WTuL0yEwNGF8Ign
	 mO8SaRk30RinvisqXI0ec6iWWQDRWVlsXezvn9I7VBCmdbVmYVlWFjJtFmAHKiIkwOeGS
	 B2Vp1z4DeYjz+ii9tNc4HNdAGiJl3yMY+k9ctjFZA/l1c77hh2m6R6tgNhzP6COBzpier
	 /BuZhU43f+Qj6XuKOmKh0M6jv5oNBOcB1rCri5JgaJ8pFrpq9sdNKEYIK/4xbu9C6jw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1CD361F000C5;
	Thu, 19 Nov 2026 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116791;
	bh=WGZIV5m2cbvbePOeiIg+KiTHMRAB3Uic6UzxfiVJO18=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=CucyDZlRvHRwelO89vMwPheVStVONocuuKtat57mgZnbYC/zuxbSDG4eAey7y3ngR
	 PHMaUUbqLC+OUlRoUbweRq8nFmTnUHP8DKoCKFIzhQX6MX/GvqpV0nqBoaGbdYD/4i
	 z8Wnj9HeZTkmNg12GssWNQemR8L5B5VwSr4r8eAQPXiFVQ+sqiIhYBsJJFoPbsubAv
	 NjYB576L7jvTatnp4GjUGxHQ0FvAYO451w9Hu/gKx+F5jDsOEUwkkQenLkI49EEcSa
	 PNvXiq4l6SelmP++fRr43aRRj6qwagUx+oBZg+1FPP4vHumkG40ItvlXQ865TsuVw4
	 RQoAyS2oHMvMg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8AB864B3D5;
	Thu, 19 Nov 2026 19:33:10 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 20:33:07 +0100
Subject: [PATCH] rust: bindgen: Preserve sched_statistics alignment
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-fix-schedstats-bindgen-layout-v1-1-0599dd230ffd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPJO/2oC/yWMQQ6CMBBFr0Jm7UQKCMGrEBdtGaFGC+lMDYZwd
 1tdvp//3g5MwRHDtdgh0NuxW3wCdSrAztpPhG5MDFVZtUqpHu9uQ7YzjSxaGI3z40Qen/qzRMG
 yry+mbeqmKztIjTVQEn794fZnjuZBVnI0P4xmQhO0t3Oe4soSSL/OIbKgp03gOL7Z1CCbpgAAA
 A==
X-Change-ID: 20261119-fix-schedstats-bindgen-layout-0935b6434707
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795116790; l=2061;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=enj6BUb4oRB8IE5yaVUAOv95G/2SRaL0ZVC/+tCgiiM=;
 b=rQs8CAyFUbEYInVCLSgBlAGhq9GORNTkDMbyOCPP/Y82UJOutZ4Y4O+RHHUn0zap6mInfzx3F
 mgGOYtrg3ocBebFeSG9AqC66FX9RCOAL1h+Uq3/fJkAHzUUVQtnKBAD
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

With CONFIG_SCHEDSTATS disabled, struct sched_statistics is empty but
still cache-line aligned. Bindgen emits the empty definition without
that alignment. On affected builds this misplaces fields following
stats in the generated task_struct. In the reported arm64 build, Rust
Binder reads the wrong pointer via CurrentTask::mm() and rejects mmap()
with -EINVAL.

Make sched_statistics opaque so bindgen uses the C size and alignment.
Rust has no callers that access the fields of this type.

Fixes: 313c4281bc9d ("rust: add basic `Task`")
Closes: https://github.com/Rust-for-Linux/linux/issues/1269
Cc: stable@vger.kernel.org
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
Jules Mercier reported the layout mismatch on arm64.

On arm64 with bindgen 0.73.2 and CONFIG_SCHEDSTATS=n, the generated Rust
binding placed task_struct.mm at offset 1168 while the C layout placed
it at 1208. After the change both report 1208. The layouts also agree
with CONFIG_SCHEDSTATS=y, and the Rust kernel crate and Binder driver
build with Clippy in both configurations.

OpenAI Codex assisted with the bindgen change, validation and drafting.
---
 rust/bindgen_parameters | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 5bab3cf063360..2686687555af3 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -26,6 +26,10 @@
 # warning. We don't need to peek into it anyway.
 --opaque-type spinlock
 
+# Bindgen drops the alignment of empty structs. Keep the cache-line alignment
+# of sched_statistics when CONFIG_SCHEDSTATS is disabled.
+--opaque-type sched_statistics
+
 # enums that appear in indirect function calls should specify a cfi type
 --newtype-enum fwctl_rpc_scope
 --with-attribute-custom-enum=fwctl_rpc_scope='#[cfi_encoding="15fwctl_rpc_scope"]'

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261119-fix-schedstats-bindgen-layout-0935b6434707

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


