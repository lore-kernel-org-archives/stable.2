Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844A2882AB
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356835; cv=none; b=XiUJAMQXcnVLpPyPGmvMMIOqCTGWmGIiMOu/DyQU0kSLunv3kE2/AN3ecW9fh3nAa1smeqNnHv1H+Epxm0T/enqYjghCBU2ekzpXz0p3+3fURz5G61bxSnELFv4v9vBDR+4ZfWWmbeRiYYk6KPpd12BPCO8yT4gdfr0IGLf/nyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356835; c=relaxed/simple;
	bh=HJtc1kLXDLCMyh9y6Vm3Q++TQQesy6nrVmn55E/n5d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgMgDQ/m2MdUvo9Jv9JZ1Hzfqnx+MtfEK6N9yQ+02fO5SvmrpipApdxXuTmFAeXSMN0VqGgJkN0vxKd2gQuwbv0UBuoxuXffsGeJ/dlbNoAvWSiAkpOnSlavRWHWkI1phYvXUyDfunj+F6qirz6tMMHcs+hKKM4ZZp2k3J1OO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ZdzeUSiL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ZdzeUSiL"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8518d5ddaabso1206048b3a.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787356833; x=1787961633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zYgQHC2sj0tGkOYbvf91tzomhlBCh6E8FBNBbNM2y4M=;
        b=ZdzeUSiLJBhGiu3dZ4Rb7YKY+H21bY59RIf3hn+stibkeIeKvEOn5aKh2FPIzoxdTc
         RBnstDNxvBXrjFD3KNx6Zk7YVtuFJtIgo9VrIaecVpglto+xBqlOmsazoOD5RFqea37M
         Cjy0dN5Mfln3/OeXHYSqnbiHxcuVjWqMhurevsWbrGa0j2kC3ZkZxY0P8YHqQj6yzgp8
         aXkIcz0n/VTB3r4q2WUh7xZuLmH+UHgUfx+l5cP+0V+Kkwn0PPlKvdCacLIyPejoAy2k
         RFnFgGsdKeC/1OyFm3H7+M+NT+N//RaBYB/hEcCmSpDQLsjauQm5F4E4LUsVLKPPqW3d
         7vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787356833; x=1787961633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zYgQHC2sj0tGkOYbvf91tzomhlBCh6E8FBNBbNM2y4M=;
        b=DUUL75n/yoSftwqdXMI/LLNsGywl+YWKmM0L2yIXeBkTC/MZD7sIh2XpAqq5kV9gZ6
         jPmrtQowzMk7TMG8HSPDvDEg2aZGdDEJasVGiDL/6BlbSpuObSnnT+MlyBZNQDmFhl8f
         IWNfDveoEYtKpPdjtIni15RF56Wr74Yalkhi4PMxdNcfgtWOpdr0wJ8iKghcWwIkc7rk
         yQE4JFanX3OlTx+TY0TRCLee94sjMQdLJpTFslsG7xYIg6IpI0dShOOgnr5T2wurIujy
         Pxy+bu7N0Tk03OnC4VFxm8l5LxTuyBznmLgPdJkOmqDXEu/aw1ebzmSG2U6QlLcOV+0d
         gjPw==
X-Gm-Message-State: AFuF++kLUhX2NW2kLcdB/k0z460u5TDxA6OMuJtw0n0XOWuCbTUv/U7+
	Noiiq0O1VyqRpGVXrhv1f0bbs58DIRJT1EwcJwy3r53vMIX0AUKoUabx7GIym5rlknJ0LmzxaOH
	XwMQjDJ0=
X-Gm-Gg: AR+sD13D7KI47IoiFEPeoCW037VSPJbIgK6BiwQ7LOyCm45+4ac89YJSIKkPW0SyDWB
	wutn9M2WsuqiHwNsWBun75FdkRSinrengCidAJiaPlLOJnvs+ucHdF7pQI2Hm8kljZz8pLUaya6
	0vlCAD+iqmxTpx3RBnhZ34Et1wD0wHLRVwKu8faBtTNR5+qXyJByg6OFAQWGILFVWc5ZYOJqTWd
	5itfuPtatl1VbUocHQyL+RfbOyL1ny7sfPnAf58Zt7C7VkTIq70ScsptogpZgEksdFr7R1U02Gy
	YZq5NW8vcE/3D1pjHV1UXMiuI7wai8gB3izybfmFT90orXHVHz0ALsSbFOf9AQEmbpfDoeb8ZuF
	vE5ir02rXN+SaXjee2/7IDUzdHH9ci9HVv0tMInAzZRcp4k/9G5KFRb7fZHelHUQWDpUe4z0QtR
	EvZOfKv/OztH1j6GrpR3zbARRSCHY/CtQPDGVeH+Qz9+Lvbt/mQ+jaX7KpAgPD80KPS+NeVNyb4
	6areHm4TPwgq1o24+WbnvBYiMRT40ijW/pxKgd9KKLbWsgDxUoOM8SElIFx62D9GErdVOaS
X-Received: by 2002:a05:6a20:d045:b0:3c3:76a8:c0f with SMTP id adf61e73a8af0-3cd2fdae77dmr19999183637.4.1787356832953;
        Fri, 21 Aug 2026 17:00:32 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:fc5e:9d66:f144:bfe9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm1743425c88.10.2026.08.21.17.00.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 17:00:31 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: [PATCH 6.1.y 2/2] tls: handle data disappearing from under the TLS ULP
Date: Fri, 21 Aug 2026 20:00:18 -0400
Message-ID: <20260822000018.48130-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822000018.48130-1-artem@trailofbits.com>
References: <20260822000018.48130-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 6db015fc4b5d5f63a64a193f65d98da3a7fc811d ]

TLS expects that it owns the receive queue of the TCP socket.
This cannot be guaranteed in case the reader of the TCP socket
entered before the TLS ULP was installed, or uses some non-standard
read API (eg. zerocopy ones). Replace the WARN_ON() and a buggy
early exit (which leaves anchor pointing to a freed skb) with real
error handling. Wipe the parsing state and tell the reader to retry.

We already reload the anchor every time we (re)acquire the socket lock,
so the only condition we need to avoid is an out of bounds read
(not having enough bytes in the socket for previously parsed record len).

If some data was read from under TLS but there's enough in the queue
we'll reload and decrypt what is most likely not a valid TLS record.
Leading to some undefined behavior from TLS perspective (corrupting
a stream? missing an alert? missing an attack?) but no kernel crash
should take place.

Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Link: https://lore.kernel.org/tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJXfIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=@syst3mfailure.io
Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250807232907.600366-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: Codex:GPT-5
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
The CVE-2025-38616 fix, applied verbatim with no source adaptation.
Patch 1/2 supplies the bool msg_ready that this patch's WRITE_ONCE()
requires.

 net/tls/tls.h      |  2 +-
 net/tls/tls_strp.c | 11 ++++++++---
 net/tls/tls_sw.c   |  3 ++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 9fd5867a3..c1be90019 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -147,7 +147,7 @@ void tls_strp_msg_done(struct tls_strparser *strp);
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
 void tls_rx_msg_ready(struct tls_strparser *strp);
 
-void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh);
+bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh);
 int tls_strp_msg_cow(struct tls_sw_context_rx *ctx);
 struct sk_buff *tls_strp_msg_detach(struct tls_sw_context_rx *ctx);
 int tls_strp_msg_hold(struct tls_strparser *strp, struct sk_buff_head *dst);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 32b57e574..be8a79960 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -481,7 +481,7 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 	strp->stm.offset = offset;
 }
 
-void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
+bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
@@ -490,8 +490,11 @@ void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (WARN_ON(tcp_inq(strp->sk) < strp->stm.full_len))
-			return;
+		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+			WRITE_ONCE(strp->msg_ready, 0);
+			memset(&strp->stm, 0, sizeof(strp->stm));
+			return false;
+		}
 
 		tls_strp_load_anchor_with_queue(strp, strp->stm.full_len);
 	}
@@ -501,6 +504,8 @@ void tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	rxm->offset	= strp->stm.offset;
 	tlm = tls_msg(strp->anchor);
 	tlm->control	= strp->mark;
+
+	return true;
 }
 
 /* Called with lock held on lower socket */
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5eec7c10a..c923b7dc6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1510,7 +1510,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 			return sock_intr_errno(timeo);
 	}
 
-	tls_strp_msg_load(&ctx->strp, released);
+	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
+		return tls_rx_rec_wait(sk, psock, nonblock, false);
 
 	return 1;
 }
-- 
2.43.0

