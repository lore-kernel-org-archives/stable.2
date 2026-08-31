Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32E37F738
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205762; cv=none; b=qQIKy7R6+OVefa71FkV1c3S8EzySr50b0pymTke8if0z4xdEoSYRuahSFLddLNTjiA27QBwB4foJYq4XICykEK5iThAWJvylHzPBQ4Uybgd/w6KpIoV54XZPV+F2RiaSI32Oi//s7g/p5rPaxis5MrFLWOhowqZgnn5rvg3B4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205762; c=relaxed/simple;
	bh=ewjMh7AeS7UxdW1t5ZVYR3mAJwTq3JM0H2t+6IKbq6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hiAGczWCVqBxu6sMiWnKGNRdJItTthp3YyCIduMy6X8NjkAMRzqbufltfn0c7AFG2m0LPODvPVvVjFvzV2S5Bmx/8lZatSqLdzA+bgT9PIulFWazK0+xpeWSC0u/6QKFtuEEOBy3RdFyEgHXYdH7CBtpDZMCIZOK+0p8MnPaMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N51IutvS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N51IutvS"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4843e397f74so245519f8f.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788205758; x=1788810558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAn07Obxp1A7Fjhw2ws5anTiu/0A5X6fpZK312Rn4vY=;
        b=N51IutvSUIdl5bM7Rkbpc5Vh+u7yikq6F7deahFvfPSdSkcDrAnqHHeOtShQ0zHwk5
         S6lbNXFOjLK2IpnMF7Cnm+Rw+SJ3UmnepbDacvkUFmOLc0Msff+wQRlNB7/lniKMCJoT
         ugSAVmr2Wa6HVcb486xow08in994VGN62DuKDQziVxNLhp5bzhedjZyBAydf2h6VO/7f
         rZoxBxBWjYUYvruflfj6Mjo638+IqqSNrNviUK03KgzaRPM5rDEVGJ+7YVhXsrJGyzkV
         6khXHYPwmXH9LdKjd3AUtQtmIibOFifbBTeyePtmD+Q/Dn/8hR50xj31riWjUDhs1JSO
         TnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205758; x=1788810558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAn07Obxp1A7Fjhw2ws5anTiu/0A5X6fpZK312Rn4vY=;
        b=WzumZZOQPBpFrUYKvJ/Zz4wAbRe12MZtoHZxxgN6/txGtf+AS221eA/DLFFPqQVPOL
         k3HLKhgm6o/Fv8Cn/6ilOQGA4Vv6SfxZ5pLlNDENIQEXo8xxeSSah+EER2pXhZa4L6DR
         x5y5FViOMPf2GnPk8MFgFBCQzynZCt7iZrdSpEKYxWmmO9vHd0FS3P5WSa8zwhSeDn66
         Iz5ujwGOCaudR9nBs2c0hXYU7NvJlwLUeRG5TzbHKn+tpeRTp33JgkfhiYqPFXWzN2Yk
         I1ZGZgSzLo85wsl5HXgG32iM1eKUXsMsnaQQWq1+EOfRDCTSbKGVIPGKYqEOo8Li5xT7
         2iiQ==
X-Gm-Message-State: AFuF++m2R9a0ssaSkwckmdOqHlaGMXJRjoQBTZVXaAqzGjnKy6EZPOJW
	R3IYgX7oFodt3ci4nmeMJ9inOsnLVrgledT7tRf+GKF3TSqV60fofGpCH3lAs/ha
X-Gm-Gg: AYBFou1ndDTRBnCOB/9OKgICb1mYvko6jMt06YN17thrsIvJe51dj17nyJH2Pm65R21
	qq6dbtPOMyE2v7XzNjTMmCxSnhyVM5ZjlmNh1XnlIMOM2SCvBA5+mg4RoS4JQQItQ1IFkadSJPa
	AjryDBJShEG3mIVMfNxeGpmIocIBfqS3y5i5ZupQ+oRuUz04DX77F/l1EisrXweuwDIBhXX1FA0
	m7Ke9Yapof8+LOIRP8S4L21SwhFGQojzZQ1Z96H2p4atwsZ9cm6p+mzHQmrwKgCYaj2VoDV3YHt
	Ux1t+xbC79JQNF1CdNfMwX3xNE3h/k3YMsD3kkFG4CyFHngP/1r718aYjiM50hi0rIHNEVbMzRU
	bvD0HBkxWzQNO106WhMnHZtakh18jJO7rKENN1H2J6MKYmtmc4lFxgceLx1wVqm5vsWYG561oG6
	C/QffnRTZepSolRoC67ZQGTTv5cHM2LQdww6bChn1idnmQpKmmeY1uw9hKfXT+5fLvUpnKMwZa/
	WmXpuuohOKrGdxC+0+AGm+aa00eo3yDWYEm88Krdtns+KbmpJfL7RC8Lkqmd4dhmySdUemIeTrw
	PKlSRQH2VklKFxWB2gMQTBzEWvxQiMUx2vCsIterGtRK/JNou8hGEU8JJ8Q7kVs8qQ==
X-Received: by 2002:a5d:5e8e:0:b0:484:35bf:af6f with SMTP id ffacd0b85a97d-484421d969dmr991971f8f.12.1788205758197;
        Mon, 31 Aug 2026 12:49:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d6e8eesm1731f8f.18.2026.08.31.12.49.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 12:49:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mukul Sikka <mukul.sikka@broadcom.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	Bin Lan <lanbincn@139.com>,
	XiaoHua Wang <561399680@139.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y 6.6.y] netfilter: nft_set_pipapo: restore cloned mapping table memcg accounting
Date: Mon, 31 Aug 2026 21:49:05 +0200
Message-Id: <20260831194905.45045-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.1.y and 6.6.y backports of commit 69e687cea79f
("netfilter: nf_tables: missing objects with no memcg accounting")
changed the pipapo_clone() mapping-table allocation to
GFP_KERNEL_ACCOUNT.

Later stable backports of commit 07ace0bbe03b ("netfilter:
nft_set_pipapo: do not rely on ZERO_SIZE_PTR") rewrote this allocation
and changed the flag back to GFP_KERNEL. Upstream applied the
ZERO_SIZE_PTR change before the memcg accounting change and retains
GFP_KERNEL_ACCOUNT after both.

nft_pipapo_deactivate() clones a populated set before looking up an
element to delete. If the element is absent, priv->dirty remains false
and the clone is retained. Its mapping tables therefore remain allocated
without being charged to the requesting memory cgroup.

Restore GFP_KERNEL_ACCOUNT for the cloned mapping table.

For a 32,768-element two-field concatenation set, A/B tests on 6.1.186
and 6.6.155 measured exactly 524,288 additional bytes charged to the
memory cgroup after restoring the flag. An unmodified 6.12.107 control
already accounted the corresponding allocation and showed the same
accounting behavior.

Fixes: a4983e89e3b1 ("netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR")
Fixes: 32bad10de347 ("netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/netfilter/nft_set_pipapo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7c8d28a031ad..4c3bb5d61a3b 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1465,7 +1465,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 				goto out_mt;
 
 			dst->mt = kvmalloc_array(src->rules, sizeof(*src->mt),
-						 GFP_KERNEL);
+						 GFP_KERNEL_ACCOUNT);
 			if (!dst->mt)
 				goto out_mt;
 
-- 
2.39.5 (Apple Git-154)

