Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413921;
	b=O8YAInYCTvpKZvd0WXQr6wky1qWmEeeBc0Ur0laleATlK9CMLxjkB3zc7bNAhpGZdnIQ
	 T5vqG44ziQimmq2HUUlUhIfnX3Rioa9HBuQAmi6WVkUFg8bfP59WEne2w9CpDn9bCNaOa
	 lI+tnfaXHqrABV6wGFsocl3loDbl0K9191sL9Gm5uNZnvcd0QYR1rJVARxNGgRhTu1kVG
	 Xx73B72GOPojfYvD+IW4gdS7XezSMHovFgbxI/OXTH1Z2gL3hb33JWj9K1jj00/vCNqSu
	 sKRYCjWackHWdWBk78kFCTjTKf1JQ6CnT4KiMvMwLriQIZk03KqQqW832vPpMTCWRUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oM/6l2zeyiYa7HEKwL18/fyBBln2kYpUTJiHwLiTo84=;
	b=rk1lvzGgHu4+PSXIZtrd0YN5AFLJF0BHn2jsnZ0YlZuVqRvCggl7uomRqDJ2nSShp3E8
	 7lTo11DnKt5iL/BZiNkXTwkPJ9qecXslZaH0Ub6ZP6Nv/FQMohKdaEV/F5Um+yNqZMMyJ
	 RhTzEHoa0ASyQ/vTxUAdM4W3s+MBMGQaf1U+Vyv9yWNQ5aIhnOqNAkL7AIE205F7FA5t6
	 khovtuIOfGJRTNqWPm2wZMTmWIgVyI9Tr1oawf1KS2sIz4LmRKu0QyyQJIHRDQxQz4vBW
	 2tf67UPpguiqWGUdZkSQQV3GBvP/AXIqKh1L0P4avrS98Porz4jioXakHUZiVsfS5MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=ExLC8ry0;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C860A2607
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A16C860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=ExLC8ry0
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490f38e9688so2671035f8f.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413918; x=1795018718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oM/6l2zeyiYa7HEKwL18/fyBBln2kYpUTJiHwLiTo84=;
        b=ExLC8ry04gNbzdm24tLh3UFZXQJ6TJH01gda+GcXsaqej5tdZPsNkiqdM6uyRs5I1G
         GEu1GFYAU2GzhquwA3Rvz5MQBofvL6s8Gvtba0o7qo39XNpOg391HOYXtomqgceGl/Wm
         vhKuf996W7fesOBSmrP6cF78g9x2nvX2pZPY10uDJ823xfguO8D82SYjS0mRmDPeG3RJ
         9pBbBFgQkdrNNkSHadG3YLmCd6oAcuo8oqwbgNqZFKGvjzTY0R+pFM5wY4iIJ9rLpoYY
         uxN5T1Gvf0zpwzDIRyKyVUw7BVXH8Dp3BYu23m9jBtCFziMG360GMAXrIAsHRbRMDEgg
         s+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413918; x=1795018718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oM/6l2zeyiYa7HEKwL18/fyBBln2kYpUTJiHwLiTo84=;
        b=v0TXhFseTEFG0zSiYwi7s5h5WhP2TeYYRN+22Nu+6tGFSvToRgKLF3wOOR1NY4NEin
         Xx2B/FKt/NcMUUkYGvkVomzOVnhgn/mHJViLUFZ4hgMNpFiA34/I6sxjYCWQVhIpzaDU
         zoAHvDw2McQrD5T4Zcas3nzFdKAvvAvBmRe3iQsnD/L/BHnL0WQeKw8zK/4Aipc56W+m
         1A7j36NMGYvII79JX5P4eiH/tnCizsAUna8ZJhwWjjkHveEtR+mDlojDqAx9rlDNvFv1
         rvQTKV2ULb6heX5CtT565P2h3DLBtyt0QoEq2Qq/8TPITQlUc0njDdFybgcG2ChONLKQ
         eT3Q==
X-Forwarded-Encrypted: i=1; AL+hErFrpA6Ths4G9OEhCqafNr7CUUu/W3NM8fIU3U3O0wi8SYK6nhPjWrIQeYdtVe4C2ve9A4K6oPE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uRpUobF4VBdCJ3M0XskKM6piCW09IVGB6KcFFX83OkG9Li5Jy
	h12E2/Ox7Kz3H51yWkhvCvxJ4+8qKwKGy9Zw+PgQ08okHJajDfrhD28tM8UgkBX1w6U=
X-Gm-Gg: AYBFou1TvZj7nvWHo0MOJY19so8Trth9ixkhscX2PskKb37uOxEqXypZrVohpTspYBS
	o06/rfdTmdYKHgjvUbI0OB28AssIy5fIcPCqjsxnHCj8KhFRA32P/Uvqx5PurFYURm2JE5XWR+x
	6Bxi2Y7z/AgkBYks4OJnci8iZOtBGkoz5KRiW271J9vXHb06R+cXkrsoR5rq9VDF+eB7Zj+dvCV
	39AjGGKPYnubOSCrKCv/AdOn9XwjjnOadWWHtEAfNEUMFRyee1Nqe1YOjwiwxc/jRUvolM8rrvD
	O+7O50AGbG9nleuOo+lREhPppF76LswizgMeaaA0e76k1KdYG1TBDOXfrZl1MxbTPJx/Qfz2k53
	5qRIGWxVY9EFG/rIkiX9Vicyw4art/cDQxMVxQ4rMiqPJFuAvf4DYtcOTFcITD1ovVw7+7Jnswh
	rkwiruqWNDTKVnrIdgiF4O4ALrtnjn7rchWkqW5w27nDoEccWCh5f+xJ7TN7tcpP2BE0fdNPB71
	vBTa0fbcwT9gRJUfYzOl7h0+qzd/Or8JazTH8S1yA19LMdpPETTp0xkPEctRohoDQmHwZz/gFi8
	oniZM03LuX/R+P5vWGf0HAeFQ221jASoJmU4YEGVyFWLOTHWXub94Cp+fWV52PzF1YNgo/U/WA+
	AHXZI1v/she6eNqyh7FVBplLs6cIXug==
X-Received: by 2002:a05:6000:4615:b0:48f:8eb6:2320 with SMTP id ffacd0b85a97d-499c3c96806mr5058142f8f.3.1794413917994;
        Wed, 11 Nov 2026 08:18:37 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:37 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/9] ceph: fix mdsmap use-after-free in send_renew_caps() and renewed_caps()
Date: Wed, 11 Nov 2026 17:18:25 +0100
Message-ID: <20261111161830.1336485-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

send_renew_caps() and renewed_caps() read mdsc->mdsmap while holding
only session->s_mutex, but ceph_mdsc_handle_mdsmap() replaces the
mdsmap and frees the old one under mdsc->mutex.  They are called from
delayed_work() and handle_session(), both of which can run while a
new mdsmap arrives, so they can read the MDS state and the session
timeout from freed memory.

Read those values while holding mdsc->mutex.  Callers hold s_mutex
but not mdsc->mutex, and taking mdsc->mutex under s_mutex is the
existing lock order (e.g. check_new_map(), handle_session()).

Fixes: 2f2dc053404f ("ceph: MDS client")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index da40f2cb80f2..a43ce23d48f4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2190,7 +2190,9 @@ static int send_renew_caps(struct ceph_mds_client *mdsc,
 
 	/* do not try to renew caps until a recovering mds has reconnected
 	 * with its clients. */
+	mutex_lock(&mdsc->mutex);
 	state = ceph_mdsmap_get_state(mdsc->mdsmap, session->s_mds);
+	mutex_unlock(&mdsc->mutex);
 	if (state < CEPH_MDS_STATE_RECONNECT) {
 		boutc(cl, "ignoring mds%d (%s)\n", session->s_mds,
 		      ceph_mds_state_name(state));
@@ -2232,14 +2234,19 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
 			 struct ceph_mds_session *session, int is_renew)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	u32 session_timeout;
 	int was_stale;
 	int wake = 0;
 
+	mutex_lock(&mdsc->mutex);
+	session_timeout = mdsc->mdsmap->m_session_timeout;
+	mutex_unlock(&mdsc->mutex);
+
 	spin_lock(&session->s_cap_lock);
 	was_stale = is_renew && time_after_eq(jiffies, session->s_cap_ttl);
 
 	session->s_cap_ttl = session->s_renew_requested +
-		mdsc->mdsmap->m_session_timeout*HZ;
+		session_timeout * HZ;
 
 	if (was_stale) {
 		if (time_before(jiffies, session->s_cap_ttl)) {
-- 
2.53.0

