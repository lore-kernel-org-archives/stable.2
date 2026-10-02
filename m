Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D494AB1D0;
	Fri,  2 Oct 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949242; cv=none; b=p4sU2SfD/w6Zn5hPllIdWmgga3E8Pt5sHFs+8xvPFpO68z33arHmhDW2cOXDCLicUMS18VQfgngrJN6nDBa9X6qj3gcTZBPXBmsaoKUH0L2Nnu32azzFJo7zUxDQQBHhDaBMj5uA4SOhXziZs2qrAArWl7eIL5NiYAieVyWImFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949242; c=relaxed/simple;
	bh=vZIhlv7pCpySoAEeceHzRrXkzwDWntzhpUfoYx1Wy+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUpgclVemZiVsJLlZ/7bo61lB+TYqyMjLjBT3MH799vBI03rMR/xBVOG0XVqV6HeQbH4iNrD330WZouLRhpUJM+CfKh6HkyNS3fFEYup6fmo70X2FjwWxNh/fofrMz0dTObXlh0rR6NtsGSjlJqSzRaL3AM/VDydw/YSCBE8adc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTuKesJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTuKesJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2ED1F000FF;
	Fri,  2 Oct 2026 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949238;
	bh=msAVOiuplmy7Etjdh68LB6lCGbD8VtrETdMeI+dVVr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CTuKesJ2A1idVnBEkDXVgblt3Y0WJIdQ1qnAfh3au64+QnGnGO2S/Bohw+fsto4Ws
	 sssXWaZfJAoi3nYUOeVAlxjUZM7BOWY5h/hKpnjNg0QM3bZRiWPjmlgbbD8BA5YGuW
	 k/EXsjE8f/MIbPptlP1bU+p6viOl/BVsSS0O+ajcbKiPGoW41Z/KjLE287mhQfj8nk
	 DunivsjsaQpAY3SGFdlBgNWYCDP4sJbhLPrKaq7xhXyL23Nz5I0WeyvLzguELm5xVF
	 sY1rOPVBvM37pi6xrkxZxp3STijgVXJevyDFV56Tmk/m6HYUxn7Q2cQ0TBerg4uNYk
	 EIikkRqjKrAxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:40 +0200
Subject: [PATCH 09/21] namespace: keep the lock on a mount that a
 propagated copy is moved beneath
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-9-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3036; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vZIhlv7pCpySoAEeceHzRrXkzwDWntzhpUfoYx1Wy+A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x5pYbzmzqapl5Lbb/+wi1X+m/y69/Jyt7m/GDYej
 MmNlJjg1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR1C+MDH3OGfXcaRGX5Jb0
 ZGqsaosMi3qmqKMS67HqRtb/4IQtMQz//b9Z6d64nGh7essTxQqJD8t/i967fLI8Uc/GcILkPO0
 0DgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

attach_recursive_mnt() transfers MNT_LOCKED from the top mount to the
mount that is moved beneath it with MOVE_MOUNT_BENEATH. This allows the
owner of a user namespace to replace its locked /proc or its root. The
mount beneath takes on the job of covering the underlying mountpoint
allowing the top mount to be unmounted.

Consider two mount namespaces:

(H) The host H has a shared mount P with a secret in P/d
(Z) Z is a user namespace made from M. Its copy of P receives
    propagation from the host's P and its copy of M's cover on P/d is
    locked Z's owner must not get to see P/d.

Now (H) mounts X on P/d. This propagates into (Z). The copy of X lands
beneath (Z)'s locked cover. The locked property is transfered from (Z)'s
cover to the copy of X propagated beneath it. The cover is now unlocked.

Now (H) unmounts X again. The copy of X in (Z) gets unmounted and the
covering mount is left unlocked on top of P/d. (Z) can now unmount it:

    Z: umount2(P/d)             = EINVAL            /* the cover is locked */
    H: mount X on P/d, umount X                     /* both propagate into Z /*
    Z: umount2(P/d)             = 0                 /* the cover is now unlocked */
    Z: read P/d/secret          = "covered-by-root" /* secret revealed */

So only transfer the locked property to the mount beneath for mounts the
caller has placed. A propagated copy that lands beneath a locked mount
is locked as well so that the mount at the bottom of the stack carries a
lock the way every check expects. The mount on top of it remains locked
to ensure that it keeps covering even if the propagated mount is
unmounted again.

Fixes: c62a4766937e ("move_mount: transfer MNT_LOCKED")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e74e63466c24..bb0183ec2aaf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2712,15 +2712,17 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			/*
 			 * If @q was locked it was meant to hide
 			 * whatever was under it. Let @child take over
-			 * that job and lock it, then we can unlock @q.
-			 * That'll allow another namespace to shed @q
-			 * and reveal @child. Clearly, that mounter
-			 * consented to this by not severing the mount
-			 * relationship. Otherwise, what's the point.
+			 * that job and lock it. If @child is the mount
+			 * the caller placed we can then unlock @q:
+			 * nothing another namespace does removes it
+			 * again. A propagated copy goes away when the
+			 * mounter of the original unmounts it, so @q
+			 * keeps its lock.
 			 */
 			if (IS_MNT_LOCKED(q)) {
 				child->mnt.mnt_flags |= MNT_LOCKED;
-				q->mnt.mnt_flags &= ~MNT_LOCKED;
+				if (child == source_mnt)
+					q->mnt.mnt_flags &= ~MNT_LOCKED;
 			}
 			mnt_change_mountpoint(r, mp, q);
 		}

-- 
2.53.0

