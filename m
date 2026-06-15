Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF73F6C59
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532340; cv=none; b=SwHvlRpbJHrypYtLlp9iIY7iC/9jZyz0Y+gJykROK0sgStRZNuBcOgBlny+6LQOFNdKAOHqiEGkFEUW1GY+yGS5I/J8HvYKC8ciaLjdGkTmjCqS5BfkxNtI8Y+U3Pf0dgjIJ4B7WUKSi1ErGiEE1AoK/f0f4z8W6Ra6+s3aUHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532340; c=relaxed/simple;
	bh=WEKfdR3nIfiUBVE84Vc5XVgzZju8SkfK1ojCBLqiM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwxIlkZkLcHOL9N7nvOmd7ptrpMxVpqANkLu0qHjLSx/matj63NC9sqsQozNfDwv+uTCeWOyF/Rhs5AC9UWMHcCPMExVnz7QKPrs9+GwyzbMqRk//+RNCbV3S7lDU7+oOl2GrTkZe3WvtrpbO+HNd98kIP6Rcxu+ML+JjTbDb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=EKySjeyz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="EKySjeyz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490a76757e5so24528875e9.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781532335; x=1782137135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cvAw1dsEWiSRXIXzLCtyB3OxbKLq8//WuTTzMwNXLh4=;
        b=EKySjeyzwVR2/b6wcOTqk0G9chk5aVfbuDom3iyG2nsa867olWyjzEYgRdgVATTf+v
         Vk4YQOGGQsJtFRAigF2e6sgD6rIOW9Xoax4GGSCfvwEEXeGNrcLFQwako20qHddp0CHS
         iNP/QZNWjm4roTQjLgtVONL/M1Huj/0jL8ohQx161EAyIdolIkPRkGiDhu+fx/fj/V/S
         OlHIiXc3D7zV/YyiP64jIttKzu+A0WDmHCSiFw5ak7qVAQnDq2D+o3UpT8kYUu9FaLhC
         UTiBnpFzk4l27gW5WyGY3fbL1LdZ//tzXCmqwmCroyLaknk//RF1TPBrTKOC+tU/UeYr
         g+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532335; x=1782137135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvAw1dsEWiSRXIXzLCtyB3OxbKLq8//WuTTzMwNXLh4=;
        b=FLQI2cCkwyziUCMUkNoBV87bP36gwJNWxNFsKP8vpKMxfzM4wco1yEhWGj+zK6Zs+W
         GezdnadcYLZi19D79SmnChqMU1honWbVOTFrhkxNSLJnSGdcCl4Yyb0onaEvrIhTYxGy
         gBkKpRRu1+3RUZnSRaeaQO0TmxBfkmrA0yXDgB5EEzfnTYTtQHs78jvMQhnBGWYaB1LI
         YyeauljCwR4m1mn2F8r30EwDDy1B/aXU/j/Mdg0D03V+ggweK5wYUm0tUScPVCATMoMp
         ze1h3A/QNluFs1TdZ9ngpn4g+8UkJlJqWXJI43TFk3KEqCXHJf94CUruNHD4AqQ6myy/
         PurA==
X-Forwarded-Encrypted: i=1; AFNElJ8iohmxgOF9mKcqxbZkPxgNqjUeUkC8Q81IcUz4cgK3jYnIIGzBJhFY0Uj4IXoouwoeYe+lkJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nIjLZN7aHDeHCluS/WXdJbkax5lNh0neLezqxlo3L9RYdy9x
	LX2B1WqqgP6Oiu+OGRP2ehmSU+v6TvOXq0zoRJ+7JSaGfz8Ep6eR3ugQEVAGSaByljAz
X-Gm-Gg: Acq92OGt6PTf6IaD7XbMrouf3tVqcjDM11ShOa9gGWjqHiucAlwzrhJJLT159AQvMRz
	1ZyYePovEzHayKHBe7dXsiZDWIyU4tivpDZ7f+IbFqoxqo/9Br9uyYaBP/B+gbginKpfSk1n2P5
	UNFtyEwpIkaN+5EXsSXRMbYHolZ13hQjkt0lc1kkqEORUd/WxMDwEaImwm782RO8UhYbsnCD6yK
	1E2i5FI4tYCrec6LG5Ob3ejmdrrDigB/+MbtBOluPMs/mWQZVkXBlGgimQULJgLmhYvcBNKCCQM
	7ofu9ituZb12b8TciyLUZEBjcLbI9z0Gyv5O7h2QT3qldJykDWFuJ6J3TO88g0UFEIjkH5kRHCt
	41h3FU4PJNTJabOQrCDB8QouWN+Ug2ZWpJ8YInK9XxrGHOzhCBZlJzhaYqVSZekrSqv4Bb1Ogtf
	H5ICr0yxk3EIAa0JbG5ghI1/D01yM4A9/rK+Pz3lLeo2Sbs6UhlSChi1SP/Qd4vDK7Ml3OLTles
	X/7GWDodUa5foHMWqCAESe4Bw8sHnwF+oPWE03Oj9t3UQ==
X-Received: by 2002:a05:600c:47d3:b0:490:d354:bcf4 with SMTP id 5b1f17b1804b1-492200e2409mr89495105e9.27.1781532334628;
        Mon, 15 Jun 2026 07:05:34 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm32087268f8f.27.2026.06.15.07.05.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 07:05:34 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: piotr.raczynski@intel.com,
	michal.swiatkowski@linux.intel.com,
	wojciech.drewek@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net] ice: eswitch: fix use-after-free of metadata_dst in repr release
Date: Mon, 15 Jun 2026 16:05:32 +0200
Message-ID: <20260615140532.52676-1-doruk@0sec.ai>
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

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
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

