Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466587;
	b=PaaE0JjEaBvG9omxdSdSCgfvrWTg3P4LiTGWSM4mZ+wZQuKdcAFD+w5C3OlGJNHwRYvT
	 L6iRTbE9ZyhplqAW3a/entkplJ+wmNTavI8vfwE6onj1uJH6ZNz9uR2x+qKDU6L9JHi38
	 BpRLUdnFGYeeWXIdlrXVibLl1LovGUGFNr8nkhdas3PnKFltyxpqIWqZUqr/7Umg9YYTq
	 ODMlH8OST+laMQ2CU7qGsVh9gaSBb104mtWtisvS3lGLFFRHtttCRaqbpX8/3V+gpmlSD
	 vEWhUxaKsuuL/Q858QMr5QGHqOJy/1xaB+38LsW5hfXyXv0FE2+QDhLzYHJ11QQD0+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0Y9pBXNFdOnmtcn0gkIAMKcy7ARujZNyPh4CIXZPjfs=;
	b=2chPGQ/c521/ZnUcN/OKAFusuqJRvzc6VLghZQWw91JSqk77NA8DzPze6XH0bkDa5tsv
	 W5iuUt98rt9DrjXTNuclKQMVcI00Nbf7iWQ7hLOcZ1wnYvI4Enwna9j5XN6jjNYKhGT9Q
	 ska90GziOgNSAyd2ukPYteDgyrvOtKLnVwSvJAgrM0xoLqGXCHayWmNXzQx3T2iXGEKvY
	 nK6whg5XcG/14fRPloNcf8ZMzNQzidmId/IVU3MG0KBViSFaT5gdOxynVVqghtKjYO/MO
	 sBKpZAxkmUbPdUo+u+FkiTr56DAwYRIrJ8lomuDEW8jo4JtPYqy6ssp69u9cENR3OIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=rIHXgnK8;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1A606A32C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E1A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=rIHXgnK8
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-385d8a00598so5237322eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466586; x=1796071386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Y9pBXNFdOnmtcn0gkIAMKcy7ARujZNyPh4CIXZPjfs=;
        b=rIHXgnK8row74LDcdM+nCrafO38geOO5vZXmSGZqOva4XGyPoifLSKddWZ6RlkAqhc
         WO9LXeTa/IdNTwSVHt/aXgy65QdP5QAU+zvJFERGMgxBmnJqYS2MVZvx5uoMJMUdIeVs
         DGWGe0fFBWA465fDAQFs04GA8NHFkq3POPHOuqiwb/05CnU5EmNwE2zxexNvcnb+ObI/
         MwLKNfIS4WJEM6rE6VOUmEne93Tts6z0yEv7pNHmIoBiYjY+eO4A7Wqu3Y8rxA3GYtFq
         PhIfgqZ+eF/XaU4+vZojkG9fBv71SMN6EeSJ2TjqA9AkKwjrxPEx+9ypREn5v7XLXXNi
         TV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466586; x=1796071386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Y9pBXNFdOnmtcn0gkIAMKcy7ARujZNyPh4CIXZPjfs=;
        b=w4MkVOI/+yuqVF/T0qUtUuFKUVEVnSUe5ufkvqiqE124nwHaU7OP8xnrDlc+yYWs8v
         qQ1WADPAtJa1AdEFGOfrlklRVokSIintr48qaVWIAWoOskY0TyNdf0zRBil0Cug7hf1W
         vdAB1LBPTB55BYRjtYlhoMcD5dL34sDB2L8WsF7nBwItkehfqWjsjVcLGLfm+y4xpn/h
         vOQcpOvzxCqBFya0aXezuogaLHfjPvaK3cjv51XDLDliQIdXRt47EX/y2M+Jq7hSiyI5
         8EquRHrAWudtYJnCKHfyxrNTPbBv0oInVHR5KmQDw09jmAWZw4HuNKDEcqbx0eaJxJL/
         LCoA==
X-Forwarded-Encrypted: i=1; AL+hErFaLJy9vX/FIxrWI8VTb2eq9Lvlwe0JTcEPctW1ioyhLAVskKBoT6Ura2aqCNenHKXOi0g9ipc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eTZoXXIQKDXGpJ21VHIG62p4w6FKX8OozrKP2uujXTVhMiDka
	t+XBjdXB1NyNkfOGZYkPyvcz7oWLUbVfw5ZXVwg8XqBrZpDKJXGw3trCHaB1udeqTw==
X-Gm-Gg: AZFdTZda/+2/66SHuH3lbRdNT1iBFeQPqiGwkUcVL3QcFt3dquVz9xGBbjtmH4WnGTA
	3kfSnzOqFrdlVg6NN7LJYiieli/ejtyFJqGUABBNwdTQxjAOfmJfottl0T8IbF4YopffNS7trvA
	TsCzj5R6MOeuxyJJJXEZUEOgQ1tdDixRyD/F2v+8iHtt/FmSpcFWNVte+pQjY9jnTQ4YWnr8sqq
	nSpjYXulQaHF+YnLG0fEn0gI8t9Wj58r9Z1eVGbhu7xKpN4e4gRIJCnImq1AG5DXRTbE/bh3DiH
	De1vkh1kCZY6Mtpenl6tKxiPi58/xSGhco2qOxwEY+5ZQ25ElKzLg4PutcnsJtAbbSEKJ28jQar
	HALU3Es5a3QJJ8YSlq1lLnS6LDGlCc6mKqvIaYytlTH/c/QBn3ToTY33fO/muG7d93r985quOy8
	8nv0s1mOqFSghFH53CRh2kYYSA+07eSNc1vaEy18hUGEeIh3hUMeYrySg5zOc8LdxaYnxZldP7M
	DB4A6vXvGONp7lzz+PgzjU+GhpOr3ziKXjFs3iFJ+Aq67JnrEg8EZ2p9QZDhPhsL6jX7ts5wlGS
	NvJ3M9xxqNztG6JvyT7cvye9Nh0VRLxPg5RE+g==
X-Received: by 2002:a05:701b:2508:b0:1b2:3497:5998 with SMTP id a92af1059eb24-1b5568f03abmr11749247c88.36.1795466585475;
        Mon, 23 Nov 2026 12:43:05 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:05 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	Sashiko <netdev-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] 9p/virtio: move the error string of an RLERROR into rc.sdata
Date: Tue, 24 Nov 2026 05:42:54 +0900
Message-ID: <20261123204257.3055515-3-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123204257.3055515-1-lian@is.s.u-tokyo.ac.jp>
References: <20261123204257.3055515-1-lian@is.s.u-tokyo.ac.jp>
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

p9_check_errors() parses an error string from both RERROR and RLERROR
when the protocol is not 9P2000.L, but p9_virtio_zc_request() calls
handle_rerror() only for RERROR. The error string of an RLERROR reply to
a zero-copy request is therefore left in the reply pages while the reply
size still includes it, so p9_check_errors() can parse the string past
the end of rc.sdata:

  BUG: KASAN: slab-out-of-bounds in p9pdu_readf+0x151e/0x1c50
  Read of size 8179 at addr ffff888004b4c009 by task ls/155
  Call Trace:
   p9pdu_readf+0x151e/0x1c50
   p9_check_errors+0x23d/0x510
   p9_client_zc_rpc+0x4f0/0x970
   p9_client_read_once+0x237/0x6c0
   p9_client_read+0x9d/0x140
   v9fs_dir_readdir+0x2ea/0x730

Fix this by calling handle_rerror() for both error replies.

This patch is assisted by Claude Opus 5.5.

Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://lore.kernel.org/all/179446998758.2199510.14994914047354508278@kernel.org/
Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- New patch.

 net/9p/trans_virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 53046668c16b1..8d9555e64490e 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -541,8 +541,9 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		// The device may report more than the buffers we posted
 		req->rc.size = umin(req->rc.size, in_hdr_len + inlen);
 
-		// RERROR needs reply (== error string) in static data
-		if (unlikely(req->rc.sdata[4] == P9_RERROR))
+		// RERROR/RLERROR needs reply (== error string) in static data
+		if (unlikely(req->rc.sdata[4] == P9_RERROR ||
+			     req->rc.sdata[4] == P9_RLERROR))
 			handle_rerror(req, in_hdr_len, offs, in_pages);
 	}
 
-- 
2.56.1

