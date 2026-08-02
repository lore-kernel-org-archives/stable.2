Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA014369985
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785675703; cv=none; b=X65a1hnpBe+IV9vEq5cAxAVu069PyDbRybNlEJVINuLS9NsoHr/5vtjWrfDyvUTjJeredxk/rDTJcXBQlDDsa5SczKK47yv5Mx+MGxRSYNpNAwjVTsXDf+JjOwXd7ES21YoI+RA00RDvX1NDik45ly2HFPJW1cQN7PSw7xvjZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785675703; c=relaxed/simple;
	bh=D7SDYRd//qEp8Zuv8R8oqY3XIrvPozA6HvQnSnYh2Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yb1Z68ETp4ZwD7reUQa5InRzWDnp0kmv2+mwxJS8DjeYK9++ZnS7wihxOiDn7m6o7DWibiehhk/esIemzETt5lGWH1VU/zeoMQ/od9OnnnBQM9nVQmCyyeIRs/xSttDICKrvelIdjfrMnRk7DQxaPtxPD/2fqbyMNsLiGuqlOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=qqVAXJxG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="qqVAXJxG"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-472326ca506so1753686f8f.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785675700; x=1786280500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTOztzpZ5vklCGPe6uHGZOcBDSWwpb+ZPeyegaSuA3E=;
        b=qqVAXJxGlyHLhhbhKLOQK+rloA94A51QHYcQwXdvJtC6sPywWrGPC0haSdB7QDoJEW
         84+/z3uBwDYkuJJRCmwvWuy0mz0wp8xMzBpR9eLv1sbKFuPZIpMapNjy0yHN60VQp6Xb
         0dDHrDuioGJmFVl9d1j6OOHIdQdyxjuR4wCuC8GWs/NXELt01APovoHIcJkTVAJSHFqi
         havtQLCM6SaiLArZnxt/xheyv6SDpRScTok8L7MCkDy2WfC1qtlBJhsZeAffRBafzHq4
         TrD5IGTfMrxqxHjxsq1uFZqlmQpFil78RT+9SAk4Qg2sfgrCJTE5fxtEBKknmOzPvEPk
         6Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785675700; x=1786280500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTOztzpZ5vklCGPe6uHGZOcBDSWwpb+ZPeyegaSuA3E=;
        b=SujT+DKfSEX0ytaTvm4AqhPM3V69WGVwARcArDwDE85QeZGfGtPncoT3fyrkf8xev7
         iqVfMzECAc+IVGs5G1GIcE7OnoaldWiV8/K+XUmSAPK41kbL6QUouLOKB8EcgkJMfOcC
         HMde6yTAni8gImapvFoRQnofH6ushXnK9gTBZVEYfkmBZ95sJNmfZ85rMq7pagdiA98p
         cPego0nkIzDaohi0ZOUEdU6HD7PQuRvNpRSLB9EpuYiJsd2J3vJGJ2i8iHYwgm/itL6U
         sCYy5cyEXp9Zmw08QI1DH9kgCGxzVEtu/8ZDxhvuEm6gA76ZKjomOzbrMHZRE/VvuxgZ
         3uxw==
X-Forwarded-Encrypted: i=1; AHgh+RpPDznCgY+hyGqdLTNX8iejNoVNubuESATY9OQBlXxfSMyU9JE6hNnKpyPjBjJDzSzvhrvJz8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jtcDum3NCGqnMW7HFFq8Z9lI/oLjrocznszCfLyWUG+LzF9s
	o4CEtVa3UkxtYTEogflPRjZMtJ0hjZH6XO7jz1KaBg/6hj3h1Qq0evwfFgo1IE6Fqbrk
X-Gm-Gg: AR+sD12hqAJGdUvv+kbwZK3f95RyDmKmn84JzR2OmlWslBCPyJnLSmY/Zo5oYUTPEYJ
	XW+rXCVEWPrhfLrfDLKy1tk0tHkzoEbR6N3GKhkmedlR1sPzwWYTfazZkA9qmq4QcTttRdchMcL
	K2DBj4fFivsU1HzKxUCGhRjp4fz1jvuNbO1jpTLcEn1NEaPLahHmagDnoS8AiwSaxDoBksgjud5
	vdz/VlNEKMSwS6h5zSjHnxOivZj/jXTa1gIWCvca/V2o9isUv9W/sNO/7Oz95jVooDfG5PF5JSn
	dEFM1dsdVZRP4QC/J3bmy75ur/ivJvGiUBdr19wKh7XV6C1AnqMrGTz5EaT4gJdV0inenDszOU3
	Ke3ynXFwGromT25lA57rVgnWQe0wqqO2xYGTiqcGtqvkiuO6aZQLOTIlDsdr2ywCtA7KwNPiGov
	t9WQOixFzQg11vj2SeL/PuydsOa7QzHmqrVq+R8YQ+nyTWmRTZkPXUggKltOtTeLJ5mgtLl1jIJ
	Sd6DKcBENRCXfsUNqnMMHvM51lc3wnv2SI4agcd8ep5wVaB4LDG+4tomIx3JBF6wF23pc5zzhnl
	kLgKIw0=
X-Received: by 2002:a05:6000:41ec:b0:474:3b3b:5e5f with SMTP id ffacd0b85a97d-47fd72c4d4dmr14468804f8f.16.1785675699784;
        Sun, 02 Aug 2026 06:01:39 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm25669896f8f.14.2026.08.02.06.01.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 06:01:39 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: xmei5@asu.edu,
	thomas.karlsson@paneda.se,
	herbert@gondor.apana.org.au,
	daniel@iogearbox.net,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] macvlan: require lower-netns admin for shared port settings
Date: Sun,  2 Aug 2026 15:01:37 +0200
Message-ID: <20260802130137.98105-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct macvlan_port is per lower device and is shared by every macvlan
upper on it, including uppers that live in other network namespaces.
Two of its fields are settable over rtnetlink by any upper on the port:
port->bc_cutoff, written by IFLA_MACVLAN_BC_CUTOFF, and
port->bc_queue_len_used, recomputed from IFLA_MACVLAN_BC_QUEUE_LEN.
(port->flags and port->perm_addr are also rtnetlink-settable, but only
in passthru mode, which requires port->count == 0 and so cannot be
reached from a second upper.)

rtnetlink checks CAP_NET_ADMIN against the network namespace the
configured device lives in and nothing else, so once a macvlan has been
moved into a child network namespace, an administrator of that namespace
alone reaches macvlan_changelink(), which applies both attributes
without considering who owns the lower device.

The create path has the same gap. macvlan_common_newlink() resolves a
lower device that is itself a macvlan to the real lower device:

	if (netif_is_macvlan(lowerdev))
		lowerdev = macvlan_dev_real_dev(lowerdev);

That real device may sit in a network namespace that was never
capability-checked. The new upper then joins its macvlan_port and runs
update_port_bc_queue_len() on it, and, when IFLA_MACVLAN_BC_CUTOFF is
present, update_port_bc_cutoff().

port->bc_cutoff is not a local tuning knob. update_port_bc_cutoff()
recomputes port->bc_filter, which macvlan_handle_frame() tests to decide
whether a multicast frame is deferred to the port broadcast work queue
or flooded inline from the RX softirq, and a negative cutoff clears
bc_filter outright. A namespace that administers none of the other
uppers can therefore change how all of them receive multicast.

Reproduced on 6.8 with a dummy lower device and two macvlan uppers, one
left in the initial namespace and one moved into a child user and
network namespace. From the child, both a changelink and a nested
newlink carrying IFLA_MACVLAN_BC_CUTOFF were accepted, and the value
read back on the initial-namespace sibling followed them, changing from
1 to -7 and then to -42.

Require CAP_NET_ADMIN in the lower device network namespace before
applying a shared port setting or creating a macvlan on a flattened
lower device. rtnl_dev_link_net_capable() short-circuits when the lower
device shares the macvlan network namespace, so an ordinary
single-namespace configuration is unaffected, and per-upper settings
such as mode and flags stay available to an administrator of the
macvlan's own namespace. This is the model ipvlan has used since
commit 7cc9f7003a96 ("ipvlan: disallow userns cap_net_admin to change
global mode/flags").

Found by 0sec automated security-research tooling (https://0sec.ai).

The newlink gate is unconditional rather than keyed on a BC attribute
being present, because joining another namespace's macvlan_port is
itself a mutation of shared state; ipvlan gates ipvlan_link_new() the
same way.

IFLA_MACVLAN_BC_QUEUE_LEN is gated here as well as by any magnitude
check, because the two address different things: a magnitude check
bounds how large a value any caller may request, while this bounds who
may write the shared port at all. update_port_bc_queue_len() takes the
maximum across uppers, so a cross-namespace lowering has no security
effect and this over-rejects it; that is accepted in exchange for one
rule covering every writer of the shared struct.

Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
Fixes: 954d1fa1ac93 ("macvlan: Add netlink attribute for broadcast cutoff")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
 - Drop the Reported-by: and Closes: naming Xiang Mei. Xiang confirmed
   this is a real issue but a different bug from the broadcast-backlog
   OOM reported in
   https://lore.kernel.org/r/20260706212556.3199234-1-xmei5@asu.edu ,
   and demonstrated it by reproducing that OOM on a kernel carrying v1.
   The two differ in who the caller is: there the caller administers
   everything it uses, here it does not administer the lower device.
   Thanks to Xiang for separating them. Bounding the backlog is a
   separate fix, and this patch neither replaces nor competes with it.
 - Rewrite the commit message around what this patch alone covers,
   cross-namespace mutation of shared macvlan_port state, with
   IFLA_MACVLAN_BC_CUTOFF and the nested-newlink path as the parts
   nothing else addresses.
 - Add a second Fixes: tag for the commit that introduced
   IFLA_MACVLAN_BC_CUTOFF.
 - Add extack messages on both rejections.
 - Add the cross-namespace bc_cutoff reproduction described above.

The permission check itself is unchanged from v1.

v1: https://lore.kernel.org/netdev/20260726125447.32244-1-doruk@0sec.ai/

 drivers/net/macvlan.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836bb..19c599b676076 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1479,8 +1479,14 @@ int macvlan_common_newlink(struct net_device *dev,
 	/* When creating macvlans or macvtaps on top of other macvlans - use
 	 * the real device as the lowerdev.
 	 */
-	if (netif_is_macvlan(lowerdev))
+	if (netif_is_macvlan(lowerdev)) {
 		lowerdev = macvlan_dev_real_dev(lowerdev);
+		if (!rtnl_dev_link_net_capable(dev, dev_net(lowerdev))) {
+			NL_SET_ERR_MSG(extack,
+				       "Creating a macvlan on a lower device in another network namespace requires CAP_NET_ADMIN in that namespace");
+			return -EPERM;
+		}
+	}
 
 	if (!tb[IFLA_MTU])
 		dev->mtu = lowerdev->mtu;
@@ -1619,6 +1625,14 @@ static int macvlan_changelink(struct net_device *dev,
 	enum macvlan_macaddr_mode macmode;
 	int ret;
 
+	if (data &&
+	    (data[IFLA_MACVLAN_BC_QUEUE_LEN] || data[IFLA_MACVLAN_BC_CUTOFF]) &&
+	    !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev))) {
+		NL_SET_ERR_MSG(extack,
+			       "Changing shared macvlan port settings requires CAP_NET_ADMIN in the lower device network namespace");
+		return -EPERM;
+	}
+
 	/* Validate mode, but don't set yet: setting flags may fail. */
 	if (data && data[IFLA_MACVLAN_MODE]) {
 		set_mode = true;
-- 
2.43.0

