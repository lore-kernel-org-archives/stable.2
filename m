Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795279146;
	b=ZkMuh+73hFj0GDlFtSZnUAtC2+tud0H/ZdhuAawMsr94ddNtZwI36JtNs0ekjiS63fRL
	 kSiKgWWa7WtxYwLVtM6DyhXw72twOcgjKcRfWIqCucKOxaVw3scVmfIBhYLqZZRvSSifB
	 42D+HYhFc231rEC2nprmMfKHDqohdWODk9yEnfEb8OyxRlS2hK2zY+THJ4ms8F50/X6H0
	 4ap+7pdr6XxdL2N3VgdpYZb6iGNqGcF5TCnVAoZlhMbpKsgfiJ4YcFPjkdJOEaTh9AbYq
	 DxOHhYtQpK/eFceNNWTIr0eMIm3qGMOvN0WGhxxfZ4ikSNQMLcwioPkH+HlcvNyxGOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aJagQIak0BRtppgANFUQl/qR942eiwZ9P0AShQ9wWS0=;
	b=2vdl+vqxT0JJXHyZxnara/qYF8kHs6pPNcW8dEqTAXp1yuQUSkGE9hcDM7dJPsGNfqXn
	 W6Sp6QW+COzKE4olrHXC/FsKel0uDnaa+pk/B89h5HfmA/9zFVTBy2z7VGTJhDp6RL+Im
	 M4ekCeYqMSZOAABQu1wVszUe6IDMNJffetFS7Jox2reDAST+RAshhWp/27xJduE23GniS
	 3n+TGaaMfFWbttfmU0oJyfxLRo3AkPaLP4tnjcSAStvGPFW/pfEL12ldmQiwOS3kqruzF
	 kXR9eIN4jNQuRuHfPEjVt/SbbKPCuLuFWlQm9LX4NS39mVq/ldpFWJAeGl7s4mgRIzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZaGse3B;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6791606A333
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6791606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZaGse3B
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so17354335e9.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795279144; x=1795883944; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aJagQIak0BRtppgANFUQl/qR942eiwZ9P0AShQ9wWS0=;
        b=oZaGse3BRu13yzlOR83x5vEkHZPhBpB3/wKNUHuVByLLjz1dOEKr1S6G8WE4hP237Y
         esy4s7j2RizS5XZHqk3AzIzX0Dvcn33IgYjpS3PfUo7hZlLeaPi/iygiKJr3eiEr/IJ4
         +mB5YglndJpcWaXm0wHieAE07b9/gYGD2XUSCOvhj4hmscdJUTodvEqaNCoaC4KPXMwf
         vxyKf/47hIeM2SrQ0kuGYSQRCCyIaeD+2pdkYH4IuNIHiqmAIT8+W/9+gwIQIe/pWR+M
         QYiMSN5/VgCE7lV1Qg7kH/n7E1HXYdciP+BmnKVy6biCcNIi9WyoRMXBLRkZk21nXgWM
         xtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795279144; x=1795883944;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJagQIak0BRtppgANFUQl/qR942eiwZ9P0AShQ9wWS0=;
        b=K46kVRbmnkfGEMq6RpqxI1kv5wzEC5G/g2sb91ZGtUQUYD3AGhfV2JOPMUoDuuXn3A
         tEbce5fAt7b44JMNrkj0dS+1iKZ3eZkDQpTWCb1fQg8x11DbQMs20K/nB8IGTp2XIl6H
         rpFWa88zhhfFCP13ynQVp9w70v0TQX616rTirdTxOdLXUDDnG9V1JzxQUadiKdYqXgRH
         Jq+5KmmuGrWQsEofeZ+zOWc1XYx9EETqEP9Ua8n3NSbvDLeFFnN0heWx0kbnqhmCvg7D
         CVix2S8OJaF2uNzHi9klGOSpC7cIWLiEpbH3dtjYx+1KE0T70ip6KpMFVNSYmnXGlrsB
         ViqA==
X-Gm-Message-State: APuU4Z+WX/R85C3d1tVmYlFh3PYJm7qSbDggLLGOlFWQGG/sYSHeHCdG
	UGHUzx0rZzrZGinNUWDaTpfL0fsLw22zxV0Rs4KrhbkwSmZXx4vg20piGB7LMLixNHCI007I
X-Gm-Gg: AZFdTZf1/DYhmXM1UXwGhnNTB0HjrJx8hp+RBM7iEFylcyuziLcPMds6YuWED3OuFN5
	JkaZONkUW6AVvw+1gVq2kh9DZq/lgfpNUxJnkhJvlRAcRc2eSuUlA16jrVrIaS+Q+8QA8YJyxKg
	zKHj7muUZUT9g1iZvB+VUBPD8PiAGyrIw6VNFFFRAZ+3r1wfWAy9CoJfbS6E4VjLe0U6b+IIn8b
	OV6sjRJ5g9Mho2+iaKlbUBAO1YrzRJp/mcxuZL4qM9WYgbzrygU3NgC7LAeprf8fHzdAvBAEMjD
	7CuiUBxAPq6yAo6sbZyCocISms97VJgTNHWrtDlcKv+9VxJWs6HTB2WQHwbVuu5bdYhandZWHCd
	TFs4ckHh5Vlews9vccM3HSMUZ4F0AtyxpqKES0H3RtEaTGRGVnz+IBhOpRVgP5xQ0EniaW3eijL
	jbEY8wnCkzK6p1f1AI1izgAcSEtjShwrHQ8wUkFhZcVP4vw8yqL/KS1YPEC+KM+r77WTv29Q6lk
	7JfjVUoz6jN45Wy8aUzCsceSbap3kCpLn3TOkERxUWYReP46zJXBO7ezv2+cYznIy67ESZ9a9f1
	pyf+r36yKKGALs+Q+kEQX3WpM1KT52TBrEMxkyr89G2h
X-Received: by 2002:a05:600c:1549:b0:4bb:6a2d:b440 with SMTP id 5b1f17b1804b1-4bb887e0699mr151063275e9.2.1795279144008;
        Sat, 21 Nov 2026 08:39:04 -0800 (PST)
Received: from [10.77.1.44] ([94.188.8.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61b8sm11212895f8f.19.2026.11.21.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 08:39:03 -0800 (PST)
Subject: [PATCH 1/1] scsi: target: iscsi: fix use-after-free in iscsit_stop_session()
From: Vitalii Dodonov <dreamer.two@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: stable@vger.kernel.org,target-devel@vger.kernel.org
Date: Sat, 21 Nov 2026 19:38:57 +0300
Message-ID: <179527913740.32224.16728687439026782592@gmail.com>
In-Reply-To: <179527913740.32224.2426414360492240680@gmail.com>
References: <179527913740.32224.2426414360492240680@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

iscsit_stop_session() walks sess->sess_conn_list with
list_for_each_entry_safe() while dropping sess->conn_lock inside the loop.
A connection that is being shut down concurrently removes itself from that
list with list_del() under the same lock, which leaves LIST_POISON1 in
conn->conn_list.next.

Taking a reference on the next connection keeps the object alive, but not
the list links: the next iteration computes conn_tmp = list_next_entry()
from the poisoned pointer and passes it to iscsit_inc_conn_usage_count(),
which takes a spinlock inside the bogus struct and faults on
0xdead000000000004.

This is reachable whenever a session has more than one connection: on
logout (iscsit_logout_post_handler -> iscsit_stop_session) and on session
reinstatement, when a new login arrives while the old connections are
being closed (iscsi_check_for_session_reinstatement -> iscsit_stop_session).
With MaxConnections=1 list_is_last() is true, conn_tmp is never
dereferenced and the bug stays hidden, which is why single-connection
setups never hit it.

Fix it by taking a snapshot of the connections (with a reference on each)
while holding conn_lock, and using only the snapshot afterwards.  The
allocation happens before conn_lock is taken, on paths that already block
in iscsit_cause_connection_reinstatement(..., 1) and in
wait_for_completion(&sess->session_wait_comp).  The order in which the
connections are reinstated is unchanged.

Tested with a LIO target (MaxConnections=8) and a Microsoft iSCSI
initiator that adds MC/S connections and then reboots gracefully while
I/O is in flight: the stock module panics in 2 of 8 cycles (general
protection fault, address 0xdead000000000004), the patched module
survives 118 of 118 cycles.

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Cc: stable@vger.kernel.org
Signed-off-by: Vitalii Dodonov <dreamer.two@gmail.com>
---
 drivers/target/iscsi/iscsi_target.c | 68 ++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index f3b7569..e644fe0 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4672,36 +4672,62 @@ void iscsit_stop_session(
 	int session_sleep,
 	int connection_sleep)
 {
-	u16 conn_count = atomic_read(&sess->nconn);
-	struct iscsit_conn *conn, *conn_tmp = NULL;
-	int is_last;
+	struct iscsit_conn *conn, **conns = NULL;
+	unsigned int i, n, conn_count = 0;
+
+	/*
+	 * sess_conn_list may only be walked while holding sess->conn_lock: a
+	 * connection that is being shut down concurrently runs
+	 * iscsit_close_connection(), which removes itself from that list with
+	 * list_del() under the same lock and leaves LIST_POISON1 in
+	 * conn->conn_list.next.  Pinning the connection itself is not enough,
+	 * because the list links are poisoned as well, so take a snapshot of
+	 * the connections (with a reference on each) and work on that snapshot
+	 * only.
+	 *
+	 * The sleeping variant is called from process context only --
+	 * iscsi_target_tx_thread(), the login workqueue (session
+	 * reinstatement), configfs, iscsit_release_sessions_for_tpg() -- with
+	 * no locks held, and this function already blocks below in
+	 * iscsit_cause_connection_reinstatement(conn, 1) and in
+	 * wait_for_completion(&sess->session_wait_comp), so the GFP_KERNEL
+	 * allocation does not add a new constraint.
+	 */
+	if (connection_sleep) {
+		conn_count = atomic_read(&sess->nconn);
+		if (conn_count) {
+			conns = kcalloc(conn_count, sizeof(*conns), GFP_KERNEL);
+			if (!conns)
+				pr_warn("Unable to allocate %u connection slots for session %u, shutting down without waiting\n",
+					conn_count, sess->sid);
+		}
+	}
 
 	spin_lock_bh(&sess->conn_lock);
 
-	if (connection_sleep) {
-		list_for_each_entry_safe(conn, conn_tmp, &sess->sess_conn_list,
-				conn_list) {
-			if (conn_count == 0)
+	if (connection_sleep && conns) {
+		i = 0;
+		list_for_each_entry(conn, &sess->sess_conn_list, conn_list) {
+			if (i == conn_count)
 				break;
-
-			if (list_is_last(&conn->conn_list, &sess->sess_conn_list)) {
-				is_last = 1;
-			} else {
-				iscsit_inc_conn_usage_count(conn_tmp);
-				is_last = 0;
-			}
 			iscsit_inc_conn_usage_count(conn);
+			conns[i++] = conn;
+		}
+		spin_unlock_bh(&sess->conn_lock);
 
-			spin_unlock_bh(&sess->conn_lock);
+		for (n = 0; n < i; n++) {
+			conn = conns[n];
 			iscsit_cause_connection_reinstatement(conn, 1);
-			spin_lock_bh(&sess->conn_lock);
-
 			iscsit_dec_conn_usage_count(conn);
-			if (is_last == 0)
-				iscsit_dec_conn_usage_count(conn_tmp);
-			conn_count--;
 		}
-	} else {
+		kfree(conns);
+
+		spin_lock_bh(&sess->conn_lock);
+	} else if (!connection_sleep || conn_count) {
+		/*
+		 * Either the caller does not want to wait, or the snapshot could
+		 * not be allocated: tear the connections down without waiting.
+		 */
 		list_for_each_entry(conn, &sess->sess_conn_list, conn_list)
 			iscsit_cause_connection_reinstatement(conn, 0);
 	}
