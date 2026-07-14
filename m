Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0C426ED3;
	Tue, 14 Jul 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019976; cv=none; b=Q2B2eCUUhm8sqIimTZWNBlnm93pV0fr49jGri777vfvdruCB7F67fbMPExjyCOZVDtBiQdq8I3Eat8TqQeEI1ZHocm+i03XW4Q7BFZDnNCN0uT2Hjyw0eOZxzbmfguYY+F6r6FzXKyW+afe/zfia9/Wt14cYfe303dpbQd7P9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019976; c=relaxed/simple;
	bh=kaoxXX0jAstSfaSlXnlO4sW/eHscmBEnQsohmFJRh5E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pWUeznGm1g4WB5TzSMyJ+9kTTsRqTk3Q6q1ra1fno30t/qy1gtn7vjFIuk9Z4PJwNjNtsKGjKqrVjE4y5YACbJ+rVRyDC33YJgkJ00Ww+5Prch7bAWtrIufZrj6PcheNV1uH5zvegKdZkKHxR6xugYAEz4ij9nt9NdkKVOsLzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2W7GE1q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZ4pgaqi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2W7GE1q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZ4pgaqi"
Date: Tue, 14 Jul 2026 09:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784019973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uc1n7R7SS3CkocN0qbaxkTdnlUlunyItCVNa07EcMi4=;
	b=U2W7GE1q9FKMUYwQq6M8eba3aMMwK7h90sP1kw84W4VcxwfsmOOGULEnUjhdMgTKifnNiC
	nd2kuIuW9CjaKxYsis3Nqh4Fe8OEs+7K+EPD0oFhNBplLYCngZvGlGzgXkWaNXBQO06oBy
	yi5gHTdVFRFe/PfGZVuIvwfJ7CuFl0D1YLIA8Gx6nQKcNSTHaOGSGoZKEb/1PaU8B9VXCX
	nhtBr4L+RoVuDdaiKwGqtdatV0QwAOrm78K+HHkRr/hpQaT9CoBiMMYKhQ4uZJVUYpgNIi
	W92rHQgxq+RXTmMmLHGpo8bgQ7VLno2+q6qoEnXroqiXzA6Ta6QP9EUs7q9gRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784019973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uc1n7R7SS3CkocN0qbaxkTdnlUlunyItCVNa07EcMi4=;
	b=dZ4pgaqi6dHniVGWwL4/sw1ndYWHl+GwB45P6G3/RZy0ySsD/2Ky4aLjaIeYp9Xb/k44KA
	LPFsaONZl9t4LdBg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Validate console=uart8250 baud rate to
 fix early boot hang
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260713194924.126472-3-thorsten.blum@linux.dev>
References: <20260713194924.126472-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178401997162.1844600.12790933633191960716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ffa0aa5b625fe0bed7463ac613f8b06676ff4542
Gitweb:        https://git.kernel.org/tip/ffa0aa5b625fe0bed7463ac613f8b06676f=
f4542
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Mon, 13 Jul 2026 21:49:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Jul 2026 11:01:33 +02:00

x86/boot: Validate console=3Duart8250 baud rate to fix early boot hang

When the baud rate is empty, 0, invalid, or overflows to 0 when stored
as an int, the system will hang during early boot because of a division
by zero in early_serial_init().

Fall back to DEFAULT_BAUD when the resulting baud rate is 0 to prevent
an early system hang.

Fixes: ce0aa5dd20e4 ("x86, setup: Make the setup code also accept console=3Du=
art8250")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260713194924.126472-3-thorsten.blum@linux.dev
---
 arch/x86/boot/early_serial_console.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_seria=
l_console.c
index 023bf1c..5b83bea 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -117,7 +117,7 @@ static unsigned int probe_baud(int port)
 static void parse_console_uart8250(void)
 {
 	char optstr[64], *options;
-	int baud =3D DEFAULT_BAUD;
+	int baud;
 	int port =3D 0;
=20
 	/*
@@ -136,10 +136,13 @@ static void parse_console_uart8250(void)
 	else
 		return;
=20
-	if (options && (options[0] =3D=3D ','))
-		baud =3D simple_strtoull(options + 1, &options, 0);
-	else
+	if (options && (options[0] =3D=3D ',')) {
+		baud =3D simple_strtoull(options + 1, NULL, 0);
+		if (!baud)
+			baud =3D DEFAULT_BAUD;
+	} else {
 		baud =3D probe_baud(port);
+	}
=20
 	if (port)
 		early_serial_init(port, baud);
