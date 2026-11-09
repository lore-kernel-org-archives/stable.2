Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221581;
	b=sak3m/ooNvlsGJjSZ/vHTYghyg6Hm7wZZBmL6iAn37+hoUnS/qH+fdDLplZn3WB9JUNS
	 bxY5aSlN8SRgI4v6tv07HxoKcy43lmsXzLSXkfLzPXzxb9LF1SDH8HvHahSHFCaLwXZRq
	 nCvwtg/jHnRU02ImyLYmcuHHh6xb+2UHkXx3X52Nnj9IcV9i8TEVE61ofxrKkxqOtpibx
	 rsU62rCVFEK0RPybFuB/KF5XmY5Cc0krq0XPLOIpxTV3JZl5+qUtEwId5io2ERq7Wp+wK
	 FnwCtxPIEKJIiQYIdkJLqUXo1OfswL8awlRVZ59A44pWnB6SJxCTPtJbkbsYm8+1r5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
	b=S7TOUhDlNUAXu55wWOv2w5Rs4+uNMD0SjH1FBDeLJPv5sjRqU/GD+ukQ6L6jXDRaP+oV
	 yu4LP5gvfbqpZYJvy1BVw8L9FFB+9CEgf6QSh3SRscv7bM0lv9Z+fNEevwIRRqHmkojva
	 rlKwHkpw9FgV4U3izO9SZUC0rzjILj30X0gecXLZepVAR/wpEVE4jwyBy69dlWLkgmAx8
	 iFfO7Hcjwrmg1wWxlBVOoMLgLbsodtjAER0LDgq/EzGxO2sKc/7XiRq8ojwtNHVAC45/K
	 GrK1xQQkn/qO7jZjOIy7h4t2nSM2iRB+6hlcJieK+PIDQzF7xyrnWSa0GjpRkLRBobw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=StIPfKYY;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3789606D802
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3789606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=StIPfKYY
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3acec6677so839906c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221580; x=1794826380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
        b=StIPfKYY0Pf7oESixa8VrpAIMTjIbazHOQ8STdsjPvFKdOol/sVnmE+8+sSvl//8IU
         Se0fKXdvw3HY5rm2+78JchT8kHvhE3ovYvbj9y2vzUHs2Dfl2A9QTJ95K+ADpQcFaH9P
         1c6or5xnNkY/p65dius0nEop+n72ywszZEYESyDcFUgo7dPovFT3ZplKeT9k63pxpgJp
         BkIxFXywA4FeI3pdXUZR3dCW142SykEQUw3Tr/76Ebqshbv1JEKpWZ5psqO1Nj8n+XtB
         GOQjRBXU4nT+7TgJEUUOC0Z+qh7qF5qyU3pqROke5ugJa/5pM/9dWvFLi6NhGSPcEonk
         0jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221580; x=1794826380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
        b=ztCDYeWpIjUv8RLM7NopA1twXH7h4QFjODWo68RqDeuUQSYx680U2iPbSK0dHiG79u
         aslTNWeYWBfNgEWCy68tRJgnXCHd37COkX4ZBzUV4uhYSxRDmCXRt+5t+vI0gVaofPFv
         /YABVEHVLwMaf59RZQuB7vmSQfBkUJW4HPfWCl+1G2xu5wb5xSP3d88uofcnl/vX5/7z
         IbHJnrBhl9xh5bNq+sWRnnQj1vdjKRSt8RtMHj9Yc4yvRABhXblQRgItStPHD3yJWOut
         AZbGrBCMtF7S0szfsrNe5P+euCduP0KQgKkuHGbF2aW0oAcr9ezQosog4P4JXGBsItqm
         RCew==
X-Forwarded-Encrypted: i=1; AL+hErESzd5WwAdcHidDK0mwJW3QMkpEAvfzXPYZywUtROp9XBkLanehbAAI2UEJHODcL6fFylQ0KYU=@vger.kernel.org
X-Gm-Message-State: APuU4Z93LFpnRGfBK2eUdb0XxgG2IEtzanNMZXDwLGSPYwRoRs9bEsm6
	a+CvdTtBEUT9+09keMNvqt/YJSaoMsYquGqjpvow5lsGfKwAQn/G8hbDLt6m8RiDJA==
X-Gm-Gg: AYBFou27VlVeF/+zPZJT0UTyVKGwLkspxxq1LLv6Oxpl6l8YK+TjaqUAlMMd7tZ3F7M
	rzVuS7xgMZpSDOzz9WtZiG3zFk84nK6mHXLpic8YZgsvYHBCfg356mpA9d/0E6+w0vx/RX9jY7Y
	uYysn6bEbfvkeqOq5iHmafMAY8g/RIB4evcgboMHZy4Hg/aZ1x9rZDZqS6ulWKOFxG1GMulVROA
	RASB/EsB1RSuZLx71eglazq56iL/Ogz7WEPbZ7+tyYdRSRg7NzwgTjqPLB+B182exzopG6EHJSj
	d148+u97lqnnYPfYtBmQBg3NsP3N7nUx0mkZKixC8P6XHpLpOwa0m5YkasHeXaoYbuiJtfuFwBe
	Sj8nfcDHUGb74L8nOPi36aWdgeSTymdOHa3qzJaha97OvRI1QRk9Bf2WDnw5IW0/Y+10XaLOY6b
	mnzQ5DD7aLz6vj7Db5EObQYfszwSibE5x0+YxbGoxwuwM1NcXGKlNzrv/DD1s5vbGrl1B0CmWmO
	d5FlJE6Hr0hStgJwy1oNN+dmxGxZj+E3mMzgiRjazgq2MJhq+Y9iRFdFnkFOHnQSAMzdEUU+9rG
	jg3KOJlwcCNLLGRMP4etqe/enaRqD7CfC3NXOQ==
X-Received: by 2002:a05:7022:4588:b0:144:fb42:52 with SMTP id a92af1059eb24-1b39feb42f0mr8095312c88.28.1794221579708;
        Mon, 09 Nov 2026 02:52:59 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:52:59 -0800 (PST)
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
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] 9p/virtio: clamp the reply size of a zero-copy request
Date: Mon,  9 Nov 2026 19:52:47 +0900
Message-ID: <20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp>
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

req_done() takes the used length from the device as the reply size
without checking it against the posted buffers, and p9_check_errors()
skips its size check for zero-copy requests, so reading an oversized
error reply to a zero-copy request can overrun the posted buffers:

  BUG: KASAN: slab-out-of-bounds in handle_rerror+0x144/0x230
  Read of size 8 at addr ffff888003065768 by task zc9p/157
  Call Trace:
   handle_rerror+0x144/0x230
   p9_virtio_zc_request+0xb8e/0xd70
   p9_client_zc_rpc+0x21c/0x970
   p9_client_read_once+0x237/0x6c0
  The buggy address is located 0 bytes to the right of
   allocated 8-byte region [ffff888003065760, ffff888003065768)

Also, handle_rerror() returns before truncating the reply size of a
zero-copy TWRITE, which posts no reply pages, so p9_check_errors() can
parse the error string of an oversized error reply past the end of
rc.sdata.

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
2.56.0

