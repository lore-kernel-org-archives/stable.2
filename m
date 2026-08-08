Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA13246E8
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209277; cv=none; b=qYsy7yr43i1NDuORoyOUs23ylDMieeakK2N6DdOxVYXJm/i2qhzgzdpENTaIaf2y0GcqkXkI/AwQMUQXSWBvb+Vsc6y2KOUf5DqvvXyge6CZFoMQnQ9p35nAwTzfLiDYiBD582X1gbgTI7C4LYvZL/u+66fe28HgGb5dfjbF2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209277; c=relaxed/simple;
	bh=i9yN890UOojuHnO0szmO7gkOd5//00uh49X/k/tl7+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TP+/6/s4jCmbp+u8pDexw+KskssDaop11t0F4lh5s1EySIQ3O2kYycgHZXzq2KMY1Et1T+7wMPOROKPFgH/1X9EtfDhpaoidcTY9iCfMNU61lklx5myXp6bf+3kb3IwaanFwxeuw0NsRZbaaIhjU8D4zDH4HrmJkcwsteB+4fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmacfWer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmacfWer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CD81F00A3E;
	Sat,  8 Aug 2026 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786209275;
	bh=aE55SIi0AnufoB3SLtehpEdLL27ZwNgfJprrLMoSt0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmacfWero8FPTRHprj4dvYBW33mO9B6pkuC0Tk2MqR/Rlny1zTb316ZZNlEuPGf8E
	 krGLGu1cybcETgdLkBI5BlP+8T8fLKjbS1Fd56HGau4csdZjLdSjjUORp15ZUYdOs+
	 KP2Hvhn4t8sJxSgyyv/+lmCoIutsXOLLnRC13IieD0JfemdP5pdzKVPkBg4XJdme/P
	 4js5HzogNGAW1vhVsZCCqtHWF8+Baruourwjh5hFR0SAfsF7GQflhXQZi8Y3sxGkfv
	 BAJ8xv5MbkEEhj6cwUQMbzs7ReErsWT4jJaOwNXkvtuv9catZCgRb12TIbK6yqfxKH
	 jEBOvX+uFUgFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] ksmbd: restore DACL size on check_add_overflow() to avoid malformed ACL
Date: Sat,  8 Aug 2026 13:14:24 -0400
Message-ID: <20260808171424.498621-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808171424.498621-1-sashal@kernel.org>
References: <2026072937-broadcast-renewal-0307@gregkh>
 <20260808171424.498621-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit bbf0a8e931204ecdab494a88d43b0a24a04285c5 ]

check_add_overflow() unconditionally writes the truncated sum into *d
even on overflow, per its contract in include/linux/overflow.h.
The four check_add_overflow() guards in set_posix_acl_entries_dacl()
and set_ntacl_dacl() break out of the ACE-building loops on overflow,
but the truncated *size is then consumed downstream at the end of
set_ntacl_dacl():

    pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);

This produces an on-wire NT ACL whose pndacl->size under-reports the
bytes actually written by the preceding fill_ace_for_sid()/memcpy()
calls, yielding a malformed ACL that can trigger out-of-bounds reads
when re-parsed by clients or ksmbd itself.

Restore *size to its pre-addition value on each overflow branch (via
`*size -= ace_sz` / `size -= nt_ace_size`) so that after the break,
*size once again holds the cumulative size of the successfully-written
ACEs. The committed ACL is then truncated-but-self-consistent rather
than malformed.

The ksmbd DACL builders are the only check_add_overflow() sites found
where an overflow path breaks out of a loop and the destination value
is consumed afterward. The other nearby break-style cases either
return -EINVAL on overflow (transport_ipc.c) or break without
consuming the overflowed destination value afterward (buildid.c).

Fixes: 299f962c0b02 ("ksmbd: use check_add_overflow() to prevent u16 DACL size overflow")
Assisted-by: atomcode:glm-5.2
Assisted-by: Codex:gpt-5.5
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smbacl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 45c9b980418e8..2b2d8fbaa392e 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -644,6 +644,7 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
 		if (check_add_overflow(*size, ace_sz, size)) {
+			*size -= ace_sz;
 			kfree(sid);
 			break;
 		}
@@ -658,6 +659,7 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
 			if (check_add_overflow(*size, ace_sz, size)) {
+				*size -= ace_sz;
 				kfree(sid);
 				break;
 			}
@@ -703,6 +705,7 @@ static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
 		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
 		if (check_add_overflow(*size, ace_sz, size)) {
+			*size -= ace_sz;
 			kfree(sid);
 			break;
 		}
@@ -745,8 +748,10 @@ static void set_ntacl_dacl(struct user_namespace *user_ns,
 				goto next_ace;
 
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
-			if (check_add_overflow(size, nt_ace_size, &size))
+			if (check_add_overflow(size, nt_ace_size, &size)) {
+				size -= nt_ace_size;
 				break;
+			}
 			num_aces++;
 
 next_ace:
-- 
2.53.0

