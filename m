Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1226F29C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939676; cv=none; b=tD8leLpn3j8TSv+9pKvn2sxmruJtl3i3i7KMM7ZrHKzS/oVqRaJCETRSH6BcIESh20kUJ6tiB+SFDbds854HZ6d8QBkmxGUeEFHQcWGDA3GiCBxR0zy2WJlhBIAiVlfGBR43/Uq+LeeXUTDt1gWd/LNOfu8L7QXBQznEvgIsJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939676; c=relaxed/simple;
	bh=GxG/GDWpn5mwK1tIal/l0Dw5POK+wIXBW12wM/0SicE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpe54gpClpSoAjcw5k0uLsAlu4a1P+g9I9dqUumoJ/H04LpBRvFC5h+bbxNwzw3SJQEuGcaIAPMCqu3Xrm3oSnbiUDt8e5w2I2zEc1n+mBQ7Fh5E8KiF/7k4ZIYkvRlQSqp6Vy6iCYCIa+yEF+oH2SuuQ3ixLfHtygf8PvCh+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SCNJLHdV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="SCNJLHdV"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f18d92172aso40482676d6.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1783939674; x=1784544474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=djDZZW+WjRlIj682sN8PrAtMnjaRhZOc5mbUij8u74g=;
        b=SCNJLHdVIYR2vI17FYhRc6vMgRd72AMHsMdRQ2KdsC2Klv15BaH19iXc/C0zJDHJnV
         13LKalp32u9aLgo83/OlgzCrRH/y2bKncA2TqrT72u793a//UnkIHQx3YYlWvvZolQRL
         YetGEv/2CoaxkYzO2UN+cEzHndQhLyywNBYIppkE7OwEk9LSiUaPMhDjkiTUM6oQwgib
         Xv/jYw5nBqXpfRNxW4Ec/C24bSerdnlm/00lkVWCtAziw6f/hQiwef98V8eGi8e1E80x
         V+Qik5b7VOgrVcZoo0TEsScFDeedDSBLp83T5XegPuLFBIMbJkBIjmJO3s5qlOoTcb7j
         /bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939674; x=1784544474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djDZZW+WjRlIj682sN8PrAtMnjaRhZOc5mbUij8u74g=;
        b=ha98Zq0MKyMtmHpG9BWozZ+RF8fa5ImZU7aHEYFfCNJZszvTahaiDuOWDR4ruZojuB
         TRHGYtuAc6NAdlBLHXw8QYxhlCKIhfjR1gSsOy/YRHoFncywHL0eJBjoeiJDtu2VV9G/
         08KdJygzg2iRbDAmqWPwwK8yBMd8kWwvLBNG6MCGiRZ5esEd9K7d0joTUcRD0JdCqnOZ
         wFPFckRONwZbmXG26SdsWWjBO3a/uc4T5jr6gHkQoHC/fnIEAgtru3ZaVyuE/K+5N4lX
         syEWwaS3SGzLuE4/Sxry9oSe4gFItO8J5IP3agvQ6DYQ6DYwkTS1IinXta8hE6zTvm4u
         ZGVw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3SG3lyc4IfmbQOV+xZCIi/wV44Pbx9UgZ4AGhX/kgqJG4AhwEZsB6g0LkYLhEJd5Tz7AIQ8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXSkEeaDYb5YvY+2RxMQympsOt07PT8pfd+Rp5A2t8+VcZxgs
	UtBhorsRm81c1jyK4mJnXOxmHTJ5Dfttq4hAuZZAXypOqJOZHruilsWDEAGpBrlLk3U=
X-Gm-Gg: AfdE7cnZTEUaoRE8dRvkd5WX661zDRq6R7yGmqo980YKEYJiD6derPYUnPtXJI+auQA
	vZG9ZMFVxsYgXtJ8/qCEDRu6m2wS7PTpZl1qCWO/6+tI6Meo0dMldHcPutSeIbfthpEIU1sqtyw
	MrMViACje2nBl4EXPlrR/7A7vUFs8t0tfK6u5vhZZX6Uv3BTeKEHDQoSpbPeuLdTWwfPATzx6JO
	qSHgC7spr4fT18eAz2cRH0KM5FMOmd8Po22W/B/KCd0sN6NpUOcIhcq14R4D96uonWSaVJ6N1SS
	EDNXlzU64Jr8UzxzWZ8kxG6BK11uwQrsx2lYkF7xjx8ejbfGWWvnprK1vdAPCFF6q588JUu77b9
	F31RP9A2F2+ene68dRw57W9uAXC/lqnOEVJyAZASnFUbISCp5DIK7wApOpjRN6aCdO0N2H1Gdh9
	DBSbVPYCTDihF8CkmpyA==
X-Received: by 2002:a05:620a:25d1:b0:92e:71bb:d1ac with SMTP id af79cd13be357-92ef2aeb554mr848155785a.19.1783939674393;
        Mon, 13 Jul 2026 03:47:54 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-92ee59223e7sm1031429685a.0.2026.07.13.03.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:47:54 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: David Lee <david.lee@trailofbits.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
Date: Mon, 13 Jul 2026 10:47:50 +0000
Message-ID: <20260713104752.241175-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x25_kill_by_neigh() walks the global X.25 socket list looking for sockets
attached to a terminating neighbour. x25_list_lock protects list membership
while the lookup is in progress, but it does not pin a socket's lifetime
after the lock is dropped.

The function currently drops x25_list_lock before calling lock_sock(s). A
concurrent close can run x25_release(), remove the same socket from
x25_list, and drop the last socket reference in that window. The neighbour
teardown path can then lock or inspect a freed struct sock/struct x25_sock.

Take sock_hold(s) while x25_list_lock still proves that the list entry is
live, then drop the temporary reference after the socket has been locked,
rechecked, and released. Recheck x25_sk(s)->neighbour after lock_sock(),
because another path may have disconnected the socket before this path
acquired the socket lock. Restart the list walk after each disconnect
because the list lock was dropped and the previous iterator state may no
longer be valid.

A QEMU/KASAN run against origin/master reproduced a slab-use-after-free in
x25_kill_by_neigh().

Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by x25_disconnect")
Cc: stable@vger.kernel.org
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5.5
---
Trail of Bits has a reproducer that triggers kernel panic demonstrating the bug, and can share it if needed.

net/x25/af_x25.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index c31d2af5dd22..8aae9273b7c1 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1768,15 +1768,19 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 {
 	struct sock *s;
 
+again:
 	write_lock_bh(&x25_list_lock);
 
 	sk_for_each(s, &x25_list) {
 		if (x25_sk(s)->neighbour == nb) {
+			sock_hold(s);
 			write_unlock_bh(&x25_list_lock);
 			lock_sock(s);
-			x25_disconnect(s, ENETUNREACH, 0, 0);
+			if (x25_sk(s)->neighbour == nb)
+				x25_disconnect(s, ENETUNREACH, 0, 0);
 			release_sock(s);
-			write_lock_bh(&x25_list_lock);
+			sock_put(s);
+			goto again;
 		}
 	}
 	write_unlock_bh(&x25_list_lock);
