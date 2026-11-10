Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273347;
	b=gueFdITSBaRppU6JipzvmuDx6Is0WGlfgijpZ3xo+vHkEHimysJJacGI/M0sOEP3CGkS
	 ivJI8oYa0q36n0n2PZrlMqwoefNMvUk7KL6ay1cFWRCwIQzYNsa26Toxtc992TESl/kVk
	 HrdRysobrDvPPqB5TN2bN3Ezbl39VHqY+mwSLZ1HCc36Hz8sKmHGz2CR22d3hGh1MrxW0
	 Vw+W+rvvwIKmUlJS1e2Tl2rt3O0a4cIP8NHWRmkHPpk0HMsOm2TP9/n58TP0HXuoDG/lv
	 hl13Nii0+UTCBmWc+AUa3XVt79xCLG58o+OzN6JiWityOumRZCtL1D49J/vsQJrlFIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273347;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tBkOBMLWNkEm5TvLXUecFiVFqcUmEVFWvU36FdJItpM=;
	b=ytaeVsa7P1OgpOU8rkCRv6WJ/loXo6TWWu8ohEjk3OK7xOflR4U7kePKwjOhFq11eFXz
	 eHIiQ3tpD1OZWNXl80VW2QZmiJK/cpuTaHH0Yf1sqLM8l3aph8l5OZAGh0T8JN4e2hsVR
	 7Ualecr1wdnaCStnF3dnCqObrOfXzyyfD0u32ouwTqlB70pQuEpYHJbCa58kD3mC+WMfD
	 LeVMuYHVtAHG2XtIXxid2puAWn1JDi3NozkWXrW7MF9D7B1gPrpkLFb5uNNByxXxvX45M
	 o5TbSgsRgipkCv7exbEukN6R0tedc9Xwc4l2k6XkOyJ/TFSgmBYia2D89DRECU8kWKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvgAHGx2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvgAHGx2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163881F0089F;
	Tue, 10 Nov 2026 01:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273347;
	bh=tBkOBMLWNkEm5TvLXUecFiVFqcUmEVFWvU36FdJItpM=;
	h=From:To:Cc:Subject:Date;
	b=WvgAHGx2OgRLkFPgffQDB2k3CtDIDnN+pjeZ2n+kxGKinAiS3QSizbmsbWTPtDY3L
	 y6QEfN5X55d8A7ZCmpRAl34/sKleco+rpM9TytWqqMyRuItvXWXBuNkfhwrEAJpUL1
	 bJ4j5Mma1q+GW1CeqWLBAHaMWlZ5EqjbrOEy6SW2IOYzu0msOj49ICeCZBnAP3apQt
	 K4PnIRcmQklm2cB9HMKeYD9MG11EJZTG9x2YyhbcL5xpwfDsGQ6dQ1i/jnMM0I0KpB
	 YHTkV5JumpEAnZ5k47qVi1GkunTht27eZS5A2bnO7JJFwnWw/ZRlT0WcjDraRhgdIF
	 IG7Hwvrw847KA==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: let the owner read and change the DACL when no ACE names it" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:45 -0500
Message-ID: <20261109201545-failed-6.1-ffc855fe16af@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ffc855fe16afe02b22305111aa68cd8d07360941
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201545-failed-6.1-ffc855fe16af@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ffc855fe16afe02b22305111aa68cd8d07360941 Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Mon, 2 Nov 2026 00:15:36 -0600
Subject: [PATCH] ksmbd: let the owner read and change the DACL when no ACE
 names it

smb_check_perm_dacl() refuses the owner when neither its DACL lookup nor
the POSIX ACL fallback matches. The owner then cannot read or replace
the DACL over SMB. MS-DTYP 2.5.3.2 grants the owner READ_CONTROL and
WRITE_DAC unless an OWNER RIGHTS ACE applies.

An empty DACL allows the owner's explicit requests for these rights but
refuses MAXIMUM_ALLOWED. smb2_open() uses that check for the maximal
access reply (MS-SMB2 3.3.5.9.5), so even a READ_CONTROL open fails when
it asks for that reply.

Grant the owner's implicit rights on both paths, for explicit requests
and MAXIMUM_ALLOWED, unless an OWNER RIGHTS ACE applies.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/smbacl.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 66fbf5537321e..ab76c5c9e0ea8 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1477,6 +1477,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	int i, found = 0;
 	unsigned int access_bits = 0, denied = 0;
 	struct smb_ace *others_ace = NULL;
+	bool or_ace = false;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
@@ -1509,6 +1510,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	is_owner = uid == from_kuid(&init_user_ns, vfsuid_into_kuid(vfsuid));
 
 	if (!pdacl->num_aces) {
+		unsigned int allowed = 0;
+
 		/*
 		 * An empty (present, zero-ACE) DACL grants no access to
 		 * anyone except the object owner's implicit READ_CONTROL
@@ -1517,9 +1520,14 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		 * not let trailing bytes after a zero-ACE DACL become an
 		 * implicit grant.
 		 */
-		if (!is_owner ||
-		    (*pdaccess & ~(FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE)))
+		if (is_owner)
+			allowed = READ_CONTROL | WRITE_DAC;
+		if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+			requested |= allowed;
+		if (!allowed || requested & ~allowed)
 			rc = -EACCES;
+		else
+			*pdaccess = cpu_to_le32(requested);
 		goto err_out;
 	}
 
@@ -1604,6 +1612,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			found = 1;
 			break;
 		}
+		if (!compare_sids(&sid_owner_rights, &ace->sid) &&
+		    !(ace->flags & INHERIT_ONLY_ACE))
+			or_ace = true;
 		if (!compare_sids(&sid_everyone, &ace->sid) ||
 		    !compare_sids(&sid_authusers, &ace->sid))
 			others_ace = ace;
@@ -1648,8 +1659,23 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		if (others_ace) {
 			ace = others_ace;
 		} else {
-			ksmbd_debug(SMB, "Can't find corresponding sid\n");
-			rc = -EACCES;
+			unsigned int allowed = 0;
+
+			/*
+			 * No ACE names the owner, who may still read and
+			 * change the DACL unless OWNER RIGHTS applies
+			 * (MS-DTYP 2.5.3.2).
+			 */
+			if (is_owner && !or_ace)
+				allowed = READ_CONTROL | WRITE_DAC;
+			if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+				requested |= allowed;
+			if (!allowed || requested & ~allowed) {
+				ksmbd_debug(SMB, "Can't find corresponding sid\n");
+				rc = -EACCES;
+				goto err_out;
+			}
+			*pdaccess = cpu_to_le32(requested);
 			goto err_out;
 		}
 	}
-- 
2.53.0




