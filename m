Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BEE33CEA8
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096399; cv=none; b=Pjdi40htrUCraVcUfI2r9edeDYPco2ZFs4BdpN7qwm4WzkdZA2J06sSJGOGZLsOGcWWXDKCakYnIT584Vh3r81HIJiQGVWILR41sO6JNZa6DPPNWXcB+RHGq2FtEZkK8gadHDgRIA4k1/BIIDhXOHj9NCCcb2nSqSFiJpR1+fkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096399; c=relaxed/simple;
	bh=lSHEsIRib9siXBZ0/PV/c0AxkrP1+Nibueemuell8yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9yKKEdsFOQ6sKitifFtXa8SmohRGhyfXxoJK6m3t7slUiIluI/WgxvNM+MTrCLFPNc83KAU11Ayj04acuIJA6Nl3z1RAFXNSLJN2TGH/chZaXQxBagYbLZ+7W4I/yZ6bEfLeuakJU7BnkMyT7SvuxYeDw45XdwzwaiJ2/FjeFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=LqrNyFVC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="LqrNyFVC"
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 52E813F16D
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 23:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787096389;
	bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=LqrNyFVC0zAjn2j/l1LK5F96UTenoLR8xl7MEsj430sHCRC0g/gqk6cAcANYV2MiD
	 KK19nCnHX6MWX6IQ84nYy6xGMadrAk1Rpz2XmTRaIJdp+IJYsjkHVlzbgoB+GnqqoQ
	 +5tN7cWN6OZDrnhdXscc8c8iDM58kKVfhb0+wOd9hdzuUPsiVsg5pdmLz3dE4COzSu
	 k5riYarll7R4WxmbMQ9JQ9DmpnaAsQhL4hWXonpOsMV6h3vtE5V7g/5Tmf8hkOJ3M3
	 6r+eqWZwtfXSnFTTw36Lf6TSD5qfmwNwltNKi5cXRf+CFdcUA8txd1y3lD5Cwr+tKz
	 JsOimgoOBQ6Rg7eZpAHO5hO96VZjp7T0whaCSJeKCB/C63rn2TqCbRDchccWdz+jsz
	 uC7dwrcc74NuVWsrvK0vbumymICxIqDpTYsPaWWOvFdDcg0HnG6F9xVdRSlKgzj+sK
	 PdZaJ/xEqL9kvDanVwIjxR0PDNht7ru22L9vFfPaZTofexJpsxhrIkojgWN8hEhUkX
	 rYVGEmVfxWvrGmDmChpLgeIwKz5MikYEY7gfmDekp8cw/K0lBhh1R42w2ZQSMfCqAC
	 munC4/8ssJxIKzfxZ4SXwksz8lGOvJqxuqYIEod5SmRHzzdKbifv53TL1wZPtMV9n3
	 YHkw9GQIV8nD+aNBPqATdUkQ=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e71be771cso40498067b3.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787096388; x=1787701188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=14nD57vBDEhsz0A5DXNuyBynoXCz6QiaxnRUM+B2EAE=;
        b=Tg8S6oRUhtCfCua88y2hOgxw3FIVOMDOo4e5WpNjS3gdHJD1b5A6iYQb6mENEHHRbk
         ZPO/RkV5mR1zombRdk2m44EIka5PGgrYW3xgp8OXwFMpLY9VHhspiXBsD+Kjp8kq6DR8
         BwiQDRm/m1JYcon+S1WVEadgjdg5/uawpAy4Aba+bcaai5Jpky9WCPiXv2NC3UKnjTC+
         Awv2XJaNQUoVFunFt3opGPBUAskGrEHytbvp9ZM3XAQg4L1PmEChOLUgZDl+uO8vexwf
         bBxr4CgahO9UI+GyZTI7YHGoxbXVHwopR834WJSCV2XZa95cnMsS0w44SFlvWcSmrNQ/
         fcSw==
X-Forwarded-Encrypted: i=1; AHgh+RpGAWZiYlZ1pkOHnXhLfdkkx/ubkrU9AO1iid5cZxowwA2As1vSg03t03V06Mj6b5Jqvd1BHAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9E8K3uUsYlRNKdhtpk92c+7O+poI6R4irPDJhWn3sz/pn/le
	Bw5tsyJVoeeoz4esyEb/PbZdCK5FIEIdRXhziLAQq/4zxXQGfpB57C0B7gF0uCjlnMkWDwvzyUy
	tvjniLOVkMhkTmmu9KgzZ4ozcmBtSK1EH00Z8dX9i0tyx8gt4HYl5Qc1DjhVtFHcemY2D4waFfQ
	==
X-Gm-Gg: AR+sD11S0H8cCPGMwuHk3T44JpMZH4u3tnu2l3+xSW+bdlgEhp7/N0iDFsRze9VKBHn
	bK8JG2bPRLi3PS4p0eynqI6JD/kcFK2ocYvY8hlmotdXjClE3gYxMDaa0L89Y0OAJ4p63MB5Rwa
	gIS1Wew4Of84npla/vtyRey6PU6ZSf9xLBcbKXd9TXyGtjnjJgXjyQ5FVx2sAZagY68izWYTXmn
	d2ReCRkh3UTyeNFjEzKtNe3j1ugpWSXQWb9ki57T00s6/a2UT0ePQfHewt5B/W+q7ddbbe0vmP3
	6nzQv1GtWdy2+leOz3eoEIlzYgTN7JeffSldaHtUx5ttqT8VJ4ck84HsH1AHcdb2KaTF/TaEP2k
	3SGcwhBjWikNKL7g=
X-Received: by 2002:a05:690c:388:b0:81e:c500:c6d0 with SMTP id 00721157ae682-844dcf4e90bmr4612287b3.0.1787096388209;
        Tue, 18 Aug 2026 16:39:48 -0700 (PDT)
X-Received: by 2002:a05:690c:388:b0:81e:c500:c6d0 with SMTP id 00721157ae682-844dcf4e90bmr4612077b3.0.1787096387831;
        Tue, 18 Aug 2026 16:39:47 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4bc4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8451954f228sm662277b3.45.2026.08.18.16.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:39:47 -0700 (PDT)
From: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
To: rickey.castillo.valenzuela@canonical.com
Cc: Jordan Rhee <jordanrhee@google.com>,
	stable@vger.kernel.org,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [SRU][N:linux-gcp 2/2] gve: fix zero-length skb frag with header-split
Date: Tue, 18 Aug 2026 17:39:33 -0600
Message-ID: <20260818233933.18570-3-rickey.castillo.valenzuela@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818233933.18570-1-rickey.castillo.valenzuela@canonical.com>
References: <20260818233933.18570-1-rickey.castillo.valenzuela@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jordan Rhee <jordanrhee@google.com>

BugLink: https://bugs.launchpad.net/bugs/2153950

When header split is enabled and a header-only packet is
received such as a pure TCP ACK, GVE will indicate an
RX SKB with a zero-length fragment. If this SKB is then
hairpinned and sent back out, the GVE TX path will emit
a zero-length descriptor. Hardware considers this
an illegal descriptor and stops the queue, causing a
TX timeout and interface reset.

Fix it by not adding the zero-length skb frag.

Cc: stable@vger.kernel.org
Fixes: 5e37d8254e7f ("gve: Add header split data path")
Suggested-by: Praveen Kaligineedi <pkaligineedi@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20260807224315.234152-2-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(backported from commit 6bf14575c65569dcded90ef78afb8a6d57323f04)
[rickey.castillo: Fixed conflict because there are some missing commits
 that added gve_free_buffer() which is needed to apply this commit
 clean]
Signed-off-by: Rickey Castillo <rickey.castillo.valenzuela@canonical.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index e6decc0e7a30..51b0dfd9c6ec 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -811,6 +811,11 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+
+		if (!buf_len) {
+			gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+			return 0;
+		}
 	}
 
 	/* Sync the portion of dma buffer for CPU to read. */
-- 
2.53.0

