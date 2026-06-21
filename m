Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83045039;
	Sun, 21 Jun 2026 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782061298; cv=none; b=UKDUYJfyJnmKPtlv83YwjFxoFHl5naa0AkpJmC+zkc+tLOknrdT9ATiYnNLiaU7sbnvP+jIES7USqzSyTu1yDNHHd3v02i+WzK1dSLdSAC40DIvfyBjh2yFdzVXjBWFrVMnfAKFpWUVnr16RDLbd0GAL/5WMTB5hoaPjNU8xOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782061298; c=relaxed/simple;
	bh=zh18mqmSEE7NEv7hX4NVylZ1qqPsyoT0WlnZJ5QoIrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9hGu/A8fbuSSJ0Oi+SbzMlGSTyJ+oTCU4MzH6JPxFbLfAgThLkQKLTTJ1NaLhmoX9FgfDs04sLqpwGKnuxcUuIZvf0FtxnKfuO1U0bjH3ka0eSrrj7BzumB6tkGg3aHF5HlKNljGDw2aymMk6R/qLtVMilVRhwqkFTtDxuIjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fBH+isR0; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fBH+isR0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782061294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gmYajAdy7xi1/l3ni436vTi7u6riNPqdSWnUcPjlLu4=;
	b=fBH+isR0Uur79QZwYortILegGYl71BheADa3YNWujezMyiX/PhAz6iviQxsFtCUZ9A/43Z
	pd58pQ9VH9jQZzvnmvfyklkUSf4gI/b0xbDar+gkheWilxMIY9vZp1EvtYb9JXnAL41eQH
	7eIzYYZPHbDGvPiJO7SotYQmqj9Jubc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86/boot: Reject overlong acpi_rsdp= values
Date: Sun, 21 Jun 2026 19:00:10 +0200
Message-ID: <20260621170010.276591-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=thorsten.blum@linux.dev; h=from:subject; bh=zh18mqmSEE7NEv7hX4NVylZ1qqPsyoT0WlnZJ5QoIrM=; b=kA0DAAoWXqtxINjMdS4ByyZiAGo4GJrIwSY6uBMhWfxB5+1uGJgw01in+j204kHgB0EFxTWbI oh1BAAWCgAdFiEE4Jr4mE11fHmyNFi5XqtxINjMdS4FAmo4GJoACgkQXqtxINjMdS7MygD+MwAp R+kCqn81OG9Olq/NJ86AEpIEULjIWBSmYZhsctcA/1dZbhgweIjfrNn2qBhVfjx6cytlPGIjvz/ v8uxslasE
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

cmdline_find_option() returns the full length of the acpi_rsdp= value
even if it is truncated. However, get_cmdline_acpi_rsdp() only checks
whether acpi_rsdp= is present and does not reject overlong values that
do not fit in the buffer.

Reject overlong values and warn to prevent boot_kstrtoul() from parsing
a truncated value and thus from silently using the wrong RSDP address.

Fixes: 3c98e71b42a7 ("x86/boot: Add "acpi_rsdp=" early parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v3:
- Drop the newline as warn() already prints newlines around the message
- v2: https://lore.kernel.org/r/20260621131836.175468-2-thorsten.blum@linux.dev/

Changes in v2:
- Warn on overlong acpi_rsdp= values (Boris)
- v1: https://lore.kernel.org/r/20260617130417.36651-4-thorsten.blum@linux.dev/
---
 arch/x86/boot/compressed/acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index f196b1d1ddf8..aed27604c11f 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -184,10 +184,15 @@ static unsigned long get_cmdline_acpi_rsdp(void)
 	char val[MAX_ADDR_LEN] = { };
 	int ret;
 
-	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
+	ret = cmdline_find_option("acpi_rsdp", val, sizeof(val));
 	if (ret < 0)
 		return 0;
 
+	if (ret >= sizeof(val)) {
+		warn("acpi_rsdp= value too long; ignoring");
+		return 0;
+	}
+
 	if (boot_kstrtoul(val, 16, &addr))
 		return 0;
 #endif
