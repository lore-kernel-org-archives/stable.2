Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E227874F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560773; cv=none; b=KXIIQ3NDUTSMwaE8KtY/kPoo90k6wvllTtPCinW8FKXlh/wI91H5Wj5aSlFx5695XqzN8fv6EKDONGC5cLORAsnPZiuDcLtx1C3SEFQ4qUhtHi/Z+A4sYSv2Fv5miariBt3w7jbcPIhKnfyEUMRAQZvFDeDDCNH5vZ5pUCYsf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560773; c=relaxed/simple;
	bh=hN26Qab+nDTmWW8xJS8DO6OsWm2ciC5mIIzcfN6PytY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lxkxzsm3lHQxo1yH212FmfcGaHpAR6V1QUuY03VgDiV7endCT7+u403LPvxSuTiUBWpUEIzgHk/kgWM3k8ly9GpmCyVn707WCmXazsI3WUTlF1P/qEFkZzctHz//Rh6t/ktAs4njEi809H/BusSDI7ONJYHmQK5F/902EtxUWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C1ysplEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C1ysplEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258391F000E9;
	Mon, 20 Jul 2026 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560772;
	bh=umPZCrubznqdAZTvFhwyNp+NIkOYF+8H9WULwaJCTPA=;
	h=Subject:To:Cc:From:Date;
	b=C1ysplEq421d/DUzG1xYjV7X0cKgg2p4iD8GSUg68MmWmeQvqwtns/9hnRDPqmMu6
	 77x3+kfwU84obAq+6P1NwY5Iax8RGRHX00GTOmB15Ov3goBvBkAVYu1k5uB3Goes8w
	 cXVDyOoOUo0RrMKWZWh1U/ay72I1iRrZJMK8mj2s=
Subject: FAILED: patch "[PATCH] dm-verity: fix buffer overflow in FEC calculation" failed to apply to 5.15-stable tree
To: mpatocka@redhat.com,samitolvanen@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:19:06 +0200
Message-ID: <2026072006-geometry-exhale-420b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 31d6e6c0ba8d5a7bd59660035a089307100c5e8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072006-geometry-exhale-420b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 31d6e6c0ba8d5a7bd59660035a089307100c5e8e Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 1 Jul 2026 18:13:50 +0200
Subject: [PATCH] dm-verity: fix buffer overflow in FEC calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There's a buffer overflow in dm-verity-fec:

if (neras && *neras <= v->fec->roots)
	fio->erasures[(*neras)++] = i;

This allows *neras to reach roots + 1 (the post-increment pushes it past
roots). This value is then passed as no_eras to decode_rs8(). Inside the
RS decoder (lib/reed_solomon/decode_rs.c:113-121), the erasure locator
polynomial loop writes lambda[j] where j can reach nroots + 1 — one
element past the end of lambda[] (which is sized nroots + 1, valid
indices 0..nroots). The out-of-bounds write lands on syn[0], corrupting
the syndrome buffer.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Cc: stable@vger.kernel.org
Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 85ad9dc210ff..c79f60df3a90 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -220,7 +220,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 				     PTR_ERR(bbuf));
 
 			/* assume the block is corrupted */
-			if (neras && *neras <= v->fec->roots)
+			if (neras && *neras < v->fec->roots)
 				fio->erasures[(*neras)++] = i;
 
 			continue;
@@ -238,7 +238,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 			 * skip if we have already found the theoretical
 			 * maximum number (i.e. fec->roots) of erasures
 			 */
-			if (neras && *neras <= v->fec->roots &&
+			if (neras && *neras < v->fec->roots &&
 			    fec_is_erasure(v, io, want_digest, bbuf))
 				fio->erasures[(*neras)++] = i;
 		}
diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
index 50b5e187d5cc..3885b514fc23 100644
--- a/drivers/md/dm-verity-fec.h
+++ b/drivers/md/dm-verity-fec.h
@@ -47,7 +47,7 @@ struct dm_verity_fec {
 /* per-bio data */
 struct dm_verity_fec_io {
 	struct rs_control *rs;	/* Reed-Solomon state */
-	int erasures[DM_VERITY_FEC_MAX_ROOTS + 1]; /* erasures for decode_rs8 */
+	int erasures[DM_VERITY_FEC_MAX_ROOTS]; /* erasures for decode_rs8 */
 	u8 *output;		/* buffer for corrected output */
 	unsigned int level;		/* recursion level */
 	unsigned int nbufs;		/* number of buffers allocated */

