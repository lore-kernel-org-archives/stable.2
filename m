Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168583;
	b=iDIL/D8dw/+fg6GEoFimBydnp7PcejGoKMuk5RWP1bvmB1MSwhMlXnCEJiYg4qJBN3ff
	 FsupJPlO+ReMK9wv2rwsIRexouBqq4yxLW6TtgbRkjrO3gN54Jjs6EXXE2TYe6fYMAkOu
	 mt/eg/+VQ0Iwu07ICm2Xpx+U836NQLJbImqVJ4Q5PQLwdJmucdp2JTDIj5bdIl7S6f6P3
	 ADWvquqZskKyjU0skZ7Oq0FK/VUcaJy9UkTg1rjF0Bj7JGFpMJQR1yEQydXyh8tgyzFBg
	 vGnONmPWMT+Vna/9dw7z+PEtnDP1h0U1ASR1JCEJa3gAUEleg+LRv6CgiWkHqrYM0LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=G88ceLyh4AUnlGhVt6bK2ePXMzrBkJbu90gp7HX3iVE=;
	b=lZul9NVMxu9kLJR6buTxvYjVL4jGxewPRlggYIGPBkRkrRMDMNiXYtAJ2ufXP8T0cocn
	 66/qp7wq4rHoue3rKRfdHuhXtt2wwW78GNvuYtwq9/AvGCSWoawnBHdJgN4OnB9QMgCBg
	 fu7H5f29Pah6WD/M7tQZbVV1zH+Ff3EoaiOg6fEgodb3oW51c3Hr1zKMOLEIT2Q8DnSm3
	 q1YogimLwurP3iOeKyXPIwPAXfsD+UZFBmuwTOs7XmIitXD9nTmXO/s3+TbhQwZd7GWGk
	 2HlCYxSF973OT2/xMBTBkGEN1ZwGnKTk+xSzyThZdphQzuEp6HKs8OmP/KSdg7MWKKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sMOLWRKu;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6E606A33B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50D6E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sMOLWRKu
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so6284565e9.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795168581; x=1795773381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G88ceLyh4AUnlGhVt6bK2ePXMzrBkJbu90gp7HX3iVE=;
        b=sMOLWRKutcZH17ajz5//Y4jABX+TbtrV5UIADABOPpPKhC+FEbw9wEPBbp8+ObkgE4
         8q7iDTaj1xqaWB0XFxV6D5d2BcKknlLPq3xLO6AmdZVprEr+6kI66JJuPRK1FTHf7bQl
         VwPl/XG5YSXCRzDQ9gamS8pDjR3Yh6zKlWwLu3vM+wiVOEYi3ymXIFR22Qbp7zQ4WUtT
         R85PBqnmIapf1w1lHI84+n/N+KXvUfDpbZMonNLGBhlV5i0L6FK3OiA4KEe3VkuIQm96
         oGTpIxu7RUY/Xjty2STwB31L2ze9j7wvKLIrad0Jmk7Iyt7AYyaM4E6KJ8ZYtMskTeg/
         ObLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168581; x=1795773381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G88ceLyh4AUnlGhVt6bK2ePXMzrBkJbu90gp7HX3iVE=;
        b=rV6Nd5WSsGTADRVUHFW0yDUzcp+Qvx5zrBaV9WlpXkojDRShGYqWVrC+460g/L84sQ
         EO4rbpcWe0mj3cIsXNVJKU9irUs6ipU8CDozFMTx/2pVZFgeHJYgHS2RYwwk66K06BGl
         wUPjx5aoWtm3cixj+XOJcOMQN1XjPSmCyC6J6Kj3yal6p9BltXRhJvy7x89LLoF/FMfx
         Gk5XmiuQNBwSWlPLu7CF3gNEXNRWk33xheQckAEVFSBKfsXaPGzhaAiwX4xuptcROSQr
         3yn7liHLdhCayQ8AdDijRrHjtCGsF2WPj23AqKvKsK7id2O8/Tn+ZSbMk7o9cZs7sc+h
         ZRdg==
X-Forwarded-Encrypted: i=1; AL+hErH0yZ9jsznMPDdBsV0ccLPMyrxUf5ogKbfqsY41Qy0661NDhhD2xyhRW2XgDhxSRmjw/YrCUac=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HeZtUOzw0+ArQIcgZ6ePlEglQupyK9St5hRaPBhoV/hYugFi8
	Dw5uqOhMW+fjKquzneBOZPKYf5E6n2mw7lUn7EoxPra8U3XgXPyXDfQQElwWIKmj2mw=
X-Gm-Gg: AYBFou1+lcG5BrK4m5JvMXJR00hQm1C64x2c9vtEdJ4dffg/7LNRthK08hOTNxjxgWR
	dDiqTGI6whK6fBx6UrulRcXKdcp/hKWuBdfkdG9NLWjp5R4pDKRH5MDIfIGB0ye/Qy/8NIRZrxj
	zPNY3vOYIQcCtC2CgR96FAD0gNSATuAJGgFP3dwk+2gQ7u3A7EAcUKNZO9lr+EQN0UpmGksw1nb
	HYrXFwXG9E8WwBX00Z2ExJSXoff3i8jF1AEr3E6kCfM7OWpC5XRvBf8/zstdYucj/PdKA9NAPs5
	3/QvbpPRWtSs0qn6KpsWM9kmbFW1tw6yn539PWGkaSMi+4Uk2r25hQeFz/orNu5M6+Q75LQCTQC
	kJjn00aspbUeICXH/+MiOxHIe1MT49JnzPgpLF2s6bhDyU7B9z4AAYK1jG548bz0qDyVuOmnKrF
	rR9Zf4WYu49lc6NwUVSbhlYM2p4fcVKgACWBuxy2Phtmj3GwVJO5AGI0oD8p4fMav7XtcR4ObO5
	kAX6sxCZM9WJ5nNv9NW56yyqYN6bAmAeth3EmDfviQnUyS3cB6OwyATg33qSiOivMOV9MJNzNh9
	SwwxYXD9n96FZDW+qDEi7uUK2kQXt/o3Bz/DBVcxwofhjVqplZhu2Hj+2F5j2SvQFu6Z42Rp
X-Received: by 2002:a05:600c:4f50:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4bb888063f3mr62182745e9.16.1795168580504;
        Fri, 20 Nov 2026 01:56:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm149124555e9.13.2026.11.20.01.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:56:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Nov 2026 10:56:16 +0100
Subject: [PATCH 1/2] usb: typec: tcpm: unregister partner altmodes before
 re-discovery
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
Message-Id: <20261120-topic-tcpm-core-fixes-v1-1-c753d1d286bb@linaro.org>
References: <20261120-topic-tcpm-core-fixes-v1-0-c753d1d286bb@linaro.org>
In-Reply-To: <20261120-topic-tcpm-core-fixes-v1-0-c753d1d286bb@linaro.org>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uSmAwwX1348iaIOry0wnOTbMLtmEstD0Q59oLCpeRw8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBrABlCAuAo95PwvlksXSsBKzGKPlpEKRrkNN9/qRWD
 ERrShHaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCawAZQgAKCRB33NvayMhJ0cGED/
 9mRnbAO+37956QNMV/b5pIL9o8Wf4AZcFRo/Djvk5g/UcQq3sIKSdeiOLJ9ovKF380xVwJBsbDiYn1
 PWkLkoBWya5pwhBaiy+T9y1o4oXnsyVNsulkQenPfQfJnfCb9J3pYD07ZsU5xT1sGLcD5DFtY0NH74
 dW/oaVC0eO+LTZkrOEfm7aRjlVSrEyK9JhGQ+mg84XAWQ7sAkxuDZnP7aNVQ2/gzkNw9dBAeHwvtx8
 VXBx8qUOoaeqNXMtv2Mcd/wLSxwLd4kFP7xtipsHfFiBqfipDqZ5MSyDdUqlq2C6WRcVn7Tdr4TyJ9
 zJia9GAdbaM1s/VPeXTvBwxl7GvFWA//+gJ5NtXmbi/JJpAgfs7mjhb//q7Kcj8IeMMOw4+fHKimra
 s7pqxSqr9WFQaXoyAFWJabh4+Htuv44RuJCTGtH4zTPcq2D7565RD5AvVaHuEmnymxMxHlaQxNsB/E
 LV5t516Tc0+Uk4Dcu/aVOLTQD4Fz9Rvs61c/3TIuWp7dqf7HiJ6BtmEKg3wlW+mdjg4AJSHNHD2LTl
 9HcK2jH5HMS4xMs34wOBnPhoXA3P+9LyXNbjr7f/bHwh+v/KMt6JkVp+Lu/7eHduJfdxXYhGBnYuvB
 thzmdWx8pY6pAvjpkrQOfdjmEkA5X7T95OmN9y8XT6MnGheUN0Kcsuwf66Tw==
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
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bb90211660ca..1d007e59a2bf 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2060,6 +2060,17 @@ static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
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
@@ -2068,6 +2079,7 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 	if (cnt <= VDO_INDEX_PRODUCT)
 		return;
 
+	tcpm_unregister_partner_altmodes(port);
 	memset(&port->mode_data, 0, sizeof(port->mode_data));
 
 	port->partner_ident.id_header = vdo;
@@ -5129,10 +5141,7 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
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

