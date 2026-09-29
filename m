Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE85187D3
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682679; cv=none; b=C7F8d765vkc51LWzfXgJe3iqHlAj+veMSvPfEjs/VBMc/Cdw6FsN8+9UVjGYHuApEU+NMg+CzzgfFpYafQ/GkMp8iFoEhbvZONLSHyXqogT088LTE5uBohoxd7T0yGhqHT3PiKm+du8lHaz/mWXg3D1iplcWOMwhM0XAfN90dPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682679; c=relaxed/simple;
	bh=uAHi1qOUp+OZPCXyN/9xoYWXaRpm7WmYGa24zkQhRdk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iaqJhNgw5FtIcpe5STQ1kNCg1mSSj+DpggKQBXFlxczO9M3dhUQyJuXRevgKSZX6lddbdSseqrKenqao/vWR/HuTptzuRX3srUWoNNXY/U5+cpd0PlMZ2WRcR8l5h/QIbYh5JpMrgVdSmFkcNqVeloYHevaa+/puoHRmWf+oSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=atSSz3kC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="atSSz3kC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018D91F000FF;
	Tue, 29 Sep 2026 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682677;
	bh=u8qb3teyLLuocjRq+E6uS8Q4tMxpljU5Ky0Nfhom9JE=;
	h=Subject:To:Cc:From:Date;
	b=atSSz3kCoUJON9EoQpAU/7zm+jVoRhIp9ZpVKMmlOkHjK48RlDutIzq89LclwbjdM
	 z92COKqt31UkrINvrjbVhc1XHzuFpM1XLB4AFMulVPAujfjPUv6646Eqqime7ebpGD
	 ou/DnyNe1XB2vFIEKY4e0IT7mnhNZKJMuTKz/NTY=
Subject: FAILED: patch "[PATCH] smb: client: clean up failed cached directory opens" failed to apply to 5.10-stable tree
To: zihanx@nebusec.ai,pc@manguebit.org,root@tr0jan.top,sorenson@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:51:03 +0200
Message-ID: <2026092903-carrousel-elevate-94c7@gregkh>
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
git cherry-pick -x d2ff5fb93ea83034025850266b5eed391f96b825
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092903-carrousel-elevate-94c7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2ff5fb93ea83034025850266b5eed391f96b825 Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Wed, 16 Sep 2026 15:29:27 +0000
Subject: [PATCH] smb: client: clean up failed cached directory opens

open_cached_dir() sends CREATE and QUERY_INFO as a compound request. If
the CREATE succeeds but a later command returns an error, the function
must retain the CREATE FID so common cleanup can issue SMB2_close(). It
also must not treat a response error as a valid CREATE.

Validate the CREATE response before using its fields, record the FIDs, and
mark the handle open before handling errors from later compound commands.
Move the -EREMCHG reconnect handling before response validation so a
missing response does not hide the reconnect request. Count the handle
when it is marked open; confirmed close responses decrement the counter,
while existing close retry behavior remains best effort on transport
failures.

Fixes: b0f6df737a1c ("cifs: cache FILE_ALL_INFO for the shared root handle")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 88d5e9a32f28..647fa26da4d2 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -8,6 +8,7 @@
 #include <linux/namei.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "../common/smb2status.h"
 #include "cifs_debug.h"
 #include "smb2proto.h"
 #include "cached_dir.h"
@@ -323,25 +324,37 @@ replay_again:
 	rc = compound_send_recv(xid, ses, server,
 				flags, 2, rqst,
 				resp_buftype, rsp_iov);
-	if (rc) {
-		if (rc == -EREMCHG) {
-			tcon->need_reconnect = true;
-			pr_warn_once("server share %s deleted\n",
-				     tcon->tree_name);
-		}
+	if (rc == -EREMCHG) {
+		tcon->need_reconnect = true;
+		pr_warn_once("server share %s deleted\n",
+			     tcon->tree_name);
+	}
+
+	if (!rsp_iov[0].iov_base || rsp_iov[0].iov_len < sizeof(*o_rsp)) {
+		if (!rc)
+			rc = -EIO;
 		goto oshr_free;
 	}
-	cfid->is_open = true;
-
-	spin_lock(&cfids->cfid_list_lock);
 
 	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
+	if (o_rsp->hdr.Status != STATUS_SUCCESS) {
+		if (!rc)
+			rc = -EIO;
+		goto oshr_free;
+	}
+
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
 #ifdef CONFIG_CIFS_DEBUG2
 	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
+	cfid->is_open = true;
+	atomic_inc(&tcon->num_remote_opens);
 
+	if (rc)
+		goto oshr_free;
+
+	spin_lock(&cfids->cfid_list_lock);
 
 	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE) {
 		spin_unlock(&cfids->cfid_list_lock);
@@ -408,7 +421,6 @@ out:
 		close_cached_dir(cfid);
 	} else {
 		*ret_cfid = cfid;
-		atomic_inc(&tcon->num_remote_opens);
 	}
 	kfree(utf16_path);
 

