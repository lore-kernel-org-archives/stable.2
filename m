Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413918;
	b=qgmpNe0/ALXtBXEr6NILUukT5YeiI6e78GdqXM1VcG9ddTxa/R1bmPSWe6AMywL+nuTe
	 JS6EI89FklBcAh2A62DDX3dcbJcHFWDCZDmgxhQQFwTSfCbepzMLeDpcjuY+Y01TI21TC
	 9QbsOUaqv3wsB0OJFXqaW+1c8dO3dOu/wbLBc8NKr/qRO8w1ceCfD+dx4XD3oFvncGryb
	 1pmlQRusNUUDqBnTjz8i+rUMDsSAVOFKeUcEKwkwHplr6MUZRZ3xKH5aWRs1S6axT6S4F
	 +nJcj+WnKf8UA/b93Pb5fBdDtVDvyPQOMlnnG7BDjo74l8wHe6NZww9Mgbw/YBZ3G8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=th4q9b08lCLfMlfvam+Sv2PUGdwUZSEvcq1PM3dYcnM=;
	b=VZltifsEDoXGWjGSC2FbeiwhXa0RnTJrRAYfjzIFqDNaCM4VpU3bOhGLz4RsMarAoLov
	 Ue92sfQFKjxM19Ua+fpVdqBKDLRvjKY8ey+fIcxBL1uCIaxkXtvdL56EpcDLinObZt4mH
	 3rtMrNfyHPEJc0fcWzvVt0c/kBthccKe6fyTnQpMTHkHNUAN6Oos9B8r0uuZeb5EO8I8y
	 92yud/ZKZUZDslpN0M1WKYR1d183j8H4Qv5U0QwVLE3DNxAr6FxYtMELEwpy62UDNP6x2
	 S0ka5kaeYagiBFhPcGxRzfBdD8HVV+riKxBSaiFdcno+t3b8aRL3cDbE5AeB20tiOGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=RXGhKNJV;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361B606A885
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B361B606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=RXGhKNJV
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-49465892f7bso2433512f8f.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413916; x=1795018716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=th4q9b08lCLfMlfvam+Sv2PUGdwUZSEvcq1PM3dYcnM=;
        b=RXGhKNJVl1lv5SHKHOJa/S6JDrV8Sp20C/S2L9eAEz/GwvO9FFqGvg+hqQeTBNImNv
         9mCebGGOeLY4rMcUFsR+BUx7/yVL+ZuB96xAIjCLBvVU7/5YLJXZb9rWUBgFK1KBfh9T
         XbVYvEH8+jwQUhVtF5nk/sd43TdWD9t73HlAanUJDzaBrfU7jzzDGaX5N8tMRgTch3I+
         5PBXLDn94OFgCx8/kLnwt/jjsJng0zh2xGyt4Unc8jAZifcjPQGkLWvSe6Y/a/gtCyLa
         unfkx/D1eHjK7NcoIgmwkXgrcdled0Aze/hMHK7GO97zGSEo/jTnnyPh39iq93B/cydT
         MT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413916; x=1795018716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=th4q9b08lCLfMlfvam+Sv2PUGdwUZSEvcq1PM3dYcnM=;
        b=n6lcfFQY3h1h99COWk4eHegk3ul+wzLoKV105SWXqjn81PdcwwVKpHdCAfDtodtW1p
         68YoOyJoaxnm8pbw++4jsMR0x0CDkK1L8mMEMTSIO/IhGmuVCTROIvAi3ieKErAaXPNR
         RDWQItb6aZ9axwebtSkxHHCuJ3NiSjnfa+Axxf56iQ0qqq6F+Oa9jVXI9gxodazpg34n
         Ns6+idfyjzRLijlM0o7tjeV7YFuK3jSSGqH/s5AyKte+Cl04SFSQLqaa6WF8+zOoEtUU
         ueygN1d9eFmnQ/MnGwBKYiz99uVxGVdV71q2qXiLSwsdZnDrK+h5YOFcH3SRR7kV0met
         7yPQ==
X-Forwarded-Encrypted: i=1; AL+hErEOPzJFytcOpA8iMhm2oZxQNwamX28zLBNki4w7cajzsDrKq9fsWDiAKIi9LjHlBdotwh4Z0io=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WtCvWBSOiKm8jB7F6lsUF6yjkNq6U+dw5xiBwAk4QeeLByF7k
	kfzZVWT0vRwdKPMHvP9uZ3vuYifo1sc9bVLuoiA6i9mCWpd3nM9w2shMqicocRBQYP4=
X-Gm-Gg: AYBFou2lbwyqCvcg0emZ9zdxDEgPD07UUHgifXJkfy9EruxG9YZ1Kl/7TXYTRT+HEcm
	BvWYb30rsYkO4VYUxFqM7AJ22aRLQT+DeckdX1Rt2ywVtoloyICjoBmIcuYuMRMVUrccthaj8+a
	4FIDULat68NPsqMEfXQU0VzA4eqssaom9+6dZiCJlGgZhoiVv3soNXMK0f9rmuvLezH3dK/lcOM
	+sUZea2MC2g9IYhj2s7+rOu3jAZhC4k32VMh73FRWay7Ld7f51hHvWCKsf7o0bz0OE0nLQbnOhL
	tZY+3T8ypzBvasfk/JMQ5gbGm7NpEIrEjCQRGYedHj+Py3ZDriwz1A1kLJM42qNe9O3U3RFH9av
	/ISJ9wCkbrQHc1VGAZ/v33js321QdFqHJ8If2DCVRcC8zkAJ94lyy8PRAc2+6hW3BHEO3c/zgdP
	LMIyvFNz1EKxQ/P0wbdgY7QdcLgxEIK7v6xuyivKUL7tu+TUUeu/2HMHy/KJ+t+AUgrqs4S/Ql9
	Vull9PjSbJIRQvd4jpkEhA3w0SNsQ0UORU4Jcabgai5Kyici+BY3MDNVg7hjYNcq+64sr08OIT1
	ltklc67IMB5LpU7meb0MvelDkM43zc+nFpky1uQeOBi6dA8qLzZM4KI1sh8rcwL55ZSZ8Co6R3m
	ljHtDnO3zQJwybGke2Mah8ojct+dUqg==
X-Received: by 2002:a5d:5d13:0:b0:48e:2108:4d28 with SMTP id ffacd0b85a97d-499c60275ebmr6470199f8f.13.1794413916177;
        Wed, 11 Nov 2026 08:18:36 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:35 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/9] ceph: fix mdsmap use-after-free in debugfs mdsmap_show()
Date: Wed, 11 Nov 2026 17:18:23 +0100
Message-ID: <20261111161830.1336485-3-max.kellermann@ionos.com>
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

mdsmap_show() walks mdsc->mdsmap without holding mdsc->mutex, but
ceph_mdsc_handle_mdsmap() replaces the mdsmap and frees the old one
under that mutex.  Reading the debugfs "mdsmap" file while an MDS
changes state can therefore access freed memory, including the m_info
array.

Hold mdsc->mutex while printing the map.

Fixes: 76aa844d5b2f ("ceph: debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/debugfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 6a9a5551d9d7..01c9f1896aa1 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -59,11 +59,17 @@ static int mdsmap_show(struct seq_file *s, void *p)
 {
 	int i;
 	struct ceph_fs_client *fsc = s->private;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mdsmap *mdsmap;
 
-	if (!fsc->mdsc || !fsc->mdsc->mdsmap)
+	if (!mdsc)
 		return 0;
-	mdsmap = fsc->mdsc->mdsmap;
+
+	/* ceph_mdsc_handle_mdsmap() replaces and frees the mdsmap */
+	mutex_lock(&mdsc->mutex);
+	mdsmap = mdsc->mdsmap;
+	if (!mdsmap)
+		goto out;
 	seq_printf(s, "epoch %d\n", mdsmap->m_epoch);
 	seq_printf(s, "root %d\n", mdsmap->m_root);
 	seq_printf(s, "max_mds %d\n", mdsmap->m_max_mds);
@@ -76,6 +82,8 @@ static int mdsmap_show(struct seq_file *s, void *p)
 			       ceph_pr_addr(addr),
 			       ceph_mds_state_name(state));
 	}
+out:
+	mutex_unlock(&mdsc->mutex);
 	return 0;
 }
 
-- 
2.53.0

