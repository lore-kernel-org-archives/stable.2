Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785253;
	b=JMATKEFXd/LiD0/Ru3ghrAUhQB8q7Ql1bmqjxzHu77TGu2jC+4fTDIN22Wq6+9IMa67b
	 6EgkPT1pXhZk+u1LwhhVeUkwzAEnSS+gfOIe1s3JqQvs0JbwtYWEUF5jpF5+0JJlweBAy
	 av80aZCW+IHTiwX6Q0/v8xW598CpY0cwepR/VRP3L46sqfqvnpSF7n0G9iBgtpjDlUJ7w
	 GqiWQwLI1XJFoiGY3asf0BQob4jk4VV7oWR5ZB7dyGE1w3N+BguN9zTSViHHLeO4VkOUC
	 lvoCKCnVZVzN5unrt01RYLgshls6r0oPWzBPan/VWEQZOYKgF3axWop3QKalzFUr+sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OXHww7JRwC5sR22/HTGUO5MsP2p4PTlezupZRsfe/2E=;
	b=jFHQFppCv0yDvFw1z315Jxu29+ZqLF2xDFbKAeLOKVn2evmKI23Spkm/Tr8e+XNcC5OS
	 kleb44uuMFDQYuWWM5Gxpr7vEj7iNDdrBMzGZGNdLfQkSfOJfpQ/Ay+SyE2gcmmWkqjfT
	 ywayiIVLcBPqdXYGAkSUGWmkgHBKZPz7iOU6S8f6ttPg8rpphTQloea+Phtfg4Yuvzw0U
	 VAetm/28CsX819FBmnzhZLzku3hKNFo+Y8BPv/IVbDW+x03i1zJ3//v2ekIhmfxypTTTC
	 DtFtkeuEAbfio/ajC/6iC/0iHzJPlS9K1CQ0g6SvqVjhwal/SRAuWjR8oWsg7VyaMoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kI+bwye9;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7043606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7043606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kI+bwye9
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so11573085e9.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785251; x=1793390051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OXHww7JRwC5sR22/HTGUO5MsP2p4PTlezupZRsfe/2E=;
        b=kI+bwye9oXV5c/UPK9Si+6GyiMnjIXPLtvfyZzQpz+Q939kTlUyL6rL86QL5pmt6oi
         g9m+6TZJjPi2qYdf7LSBRW6UXARhfL2QavUv6VLzn9wHYYxiqBwY8gIaHkYQLfoETy4r
         oQFCFX5kOWGs69DQCo5P71VZ0rYS+Z4ZjPjvSpI/+DYMYfpCVfFUjJNkyB0EvZqRU2m9
         m6twM5210z5v4HpDvUk+gsgw/Y42Rs0lGzjcuMxzNniIkVQVZ+pkQLEEiRXMoaKiDBkl
         yiTYjOO69N+Z209H4JgtxK8W8Cz8M4Vqk+hyhjo3SoQ0dmSiD+XuIkjROsQuhQuPmK7X
         P55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785251; x=1793390051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXHww7JRwC5sR22/HTGUO5MsP2p4PTlezupZRsfe/2E=;
        b=iV7KjKT3zX9giXWCTlNgebfbWHtiGaxPtGv46qnVWj20T0hp+q7vmeN9fABHK2tlcy
         4xbNGwccIf06sPe9w6dpYWs/20FEx90P2HVJnanTk0QP2Uz6T4l/E6vwEizHSJtz7gD6
         9nH+hjq3TypIZkmaSA0S9LHc5k/alcnXRYcMpgHX+oblFTglClDzJKH2DXowK/jDD6Wi
         HuaDhrORTp2Apd/6ZKTRTwHvOk/mSIW1xK1PIulA1X1F+hpy4V9nbLfubvFG/1BO17PP
         bmM46zvulMo4CY+GdgdOamMeToQLU5EJ4ZVbKOQtzbw68PfIfkeaGaA3nHSVUEz/NSnO
         TAqA==
X-Forwarded-Encrypted: i=1; AKwUvBwaUiwzVHH515S7vDhABqLKAUEvV43dGOB5SWGRtBr3t3EZb1xanVwHOIol50uVlT3tdC5GrhU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl6DNMQWdKmiWptoc+DHXJ39etAkrLB3pHjrDYD0n12s8Y3lzG
	D2Zd/fz8Lpk0YW0JSWGjm4NASjxaPcdh61EkoQxVHYUHLl6mBL41v9U=
X-Gm-Gg: AYBFou1Df2G4V+X0yHTDFCXxwq85+CmEGfYZjra2Gcwl84AdbtlL8F3nmx0TJX4F7YG
	JmmntF93tu4b+tZy55JeEtk2esMxhpWvwIo/3UzZtecDo4v1WdU89L4F0T++5XX/T6g8XsbwfjC
	uVH7E9pCxXChTqZ+cintcRdBbpxdRAj3TpDSy6sHfNySqprMUWQ0/Tg4qxnOt71HadUHW8GHUJw
	xCRKEqjh2mD9cOie+BJd0ln5VcofeZ6fEI22xq5E1jX+XqLHgUhwk/pI0QzQ4ychrdp303jxLE9
	JL8BG72GcPinIPuhuwd32imL2JsfjcS3KJ6YB713Z/DanJwl1txSdRqNfqaU9c7ub7JO/IdpcOY
	cW8/+lEi67wi30Efx/6UgB9Np+hcZxilStY8ft5kPcUM3tKUSDpuZibavJ3U3JgNX1SRqKG6YUq
	+sLQi1lUOYPH5+Jc5KALMBxXCv0WvlCSIoNHTfLTPGWCkGBJhHw8WsuTfpnVhtl6puyI7T0wmQE
	eIPPeBRDvqGh+sBLP2uvsRN
X-Received: by 2002:a05:600c:c170:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4a2190fd130mr29520455e9.35.1792785251101;
        Fri, 23 Oct 2026 12:54:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm3346915e9.9.2026.10.23.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:54:09 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer rearm
Date: Fri, 23 Oct 2026 19:54:09 +0000
Message-ID: <20261023195409.3532540-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

local_cleanup() uses timer_delete_sync() on link_timer and
sdreq_timer, followed by cancel_work_sync() on their associated
work items.  However, tx_work unconditionally re-arms link_timer
via mod_timer() when it runs, and sdreq_timeout_work conditionally
re-arms sdreq_timer.  If a work callback executes during
cancel_work_sync and re-arms the timer, the timer fires after
kfree(local), producing a crash via schedule_work on freed memory.

Use timer_shutdown_sync() instead, which prevents subsequent
mod_timer() calls from re-arming the timers.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/nfc/llcp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817007cf2..a098d72a15ba8 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -173,14 +173,14 @@ static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 static void local_cleanup(struct nfc_llcp_local *local)
 {
 	nfc_llcp_socket_release(local, false, ENXIO);
-	timer_delete_sync(&local->link_timer);
+	timer_shutdown_sync(&local->link_timer);
 	skb_queue_purge(&local->tx_queue);
 	cancel_work_sync(&local->tx_work);
 	cancel_work_sync(&local->rx_work);
 	cancel_work_sync(&local->timeout_work);
 	kfree_skb(local->rx_pending);
 	local->rx_pending = NULL;
-	timer_delete_sync(&local->sdreq_timer);
+	timer_shutdown_sync(&local->sdreq_timer);
 	cancel_work_sync(&local->sdreq_timeout_work);
 	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
 }
-- 
2.47.3

