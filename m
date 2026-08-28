Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA701448E0;
	Fri, 28 Aug 2026 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887217; cv=none; b=U7Z8Dz4bWmW3dwAohKkHtiL531/va+w4+7fzeD3gcIm+JvTZ90XnQNLdYHvyEymgRjINTN36m/+2FaMztjGn3V3CaZrNoP9PmdgYgLl8ppucyXJeK9daFxIZY/ad3Fg0b7oXjKZ/uJ0SFbyihx+ea2QxdV0PNFsonRDFI4eLf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887217; c=relaxed/simple;
	bh=nbHAPIj9By8rrcKYY1reKxYEa32ax6KO7ebFKK6TmKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gq+abquI2XJ43HXGulof842kpq7Y0lSCNTfrkGXkCKI9L9SkCOklIfRLSQD1kKW0joAU3Vnr4Jyl/1UGbMaQtIcA5Qk5w7SIKCOR0/gpuL11/g1G2ZQ1cYHgDG4fj+DTXbBm6P8VoddKVU7WAXOKKV5nU2tCQuRpNtvVsam0L/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OlFNxeu+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=txv8Xjjz; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OlFNxeu+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="txv8Xjjz"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hWNtN1sr1z8v4R;
	Fri, 28 Aug 2026 05:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787887212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GHZ2xVh5v+YPKAnAGNjJoiKICOFNNjf0Cg/Bo8t5giA=;
	b=OlFNxeu+YBTNN04nZxyXk7KYujfLEmm6kfeeE2jDkS/uxv9XqnwKft0dBQnDYw9L0GvqSI
	PjhDbGIbngnc4avzxpCGeJuqVNMsaAtpc5tZeLUaev5qGi9JkP4bPsqcWPAR9qAdXi1mnR
	lS4v1HrpiYufNogHrNiF2sH4sIL5GNPBYTHju5Mczk+KH+WpiuiYEm/04OBBUuPKifdRXo
	d5PnZ9G/8XzE5Fs/K0Z/u6/pt1pxpRr1Z1mBM/FDgy9hdy7Ly8eNpe9uf+c+QAiKmH1Jqw
	YUuUDuqptRbJIO8n+h+fq8V6kuEuCL3Wbci1W7JfUSpbHUh8RJp9BPfhEnCj8w==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787887210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GHZ2xVh5v+YPKAnAGNjJoiKICOFNNjf0Cg/Bo8t5giA=;
	b=txv8XjjzXfzEjGpus9JYGmP6bPHdbYOXWLWDWyb04++S0Eti2iq+4z3XANLka0GJSHeYUF
	ypFXSbfAVLr2S4bvRvGlgNuZHaICH71pbBxqRIwyMfXJQk4EBaiyUbPTeZpbXXelJRnzMK
	XwYXMkKSqrao/XfrAzaMJF3AapS+Y/EJBQqduwdYr5l0VSY4hhndX6mZeg3OLhhSK9SGgX
	ZDaAARsiEvE3DWvDHX64mfYEkQjRpkEOc2EJ8B+vmCa0Zb3dx69x3ZNZiQKR4ma4jVt5xP
	P8lBUFgt+YVFZXneEcj/+/sWLkLXpDWaDWmESFmcOqz4GmLAspykt5eXeP8WEQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Daniel Starke <daniel.starke@siemens.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH] tty: n_gsm: pin DLCI during configuration ioctls
Date: Fri, 28 Aug 2026 11:19:49 +0800
Message-ID: <20260828031949.18580-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4jr86dfb6skdhk5ehmirjm5fdxmpayon
X-MBO-RS-ID: 3ddbde06dd230ad720b

The N_GSM line discipline keeps per-channel state in the mux table
gsm->dlci[].  GSMIOC_GETCONF_DLCI and GSMIOC_SETCONF_DLCI fetch a raw
pointer from that table and then read or update the DLCI
configuration, allocating the entry on the spot when the slot is
empty.

The table lookup is done without holding gsm->mutex and without
taking a reference on the DLCI.  A concurrent GSMIOC_SETCONF that
changes the multiplexer configuration calls gsm_cleanup_mux(), which
releases every table entry under gsm->mutex; the final tty_port put
frees the DLCI.  The first ioctl then keeps using the freed object:
the GET path reads it in gsm_dlci_copy_config_values() and the SET
path writes it in gsm_dlci_config().

The issue was found by static analysis of the returned-pointer
lifetime.  A reproducer on a PTY-backed passive mux racing 16
concurrent GSMIOC_GETCONF_DLCI readers against repeated mux restarts
via GSMIOC_SETCONF, with no fault injection or artificial delays,
produced the same KASAN report in 2 of 2 unpatched boots: the first
report landed within half a minute of starting the race, and each
120-second race window averaged 2-3 reports per restart (486 reports
across 172 restarts, then 357 across 162; the copy helper is inlined,
so KASAN names the caller):

  BUG: KASAN: slab-use-after-free in gsmld_ioctl+0x156b/0x17e0
  Read of size 4 at addr ffff88800b84d008 by task n_gsm_dlci_conf/226

  Call Trace:
   gsmld_ioctl
   tty_ioctl
   __x64_sys_ioctl

  Allocated by task 218:
   gsm_dlci_alloc
   gsmld_ioctl

  Freed by task 235:
   kfree
   gsm_cleanup_mux
   gsmld_ioctl

The reported address is 8 bytes inside the freed 2048-byte object
(cache kmalloc-2k), i.e. the read of dlci->addr.

A control run with this patch applied completed 19291547 GET
iterations and 226 restarts with no KASAN report.

Serialize the lookup/allocation against mux cleanup with gsm->mutex
and acquire a tty_port reference before dropping it.  A concurrent
gsm_cleanup_mux() then either completes before the lookup, in which
case the slot is NULL and a fresh DLCI is allocated, or runs after
the reference is taken, in which case its put is not final and the
object survives until the ioctl releases it.

Fixes: afe3154ba87e ("tty: n_gsm: add ioctl for DLC config via ldisc handle")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Ming <a0yami@mailbox.org>
Assisted-by: Claude:kimi-k3
---
 drivers/tty/n_gsm.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..605549d742e6 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2711,6 +2711,22 @@ static inline void dlci_put(struct gsm_dlci *dlci)
 	tty_port_put(&dlci->port);
 }
 
+static struct gsm_dlci *gsm_dlci_get_or_alloc(struct gsm_mux *gsm,
+					      unsigned int addr)
+{
+	struct gsm_dlci *dlci;
+
+	mutex_lock(&gsm->mutex);
+	dlci = gsm->dlci[addr];
+	if (!dlci)
+		dlci = gsm_dlci_alloc(gsm, addr);
+	if (dlci)
+		dlci_get(dlci);
+	mutex_unlock(&gsm->mutex);
+
+	return dlci;
+}
+
 static void gsm_destroy_network(struct gsm_dlci *dlci);
 
 /**
@@ -3862,29 +3878,29 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 		if (dc.channel == 0 || dc.channel >= NUM_DLCI)
 			return -EINVAL;
 		addr = array_index_nospec(dc.channel, NUM_DLCI);
-		dlci = gsm->dlci[addr];
-		if (!dlci) {
-			dlci = gsm_dlci_alloc(gsm, addr);
-			if (!dlci)
-				return -ENOMEM;
-		}
+		dlci = gsm_dlci_get_or_alloc(gsm, addr);
+		if (!dlci)
+			return -ENOMEM;
 		gsm_dlci_copy_config_values(dlci, &dc);
+		dlci_put(dlci);
 		if (copy_to_user((void __user *)arg, &dc, sizeof(dc)))
 			return -EFAULT;
 		return 0;
-	case GSMIOC_SETCONF_DLCI:
+	case GSMIOC_SETCONF_DLCI: {
+		int ret;
+
 		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
 			return -EFAULT;
 		if (dc.channel == 0 || dc.channel >= NUM_DLCI)
 			return -EINVAL;
 		addr = array_index_nospec(dc.channel, NUM_DLCI);
-		dlci = gsm->dlci[addr];
-		if (!dlci) {
-			dlci = gsm_dlci_alloc(gsm, addr);
-			if (!dlci)
-				return -ENOMEM;
-		}
-		return gsm_dlci_config(dlci, &dc, 0);
+		dlci = gsm_dlci_get_or_alloc(gsm, addr);
+		if (!dlci)
+			return -ENOMEM;
+		ret = gsm_dlci_config(dlci, &dc, 0);
+		dlci_put(dlci);
+		return ret;
+	}
 	default:
 		return n_tty_ioctl_helper(tty, cmd, arg);
 	}

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.53.0

