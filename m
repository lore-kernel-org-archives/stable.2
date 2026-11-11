Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410681;
	b=j+GCxvH3x60xmLy2lBNwWv0svnDs081OP+u9UATkJVFQa7w9syqkJ/ckBrCukYkVA/ru
	 +VB3v9B2Q0WcvTdVi6M7BaVTUrkMw+ZtkVMCUlHHLWxg/SFswTKJXwQTyC2GrNlwCWFGW
	 5lESeLxi42eVibXSgkPw7ZZKToiDnS+GtDKM6WnfFzLaBmqm0jUfaFTQq3fca77k58rUl
	 BmKZ68RpRQq2kekqWANIrt+T7QFte2UthGD9ie7gehp0b3m03sSaHy29U0+HZgOnuEwaL
	 k5UfYwPLeSEr+if6/d7SfnCFlYjVff7cc8mHY6wqhLJa9TeLuqCnk29RiTijlUgd6LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410681;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hzBceqh/KQBhXeCn5oMTRtvRyVQ5R1TjWoLMywUAQlM=;
	b=SPKgUyj2sCvdmz97GTGqkRxzRS8KAdDroFcBV+RkAY+4CavK3HsYiarIc9fVxvnyFW4v
	 3DOfeJX/xSuodcTYEigL6BltkEOuzWRvZQJIORb2OgaxZ5mWo1Yx/sA7foakCHxWMSXhC
	 LOKrgN0UMuPsFpvFQR7jsyAsf0t92m/5mM8Y/rnGjum1Obre7wtj5dB6zxK4TSxKYeGw8
	 JfUEannK+QNS0H8ecZPkkrwbJYLbQMf9MN0/xOynA5y9bDVl5+mv/KqskiVy+AXCDX3zM
	 8fg4kwAEQerWHmOuhVk79z56rEj7EXhhqo4pKeMK34rXU8T0ni3feRJ28zrdBUDNRzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESKC14ZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB7606A890
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESKC14ZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2D31F00A09;
	Wed, 11 Nov 2026 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410681;
	bh=hzBceqh/KQBhXeCn5oMTRtvRyVQ5R1TjWoLMywUAQlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ESKC14ZHGOK2+U8iuiHbIu7l62PuXb2LMQkOD0rTAmQfoQht6d8AiLjWLOj/5yXOF
	 JGbrThs7/pP4rCZYTNNczo1VJ7WINBn4NACoQG05yM125D05OedxgkDh/HbpS8kBnC
	 zCV8b6VKOz06WrN4l5p0muQi4Dgk/W2Cj38X8LNOX3Y38Us1d7Yo6z3a6CXS86GXHe
	 1f/YIahl+vUjpKGhpGuhc0Xq0rApUAhn8QAIjsLtdlanQ8tZjCF9hCoetqiRO0HFbm
	 yys3qZX0i8XKyESn0KHcX3r8oNBPP5jQhfY+sfS83r5xesZD1fdmodqbmKziaLZMVq
	 E7YCSmbUtKXFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] watchdog/hpwdt: Refine hpwdt message for UV platform
Date: Wed, 11 Nov 2026 10:24:38 -0500
Message-ID: <20261111152433.2592922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051109-failed-6.18-ed9e4c1ff15d@kernel.org>
References: <20261107051109-failed-6.18-ed9e4c1ff15d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steve Wahl <steve.wahl@hpe.com>

[ Upstream commit d8207d1e9a36b1a8a461581b2d4073ea28335603 ]

The watchdog hardware the hpwdt driver uses was added to the UV
platform for UV_5, but the logging mentioned by this driver was not
added to the BIOS.  When the watchdog fires, the printed message had
the administrators and developers looking for non-existent log files,
and confused about whether a watchdog actually tripped.

Change the message that prints on UV platforms so it doesn't send the
user looking for non-existent logs.

To aid in any future debugging, include all 8 bits of the NMISTAT
register in the output, not just the two bits being used to determine
this was "mynmi".  And provide names to the bits in NMISTAT so the
code is easier to understand.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20260318155005.90271-1-steve.wahl@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: ed9e4c1ff15d ("panic: restore variable arguments to nmi_panic()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/hpwdt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ae30e394d176e..ba08189937ec6 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -22,6 +22,7 @@
 #include <linux/watchdog.h>
 #ifdef CONFIG_HPWDT_NMI_DECODING
 #include <asm/nmi.h>
+#include <asm/uv/uv.h>
 #endif
 #include <linux/crash_dump.h>
 
@@ -158,24 +159,31 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
 	return 0;
 }
 
-static int hpwdt_my_nmi(void)
-{
-	return ioread8(hpwdt_nmistat) & 0x6;
-}
+#define NMISTAT_EASR	BIT(0)
+#define NMISTAT_EWDOG	BIT(1)
+#define NMISTAT_RTRAP	BIT(2)
+#define NMISTAT_DBELL	BIT(3)
+#define NMISTAT_EMSWDG	BIT(4)
+#define NMISTAT_GPI	BIT(5)
+#define NMISTAT_NMIOUT	BIT(7)
 
 /*
  *	NMI Handler
  */
 static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 {
-	unsigned int mynmi = hpwdt_my_nmi();
-	static char panic_msg[] =
+	u8 nmistat = ioread8(hpwdt_nmistat);
+	bool mynmi = (nmistat & (NMISTAT_EWDOG | NMISTAT_RTRAP)) != 0;
+	static char panic_msg_default[] =
 		"00: An NMI occurred. Depending on your system the reason "
 		"for the NMI is logged in any one of the following resources:\n"
 		"1. Integrated Management Log (IML)\n"
 		"2. OA Syslog\n"
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log";
+	static char panic_msg_uv[] =
+		"00: A watchdog NMI occurred.";
+	char *panic_msg = is_uv_system() ? panic_msg_uv : panic_msg_default;
 
 	if (ulReason == NMI_UNKNOWN && !mynmi)
 		return NMI_DONE;
@@ -189,7 +197,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		hpwdt_ping_ticks(SECS_TO_TICKS(val));
 	}
 
-	hex_byte_pack(panic_msg, mynmi);
+	hex_byte_pack(panic_msg, nmistat);
 	nmi_panic(regs, panic_msg);
 
 	return NMI_HANDLED;
-- 
2.53.0

