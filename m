Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B02AD37;
	Sun, 12 Jul 2026 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783823409; cv=none; b=uM+TQjZWiB9nLqtExymqjRoleKu7EsCGm9834oOC1F0awPZJWAkVQEun0d6oZ7VsBhSXxZvM1L96c20V4qnguO1HuFQtSnUz8Q35rEncvxqkCBLGU+txoJr70tAXxFseurN+Wk8THCBhtPFMzfdRfXmkiyAEYB+fis6KPu9juD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783823409; c=relaxed/simple;
	bh=By/aGOzrhVBpJz4z9clfRGXt0lPa6efmjYPNtFKz28U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZiazkhWwBXgErYAfsrgjLaMhZjSBo7fuICR13e5ZyuT6gqCUl8OK8cxoByrpLDuZaOq8NRIcz+5Ihp0fJhGR3U/n4RbqpS7g/Sr96mfPhWBkcArq+4RuSxplf4I6eUFbgLPh+F2Jl9TNose0cYBqocjZkb5yQjTQP5S0PTd+UDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0tNeLnv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVBEoylg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0tNeLnv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVBEoylg"
Date: Sun, 12 Jul 2026 02:30:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783823406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lTxT6AleD68v6YxMdfjI1Lpf4GxMDc0BJmy6BXOCE+0=;
	b=U0tNeLnvNZjRwkI/yOvChYu2+0I4O7OCUNRFQ8SlYI/Vw/zg+CAo8uPwY1Nt9164rT6H1f
	Q75XYbf3rY/x9SSwag+4fbQAnXa8klM5NyteBLAUeubwuLBViLy6VkvLsoHNHEAjZMQLvo
	NDNZyktKBHkV3+bgwW7VGtj5t2hfEWKP0rLIpdiJ3+v8pe0dpUypRVuTOI142TSp56q18D
	Cf1qrJ1/Reurz8ilmt9W7LRIpvFRP347IRuyEmpr5Lp2OMG78VA7f9ZZi+O4yPct0cO5Ih
	o5L3XMTtGF0pXZfAk9kUEiG/SVc3Dmw3XLIFEkEOblwuarqSaY2ZqpCYnxTeMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783823406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lTxT6AleD68v6YxMdfjI1Lpf4GxMDc0BJmy6BXOCE+0=;
	b=FVBEoylg+D1rsZ4ZdVq6F+IJBm98OiJCQF8Wr6+cHOkWDVD0e11Pm59SnPZj5MjZTQnj4r
	/OA1G5/UjAEtJgAw==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Reject too long acpi_rsdp= values
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178382340382.1844600.11061068818259843022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d130041a7b96f79cd4c7079a6c2431a6db4c9619
Gitweb:        https://git.kernel.org/tip/d130041a7b96f79cd4c7079a6c2431a6db4=
c9619
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Sun, 21 Jun 2026 19:00:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 11 Jul 2026 19:25:26 -07:00

x86/boot: Reject too long acpi_rsdp=3D values

cmdline_find_option() returns the full length of the parsed acpi_rsdp=3D
value. get_cmdline_acpi_rsdp() then silently truncates values which do
not fit in the val[] buffer.

Prevent boot_kstrtoul() from parsing a truncated value and then the
kernel from silently using the wrong RSDP address, see discussion in
Link:.

Issue a warning so that the user is aware that s/he supplied a malformed
value and can get feedback instead of silent crashes.

  [ bp: Make commit message more precise. ]

Fixes: 3c98e71b42a7 ("x86/boot: Add "acpi_rsdp=3D" early parsing")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260617130417.36651-4-thorsten.blum@linux.=
dev
---
 arch/x86/boot/compressed/acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index f196b1d..aed2760 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -184,10 +184,15 @@ static unsigned long get_cmdline_acpi_rsdp(void)
 	char val[MAX_ADDR_LEN] =3D { };
 	int ret;
=20
-	ret =3D cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
+	ret =3D cmdline_find_option("acpi_rsdp", val, sizeof(val));
 	if (ret < 0)
 		return 0;
=20
+	if (ret >=3D sizeof(val)) {
+		warn("acpi_rsdp=3D value too long; ignoring");
+		return 0;
+	}
+
 	if (boot_kstrtoul(val, 16, &addr))
 		return 0;
 #endif
