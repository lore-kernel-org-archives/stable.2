Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0F40F72E;
	Wed,  2 Sep 2026 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384777; cv=none; b=VlRlIqQ5agsePPMUal/EyjPkzwVQ1qDWcr3yNvTO1qLg+f9JWSowuLOSISdWUMel3ucZE01r00gsiIeVp9+UyNZlf9wzu8+5h9miweszjxafNm/emisNhmHrTI0XsDNBVGTO0tk7GaPYMiOmYZHJKH0QSHJpPtzX8YXDVXUnAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384777; c=relaxed/simple;
	bh=Roy+6NsCVc+XuJ65bLey8yQ7bjpETEOJmX96eAhhW/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T7YI7IiHJD34J51MNFl9BmmyPzZK2RV6AxQcNmOMDJZ+Pz1XP7HptTNbDT97/BkWN0L+mmFyNNlpAnvmko/JspjSfAe8/S5mgJhFhTQsQWmhfo4PdmYm2xvt/dK76skJH1//CfwbYGnX/N2mez6XT5D2Npgz5JDkQGl84G5pp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ShzQc4kB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRYU/1Sn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ShzQc4kB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRYU/1Sn"
Date: Wed, 02 Sep 2026 21:32:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788384764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CexkDT9WayOoC6b7XJENYNPc4gGD9Rco8JIjCaumlyg=;
	b=ShzQc4kBM8or21hhevL0NUSI7mymD4ce1BVppIUeiUAlhxBYVBITFx6LTe+WyZIEWZRjto
	VnktYyBAz6fHYq46s7DBod46HnyT5wq5yqADfXbRehEoI6gC3METxEJxTPiDZCP9CYx0GO
	RXBLcBF5ao67C1R0pDVwh2qdmOFDo0/Qc1sU/w05/0G/MeDVU7y73ZQyWfVg6rutZewF8A
	IsuG9CDqclM4mQjC7GjW39ivHhaLft7vPCbX8owC7RCj6+3ZxCtnFt61tElzI138eCbYzC
	DPKLweu1XU0HvaE7smGex/881/6IsPsMfI07qTz5s1LDx6LDvApj3inhLnFuSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788384764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CexkDT9WayOoC6b7XJENYNPc4gGD9Rco8JIjCaumlyg=;
	b=jRYU/1SnJxS4mgEiOFnrHPy8mtAVtCvV1EADLB0weJcdCpS+ePrNPu7gawWd5wAje8yL3p
	anPQy3EhVsTbM5DA==
From: "tip-bot2 for Jasjeet Rangi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/MCE/AMD: Fix inverted interrupt enablement
 during storm handling
Cc: Jasjeet Rangi <jrangi@purestorage.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260812221514.598842-2-jrangi@purestorage.com>
References: <20260812221514.598842-2-jrangi@purestorage.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178838476249.3717435.11003033987790003040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7755fae2ea370ee914797c5bcca922836a818c3d
Gitweb:        https://git.kernel.org/tip/7755fae2ea370ee914797c5bcca922836a8=
18c3d
Author:        Jasjeet Rangi <jrangi@purestorage.com>
AuthorDate:    Wed, 12 Aug 2026 16:15:13 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 02 Sep 2026 14:20:59 -07:00

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
