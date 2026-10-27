Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098065;
	b=OKUn6gajf8SDrX7l0Du4UpsiwQABL6xXTFsDKnJ/lNNoU7JUaoN/z/x1zDeULWUaBMGO
	 qvC8Z2Y7RagN10ld7oYO1aVPMtDUuCAri0Kt2oXlSzANhaQ0ZsB+VUJ9eCuHcAmTTuyd6
	 ANhLB3T5MzojT/SKscBPeYsOcxehD1tW2BbF/BYcxxxdXlP7LIN1QRWj3HQWdH6+2n617
	 2tiyRhaOaTpoW5AOtSO1M/XEzylKpQ5yyTxCku8cLSrFdzghVHEYVo7/xQ+d0unTqCeh/
	 Aifa+S4yzUVojrPSOruzJKbKj7D/b7+bMLJS04Y+BoaSdqOz+nL3AQIeSvfYwLpzh4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=31yePHJkZvVIMPqk+qU1LWlJ9GBJamyVeNTyh7KlbfM=;
	b=inip2PasUYtO4WRhRvyuSRMI3K39/gqCaKAnnUsp3mfzPBLZyAZzcE8APIqA/oQdShQL
	 YjgHL4gAcAKfJSLPsOMyJZmfb8P2ldG5VojFBatrCi8g/1zVvLyb69fDYLs7xZhSJpcgg
	 BjEDhMkAnDfhUJp/273nb9+9BJym4/XDSiV2ZGOy7qoSbbzETPRvLc9dX8WabocHW+W/R
	 HXluffDse4wRylZ9f33koSnDChEb/4bZ12ioiEN9sHSLDDw7cWN5kbMXsbbd5OTT8zaNw
	 9SIb/erNVH1/soMss5EUzFkCGpmhJy+u+djzpGQYmbuPG/06AncMU/a6Sx82KzzDjpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nv9rbupi;
	arc=none smtp.remote-ip=74.125.231.132
Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796D606A336
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A796D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nv9rbupi
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-702ba2fd61cso974044eaf.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098063; x=1793702863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31yePHJkZvVIMPqk+qU1LWlJ9GBJamyVeNTyh7KlbfM=;
        b=nv9rbupi+ErQQzelJi+myJQTS+9F61QxOVOWKDArpr6CskZuZxl7X+alV1TdNTdN9R
         +4/q256sSuKxfiNWGbkZVJIArsvnOzyun9qOyjB9AzykLR0T444643LiJcufHYdOfE0P
         /WGRcjXnyR5E9cEREYWGr9ruXm/MONtTYCXSpJ8ecgs4E8ft6hCKx6YLB3ab3O96ON+L
         hGWoVn2m5nY2HwJb7uREQxhgrk+nhbhEQ+kZdj+stW6nFirl9A6YWeAw3drYoyldwc+U
         15BMmktxdaiiaipNAp9w98JtQrcGJ+I7Lwlaga2fOf4qf12ATD6/pFGOvdJf2jqy88cd
         VYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098063; x=1793702863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=31yePHJkZvVIMPqk+qU1LWlJ9GBJamyVeNTyh7KlbfM=;
        b=a6M/VYQA1kCoQ/nMWQvE3X8K+ibiP+5BFwyI2IOeGjiDMCwlHEZ81H1f2rdoD5ZUtr
         +g43OBmJq7M4PG2O84hks+4AMpKv9NuhCCkwe2PBgxmT6RhGKkkxjnyBWxBQXdX8WQVk
         Kgyve4Y8EZQ5X+RmcvsX9HOrTBbVzdTRy4FJkGBN7aYBvzEwYxonRCR/qk/6SC0Mogif
         +S1z/Qc4UeVLDkE7BOpB20z8WrzrvSRbxgIbgqF6RBeDV4O/0qLq6nLVI3XIob8OBbvO
         kDfX4Es6eOJkzkC3fcdmzhzx2tjkYTxlghgpP3KX5eJn/75xGaw5Tui1a5i7fFFc+PBb
         zaiA==
X-Forwarded-Encrypted: i=1; AKwUvBz76ArhV/JQATGHNFwvJqSSsltLHiklaDnHwOXhre8aZ9f6ZvMLkacHRWQsvBCXPZDGttF0d8E=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8ihOoLHSurRbzauwOaKNZXXCEjkx/BPY/gXPjLHKKmQyhkGlP
	zQFbJsnI8RVbnfeymRK5a/DItFaK4YmBBqY3AyuV0kmIjiyrziqNygqs
X-Gm-Gg: AYBFou1sq6AL6JjAGZNDxKeRaOCGRRnYg4lbxmfcbwqfCtH8OTqY9PmkF8huqKAl7EK
	BvmuyHVNlsEltguSidz1XefcY+PUPhPHJSePArtY/GNHhC3Bjut0UcE5OMk94urqdpaaDL1u0Yt
	oUKxNqLO9XngHQuL3EOn+9tTQC+j6D5ik6j4Y9DptFDr3f0ok2o4NjH7eWtTIAeXdxog24o87/e
	qald/enYIy63/htF1WVvF3PfwpHfEAWumf9owZ+lp1SOwb6kH8pQPnWCcYP9r//eNO+jp2Bvo55
	pIlb7OxMIWCpypmtrjxPe0EsI99Xf3b4Trs9Qucm8HlfL55ikoDWL84MTSwbDVROtkRDKICQyEg
	iwbCBA/s+yGZhgciNWqqtj5Rs9KEFhHnxRlJrdm/Taw/mrpSpcbE+GbBsJ7SVZFxf7yayOkp2CX
	Om3YpwpKq/chvIUE9JaZU0acpwx3NGC2AIOckEe8N29WscHTr5ZAk60t0OWbm3nZBbzJtZVR5sg
	++WafCYygD5VvAOXV18JXHL8mMvJ8RNjJwDzziJSVrsZug1rsksAoIZGlRDmFCZP4BEZuRsZKx7
	UMJQPQ6dwJDa2yv/cZY=
X-Received: by 2002:a05:6820:1c84:b0:6b1:a812:9871 with SMTP id 006d021491bc7-70da9e1b77emr3695466eaf.18.1793098063493;
        Tue, 27 Oct 2026 03:47:43 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89b77sm6597299fac.2.2026.10.27.03.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:47:41 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] vxlan: reject VNI add when the default fdb entry is nexthop-backed
Date: Tue, 27 Oct 2026 18:47:13 +0800
Message-ID: <20261027104713.328028-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261027104713.328028-1-bsdhenrymartin@gmail.com>
References: <20261027104713.328028-1-bsdhenrymartin@gmail.com>
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
+	    !vxlan_addr_any(&vxlan->cfg.remote_ip)) {
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
