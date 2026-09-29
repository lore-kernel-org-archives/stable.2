Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52B5293EC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688682; cv=none; b=jQU3e8Q4DDBx1HeaLNZcHHyCfWRH14m34qabbBLN42RFKhysvd1W05HoEjWf6idoSRQ/No2Go2ja89kcjUlyAeeXRZKTyUB2u2FCnxx5vK9GEwl4ua6rloyVxObNmav2z8SF3Q6qnqCYsW5cfSn2s3L4JWKZslW3UYQpwmJhlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688682; c=relaxed/simple;
	bh=e5Zv/NrSevINDmGyETygU9ak3ojM6NKjSdUeiSQIJyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9c364BUTU4/QGcPKI4+HgDSSJ2i1t+GW1PhAZNC8j0QfCAMwJthpJxKnH91OJ/USZiyWJDGb92b1gUkFNGZfnuLtsTS6oMPeJBOXW3v+RX2+H2yaB1+g6y9mHl6xQe4lAoRTxtr9hoZZE9ENjT6f1Kbk3aiYKpFSbLk0e3HObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzpXZgi2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzpXZgi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162AC1F0089A;
	Tue, 29 Sep 2026 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688681;
	bh=dOHU56IyNvWsvOd2DaNuDZVgsBEiCWAKt1qBjHJca48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GzpXZgi2BqgJIrFNxsR1ADwWRkKTMJ7MTxAcFoWITpuqH8zY7R2dCU7MDIsM2oAsw
	 nvxF1fQqPZovQsG/FzcE5xTyVvjZ7WCvCLZFg5q9XayrjPIrPftnjbvCk2bszIeKnL
	 1AcLPz08mq69CSgHEClg5rdbEPTSoEMOsecQwr0XgW0FpaqHcxjeOmrAecmaSYUscV
	 Ng2NdqgEovIvBFT93TX3zRnzjBCTkGFUdme7gyPiUKyFvz2SDh+s9hwCExSV8CD8Sa
	 HtUrbkoyJLkp16zbyZVv+eTvIRmDcWBOZI35dkCPB5L48TNK9yKftrffe1FGKE+d1i
	 OqvAR7syjtNVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Melody Wang <huibo.wang@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] x86/sev: Make vTPM SVSM calls preemption-safe
Date: Tue, 29 Sep 2026 09:31:08 -0400
Message-ID: <20260929133116.3502913-5-sashal@kernel.org>
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

From: Melody Wang <huibo.wang@amd.com>

[ Upstream commit 6c43c72748fffd29dec15cd1f31e9a32949bc437 ]

Two functions in the SVSM vTPM guest implementation do not disable
preemption when fetching the SVSM Calling Area Address (CAA).

The SVSM CAA is a per-CPU structure. When a thread is preempted and migrated
to a different CPU after fetching the per-CPU CAA, the SVSM call will execute
on the new CPU with the original CPU's CAA. Which is wrong.

Move the CAA fetching operation inside svsm_perform_call_protocol() which
disables interrupts around the SVSM call and thus runs preemption-safe.

Fixes: 770de678bc28 ("x86/sev: Add SVSM vTPM probe/send_command functions")
Signed-off-by: Melody Wang <huibo.wang@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/a5bc0d4a2c462a0089109e145c21626b244b2ff0.1789345277.git.huibo.wang@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/sev/svsm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/svsm.c b/arch/x86/coco/sev/svsm.c
index 916d62cd17dc7..2d493d55ff2e8 100644
--- a/arch/x86/coco/sev/svsm.c
+++ b/arch/x86/coco/sev/svsm.c
@@ -74,6 +74,14 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 
 	flags = native_local_irq_save();
 
+	/*
+	 * 'caa' is a per-CPU variable. To avoid using a stale or incorrect
+	 * 'caa' if the task is preempted or migrated to another CPU after it
+	 * is fetched, always fetch 'caa' and then issue the SVSM call with
+	 * interrupts disabled. This ensures the correct 'caa' is used.
+	 */
+	call->caa = svsm_get_caa();
+
 	ghcb = __sev_get_ghcb(&state);
 
 	do {
@@ -321,7 +329,6 @@ int snp_svsm_vtpm_send_command(u8 *buffer)
 {
 	struct svsm_call call = {};
 
-	call.caa = svsm_get_caa();
 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
 	call.rcx = __pa(buffer);
 
@@ -345,7 +352,6 @@ bool snp_svsm_vtpm_probe(void)
 	if (!snp_vmpl)
 		return false;
 
-	call.caa = svsm_get_caa();
 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
 
 	if (svsm_perform_call_protocol(&call))
-- 
2.53.0

