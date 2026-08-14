Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA1175A8D
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786684934; cv=pass; b=B5ps5khJD0jdYs+V03cyi0iXZ08Z411DPxaOf0pNEFWsq0mwQfyqoRzOsH9SnRoJ+chc5+iwqnFBSCEkYOAj8EOpLTxgwh9HWQSrBHLDw39g/BK7BUQsb2AD5/B1U44XSCIlWJJH339uhFRro/6PGNdWkZ2jGYn5FRlTKv7oc3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786684934; c=relaxed/simple;
	bh=ohlmMtYRUDHzK2SRXr8jtcqSs6B3bzuBWR5f8Vws71o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nxO5sqiepUkqLbiqGxWXiVAjIFsT1H67pGZGPKf6kVd6Zuu3ZQgPyEYZLoIYOvGI04W6qG35gTCBQrVY6ykLUMHBwBna72DM1g5nAn54DVNEbN7T/nqpk3GkRCA0MlNP5MhkpXauZHn/tzy3x9E8ORVE9QSZeWq+iQK4dMXkQ64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDAc+Fjc; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDAc+Fjc"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52b6543169fso4581191cf.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786684931; cv=none;
        d=google.com; s=arc-20260327;
        b=bVzHLwNYcTUoyB301G6HJQIpP3LU2FSGPszfQcgZYI3xKANWHqjoTPJzje//s6rRHI
         RC8DXma6JEUGCYPWNDNNpk86B1FIlxfiodWPJYfY7tZRYm6ws8X/7Pe9ls+lpmCsVBRE
         Pi+Bxa9oWD//gfGzQ/pFzLfIs4o0b7O6zCcpDyO9mltcGkvyTLb6H+qDo5U1o4VQP9Ab
         vg2W0Md3Tmq/a204Z+B557M42oamuihMyUySey8xdgWh0kswMcCJb2fMDdUxGm9rOjG7
         XDwSJzingsLGf916h6/482TDaLJtm8gzJfy6KbDI8OXQ/HuuPEvPMR/bLsOxeODjJFDF
         ri7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3JXE+rmvpEkwSkNziwCSQtGp5waZRrqyKerzZGgG2sY=;
        fh=1LsaRJoIr59NZQdxBLSPGh4ZUSuVC4gLzgl3Ii5fmx4=;
        b=PMOki6+AmnCJ7b7wvVCd0IsbHLdGntazcc/QpG03BiVOQs7Plr5/2w6OICxOfmHWto
         A/Qp3pL9iDeB9O9A0SUcWTKrtH/CYARgSpURTJufnEVvPYVbH3O5HOxtsyTUOILF/FpD
         Eo/z80XJgosgRlEPFSC4cDpXV6GRHPoImiP74JhmMQBY6g7cd4tFIVES7oNbCPtARIBG
         ubZIXtSc2RmGiBN6K48q2HrMPC2fXpV0YjBhXpxfbgSDVu3ya60PC1TMdKQVsqWOb7cN
         QrfN+JvPf935z+6td0waSCiJKVwiD4dYol8SzVCjkgm46nRH2vH9fTE1+zoE629EBNGL
         W7/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786684931; x=1787289731; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JXE+rmvpEkwSkNziwCSQtGp5waZRrqyKerzZGgG2sY=;
        b=HDAc+FjcNeppvJc8NTCgpcC/yZXXpm5Qk6JcLBuPq0FbJT65ELvxvNJnYFrjxB1xnM
         VERePqHJtM46jtMkD7jc/uWqtaLuGYg1LWE2mU+5EwSrYvvBEMNKsRpu8jZ2jdHZRX2P
         JxaRE/HN99y15TRSJeK/6K/h9PeGfllYEOkbMJYKsjlGKG0JwK2dXHsl+7IWjrOuzQw0
         GfLnkM5ZGMmRJj3J7JjGndpOLMa4B2m0FSnwJD+t62jjmHY5MAZxkdwwExjb1Hs3R93V
         V96d5a3v3B+oPfFn118gy+5dO5ZZMbb4H4BHbRwufExTjbALl5u2CXqwIU6R7dAvwF7u
         nQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786684931; x=1787289731;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3JXE+rmvpEkwSkNziwCSQtGp5waZRrqyKerzZGgG2sY=;
        b=FMzIqwEDdySh8MpyBVsBmd4juTxc+JeKgtw0OEf4B3935OvrWC8dijQseEtEjUtAjk
         N6ukVObqgJuF53ufzETgW9EQGJwvr6EYCIlZ3xF68ciVUqvVKaXY+r3NeS0G9mQatKXU
         W1IhFWxsL4W2PTRXZaDqEl8kZLMandqgXAPu8ZPEINcUDjjhovgSNLJpU1e/LriIaz/V
         +UG3NfJy4ZvQXEwrIbkErpcKoIqKLYtYSDqBEU0VQ3VjHB8YTyPNtHs0egcBw6mz2b3E
         CxrqFT4mY+DXPCJDY7VI9Rfn5EXKyC/dRrD3ZtTc5goXEHM5SDv2yL9gdwwoRApU9FPM
         ez0A==
X-Forwarded-Encrypted: i=1; AHgh+RqTuDvfWzVeNw7MyAVc+fryoNfs3N/6ng0pSGKYiQyQBRkDEZ/+CSDwFWZYa7ph/uxOP0vTgUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkliVhb9FWL44W8UMqqSdEHqzXz9NNCiYhic4x1ASwIYL3Dc+2
	Bw4h+SSGlM0xp0HVBz+k8iZSkxcdyV3um8Zj5dNVVfWY30Fnzn87KdDQICl0Gj5zGGdyxcQ2+8O
	qCIShJSzDiyqBX5v09ALu7SKbbbyyF3BlMA==
X-Gm-Gg: AR+sD12UC2m4za6m3n5NLM7vEPHw6LXzyuDm4yNrs5vOM2nheVU4r5XD2QqIUG7YuIU
	RLeKSDEfReBG4vumGMENaY0fkaHNjBJZGaEHkx86y21Oq0ZhUFCGy8rgLzK/rtey53LsoiQxCDe
	oSC+6R69H0Lq7GYNzQOaF9geqRTCjoTSDBVYJP2bNEJyLMfeUkkOh8Hg0/i8d2LAUifZtwT1Fp8
	namkiyY94/YEpS7Vmv1yQT7a9E2AtQVJN2dzhquJ3A9K+QgdP4Vwm7ZruiO9U/TaJpv3VHh732P
	cIF5L9jbEx5UMIPJ4J1lajhQYAoKBOrqfcOCqkOLrlQ=
X-Received: by 2002:a05:622a:4185:b0:528:3882:386a with SMTP id
 d75a77b69052e-52d8534fbbcmr45236501cf.11.1786684931381; Thu, 13 Aug 2026
 22:22:11 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Aug 2026 22:22:10 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Aug 2026 22:22:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: diegomancera.dev@gmail.com
Date: Thu, 13 Aug 2026 22:22:10 -0700
X-Gm-Features: AUfX_mwI94UpPhk7GoTpsv7_OM87DrWKt8F-iw2PwKxn6igkpnk3x07qqidsnKw
Message-ID: <CALruWrVTmdRYoCQ9kh7n2KJ_HjGKhMkhX5_ybMYwCgeCJiTnKQ@mail.gmail.com>
Subject: [PATCH] net: stmmac: restore XDP configuration when reopen fails
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Exit code: 0
Wall time: 0.3 seconds
Output:
From 7691567e29d241f28d1525d99b11faa2d5831f3f Mon Sep 17 00:00:00 2001
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Date: Thu, 13 Aug 2026 23:03:56 -0600
Subject: [PATCH] net: stmmac: restore XDP configuration when reopen fails

stmmac_xdp_set_prog() tears down the datapath of a running interface,
replaces priv->xdp_prog and then ignores the return value of
stmmac_xdp_open().  If reopening fails, the interface is left running
without DMA descriptors, IRQs and queues while userspace is told the
attach/detach succeeded.

Propagate the reopen error and roll back the program swap on failure:
quiesce the partially reopened datapath, restore the previous program,
release the reference moved in for the new one, recompute the SPH state
and try to reopen the device with the old configuration so the interface
remains usable.  Preserve the original reopen error and only log the
failed restore attempt.  Also update the XDP redirect-target feature only
once the request succeeded.

Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level
switching performance")
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..c90a1eb2ed31 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -104,8 +104,10 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv,
struct bpf_prog *prog,
 {
 	struct net_device *dev = priv->dev;
 	struct bpf_prog *old_prog;
+	struct bpf_prog *new_prog;
 	bool need_update;
 	bool if_running;
+	int ret = 0;

 	if_running = netif_running(dev);

@@ -117,25 +119,48 @@ int stmmac_xdp_set_prog(struct stmmac_priv
*priv, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}

-	if (!prog)
-		xdp_features_clear_redirect_target(dev);
-
 	need_update = !!priv->xdp_prog != !!prog;
 	if (if_running && need_update)
 		stmmac_xdp_release(dev);

 	old_prog = xchg(&priv->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);

 	/* Disable RX SPH for XDP operation */
 	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);

-	if (if_running && need_update)
-		stmmac_xdp_open(dev);
+	if (if_running && need_update) {
+		ret = stmmac_xdp_open(dev);
+		if (ret) {
+			/* stmmac_xdp_release() tore down the datapath and
+			 * reopening failed. A failed open may leave the MAC
+			 * and DMA running, so quiesce the device again,
+			 * restore the previous program and try to reopen
+			 * with it, while preserving the original error.
+			 */
+			stmmac_xdp_release(dev);
+			new_prog = xchg(&priv->xdp_prog, old_prog);
+			if (new_prog)
+				bpf_prog_put(new_prog);
+			old_prog = NULL;
+
+			priv->sph_active = priv->sph_capable &&
+					  !stmmac_xdp_is_enabled(priv);
+
+			if (stmmac_xdp_open(dev))
+				netdev_err(dev, "failed to restore the previous XDP configuration\n");
+		}
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (ret)
+		return ret;

 	if (prog)
 		xdp_features_set_redirect_target(dev, false);
+	else
+		xdp_features_clear_redirect_target(dev);

 	return 0;
 }
-- 
2.54.0.windows.1
