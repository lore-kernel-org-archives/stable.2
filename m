Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649846;
	b=NCNS2caG46dX/wjb4sokYJ2YmDqOMgl35cEmLY2GOzgxUMOptMGIIpYE2bYX2TXoFg5t
	 WbvZZd+TaQ7vL1X/gMHVALX+lwy6lI8nHgF/dIptXyZVT24Li7e/9OUhVrbslkLItEzoR
	 oGg0uxdVYAyE7jHVjduBEQB04aNOG71/EkPxJ8UThwP+tvN5wUUhBM49mg0sDtO4EWPZb
	 8Fr2wtNORdqcUZN1Hc9w0jJSHVyYJFlWesS0HNPHcxrAlzP2b6oP31rr9mEpAT+BwhnZD
	 GN2ckxUTF8zXTQcqHtDV+ouEuZLKgjWwa5UGbxpRE/Fi4K8gxY4sO4wizsvtj+Eegiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YiWKeC1MiIyvrH+4z2zS7difmxKk8EqNUVTUaD5g1l0=;
	b=aKcA+TKcGwTtfdEZ1IW/LjFAKeymM5vWBUHYCEDI9blBJ7RXpWyWu4LlBa0edNe3EppD
	 hxkacuFGK9dmIjLJL2QsHqPMEtpLoktnWyabJiO9w7yZIg4LcWj7Meiu7mOELjabhPFC4
	 R/T0daTTXxnARmT+zyUYlDOoIkFtNWFCJD+Dg2JTjq0sofQldWa1mvZ3c1K+yXdSgRG/S
	 5YYwmoiMVBY5z1ri28V1xwGx+qJ4YN3Oh5dhpK/O4Jmnwg2yVmLWqanp4DDaZr/XhC+rJ
	 n4u7tjt/X/KTZqKxK9hAXTfX/1wd0VhR1iQHN2oxAQ6FZ3lhuaU7GFC+zNp5UyxWMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm2 header.b=X9V3vRMx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CczTawjN;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A02606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 20:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A02606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm2 header.b=X9V3vRMx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CczTawjN
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1245314001F4
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:04:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 15:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1793649845; x=1793736245; bh=YiWKeC1MiIyvrH+4z2zS7
	difmxKk8EqNUVTUaD5g1l0=; b=X9V3vRMxgfKszvjZmyV/zgn+Io/TRYJOVTwXJ
	L/trbm3gR81u68rQVTvb59wW6J/RiIZWe3hwWzkVC3cnjOBe/ZuWKljhwSd/+NAZ
	Q316lvqM3J6581sI9lX6e46Q7VhqX3FHhabeHoEv0QZtCIZqYYW6DY4UzyIh6/U6
	J78JEOgSW43kds/uFH+J2qyU9PUkBJ8WRa9fWW9L8VIqVv6tKAKe7GX4YlhGpH+H
	Sn2+4nlEoJ+yMKpixT4tGoFJm17Uc1TjGtFTNvdrpbrpsBT3JZHuwJDB/Df/tEgX
	Nm4emxQrxwrKFR9dFdS6mycfaFHW53iiFtlWydlVhVy//9VBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793649845; x=1793736245; bh=YiWKeC1MiIyvrH+4z2zS7difmxKk8EqNUVT
	UaD5g1l0=; b=CczTawjNnonTzOf1C8ylUAbdq7bMmMb8OC+ADBV9lcvosm8Sz1/
	LQV7EStoUFkWTrt42NKPGdalYyE3N+lXUI7UXfYcV4A6GJPl8+Px6W/r1gwDWOqq
	bYWZuBYHf2e8sC7zlX2h2rY8WygcQrpW2TsKA1+0ayPGpMrJi+xIwj3tLB6bWDld
	eWFHGdx9uMefzOrTfdt3+gRrRjQ6CTAu0gp6RUsVSjAJ7enGFZ5z4lZr+5BexsE2
	LHP4R5jPelScrVAyls/LZ+a2yQmVoHEdRlAx/nY29fsMmNtsBCh4JFI8W+WfFgh4
	Lsi6QadKkJJ7b4PQspUkw1xmBaY+GvAHbnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793649845; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZCERdBLJNoZYZASUiMBKv7tiZ5Lh5lCVrOb9ubVoiwkQbVP
	wB9jO+iUGEGOmP9HRBZOzUM69x7KmdrPCRLYBewTbycMEYlq/U2xVhz5wab6ItaH
	RNfFyZAjzqkcpDJ2yaFzBL5TPY/NqvGcJlGdMdJLr9mq3OFHJ2JMhHWTv1qpFj1s
	qRNrEXce+BiTl4jpfSUC2G1LhcTM8FufnVgTGeZNVldrAJTEx4XLO33BRSNJ+6Ed
	yw41wxwXjQJDI+W44aAtGeFkVzx1Pb1LtOPEF6lgCZXprB9kpKgwo7cKJaDzqvJX
	Ivg8wCW2mos9SeIybx2YYKKN7EVWdv0QW9DDX8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:EnuZclC8ZtR2spHq5HetwzIAON1jiGvho0A9vaTSRNI=:zCof2IsTe3dakitPEMe8pw2akIaLdFI/WGUKoQ8MZfA=;
X-ME-Sender: <xms:tOzoanFLkKOgpDxAZuvuGl1Vkoe9Fg_uNhUBO0gC-BKt3fKqASfjUg>
    <xme:tOzoag6ML0pHdhewNG_tiOdKmkhR9H_qt8tAiBTyhJ9CcXIeIlnvs9EBMhxEdYnt3
    FW_00WkF-kgS2IHKpCzd4xCZCND5cefoL4GAizr_QREp2PecO5SXg_Z>
X-ME-Received: <xmr:tOzoatluoQIg1pxpjHD6I9Re7--lc-Fn6y8xMnEYDe__EFIqydS5ib45dzMOgPwS>
X-ME-Proxy-Cause: dmFkZTGrI/BYYEHvbLhhTvUJLQmv4G/KVyhmcdqSvkN+WyIMEyRmFK2tpwN/XEfpFxjDVa
    99fTGbvwEZdY7BAqv+2lsJ3VtAv8BZs/1QISYzCz50Ti5MUg1WENobE6nmcUAoqFGsGeLW
    Shxuw/16YKL6nKlzrrRYOy/pODakzkw8c7viN1+V95wldA4Ifo8m/0By67Z4Mg2Uj42p3i
    x2eLKHbC+pWvaob/FN2Wu/pUCrXN6MAbSBVe163KRNKAr+d4V2gVW2YeGhcByXG5SSdYSD
    nEP3Jk058KYLrlx9aGN54Jvnvn8a1D57Y06Z25UlEuErTGuUiCiQYl+pk3oI/i/6vYUpm7
    1pONcTrUAbZoz+3uHCq3M7w5KVQ+Ds5aIsFIk1LM3cdjv/0dL5yYr3cyPGpo+X7GrENDt8
    Whpg88aZeuKcb0JqdWliSrQy+q2Nbr9VKXzp4s82YyifwUATpNIRaGKxuLUwSm8kWuWFFP
    vwMnygFZq5pRtiG3X6idwjgmtwnxQa9XslugnSCVWRrLg0oCQ5b+/8lEB1Acu01Ltch26z
    kJNACyUCmFGM78O5YeMp9B4+ebV3iHnCFUVoMfU4Ee6GyC7y534+1JFiOzZhpjkJO/t9cf
    8f5iG7ggtAtcq8gxNrmZk3e/8qSVr7+zNEkKbKUKcvNA6wy6qEs9L36jXoBw
X-ME-Proxy: <xmx:tOzoar4p1LZKpWHgKih4uQi4e1v679QnE1fWZV027PIALNFVdsLiMg>
    <xmx:tOzoauRRHBHG2_JDtTacONUXmbZg6WpKafj2mOEK2l7o7u87rrK6PA>
    <xmx:tOzoapwt1MmznJR52qAMsgdaWjeNCHj1T7_rBb5q-mjpjtn017Xa1Q>
    <xmx:tOzoamr84XcVPVJQBP7r9AYAS031A981rDQ5WRCr2c_j48hbN8d7xg>
    <xmx:tezoaukSqsvTkwhP3m56KQYfDLgzvCh-PAeRMFPRhbyf50yZI3JL5v9d>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 15:04:03 -0500 (EST)
From: Ian Bridges <icb@fastmail.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	Ian Bridges <icb@fastmail.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] ksmbd: grant a caller what its groups and OWNER RIGHTS ACEs allow
Date: Mon,  2 Nov 2026 14:03:53 -0600
Message-ID: <20261102200353.884509-1-icb@fastmail.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smb_check_perm_dacl() does not match ACEs for the caller's groups. It
also refuses an owner named only by an OWNER RIGHTS ACE, although its
MAXIMUM_ALLOWED walk already counts that ACE. These callers cannot use
rights the DACL grants them under MS-DTYP 2.5.3.2.

Run the existing ordered walk for every request and match Unix group
ACEs (S-1-22-2) against the caller's credentials. Use its result when
the existing SID lookup and POSIX ACL fallback do not decide the open.

Group ACEs remain excluded from MAXIMUM_ALLOWED. An open that asks for
the maximal access reply is therefore still refused for a caller that
only group ACEs name. Adding them requires corresponding changes in
smb2_open(), which derives open flags and the maximal access reply from
that answer.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
---

Notes:
    Since v1, clear access_bits after the ordered walk for explicit
    requests. In v1, when the caller's first ACE had a type the lookup does
    not handle, such as an allow-callback ACE, an explicit request got the
    walk's result instead of the earlier refusal. Sashiko found this [1].
    The message now also says that an open asking for the maximal access
    reply is still refused for a caller that only group ACEs name.
    
    v1: https://lore.kernel.org/linux-cifs/20261102061537.830714-3-icb@fastmail.org/
    [1] https://sashiko.dev/#/patchset/20261102061537.830714-1-icb%40fastmail.org
    
    Reachable on a share with "vfs objects = acl_xattr", for example on a
    file whose DACL only has ACEs for Unix groups (S-1-22-2) or OWNER
    RIGHTS.
    
    MAXIMUM_ALLOWED does not count groups here because smb2_open() also
    builds the open flags and the maximal access reply from that answer.
    Counting them there makes some MAXIMUM_ALLOWED opens fail that work
    today.
    
    Tested on ksmbd-for-next ffc855fe16af with KASAN. Results change for
    members of the file's group and of other groups the DACL names, and for
    the owner. A member of a group that the DACL grants full access now
    reads the file. An owner that only an OWNER RIGHTS ACE names now gets
    what that ACE allows. Its MAXIMUM_ALLOWED opens, refused before, now
    succeed with the rights in the maximal access reply. DACLs with no ACE
    give the same results as before. So do DACLs whose first ACE for the
    caller has a type the lookup does not handle, such as an allow-callback
    or audit ACE.
    
    A reproducer is available on request.
    
    This fix was developed with LLM assistance.

 fs/smb/server/smbacl.c | 58 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index ab76c5c9e0ea..df456c635004 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1459,6 +1459,22 @@ bool smb_inherit_flags(int flags, bool is_dir)
 	return false;
 }
 
+/* Whether the caller's credentials hold the group of an S-1-22-2-<gid> SID */
+static bool smb_sid_in_group(const struct smb_sid *sid)
+{
+	if (sid->num_subauth != 2 || compare_sids(sid, &sid_unix_groups))
+		return false;
+	/*
+	 * ksmbd_override_fsids() builds the caller's credentials with
+	 * make_kgid(&init_user_ns, ...), so the group membership test must
+	 * compare in that space.  Applying the mount idmap here (as when
+	 * resolving a SID to an on-disk gid) would mismatch on idmapped
+	 * mounts.
+	 */
+	return in_group_p(make_kgid(&init_user_ns,
+				    le32_to_cpu(sid->sub_auth[1])));
+}
+
 int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, __le32 raw_daccess, int uid,
 			bool strict)
@@ -1475,13 +1491,16 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	int granted = requested;
 	struct smb_ace *ace;
 	int i, found = 0;
-	unsigned int access_bits = 0, denied = 0;
+	unsigned int access_bits = 0, denied = 0, ordered = 0;
 	struct smb_ace *others_ace = NULL;
-	bool or_ace = false;
+	bool or_ace = false, in_group = false;
 	struct posix_acl_entry *pa_entry;
 	unsigned int sid_type = SIDOWNER;
 	unsigned short ace_size;
 	bool is_owner, owner_rights = false;
+	bool maximal = *pdaccess & FILE_MAXIMAL_ACCESS_LE;
+	/* The answer to MAXIMUM_ALLOWED stays without the caller's groups */
+	bool groups = !maximal;
 	vfsuid_t vfsuid;
 
 	ksmbd_debug(SMB, "check permission using windows acl\n");
@@ -1522,7 +1541,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		 */
 		if (is_owner)
 			allowed = READ_CONTROL | WRITE_DAC;
-		if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+		if (maximal)
 			requested |= allowed;
 		if (!allowed || requested & ~allowed)
 			rc = -EACCES;
@@ -1531,7 +1550,12 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		goto err_out;
 	}
 
-	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE) {
+	/*
+	 * Evaluate the DACL in order (MS-DTYP 2.5.3.2). MAXIMUM_ALLOWED takes
+	 * its result, and so does a caller that only group or OWNER RIGHTS
+	 * ACEs name.
+	 */
+	{
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = pdacl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
@@ -1562,7 +1586,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			     compare_sids(&sid_unix_NFS_mode, &ace->sid) &&
 			     compare_sids(&sid_everyone, &ace->sid) &&
 			     compare_sids(&sid_authusers, &ace->sid) &&
-			     compare_sids(&sid_owner_rights, &ace->sid)))
+			     compare_sids(&sid_owner_rights, &ace->sid) &&
+			     !(groups && smb_sid_in_group(&ace->sid))))
 				goto next_ace;
 
 			switch (ace->type) {
@@ -1578,15 +1603,20 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 next_ace:
 			ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
 		}
-		if (is_owner && !owner_rights)
+		ordered = access_bits & ~denied;
+		if (maximal && is_owner && !owner_rights)
 			access_bits |= READ_CONTROL | WRITE_DAC |
 				FILE_READ_ATTRIBUTES | DELETE;
 		access_bits &= ~denied;
-		if ((raw_daccess & FILE_GENERIC_EXECUTE_LE) &&
+		if (maximal && (raw_daccess & FILE_GENERIC_EXECUTE_LE) &&
 		    S_ISREG(d_inode(path->dentry)->i_mode) &&
 		    (access_bits & GENERIC_READ_FLAGS) == GENERIC_READ_FLAGS)
 			access_bits |= FILE_EXECUTE;
-		granted = requested | access_bits;
+		/* An explicit request takes only ordered from this walk */
+		if (maximal)
+			granted = requested | access_bits;
+		else
+			access_bits = 0;
 	}
 
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
@@ -1615,6 +1645,10 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		if (!compare_sids(&sid_owner_rights, &ace->sid) &&
 		    !(ace->flags & INHERIT_ONLY_ACE))
 			or_ace = true;
+		if (!(ace->flags & INHERIT_ONLY_ACE) &&
+		    (smb_sid_in_group(&ace->sid) ||
+		     (is_owner && !compare_sids(&sid_owner_rights, &ace->sid))))
+			in_group = true;
 		if (!compare_sids(&sid_everyone, &ace->sid) ||
 		    !compare_sids(&sid_authusers, &ace->sid))
 			others_ace = ace;
@@ -1668,7 +1702,13 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			 */
 			if (is_owner && !or_ace)
 				allowed = READ_CONTROL | WRITE_DAC;
-			if (*pdaccess & FILE_MAXIMAL_ACCESS_LE)
+			/*
+			 * A group the caller is in, or OWNER RIGHTS for the
+			 * owner, gives what the DACL grants it in order.
+			 */
+			if (in_group)
+				allowed |= ordered;
+			if (maximal)
 				requested |= allowed;
 			if (!allowed || requested & ~allowed) {
 				ksmbd_debug(SMB, "Can't find corresponding sid\n");

base-commit: ffc855fe16afe02b22305111aa68cd8d07360941
-- 
2.47.3

