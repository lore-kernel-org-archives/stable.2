Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C043C5540
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690762; cv=none; b=neVdBMgvZ6QGq39HvnEWhDIVO576QL/IZRra2oJT3buWee2jLjqIXfibTUAPR8m/apFxV8Snf/eHtnggIMiBPYGm28FlIZ4GCeqvp3TOYoDGKdIFVYmHhUBvViL0kC3g750HiQq9dSlxv+4doSSVaok0vxXeK3Yqy6LCkbm0FVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690762; c=relaxed/simple;
	bh=hmliK8samJNpT3PJSWzQYDk1lSB+31K5rpAqv2pdv9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbWJjI8b1mtIO6v8FLq0bwqTWo2gZjrUZA3aERz7/wlQRnIPjXSBzivGKI63p3BJzZaOmLlGZFABcoFNvESbtp2DEkE/ed3enUOFoIuzNh5t+ERhiFkw0KGXcepnDXH8tbSTA5nJOi+yV9yiOllvAAcBrQtq0PFRbl4AIfxVJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=pg1mEsUN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="pg1mEsUN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so4168634f8f.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781690759; x=1782295559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFsSmP6aMO4TG59Hc8Zv34xLQSsBRpaPGd67pr1FIwc=;
        b=pg1mEsUNBDfRY+gSf/5TCzF8zqn9ST1QFtFYhIYqiGXayoKnoQHaHM+wYvMdm8VPiy
         kTRyJRrNf0huBCJXUF5eWqVoxhpFqjofmzUO1OMWAp4oN7s1IiQzCITUnhF0fGePqv3S
         H/MGnjyvxUrSbKNnMhp6/2bBkPlwzpTTreRhLxaSRZAJD5SGDgJQZOu/FWq96luCsx3W
         fQy7Jgq9PejRZFvHk0tDMRGWFbxc92F7tAAr7VsHkE0nzixmGYtzOPNlV4iPk9CaV5Fr
         pelBJfRSRWbRVoHEtNik2lLrHkdPTprqkZbfEtwcVd9+4M/Dkvp2nxmL+TcKK/qlNMFU
         Ns+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690759; x=1782295559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFsSmP6aMO4TG59Hc8Zv34xLQSsBRpaPGd67pr1FIwc=;
        b=Ggj4AbsOLZx2UO9Ec5av3fT+tYmqHjus5E5mrt0p5xBM2aSfy3I+xb8vdUaOzJK2W9
         v31hZrA9KjFWAnDRedn+L2QKkUOYEOMGM3YAde8Fet5TIMJRnGiEPCKftMR5eO5+513m
         CcPMtQX1sZxBunL1o/eqBGTReOUzDmf+tOcw9NfqqGvAHqmKHs3ESPYXWtO9elFeMyc0
         4nJm48P4aHd8LM2roc0FsTB1fI87a3QldDNp2N5CiLY64Old+D4VJPzchHL71M8mXakD
         TQHT8VtRHcjfYUCgUHRMRWACU3R9s9Q+6irt36ffjs6shbrMQr7DwdaCvuJ6h2pgsZDp
         WE1w==
X-Forwarded-Encrypted: i=1; AFNElJ9t+8ujU5YBxI1cegob8GRGkn9D7PzIbc3P7uPwh233umJpWo2XpGPKcLNPytFfpGf7htUPEFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFx3f+YlUBSkfCQQXWuySQP3Aj0jvEvkpmfd/n+OgbIqCj0sOD
	O7U5HstgxpxNRGoYvHYl/FpQUdefxoK3kEisfk3Yl/Cx+SDNL+C4rBQU1IO3/fvzzj1Q
X-Gm-Gg: AfdE7clXTO2CCXjTPGdKfkqE8t0cBBZ0g/yEINsJMFFLbgPPlwBN8EI2OudXutWT7mp
	Hy2mzj9ZeGoiZX+eBMMnhUWjbKy0gjTtzSgNHo+upxtEXkkphij3k2ibvXYJoEq6yFtzYN8WLAV
	eMuPmXO449RN9/atSeTfP5ZqzzL8b5F/pzxFLVhOXtNnFlyh/gQ9gC7u3tCRd3fW0Pm6McnamU0
	9sExD85nqwI5NoV1yFOLeL3F3nPmVAt3QlDVzYObsKEGdgKlHIyW6E2j/VEGuYjB/ITAi8K63kr
	f7+reAQFXvi/0OVVXe++gnuEcoeRtTMa0a+LIQ4L49w6Z63RFcU+Xcz2VEs00Eaf1W8UiRMUF7L
	Jz9f4euQ8kGMKnwlnotNdj3JUP39UxS/t4o5UETx38Ck0q/BA9rQynDgxw63UAkFB9g51ibRZOu
	QgaSygQFIdpP48tR4G39Py2AbuMRHhByc/tUB6oGyuyJj2QyFIW/swsRvAY10rFU1ElmUkNwQrF
	c7XKpPOL9w6JZT6dp1+YdsXPp7QwTUwxlQ=
X-Received: by 2002:a05:6000:2302:b0:461:a159:98c6 with SMTP id ffacd0b85a97d-46235e9ac51mr5885239f8f.6.1781690758585;
        Wed, 17 Jun 2026 03:05:58 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm55033847f8f.11.2026.06.17.03.05.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jun 2026 03:05:58 -0700 (PDT)
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
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v2] ice: eswitch: fix use-after-free of metadata_dst in repr release
Date: Wed, 17 Jun 2026 12:05:56 +0200
Message-ID: <20260617100556.83620-1-doruk@0sec.ai>
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
  - Correct the Fixes: tag to the commit that introduced the switchdev
    teardown (Simon Horman); add his Reviewed-by. No functional change.
 v1: https://lore.kernel.org/netdev/20260615140532.52676-1-doruk@0sec.ai/

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

