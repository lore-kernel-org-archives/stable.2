Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA823C4168;
	Fri, 24 Jul 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892022; cv=pass; b=Df8lUPK09Z/NTGqJFoCT98biln1rq1O5w/z1w5jx774Vh1VbB6ZsYcXeX8itql+uLDc3qEe93VnWxiE5oxlfCj2tvA3AmYOyP/iVIPqqEXXd8RRxCyJWF0YLr+n9rx2Y+uRD1fNt+nUVnfCD/s6URlZAfK+iE7fEvBkyEBu0V4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892022; c=relaxed/simple;
	bh=XavdgeStjkSn+NtOzy1VzvhIdvnRqKWIpiZg7PYiBkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFeKyAyNGaQbJe6gOe0kzPeQcuc3E0P2O/3onOe4IalMKWO1viUdt9h7Cr8igUNKVaLL7l52eIIOYQ1oYWb9LPxfo40iqE+S0NZf0rTYfDA5MPtcTwKxScLlTFTBLKF2poDvoM/nsoKa/vZiLEtm22dNJWRnQcMlfIVEnkcXsZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=L+H3VNeT; arc=pass smtp.client-ip=136.143.169.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="L+H3VNeT"
ARC-Seal: i=1; a=rsa-sha256; t=1784891977; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WxPVJoFjx9aPW0sEzulSo/o2iOUo/SPFHf9JRpn/CHRkN0l3GYmIHS+sd4A0UcMu9WEeOmpq5zGkWZhySwFC6cDFDF6eWwxGV12xSmto09M8zBRn658LfmUHAqoG6+snlTRZa/ftTM+gTtTw3wq0FU7kaSPDWPS66EVWW3iILsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784891977; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W6Px5a6vVEkCpmv2n7tsMwFBT/kgVpoaE4enTXtDgmU=; 
	b=ROZMjYeye3qoGAdquDGV0hBL3cuwH+p0z/xvd+cd/GNOi1T7lG0E/B9J2JG/wAqaekE9Gtz8VJrCqrQkMva/OAQuoQl0R4hq4AJt/R+zt2kLchTiCP40AKA8ORlECm3dDgdXHz3hCjFZ/kAWGQzI3YBczvW9YWzJN06ZWioq2eU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784891977;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=W6Px5a6vVEkCpmv2n7tsMwFBT/kgVpoaE4enTXtDgmU=;
	b=L+H3VNeT16t3mLP4ZJdp264ECdGPd8iZPOZhxJua5dkDZyOReolTcgF/sVstQcyO
	QcXUtBewO8CQBoqUWuKUJSPwxBJS8vTYt9Wx4DLrSik1xy47PHpeeIHaSjNM6+W3hrp
	kCjTX5JjpAqmrasoB0J8Poh/zHH6nH5Gtc9RZ3tM=
Received: by mx.zoho.eu with SMTPS id 1784891974746726.9116488134342;
	Fri, 24 Jul 2026 13:19:34 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: guoren@kernel.org
Cc: arnd@arndb.de,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] csky: alignment: validate address before emulated load/store
Date: Fri, 24 Jul 2026 13:19:31 +0200
Message-ID: <20260724111931.76451-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The abiv1 misalignment fixup csky_alignment() re-executes a trapped
unaligned load/store from kernel context. It computes the target address
entirely from user-controlled state -- the base register read from the
saved user regs via get_ptreg() plus an immediate decoded from the
faulting instruction -- and then performs the access with raw supervisor
ldb/stb instructions in ldb_asm()/stb_asm(), without checking that the
address points into user space.

A local unprivileged process can therefore execute a crafted unaligned
STW/STH whose base register holds a kernel address: the fixup emulates it
and stores an attacker-controlled value to an attacker-chosen kernel
address -- an arbitrary kernel write, i.e. a privilege-escalation
primitive. The symmetric load path is an arbitrary kernel read. The
__ex_table entry on the asm only recovers from an unmapped fault; a store
to a mapped, writable kernel page completes. The existing rx/rz != {0,1}
test is a register-index filter, not an address bound.

Reject the emulated access when the fault came from user mode and the
target is not a valid user address, using access_ok(). Rejected accesses
fall through to the existing bad_area path, which delivers
SIGBUS/BUS_ADRALN like every other rejected case. Kernel-mode faults
legitimately touch kernel memory and are deliberately left unchecked.

Found by inspection; CK610 (CONFIG_CPU_CK610) abiv1 silicon has no
upstream emulation target, so this is not runtime-reproduced.

Fixes: 081860b970ad ("csky: Exception handling and mm-fault")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 arch/csky/abiv1/alignment.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index aee904833dec..19337946e0d5 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -261,18 +261,26 @@ void csky_alignment(struct pt_regs *regs)
 	switch (opcode) {
 	case OP_LDH:
 		addr = get_ptreg(regs, rx) + (imm << 1);
+		if (user_mode(regs) && !access_ok((void __user *)addr, 2))
+			goto bad_area;
 		ret = ldh_c(regs, rz, addr);
 		break;
 	case OP_LDW:
 		addr = get_ptreg(regs, rx) + (imm << 2);
+		if (user_mode(regs) && !access_ok((void __user *)addr, 4))
+			goto bad_area;
 		ret = ldw_c(regs, rz, addr);
 		break;
 	case OP_STH:
 		addr = get_ptreg(regs, rx) + (imm << 1);
+		if (user_mode(regs) && !access_ok((void __user *)addr, 2))
+			goto bad_area;
 		ret = sth_c(regs, rz, addr);
 		break;
 	case OP_STW:
 		addr = get_ptreg(regs, rx) + (imm << 2);
+		if (user_mode(regs) && !access_ok((void __user *)addr, 4))
+			goto bad_area;
 		ret = stw_c(regs, rz, addr);
 		break;
 	}
--
2.50.1 (Apple Git-155)
