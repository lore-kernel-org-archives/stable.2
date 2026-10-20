Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467945;
	b=N7Lvr5rtvnUUnHPuBOaKX8eXIWGAdIipdTRZPKrsffNuheAhYVK48N18nenbDoFAF9/E
	 59va0YTMR7YTT+o6v4lfWR4Nt/2ohkKzChwCO2+R9AWFQ2X75SJEVwqQXksVQVBRK4JCU
	 TEZsY3PRa+yX3SmfZ5hyfP/8LMjLpkRA+MvnZZ1qpxDkQYUjSaCnjkBPeZQ3wUj5EIGJJ
	 R717xE6lpSyqonNZfEAn9b+zEIttcuV7jU57vr4ZyASsLw+09VD6QHhaSnk+BPWA3uRKb
	 ritRbdL+G9QwIOGS/2NpUSrF1pHUDWCPMCr8fbfyCnaofYWYha0HaQjvlzNqwNFeNnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ULuGvekLIA9kqLWF/rjFDFzz9QzEifCQafgwxDg8ZBU=;
	b=LRDOwXR1stctfksRO9Rp65CRdK1ul9dYs54VDUgN7rvIXR19yTjACVBQtKg9nvCDySSh
	 cGqMp995EmqNNfw1XQWjVj9dmOfKQTupABAXxBMBMSfg2mvVGi5wu8WqLfUM3QxNwH3JH
	 iKZQyRE10YfmekgL7ZGniuI9UdFC5RymSsK4QskGLTV20GjIVCoktigYCNWa7CPE5QwHn
	 PfoOX9c/VNh+GpTMHqEhyuZ75IJh9yP5sCC12Gj3HgKPUJ5PLP2N3JgOCS0dex3N6spLM
	 omn8PcCMDx2DF01xkl0kTPtI/dFxfr9v7M+kCUAASN4e6lelC6sjvhp3uoSmpgjor9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QNUydbyP;
	arc=none smtp.remote-ip=74.125.231.201
Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDD606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08DDD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QNUydbyP
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f61e12e8e0so290399b6e.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792467944; x=1793072744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULuGvekLIA9kqLWF/rjFDFzz9QzEifCQafgwxDg8ZBU=;
        b=QNUydbyPz7OjvEvLXsauM9XC4aZqXdk0GUCJxlwONwH6xc3ncdV30gJOAE3h0UlwG9
         ACMPDKSicxvuwyOa+VSoPt8r1WC7+AQI7PCPJfsMUFsf4U2lhRSdmBHPfFxvThSfCDpK
         /7AE3/AfuHijqSrz5AVovSgKi57dhOlPIiJ5qBVLCQ+3Ry3KnFR+M33loLvqzGSqc4CH
         phdCg+5ro093v3iTCZyOjMG6/U5IEXlYG5AGZMts6Fjr7bIqF4juQ/574qX3Bzk1KtEO
         NOJfku2kZUB48AoU62vl3dEKmFFeiZo7GK+/mSGccprSElJYgqwtsQau3pVKn/VzC+42
         VwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792467944; x=1793072744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULuGvekLIA9kqLWF/rjFDFzz9QzEifCQafgwxDg8ZBU=;
        b=aIGnmNwC5HfYvc3/0nnjx7sodVz3i2rNh19P22lJtAJp/32QiKwRgNnBznwNWyw3PF
         r/A1WvQ2s2jOJ+zaMj6Su+I6YZ6tFMM86ycEtD5EWkFQKB4G2d99y20Emw8RxC4rmopv
         VJGtTP7iccHh99E+x0Q5+z5IY9ZJ4q9Cnj2GcPW6swjMDniZgWS06YKnPYvrjSRxN8Ah
         EYKuGVjWJVSj+iv8/1E+15jCllJpWyw7kRuteBMFQ0Tvh6QmhJJw0nJkLdZLhD8diMwg
         eO9ECOGmfii0oxFplWZe5O8efwje3k5pnz2k0onPZsz6hVQqFtLEdmBMnZTq6UzLJv4S
         IZRw==
X-Forwarded-Encrypted: i=1; AKwUvBySP6sDR4cPl5aV4amVSH0qmzEkG67yNo0YC4cRJLWnNi4dyIYY2QSHHpKBb3O0xde4B2mSIzQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiObVBfs+4Ap1NGvvRspcxtCfZn90aOwK+QgmEPdrpEBfZSlwT
	Pwv5M1lAf7ZsILYkCag7Y1fXr/5fh7GFRdig01Ejz+iskSAQ6nsinUiL
X-Gm-Gg: AYBFou2Xm3lyMgTDdUxUOW2z9syuQ1DHAt1AamETRro0pScS87yuzzq1W2JPO9pXr9l
	ej5jN7Nk4tsac8ajaDdFKPNL5w4TX86APIbOyZdapJXYEq1MFoNXF2AVDxKkSwgNG37NbTFFaIt
	ZZBOeAbMSbdMX+PU6HTPvJiNVQgU7kTCx8SE2f4V+gRfVQklMZADqudOps7HhJrc5qoa78Ojep9
	mi+OyWUya2W8ek4K2fv4AUv3/QWvlwCQndxHkn7LOardtUar9SFfo12SuIzFFPaQboN+DydmPgD
	EIb43nEw2CE6zDWD00KYW8cEtLsSNzjCd4FQG1R1S5ALcYn3IRIP4uB8LZJGcTDYwu/l84qP6mp
	LLUMy1WnczuGeNFc+oAAmi0/7sIHaqdplLQvIW9ArupLEiocUK5ikEjkAJzBc3vbmitpTfV18vC
	afbwtbYFAoW1QNRU8ARIQUfiDU+1EZCvtdtWeMeh0r6w9wwLCrDEvXrel9IJszsARY6UUTg60M3
	yE1pSFsHHy7sPgKDpRzoG4AWfMftoEd/rDq
X-Received: by 2002:a05:6830:719c:b0:81f:92c9:1f80 with SMTP id 46e09a7af769-844ffcda39emr8967693a34.16.1792467943952;
        Mon, 19 Oct 2026 20:45:43 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8498d1a4bfdsm4387344a34.20.2026.10.19.20.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:45:43 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Seungwon Bae <qotmddnjs@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] vxlan: reject adding a remote to a nexthop fdb entry
Date: Tue, 20 Oct 2026 11:45:31 +0800
Message-ID: <20261020034531.1420194-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

FDB entries backed by a nexthop group must not carry a remote
destination list.  vxlan_fdb_update_existing() currently appends a
remote via vxlan_fdb_append() on an NLM_F_APPEND request with a
multicast or zero MAC even when the entry is backed by a nexthop,
breaking that invariant through three different callers:

- "bridge fdb append" with a dst on a nexthop entry;
- "ip link set dev vx0 type vxlan remote <ip>" (vxlan_changelink());
- "bridge vni add/change ... group <mcast>" on a vnifilter device
  (vxlan_update_default_fdb_entry()).

All three reach the append block with nhid == 0 and a PERMANENT
state, so they pass the earlier nexthop checks.

Reject the combination at the top of vxlan_fdb_update_existing(),
next to the existing nexthop guards, so a refused request has no
side effects: placing the check in the append block instead would
return -EOPNOTSUPP only after the entry state and flags have been
rewritten, skipping both the notification pass and the err_notify
rollback.

Note the resulting behavior change for the two rtnetlink callers:
operations that previously succeeded while silently attaching an
unused remote to a nexthop entry now fail with extack
"Cannot add a remote to a nexthop fdb entry".

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v2: Move the check before the entry state/flags update, next to the
    other nexthop guards, so a rejected request cannot leave the
    entry half-updated with notifications skipped (reported by
    sashiko, confirmed by Jakub); reword the extack message and
    document the behavior change for the vxlan_changelink() and
    vnifilter callers.

 drivers/net/vxlan/vxlan_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e58..83dcede2ca62f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1002,6 +1002,15 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
+	if (rcu_access_pointer(f->nh) &&
+	    (flags & NLM_F_APPEND) &&
+	    (is_multicast_ether_addr(f->key.eth_addr) ||
+	     is_zero_ether_addr(f->key.eth_addr))) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot add a remote to a nexthop fdb entry");
+		return -EOPNOTSUPP;
+	}
+
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
-- 
2.43.7
