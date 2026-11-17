Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907602;
	b=5YGDMlmte9z0umRECPt3uKgDRfz7ZwmmWJLSxbP6jllYJ3NoSy2nij4+aEO732AdoNel
	 fxRorjDLrG4/xAkr48gi6PFkbU8PWbr/h+uZ5Dp8Bz+YtnOFH06TqoqGsho1qRvr7nTdX
	 hcgCxsRykFkh+0uNHfrOWYpatVayzJBTA+gj/TYr8Fwr8rtmfcIG6qfeajANX7B769qw+
	 suYqEMuetQZ/hY4mohm1GheObDdCdS8JYCdNpRu10mDe/51sqGWeZxeZh0agWwYSYNDEC
	 eO3GaxPJ3b5osp9t/p5W/WEelymCkKP0MBqgzAzm2Y5S5a7OHhmhTmGlH+XlExAiMEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aDSdHKsmTGGWkDOKCvZtMPEPFRR2Z2wRDeQx9ZQTN3o=;
	b=pM1ivold669BQIZwWvVM+BFdLOMzY1MFhIfRBeh2LZYe8hdny+WBdSEjCSCD+SC+jpa8
	 DU85Koa4G5q6witrC8GMfd8mKRy80H7JF2Fo/kyJ+thlnfB0NTPhNcVuDCfW9p0iKbKzP
	 KGxSmze8gigCwxJA1xBt1rbVRJ3G8VNa9ss3Jd5gWni9bbm/7hmAHMhKr1gG/NukBbOnG
	 3qY+Xp1XK7wYbqq37ebc9IeXayvTyh0q30WnrTtZhcfpau+jQvjOqZXXoa5DKeNJRMLuI
	 phpAnj2pOnRh/hcNdcru3pYvpXlE6Fdj3hIEKlGvHltjXR5b3YUBS7bzo27AGgIcibQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jAuoeEgA;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B07606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B07606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jAuoeEgA
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36e06480786so1259336eec.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794907601; x=1795512401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aDSdHKsmTGGWkDOKCvZtMPEPFRR2Z2wRDeQx9ZQTN3o=;
        b=jAuoeEgAIiCWcKmhSa5GCBAsqHwub3zPc+dFfc8j1Gix3S95u8xQ5PJz24Ae/grl6i
         ZusUURfcLilUuLUXY85sjls5B6JzYrMNsLe8EPPihrnTxxcuy+9bGQ0qfOIRNNknA+Sv
         f0fS0SO92W1+PCQTQ0+iK3l1IOPskEUk54fjptJeO0OnukVqDpp8rE2b52Opva7sWRkz
         NDHzU7d50iImwpoOG7l3hx1PptqFC95pZveLHQTWUjxnuylvfyBpTOGPlC8WUdZlUzjw
         L+ZmqDgr9BjPkhb2k4KxZ4UvAh9qZgWw+AwSA/f6Z4IpzPa2EHHy0xNyL2vv0oTvXR5I
         v5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794907601; x=1795512401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aDSdHKsmTGGWkDOKCvZtMPEPFRR2Z2wRDeQx9ZQTN3o=;
        b=eM8CHpcNmx/3VZM5e9f6EfV86V9Jx3AcOAZ6gtyjC51rZAxau8D7lYSjyaw2+2nT71
         z9u4cRjZd9G3vToEtpNUyRu1/OJf2BGeMKUaFIofZLCTfhc9GqAAM5aK55Xq9t/k1lpV
         02v4qcin4Q1zuEIy4CzhIbfiKlaO139NpDpVaWZ5hrHC6une8iJgoLdIDjWds3ktjbdm
         ri9ixcMzE3ZQUu5oJNUz4sTdvRm84azcKX6jOTCWLW41IGf5PArqoSxzEAZCUTXKU7PO
         Ht+NDodKoqRSfZMQ89NI46FoX/uliNnraQ4UWdCzvyRzYZCdridD9XvHJUIZoBqHUkEf
         f+kg==
X-Gm-Message-State: APuU4Z8OwHBSfcD36qyAtbxYA5LkTdZWcWTZSGWt3lZrQRBLJN9JATAK
	9Xqgpn0pmEuPJ/tbcQTFMj46smc1+jxjntEzosUWloPWBNR8zV1LfWF8
X-Gm-Gg: AYBFou2HdZ+ehZuuMJEC12rMjjwczzTeAO5tnN7JfKVhZaIqBnFmZpjSwrYMo5PBjfO
	jzPUff53x8ohMeNcrlrdwZYMrlPXxKDIZotl1kJ7S1dVQa0KDeIyYbci3ZV+7itlJaso3MFuYoE
	jDs8aymYGBSWF+s2c3Couqr7UwFx3/zfJF+obaVUC08+jUAsV8Gy/4119sgV0j/gjgDRy6tO4Qd
	b9Bh2dOO1g2HdlDs6FUlTAjfsRbuflptOUB0Q13sdeJUfdQ36RRMkAokZEVGLvLwN1AY5zxY4uI
	75TO0QngTyRt2yX0cWriVFGX8ca+Y8QJ736ySOPx/h5D7AGPPsgNB/PKyhLtAw5D/aidFrr1Uhb
	VmkQcPeaz25ezvocjrZXe+BA6MoOFm+3nXUYyig3R7TvdZpyxAyjtQM4TLoYhs8nKlcltDcUoNW
	3vne5h2w2lgg/k0mDccfm40vHXd4eUT7mBstGlBjmYa6JYyUmjSXzT7nI4vD45wRCqK4xrbDgLg
	n34EadvOPYM3DVftWUCZFyIfZx+7aGTpOB+lUutkrzkFkwF4nVDJKsaX3UIllUMYHwMqGi5Q11W
	YmJdrnbJ7hXmwtFfbS3M0AWBjRe5iC4KJawMJEyAbsER+NTEYVSM9a4=
X-Received: by 2002:a05:7301:4e47:b0:369:f18f:3492 with SMTP id 5a478bee46e88-379676faa4emr12927815eec.35.1794907600961;
        Tue, 17 Nov 2026 01:26:40 -0800 (PST)
Received: from DESKTOP-GSNRJ5L.tail4a8ad8.ts.net ([104.28.223.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm45794999eec.23.2026.11.17.01.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:26:40 -0800 (PST)
From: onLeaf <onleaf322@gmail.com>
To: onleaf322@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH net] netfilter: ipset: exclude add-path GC during resize
Date: Tue, 17 Nov 2026 18:26:31 +0900
Message-ID: <20261117092631.14530-1-onleaf322@gmail.com>
X-Mailer: git-send-email 2.43.0
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

mtype_resize() copies elements to the new table including their extension
pointers. Garbage collection of an expired element in the old table after
the copy therefore frees an extension still referenced by the new table.

Commit cffcf57bf03c ("netfilter: ipset: exclude gc when resize is in
progress") prevents the delayed-work collector from running during resize.
However, mtype_add() also invokes mtype_gc_do() directly when its target
region is full. The packet path can enter this call while a userspace
resize is copying the old table. It then frees the old copy's comment, and
collection of the published copy queues the same object for freeing again.

An unprivileged process can reach packet-side ipset add with CAP_NET_ADMIN
in newly created user and network namespaces. The resulting duplicate free
was reproduced with KASAN on x86-64 and exploited from UID 1000 to UID 0 in
the initial user namespace on a non-KASAN build.

Serialize the direct collector with the same GC lock and honor the pinned
table's resizing flag, just as the delayed-work collector does. The table
remains pinned by uref while the lock is held.

The issue was found through AI-assisted source review. On the fixed kernel,
the same copy/old-GC/publish/new-GC ordering completed without producing a
duplicate object; /etc/passwd remained unchanged and the test ended in
LPE_FAIL.

This change was prepared with assistance from OpenAI Codex.

Fixes: f66ee0410b1c ("netfilter: ipset: Fix "INFO: rcu detected stall in hash_xxx" reports")
Cc: stable@vger.kernel.org
Signed-off-by: onLeaf <onleaf322@gmail.com>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 80ca523f304b..70f768ba7b44 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -1009,8 +1009,12 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	maxelem = t->maxelem;
 	if (elements >= maxelem) {
 		u32 e;
-		if (SET_WITH_TIMEOUT(set))
-			mtype_gc_do(set, h, t, r);
+		if (SET_WITH_TIMEOUT(set)) {
+			spin_lock_bh(&h->gc.lock);
+			if (!t->resizing)
+				mtype_gc_do(set, h, t, r);
+			spin_unlock_bh(&h->gc.lock);
+		}
 		maxelem = h->maxelem;
 		elements = 0;
 		for (e = 0; e < ahash_numof_locks(t->htable_bits); e++)
-- 
2.43.0

