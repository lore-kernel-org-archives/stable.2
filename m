Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18C283FE5
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787972494; cv=none; b=piAb35hVicvrtvDpYbJZk01cwmNq0Zw9lVmiTm2+Af0IuJIphSaUIPVxtybuyia9spxcPn9O2Uw7NuT6liBF6FURO06wWVArwpzloXpB1wyeG+taXesJ+E7iCi92bCG7NQ7n+wJyTTi9/f0Yd6FsBM71a5Wc0UOtRF4GvN2rIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787972494; c=relaxed/simple;
	bh=qQdMi8Jgb8bfEkmTNXvPHUJmLQKYjK/Vxzq0/r/+LkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVn4EpoiG+xhERiQlEYMCmSzH0bbViNxz1ge/6L0uCMxx8yoBF+7xZaLNB3BAnnDLBPCaQMlpFHZMVAw3yyvaiVKK63iL7w0p1oHj0eunXaFEpxP145Lmy415zWGDV/T+UDgV7NR8tT2UOcoycBqYTIevW3KSWnwaYYfTeLHpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O367jAo4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O367jAo4"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482e29049adso783056f8f.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787972491; x=1788577291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5EH4v06YGJpqqsWC3cck6VVt8t8Ztw0dDHt3qG/Q8H0=;
        b=O367jAo4IPDUqyw7wcAEErND/dFeWT5ZXlWhry/Vn656CCCYZBiQ3kezXjgF7CFh6u
         wBPOXu3mTHk7iQ9Y9qUgEQxf5kpDrK1kQ1M3y8XoY/tfu2ULwFaZSYUbBUsEsJb9tjmY
         OPNxPzdTo9aFbCTwH7o/w8VvIXetuCVoOv9HrnIpvHAwUod+LFDsLDZKJaYPx+bNRCqf
         wol1s3XZxWPJGW7of1CPUQLF/7TxuqwZLFVdWfVDiy9zl3i3Ycragz5nhF1o5UsVISox
         CH5PVIZribqDeH8hqlqE8068mzkAexKyT5djqInAHfzhl3ieSo9Yp5f5ehAPcZ3U3adZ
         vQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787972491; x=1788577291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5EH4v06YGJpqqsWC3cck6VVt8t8Ztw0dDHt3qG/Q8H0=;
        b=pM8HAasTRxGCC2bYlfqiXhWp4+bwwe70H2tknGCne9OByQ9aheI9ZA+AIL7Lbg9Et3
         G2AiWWQNtf6F4DF6mSuUEcC6IJa2FqSBY+QWQoBMrG03TV4wXg0e2GtbiHCZl7IPJc0t
         a+akh0k4YJLtW34JRhn2aL422DyzrDCS2i/+CrNgw1qpF/uMmdgGx2pGwgCALnJxlQ4p
         7fH03LAgOIGHgjUX0oCBSuK4WmcP8hQz+bOtt8DbDhhlwUWhwod4ea+sPuCn5V34siI3
         w8ozowT6WWeFbt/1+5IgWm8NWw6ojLE0uqfom37wfoC7HQvw0pIRSJEv/Ppshbthcq37
         veiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLwG6bc23b1WKS+SJt9NQ9L0NL9S4DG1oLgewxmeJ6hnOnbd7gO/r5gElyPBCnvErzLpmn0ig=@vger.kernel.org
X-Gm-Message-State: AFuF++ldH9KHwgR3DIqpGSOwnKZoyWUCSH8ncuWXUuFYd9IDnAFPPPsM
	/Nz5acArJRe8Y67Tdj+NREdoYG9am2w+4rcadDA0aWeH63QZJozGlYZl
X-Gm-Gg: AR+sD12NRBXJJEfET8VWcX0lS6LplpxIJjtQW/7HDLoZ6Bb2VFal8waHN17TmSnqabn
	TIt17PgzMaJ4YiifAm9HAf8o9vxCTYHVQNhynrwpHsBrgnRZMsAdNt/aQn4a9jJ8qCt0hh5DlpQ
	28RXAifuVaQqaT9/C78L0K1BKbccArLrzu5LSH8/OfqNYNhBVqVjkW4S0K3s0MkLVApJ9nc7CUW
	leuOlT124ZWQm2QvxJhZkxYBAGnPXJylPcKUvXSMA2D82gCZ6mcU0AOsersEP8wrgdPEOvEWQzO
	/ghv0NTnP+6n6EKvCWaw4fRq+HByftYgQZ0gy8+fDsc5XOCAR8Zvd8f0gEtQ2EEjax5sYifs671
	fZ/Sx+0iqZAEhuopGzuQiRgOSAXuYkknkth7Q7GUZxmDNTqcLywqrgIf5XvDUjMLYUUIvvoTvk7
	5DDHa8Tcdj4j2rtMRPV2Nuox0ITA91eDGkRvlTfyA9tD61PGkl17eYzDAiPXPHrri/6ck9rEPDd
	V5Y2GapOKgazw==
X-Received: by 2002:a05:600c:3b1a:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49b91c2d8f3mr136960095e9.7.1787972490411;
        Fri, 28 Aug 2026 20:01:30 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b945816f2sm116637235e9.8.2026.08.28.20.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 20:01:30 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	idosch@nvidia.com,
	razor@blackwall.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net] vxlan: vnifilter: validate the VNI range in vni_filter_entry_policy
Date: Sat, 29 Aug 2026 06:00:41 +0300
Message-ID: <20260829030041.940594-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VXLAN_VNIFILTER_ENTRY_START and VXLAN_VNIFILTER_ENTRY_END are declared as
bare NLA_U32, so neither is range-checked before vxlan_process_vni_filter()
passes them to vxlan_vni_add_del():

	int v, err = 0;

	for (v = start_vni; v <= end_vni; v++) {

v is int and end_vni is __u32, so the comparison is unsigned. With
end_vni == U32_MAX the loop cannot terminate through its own condition:
v reaches U32_MAX, wraps to 0, and 0 <= U32_MAX is true again. Every
iteration allocates a vxlan_vni_node plus a per-CPU vxlan_vni_stats_pcpu
block until the machine is out of memory. Neither allocation carries
__GFP_ACCOUNT, so the memory is not charged to the caller's memory
cgroup, and the per-CPU block multiplies the cost by the number of CPUs.

The rtnl_msg_handler entry for RTM_NEWTUNNEL carries no
RTNL_FLAG_DOIT_UNLOCKED, so the loop runs holding rtnl_lock. rtnl_lock is
global rather than per-netns, so for as long as the loop runs every
network configuration operation on the host blocks, in every namespace.
There is no cond_resched() in the loop either.

The interface is reachable without privilege: creating the device and
adding VNIs only requires CAP_NET_ADMIN in the network namespace's user
namespace, so an unprivileged user inside unshare(CLONE_NEWUSER |
CLONE_NEWNET) can trigger this with a single netlink message.

A VNI at or above VXLAN_N_VID is also accepted and stored, although the
VXLAN header carries only 24 bits.

The MDB interface in the same driver already range-validates its VNI
attributes with an identical constraint (vxlan_mdb.c, vni_range with
.max = VXLAN_N_VID - 1). Apply the same validation here.

Tested under KASAN in a 2G guest: before the change, adding the range
0-U32_MAX from an unprivileged user namespace drives a global OOM with
the allocating task in vxlan_vnifilter_process(); after it, out-of-range
values are rejected and the in-range case is unaffected.

Reproducer available on request.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6 [claude-code]
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e0886..9e86ac39cf9d 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -459,9 +459,15 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
 	return err;
 }
 
+static const struct netlink_range_validation vni_filter_vni_range = {
+	.max = VXLAN_N_VID - 1,
+};
+
 static const struct nla_policy vni_filter_entry_policy[VXLAN_VNIFILTER_ENTRY_MAX + 1] = {
-	[VXLAN_VNIFILTER_ENTRY_START] = { .type = NLA_U32 },
-	[VXLAN_VNIFILTER_ENTRY_END] = { .type = NLA_U32 },
+	[VXLAN_VNIFILTER_ENTRY_START] = NLA_POLICY_FULL_RANGE(NLA_U32,
+							      &vni_filter_vni_range),
+	[VXLAN_VNIFILTER_ENTRY_END] = NLA_POLICY_FULL_RANGE(NLA_U32,
+							    &vni_filter_vni_range),
 	[VXLAN_VNIFILTER_ENTRY_GROUP]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, daddr)),
 	[VXLAN_VNIFILTER_ENTRY_GROUP6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
-- 
2.53.0

