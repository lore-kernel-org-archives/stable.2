Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046548;
	b=sRoHpw6kVNLhASOh4O4YrKyVnhLuTIuwgS3zb7D9Cob9nvFQKbe3U3zf6YnBy1lj1i9D
	 iEQGs42Bj6cjZkddjfMBwUGgKzuhqlZc4YqXNmrFj5cYC7mHKpqFBVpzwkASSdi3yjHK9
	 LSK+V/55ok8JeS0aVFc0Xyj9laM1Vx93JyMGsrur0dHu4fqMJP/dwKasQ9+hS072y3R/9
	 15fOWkwJe0G/MrHGKdLcA9DU4BMCWMqaE1p15FvrfwcmkPhIgulRqeZt/h0IwGys1QdC9
	 MJd3U3LSA3QvXbXq0aLjEucchiD3+7O3jz9WrIT1xHLdHqx5hqUL6lM6p9pO0UsyFHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Hb6Qr63aHWj08S1ayRFkIfDolfKllTnmsgEqOfzGFDc=;
	b=Az81QKPHtzb7m+JSU4I+/1WLfoYtw1rk1AC6+TRAZQWBgrm0PecNXjgEoY4LdfP/rzT5
	 h0qQQjRuVJR5k2yt034JiI8tuPSCngofQG7WGKnjcvXCjtqgoLJKnrDvYjD7ilg0mO28t
	 ynOhAFboEnLq37KzbPMJNsxgqrTbda9SBHc0HpDWSVfHCaI9h/7ReOr9uZ5mKUlzqNwP5
	 JwazwBTIlmNgGd9fmhkMQKmX+NoLHwKbwlkyQEF+V1Yw0Mr8W5K13NKiQmQTLnAR9z9dI
	 7E2WgP884pkfLvWu1XuJsseP+h8tRO70wGr4jgZaTonSbjtxfO0GfcyPro0eglGZYNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qh5C/Whg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD25606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh5C/Whg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2171F0089F;
	Sat,  7 Nov 2026 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046548;
	bh=Hb6Qr63aHWj08S1ayRFkIfDolfKllTnmsgEqOfzGFDc=;
	h=From:To:Cc:Subject:Date;
	b=Qh5C/Whg66KHslkoHCkkzWUEpzHYNCAD2YT8Av7efG10A4UPAkpF0zQ4rYKQ52RAh
	 8yp8AssZBFNDzcu1TNe+UmBTwD/SeliVVlGLU8JJMjL47ygVZyEvYBnV6LEptBcWn3
	 VNTQBJDT3ye6s/N8WtmS5jEwBxYqKFPGGM1EqXCo8vs7DBQDOvmMEDcvT8dpvLjr0M
	 LvaIMGQL/RoD+wrCfgTHU0OUOfmzet6z3S2jF+w7qbg9ea1HnR2ixta8uCNG0alBQy
	 Ci2kr2r/k77jtxvL4bIJ9xxRdwb82uQZ106Pwlw7PldHkWPd81nb1KmJ1Pxx/57BNR
	 cHMa2hXUo4r5g==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	wufan@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fsverity: Tell LSMs about signature only after verity is enabled" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:46 -0500
Message-ID: <20261107051546-failed-6.18-28d74059fddb@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 28d74059fddbd8ae83c7715056b303c402071f6f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051546-failed-6.18-28d74059fddb@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 28d74059fddbd8ae83c7715056b303c402071f6f Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 25 Oct 2026 13:45:34 -0700
Subject: [PATCH] fsverity: Tell LSMs about signature only after verity is
 enabled

FS_IOC_ENABLE_VERITY calls security_inode_setintegrity() before verity
has finished being enabled.  That's broken because enabling verity can
still fail at that point, e.g. due to insufficient xattr space.

Afterwards, arbitrary contents can be written to the file, which doesn't
actually have verity enabled.  The in-core inode stays the same, so the
LSM considers it to have verity enabled with a valid signature.  (Or
rather, in the case of IPE, which is the only LSM that implements
security_inode_setintegrity(), it also checks IS_VERITY(), which can be
bypassed by enabling verity with no signature after the file writes.)

Fix this by moving the call to security_inode_setintegrity() out of
fsverity_verify_signature() and into a new function that is called from
the appropriate places.

Fixes: 7c373e4f1445 ("fsverity: expose verified fsverity built-in signatures to LSMs")
Cc: stable@vger.kernel.org
Reviewed-by: Fan Wu <wufan@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
Link: https://patch.msgid.link/20261025204534.122506-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/enable.c           |  8 ++++++
 fs/verity/fsverity_private.h |  8 ++++++
 fs/verity/open.c             |  9 ++++++
 fs/verity/signature.c        | 55 ++++++++++++++++++++++++++----------
 4 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index ad4ff71d7dd95..2949fb8afb2fa 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -302,6 +302,14 @@ static int enable_verity(struct file *filp,
 	} else if (WARN_ON_ONCE(!IS_VERITY(inode))) {
 		fsverity_remove_info(vi);
 		err = -EINVAL;
+	} else {
+		/*
+		 * Now that verity is enabled, report the signature (if any) to
+		 * LSMs.  We tolerate that a process racing with this ioctl can
+		 * briefly see verity enabled with no signature reported yet.
+		 */
+		fsverity_report_valid_sig(inode, desc->signature,
+					  le32_to_cpu(desc->sig_size));
 	}
 out:
 	kfree(params.hashstate);
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 6f85f63861aaa..2c41428d484b3 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -160,6 +160,8 @@ void __init fsverity_init_info_cache(void);
 extern int fsverity_require_signatures;
 int fsverity_verify_signature(const struct fsverity_info *vi,
 			      const u8 *signature, size_t sig_size);
+void fsverity_report_valid_sig(const struct inode *inode, const u8 *signature,
+			       size_t sig_size);
 
 void __init fsverity_init_signature(void);
 #else /* !CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
@@ -170,6 +172,12 @@ fsverity_verify_signature(const struct fsverity_info *vi,
 	return 0;
 }
 
+static inline void fsverity_report_valid_sig(const struct inode *inode,
+					     const u8 *signature,
+					     size_t sig_size)
+{
+}
+
 static inline void fsverity_init_signature(void)
 {
 }
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 78a65154b8957..d1ac9556e9474 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -387,6 +387,15 @@ int fsverity_ensure_verity_info(struct inode *inode)
 		goto out_free_desc;
 	}
 
+	/*
+	 * Now that the signature (if any) has been verified, report it to LSMs.
+	 * Do this before inserting the fsverity_info into the hashtable, so
+	 * that anyone who concurrently retrieves the fsverity_info for the same
+	 * inode is guaranteed to see the LSM's signature status populated.
+	 */
+	fsverity_report_valid_sig(inode, desc->signature,
+				  le32_to_cpu(desc->sig_size));
+
 	/*
 	 * Multiple tasks may race to set the inode's verity info, in which case
 	 * we might find an existing fsverity_info in the hash table.
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 07657e913b22a..2f49c5d9d9870 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -42,13 +42,16 @@ static struct key *fsverity_keyring;
  * @sig_size: size of signature in bytes, or 0 if no signature
  *
  * If the file includes a signature of its fs-verity file digest, verify it
- * against the certificates in the fs-verity keyring. Note that signatures
- * are verified regardless of the state of the 'fsverity_require_signatures'
- * variable and the LSM subsystem relies on this behavior to help enforce
- * file integrity policies. Please discuss changes with the LSM list
- * (thank you!).
+ * against the certificates in the fs-verity keyring.
  *
- * Return: 0 on success (signature valid or not required); -errno on failure
+ * Note that signatures are verified regardless of the state of the
+ * 'fsverity_require_signatures' variable, and the LSM subsystem relies on this
+ * behavior to help enforce file integrity policies.  (See
+ * fsverity_report_valid_sig(), which assumes that the signature, if present,
+ * was verified here.)  Please discuss changes with the LSM list (thank you!).
+ *
+ * Return: 0 if the signature is present and valid, or absent and not required;
+ *	   -errno on failure
  */
 int fsverity_verify_signature(const struct fsverity_info *vi,
 			      const u8 *signature, size_t sig_size)
@@ -111,18 +114,40 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 		return err;
 	}
 
-	err = security_inode_setintegrity(inode,
-					  LSM_INT_FSVERITY_BUILTINSIG_VALID,
-					  signature,
-					  sig_size);
+	return 0;
+}
 
-	if (err) {
+/*
+ * If the signature exists, this tells the LSM that it was verified.
+ *
+ * fsverity_verify_signature() must have already been called with the same
+ * signature, *and* the inode must have verity enabled with the signature
+ * matching it.  If called from FS_IOC_ENABLE_VERITY, the latter means that we
+ * must be past the point of no return, i.e. verity won't fail to be enabled at
+ * a later point.  This is critical, since LSMs must be told about the signature
+ * only when the verity status is permanent in the in-core inode.
+ */
+void fsverity_report_valid_sig(const struct inode *inode, const u8 *signature,
+			       size_t sig_size)
+{
+	int err;
+
+	if (WARN_ON_ONCE(!IS_VERITY(inode)))
+		return;
+
+	if (sig_size == 0)
+		return;
+
+	err = security_inode_setintegrity(
+		inode, LSM_INT_FSVERITY_BUILTINSIG_VALID, signature, sig_size);
+	if (err)
 		fsverity_err(inode, "Error %d exposing file signature to LSMs",
 			     err);
-		return err;
-	}
-
-	return 0;
+	/*
+	 * Besides the logging above, ignore errors here.  The LSM hook just
+	 * records the signature and doesn't perform access control.  And in the
+	 * case of FS_IOC_ENABLE_VERITY verity was already enabled.
+	 */
 }
 
 void __init fsverity_init_signature(void)
-- 
2.53.0




