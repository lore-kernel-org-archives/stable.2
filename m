Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BC36F901;
	Tue,  8 Sep 2026 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851112; cv=none; b=cPGiH4RswoIVVxTfnObPt0aRDCi/VbpGT91l8zNLlGQTdxdGyewknQ8qdVWreCFAR9XUXoY0UCCHoQPWSGWyNOtXuF66P005nQcTHrmVFYIfrDY+/M2+pQBOcJ4JgZkn4xp+1+lrHhbw0CzAdHEFsvqFb+rAV9TVJFVQcoN7iwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851112; c=relaxed/simple;
	bh=C0jK5NIdGCPqqfQR04SL47oLZPhGxizCIrXWp4QtOTg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bhyBwyMBBP1hkZn6mDQ+ftAeYWCIELqrJLX1whMqoHFo+M67KBgczzzBW1XwVrjWvh8dzBPqZJ3JtnbbyIcR6A4hfW6vBugV6OvYWATxYcxH7+6txEO6JvAeUBDGQFXE2twZu+s1Rrsv5RhF8nHhx7k6sltDajeU2/Kl+wGbEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uUEfm22b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GyPIuB6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uUEfm22b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GyPIuB6Q"
Date: Tue, 08 Sep 2026 07:05:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788851109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TC3makVF7PAEJ54GqT9jHTJ05rXYCNsgxEo34AAa3FA=;
	b=uUEfm22b/m7xjUAyHZ25rk2AIieqssa8rQNNDScWpJEhSIABfBaHzFPl7cH5e5Und3G24u
	pZPGo8KEwdv5pPsW/BskVbowLAuiC1YGHcw+/JkTpWgI0FKwL9mxWoOYDEiRbD3j7MAOQg
	JGGkLC7s14gcnN63CZpfhTnzaJBHJOi/byEInPl0zLVD+vXKF+ll5LjqM2ZJ83lc277piA
	JOxqx51SI+BpPF3+hRrTmal0Ynaskg3HIr/RWyrUzJ4AlPXead8XR+f/m7mDuIwc0hEFS0
	Ljq9FDhly5E0ZErWuf1UlsTAj6VsRN61S67lGrMs6Nd6lnXL/Bmc31gWnzpbNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788851109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TC3makVF7PAEJ54GqT9jHTJ05rXYCNsgxEo34AAa3FA=;
	b=GyPIuB6QyRqvc3xqE2SYkFo20ARHfrYMBLjfkhV985hAKw7drpsdVLlQUgUjAvlyMRn+GM
	pSifdejFeX3NOPBA==
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
Message-ID: <178885110772.623050.9181470463178774351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     03e5b3a50cfb82d2e8d462fbfce83732b8d7a16e
Gitweb:        https://git.kernel.org/tip/03e5b3a50cfb82d2e8d462fbfce83732b8d=
7a16e
Author:        Jasjeet Rangi <jrangi@purestorage.com>
AuthorDate:    Wed, 12 Aug 2026 16:15:13 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2026 09:01:47 +02:00

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
