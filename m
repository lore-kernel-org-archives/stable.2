Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B52459FE
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782047939; cv=none; b=i6xGkw+/NSIdpbCyhkUgbtiEvEDjqxYEh2cfYElft4HUNpo9nXzMUF48g0HysdwNQvZIVLOdJcPdlmSgd97EjtZvPkHMCeERjspTeB8XsWJ0tFtFIxJZN0hNMhEfSIIM+fZHrZFPXIvrzUgFCpxyiJVM3FuTkE6vD5OmT1QQYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782047939; c=relaxed/simple;
	bh=AyPxKl5oBQalTzhyidZ2I8buKQepo27B+cbRvOvJGyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAyD7KpKEVYHA+oOagjjVpnu0p3vbDdsZfliELH9ORHirwJpSDYzDOQ4vL6uliWeuKB9DRVXLfaC2/6SO5qLwuS1IRSOSw2tXXs30Wo/c5hhyTp4vG2IixxWmgqzXHnoQUD/Mm2xMP5YKqIWe3epfAid+HhI3FZf3xzk92bLHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p0Z2Zwc4; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p0Z2Zwc4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782047926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uk1iymDuJIMBegf3LSsRMQr90HS3BQmdoLuXkwIxLLw=;
	b=p0Z2Zwc4IL/Ix0gByyuB8+CYFp2XOGMH8gkS79PPSKp6ccrosc9wD4cE2z0f3etFSbNQFz
	nHLs3UI/nVdpwDD+jzCIV6PtcfFOWEF2KedmQwtt+CSLseDgKs6rQnhyYsmkyIJ/fo3zod
	2ju+B0izJRro/jBObgvSiWhn+2Xln3A=
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
Subject: [PATCH v2] x86/boot: Reject overlong acpi_rsdp= values
Date: Sun, 21 Jun 2026 15:18:36 +0200
Message-ID: <20260621131836.175468-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=thorsten.blum@linux.dev; h=from:subject; bh=AyPxKl5oBQalTzhyidZ2I8buKQepo27B+cbRvOvJGyE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnmT9ak3e1/d5d5h+jvhxU5zkpfBa9v3tHYb7/8qdiFi plvQ1Umd5SyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBFljH8L570YIKWlnehr6fn 0r/hwlsFJY+vrtpoWXy+nX1Kvlx7IcM/u2MJ0e2LZnnWH6sz1rItY7VqmpU8KVPRn2n2OlOjm84 sAA==
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
Changes in v2:
- Warn on overlong acpi_rsdp= values (Boris)
- v1: https://lore.kernel.org/r/20260617130417.36651-4-thorsten.blum@linux.dev/
---
 arch/x86/boot/compressed/acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index f196b1d1ddf8..baaad01d2074 100644
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
+		warn("acpi_rsdp= value too long; ignoring\n");
+		return 0;
+	}
+
 	if (boot_kstrtoul(val, 16, &addr))
 		return 0;
 #endif
