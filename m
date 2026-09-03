Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3F4AE120
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439676; cv=none; b=Xnrv0Qh+XOGFWysO9Cw7P+muGNUX2xYLEznrFBoSIfOKJYAINNJcT7sG95QD4/+u48C4lyVKFfSWiTwwHjwmxgtk39hNtFQ2g96Z52uBfAHw4/JE6xUI7nJhOabCPx2WKUejvvFz2TefNjp9sGK7b09gFIrO34OwCbd/8pqKloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439676; c=relaxed/simple;
	bh=9CYfaFqawJ59zyzMJ6bALbjV3fkclXLC3RjOzxQ9QXk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jImWRAeuUvLS1Fw2JmuPPseU0yw3jQYS8HJ32dFfdD9i8vu45xExLy2fZIIYN4ALyVxhsok0EKKQGx+juUkySsBztMup49tS22dPLRikPpujGvduO8ua7NwDNjDquKErlhq/XrhaeJen15b7liyegqJzZ39Te82qdFpwsmeTXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQtmu3uD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CQtmu3uD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48A41F000E9;
	Thu,  3 Sep 2026 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439674;
	bh=PLLLrBcgNc3jBxSytgv61qVjUYdNPeXFXX8ttr6Ubvk=;
	h=Subject:To:Cc:From:Date;
	b=CQtmu3uDYOseH5AOMLcuY5H5RYb9hFoCkWncvplHiQJzLn5XoZRM2HPSE+Iw+cYkF
	 Oh7hcVD1BABIpJKUhzT8spYshOI9Cnt13NNLHuLvq9lqwaTYImnri8KDs3kEh6wiJV
	 50syWwHdXbsxOPPZ6lIT9ZvFvnB4NCB0HjzINcDE=
Subject: FAILED: patch "[PATCH] apparmor: fix out-of-bounds write when null terminating a" failed to apply to 5.15-stable tree
To: imv4bel@gmail.com,john.johansen@canonical.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 13:07:22 +0200
Message-ID: <2026090322-bloated-rerun-fcbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9f1e40193eef7f047e6b77cfb4b4cafdecd7a123
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090322-bloated-rerun-fcbb@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f1e40193eef7f047e6b77cfb4b4cafdecd7a123 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Mon, 10 Aug 2026 18:51:33 +0900
Subject: [PATCH] apparmor: fix out-of-bounds write when null terminating a
 label vec

aa_vec_unique() null terminates at vec[n - dups] when VEC_FLAG_TERMINATE
is passed. If the components are all distinct no duplicates are dropped,
dups is 0 and the terminator goes to vec[n], so the caller has to provide
room for n + 1 entries.

aa_label_strn_parse() sets up its vector with vec_setup(profile, vec, len,
gfp) and then calls aa_vec_unique(vec, len, VEC_FLAG_TERMINATE), but
vec_setup() does not reserve the terminator entry. Up to LOCAL_VEC_ENTRIES
it uses the local array of LOCAL_VEC_ENTRIES pointers, above that it
allocates exactly len pointers. The terminator therefore lands one entry
past the end of the local array when len is LOCAL_VEC_ENTRIES, and one
entry past the end of the allocation when len is larger.

len comes from the number of "//&" separated components in the label name
and label_count_strn_entries() does not bound it. An unprivileged task
reaches the parse by writing to /proc/self/attr/apparmor/current or through
lsm_set_self_attr(2), both of which go through do_setattr(), and the name
is parsed before the change_profile permission is checked.
The query_label() path behind the securityfs .access file, which is
mode 0666, performs no permission check at all. Every component has to
resolve to a loaded profile, so a system with policy loaded is required.

The other two VEC_FLAG_TERMINATE users work on a label vec that
aa_label_alloc() has already sized with "+ 1 for null terminator entry on
vec". Reserve the same entry in vec_setup() and DEFINE_VEC(). Passing
len + 1 from the caller instead would move len == LOCAL_VEC_ENTRIES out of
the local array and into kzalloc().

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index b5a722a47fd2..37cb135de323 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -23,7 +23,7 @@ struct aa_ruleset;
 
 #define LOCAL_VEC_ENTRIES 8
 #define DEFINE_VEC(T, V)						\
-	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES];	\
+	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES + 1];	\
 	struct aa_ ## T **(V)
 
 #define vec_setup(T, V, N, GFP)						\
@@ -31,10 +31,10 @@ struct aa_ruleset;
 	if ((N) <= LOCAL_VEC_ENTRIES) {					\
 		typeof(N) i;						\
 		(V) = (_ ## V ## _localtmp);				\
-		for (i = 0; i < (N); i++)				\
+		for (i = 0; i <= (N); i++)				\
 			(V)[i] = NULL;					\
 	} else								\
-		(V) = kzalloc(sizeof(struct aa_ ## T *) * (N), (GFP));	\
+		(V) = kzalloc_objs(struct aa_ ## T *, (N) + 1, (GFP));	\
 	(V) ? 0 : -ENOMEM;						\
 })
 

