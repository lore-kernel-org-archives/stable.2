Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793146831;
	b=UyaUX1UTlP6Ox+aD0FaMBk0rGv0JW6LvknNBEQrj9IjU1sPAu+5xJPuBBZQhy8bDK2dB
	 Plwc2URPGKO+YttX7+1WwyDWxbBZhso6iFIeeObRKFDGbjspx+M3e5hEdTtw4hWYyl+QC
	 WazzLEdyhS/zpaP/Cfeh8YIStilrCkm4F0zjPHMKCTzzNGBVLvvvdJiEapAGI5nlZZGUm
	 VPT9gaze7Ac/1i2DQM0ECzLg41xXKMpXye/qkfndYvucM6qci4V7V+9hLD7HANHd+qrSi
	 tyJSj9oOm0JmyXqnlvTU25Qii2JUIRvASHf4S7i2ECdkwuWHfrD7VKJbuPLWgo3SGKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146831;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=SbSFMWMcTFtBtAC17/dwYk0aEIoGCNywrR+jlOIm7Tk=;
	b=4RYFZiCy6MQ0vgYMBp5sFU/DpvKfkcnPvsgoxg2JuLA720uY0vo7n2jj0RENDv4Ofk2X
	 Wsfwn7AfKvMrzvnZ7bTi5mKVat0UrggDX2TJWT9Uum87RgIcM+oNgJv1CNS1GLzFcRUGZ
	 rpd+JLtEJDtMZ2m0v69saS1exrpDhUFOgrB4OxrZK5MrlufrgTXb6amDZomVH8xg3wWGi
	 UUI84qiTcJuaH6ky+TRNTS8K9htxqpuzuwzu3B2Z+Pl6W9xPS9RCYV1vxt05fzOK78nS2
	 RVXyiSMZH8W01Ty49c5cK8MB3NBLYpabvDCxqvjNF2khBqlzI4u+fLusiKKdGvU0VhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bemRSK3Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA76606A31A;
	Wed, 28 Oct 2026 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bemRSK3Y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793146830;
	b=D+Vw5pVNMkCI4vNaKypRmkOSO+orDgAbc5698jAIRxz1oHxbS0b7gSkEsO08jXBCgMNg
	 BgVTaGrozMaHWLnRNVBJSesJl4QqwsblWicedBnwWdN1JMTQCkwg1pegEb+N2ZxDFKmBR
	 T8gPA0afyhtFdED9CEojC6U26Cj1moPV8qN1V9DVBxJr+gxLiJzCGxr7XavvPy4x+4esW
	 1M/osrAXqFVKpIHtXBYn9C0lAxzLQgqoF4HMJQ7QlG+zHVho5fGbTO8b/Uct4DwmgQpS1
	 GraEshW3sEo5ui7NHzZrrRzU59YRc9J9pnZXEAEogSezAtIqozWQkrJ8Ws3uGojTokw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793146830;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=SbSFMWMcTFtBtAC17/dwYk0aEIoGCNywrR+jlOIm7Tk=;
	b=13xaSV1v9tvdM0h4B/MVUBWy9VYh9qTnqYnwSy4cL8hvcZFeahTHkUuIDp7Zh9E+y1au
	 TTtrg7FdHOk3rnufuzzZSrB9EJ/QL1+Vsdax/HB9U1H5uLTa3QjW9gnutqEq7FLn/VU8W
	 HWO59emIfe5QauWRUcFpg9OGPsNiqs4rWa5+9xWmBICAYCVzn0EOonFZkbufBCUEvWxAN
	 eaE6g43X+r/LJJ3zU+pvKQG3Gfg69FLbAtFmG312L2Dbq4M9wXe+NahHU1z8DLXqqSc60
	 HojZZYGepgFrVK0x3O89xeh8SY0MXGOdOpT5toBY+1pdUE+1637qSJ7d80jKnMwX10Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC87C1F01829;
	Wed, 28 Oct 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146830;
	bh=SbSFMWMcTFtBtAC17/dwYk0aEIoGCNywrR+jlOIm7Tk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=bemRSK3YFz/m+5SiA1C4lxY171SzE1i+l8zopXijYO82S6L1T65Lj5+daqnActrvP
	 kNfqsO+m3w4NlVb4Svajhoxrsr0ytxPSyzKpZeYdkhkq0mZbWIPqKvNS2O9/lzw+Pl
	 KoXLvnBhR7sOPbp7U3hcRrS3STwa3YWb+20Tj/J6Jq9jCSGw2senAqVxnzMsAdjaKV
	 YCbguvtHW5ljlwkiswiVnt0WMOq9RBAR373Tf1H4sZUCmTrpv9n916HjyDy/W3k7dR
	 SnQTf4C6FnwOL98Eodb0cHsLpw0kdvMJOpOCpHfimq2i8XupDxNdHKCDbGLmb2MHs1
	 ZQDdaJu+NrUWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1C613452F9;
	Wed, 28 Oct 2026 00:20:29 +0000 (UTC)
From: Jez Ng via B4 Relay <devnull+jez.sfcompute.com@kernel.org>
Subject: [PATCH 0/2] thermal: intel: hfi: Stop hardware writing to freed
 memory after kexec
Date: Wed, 28 Oct 2026 00:14:44 +0000
Message-Id: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQ+4WoC/yXM0QpAMBiG4VvRf2zFwuRW5MDmGz+FNqTk3g2HT
 729F3k4hqcqusjhYM/LHJDGEZmhnXsI7oJJJrJIE6nEYFlMOGEElMm0snmZaVDoVwfL5/eqm99
 +1yPM9g7ovh/8KbM0bQAAAA==
X-Change-ID: 20261027-hfi-kexec-e7c4b7f584be
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
 Len Brown <len.brown@intel.com>, 
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Andrew James <ajames@sfcompute.com>, 
 John Ranzie <jranzie@sfcompute.com>, Jez Ng <jez@sfcompute.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793146828; l=3133;
 i=jez@sfcompute.com; s=20261027; h=from:subject:message-id;
 bh=Q35Ngjcsidz/Av1fy+wnmQitU+ZbicSO+I9WZ2tM750=;
 b=+KBJozgnpPCuPVlgyuw7GVpttKhbd1B1UkcoLr6T/hB4ZH/VHKiVtKh4xfpgpVlldAaF4QLbE
 skjnuMuefbkAJwSab7sOmc4GTCkzw9naIBsm5wI5dSRTTzxrJWHK8qE
X-Developer-Key: i=jez@sfcompute.com; a=ed25519;
 pk=e8QxvBomwv96udVoo4EZvgPDtnl1YbPysb3vNdKi8JA=
X-Endpoint-Received: by B4 Relay for jez@sfcompute.com/20261027 with
 auth_id=1337
X-Original-From: Jez Ng <jez@sfcompute.com>
Reply-To: jez@sfcompute.com

HFI hardware writes updates to a table at a physical address the kernel
programs. Nothing disables HFI on shutdown, and since commit b33f3d2677b8
("thermal: intel: hfi: Enable HFI only when required") a kernel that
starts without thermal netlink clients does not touch HFI at all. So
after a kexec, hardware keeps writing into the previous kernel's table,
which the new kernel treats as free memory.

We hit this on dual-socket Sapphire Rapids hosts (Xeon Platinum 8462Y+)
that boot a Debian 6.1 kernel and kexec into a 7.0 kernel. The new
kernel crashed in find_inode_fast() when the inode hash table landed on
one of the old table pages. Reading MSR 0x17d0 on the running 7.0
kernel showed both packages still pointing at the 6.1 kernel's tables,
and the corruption had the HFI table layout: a timestamp, a changed
flag, then one row per CPU.

Patch 1 disables HFI in a syscore shutdown callback, which covers
reboot, power off and kexec, and keeps it disabled afterwards: on kexec,
user space runs until machine_shutdown(), so a new thermal netlink
client could otherwise enable HFI again. Patch 2 makes a starting kernel
disable HFI if the previous kernel left it enabled. Patch 2 can only
narrow the window: hardware can still write between kernel start and
the moment the package's first CPU reaches the thermal online callback,
which was about 30 seconds into boot on these hosts.

This is the kexec counterpart of the hibernation corruption fixed by
commit 97566d09fd02 ("thermal: intel: hfi: Add syscore callbacks for
system-wide PM"), which disables HFI for suspend and hibernation but not
for shutdown.

Tested on one of the hosts above with both patches applied to this base,
alternating 100 kexecs (kexec_file_load + reboot(LINUX_REBOOT_CMD_KEXEC))
between the patched kernel and an unpatched 7.0 kernel. Before each
kexec, a thermal netlink subscriber enabled HFI on both packages. All
100 passed:

 - Patch 1: after each of the 50 kexecs out of the patched kernel, the
   unpatched kernel read HW_FEEDBACK_CONFIG = 0 on both packages.

 - Patch 2: after each of the 50 kexecs into the patched kernel, it
   logged "HFI left enabled on package N, disabled" for both packages
   and read HW_FEEDBACK_CONFIG = 0.

A test-only 5 second sleep after the shutdown callback, with a thermal
netlink client subscribing during it, showed that patch 1 keeps HFI
disabled. Without the hfi_shutdown_done check, the next kernel found HFI
enabled again.

Thanks to Andrew James and John Ranzie for reviewing.

The investigation and testing were done via Opus 5.5, as were the
drafting of the patches and changelogs. I reviewed all of it.

---
Jez Ng (2):
      thermal: intel: hfi: Disable HFI on shutdown and kexec
      thermal: intel: hfi: Disable HFI left enabled by a previous kernel

 drivers/thermal/intel/intel_hfi.c | 71 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 8 deletions(-)
---
base-commit: 70f331d89564126fdcaaa37f25194fe391d8f3fa
change-id: 20261027-hfi-kexec-e7c4b7f584be

Best regards,
--  
Jez Ng <jez@sfcompute.com>


