Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90B30D3F6
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130599; cv=none; b=rOd44Bq6g3Xe3zRQ9GErPYicbdiRehxm40bp44Jijw2+ZT47sJysWMAUm7e2bjp18AsEUuY2ztU2LYLR0KyFOV9rJu3sH8iQLbdBO30CYVD2n1FoaixT6kb/wVDrr7q+6fAHzkEVRultXJU4x8goWADaknBFBI0eZtD0brDgLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130599; c=relaxed/simple;
	bh=SN1R1gwM5CzKZlJ6igMmgVbhw2pCk4spP/qfX9xQH4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giBwJyPXLs3dYrw1l+g4BnEfQjFnF4ikyPrlE1TS81701Ai1ldAEgxMYGRhnFnj35+QzgKuHz4orSMIdg/x8wMt8Zx6fFIPfiLwn6wLppYU9cldAK/XEkzglIdlOHdaLnyQTVfwgLzCQhZcmXd+9EU0+BqFyeguRv6Q+UH5TuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3Pjp9wp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3Pjp9wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7021F000FF;
	Fri, 11 Sep 2026 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130595;
	bh=aPpMlgoh6JSu80mQNgchp2CulP5D69mi2GhT66mwvQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E3Pjp9wpseNZRbbdNZcAbpFOtk8A50o42wK/8lxdBK2ddyYxdWwNRv0/zpttlTONH
	 jXwsmScYGrC/f3CrNgfaHhDvy6bUx/un0w7nG6V5IMzwRtdH8/FkRnnuTJtXTwkYUt
	 bd+MrzqgFxlZWFhdPx2YAXLPXJO+kb2yNgtZvCOX+iHfH5dMo00+M/U10LN0ZTmLda
	 l8Qtjmoq0atc7ABMc2l1sMFyyTw2SBaSBra+CXIznjEoiVpi/05TkI7CgDFM4HIxp9
	 vefjbeDl4e50v5Ryn1tke/PDIRobnIGQa8c5pxBdI03rFOMfTo0pCKsYVvcJT+xipV
	 /oIQsSQFBMfVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: s390: Zero initialize data structures for inject_pfault_token
Date: Fri, 11 Sep 2026 08:43:13 -0400
Message-ID: <20260911124313.637781-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090924-animator-theme-7c73@gregkh>
References: <2026090924-animator-theme-7c73@gregkh>
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
index 15cd2c22ed003..c554c0b59f857 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3932,8 +3932,8 @@ long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable)
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

