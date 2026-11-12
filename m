Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794461452;
	b=QZT3LYgYqb2ytzt67lY7Lcj6yl/4O4U9mNzDIjt6Xw3xEqD+oJEiCckwJ03IUuVny73E
	 ZPEF9n6kxsfj8IHzy03bInA8LIac/umDy+RloZ3eR/2ZtF7LWBAOsdVNjy625pmFOkAYB
	 j8d0ZdQ8pUFnG1amamVfngnsWvmCP74ex9k4feP2p3mzm/qdf14AQ4CPxgG2+CmDKz65S
	 i3OgQwAWIdzSkOOqK+TSoBr2kmKG/9CG1LKQjdM//LQv9wKClB5OqRd2FEwYckZUOYxt9
	 yENQzQR0AobTVNO/avoqZPZXrnHf45xIzpKHRUBchl/Vgx2nVY3CDDINZQXJxgfBXrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461452;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UviLEzCi5yC1tk6oTyIn9YBlv7xdwXYD5u/ePdmahAQ=;
	b=2bnSy1LCBNQdRHIhjuzPeJIgq6jBwXFgut+geJqtwZrMx2G7zHnIqZpSK1c7+hntqGRn
	 1Pj6og44tH9QoBdDx7VK1i43bF62fOvlO9xxE2JgSdd8wvBkSdNWQ7Zue0nlgRMjHKYz2
	 n1e6QKgPV056yqNW8Ll37NcFh3Iqd/y5tLFLbKHgVk1tY2MgYELkzi/CmVDY+yB75+FlE
	 2CRWClq5xgyryGWLAdHpAcjoANDhgWJ6MSqgk/gK+YRFsCjaPkH0yCIAHpVCSDwMrTz1b
	 Z+VHSjq5dS9OJs28lLWI4E415k1Z48Ii68dQF4ZgN/XXDeoB/oYTVPdJiQgsi/Sk7OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUwBi8wW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42250606A327;
	Thu, 12 Nov 2026 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUwBi8wW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794461451;
	b=v/3TwPWeNUyph4m0gCDNy3iW2M1clrGxw1u+Q/sFZma27MQQj4+aQUfkW8ZWocqT+qzc
	 12JFny53rcSZyhvRYfs4/dZa7l5hIhLT4zbjVQtf7GMxdMxskByUBlnTjg3eXMyk/Y+FC
	 0Z3gd2sWzAx8n1nrEAucrgzbXuj7l7yi8xn/mdY70VaC6bD+A55bmLaG+surZruJ9OW99
	 rd4oCRn7u10/Kg2RUby3NBelE2rYmG47xR0mD+CaUU7qSd1FBYzRBIQzePCnWHlcKAc9J
	 PtsbuWr81xO//OBb+dCsR94bP5w/VSCq2ncQbgiWgoe+MSfhPnRKiyhX9nglunl4gCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794461451;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UviLEzCi5yC1tk6oTyIn9YBlv7xdwXYD5u/ePdmahAQ=;
	b=qEwYb9dkwAidr8WX3GxdXdYJ0M2ZM6Fkg0UhGpsxw0NUCI2ICq2BzJBnndbiVYpBhjMg
	 WowGroQD9CZ0GPJ/cbFNde5aCoqfYwt1M2mv6u+a1xasMGRobJ8nwNctjDqhGXVo9aPvF
	 pRTDrdKbmn13BCOz1G8niQIfU6KCoys9sHwirjRl9oJGUVzgdnd4wDl8AjITrRtRptw8O
	 D0YPGxLuyU1DF5iV+893NGpPLyM4+6UQjPnkLZLKX5h0xFnfdk4J4MxFcHEJjdsMyjauG
	 GS4x3p74IoEiZVMrr8X7opiJOWpN/FEnYHjsphRSHdk6oVB//2Sc5Xzx5DYbcgVr0tw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 436771F00A05;
	Thu, 12 Nov 2026 05:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461451;
	bh=UviLEzCi5yC1tk6oTyIn9YBlv7xdwXYD5u/ePdmahAQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=GUwBi8wWY6wQbdgsyweWdRlorWzWUgdE9Op5xsZSzz4gQ6RIFYWbGWSrgj3T9rMpT
	 2nHH5jKx1WuUn1k54RCx2VEhUB/dPXvSGnckZwUf3cROvckFVAoNs2DgNrGZEOoWWN
	 +X4PROSX8CpJGPN2Szej/gNqRocFWcrsSVoAczPj3MQpXoxH2cK4+PdZDM8nc9MROk
	 nZmJBiI3nZcqwJF0da4XP63wSWI5JnhKbBREAkTxKEwLBvdypV+twMWZ3GK1g1wCoM
	 LgXqheck3lo7zpfopgdZOsRjawDoaL26IW2J9mdEtDqxo1FA8QLPp3Ib69QnJO94PR
	 +bEosHAgaT0KA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B52AA49191;
	Thu, 12 Nov 2026 05:30:50 +0000 (UTC)
From: Weidong Wang via B4 Relay <devnull+weidongw.illinois.edu@kernel.org>
Date: Wed, 11 Nov 2026 23:30:25 -0600
Subject: [PATCH] remoteproc: elf_loader: Bound the program header table
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-c3-n021-v1-1-17c9151d0245@illinois.edu>
X-B4-Tracking: v=1; b=H4sIAPBO9WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINBNNtbNMzAy1DU3MzC3NDFJNbJINFMCqi4oSk3LrACbFB0L4ReXJmW
 lJpeAtCvV1gIAFv8ZXWsAAAA=
X-Change-ID: 20261111-c3-n021-7607944e28a6
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Zijie Zhao <zijie4@illinois.edu>, 
 Weidong Wang <weidongw@illinois.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794461450; l=3782;
 i=weidongw@illinois.edu; s=20261108; h=from:subject:message-id;
 bh=1+dxp4TSkvo99vpszS33ptcnuh7ZLO8mxAuiCbEJZ2s=;
 b=bVPFLFW4TgQVG01rb6iT1GKoLw3UEMEXZT1PQ1ti01+uV1i5KUnacemlHqoDQKt+eKN/EjRiQ
 AdOjFspT8u7BJPxCdT1GZ+ecwgUOIhE8YRUWHLAIt+jqJQKGZCwSdUX
X-Developer-Key: i=weidongw@illinois.edu; a=ed25519;
 pk=DR2S1xPEa5sELrWPfOpvUphJQ2VHC+MDc/wJavE/ifg=
X-Endpoint-Received: by B4 Relay for weidongw@illinois.edu/20261108 with
 auth_id=1449
X-Original-From: Weidong Wang <weidongw@illinois.edu>
Reply-To: weidongw@illinois.edu
Content-Transfer-Encoding: 7bit

From: Weidong Wang <weidongw@illinois.edu>

rproc_elf_sanity_check() checks that e_phoff lies inside the image, but
not that the e_phnum program headers after it do.
rproc_elf_load_segments() then walks all of them, so an image that
declares more program headers than it contains is read past the end of
the firmware buffer. Both fields come from the image.

Commit b32177ead5f8 ("remoteproc: elf_loader: Bound the section header
table") added the same bound for section headers. Do the same for the
program header table.

Found by an AI code review agent (an LLM-based bug-finding tool
developed by Zijie Zhao and the submitter) and confirmed on an
unmodified kernel, without error injection, on x86_64 under QEMU with
KASAN, using an out-of-tree test module that registers a remote
processor with the stock ELF helpers (rproc_elf_sanity_check,
rproc_elf_load_segments, rproc_elf_get_boot_addr) and a da_to_va backed
by a kernel buffer. Booting it with a 120-byte ELF64 image whose header
claims 64 program headers at e_phoff 64 gives

  BUG: KASAN: vmalloc-out-of-bounds in rproc_elf_load_segments+0x4e5/0x6a0
  Read of size 4 at addr ffffc90000035078 by task run/72

i.e. the first byte past the image, in the buffer allocated by
kernel_read_file(). The same image with e_phnum 1 boots cleanly.

With this patch the oversized image is rejected with "Program headers
are out of bounds", and the e_phnum 1 image still boots.

The reproducer, fix and changelog were drafted with AI assistance
(Claude), then reviewed and tested by the submitter.

Fixes: 400e64df6b23 ("remoteproc: add framework for controlling remote processors")
Cc: stable@vger.kernel.org
Cc: Zijie Zhao <zijie4@illinois.edu>
Signed-off-by: Weidong Wang <weidongw@illinois.edu>
---
Tested on v7.4-rc1 (05441d697f7f), x86_64, KASAN, QEMU/KVM, with an
out-of-tree test module that registers a remote processor using the
stock ELF helpers and a da_to_va backed by a kernel buffer. Firmware
is a 120-byte ELF64 image, program headers at e_phoff 64:

               e_phnum 64                      e_phnum 1 (control)
  unpatched    KASAN vmalloc-out-of-bounds     boots
               read in rproc_elf_load_segments,
               first byte past the image
  patched      "Program headers are out of     boots
               bounds", -EINVAL

No KASAN/UBSAN reports on the patched kernel. The code is unchanged in
mainline, linux-next (next-20261111) and rproc-next.

The reproducer is not attached (AI-found issue, see security-bugs.rst)
and can be shared on request.
---
 drivers/remoteproc/remoteproc_elf_loader.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index da3cddbe7..54e1fd4bd 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -46,7 +46,7 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
 	struct elf32_hdr *ehdr;
 	u32 elf_shdr_get_size;
 	u64 phoff, shoff;
-	size_t shend;
+	size_t shend, phend;
 	char class;
 	u16 phnum, shnum, shstrndx;
 
@@ -126,6 +126,13 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
 		return -EINVAL;
 	}
 
+	/* rproc_elf_load_segments() walks all e_phnum program headers */
+	phend = size_add(size_mul(elf_size_of_phdr(class), phnum), phoff);
+	if (phend > fw->size) {
+		dev_err(dev, "Program headers are out of bounds\n");
+		return -EINVAL;
+	}
+
 	dev_dbg(dev, "Firmware is an elf%d file\n",
 		class == ELFCLASS32 ? 32 : 64);
 

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261111-c3-n021-7607944e28a6

Best regards,
--  
Weidong Wang <weidongw@illinois.edu>


