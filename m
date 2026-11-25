Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639183;
	b=EowIRm2CR1PoNOS5+2KPF99/X2cG0zvHiRRl46tjCib8Kw4HQsxSPS2qMe0T95abBO7X
	 FXVIhKKChM438TfGkSoF6Fy4L1z5RnwWei0CDzGjxw5QJLEkxSRoUrVAP9CBbHAec0S2A
	 AvLRpBHSm/lJqFbC/7Tdtpd5T8OiUE8TXZilh7QtTvi8Jn9s/O/ZrqhZyYRftjUQ/eyuK
	 XfZ3JxbIU+69zN2qAyhMsl1snaaHeNCl9PZj5pKu/Zvtlrf66O28OQMHL6ZtuOHKDsSPZ
	 btg/spLk9sPgnv1ajqed/1qEXN39ZiXfHTxWbKwkIgbjmyUMqP1JXBI3E8svqlEECJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639183;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vXKH2spvsDT/KqiSDmc26kzXpsaBZaT37lViH2P53BY=;
	b=hgJlcEmt4WhE+zGUWK8Rj3j08tk2Ky+gwSqtJqxnvwM+/FN1doRfkYsOI36D5yOJ9ZLF
	 bHMgbWWBlKaXjkp22vxNCNTuhZga8vcmK1PSvfeBDMlXeAExAqeDNHpclMUvNbPJwU9B9
	 yqwpHbHazraCcURSETdVHypcPhlSH5ChNc6x9hQj4vnfDKZgbQpBi3dzEmvYCuN42cwFa
	 V0n3TpAE6i28ZiAJe8T9wMXDbXzG4/wns1lx0nmcyVCjFrrp7z477989cAJ4d15mb3Cpv
	 OduPQeJ6GiVI3P4oXrBB5vvRZcuJWqVLcM7oCWSyZ0RB3Uqt+VJGqEzZbRwhLiw2+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAPQP7rk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433C606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAPQP7rk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297151F000CA;
	Wed, 25 Nov 2026 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639183;
	bh=vXKH2spvsDT/KqiSDmc26kzXpsaBZaT37lViH2P53BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lAPQP7rkhNLu+pwjeTAzKGHCqId5k3S7zKOgdZv4gvOzb4YsKrsSJRm7GV226CKhQ
	 wv8I05wQIyNFw7jykEEKJLKKu9LGxy/t0RQIA7wHD9ndvMZxhsUsg17C2BCIqgKLKw
	 22RiCWHCzBcb3ATsckw2Q/TRjF2Em5pcO87/+SbB18ivdIlVPYo41ksydrWZxJqr2y
	 qimwKu/9FK9LY1tr+YGHzItoPG2kPyWMNRCgWQzvkP9KY8mV0QOoNDPHBYLAJzdgQ8
	 DyGuTo5k6ME8OXZTzCgTDfvKMcOPsK/E1HC04qD5X3qyAoM8c6zq5542A5mLXoI4wB
	 fn84BqI7KoLKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] wifi: mac80211: drain link readers before stopping removed links
Date: Wed, 25 Nov 2026 15:39:41 -0500
Message-ID: <20261125203923.1418678-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125203923.1418678-1-sashal@kernel.org>
References: <2026112508-leverage-contents-d7bd@gregkh>
 <20261125203923.1418678-1-sashal@kernel.org>
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

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit 745f5d04395dfc4c311f443c7c04ccb00c436984 ]

Removing an MLO link can leave work queued on its link container after
the container is freed.

ieee80211_tear_down_links() stops each link before the RCU grace period.
A reader that fetched the link earlier can therefore queue work after
ieee80211_link_stop() has canceled it. ieee80211_request_smps() and
ieee80211_csa_finish() can both reach this window.

Record each removed link while removing its keys and debugfs state. Wait
for RCU readers, then stop the recorded links so cancellation includes
work queued by those readers. Free the detached keys after the grace
period as before.

LLM assistance was used to find the bug and review.

Fixes: efe9c2bfd1a8 ("wifi: mac80211: isolate driver from inactive links")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Link: https://patch.msgid.link/20261028141708.5532-1-enderaoelyther@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: Reordered the removed-link stop loop into two passes so the cancel runs after synchronize_rcu(); context differs because the older tree lacks ieee80211_link_debugfs_remove(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/link.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index abca9d627cfc2..271bbb05bfde9 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -80,6 +80,7 @@ struct link_container {
 static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
 				      struct link_container **links, u16 mask)
 {
+	struct ieee80211_link_data *stop[IEEE80211_MLD_MAX_NUM_LINKS] = {};
 	struct ieee80211_link_data *link;
 	LIST_HEAD(keys);
 	unsigned int link_id;
@@ -93,11 +94,16 @@ static void ieee80211_tear_down_links(struct ieee80211_sub_if_data *sdata,
 		if (WARN_ON(!link))
 			continue;
 		ieee80211_remove_link_keys(link, &keys);
-		ieee80211_link_stop(link);
+		stop[link_id] = link;
 	}
 
+	/* drain RCU readers before cancelling work they may queue */
 	synchronize_rcu();
 
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+		if (stop[link_id])
+			ieee80211_link_stop(stop[link_id]);
+
 	ieee80211_free_key_list(sdata->local, &keys);
 }
 
-- 
2.53.0

