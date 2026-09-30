Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EE4FDA65;
	Wed, 30 Sep 2026 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775171; cv=none; b=eW/9CZZ6R0F+nXNX2xh/T4ijsVqfrVBVxq4QndRr72XPAdjT3Rm23YkQBBnUK+LgJFs39x7ZJ7qgTo3Jqz+Ir1GuVoBlWd1YthaiUHzCetMqBjxR+QTpAyX+0r7gS3ZBnyiWXuNWT0Dq0MyIxG+3VyRGqhfFQGK7UR2xLuryaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775171; c=relaxed/simple;
	bh=aLAt3O000c+HgzM4kEJcEbm6sHc2kmKlwquloW5nlhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PC1kixyGn5ayTcTjsH0AxTpPevqQUVrBM8YwZC8l1pT6Df9DRScUn3anN/tS+G99IiVWvP/zxE5/D975tUfEoV7zjffvvliZ5W4r74IxwCXvSOoQfqppHkpvGQnaSsI09AUIlpoUTN0BhmM7V8GUHaWD/Xim+K3iYs2tl+UQrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kypbNAEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kypbNAEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1204B1F00899;
	Wed, 30 Sep 2026 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775163;
	bh=bJfaNU1C8Yzvj+zzG4aPnzlR5aml+D+FHeWud95ZDJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kypbNAEErueQjTZRCaiuFOYQUz3e3KNJ3MdTbkKwCkj3nL3GPx0vA5dC7EtCs8VCf
	 PaKF+8qlB85KhHuYnCgsnaLz/8jxD7fcQGDC0hHVUiE3LtPj25LMddpdRXuCk7pcK1
	 6qaw9iCeC/r4Cv2ZE07BixqOZa5o6l4kPIQ9nKr7pkIwc8g+2ECVP5wnORUo2ldj/x
	 4lwuvUrOQdvu+sJEeto2buPOiGGYQT/tZ65GO/jIqX/Vx9fC7+EK1Ogwc8nIfrnBmU
	 MOJ2ivUQgpoCOGq/UOemgNScMrdUBZ9pZDT0NDq6UZ+APHy2Ul//y14NPER7reHi0E
	 EnyK+ADM5p+tQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:06 +0200
Subject: [PATCH 14/17] fsnotify: detach the connector before destroying its
 marks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3181; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aLAt3O000c+HgzM4kEJcEbm6sHc2kmKlwquloW5nlhw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5fevtXht9JbHebKqhNuTYtdH2qv+Jju80v9Qs//Rf
 5miG1f9O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy1pjhv8+0N2q7v78X2nT8
 5f9/rs5J2ovvnv3w6sbs23OKOKP+qjxm+F+gfiYrImJF72WV/1s3m2yXXMqj637q45T7C7e05fe
 tM2cFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

fsnotify_destroy_marks() removes every mark of an object that goes away.
It walks the mark list of the connector and has to drop the connector
lock around fsnotify_destroy_mark() since that sleeps. Afterwards it
continues from the mark it just destroyed. That mark stays on the list
because the function holds a reference to it. But while the lock is
dropped fsnotify_add_mark_list() can add a mark to the very same
connector and put it in front of the current one when group priority
dictates. fsnotify_grab_connector() hands out the connector until it is
detached and it only gets detached after the walk.

So the walk never sees that mark. The connector is detached from the
object with the new mark still attached to it. It never receives an
event nor IN_IGNORED. For inotify that's a watch descriptor that never
reports anything and doesn't show up in fdinfo either:

  wd1 = inotify_add_watch(/proc/self/fd/6) = 2
  events after the unlink:
    wd 1 mask 0x400 IN_DELETE_SELF
    wd 1 mask 0x8000 IN_IGNORED
  events after write() to the file:
    (none)

Detach the connector from the object before the marks are destroyed.
fsnotify_grab_connector() refuses a detached connector so a mark added
from then on gets a connector of its own. Nothing during the destruction
needs the connector. The inode reference of the connector is dropped
after the marks are gone as before.

Fixes: 6b3f05d24d35 ("fsnotify: Detach mark from object list when last reference is dropped")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/notify/mark.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index b2640d836a71..f6891d39e42f 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -1112,6 +1112,16 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 	conn = fsnotify_grab_connector(connp);
 	if (!conn)
 		return;
+	/*
+	 * Detach the connector from the object first. Once conn->lock is
+	 * dropped a mark could be added in front of the one we're at and the
+	 * walk would miss it. fsnotify_grab_connector() refuses a detached
+	 * connector so any mark added from now on gets a connector of its
+	 * own. This also stops pinning the inode until all mark references
+	 * get dropped. It would lead to strange results such as delaying
+	 * inode deletion or blocking unmount.
+	 */
+	objp = fsnotify_detach_connector_from_object(conn, &type);
 	/*
 	 * We have to be careful since we can race with e.g.
 	 * fsnotify_clear_marks_by_group() and once we drop the conn->lock, the
@@ -1128,12 +1138,6 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 		fsnotify_destroy_mark(mark, mark->group);
 		spin_lock(&conn->lock);
 	}
-	/*
-	 * Detach list from object now so that we don't pin inode until all
-	 * mark references get dropped. It would lead to strange results such
-	 * as delaying inode deletion or blocking unmount.
-	 */
-	objp = fsnotify_detach_connector_from_object(conn, &type);
 	spin_unlock(&conn->lock);
 	if (old_mark)
 		fsnotify_put_mark(old_mark);

-- 
2.53.0

