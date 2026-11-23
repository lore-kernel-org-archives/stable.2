Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466584;
	b=ex0x/SFHe2HgBewnarkmZiy5hkrb92WRvXxnFMZZbOW5y1nUlxr4Sytj0/op7y85j30T
	 gRy2y1y7gG71A7+YfIV1x/3pASVauPaAE1YVJ9MW3xHpnXwEws0EI0rQ1COX6aXHvzpas
	 ii5v4bdf/jz48x8Qg/1i82ZbjgP6ZcPwJDG3FFW10BOE1EurzXWbTa+7dNYygH64458qv
	 wZz5blgYtwXNBJfNUMBGSNkAHDEYQzZ9fj04mIbcNrQNpSB/Q2cZsEed1Plv49IpO0MSP
	 uYMbbzbvFPOntvFZuwvsQNY97z7f2ep5STEcr845MaLwdmSn3H8n3ohBpAZ8OmNVQTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OJO603BZ56Gwx+rXu1nkCbY5cmn2EctNBhT/u/dOfig=;
	b=f85nQES5xclH+gP1cYAiNcl8VFVlzAcF1R6eB2PPhxjTF+VZRQoAhFjyu8JzDBpZtyLq
	 uL78n4oaqSfUJFVatMsDpdWbDWPuzFWYWPtU+jIiyP0z2ZjQBJln2crc3HsPB7W49g+mA
	 mzg8SAJSgrI0cncuWlk7+V1VLWczAZ3omZVwRnLDz07fASbxzu62P50aWxBzFxpboR5Ca
	 XOuaa1jRMn3+mGUirI68fm28fQP1x8M+0tqiyxtmkF4JYOe5VPdKuWhDrT8tpA7K3ytzG
	 zPdGMQRa0CHBMeu2OKChF2j/fgH4hynhYBA/tcN388Tl1CGAhHyEYUJNTyIV2QwHizg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=jG52oS2r;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C2606A332
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D2C2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=jG52oS2r
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so2944620c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466583; x=1796071383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJO603BZ56Gwx+rXu1nkCbY5cmn2EctNBhT/u/dOfig=;
        b=jG52oS2rt907pQFHxPYoSi6b9lw1qtUK1+T6tE6fNhQ218OTaqJ2Y9RPTSBzLxd0qt
         L0bvA4I002UGklsLCx7YFeOpR1gH5KxcQoGRgrwRUsSAHOhp4wgO159ZMJ3AXX4+6nUY
         6tuBXC9rwl2Y4el1/QOMEV0VD2y8j3dlhsRn478msJYDt2iZAzk6gnxa9BsX1+J89wpF
         aSsg6IbN8AjZFAi6JqA92rop2s8fwKSjKJgpedj8eT8LK8f40x8BUP1hqZJ02zQ5h03x
         rBZQn931Hdc3+zq8CEM8FIayMG2WldqbkjAGbhzKYNe3lHG0P620+6rcKLC9o88QvB2l
         Gi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466583; x=1796071383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJO603BZ56Gwx+rXu1nkCbY5cmn2EctNBhT/u/dOfig=;
        b=bkZrKZA+hCwvNROmI5s0nned+2T2YtBxZJVboftOUYetyG18RUFiCsKBYquO0qpetX
         SwA9Eny5J7lT9n82fH1sSk/onWkdq9ZtbdtZRrmNOlK8ZX0SdE89vQ5aZkSYmUcZnMb6
         xCbS1ZFVI/hOEa8pcRS77KaUGMDHMKdUGaIr7wpACYn3PwehynHT7CGYWKX6Ee8AHoVK
         +9Xkin7CJEWQLRDfsw6oxApiBziDBwCAlIlOqmtRdZ419FzmmTULFGvd5edVk4H3fR5Y
         CtXY/k41YVJ82WOlB1ELawbNWfsGcDwnBL/c2cvrSdg6WMcLgSqYAGDtUGXvV5bp1a1V
         ZAWA==
X-Forwarded-Encrypted: i=1; AL+hErHmOyZs51k0A57or64M48Cm1VcsgldzdKXtEg0M2pkz3Sm/onLfPdGIEm2kWj43jf1quxuYeus=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UDmV1Rc7aKAPo2lMiuIBtJd5KmFns6z7rS79qkfxcwqDtzerM
	2astzZBRqD9QycJFVNJJwf+XQelA7BLCxCkYL37WMd4hlwubKac7gtejnQQutzpKhA==
X-Gm-Gg: AZFdTZd4IUWD86BZ9/CDhgPn9Lu0dAfesvOD52eqCz9pbbZB3ZeT85EXqmxaO5IwoOP
	GCQAI48ex1JnibsNvEbRVqtySNjgkro9foaSYJuZ6b/MBDJMbULgGRcM9Z3shpy51B23k/KT2zc
	rpk2Bz7x2zjc1wmNaf0Rke7oG0NtXaMxdggm7xhtI/rnHbjkOmj+rvSb+uuFtNOCRrv7hFCql0p
	oNDF0zkmlrtvUqL4AeukY9qG9LKYEinh/czknpalAnaXQAskw2Fun6wzUJznwtN6VPyo0gr0Aat
	WRCaTM1U9LG5NaRecWU+W8Bd8fQCPtuddrKpQiawKsL/cu9UP9714DUx9pMwaG7i3nMfhOr6tBL
	s2lVq5XDQKZbwZMXmYk48ACV05o9gceoagmAAjg9eoa1hofWm1NuhIgcflrgNL3kGDrEyGMRZqm
	Wk/4eqoGSqcYaReAb90rSczkm+4Jom/8afRUWL3phkbfaHJQ/JWS+fF4eY0pDQ5KIO/m1LZ6Siy
	vz5VWppOC92xPZ0y6o08MJOeAVjlmBqC42cb1ZhNa1agpmCwp2ymeN3931c58b1PWOrzlnsApEJ
	j7vrtDm92TvXcKIQX1IO1spxHv4JSmFG3zEulQ==
X-Received: by 2002:a05:7022:b0c8:b0:1b2:6855:998a with SMTP id a92af1059eb24-1b556911007mr11278105c88.34.1795466583163;
        Mon, 23 Nov 2026 12:43:03 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:02 -0800 (PST)
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
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] 9p/virtio: clamp the reply size of a zero-copy request
Date: Tue, 24 Nov 2026 05:42:53 +0900
Message-ID: <20261123204257.3055515-2-lian@is.s.u-tokyo.ac.jp>
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

req_done() takes the used length from the device as the reply size
without checking it against the posted buffers, so handle_rerror() can
read past the in_pages array when copying an oversized error reply to a
zero-copy request:

  BUG: KASAN: slab-out-of-bounds in handle_rerror+0x144/0x230
  Read of size 8 at addr ffff888002ee02c8 by task zc9p/155
  Call Trace:
   handle_rerror+0x144/0x230
   p9_virtio_zc_request+0xb8e/0xd70
   p9_client_zc_rpc+0x21c/0x970
   p9_client_read_once+0x237/0x6c0
  The buggy address is located 0 bytes to the right of
   allocated 8-byte region [ffff888002ee02c0, ffff888002ee02c8)

Also, handle_rerror() returns before truncating the reply size of a
zero-copy TWRITE, which posts no reply pages, and p9_check_errors()
skips the size check for zero-copy requests, so it can parse the error
string of an oversized error reply past the end of rc.sdata.

Fix this by clamping the reply size to the posted buffers upon getting
the reply.

This patch is assisted by Claude Opus 5.5.

Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Closes: https://lore.kernel.org/all/20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn/
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- No code changes. Reword the description of the KASAN report.
v1: https://lore.kernel.org/all/20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp/

 net/9p/trans_virtio.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 9fa63e3ebf673..53046668c16b1 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -537,10 +537,14 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	 * threads - echoes to wmb() in the callback
 	 */
 	smp_rmb();
-	// RERROR needs reply (== error string) in static data
-	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
-	    unlikely(req->rc.sdata[4] == P9_RERROR))
-		handle_rerror(req, in_hdr_len, offs, in_pages);
+	if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+		// The device may report more than the buffers we posted
+		req->rc.size = umin(req->rc.size, in_hdr_len + inlen);
+
+		// RERROR needs reply (== error string) in static data
+		if (unlikely(req->rc.sdata[4] == P9_RERROR))
+			handle_rerror(req, in_hdr_len, offs, in_pages);
+	}
 
 	/*
 	 * Non kernel buffers are pinned, unpin them
-- 
2.56.1

