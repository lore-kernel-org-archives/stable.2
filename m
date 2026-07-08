Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18F434E34;
	Wed,  8 Jul 2026 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511631; cv=none; b=qfXyIKprx2qK2GszCIQ+9bnEyZbu21Zv3j2rAAwOi12qDKRT/rE11PS1ajyseP9BdeVebWiSsHuS5VMlvtM+yVIVx/xLcq6m14aopd9WfGiKXpkhTLmnf3gSCNyCAqyNOK97w37zjqIzRdFIG/0dejg5nhr8QXxaFzfcrLy17uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511631; c=relaxed/simple;
	bh=GFw7D/JMS0BsuGX/tR7HOdbhomGNW/4YluYwoedfrRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s7t2NDv6WYzM1UQCah4HOu/5RUopaGHvh664Zzbz+UFMGZ0tX2lJdBb4f5FmMW8Mlq/VHCH5aiwJn2YIRcV+mANp0tyvTlkAuP5pgtaMSsuJwgIKH1b9+YMM1crl4oMnv9ZPQuKeJC/dblr0EvEyGoH5+loMAfoC0aVPGKqmCQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCnsAKSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCnsAKSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211EA1F000E9;
	Wed,  8 Jul 2026 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783511629;
	bh=rdxl7IdBBRnl/VjmGlLMS0ydVwD25wn/ZqHLovQ6J6I=;
	h=From:Date:Subject:To:Cc;
	b=gCnsAKSY+e6QbI+E+K7+TivToH0yJwdaWxYXBes+wU8hsG0n0ifOMFczy/pA5VyOD
	 c+Fgnq+QddgwI4x7CFLcN3oCn5ymePLeucyEQ8EVgK56u1YAFpw1JO1f+EFZPc20Uq
	 ref8rB2EbglbPiCVHMADGqYvGXCc0SpneRRs6vIKc4tMWPbg2GfwSU+g0sKzrYmyX3
	 Rp1o7wuSniLXA33RteEWnIKrazXENCrXN723ImJ8KbD1K7khmQUCEpTANVDHpiNIvx
	 F/hu+632nGu7qojRmvN2+Ah2GILBmvhw5FVZc/WHtRQqRaE/yjhiK1kUxaWbk1ybxK
	 /alm3AcHuOPig==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 08 Jul 2026 13:52:21 +0200
Subject: [PATCH] rust: helpers: guard dma_resv helpers with
 CONFIG_DMA_SHARED_BUFFER
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dma-shared-buffer-config-v1-1-8c1571000855@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPQ5TmoC/yXMTQ6CQAxA4auQrm0yg4jGqxgX89NCTRxMC8aEc
 HdGXX6L91YwUiGDa7OC0ltMplLhDw2kMZSBUHI1tK7t3dldMD8D2hiUMsaFmRTTVFgGjNEfT5x
 j77mDmr+UWD6/9e3+ty3xQWn+/mDbdtC4iq58AAAA
X-Change-ID: 20260708-dma-shared-buffer-config-bb135fdb61f4
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Asahi Lina <lina+kernel@asahilina.net>, David Airlie <airlied@gmail.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=GFw7D/JMS0BsuGX/tR7HOdbhomGNW/4YluYwoedfrRI=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqTjohxZF84h7fJ2UmPYxqA3vKydhfq68R9bG+u
 XHX9BC8+nyJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCak46IQAKCRD6UCkIqsW9
 0KbgD/4qZPbBYIIzwFdYkfFfWNNcSR/UjYKuc8ShlJJMJuVC+okSfR/t/PEmKH/d5rWhgoZKSQI
 wakFdKarTn2mL5aUUGzxVg3c+XZDhMsbTn7ORMkIXS0xJb/i1Al8lq7zRIvtWqo+yxdG35npfY8
 Br2odXPH9fId8f7pZ+1tWTJNxjk7xHSooaqmHwGJe9Tb8ZvED7IzQq/tdCB3II/Z9gfJDJToBVx
 cefsOFlTGR8bZJ7p6jY177YFeuCrQbK43Q7ayEUpnR2obYAIqpX8kTHt2W/LIV+/74DfhxE0jJy
 EHd49f+i66phQnOhTnAWgSWZH3tHIudzPfcnKC+PmJyHqOOtp+WyAZXjO0lnTVKGFpZF4nqJLVb
 rtLItXxPl7+HQE/ZvaD90Qy+fD2DSUNpSn2m0yZFDRvxBJ2iYD7CRm010mrzqXVePAokiD7tA5y
 Eu3jvLQ8RHO4FMch1BE3MCmfZXUs2qVatz8njLXLJNrNaaYK78M1yVAlcDdETAkEfr8seGYf11F
 LtAH7YfmA88CYenw8iKSvX6vHMtU5LteV3Pb5UfJhy54fF59Z3z9U58YVDHNPKltY6xeb2pZMlW
 lDanf/t1GhoEViAW/wHPWS7921LNLacFViQ/gym8xnBZJ8Y555VO6287s0vXMjWsFdrj1dN9fiX
 a93sMYAhVp+8LwQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Commit 9b836641d3bf ("rust: helpers: Add bindings/wrappers for
dma_resv_lock") added rust_helper_dma_resv_lock() and
rust_helper_dma_resv_unlock() unconditionally. However, the dma-resv
functionality is only available when CONFIG_DMA_SHARED_BUFFER is
enabled, resulting in the following link error when it is not:

      LD      .tmp_vmlinux1
    ld.lld: error: undefined symbol: dma_resv_reset_max_fences
    >>> referenced by dma-resv.h:463
    >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock) in archive vmlinux.a

The dma_resv_unlock() inline in <linux/dma-resv.h> calls
dma_resv_reset_max_fences(), which is only compiled into
drivers/dma-buf/dma-resv.c when CONFIG_DMA_SHARED_BUFFER is set. With
the option disabled the symbol is never defined, so the helper fails
to link.

Fix this by guarding the helper definitions with `#ifdef
CONFIG_DMA_SHARED_BUFFER`.

The only user of this helper is the DRM shmem abstractions, which already
depend on `CONFIG_DMA_SHARED_BUFFER`.

Cc: stable@vger.kernel.org
Fixes: 9b836641d3bf ("rust: helpers: Add bindings/wrappers for dma_resv_lock")
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/helpers/dma-resv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
index 71914d8241e2..1698092b9317 100644
--- a/rust/helpers/dma-resv.c
+++ b/rust/helpers/dma-resv.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#ifdef CONFIG_DMA_SHARED_BUFFER
+
 #include <linux/dma-resv.h>
 
 __rust_helper
@@ -12,3 +14,5 @@ __rust_helper void rust_helper_dma_resv_unlock(struct dma_resv *obj)
 {
 	dma_resv_unlock(obj);
 }
+
+#endif

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260708-dma-shared-buffer-config-bb135fdb61f4

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


