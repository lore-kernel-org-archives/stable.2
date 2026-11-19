Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057084;
	b=G4bh9EzZiaeZgAjruS/UUgRrcDa5cwNqaZIF5DmAcnu5Dz8b87Ya5yOtkjkizMU8XVIe
	 fGMuRiAvOzyRau8aCARply/lhU+ZhlaGPNoFOgtxayxoea5ek5GvrJmHdxuyrDTS0z40I
	 lWsA1r7EHGk1aWLGENI6lygaUyE51Plyiufc/rZMqp5B0yigQ5xh/z4fMLwFH8kVWjJ6L
	 mMhRlsweXoXf/UkJO1yhMwi7Xsdn79OgdZ/62Mi+gaeilIKaJ1Z8Gce8iSAEcBOfdswDU
	 Dp4BqMOIhg1Q6rB6AbbqJD7cmZw2HSw5lJ4rCvSPpjSlsAtvjbH048jEbUqgOcjk7HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057084;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=oyu43AQhbnv8Td6VHP0A77tI7RMEgxBrbKIy3Qxe1ww=;
	b=hoYqLeMx9Dv3Ac55Ohg3ONyNmbQQc6ObgZ7L92+B4swbnn8+vLMoR+8/VdEnrRGscGb0
	 +cy+0t1H99kU4n4A3TvLR66aG82D28d8oa2S0QEg65iGDLDuIeFpx5RMNCQR7gZeMmg9z
	 oBIgukpARW1YU/lr43UT3ge6EYEgp4RQ4q+2h1zW8X3HXSsq01i6BVgT7YS02ultUTSBn
	 VJe8n8KjUQt9bhmyYpLOu3yQ6Fz7qoV7Xc2VeGyCOaPb40bRMGTWdoMxtrIM7iukD/z0+
	 goFDHVFHdrrvm8eNmfXcTsRCq6rdLFdVHmFe4m9qHZPSYgUbHLKKLy1MJco7qP9ZVvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=kRJAAbI0;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC97606A331;
	Thu, 19 Nov 2026 02:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FC97606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=kRJAAbI0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795057049;
	bh=oyu43AQhbnv8Td6VHP0A77tI7RMEgxBrbKIy3Qxe1ww=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kRJAAbI0FibNf3HypDwQabMuQBJo/tQGFEn507Xb3VOWNf+hBoGOliUDh6Tw+AWfZ
	 7JPEn5XU+66XE86QnwJb+NVdlW1WNfcadfmucttSCDuznDmcvopVey+g1k3pLB9LKg
	 4UUc68d8ad2Di0FxhGvRKToMH42tZiTu7VPl5OJk=
X-QQ-mid: esmtpsz16t1795057026t499ab346
X-QQ-Originating-IP: DiBjuhAcYtxQLVpmqODzZBxM2fWnZDDrgd+4e+eHCRw=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Nov 2026 10:56:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17931095962482534419
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuba@kernel.org,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	melotti@google.com,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tcp: cancel cloned request timers without waiting
Date: Thu, 19 Nov 2026 10:56:20 +0800
Message-ID: <0907415D86226AEA+20261119025619.3485277-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.47.3
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NQDSFSrlZSaize44cg4B4yiJz70QfDlWpy8mB/gBEV7ODpaCeIIFToYn
	6ieHQnxrJyjzl65VRJ3mshoWdBBrCJsTDrBziNGYzkZiI8mlaxQwIRrNGOtpakLrbjaIPt6
	cO1j3d3FkdbhBlBeabUp0P09bwZ6uEUAYkxkifIZJvIWyc/9aHOga9/ckvtW0tWsqK9cafl
	/IUc/giuk8r9CCRX3HSAhT9qMgwmJLy6LCjHdV2RqgWsH1VX5a2IHJaF5P02Gpd05xwoZgf
	SR+3Q7Kv0KhH41PkdNst2z2tqJ/54s1BK/Vfe6LitY82d+KbSD9Ek2fhz0Jzuc1w30Cj32E
	N65fFptRVWT88xJr/iQG5Ea37zHcVfo1UlUwSmjblcrmMzqIfr1smmEF7uzWpE8YN68Qemw
	zz04WEHmj1J5GVLamSPgazV9r9dI0F0o+jh1h+ZvA+hxqlcsDoGLE1mKMQMto6bW6ICtKla
	KU2E9AaBFHzkOOFrAyLE3OmFTI29wAqF6gZFTQcXXJzNZR6skHhkpCm1kKHUgRJJCrLAYIm
	cMnT3S++W2X4x0nND913/xBnLSjDoXmSy8Adk/vzG1i/DWAlCCEOXehM1652VuWBq44ZovI
	FTSmynkM+Vhv1TwCOGmWxxRsfLDzu9tqz6A7mo2IpGkqoHN1uihz95aYi+keb50/V9w5jdt
	hktBFisArh/K5rNcDYODKNV1iYPuhs/DamgYNh+0aWmwnddjfkM6rai4VNlo0LJaVMAevJd
	DxHpFXiR1dL4or7Wo5UIhPGXq1YcKlPJgW92ESX8Ekb7YGG/UdFyKwZ1dL5x7lRwE+w36bQ
	7BbB3MKNOziJgVD34QipoOfDMUhKHow38Up6LvDo4RQUkjv/uuay15tgx1/K8j9UxBe7NTR
	a7NhPuW2ldQqTH8y3F995OTdq4RnCooP67ATDOwoeHS/k4plYpzjUSJ/NnD/fJZ0G4Oful8
	2I5y8J/d/JxaMAWCuwY0VfFSFHyQHoslJWXzUjjSI8325H7/J3SN9Ay59k+1+U1/d0JpPiX
	L8jyAk25WJOi6fV6edhQk1+DPBPYUJvPpOtRKYVQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

When a cloned request is migrated again, its timer has the same lockdep
class as the running request callback. Using timer_delete_sync() through
__inet_csk_reqsk_queue_drop(..., false) can therefore trigger a
recursive-locking splat and disable lockdep.

The clone is unhashed when inet_ehash_insert() fails, so
reqsk_queue_unlink() is a no-op. Its timer is pinned to the current CPU,
allowing it to be cancelled without waiting for its callback. Use
timer_delete() and drop the timer reference directly instead of
synchronously deleting it through the queue helper.

Fixes: 97c8a3c1f73d ("tcp: Fix potential UAF in reqsk_timer_handler().")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/ipv4/inet_connection_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6c079929e06f6..346d0015a140d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1121,8 +1121,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 			return;
 
 		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
-			/* delete timer */
-			__inet_csk_reqsk_queue_drop(sk_listener, nreq, false);
+			if (timer_delete(&nreq->rsk_timer))
+				reqsk_put(nreq);
 			goto no_ownership;
 		}
 
-- 
2.47.3

