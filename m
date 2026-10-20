Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500303;
	b=r8/e/9cEn7dgPoZvlmpNuGhxyLumKHjSf3DqMRktyQBrlw9TCMUgo6CEy3sB63KgWxEP
	 1axB5ALq5uiVrht4nVAljICNMdTnNBy8TkH0pzBhfWuwwJ48PGgjnD9ZH6nObE82nhK5f
	 /xOC1xDhcjyc/f3gJBBPIpWaeXHaytJdL1PkBbCogNCPNI9U+1S6777N2K493p8JuFiBW
	 AQ63aiWkdDD56rnTSsjm5uNX8OHIadaDHP4Cu9GssZZ6Gf5s8/eL0prVIisO4Jq7MDqNH
	 2V5AaoLBjk+xNG+Xmn7hWzlENpreBOvkFzLOvDv1K5hvZFXZwdwDHf2I4O5twqyfRzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500303;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Authenticated-Id;
	bh=Eb9D7KTBeb4IYVRtQ1FmeANrrrWvxTGnp7qUhdj7ORY=;
	b=bvSN4JYpgFjFR/h1lCCRJoCC03gpk6VeQAh53t8ZQfIRScUUFhyZFb5Qze0qiYh+7Pt/
	 NneXo7XDDpZC27A/s0w0AcKwotI4GOm+HRVFa2iN03VvsHl4FQNUE1O5VHBh4ZBSu0IqS
	 hmuZ4l91G97UVbOMsby5hKPDof2GViYkWXJwSosjmdAns9rfOmNkPMzmZDr8azyMlUtrK
	 YNPBveM5DJq0GiPcy/xC+aNrrTF72nmVdk+gTvbwKoUywmCXuYjJhzakPR+EgvKGpZJIm
	 aAGs4v0PSyFgks+6kpH7oy9g27E1bTYqCyscBfdX+wWSyYnHpmTWf2yZrmQhjSZ6Epg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.36
Received: from mail-e681.seohost-mail.eu (mail-e681.seohost-mail.eu [213.239.133.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F9606A321;
	Tue, 20 Oct 2026 12:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A4F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xJ9D4-00000004hL7-0jZb;
	Tue, 20 Oct 2026 14:44:54 +0200
From: Piotr Kubik <piotr@kubik.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Muna Sinada <muna.sinada@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Kubik <piotr@kubik.pl>,
	stable@vger.kernel.org
Subject: [PATCH wireless 2/2] wifi: mac80211: set the link addresses of a 4-address AP_VLAN before its links
Date: Tue, 20 Oct 2026 14:44:46 +0200
Message-ID: <20261020124446.188739-3-piotr@kubik.pl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020124446.188739-1-piotr@kubik.pl>
References: <20261020124446.188739-1-piotr@kubik.pl>
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
X-Authenticated-Id: piotr@kubik.pl

ieee80211_set_sta_4addr() gives the AP_VLAN of a 4-address MLD station
the links of that station. It added the links first and set
wdev->links[].addr afterwards, from the link_conf of the AP_VLAN
itself. ieee80211_link_init() takes the address of a new link from
wdev->links[].addr, so a link that the station gained later came up
with the zero address that an earlier call had set, and the copy from
its own link_conf kept it at zero. With two such links,
ieee80211_check_dup_link_addrs() refuses the change with -EALREADY,
and the station stays on the AP interface instead of its AP_VLAN.

Set the addresses from the link_conf of the AP before the links are
added, as the AP_VLAN link update in link.c does.

Fixes: 469d5d5a3b7a ("wifi: mac80211: synchronize valid links for WDS AP_VLAN interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Kubik <piotr@kubik.pl>
---
  net/mac80211/cfg.c |   17 ++++++++++-------
  1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2823,26 +2823,29 @@ static int ieee80211_set_sta_4addr(struc
 
 		wdev->valid_links = new_links;
 
-		err = ieee80211_vif_set_links(sdata, new_links, 0);
-		if (err) {
-			wdev->valid_links = orig_links;
-			return err;
-		}
-
 		master_iter = master->vif.valid_links;
 
+		/* ieee80211_link_init() takes the address of a new link from
+		 * wdev->links, so set it before the links are added.
+		 */
 		for_each_set_bit(link_id, &master_iter,
 				 IEEE80211_MLD_MAX_NUM_LINKS) {
 			if (!(sta_links & BIT(link_id))) {
 				eth_zero_addr(wdev->links[link_id].addr);
 			} else {
 				link_conf = wiphy_dereference(wiphy,
-							      vif->link_conf[link_id]);
+							      master->vif.link_conf[link_id]);
 
 				ether_addr_copy(wdev->links[link_id].addr,
 						link_conf->bssid);
 			}
 		}
+
+		err = ieee80211_vif_set_links(sdata, new_links, 0);
+		if (err) {
+			wdev->valid_links = orig_links;
+			return err;
+		}
 	}
 
 	rcu_assign_pointer(sdata->u.vlan.sta, sta);
