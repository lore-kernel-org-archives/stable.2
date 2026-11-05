Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793919589;
	b=K/a15MYGZi754FarcVzHkuMuvAbu/D6kD4657TMQFc+/B3C7Cs3km5IGGtEaGwwRAgYa
	 2HlLhfqg6mpoVxkiBkfbl1ouogOe60kqNlMqVbZCP+IFR1b+PWExYwI0BeYEfP5Dj5ZLp
	 Q6xPKZjnH1g+/Exo7RH+SIudr48r21nulBcd4XwjNsVuNNNUxnewyPKmXcj3xOX/fPL/T
	 ou7poaAn5L7F3f318wMeGOIVPONBsiueGENgv+wJk+t+kwRYan2rfNCSVARUZQQI0466i
	 A65weZik7PGgT6+yxiUk7zdSLCxWLD0+wbDhrZiJ4z8zdUar+O62Hkg5DZMNZqSj/ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919589;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=WdrkeWA5q5NZPAjfL6pBJnTm0PpgBinSg9ZwIQcwiok=;
	b=gJFa6d1DvzoBqM5p2vT/cNgE5nplP6hDzUl/5RgWGoSo/oAsp6oEJVLZ4ciU28TxYaz5
	 WW7lJ05OQfcMKOro0H4G/DeiyCwK1JS75XHWOflwcs30IZ6WwsKCurC7XufRlL9CoIzs/
	 fb5Kd7FGSW+nKSs58hiJyl3rSOWvhg9exXysrKHM7aPsAfHZSXpNCecPXDBuFjCHxQbEG
	 BRKsO+iIZrhbIryimizDWK1CKftgX9eNU+kbRO5ZKdhQunH1Y3t01kZNEj9GZBTS5NbkK
	 9q5XlgXGXVngrAUX975S3ZCFF+qfFKdiL6l7NI0eSshDHEyqVfFv6CFyrU57gu7s5eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMwS3fBk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD3606A328;
	Thu,  5 Nov 2026 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMwS3fBk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793919589;
	b=c9NqO4TLKq8l8MlIVHnPqbEdRZp+Jw29wdoJpCzGZ7UujRxvDLRGrr/pjlKadlkkh3Ce
	 9tTjYcH9Qo4viqI52ytB/ex1Lx3JmaJ3LOzW9MzvK1PvA1j/kTJP+Ju+lrsPFiXrvfisC
	 zpvfDxlVPJo3NWDCdaF0+MOwP3ucct3DcVHI/Y1gvUO9qdIzXLthwNR6u0Dg/z/SMrIJb
	 QYilag3/xl7QiyDT3P6+UkDVFlsDt8rVirwr48nNiFLu2WQSwti2fCNBrEprZ86zBN9Ac
	 1vfdJH3C69dIAJx7WANfUvE0q4g7L1cgtSThjSV3xBKp2HQOB39pqipCXVjr+ZgO6fA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793919589;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WdrkeWA5q5NZPAjfL6pBJnTm0PpgBinSg9ZwIQcwiok=;
	b=Fd/+r7gNgqW5CdYXwsZ7Ph2X/F0EHLCdXoBBp/vJuiCg1iKBKdWaemsKUoV1NiJeZtju
	 UeQCq/R/7Lbj+H5aRpgPu5dH2LuVylLzgRQSfgGPDSp/DEydJT0Pt3B/DacVIwJzOagZt
	 qs+akDh/PhAmQhnEsJeFTJTCqcP6D1+RNPuLvG6+oXmwN9m7dB+hDRqgMM1ivGvYujfYV
	 xyqq/fyROxtcYb2W+hdPcUFM57HHfchQCqeqPDYkvYdP7inILwPVNh160vEEx1syuKFfp
	 u09gYwfTSc3geo1SaZrburRsEWnZQCR/rI8onqNT+itGo+I7SUQJjwTT7wqRLHB97hA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 734191F008A2;
	Thu,  5 Nov 2026 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793919589;
	bh=WdrkeWA5q5NZPAjfL6pBJnTm0PpgBinSg9ZwIQcwiok=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GMwS3fBkn+OeUvvKnPShuxiZ22PTxPS1f8st6c77zZ6JFMfiYLVby47fsqjjEY7Zh
	 PFT0xp0SqIoloSneDaRID4E0sfIVG5+HIT330tABYzGzLGoKVKSRm6VH4Lipr/vTQr
	 nLugk0fF16Bw1OIcqaQQeFjqoWOdP9rmai2bYHI3N6/QiD/os/W9Po0sD9xP7qLIet
	 TcEwrFCkOs+nJitSMMBbApV4fwlUZjeSmJX3O3THj269prBuR39jdwPXlWmksRPRC2
	 KVvpr42SboHsFPuzSnrYe6fr11yW/0DJ5Xq42p13mtOX30Q7eFXpr4vLn4nE93QX1f
	 9T+f6FVpXp7/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5E3A45AD3;
	Thu,  5 Nov 2026 22:59:47 +0000 (UTC)
From: Xuheng Li via B4 Relay <devnull+xuheng.cs.columbia.edu@kernel.org>
Subject: [PATCH v2 0/3] KVM: arm64: Fix the hyp pool size on large
 machines, plus two hardening patches
Date: Thu, 05 Nov 2026 22:59:47 +0000
Message-Id: <20261105-hyp-pool-and-map-v2-0-44a6ca90190b@cs.columbia.edu>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQqDMBBFryKz7khGiNaueo/iIjHTOqAmJFUq4
 t2beoAu34P//g6Jo3CCW7FD5FWS+DlDdSmgH8z8YhSXGSpV1URK47AFDN6PaGaHkwloNTeWW0P
 UEuRZiPyUz5l8dJkHSW8ft/NhpZ/9E1sJFTa6tla7K6u6ufep7P24TFZMyW6B7jiOLz0pGeS2A
 AAA
X-Change-ID: 20261105-hyp-pool-and-map-b5e7be9a1191
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Xuheng Li <xuheng@cs.columbia.edu>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793919587; l=1934;
 i=xuheng@cs.columbia.edu; s=20261028; h=from:subject:message-id;
 bh=CAOlYbJH00SZ0i+KHyNqqm2Di8dpY/YNVVprTboRUdo=;
 b=c1X/nyAlwsURpe72dwNz4wB9yo7f6Xx60mT0l5jS7LojUn/cgTuWMddWKw/TsCvXlYu41zll8
 XqC4R8vzMtCCkFzXTCd4CKrg+/ZfCIGYmt4qkNKIPTZebWkZn+MPamQ
X-Developer-Key: i=xuheng@cs.columbia.edu; a=ed25519;
 pk=L1HVV+goqxYmEMO/OXakL6uf9isSpgk2QrLlFqyZ2Qs=
X-Endpoint-Received: by B4 Relay for xuheng@cs.columbia.edu/20261028 with
 auth_id=1349
X-Original-From: Xuheng Li <xuheng@cs.columbia.edu>
Reply-To: xuheng@cs.columbia.edu

Three changes for issues we found in pKVM as part of our research
project.

Patch 1 fixes 32-bit size computations in hyp_early_alloc_contig()
and hyp_pool_init().  The hyp page-table and host stage-2 regions reach
4 GiB on machines with about 2 TiB of RAM; the early allocator then
carves them too small, so the two pools overlap and can hand out the
same page twice.

Patch 2 checks the host stage-2 PGD allocation for NULL before using
it.  With patch 1 applied that allocation cannot fail, so this only
turns a mis-sized pool into a clean -ENOMEM instead of a hyp panic.

Patch 3 makes hyp_map_walker() refuse to replace a valid block mapping
with a table, which would skip break-before-make and unmap the rest of
the block.  Nothing in mainline maps into an existing hyp block, so this
is hardening; Android's interface for EL2 modules to map pages can reach
it.

Signed-off-by: Xuheng Li <xuheng@cs.columbia.edu>
---
Changes in v2:
- Patch 1: also fix the same overflow in hyp_early_alloc_contig(), which
  makes hpool and host_s2_pool overlap (reported by the Sashiko review of
  v1); describe that in the commit message and add its Fixes: tag.
- Link to v1: https://lore.kernel.org/r/20261105-hyp-pool-and-map-v1-0-756bb5d8e067@cs.columbia.edu

---
Xuheng Li (3):
      KVM: arm64: Compute hyp early-allocation and pool sizes in 64 bits
      KVM: arm64: Check the host stage-2 PGD allocation for NULL
      KVM: arm64: Don't replace a valid hyp block mapping with a table

 arch/arm64/kvm/hyp/nvhe/early_alloc.c | 2 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 3 +++
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 6 +++---
 arch/arm64/kvm/hyp/pgtable.c          | 7 +++++++
 4 files changed, 14 insertions(+), 4 deletions(-)
---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261105-hyp-pool-and-map-b5e7be9a1191

Best regards,
-- 
Xuheng Li <xuheng@cs.columbia.edu>


