Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0A417D97
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222905; cv=none; b=ozlvC3cw5it0aKf4G1KpJLECbesD0rUAC7iza8vREQcO43lDepfM3sH/ScaCYlkXqM0uf4nICpVKM8QKQJTlUZH9bBCr1IdWrd0BYLKEJ4i4NInHDK1iSL/65PA3HITZPn6nykrcejT1nxh4jKwy73VuIhsRhvGLrbPozJoKzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222905; c=relaxed/simple;
	bh=rywtEF089uUo63OvRbNhpN9ISp4G11pvvdxEhmZwL1o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=raYl46gc+5ivwfsKROQubwzKj3GpNHrJgGhexWKypNipH+cRQ0NGDdza1wxMBj88r0cI/xr4WY44tBuA4rDt32tqA82njY6JL68clw96fmQROELnxuoSwqaX58WzUQ57mMtuoE0W3aIYr3vPjNgASuM6B/Tp0eXvSyn4te3yfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B60QagKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B60QagKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0D21F00A3A;
	Thu, 20 Aug 2026 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222899;
	bh=VDraI7CFxPKwnTn/AQcUgPMRAijXurkhvwdwULJpA7g=;
	h=Subject:To:Cc:From:Date;
	b=B60QagKLQ9U2EAF8RpaLe//IrOhEjUvQzUOKCwZt9Ojj5NETGfrv5MK2/vw1DRyIp
	 c4VQ8nramX5EFz4pusbZKVf8GYloMThVcGoN0QDt4oKL8i8cUzz0dAH+vHUjomitpH
	 KFfB2CznqifBIvJzFF584MyMc5aQ0oQrXP2Fy95Y=
Subject: FAILED: patch "[PATCH] selinux: reject a permission value exceeding the class" failed to apply to 6.12-stable tree
To: hexlabsecurity@proton.me,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:46:37 +0200
Message-ID: <2026082036-helper-starting-aa32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d14b5d0e97fccd27974fedc03b903408872907fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082036-helper-starting-aa32@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d14b5d0e97fccd27974fedc03b903408872907fd Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Mon, 27 Jul 2026 20:30:58 -0500
Subject: [PATCH] selinux: reject a permission value exceeding the class
 permission count

perm_read() bounds a permission value by SEL_VEC_MAX but never by the
nprim of the owning class or common, which is taken verbatim from the
policy image.  security_get_permissions() then writes perms[value - 1]
into an nprim-sized kcalloc() array, so a class declaring fewer
permissions than its largest permission value drives an out-of-bounds
heap write.  The top-level symbol tables are validated this way; the
nested per-class permission table is not.

Reject a permission whose value exceeds nprim, which is already set when
perm_read() runs.  Well-formed policies are unaffected.

Cc: stable@vger.kernel.org
Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: tweak comment for line length]
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ead504a639e3..5ff4d095ec2e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1175,6 +1175,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	rc = -EINVAL;
 	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
 		goto bad;
+	/* indexes an nprim-sized array in security_get_permissions() */
+	if (perdatum->value > s->nprim)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)

