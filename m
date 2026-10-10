Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020E2D838E
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614898; cv=none; b=c4z4EeuYYd5f4K8X7l0uTjRQE6Sc0r69gZbSGcf6+Cr/ctcvstTAsSh6FIotqIOvCfrEciXOl9hrPW4YcTHfpbK0CES3X+tIS4TfHedOqOZUGG29vZSoY9TamJRS1OKcK/2kEHrVCDKKRr0KuZikeOp+L+pO4XyD7zF01LeLqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614898; c=relaxed/simple;
	bh=5L5DxwVvnvUWNH5IP02RQY8g/fqYMrFIez+ufoPDWCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KER6b9l0OHTYApQDOxPwHLk23Tr5KATWu8a7mGsC6g53fFeG1sNUS2/lI0NYSY9Ueg49pgBd+QWuAZeWOiST6vii1VuK7UEgQC5Kcx/34UpMrBxo8WXuXwQVQPgRNApIEm2EzYGq2+xUXdZ1G0UbjNqSgEYjRgSy5Mcv5HUa/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eomXT2Z/; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eomXT2Z/"
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-820ff812cd8so139062a34.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 23:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791614894; x=1792219694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R3rH/D6qM7voVS6XyaxzTyltsiNIVflM2CckMW9LdmQ=;
        b=eomXT2Z/zMb0XUYnzXPpEVw6gZbc+qXYi8jPIseSscmUR21AqGq/PM3Ib71m/0TVx0
         ScHzwZYB6i9gguXwugb8QiZ0fP0O4JbronAwLignYtXs8nms2aslyjobxy+qwIowusqR
         HurYbkeppW2LZqbEt363C/Z9yQbEIhGPUHeaDqsmcV0pblRXW0h6wPzsi6OpcAYODB6o
         3KB1rpUR3B6rse9BLjGQ4MSly93AK5hs+uxkWFVHpf6KYxgp5bXd1h0JTf2pJSun7nFX
         Bowp7wJI7XKUKMd4NslQOFH5CddSfUVdKfFi26ic5eamkZgkMKdv25pwGEJwSqzYhe+d
         qy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791614894; x=1792219694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R3rH/D6qM7voVS6XyaxzTyltsiNIVflM2CckMW9LdmQ=;
        b=A76AytS2X0mRUHBMowwHQOrOCMTMzDm3Ro3hZTCv21uOoyT97swjMbkUvgHyIm1eJ5
         FM3iXJAJByNGoRwNfcgOroDjjtnqpVGuAammb/jbsS9eA9DkyQPJWPs4s4vBxUz6aoh+
         WhIj8tkKizCFL0O7tyjj0SXYV6ik7S/d8KorEOLC6L4XadfxiCKNBeQgIckYd7+2mjXb
         Nj/pnCza3M7L5BsOFeicyQw2AZw6WT0wgMXPZn0uSAGMwA3kPG2lWlMlPe4jiMcfqybJ
         B7WsFhprzgScDJ+ouRupO886gbFIUC3LMqI6J6GLshLQCEYZPpxW8KGlxYPt7XohvSIX
         3XXw==
X-Forwarded-Encrypted: i=1; AKwUvBwsH9edhcNSikgzJ0cz0RttEBBAeBQDETxAt10Vl9idQ3s1VpEhCHlmqrWq8MlPoriJiZKUXA4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKj1VcDWWzH6whh9aw483iyouagsUW3+CQWqDXfT7gemSdzVNya
	bVFBhKDh6+8eXVrHywTm7k/M84+33aqRUDHm/5mDftVdCZv7ehraECwi
X-Gm-Gg: AYBFou3rswUbqWByoKKvGcQj463LP3EX0L/jXnDfiyZqL2cxchLMVJBeSrFW25WtIVe
	R6ncQGO/c2RQfrXJrqAdfLtgKcj973CtzWNOGietNkqHc6KSot7MsI5WiytF2umzjdxKM7K8jeo
	xvRed6KdEcmu062sQclNxj3IY7miHstqFpTBMrcqXL6dqtR51Fxnn5IwchaALRKoZQP+fjebR6M
	YY4WDxEHzMpbL7D6gECJmAwoNrYtE3jQINr5ngwBWJUQX2fzsqTXLe0oqBJ/4nyKOb651vfnR3k
	JOf/dP1JGrY8Uz+4LrGkyabodpVmwt2jvfkiDCEwhp7y/gk9B8F/CWbbToHnzwTazaHCtSRRjdC
	mXs/pDbUB2GP5mFMXeZ0oFIzVM/p3pmetwGgAAErFwusy3JIHlsLxOO64ae3A0vbBK3onqXUfzh
	mGRRGiVDJ6JWvhKMkJF7eccttJNPrc1scGyVBBG8uM786tgUbvFv0POG2QWj4iS0XHCXh/ThzzW
	3pw1IXUKvcxK1dw4S9r9zPuhXmLy05eePOwdE4KINfxRgaJ
X-Received: by 2002:a05:6820:16a1:b0:6ca:5f4d:318f with SMTP id 006d021491bc7-6ef0d8173bfmr2975799eaf.30.1791614894240;
        Fri, 09 Oct 2026 23:48:14 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.41])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385ba23csm3864752a34.7.2026.10.09.23.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:48:12 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Seungwon Bae <qotmddnjs@ajou.ac.kr>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vxlan: reject appending a remote to a nexthop fdb entry
Date: Sat, 10 Oct 2026 14:48:02 +0800
Message-ID: <20261010064802.2741221-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_fdb_update_existing() guards nexthop entries against nhid
replacement (nhid && !f->nh) and against nhid-carrying NLM_F_APPEND,
but the plain NLM_F_APPEND branch for multicast/zero MACs never
checks f->nh: vxlan_fdb_append() happily links a remote onto an
entry that is backed by a nexthop group.

This breaks the "nexthop entries have no remote list" invariant: the
xmit path consults f->nh while dump/notify/delete walk the remotes
list.  Concretely, the appended remote is invisible in fdb dumps,
yet "bridge fdb del ... dst <ip>" removes it, and once the last
remote is gone the whole nexthop entry is destroyed, silently
dropping a forwarding binding the user never asked to remove.

Commit 98fc57d167446 ("vxlan: reject dynamic fdb entries that
reference a nexthop id") closed the sibling nh/state mixing vector;
this is the same invariant violation through the opposite door.

Reject NLM_F_APPEND on nexthop-backed entries.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e58..aff450ff6aea7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1038,6 +1038,11 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	if ((flags & NLM_F_APPEND) &&
 	    (is_multicast_ether_addr(f->key.eth_addr) ||
 	     is_zero_ether_addr(f->key.eth_addr))) {
+		if (rcu_access_pointer(f->nh)) {
+			NL_SET_ERR_MSG(extack,
+				       "Cannot append a remote to a nexthop fdb");
+			return -EOPNOTSUPP;
+		}
 		rc = vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
 
 		if (rc < 0)
-- 
2.43.7

