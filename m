Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE43BBFD0
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399840; cv=none; b=PeAQrpw63/zfg/l9RvD8LrvZFoeNAPa/Tz5wnF5PwumYkMgRaJExor4CFOQDRmi9nZa0V27X0e4Y4R1xJ552ZLfeFaJE6Zcln1keKKPM58meQzY4MInuIHTLsVYq7GmkERGarkx4IL2r3Wc51Ev6ZAy6P3nPXePZVIX92OGtfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399840; c=relaxed/simple;
	bh=PE9stOFA6zV9BS4SU86vPnbOTj7DLVBLfyzMUEBxipU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN+plUQzfa+2vh05OF9Kfa28Pi/fkGmAd7Hmj5e7SZrFDAOV8Igky1ocKJ6ca0CCnzQ4drUS7/4xsSQkFUzdiTU6i3LJbj/r0YPeqz59Ims6HpYFxy4GAkIrnhK991/GkYa0M4J0gz2c8iaLgBAuZiAT4z7ZYxaBoKqbQDZre1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQrtvgeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQrtvgeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FD71F000FF;
	Mon, 14 Sep 2026 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399838;
	bh=ryM02/v6FBl0aQ3XVvq1CdICFv4KEtuILMo9DE3E5WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KQrtvgeZwU+JH8pxRaR2dq5hhkt3FNZ5at8B+NAO56NG5SsPqYoGUhOSrGSdbXYZl
	 iVp9s8ssJ3lNXeUz0drwI2JSFXjjLo9Tldoo9rp29fj3gbQVjNPSbyuapkwYs0ZMRH
	 dz2t8ZpLqzhMRdZbzdAQaTLFNsKzL3+lkPK/tMNDI11X03BAnv85YVCDHQ9FNbBEAP
	 gGQljnQwBZo3bCThVINBgHv1CedCLyfioXPW1ym+AzRC3mdw1Auv5+ZlSU7bGltVw2
	 liOLdQHLw+7zRRhGA8Yxg2g/8YwRtN8jgEva4aXn8+FqVibN8Fb2fDpojip4/GvhXK
	 08+gRbDUyc3FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunseong Kim <yunseong.kim@est.tech>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] ksmbd: validate ipc response length before dereferencing its fields
Date: Mon, 14 Sep 2026 11:30:32 -0400
Message-ID: <20260914153033.392874-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914153033.392874-1-sashal@kernel.org>
References: <2026091412-bottom-cadillac-a0fb@gregkh>
 <20260914153033.392874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yunseong.kim@est.tech>

[ Upstream commit e9b33376bd07bca4175f7bcc2d6034ef250f8181 ]

ipc_validate_msg() computes the expected message size by reading length
fields out of the response buffer supplied by the userspace ksmbd daemon
(payload_sz, session_key_len, ngroups, ...).  Those fields are read before
the buffer is verified to be large enough to contain the struct they belong
to, so a short response makes the read land past the end of the allocation.

handle_response() sizes entry->response purely from the netlink attribute
length (nla_len()) and only guards the leading handle read, so the daemon
can install a response as small as the kmalloc-8 object seen below.  When
ipc_msg_send_request() then calls ipc_validate_msg() for a
KSMBD_EVENT_RPC_REQUEST, the cast to struct ksmbd_rpc_command reads
resp->payload_sz at offset 8 of an 8-byte allocation:

[ 3697.841381] ==================================================================
[ 3697.844099] BUG: KASAN: slab-out-of-bounds in ipc_msg_send_request+0x763/0x800
[ 3697.846604] Read of size 4 at addr ffff888105f95910 by task kworker/4:3/20682
[ 3697.849061]
[ 3697.849801] CPU: 4 UID: 0 PID: 20682 Comm: kworker/4:3 Not tainted 7.2.0-rc3-next-20260717-virtme #117 PREEMPT(lazy)
[ 3697.850077] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[ 3697.850303] Workqueue: ksmbd-io handle_ksmbd_work
[ 3697.850592] Call Trace:
[ 3697.850794]  <TASK>
[ 3697.850952]  __dump_stack+0x21/0x60
[ 3697.851239]  dump_stack_lvl+0xc2/0x100
[ 3697.851528]  print_address_description+0x77/0x200
[ 3697.851816]  ? ipc_msg_send_request+0x763/0x800
[ 3697.852024]  print_report+0x58/0x70
[ 3697.852316]  kasan_report+0x117/0x150
[ 3697.852585]  ? down_write+0x146/0x1f0
[ 3697.852809]  ? ipc_msg_send_request+0x763/0x800
[ 3697.853082]  ipc_msg_send_request+0x763/0x800
[ 3697.853385]  ? __pfx_ipc_msg_send_request+0x10/0x10
[ 3697.853604]  ? kasan_unpoison+0x48/0x70
[ 3697.853936]  ? __pfx___up_read+0x10/0x10
[ 3697.854221]  ksmbd_rpc_ioctl+0x380/0x520
[ 3697.854542]  ? __pfx_ksmbd_rpc_ioctl+0x10/0x10
[ 3697.854757]  ? kasan_unpoison+0x48/0x70
[ 3697.854962]  ? copy_from_kernel_nofault+0x32c/0x4e0
[ 3697.855166]  ? kasan_unpoison+0x48/0x70
[ 3697.855416]  fsctl_pipe_transceive+0x139/0x7a0
[ 3697.855705]  ? __pfx_copy_from_kernel_nofault+0x10/0x10
[ 3697.855937]  ? __pfx_fsctl_pipe_transceive+0x10/0x10
[ 3697.856388]  ? __sanitizer_cov_trace_switch+0x7b/0x140
[ 3697.856620]  smb2_ioctl+0x1141/0x3420
[ 3697.856994]  ? __pfx_smb2_ioctl+0x10/0x10
[ 3697.857182]  ? get_smb2_cmd_val+0xe3/0x1c0
[ 3697.857655]  handle_ksmbd_work+0x9ad/0x15e0
[ 3697.858034]  ? __pfx_handle_ksmbd_work+0x10/0x10
[ 3697.858251]  ? lock_release+0xf7/0x360
[ 3697.858466]  ? process_scheduled_works+0x954/0x1600
[ 3697.858698]  ? process_scheduled_works+0x954/0x1600
[ 3697.858905]  process_scheduled_works+0xc22/0x1600
[ 3697.859368]  ? __pfx_process_scheduled_works+0x10/0x10
[ 3697.859637]  ? __pfx_assign_work+0x10/0x10
[ 3697.859896]  ? lock_is_held_type+0x7b/0x110
[ 3697.860146]  worker_thread+0x975/0xee0
[ 3697.860524]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 3697.860830]  ? __kthread_parkme+0x21e/0x260
[ 3697.861105]  kthread+0x3a6/0x490
[ 3697.861423]  ? __pfx_worker_thread+0x10/0x10
[ 3697.861643]  ? __pfx_kthread+0x10/0x10
[ 3697.861878]  ret_from_fork+0x55a/0xa20
[ 3697.862194]  ? __pfx_ret_from_fork+0x10/0x10
[ 3697.862480]  ? __pfx_kthread+0x10/0x10
[ 3697.862714]  ret_from_fork_asm+0x1a/0x30
[ 3697.862965]  </TASK>
[ 3697.863039]
[ 3697.938882] Allocated by task 20761:
[ 3697.940257]  kasan_save_track+0x3e/0x80
[ 3697.941782]  __kasan_kmalloc+0x72/0x90
[ 3697.943228]  __kvmalloc_node_noprof+0x3e9/0x6a0
[ 3697.944948]  handle_generic_event+0x59b/0x750
[ 3697.946592]  genl_family_rcv_msg_doit+0x3d6/0x560
[ 3697.946977]  genl_rcv_msg+0x67c/0x900
[ 3697.947224]  netlink_rcv_skb+0x286/0x580
[ 3697.947488]  genl_rcv+0x2d/0x80
[ 3697.947706]  netlink_unicast+0x937/0xb70
[ 3697.947993]  netlink_sendmsg+0x977/0xc10
[ 3697.948268]  __sock_sendmsg+0x264/0x2d0
[ 3697.948536]  __sys_sendto+0x4de/0x690
[ 3697.948789]  __x64_sys_sendto+0x173/0x380
[ 3697.949069]  do_syscall_64+0x13d/0x420
[ 3697.949328]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3697.949662]
[ 3697.949779] The buggy address belongs to the object at ffff888105f95908
[ 3697.949779]  which belongs to the cache kmalloc-8 of size 8
[ 3697.950550] The buggy address is located 0 bytes to the right of
[ 3697.950550]  allocated 8-byte region [ffff888105f95908, ffff888105f95910)
[ 3697.951455]
[ 3697.951574] The buggy address belongs to the physical page:
[ 3697.951958] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888105f951b8 pfn:0x105f95
[ 3697.952571] flags: 0x100000000000200(workingset|node=0|zone=2)
[ 3697.952973] page_type: f5(slab)
[ 3697.953198] raw: 0100000000000200 ffff888100042640 ffffea0004063610 ffff888100040588
[ 3697.953707] raw: ffff888105f951b8 00000000001c000e 00000000f5000000 0000000000000000
[ 3697.954240] page dumped because: kasan: bad access detected
[ 3697.954616]
[ 3697.954734] Memory state around the buggy address:
[ 3697.955063]  ffff888105f95800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fa
[ 3697.955534]  ffff888105f95880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 3697.956006] >ffff888105f95900: fc 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 3697.956477]                          ^
[ 3697.956728]  ffff888105f95980: fc fc fc fa fc fc fc fc fc fc fc fc fc fc fc fc
[ 3697.957202]  ffff888105f95a00: fc fc fc fc fc fa fc fc fc fc fc fc fc fc fc fc
[ 3697.957671] ==================================================================

The final "entry->msg_sz != msg_sz" comparison cannot help: the offending
read has already happened by the time it runs.  Every case in the switch
shares this pattern.

Floor entry->msg_sz against the base struct of each event type before
dereferencing any of its length fields.  On failure ipc_msg_send_request()
already frees the response and returns NULL, so callers stay safe.

The malformed message originates from the ksmbd.mountd daemon over genl
netlink rather than a remote SMB client, so triggering it requires a buggy
or compromised daemon; it is still an out-of-bounds read the validator is
meant to prevent.

Fixes: d6a6aa81eac2 ("ksmbd: validate response sizes in ipc_validate_msg()")
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

[ Stable dependency adaptation for f25e93768fcc5d8287e50b1ec52a42e4c276df34:
  Retain the minimum response-header checks for RPC and SPNEGO before
  dereferencing their variable-length fields in ipc_validate_msg().
  The share-config header check is already present from dependency
  2d1f4c041770, so it needs no additional change here.

  Drop the extended-login hunk: this stable tree has neither
  KSMBD_EVENT_LOGIN_REQUEST_EXT nor struct ksmbd_login_response_ext.
  Do not introduce extended-login support or any new functions.
  The target applies cleanly by three-way application to this tree. ]

Stable-dep-of: f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config responses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index dbc3c2bd241f1..9edd598105c4f 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -481,6 +481,9 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 	{
 		struct ksmbd_rpc_command *resp = entry->response;
 
+		if (entry->msg_sz < sizeof(struct ksmbd_rpc_command))
+			return -EINVAL;
+
 		if (check_add_overflow(sizeof(struct ksmbd_rpc_command),
 				       resp->payload_sz, &msg_sz))
 			return -EINVAL;
@@ -490,6 +493,9 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 	{
 		struct ksmbd_spnego_authen_response *resp = entry->response;
 
+		if (entry->msg_sz < sizeof(struct ksmbd_spnego_authen_response))
+			return -EINVAL;
+
 		msg_sz = sizeof(struct ksmbd_spnego_authen_response) +
 				resp->session_key_len + resp->spnego_blob_len;
 		break;
-- 
2.53.0

