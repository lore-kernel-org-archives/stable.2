Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348610;
	b=ORyFFGIibGoxrmNHjcZWZl0CjneABWcZShfO/3tUt/fjpk5ZNRcNFKSMOmUWSpuyaHh2
	 kq0yQiaAPAtz/JpeYZ6H6oo9/ipdu+wXTU7ZrwCrTkSNhvBW2SBxDl5962smtu2ra2+5u
	 fNiBG531yX8FV60ipkqEtJ9L7tp7ac4fhtWGYoYl/o5l5vCNVVgacuhwBIYWKKpRpLvKC
	 erctvg0sOnrqXXSv3DQypjBpBv8nK4UBMlGuKaxXJygsY8rolk8KE3meDEy8jc+oC525F
	 o/bqgA7G11Kurd0Beag8z4Kdbe9tpnWXMrRgDwpzlfM8DSVH5DnDGoVGOxQhjW1icEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KD9ED2MqTv4/+phnYY6+icCa/NG3RCXJ1b2cfyWY1jo=;
	b=2uD+fFrXdMVTE2lNcrQ5PvT5/N0Qtelp4zH1GB36P7B9+BgV6B5nw7Ba08c4slWzuDNk
	 UjR7rT6MjFnV/egMMcKQ21QoDuu0SCgEAG6S5TkbbfSmXu56bfnRLelXMGEx6SY0HNwGD
	 kCCLs9Pmevg7PwvDr9FrMLlFLINtgmb625f2ujIG8MPbOJNdgAhTAT8NYxx3H/xd7O4xV
	 1gXT1HQD1YCBuyjA7ZIl/+a9+yi+qQyNo123vXqpByO45UKpPgtTFoAXX5h+4lGQeaJ10
	 RfbZAAoCkg6xbf/Q8XBzlnsiWvcw8/LwB7uRqZ+d6+eEMl0V4m9p2GfhVrovpeF9lLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVZYJPUy;
	arc=none smtp.remote-ip=74.125.228.135
Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC867606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 11:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC867606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVZYJPUy
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c5119f642fdso100924366b.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348608; x=1795953408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KD9ED2MqTv4/+phnYY6+icCa/NG3RCXJ1b2cfyWY1jo=;
        b=LVZYJPUyG66DPQyzdEv+7OKR8xiAXQqwH14IETsmnMqd6e/C4uASMjQeJInqJhn5XG
         q/e6YUjWlf+7hgHSUZehItWpgyUyZS+p4KPndeFw3aGaDW8WO5gWERrxInbsLqLI534b
         HMd+TfWM7AJ0Z6bNhGUII4audziihOGylEaTHct9/HOcJciuHtB4rE9YoVip4wN78604
         0rO9Wj9GzxmnQM/QBmP4gHB8IUAtAnwWOjM7g4aMRUGeYkSO21P8LQd3XV0ORYivpx6M
         SXv9uHMJnlIF/zsYrbx5AdVdA/+37T90H9En3meR/o4gb63QVp2cZqwCLCgn2+gZ9eZS
         Jkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348608; x=1795953408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KD9ED2MqTv4/+phnYY6+icCa/NG3RCXJ1b2cfyWY1jo=;
        b=tea0VLeI56ge3gLmZN2MsBVJR2sSQykw2wz3W/hrZF2pATSkQYYu12MZm/CvABlG2E
         BF//1rzupUqQgeuOD2sdXWDskfUz/LbY4couf6Dnxhnk3MLx8GSBXrPQpHUajxehr14h
         uAe96UlWTH2cBKCON3HiyVz0RSr+ogwJ/PSD2j78Qs3BRLRk5daUViIof7JJLf27OTPu
         MXZQ0s7m5wrJXDPtKaiBV5qZ8Mm+dLVWDqhWK/m/Gwit04dOFSNGQrAvtkrt8k6BduWG
         9hzIleKTEWr5ZtqxZpRvSXyo8lIGUcovaE1xUOjbDr97zIa/TvZ6ihOcNo9Sehncif7/
         zqEg==
X-Forwarded-Encrypted: i=1; AL+hErFfnDyWE6oaKiumDL+NMJEF2S0cyNpLR2vWfN/pdz1fJeyq/Xb/W2APlcde8+4ETXZLRLjK2BQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GKxWfOxVPy0ebrgZetuhPGIq3lTeQSZwfQCBpUXP9q9exhtdQ
	wTarc93LOXK3m7Vr29d/QLawiog9ORSnuyIaEocLSJU4SAINAZKkVow=
X-Gm-Gg: AZFdTZeDFAW5T7trst6UvKjPk7vpV5Zri/mpwbq8+I7ydX4B45ZRrtSOyp0kKhyye6c
	IT4Ck+OmyXEPRfZiuj6ml42Nh8Zbv6hgkNlSIP/MhCQ2r+DGOVkP0sUOlQ9t0iIDSW4TKtSObst
	rw9zatPvn+MFoA+DLMJLBmYd/cZe52Pz4jAnTMkNVpmkRf85HpGQYTor3HJgNeczpOZD4KqgD/O
	woMLdpm8SAkK3nBfUAcosxTdyqBowcejJfJZ+lEl5qXYmhBbduRaRITt4tGYTY6TxKdoJvUBz0K
	phIRHYGt3UvEDMa/INSZBrhONgo8kgkmkA9OSNZdJq0hgFdoBT01oYZltfJo/Mpwj/pBjK3N2kj
	8HfQrVmHb50c4iNeeImWrQ9bLS4rl7ogmquOYhrgAVEFTxVwNqElIaJZutAQGznLm8ur9t8pOU5
	n8C72bhKNVlx9Ixq2j+qXtguWd/ScFoZBSES9ePa9XI7+VTF+Ao2m2lo8EGA6te03l5iR/1W9MW
	V9WQfwpNhyvl3o4j6FGjG3OTNr1w//JDGRlOV0HuI0C8LLu3U8oP99iOGp/gBmYULtvIdg8IWYj
	Qv4R/exkuFASzR2JW0FOt+XyoM6vvvQzpGfdhe6xrK/M
X-Received: by 2002:aa7:c148:0:b0:6b7:8444:a44e with SMTP id 4fb4d7f45d1cf-6ba37cc0b7cmr4214881a12.4.1795348608196;
        Sun, 22 Nov 2026 03:56:48 -0800 (PST)
Received: from llm-01.drunkbatya.int ([80.251.127.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e362bdsm3932556a12.5.2026.11.22.03.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:56:47 -0800 (PST)
From: Max Andreev <drunkbatya.js@gmail.com>
To: Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kyle Tso <kyletso@google.com>
Cc: Max Andreev <drunkbatya.js@gmail.com>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: typec: tcpm: fix missed frs_sourcing_vbus() call during FRS
Date: Sun, 22 Nov 2026 11:56:38 +0000
Message-ID: <20261122115639.2912666-1-drunkbatya.js@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026112206-lapped-unvalued-8696@gregkh>
References: <2026112206-lapped-unvalued-8696@gregkh>
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

Since commit 0908c5aca31e ("usb: typec: tcpm: AMS and Collision
Avoidance") the TCPC reports sourcing vbus while the port is still in
AMS_START with FR_SWAP_SEND as the upcoming state. Because of
_tcpm_pd_vbus_on() ignores this state, frs_sourcing_vbus() is never called
during FRS.

On Pixel 11 Pro XL after an FRS from sink to source the phone keeps
showing the charging indicator, and about 20 seconds later VBUS drops
and the attached device reboots.

Call frs_sourcing_vbus() from AMS_START when the upcoming state is
FR_SWAP_SEND.

Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
Cc: stable@vger.kernel.org
Signed-off-by: Max Andreev <drunkbatya.js@gmail.com>

---
v2: moved the trailers above the --- line

I'm not test theese changes on mainline, but tested on Pixel 11 Pro XL
vendor kernel 6.1 with the same _tcpm_pd_vbus_on() code, as i see
mainline tcpm.c is identical in this area.

 drivers/usb/typec/tcpm/tcpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 51e5c72799f2..5caa649a92f1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6889,6 +6889,11 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 			port->tcpc->frs_sourcing_vbus(port->tcpc);
 		tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
 		break;
+	case AMS_START:
+		if (port->upcoming_state == FR_SWAP_SEND &&
+		    port->tcpc->frs_sourcing_vbus)
+			port->tcpc->frs_sourcing_vbus(port->tcpc);
+		break;
 
 	case PORT_RESET:
 	case PORT_RESET_WAIT_OFF:
-- 
2.47.3

