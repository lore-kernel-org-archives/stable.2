Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BED43F8DF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534195; cv=none; b=FsSgP9Z00ZIVi6pEpMiTrJ2OtqROqCoEkYrCa/13vY8bwzg78I3Xlu15kJZNtABqrSPlO4a6VettbsTkhzxhJlkW3G5PBepQMxwKJ89aXTOY07JRtqKobrvIO/HpfCjx58EImLG1vHcYFxDgjX7CiZaG0NgBQqzSkqWv85YYPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534195; c=relaxed/simple;
	bh=rJMGxltpZAJR+jvcsSWb1sWqev/1OdfAjfWAfOaf5p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blwJgl+hlpCdfrkSBxDLM/S/5QQUrclpIJhumtKtR9+emVCddXQRgNGKGp9tkbh6cmIPN+frTrp8TvEiBHMnXnkvyM+bBq3uqkX/XBRCIWyuE0OfqyLGGj29vxTSOmAMEERm2J7wAaOGbeQyzo9MiTpukF6NYsvfwaX6p6pFFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NOPau+o7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NOPau+o7"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c25fbcf5d44so168874666b.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788534191; x=1789138991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nzoyfcOHeKv+tpIRgc2EL6jwYs5rJEcNEzi5ToP2Q7A=;
        b=NOPau+o7lFVkyOQu82/0x2kbPX/Qjl1gUl2J4269yEES58mAR6CYHq3AinAEVjG1FN
         CNF/6oHiGApxRGEI8ifXSp/7t29VbxLHTwqSJOqxtOWkba5yUqVveRko4SvBqcJas6gY
         kW7npbpnfQUiX0mgOZyKcJLgEljcPv414UvlLNj3IqRg116kj1hCDIjSwex2KOT7F0/7
         eyndeizrwnR6PEhl9lEF4d7fRTEcJfgHKxDB/mlUQ7Pz78rx9Jy2xef9MhMl3hob2x9E
         esj8mFsH/YCyISw8CPjeGQdUsQ8IgoTHRY264QlGcXZms9dy/+2VPG1tPYoGT63ieHHP
         mdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534191; x=1789138991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nzoyfcOHeKv+tpIRgc2EL6jwYs5rJEcNEzi5ToP2Q7A=;
        b=EH3CKRvFKHSmlzf7WPUq8JX0NIdl/tFkDFeXndSqkrujWhD3Sbsoof79nrC3meHIHZ
         4GKWn0cJrQl3rwsF8h7GQajDV6iqqnlz8aOuK8hga2239CnYrRfqLgGtljwCPfHyDTu1
         DNFQrWMWcwL6ba4c0iolPsFwQ/jnL87erqG1O+F6kM8ezzjPbggh3LXafeEJTCcAmN4l
         tl6icjqbqqbVjLoYd+R7DgiFOt8tpYp56BEaIKM7VEJt3yVmqT+dJ9kWDua7e4665GfE
         JSFmmmJFb165Lec+gt60+L+t4W+u+zZa8p3yUq67GvyCZ7PKGdRbyILb5jxCQZtRFENb
         L6hw==
X-Forwarded-Encrypted: i=1; AKwUvBwY2Klm1Offn5B0AyxDzCSYSPphAH8N12ZSTYPt7Bsiqu0AG3RUjuEs476mSlpONDO+rut2VB8=@vger.kernel.org
X-Gm-Message-State: AFuF++k7cHBxPOrzkk1cdMQp0C3ALMdsy1rWeYQILt5ZSEsWgwFCAZPZ
	NdDGu2KnifKVigrRpbEoKepcav00J7fCsBUlUAq+rXiJR43GEoWUOepAdAa8UTmTd6w=
X-Gm-Gg: AYBFou3fwcmsRU87V2ujYeJsSudRsgyrkLE29Vj/+U/w4qiHzGd0DSpVro2EgRyDdI0
	KtVKJG4dC/s7nwpxLsN/OeC9SPW2VAyjBUPbb90qQyQPuqj+Hb33/jwpMRkuktp0EXfM5AF0Cxw
	nQxBheMen1Pvw1UouJ20tHqbMrv2twoje8epmXYEyNqeGmvMzVO+XcwUJrZqlco3cu5OsryEYHW
	8z/Owm6LeexZqgqA0m59U6Zfb5nHBDhFR9dhE6pnwQVbOutkqrUdi8nlalPCECfzd25Bp5b5ZMC
	dzJ4pHjxo9Ga7dubOM9SwF1sasyh7/uBZpjdly2RsVPIftSXygDM5akDDZK+bCnfTG1gfix/37Y
	YktamvartbYWgiRuvXhUoOng3Q3SgPF+ybzvOeV0IvDkbGKPkPnNJrF6Y1MLG3+mGmzj3+l67Dx
	7A0yFHosjxDkHJIMM4n1x+P8g4ECvqXTMI4WFTtXiYB0XzfRGDyk60OJgLvCFYoFrpHOc1CRwmV
	OtvbHBaLYj8rJU421tD1J08X01PVgeDYQ1OsmqFQ9pPEWKfxPY15ZwK/aYiy3ekdyRTADwme/7V
	Xw==
X-Received: by 2002:a17:906:f586:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c260c6a0e2emr465899466b.3.1788534189151;
        Fri, 04 Sep 2026 08:03:09 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c93sm122438866b.63.2026.09.04.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:03:08 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] ceph: fix use-after-free in check_new_map() after early session put
Date: Fri,  4 Sep 2026 17:03:02 +0200
Message-ID: <20260904150304.49104-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904150304.49104-1-max.kellermann@ionos.com>
References: <20260904150304.49104-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_new_map() drops mdsc->mutex while it locks a session, prepares a
reconnect, or kicks flushing caps.  A concurrent teardown can call
__unregister_session() in that window and drop the sessions[]
reference. When check_new_map() reacquires mdsc->mutex, its temporary
reference may therefore be the only reference keeping the local
variable `s` alive.

Commit ee611a750955 ("ceph: fix UAF in check_new_map() on session freed
during unlock") addressed this by taking a temporary reference around
each unlock window, but it drops that reference as soon as mdsc->mutex
is reacquired, while `s` is still in use:

  ceph_get_mds_session(s);
  mutex_unlock(&mdsc->mutex);
  mutex_lock(&s->s_mutex);
  mutex_lock(&mdsc->mutex);
  ceph_put_mds_session(s);    /* may drop the last reference */
  ceph_con_close(&s->s_con);  /* use-after-free */
  mutex_unlock(&s->s_mutex);  /* use-after-free */
  s->s_state = CEPH_MDS_SESSION_RESTARTING;

If the session was unregistered during the window, the sessions[]
reference is already gone, so this ceph_put_mds_session() frees it.

Additionally, the session could be freed while its s_mutex is locked,
which trips the WARN_ON(mutex_is_locked(&s->s_mutex)) in
ceph_put_mds_session() and then unlocks freed memory.

Fix this by holding a single reference for the whole loop iteration:
look the session up with __ceph_lookup_mds_session(), which returns it
with a reference held, and release that reference on every exit from
the loop body.  This subsumes the per-window get/put pairs, so remove
them.

Fixes: ee611a750955 ("ceph: fix UAF in check_new_map() on session freed during unlock")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
Note the stable maintainers: this is a fixup for ee611a750955, but the
bug has existed before; see
https://lore.kernel.org/ceph-devel/20260828174504.1247038-2-max.kellermann@ionos.com/
for a patch that applies to pre-7.2 kernel versions.
---
 fs/ceph/mds_client.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a091f77cedaf..d36a114747ae 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5860,9 +5860,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	}
 
 	for (i = 0; i < oldmap->possible_max_rank && i < mdsc->max_sessions; i++) {
-		if (!mdsc->sessions[i])
+		s = __ceph_lookup_mds_session(mdsc, i);
+		if (!s)
 			continue;
-		s = mdsc->sessions[i];
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
@@ -5875,7 +5875,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 
 		if (i >= newmap->possible_max_rank) {
 			/* force close session for stopped mds */
-			ceph_get_mds_session(s);
 			__unregister_session(mdsc, s);
 			__wake_requests(mdsc, &s->s_waiting);
 			mutex_unlock(&mdsc->mutex);
@@ -5896,15 +5895,14 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			   ceph_mdsmap_get_addr(newmap, i),
 			   sizeof(struct ceph_entity_addr))) {
 			/* just close it */
-			ceph_get_mds_session(s);
 			mutex_unlock(&mdsc->mutex);
 			mutex_lock(&s->s_mutex);
 			mutex_lock(&mdsc->mutex);
-			ceph_put_mds_session(s);
 			ceph_con_close(&s->s_con);
 			mutex_unlock(&s->s_mutex);
 			s->s_state = CEPH_MDS_SESSION_RESTARTING;
 		} else if (oldstate == newstate) {
+			ceph_put_mds_session(s);
 			continue;  /* nothing new with this mds */
 		}
 
@@ -5915,7 +5913,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		    newstate >= CEPH_MDS_STATE_RECONNECT) {
 			int rc;
 
-			ceph_get_mds_session(s);
 			mutex_unlock(&mdsc->mutex);
 			clear_bit(i, targets);
 			rc = send_mds_reconnect(mdsc, s);
@@ -5924,7 +5921,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 					       "mds%d reconnect failed: %d\n",
 					       i, rc);
 			mutex_lock(&mdsc->mutex);
-			ceph_put_mds_session(s);
 		}
 
 		/*
@@ -5937,15 +5933,14 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 				pr_info_client(cl, "mds%d recovery completed\n",
 					       s->s_mds);
 			kick_requests(mdsc, i);
-			ceph_get_mds_session(s);
 			mutex_unlock(&mdsc->mutex);
 			mutex_lock(&s->s_mutex);
 			mutex_lock(&mdsc->mutex);
-			ceph_put_mds_session(s);
 			ceph_kick_flushing_caps(mdsc, s);
 			mutex_unlock(&s->s_mutex);
 			wake_up_session_caps(s, RECONNECT);
 		}
+		ceph_put_mds_session(s);
 	}
 
 	/*
-- 
2.47.3

