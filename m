Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5632EDD58;
	Fri, 18 Sep 2026 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692114; cv=none; b=YD22sD7dn0osjBzJt3S1BWiJYVwnHX9IDvDnXHauI3UGv7NxXbKUmX5r19kBGzbxQEWIVaMCDUzJ+BloalvnJwvcvQTnWF9NBBgDoBePOJN/QirYlAOTRB0Rheagz/C9YN7Xm8pit/XO46tH6IEvP+kk1ph+9iukuibSyV2gQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692114; c=relaxed/simple;
	bh=flaE0pWMxEdq3g4ouxXb9ZYh8MBBFueA8eXTx6K5XnI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XOVTO758a9wQgHL0NJEC46JRfG441HX8WRENaaYbvK7kINAGwarUNt2sgtz1WndesO6bgwjBbiUgDTXcukb6zQ3QiDp7ZtnS5w7Ug58Z0AeOqQpXcz1rO/4IBAAex0ePjkn8OrsvOPZy3RgWB1S2Syo0/uQ88GYIg3Piuko//wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o3RkYK/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fXaNboY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o3RkYK/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fXaNboY"
Date: Fri, 18 Sep 2026 00:41:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789692110;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW5VJIywckitCgbfM8/Ncr2rVtPrQWVtBIk5/mlllEw=;
	b=o3RkYK/uEplrn7a027Prw2Q8l+1355L/ywbTc4YRYHmNWmQ1WNzgbT2x3SKDsyWcHrJekh
	HfDds+6+X3jHOHO4fL/y8lNY2QBZ2rz/3YolzVvBtoJpTEXSZek49Cfxyj1kq2dS2BOzAu
	Yf98n5iB4XowL0+vu5KlfEbx/JWoUJzOD/M++VbjoBupx7Xd5Fv/Lb9sPEFGGUWlHM/55l
	aAAPFacgm0rTSuDWMdgDbubjSj00uKHR6rB2nTVKYNjWZD7MAxGvlKvqPUbaoO4Y8nKid0
	C/3AWL8JJ+GML8j2vJXcuiMNHbpLqm4kF/TFV96yuyUvVIQoJmS8jjjm1iOZ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789692110;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fW5VJIywckitCgbfM8/Ncr2rVtPrQWVtBIk5/mlllEw=;
	b=1fXaNboYl0wCODtPVHVd4oAu/sRJyiCyBZfUF6KDmaM763MEZwEVYflhwNfjlqCrCyPCPQ
	GSJqkfAfq7IhKaDw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260916225939.1144524-1-chang.seok.bae@intel.com>
References: <20260916225939.1144524-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178969210882.1720534.495699346053864121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e7d3e2f46dd5a69046e6d95a0f189155a5516b93
Gitweb:        https://git.kernel.org/tip/e7d3e2f46dd5a69046e6d95a0f189155a55=
16b93
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Wed, 16 Sep 2026 22:59:39=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 17 Sep 2026 16:54:20 -07:00

x86/microcode/intel: Reject problematic loading on Granite Rapids systems

Microcode updates can usually jump revisions. However, there is an erratum on
Granite Rapids systems. If they "jump over" revision 0x1000405, they result in
an #MC. Avoid it.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260916225939.1144524-1-chang.seok.bae@intel.=
com
---
 arch/x86/kernel/cpu/microcode/intel.c | 26 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index 1142183..9f09d38 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -309,6 +309,26 @@ static void save_microcode_patch(struct microcode_intel =
*patch)
 		pr_err("Unable to allocate microcode memory size: %u\n", size);
 }
=20
+static bool revision_is_safe(struct cpu_signature *sig, u32 rev)
+{
+	u32 vfm =3D IFM(x86_family(sig->sig), x86_model(sig->sig));
+
+	/*
+	 * Erratum GNR98 can cause #MCs if "jumping over" revision 0x1000405.
+	 * Avoid the jumps.
+	 */
+	if (vfm =3D=3D INTEL_GRANITERAPIDS_X &&
+	    x86_stepping(sig->sig) =3D=3D 1 &&
+	    sig->pf & 0x95 &&
+	    sig->rev < 0x1000405 &&
+	    rev > 0x1000405) {
+		pr_err_once("Erratum GNR98: skipping revision 0x%x.\n", rev);
+		return false;
+	}
+
+	return true;
+}
+
 /* Scan blob for microcode matching the boot CPUs family, model, stepping */
 static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 						     struct ucode_cpu_info *uci,
@@ -330,6 +350,9 @@ static __init struct microcode_intel *scan_microcode(void=
 *data, size_t size,
 		if (!intel_find_matching_signature(data, &uci->cpu_sig))
 			continue;
=20
+		if (!revision_is_safe(&uci->cpu_sig, mc_header->rev))
+			continue;
+
 		/*
 		 * For saving the early microcode, find the matching revision which
 		 * was loaded on the BSP.
@@ -878,6 +901,9 @@ static enum ucode_state parse_microcode_blobs(int cpu, st=
ruct iov_iter *iter)
 		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
 			continue;
=20
+		if (!revision_is_safe(&uci->cpu_sig, mc_header.rev))
+			continue;
+
 		is_safe =3D ucode_validate_minrev(&mc_header);
 		if (force_minrev && !is_safe)
 			continue;
