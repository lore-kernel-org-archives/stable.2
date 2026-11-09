Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210509;
	b=oNqK/NEVPzyfd3q5KvDMeTierZQKL+hS/JGZ29j42oscaIJw1kRLEfGOkPqFuoSZ6L/n
	 PBJwM856AUpMVf6x+fm7W9VDPra+YA6YU9pmRr1LksPH2PVN7dkxM7jAPfjrext9bBQFB
	 cwj04OoFlVAsUsGPS1CuhqJZV9LUh6KZSwDgpsSTdP0z5LtbaKUpmXhbRaz0eJf3JvnNm
	 9QbpG2biqiqTbJ6Hbzlf0tuGmi2tNwCdEOSwoNWzBoBEOZBm8nJYZtnP6/gK7nboaxbj2
	 igNJFcR5HsBYttd+P0kNANzwwVZPRF5003JeAnDyz2lVS2I9m9t1H79+9mm/5/nX24A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210509;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=T7ia6HAcSNfWdLBd4/D4gU8O0cJq5FRXdZNy9UsYfp4=;
	b=gbhVXp45m4pnT7aDC00IqOkbzFf9TSdKcUqN6KQdNxov1h16m5Jfu4Sq9iqPAhQ256q3
	 GZ4tiyH99tSx9i0AD9WTgIfSj9alW4fLOkBy5jTiX8ck8poB/IOGZ/6MoanSCKwN4gVmV
	 VT93deZWvUgZqr1nrOy5NFufyNILez+SZS81m/3/v9irFY55SxcP03Br2qIEaCE3rfTD7
	 DPOniR3ov9by4ErM/WnwmOjex9Xo+rBYHnFdRabeE2VbraiPWSnPfXxa3JedwP6a/RnFz
	 adE8yFmNI7nDH9cPT6KDqxCYPkh1yCPGzqkh0PdOhna9I5ze3MCU4f1GbQrovBTqpEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jotOPCU5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ppVdFIBB;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C1606A31C;
	Mon,  9 Nov 2026 07:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 996C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jotOPCU5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ppVdFIBB
Date: Mon, 09 Nov 2026 07:48:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794210506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7ia6HAcSNfWdLBd4/D4gU8O0cJq5FRXdZNy9UsYfp4=;
	b=jotOPCU51U+tVIfLanC+qle1guJDQ4U4HMB7/l10NQraBt79FxENWL641ZBGVoT8PIXBMK
	OggYR6DBc1WcPcUpK1qnhJVambX2d8VVO8/+t+fykqNEpl9gOFiPdC30JkmdBMLb1wMMfk
	vzHvPhk8IQmsbifbicbDienTfk6C31sdl6E18ElHnOz2fPuYKCj7v9DB9wx49isEArL+H3
	qfzt79KGM3c0PWHZ/rwIc4uITdKOXR5tufPR5UdXZj0U/tIzpl/5l879xEAwdD1BalsIit
	jC7s9DPwtJZrL9vbpFWnswCFojtKL7OHzspuL0v/wpEj9/l+pMpI5/BVP+p9fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794210506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7ia6HAcSNfWdLBd4/D4gU8O0cJq5FRXdZNy9UsYfp4=;
	b=ppVdFIBBskGNourXgJTCp3e+tvDqPduMrCUK9qfvLFF+MDlkKyXoCkqpe6V6EwqHEZAGha
	dUCeHMbnfI4xppAw==
From: "tip-bot2 for Jason Andryuk" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Don't print reset reason in VMs
Cc: Borislav Petkov <bp@alien8.de>, Jason Andryuk <jason.andryuk@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Juergen Gross <jgross@suse.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261104013026.185392-1-jason.andryuk@amd.com>
References: <20261104013026.185392-1-jason.andryuk@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179421050476.2093942.10171670781856963978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ea51d1a4c31fc8320c34f897dc5296a0bfc5c7ca
Gitweb:        https://git.kernel.org/tip/ea51d1a4c31fc8320c34f897dc5296a0bfc=
5c7ca
Author:        Jason Andryuk <jason.andryuk@amd.com>
AuthorDate:    Tue, 03 Nov 2026 20:30:25 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 08 Nov 2026 23:25:40 -08:00

x86/CPU/AMD: Don't print reset reason in VMs

print_s5_reset_status_mmio() expects to read FCH MMIO on baremetal.  VMs don't
have emulated FCH registers, so there is nothing to check.  Add an early exit
when running on a hypervisor.

The real motivation is Xen PV domUs can't boot on Zen CPUs.  PV domUs PTEs
contain system physical addresses - they don't have the concept of guest
physical addresses.  domUs can only map physical addresses they are assigned,=
 so
a domU fails to map the FCH MMIO addresses.

However set_pte() does not return failure, so ioremap() returns a pointer whi=
le
the PTEs are unpopulated.  print_s5_reset_status_mmio() faults when reading
through the pointer, breaking the boot.

Limit the reset reason printing to baremetal only where it actually makes sen=
se.

  [ bp: Massage commit message. ]

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261104013026.185392-1-jason.andryuk@amd.com
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3972966..2f7efd3 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1362,7 +1362,8 @@ static __init int print_s5_reset_status_mmio(void)
 	u32 value;
 	int i;
=20
-	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN) ||
+	    cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
 		return 0;
=20
 	addr =3D ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
