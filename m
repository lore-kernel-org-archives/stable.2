Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627959;
	b=gr6ouGGlO5Im+de7wEgAGkVhxogJ0ryamXM6oBFaP5jTC2Smgj+RO2vMY4zv/oiPtU3E
	 QrCaRRYdFaT0AZEUriw0Bl2k1JNfhyE4Qdj4MuVFj9vkmwiG0HjiGo8rCiCM/qbhMWecu
	 omTTXqPK+IQDoinGO2gIh8vwsSp6fB74R05GK4ytf5d6rCfvW+X4OCprNX5LiALLn3QMb
	 GSKLFUSWMwqPRA651Q4Mj/SCUBQy6IAEoyoKMNDdXZmXpP8SY8GSbyVEDs8BGvT9ffjBX
	 DEGp6DXM/y+KmTeJ8lJLcLx/DJLB9Qkx+ZmZ6NFcDOezGGohHBr82mf4l69d7TKEgew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627959;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=j1YQbngVA3Za/KplbaHkGVO+Kv4UjVCs57jX3TWEctg=;
	b=i8Aoxw51jU8hQM/bfcDO+ZiAAFhxS30eSxqrklV+yBXmAJdqRzPfMCkqnxkT4z/XV/iN
	 HGz0kM+RPQc6vOdtuj1TTA+dBORbOLV03XztS3LXy6qSd6OeViVXDIkp32aC/N8LKbDhU
	 bL7Qn8CCTzvkoayIKm7lDV3byEjWtpE1lc2ZCE4Jf+4rs6UZa62X04a/YkBZU9bzDV8RT
	 Yom2VMXnJ/QGSeVtCOb9pVMu2p94CRvx6ziCYhvHUZs4hBec2TpXynz3fVYhepEcWy/2m
	 jXG9pnAdehvvhnIVzo9Q7bw9jw4/ThSkCKjYzyM/NJgUGHxqqSkLjh6U5tNXZkWPnKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL7lIHzh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL7lIHzh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFFA1F000C4;
	Wed, 25 Nov 2026 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627959;
	bh=j1YQbngVA3Za/KplbaHkGVO+Kv4UjVCs57jX3TWEctg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hL7lIHzh1pbN80OnxAXZO6rkaF21CmK4NqxqJ5QWBiaTTCQY9YkwEJTlzOfG8vEvM
	 CxhdQ2sHzHPvTzzqgFLQp5LqSFZmmqvwoJnb7/9myoh+kFn2+n/Lx2xYCmWj8tyOSu
	 GOopCbR/3REPsEtzP2vtovgYs2ZBmKNlT3zy8w+PBGLItPv0OJNBYtADmmmJECGppC
	 nTLJZ3nMXCx5lnxbj/RPzxihu5MaRJ2pWzbuasWxanfZ/Prn1a9eK11NXQOlXIPCrg
	 MgCGBZCbBCaoAHwL2YYhqBRolXixv5qN5FWpIp2iVnQmGEcpvy8wND9avg+xa4tNmX
	 zmt7NWXjmvQUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] kprobes: Reduce preempt disable scope in check_kprobe_access_safe()
Date: Wed, 25 Nov 2026 12:32:33 -0500
Message-ID: <20261125173227.966424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112527-vengeful-handrail-9419@gregkh>
References: <2026112527-vengeful-handrail-9419@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 1703abb4dead917ec7e6d9ccb4c13632a6f0994d ]

Commit a189d0350f387 ("kprobes: disable preempt for module_text_address() and kernel_text_address()")
introduced a preempt_disable() region to protect against concurrent
module unloading. However this region also includes the call to
jump_label_text_reserved() which takes a long time;
up to 400us, iterating over approx 6000 jump tables.

The scope protected by preempt_disable() is largen than necessary.
core_kernel_text() does not need to be protected as it does not interact
with module code at all.
Only the scope from __module_text_address() to try_module_get() needs to
be protected.
By limiting the critical section to __module_text_address() and
try_module_get() the function responsible for the latency spike remains
preemptible.

This works fine even when !CONFIG_MODULES as in that case
try_module_get() will always return true and that block can be optimized
away.

Limit the critical section to __module_text_address() and
try_module_get(). Use guard(preempt)() for easier error handling.

While at it also remove a spurious *probed_mod = NULL in an error
path. On errors the output parameter is never inspected by the caller.
Some error paths were clearing the parameters, some didn't.
Align them for clarity.

Link: https://lore.kernel.org/all/20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: f60f98881b54 ("kprobes: Switch ftrace ops when adding probe with post_handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261124154724.480298-1-sashal@kernel.org>

 kernel/kprobes.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 596d9ed7d6831..5b36cc4bede0e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -39,6 +39,7 @@
 #include <linux/static_call.h>
 #include <linux/perf_event.h>
 #include <linux/execmem.h>
+#include <linux/cleanup.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -1581,16 +1582,25 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (ret)
 		return ret;
 	jump_label_lock();
-	preempt_disable();
 
 	/* Ensure the address is in a text area, and find a module if exists. */
 	*probed_mod = NULL;
 	if (!core_kernel_text((unsigned long) p->addr)) {
+		guard(preempt)();
 		*probed_mod = __module_text_address((unsigned long) p->addr);
 		if (!(*probed_mod)) {
 			ret = -EINVAL;
 			goto out;
 		}
+
+		/*
+		 * We must hold a refcount of the probed module while updating
+		 * its code to prohibit unexpected unloading.
+		 */
+		if (unlikely(!try_module_get(*probed_mod))) {
+			ret = -ENOENT;
+			goto out;
+		}
 	}
 	/* Ensure it is not in reserved area. */
 	if (in_gate_area_no_mm((unsigned long) p->addr) ||
@@ -1599,21 +1609,13 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr) ||
 	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
+		module_put(*probed_mod);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	/* Get module refcount and reject __init functions for loaded modules. */
 	if (IS_ENABLED(CONFIG_MODULES) && *probed_mod) {
-		/*
-		 * We must hold a refcount of the probed module while updating
-		 * its code to prohibit unexpected unloading.
-		 */
-		if (unlikely(!try_module_get(*probed_mod))) {
-			ret = -ENOENT;
-			goto out;
-		}
-
 		/*
 		 * If the module freed '.init.text', we couldn't insert
 		 * kprobes in there.
@@ -1621,13 +1623,11 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		if (within_module_init((unsigned long)p->addr, *probed_mod) &&
 		    !module_is_coming(*probed_mod)) {
 			module_put(*probed_mod);
-			*probed_mod = NULL;
 			ret = -ENOENT;
 		}
 	}
 
 out:
-	preempt_enable();
 	jump_label_unlock();
 
 	return ret;
-- 
2.53.0

