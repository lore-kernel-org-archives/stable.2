Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973554;
	b=EAF93RTE8CL7WCJnubszoTJVxrABq1j2TJ2ZSt/eHDKhgdQEetbeyiyLivOPfxHeKrBH
	 ySngfK/w2TvD3gWItaVGVRrRpdcNxHOImhJMewUxYMswlEvWNweShvGu0r2FctCatPtBN
	 20EOQe9VMzG010HOZdq4RQe2EtHZQNJO8dBlzLPxVlifQ4iXM8W08Zb6FxTohzAhmy5xa
	 qXP3e8NvgqzR7dc3RnBlg4jgeGV4b9jtbq2Zv+Vr/BrMdrz0NJ7+/leTC3BFbW3WIMt0A
	 Y2PJObjV4ThM7A2uWRrH7+mol1SuSdCgdNrrvbeo9KTicye0lwHZdcj8HRTcJvn7ZKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fdyWAktPoh7yf4BNuSuBcGMtWgBKcjHGM1gjgcFt1EY=;
	b=1QHozHPUIHixlGMk0qhmOosRkpwqoGjyGZKmx3iaNuJJyq2RQglncR/BQe7zjGtEbUs2
	 OBHyltkMU/CoI785Isdq8VAN2S2N4Yen52pkEeDKMelogpXG9Qdngt01Nj7qpVVkxt6yt
	 0UOV7E8Dno8tU/JkXWSxiPybGJHNAbnvaDTqcDtwaqpt4wWJ2vcBPY5Ro9ahrz5DsnUG0
	 jKRbzbFQAzt+4LXbQsNrwB0feLHrA1Zaf9Bt/NzkXJAmt6aQ93QMQRZiKO4nOfDFLEkd6
	 vahDDVOZAXPo9h4ED6+vlCqjGyv0suP3RA/Autjx75xxeCyrb6OnXxyCSl7N0G6tlEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P72btyHj;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F8606D839
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53F8606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P72btyHj
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed408b0d9dso2484655ad.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793973553; x=1794578353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdyWAktPoh7yf4BNuSuBcGMtWgBKcjHGM1gjgcFt1EY=;
        b=P72btyHjY0jWhATyUuntFPnCjQYvQyZl6CAC83+e1eJuLGmmk7Srn9vgLectTb7NwS
         SkjrxMTYbyIkZH1OX9DoDc0jA57Mir0CQ7WrD90TidWTpgD6p/gwTrVFFlxtC0+6PYkF
         swJ3gb2skQPh3jakrbqwFmrYeNOQ08vL2/HS9ib3W2KuLGakO5w5iDpt7u9ISs34WWC1
         4sutvtlrtkR7hlYys/VMaFkUgpIikUYS3oLKM1fSOY2OCUp9MqYI3m/Fhtff1hXOSO/d
         tIr+Bda7xassy/dF+LT7We+g6DFiq0/g/6MV4zsyEQAF1jpiEPZsIiku+lL8KaDmdFOS
         OWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973553; x=1794578353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdyWAktPoh7yf4BNuSuBcGMtWgBKcjHGM1gjgcFt1EY=;
        b=mNUkDVBxXxvvA5EeCefya3MZq4e9anlKHgiYgbLuaPHGZ6ebKVkYMObcdmr21aAdTi
         +106aDIm4XTMgUh8XafcoreeUful7vo9Ci1obQFcNrSdTJpuOLJ3TsGvXYNeTfmTzy2r
         TpjcEI5BD3t0xAq9i+FLSN2LqbG/G+Rc+k6hjy+5U3PTxrtM1d+90Bc0Qb9W50qFTulb
         9S7r8uxkx+TFMKfqnk+Cpt2BrL0Y963Rfb6b9znYb/cck60k3UvsE4MQWwCUxOwRHIE0
         zIKJ8oU9/gSjzhtJ1wVAlxIprfxoAmbfMY55HOjftvfXGGHQLRMWCPS/UIfMmch9qETx
         TWFg==
X-Forwarded-Encrypted: i=1; AL+hErGcl/Gyz/QX6Z6Rbgw3l/nkn9hSc4n/QEGYedgMYulpelVpNXWvF3pOIbwPUMZjspci9MXb3IA=@vger.kernel.org
X-Gm-Message-State: APuU4Z91N5/ka27uaBFMmdIazpgASuEZOnfTTBSQQhwhmqhMfmk68qr2
	TUtwbgyL77HSaXdUtd+xdEpSoP3Pb0qh1u2MsFFKHH1s5mzOI1T6K45T
X-Gm-Gg: AYBFou2PKgiXBm6lbpsF7mGZe/NhN2GVUt1RTns+dQ5DOf6IY+uIONbAmzloYwaMEPK
	q3IymulUEj5rKux0hJM2VmeNvABQNI2TZZitjSQakcBcjEQ65DPMLKtStWomeo/UMFgEuL3qV7q
	jboXcfSVSluEHKPbMun51qXQTl9hSaQkOHgj6BrHs9JNjSFpID7xYTLfQfMEqp2yPw3a2H4WMJ1
	N+IRLPkJdgTCjxjdVNWD1yckw8gIr84IcgoYhzOPLYr928QlhtmOrA1Y7xF0+xcwrvj1daW4zYW
	dMfwTWwkollr6sTd/sby7Be2QAHKmogkpJdBzqNQG8xEQIwuPdAu7HasnEcPTMLRgf6FgoMEDhg
	DcwhxXApSMsOTjsbI3cKED/skDOzBY3wLsZb8dCSJk1eRIn/x7mdo7SitUSDQf/7CBeIewMdPmd
	wrVtRfZ+c/hxstAt4/j+OD9Trpehr9tLapOfk+NefeZJaW24CeIQQOvoi04+A8Bfe2HrIBVJKew
	rJvpz6sZ+CaHS70hFxBV++guHNQKQXGkdv8Sr23V5i56UXMVahrUaOd3XfJDUjfTPHuMP7T1ETX
	+Zzbw4X+71mnlbm1BgfLULVwfIUC7qAxdBYo4WfnIPXZgJ7sqeL+3myyFuNp/KYgVvej5+KlxNa
	FakUDrmquzNRU+Q==
X-Received: by 2002:a17:903:2ecd:b0:2e9:7e90:8a3 with SMTP id d9443c01a7336-2ed41bfc38fmr34706695ad.39.1793973552850;
        Fri, 06 Nov 2026 05:59:12 -0800 (PST)
Received: from JIAPENGLIN-MC0.tencent.com ([112.97.59.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d40998sm5634145ad.34.2026.11.06.05.59.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 05:59:12 -0800 (PST)
From: Lin Jiapeng <ljp1205831794@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Jiapeng <ljp1205831794@gmail.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org,
	Lin Jiapeng <jiapenglin@tencent.com>
Subject: [PATCH net] net: reuseport: avoid duplicate closed socket insertion
Date: Fri,  6 Nov 2026 21:58:38 +0800
Message-ID: <20261106135841.418-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Clearing SO_REUSEPORT on a TCP listener clears sk_reuseport but leaves
sk_reuseport_cb attached to its reuseport group. A subsequent listen()
does not put the socket back into the listening section because
inet_hash() checks sk_reuseport. However, inet_unhash() checks
sk_reuseport_cb and calls reuseport_stop_listen_sock().

With request migration enabled, reuseport_stop_listen_sock() ignores
whether __reuseport_detach_sock() actually removed the socket from the
listening section and unconditionally appends it to the closed section.
Repeated connect(AF_UNSPEC)/listen() cycles therefore insert the same
socket until num_closed_socks exceeds max_socks. The next insertion
writes before socks[], overlapping prog on x86-64 and leading to type
confusion when a reuseport program is attached or detached.

Only insert the socket into the closed section when it was actually
removed from the listening section. A socket that was not rehashed as a
listener is already represented in the closed section, so leaving it
there preserves request migration semantics and prevents duplicate
entries and the resulting negative array indices.

Fixes: 333bb73f620e1 ("tcp: Keep TCP_CLOSE sockets in the reuseport group.")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 net/core/sock_reuseport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index fccbdd0430b0..775f446516c3 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -480,8 +480,8 @@ void reuseport_stop_listen_sock(struct sock *sk)
 			 */
 			bpf_sk_reuseport_detach(sk);
 
-			__reuseport_detach_sock(sk, reuse);
-			__reuseport_add_closed_sock(sk, reuse);
+			if (__reuseport_detach_sock(sk, reuse))
+				__reuseport_add_closed_sock(sk, reuse);
 
 			spin_unlock_bh(&reuseport_lock);
 			return;
-- 
2.55.0

