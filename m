Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794284016;
	b=PBPVu0Nw7yg4kkn3yyNDz8q/FIhh9RDPAmZDNnKfxbrZX5T1MzQHbKIVXHXvpdEtuIkX
	 NdOxAzL/RdDQBJvPhD3s8uB/LysrQO1uvY4SzvGttAgxNlvaExlap29G4m7GBfdZvYymX
	 DJs0HVNTJ48rV0L6zpCx4vNwq+H3683sPEZYaWyDmi118MZrA3G4cCBfkYQ1u0Ol6ukHR
	 3z+WC4kGQcmx1n64lrGG+TH4y7+raLMx49a4bgUKhTuS2Wg07kBpP/tGBjIcwhf9kMaye
	 Nk63zRrP0oPa0hQbobXNaiQe6xleyiEpXeTEbp4l39on9CUQ7bPfV5GkU8DQUeTX3Aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284016;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x5Nutz9s3G9AAWB/9srA9rP7IgGDdtdeNmZgsZmICyo=;
	b=ri13Lq9MrVHxQcv/3t3pgUV9xlSYBi1IbloNLh32qnwwRuhFwy3GHaW8KqiIeEFCE8nV
	 /lpVdaFVFRRV8+FwlpwBdFmnM4NUC12+IUQql2NahjP+E/UZhQOn3fBggTRdFOxgNluqE
	 Cp6K8C81fNbggoE7ZDDRwk6/6ZohBz9vTPGRHbBcgsxO7MYgSDqatQdf6hIBHQLQgiMqg
	 RiHZyxtlzgn8Zug3ut/UzGbYNyOBJtfeyKyA+gSZsZ7xe5by0In/egPvifykdiRv4FrL3
	 RV1eFh0smDEq6hJkaUgekD5vzV/cwQLRovU/2BEfLQHaXv4/rIK5UhCNP18Dc6BWhaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klvwVp0B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697A7606A326;
	Tue, 10 Nov 2026 04:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klvwVp0B
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794284006;
	b=wyu4dG0WprRxGfwG9uXkkdJzhCtmmudsbc0EGk/3BnBEfSNc96sz0Y6QLH2xMAAz6PwD
	 XO8xUwbYPznxRSCK5mzcvoru46E21+N4FaJcl01HS3qiVXzjIaJ8gfgju1DsSWmINwmdL
	 Ua7CtMVTCFmbjJoMS1327fBLZD5HD6PtHYjlCQ7f23TZXzdwy7/Gny0/VGZfdrTDYabrV
	 NpA/W8meLY6hOgnsgfvnOcAVXIu8J4hE6jA9lB5oXqCU1Tgohk2hqS3g+lG54+wwEMaB/
	 +n1r6Z0r+lLHNJ+vOku/32nrhJ+dFWLc9zPXRDx1wi0VyTpqlnNuovRQvrtG5s/1uZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794284006;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x5Nutz9s3G9AAWB/9srA9rP7IgGDdtdeNmZgsZmICyo=;
	b=Bw69bizp2byDJ8V4GgjyhnWCypdXS2qDNOpqNOJa0IOwSwnSR3XNJChZmq5vrslbU74C
	 /D/QK8fa8mHz3AtF8oC3UP9LLwu4OMlRzjXeSBoAlA/F2bY7waKmjhnP2Pm71oXtc5QXg
	 D+gCzGiHIS5kYTVHgXIcM2cHLjJYzwSChD6SlGQMeyJOjhSS9eMgbtQQ2IfuZbRyGiaJP
	 2dsJkv44uShw31R+o7D+fC8sYtvGMgpo5laCPPL0+/T18qoKJDMAD1F/qFdUkeKEtv7M8
	 br201+2Ho9x5FvFx9T3I8+rhWC8hqxOAkHIrjAh1YBxXVsy8BAPHFyi3T84jQ8z6k9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1277A1F008A4;
	Tue, 10 Nov 2026 04:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284006;
	bh=x5Nutz9s3G9AAWB/9srA9rP7IgGDdtdeNmZgsZmICyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=klvwVp0B5kOE+cIifMDPD7M3OK5o7DOGSFrBon2VAwufQeZ5HDojFlBM3V7orZInz
	 7kCI6wPTkCd7AEKnR2Eidji7/eBnyyORuywmHChK2/MqarOqWWDTlfS/wM7NjSUVad
	 OIQXpusvJDHZxfVtA8XfbfMP7ptY7Fg3dkM40FQOxrgqDUXG2Z7Jjl3H0mTh8weeqo
	 astwGtxQTnpC3eH4ZZVU+2zEYjUAwBHIKT8yc70m7pgmlGZAOPnJad3rz7cEbQ3hlu
	 8yYPh1quCq6MwuE1SQWRc1H2jX6jcCYOq8faIDpUGj4N68JKP1h1e6lipFl/cU4p9f
	 5M3IvQTtabudA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 956B748828;
	Tue, 10 Nov 2026 04:13:24 +0000 (UTC)
From: Jing Lin via B4 Relay <devnull+kayano050408.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 12:13:24 +0800
Subject: [PATCH v8 3/4] usb: gadget: gadgetfs: prevent ep0 event counter
 underflow
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-gadgetfs-ep0-v8-v8-3-8f90434574fe@gmail.com>
References: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
In-Reply-To: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jing Lin <kayano050408@gmail.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794284002; l=2064;
 i=kayano050408@gmail.com; s=default; h=from:subject:message-id;
 bh=pBjpCdkDcRNOhDPtGrN7QLaKfaAQikSi1RkPd2YYDUQ=;
 b=samnUyOjUqW5GKsaAhRjLqkd5+rKXEIFpZzgZWhi044/16FyRCE/k0E/8LNh+hayxZbQp3k8z
 uz9adxC3fv7Aw0hDYJ39vEtI9kYn9ZQAv2Bdrt8wD/tQ9MZEvCuUHmI
X-Developer-Key: i=kayano050408@gmail.com; a=ed25519;
 pk=pr6i8RN1WEON1jbXPdghSglxaBSzfuJjXNGFknX//+A=
X-Endpoint-Received: by B4 Relay for kayano050408@gmail.com/default with
 auth_id=1441
X-Original-From: Jing Lin <kayano050408@gmail.com>
Reply-To: kayano050408@gmail.com
Content-Transfer-Encoding: 7bit

From: Jing Lin <kayano050408@gmail.com>

ep0_read() snapshots dev->ev_next, drops dev->lock while copy_to_user()
runs directly from dev->event[], and subtracts the snapshot afterwards.
A concurrent disconnect, connect, setup, or another reader can reset,
deduplicate, or consume the queue in that window.  This races on
dev->event[], can drop newly arrived GADGETFS_SETUP events, and wraps
dev->ev_next if the queue shrinks below the snapshot.

Dequeue the events into the local buffer and update dev->ev_next before
dropping dev->lock for copy_to_user().

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jing Lin <kayano050408@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index d2e148054..d15739df2 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1266,25 +1266,19 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 				break;
 			}
 		}
-		spin_unlock_irq (&dev->lock);
-		len = n * sizeof (struct usb_gadgetfs_event);
-		if (copy_to_user (buf, &dev->event, len))
+		len = n * sizeof(struct usb_gadgetfs_event);
+		memcpy(tmp, &dev->event, len);
+		if (dev->ev_next > n) {
+			memmove(&dev->event[0], &dev->event[n],
+				sizeof(struct usb_gadgetfs_event)
+					* (dev->ev_next - n));
+		}
+		dev->ev_next -= n;
+		spin_unlock_irq(&dev->lock);
+		if (copy_to_user(buf, tmp, len))
 			retval = -EFAULT;
 		else
 			retval = len;
-		if (len > 0) {
-			/* NOTE this doesn't guard against broken drivers;
-			 * concurrent ep0 readers may lose events.
-			 */
-			spin_lock_irq (&dev->lock);
-			if (dev->ev_next > n) {
-				memmove(&dev->event[0], &dev->event[n],
-					sizeof (struct usb_gadgetfs_event)
-						* (dev->ev_next - n));
-			}
-			dev->ev_next -= n;
-			spin_unlock_irq (&dev->lock);
-		}
 		return retval;
 	}
 	if (fd->f_flags & O_NONBLOCK) {

-- 
Git-155)


