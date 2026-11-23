Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466592;
	b=u+9HzgpYIx5iTjf7e/8bV+VPvGPr9QmHznxBebyzDRMMjmOfX8glcaAZ5NYxN2oTYfg7
	 D4F7622sj1wASmUVHjcNF1kTQMbEcEkPdVKI9LuEmO3ov6ttYd2mV31Cv/HLLNbSG2zrZ
	 nA0UJI51d7uXKEJxcsmXAKaY/5Dnkd/ogvFlpEzm107u1eaQtbKTZZ1eV0UMQmI1sOJ5S
	 ENRH4hO+oK1boYvzfgcYa84vby4RV4yGBm/hkvT2L5c06a5VT9f4kmV20/p1cxfZ5Wmkz
	 b+qDh2pZtR3P57JChn4Uv6KfoaMlBz8NIi8y6XfungVv+4vnolf9PSW8WOFUAiaYmWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CxAc7sA9aEFc/cgGMwpQLH2BX4UWpk4VulV34Xym2pk=;
	b=W1220Lo/v4wrxQX3bdCmST30o0hZkwUiDebQ3tXWFBWEZn8jZkm3SRaUP1AnNTNqsW96
	 U2I0/QnGEjup0sKviI6Xwz8ImLtUiwNR+uPkeMzeHMYUa0h+531cFxJkLXn7mA7bNnNd/
	 +4ml8gf2sDmUu7enjUcaR7GI3+16mBab/tfqlvySmgNvFQTW1U0eDzjBZ1O8f9gVzMQRY
	 M5zQh3tmY4PBJ4UmI7qQiO3T6qC/m1/MvTRNcW+y1JEpYya9CYEcNixV1xppkLK/AYTd9
	 gjzlsoEwX5+DVtuyFvUwYOvLlsZP60uW+v2UgyyAhCavULFv8R1cpD6vuAfA0moizMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=mIK6uVWU;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F690606A336
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F690606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=mIK6uVWU
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4680767c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1795466590; x=1796071390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CxAc7sA9aEFc/cgGMwpQLH2BX4UWpk4VulV34Xym2pk=;
        b=mIK6uVWU5+x+qlXehQVkgKQBpccZzm01Z8kOLaJEXAOvZi0618t0YBbuxuenYkv3Ih
         nyV64qSqWXEOjXfMsYzz984P2HE5mTto+ldmeXZrCE3h9/RB5VpzEmfjGJUTGJmDZ2Gr
         8ENJxtaPkSHypea2Ff+a4HQhKaMGYUGMkRRN1lRE7XOYvnXkGSXDOPXts4YxuHBcSoyE
         m5/7ofJ3L22tASqxQGV0cs8u60dMX82QgXN15Y0AAMk6KttXs6FcTDMLqc9yxIYxuJ0r
         38zGA7oEHev0XIqO03K+l9yraz7rWCfMFDDKQCaJIS9XGnLs5DKzh+OcEyb2jqQvh8SV
         VGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466590; x=1796071390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CxAc7sA9aEFc/cgGMwpQLH2BX4UWpk4VulV34Xym2pk=;
        b=dYovb7p6DeiTMiuMGJvOjK81/nV4q6V5kYosp+1OErIqxefjFGi0s3T0p9upk1KmsX
         Bbp0juWxUJYTBznaXjRv9udwbVne29LrUykqvntRUK6HGpAfYmHb1QULnO8MIpx5gVBU
         eLPV9uY8OK43KInaJ+U+KChfhxWyZaZnJGyz5AlsXyRp8iJ/MeRsQxRfjWQALoqnku+C
         kwokHFmcJutOlOnwfFude8w2OnQS/zXpTfURjovR/s7Ur2EKxaDgjc4dUS1QKlb0UPDC
         71fQQwuSutOkwbDcQVAudzS39/3OouZS0xs4CXNnHlWc93fNu/Ct0L9FtLvEATl5UPD9
         oMoQ==
X-Forwarded-Encrypted: i=1; AL+hErGBekrkf/kuBIcOdiCNitrbrwkqzdEdSz0EUnzB0eZgIQUnEIEhsMXqzp+uh0NdBwSk/OAwBOI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uibmXYsdueG36lbTv9wfSqxUZCcs5cny5JMw4jtV5jdDC/ggO
	hVowmspZrRN4/SNUe1mJp74XMQ4ZZXBoM5/CD75R0nhq2RJVcK7OgqDqDUMd3332Bg==
X-Gm-Gg: AZFdTZeZDIuhUSWtj9n9vAo98/T1bPsPJb4zAfI/FihoMCSs60gZP1MKrmcGwFTyq50
	MOkD6aANDalz0b4hLgImKQjzEnZX+RbyWiZYIyND4mrrYaxYVzJIg0H1uYTQSrPj4SEhBK6zaNT
	ZVQlZ3W/FN14PI9kTWr4HJYbBSLLG98UEE8kcfAlNh0k92Z5wNcupqivS3rW0L0oMkzJIZ5FfaA
	9w37Y3gcf6Sgszg/hONnoLbxUY0Z0wTGcsuGPEkKzD6d5Io1xQYvp93jb8cVxEFKCxiZBHp7ihD
	ij0MliLp8ZZaNrrE1IBbrbo0b5KpA2TeN4O0uAl4mHpWyD+5HOLLCd7ByZC41dVpTO1/PciaKPh
	jr6ZwVcoeXN4Rzwylef8vezsc6wwvX5lpP9eTbLptR3+jLzouCTEQPUDtbC3KQN8ZlVEMridUu3
	1XRqvCN3oq0ZxyPCtNQeIIaquDRHhReGD8FO2h47/jdzxoVcSuZGcXv8eym+aEfbyi/STCycid8
	AbxI4PxLozR248TtQ4pheL42gTZG7C7AZ3/UzDjcBWGcUpLOkms7NA01rHhGi/Rw4irRzAue5x9
	RVRYdHb01Vcss9Gj8vPbddrLHMOR6lLN35f6mQ==
X-Received: by 2002:a05:7022:3a8c:b0:1b5:3490:d715 with SMTP id a92af1059eb24-1b55691e0camr12826076c88.34.1795466590192;
        Mon, 23 Nov 2026 12:43:10 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17407732c88.4.2026.11.23.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:43:09 -0800 (PST)
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
Subject: [PATCH v2 4/5] 9p/virtio: set REQ_STATUS_SENT after adding a zero-copy request
Date: Tue, 24 Nov 2026 05:42:56 +0900
Message-ID: <20261123204257.3055515-5-lian@is.s.u-tokyo.ac.jp>
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

p9_virtio_zc_request() sets REQ_STATUS_SENT before adding the request to
the virtqueue. If the wait for the ring is interrupted by a fatal
signal, it drops the virtio transport's reference to the request, since
the reply won't come, and returns -ERESTARTSYS. p9_client_zc_rpc()
flushes the request on -ERESTARTSYS, and p9_client_flush() calls
p9_virtio_cancelled() for a request in REQ_STATUS_SENT, which can drop
the reference again:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:37 at refcount_warn_saturate+0x84/0xd0, CPU#3: dd/314
  Call Trace:
   p9_req_put+0xe5/0x190
   p9_client_zc_rpc+0x537/0x980
   p9_client_read_once+0x237/0x6c0
   p9_client_read+0x9d/0x140

Fix this by setting REQ_STATUS_SENT after virtqueue_add_sgs() succeeds,
so p9_virtio_cancelled() is not called for a request outside the
virtqueue. The status is set under chan->lock, before req_done() can
set REQ_STATUS_RCVD.

This patch is assisted by Claude Fable 5.2.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v2:
- New patch.

 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 8d9555e64490e..6d1e6093db095 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -467,7 +467,6 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 			inlen = n;
 		}
 	}
-	WRITE_ONCE(req->status, REQ_STATUS_SENT);
 req_retry_pinned:
 	spin_lock_irqsave(&chan->lock, flags);
 
@@ -526,6 +525,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 			goto err_out;
 		}
 	}
+	WRITE_ONCE(req->status, REQ_STATUS_SENT);
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
 	kicked = 1;
-- 
2.56.1

