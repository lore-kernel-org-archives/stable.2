Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D53EFD3D;
	Thu, 15 Oct 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083638; cv=none; b=LovssokLUzFuac+aPIJW97derA2O6vKxUa5XqkcrHQj/ZjAHg0Fr/mXpLGR4I3a5TZa4HjIHQ5vEOFYotVBGrCvrZHKn/iZBpPpym8h/HMvl5/uPIsE2gzBvUEM9CURvdsLs9niXDl02NI/TQfu3pAMZFNQcYHmrCyD4FajzKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083638; c=relaxed/simple;
	bh=Hsw+CFLyIuL583JEOvkXylZyRV3D5lJ5KrLCuovCJoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVKqXy0sYz9bC8bVaHM0vDNNbm3BI+oEosYWGfgzTVf+DzSgMwI1ECR3H8jkUQltH+/Csm17Y+yGtsD0HIBr9i9ActDrKquqxIrp06y22BCQeZw+aMiDEqGO2Ao2az9NrhLlPEpzy/aATAgKxpqrhk9NAMpnCbv01neoUkwwdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOsJXRPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOsJXRPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75FC1F000C4;
	Thu, 15 Oct 2026 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792083624;
	bh=DhOSN6m6izu8EYCbEnbOEHxhb6pEEDwTP7cVWugKwME=;
	h=From:To:Cc:Subject:Date;
	b=EOsJXRPAO/u2rGLjD1ohGm2fBaHGrAgpjw8M0MWtq+SNYrndo2EWGsO+Ms3SxcfRR
	 OQlTGr8GJN3DanafJNkggS9XKt1jQQZCbYpN05/jgIfwj3DQKW5C4JGp6s+86AJ1iv
	 M7GJ0IF7xF4wKIVWayKV9Q9OoT5ic+Y9p7xbrhviqJV7CXuB+Qjmf44zJd/Sz2ppWp
	 rK6dLOs0bTMQMwxQF6Uy1k6QN5IPuc1IcmX7sOqCXTzYWkPPXHOrEjxKfn16hNQmze
	 3gsTkAh09VFjMcN12KddPJdGaiN8hpudzZFtN4GYw1SdW/5Y3JJYjI1dpjzEKRAOV+
	 Ax6NYq8LMCrDQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Brad Spengler <spender@grsecurity.net>,
	PaX Team <pageexec@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-hardening@vger.kernel.org,
	Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next net] netdev: Hide the netdev_priv() origin from GCC in netdev_from_priv()
Date: Thu, 15 Oct 2026 10:00:03 -0700
Message-ID: <20261015165959.i.798-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3704; i=kees@kernel.org; h=from:subject:message-id; bh=Hsw+CFLyIuL583JEOvkXylZyRV3D5lJ5KrLCuovCJoM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkX2SZ/cP779JXnzmeZKpY59p/z2uKzDRYdrGt7/8Lu9 sfZXKVnO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZSv4qR4fyewg0PmOce+OLH s2d/nM7j7//atj2U36t1LVfdren737sM/zRz9/GncGb7pq3cezqwMCM/88sGJ1ERXsf+5TmmHS+ X8AAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15.1 and later can compute an object size of 0 for a pointer that
container_of() derives from a pointer into a __counted_by flexible array
member[1]; Clang gets it right. netdev_from_priv() does this with struct
net_device's "priv" array, so when GCC can see that its argument came
from netdev_priv(), FORTIFY_SOURCE sees a zero-sized net_device. Since
commit 9027497a25e3c ("team: use netdev_from_priv()"), adding a port of
another type to a team device can then fail the memcpy() to
"dev->broadcast" in team_setup_by_port(), which GCC sees through after
inlining team_port_add() into team_add_slave():

  memcpy: detected buffer overflow: 4 byte write of buffer size 0
  ...
  kernel BUG at lib/string_helpers.c:1044!
  ...
  Call Trace:
   <TASK>
   team_add_slave.cold+0x88/0x201
   do_set_master+0x11c/0x180
   do_setlink.isra.0+0x3a4/0x1410

Whether GCC inlines that far depends on the architecture and the
configuration. It does on ppc64le, where this was reported, and on
x86_64 with defconfig plus hardening.config or with Debian's
configuration, but not with allmodconfig.

Hide where "priv" came from with OPTIMIZER_HIDE_VAR(), so GCC sees a
net_device of unknown size whose members have their declared sizes. (An
"unknown" size is considered uncheckable by FORTIFY.)  FORTIFY still
bounds writes to members; only the whole-object size becomes unknown,
as it already is for any net_device pointer GCC can't trace to its
allocation. In an extracted PoC, the __builtin_dynamic_object_size()
of "dev->broadcast" for the two types FORTIFY sees, before and after
this patch:

                                   GCC 16.2.0      Clang 22 and 24
                                 before   after
  plain pointer, whole object   unknown  unknown        44
  container_of(), whole object        0  unknown        44
  container_of(), member              0       32        32

In addition to getting the bogus "0" fixed in GCC, I'll be following up
to solve the whole-object visiblity disparity as well.

Build tested with GCC 16.2.0: ARCH=x86_64 defconfig with hardening.config,
CONFIG_NET_TEAM=y, and CONFIG_NET_IPGRE=y; ARCH=arm64 defconfig with
hardening.config, CONFIG_NET_TEAM=y, CONFIG_PPP=y, and CONFIG_NET_AIROHA=m;
and drivers/net/team/, drivers/net/ppp/, and drivers/net/ethernet/airoha/
in ARCH=x86_64 allmodconfig. Under QEMU, the x86_64 kernel hits the BUG
above when adding the GRE fallback device "gre0" as a port of a new team
device without this patch, and adds it with the patch.

Reported-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Closes: https://lore.kernel.org/all/3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com/
Fixes: 9027497a25e3c ("team: use netdev_from_priv()")
Cc: stable@vger.kernel.org
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127875 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/netdevice.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e..e1dedecd796a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2838,6 +2838,13 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 static inline struct net_device *netdev_from_priv(const void *priv)
 {
+	/*
+	 * When GCC can see that @priv came from netdev_priv(), it can
+	 * compute an object size of 0 for the net_device and its members,
+	 * which makes FORTIFY_SOURCE fail valid accesses through the result:
+	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127875
+	 */
+	OPTIMIZER_HIDE_VAR(priv);
 	return container_of(priv, struct net_device, priv);
 }
 
-- 
2.55.0

