Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1723D7C2
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701531; cv=none; b=g6SDp+oqCqfHY0hwScwl0pEuu41IAmUBjD+3jod6da+JLnk7X6CZudMtF07tJV/HAeLVc6ZnbJu8fJBFnBV64F11uj1XG7RlFi3kXoYVaN9GKp0UectjGjdRUcx+X04GZbC2mMoktPJthHrUy1qR1Br4zuYsazJ4YAhe7nMWooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701531; c=relaxed/simple;
	bh=F8NlBVr4VwSh2mJQsAHpDWUKudGps7GKQpNYUrtsjhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Us7wPmXznHYhjqHR+eRcvt2IEgAwgJno4/XUzPEfn4jaDBkG4VMC8qEW51djC7xmxlr6LK6QSApNFIj4MaX2UmiQjdq8mAWRqzK8HIO8Tw06D6JkMVnOJYg1yGseFGWhNBb3t3vXpa0BBqtJwmLNqoU/nYNYSTWGkJGj+xLsOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EXoB+KYX; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EXoB+KYX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781701518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Hju7v9DGm0akEOAgYQWUZzDD8WFmDp5IWw86hVc36Y=;
	b=EXoB+KYXCbi//TgULMJQ6RU3RjlUcA2mWWlp4shyooQnNCt79XzIurBxwBMJ7k7zFC39kv
	aeNSvzbn9Z2aLkI7OPm/4CGQ+kT+362lQcYKuty/s8yeqlNbNh6eFbd3sXZCXvAi8iCwqm
	yFSo6YwhKM7PpTVa7z89hVGHhOitLTM=
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
Subject: [PATCH] x86/boot: Reject truncated acpi_rsdp= values
Date: Wed, 17 Jun 2026 15:04:18 +0200
Message-ID: <20260617130417.36651-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=thorsten.blum@linux.dev; h=from:subject; bh=5jzJ/iPw/qwUiu0nSy3+/68QV97UPiWau5FrB4QWoe0=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlGswOZ1wl777odt1bnevqlfI1N05JiVgQ/jvwksZV10 8ZbMstedZSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBE7kkwMmw9vmr2yTzLYLY7 zhqfrO/nM9hxdjDz3nn/y+B4lvSz+jkM/4x9Th7qL2SYujYjYIu32ulf8d/7O+cKpPR6NGjEcYh M5QAA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

cmdline_find_option() returns the full length of the argument value even
if it is truncated. However, get_cmdline_acpi_rsdp() only checks whether
acpi_rsdp= is present and does not reject truncated values that do not
fit in the buffer.

Reject truncated values early to prevent boot_kstrtoul() from parsing a
partial value and thus from silently using the wrong RSDP address.

Fixes: 3c98e71b42a7 ("x86/boot: Add "acpi_rsdp=" early parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/boot/compressed/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index f196b1d1ddf8..1b5638a8e180 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -184,8 +184,8 @@ static unsigned long get_cmdline_acpi_rsdp(void)
 	char val[MAX_ADDR_LEN] = { };
 	int ret;
 
-	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
-	if (ret < 0)
+	ret = cmdline_find_option("acpi_rsdp", val, sizeof(val));
+	if (ret < 0 || ret >= sizeof(val))
 		return 0;
 
 	if (boot_kstrtoul(val, 16, &addr))
