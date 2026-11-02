Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633417;
	b=VHpNjE9k/vKRr55LnlO8QcPqEt/NPWN2XkxKYktFv0EYN7bZ841sJESxxJYbb8yPQBKZ
	 ij9E0bjimFYYDsiL7cbq6qs82FEAlF9H+bO4m+uRsV44OvCxmHpa0I1jlLxNHKLUoU7pW
	 gs84dRiedMa8fcJoyY9TCDQNUJlCTW2X66i6a+08ENNQDOXs04tgPwZPy48yMGC4rLNln
	 EUBDq0KPgAxU8H9nCsoZmx8J1RJ1ofadgusz9LUJVj75nOfipXCMFVopcdHugisXRqkPJ
	 7/ChEvvypazKLN9NcBBkPj9Q9iESIrr2ZSKb5ZqI7ZWOsd8GEArs3BXw17Kv9mWehDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633417;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ovQbiBMowuHc6t0NcUDHhlEujtquP5qv5Wxv/1+6JzM=;
	b=gdaroP1fN8gSWZIP7QuiitaAsLZ6BytMgZQwlJBsz26shbUsx6XopLY8V2WKMZDqKns+
	 zc1ElDjbbotIJq4iwIz1b5Br//epZsRBJGUxA/lhT1tMjjAUj7Yqf1Q0sGbo1JAKmf4T6
	 4rb2EiVpNLmLygvBbKoNKw9CiA61btFxkBDrI7Qo2TqyBuwEHWQ+YbZ6crOY6xMANcFmb
	 +p1z3OdhdsdMWztwM08lx/qcGmnUmoC97LCOn6B8WEavWf00ZdFgUdOSSMoSVSZwC3xyT
	 cS72Tm+CXTd95SOM8qOcMZqWDhsrE4cozU+gDedEShWo9WffeQZCngwzrFG+9HBNUxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rwfn3gtC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D0606AE86
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rwfn3gtC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E5B1F00A16;
	Mon,  2 Nov 2026 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793633416;
	bh=ovQbiBMowuHc6t0NcUDHhlEujtquP5qv5Wxv/1+6JzM=;
	h=Subject:To:Cc:From:Date;
	b=rwfn3gtCeLSYr9/RUoorgRyTnXb9FUrzV1GW1ORhgMvAs/fTOxaamTyaLYJbGW0Zt
	 AOeumViv2n44V5jO6xxc9mBQTngs/kj4qlavwJ1jDa+TLoNvPWWRFn7V2bUPDR2Ttv
	 jAFWD/5ucIbz6oa22CKeoQWsjZfcAka6PdCLqS2M=
Subject: FAILED: patch "[PATCH] smb: client: do not pass a NULL buf to is_oplock_break()" failed to apply to 6.12-stable tree
To: 2715417602@qq.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Nov 2026 16:30:13 +0100
Message-ID: <2026110213-sliver-doctrine-6a23@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2225ab306575e424b3dad2ee1be2521c89249d15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110213-sliver-doctrine-6a23@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2225ab306575e424b3dad2ee1be2521c89249d15 Mon Sep 17 00:00:00 2001
From: Zikang Gao <2715417602@qq.com>
Date: Wed, 14 Oct 2026 04:19:44 -0400
Subject: [PATCH] smb: client: do not pass a NULL buf to is_oplock_break()

receive_encrypted_read() sets *num_mids = 1 and never writes the
caller's bufs[]. Offload returns -1 with *num_mids = 0, so the
demultiplex thread skips the frame. The inline decrypt path
returns 0 even when smb2_find_mid() fails.

cifs_demultiplex_thread() then treats mids[i] == NULL as an
oplock break and calls is_oplock_break(bufs[i], server) with
bufs[i] still NULL. smb2_is_valid_oplock_break() reads
hdr.Command at offset 12 and oopses.

A large encrypted READ whose MessageId does not match is enough
to panic cifsd.

    Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
    KASAN: null-ptr-deref in range
    [0x0000000000000008-0x000000000000000f]
    CPU: 0 PID: 100 Comm: cifsd
    RIP: smb2_is_valid_oplock_break+0xc8/0x2270 [cifs]
    cifs_demultiplex_thread
    Kernel panic - not syncing: Fatal exception

Return -1 when inline decrypt finds no mid, and skip
is_oplock_break() plus the unknown-frame dump when bufs[i]
is NULL. receive_encrypted_standard() already assigns
bufs[*num_mids].

Fixes: c42a6abe3012 ("CIFS: Add capability to decrypt big read responses")
Assisted-by: LLM
Signed-off-by: Zikang Gao <2715417602@qq.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 550e687a1b15..f46c37e9b3c7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1422,12 +1422,14 @@ cifs_demultiplex_thread(void *p)
 					mid_execute_callback(server, mids[i]);
 
 				release_mid(server, mids[i]);
-			} else if (server->ops->is_oplock_break &&
+			} else if (bufs[i] && server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
 				smb2_add_credits_from_hdr(bufs[i], server);
 				cifs_dbg(FYI, "Received oplock break\n");
 			} else {
+				if (!bufs[i])
+					continue;
 				cifs_server_dbg(VFS, "No task to wake, unknown frame received! NumMids %d\n",
 						atomic_read(&mid_count));
 				cifs_dump_mem("Received Data is: ", bufs[i],
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 207aa2c6acf4..a0b9363ba89d 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5396,6 +5396,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	*mid = smb2_find_mid(server, buf);
 	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
+		rc = -1;
 	} else {
 		cifs_dbg(FYI, "mid found\n");
 		(*mid)->decrypted = true;

