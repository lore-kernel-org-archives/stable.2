Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265147B43B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983690; cv=none; b=oCQdZsxtRljbjcuVSRf1S6GCxe9o0Ig+ZaTI3CEEmPtWvc8pxc9bbLX0Pqp/pDJpNFTZuancgNWb2fKBIAvKKryrIJR1OX0sosD+4Ioki/FaBVz+aBOzxO/ACBDbQuM4GJQbFbSwQkyF/kxjBPdgixVucJv8VB5TIajb94sDQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983690; c=relaxed/simple;
	bh=8Y0ieGjoOk3NQHffHGSqBG9S2VJY42ojCB0DdZyh6pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2rCd+AdFzSF0RXj3uwBwCSC2xgOup/kkD4d04bjUdKVlOzGzy0Qd4Atz3F7DBT3Isz0Qn348ZM4u/s4z40nC0ui0l/JIHa0d/p1LEP44b0+1xfhcIlWAxmo2aqiy+m84/OhGIvn8FCPCT+/Rs5SqoqfWnT9t02JFDbqP+12HNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o93yqgJU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o93yqgJU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2db710396ffso28203375ad.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789983688; x=1790588488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMfX4UXESdeW6G6btInEL8/FoE+QOLcJTNuBkG5ZRtA=;
        b=o93yqgJU1VqUIRO1RE+u+GR4PN7WT+am3IdZmEq6fSt3bCaDtLJtKOfIeqCXJ8lvin
         7zNpZGmoI8qxQrcbofyTh7HAep9cKCkklqEOxVaUAbatwp0k5sL9D+mnknWN9Wr7x6/I
         KLS89ltnK0Kpv/nVC5KWRbSjJFpWnpzPDL2SX+n1Wjg9mAURffcyUKcrjyTCwirt6/c3
         pEJ7FJQ8PaxafJmvN6tNSMUhzDEafkWQOtRJZ6/gImsx/17bSoe1dXlNOpnIoGFz/4hb
         Vx5isnWn2sJVfkKjmUxeIelNTK6zfUAJKJuUkyT3v1HN+SMb6nZfLmoq6mtVFOhFDRXS
         AsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983688; x=1790588488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EMfX4UXESdeW6G6btInEL8/FoE+QOLcJTNuBkG5ZRtA=;
        b=tPbOrvlUS9zmIssNofAaji+t5ePQr2jLmXhqtl6/cnEI8VywJh9AV8XthEHS+WPoBs
         DFh6lX4JJJZRfHwt9fWBEDGgWXcPwNUzYlis3PapA+6gswfA+EuVfR9WuA0kdyRTkFqo
         pIZaHehKNCHZj9mqE/GP7c8Q7RwWg/FlGO9TNBHhjEieqjq7FVsDSuohS42Pk2GHJpO9
         XPzBR4ZX/nq5+nm4FisziPXq1SFKWxGOVpuSnd4QNFBXrsrDDkzY+ocwcs3LaOJoID3e
         dI9NOqE6woQet3ECn38SISo7rsbyUk20wjuaOuaFdd+fYk3Y4wgwrOAmD/I+EeTU8lk0
         gw0w==
X-Forwarded-Encrypted: i=1; AKwUvBx815vYX4HlsUXFAFpPHhYkzs4EqhcdsvRWANIrznA4x/qA4JL8lyRD8DFIZu4BKFhHdbsCuWk=@vger.kernel.org
X-Gm-Message-State: AFuF++mOoZSrd0oeKVxpQiYPrgpZgABAa3vhNFAm21TeH2GaNA6Dro6A
	YHXo77WC+BwypKZAPq5TfAQLI9siuWRqn4fIUE5DWPtLxD7KPe3n2cRY
X-Gm-Gg: AYBFou2RsttAfSx80fSc/2Wzv3vCIP98o8HnlzWrwWuwS/p3XOdSXlF5NhuAFePkDYt
	9BXwRFBA/HgQ7751ZKkO2OIsftwDGP7rmWSimo1ICLjXbuQpx7XPxHfnlAFPCInN3fTNydAWYff
	CvspM2ewpVJ054V+Q00l1jg2o1zoB5LDToERNuG7JUcbUmrn1pDcTTLdDsGcC7cVQQbfDC1flh1
	LOMk++ZpUC9ye7dhCQHxyj5V4y5kEVcnKdD6Wh+SeKMKWg4QID2fmfVOLbj2DgjA+MhadGvROY2
	gG138b8LjcCnxGmjbF4QLvO8NptWg7Vbi508E8z4JBrQorwAgREYwtPo16JGzB3hsCvNwETnawm
	2wevbXxfXTImYKWJgIXpWIMs88WJWi+A0rbKfGGBJFD/FnEQXIEEbXkP/LqtMl4vhYdyBwCHxMc
	1Bnu5DXM4IvqtFV/x/YOvnHd4cigltP4SlmwdrL6s8JdLOtxgHOqE3oW05U9DC+sWLD7jN5Rx4T
	6q6+UBguZlbj8vJZMqHKKhnJsbhMi45Wsp/Pb4JsNzrDZq1wTMy91c5BO5s61Mzy89UqkR/9y8A
	tXKZ
X-Received: by 2002:a17:902:cecc:b0:2d8:d4d2:d139 with SMTP id d9443c01a7336-2dd9ca3f088mr175298675ad.21.1789983688071;
        Mon, 21 Sep 2026 02:41:28 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n112120123178.netvigator.com. [112.120.123.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17a04afsm31053665ad.42.2026.09.21.02.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:41:27 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net v2 1/2] tipc: stop the listener before draining connections
Date: Mon, 21 Sep 2026 17:41:14 +0800
Message-ID: <d16573ddc2464277a04274fc12630daf00b8f149.1789960909.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789960909.git.xuyuqiabc@gmail.com>
References: <cover.1789960909.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_topsrv_stop() destroyed the receive workqueue while the listener
socket still had its data-ready callback and sk_user_data installed.
An incoming connection request could then queue srv->awork on the freed
workqueue from tipc_topsrv_listener_data_ready().

Reject new accepts, clear sk_user_data under sk_callback_lock and cancel
pending accept work before the workqueues are torn down.

Fixes: 0ef897be12b8 ("tipc: separate topology server listener socket from subcsriber sockets")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
Changes in v2:
 - Rebased onto the current net/main tip; patch content unchanged.

 net/tipc/topsrv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index af530c9ed840..908622a3d0fc 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -700,6 +700,15 @@ static void tipc_topsrv_stop(struct net *net)
 	struct tipc_conn *con;
 	int id;
 
+	spin_lock_bh(&srv->idr_lock);
+	srv->listener = NULL;
+	spin_unlock_bh(&srv->idr_lock);
+
+	write_lock_bh(&lsock->sk->sk_callback_lock);
+	lsock->sk->sk_user_data = NULL;
+	write_unlock_bh(&lsock->sk->sk_callback_lock);
+	cancel_work_sync(&srv->awork);
+
 	spin_lock_bh(&srv->idr_lock);
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
@@ -713,7 +722,6 @@ static void tipc_topsrv_stop(struct net *net)
 	}
 	__module_get(lsock->ops->owner);
 	__module_get(lsock->sk->sk_prot_creator->owner);
-	srv->listener = NULL;
 	spin_unlock_bh(&srv->idr_lock);
 
 	tipc_topsrv_work_stop(srv);
-- 
2.55.0

