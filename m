Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B03E8C65
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965105; cv=none; b=vFRobOdUN3F3bUpqLJ0RHBc3g45PdccxRHe8IC/YvFsrUvXjM7omXh+V0gSY6jfX3qR5MO+YT78/NxtJ4E4jXE/TugGZ+2r3aaDeWITSBXTI8LuPzmPjkQebDGycholapb1ySKHTqfQcqwYQgsEbn9PsBT7QjXp3D+0755qbmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965105; c=relaxed/simple;
	bh=G2Gb8ryU9CB/tkIoI6Nf0ZbyezD1MDOliNvGtQxweb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvipXTJNYwvbHTywf5I9D2RtcgpO2+u8sYCRLocFvN8yXKyL+iRTVENb9HnqDTyGWiaXZeF7PUTRlpnCr5CZT/qzJtcAu0+J5SIGbXng3FRcQNLJOU7a2a7v/qdj5ohQsQJUkEfybd8qt5OClGF6ebwcjJhlM2rN183Sdz7PahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSn3muos; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSn3muos"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486c3411c8so1846004b3a.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785965092; x=1786569892; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40ts9A4u96ZUBLDRq3LwUF/0mcwzqzGt7HKamq8DGIs=;
        b=XSn3muosSmxaYnU/p4J+DHvncxprTsDDCmpzmHDXSGZJrv3t9gb6bktHbdAHHnSiSP
         vUOI9/QXXHlLzTIsXiPqM5/gO5fxuS9Oqxexpwewts+3PtcmdbvYFVL+xHicpRCbRDHG
         vfIto1aGbDaNcjPnsMBq94vz7AhTftb+oLYr4Y/v/TQuIRgObFwsS3PPlifI7bIaMdNK
         7wI3kh5OJaLC/cl2IHgyQdooBld2xzA0X/PO1Cju0WLUTTW/LblEZR11s6xV6yGbsSfy
         V8Rp7djdbDlFyQlqhRAc/nuZJ/P6r9ud0KxF/m6cJJg8bPDIeLDBY0Bffp1lz4iV2KYT
         XDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965092; x=1786569892;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40ts9A4u96ZUBLDRq3LwUF/0mcwzqzGt7HKamq8DGIs=;
        b=QA2iZ+AkSaKMwXRrpbI2Qm52JagTl27MHdXGGzpZcnfFiY5ekqBrXXixWoMEP8+6Do
         vQe+GxdsLft3D6ZLuUPu1RnkHX006PN/USkIuupgFVgXDfa/P6/E/ebmzudsfk3zFSlf
         h9bRQzr38H7vRDU6+CFWoocfePNWEyq3dV2b3QSZEqv37TiEV1b8Lam0APO2Pfg6jmmj
         FRiSFapDrhLnTyV1k/xde1qEG4veOveegd8A7trmrVs6e5HBVYdGMOdnmCoGWdaNTHFF
         u3IHFXHVCyF4hsMXJ01RtKiLS6bilblA2k41Cs6cbEkUmBhBHAkBPi28ddyO9pOWO7Dm
         ahfA==
X-Gm-Message-State: AOJu0YwKfg1VCn/FNL4NPSOXCwF9CDI/6kkcM0R490GGlWtbYdxnjZZu
	dpU1LmMnfqNOJN1cHHsG307fyPE+FkfU+ujs3ng+Hx3Xmr0TkG8o6PUHi0pEPr7EOapcB0m4o01
	ELHW5opSVd+nZM5cGlM+8kGSzk3/O7BVIjonnvYhuCJuw+XvSbbxIV+Q558y2zLgypiLB2ep0kS
	d1+07y1MEQa3HNmjymZOgaX5cEt8M/64Y=
X-Received: from pgbeu25.prod.google.com ([2002:a05:6a02:4799:b0:cb3:9a4d:501])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:414a:b0:84e:2f2e:8c4b
 with SMTP id d2e1a72fcca58-84f2e0ccecfmr10983412b3a.32.1785965092256; Wed, 05
 Aug 2026 14:24:52 -0700 (PDT)
Date: Wed,  5 Aug 2026 21:24:35 +0000
In-Reply-To: <20260805212435.48618-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805212435.48618-1-tkjos@google.com>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805212435.48618-2-tkjos@google.com>
Subject: [PATCH v2 2/2 5.10.y] Bluetooth: SCO: Fix use-after-free in
 sco_recv_frame() due to missing sock_hold
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Sasha Levin <sashal@kernel.org>, 
	Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 598dbba9919c5e36c54fe1709b557d64120cb94b ]

sco_recv_frame() reads conn->sk under sco_conn_lock() but immediately
releases the lock without holding a reference to the socket. A concurrent
close() can free the socket between the lock release and the subsequent
sk->sk_state access, resulting in a use-after-free.

Other functions in the same file (sco_sock_timeout(), sco_conn_del())
correctly use sco_sock_hold() to safely hold a reference under the lock.

Fix by using sco_sock_hold() to take a reference before releasing the
lock, and adding sock_put() on all exit paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 net/bluetooth/sco.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 2fbd9c93440ce4936d47b3bd47aa1dc28da82c20..b49b2d6bb778e8956d4a297c9feecadd1557a3b9 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -312,7 +312,7 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -321,11 +321,15 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
-		goto drop;
+		goto drop_put;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sock_queue_rcv_skb(sk, skb)) {
+		sock_put(sk);
 		return;
+	}
 
+drop_put:
+	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }
-- 
2.55.0.629.g250fe7f194-goog

