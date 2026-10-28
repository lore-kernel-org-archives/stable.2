Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793146831;
	b=XAXqHeujGPv9FMOMkRgkC//fohR/joX+YCqKQVR0wOLfvkgR1BdrKKhuPVOLcruS5SRW
	 aXOBQ8G4vZYqHNJkmQgt45Mp5FmVwb3LAdm/KFDOQQsAytXpwu70L/9ZDM4CMP1TYnP5V
	 H5BfdfZ4FATXii+Foq4ilYNH2AHFBuSM5o/+O6ZfKVqmu/bu2ToIJ4bmoeOpY2RhcSgVj
	 k2hCnBwIf0YhX0FvkgnjlbnHcX/x0QY6FYXteMlJpdb48HNB7lgZawzxa4Id1+MJIRVsK
	 MOYDj9BlCddC5/yyqJ3VXUUpFmd9htlf6i99cyeRM+i3DgE0EsOAMarmewsegFonnaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146831;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tJzDohBgQIEeXhbGPUON1R9UnoZ1QEo5Jwi1O8KFilY=;
	b=Rknc9hkz+GY2BDc4wQaCuJy8iRvNg4xa6vdLWOUEt9tOHRr80EIqe+i/Y9UzWQbHdcsp
	 L2YdEr/Q31nRvtIzaSB3fd1pATEdT+sLAdo5jQNP5dcoTr77TFrGRr3fBrJ/2efVv1XfZ
	 vfXw6lb17kH37jZcVUlNaKYUX+Ww9kj0QjGgwkMo7REofbFjbxQsvFbnqsvpKSPVhxiJd
	 AIqmZeholXUFGtPnLXagtVO6di6xxcEDYKLVvPLpXtGvNcj7smdY6zZY5R8qLjhkTULtX
	 /gi7qvBpTmidtXVHUZQ//06nXSdm2oz6RhrenPm3Sq7/s5OXSZ7z8nwXHh79N74u3Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcdX+S52;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC1606A31E;
	Wed, 28 Oct 2026 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcdX+S52
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793146830;
	b=p90rWZEBGX1a8KALpsg2Isrw125FaRGoSLVjsUDo9VzOOD/lAbjCl9YPttxSK6FQt/uU
	 tQfQQGiTPWbXaR+K91XpK5j5ukS5+J8mzfwfWR/HIhiLZlIWgfbIf6+Hu77KSo27thf5y
	 rQ8oil6KWgVuYX3mqS6UlvIyjP2Dkr7Xq+J16Lj6ITf5GHQ0+FVgOotl50CaA9LaLUWuI
	 IuaDtcqY4/umVu1dJzeQq2YhyeRkuJHyNhKReGUxtZYN+suuVo+SLwn3KfJE7/0l1oL5+
	 88Xyn+4qbwXFodKDqtIls1cTgzQXd/pyWwnY5NOncge3rX4l6HfmQ6/IipMVE8VXBHQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793146830;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tJzDohBgQIEeXhbGPUON1R9UnoZ1QEo5Jwi1O8KFilY=;
	b=H07U5ie5XeOwbcnfl0tKSIO5spZ7TvanYfQlAPkEqN64M5a+NjhZWiUAox6y++b1hA5u
	 syN6Qb9gwV8JN2wnfDWKLmK1k0Lzcp1+zQ95vYyejhtFripfxPWD3rrtcg3zWdLt/8ZgW
	 dggvT03ffoDFdIgfmQfnpPdSqFGigRIUfeNwkqBAF1l6QUCrQvI+QNEq24nOaWqWvDp0s
	 COKexgL5MpkXHKfthiIEZZmzdg7AFmoop8BVRzJ0nvcTVFCX8aKhey90ogFsd/O1DToXs
	 nLkCp/AJKNMFhIoc+VK15u4qMmkacS8cWyj5xyuO01+a52jbF+S9GV+FYyq7V+3nyPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC72F1F01828;
	Wed, 28 Oct 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146830;
	bh=tJzDohBgQIEeXhbGPUON1R9UnoZ1QEo5Jwi1O8KFilY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RcdX+S52nBkXSOQNeHrLHNLAgDiwVOnidVXEYRXK1qRvMRfpiGvpaGBZqcy5gJPoA
	 7jHwNHsOxqKqh/XJLAmwUAPN/flfYsZKjoRSe6U3jrvRQZVrPiZFkgEbDQwQCymgE+
	 KudL935YOtu3oJ3m5ku9+Q7gVzZiGzD9shvMILmcFYQhotFzkxU1+flEJuhonz7lcV
	 qCQ3wSoP6lOsgmfGGcrolkUdRHCeB/rXd7i2oB2367ZfC1FUxJeV3sxrsdkTIXQQbJ
	 DXywPUX4KClGYZrDyfypfJmmjXJt/cQ0HLTl0icQ9hTB/oVeXkhhHUG1tuJfCTk842
	 GBrcmqQasqMZw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 35A9D452FD;
	Wed, 28 Oct 2026 00:20:29 +0000 (UTC)
From: Jez Ng via B4 Relay <devnull+jez.sfcompute.com@kernel.org>
Date: Wed, 28 Oct 2026 00:14:46 +0000
Subject: [PATCH 2/2] thermal: intel: hfi: Disable HFI left enabled by a
 previous kernel
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
Message-Id: <20261028-hfi-kexec-v1-2-956234dcfb2b@sfcompute.com>
References: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
In-Reply-To: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793146828; l=3879;
 i=jez@sfcompute.com; s=20261027; h=from:subject:message-id;
 bh=MFHvCGMUfhFOc56f4vLbDg8eYQ8Wf8YlM3SPBL0W/oY=;
 b=FJFpb2EWq1gVcnPUpk8FY5Wsa6tnVG0gXGdAVE6kOPndaZVq8RYjjKa1x91I8PuEVgSph0pUT
 01u9WWPekmHDMwIpgx962TDfY1uKUTpXwh0FafqaZ/4YKmk63b0E5VJ
X-Developer-Key: i=jez@sfcompute.com; a=ed25519;
 pk=e8QxvBomwv96udVoo4EZvgPDtnl1YbPysb3vNdKi8JA=
X-Endpoint-Received: by B4 Relay for jez@sfcompute.com/20261027 with
 auth_id=1337
X-Original-From: Jez Ng <jez@sfcompute.com>
Reply-To: jez@sfcompute.com
Content-Transfer-Encoding: 7bit

From: Jez Ng <jez@sfcompute.com>

Since commit b33f3d2677b8 ("thermal: intel: hfi: Enable HFI only when
required"), the kernel only programs HFI when a thermal netlink client
subscribes to events. Before that, the first CPU of each package to come
online wrote a fresh table address and enabled HFI, which replaced any
setup a previous kernel left behind.

Now, if the previous kernel left HFI enabled, for example across kexec,
nothing touches it. Hardware keeps writing updates into the previous
kernel's table, which is free memory in this kernel and can be allocated
for anything. On dual-socket Sapphire Rapids systems kexec'ing from a 6.1
kernel into 7.0, these writes corrupted the inode hash table and caused
oopses in find_inode_fast().

When the first CPU of a package comes online, check
MSR_IA32_HW_FEEDBACK_CONFIG and disable HFI if it is already enabled. If
a client subscribes later, HFI is re-enabled with this kernel's table as
before.

This narrows the window but cannot close it. Hardware may still write
to the old table until the package's first CPU reaches the thermal
online callback, which runs from a device initcall. On the systems
above that was about 30 seconds after this kernel started, 21 of which
were spent in acpi_init(). In testing there, hardware wrote the table
once right after HFI was enabled and not again over several minutes,
idle or with every CPU busy, but the rate under other loads is
unknown. The complete fix is for the previous kernel to disable HFI on
shutdown, as "thermal: intel: hfi: Disable HFI on shutdown and kexec"
does; this covers previous kernels that do not.

Also update the kernel-doc of intel_hfi_online(), which still described
it as always enabling HFI.

Fixes: b33f3d2677b8 ("thermal: intel: hfi: Enable HFI only when required")
Cc: stable@vger.kernel.org
Reviewed-by: Andrew James <ajames@sfcompute.com>
Reviewed-by: John Ranzie <jranzie@sfcompute.com>
Signed-off-by: Jez Ng <jez@sfcompute.com>
---
 drivers/thermal/intel/intel_hfi.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 8ff094eccbaf..b97f8113930c 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -413,13 +413,14 @@ static bool hfi_disable_if_enabled(void)
 }
 
 /**
- * intel_hfi_online() - Enable HFI on @cpu
- * @cpu:	CPU in which the HFI will be enabled
+ * intel_hfi_online() - Set up HFI on @cpu
+ * @cpu:	CPU that is coming online
  *
- * Enable the HFI to be used in @cpu. The HFI is enabled at the package
- * level. The first CPU in the package to come online does the full HFI
- * initialization. Subsequent CPUs will just link themselves to the HFI
- * instance of their package.
+ * The HFI is enabled at the package level. The first CPU in the package to
+ * come online does the full HFI initialization, which includes disabling HFI
+ * if a previous kernel left it enabled. HFI is enabled only when there are
+ * thermal netlink clients. Subsequent CPUs will just link themselves to the
+ * HFI instance of their package.
  *
  * This function is called before enabling the thermal vector in the local APIC
  * in order to ensure that @cpu has an associated HFI instance when it receives
@@ -462,6 +463,14 @@ void intel_hfi_online(unsigned int cpu)
 	if (hfi_instance->hdr)
 		goto enable;
 
+	/*
+	 * A previous kernel may have left HFI enabled across kexec. Hardware
+	 * would keep writing to that kernel's table, in memory this kernel now
+	 * owns.
+	 */
+	if (hfi_disable_if_enabled())
+		pr_info("HFI left enabled on package %u, disabled\n", pkg_id);
+
 	/*
 	 * Hardware is programmed with the physical address of the first page
 	 * frame of the table. Hence, the allocated memory must be page-aligned.

-- 
2.39.5


