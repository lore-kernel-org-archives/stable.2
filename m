Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A396388369;
	Tue,  8 Sep 2026 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852095; cv=none; b=HAEhCpGeNKq0SbLNsHxt2Z6JK/zq85KRo8LZtGuOXzlywyb37zeSUxRy29rl3s1ctMcoWUy1KUXCSrXtPE3tw59Jg19XRmJhiTLn8UwxBtcmc2edHSGMM2jDn2WilV+XdJ8nSxpwDc3etDKcVKWeI8F8WeGsu9sdRwGeZZOU0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852095; c=relaxed/simple;
	bh=tKxpDhWcxh5H8Db+Ku3Aeatq4i9Jz5/ZgVpKeZp3kmg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QPvmQ+iodS6LgRm5NgJ2t4TvdkSBT7As/f8gJOiZFO0xNvttvYsL5A6EkTqXPxCxocBLFdTovplOBcBiR/uUTFrt7bovDH6ld2Z5p3fSajsAEIpeng+cGFbHauly0UfdjZgoPaIb2YjFWvSTPljIVcnGR+l27+sXrntKe7sMhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odZytt0f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vJTJobD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odZytt0f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vJTJobD"
Date: Tue, 08 Sep 2026 07:21:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788852092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpOmLpQn+dJltPqxEPKudgB2YP8mv/I8IovKViPATos=;
	b=odZytt0fOLMEC1d8Rk+FD6XWVcheMleS2GtGRnZgfhgy7f4rRjPGPM4uvIrW4ffxqhUFOo
	dOlfU5SgiHmX3mk1cfeeIuVxyY7hvueD0pwhIoc8n8idFQhDdR/hu1B8bRsOrvoF6x9Qj/
	X9RYlxWR5QRb0EoK8MnqMh/GyOylxuBpABxaHsPThEKvCfqM56WAFfS4oUGD1uNBQm00GT
	cj4GBletZ0Z0p+W5H7TC+K54aKcj+7C+TfbNKamkp/Vc/FEnpNuQIwxc1QaTFWIZ/4q3KX
	bzDM2d/12K0hIVFjYhxZ9FITlJ9LWqC4tzB7zbQcjfQdWis3FU/JhJtACaiVkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788852092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpOmLpQn+dJltPqxEPKudgB2YP8mv/I8IovKViPATos=;
	b=0vJTJobDa0i9xhMlOVMnIPaOMTfyeul2Qu05jYxRWe2M2/699waCFD9OYAGNI4OWwxO+t1
	ulVYejEftcNQpvBw==
From: "tip-bot2 for Jasjeet Rangi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/MCE/AMD: Fix inverted interrupt enablement
 during storm handling
Cc: Jasjeet Rangi <jrangi@purestorage.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260812221514.598842-2-jrangi@purestorage.com>
References: <20260812221514.598842-2-jrangi@purestorage.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178885209052.623050.5781615859775130567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d2929113b15bfc06793b852aeba3d2db6d79fcc9
Gitweb:        https://git.kernel.org/tip/d2929113b15bfc06793b852aeba3d2db6d7=
9fcc9
Author:        Jasjeet Rangi <jrangi@purestorage.com>
AuthorDate:    Wed, 12 Aug 2026 16:15:13 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2026 09:16:32 +02:00

x86/MCE/AMD: Fix inverted interrupt enablement during storm handling

mce_amd_handle_storm() currently does the opposite of what storm
handling needs: it enables thresholding interrupts when a storm is
detected and disables them when the storm subsides.

Flip the "on" function argument before passing it to threshold_restart_bank()
as it should have been done.

To clarify: "on" to mce_handle_storm() means, the storm is on now when
"on" is true, and off when "on" is false.

  [ bp: Simplify. ]

Fixes: 5c4663ed1eac ("x86/mce: Handle AMD threshold interrupt storms")
Signed-off-by: Jasjeet Rangi <jrangi@purestorage.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260812221514.598842-2-jrangi@purestorage.com
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f916fb4..1cc20b8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -865,7 +865,7 @@ static void amd_deferred_error_interrupt(void)
=20
 void mce_amd_handle_storm(unsigned int bank, bool on)
 {
-	threshold_restart_bank(bank, on);
+	threshold_restart_bank(bank, !on);
 }
=20
 static void amd_reset_thr_limit(unsigned int bank)
