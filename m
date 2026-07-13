Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8974499A4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972228; cv=none; b=YFveDOuX6XqcV52SgVXcbqJeGOhRgT7NnmSjzYMqSddrdiPwpaHkcp76HfAM+oMWGKr6vbxhsHYRmop0TB9kT7WSJBGFmKBcFg5gzqrE1XJSnbIvHMyDExwWQGSV9msJM9OjIE3QGQIC6qt7zrZdaOQ+SP/r9+myx7ZUY7ZMaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972228; c=relaxed/simple;
	bh=+pX07a2u5TkbqrO4azJbx+91thfYIYeQVNU0vPSkC7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3KCz5U6tWMswO7ICEACcI/550CHuukRrDvlIhv8jtutId7e2s4fVgkhPmU0HxGnrfS2Ls5s6oLzbdJgdJ80ZMt5DTaux+Y+Ew+JjX0oKNDqUtTapO1KjM/jTZAkEqOCLpt3gmtmjyPDG9uZ6xSDiyQSSaTXQqVp+E22hj9bbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ESwr9im2; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ESwr9im2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783972214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sRyqpi+BAHs5WUp31Tgpjj0ZLVkhU0Gr2GsoSexZcO4=;
	b=ESwr9im21xQHihCYdnc4Wi8lSsiLYewW45b1umUBXqdZr3aEUeZBQ1EgT0pU9g2DceYCFC
	pLbpst6eMVfVp8umY5tcJA0zkKpME1IPkFl+MKoQ/wj4ZHRoS2gRamAZLzFmHHs54RYLG6
	AyKdztpA/nM8qPXiLSHhZdP1NmP0aRc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	"H. Peter Anvin" <hpa@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/boot: Validate console=uart8250 baud rate to avoid early boot hang
Date: Mon, 13 Jul 2026 21:49:25 +0200
Message-ID: <20260713194924.126472-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=thorsten.blum@linux.dev; h=from:subject; bh=+pX07a2u5TkbqrO4azJbx+91thfYIYeQVNU0vPSkC7I=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmhji7KHL81tP6ZLnv7V2D54Rfy6t4F/39fOTJ5sRL/P /ZrP5eqdpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBE5noyMky6zaVediqz6iaP xBKVWrGUVNMm2xzh08dLDZP3Z8zRZWZkaN8yldGxfmZkYVp0u+/OTYnntrU8V3n8m/2mw6eqRIO dXAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the baud rate is empty, 0, invalid, or overflows to 0 when stored
as an int, the system will hang during early boot because of a division
by zero in early_serial_init().

Fall back to DEFAULT_BAUD when the resulting baud rate is 0 to prevent
an early system hang.

Fixes: ce0aa5dd20e4 ("x86, setup: Make the setup code also accept console=uart8250")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/boot/early_serial_console.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c3de8b..5b83beab89e1 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -117,7 +117,7 @@ static unsigned int probe_baud(int port)
 static void parse_console_uart8250(void)
 {
 	char optstr[64], *options;
-	int baud = DEFAULT_BAUD;
+	int baud;
 	int port = 0;
 
 	/*
@@ -136,10 +136,13 @@ static void parse_console_uart8250(void)
 	else
 		return;
 
-	if (options && (options[0] == ','))
-		baud = simple_strtoull(options + 1, &options, 0);
-	else
+	if (options && (options[0] == ',')) {
+		baud = simple_strtoull(options + 1, NULL, 0);
+		if (!baud)
+			baud = DEFAULT_BAUD;
+	} else {
 		baud = probe_baud(port);
+	}
 
 	if (port)
 		early_serial_init(port, baud);
