Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34835838A
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782604726; cv=none; b=nAk9pF7TCzJU9mDgoP5cjjmBD9y/Bue37eTeMHp0u3CpUAESNvWZHoSn3v91WrGPmXBZne3zf5MhjTpVuOHnFv8lUmPNyG813slHArq9viIHk4jleYaklY9864ZAtWwJMMjbTS1FyITFuKiNhQ9lXPqGWVxa7ykHBmE5EybaBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782604726; c=relaxed/simple;
	bh=t1c6ZkEqo/5nbeX5Y37JbyRiMyH/PLMuUEC6tLqOZMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSTALFV+XWSMBnZOD/uzVBsYjY4MN8zmUAu0lfwI/H2wR1rx94MZW/hWyL0nPA+a+rkvTEIz5QpTXP7eua1z6P1AwD+mEc856JGoAPXE7P1uK9nx0oDdU9MC2jo19wK25G199e6JnFYtPbmFgtg0RIJku8tocpx+mS+cXIe2jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml71Fd3d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml71Fd3d"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4704d652e9cso459570f8f.3
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782604723; x=1783209523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skDXyZAJq24/qIOZkzrlcPyP6eRzwfs+LL2sC9Z2FWs=;
        b=Ml71Fd3duV1vI6zM10YZHcg6HyOIuenZTSsfAoDutffzyyGHUyzVsdOt0W+RfAglBa
         E1ER2BeOLkAEVCG8I2p2hugupwPqVqYUjS8BrjTyMSL4Z60J+AsrlvzbqXHjS8nXrfcM
         ANF7zRqKWIUmfWi4SeH1AgjK9a0q1dGSgHn700ULmNSFaGU9zdWfhs3KLyZhaCgRct73
         6HNRqRoHtqytA5KixJOmpVlS3k5o8ZjjDVsJTABIPIayhJQ9y6dg1gPALi9JUDRqfNAb
         BW3zJPSCTC3RqQiJJ6Hb60p0symHMSP9KU12RyraBqRCaiUore1VE0f3TbepDuGqhBuH
         J+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782604723; x=1783209523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skDXyZAJq24/qIOZkzrlcPyP6eRzwfs+LL2sC9Z2FWs=;
        b=RcTFfIzHl1njd+AuWuPpt6t693Aka8fJpTpnpS/EQGeLkvw1P5KH/R42YUJg0EIJfI
         fcxtDgMv/ECHjF7gwp+wLbu4GOXBVFKAx88ExeMxqgWSSrlOt5qkNqNlMIT8q6cQMR4I
         8vIGJ7HDlNjpwLuC2VUmSb+lJlgCoau0QZHmcNnwKG4Fh4+dfl2kyy5NNv7AYw+bwOlj
         OUfCUlu6HA17jZcMQ/rg7B3UtuxlzroDJrVrb9oqWSHz6ztYk/URC98CBhZop79VDV3h
         GnnVPOJzs5Cy1wJ7sjMMOniXGTYOtghpASVdJl0IZLDDXQAWestMAJmrXFD44mtnvzU1
         z3qQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCsnYGFrkQWY3yMoe1z++b+rfCpHhaiRh/t6K2i59vXo8BuKiY3EBx4ddW6yV72SuxNcISvFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzslVc18CPF2c0VocEQMS6CXHryrrn6c0mv92zbaSvWgNdPY+yT
	Uf9ZFR8yG1Wk1OMw2JCURFir0cPQp+0uR41Z0Uu67xHuBuhvp7XzReMK
X-Gm-Gg: AfdE7cktCdVF7ve511Mco07mN095DgjFOcTaAepIMxUCupyeJb14nj64E0/PoAjmJop
	TUE0/wyECBk/N7PcMVZXMwtFIRSCQEdOtgSn7E/8d3jYYVWDJ0955Y/q/I49kpozR/FGRxVw4f4
	f/LVqbK2ikYBzUT1bKZEbLqNEc7nb6Gyqcr4AoAFDB/Zb0f6oFj+YWZwJ+wK6ZzHtc09b1bqpuk
	lTmF4hyiSzXYrelNYq5lxWo38am7teWTSdjs0zb3nDe5TMITshTupGXHZ+4qHcWPk6xBGCVvuQ/
	mwAbdBczQGrfz8u3u6oMT3iGVLgORybM2ueJt64M9S1Dop2dPxj8hPzZAuVJKozDON68uO2l0mP
	yLle9Du3y+fn7am78HBZP6cz+SGfZYyK64ShTfLrIm3tpAh6RQzxcdZ10FynZP+r0a6NoKI/6lw
	RDgKssupsGkzsePEzMRvUs+5jmQC0bkTfTMMmc
X-Received: by 2002:a05:6000:470b:b0:46d:28a7:3ce7 with SMTP id ffacd0b85a97d-46dbed35effmr17819314f8f.7.1782604722940;
        Sat, 27 Jun 2026 16:58:42 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm8348957f8f.23.2026.06.27.16.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 16:58:41 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
Date: Sun, 28 Jun 2026 01:58:05 +0200
Message-ID: <20260627235805.17310-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwsim_del() queues the currently published PIB for RCU freeing before
unregistering the hardware. The unregister path can still invoke driver
callbacks, including set_promiscuous_mode(), after that grace period has
started. A callback can consequently dereference the freed PIB.

Unregister the hardware first, then fetch and free the final PIB. This also
handles a PIB replacement performed by a callback during unregister.

Fixes: 1c9f4a3fce77 ("ieee802154: hwsim: fix rcu handling")
Reported-by: syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4707bb8a43a42fca2b97
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 6daa0f198..2a2d8a9eb 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -1004,12 +1004,11 @@ static void hwsim_del(struct hwsim_phy *phy)
 		list_del_rcu(&e->list);
 		hwsim_free_edge(e);
 	}
-	pib = rcu_dereference(phy->pib);
 	rcu_read_unlock();
 
-	kfree_rcu(pib, rcu);
-
 	ieee802154_unregister_hw(phy->hw);
+	pib = rcu_dereference_protected(phy->pib, 1);
+	kfree_rcu(pib, rcu);
 	ieee802154_free_hw(phy->hw);
 }
 
-- 
2.54.0

