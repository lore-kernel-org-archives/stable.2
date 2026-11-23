Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444598;
	b=gkuTCBvAyvJW3zfGwn9tvTwBq1mFDgnFEzRlIzVUoreIGV48Nr8HyjlcCgVNPExjYsE+
	 KBn3z08IGRNtKjuTwjoVj03cdf2lsQfhjoNJjETQylxdWWLwWXnmQ8AYBRsDDLqPcoL3s
	 yDPUEWmnukTtntna0z09cBKUPUGXdzqierh9I7jYrfjNEJ3vFYWVBRNkN1htur20uvvdH
	 ixKnvgABo90fNNrMapa1Xz24CkCX4rmEsd573Tm2NV8Us/muvAegjL7vbaL/UgusxX8mI
	 jnjmdT+FPS018d+/lz/di7666tT/+dl8xlqKchRh+p/JRfil0pt6suLPnjJiA0bqjuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c7RIFJ9JCRdyaG8UKVxLRWxNqNn9TfnyLCzHHvdNicM=;
	b=CSF6iIq9Dxl9jy8PFAJyUmfy35mMXWHAmXb1C18c7Nmk+D7FwgoF6mGlU3UF4WMTuuAh
	 flZc17cSOLh+z9573IEp4gGeqaWFFzUUBKw3xunaB6jEhL4dPzmAHGCWqgGMGE4uGl/AK
	 UF2iK2EfuH3EOxlyMg9Fwp7eZE0PICeCMkIK0u03ibz5E44vqZ6gSQqO7w+5CFeENC1rB
	 r9c5dJ4wxHMd0zONjxeKHDRaO4Gjty+gVWTSlgEMcSxki7qtN3myPn5bl0sP3q96bacFS
	 QwRI+79cCNrHLGkcIybrH0dn9KIMaomu7qTD3+66NppmT+ZLG3scvH8bQb5GrnXdb0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=HQ61VKDz;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F233606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F233606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=HQ61VKDz
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f02f04a426so27406305ad.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795444597; x=1796049397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7RIFJ9JCRdyaG8UKVxLRWxNqNn9TfnyLCzHHvdNicM=;
        b=HQ61VKDzJuSyLg0GiLde4RIIRMg54I5xdOttpoZvzcz3swdIwdA/eSKH7IrbCIaMFH
         1ftQy0jVuo5nXxQBRZcVdZovUXDtn1enquSp8suF8HRaLvAAz2EKh4Af0WRRUH4/wAlv
         esH1cGnI3PK8URfa4yjsw4UQA14K+y/p53Aos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795444597; x=1796049397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7RIFJ9JCRdyaG8UKVxLRWxNqNn9TfnyLCzHHvdNicM=;
        b=yTukA/u64mkjDHw+DnHdfRMA5aV54E0FjjAqWMuXe7sqLLhMRysaPXZg3yRtv1qqHc
         STJgDFg53uMaLVVjtlCzWmX2V7dC5Atv/50tmrS54aN3BncfAFJ7NzdIxM1Wm2UlyeDV
         Ax/l4ZJkor+ZIXVFMtsY3zarBykdO+/xKs5X6l2k5H3s7/CkQN5zFQax5Urucml7rHo0
         gIFaTfD/fIiDZPm2XUj2ybjS2//c6IKxNPppf8MVSmY+NHKrBoKCDTEYZqgYzBN2CCzg
         Q/zVVGRl35ssM4++9PujG/lK+V9OuE6qhxHIPY2W0Gukpd4cdgeRSBCud7gpcLPFOe18
         c0aw==
X-Forwarded-Encrypted: i=1; AL+hErF40aXuXXFFNQi58D+E8J6IX8J3bd8IlpUVVKALGvw2U7IIQoQHPLDhRpXyNOGYgk4sVU44LV8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L5I7Bf+z/QmlP9FotaFBzt7FbSKw/IKMuHrS+kfSahHoX6Ie/
	laukHbjfuQ7VCypF9tdm4nNsVwbn9fPaYUrBM2PSaQgiYpv8U662wS1baVgn5I7Z7pc=
X-Gm-Gg: AZFdTZfOAnvJReLd6sfJ8F7Pzfs5vetgRmJNvOkxMuRb3A3alo2uahk5AVXC0siRKxV
	eFFnFAIC/HbwdlVYM88rkNCuqSZBGrDD7nrEatRTjpHzoCrWLvM5r/tPy7CSL0zEAQJFdRJVnT1
	cGNc51gSdo5X0NnKl01FRjP0K4RU2jjRvZ5GRc+3W/b+Do4ASsDInOFjEG6zlZ+RuGJrzmSj+d3
	W7mxU9isQGUPcVzwzWMtpvzc3ChY2OiyLeu43/Elfzk08R+u3BLYkMbgdNcwDz20Qe7g0Y3mR3f
	gb9L+Xg4MbSyfmPYH6KwutKCoBABA1sxbc9eE9VDsPfehLap1+waVQT0GJE212yIVsQTAq3r0cT
	MZFVLSv37rFpuIDqoREegneoBtmo33AGGaV4ajxj+KHXD4nGJUQ9DaTz4tYBXJjAEMr3xTP3khf
	wA5DtPVo5AsFd4HLKQ276VfmLDkWY2mqAN84EOu4hPjcW280qzckZPQbAgVIk9JEp5rZhXjelzf
	cHdaAIcWY1M3oKkNjFyMB8ADajM9CWBP95TKPPNcUW81kNvF0mBpQ0pTsbUrmj8ztpLbUuDyPK5
	Qyg0F+IGfzdTUXZN9xHmhQKIUVxXuZEeZQunJwSYjX3Xxw/gcM/1fO2MpNf2+PIj6EmtrJaefKc
	Ha3/eMk1GKYnurauzYaP/CR9h3YoNZxTxPSiJstyKCNyH9P0eni5EiJqZBnOAcZlJWQ==
X-Received: by 2002:a17:902:ced1:b0:2f0:340d:dda4 with SMTP id d9443c01a7336-2f03f1ec3fcmr143338425ad.24.1795444597511;
        Mon, 23 Nov 2026 06:36:37 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee85466sm54062085ad.4.2026.11.23.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:36:36 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	Piyus Kedia <piyus@iiitd.ac.in>,
	stable@vger.kernel.org
Subject: [PATCH net] can: j1939: do not pass a NULL session skb to the socket layer
Date: Mon, 23 Nov 2026 20:06:25 +0530
Message-Id: <20261123143625.4021586-2-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123143625.4021586-1-piyus@iiitd.ac.in>
References: <20261123143625.4021586-1-piyus@iiitd.ac.in>
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

j1939_session_completed() hands the session's skb to the socket layer
without checking that there is one:

	if (!session->transmission) {
		se_skb = j1939_session_skb_get(session);
		/* distribute among j1939 receivers */
		j1939_sk_recv(session->priv, se_skb);
		consume_skb(se_skb);
	}

j1939_session_skb_get() returns the skb covering the session's current
offset, or NULL when the queue holds none, and j1939_sk_recv_one() then
dereferences it on its first statement:

	if (oskb->sk == &jsk->sk)

sk_buff::sk sits at offset 0x18, which is the address in the report below.
consume_skb() tolerates NULL, so the dereference is the only fault.

A peer reaches this by completing a transport session that has no data
queued - an EOMA for a connection whose data packets never arrived:

  BUG: KASAN: null-ptr-deref in j1939_sk_recv_one+0x34/0x170
  Read of size 8 at addr 0000000000000018 by task syz-executor
   j1939_sk_recv_one          net/can/j1939/socket.c:318
   j1939_sk_recv              net/can/j1939/socket.c:363
   j1939_session_completed    net/can/j1939/transport.c:1247
   j1939_xtp_rx_eoma_one      net/can/j1939/transport.c:1424
   j1939_xtp_rx_eoma          net/can/j1939/transport.c:1439
   j1939_tp_cmd_recv          net/can/j1939/transport.c:2153
   j1939_tp_recv              net/can/j1939/transport.c:2201
   j1939_can_recv             net/can/j1939/main.c:108

Test the skb before using it, as the two other callers of the getter in
this file already do (j1939_session_tx_dat() returns -ENOBUFS, and
j1939_xtp_rx_dat_one() warns and cancels the session).  Nothing is warned
about here: a session completed with no data queued is a peer's protocol
error rather than a kernel one, and a netdev_warn() on this path would let
a peer flood the log.

Cancelling the session instead of dropping the completion may be the more
correct protocol behaviour; that is left alone deliberately, so this stays
a fix for the dereference.

How this was found: by AI-driven fuzzing built on top of syzkaller.  Its
analysis was checked by hand against the code, the fault was reproduced on
net.git main under KASAN, and the patched kernel is clean on the same
reproducer with ordinary J1939 transport sessions unaffected.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
 net/can/j1939/transport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..af54e6a6bd71 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1243,9 +1243,11 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
-- 
2.34.1

