Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466589;
	b=E9XKGw5aLOTJtGQnMqVGSouhfqSAlQPmaJpPShbNtfEqTdSPJB9+SDSexUxPbWLB5DSX
	 GBhvZWHm8UMjKS1RhqnMCVzSStkeH5dnI9xTXEcg6GZKXUWHGab3QIebUb/IKMbRBThdg
	 9mFouY8Lt8I0hTQnjl9jD4oDH5TMcKSx07X7dpiyoTPiI0Nm7cuKWFCfxhKJjLUYyTqTF
	 T6WgZU2VZVJ8skPT6eT108kg45cXsFfPeEU8/rPE9F83ubuZ8fsmxueH5W99+9ZCHfE+h
	 wlCUTff2hNvaFAyM6CPb3vJwdY/UF5NUHz+COiZsNpOrihGQ20Ru2BHXl6RHelDB3aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EJRttlzq8IpBp5LFV+m7tLojBORcGwurVqY+n4rc2GY=;
	b=0kkI2e43QkHDxWTELDPlJNFDHlw4LtGYKtJx3BstAxzBzvD8/Iv3KcajOMZpN07aEGWL
	 PdOvzWRbQeB/WdUGTz/M4jU54Rzb1XDgV85ufuI6jmBfDoTli7w+ZgzMcMmPJbrN/xpAZ
	 eE2uyYB2K3bj/a3QtSAT8+o6L3fxUL8DKZHm6gckfYWN30+ROCgaYujnvvpzD5XCgsPKM
	 Ns4C+2VblfuumLdKn1aF/X6AmgwynHJtWg984h00jhvuNbmgZXJtLdtklr2sfcA777ROJ
	 GyLRcg8P+yt7w+VPu4RHJ9tsSC/22Y4lIq+vljXed58DTJMNOgFxOh9oKPHqJMrfvwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=WkWSDix9;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC201606A332
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC201606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=WkWSDix9
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4680733c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466588; x=1796071388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJRttlzq8IpBp5LFV+m7tLojBORcGwurVqY+n4rc2GY=;
        b=WkWSDix9GuK6inx+cpjcLk+pY4ZD92gWMy+8XEDyLaSeb4Qy/npFjEb58pGTF9AJm7
         6HT/1tkkbQxr7+mHJC1n9+ukv0V9o2eJ3Jk5sZNuyKwxKU2Ntr0/wON0Pet1lz1TmrxA
         pVdGhY6DdlVK3gyO5Or4WdsZu1uTqvvNF5bFHy00611SteZlHIo7iBwrZ84bTCNZWUql
         O/A9gzIySBDR06kSSHCyqfA3768MKIeh1GmYV/EfUgmrIQ4bCc9MDrogqlWdRhFfZCjj
         /RZTWVMPlXpikD/9QhVxn5hZ1i4Fjx7T/w/bq9T8HgTjfJciVxcnMVQQ5tcftP3fbUW2
         FyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466588; x=1796071388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EJRttlzq8IpBp5LFV+m7tLojBORcGwurVqY+n4rc2GY=;
        b=fUsr3ZCduSH4TDlLeJu68/qrweTQY711bq6gheSwN+n/y1HoJFk4fPhganvg7ufZhI
         wDOxaSddGp0nwpxk8B2ydMOyl0/RLjjt3ANfMeUA13YXnLvNDrJ9HVyw8OFL4snmOUwR
         HUWKCAHnU7652joXgIKRsVNTHtxm+zjwFo1AfSN1RS6nmlPAWG+3xfL83DTOHx0vfxZ/
         SuBZCSS1uuSWe1lVwvz+Sh7uLiuXECMBrBdx5mASOjc2ftF9prFfwRUVp/dv8xG9lpdc
         Ih8LVXPYHloT6/Gywv55F9x7sHHsZ2/OWUX/olnmb8TX6mmWeDDLkqdkpAmq8zu90xMu
         dNJw==
X-Forwarded-Encrypted: i=1; AL+hErH7JB/hK/O5M8tSdRMBaZ+xJIbszum1uYJs5ij+tZRyRgt2RvBzi7/bifJRcPaya/HUYYJn4YU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9G2K2F6oGf9w6I1lI/pvN9r8iN1MJyjtYbZFKmaaUTwvriDwkN
	po6aRhcHTdGsTZbdHJ8S1ii3CnOO57g5egsJtSRWBRgUr4jdPESWmIrD0DxzSR3Nzw==
X-Gm-Gg: AZFdTZe52kVpRW/uw8EXlHPELpZ3E6ihE1AEi7iY/yAYNtqyswJuqkScyU3OscMcqQd
	b+2D2wq0pVIQ5Rr5jlzI3549PwnjcNYGbX+gfjCy9UB+DH8D93fCmJst69p/djzOcF54PK5jZSL
	+FHMtsXEuLwxFJLDXuK0flngBJiQOO+BBWSJXenWOIfoA2ACxAvOlQ4WemsCqzablgDrNtEBXuE
	LHs7aiYrV+lc5vNPvGJ8TwTnwBdhg1eNtsK9dK0cgZynRCydRLMLOxt1hEMcdGEXW+YBvuD/p6d
	4cK0Kgj76PT7Zx/YvAm3LF9QjyPCImz0mwtjnEpBVZ/Tlz0+089EJqeGOazezcprlsW/tsciD78
	xnuCieuhAl6Szdgavwxbhle8Zz59T/5HG+MYVn1wqD2Cq/pDzCGjF6Bq22AY2kB4S9Lt+/xhmco
	c974AppG8gYh4ti/LgOMcV6s4aH2qsh7DXdlecgTyM6yrTGnfb8MnvO0qCr9ObYtBb3mOiBxc7y
	JjhIbQ2b1GS0NZE/G0h7Kfbk50FwLLc+4dWorvHcN1BcoPeihQ293nrFgTOhXmC6jnHWrB0EzA9
	l/MA+gKYZ7GotSRA6pBflZbraWzJ4N1mDb47Ag==
X-Received: by 2002:a05:7022:b886:b0:19c:c396:37aa with SMTP id a92af1059eb24-1b5568e1d36mr11821108c88.22.1795466587986;
        Mon, 23 Nov 2026 12:43:07 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:07 -0800 (PST)
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
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] 9p: bound the zero-copy reply after a fatal signal
Date: Tue, 24 Nov 2026 05:42:55 +0900
Message-ID: <20261123204257.3055515-4-lian@is.s.u-tokyo.ac.jp>
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

When a fatal signal interrupts p9_virtio_zc_request() while it waits
for the reply to a zero-copy TREAD or TREADDIR, the device can still
answer the request before the RFLUSH, and p9_client_zc_rpc() parses that
reply. p9_virtio_zc_request() has returned by then, so the reply size is
not clamped and handle_rerror() is not called. p9_check_errors() skips
the size check for zero-copy requests, so it parses the error string of
an oversized reply past the end of rc.sdata:

  BUG: KASAN: slab-out-of-bounds in p9pdu_readf+0x151e/0x1c50
  Read of size 8179 at addr ffff8880043f8009 by task zc9p/155
  Call Trace:
   p9pdu_readf+0x151e/0x1c50
   p9_check_errors+0x23d/0x510
   p9_client_zc_rpc+0x4f0/0x970
   p9_client_read_once+0x237/0x6c0

Also, p9_check_errors() parses the error string from rc.sdata, where the
device wrote only the header, so p9_errstr2errno() can print
uninitialized memory.

Fix this by accepting such a reply only when it fits within the part of
rc.sdata posted for the header, and by returning -ERESTARTSYS otherwise,
as p9_client_zc_rpc() already does when the device cancels the request.
A zero-copy TWRITE posts all of rc.sdata for the reply, so a late RWRITE
is still accepted.

This patch is assisted by Claude Opus 5.5.

Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- Accept a late reply within the part of rc.sdata posted for the header,
  so the RWRITE of a completed write is not dropped.
v1: https://lore.kernel.org/all/20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp/

 net/9p/client.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e63e8c2a853df..e21d13e274691 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -707,9 +707,17 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		if (c->trans_mod->cancel(c, req))
 			p9_client_flush(c, req);
 
-		/* if we received the response anyway, don't signal error */
-		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
-			err = 0;
+		/* if we received the response anyway, don't signal error.
+		 * zc_request() may have returned without clamping the size
+		 * or handling RERROR/RLERROR, so only accept a response
+		 * within in_hdrlen.
+		 */
+		if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+			/* echoes to wmb() in the callback */
+			smp_rmb();
+			if (req->rc.size <= in_hdrlen)
+				err = 0;
+		}
 	}
 recalc_sigpending:
 	if (sigpending) {
-- 
2.56.1

