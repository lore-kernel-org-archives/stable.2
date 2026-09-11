Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031844F55F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127371; cv=none; b=BhLucrOK38UI3R2CDKJ2/Pig4z6THsUQPIZt9WxoVVo+yRgZ+zWB3ZqcIneFqZGzfAwU0w60spUrXLUPxnSpuaLBnccgBDpAlaRYKoomox6eCWlstEqHPFg9u5q64rMXu8u9dE1+A8bKUiVbBRiSfkc4hMrGux1kI5CdTFM/cRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127371; c=relaxed/simple;
	bh=i5czo4/AUOkgqQ0Ck7/l1eyRn8V59WCWRg8zoDc+N/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWIvByUK91Ufoc//8twE8FniB75N1IEMjDvj7fujqr4Kz/eK/TG0aacBIlq24rG81NNM+oh4k1r5FTE32HSpi2y2ihe+l6cJXfdCy5A2KAM4hiKt/kweJrvaHQZj8+j98pCuxiCKRqDQts//0x0U8hd3cTIBsGoIY9Pyv8npHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRLGZW87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRLGZW87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4944E1F000FF;
	Fri, 11 Sep 2026 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789127369;
	bh=lyELf7ZIh+jyjcM+s7dcVtewe6aO1QMRDTYT4/xmr2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRLGZW87vgMZllcGEy1ehhGInf1yDKXk6K/6gM6r00I13wJN3U8UUO1t1J52Z+7j9
	 S0+IFyIkikDcFS0Q2NkHyqEb9Bwf58cPGoLv/hjYgDR9pj0M7gOjCtYr3Mde3kxNOh
	 KvfhIh0zvG8Xk0y3dWq/SoIVcJX4TjRTiZQrAYZqZpzcpxMCHFLnwt6mIJKT5/tI0n
	 83gM9/Rbp6EYyQssPsy9OU3PktL1LMW9Udbr4tx/wn0yFPBnakvjX7Z99/UOfsIqEJ
	 IschlPd+8CT9K6rJZUJqPsY5BvzvePKY+VlpJVaNtnojL3MXRyr/hK7sJnUUy53F5g
	 zsvPNCcKlIqvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: s390: Zero initialize data structures for inject_pfault_token
Date: Fri, 11 Sep 2026 07:49:27 -0400
Message-ID: <20260911114927.461866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090923-freestyle-whacking-e0e0@gregkh>
References: <2026090923-freestyle-whacking-e0e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Borntraeger <borntraeger@linux.ibm.com>

[ Upstream commit 4e2c7f7cbc27418f9a290399b986c1b85ff93b90 ]

__kvm_inject_pfault_token() only sets .type and .u.ext.ext_params2 of
the on-stack struct kvm_s390_irq but the full ext substructure is copied
into the cpu local variable on inject. ext_params and pad contain stale
stack values.

Interrupt delivery only uses ext_params2, so nothing leaks to the guest,
but a host user can use the migration ioctls to get to the data.

Fix by zero-initializing the irq struct.
Do the same for the inti data structure.

Fixes: 383d0b050106 ("KVM: s390: handle pending local interrupts via bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260805110455.7200-3-borntraeger@linux.ibm.com>
[ Adjusted context for missing inti_mem and ret declarations in __kvm_inject_pfault_token(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8b31d482712fe..ed08e2f3a8ec5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4705,8 +4705,8 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clo
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
 				      unsigned long token)
 {
-	struct kvm_s390_interrupt inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_interrupt inti = {};
+	struct kvm_s390_irq irq = {};
 
 	if (start_token) {
 		irq.u.ext.ext_params2 = token;
-- 
2.53.0

