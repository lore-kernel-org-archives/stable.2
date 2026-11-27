Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795762085;
	b=puXr58865Wi1mc53+uChCkT+Vn+s+7zxwHNiuhGSjKjuKRwwMZeVJEEXWyI5hVPBdatV
	 kDydu/Np84CE+EEnU+IiNreq7qNN+HzHu2yaWpZjYGR0EvZj3tLrquRWKYKt8cQAquBmS
	 z9Lzqq8CAUF5Qa5zDtZU9s78b2y9ew/03vudQfYMASIxZQJyT9MSOXS+bEckGp04lle8z
	 BDty8ksWj799nodvSsAx72KiiN26ovAc0P4ot3XKt6DtyKpVaMOOtsZXzP4aNZwnSl0cM
	 SoY+19xJNkfQ0gnRJqKcyvcI8bgmmb3XplMFDjG0yNEvjSTgqTYXbIO3DIaVp1yO4rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762085;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=mnRsxiP5CDXvJyBOhMK61M5i51SmpFcieZV2SE2HJd8=;
	b=NfLF06u1bYn8KIQJyDMWZZbblSi2+zCB/y+I6m0ieGyx1G0kbKJ63fUWoky6ClcXKvqY
	 hBtm/5asyvw2vVj3KfiO7R48oDjQ/29187500Mj29maJBZmWRn4ukPEmNTrFGJxGLAcH2
	 SnFBGk1ySbtBH+NsZkIOLdUJu2LS4Y6HwnExr8FnIoQW1FCYcV+UxwaIxJ78u/MeZZ6Fa
	 QwS+W80JOBiYCcjke1MTG5a80Vj5KxtoBwqVuSSnJ+R6Ec90UM46rEju0YtEGrbJrkKJy
	 sY6fj/SU58QN/OYwBef9+DcYKYRgcObzF95LGJusmUjVZGRMvuXa7pyRrMsd2NBGcNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHkYorXc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF9606A31C;
	Fri, 27 Nov 2026 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHkYorXc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795762085;
	b=MUAu9nOJz156un4yaQ2/E7rcrUplGOhsndUSDxRXxxHJnl0S0Xaez4iuw7cEcSiUSpyw
	 HH+3OhUKiYI5fBCRYmjYUZsWNO01/7SMjD/NISIcEUGL7ZbM8Lc6CCXDJKNEmfTLGiZji
	 vMuAX0TWoNF04apAItg5N1Ba3WQbJHoWMhc2s9YC9vnrybtzL+dogRlw2898m0hB8NXLe
	 JjFBQGcA6QURAzdWVh0e90CrPcY+/gZ8QXkaMejYMMTkMGptifBUmEY6kGK5VC5F5HLUP
	 cd5M5txmm+L2LJnji+2R06jxv38ODsDENbIU75v03oDggBJYHfKnDdUX3oaPfJCPDAg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795762085;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=mnRsxiP5CDXvJyBOhMK61M5i51SmpFcieZV2SE2HJd8=;
	b=nxqxp2h6PkwSSGR6b+J6OHdbr9F63OAIaQxfBqTDzA+JR7tIfsnkF7fT3y7AKF/24Hgg
	 oAepvDLyBGXNT2jy0aQf4itei1ooN97BGIhKbgmJ5mW90mJfAn7MTD1dTujOblNGyNILJ
	 CxIZVeaAQywwpwMjPo4bo5JsV1gmLxzF5BeU8fxFZQiCMoC0qN0A1Zwc0xKYQzmqIiFU7
	 i93TpmOWJKueyxWM78d5BIy04O+zWzko8ZjtBFILBkBKVLNc92RubQYRVv5Q7c/G8b2Sc
	 oxDzLgZu7KtDocCnrK2HD9S2sqXtgOTjcLtWEqPzZLpBtQleGl2GSXWua4a9ZaDme4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 827A21F0089F;
	Fri, 27 Nov 2026 06:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762085;
	bh=mnRsxiP5CDXvJyBOhMK61M5i51SmpFcieZV2SE2HJd8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=IHkYorXc7nz0LBJdg4GIznzuGYcFTJBN29Mn3zR+c6Vc5EPcnFseXAnbeCeVd3uBj
	 aIN8ggjKQ6MWwpbL25udG2HTEMo1yVO9fZAhAf7K3QpnZdyRI04nBM8aHf658+hBau
	 zqr1oMMdqKf+HAlNe4V/bOoVoKbHmN0PAU4vPBxxT3QQBwSPIYhs8htKKo7HOkYFAv
	 eKjIRXhK5dXYc5ZLgYWW1dMxvjcHmt3i1osUIoWd6QZJOnvnJHenTKFspI+ZhjdVEg
	 w9G1oReVqNw2/+8FCPv1vX6WwYXJI0kdtd3M0acfL5W4Y7KxDqRiHp4fBUh/4nXFjJ
	 7xs+fRBDkFbAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AB83D4B5F5;
	Fri, 27 Nov 2026 06:47:48 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 06:37:47 +0000
Subject: [PATCH 6.6.y] rds: tcp: unregister sysctl before tearing down
 listen socket
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
Message-Id: <20261127-so5-rds-66-v1-1-1abb4e9ce92b@certik.com>
X-B4-Tracking: v=1; b=H4sIADolCWsC/0WNSw7CMAxEr1J5jUsTwKhcBXWRj6FBKEFxqUBV7
 04CC5bzNPNmAeEcWODULJB5DhJSLEFtGnCjiVfG4EsG3WlSSh9R0gGzFyTC3rne7vZkvO+gDB6
 ZL+H1lZ2BWmrfMPywPO2N3VRFtWiNMNpsohsrEo5+SumOlW//B7CuH844CQqgAAAA
X-Change-ID: 20261127-so5-rds-66-9cc9b346add0
To: stable@vger.kernel.org
Cc: Cen Zhang <blbllhy@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795761466; l=2888;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=eX75dksd+0Eq/c6Duq5vPiGvUbIGB0rYF3qmdTVxvX8=;
 b=BLV0tpHTjpwxzWlawloS8nPZzByn15w+p/yUa9RcglQDfGguxqgH0yPyz2x/FuI4GXYh4kywc
 i71OQrCJHG1DgqyX9MeUJZbA9yS1hu1Jxn6eIGtXSHNxfo6V+R8TIqX
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>

commit 167e54c703ccd4fa028feb568b0d1002020cff86 upstream.

rds_tcp_exit_net() frees the per-netns RDS TCP listen socket via
rds_tcp_kill_sock() before unregistering the per-netns sysctl table.  Since
rds_tcp_skbuf_handler() derives the netns from
rtn->rds_tcp_listen_sock->sk, a concurrent sysctl write can race with
netns teardown and dereference the freed socket/sk.

KASAN reports the race as:

  BUG: KASAN: slab-use-after-free in rds_tcp_skbuf_handler+0x2aa/0x2e0
  rds_tcp_skbuf_handler              net/rds/tcp.c:721
  proc_sys_call_handler              fs/proc/proc_sysctl.c
  vfs_write                          fs/read_write.c
  __x64_sys_pwrite64                 fs/read_write.c

Fix this by unregistering the RDS TCP sysctl table before calling
rds_tcp_kill_sock().  unregister_net_sysctl_table() prevents new sysctl
handlers from starting and waits for in-flight handlers to finish, so
the listen socket can then be released safely. The fix was tested
against the linked reproducer.

Fixes: 7f5611cbc487 ("rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")
Reported-by: AutonomousCodeSecurity@microsoft.com
Link: https://lore.kernel.org/all/20260719203718.9680-1-blbllhy@gmail.com
Reviewed-by: Allison Henderson <achender@kernel.org>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Link: https://patch.msgid.link/20260719210357.10179-1-blbllhy@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
6.12.y and newer already have this fix.

Tested on v6.6.163:
- x86_64 allmodconfig W=1 build of net/rds/tcp.o, base vs patched, no
  new warnings
- under QEMU/KVM, base and patched: loaded rds_tcp, read both TCP buffer
  sysctls in a new network namespace and tore the namespace down with
  no warnings in dmesg. I didn't run a race test.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

net/rds/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
 net/rds/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 80d0e4c5b6aa..76cdea73a906 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -711,13 +711,13 @@ static void __net_exit rds_tcp_exit_net(struct net *net)
 {
 	struct rds_tcp_net *rtn = net_generic(net, rds_tcp_netid);
 
-	rds_tcp_kill_sock(net);
-
 	if (rtn->rds_tcp_sysctl)
 		unregister_net_sysctl_table(rtn->rds_tcp_sysctl);
 
 	if (net != &init_net)
 		kfree(rtn->ctl_table);
+
+	rds_tcp_kill_sock(net);
 }
 
 static struct pernet_operations rds_tcp_net_ops = {

---
base-commit: e2bb30811e063ce0db964484357973b855b06572
change-id: 20261127-so5-rds-66-9cc9b346add0

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


