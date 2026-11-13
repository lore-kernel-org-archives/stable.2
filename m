Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542729;
	b=yCNc8hkmhQZzphnTDHSRZ1nD2zybP4339pbSFKxfW18BZ/fWa23Y/7YxM0TfGoSGWEIU
	 we/32KeJGiR4WaPpCbZ2zz6QoGuQ7KOUexi1XiEchaNqyulMVUI14PwcoWAqBb+WABTIJ
	 Wo1rxdb6MGqQUk4/CD4cUAyGVNsG8gG3sEJ3eot4EFfvI1tJqCeh8F2hjFD0TiFdQVnck
	 fcetXgBxRsqDDbKrLCecUetqV/AG58GO6Am40iga8y9gYyLoMTProqsPD3JB8mrUz3Spa
	 ljyxRQB4GHs5Mft2cFbX0AVUi44RzQORQ4vs62XF6gNNYlgqraEhN3gPQS+yZ/dN8ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542729;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=cSjwYB1H/33/pIUhMAid93PsP5KSpJh4krFm9dk6wmw=;
	b=f9Mn3aMUOeZbTjTwdO/kRZMR04cjKJNtf4+UXZpDteNhzUFX7dNIGnDr7EwPN/GDRtjs
	 BBRiatOfcpf4gPcOnw1ieBUaT81tJTNQ7CYNaXiVvbAStOO0SmQyi+Z5BJdzJFpq0R892
	 71N03zW8ibpVHb77RdrWZqckUyGTRmJx+ggRhbarKJlDXe1TBTSke1HuugB6Y92vq/6p3
	 vCF/mSmiknl0PLSdyFfyw+k7RABmXH1niUeXlogAqIYXLcqCeCkzJLOfKwN+jcfl+cejS
	 B7XjCFfn96DIQq/9Gu92LlTC+ctvUYZpsIhH2MiTauQkrnkK8JQIYWvCoREEAxUMGQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sSSBTmRC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wRcPyN8a;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615F606A323;
	Fri, 13 Nov 2026 04:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4615F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sSSBTmRC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wRcPyN8a
Date: Fri, 13 Nov 2026 04:05:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794542727;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSjwYB1H/33/pIUhMAid93PsP5KSpJh4krFm9dk6wmw=;
	b=sSSBTmRCpi0eiAS4KAqr8V5qDfn/JyZfMtdIhS7Z3Q7+UdVOzoDO3JgbJbAVzIuLXrFsEx
	JfGy3rxlJ1EH6oweewdlXWxlGnywMZve4IXHlQN0Sa5KBNEAExoNTsGbKOaxLVHBZ462kP
	y3bEgzjeHjiQ40pJdlE5i/yNt48+itVIEVZ8CkMYRTp4YdxQVGdiUnssvVMD56XXWPifIq
	oeSznuYKxwyyApZoycCEtHdHL4aID2p+p7p5p/nYrkriTt1nkskzp71TKX77HusCGhQZtb
	528v16otET/etAWdDmvjzIfzaatJc7Za30yfnWucTPUAFAFzQqCbOuKdS8YEQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794542727;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSjwYB1H/33/pIUhMAid93PsP5KSpJh4krFm9dk6wmw=;
	b=wRcPyN8aNyAWUnahwuKvbtQEFgPKmtGUFvZPwFQ56tTrsxbI7cnpvuuWQjjQESDsXl/WVz
	04wdOMtRNkBlcbCw==
From: "tip-bot2 for Hengyu Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/video: Preserve the default VGA fallback for
 legacy modes
Cc: Hengyu Liang <hengyul@cs.unc.edu>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103031630.2085194-1-hengyul@cs.unc.edu>
References: <20261103031630.2085194-1-hengyul@cs.unc.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179454272497.2969448.17262198902355060931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3b4c98b47ba7c3c57bcf54fb85f54a854622041c
Gitweb:        https://git.kernel.org/tip/3b4c98b47ba7c3c57bcf54fb85f54a85462=
2041c
Author:        Hengyu Liang <hengyul@cs.unc.edu>
AuthorDate:    Mon, 02 Nov 2026 22:16:30 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 12 Nov 2026 20:01:18 -08:00

x86/video: Preserve the default VGA fallback for legacy modes

Commit

  596b3678326d ("x86/video: Only fall back to vga_default_device() without sc=
reen info")

made video_is_primary_device() rely exclusively on screen_info resources
whenever any are available.

However, screen_info_resources() also returns legacy I/O and memory ranges for
VGA text modes. These ranges are not PCI BARs, so pci_find_resource() does not
find them and the default VGA fallback is skipped. As a result, no device is
primary in VGA text mode.

On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA (bochs) loses its
DRM boot_display attribute. VKMS registers fb0 and bochs registers fb1. VKMS
is not a PCI device, so it is not primary either. With no primary device,
fbcon keeps the console on fb0 and never remaps it to bochs. This can be
checked with:

  cat /sys/class/drm/card1/boot_display
  stty -F /dev/tty1 size

Without the fix, boot_display is missing and tty1 is 48 rows by 128 columns.
With it, boot_display contains 1 and tty1 is 50 rows by 160 columns. VKMS only
makes the console part visible. Without VKMS, tty1 has the same size with and
without the fix, but boot_display is still missing without it.

Use resource-based selection only for linear framebuffers. Fall back to
vga_default_device() for legacy display modes, while keeping EFI and VESA
framebuffer ownership authoritative.

Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() witho=
ut screen info")
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261103031630.2085194-1-hengyul@cs.unc.edu
---
 arch/x86/video/video-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 8ed82ff..b8f8334 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -45,7 +45,7 @@ bool video_is_primary_device(struct device *dev)
=20
 #ifdef CONFIG_SCREEN_INFO
 	numres =3D screen_info_resources(si, res, ARRAY_SIZE(res));
-	if (numres > 0) {
+	if (numres > 0 && __screen_info_has_lfb(screen_info_video_type(si))) {
 		for (i =3D 0; i < numres; ++i) {
 			if (!(res[i].flags & IORESOURCE_MEM))
 				continue;
