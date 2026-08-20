Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04168416857
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222915; cv=none; b=kpO4rbgTGQyb1t0zouUUIcWbCUIzdrIeh4VHhhMS9kZe6OjxSY32Pqxyl3XY0g+0pEn516i1iU440CSARWNaCNANHqPRrI3j/XNzA/buy7jimT/VJ5H/BC4S2M3iUZxs3JDjAuwYkOQ5SlFfSQdEKzcryU4mgFsh/z2L6bcNXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222915; c=relaxed/simple;
	bh=K0Bv8dtw227+IZrvdCCEV9GWGyBaKaCc9aB+g/sl0cA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B/ha7HRIhSVwYQTfxfpFBOB0o2Jo+R0MZDDDmM3VHFStuf2N3stwYjWhX+j9yI9O+891+DvER+BJYVHnUtsxbwVJzn+kfzRoMAEuRe0a40Iij7p32Sy6OWQYRS64+sQYZTBzLnMiCKoP3Q0YYbLoeVgv8MC1u6ClpKrl5gLMhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tr9M1xPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tr9M1xPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AE41F000E9;
	Thu, 20 Aug 2026 10:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222913;
	bh=4qIB1oJq/lIuteM3mp9mN4Qpr0xplwf6k5iE6UsjRM8=;
	h=Subject:To:Cc:From:Date;
	b=Tr9M1xPEF8Zc2eKwTDa676ck7w1Z6x9SMuT6Hk1lGIBbv4+Gyd4IlLMUg4wioGGUE
	 yWpAy0RV1Mz0RwjLV6+c2gX8rkZNSlVw5TzaOX+CjnNXvWhCNNNi/WYb6oQQGXIY4u
	 02XqjxsM0CtzzK7/3MOS837PfqMEE5cp4fxqrOyA=
Subject: FAILED: patch "[PATCH] selinux: reject a permission value exceeding the class" failed to apply to 5.10-stable tree
To: hexlabsecurity@proton.me,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:46:39 +0200
Message-ID: <2026082039-vindicate-eel-90a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d14b5d0e97fccd27974fedc03b903408872907fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082039-vindicate-eel-90a8@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

