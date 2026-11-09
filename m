Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221585;
	b=vvi3pSKMA9cB8Vlw9jCDEKoRf0AFUFWMyugkjdTeRVpdTa92XdDAMpiitwbG00dnd79b
	 SdniUDMb2gt7M6JUmNDQoG0HXaBrEZottfR8lmQ6vZNNrndR3vrm8eMJVUI0sY6Sm3vG/
	 6u8ZW9qvS3Ao+deGh3fg71pU1kzCCq3oxNdxFSoa7Ud+NvkLPDN+HJ/0Up4jKWkbxReH+
	 GZ843dkLqFN3YYpzfYLb7CJ61E9Ozb798fG/U9vGctNicLDwTSD/+dzKAKRfL0z1p79XX
	 EvNbfUe75Z6UnJ3h5pJiI0NOgQVDg/zKbrW4aVlVtPlvsdkDOLimZelbFwnaMVztmbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
	b=3EQAugmDV0Hh3ymQYXz1wqsvd9H765ZJ9ZyUAWXQFHtfG25+v99qK4uTrEUfDgJHaYZm
	 7tN5PfmdkkmOKqp04GeUbFVHtjxieGmTUW/ff/pKsBpwjybd1ozeJe0X7kPlTOHndj024
	 rel8Bp7V/OpgUVap2jj9BJCMVbYOvOrSD32BsicXwPSEpmtmscsnUEAojKJRMqPZkF+z7
	 Y5XtWBJ8jn6Dxji5gIc1saPMFB9NsFD+NM/8MtP6HLAPI2FB6rbRLJE/eeSCcT5y+AAZl
	 ibf7rP8CvTJpP4SL7QNnq2hamLZB/gXTVP4dRtn7mOtNRM7TC0Xj9OxnvuvKMUn/Gaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=iuwFimSr;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC63606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC63606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=iuwFimSr
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b2513decc3so795591c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221583; x=1794826383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
        b=iuwFimSrqv9XlDbzpW1iOYqtZawE7Uk8u6Mmd5lCyb4oscwXFUkWIxbvE8TtA+B/9S
         ZL/mgAeaqdw29LV4vO7pODn1BiuVvrQYpM5sTA8f6DbqEXfoEPeko4goDe/x4ErWC+zg
         +mODSEvFq5ljQbezobel1yT8x9XnU9x+FhdIYHgKNmWpmC7F8BECM6OYnhPOsQ0fyeVt
         YBJ4g1M23Apn+MSghcLnFUBB94s470TgEjMgU1+1iA1sU3XnwxLiIm1wyvD8SRaXtyZS
         76WQ/wBqIlMIyzzqrowOvVe0TL6FFxqOQ3bRWcwgVgz0HYZ+5GzUwjs8CYqUjWpOrh8+
         uHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221583; x=1794826383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
        b=EZ7lYkQFSGK9/M+Tf83TcH3CQW1QwBDnc6FInia9E/+ig31dEYGZKVQfRG6nl1uM5G
         UBsN6V9v+JilM414UlN3onDQguPp/kvQVIcYBvyWaqRB7xdPtgSl3A4YGgjXWs5sAr5o
         NKmiZIfVHdYiRKELjYrBybVYsS9p5VaXstllm5WO3I+ph6H/u3Xy6u0beYg68vCFkpuA
         +/XRfNu4MyyAH7GwAkXuJojK33MaxmuLiAfy2jJvD50gR6gaOGucjvyca80SvrXyVo4c
         UHyERdMYlrLu1omgVmSPeZBxYFrm5wgBzQ/VzgZIQuN0ia+xhHiQOmFQM156R+r3Bi/H
         guNg==
X-Forwarded-Encrypted: i=1; AL+hErGjvW4OjwQadRuyOJnQ+nMmoiS2B0rGozlZIt+sNMClstHejWa1SzG3gdw0FUV635T9zRcXdN0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wLgkC7D6veFLGwvuJWbzHUnMQQBrYu1ysqkXbP/TUyTewE7/V
	tdrgvu/BYnUFE+vcJFChg4nYPqRT9lipLUZUtlVgx1S5cRpWrY9Ws7bGE6WDr+O9SA==
X-Gm-Gg: AYBFou3CPBxY/f/SxjKnD6F+SdE9i/27IhJh85sc6ydOuvR9pgl+oinAjwxrVtT4lVs
	A8nTqe4xgBpo9be650W0nlFUWRu7cbY/fon9VWRnqDSiLd7yKY49+jRY77AjSOVYkqWXaXpJEx6
	WLD13QmZVSd/3mqu3NUMcBWBEN4FD64K7WBlt3ymPRz/WIaOo+9opU5dFI9D5OV8GOOabMgyoSZ
	hNZWvQqUYcKGpZCUL0tRXu3JxLyTXLIlJ4ZPSA1H20V2vZvf43/3ZkrvJSjg9CmWxCXp4JQQm3k
	GvL0G2StpisJLXmV7KvDrAvAkYjVVesbyRLK0L18nAKFbk/wdOgMbjJefhm7Ug56GU9llzMSif7
	B2MZyGyCjW3vOlBssXpCXMd5K7x4N/GEWPMCCYIZjdg1u8bcS6xphTx61FX83jubODPWTNZiywm
	7OH0S/lvf19xPi8jAFR6Gy4DKfy3dGqHvIuhxvFmUCqt5bwh5ObGRlInkln3N+A973vK9DHzAgN
	jIzauvDfSf1oUEY4X/C1UJJ/V0ZMek0iWeL30vBpxQfHLK2eG0FJwN5t+9LfJfcwFdpwVG6cp56
	VcIzIzfh/dv98LT7V/1kqzw6gAbzfmxv6NHuy6JgMQvkN5o/rV2W/OISloo5
X-Received: by 2002:a05:701b:2214:b0:16d:1e24:5cc3 with SMTP id a92af1059eb24-1b39feda859mr6171128c88.19.1794221582983;
        Mon, 09 Nov 2026 02:53:02 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:02 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] 9p: ignore a zero-copy reply that arrives after a fatal signal
Date: Mon,  9 Nov 2026 19:52:48 +0900
Message-ID: <20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
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

When a fatal signal ends the wait of p9_virtio_zc_request() for a
zero-copy TREAD or TREADDIR, the device can still answer the request
before the RFLUSH, and p9_client_zc_rpc() parses that reply.
p9_virtio_zc_request() has returned by then, so it neither bounds the
reply size nor moves the error string of an RERROR from the reply pages
into rc.sdata, and p9_check_errors() skips its size check for zero-copy
requests, so it parses the error string of an oversized reply past the
end of rc.sdata:

  BUG: KASAN: slab-out-of-bounds in p9pdu_readf+0x151e/0x1c50
  Read of size 8179 at addr ffff888004724009 by task zc9p/155
  Call Trace:
   p9pdu_readf+0x151e/0x1c50
   p9_check_errors+0x23d/0x510
   p9_client_zc_rpc+0x4f0/0x970
   p9_client_read_once+0x237/0x6c0

Also, the error string that fits within rc.sdata is parsed from
rc.sdata, but the device wrote only the header there, so
p9_errstr2errno() can print the error from uninitialized memory.

Fix this by ignoring the reply when a fatal signal ends the wait of a
zero-copy request, since p9_client_zc_rpc() already returns -ERESTARTSYS
when the server cancels such a request.

This patch is assisted by Claude Opus 5.5.

Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/client.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e63e8c2a853df..66980ad52bca8 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -706,10 +706,11 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 
 		if (c->trans_mod->cancel(c, req))
 			p9_client_flush(c, req);
-
-		/* if we received the response anyway, don't signal error */
-		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
-			err = 0;
+		/*
+		 * err stays -ERESTARTSYS even if the reply has arrived, since
+		 * the transport moves the error string of a zero-copy reply
+		 * into rc only while it waits.
+		 */
 	}
 recalc_sigpending:
 	if (sigpending) {
-- 
2.56.0

