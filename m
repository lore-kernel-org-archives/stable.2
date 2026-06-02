Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B53EA953;
	Tue,  2 Jun 2026 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402531; cv=none; b=lZA8RUERhi9LtvSjL6BHRMNt02Ne1NDctHsKZx0fwT2e6K/XikfCXIw1Q5jwlY2wXcv+qE/meMKvYQTjx7T9B3I+Tg+nmmKGsObzf6UeE79LzxNkIH4UrDMRjFQUaJ04jAuLpiwuBnzrTr3mp2p5le1DGByempI+xCy7NvTHups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402531; c=relaxed/simple;
	bh=Pb5uIQF6xrHvLFdMOfZGgfzn3MnhwBuxo1h2x2WO0y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOXyCUBH+UgaPks1JhsvOvSwcV8PbhOy0YD1eVLUGJNxJLK2v16eaW/Ppyh+SQyi/ARQOHPPiMXoUT0Ex3eeqoUPJpxs/3ofzv6dxEOfdy8zHEE2KgEU9NZUAquFPPlEMO3XWbcbCF9jLkzMlVB61UtimEddQIT2lC35w3gjx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gv4VxqSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gv4VxqSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74661F00893;
	Tue,  2 Jun 2026 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402530;
	bh=ZhxoqN3JeRUhEKx5rHCeGzKqFMlKcZtGh4H2OOvDNq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gv4VxqSF0z5eTwH8heCZvsFWR4toI/N68Q8EiNCHkJHth/ekm47NbiR8idX/hMR0q
	 K2+m/cd3T2gDYcfmcX39D5mUCBx3rfZYBn7mb4YmdMo/EqE7iSfr/ZmvSyHGtwoT2Q
	 RKuwl1obPRnkN89v3U8tM7BP1TIzU3R9uRWYa3bpQRlAnVDY4yF+0Zt5+/JkUnr/xC
	 ErLFTP9UGKk4WNKVur7ZUcWrKqXgON6ALPjdTgSqNvktN7Vmddr3Ee8ekjwhYsXDDx
	 fIOSFt5pjBqZGuYHWarAZisf2GqI8MLGDL9xp7lMYHS20DhNd2JIcorHFymIcPFsq1
	 sOTYPTyX3EbLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:17 +1000
Subject: [PATCH net v2 10/11] mptcp: fix uninit-value in
 mptcp_established_options
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-10-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4656; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/aohqf5DfCAEEto2DIC4coPvV+C/adCq+3P2bJc0Tmw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsks6mN88BwgXEZDNHutPT6ZitmrbrJ6qIorU
 6kxjscuNV2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c7+pEADtX+AYElWYrT7/DTddd3J6oDx/v8llXnP05v0EBWKqXsJor7n+9FTmm7g+AvjEUFljnKh
 Wm6fX0UkzBJDmsvV5HRqbHGAn2dXyiWBGZvcdfo6n212jnvTlwwI8M++15gp2H1NmBrlF6aMWcc
 cOHpDWrvjRn4saCskJtq12rT2UQ0p4wNi35Bpp7AkWA740X9bbsuJa2+PhWotCDAlV0Ti/2sCk6
 ffcH56d8A4n93no2+bO8C8TMbaXPfXmfT/sbMxsPm9+/p25I8B3Pq69sH20GtW5FgK+/aHs7Cdu
 AuSv0kC7DOIvlPqdbiBYFvPxRLNchkYu0QVsrDTHk80VtpDYpag2bFe4PRVLU5FoEaR84kHhevF
 BzPoBz1gjsmVX0Sr3uFQB/k7kouWxD44Zi2YqcjW5c91jPpKgmD9PQlCcnDuOy5IoyRRkVpO5Ub
 ruvdhnWzE5c2xi9n7RIZl5Lw+J68OtGWfWrQk7HielxwsH1aS6EofIoD/L8etOu7Q8j5gps3FsD
 X7pfLNLrdne0xPzfouoNsQZVB5z31jDjF9X/cDtgy5xAU/iYD56anjxjWlM1ijO7EXxIXdpxB4k
 vXvx+9eCtwlbk1fCZfCCS/v7yQZsXQmYsBfMhOV++EBCQ4NXBTq+l5Mp9/GLntY65b9c855NHMN
 EZWiG6c+G8vetsw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

syzbot reported the following uninit splat:

  BUG: KMSAN: uninit-value in mptcp_write_data_fin net/mptcp/options.c:542 [inline]
  BUG: KMSAN: uninit-value in mptcp_established_options_dss net/mptcp/options.c:590 [inline]
  BUG: KMSAN: uninit-value in mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
   mptcp_write_data_fin net/mptcp/options.c:542 [inline]
   mptcp_established_options_dss net/mptcp/options.c:590 [inline]
   mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
   tcp_established_options+0x312/0xcc0 net/ipv4/tcp_output.c:1192
   __tcp_transmit_skb+0x5dc/0x5fe0 net/ipv4/tcp_output.c:1575
   __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
   tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
   mptcp_subflow_shutdown+0x164/0x690 net/mptcp/protocol.c:3137
   mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
   __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
   __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
   mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
   inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
   __sock_release net/socket.c:722 [inline]
   sock_close+0xd6/0x2f0 net/socket.c:1514
   __fput+0x60e/0x1010 fs/file_table.c:510
   ____fput+0x25/0x30 fs/file_table.c:538
   task_work_run+0x208/0x2b0 kernel/task_work.c:233
   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
   __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
   exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
   __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
   syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
   syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
   __do_fast_syscall_32+0x2c7/0x460 arch/x86/entry/syscall_32.c:310
   do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
   do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
   entry_SYSENTER_compat_after_hwframe+0x84/0x8e

  Local variable opts created at:
   __tcp_transmit_skb+0x4d/0x5fe0 net/ipv4/tcp_output.c:1536
   __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499

The output path currently omits initializing the mptcp extension
`use_map` flag in a few corner cases.

Address the issue always zeroing all the extensions flags before
eventually initializing the individual bits. To that extent, introduce
and use a struct_group to avoid multiple bitwise operations.

Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
Cc: stable@vger.kernel.org
Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/mptcp.h | 7 +++++--
 net/mptcp/options.c | 6 +++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f7263fe2a2e4..ee70f597a4de 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -27,7 +27,9 @@ struct mptcp_ext {
 	u32		subflow_seq;
 	u16		data_len;
 	__sum16		csum;
-	u8		use_map:1,
+
+	struct_group(flags,
+		u8	use_map:1,
 			dsn64:1,
 			data_fin:1,
 			use_ack:1,
@@ -35,9 +37,10 @@ struct mptcp_ext {
 			mpc_map:1,
 			frozen:1,
 			reset_transient:1;
-	u8		reset_reason:4,
+		u8	reset_reason:4,
 			csum_reqd:1,
 			infinite_map:1;
+	); /* end of flags group */
 };
 
 #define MPTCPOPT_HMAC_LEN	20
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 51ca334678b4..f9f587203c35 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -572,6 +572,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	unsigned int ack_size;
 	bool ret = false;
 
+	/* Zero `use_ack` and `use_map` flags with one shot. */
+	BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_ext, flags),
+				 sizeof(u16)));
+	*(u16 *)&opts->ext_copy.flags = 0;
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
@@ -595,7 +600,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	/* passive sockets msk will set the 'can_ack' after accept(), even
 	 * if the first subflow may have the already the remote key handy
 	 */
-	opts->ext_copy.use_ack = 0;
 	if (!READ_ONCE(msk->can_ack)) {
 		*size = ALIGN(dss_size, 4);
 		return ret;

-- 
2.53.0

