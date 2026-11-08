Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141292;
	b=z9u75vQmK/cqDRqPnll5kQZ4PvFil3WHm8xEP8j+q/u/io+LZ9XWflbkVvlYklT+4IxV
	 WdoRoA0Fgxce5qjPYgmigD56z8ZbL+kTLhUvABS6HafKJH2PLtLZGSKccmfbHZb1n9UJj
	 GEpBxFMS2RAQzW60OZAW3+NhAWF+39cCv2R+n8JMZgIZ1CqjnuMcMxb5pJp+1q60nFWtu
	 9GMPrieWXZYIkc9K7kwhlEm8ltS+/JdrXj3SOGDLqr7TVVCafvAJVH6ySD4qa4HnJJord
	 /2tQ/BqJNDijpq2EkBc319efKn8nSh0u62+dGAEYhXZNqrK+3kx5qO1V+g3Ts8fqACw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a7MU1a2Ky80ww1QI8pf11DKI/bl0yAkVUnac57Jert8=;
	b=Bfh/yLaw7hbrkTRgIVGp+mKboWYdLJOmSMhjSDwxVTcO5DQAhos5qxUzXz3tzF9eWfgk
	 GW1BtT7dYy5aXfDZZtOb6BZ4sUm5pBAzyZrOqOATnNSyVDrlNgf5ICZpEz28rBAq9cpHE
	 v3rQpFokkjJQFCvhFQLeGO41IxFQ13wDdhLBInJjXw4sXwTd3s3r4wUgneIC9et8SncZZ
	 i5/orq+YcqukJ1nJueFX6xKInHlQAazbWe5BCRlXRWu7W2xD1jCMBmfkvreeXOtgGHpzw
	 FeINXsncBzzy6Rzt4588DbS1gse8L0xDpiHGY3bO+EM+q2AIIfiWYBx6nwMxwhltD3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lL7e/eKv";
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310A606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B310A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lL7e/eKv
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso528217b3.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141291; x=1794746091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7MU1a2Ky80ww1QI8pf11DKI/bl0yAkVUnac57Jert8=;
        b=lL7e/eKvADhid0J2196uNo2gIgCkBKVN7yGBuZaGVHtWPcYH9FPAsY4DOVpPQY5NsN
         MM58r43vbHi9h8jguF/cIzzvvvEmr54uTt9JEIyoRg4o082BGgVYCQmaPI+YI9CBpjok
         5LYvmNo2oKcbziYmCw/R7ru2eEURLTyaqrFdmvKBCcBiMTCPGie7nZFzMsVRPyoH1q2e
         O97ArGsaIBbdzW11J3hvERUPv96noLm2dWDrXjKfd9DrB1+8EA/eJDd0tjRwIJFIKdZv
         XB8qlM7EB7lHZ7NAW0oM7i3ytu4AkD2OIzCjNrxuf7wT51YZNldaSaTvWU8uPyDBd85q
         Sntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141291; x=1794746091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a7MU1a2Ky80ww1QI8pf11DKI/bl0yAkVUnac57Jert8=;
        b=hxhwnPE9XjqblvpjhKfuAzrAHM48WW9xGxsFLZqjjChdSsbWa5J+dSUYg/0F9+nxE/
         da6Lt/TZF23kGQ/ORXFvAV8sHYF2eukUTreKwE0yulhJwW+X15+flSNygdGL3e5d83FP
         X1Uh+Jx6fdsjsmggpjTIwGoZRawC+sqee1RfbupF/VIOs79fbIH5BKA8zm6BNtippMly
         puGKhP+DlVDD02yRjvYLzbtlI2EjF4aBs620dz5tIerjFJAazU+q2DkFknZT548zvvdO
         ylJvDe5HQOl1njwVn75SPcUqAMiC6fST8TB7bXZ0Ci2kdwni2habVOWAH41n8Y6op8Fq
         nhrQ==
X-Forwarded-Encrypted: i=1; AL+hErGETChkxY6wOqYQfqQdTkV3dKkfibXd0u0sNhkW+bMnH37hpQyVzuVTWJTDRuxbCRSDR4cVrJA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FSYrthgnx2f5UkV2APKhSlfs2qRbe0M/75X0cwwD9M3406tje
	ct6KLtDZT/Z8YgaAlV3/IyZ37Y77cXw6Gc5wMXY8YZld0zzoQnlK04WL
X-Gm-Gg: AYBFou022FWDgxbP2ny/IU5h5me/sQAqY4nnH54+8honY3MMbJgGhOHN1+CE2L82vgN
	gpZj43f8MxL1EnRnI/kg+WFWG/TeeNOA+STra4FLEscJ9IRRJTY+jxkM5MBUmeQc0fqH5HykK3S
	JwLaG8Aj0vx7OKT7U+2/oHAfSg5W4wLsiYGhFnzH00O1oLhreTD8RHBeVA/ZnU8k3tBz+y7wt5D
	Ua5tBd/1J5lRlTMBozalzKEuuwJnaPkKxMFHfqWamMCFbnkGhY8IC1DUuKJ3eR/qYmCpuHNV88I
	Z+DRn4J0+PPh1237Ovz9f2hr29QkX6lBfaWFKl83cWrNj9zUol/7ZqZJODBLCvPY5wmGmCj/T77
	UdXVGBVet71krfEPULVXmpE00XdZQrK50jeVw7LWTcrGknx/eF39rXV+RcZbqgk2qmhKIejF5VZ
	3tCi+OFTmM54XihRn+i7dD5EfjGLVcfLDcLVc5j7XNPhpSr7XERT/AYkTqgchlS0vuq26YiL4LU
	gmYJpq6Mkq5O1bSQbPsp0lSmMFkBMgkKEiXVqVzNUlde4TQtj7+p3EipA49L98oPLgLmqUQWN7h
	Fd0NupyNL9ehESEnaTSYbWrt
X-Received: by 2002:a05:690c:83:b0:8b3:2e4f:6bfb with SMTP id 00721157ae682-8b36c9bcc9emr9231857b3.22.1794141290587;
        Sun, 08 Nov 2026 04:34:50 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b36be7d88dsm13475627b3.39.2026.11.08.04.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:34:49 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paul Blakey <paulb@nvidia.com>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: openvswitch: do not record user features when the change fails
Date: Sun,  8 Nov 2026 07:34:23 -0500
Message-ID: <20261108123424.2825403-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108123424.2825403-1-houminxi@gmail.com>
References: <20261108123424.2825403-1-houminxi@gmail.com>
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

ovs_dp_change() stores the new features in dp->user_features before it
updates the per-cpu upcall port IDs, and that update fails when the
per-cpu-pids attribute is empty or its length is not a multiple of four.
The request returns -EINVAL with the new features already recorded.

The features decide whether the tc skb extension static key is enabled,
but the code that enables or disables the key runs after the failing
call, so it does not run for the failed request. dp->user_features then
claims TC_RECIRC_SHARING is set while tc_skb_ext_tc_enable() was not
called, and a later request that clears the bit calls
tc_skb_ext_tc_disable() for an enable that never happened.

tc_skb_ext_tc is one static key for the whole host. cls_flower, the
bridge, the flow dissector and OVS hold references to it, and the key
stays on while any of them holds one. The count ends up one short and
reaches zero while other users still hold a reference, so recirc sharing
in every datapath goes off with it, as does the skb extension allocation
in tc, in the flow dissector and in the bridge. A disable on a count of
zero also reaches the imbalance check in static_key_dec_not_one() in
kernel/jump_label.c and warns there, which panics a host that runs with
panic_on_warn. The opposite ordering is possible as well: a failing
request that drops the bit leaves the key enabled for good.

The request only needs CAP_NET_ADMIN, which a user namespace that owns a
network namespace provides. datapath_policy has no entry for
OVS_DP_ATTR_PER_CPU_PIDS and the operation skips strict validation, so an
empty attribute reaches the check that fails.

Keep the new features in the local variable until the request has gone
through, and use that variable for the enable and disable decisions. A
failed OVS_DP_CMD_SET then leaves both the features and the key alone.

Two other paths touch the bit without keeping the key in step:
ovs_dp_reset_user_features() clears it without disabling the key, and a
new datapath that fails after ovs_dp_change() succeeded is freed without
disabling it. Both predate this change and are left alone here, so a
failed OVS_DP_CMD_NEW and the reset that follows it still leave the key
one enable ahead.

The selftest in the next patch sends a set request that fails on an
empty per-cpu-pids and reads the features back; it fails without this
change and passes with it. The openvswitch selftest suite passes with
the change applied.

Fixes: 35d39fecbc24 ("net/sched: Enable tc skb ext allocation on chain miss only when needed")
Cc: stable@vger.kernel.org
Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 net/openvswitch/datapath.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index b2a0b09fd4a5..00043aef2d03 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1801,9 +1801,7 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	dp->user_features = user_features;
-
-	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
+	if (user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
 	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
 		/* Upcall Netlink Port IDs have been updated */
 		err = ovs_dp_set_upcall_portids(dp,
@@ -1812,10 +1810,12 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return err;
 	}
 
-	if ((dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
+	dp->user_features = user_features;
+
+	if ((user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
 	    !(old_features & OVS_DP_F_TC_RECIRC_SHARING))
 		tc_skb_ext_tc_enable();
-	else if (!(dp->user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
+	else if (!(user_features & OVS_DP_F_TC_RECIRC_SHARING) &&
 		 (old_features & OVS_DP_F_TC_RECIRC_SHARING))
 		tc_skb_ext_tc_disable();
 
-- 
2.56.0

