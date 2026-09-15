Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541F44238F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455723; cv=none; b=Ty51mvbIJhTSh28Xi8Zi45VPg4ulHvXbsGeP2T/gtZ9n2yvI8KlL82z2cx8Kr6fiFKqQandzaHseU1TqiUBRkwo5UPYWX3Oo+jpk90735Ns2HOFuDW3dwn/h0Sh6mrqwffrp4PPk8ygBV4axbLLe6GP4yAd2MCmrB/+sJxjz5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455723; c=relaxed/simple;
	bh=PnZPTWSMbJFLqmzZylh0ufIhiLD7YCit/Z6WxmZ2+3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pV4wXH0Tj8DOkKb6GS22fFaNwmqcNetx+ZV0uf/2BMusMekNUs81PcD6xY4pmOGPclHFTtC+sJa6/ziyIqdJ7YJB+17Avb0ytV/eufW30G+sBKbS/eXfE0krIfmgBRlNnV6wYOQt8q+z1QOXufJUSWqi2WUhdo3y7804ZR51xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftHLJydL; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftHLJydL"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b899413537so4657340e87.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789455720; x=1790060520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjuyMICCrYkUM++5c14PtDJ8fduutsgs593zdKpvwvY=;
        b=ftHLJydLHKbqIoMI8ODGmcr4U4Y7tBey25YH0zCDeKAINYSlqqSegzs8/cX1pFtCGB
         dNwcZJ8cMXUaUwDIm3hzR/qd9EAxonFgqiXgcCp7cFOGznlkQQCD7HOKszIFuiD2bZ/K
         KpVq/XlZXU3mI1XfCwYM820vydEOZ0D0RhB5L1crZhG2ZQ6rgqqqYfjQV4DXPofIFK5N
         PheSyuR5faFna6FySJn9opEKNmnIW8TCSU5NuxBB+uEZcGYAsV7t6Mm2DrBTKB5gRHHa
         Kj2NgwMbHZZnGUbsgZJU3pUm/2PjM95AKZB0wLyX7xRqJPnyVtx4bJryuQCO7c+KJd3m
         +RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789455720; x=1790060520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjuyMICCrYkUM++5c14PtDJ8fduutsgs593zdKpvwvY=;
        b=Nyfvok/7Mf0hUrTJlxXumygPGvbEQoP53rRBO4h9UWDSFN812BNn93Ytpw+45gAHfB
         JciwtwA9roN3pMBpExKatfu0adYk17o47LWyJ3ttm3nmH2n77Q67G858Ub0qfMGGV4K9
         +4zXOxt+ff1oxLXTgpjC6qrcxk4nqLNtEyoqgcKQYZ0O0LzxMadWzGTD4+N+/ZGHwbdm
         iO6SKLn0gQzBFxtnSobxMLgJt+pQlnDvS7CoWjiW3GtgK7kEJ7McYqpWQlhbiKgiAztu
         sO47tushdOOWx6V6+ez2P6zoZhyrmelET+a53Wt2dE/Senh/fECKaVcLCgYrrNMR2cAp
         3T8g==
X-Forwarded-Encrypted: i=1; AKwUvByqKva1yEzj6y+8/93dRlZN4+MHCcNw+u8lEKeaE/ZvMBcVLIbdVg+cgLO5VmMrl880/nHHdU8=@vger.kernel.org
X-Gm-Message-State: AFuF++maCFNxteqxeqG6bXs8blqyvniQORkQtoDsOD6NAE2ybFxAwLiB
	CXDRTo2IkK4kjL/q4br9x+l0Hf0JHuelsh47tNnBBcPNjqmxDRQkKaEr
X-Gm-Gg: AYBFou2X9v0riou/xH9ZxW6znPQd1oMfzTEnVTne78cJLg5VxLe2qXUu2j4rSVrybHE
	OfkiTRotli4NyoFjtOA1+DX2iGpU8AnhB9+i+JySWn7ksy6WzuJJNoRcdJmSuYaTOsklgClogAV
	GA+EijVTxKH9ghGl2uPpUaXsDNpjw4EEktI6xxUD3wne4oBOsZJt7bBxFJNN899D3DKORuW2VzZ
	E6/9PawD79wmjxN1LpzAN93UG6mUbS/EcZj/9MLfj/Lu5e9dxuY1KH1pCDRFyrge1GJdCv2fHDK
	9ELv4l1IcN3TQ9rbYK0SydC0Jl5Gy0WP2Z1lTPJhtbv+pAPrF4Ngg8/YA0Pbup2EdR7IOjIbiUu
	jc3lzYnV4JuRcWy8UmEiGLlFh5hbR1KQrnsSmY8Cjp8SJAaIaWN8f4WbvLGRXTx84Xk0eY1K8ph
	tn2j1voys7mGGd2oUei4MbLw6Ict23DBG8ERtt1JJMlEHl7ZhPESn/qH5aGluLDhxGtCwbKvfAv
	t0PWH0Ku6pMZmk=
X-Received: by 2002:a05:6512:32c6:b0:5b6:183b:d218 with SMTP id 2adb3069b0e04-5b8ae6a7786mr1558561e87.63.1789455719335;
        Tue, 15 Sep 2026 00:01:59 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a03a88a5sm3002566e87.8.2026.09.15.00.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:01:58 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mikhail.v.gavrilov@gmail.com,
	Maxim Skokov <skokovmaksimevg@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: RFCOMM: free the skb when the DLC has no owner
Date: Tue, 15 Sep 2026 10:00:46 +0300
Message-ID: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_data() hands the skb to d->data_ready() and returns 0
without freeing it, so the callback owns the skb from that point on.
The tty implementation frees it when the DLC has been detached from its
device:

  static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc,
                                    struct sk_buff *skb)
  {
          struct rfcomm_dev *dev = dlc->owner;

          if (!dev) {
                  kfree_skb(skb);
                  return;
          }

The socket implementation returns without freeing it, and the skb is
leaked.

A connected DLC can have no owner: rfcomm_sock_destruct() clears
d->owner, while the DLC itself stays on the session until it is closed.
Data frames that arrive in that window still find d->state ==
BT_CONNECTED in rfcomm_recv_data() and are handed to the callback, one
leaked skb each.

The leak does not stop on its own either.  The remote runs out of
credits only once RFCOMM_RX_THROTTLED is set, and for a socket the only
place that sets it is rfcomm_sk_data_ready() itself, below the return.
rfcomm_process_dlcs() keeps granting credits, so the remote keeps
sending and the leak keeps growing.

Free the skb, as the tty side does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/linux-bluetooth/CABXGCsPe5wykd8Aj-hm+SJ7SGQyb8yoGNnx3XDpPmBathj+EGg@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
Assisted-by: Claude:claude-opus-5
---

Notes:
    Noticed in the v3 thread of "Bluetooth: RFCOMM: connect the session
    socket without rfcomm_mutex", where the same leak is described.

    Found by inspection.  I did not manage to produce an orphaned connected
    DLC on hardware: it needs the socket to be destroyed while the remote is
    still sending on the DLC.  A kprobe on rfcomm_sk_data_ready() over an
    HFP session (RTL8851BE, btusb) counted 31 frames delivered to a live
    socket and one rfcomm_sock_destruct(), so the window does open in normal
    use; no frame happened to arrive inside it.

    Built and loaded on 7.3.0-rc1 with KASAN, UBSAN, PROVE_LOCKING and
    DEBUG_OBJECTS; HFP and A2DP sessions behave as before, and none of the
    sanitizers reported anything on the RFCOMM paths.

    v2: no code change.  Removed the trailing whitespace on the blank lines of
    this section, which git format-patch --notes adds and gitlint rejected.

    v1: https://lore.kernel.org/linux-bluetooth/20260914173044.5249-1-skokovmaksimevg@gmail.com/

 net/bluetooth/rfcomm/sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 958081adb9..82aa38715c 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -48,8 +48,11 @@ static void rfcomm_sock_kill(struct sock *sk);
 static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 {
 	struct sock *sk = d->owner;
-	if (!sk)
+
+	if (!sk) {
+		kfree_skb(skb);
 		return;
+	}
 
 	atomic_add(skb->len, &sk->sk_rmem_alloc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
-- 
2.47.3

