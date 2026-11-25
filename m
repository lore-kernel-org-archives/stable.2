Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603226;
	b=MIQUikazllnLMSZdV9tAjkW4BihBJu10HgNeDQ5WyYQbORQ9xEiCdaogsMe4HDj6/csd
	 w2sDP1uuYZsVkuAK88b95A500/vLDh1hsoNJKtw4Ma0N/s68RxxJbFBgSgKXWb/GHdY1T
	 JDMr68DHZK0gJmIoYUteq1y55bsblYXr1FX6gBXmUy3ZUlmgJvQkXBp44RRfmiaGAB5TE
	 NQHGJE5ZCmEP9mI4Ld3snnHtFSp7RDrKtEWRcMHADC3nFGOrAqHLbC/KxhzCbNswJXoYd
	 5UaXqec/QdLSY2XQJ1PC8AogrbELKm4HHS0aY334lxHHsptfmfiRMiCd5SlE7boZDaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VODHi/MLpc+ZtHryROUioFLiF8Foji+sSV/+pxzQ5oc=;
	b=l/yBYuhtIN8SQearfswaPX7V2ptPVUdNcPr+q3AF1BLnv/ZpfxltWAfMMwXEz63t2zLo
	 SKh9oGqhQQE6ODCjGXFMg+OuQ6nofFT7eepzRRVsqbW8fbI+suYJlQvBAZrSEFLpcY4U1
	 xQBBcqV6WNwzO4M4OEPL43zjgZDPK/wHN0xpURUzGsw8P2uyoOFv9SNBbMpqWe48Nh0AH
	 5VnR9qpdh3UNWQtOncEPuUad+Hr6wYi+KaQp04GFEuspPqbDK9+AVuEWSrHy2RxJc69AP
	 4qiQG+XREHDnWERjzN6Md3gwvduw/aks2X/nnbmiA8aKyGwzd2g/DnuNFnUHPqWUPqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LsThTw8x;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C4606A33E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C18C4606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LsThTw8x
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso55049665e9.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795603224; x=1796208024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VODHi/MLpc+ZtHryROUioFLiF8Foji+sSV/+pxzQ5oc=;
        b=LsThTw8xTGNyvxA8gN17/1cV/qPvJ7KLNKXdvjQSyrrKNuAZcGTUMhjuu6p+zA9MaY
         yxtTy6+DfYYAZshj/VEKgNtdKrx/am7T5jvodQG72zD1v6tPkvyhapH5KpzEYnKzLSmN
         KSSqhIuZAxKKR/S+eogQGwkrJY4/Gms3h9H7APc6rNp0wzTdhvlPwtcW/YtrvH9yXVya
         c40uGvu0L8wCeYSgS4Ae/x6MG1ietvBCrq4s3Nm9NaOkbpfUTg+gUAE6T3kgq31yHoeu
         ctho7xQkNSsoclcByDqVlz/xt7NXLhK1J5z8a5cagniKEUQIxIuWwN4RJvfmoyRKu7mM
         e88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603224; x=1796208024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VODHi/MLpc+ZtHryROUioFLiF8Foji+sSV/+pxzQ5oc=;
        b=jUpTjt8CFi19omaDmnU2dzwefQYjSibood1ptUx1qbvFq4kLXrlYEL7SU1dE4bgKxJ
         Fh053sUPFKU8/35lBFcRY1DN7DtwqRoUAEoWKM5oXht507mrN8debqaNKYHShfo0gedX
         zhn0VeawD7mCj0UyRnELHnfifAHvt9GZCrwuFNT1sIx/9ShXjeccEcBEzhD0isj4P0vK
         UuS58q8LvaXF7YO0QC5VJgLYBucY3xya38XixAqiZW7aax2/ij7aj7U5doPT5oLuvcm6
         IcDsNTm5pM+Ldc3hX2TW6W/soKf3M4u9KYB4wQ4hCKIWTwk2Jt71D4MfOS1xTFCM7CPl
         eEyA==
X-Forwarded-Encrypted: i=1; AL+hErGVjsgRBK8Udf9/dZHCE7lnCDe/eXvIrApj48ndupaLO0/u9P05b6/qGeu+4bDuXWAjNXUqJ9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9keiQMLltMdfy+TN9cyMkzGmyRLcAO2OU87D+3uvhtMw6XBT0X
	nK1wPobAIv7SR8p4rFNbvkEDHwqDkb7Ot603EJa/Nb9OqXw9C1bbWSK8AIYrGR5apHI=
X-Gm-Gg: AZFdTZfw+amhrW+DKfkZ7NVk9trxur7x/z7rzFrAeEcAq2OnTkLE1tf5F2qwEYMTRkZ
	pa0BJveuySP6i6vl17sVutMQmQrJVb7To7rKd4L0IsW9J/qVJfofzIk0cU1/plL9xk6T6cBgJT1
	5RSdiQp+W66rQrgj5UMif3FKO5cFxHJGaeVIBTIndhlJ8gLXGmalNTysk0PBpoynEF21XmSXAXB
	Uxl3ukAO6iav6MpDadFqji8ZThXa9UU8OrukUlX5Mu/gvW2hbdFT2nkicgM0WJQENXYkETvHwv+
	fQFn8f5PCSC4NewVx+ZYoxFFXFPB8yIWUbT8npRs/0FRN5ZRrOVN4l0DN8jPOcCq8+tJE/O2Vf1
	HKHV4+XLIEZ32IxPBM+sToA6yind4ctAIVf9vuY5ndnGXFVm6m6Xfm2YRvM1/5to+H8b/BGCnEH
	kzifEKb2F2mZs6y77mgd3x29YQViH2d/VhGB/GpMAhq0gMohuD4I47KpoOfSOHX2h3wd0GMO/uD
	oa/Hg/dLHMtFXzy95AwbZuVUaksJjB6I/ub5eYmyYsRNaer8AFnWM/gVaLZ52hIj1vtT3RNT7eN
	wul14zIPWUr+jCSCogkBqXivMUzf9DYXdDPV0nOrlri+VTXwyJpKGoJZtJgnPat6wQWQ/yM=
X-Received: by 2002:a05:600c:3b83:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4bb88822242mr407442995e9.28.1795603223958;
        Wed, 25 Nov 2026 02:40:23 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm527792685e9.2.2026.11.25.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:40:23 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 25 Nov 2026 11:40:17 +0100
Subject: [PATCH v2 1/3] usb: typec: tcpm: unregister partner altmodes
 before re-discovery
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-topic-tcpm-core-fixes-v2-1-aede2a3471f4@linaro.org>
References: <20261125-topic-tcpm-core-fixes-v2-0-aede2a3471f4@linaro.org>
In-Reply-To: <20261125-topic-tcpm-core-fixes-v2-0-aede2a3471f4@linaro.org>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <groeck@chromium.org>, Igor Paunovic <royalnet026@gmail.com>
Cc: linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qPhGNp5TSTCev4Glk+F1e48Gj7YkbH+PSoXFBjOFR6o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBrBrsV5HENZOOAdIw4hVBN2Ya2oDpdmS5Xrix8Rd8+
 Iw9BJ9OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCawa7FQAKCRB33NvayMhJ0SPkD/
 9hhpjhOnbsPYn8Rtma0aMwzM0X8yky0SvqYSJMuo0fXoFiTAg4c3J7feG3zEYuGI8ZfdIGehFTf+YB
 9b7YIMen9jEVceCRBpVAyD/4jVW6jUIvH2hziZAvgwLc6pX3g6pJNJUzpqm5t6xJlk4vFctKOWcaw5
 GFELApHqHKd2Mbp+BIPZ27KRwwnzk4gLjikhsLzSmbPnuy/zPOT64M1KBVJQAdodcANB5cAKjGyMEP
 V1Y1I87jo1lSy07Oh+/ct7OfDG24kgcPV80VuISbrcOdlT1ke6eqlT4EIWov//W7FwrNTU7sAuOigS
 DnLnw/gg0826Puh1p23SHIAD7tsYqWhyjOcHw1gfyUUG+IcimgsA8jETcQKUeN4uURhgLf0kd9XmY0
 F/aN0OjMWzs4XtJ59Sd2KmWAVxGohp+jNN8p+30qkxr2Yta+hBDNftduYbp3dQNlmdEimpgl/o95SE
 Z4NvlrCM9++RZkhznHGVLDdqGUIn+IdHvkmUAD/ZkjKN4XtSyDNblIMIk5MkZJiMRsGnWNgQHPAPOf
 dfx0DDDiybOlDlHhcC2G+cq33+43ZlZarTCF4liN0wgO9VrDd6fZajV09Lh08IhuZHtliw8Dcyisgy
 dOz30lNMTuahEHAQbcXWjeSdparFHzMjVctWn7XDE76GMuS7FVBC46dhRAjQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

svdm_consume_identity() clears port->mode_data when a Discover Identity
ACK is received. mode_data.altmodes is also the count used to walk
port->partner_altmode[] when unregistering the partner alternate modes,
so if the partner altmodes from an earlier discovery are still
registered, clearing it leaks them and the following Discover Modes
round registers a second set for the same partner.

Unregister the partner altmodes before clearing mode_data, and reuse
the new helper in tcpm_unregister_altmodes().

Cc: stable@vger.kernel.org
Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Assisted-by: LLM
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ca38e05f831a..20e18bca649e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2068,6 +2068,17 @@ static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
 	return ret;
 }
 
+static void tcpm_unregister_partner_altmodes(struct tcpm_port *port)
+{
+	struct pd_mode_data *modep = &port->mode_data;
+	int i;
+
+	for (i = 0; i < modep->altmodes && i < ALTMODE_DISCOVERY_MAX; i++) {
+		typec_unregister_altmode(port->partner_altmode[i]);
+		port->partner_altmode[i] = NULL;
+	}
+}
+
 static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	u32 vdo = p[VDO_INDEX_IDH];
@@ -2076,6 +2087,7 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 	if (cnt <= VDO_INDEX_PRODUCT)
 		return;
 
+	tcpm_unregister_partner_altmodes(port);
 	memset(&port->mode_data, 0, sizeof(port->mode_data));
 
 	port->partner_ident.id_header = vdo;
@@ -5137,10 +5149,7 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 	struct pd_mode_data *modep_prime = &port->mode_data_prime;
 	int i;
 
-	for (i = 0; i < modep->altmodes && i < ALTMODE_DISCOVERY_MAX; i++) {
-		typec_unregister_altmode(port->partner_altmode[i]);
-		port->partner_altmode[i] = NULL;
-	}
+	tcpm_unregister_partner_altmodes(port);
 	for (i = 0; i < modep_prime->altmodes && i < ALTMODE_DISCOVERY_MAX; i++) {
 		typec_unregister_altmode(port->plug_prime_altmode[i]);
 		port->plug_prime_altmode[i] = NULL;

-- 
2.34.1

