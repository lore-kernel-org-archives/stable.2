Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385405;
	b=twgWd+jRM6ztpHJFJOqyhNbACf/NsdHjLTwJcbOUbJIl/sGLQXisovTzmHCJzRT78jck
	 k9nT8ioS76JF3WN2AxKM5/AhmRylAN5l4tf7WGgA5y6CbuUtfjI0jzL0vbWntjpt7FlRS
	 x4ot0106OR6ubfx8O3LFW2IU4XDLX2+JySsVBpe11ptPq/1m7XzuKfTgdr7W36KiFAfFI
	 NnJnIZztMkNXJRbfAXADb4h9yx8V0QUxE3UrSIEnNJU/bFI41WvoA+jRLDoh8QlLx1yMB
	 qVlwVijHqs105UeXfBwNGfnhG4fMRT+1YpXlFJnq4evTsEKnszbRRIeJ95NPcT2V07w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q7WNoDNvK27nmUs1OscOlkdJptRoBsF44ZsXFn7l1eA=;
	b=dCqONXWq+EgTF6DYekz8l2RBglAv1QnRVYzVKVBquSJ1wxENUS8k4Rm2UhL2e1ZLxRbS
	 FL6bCVHMAk9x5YC/Mrm+sD7/tdRIfYwunKJmIq331qWjLl7pGauBvydQEAtWBK4BaMtER
	 gGHCeRcy21e5ksSdVGiXatUZEU8Q0QKXhHptsSMVn4HILOlnklK/fR1eyoV6mVUFo7OVx
	 ATCrFGUBJr/EvYbgCWdFybfv+E4PTB2QPAyvdcpqIoobXU1Zmev0kK32TjXToft9TwseT
	 iVCvugI/tHsH69IaSrRJdpZxoger5J5764gaIMAH8iVVKf3NtM+3PK+1IdW8eywbkfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGqefc3N;
	arc=none smtp.remote-ip=209.85.210.67
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7D606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E7D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGqefc3N
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-854e904005cso1837414a34.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794385403; x=1794990203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7WNoDNvK27nmUs1OscOlkdJptRoBsF44ZsXFn7l1eA=;
        b=mGqefc3NCxerrmYCjjLVfZT0mIT5UV90VtP0gRC7dXQKyP/reZlPLbjZyQzSZuOOiO
         iumhvcJGZEbx8jFYMr6oTuRXXdUyikQOINICli7utWsLokxwlckuh9OLDWKm/Egmu8+1
         ywhtrHxx2XRqa1dQVCvWfzQZVuhTFViTynRuR+Z6Xwti8yO/hVmLMLFgdx7g1UDz+cCq
         KivpOz6YMcrPaI+GY7FQak6ObCPeWFEm9ftG7jAQsHy/YlVDG6G5qmszxW1gcaf10T37
         CBdHlMAguWXqv1I41VjyVKdeocbCfhCqFL+wWxgwHP6s93JsAEMeS3i+mXurOovwdFTs
         7Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385403; x=1794990203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7WNoDNvK27nmUs1OscOlkdJptRoBsF44ZsXFn7l1eA=;
        b=m36J+L91RhZqUNmi2d/UAdjxE0XthKDs2J06wknVCFeyrzS0BqBg+IO9SvaiM9632v
         +az4xFBBgLjOjpiso2DS4gdBh7+jonpv6CnzGNv9nv1SwDW4Qdpi7za6BVmMADTeOTG2
         9a5FEveN+qr38QxNE6IUu26vXD/0QY9UIvAzk6TycfUk/WmphYSANM/YND6bTwwVcBmZ
         cgXe5iYEFHPdG6XjZdpZwn+rBZYvAtBi5BjtJH1Il/CpEoYKHir94qgoH/wuLRQh2qGZ
         CAIDcmFxkrhcQQVvBKbnM3uzlomFHEtIL7KeCHzDmxkcDJ0wpQXL6obld5J4v+APL3aO
         DN2A==
X-Forwarded-Encrypted: i=1; AL+hErGwZuGDkTVurUJ1Ct7c/Z3CkWG6RGSfuxxzGMyvredPdETRyy/c9BxRa3IRSilDgdkv582O5aA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tfrA1Pw5nyxJ0O1ZrwvKgq0Hcp46hKK7KiY66xSEBEiVPLKix
	p1dTsqgJ0NpZp6Xucdevz5LjzEyT+zxBU2r2XkWVwy3l8WCIzt2Kah0L
X-Gm-Gg: AYBFou0uAk6WdIelu+lrAQUzKZfcjkn1i0BRojSPrAHRU83mjxDRx72vaed4y6uFMP0
	47J77ZR++M11b74rA1up5TQxZ1/GdsNMfb+VXouUnNgRDlpDZyQTVfmPRnH4EMpzsk12W6tYMQe
	TflS4cPkabP8+kASsOKIviMJjW/8u8Kx4ccciSjJ+v/1WycpKiMoEpvD9zP1WjruD4vHSZku1Cs
	TT7cgbm/K/eBqRD8ataVbVXJUd+Y7TXXDVG1T/c+sxE/AFYWaiWQ6X1LR53YjGiRPHHD0HaSia7
	x2KOoFMqZy1RxN7BSiIxLqdf8es44uUXLctfxQQ/GLF2guPIG6QTqpTXlCCVSzNDTadYti8/hZl
	7u7v5F7F4xRx+8O8QBS88tjjTiFuleLLeKWX2sswGyLTajGFYoXIGop9GBxdG8DVhlRAeEtNkFd
	IJ0M+oi30wuzrjPN2MGQf5SDT5ErtRP+NL0WPUtK+HcxkcgW4Q6SIIMiKNt5Wc4HOLlaPg9wU9J
	+IYvp3J9iN2JUu3QudOLUIBA8Bafzpu3IeJPCohENdba8fxWuGrdOpPsGqljmndWergpCIsTuof
	cyg7dnMal03VVzI3O/AKx91IGpWn39PmfILfNOaRCmRNqaPh0aPJYNqY5bbKk0vF2Cv5
X-Received: by 2002:a05:6820:290b:b0:70b:930f:9a9d with SMTP id 006d021491bc7-71915c19d90mr1375796eaf.31.1794385403379;
        Wed, 11 Nov 2026 00:23:23 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbfa976sm4056000a34.21.2026.11.11.00.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:23:22 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	edumazet@kernel.org
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] sctp: fix skb_over_panic when adding addresses with a pending delete of another family
Date: Wed, 11 Nov 2026 16:23:13 +0800
Message-ID: <20261111082313.1606366-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CADvbK_daN6zZNPckkGh=r70ooNwTz59VViJy5jPp1w18SDPrzw@mail.gmail.com>
References: <CADvbK_daN6zZNPckkGh=r70ooNwTz59VViJy5jPp1w18SDPrzw@mail.gmail.com>
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

sctp_make_asconf_update_ip() accounts for a pending DEL_IP
parameter by reusing the length of the address being added. The
write-back side instead serializes the pending address itself,
with its own address family. If the pending delete is IPv6
(20-byte parameter) while the added addresses are IPv4 (8-byte),
the chunk is allocated 12 bytes short and sctp_addto_chunk()
writes past the end of the skb. E.g. on mainline (05441d697f7f):

    skbuff: skb_over_panic: text:ffffffff84859c77 len:392 put:20
        tail:0x188 end:0x180 dev:<NULL>
    kernel BUG at net/core/skbuff.c:215!
    CPU: 0 UID: 1000 PID: 379 Comm: poc_sctp
    Call Trace:
     skb_panic
     skb_put
     sctp_addto_chunk
     sctp_make_asconf_update_ip
     sctp_send_asconf_add_ip
     sctp_setsockopt_bindx
     __x64_sys_setsockopt

Requires addip enabled on the endpoint (net.sctp.addip_enable=1).

Account for the pending delete with its own address family, as the
write-back side already does.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v2: move the pending-delete accounting out of the length loop and
    drop the del_pickup flag, which no longer guards anything.

 net/sctp/sm_make_chunk.c | 16 ++++++++++------
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 90de272842512..b8e4db81636e2 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2870,7 +2870,6 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *asoc,
 	int addr_param_len = 0;
 	union sctp_addr *addr;
 	int totallen = 0, i;
-	int del_pickup = 0;
 	struct sctp_af *af;
 	void *addr_buf;
 
@@ -2885,16 +2884,21 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *asoc,
 		totallen += addr_param_len;
 
 		addr_buf += af->sockaddr_len;
-		if (asoc->asconf_addr_del_pending && !del_pickup) {
-			/* reuse the parameter length from the same scope one */
-			totallen += paramlen;
-			totallen += addr_param_len;
-			del_pickup = 1;
-
-			pr_debug("%s: picked same-scope del_pending addr, "
-				 "totallen for all addresses is %d\n",
-				 __func__, totallen);
-		}
+	}
+
+	if (asoc->asconf_addr_del_pending) {
+		/* The DEL_IP parameter is serialized from the pending address
+		 * itself below; account for its own address family, which may
+		 * differ from the added ones.
+		 */
+		addr = asoc->asconf_addr_del_pending;
+		af = sctp_get_af_specific(addr->v4.sin_family);
+		totallen += paramlen;
+		totallen += af->to_addr_param(addr, &addr_param);
+
+		pr_debug("%s: picked del_pending addr, "
+			 "totallen for all addresses is %d\n",
+			 __func__, totallen);
 	}
 
 	/* Create an asconf chunk with the required length. */
@@ -2917,7 +2921,7 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *asoc,
 
 		addr_buf += af->sockaddr_len;
 	}
-	if (flags == SCTP_PARAM_ADD_IP && del_pickup) {
+	if (flags == SCTP_PARAM_ADD_IP && asoc->asconf_addr_del_pending) {
 		addr = asoc->asconf_addr_del_pending;
 		af = sctp_get_af_specific(addr->v4.sin_family);
 		addr_param_len = af->to_addr_param(addr, &addr_param);
