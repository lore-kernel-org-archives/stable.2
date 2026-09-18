Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5433ACF18
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723296; cv=none; b=R5f95CDZGGSBtTEUUefbWul1bKwI/CZAwmjwCgIKrp3zva7EHNHW+KvdSl1m23LPSH1JClrph7fkbCBeuy9y9drT3Ed/trHShVL8+YHowbWV9ZuIey32iw2eQVp6sP4/4FWHAObiQLUwZ3jday8tov0mhws41hoaUawcMRSk//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723296; c=relaxed/simple;
	bh=LgQwq0lqcthkLYGKPObYEllQc/Znk/K8NYI2hj7hZzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrxHBXo5HSKmJrClRv4kbELbNP/5XCt6gdf9f8u6pC7xrNu0NualoltNplD5hGul+LnyQQLs+6iNyqcv56ybIvMc1L23d14Zd+1zTcbYKb/74p1Xg7tJojYWoIKrQsW8oTf0saQgFsCDqsLFuoDEb3a1rNF9tBfyp/wYvu/cYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFF2hfp3; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFF2hfp3"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d90ba1d807so5905305ad.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789723294; x=1790328094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5470ZJyWN3bHAzgTPv/D/YMrDeBQ3kUcDTovrPyBs0I=;
        b=HFF2hfp3n9RYwkiKPnbempJf+cb1WnGUFIyB2ZPgqwmAwpm8IzVAURAw/Wzm1+tN+2
         o6pkViOkHn+j520oFF6gZOPf3wXm6/5FEifUL1AlxEVPFzEb5kQ6+8FQ60hn4TB3N62N
         f1BHzPqanP/p3/mQJKX+NCoiFNd8ZPvLy9w7fpSOqn9cCi04nT/2IMGJ935G0TDs0F9r
         cqRs8S0O1Dgu+P3TWBII/Hu/uad3uKwcx3Ua1+L82cLaMW7Cdg5WGLE/2Q6PmXdskz2N
         r1n/XVcXJPSoTx2LHq8LIm0DoWjv3BW3sM5ZnDfSWrIcTRu1WD77Ae4J9qDIie2h9+GA
         T1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789723294; x=1790328094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5470ZJyWN3bHAzgTPv/D/YMrDeBQ3kUcDTovrPyBs0I=;
        b=KGj7fU3u+xlM85mfxtF5tOJtcmPqi6P6xfxHpjT5KUuQyZNHUYphhfVgVGbH3xhFug
         0/Fb1wEeYUMi+foxxN2i6YDqFftYd7uabjRxiEzaaQqWJJ10NPVRfbEyUTrRTIr3YOQw
         iff1Oh8ZGMozoK8zKOuWAN9IP0dgb5Wda4rqpsIyXl9fIOx8cLleHv4ft4qs8V7OvQrD
         pdYD6OLnK0mRN2quB3DnXRfK3H5BhPhAxL38GtGkFhcbGKEeDQNKartt1Day7elu3ey3
         UDYeUz5VTci0gFS16y1LP3gSDy/EmUsWmW2tHY64UT0H6sUJ8s7Afr19UIdKVbn1bpg3
         /vIg==
X-Forwarded-Encrypted: i=1; AKwUvBz9oKz2oMOVQfBrSnM6kWS0cd4zyTsE/rl5JMhihoaTAkPzX7UWy+CahQW4KOt/toPGTijyVNw=@vger.kernel.org
X-Gm-Message-State: AFuF++lY9OLqk+7msvy+485IHkFscxMZpnCOXe/0Mv8xJ5Wyv0E01wmY
	0xVme7FC9SL8SoYCDhNtM2KJGHPNaPwo3rv6q86lBIq7msPAafqJQww6
X-Gm-Gg: AYBFou2vlBnNvRdBXIPVPHHMpIGfEau+oA4yk5pjTMJpN25RCDVEIMMIHQDHeXWlCkU
	UjUacMfXrprw83uedEo6fCxajvvXnWoKC0F1bVM25Wn0P5DJDoAdHYfdLzPBfuQhVEvf4vAN9Gd
	FqUym+K/bl+jxMxz8BFfbaItWaYd3pV0aJSz0ZJQqQ52AgTqhikGIkeF0B2pDskoUxHTerit6Jr
	qxh+naZ1L2ra4Q9yWAQh2haR/SUJYtGwUWd1iY5yj1Kt4J4Ep+uXAg8et+ubmkDxDn+i8CNyW4Q
	P6WzqEU9LPIwj12lx0ol7WCGkqgMjXRWJaIALhNqC4ug1nbYkIVIaEMAwmv+S2OnrmI7QoxmtSz
	JdpL+E+R+e9R6ZvrP4dNeqx8GHa/bbsfTrykOC7VQ+2eu1PwIrqPUZWOBIq4kjTtgeHlEiHU2gE
	MdOTUozCDAi+q+WE0t97ylEKIVnK5Ya93/ZFQ5GGvzXV8s1Tpeuj91DVca2WK9GPyKBYeF5sOJg
	lgEuWBexi975G67KQ5PPO2LEIDBLKAIHZz2ijUyeQ5VGgU3NKsq4rr14f03oHPo8eiaB6OKjXAy
X-Received: by 2002:a17:90b:5623:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-39e54d160b7mr4950618a91.12.1789723294171;
        Fri, 18 Sep 2026 02:21:34 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n11212025079.netvigator.com. [112.120.25.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6137e111sm677341a91.1.2026.09.18.02.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:21:33 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
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
	Ren Wei <enjou1224z@gmail.com>
Subject: [PATCH net 1/2] tipc: stop the listener before draining connections
Date: Fri, 18 Sep 2026 17:21:12 +0800
Message-ID: <48f16f41da6ece5aa646c28617031d00a126411d.1789722780.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789722780.git.xuyuqiabc@gmail.com>
References: <cover.1789722780.git.xuyuqiabc@gmail.com>
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
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
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

