Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413917;
	b=xM8zRxLkYvoqFGpeB9wFM2KXiDs9FqZSHnnk20ls28ZeRH3jzhGd8EJIgPnjwYJrI0/J
	 Wb/8NxOaIi1HYVW5U9hF1EU4M1SaZB1Iov+evAcKp8xrDN3TVkKoPWw4rt6YI3CbALjdH
	 izMrAw6iKPlE6TJvvyrAoSMI6+BbKVPl92houhMOnxfnb3Xd8LRyJ8iIVy/4Jn/fYYQVU
	 My1n6HQb3E7At1fdwFm3ooMHOZxOaKgsu1lG6i85tLHFWvjwgYuTbffBqATXWLlRY99Zt
	 Xd63YWsM99Bhf2e1QEAnrd5Ynv8LnYdyuZKJS2Ze5+6krTGD61bhtVD40gtHeA8IR+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PywhPEppgcWI+Me/jVt+CP7Qe/6FQfOUGlT878EeRYg=;
	b=X/w1yz8aQ8Vn50hgafmf/98AkhFF9m6x9qCYHw9Q7KkgoFGvCYELQd6LN6Q0ndMXT4uc
	 0Ft72uM0VOy4IsGdcE7bjCZexkupKSWSJSDBK144FIkqvnw+kCL5OGOlxP0srwHRD4XNA
	 eUY9BS/J0Fw5XmxdOixvoa6V7Vu+/EPNniFTqeoAmBFzpbgMqNK2Mtd8yimbjssZmPLqJ
	 IN1BzoUVl1EBi1OE2XNzOuEupbCbdEgQl0UnzIgCALTcab6U1DP0L2n0ts1NbRHe32h9w
	 EyQNc27MYk0sJxDl/DMOhBAEt482zux/IZ504b94qnTDyXQHDFQa8pA3gj5Zuu++jIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=MAULci7y;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC157606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC157606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=MAULci7y
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so35847415e9.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413915; x=1795018715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PywhPEppgcWI+Me/jVt+CP7Qe/6FQfOUGlT878EeRYg=;
        b=MAULci7y91YTKEUFyO/XThAFj2Pe9m5tWcxpxxpPKFaUanSCNrn4fBmKilzd34WSVy
         F1Rl+ozGWD4G5Lrf1+qZs/31vD47Do6X0Px+St1/m7+GMjp3+b06PHGA4G5TDoTHc/Jk
         PlHZOdI0PvQpwMieLqh8X1C8gG6fSmoMHQggRwuvU52FLa5qfw0OX9eY0mWZP+o9x/P4
         7JTJKsWSfHwz1gtTy4+jlmc2v9A4mBHhfHPcwH7NN3ZzhsfHHyk0JVkRMgcdvvnDj6p+
         EmpBTZrZwmTtWi9pjEBzEpowQ4p+LvPs+JzZi0RuNSyAKMd8KZPs4UGDT1678uLXaDDS
         HFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413915; x=1795018715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PywhPEppgcWI+Me/jVt+CP7Qe/6FQfOUGlT878EeRYg=;
        b=RcjgxsqMFjrzECKLkqAnGuys34fCpIJDoLk6vX1LgxadtNvOkFkFDoWKbyggLSbqsG
         0rP/49PV+ZxzeJTlcHsnEoUipZU7VzoCuqvNCrsl0j0RylPPPDP2/Z+oG8Kk2qUkVSsU
         /v+K9yAssaLAq8f4GmdHCSYzyBoiWdvhTIxPJ6hNDhHuKBpcqpkBhfLA5fNl2UOxcMM0
         feqv2R3M5MUKbwjUy8vGk4JwxnT/3VPoMDNh55CPOrjl0L28afib3RJS8u0HANitXwLK
         a2k0zQUI9kMdpKv+B6OT/Jh2BIlrUSLGU85dbokMZXniUcauFio4OHzmuAIV0XfY8iNU
         kmYA==
X-Forwarded-Encrypted: i=1; AL+hErG6h1EyheZHDoDyznUaxk5mbelPlIHaWKilppg2LNKCO4T5GsVJ9Bo+AS/rX35E8WuYiAmZDio=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Bir06fqM8Hg4IYFHDp/iYo5r4HBxRJEWFTWx8iX5SXiqIOJ1V
	hqNUbNTeZ2HT7N1/YfZ4dzi+eT4xLoVPpXXomIq3s37rSdycFmjOi13zPqAJSn00UQE=
X-Gm-Gg: AYBFou1moOOSspflfmn9lI4IpkK8Fe0jrXfMfXZjJL3JsJrzHADVMLazGxf2XgSRo+n
	zSiZ+hAGHlwTVznKI9HHtkTBMzjscvRj3/RldSJ6/WbYZzBSwF/hgmTCxT+K0/bQzeNoKTQrXcA
	S1ija/luJu/dEhEddEu86dL3QKNJhaLTI3FPpPiDsXToP3ctZIOqR72mo7jqRs4PfCYSusxi17/
	FORIjj1xRH6SBqSmAG6zgTGnQ6IouAFQ8002Wmw/WVR46zCwWEjXKmTC8CdllrSqnFHjKQIYyki
	eMatlBexs/SXAeIxSTEOUXukdfhQG5XxpKm/iH8ViVcBuJBBoSqY4tTTlo6hWql/NmryaXWGXnj
	DQYhNma3fi5PaYLMxY1ilUj6CdQF7O/g9qjJEXd+YzokCJIwj3EuqWV0QTn+2CnyDTbz9pLZTYN
	LZ8iqWquC/pRz/Hlw+QLtTvzL0i3KPgQM/tocv/OQog4riKsjl3jwWdxnRMvOSBkpCvwQaWtBVs
	+xAK/GhaEy9ESxZiuKemfNbPciiLTrJP7Bb/mpkv+afHdcgtqa59FJHfnZPs2joSOOCzhguuitD
	pYBazrlkSxyojS62Y8LFIijuFrbZUIgGLQa3s1dNV9LqB2l29U01eF21LFkp6S3XFOulq7iucg4
	7Q23+Qru0/MWb7QXsVJfj6s/GoSF2FQ==
X-Received: by 2002:a05:6000:2008:b0:48e:d88:55f4 with SMTP id ffacd0b85a97d-499c38bce0cmr5171391f8f.2.1794413915273;
        Wed, 11 Nov 2026 08:18:35 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:34 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/9] ceph: fix mdsmap use-after-free in ceph_statfs()
Date: Wed, 11 Nov 2026 17:18:22 +0100
Message-ID: <20261111161830.1336485-2-max.kellermann@ionos.com>
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

ceph_statfs() reads mdsc->mdsmap without holding mdsc->mutex, but
ceph_mdsc_handle_mdsmap() replaces the mdsmap and frees the old one
under that mutex.  A statfs() racing with an mdsmap update can
therefore read m_num_data_pg_pools from freed memory, and then load
the m_data_pg_pools pointer from it and dereference it.

Any user can call statfs(), and mdsmap updates happen whenever an
MDS changes state.

Read the data pool while holding mdsc->mutex.

Fixes: 06d74376c8af ("ceph: more accurate statfs")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index bb5591c1e154..01f92d77ef45 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -64,6 +64,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(d_inode(dentry));
 	struct ceph_mon_client *monc = &fsc->client->monc;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_monmap *monmap;
 	struct ceph_statfs st;
 	int i, err;
@@ -73,11 +74,14 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	ceph_blog_enter(fsc, &__ji);
 
 	boutc(fsc->client, "begin\n");
-	if (fsc->mdsc->mdsmap->m_num_data_pg_pools == 1) {
-		data_pool = fsc->mdsc->mdsmap->m_data_pg_pools[0];
-	} else {
+
+	/* ceph_mdsc_handle_mdsmap() replaces and frees the mdsmap */
+	mutex_lock(&mdsc->mutex);
+	if (mdsc->mdsmap->m_num_data_pg_pools == 1)
+		data_pool = mdsc->mdsmap->m_data_pg_pools[0];
+	else
 		data_pool = CEPH_NOPOOL;
-	}
+	mutex_unlock(&mdsc->mutex);
 
 	err = ceph_monc_do_statfs(monc, data_pool, &st);
 	if (err < 0) {
-- 
2.53.0

