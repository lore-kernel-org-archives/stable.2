Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A4428470;
	Mon,  3 Aug 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782554; cv=none; b=tBxN/VqkYVkShj2x7yrU+tN00ILPwc/hRzknAowJrlgTzPRBYJfy2br2dmw0h27iGB+ZZIUPvWeMp74qEZE65WxhVVD5qkbLb+MKvNFRf8t4leToiv0BPEDPPOYWzAl9T0VXa+ilgQaSCYFfJTAsHVvIJ9G5GZAiRxrcJYV56K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782554; c=relaxed/simple;
	bh=xlX+uKdCLedFY25GHlGs6muPxvfYepytqbEwIAgkITo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgJmN6/PKELsFUG8ao7YPG9b/hMtHPUfYOck9Xbz4HJYDKdBV6mBQHOKhABBFntdnle6ehAVyoDb2MpBE8kMwr/ZVGVWRRzjV/yZrHsVXB1wFSHpe+z19uqAcue8SbuBR8Y4/5F/4Nnlvlt2/eaQBFZ3LSk1Qf0tgETUTF9kcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BnF1Z7lj; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=flZ+5Qn6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BnF1Z7lj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="flZ+5Qn6"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDQX50QHMzMlDK;
	Mon, 03 Aug 2026 20:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785782549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HJ9PWG6PG1F+vg9tF3o1IzF7vKpxXc1HPlvIfdel9T0=;
	b=BnF1Z7ljfThDDruDI8CJNQHpdMJTqYjjwyeQjDtsFMgEoLxcEbva3mC8TUkSZtBxxnRkIF
	MTga2f0k1Q8hX3aOatmSDTyS4ivEcskRR1MLNLfT/1aqM02HjCg6Dsz4vkA3KkDwhUmWEB
	L9RrSNM59lpGnIdxs0nbM4KSJwqFX6bDfQ/iYjEzFaxRdmmpep7cugFiX05xCcCoa8PGXU
	4tbGXs51eeVEuiHD0bPsX0nAZOVki56fYmyyXAbW1yLDcF/igHOrc43aX91QUcsYrjLP0O
	w26jcO8RYmSIPHc05dS3GSx42lazGPNkzPee2oMNrhGPgF6YPFuj2AUdLi9dUw==
From: Markus Boehme <markus.boehme@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785782546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HJ9PWG6PG1F+vg9tF3o1IzF7vKpxXc1HPlvIfdel9T0=;
	b=flZ+5Qn6hTi258aHcJ41G7TfaLsx6UJJUauPcgybb0HmU82TsW/rUM+m16UjCwwnxTYyjT
	uwnwPTLPmF3oTjvqh7HxfHMB0pt2VHld0NYoNZB5kZtfS2OE8s8J7Rj2Dbo5JkHkpDW201
	4JzXydAm21w4W9u5fBynmD+ut/d4sfdS2klh46GS+sfJS7inr1LxqoAoIYa9mStVbVLsKZ
	4rODbHABTyOsuSCrfy+R22HHAKTf9LLUzqdHVN1KzU/29OuFFshvuGa7s1OjZn9SwN4DMA
	uEJDnKlKHY9MZkCwp5ArYzzKrNPuzI6rua9OSDS7C8hViCZlVR5HVS/kTrHEjg==
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Boehme <markus.boehme@mailbox.org>,
	Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12] netconsole: avoid OOB reads, msg is not nul-terminated
Date: Mon,  3 Aug 2026 20:41:29 +0200
Message-ID: <20260803184129.24594-2-markus.boehme@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 35c622e1838852ca787
X-MBO-RS-META: kinbz1yjwn8msrh4ayehruaqnrwybo44

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 82aec772fca2223bc5774bd9af486fd95766e578 ]

msg passed to netconsole from the console subsystem is not guaranteed
to be nul-terminated. Before recent
commit 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
the message would be placed in printk_shared_pbufs, a static global
buffer, so KASAN had harder time catching OOB accesses. Now we see:

    printk: console [netcon_ext0] enabled
    BUG: KASAN: slab-out-of-bounds in string+0x1f7/0x240
    Read of size 1 at addr ffff88813b6d4c00 by task pr/netcon_ext0/594

    CPU: 65 UID: 0 PID: 594 Comm: pr/netcon_ext0 Not tainted 6.19.0-11754-g4246fd6547c9
    Call Trace:
     kasan_report+0xe4/0x120
     string+0x1f7/0x240
     vsnprintf+0x655/0xba0
     scnprintf+0xba/0x120
     netconsole_write+0x3fe/0xa10
     nbcon_emit_next_record+0x46e/0x860
     nbcon_kthread_func+0x623/0x750

    Allocated by task 1:
     nbcon_alloc+0x1ea/0x450
     register_console+0x26b/0xe10
     init_netconsole+0xbb0/0xda0

    The buggy address belongs to the object at ffff88813b6d4000
                which belongs to the cache kmalloc-4k of size 4096
    The buggy address is located 0 bytes to the right of
                allocated 3072-byte region [ffff88813b6d4000, ffff88813b6d4c00)

Fixes: c62c0a17f9b7 ("netconsole: Append kernel version to message")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260219195021.2099699-1-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ mb: adjusted context; in 6.12 the affected code lives in
  send_ext_msg_udp() and writes to a static buffer instead of nt->buf ]
Signed-off-by: Markus Boehme <markus.boehme@mailbox.org>
---
 drivers/net/netconsole.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 60375bb814a1..3b76ec3cd49b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1103,7 +1103,8 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK) {
 		/* No fragmentation needed */
 		if (nt->release) {
-			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
+			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%.*s", release,
+				  msg_len, msg);
 			msg_len += release_len;
 		} else {
 			memcpy(buf, msg, msg_len);
-- 
2.55.0

