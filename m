Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802977;
	b=vmF0wU4Q4sOJTkcKZqRI16ArkrCIQn3Rd8jE0FnolWpP1Kh6qP8I0AY5Pmlfqq9RYSWP
	 tSI6YAXp1rFCv67PF3LkOIfldrLg2E7uGImkohLYl8fFlgRNs5UC24SHNBxWMErROpmYt
	 EpjA1AD8CgGDa3PEJJ7GqGXtUIx2b17Rv+Uz4MFM2YiL0f6acn1qUzFKRMw5xPKzMlrcQ
	 uY2pMk3zWZSUCcuNYr/zf30xQNDUtifhidUJG3NY/V6JaRmSMOk8V0LhwonrkzltODUgC
	 fLFfCm3afcRTkpyY7MNusUCO6swZDQJbNWs7il30DdTDI5KSEMU/X8qNaYcrFb1AoYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802977;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LSyuf8/r1VgQbKvGUo3ALhynlWRjFGCRqRJJmb+CQiw=;
	b=Z+iXwLv3bB+5Yxa1Zzby7XjqLkVb+DZOff2R0/rzOhU+6+64rDHJLeWHzvJJwMiuaL98
	 1+jhi2b13XZhb5NKtfjV6sUOe9u3Yjg+vOjJcCDIBVGaSIB2UDKVqCCOmg1eYMLa0E/Lp
	 5aCnJ6Krs1QJCX6AAMasPtcO2NW7/HmiRFwCvBe6rZfJzoCt4TJc7pCZJhXfBnhdyJkBU
	 zO3hgCf2TywPcOqKRg5s9Rie7+QoYtBBXwNxEHaGew37bn568aaSaAtRZKgWJdTOrP3ft
	 5GMQLAkZlGR5bXpVJc0JjGs8jbTNuP4to3HMSbwU4O9dGaUzWN0jn2xbWSaFbg+BHgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oaVeT25C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE20606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oaVeT25C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A5D1F00919;
	Wed,  4 Nov 2026 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802976;
	bh=LSyuf8/r1VgQbKvGUo3ALhynlWRjFGCRqRJJmb+CQiw=;
	h=Subject:To:Cc:From:Date;
	b=oaVeT25CD2wmaYR4iPf5+XlpBmeMtEvNdba1ufZD7n/Sh3tmXuqmg3uUSNgysAZEq
	 u/+l1q+eJXlQMXwFnjeSS6HdmpW2PTMLUTB90zd53QM1RnXvXeSUl6BNUjQgo/0y2T
	 t4h4Hw6J7csgg3y5vudDgXjoC8vh1Xrd0wYQOafI=
Subject: FAILED: patch "[PATCH] ovl: do not copy up a dentry that was removed" failed to apply to 5.10-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:36:09 +0100
Message-ID: <2026110409-shorts-resilient-2f0f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x f635192ad223d2009ee640b63adf5ce3198aa338
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110409-shorts-resilient-2f0f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f635192ad223d2009ee640b63adf5ce3198aa338 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 11:00:06 +0000
Subject: [PATCH] ovl: do not copy up a dentry that was removed

A change to a removed file through an open descriptor replaces whatever
has its old name in the upper layer.

Copy up must only create a name in the upper directory, never replace
one. After an unlink, an rmdir or a rename over a lower dentry, a
dentry that an open file keeps alive still has its old parent and name,
but in the upper directory that name is now a whiteout or a new object.
ovl_copy_up_workdir() renames the copy over it, which brings back the
removed object and destroys whatever took its name.

An unprivileged user opened a lower FIFO and unlinked it, root created
a file at that name, and fchmod on the old descriptor replaced the file
of root with the FIFO.

Fix this by looking up the target name of the rename in
ovl_copy_up_workdir() with LOOKUP_EXCL, so that copy up fails with
-EEXIST if the name is taken, as copy up with O_TMPFILE already does
when it links the copy to the name.

Fixes: e9be9d5e76e3 ("overlay filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use LOOKUP_EXCL instead of relying on d_unhashed()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 12000e45fefc..286978d47ef7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -793,9 +793,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	rd.old_parent = c->workdir;
 	rd.new_parent = c->destdir;
 	rd.flags = 0;
-	err = start_renaming_dentry(&rd, 0, temp,
+	/* The name may have been taken since lookup, never replace it */
+	err = start_renaming_dentry(&rd, LOOKUP_EXCL, temp,
 				    &QSTR_LEN(c->destname.name, c->destname.len));
-	if (err) {
+	if (err && err != -EEXIST) {
 		/* temp or workdir moved underneath us? map to -EIO */
 		err = -EIO;
 	}

