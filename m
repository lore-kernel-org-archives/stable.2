Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95F46AA9F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947227; cv=none; b=HkvwuF91pEACJC8l0ELgjKZnhipw5szwVjX43Jdh17boo5omIfKWJPe7jm9Bc95bMRc2RdD4kbboz+xKU2N0xBgF1XWVjm/Adw+uHJoC714ovxcc8dybctoo4zupnVyBmVlF6+XoaiV6mbciMaGMvv4qgwgjjr3y1wdy/gZLnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947227; c=relaxed/simple;
	bh=Hb+1HHSESpBcgvWo3QuqeYWWcdGm+FsfgjmAnYX8NDw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PggkbjYywvVN1BV5/Gtv7gOcPhKM16LIYKw+PdWE8WEZs1UPYqMjfUgr1V6q+NSOMdv1mwT6dh5xg7k3/ziOEW1JMyXdFjlgGAXJr4nJ7GiAHZvCFRi6ekwULAt13lwUjH9vSsBPWo0P1sndOyTjEe6yYxIgv3UNK2yLNfgVb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oWKEz6ER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oWKEz6ER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68361F00A3A;
	Wed,  9 Sep 2026 09:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947225;
	bh=Vk+7Vyr+CN42pe9AOxIZ/2ENDY1Jw+OImcEigrDVWdw=;
	h=Subject:To:Cc:From:Date;
	b=oWKEz6ERcgYuC4Sxgw90PlO+/ser78hW3TRDb05yl+EBaZ3MXZE8gXyH8h6dv2GIB
	 7hYlbO6UaeXmvzVlcgGPGKOmt7lMZD4z2OR6m2hvjSJAaolWKTNd+ATZXoB2l4zvTw
	 r1qrj4c3w7axFZFMZhsspYWpBF3K605i8ox43I3I=
Subject: FAILED: patch "[PATCH] accel/amdxdna: return early from a zero-length flush" failed to apply to 6.18-stable tree
To: taimuraz@kaitmazov.com,lizhi.hou@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:42:59 +0200
Message-ID: <2026090959-anyhow-crinkly-25f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x dc14753664240cedf669623b27ae9922b0618b25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090959-anyhow-crinkly-25f7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc14753664240cedf669623b27ae9922b0618b25 Mon Sep 17 00:00:00 2001
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Date: Tue, 18 Aug 2026 02:06:55 +0300
Subject: [PATCH] accel/amdxdna: return early from a zero-length flush

SYNC_BO does not constrain its size, so a request for zero bytes reaches
drm_clflush_virt_range(), which ends with an unconditional
clflushopt(end - 1). For an empty range that is the byte before the
mapping, and abo->mem.kva comes from vmap(), so the access lands in the
guard page below the vmalloc area and faults:

  BUG: unable to handle page fault for address: ffffd16fbbc70fff
  #PF: supervisor read access in kernel mode
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 7 UID: 1000 Comm: sync_bo_probe
  RIP: 0010:drm_clflush_virt_range+0x3c/0x70
  Call Trace:
   amdxdna_drm_sync_bo_ioctl+0x124/0x430 [amdxdna]
   drm_ioctl+0x301/0x4c0
   __x64_sys_ioctl+0x115/0x2f0
   do_syscall_64+0xa6/0x3d0

Any process that can open the render node can do this. Reproduced 3 of 3
times on a Strix Point NPU (1022:17f0), by calling SYNC_BO with size 0 on
an AMDXDNA_BO_SHARE object. The import arm takes the same request but
flushes the whole scatterlist, so it survives it.

Nothing needs flushing for an empty range, so answer before choosing a
path.

Fixes: e252e3f3488a ("accel/amdxdna: Revise device bo creation and free")
Cc: stable@vger.kernel.org
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260817230655.356785-1-taimuraz@kaitmazov.com

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1c63eff0a4a8..2a16de96e6a4 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1247,6 +1247,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
 		return -EINVAL;
 
 	size = min(abo->mem.size, end) - offset;
+	if (!size)
+		return 0;
+
 	if (is_import_bo(abo))
 		drm_clflush_sg(abo->base.sgt);
 	else if (amdxdna_gem_vmap(abo))

