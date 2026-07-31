Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E83B388A
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507197; cv=none; b=GWk3VVqVi2hp3Pc2uwZIxtK6wuVaL/hwjY1KbfOA4QA++whay/TFGSC2hvKWNbcNX/T/8Wz4kaXFgKP/b5xsf1LaMwOWGVd/XcTwqIs1fCetodxMbV/oFRKGG/yfoATkD0SRlLzL3RtT6txE23LS4NITDUJlSyU006K2hc579O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507197; c=relaxed/simple;
	bh=f8y7zXkc0E+z17vAWKNmc1qHXMoOIjzNIagS2xro+PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+YzWOSsOzdprGKng1yLgHSg+4vh2swTF+8wrgrQkkeWXkotIhqyqyr1WUQKyBQZOfssOBmaKhT2ppMJ/FyyqhkAX0JqgD4QktgVcJYGi28EhI9qZn5Xp23K2wvuIzDxDOdHpezYm3VJATIrLf8Kk6LgXsidWQXAkjLIEpnjcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=COehuNeP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="COehuNeP"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6c4a867cso70291485a.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785507194; x=1786111994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b15F1a43UTMMEkb+LiO+nUB2piwvXEDFRceF2Ae9bdo=;
        b=COehuNePcr4mzzt6NJFfKzNcDTvtmcJepUijNCL+b+5/tIOyWJ9nxBQ++ln7/Sp1jU
         7NlCfan2NjFxYle7qUXIUK/r/5gcEboPOybRVVbff4dLYjYmNcIr+0NhfsAKP0Xu0xHk
         Eyn09NMdiPPgw7RSQTyGXArduVN5qLG/y4DrQUUS/qAMYJMIskt4reP35dATfhG5gcUc
         Ip00YC/rSspwXkY3Rt+VvtHX0cJiAcGtn0++/apliJmwkwwRgS/jqDT4IpdTV5fb/3fO
         xjr68bn2q6RsadWtZ4PJcxnP/Y8zKh7IxoTbThKz2Pt3Ilx06KvFjx3fLLQvh2zyFGT9
         p9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507194; x=1786111994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b15F1a43UTMMEkb+LiO+nUB2piwvXEDFRceF2Ae9bdo=;
        b=agyMyrlSVtKiJ2VLqNdnHOX/OAbOgIPPbR9wjGqMGP4m6UsdtG62RejApbCZEe9Ta5
         WgJhqU/ljv39+z3f4aunFFnKOkCBZw9xzieoGwgylw6kojSeXNVb27h1rlC5NZIYEJoQ
         lRaclBOqqO0Zmni1mikMIZBTzkphh+FZ7Gcgn2I75kuUCjWjZCxkFuG58MuVrYEIP7tb
         +1MOGWBM4ha1KgrjhiWJOU2SWW3p8lpTB4BjICj/ynJJ6YWawZ1lyPmwo0hDoh4uAOlO
         TJ2vntGAd/4V0Pm6zG+7vRkew9w27YDfshX7FrdLqPMdqCOTdZmS4qqungmQXQ5d50vO
         PXZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrnfy8ObOcqr9pLB2zV+jHyrfnHL9Yh+18RIPq9fi9YOWp1Un4F+MeDeKW7PzL1V7E44BZ2GkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPO55qDrZJx90t9Vb6DnaPFFHiC0ip9ejsLp3Lzr16FeZaY11
	I/ZF1THvB7FetVD05V1Ma3ctcF0d/JkDtuBoIbDrf4UqcQ04Pq9QgqcNBN8Qo8X9L98=
X-Gm-Gg: AR+sD13CJMfm/9AprV/EhmAEZ4uYs5zSPBdkm+ATc0UoK+IH2Nh9VRR3Xy4Q8IDGxed
	5KMNHtDyAC7957H067vmTsbdjjfQvpEUSxpoVO4t6hEBzq8iFuAjN0cwKe+uf2m0clSgmKyzDRR
	KijyjIWV0Iq+xUz60FbTbCtAYEecbz/2Su6rW1a9LLhw6aprKvo0jvIKi6FdehSg/Vuma7WlmzN
	LJZpVoeJrVyb0RKajnl/XhC4K1A8c+ZFEStDS674Qo4Fnuo8ojJQBm7Ub+MiD9mwDyYJOSRuMXA
	GKt4akdYf+JcY9A/U8WUB2RwWc+1RtEbUBqyWTbpl3WTtyHmf3ftjfNFQm/lBprHMhSGsEnZa8l
	mpu9NZe11zB6Wi7lP+AoK6MjkIf2LXHEZyfxVBToRVsyfSE9Xc/n7ULiQT3j23o/i45cGAHvyWC
	1dvFF0gJ3nz9a5jpNxaAnNYrRf0+ueXzdMJHCLAbpGh9FDYcHP0uYv3it36YRHd/SUMg==
X-Received: by 2002:a05:620a:4502:b0:92e:ea8d:5c89 with SMTP id af79cd13be357-934a0aa7617mr7941585a.40.1785507194331;
        Fri, 31 Jul 2026 07:13:14 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9349bc52142sm63714885a.15.2026.07.31.07.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:13:14 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] vxlan: keep the last remote linked during FDB flush
Date: Fri, 31 Jul 2026 14:13:10 +0000
Message-ID: <20260731141311.570187-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
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
