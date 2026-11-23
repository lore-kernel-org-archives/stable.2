Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795452224;
	b=PEjz2TlLpmZ2H/PbroPmy7x3h3JleJmKaS+Sxvg1DIGaQzho6NN1BjDwQr1d7kulgKzW
	 +N7hUhvHjjFVl2ZlZj6T08TdlQScZN5dzVzneEfLfYRs7hWLuvXfpPFnhqnu4aBJj4R//
	 9E2oZk3zCpX9sw07O1Kid0dNynB7UmnM4TiRDiRTlPOilvjtbf4E+VymguSgfRhxGaCcc
	 xinTRxQv6bfGnXMn0zhbZZJjXYd2P0z4uYmp9cnydTDMWf6fAYZlRLMpgb0Vfy2lYpQ1H
	 OROUwPa8Dd78XfilkqDTqfWGH7tOBhdcQwrUKv3wJNWbnZlVDxGjZMk8dGN+DhIffSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452224;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wZfV6HS/qzi3zEP4C85VmFm7lcaH2SB1YkYHOpfY92E=;
	b=366+cLVFXE1zxpXjBpfkBRXdQ9VYYpnMPk9DO4NEJtOIOR7TsgY8s3TSuHaimUTpY5DL
	 KKdjrygB0ccVfRnACi2sw4GP17zHfhyM99DRhtJpKtjZ/N9wo+ptF/BV5faOTwZoUPLhA
	 OqQ7apJJ0/6yWyrIH+hUgH96OoUViLcr6gFzphJVwiE5hO+Nmf8AWJMqoAOoeDmT1YDDS
	 hfaadRnx7CurjlRsG53og0fneW4cRBYVFPlSZmMtb7875rF32hjhthX2rTsqqeMuJpgJr
	 n1HIFjsxmY9E0y6P1uKlEDG8jVHLeEPVE5mW6F1+qW4NFGWeDN9R9suTKdbvic7bxdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJt+T1Qd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775E606A31E;
	Mon, 23 Nov 2026 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJt+T1Qd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795452223;
	b=tFlFlpw7sxx4mA4ML9ZCBpU/UO90iM78QXM/lmGKH7/PsBPWZLvT8VLoAKuKIhyFdkiD
	 cqusHPth84teO6y9/dxKldwMMzTWaRRV0BAvlOyE+I/gCLtJofP738/bjpj8SiZQPzk9s
	 sgfmm7Ky7TWszwqI9jPWe2oriLz2HA1A91yEkmrCX8A0xYRd1lpAc7TociKUMq06y+7Ux
	 gLzRLF0NoSpC9mkig/+NLmGg8VYJPshxaf6NpCgxWkAprZuYa4gRIlxzboeRuXi1r+lWL
	 0am8/AtNxz7QMVPVUzKLTmqdM8IXlz1BOr7CEiBiyf2NQ4yKqquwQlLMBZv3A9T9A8Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795452223;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wZfV6HS/qzi3zEP4C85VmFm7lcaH2SB1YkYHOpfY92E=;
	b=D/GODMlU2BhpJTUuzISNzojAKzvhUJZi++Q8m59q27NxIe/eBRxXOrLaVvvmBDUaO1H7
	 hpMMS7+qRU5VLTpjjhuTxgNl276k7EdOzXIJ1M92pk64U0RY14xyS1XVwcQaAL3aaZFZF
	 fmFjpCzgc1YFMRWKFEfKMV3ptr1Oz54HHC8HVHSuRhUl+/Pmyb90KGO8xEjURFYPYC8Fu
	 bI3ML/loAHoWAtZWY87vToSYWnnMZ9L0e6lWhBp0M8ojF0sI5TPsi++unlN5Rfnelbc3U
	 3rBMddNnh+qgFBhZI5AI/zHS/HfZLwOtGZR0IGlQZT22aE/7PLXSYgNKXiUmTT59B9A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF3381F000C4;
	Mon, 23 Nov 2026 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452223;
	bh=wZfV6HS/qzi3zEP4C85VmFm7lcaH2SB1YkYHOpfY92E=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=kJt+T1QdLLvMGg/11I24/sExriindH5912O4v3P7EusxvgEGJcFZFJ8r7BBb/QJlw
	 KeewuQ30VEXNTR20xHisdWx6LWejOsx64gyARJBHI269TIPTGP//z91BIfe4E7NKPJ
	 mCh12a5IvG4oqdUbGyFY60tXzWCHE6Ace7f6BOpqL5f2WyYK6onRd2oC5Kqc2G1y6Z
	 YMG22nmZYp1HnRRl/F7NypnmDEqcurCDyw7s5oPDQa9rYJ8h0NuB6LAXAXoTbxRg3C
	 wrVvEXJdX+7N1QxYzovftRfXkdAqyOO7jdtKBEHdbvH1mN8OUHL6LJzuOWmZSCgtWG
	 qydqz9t7EoGbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4D18A4C55A;
	Mon, 23 Nov 2026 16:43:35 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 17:43:32 +0100
Subject: [PATCH v3] rust: bindgen: Preserve sched_statistics alignment
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
Message-Id: <20261123-fix-schedstats-bindgen-layout-v3-1-ef7e83c32b42@gmail.com>
X-B4-Tracking: v=1; b=H4sIADNtBGsC/43OQW7CMBAF0KsgrzvFdkKQu+o9qi7G9iRxRRzkc
 SIQyt1rw4YdLP/oz9O/CaYUiMXX7iYSrYHDHEtoPnbCjRgHguBLFlrqTilloA8XYDeS54yZwYb
 oB4pwwuu8ZJCmOdiubdqjPIpinBOVh7v/8/vIvNg/crmitWGRCWzC6MZ6Ws6cE+G0TwtniHTJt
 TQGznO63leuqmLvDloVKJAHY7zXjex7/z1MGE6fbp5EHbTqJ03LV5oumnKtphaN6ZCetW3b/gG
 FBdU5TwEAAA==
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
 Carlos Llamas <cmllamas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Jules Mercier <jules@les-mercier.fr>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795452214; l=2194;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=BRNvzNrAOE8SCJYrQje8ClEabdCLlvZJpmkzsmH/zvc=;
 b=hvkGi2TTDZ5rlFhFS9Sj0TO7Yv3elJsXxiwEWUuUy1v46bGKVG2U1hni9P6f4iGj54YI5wpcU
 02BmMXJGqIiBrB9Eps8k5D56uMKDNX3AMpRzcykH7ZknPalLBFaALjG
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

With CONFIG_SCHEDSTATS disabled, struct sched_statistics is empty but
still cache-line aligned. Bindgen omits the alignment of the empty
type. Bindgen 0.73.2 also stopped forcing padding before over-aligned
fields, so fields following stats can be misplaced in the generated
task_struct. On the reported arm64 build, Rust Binder reads the wrong
pointer via CurrentTask::mm() and rejects mmap() with -EINVAL.

Make sched_statistics opaque so bindgen uses the C size and alignment.
Rust has no callers that access the fields of this type.

Reported-by: Jules Mercier <jules@les-mercier.fr>
Closes: https://github.com/Rust-for-Linux/linux/issues/1269
Link: https://github.com/rust-lang/rust-bindgen/issues/3549
Tested-by: Jules Mercier <jules@les-mercier.fr>
Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
Changes in v3:

- I generalized the comment to cover any types listed below it.
- Link to v2: https://lore.kernel.org/rust-for-linux/20261120-fix-schedstats-bindgen-layout-v2-1-1c42e4a996ae@gmail.com/

OpenAI Codex assisted with the bindgen change, validation and drafting.
---
 rust/bindgen_parameters | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 5bab3cf063360..ef9379312fce9 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -26,6 +26,12 @@
 # warning. We don't need to peek into it anyway.
 --opaque-type spinlock
 
+# Bindgen omits the alignment of empty structs. Bindgen 0.73.2 also stopped
+# forcing padding before over-aligned fields, so following fields can be
+# misplaced. Making the types below opaque preserves their C alignment.
+# https://github.com/rust-lang/rust-bindgen/issues/3549
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


