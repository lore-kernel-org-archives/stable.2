Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282362;
	b=bMW2waGtjO/rxwuEDw02U+PPIOHm2XGJchwXj/rn0LVpwWXy55CEJJOlMVB9rNHht8Jt
	 mWMbuly8K5yPRSQ0bO3z89T0deMrQVXmeSliLKUIJU4kefP8Oh9OwTdNQMVL8tlyzNufJ
	 kmqUYbECDbD1U/Ixmt/c6+F2zS87+/mdCarFqWdOhlQc1WminK85SriKcwgH8TZR+iB/O
	 zgaV3kyOsimU88rq6ZQ6TNj76v9zfCPPSOL3yp3ikW9CX1m+r7h4OhdV0A/vha3p4i2z5
	 z4GKa3xN47DXPZgt5aaByLJOac+JbHZzCAD82MaG6U2n3xVQ4w7k/iwEe132FSRkm4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282362;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dtEOZ5HRcHF0rBhzzuMAfFC4v3ihCe15j7DwphYqxpI=;
	b=Cu4yM/efMJ8kp8tA6yzmA/v0+doKMtXDUSvEhKCD7y0qSCNY/HbGQEqtVgeb+NScd7vq
	 byztJP7EvvJ00tKgiTDQGnxvtL6sfawRSuIk4XID5G/aHsbxGwADyJEJ2mq0BNRgsy1Lm
	 k0yHJpaobb4V5/nqd2URp8hHtPrkNJAFg1sEwZAAR6vLWirQf9Ae6rSZJ+f2mZW7JYsqY
	 rhWCRzwMM0x9PZzH7iVuJDE83E+1B85xBA1HvVrWZmLENrCj7tOZWJ3NNMMfDndHUJ7Qf
	 nqRFUyRUtqMnwTzFmNrDJbL1JFVWylMO2Rs5qutGLpTR3LPZdis//npNUGRoWqictBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kawHLgG5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C5606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kawHLgG5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7A41F0089F;
	Tue, 10 Nov 2026 03:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282361;
	bh=dtEOZ5HRcHF0rBhzzuMAfFC4v3ihCe15j7DwphYqxpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kawHLgG54SNaVJ6UKwyivL3lLwzVv6wxPkOLX09dUvC2fTMdfBFMUQoUOX6IE/Fxd
	 FKfkH7gITAeohF4LkCoKtPPjTua8WE6uRzx1D3kn2J6GqJC0ULAjSQvXrtQnnpyecl
	 042zr6v8j5aMs14DXQkK2Ck3spS/uPOjGkSfIGmUu+2Jw/1bdpgpp1UU0YSCp62m1a
	 Q4fQn/6wRBaigTjNpmiGTbZ9V2v6RlrKhZyNkd/l0MSbGX0v/g6ilbyCecO6oDxYw0
	 dXRmvrCf7DcYtHJTMe1f5d86/89f1LTc8H3PkOC4jay9nq3z7fUhzqF+W7BfWxCXno
	 uAgS9Eif+gd+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] wifi: mac80211: update outdated comment
Date: Mon,  9 Nov 2026 22:45:57 -0500
Message-ID: <20261110034553.250150-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054118-failed-6.1-13e51269b665@kernel.org>
References: <20261107054118-failed-6.1-13e51269b665@kernel.org>
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

From: Kexin Sun <kexinsun@smail.nju.edu.cn>

[ Upstream commit b8a57b979a7c2069081ed0bf88a727b17d85ac96 ]

The function ieee80211_start_scan() was refactored and replaced by
__ieee80211_start_scan() in commit f3b85252f081 ("mac80211: fix scan
races and rework scanning"). Update the comment in
ieee80211_tx_h_check_assoc() accordingly.

Additionally, remove the broken gmane.org link in the comment.

Suggested-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
Link: https://patch.msgid.link/20260228061944.887-1-kexinsun@smail.nju.edu.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 13e51269b665 ("wifi: mac80211: queue frames while off-channel")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 51cf8c4e0e90a..36ea274efd051 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -300,10 +300,7 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 		 * active scan) are allowed, all other frames should not be
 		 * sent and we should not get here, but if we do
 		 * nonetheless, drop them to avoid sending them
-		 * off-channel. See the link below and
-		 * ieee80211_start_scan() for more.
-		 *
-		 * http://article.gmane.org/gmane.linux.kernel.wireless.general/30089
+		 * off-channel. See __ieee80211_start_scan() for more.
 		 */
 		return TX_DROP;
 
-- 
2.53.0

