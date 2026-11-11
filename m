Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440680;
	b=5K1x87e1KHKmgDk5XZJO/m36ZsE3WopEezV8ovZI+gIiBJIqZ5G35Wvn5g5J7AHF1xNb
	 JLy4DBc4OHlmsoVKYFQmR954BhVcBaxOxFyYj/FUA+rKcAJ6z0kPildZfiXJssirXa7V+
	 X2RiaDjMLlpFMsE4vqDuMwBKi3Qc2xdrICZxXVeL+T9BX6h0Zavb0X/9ddwjfQx9q8XGf
	 k9AcGn+YbSmUOZb1mJ8z9kDDvDQ7Kh2XU4qRcEvlmdtnJFZM8irL3TP4uPQktSGwzyIco
	 NNjlCFvOIDSoGGkAM4ZIDUcgoSbKMovlB8sSYw+WjF98nJsAGv+vxtoKz3l/gp2YAHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440680;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hRtRWsNDT0E4ihZ7rKloseKdM5fQEm23ENBT65T6JSs=;
	b=h/kzzoAqurJt7IbQDktLVWXyJw+2K0ius5U7mtX+3fo9f/R4iA1+z/UjJZioLuNLlt8s
	 e+cUxe0VzVRbCp9Q2LixiCCNXxmeulWoxVNcXJ1a/Ym8mqGjxox76TWaTl0McjT4JiqhE
	 IwooIfI+MAWfwR4QpOUQZ3lapRg/TF2akxC2/JAuVx6zEVoCu/AVNtlbb20vQWobEL+bI
	 cgCYZNVIZKkdjQXiXo/m+SldlQ5vTRZG2575W/QAKL+Q90f2sWuCCjsf99nUey/0oIvsg
	 O17DqtgN77b32HkHTPn9omLl7tYjJjdkpqGf3tqEdmoBJv3T/UuLYm8JD125MYIaMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOUCFFZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C110606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOUCFFZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2291F00A05;
	Wed, 11 Nov 2026 23:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440680;
	bh=hRtRWsNDT0E4ihZ7rKloseKdM5fQEm23ENBT65T6JSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VOUCFFZHcPiX/ANMXF/QKOXDbvzB06BrGL6kaDgFOmuiE7XqlJNPRJDIHOX4t/wE6
	 hD4nS1ZY4N2aTjWtzFjj84+HywL0P24HmCs6CTaDuydr+zF34c2u11AwmRjE2DqEi9
	 x9y0Y/OFrFyIUVzYlyi9OmxHPDnZwOA6iiPJ8u/Z0KWYbW6qwdO0pIiAT0SKUqpyQZ
	 VIt/Hps/p/DXrIJ6s3uE3Jyf89QuHeZEnLrfIoCc3R/pjJ+k1lm5oDNOCSx9nJRO43
	 fPVMjMDzdY+jWA3Jl6wDjq+t5ir+00lWApO1IwUuzoJ4X2YQCZoVCABR+b79zionWd
	 15rrOuo13BRFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/userfaultfd: wake waiters when registration modes are removed
Date: Wed, 11 Nov 2026 18:44:38 -0500
Message-ID: <20261111234407.676040-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201823-failed-6.1-4eee9c389b07@kernel.org>
References: <20261109201823-failed-6.1-4eee9c389b07@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 4eee9c389b072e161549d46dcb1ae10b0222717e ]

UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
faults that are already queued. For example, switching an anonymous
range from MISSING to WP leaves a missing-fault waiter asleep until
userspace explicitly wakes it.

When a registration change removes a UFFD mode, wake waiters in the
affected interval after updating the VMA. The VMA is write-locked at
this point, so no new faults can queue under the old modes and woken
threads cannot retry until mmap_write_unlock(). Waiters for retained
modes in the same interval may also wake and refault.

The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
with both read and unread fault events.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-25-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: inlined wake_userfault_range() into userfaultfd_register() using the existing wake_userfault() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 59c4fd41a35aa..7a23fa700ffd1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1450,6 +1450,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	do {
+		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1504,6 +1506,16 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
+		/* Retry faults for removed modes while the VMA is write-locked. */
+		if (any_mode_removed) {
+			struct userfaultfd_wake_range range = {
+				.start = start,
+				.len = vma_end - start,
+			};
+
+			wake_userfault(ctx, &range);
+		}
+
 		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
 			hugetlb_unshare_all_pmds(vma);
 
-- 
2.53.0

