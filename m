Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582849DB96
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051738; cv=none; b=K3ev8YQ8/yvGwNcOz1D5C6rvO7kO6802GSzN/kLN5suLZcayKufDm8xOo6H4mLbmle7l64UV84CvArWn+FRBUwL8PA/seIsOpnQ0hJQ7icakUDhSM6pPuTdWSUHvv0DK5nsuVVIGp6Jdmr5aDyAimtciLQxnV5AQEveJO0/td1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051738; c=relaxed/simple;
	bh=YM7KzRMlWzqVl+WNhTeX/beK1tx3PR9D3e13J7EMLag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORuoTxfDmHKjDqUFr5LP55sNY3C4tyID+4+eRAfT+f1+F1s+8YQtXULMfDqClmA9jAiP7em2VaKPCM6zJHXihXIt52miSRg8uOlqLWxTv/kV5u24FlrsCZhqr3wVa+w5o3o16oFudE4RiLqfCqRqWoLDZiwaZDwXUA8xNH8kuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=f1e3VNLJ; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="f1e3VNLJ"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hggXw2RBFzmrX;
	Thu, 10 Sep 2026 16:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789051728;
	bh=PnKpu1050wzCRAg3LYWxdRTHOUPJgvegLDYPC+bThGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1e3VNLJ7N3LlZyvTOyb2VNO6dOroPNlZnToaMHmjke5E6unPEIQJYN2yFu7d6sDG
	 SYqLj83UwZwLD9ebThu966waz8Z63JiHWOQV4rGdJdwgkO760wiC/tCK2L71ZmxL1K
	 s2jHEhdsIyf2Uuv/sjFQzBy2JMZuioYSyiySIzwY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hggXv1qDzzN5S;
	Thu, 10 Sep 2026 16:48:47 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Nick Kralevich <nnk@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] lsm: Preserve full ioctl commands in audit records
Date: Thu, 10 Sep 2026 16:48:33 +0200
Message-ID: <20260910144837.381855-2-mic@digikod.net>
In-Reply-To: <20260910144837.381855-1-mic@digikod.net>
References: <20260910144837.381855-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Ioctl commands are unsigned int values, with their encoded direction and
size in the upper 16 bits.  However, struct lsm_ioctlop_audit keeps only
a u16, and the common audit formatter uses %hx.  This logs 0xc00ffeee as
0xfeee and makes distinct commands with matching low 16 bits
indistinguishable.

Change cmd to unsigned int and use %x.  Pass the full command through
ioctl_has_perm() as well.  Its driver and xperm values remain u8 values
derived from the same low 16 bits, so SELinux enforcement does not
change.  Commands that fit in 16 bits keep the same audit text.

Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: stable@vger.kernel.org
Fixes: 671a2781ff01 ("security: add ioctl specific auditing to lsm_audit")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/linux/lsm_audit.h | 2 +-
 security/lsm_audit.c      | 2 +-
 security/selinux/hooks.c  | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 584db296e43b..fc68ca94f05a 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -44,7 +44,7 @@ struct lsm_network_audit {
 
 struct lsm_ioctlop_audit {
 	struct path path;
-	u16 cmd;
+	unsigned int cmd;
 };
 
 struct lsm_ibpkey_audit {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 737f5a263a8f..a7891a75d0aa 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -231,7 +231,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 			audit_log_format(ab, " ino=%llu", inode->i_ino);
 		}
 
-		audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
+		audit_log_format(ab, " ioctlcmd=0x%x", a->u.op->cmd);
 		break;
 	}
 	case LSM_AUDIT_DATA_DENTRY: {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 035aaf113d1d..e3eaa3141d91 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3859,7 +3859,7 @@ static int selinux_backing_file_alloc(struct file *backing_file,
  * operation to an inode.
  */
 static int ioctl_has_perm(const struct cred *cred, struct file *file,
-		u32 requested, u16 cmd)
+		u32 requested, unsigned int cmd)
 {
 	struct common_audit_data ad;
 	struct file_security_struct *fsec = selinux_file(file);
@@ -3930,14 +3930,14 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	case FIOCLEX:
 	case FIONCLEX:
 		if (!selinux_policycap_ioctl_skip_cloexec())
-			error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
+			error = ioctl_has_perm(cred, file, FILE__IOCTL, cmd);
 		break;
 
 	/* default case assumes that the command will go
 	 * to the file's ioctl() function.
 	 */
 	default:
-		error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
+		error = ioctl_has_perm(cred, file, FILE__IOCTL, cmd);
 	}
 	return error;
 }
-- 
2.55.0

