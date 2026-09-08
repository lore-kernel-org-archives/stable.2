Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F33955F7;
	Tue,  8 Sep 2026 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852097; cv=none; b=Gas4zgqTMxCPEPMECq2VN1XKDql3P3qqxRhG5YIqCPlJuZxi7yWUUZizJb3ryMw4Ko3/qUr6IssHQcIU7spgm83TFgFkIylfuumt4MAbMR+qO/g2qNCJ+4AU2WZy+FtgdyX/g8/nIP8Seosw8Uc2nCiNmVdgiHtwvGolcl/uKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852097; c=relaxed/simple;
	bh=9VjWwdaIjWKwCkmjMMQ+TiQIgYPbHdrq7cTFbjUOUhI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T9bKoKONZ7IA9CZeb79GoL135Ut4i196X+KPutimKvWbhZdk4oMHwnOairYGTbllhcpgxQpysA1In3+OauTJhIuFBtj++XVRd178CpuyVCo0WZ35osg21EIcxs9iyN0vG8H+FnXPxajwDxfwOtm8GFDhMbpdBeg+Viw12xj6ovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U/Bm+qPd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtyRdzEe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U/Bm+qPd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtyRdzEe"
Date: Tue, 08 Sep 2026 07:21:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788852093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Es93h0JzaYMyLYuYmNaYPWTMoEitkI+BgJ0PO45OFrk=;
	b=U/Bm+qPdhWUwEjZKMr7mlIrAPWAtrWIIaRdiMJuN3wU5L5OkD9Mqb2cq4TYLF0BIbo7Y5k
	B4RSAjP8/ykP7YfZ4W3OdBE5PnRn967lnWzD2TQx3itGts7ZU59nFgMVmQm97mlbrDhjMr
	w90eJRoV13fWwvhOd+S60QpizdxrXA/I1qvZiIICj9O9SOeX540wnp3YCUf2f+ybnW121v
	BoaftdstlS60MSUtIShEVMDG2jqpS44gYxJK8CESyTpxlqTnJ9X2xsKRjHEITUGkOfQjsO
	LId6QjpK3AzkYxNIv+tHMrV1eTEDstySHMFzNn4kjK/3I9xLS9sDwp3ZxBmDGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788852093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Es93h0JzaYMyLYuYmNaYPWTMoEitkI+BgJ0PO45OFrk=;
	b=gtyRdzEegjH/djqKRwRRLIs+17kZgz7N29NXQuRsuyQFbTYdXzESCDlolCWeCTvIu6abPS
	cTtXHFusAucLKiDQ==
From: "tip-bot2 for Jason Andryuk" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/amd_node: Fix potential NULL pointer dereference
Cc: Jason Andryuk <jason.andryuk@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260825214805.39148-3-jason.andryuk@amd.com>
References: <20260825214805.39148-3-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178885209203.623050.9436256911569173251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     aefdbd574a362dcf7569bada6d72f64a006b9fb9
Gitweb:        https://git.kernel.org/tip/aefdbd574a362dcf7569bada6d72f64a006=
b9fb9
Author:        Jason Andryuk <jason.andryuk@amd.com>
AuthorDate:    Tue, 25 Aug 2026 17:48:03 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2026 09:16:22 +02:00

x86/amd_node: Fix potential NULL pointer dereference

amd_smn_read/write() are exported functions around __amd_smn_rw(), so
they are always available even if amd_smn_init() fails. In that case,
'amd_roots' is NULL and __amd_smn_rw() will access uninitialized memory.

Then, commit:

  83518453074d ("x86/amd_node: Add SMN offsets to exclusive region access")

added the 'smn_exclusive' flag, which indicated the calls to
pci_request_config_region_exclusive() succeeded, to prevent
concurrent userspace access.

Commit:

  0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")

re-ordered initialization so pci_request_config_region_exclusive() is
called earlier and a failure exits amd_smn_init() before allocating
'amd_roots'. The setting of 'smn_exclusive' moved to the end of
amd_smn_init(), after 'amd_roots' is allocated. It became redundant
and can be removed.

Replace 'smn_exclusive' with directly checking 'amd_roots', to fix a
potential NULL pointer dereference and to simplify the logic.

  [ bp: Reorg commit message, touchup comment. ]
  [ mingo: Rebase & further touchups. ]

Fixes: 77466b798d59 ("x86/amd_node: Remove dependency on AMD_NB")
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260825214805.39148-3-jason.andryuk@amd.com
---
 arch/x86/kernel/amd_node.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 408b9fd..7625857 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -38,7 +38,6 @@ static struct pci_dev **amd_roots;
=20
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
-static bool smn_exclusive;
=20
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
@@ -91,11 +90,16 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32=
 address, u32 *value, b
 	if (node >=3D amd_num_nodes())
 		return err;
=20
-	root =3D amd_roots[node];
-	if (!root)
+	/*
+	 * Uninitialized amd_roots indicates pci_request_config_region_exclusive()
+	 * didn't run or failed and thus the kernel cannot rely on having
+	 * exclusive access to SMN registers so prevent that.
+	 */
+	if (!amd_roots)
 		return err;
=20
-	if (!smn_exclusive)
+	root =3D amd_roots[node];
+	if (!root)
 		return err;
=20
 	guard(mutex)(&smn_mutex);
@@ -313,8 +317,6 @@ static int __init amd_smn_init(void)
 		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
 	}
=20
-	smn_exclusive =3D true;
-
 	return 0;
 }
=20
