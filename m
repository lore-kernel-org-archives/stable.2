Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7842BEC4E;
	Tue,  1 Sep 2026 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222460; cv=none; b=Cj6jeDUGI4tpZ34kJO1B+lU9UiOqJZ8a0k2ty3kkta4ci7KAz/102/GbV9n9mY7Xn7qYT0sOh7OJ0DZPvq2+niHtw7oQ2rG7J3E68DWTNRg6P4reF2IDNGU5VflToe+wiyoi+atEiOYqFpVgUojShwI59OfWIS12wjcW7XXGv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222460; c=relaxed/simple;
	bh=/OGVWDx7+TFb7bNqod46Eph46vbXerGxh9YA4lIA9Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNzVsP+cYz240Pao2BdCiF8m0iz89QGxT/4JZq+5Bubpa2e+VBxnTjMgAwmAxGNtkQo8vHSjCN6Di8axpOZTa1fiJd5R1xn1A2Lf8vIz924TRrFQTz4gtezS8gzTg79S7Whb8vMZccGL/jY7HoLGnL4F6aexHENJBXQ47b9P/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q7LkG32f; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q7LkG32f"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E89540E01ED;
	Tue,  1 Sep 2026 00:27:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bKvd3wzAuRUZ; Tue,  1 Sep 2026 00:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788222442; bh=EliQ49XxDKp/1T09JhztQon1FzUKtJyFqOwY8jQK334=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7LkG32fr6ddOIcISHqfpn6ssDg2vmeL2x382oPD7ylOLyw1/69Usj72jGFFBXIsc
	 zMezJZOJk6CVEeWMLySaqDEp7/Tl0dNVpKTbltzofzygCwCPzz20DlmSo14gl7VHFB
	 AscX0nzDXkwRckFZhgX7mBfU1v4ksJm188F3mn+vJnqmQNLrKQkAMz1V/nQe9rwqEz
	 x7sqNjsWEEO+gjHUgljsjeSB77JFKMeNn/jj2RmyEilG0EFj36yj1kSQjfYyhYhlK5
	 QtDziuz8b7VHd1TG8LtfsN1RPxlPurI5tGXjk7FCtKZRdv3/RreheYIINgpysDiKHV
	 3a7lB4LbHAKdbRhvvl4epxJo9teJugMtydsHHb70PvexVaSP8hjcMMBKgZy2+bPZim
	 drhSDZOYae+20Akk9haA/8TB88AuSsws3p7QtvACtiiX5QjuniSDPAx85Xb/8BoPTs
	 Iw2Y5V4jwqk2w6cdLsAMYBsdDQ6wWlweFS2NBre/aO+V6m8BIw7sZpUQ5HG+Ewzf4J
	 Unv95Ui1SfaZnRSFzYTXGJp3C3yCfE8xlAlX1HjIVC/LdZWz8om9ldDOwE/D/MkPYH
	 W3DIV53DTNcxKWuj5WgMr6H5A+vxz877JoGRTlJOplLr502gybw+AHmqjpFcJisNuD
	 0ZS1PVbDxkUIcQpCzREBM5w0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6543640E01B5;
	Tue,  1 Sep 2026 00:27:09 +0000 (UTC)
Date: Mon, 31 Aug 2026 17:27:05 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org,
	Penny Zheng <penny.zheng@amd.com>, stable@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [PATCH v3 2/2] x86/amd_node: Remove smn_exclusive
Message-ID: <20260901002705.GFapYb2c6fPJYqokRi@fat_crate.local>
References: <20260825214805.39148-1-jason.andryuk@amd.com>
 <20260825214805.39148-3-jason.andryuk@amd.com>
 <20260831023016.GEapTnOHTbN8XZGe2j@fat_crate.local>
 <13e77e26-7b4e-452f-bc61-a84acadf37f0@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13e77e26-7b4e-452f-bc61-a84acadf37f0@amd.com>

On Mon, Aug 31, 2026 at 01:52:08PM -0400, Jason Andryuk wrote:
> No, the code and the comment are both correct as posted.  It's just that I
> wrote the comment reversed from the code to state the positive property we
> want.

So if amd_smn_init() succeeds, that means we have registered the PCI config
regions of the PCI roots, including the SMN ones, as IORESOURCE_EXCLUSIVE and
they won't be exported to userspace through /dev/mem and what not.

So, any caller of __amd_smn_rw() should fail because it is coming from kernel
space and it can expect that userspace could interfere with the hw and thus
not a good idea.

So yes, this is what got me confused and the (!amd_roots) check is correct.

> I'll change this whichever way you want.  It's not a big deal, which is why
> I added the comment like you requested originally.

I think I already "intercepted" your suggestion, see here:

From 1a1c4addc5a14e9ef2bb7d351a62ff4563d0f10a Mon Sep 17 00:00:00 2001
From: Jason Andryuk <jason.andryuk@amd.com>
Date: Tue, 25 Aug 2026 17:48:03 -0400
Subject: [PATCH] x86/amd_node: Prevent potential NULL pointer dereference

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
index 408b9fd48349..762585775b5a 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -38,7 +38,6 @@ static struct pci_dev **amd_roots;
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
-static bool smn_exclusive;
 
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
@@ -91,11 +90,16 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	if (node >= amd_num_nodes())
 		return err;
 
-	root = amd_roots[node];
-	if (!root)
+	/*
+	 * Uninitialized amd_roots indicates pci_request_config_region_exclusive()
+	 * didn't run or failed and thus the kernel cannot rely on having
+	 * exclusive access to SMN registers so prevent that.
+	 */
+	if (!amd_roots)
 		return err;
 
-	if (!smn_exclusive)
+	root = amd_roots[node];
+	if (!root)
 		return err;
 
 	guard(mutex)(&smn_mutex);
@@ -313,8 +317,6 @@ static int __init amd_smn_init(void)
 		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
 	}
 
-	smn_exclusive = true;
-
 	return 0;
 }
 
-- 
2.53.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
