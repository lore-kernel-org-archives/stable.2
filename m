Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DE40627F
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970500; cv=none; b=rGnzZcDvOyBWwGiEj9K/GuoxSXfvEyC+weE7YPSm849bMUeyWJrjFipHmHBzZH4Jj4Rjm1yV/wO/Avwzt9H+bS8pjN6Qg6Hn2ANGLwasJhhVhP/IfDstmYgWHwyKgNkS7hjeicvBnWSNbCD+qutOT9HBEfNrE4L1ftFCsSntG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970500; c=relaxed/simple;
	bh=kp3aRPj0yrJneSRrwqt3a3WCuPfKKaOvNaPQ5Y5IZvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFtCQIXS4N2QrpSlvI7ogcfCUPZ+qw5Vc99eKVEcMnN7yrv+DR46uhN/gC9oznWDY7g+zXa6+gwL66V/C8O1NOnbWkyRtPOJ0Df1Y2E16lEAWNcNuSXAeg7yywDosXmkq7aMWQm52NjVk2/a7OjOHuHRoRduLjD+AFbWfIPeJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ielnhv70; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ielnhv70"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-149241d04f5so312545c88.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790970493; x=1791575293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPRt5eKpQYZLRacEDFzRrkBIy6qGtNsmMHZIyJ1pN3M=;
        b=ielnhv70tVjzEww7gu5b20HMwHDwve7GJvTmo4fvmE2TE/d+9MgNulyrgrGLAVu7MF
         3qjCsZ7cKf1HFkis0ZsdLDASm7ojh7Wk9/JpxvyYpFtIYTP3hh39vWZlkbkpJv0Io4xo
         wy7iViem24RCN4OhuV4TzwGnmXR0JT9/0aPbAZfK1yoce2/HNQTUSdBbA3RUhFdtnOqj
         XxfZ3m0rWup+v5F+5rruH9s056DjW7TeSMCeT4yYOsoYj2+5yOFvdBWCecmxvNNjVqKt
         gACz9hKSFHX4rJT2zudE6TG3IpRnMn34/QfSXoYpGbwuzVk7mIiwModud6jhdHR+8c59
         QmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970493; x=1791575293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPRt5eKpQYZLRacEDFzRrkBIy6qGtNsmMHZIyJ1pN3M=;
        b=S6R7C9/BDEvMB5TGxz6rsBt5xZn1dT+XaI+2s8DSchsX8xaCX0p9r5I0yRyndhQrgQ
         Dg8F02SnaPjKwXs0RBZuA5pMUrcf8RzQ+jESt96oGQgnnqEP971FtUeuISirzRVSTDal
         EmDUYKZyGHfPR5YZDZvpqmV8CBd0D2WDQ7JhhGPog3PYV0TlQI/FImn0Q25Y6nlp2xy8
         UYYzlBakAwL2LAtAXEfgz0XRH3jWdGD3pM0l4B9GnehicC52o/V3PNC5qiKqjAH1rOy/
         z2r/3xVDxhudOhrwc0CBRho/OmPPi7TYpzXBDB6neAuddLCHCHwQo8R4vpNQpoNQEzwc
         YIBQ==
X-Gm-Message-State: AFuF++n4082mjNnrpLV9+A0eUNfXWJ7E+qjPopy1ewwUYAwkIFKXn52j
	ORHjIY9wRnmVj+sQZylfvGYohaMiN/1MijvUTL79ujOpnRPE/02zhplUGdqc/HX8avrXhWlFr1g
	Cz7EFd+DLqQ==
X-Gm-Gg: AYBFou1Iu1kRWygtIH+iDHXS+Qzozbjsgt4f68Rsgy7si+a7381bigxJq9BI2PhdPge
	qwTr+035COcn16Xs80RFtF/i9HKRL8GIkmatfhtNoTCoz47bjJpiBu3jdHQBphg8GLBZA+N1LPI
	9c/+rP/kpKyknNVEtlvRQbMMjFLuqs2clFgKsUoW4utMek5Ljwpl1Uml6lwSdfX3u/BUR6fgzXt
	VQGMW7n3QrxbS47VzoohaEN6atG+Ce8ckqufs82Fz0syxeRpue6LYGG/kDbXTG21FRiN6F0GvEO
	WwKTj8NTyHGXLSGgoHa5HbEKDts/c9ngTos4ihx3AFON6X2EjBm5eihytHDzW8xHdNh0TLXTIiO
	qcjNluimFyRmKQeXZ5MADjbHVIrwwS8MKkTRM/bHWD9/WT1bWs8fHrz6dctcJuZV27rye1CLxOD
	0cGD6EL4phEtnXT5/hX1H24ixm6EN2I7MAVyXWFBj1mcWSw2JazyAVq+IrWY0ewM/9kwxyKFm99
	YhK9SwlnsirElV1jho761/UdUztXfi7ug2HPMdxxaJaYAKXK3emP80tJzyvRFZFs7N7wMYY
X-Received: by 2002:a05:701b:221c:b0:14a:8cff:fbb8 with SMTP id a92af1059eb24-151c38b1453mr554659c88.28.1790970492218;
        Fri, 02 Oct 2026 12:48:12 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f97a5fsm12698196eec.15.2026.10.02.12.48.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:48:11 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Heming Zhao <heming.zhao@suse.com>
Subject: [PATCH 6.1.y] ocfs2: Avoid touching renamed directory if parent does not change
Date: Fri,  2 Oct 2026 15:48:06 -0400
Message-ID: <20261002194807.21118-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 9d618d19b29c2943527e3a43da0a35aea91062fc ]

The VFS will not be locking moved directory if its parent does not
change. Change ocfs2 rename code to avoid touching renamed directory if
its parent does not change as without locking that can corrupt the
filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and fs ocfs2 maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2023-52590. It avoids updating a renamed directory
without the VFS lock when its parent is unchanged.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The code change is identical to upstream.

Could you please queue it for 6.1.y?

CVE: CVE-2023-52590
Upstream: 9d618d19b29c2943527e3a43da0a35aea91062fc

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 fs/ocfs2/namei.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c97c6fdb8cec23..a4804694cf1fd5 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1345,7 +1345,7 @@ static int ocfs2_rename(struct user_namespace *mnt_userns,
 		goto bail;
 	}
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (S_ISDIR(old_inode->i_mode) && new_dir != old_dir) {
 		u64 old_inode_parent;
 
 		update_dot_dot = 1;
@@ -1362,8 +1362,7 @@ static int ocfs2_rename(struct user_namespace *mnt_userns,
 			goto bail;
 		}
 
-		if (!new_inode && new_dir != old_dir &&
-		    new_dir->i_nlink >= ocfs2_link_max(osb)) {
+		if (!new_inode && new_dir->i_nlink >= ocfs2_link_max(osb)) {
 			status = -EMLINK;
 			goto bail;
 		}
@@ -1606,6 +1605,9 @@ static int ocfs2_rename(struct user_namespace *mnt_userns,
 	if (update_dot_dot) {
 		status = ocfs2_update_entry(old_inode, handle,
 					    &old_inode_dot_dot_res, new_dir);
+	}
+
+	if (S_ISDIR(old_inode->i_mode)) {
 		drop_nlink(old_dir);
 		if (new_inode) {
 			drop_nlink(new_inode);
-- 
2.39.5

