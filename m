Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186213;
	b=DvYuRZ1YZ4Miz/Z/Ifuk229wflQ267Lbx5hnY78PUBjGv+b2UKCVrLLOjJiwVbeUkIK3
	 aIeAw5qsrXbjQXQvP0AoPPYTh4k1wi+Qm00hXHxxYXaTqSNxDL9vE7aRtOd+HM3gXNVFy
	 2iBdjhLoEHXcRXCXxBuK3UcDoYDnRJixJY/SHQPhka+/Gy2wkCfGaTjS+vrm3d3gh9UIV
	 suc+qMM6hduVfJ/kJakEHGmgXhiMWbP6jFO7asKdWR5YC4EazQoCT+/FKFja2cANWaaJ9
	 DPcVTS4HMpf5DIrmp90AFlJym0yNXZLGhrusGtl9nC0ZHTH2KHSO4n7dXYdUFgdXIMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GR/yFWtGsd7tJ+Usqsgdls8RQ503SxfITShiJgwMejs=;
	b=P+wPToeqNW/rcX4REoar/YiKeiOprCIonlmGByh7L2YD1Z/wCOqnrU25oaPby5l2E7as
	 7Pud/iVpeQPfmrK2fQ+PfawkCfPwhyGDNp/FwvEGeUC0MZ70MiGtV47maDOfTkWedBv37
	 5Xa99pODLDu3QGtg6yZ4QLDrLYtxtc3fGCsRfOwQdcLKnNe8NdGCaPKQXKhXEFN01wc1y
	 4r3WQtAp/sjQEOpj5O8qMWVwZtOLbXvs+qJHLxMTVg2ChOsbtKwUuj9zdAnE1Uh634nNJ
	 TcNZSvLNLFw0ryq0yrb1nIU29WDnhSY7x47dEbw4vJ/kFBR8EafH0Oucm66JFR1IAvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TuFDdViG;
	arc=none smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F4606A323
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899F4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TuFDdViG
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4f742fc5d09so229598b6e.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186211; x=1793791011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GR/yFWtGsd7tJ+Usqsgdls8RQ503SxfITShiJgwMejs=;
        b=TuFDdViGJGEL+b0nZfQKqmZyadWwdWMzBmFH+Mn7eeNaUHjaDgL07albXg0moMw9or
         9+JnvbXMRY6g0zpKWR8JMQ42xGk5CNHlmUj/wJkDMVIGSfuCf62/EwBaUIbB6CGDC0Ct
         cRRYLOBnhn+a1dyNi9s1oq/Ct4znyKZrx46NhV2gQhuDiEgOGEjkLp5guXAz3sUjbDKx
         icJWDFuwZdM+esbT/v1I1mXHJPIiH6N//3grhqxjAe4CIN4W+6sxnaVFF9gq93XKOKKq
         XHY1R737tLhs0APhGCAPhqF2V7EzZPPt18ruafFAY7KQxTCJPS3wmSYZgHCn+6DO8FmP
         p0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186211; x=1793791011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GR/yFWtGsd7tJ+Usqsgdls8RQ503SxfITShiJgwMejs=;
        b=KoeJUeqGHPSKvH+t6SYMJpRQDS0s7M4+kcqICjtqnv2AhunJOUDYcX658BLLOPzXY8
         RVjjegK4MtG01+5tyWPSDp3jvyc6lITj/MnMLM5YdLkhFRher+WZGNLP9/zzV0ABZa7R
         rHUnLHDmnzAwDjVOxaUl6K/usuF+yAlbAlps2KVv5Tc1SAS1cOh3JLB4+1ZWNj/zy5tu
         FlDcV1O8P7Kx+Wx/g87roDzCNZ6guB92MtJOPWPC9cUoIN7EnO1pv5w/0213yvBIQBaF
         Wugelg4aloppAVwTVSBr55fXC3m8ho44PH/9nEJ1pJS7cBF3VGFFXpC31Onj+vqqHj0n
         AYoA==
X-Forwarded-Encrypted: i=1; AKwUvBznwKQZ9I79QzWHjaxEsaJ8spww9zC6wjUaPKgwNckWP0tYAU9N+D+saMSTqoPy+Zsw+4TFxEc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOp0SRuY11HFrOuMEDaiVnx74IopcI9cRTLPzH51esY4kUyZrj
	N4g+7OyhHX67s6kBGbZ5qZx2u8rHZS74j8Dh14VYMGJUsfnLT4RtnLFMUTHXQrGbI57pjQ==
X-Gm-Gg: AYBFou3qipD4jT5qMJdObiCvO0eQ9O11Bq+8m1MhSV8ii2d47f274RDVOHXgLbsLC9Y
	/laEy9Hhai+0fOQmaI1GgUlIPzK9kj+ertttrdUhVgzN1H8m6kHxqJ7b8lsEP+OTe8dS2fw+E4V
	vYj61Z48xyBGz6635q63sG3lqxlACIRhwTqtL7lnNUk6cZ22adS7DzgMw8Qg81yGvo+5+4haVVe
	icjlmKFNIDXh8926VATqt5Z9xOaiqYw8BvlaufXLOGp1wIH+a8qSrOE+O0OxawA3EhHAaKmfI4W
	ITyOSt1Rk9hjUes4e8dTbUZWWFyWnsoXptox+/xoJkdxYXKdTxmY5e8UNnvSndEc+k86U5kN4pg
	rC374BB3TETa5XE+1ve87dqbUbEJ9yCmtR9luwKJ+ARrZYeKcthAjVuI2vELUce3o5h9Fbo1Vgq
	dpA+Nz2lhP4ohr4VyU4q0mgvvHzKanyuXvswHT53OyUyS7ZbptqZiE+UrEIyLNbh3iEtQRuqUPe
	OGQjnWckyCWYCwh8t8VHw0Zf6A0DBZCwNs72J/XvdUdrzPngZ1cymHXD3J/2KGbMkgEMSgaIbZa
	0LyCQKdsyZaFCvOBVlMvwktP2V6xZM+bxdxFRIynEh3otJIXup6DWm0S3HJlkqH5luE7
X-Received: by 2002:a05:6808:2229:b0:4c3:6d56:77c2 with SMTP id 5614622812f47-56382d8e3b4mr1287682b6e.41.1793186211387;
        Wed, 28 Oct 2026 04:16:51 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b77ac4e4sm2003351fac.3.2026.10.28.04.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:16:49 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Seungwon Bae <qotmddnjs@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5 2/2] vxlan: reject VNI add when the default fdb entry is nexthop-backed
Date: Wed, 28 Oct 2026 19:16:26 +0800
Message-ID: <20261028111626.3460759-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
References: <20261028111626.3460759-1-bsdhenrymartin@gmail.com>
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

vxlan_vni_add() installs the new VNI - hash table insert, group list,
socket attach and the RTM_NEWTUNNEL notification - before calling
vxlan_vni_update_group(), which in turn calls
vxlan_update_default_fdb_entry() to store the group (or the device's
default remote) into the all-zeros fdb entry of that VNI.

Now that vxlan_fdb_update_existing() rejects appending a remote to a
nexthop-backed default entry, the group store can fail with
-EOPNOTSUPP after the VNI has already been installed and announced,
leaving it half-installed: present in the tables and announced, but
with no remote stored and no multicast join.

Check whether the default fdb entry for the VNI is backed by a
nexthop before installing the VNI, and reject the add up front.

Note: the missing unwind in vxlan_vni_add() predates this series;
this check avoids giving user space a deterministic way to reach it.

Cc: stable@vger.kernel.org
Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v5: fix a build error on current net/main: vxlan->cfg became an
    RCU-managed pointer, so reference the function-local cfg
    (reported by kernel test robot).

v4: new patch; the failure path was made reachable by patch 1, so
    guard it before the VNI is installed (sashiko review of v2).

 drivers/net/vxlan/vxlan_core.c      | 14 ++++++++++++++
 drivers/net/vxlan/vxlan_private.h   |  2 ++
 drivers/net/vxlan/vxlan_vnifilter.c | 14 ++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e58..13143085065f6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -422,6 +422,20 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	return f;
 }
 
+bool vxlan_fdb_entry_nh_backed(struct vxlan_dev *vxlan, const u8 *mac,
+			       __be32 vni)
+{
+	struct vxlan_fdb *f;
+	bool ret;
+
+	spin_lock_bh(&vxlan->hash_lock);
+	f = vxlan_find_mac(vxlan, mac, vni);
+	ret = f && rcu_access_pointer(f->nh);
+	spin_unlock_bh(&vxlan->hash_lock);
+
+	return ret;
+}
+
 /* caller should hold vxlan->hash_lock */
 static struct vxlan_rdst *vxlan_fdb_find_rdst(struct vxlan_fdb *f,
 					      union vxlan_addr *ip, __be16 port,

diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b1eec22163608..0454689965aeb 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -11,6 +11,8 @@
 
 extern unsigned int vxlan_net_id;
 extern const u8 all_zeros_mac[ETH_ALEN + 2];
+bool vxlan_fdb_entry_nh_backed(struct vxlan_dev *vxlan,
+			       const u8 *mac, __be32 vni);
 extern const struct rhashtable_params vxlan_vni_rht_params;
 
 #define PORT_HASH_BITS	8

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e08865..f07ae2a6a59ed 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -737,6 +737,20 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 		return err;
 	}
 
+	/* A default fdb entry that is backed by a nexthop group can
+	 * never take a remote; reject before the VNI is installed,
+	 * otherwise a failure in vxlan_vni_update_group() would leave
+	 * the VNI half-installed.
+	 */
+	if ((group && !vxlan_addr_any(group)) ||
+	    !vxlan_addr_any(&cfg->remote_ip)) {
+		if (vxlan_fdb_entry_nh_backed(vxlan, all_zeros_mac, v)) {
+			NL_SET_ERR_MSG(extack,
+				       "Cannot add a remote to a nexthop fdb entry");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	vninode = vxlan_vni_alloc(vxlan, v);
 	if (!vninode)
 		return -ENOMEM;
-- 
2.43.7
