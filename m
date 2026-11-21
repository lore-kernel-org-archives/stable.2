Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795296556;
	b=YZvxHBCUutKPayfY8edgwND2g7h32CcfuVgMGyn+qc5Y5v6VTWaLr4x3CfjcooLJz7FB
	 UMGUxha0tZHLW2MGTIjBAEJBUH77VcZkoIUwsOqc0cqs2rOG70PPrVmxxsuYiaAqaiRxj
	 xwnT4zxV6qxjH0d4ogql5pQzYsZi4CUFaKnHpZ1K9xTZGPg0X3g59jvmPMMPigR3VDgUT
	 oCe1Yv9tVJv8xsdid6IXt0qbpNZd/fjbr6qdop03IdWmWwEtxvP1PA4p35x6kW41mdwO3
	 LWAR71K8mCIAuGQWvLOBjxrIFXgVSptEy+f1KSe75iEbvD2P5q3su2JO4wXT7E/pn/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296556;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=23sDc1ULNMm1ETHtvpZrl9E+BXwKGdL/Xa3E7VzeDL0=;
	b=fL1DzZaKWbvUpYLXaveuOrs2McStyPSUFBdk8HtgHQhEn05kInPg0ipxw3hAwe4sAyXS
	 wExGoVaMa2KQypgVRopwhY64y6OKdA7qEb2sxrxtQGQA3Qvgv6uTgy8BIE82b2ikz2LK+
	 G4oab4W/i6CZtV4fRvnG6PgKj790BXUxMXDGndSvYYS6Tjs0AccXaYaRZOslfPDVv2yLI
	 5HqNn7u2YUEijsQXBV+M7c34VyqqeEC/p7a+rI9OaUMCoZgXe5YNN5U9Ddsc90RFd2Tdt
	 2UnH4QrW/ZYRqa6C8GfPAXlS6NmaH2gi3+gJdVGiZsy6I8ukociB4vg85jNj1+1h1hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZuJ4dw0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B972606A320;
	Sat, 21 Nov 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZuJ4dw0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795296556;
	b=jJjLmy+eLmZEv8lU7DDLaff9T02xDT8/z6Zad0qYOwSSQIbg5rapGIrQhMiX7g1wWiZQ
	 SmH7deMdrOMzWId+6mOChHpY8Rrosx5odtUl6hy4WfDaOAwx64/BUrMkxTdjwYdSH/UnM
	 8wpVjT82rRdMBmyYaG9/89bb4AholIzVH2pCdfJJV78N+EpiKaInKdnzf3zVi6xnpUG3X
	 zhPVEJfqO+wpaoX2FI9ZwZ++ysz5RJzAHPjbl7jvQQpGBT7xqOknXiwwcYM1b81pR4Pj2
	 B5ey7mbt+MRgXzu7pnROMZeFHiVeEBp09UVP/w2B3AOgAyrdJgfZfJM2Z59duBvDr+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795296556;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=23sDc1ULNMm1ETHtvpZrl9E+BXwKGdL/Xa3E7VzeDL0=;
	b=CgMNS6LrBxVjl/HAAPHgL6Cc6PlbsU6jVmErIdkqEE98qQLFmYtuU+WBdDmaIpOlE39s
	 tSoQ9xjum4EyxzrZFLhrKSeP1cwYi0vYLkXkzJHtJLbtDE/JdF+LCuDTGG+oBZgXsPMvG
	 ECTnUwG3XROMRiw5258XwJIcLcoUlkk0UMTOKUmAh7zbJ45zwOX9hi4hX5w3L350S8ly7
	 jSLZnHTzFtf2YGfxzLQoQZ8GgdvxFq18baVylmX9k0k29CzMxHnmjYU9SSqEiVWV1Jrjb
	 uZS2N3h5LJCwsCkHNv7zLEn4xT++PrBQznrTcv/Rhn7w0nZthCwX5nOGBdVBNExSurw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 599C51F000C6;
	Sat, 21 Nov 2026 21:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795296556;
	bh=23sDc1ULNMm1ETHtvpZrl9E+BXwKGdL/Xa3E7VzeDL0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=mZuJ4dw0vpIZSjgIBWNUGYc6UeRX63ZMt92Fz+da1TKVLxio6sIbr0SpPLQ+QgECW
	 4Ozhfsd/1N2n/LmnVoTotAGkcTVLSvxjDKkqn4ugkTSep6ztsp2hUiLk2UtobQ2NMJ
	 ITrYNlRXIwlOj5TH6B9z28sZPrlbYfdwudhJOiWlk5W6F/5Zrmb6P5bae5iblI3K84
	 fg9Il7fq8fcughOfAQe30oYbdi1Tx9LisB87D9LnuIhoBrYCgZuU3esm2NZQFtm6jk
	 ++bBkh4L/Gd2LJcQFPdOQb2T6BvNWJnjJ1igJ0lygP7SfGwUSi+ks1aJPOy5Fm141p
	 p9dTz5p7xiMJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ACFE64BDCA;
	Sat, 21 Nov 2026 21:29:14 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 21:29:15 +0000
Subject: [PATCH] apparmor: don't sleep in unix peer checks for path sockets
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
Message-Id: <20261121-apparmor-unix-peer-v1-1-99dd1cdb1e27@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDtgIrrwKqWLmPzqCI1hUkUQ7
 27aLr/FeydlqCBTX52k2CXLGgvMoyI/uziBJRSTrW1njDXsUnL6XpW3KAcnQLn1ocEYuqF2LZU
 wKUY5ftPn6++8DQv853ui67oBdLNkxXYAAAA=
X-Change-ID: 20261121-apparmor-unix-peer-5cd3efd6b0a5
To: John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795296554; l=8688;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=A5OtpOORF1rmexmWn52E93grd3HwLsXwp4br7SvH2fw=;
 b=j6rwvZp3KydRjXdqhSMSZ8F1s28gbIeK042Zcvm8g2r+RaqvcIpJ6fZGstSI0VM2QqZW2syz3
 A+w1j4XLwyUBhBqbts6U3FAMV+h8dT492gm9aNEQQyDEag4tcayrgdd
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

security_unix_may_send() and security_unix_stream_connect() run under
unix_state_lock(), but the path check of a path-bound peer calls
aa_path_perm(), which gets its buffer with aa_get_buffer(false):

  BUG: sleeping function called from invalid context at security/apparmor/lsm.c:2301
   aa_get_buffer+0x348/0x3a0
   aa_path_perm+0xdc/0x268
   unix_fs_perm+0x1d8/0x1e8
   unix_peer_perm+0x1d8/0x588
   aa_unix_peer_perm+0xe8/0x150
   apparmor_unix_may_send+0x108/0x260

Pass in_atomic down to aa_path_perm() and set it for peer checks.

Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Seen once on v7.3 (arm64, systemd-detect-virt sending to the journal
socket). It needs an empty buffer pool, so I tested with a test-only
knob that forces the kmalloc path: 189 splats without the patch, 0 with it.

Not fixed here: a chroot_relative profile still reaches path_put() in
d_namespace_path() under the lock (from reading the code, not tested).

Claude (AI) helped write this patch; I reviewed and tested it.
---
 security/apparmor/af_unix.c      | 19 ++++++++++---------
 security/apparmor/file.c         |  5 +++--
 security/apparmor/include/file.h |  3 ++-
 security/apparmor/lsm.c          | 13 +++++++------
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index 58c638830afc..ff851ddd43b4 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -32,7 +32,8 @@ static inline struct sock *aa_unix_sk(struct unix_sock *u)
 }
 
 static int unix_fs_perm(const char *op, u32 mask, const struct cred *subj_cred,
-			struct aa_label *label, const struct path *path)
+			struct aa_label *label, const struct path *path,
+			bool in_atomic)
 {
 	AA_BUG(!label);
 	AA_BUG(!path);
@@ -54,7 +55,7 @@ static int unix_fs_perm(const char *op, u32 mask, const struct cred *subj_cred,
 		};
 
 		return aa_path_perm(op, subj_cred, label, path,
-				    PATH_SOCK_COND, mask, &cond);
+				    PATH_SOCK_COND, mask, &cond, in_atomic);
 	} /* else implicitly delegated */
 
 	return 0;
@@ -240,7 +241,7 @@ static int profile_sk_perm(struct aa_profile *profile,
 		if (is_unix_fs(sk))
 			return unix_fs_perm(ad->op, request, ad->subj_cred,
 					    &profile->label,
-					    &unix_sk(sk)->path);
+					    &unix_sk(sk)->path, false);
 
 		state = match_to_sk(rules->policy, state, request, unix_sk(sk),
 				    &p, &ad->info);
@@ -302,7 +303,7 @@ static int profile_listen_perm(struct aa_profile *profile, struct sock *sk,
 		if (is_unix_fs(sk))
 			return unix_fs_perm(ad->op, AA_MAY_LISTEN,
 					    ad->subj_cred, &profile->label,
-					    &unix_sk(sk)->path);
+					    &unix_sk(sk)->path, false);
 
 		state = match_to_cmd(rules->policy, state, AA_MAY_LISTEN,
 				     unix_sk(sk), CMD_LISTEN, &p, &ad->info);
@@ -337,7 +338,7 @@ static int profile_accept_perm(struct aa_profile *profile,
 		if (is_unix_fs(sk))
 			return unix_fs_perm(ad->op, AA_MAY_ACCEPT,
 					    ad->subj_cred, &profile->label,
-					    &unix_sk(sk)->path);
+					    &unix_sk(sk)->path, false);
 
 		state = match_to_sk(rules->policy, state, AA_MAY_ACCEPT,
 				    unix_sk(sk), &p, &ad->info);
@@ -368,7 +369,7 @@ static int profile_opt_perm(struct aa_profile *profile, u32 request,
 		if (is_unix_fs(sk))
 			return unix_fs_perm(ad->op, request,
 					    ad->subj_cred, &profile->label,
-					    &unix_sk(sk)->path);
+					    &unix_sk(sk)->path, false);
 
 		state = match_to_cmd(rules->policy, state, request, unix_sk(sk),
 				     CMD_OPT, &p, &ad->info);
@@ -409,10 +410,10 @@ static int profile_peer_perm(struct aa_profile *profile, u32 request,
 
 		if (peer_path)
 			return unix_fs_perm(ad->op, request, ad->subj_cred,
-					    &profile->label, peer_path);
+					    &profile->label, peer_path, true);
 		else if (path)
 			return unix_fs_perm(ad->op, request, ad->subj_cred,
-					    &profile->label, path);
+					    &profile->label, path, true);
 		state = match_to_peer(rules->policy, state, request,
 				      unix_sk(sk),
 				      peer_addr, peer_addrlen, &p, &ad->info);
@@ -775,7 +776,7 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
 
 			last_error(error,
 				   unix_fs_perm(op, request, subj_cred, label,
-						&peer_path));
+						&peer_path, false));
 			if (peer_path.dentry)
 				path_put(&peer_path);
 		} else {
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index baca370ddfc0..056b670894c5 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -281,13 +281,14 @@ static int profile_path_perm(const char *op, const struct cred *subj_cred,
  * @flags: any additional path flags beyond what the profile specifies
  * @request: requested permissions
  * @cond: conditional info for this request  (NOT NULL)
+ * @in_atomic: whether allocations need to be done in atomic context
  *
  * Returns: %0 else error if access denied or other error
  */
 int aa_path_perm(const char *op, const struct cred *subj_cred,
 		 struct aa_label *label,
 		 const struct path *path, int flags, u32 request,
-		 struct path_cond *cond)
+		 struct path_cond *cond, bool in_atomic)
 {
 	struct aa_perms perms = {};
 	struct aa_profile *profile;
@@ -296,7 +297,7 @@ int aa_path_perm(const char *op, const struct cred *subj_cred,
 
 	flags |= PATH_DELEGATE_DELETED | (S_ISDIR(cond->mode) ? PATH_IS_DIR :
 								0);
-	buffer = aa_get_buffer(false);
+	buffer = aa_get_buffer(in_atomic);
 	if (!buffer)
 		return -ENOMEM;
 	error = fn_for_each_confined(label, profile,
diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 1614c07fc53e..aee493604333 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -90,7 +90,8 @@ int __aa_path_perm(const char *op, const struct cred *subj_cred,
 		   struct aa_perms *perms);
 int aa_path_perm(const char *op, const struct cred *subj_cred,
 		 struct aa_label *label, const struct path *path,
-		 int flags, u32 request, struct path_cond *cond);
+		 int flags, u32 request, struct path_cond *cond,
+		 bool in_atomic);
 
 int aa_path_link(const struct cred *subj_cred, struct aa_label *label,
 		 struct dentry *old_dentry, const struct path *new_dir,
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index eaebc3c60c5a..8224529cfbba 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -229,7 +229,7 @@ static int common_perm(const char *op, const struct path *path, u32 mask,
 	label = __begin_current_label_crit_section(&needput);
 	if (!unconfined(label))
 		error = aa_path_perm(op, current_cred(), label, path, 0, mask,
-				     cond);
+				     cond, false);
 	__end_current_label_crit_section(label, needput);
 
 	return error;
@@ -421,12 +421,12 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 					     label, &new_path, 0,
 					     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
 					     AA_MAY_SETATTR | AA_MAY_DELETE,
-					     &cond_exchange);
+					     &cond_exchange, false);
 			if (!error)
 				error = aa_path_perm(OP_RENAME_DEST, current_cred(),
 						     label, &old_path,
 						     0, MAY_WRITE | AA_MAY_SETATTR |
-						     AA_MAY_CREATE, &cond_exchange);
+						     AA_MAY_CREATE, &cond_exchange, false);
 		}
 
 		if (!error)
@@ -434,12 +434,12 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 					     label, &old_path, 0,
 					     MAY_READ | AA_MAY_GETATTR | MAY_WRITE |
 					     AA_MAY_SETATTR | AA_MAY_DELETE,
-					     &cond);
+					     &cond, false);
 		if (!error)
 			error = aa_path_perm(OP_RENAME_DEST, current_cred(),
 					     label, &new_path,
 					     0, MAY_WRITE | AA_MAY_SETATTR |
-					     AA_MAY_CREATE, &cond);
+					     AA_MAY_CREATE, &cond, false);
 
 	}
 	end_current_label_crit_section(label, needput);
@@ -497,7 +497,8 @@ static int apparmor_file_open(struct file *file)
 
 		error = aa_path_perm(OP_OPEN, file->f_cred,
 				     label, &file->f_path, 0,
-				     aa_map_file_to_perms(file), &cond);
+				     aa_map_file_to_perms(file), &cond,
+				     false);
 		/* todo cache full allowed permissions set and state */
 		fctx->allow = aa_map_file_to_perms(file);
 	}

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261121-apparmor-unix-peer-5cd3efd6b0a5

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


