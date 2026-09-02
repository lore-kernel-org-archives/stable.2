Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4340B109;
	Wed,  2 Sep 2026 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384782; cv=none; b=qtj5reBtdNQr55i+eZFlRyCQfg454cUB/XlpifHznMppYUSZ66urDqAYxT4jMzkQkU9MB74h86xsUK1Dr4NSfE8gxtfycsIuHrEQy5DRv65vtEaW3my0NKVRFjJrtEyw8EWUqAyN7Tj6QvAsc8vQPQAj9+eiD8wegMKTJZNJFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384782; c=relaxed/simple;
	bh=YGH1Ioh0ywu4lRS+2zrKgxDnoG6RSJuXVK6HKFvt+Ik=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mCet7jsvhs2L6eT3NKoMRPgsxQojO3+4B2K+AyPtXLOQ1o/j+KAE8hGsC5P1d2+EnKAjozS7HIyIML2DRHz1UjdnCmgbjr+z4r9OWBnp2IPP/56nnGxg3Y3alrcAIds2p/UfhH7CEdjB50RHY9TdY92DJ1DRBtYz0mk1HA3e8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqr4wwWl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iKr+ULtR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqr4wwWl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iKr+ULtR"
Date: Wed, 02 Sep 2026 21:32:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788384765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnlC/t+34BpM7Zt4ETcDf9AAQOZrvQbhNMwegBYPVQ8=;
	b=iqr4wwWlojyYyokrw2wVXKe/YAWErgGppvxhR27rBIXLUtY/m+ib6q1VkCbAcawjPedwwZ
	AP4llk9F4+jBtjtTU/2tdWbrCQEwCabWLiLnOK8+XAvlJxS1WYWCAC5hfgcaUxBKVnbl0X
	1MSZFYGbu1XG/f2AilXZxYXy2/p86vGeEkIZc2+pXFo5/v9gCSw69qbUrvObOITD1cyZ19
	TrWlGP3XgEys7EqGWB7+eihQzCFD3yoeQITimf013xWsuCjf++2JXUulYnW2+HXxMczTxm
	D9PfcsoMGEta3oDoZjgEi4Mb+GdWgV3OjGENGOLaWbpo1M2Ox1f5R0OL9YmDJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788384765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnlC/t+34BpM7Zt4ETcDf9AAQOZrvQbhNMwegBYPVQ8=;
	b=iKr+ULtR/0p/814rUM64l6orLNujHOGGarpll9HQtq82dUwymvPJKwS6S/n/nP9TP+2cQx
	QzujsIxIUnUxqdBw==
From: "tip-bot2 for Jason Andryuk" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/amd_node: Prevent potential NULL pointer dereference
Cc: Jason Andryuk <jason.andryuk@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
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
Message-ID: <178838476395.3717435.3758438069102522441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     60714fb1d494e11d1eb54b0aef45e250c51279a8
Gitweb:        https://git.kernel.org/tip/60714fb1d494e11d1eb54b0aef45e250c51=
279a8
Author:        Jason Andryuk <jason.andryuk@amd.com>
AuthorDate:    Tue, 25 Aug 2026 17:48:03 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 02 Sep 2026 13:52:15 -07:00

x86/amd_node: Prevent potential NULL pointer dereference

amd_smn_read/write() are exported functions around __amd_smn_rw(), so
they are always available even if amd_smn_init() fails. In that case,
amd_roots is NULL and __amd_smn_rw() will access uninitialized memory.

Then, commit

  83518453074d ("x86/amd_node: Add SMN offsets to exclusive region access")

added smn_exclusive which indicated the calls to
pci_request_config_region_exclusive() succeeded to prevent concurrent
userspace access.

Commit

  0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")

re-ordered initialization so pci_request_config_region_exclusive() is called
earlier and a failure exits amd_smn_init() before allocating amd_roots.
Setting smn_exclusive moved to the end of amd_smn_init(), after amd_roots is
allocated. It became redundant and can be removed.

Replace smn_exclusive with directly checking amd_roots to avoid a potential
NULL pointer dereference.

  [ bp: Reorg commit message, touchup comment. ]

Fixes: 77466b798d59 ("x86/amd_node: Remove dependency on AMD_NB")
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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
