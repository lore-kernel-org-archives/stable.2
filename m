Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1039E185
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578429; cv=none; b=n9NcJ9nPYWh/Bnu/nO7X0rhu9EsNDlwHxBe5tPjGOxggE2IANKecYaIwy6X44j7b/vzwunbua2TzBnNH2hxqleyseMSZkE27OKnsCSbh4ubKsr2kmM304fEQQov3MzJBdkgPOiMLzUJSrb5n9WUdkh/IEntDcnynBVTdLyjTud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578429; c=relaxed/simple;
	bh=XZqrez9VS5MjBheyw3vbKavzq7Yfw/IeJRbqurVBbvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BDzSKzDOfzDndFEzKOK74LSe7qy59NS+NVcrmm322YspQFZuZ7KSf2w/n7tOwHtU+yMEGIGQg3hDLORsCrNu18JSw5ZfDp3x31GmWTppwrAxfH5IqPCvxxsG/F9LYhPVeQO2COWyHPGn0K68FOH+w7MrmR7ZH9/X8T1f9rvhL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLV2oKeT; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLV2oKeT"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so17096985ad.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786578424; x=1787183224; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NR/56WqZXl4JwV28tyx1ta55KXzZFifPA0V0leVdwDk=;
        b=dLV2oKeTL5xZB6CrKALYtJ8RNOA9Ab12qxPmEMeXAdjRyUiX9Cim3ftdWmtys9KxAs
         iu8HnuG6gL8TS66Y865IU11GjMzeU5qNyMiAqjUfSVyyI+x5Jv1ySwJebIRDSDSsrDxS
         aWg+nh7yHqV7nvSX7d0QY1wS9aGozGAwiq7PCkcFBL8HgEdl2SIm3FsXPEpsVBlzjeTf
         tAi/PCqMkpdhWo5dUbwRXw1TXIfEar/laZX8glUUratkOfvfIU0SHSk5a4WxByOl8WVN
         tY0tYWU7MBQ6aejv8J3kjhsXMR7659olCMCzXC2yp296gsZx125kpRtvEPxijEzqFh4X
         NAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786578424; x=1787183224;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NR/56WqZXl4JwV28tyx1ta55KXzZFifPA0V0leVdwDk=;
        b=m1LlaVq1fkq8JSS/uZIYy1xdyGo/WBukCYJfiA1w0ZYtJ74vui07pNgrlQuPgfLfaO
         vvqzYHM04/FFrGhmbv3Ja3q1+qOUQCP2M07xkw2Q2dgyPXpNmo8VfrQZTJDczgbJbdBX
         xNy2QnqyfdtIHuToI5NXyUdU2GFTHCnpEp7n7A+/0m8kJ2atat41BjQAup00YRDRj//X
         yk5qSJUIWPqrI3WhXP2ViQWNCwSKSeQ5bO/iYv+iEUK7ThMm2duLDNojooiInP7jTb0o
         XpYchdYN6AixC0WepuBCBtBXWWilqzwdW6/MybWGEZ0pRo77DFepFWkrRNoFonmtuJ1+
         jVUA==
X-Gm-Message-State: AOJu0YyfUEopzlWafoRSf8Q8SQl+Uu2M0thEnSOsyMGsr74QV4xU0Oas
	2Lz3SqacHhlqxSAeiEIeQcQrJcEiVrqIqSC8mQ0ihYVCwJMrsGgztEbjNWlnOZTFr9RRF9BXUr1
	SPxAkV90trqiDuNMaZtlkkQpdZZE5FVQNb7YTOcROkCEl85Ag9+MBkXzfEFfU3vZzHXZVviFDtJ
	TaszRewJ/FlqMqWBIl8wrP03TPMxzD2RE=
X-Received: from plaq21.prod.google.com ([2002:a17:903:2055:b0:2c7:a802:500b])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ce:b0:2c8:2808:3ec9
 with SMTP id d9443c01a7336-2d37e855643mr16660095ad.12.1786578423347; Wed, 12
 Aug 2026 16:47:03 -0700 (PDT)
Date: Wed, 12 Aug 2026 23:46:59 +0000
In-Reply-To: <20260812234659.3439057-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812234659.3439057-1-tkjos@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260812234659.3439057-2-tkjos@google.com>
Subject: [PATCH v3 2/2 5.10.y, 5.15.y] Bluetooth: 6lowpan: Fix using
 chan->conn as indication to no remote netdev
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Marco Elver <elver@google.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding
conn ref") don't reset the chan->conn to NULL anymore making the bt#
netdev not be remove once the last l2cap_chan_del is removed.

Instead of restoring the original behavior this remove the logic of
keeping the interface after the last channel is removed because it
never worked as intended and the l2cap_chan_del always detach its
l2cap_conn which results in always removing the channel anyway.

Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2:
- added this patch to the series which fixes 1/1

 net/bluetooth/6lowpan.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9424d153f323fdfb1453d18ef7821ccddaeaa5eb..d0b1882f5b4b77d274580a0e8af7a3d43972615d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -775,20 +775,10 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	struct lowpan_btle_dev *dev = NULL;
 	struct lowpan_peer *peer;
 	int err = -ENOENT;
-	bool last = false, remove = true;
+	bool last = false;
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
 
-	if (chan->conn && chan->conn->hcon) {
-		if (!is_bt_6lowpan(chan->conn->hcon))
-			return;
-
-		/* If conn is set, then the netdev is also there and we should
-		 * not remove it.
-		 */
-		remove = false;
-	}
-
 	spin_lock(&devices_lock);
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
@@ -815,10 +805,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 		ifdown(dev->netdev);
 
-		if (remove) {
-			INIT_WORK(&entry->delete_netdev, delete_netdev);
-			schedule_work(&entry->delete_netdev);
-		}
+		INIT_WORK(&entry->delete_netdev, delete_netdev);
+		schedule_work(&entry->delete_netdev);
 	} else {
 		spin_unlock(&devices_lock);
 	}
-- 
2.55.0.699.gb54405d56f-goog

