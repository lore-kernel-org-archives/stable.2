Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794971129;
	b=cULGJcOo1FU0zU6E6aW4f01TuBnFZvbu0CPztgvE3+gqqJRIgQU9VCb2jUTi2KzZBprB
	 e1lHb8fA211Cj5zIKBRqyhiXWxvH1UBMy7wVQo0J6rztqQlSrBCleoorvepHAMoRk5Thm
	 mskMgDux7+yhXY44AAvxMpihC+swWUu2uW47leLfi9yHcWeyniONdTrDA4nnWG/2xiuRQ
	 6bqruvyVzBRx/5DfgCug5BO5q1oCagxjXI+bbsLqNujUxNrkNW3+sygLdI00PTgn5KXLc
	 esSl5DX//C0xZMLM6FD6GJD7zYY6YgU3M6c7f6741tOF9gTlHP5ZLBFyNZAeuMFL9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794971129;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=JVf5Z4L493biQzcZIUPq5WSeKo5jxSQPgvOHK9iHNbU=;
	b=ekLWNSNDV2zNk339D4J05eLp3rK4WGgQVLiIGeREquJPvu5mENK6NDuTAWIPupbwWjws
	 MoXVdtZZCDORRgOYw2d/46Up0Wog35t16lBIF9KLs3aCPSZBK5X73bapnk9Xh3N8zqbfB
	 zn5rKHaDjtHO8Kiw8tSgVsyfL/MJSjp7aR3rElQpim5cTPWHpJ3KXsIcws3eYDBZgNpt5
	 o0dTALhLvSN2V5dcdbwSuY6kRpH2PcWfXPz1qCqpURF5/QNgrgc4MYwohTKE0pfYOJjoY
	 vRLkkSWV1s/iwTygqSQ63xNVEPQzpZabYwsICgQmo/zJUT75QWEpL8MfOqYvChVdgkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=ClDhMaZR;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0053606A31C;
	Wed, 18 Nov 2026 03:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0053606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=ClDhMaZR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794971118;
	bh=JVf5Z4L493biQzcZIUPq5WSeKo5jxSQPgvOHK9iHNbU=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=ClDhMaZR4HNDzWf8gp1p2oOY/dkzabWLPp84r9vKh8WOYIwUOg5e7Kc5aO50Bs1wF
	 JywNEqxHFGPHf+sQ+TDYIPo04Rng+JidhfGuu33olH2aTnuZfWuT0XzHRSIj9gjyqv
	 7lhWl39goLdQKk1t0R0IUb16/YuGedMBFkf9fh58=
X-QQ-mid: zesmtpgz6t1794971117t96746eb8
X-QQ-Originating-IP: CtE7MWfKIvGwwWKdSM4dsr/RIPUw16t0C8P3Ex/CTfQ=
Received: from [127.0.1.1] ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Nov 2026 11:05:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18325639032088577285
EX-QQ-RecipientCnt: 15
From: Peixin Xie <peixin.xie@linux.spacemit.com>
Date: Wed, 18 Nov 2026 11:04:33 +0800
Subject: [PATCH] riscv: cpu: Fix incorrect cached machine IDs on secondary
 harts
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
Message-Id: <20261118-riscv-marchid-fix-v1-1-6d677fcd5461@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqCQBCF4VeRuW7AWcGkVwkvtt1jjpDJTEkgv
 ntrXX4Hzr+RwxROl2ojw6quz7lAThWlMc53sOZiCnVoRaRjU08rP6KlUTMP+uEGsWnPIQtqUPk
 thjL/mtf+b3/fJqTXEaJ9/wK1tqKVdQAAAA==
X-Change-ID: 20261118-riscv-marchid-fix-3ea3672d1e0e
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 stable@vger.kernel.org, Peixin Xie <peixin.xie@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794971115; l=1952;
 i=peixin.xie@linux.spacemit.com; s=20260727; h=from:subject:message-id;
 bh=+XmXptOpB9qNChqNiEmskdTqAu9CpoySFZwuHevOeCA=;
 b=soX/Y5u/Zof/TqDEPMOha+JkSm85SjmlfwBSkakoCGHxFRfWao9VmVVnZg/ZsWNXcDY7i1z0z
 b3fqqDc9nfcAoJrWhMbXxEj8Z9BLLAUG8F7K7unoT4HSC/thsDrZNqK
X-Developer-Key: i=peixin.xie@linux.spacemit.com; a=ed25519;
 pk=jczO0FmEQZBoClfXslkwCsHKDmSRchQ1hQr8W7yiiXg=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NCv6Rd7nbe9tzhgisXV4tGubeS7/b3j1/ZmU17ZGcxgsnlylQBdptiPp
	/bNLOPUN2QUp20zkU4AlPWVf/sVPL2X9Jlqa3F6UdHb5TB6g8aN8hbWFh9YulzDSm+BkoN1
	xo7gvBx+4MTB9Gk4DONs4cDkqjBB+GCo9p3A6qGGU1DtkXH2RcqZ1jPdUiLxTs9NmPS67gH
	GZHcU7/U0NqgV7EKSou70CAFluv6iwF3Vgq0LFIX58GqlxkuhUoLaP+Qxb/hbfbvEtM+JMG
	WjztnMhzjw3hnPuhna5aOpKJeI2x83aRiyZtcCiJXI44eHHR903HxwwIfrEw1swpeDtqJyH
	cRBPLtoe/XDpzYJgTQGuSesvVmdEw5I2ZGBEJXuTfoOfOI9ZhZT5PulRH5VMG9ue0YphFXV
	ckNPzu3ra5N8EiExMkQm73iJ/5J+Mh6RmZP8hjHdXER+asqibf0Hwt/ZZxBn6J8U84jfrnz
	luhmnn3qC4pkpbTKz+qnjdCgQOAbBq7N1P91J61ThD/e5znDZyIK5HUwTGnhSyMHgqMOMPy
	TJFN4DXXSUhENZC6TZ2qEPRApssA/fh5FLGt9RZ3V81h780su8pr+Zx/OFj0IFJz+KCYIdq
	MHYx4TTutgZOMKVhZ0NspTFuWWacb6M8wYY92Kk0Ql/P4xjsTiIUTAhRt5GfbzpRiJMnDG7
	A/BRzrW/nZi9WVp+m1/1nn9/pncN/XvnGqGrPnZBbvTkhc0hgE+J36wuxLlaRY+CHCYfKBG
	jm5Xf7bHD/1pOhkI2ROoFRYjmEu7fW/oRzQdKmvvzfnh50R1rxfmSH+mJNRMWt4eq7OsirV
	UBwWXvi90+5dWm6Zpn4N0HXqtejxRz3rbXg36qlfcjzfovo6Pn1aNnLqghgstx0LwoxBpBm
	lbRXEzsultz6dnQWwOfHnnJuH018UaPe/3ADt/GRn60J/4SaAgiymug3h0wkM9GnodwpzFv
	cV82qsEY/9boOvu2inLBR7UUDKfthy1IxADDg3Rjabyx2hDsoP+/cLcSnZxb1LyP06WuPUo
	NqYeZ1luZWjzg63pAkxp6iHF3mU2Qt2bpr4bPE4kMBN5EBvbrY6XIBT/4ugy6Q1dq8baPCZ
	qHU0WTxE1fsHLxQTTKrv8PhFoiSNtArgfyNQQ/zC+S4q80vvXrwOHIy5qAaS76wWw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

During early ISA-string parsing, the boot hart stores its mvendorid
and marchid in riscv_cpuinfo. This happens before setup_per_cpu_areas(),
which copies the static per-CPU data to each CPU's allocated area.

When riscv_cpuinfo_starting() runs on the other harts, the copied IDs
are already nonzero, so it skips reading their own IDs. As a result,
secondary harts can retain the boot hart's IDs.

Read mvendorid and marchid unconditionally on each hart, as already
done for mimpid.

Fixes: e482eab4d1eb ("riscv: cpufeature: Fix thead vector hwcap removal")
Cc: stable@vger.kernel.org
Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
---
 arch/riscv/kernel/cpu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index af84b97af3a1..64c0c83eff76 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -197,16 +197,12 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
 	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
 
 #if IS_ENABLED(CONFIG_RISCV_SBI)
-	if (!ci->mvendorid)
-		ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
-	if (!ci->marchid)
-		ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
 	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
 #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
-	if (!ci->mvendorid)
-		ci->mvendorid = csr_read(CSR_MVENDORID);
-	if (!ci->marchid)
-		ci->marchid = csr_read(CSR_MARCHID);
+	ci->mvendorid = csr_read(CSR_MVENDORID);
+	ci->marchid = csr_read(CSR_MARCHID);
 	ci->mimpid = csr_read(CSR_MIMPID);
 #else
 	ci->mvendorid = 0;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261118-riscv-marchid-fix-3ea3672d1e0e

Best regards,
--  
Peixin Xie <peixin.xie@linux.spacemit.com>

