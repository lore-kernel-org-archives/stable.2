Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633425;
	b=IoifzxcfopGtePv3nw0KsnA1VQ9QWfN4KOKaZwQ7Mzsfz3pIMmAvTL5kNI2+y4NLN5aO
	 pOL6SYyZAgb2NL+MKqAXRcSHK9hRtz7Mr6XgVtgJVejCjaKDzarxzC1he4STRVCT+3yD7
	 Npc9CDBl6ooCZU0IzTKzEf/dqTY+r2f0vBR6MUp3w2ES2WlYWnmBF1ht6KlDIhouj652B
	 W3Ensut1AVzwDo6xq46aJ9J1xZHmwXbzsZlMesWu/sTpiA0ZDrgARHeEt6oMsy4auX09d
	 OTGyTduKSJtHp8x+S2x4wyrfDwzUs/hwg21tYx4zDRX1OpIw5Gz/j9nwjFAtluvoEsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633425;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MNOl10txgsy2DHYOcTKWSNe3LWKww+++XMIETy27Hg0=;
	b=SsSBaFLBRlV0rg3eUAsqS0V5QzAKPOO7OZlF0yyNW2dVsA65+kj87V9RVApervt36j3f
	 w3+yBm9oYOLnyd0acCPI1hGjiwkUNq8qRM8evQGOUK98svQtjfs/FWwHDRq+WHVLzqSMt
	 CB8ZF+dYlGzUP9hEcPVNIvsaZhei4iLuDpXKrsAucQ4RqzSc9g3gVzXJ5dN2B4gMNS2+6
	 X4EmxTTbCUWQGm8Y9sCRfJFf8SnlvQmksOl7vCvt5y45Aq6KdBPkbfc1oX+ZLyz75fjNO
	 R+HVGwMUhgbWvnn9r/42QIyS2OIZvX0uVec/BwT3uiGMm8b785nFICZIVug78hkNmwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wpbS6W0K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27855606AE85
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wpbS6W0K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705A81F00A1F;
	Mon,  2 Nov 2026 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793633424;
	bh=MNOl10txgsy2DHYOcTKWSNe3LWKww+++XMIETy27Hg0=;
	h=Subject:To:Cc:From:Date;
	b=wpbS6W0KABX+7QVpWvYzwPnuilu0W5jzvPOWyMRNM2ohnxdJMjMbYrTljvpYxuy7S
	 td0nNvPMGwZTjinFq5TpnkJWvBhw4WZPW9vwrDKN6dx31ssvJPNxiOIwynKOEerDsP
	 CPYEgh4RROTZnkCOqbIR5dNg8YbzKFtqWu7RhY0Y=
Subject: FAILED: patch "[PATCH] smb: client: do not pass a NULL buf to is_oplock_break()" failed to apply to 5.10-stable tree
To: 2715417602@qq.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Nov 2026 16:30:16 +0100
Message-ID: <2026110216-shindig-consonant-aa4f@gregkh>
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
git cherry-pick -x 2225ab306575e424b3dad2ee1be2521c89249d15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110216-shindig-consonant-aa4f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

