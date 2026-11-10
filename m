Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285009;
	b=kob6MCgHrw+s73zIKzQuIkeyvq6Gm7Zp46DgKMymTPbvX4VBY2rWwZus6uOmykYruN5i
	 IinW40ewFgLBuF6bW/0MLzk8eC0uwRA+AwibosRO1Ftv3L2SzKMUTdmmCkIz3jXl30U+H
	 45/wrL5KQJvrLWdg/X0Lf0lXhwiQ+ieSab17rBtMBpdDnLSR/u0xixIpN2BHhjOJgP6dY
	 HzAYVLWaiTsk8afMCWrfnMDyLPpZP1nPK8RNuJGWYyqTQeukACj59EEyXbofxK21l0fvp
	 Sp76OoOeF2rqMIPOjrqyqTrTg8Dx7ttehbzdfee3Mrlt/eS4+BU4D7YS65epxBbGNyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mc6rPhZtcy7thF6jBsEppMpKqkoctKS795gM28YkdhA=;
	b=Apny132MIgDJIuPtyPCe7rXW62e7yhB5+SxAW44NDepYKlEd4OXGw5Falj7v15mTp+Ej
	 xnHwquCXgEbAllqdjPVY7hdYIRbeH6AXe5IzqRVXspp6BcsZDQQrhbEiwDih8jUvlh1Bd
	 mEHCX37vuTIpQ5VPgpzwSQbFgge7cmeSu/CSkUV5zHgub6HNQXzwOjtxTSOIYrdmCWrJZ
	 WNxiji5z9fImtnbGN7k1TyAl9uWFlSZlEGWTeXSiAXreriOueTLlb6E6BlxjjTaRU4nql
	 sx9dgi6e+/M313/aoaFCMvK1bBeHqYpk8pWUK0wukP7wAGiuFMJMM4yuQb4NI4/1ayg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw2goD4R;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F760A2602
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 298F760A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw2goD4R
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2b8cf037so143526485a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285008; x=1794889808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mc6rPhZtcy7thF6jBsEppMpKqkoctKS795gM28YkdhA=;
        b=tw2goD4RZ/2tu7CCKcYLAvxfmyz4f4QYQ8A7OsaW1utqAFZAgbziDtsVqBNMvlpGET
         Te/vSDKbzo7q34BTmS9Pv5r4ds6z8orc8yvXnA6ne9M0GHXvP2jb9nbUY55IHFTrT7aH
         Wq3yVa1K4rG+nWmTA2nXQQfVW/rBtVkwjcx1INqPFxby1BShW16l4Z1Q7TGDYB2rfK1Q
         waw083QR7XlXSD5eolV1pZnKaOjXibjWhvN8JN0q/bZ6GgIh0zQgJmKQc9/26bM9rx35
         1HMbOchXb288maFkZD7b1GCiD+a3RLsvXYpMVV0IhUZevw2CPeddi2Ya68FZnklwUmc7
         PMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285008; x=1794889808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mc6rPhZtcy7thF6jBsEppMpKqkoctKS795gM28YkdhA=;
        b=Iu/oNV2OutR2j3OceoAPoXkp/PuFCHWjuKw4ybLAMbNDC3vac5R7xTg99gjU54UON1
         lJMxcFwNOk3p6JxxHa7A1U0KP7hjt6r0DuEk+A50Js8UJr/o/gfnFD5ZRZ5Jwjygo5RT
         mt50Is8CA63FvC1O5F2v9NFTSkZ01aCyEK4I50H9uZFnwdjx27XXG/6PcPvpKJBNPwOh
         c+x0xF8wHe62HtOH/bPNj5821Qa49Exg8u3igkkLtD4m6qK4KTmW1VWOlATxA6yKct3r
         4p8Bws/uxfzmg40+CLNpEW5Iin/pE6IEO641HtUwzbnVfG5C0FElbwyUKVjPSTNSSamU
         AARQ==
X-Forwarded-Encrypted: i=1; AL+hErHQovqSoh60507niugyCwT7/MziiP6gcz59esXvFrbS9DKb0GLVbLgXrBYs0Cvekdh2b6dspa4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h8s9XAfYgIEU0hqdCjTEsIXgVPqJ7tguTzBJ9QyqPLr5LQ+vr
	aXfJZm7pPFjp5wn2jaeZuuU/SMEzfCg7rcc1eFOy+oeahk/hTX2qnEw=
X-Gm-Gg: AYBFou1CQ2P0y5jxpl1NKmFDnifBkg5BBPigRJidjea8+9X8ibCn1voLoV+ZbcQ0hNU
	A/NuwwXIgrPo3Hynimh2U//T2cmP5phcKJruVuY8YdgQsIfXKW51gGiitXifIcQbCJIFFcqTrOc
	8YUyG8u8cGX0lvy58Mk1DWGBF8A+c+VZVhz1F44rWGy2+9Vj7SKOxq9t+oUeLWQmwBwKK3dLsuU
	jyGpjbxrHcsxQD7n5YxiJvZKdrlm4hHr9B/K8l5pcT1LVcC5Sk80jvKWNEY7i1nrAwDxqOSyCY8
	H1TijhvNuCPYt/TuzbvWiF70r2CBylShXo0qRaFgnENe3wvTFXS+Mh7oltwwWHVoV5RLqPF3T4T
	lk2FWjPgMtHlG3ron5LrNIvk5X/e08s4h0yOGUz0U9luFYyKBRwOW+B3+MvfBEP08p43TbIzWiB
	MclChuF6hXVflCxFHAur6V4ajEQoO6i6aMSWeyzDZK13k1jeuAgrvsQe5K6NIzcbMTOBzrbbXeG
	2AbdMyPhAuFGtrdT0KaEVePEnvOlOiopp6v39roZQUC7uqDAO4CSliJsMLA+M1WdoKD1Y2IXvE3
	PYn1/zeVVhfgdjMcv5ALJQVgiL3BL+OoxwqRKZPkh62GZfJPV3531IZFsID6gvZR2+EYLAM1Qbb
	3DeWaGQ8Fq3V4wy0fxkhtqz3PVpGpvzxhXFT2ggFXgS/fQlJfCgvHG+0zsbo7PhZw
X-Received: by 2002:a05:620a:6496:b0:945:d852:1618 with SMTP id af79cd13be357-9479f3eda61mr223680085a.70.1794285008081;
        Mon, 09 Nov 2026 20:30:08 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73b2d2sm134917585a.10.2026.11.09.20.30.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:07 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: wwan: mhi_wwan_mbim: disable rx_refill work on removal
Date: Mon,  9 Nov 2026 23:30:06 -0500
Message-ID: <20261110043006.56681-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

mhi_mbim_remove() cancels rx_refill before wwan_unregister_ops()
removes the links. Bringing a link up in between calls mhi_mbim_ndo_open()
and queues the work again. With the MHI channels already reset, the
work cannot refill RX buffers and keeps re-arming itself, eventually
running after devres frees the context.

Use disable_delayed_work_sync() to drain the work and reject later
queueing. Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 336f89756f10..3b6b0066f673 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -650,7 +650,7 @@ static void mhi_mbim_remove(struct mhi_device *mhi_dev)
 	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
 
 	mhi_unprepare_from_transfer(mhi_dev);
-	cancel_delayed_work_sync(&mbim->rx_refill);
+	disable_delayed_work_sync(&mbim->rx_refill);
 	wwan_unregister_ops(&cntrl->mhi_dev->dev);
 	kfree_skb(mbim->skbagg_head);
 	dev_set_drvdata(&mhi_dev->dev, NULL);

base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
-- 
2.43.0

