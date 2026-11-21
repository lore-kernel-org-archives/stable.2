Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296706;
	b=RV9W+SM3NLrF6U3ID1sK7I+Evz9XX4BTTagTDCJkL+C9BPWehYtCQ/PTzDYP047p6QTf
	 OEgypMCMe9T0a2voLCWY0eRkdLvDSMgdDQXcM1/0z6+2W+Bc2FIcgJ0ZpIql/+UEMi6Se
	 NUdT5Sc8mb1MN7ALzSm6qbR25Kff5D8g3DGJXuxa1g8Qjhf1+56NDiWccoV8zJKsUkIvk
	 287zxyvZlu8Zira/uyTvnFYMchm3e6xbPERU9aq7afE0HfzLymtf8R2WR5A2wijZk87VL
	 xVLLrHcHw9HF1Vb6uhFtRXZIs37GX3RvsFFI2BdG0uVrcBg7a85JHp/FLxtTr4gmBkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fgYK0WdNPyZ2No6tbroW9YiDvuBSMrnuztXxUFY5BLk=;
	b=hI8RzC5AH3yRDcQuCezxgm353yzVdgVloQnqyEeXrRcf4VqyBZtgMHXsWH1EkFzOyN3Z
	 PVbXNiahc439RxecS30MYv6+WDULPK4A9uxK253e5IcohbNRQm7Vhm45cb03uT16a5lks
	 4JDs4rGDfJnzh/961YNWfnZB0ZDXJHkEfR9hlBWAqu/TvDs/dw/zZN0UhWU2AAjN1AWY+
	 ypT1/OSurnozRF51Krk5Y4sLuLYNWqk29kY9SoP52bpzbp+brE92szk3ExN1gZE5Xqqyo
	 REU0BJ6AXSErC/ldZlubqmE5JHLGy5MJyI9f+fRyVfXcwTo1iaNbJEBXzy0zGFrtnNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=JAT4XZEW;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73110606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73110606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=JAT4XZEW
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6de2f213b7aso909404eaf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296705; x=1795901505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fgYK0WdNPyZ2No6tbroW9YiDvuBSMrnuztXxUFY5BLk=;
        b=JAT4XZEW0aE9dO4wwyj67eId+YBEhzTWX6cuKzfJf41nD/JQCngWZrZfjaXBk+DJaG
         p5GRH3wr1lf27P17a8aOg6k/JbUCH9LoQhXcwtX7P6O5rzVeGnejOljCudcn0AMfdIqa
         FjcNO0Z4A0HXGVarDJY8mo4ZvQueieQAkBuXayAelL14/T04YXjdhiOJFPbN1b7R8dZ2
         0txewZtOogeqR/wW4oIEmT5jUHTeLkPEY+EgGiHZeIdH08MlV0siBqEGsgyBD48VuNX5
         0jR26dPLFTrp7wKAvs8o80q95CN5mCW6AndbZ/0OXPgPjzuTC2n3KyD1vWfYe8ITcveS
         uK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296705; x=1795901505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fgYK0WdNPyZ2No6tbroW9YiDvuBSMrnuztXxUFY5BLk=;
        b=Hnl0lYomlwNrtaxTuupMFqZjYSHZOHuZdso2JIsgvjiCwXaiWQECP/Zs8q8d9z+jbC
         YFgpMiJan7G/GVcJpAyU0oZ4AtZfsE2NAhIrqhbUIYxV+obdwNll27b8mc50iyX/AYyE
         //cXAnqpmkeRAhtT8Pbwm4hlFCKTEeikycQ7n3dzZZeT7oVBMdeVUTCfsDPMuVoSowFv
         eGnztcwlc3SGkMB3UZYUBhqXZra0YJps5/nbvg2Fkmbqsx7aekOXLtZm4Cq9Lo0MvGMl
         spV0N64pjiV25T1KaybBZSAM6BsBWiIVBFwprbHilLlBdTo9m3WAncu4tE6MPHNO1pRW
         T38w==
X-Gm-Message-State: APuU4Z8O1bhsvA9y0hlBy/GSrVOrfPgODUIxvdteyFIxFVEwiXPW5gyB
	+X5mcHSIuM2CF+h0vv9PSDMCLnu7Z0yjLWkisAROFkv+lku87VHjbCx2mfJCZgVRxQOJ3qYCZ4x
	W7YjYMEo=
X-Gm-Gg: AZFdTZfmWzlVbgWzxCeN83OHm9TZPdK3pXxrEapGStX9uPcCirxWrDK3J9tILSh2baN
	8veoiE4UxXx00w6NmOqrDXUpT4S4Pq9E4PDdM5vSUq0O1EPSoLbFg5yritcaRftVGGolOwEBF4J
	HJ3qpbBjT/ZAdG1SpbVifw5UEffIJW+HH2NqbHe7zz3Q7riq9Lr2pWXKM2vhC15rzUnNwKq4NWw
	GN90g5g+LFS2COboh4SctE8fITP0kC9/R+32cdzQHD+AZCitiO2klJmMNj4/RSqKfU+N4KgLdCk
	8sNR9qghcGkFrcqYQs2XfVVHktbK1py+EGRGyeeJqAYnWvggFTl2oPrkGo+jgJXTQAf0SIBDPI2
	VZGb0lDrsflpnMExieh9xtXoHo/RJ6+GsgUAJnCkTAAnakE9DXQcChOJz3JSAapn/S66KRl8O6K
	2WNAToI2e1DKKBkZqyquwLIgQ7zyn3UMDnftoZopYLPIfLzoN6j3V+3at77IL4kfDigOgNKnr+t
	8kkTmOINijOJgUWWgXRQ+53d/prs8mtH6NkrVYQMXJZh6S10vPMUMHlP24PUbSrs7IHV7ZKi1C8
	7tcNuZUuXCyzwUtTDrWTwkZ4a0F1yP82RypI6nkbeMrrII46spfvs2Ud/LRFi5iFxcUr9xntnWJ
	5WsfmZtiUiGtvOaz3XLaSVHNOejun5pzpASXz
X-Received: by 2002:a05:6820:1387:b0:71b:1d8c:af83 with SMTP id 006d021491bc7-71b39038c51mr5660581eaf.0.1795296705452;
        Sat, 21 Nov 2026 13:31:45 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.44
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 4/8] io_uring/rw: fail soft links on IOPOLL short or error IO
Date: Sat, 21 Nov 2026 21:31:33 +0000
Message-ID: <20261121213137.1789687-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213137.1789687-1-axboe@kernel.dk>
References: <20261121213137.1789687-1-axboe@kernel.dk>
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

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

Commit 4d3db66c5363dcf42c3d43ebaea330ac2d1888bb upstream.

io_complete_rw_iopoll() updates cqe.res when the transfer does not
match the requested length, but it does not call req_set_fail().
Soft linked requests then still run after a short or failed IOPOLL
read or write.

Fixes: b66ceaf324b3 ("io_uring: move iopoll reissue into regular IO path")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114072246.741950-3-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/rw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index f46d08bbe9d8..48ef87b4697b 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -618,8 +618,10 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 
 	if (res == -EAGAIN && io_rw_should_reissue(req))
 		req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
-	else if (unlikely(final_res != req->cqe.res))
+	else if (unlikely(final_res != req->cqe.res)) {
+		req_set_fail(req);
 		req->cqe.res = final_res;
+	}
 
 	/* order with io_iopoll_complete() checking ->iopoll_completed */
 	smp_store_release(&req->iopoll_completed, 1);
-- 
2.55.0

