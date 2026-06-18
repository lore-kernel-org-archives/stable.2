Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64933BFAD0
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794210; cv=none; b=BYZpULZvy2ZovVLrnI4NU0QCsGm1IWH5zppX3UtxCupt7Xx4fJ6WqoL+RA8SH5bxPshXmhgU1j8sK+fQcf0nZOlUhp7Fz/Tyt+WxPt6CxBUT8PoqyJ3Ttxl9MnG4N7sUXy45mdDbenaNCo+wr64/LHZw1cEfwdWlJffCltGPuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794210; c=relaxed/simple;
	bh=ebfiHxJXCBorfmGp3WjFdqGfKJbX3u6ZqUXNuY7295I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h33MJc2snfZQdejDlFR6IkLgzgTN4+NmujFjmT9JS5ILcFuRlKI7qd7sr8PVvoVFtzlCPr/F5pgG4vMW1x/RwDf6M+rc9mzQe6qtdO6uQYtwNxQGvT1NhQ/ZoB2DyuuWHTUQ4i4lQR7G/noq9eNh8MUadxXu7xjQN3qfbtOoXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=OWe3wKCp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="OWe3wKCp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-464192ab2e1so537290f8f.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781794206; x=1782399006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGgWyECjMo0A+7T5xX6MZZ8UBQzM1ZYjMx5fmvyGYBI=;
        b=OWe3wKCpatSlqAJ0W4mfntjH8iNWNZGerCIVxVNBwcq3/U9JgJ2m3yFpLQ5LuLdjND
         xWrZjRN1+qrQhoUP61bExW1pJox9IjKseH/HgNbVyigGjyM1GQAPHK/QNPBbPjHijAcp
         0YRmG2ZTAC0NMUf/qqV3zuQFbf+mkMtSHMZoOHDFUi3u9hwDvKkGZ8Ri+sW9VI0+SX1U
         QKByRdO+B1GyOzIiGww8Y//Zc5KDFyk6uphFfLFeFjfhZG/Is1U0diZ8ETYG2mQSo0tY
         LCcIh7LVAeOFOYsVzQkZFRD2mNsKz2C3jz00bdodGoOC+Ni4nEyySfhQU66P35nr9Jvx
         FFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781794206; x=1782399006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGgWyECjMo0A+7T5xX6MZZ8UBQzM1ZYjMx5fmvyGYBI=;
        b=L8KQoG1wwGi2Gk4bj7zlzoUylNc4en/5fIg5/GP7HLZ59Hec8LsyOXjQcnyRDEWz23
         5qy8QbpZnnHGMd7uyTx7Xh913fJUGPONGggs2iQi3JRRCv09UWYmKed2bPHUqelgLxMA
         iLER8syJ0FPsbunLpG+jD/+PhrQweCqKSOWYvq1brjM3hr3bDNC2e66/eN28MRonqRtL
         Bkj3Mo5iV+2oD6XIM+kbV86/gXkeeLztzQDalLOunIa6Tvvxw80EiEmltCKwbWvNWoft
         929E8PEfGjEMdzWPkws8mjWoqVbECtWhbqur5i6GlGtJ+ul/Crvi89yYXGZIjTnb28pb
         H+MA==
X-Forwarded-Encrypted: i=1; AFNElJ/y5y4h52gn7rtLH6gIZzed0xJUsZQR8jQTawY9yOwumudyPGWzhAjrJlv8USlOaE6agrO12Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWXkl0NrVfTWGM+v+aAKJmjyD5dmLi6XncN3a5XWiVcd7tXi9
	dUYM+p0iOSszuyf+aI/zY5MjU2NdGe80OFg4/h92d18lSpF/PEJnIYhA60s7EiOBtO2j
X-Gm-Gg: AfdE7cliNc05ZitArFD0OpF4phmrw/DlaKmX/DNyR6/olpLS9gZRSyHrTD7gitYrwtr
	TYE5vHJ1uOFebYBWiV1qw1NUSNMiNi98yM71uDfEDBD7LG6ZGWKhYXFMqlKhASiVkX8HiQZ6JnQ
	3ZTN0/SKURYiJ7s+7PAqS5GUHEIoVcnckdg+EYbnwYKYNq6wKkBT0JQkDrI1mjV9Nj74yecjTs+
	ENdKczycujmZy/Zmpdptc02JJItEnQsBAAtIVy/EVEVkEBzS7TXoQ57qrTnqeYVgx0hCc1u2yrE
	83HmIibE9hs/ufvcrRSVk4Lrp1OeNMMa2euAQN9SSwbBtdksrL2GjOtuF/5N4O1V9rMX+iNpxkw
	HLqM/d4Tv4Ru9OaPd47T9pbcUMTVRXr5UUajK/rKbGxNmVXNIA/nzU8Yq40Gsk60YENyoqgULaa
	88Bgv+KSn+GE3fzK7OkbjJv7ws7wt4HX1ayfCcqshkgJJO0S0fNV5DnwMmLsnQeNMdADfvMJBQI
	uReKyUNO5IU5HLT8z+JGzqYPf1cYC9NmaU=
X-Received: by 2002:a5d:5f87:0:b0:45d:3cb0:5ab1 with SMTP id ffacd0b85a97d-463ad9ade76mr6300952f8f.38.1781794205917;
        Thu, 18 Jun 2026 07:50:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm66701717f8f.36.2026.06.18.07.50.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jun 2026 07:50:05 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: michal.swiatkowski@linux.intel.com,
	wojciech.drewek@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v2] ice: eswitch: fix use-after-free of metadata_dst in repr release
Date: Thu, 18 Jun 2026 16:50:03 +0200
Message-ID: <20260618145003.47471-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_eswitch_release_repr() frees the port representor metadata_dst via
metadata_dst_free(), which directly kfree()s the object and ignores the
dst_entry refcount. The eswitch slow-path TX routine
ice_eswitch_port_start_xmit() takes a reference on this dst with
dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
is still in flight (e.g. queued in a qdisc) when the representor is torn
down, the metadata_dst is freed while the skb still points at it. When
the skb is later freed, dst_release() operates on already-freed memory.

Replace metadata_dst_free() with dst_release() so the metadata_dst is
freed only after the last reference is dropped. The dst subsystem frees
metadata_dst objects from dst_destroy() once the refcount reaches zero
(DST_METADATA is set by metadata_dst_alloc()).

Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
nft_tunnel: fix use-after-free on object destroy").

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
 - Correct the Fixes: tag to 1a1c40df2e80 ("ice: set and release
   switchdev environment"); the previously cited fff292b47ac1 only moved
   the affected code rather than introducing the unbalanced free, and the
   bug dates back to when switchdev support was added (Simon Horman).
 - Add Simon Horman's Reviewed-by. No functional change.

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f..41b30a7ca4a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
 		return;

 	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-	metadata_dst_free(repr->dst);
+	dst_release(&repr->dst->dst);
 	repr->dst = NULL;
 	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 				       ICE_FWD_TO_VSI);
--
2.43.0
