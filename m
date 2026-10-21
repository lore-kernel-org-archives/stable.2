Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602391;
	b=FoVFqQXifz5TaSVjrlGaZsQ8Drddy9jLZVAz3F1yh4C8P5nS4n6NgfmvgBmR8VXDBcMi
	 GHpV+wSfpZp3OZE2gwdr8+S9WMFM37Ipe96Z9tmGOSRzlsGycy5KOdPiUR3vrN2zNKhSi
	 ZmUMCnHpk9pRQDHDQG2mkpAP2oc+PTP5zdwtOvCC/Wl21hhrhRMDS6nf0aBhUbmXZEJg3
	 ET0MZXRpe8o4P4mlOialYeKhSx6NpOnXPp0AVDcFIklYvngTi0b2dggK5UXZHuGcr/45Q
	 CgnsR3LgUq+lXIm0LyY8zJcnS7Kgucy36guqqaq2+IQ7S/TsQRvvyYAOR/2JQPn5xfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602391;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rkKKVnZv/kHJBrv3uwIvqeZA4Aam5alns9BT/D3usA8=;
	b=uReTjyG0sK5telvFrn7pcrA8ucoM9xWhwkgRS0TX0tE+pa1e9wEA0ysSR/om8nfsf9UA
	 sPz85zCTZ2nMsE0MZjoGdygHQoKtSiSmoXzky/6DxV2QOlPSvb96f8QDe+2G7H/13pPGz
	 y7+J5Fs6mkT8jfp8mAj+nCFAu39EojBhnlEiB0j56pKbzcRrY0TJsMwlEfzEhCN4eI4tX
	 KC3QxXNvOlVeR/Wi4lmzyUb+BDnVlW43Pc8Kp9t8NVvVDlPuVIloDng7bl2VbJOkWzyKB
	 lSWZ/irmwVekNUwq1K3e8BNyNpfDcRI1yq/IIciC2EpnTyl+O7tEvjUyx6Eez2cVdsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A72606A320;
	Wed, 21 Oct 2026 17:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A72606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ar (unknown [42.86.112.99])
	by APP-05 (Coremail) with SMTP id zQCowABnzzkF8dhqtPUEDA--.14779S2;
	Thu, 22 Oct 2026 01:06:15 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: idryomov@gmail.com,
	xiubo.li@clyso.com,
	amarkuze@redhat.com
Cc: slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: reconnect on peer reset even if the mdsmap says the MDS is active
Date: Wed, 21 Oct 2026 10:06:13 -0700
Message-ID: <20261021170613.1144381-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnzzkF8dhqtPUEDA--.14779S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary7ZF1kCF47Xw1UAF1xAFb_yoW7Cw1kpr
	Zaka93Gr4kAw1xtrZrJa4DuFyvkr15ua13JrW0qF95Ga45ur1ftFWvyw1vgasrJr97Ca1F
	9FW2qFZ5Aa1jv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRUHAmrYx7xX1AAAsT

Since commit 39fe30315893 ("ceph: harden send_mds_reconnect and handle
active-MDS peer reset"), mds_peer_reset() tears the session down instead
of reconnecting when our mdsmap shows the rank past RECONNECT.

That map can be stale.  An MDS killed and restarted on the same address
resets our connection before the monitors report the rank as failed, so
the session is torn down while the map still says active.  When a
standby then takes over the rank in up:reconnect, check_new_map() has
no session left to reconnect, the new MDS evicts and blocklists us
after mds_reconnect_timeout, and the mount returns EACCES until it is
unmounted:

  libceph: mds0 (2)10.89.20.12:6800 session reset
  ceph: [...]: mds0 closed our session
  (mds) evicting unresponsive client ceph-c1 (14900), after waiting
        49.7175 seconds during MDS startup

Send the reconnect and let the MDS decide, as before that commit.  A
daemon restarted on the old address has a new nonce, so the reconnect
does not get through, and check_new_map() reconnects once a map carries
the rank's new address.  An MDS that really is active replies with
CLOSE, and handle_session() unregisters the session so that new
requests open a fresh one, which is what that commit intended.

Skip the warning for -ESTALE and -ENOENT: send_mds_reconnect() already
logs those, and the removed code was silent for closed and rejected
sessions.

Tested on riscv64 (7.2.6 kernel, Ceph 21, one active MDS with a
standby-replay): SIGKILL the active MDS while dropping the client's
monitor traffic until it logs "closed our session".  Evicted in 4 of 4
runs without the patch, "reconnect success" in 3 of 3 with it.  Eviction
by an active MDS without blocklist still recovers with a new session,
2 of 2 runs.

Fixes: 39fe30315893 ("ceph: harden send_mds_reconnect and handle active-MDS peer reset")
Cc: stable@vger.kernel.org
Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 fs/ceph/mds_client.c | 84 +++++---------------------------------------
 1 file changed, 9 insertions(+), 75 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d4ef8a355a48..d23250af0750 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -7236,7 +7236,7 @@ static void mds_peer_reset(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
-	int session_state;
+	int rc;
 
 	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
 		       s->s_mds);
@@ -7246,82 +7246,16 @@ static void mds_peer_reset(struct ceph_connection *con)
 		return;
 
 	/*
-	 * Only reconnect if MDS is in its RECONNECT phase.  An MDS past
-	 * RECONNECT (REJOIN, CLIENTREPLAY, ACTIVE) will reject reconnect
-	 * attempts, so those states fall through to session teardown below.
+	 * Our mdsmap may be stale: an MDS restarted on the same address
+	 * resets the connection before we learn that the rank failed.
+	 * Send the reconnect and let the MDS decide; one that is past
+	 * RECONNECT replies with CLOSE and handle_session() closes the
+	 * session so that new requests open a fresh one.
 	 */
-	if (ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) == CEPH_MDS_STATE_RECONNECT) {
-		int rc = send_mds_reconnect(mdsc, s);
-
-		if (rc)
-			pr_warn_client(mdsc->fsc->client,
-				       "mds%d reconnect failed: %d\n",
-				       s->s_mds, rc);
-		return;
-	}
-
-	/*
-	 * MDS is active (past RECONNECT).  It will not accept a
-	 * CLIENT_RECONNECT from us, so tear the session down locally
-	 * and let new requests re-open a fresh session.
-	 *
-	 * Snapshot session state with READ_ONCE, then revalidate under
-	 * mdsc->mutex before acting.  The subsequent mdsc->mutex
-	 * section rechecks s_state to catch concurrent transitions, so
-	 * the lockless snapshot here is safe.  s->s_mutex is taken
-	 * separately for cleanup after unregistration, which avoids
-	 * introducing a new s->s_mutex + mdsc->mutex nesting.
-	 */
-	session_state = READ_ONCE(s->s_state);
-
-	switch (session_state) {
-	case CEPH_MDS_SESSION_RESTARTING:
-	case CEPH_MDS_SESSION_RECONNECTING:
-	case CEPH_MDS_SESSION_CLOSING:
-	case CEPH_MDS_SESSION_OPEN:
-	case CEPH_MDS_SESSION_HUNG:
-	case CEPH_MDS_SESSION_OPENING:
-		mutex_lock(&mdsc->mutex);
-		if (s->s_mds >= mdsc->max_sessions ||
-		    mdsc->sessions[s->s_mds] != s ||
-		    s->s_state != session_state) {
-			pr_info_client(mdsc->fsc->client,
-				       "mds%d state changed to %s during peer reset\n",
-				       s->s_mds,
-				       ceph_session_state_name(s->s_state));
-			mutex_unlock(&mdsc->mutex);
-			return;
-		}
-
-		ceph_get_mds_session(s);
-		s->s_state = CEPH_MDS_SESSION_CLOSED;
-		__unregister_session(mdsc, s);
-		__wake_requests(mdsc, &s->s_waiting);
-		mutex_unlock(&mdsc->mutex);
-
-		mutex_lock(&s->s_mutex);
-		cleanup_session_requests(mdsc, s);
-		remove_session_caps(s);
-		mutex_unlock(&s->s_mutex);
-
-		wake_up_all(&mdsc->session_close_wq);
-
-		mutex_lock(&mdsc->mutex);
-		kick_requests(mdsc, s->s_mds);
-		mutex_unlock(&mdsc->mutex);
-
-		ceph_put_mds_session(s);
-		break;
-	case CEPH_MDS_SESSION_CLOSED:
-	case CEPH_MDS_SESSION_REJECTED:
-		break;
-	default:
+	rc = send_mds_reconnect(mdsc, s);
+	if (rc && rc != -ESTALE && rc != -ENOENT)
 		pr_warn_client(mdsc->fsc->client,
-			       "mds%d peer reset in unexpected state %s\n",
-			       s->s_mds,
-			       ceph_session_state_name(session_state));
-		break;
-	}
+			       "mds%d reconnect failed: %d\n", s->s_mds, rc);
 }
 
 static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
-- 
2.56.0

