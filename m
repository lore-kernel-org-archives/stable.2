Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECD38A728
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411437; cv=none; b=NTekAkjSqjav/whAOi4PiNyGbUORUeQy4aIRG/jcYE8FCoBBZB73F8T0LSIyAK8s49NfSb2CHfn33kn+Yxe8Gd/KPPAimhFgopWwgvMYh/lqgjXqXOIGvRiQihPT6HqRcOLSg4XCzmqjD6RTIm5tTXvUm6xzRPl3FkyYdXFam6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411437; c=relaxed/simple;
	bh=+GgJLVrqnFd+d1LIZsDuHRL4NRz0y+evr7YMa+6ZY8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVW9oUW6jmsgsvhacieeyUem96bFiqSO6zRMO5x3l8JmWxUTqfoEEWkt0yBplf1x3Vrcdm93NyEz+wZ2m4bFM3pmXzeOczUVlTJkyKtr6kCINA/YQLp8pEKwH3Qxghta8PCcf2vhKMxjCbXQlovKy2aQkPWlGBFyHSssRhMbx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxe/4XIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxe/4XIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB45D1F0089B;
	Mon, 14 Sep 2026 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789411434;
	bh=+vVZs8WoqRjRnmYgcKnB4nnxB6TwferI6z4ebtZDfQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxe/4XItu473/t6mHDBjpz1B2oLgIR4xzPngJINK9chn4ek5EPKSlml1B+Sny6pRz
	 9RNx27d1Imwnv6o/lzBCXxPk21zf4miAVZb/eoA5VW7t1QLp4o9G6+n1WAz+78oLoK
	 lEiCd20ln6ihuoi8DAsj9iq7YkLiSlHNuAYxShbZG9ic/Po46u3JlbKjzMQUMrz4Wt
	 3TvI84roKNykbKCJsqk9AJuGI+AlWEj+R/2DDCIrtwGihrkLv/M8Nrxknlvc78HR+m
	 TPk2Iu/Ri/8DKfwhHUEHIhEBgrp1X3qhW/Vx6a8A+Ea5WMxLmBFr2r0Y+pMIbilFS+
	 WdBfwPxHbGA2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] ksmbd: validate response sizes in ipc_validate_msg()
Date: Mon, 14 Sep 2026 14:43:48 -0400
Message-ID: <20260914184350.571525-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914184350.571525-1-sashal@kernel.org>
References: <2026091413-gills-macarena-de56@gregkh>
 <20260914184350.571525-1-sashal@kernel.org>
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
 fs/ksmbd/transport_ipc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index 272f8f0b3a40a..12fa21bf84918 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -469,7 +469,9 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
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

