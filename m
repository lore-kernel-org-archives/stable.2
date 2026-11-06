Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965595;
	b=OTmKszPS8dIg8ZzbbDlgbhts1VBhzY1ModtU2qZLGN1yVPMUaTCJ43UzIPN5mHVgjVDE
	 whlb19TRnPaNvGY68rW/tSuXALLdhDXQoj4re/r5NejPbj8H3tzzVR6+0zv/C+1YOrHEJ
	 saKhxqzMvJpJ50DQAnSHPZzCgb4wGN9FIIAiRq9tp6GnsW5n8qlKLbqSA42f/lCt0p8nU
	 CQP9mFecAH5VC4ZO6EWTVkAiv0MjKNFcL7zkLX1VVZ0opS2w+wotwzSQyM9S/OhXuGhph
	 +yX+oopb/9/zuYj4GBSp+VWHG9IJgLq+nzEH7+Iyfc3xrY1DgaBv7wdMSYZcxz8Xu2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PW7RojDyoN5co1CXu90PKl7ieBhUmfH8TTR5WzS4o3I=;
	b=aECSXyhsxsO70jmz/FswK/dM/7jY03xg2BHftHi4T12RRryxduEbzZ9g9cnr2jq1z7Gp
	 kvfrP73IRVvYw7k68fQGhTbMHOuPgbmmvxWy129gItZ5bfDX8lLUIJ2bmMll7PGs2pDb2
	 uAEbkr+YcUQhr9SneoX9ARnoldAqA8bSOhT15RR/4C5MKepZEI+Mf+P2ZxmKDT/4qkkyy
	 jfZ7wPRXtR++0ji3iJ7oCA+KM9NS8P+Jd0C9A5LuTgKogjQLWOVEd3FXx6qeI/mDclyMX
	 bOGrHygARcN4TxOp4bKxKO8n9kEqRr86m823vgx6W4+oTzbtMeGtsLY8qT8OdZI5Bpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Vh0eTN7/";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB1606A931
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22FB1606A931
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vh0eTN7/
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so870601eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 03:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793965594; x=1794570394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW7RojDyoN5co1CXu90PKl7ieBhUmfH8TTR5WzS4o3I=;
        b=Vh0eTN7/JxSWLK60P1Mlw0WMnnGjwEufQsnkS/70TwLqJyiLgyjfzu0TzMvysjSjxb
         9A4tdCkcJWiifGJ91fFW39s6dbSNrbCvQyrf5OL23e3lOErtHxyivpLEJmJ5mFXKDOes
         POZmcdujx1Jwpwg4sGQMNAwTOCQntkckNVJ4LyUhdlLmIMadXQ+iit9qCyrnXMwJgvQj
         TFaRTCi/P5HVLdhMrSQCgRuUiQIXKOTnThoMYbiaC68EwADTAubRICeVz+ElrEmVQlSh
         w2Xv3sCTm/XOt/dvB0+SzqmwhAYSZrwLmHPLVWTMgmI1sGl/2xc9z9yAZKgSGzpsPx+i
         7A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965594; x=1794570394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PW7RojDyoN5co1CXu90PKl7ieBhUmfH8TTR5WzS4o3I=;
        b=RgUFjv5zE9TZ2WgzidPIzk+nb9D6wfeAsHPLCeLVy1PbkVrJ8PstEuBRaXUXE2Q/oz
         L2k9p+rDRkzmNRfgBuYCbEnTYfHwdOHYgj1o5DSGbEn7A/JdYr2QfXaNatcPvsHg499I
         zbOvz3QZ8C/JE9ZuZi40bB0ANKV5TNvRwa0zBdPqzdhFxR1/3f5jwdqjCC6srTpn8X00
         Lo5tK/Y3gwJKzL8XuR+ATKeJhGvascEC2/pqd6w0bxkV3b03YgS4gvkmAo2+4YQ6KP9k
         oJ2agVcrwXOX9ZFS6PlBmmWF0V2I25Pdpz9qqSDBqna8jd6p6xpa9V4QS6H5B4swWL06
         DFcQ==
X-Forwarded-Encrypted: i=1; AL+hErE8/4fvo6jfax7omZoRM8WK1H/HcbDePzwcT/0taBnwbCiPUN0GwbDbmdMFKjqyQaD7y7kNHvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mHMe4pmbAGxn+HdW6keuBqBLhOp9+vmA4KTUXS+xvJOJzT8e7
	D1BDycDNU/WpYtAllu3DO/5RQXZW9IGU69ys85OoWcX3wUHWIXetyemt
X-Gm-Gg: AYBFou2gvQ+s8bgZTq8/PY6jsJI0VoF5m5IteW+bH0IFMlIDaAuWfsmDylGSffxY4hw
	aqZQNf5CgqrRyRjdcEu85J9RxV7Z/fhvyxNjUdI6f+DadkKg4ayWpHj9m7GqaBtzIkKuA4Maq5V
	zW00f/GomuILD02UY+zXQLTcwy/Efgqn9SoClgKaMIouEp/p9OxfiOjAhIE7BHm0k6imI8TYA4u
	QzuLLq3H7No206e5m+4UXnsCkz6ML9dWZwoMuuVlZfOZyo9jsQMghh8qHM/oRitcXa18NeWVIbL
	rTRl6whXx8I0WCaXs93PlykuLE1Duwest00LomPR3l7e3gn5EpDgO35GJ7NvK7fKp7lnWmn3wf/
	y93YXqjlQAOiN/UN8YboIQzGYouiY+i+TT/79j2rCAUNXZN5KAJk+ARybXu4Jwy1r/85UQBe9XD
	VE6M+EhjQkaav/P1nWNOJiRXuRewOAqrQRJeENyOFlDKH73yCTHBO5y3Kyqim2Btthh+DTgZdF+
	11fX+OqUp75iREpZoSQqF8EZtUrBpde1V0mIYSP46cPAl0YL8vmOO2xbuYfW5FvcPq0ElD5Bm2N
	WI3kBXUx9gKVDK9jXxGy6FhgKVoCLPxWyaRBcGUhSuUj
X-Received: by 2002:a05:7301:1522:b0:35d:4e41:d2c2 with SMTP id 5a478bee46e88-36f77eda447mr2941017eec.33.1793965594008;
        Fri, 06 Nov 2026 03:46:34 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:1d31:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9be7077sm6167055eec.17.2026.11.06.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:46:33 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
Date: Fri,  6 Nov 2026 17:15:50 +0530
Message-ID: <20261106114551.212675-2-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261106114551.212675-1-amaan.cheval@gmail.com>
References: <20261106114551.212675-1-amaan.cheval@gmail.com>
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

Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
verify_xdp_configuration(), which until then refused every format but
GQI-QPL. Nothing replaced it for DQO-QPL: gve_set_netdev_xdp_features()
advertises no XDP features there and gve_xdp_xmit() rejects it, but the
core only checks that ndo_bpf exists, so a native XDP program, and an
AF_XDP socket on top of it, can still be attached on DQO-QPL.

The DQO-QPL RX path was never written for that. Its page accounting
assumes the driver keeps a reference of its own across every handoff:
gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
recycles it with gve_reuse_buffer(), so a redirect target that releases
the buffer synchronously, such as an AF_XDP socket in copy mode, can
drop the page's last reference when pagecnt_bias runs out. The page is
then freed while it is still DMA-mapped and registered in the QPL, and
the driver posts it back to the device.

Refuse XDP program setup on DQO-QPL in gve_verify_xdp_configuration(),
matching the features the driver advertises. A zero-copy XSK pool bind
is already refused by the core for the same reason, and a copy-mode
bind never reaches the driver and is harmless without a program.

Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA")
Cc: stable@vger.kernel.org
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2437cd8ba633..4e9e692a0ed0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
+	if (priv->queue_format == GVE_DQO_QPL_FORMAT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported in DQO QPL queue format.");
+		return -EOPNOTSUPP;
+	}
+
 	if (dev->features & NETIF_F_GRO_HW) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "XDP is not supported when HW-GRO is on.");
-- 
2.47.3

