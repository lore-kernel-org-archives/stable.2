Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CDB33438F
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823803; cv=none; b=sHazQ2zsBEJYjjJD0bV7j0B7cokWxNO1vPZ/ycxyqde1gKIRoefyM/ysEgVi1dYkyG61JIg5HItOrwbD2DMDgWopxRPp7DsNvPJHcBS8rPrT5tzRN81CpziM3L/QwOJwv6yZ2Q6OIvo73h+ao0ZO9qb3mj04Og+Cqgx6dBNr/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823803; c=relaxed/simple;
	bh=hoBcQLufPj2/EG+NglGciSArXHLoJN4T/RIwQYNKVmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCru4uZjNTfFjBdQhBzHGNO5w/V8sNO96t3MVC7BDByClLTO93oBEnC5FAB35oJCXIvcAIph17aVVvuujpoetshNP4Ujc0kNZ5b4KwHH8WzrM60z8u5z7zCUy5WwGmKKx+tO1GWGV20+B/Qocm1PK4iso2d/Lp2d06Gb5AyAy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kPlDBj90; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kPlDBj90"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e55b62640so199416285a.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 23:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785823800; x=1786428600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C9tpyP4DZI5UiWip+9VyOdslieTAF/jyWhJQO7HCZHE=;
        b=kPlDBj90P3bbhP5+hnQjotXEoVzY65HhP+a1ZX2RHToahUmoRON5fyq+/1ma9Dweti
         LRWeoKY5K7vyJirBK3XNBhXOdTWdRx3ONh4eeVjx3meCpo1iJxOTbrA+SRqyhe96f9Eq
         xw43oX0bfaq96PtJxvvszcg3Fve8f+JzTvleAnyRgofwyKDXC30yJW14e+4b3ev1yZF0
         +Qskbn7natNW4PVq+ZnWvZKhXe1jGGkewPrLQC9KCMTjYYzhVHnxf4PxRYhu6jQLh87i
         72rDqa+NmgeNWXM78de103TIt3T8i0meMTYQ6g4slVagrcictYgDOH+pDHt/DSOCyyYY
         6Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823800; x=1786428600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C9tpyP4DZI5UiWip+9VyOdslieTAF/jyWhJQO7HCZHE=;
        b=bxrQgk/fmEI6sq8ld6/iU/yumZan5EZc0zqgzxL8WvDCX0WqGvWXJOiZNSXA4rDt/l
         v0ry0oUVj41l4P9//03onpdVrdCcWNYpq6A3jSkB+EwdJnsd91WvdZ/HhE4uLrgA4LA4
         hYkic+GXflJThjKnhiXF8F5K6SkH2iLjgkjn1O2KHFfEKR6W6kz3/O3R1EmLefgnq31z
         XVqOpfX8J09YYz079SJ3FLbRC0S+jdy+q5DPGX+4QHjSc4cure2aIGjjRFjcBm1lEeHe
         D9fPcBWR8AqxYsSVyOlOtVgGHOYLmbNLRd0EQvB9OXAkNLOVUVfpmczj8toc3itZCHFN
         RJpw==
X-Forwarded-Encrypted: i=1; AHgh+RrbvRqT5vqc8XgKLrTqBTplIpX8bgG/lpOspqb8UfgCr+Qy+rmj9/TZ9dOkWhDbe7ILK0XZaek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRoR5KdP4jaaA03UEaofOgJCv8VWefsVK/y6Oy+cPbe01372w
	d+950NTBU4D8aKcChhKOkBuDvFYuMgIN4NLQPBMS4qqw6gOeuU8CDKbVBRBH7D8lqKE=
X-Gm-Gg: AR+sD10Ip+buFfFaKBG8D3DQyVeiRGmJEBRehLrssmTVov35jFfxShGyL2r3ki10+aX
	NkrqzD8RlF1OBOxv9h154NScxgLIGWsR20sDecoSUy2duHPNxmOTJ/aNdKlKrHUj7b4RP1bVU3Y
	JnzeOF/avkBKx9FMoP4sYHXlUjT3FO7mKUUda1Dd2PKIokosACDTwmhknJ7ZaRsGAMMhEFTRydK
	2Fn0zEo2R7AQFp2iy9PGOuRrWnuOy4TbXT5CoevoTk+7La7p1mqF7DVbmrDCXjheAlGOm0xeMt0
	ZvpSq0GmIlGSF8vtLUnteF2ulCkhMWTWANaS8vZ4MPWoDNPvQh0skOLK2CsmkRQM7GjmzfLEDtI
	EBnkltULC7MxW+fDqOkRBJLByR23jsYe+9k1N61Q+w5S3fPX2Xpyt+6hFzw+3z+hFSMu/PC+L4T
	6Y3TaSZlUdLkM4gERuVSW57V/uOsXgvsol+LV6QxaDrck7DLOz51EGAij/5q5lp90zMA==
X-Received: by 2002:a05:620a:2792:b0:92e:e125:55bb with SMTP id af79cd13be357-934a0750096mr2572674085a.4.1785823800003;
        Mon, 03 Aug 2026 23:10:00 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908432a0cb9sm93059666d6.7.2026.08.03.23.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:09:59 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v2] vxlan: keep the last remote linked during FDB flush
Date: Tue,  4 Aug 2026 06:09:58 +0000
Message-ID: <20260804060958.711335-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

A non-nexthop FDB entry is expected to have at least one remote while it
remains reachable through the FDB hash table. A filtered bulk flush
violates this invariant when every remote matches: It unlinks the last
remote in vxlan_fdb_dst_destroy() and only afterwards tells vxlan_flush()
to destroy the parent FDB entry.

An RCU reader can find the parent during this interval.
first_remote_rcu() then applies list_entry_rcu() to the empty list head,
producing an invalid remote pointer that the receive learning path can
read from and write to.

When a matching remote is the sole remaining remote, leave it linked and
ask the caller to destroy the entire FDB entry. vxlan_fdb_destroy() keeps
the remote attached while sending the deletion notification and removing
the parent from the lookup structures.

Fixes: c499fccb71cb ("vxlan: vxlan_core: Support FDB flushing by destination VNI")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add the net tree prefix to the subject.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.
- Add the recipients reported by netdev CI.

v1: https://lore.kernel.org/all/20260731141311.570187-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN slab-out-of-bounds read in vxlan_snoop() and can share if needed.

 drivers/net/vxlan/vxlan_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d834a4865..a00df127d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3058,6 +3058,11 @@ vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
 		if (!vxlan_fdb_flush_remote_matches(desc, rd))
 			continue;
 
+		if (list_is_singular(&f->remotes)) {
+			*p_destroy_fdb = true;
+			return;
+		}
+
 		vxlan_fdb_dst_destroy(vxlan, f, rd, true);
 		remotes_flushed = true;
 	}
-- 
2.53.0
