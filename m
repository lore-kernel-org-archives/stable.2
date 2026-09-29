Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD04FD7B2
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688680; cv=none; b=GeQykrDExHZcca994Nzzt/DKPUH3AF7fhmjmKKlZIaN5Uj4Ghbfm5q0FqXEppV1eFON2avtCkW4M9cs+p2wQz/tMqKDuJkScbt2w2clu6/umTNXwcnv7QkHjI7xjrDf+xZZ4nqUHdi9sy7msfA1b06EbWax6xkXVE8M87Exco1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688680; c=relaxed/simple;
	bh=nu4nmJ4a33yS9VXGtGzV2Hcw/2v0pF13vAK6CqVopSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI8VTpz//V8y/qakRfhCQSYACAehdX6zd1dxA1Wam4VpVNBtiWLzkCfienEhbf/DgUbv1jDPlqFRWJ3a57i+yudzt+E6qrrrZzebfV1l4zhny1MvADDL4cGQTtMQfBy/FdrLIoceCldXSSFURSL8BfBcQnPBRB3PQr+M1VK2Aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4isD6wm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4isD6wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA1D1F00898;
	Tue, 29 Sep 2026 13:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688679;
	bh=tiuje6PTvAlkD0kY8vSyb35VZmBXAPwlfOFp86TY8ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4isD6wmSQVSX8ACvyfDEe9TUW5f6lSs5vhrmU/TXVYN4WCTvofPLwaNAWCdnq6nH
	 Dged1pXZ/qCS2YTYZsJz3itcbG/VKyQwyWnYMLthg53OM+JUup/L1/fsj/nadIP/Yk
	 QohL2qQP294CxY+t9N6NkYuC8INye0yvEDchBg3hDnPLFf6jrIcdPJ+vqGacMgRgck
	 +LmDqQzhw4VixKEmXZwLxfft4N8ZTBMiVFfWah+Ih+Pq17QSpePo596rQSUuLgOTx3
	 HaX7rx9TGriL4b2UhtRv8w2X96tdQvYIbJ8pT9zIJCJZjBGLUiSYRn+yECv2bnnqhd
	 LDCOqBWqjCjwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] x86/sev: Add internal header guards
Date: Tue, 29 Sep 2026 09:31:05 -0400
Message-ID: <20260929133116.3502913-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929133116.3502913-1-sashal@kernel.org>
References: <2026092939-ecard-twirl-6094@gregkh>
 <20260929133116.3502913-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Upstream commit f01c6489ad6ceb8d06eae0c5123fc6cf39276ff1 ]

All headers need guards ifdeffery.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251204124809.31783-3-bp@kernel.org
Stable-dep-of: 6c43c72748ff ("x86/sev: Make vTPM SVSM calls preemption-safe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/sev/internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/sev/internal.h b/arch/x86/coco/sev/internal.h
index c58c47c68ab6f..af991f1da0957 100644
--- a/arch/x86/coco/sev/internal.h
+++ b/arch/x86/coco/sev/internal.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_COCO_SEV_INTERNAL_H__
+#define __X86_COCO_SEV_INTERNAL_H__
 
 #define DR7_RESET_VALUE        0x400
 
@@ -85,3 +87,4 @@ enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt
 u64 get_hv_features(void);
 
 const struct snp_cpuid_table *snp_cpuid_get_table(void);
+#endif /* __X86_COCO_SEV_INTERNAL_H__ */
-- 
2.53.0

