Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794744047;
	b=Ku796PwmU4AEU8uvsXYvP8WgSwP6Jlol3NQrHLOFGVpEr91ef2kWTrfrvU+nRAgytHWV
	 UgVIEqI6TbOHxS61v0Xe9lLFIioPWf4MoCFhjqyUXYDuvis+M4iGjvvzgWoytUdMQ75Lr
	 YI00cMA5+O06fUc3WmCZkabgGP0UW0o/KEGZkTywP6WwMuIquu+RCuTImnHWAtnHBYPyZ
	 XMZjCcbH5dCIBe7NooKDs7Yyrxu68jbYh2tyXvIPIK9GKmnT1OdwbnyyKx//ku3Gbf+3l
	 CCHEjWIRfdd7ajxQzc1zGxyERuRWn4W4aA6kN+5v+ahoKMA/IVnrfsgnj8nVQuhIVgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794744047;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=1Y0Mh/YaPXXvxNmz8dhObdzhGRPTzFyPCl8ygTk5WmA=;
	b=iBYgjnIAlm+U+AYh8JTlv76x54RJ4L4zQjNyjb0p+cC3Mi1veXq8//E4Iq/RjZfGUEGm
	 85ecbeUvhVYtsiLisfRVpFvuQAEgumzJ5tdb/mRK7T3QIUIbdodVKAw9gHrM7LT7ueMuZ
	 flgrogcU3aIQNGQs0gGP6F6A6pXVvl9XO2o0xuTOCzxowOyiJPha2xngDxIhMUyUSgRnM
	 WQ0vbFvpADCaZKLSrTHS+qTB9JUvQSedAHS4o8jw0vkCrjKUMbmZ2++9wkBsDvjFtqMDG
	 YEELwzZX4a3cnAGloWcwgRT3ZBkUD21SRHYxixf08wta4rVh9tLrheLIUGMRDytFnYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0LzKODUO;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SjjwGNvV;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F3606A323;
	Sun, 15 Nov 2026 12:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 553F3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0LzKODUO;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SjjwGNvV
Date: Sun, 15 Nov 2026 12:00:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794744039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1Y0Mh/YaPXXvxNmz8dhObdzhGRPTzFyPCl8ygTk5WmA=;
	b=0LzKODUOFf5ulx+DdfYG3FYhOcbIimD9F/qrJ+ahrn0RGYZwmy17A6sYzQ4DWGvx0gAC5Y
	SSetyZo+Gwh9K6pMl+Goul03hRPiV0uMckMDZ+6Jv5x+qGdBFbA/peYhxkHFxqCylHPZfU
	VnsEuCY9B0Y7bmFQOsW1hhPBqn7B9hvgM61X26RNb0AlXlLnWTQguAbQUx/qHWYFaBSKa6
	aozBle4JTz3MEbBhQPBNTPwiI8JJwNceDr3CPVkCTeC7AJl3h5fVLc4zfEF2b/QQ3DnHP3
	XWcutzqdKySPCOOC4eG7cZ4xR8HmXfGttNuXaQ72IIOQXJryCb6FalLy+29kSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794744039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1Y0Mh/YaPXXvxNmz8dhObdzhGRPTzFyPCl8ygTk5WmA=;
	b=SjjwGNvVA1Yp9e0SnOszo8zgKhHd9Nti1+tPBE2aq5kUa29C4O1bLYhKi4ZSzBfzh7cdZR
	nysy8Czym/dJm5Cw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/mm: Ensure write visibility during LDT installation
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,  <stable@vger.kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179474403679.3191731.3498878914619508052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0dc2a4dac3d04e9e4479aeb0b46172feab1cca0a
Gitweb:        https://git.kernel.org/tip/0dc2a4dac3d04e9e4479aeb0b46172feab1=
cca0a
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 10 Nov 2026 09:27:39 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 15 Nov 2026 12:53:02 +01:00

x86/mm: Ensure write visibility during LDT installation

During LDT installation, the intent is to overwrite the old per-mm
LDT value, then send an IPI to the mm user CPUs to have each load
the new value.

But there is an ordering problem: a new mm user CPU sets itself in
mm_cpumask() and then reads mm->context.ldt. The LDT-installing CPU
writes mm->context.ldt and then reads mm_cpumask(). But, there is
nothing which orders the LDT installation side actions. The CPU
can read mm_cpumask() before its write becomes visible.

Ensure that new mm user CPUs see the new mm->context.ldt. Make
mm->context.ldt visible before reading mm_cpumask().

Also convert the smp_store_release() over to a WRITE_ONCE().
smp_store_release() has an internal barrier which is weaker than
the new smp_mb(). Avoid an extra barrier by converting it to
WRITE_ONCE().

Also refresh/correct misleading comments. READ/WRITE_ONCE() do not
"synchronize" anything themselves.

Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Acked-by: Linus Torvalds <torvalds@linuxfoundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
---
 arch/x86/kernel/ldt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 4fa7a86..c4bbb41 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -43,7 +43,7 @@ void load_mm_ldt(struct mm_struct *mm)
 {
 	struct ldt_struct *ldt;
=20
-	/* READ_ONCE synchronizes with smp_store_release */
+	/* Pairs with WRITE_ONCE() in install_ldt() */
 	ldt =3D READ_ONCE(mm->context.ldt);
=20
 	/*
@@ -422,8 +422,14 @@ static void install_ldt(struct mm_struct *mm, struct ldt=
_struct *ldt)
 {
 	mutex_lock(&mm->context.lock);
=20
-	/* Synchronizes with READ_ONCE in load_mm_ldt. */
-	smp_store_release(&mm->context.ldt, ldt);
+	/*
+	 * Ensure that new mm user CPUs either see the new LDT value
+	 * or get an IPI. Make the store visible before reading
+	 * mm_cpumask(). New mm users make their mm_cpumask() writes
+	 * visible before reading mm->context.ldt.
+	 */
+	WRITE_ONCE(mm->context.ldt, ldt);
+	smp_mb();
=20
 	/* Activate the LDT for all CPUs using currents mm. */
 	on_each_cpu_mask(mm_cpumask(mm), flush_ldt, mm, true);
