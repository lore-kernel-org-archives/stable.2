Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794425509;
	b=SEf/MJsYjpqZN1AFSL9Az0TWdMMOQX7xm9bk0IK6P2Ru2Yq8tDwRYAIQoIoc01Dx/QxC
	 zagTlIcXV6Z3XIHAoca+ES//mOun0FpCShMPGMBnUZseKjPnFokv+j8d2y70jl6ARaQnL
	 9euT443L1KxpUkLOfMvhmcWGcwSMUHjrmOsYLb+X8F0z5z5im2+TO2qwB/lo3x2QYtm8L
	 tP4qFaZ2tDl+6Tt3/cwWBIcasfSXnMXQksDAIZD6QV9MrufZYr58k3OKq3OYlElj5H4Qr
	 Ch3g8HOZXpXEqo5cqvyRyX0rfGKXkO7odq2FsxqAmujasb6IP0797JGrGxWdi6Jplhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425509;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hPJTSgl4lSpxHtP18SvOW1H3AlqpcYb2ZHd7KDI91sE=;
	b=be8Iwr1n2B4IKaxzSElWU+fYZO7sc5apDxQ0LJwekaljtY1l6NbKSvRMcGPWt1yskE1V
	 tXlrSDd+NXGqRAoMWp4RSHp0seM0kq/e2XVFqBJj7QqKMA8iIeqawjgz5a7G/yEbYnK/n
	 SYLfdpClkl3pnOBBbB4cdlqhHGm/BNpQDu1soVfyAjMzJK80EMuJ0TZgxatNrAx5DmOzg
	 SQFMP2k9IRpgtcfx8OT7mp788Xdm9MOANF9CpB/rgOKrjNIm+aXTLKM/Tpur4PfLimSEQ
	 /s4migTcKGdC7aEtVgoSllhcG6ubujdovSJ4/ZXORH1HWNUt/C5lZD3oIDIPIiXGqEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W+/T+mmy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E68606A32A;
	Wed, 11 Nov 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+/T+mmy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794425508;
	b=OtKQaSucPWMKJ1eFv8bMmhmDb6RH4DVPbvsTOYgYfYAfRQ1shXmDTWQWdQdofApozqIn
	 i2KIrqdeUL5gXdQzhYYA36ZrtndbFo94H9Ojt2PL2iMp2Uw/cgFVzbXQ9TK6cIbXaMi39
	 CLvPnXvQM2iUPaizOi4bDmjhnXaLbsw0Jd/ah1O+C8f4bZBEgLo8hsOhMRHPdScQ/cjS2
	 xBBUe5Sd73ywfTyayYfZPWQgYvm6mkuLvZw6y1/11/E4DQVUkZMieAjkqXHu03D3uhPTB
	 j5oesNg3sedNyPYZ0QHAMUQEf02WBE1J5dYpwa42PnUf1+V+Sb6OWTvrjof5E6gXwAA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794425508;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hPJTSgl4lSpxHtP18SvOW1H3AlqpcYb2ZHd7KDI91sE=;
	b=amGFHJYPv9+dNGPX1i50MNvP9gNKkCU3iDathSb5b0OwmtNKbeFFFuFw15HlGk5/9TWX
	 FLEEu94wvhnYGmz5UU7uru8nKvPlKiSu7zD0QjQupy77d/ALf+SO96iSCxz5tTYZe50a6
	 U06KvPviiVw3Uk6ZmO8MvgUKGmWq8aGF14JtQ0rs3xpVaEbyrmcQjpkU54wyBgMOls9WI
	 6yQ4zHLGUf5ZG4CjbJTd31Xt3esHBSGGGsOsSSswJ/pPmVav4JEqWz4tMVqqFMgsGvKlN
	 eO892yEk1fp4jue+koYxLy9zWleq5HujlOlvNFiwMGHUBz77zg2IIdLdkZ6A8vIaqbg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 663221F00A05;
	Wed, 11 Nov 2026 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425508;
	bh=hPJTSgl4lSpxHtP18SvOW1H3AlqpcYb2ZHd7KDI91sE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=W+/T+mmyD3X0cIpn1rAgTiINN64y3iqC/UvCFO0wOCUSYsSI7G4GU8EaG0Y25KuW9
	 ZHCUBKdAru8o8tIh+JPWiQ6DRmNfBt6OoqdtOplPk67zlcb83fMMJ2B04FrahS0yQy
	 UQ5NMg51hjNM4V7iAxH3w5s2zfqkVXksPEHwiVYDBdJXR8/k03N6pDMf2mUZOfwHL3
	 kssoqQZFZImR92u2yFdn4rfBVhPimt4P/MaLu1slmhUSLF+ns2jX8Z8v72bJl+KHpa
	 AycYA6jPejQ1daE8s/7OUTBpABNYjrz8jOauOkxwV7GkmHPuuP2m+CJlb+brcb1ep2
	 G741PvJ3/oY1g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B17D7490A4;
	Wed, 11 Nov 2026 19:31:47 +0000 (UTC)
From: Darren Worrall via B4 Relay <devnull+darren.worrall.shopify.com@kernel.org>
Date: Wed, 11 Nov 2026 19:31:39 +0000
Subject: [PATCH iwl-net] idpf: select AUXILIARY_BUS to fix link failure
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
Message-Id: <20261111-idpf-auxiliary-bus-v1-1-e76b940fc929@shopify.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSQ6DMAxFr4K8rtUQqeNVKhYZDLhCgcaEUiHu3
 qT9u/enDYQik8C92iDSwsJjyFAfKnC9CR0h+8yglT7XWRmnFk1aeWATP2iToFPqdCV9cf7mIQ+
 nSC2vv9MH8HvAQDM0/0CSfZKby2WpWiOENprg+mKNkTsOR08LvhIlgn3/AmLEkuGiAAAA
X-Change-ID: 20261111-idpf-auxiliary-bus-c0058e27cd9d
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Darren Worrall <darren.worrall@shopify.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450;
 i=darren.worrall@shopify.com; h=from:subject:message-id;
 bh=RbjW4ti8gsuFIX9ZjzwA73lhgVe0TsMd8tFgxZGXUIc=;
 b=owGbwMvMwCX2T4mx4WrYUgPG02pJDFlfDi1K9b6aINvzofyiZEOjge+28g0e39h3vWQV6XC4+
 NLgt9qbjlIWBjEuBlkxRZZJ28v+mU1q+VUe1bULZg4rE8gQBi5OAZjIBwGG/zmqa/U2nFimHeLt
 Fvcmu3CP2V2N1JI3lYLL1FgsLs1e4MzI8P3FuYc1cy/sZZJTuBTKY7a/aP7m5bMtItdqLI/ab+R
 yjwcA
X-Developer-Key: i=darren.worrall@shopify.com; a=openpgp;
 fpr=92B776FE369284FA775A8ABAFE220180D556A530
X-Endpoint-Received: by B4 Relay for darren.worrall@shopify.com/default
 with auth_id=1491
X-Original-From: Darren Worrall <darren.worrall@shopify.com>
Reply-To: darren.worrall@shopify.com
Content-Transfer-Encoding: 7bit

From: Darren Worrall <darren.worrall@shopify.com>

The build can currently fail with

    ld: vmlinux.o: in function `idpf_plug_vport_aux_dev':
    drivers/net/ethernet/intel/idpf/idpf_idc.c:82: undefined reference to `auxiliary_device_init'
    ld: drivers/net/ethernet/intel/idpf/idpf_idc.c:86: undefined reference to `__auxiliary_device_add'
    ld: vmlinux.o: in function `idpf_plug_core_aux_dev':
    drivers/net/ethernet/intel/idpf/idpf_idc.c:223: undefined reference to `auxiliary_device_init'
    ld: drivers/net/ethernet/intel/idpf/idpf_idc.c:227: undefined reference to `__auxiliary_device_add'

if IDPF is enabled but no other driver pulls in AUXILIARY_BUS. We hit
this building a minimal kernel for hosts with IDPF NICs. It can be
reproduced on x86_64 from allnoconfig by enabling PCI, PCI_MSI, NET,
NETDEVICES, ETHERNET, NET_VENDOR_INTEL and IDPF.

Select AUXILIARY_BUS in IDPF, as ICE and I40E already do. The same
link failure was fixed for BNGE in commit d7065436e8a0 ("net: bnge: add
AUXILIARY_BUS to Kconfig dependencies").

Build-tested with that configuration on net-queue (dev-queue,
34a70a40c954) and on mainline (067c5c24cef2): vmlinux fails to link
without this patch and links with it. Boot-tested on bare metal (AMD
EPYC) with a Google Cloud IDPF NIC, using a 6.18.60 kernel carrying the
same change and IDPF built in: idpf probes the NIC and its link comes
up.

Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org # 6.17+
Signed-off-by: Darren Worrall <darren.worrall@shopify.com>
---
The link failure was diagnosed, this patch drafted and the tests above
run with the help of an AI coding assistant. I reviewed the patch and
the test results.
---
 drivers/net/ethernet/intel/idpf/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 586df3a4af..6b59173e0d 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -5,6 +5,7 @@ config IDPF
 	tristate "Intel(R) Infrastructure Data Path Function Support"
 	depends on PCI_MSI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select AUXILIARY_BUS
 	select DIMLIB
 	select LIBIE_CP
 	select LIBETH_XDP

---
base-commit: 34a70a40c954fb8044ecd124840a2c38cd3aa4cc
change-id: 20261111-idpf-auxiliary-bus-c0058e27cd9d

Best regards,
--  
Darren Worrall <darren.worrall@shopify.com>


