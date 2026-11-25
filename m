Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603227;
	b=ErlB6H5gaVzCxJ4nbWViwVsAbp3c51O6j6o1XzVYPqsy0TOmhXCzJ0eWQgCENYJIRerY
	 Tgnrs5dCAgZZCvYvQNCns8b54tBBifHt4g7TBMOLwJAKfYMo1LZiL1kh0lAeos74ysppU
	 xFso9kO8uKn2LLlEJVRLS5+CXLdFktH5s0bCdiq1H5ozetslbpTpytVX7KzbCUjXI4k9c
	 04lFWnFEXYNiQl5tkIruryWSqnmb+mRdiMPCKfDWeGNFACGSNAA1+PE+hDVBIgj7uWc5x
	 GV/zFYvmbdFqZxg9A0goPacqckVYgE+fz6kIB6j7+b6h0DqHQ2lFWlLE5qyfzeW/7iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=5s0ac+QMelxSd/2e8RO+qxSk0eZ8AkmR2391mVfNhzQ=;
	b=nVAAcdKZNTcLGyokB64PLNJYVAV0q9tm3xNMn3MoENebCnBafZWGsQrMEpYd3v+Ng/kH
	 IfWzg7sXBjFKRxmyngqe+knu5szWb+Nq4ZxuRNTlJS+6nwRgBKDkirsH8+jI4RTVjpt9H
	 qGrsx46w9kcWwIFDk4p/V/GBYx3j6UOwGTkbdqpNpgxAdskwGCiPHiRqJAiu8TYQbDa4F
	 R2CGspoVkJh1bu7pG9xGkc/ufz6O9DJaGns1nuDVi6JqBcDocnRJYLb2nzXVJZNGCgZMI
	 GQKnE8IBnnv8vBVkHFe2tsfliVjg0IIb0jJSwDYaVMgFygpSFHQInzOAKVaisOw8H8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ikt1OSKQ;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA9606A33D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CAA9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ikt1OSKQ
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso30171315e9.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795603226; x=1796208026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5s0ac+QMelxSd/2e8RO+qxSk0eZ8AkmR2391mVfNhzQ=;
        b=ikt1OSKQhF0cl+Cfqg2qnmVpv6U6ITZocmbnwaivaif/7jhIK2vhIme81MEPVl2Wwc
         5nnPTR8GGKlWjH/w5V7xfKJSqwslXHN6CbZO/XdQ3XQQOxVFWzOjCE/Gj7qT2m2q0Nin
         zbQ7BU9BasLjHigpkASjaca5d1kDJiyEvM4BWC2ASm9Qqy16mplCX0qOgAZLEF2hJdMO
         MztBAXW94aBB8zGIfCh/ybVoFnBBHF5XReb3f97OQVJ7+XziF/TRgqtvHEHB4clGwHvw
         WViWZ0keGITC5Y4BK/cOUFtLs4ZEOkGfT2OlO6BCjP+IkqPu7g8fSOOdy/5gZvGTF7Zq
         ulVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603226; x=1796208026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5s0ac+QMelxSd/2e8RO+qxSk0eZ8AkmR2391mVfNhzQ=;
        b=cjPLbxGftmQyBPmWukr7Z0/Fa7I4AZELQiEvKMemwU/et8CQYiOr1p+71/2bnx1N9R
         4CRNzaAj+qDgzR3XsChhfaKmsSLPwmy8C0lu5ds5O61I+ySwNuCR45L+pL6Y6hb88doG
         tVnqSHMBHVWtzoVigD2JRb8ZOzT/CRqNuHoxyv1e+snfu4PR2LDTA1bu1BTei7Lh1j1J
         9appEukUPP6eplv9VRN7se8b2T2YpkObSbkcVkoDNl2BGkakm1CHqCRbwbRZCL8dNbT5
         wrp+B3A/I8LhJw3/zRc2I4qjtuxlbpUBhOWgWUo/AEmItrdiwU1FFT/8YMSbtIpgly4M
         1X2w==
X-Forwarded-Encrypted: i=1; AL+hErGl1rrThRILBYrwyvA686if45R5UYJn1h9c8nePBTFGmRe1JgsbhitQU9KII/P/KcYkc7VijgI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TA4pZIxLygCx7cRzkTS3svD1Po6/WXKEtAesF2cICyavsk+2k
	YAFCSpJISnvkQ14HkKVYRxrPvUKu+MOSxQ9dRNEDNoW9+JEQLH//k88a5dqx8mGDiI8=
X-Gm-Gg: AZFdTZcUeL3qxy94HTmxGP7rtfhqECd581rljBHWLi2HV4YCnIeJH/Rq6sS5ZVU/Y8f
	3UQaartA4g0nuZkEu3sCMq8OmEJ5G6nmVAS2CG6g5KzWAqJLTJyvLi6qLZTIQygVAMTjq/Oc7h6
	fXBtie3dPZCUtcnNz5kZTGDrHpMRwdBkP5PmhjN3bNLStS4B3OKjO+sLH1NnS6kdtTD8Ztkorns
	iMVRIFuTrFeS4uUasU2zMMlCBrYBHBTTpOxnMyPkaoKQSmLdqpx8lKsHuN7KMsTf3pFunfi25nL
	XC3viK+pzYhm5QURp0PRr1P2ecjZijnpBcH3NkYGZosJwWtTg2CGegJBWTcFxzKsy+QIWJtwcmK
	QBCP+gvaT5DeMHn0r4MEOonHkiM8lWWjVxrqFBQ7zLzEClOiZZR7olrNEco3gYvrWB58vy4blZi
	dH2qJ4cR9FSGd864uI92ajMtSaC3W+jhtvybsPhX4Ol57w9E8zjDYH+8XdNywvF4y6zotYyq2n2
	dEtio/ThcfiUDKbL14vU+M6eRMDC03IPMAZ0vFH1bckpaRmbB4NOWS67Vgh8vXLfLkk/fSmu4Kq
	FgBWi6Ha7uUhVE78Nk0o7bgrFIUuH/v9GXoP8EbDiu7wNEaL0Ws=
X-Received: by 2002:a05:600c:6219:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4bb8880badfmr335126885e9.18.1795603225469;
        Wed, 25 Nov 2026 02:40:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm527792685e9.2.2026.11.25.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:40:24 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 25 Nov 2026 11:40:19 +0100
Subject: [PATCH v2 3/3] usb: typec: tcpm: destroy worker after reset_port()
 in unregister_port()
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
Message-Id: <20261125-topic-tcpm-core-fixes-v2-3-aede2a3471f4@linaro.org>
References: <20261125-topic-tcpm-core-fixes-v2-0-aede2a3471f4@linaro.org>
In-Reply-To: <20261125-topic-tcpm-core-fixes-v2-0-aede2a3471f4@linaro.org>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <groeck@chromium.org>, Igor Paunovic <royalnet026@gmail.com>
Cc: linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PMXF1eyiUQFfoUh1ooyaEy7iCltnT1EynG7cG6UKHlQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBrBrsWd9Yl2ueKRDKjbMonlpOADg2gVz8KPetQZGvJ
 eP8MaKyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCawa7FgAKCRB33NvayMhJ0S8REA
 COn4KfWJ+qx7gZ7l7EgluUtIPxWit6pbM/PEJffourLtGPHL4sTz1w3uQtIDaYarskvHdnfHsbLbC2
 h3RVn8OrI31xOd8fKsyNPALL6Jq165dTINkfPtE8MMMl71rqCGltb+h9qB018hk87amyy/047hNwpE
 +Jqh5Y9VWL1VvBJEYMmUApespEJVEzaQLCAzQOFbUllzFxRb7o4cGaDsDdVVVPM1dpN1aU2jPCiwmL
 ixLJAO38mGlHA5AusFXvKQG935pHpZDF7NW3Uh4SXEkD2gNU3BQGcL7EaPBdJ8K7HXOGa/En16Rd8j
 Bj6l/zXcfDiFubN5XpNn7MrVYYGFyaBdhwwVWNyzVfinCQfRyauJnqPt4Wq0IRsQtVqC27iOi+Qz3l
 FQitfkIxRZUlLd+6/vK5yy/ACd3jUUEzzy08XPdR1GPilyzHgdEpFbE1NMB+RpfbuY/9vqzLft5I02
 md3HX5E3RjFIvjXuZoDG7XuyKR0lG+6ChJ0PvsRdEqP2MisCiyK+e0M8GO40gmEYGTp2Ks+aYbaxMU
 ovi6bqmmuMAkoAg0VftAJYTCjU1+EbxdIgJyEMX8/83fN77timseQtQOy6p1ggLqu48569jMHf9Kmt
 8SFpLn5xijKtApfTWrbd4m9Zy5ij6IZMuWkVZoXERE0t7oKqglm4AqKV48lg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

When calling tcpm_reset_port() after destroying the worker and the
associated hrtimers, the TCPM implementation may still send some
TCPM events and call back into the TCPM core and encounter a NULL port->wq.

Move the power_supply_put_system_batteries() & tcpm_reset_port() earlier,
since it's the last function that calls into TCPM callback.

Cc: stable@vger.kernel.org
Fixes: 98d00deb6ae4 ("usb: typec: tcpm: fix use-after-free of the kthread worker on port unregister")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-224916@kernel.org/
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d0abe8100742..5e68ce2ea1ac 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -9025,6 +9025,10 @@ void tcpm_unregister_port(struct tcpm_port *port)
 	int i;
 
 	port->registered = false;
+
+	power_supply_put_system_batteries(port->fixed_batt, port->fixed_batt_cnt);
+	tcpm_reset_port(port);
+
 	kthread_destroy_worker(port->wq);
 	port->wq = NULL;
 
@@ -9033,9 +9037,6 @@ void tcpm_unregister_port(struct tcpm_port *port)
 	hrtimer_cancel(&port->vdm_state_machine_timer);
 	hrtimer_cancel(&port->state_machine_timer);
 
-	power_supply_put_system_batteries(port->fixed_batt, port->fixed_batt_cnt);
-	tcpm_reset_port(port);
-
 	tcpm_port_unregister_pd(port);
 
 	for (i = 0; i < ARRAY_SIZE(port->port_altmode); i++)

-- 
2.34.1

