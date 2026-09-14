Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109048A2C2
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399839; cv=none; b=Ml10DXzJdGUXNM2X/7MpzgTZr/IJ5n+58SXjxjkT6tQwYsSMpDZfLKssbRoa2nTGHPaHH6i1viqkNWc9wlkbuyeo9wYOPOnNQl1e8NWId/NI+eH+xbIXohXXVRPMOdX6ygUgKe76/wdMQfX7Vx7lidw+wfkGMhfdrRWttpPk5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399839; c=relaxed/simple;
	bh=wmKzczBDnzf4BhOvez35NeoINSxyaKJg63Quyxzvf0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GirwN7Is4GhA3r8APuwcDP7xfxeqIz2+9LDRiCIgu86i4ZkeNjqvWe1CX+QxwM+Oat8/Y3+CkPmaSmHkWlK3QhlXBCWmSJCZ74BGn/R3RF56AJGTjPgLgRlf3/r2/uXq0hKHmJ6p6q/kT407VUDo5MNepcysLleFTaCpAMOmcs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3F/mKmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3F/mKmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9A71F00898;
	Mon, 14 Sep 2026 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399837;
	bh=rmBbLDOkJo50OevKJJpMG0Vh5TT4PjH2EAc7wHNAIEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3F/mKmuOFbKyY2ldhQ14nUs0F1nafeZH+GmnjnPwysw0WW/NWeIcUu+DFWm15Fu+
	 AO1ZbM9qfYf7zFcEZusF9BeBmiF4Kus1Vs73ZB3YvnwRYJTtKkOVijmihP/BN3tX8S
	 mZBpw5ATg6pj69XkpLXC/TmT4y1+9W9CpqyD0fkBgbOAMhmTJTJmeu+/wCeNPGBaRt
	 o31rRWLeD0X6+SPdpTNXe+qy7yxXdWGtYk+C6wNYyIucyW4mD8dt6vfIDDehYzhDTe
	 fWteHxjYKlbo0aUfGAru+9OQefUSE2HL6NzPZIouHeVgMwyNNZdcq8VEp4lonFdIoe
	 rpzQBeC9Q9MYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] ksmbd: validate response sizes in ipc_validate_msg()
Date: Mon, 14 Sep 2026 11:30:31 -0400
Message-ID: <20260914153033.392874-3-sashal@kernel.org>
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

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit d6a6aa81eac2c9bff66dc6e191179cb69a14426b ]

ipc_validate_msg() computes the expected message size for each
response type by adding (or multiplying) attacker-controlled fields
from the daemon response to a fixed struct size in unsigned int
arithmetic.  Three cases can overflow:

  KSMBD_EVENT_RPC_REQUEST:
      msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
  KSMBD_EVENT_SHARE_CONFIG_REQUEST:
      msg_sz = sizeof(struct ksmbd_share_config_response) +
               resp->payload_sz;
  KSMBD_EVENT_LOGIN_REQUEST_EXT:
      msg_sz = sizeof(struct ksmbd_login_response_ext) +
               resp->ngroups * sizeof(gid_t);

resp->payload_sz is __u32 and resp->ngroups is __s32.  Each addition
can wrap in unsigned int; the multiplication by sizeof(gid_t) mixes
signed and size_t, so a negative ngroups is converted to SIZE_MAX
before the multiply.  A wrapped value of msg_sz that happens to
equal entry->msg_sz bypasses the size check on the next line, and
downstream consumers (smb2pdu.c:6742 memcpy using rpc_resp->payload_sz,
kmemdup in ksmbd_alloc_user using resp_ext->ngroups) then trust the
unverified length.

Use check_add_overflow() on the RPC_REQUEST and SHARE_CONFIG_REQUEST
paths to detect integer overflow without constraining functional
payload size; userspace ksmbd-tools grows NDR responses in 4096-byte
chunks for calls like NetShareEnumAll, so a hard transport cap is
unworkable on the response side.  For LOGIN_REQUEST_EXT, reject
resp->ngroups outside the signed [0, NGROUPS_MAX] range up front and
report the error from ipc_validate_msg() so it fires at the IPC
boundary; with that bound the subsequent multiplication and addition
stay well below UINT_MAX.  The now-redundant ngroups check and
pr_err in ksmbd_alloc_user() are removed.

This is the response-side analogue of aab98e2dbd64 ("ksmbd: fix
integer overflows on 32 bit systems"), which hardened the request
side.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Fixes: a77e0e02af1c ("ksmbd: add support for supplementary groups")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

[ Stable dependency adaptation for f25e93768fcc5d8287e50b1ec52a42e4c276df34:
  Retain the RPC response-size overflow check in ipc_validate_msg().
  The previous dependency, 2d1f4c041770, already supplied the overflow
  header and the share-response checked addition required by the target.

  Drop both supplementary-group hunks: this stable tree has neither
  extended-login IPC messages nor supplementary-group fields in ksmbd_user.
  Keep user_config.c unchanged and do not introduce extended-login support
  or any new functions. The target applies cleanly by three-way application
  with the existing share-config preparation and this reduced dependency. ]

[ sashal: Reduced backport -- upstream d6a6aa81eac2c touches 2 file(s), this
  backport carries 1. Not backported here:
  fs/smb/server/mgmt/user_config.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config responses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_ipc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 5bf29431b4e48..dbc3c2bd241f1 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -481,7 +481,9 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 	{
 		struct ksmbd_rpc_command *resp = entry->response;
 
-		msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
+		if (check_add_overflow(sizeof(struct ksmbd_rpc_command),
+				       resp->payload_sz, &msg_sz))
+			return -EINVAL;
 		break;
 	}
 	case KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST:
-- 
2.53.0

