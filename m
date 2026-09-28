Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270C4F3EAC;
	Mon, 28 Sep 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613904; cv=none; b=iYjVXCvUHZBYDD3YzNkgwlLHLNGRNRpwzMlmTyGoBT6jEdhVoolJm2ZIJbiQ7AhxS44RXISbU+ycPFgZtkaiIEWnjC7eAzk/NXeZKWOUa8nuQfCEcIclw3YDdXMhPDXSysVvjQjUxTiRUnb/Dxjej6PQx9VHhVT828v4H49PvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613904; c=relaxed/simple;
	bh=Yz3DUS+IFvQo6aPzOqW2+myeNbLjYQRjqsyOdwh045Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDmqKcBMQlnH2qjJSiVx+JvrK5/tROsBSSQ6pdPFQFvKUz8uBNdxeoCdcsf27bDcp/s5S+duU7EYkwDHrpF1qCilAaeQTdnZyDUqsUww5ie9GR0fDN7s7FyK0xzAofn6u2VTz3Qmncgj1Iu/OxqvNCONvG0d1JIDFyVXcf5yrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=HRPG+nat; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="HRPG+nat"
Received: from fedora ([104.28.225.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SGijNq080644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 01:44:51 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=kTp+YcUkA56lS5RHOmzs9i27URDUDkF58ooHz3G3/6g=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790613891; v=1;
        b=HRPG+natydrtra/gDOD21fTifb5q6kiF5D87CWfRXs0Q2HwI/19vcvR3Fbc4Zh2f
         FTlMPIOq7Y7hDf0pHeM/vfWc3elxujxM4TO8CSH/m4hsaSJF6CPJxLJJRQxosXIg
         PDeQIGcPsDBjzQ/splQaNkGM8GapUUC0QSEUBm1ZCQ3Itp0qxtwwvoI0mD0hE/gO
         hRQF3/amtDurjXBHHklEsPksWGna70EXqGnCUuvJOen1Tc9yTmOiRAR+b0gFOVd7
         jgFwQAXiTJQPnljIDiAHcUXgfbJzENX5wQCPkpMJ5+By9UUHRGkxnuu5s6Zn3AZ8
         +PfrN1vAaSAPI7FyRx44Rg==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v4 05/11] KVM: X86: Calculate quadrant when !role.gpte_is_8_bytes
Date: Tue, 29 Sep 2026 01:44:21 +0900
Message-ID: <20260928164427.4699-6-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <laijs@linux.alibaba.com>

commit b46a13cb7ea1137b2e01dfaafcacd5cd79db8390 upstream.

role.quadrant is only valid when gpte size is 4 bytes and only be
calculated when gpte size is 4 bytes.

Although "vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL" also means
gpte size is 4 bytes, but using "!role.gpte_is_8_bytes" is clearer

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Message-Id: <20211118110814.2568-15-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f6ad81b5e637..62e9a7db0183 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2094,7 +2094,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	role.level = level;
 	role.direct = direct;
 	role.access = access;
-	if (!direct_mmu && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
+	if (!direct_mmu && !role.gpte_is_8_bytes) {
 		quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
 		quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
 		role.quadrant = quadrant;
-- 
2.53.0

