Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914131;
	b=lxJ205odGuZ8iMgRjkhKi90z27qfaY5ucMepRWxqJT98AskZoESNtmqlQx2PByltRTED
	 H90/Ebd99GSB3rrwKd1uAv+12h/7/ZIxGb7VpPfjjDwaLs6M7wwd/zf8P1d/9GjZ2zBD8
	 s+0IDTeOR20cnqujlCNoF13GbuJ7hW4p63/4ohiBmtXnpVBdvuhnwet6S7vKZHiso72jF
	 tNaWMqb+3LEcNMfuoV+59LoqDJFuffVr+OdGhSUlVCE+D3/34TRA4y6cO/iwohdi9CuVe
	 RIruUtOEbvSiZmfd6b9LzPvphqWA/pjoIKc5S2dw2m+l+Fz6I8hR1/ke4VfDs+XS1EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=9J3okju34MNnR27FDiPAaP7UT0/s47A9W6uHOHJn+uc=;
	b=IhaEadN0ecidgWiC001WU9BirzwLuwOHQXk/t61pkQy+fJFpXrnLj1ptPJkqyJxMiIGW
	 n/HsV2HfVN4hJ6WyCEyORZr/11lXl9IXb+g3kItxVUQVfbX2SA+Ti1dhaCMlsTM/NYz+M
	 FKlZDFMwunHlbawYgOSOwG3QtA4Hlz5CrLBbs4as8C4mn+zeDiVF4PgCWV82GjUlm0jwy
	 GuV7dcgEuiuSuZYRttix/ofWFL1o1aH/44whYmZxENtIMTUX7iz4qeCh6rMrRmIbp1I2x
	 NdkF90LWZeIEOxa0AamBaY6Y9lEi7cJjkAJHy/kVwqLbNFm3ZcEXmdOFxsF8qzZjEug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=CBz74zaC;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE29606A335
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE29606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=CBz74zaC
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so23065305e9.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 03:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794914129; x=1795518929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9J3okju34MNnR27FDiPAaP7UT0/s47A9W6uHOHJn+uc=;
        b=CBz74zaCPQeAfGLV4TbDZ+4TFW4hj7UsHko7rb3gYFQTHdjD+QfOv9Rj9HCaXnEqGH
         +XIVedkLIMeW5zp7xTNk/hjaBXQ8fCvjOBThBVoE/F3wQXZTRIa+pasmFLg8my8d3deB
         VL4xtZ+eZtBGni5pQ4buRdH7nfnOzXHgFR7SQV76JoC6ly474ep9653PCXcAGQAT/TRN
         HPY6nG8F0P8zLOTCL5Kw4m9Oo6EQfVfEjOJrSJNQdp/pcgHAPnAipU61cTA/hHHP0O4T
         BW+tMUPA4yQgnG4vWk+t+vpeHTslYrLUMNz5nOjVSFEavfTMN7Eu6g2mtGMtIlSbG3IY
         OLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794914129; x=1795518929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9J3okju34MNnR27FDiPAaP7UT0/s47A9W6uHOHJn+uc=;
        b=omltxPDUFUNK8dzZssYMPSuo/ltG0XdEYffbDlQpZTgP1uTqxcY39blenLyReU7qFy
         Ophm1A09foZ4kqrp9hV4XCYhcHnm9BTQQdFYmVhNakdoDXZMQqcQ+96bLnHD2P3FIgbo
         dAORtwlH72SbebIslP3JioyXqnS0Q6dqvkWi8p0LGpQKvMK4o9Nkh8WmTlPhVf0tCeye
         mru31bN4B4AcuKeonn0i+mFHotDxpfM7mmcLYBOuAVdYf2fimi5rbS8CCbo7Kq4e4nev
         RabEqbgyTO5ViRtwtzWib7xdTVfUuVmmWK3cgxTX1mZKvgQ8fI8GYxFRffc80OMmuCKW
         DXKw==
X-Forwarded-Encrypted: i=1; AL+hErFFUGIsZhoTWElQiOy8PiJ/ZMSfV3sIlS2ZwVVDuP1ITztv9KYWjxnwgWTS8JMLvtdXHwHpNlQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fyiyqR7sPJ27lQhhl6426V3igsSVUfFO4ZLUIvM9a3+vmrO7Y
	CujQ2HT/pVyzE9z5MI+uBnNoNF/V0bXrQ9X8U9KdwG2Wp17KQVZ78+aNQSClpw7mBAg=
X-Gm-Gg: AYBFou2XxcClOe5hy5i3W7VI5H2aYowK+iruMek3v1JLA7pnP4dbaTxsS1EbrQJzG61
	1MlfbF9EEoOOEI2uA39/9reE3NJu+7OEuttHa9NTKPYlMPJsqSTjx8iF/jIiwhyi40N/ANKJBn4
	A8nOtawmp7VimxJLuHFl42F9nqz0SoVtnbBKLJs5T4tJ84hqrFQvEWSLG3ZnfeIuNAgb5Us1jLW
	t7laNZWKsMkNow1AsN0uJrIy5oojumpnM2rwxVwcO8+fGZfIaMY6qvAzt8rNqw3LrtrdxRC1xJY
	3qGvFYls1St/GYjX7tZx1arrd69eFIKKG3HCX2XFOJlqFnIRJMGwxHf2g0tEW2HmKz/dBJM8hv6
	UgBRn1sbAlt5wUcdIhQdgAnf4oW3+SqdvoK2wILg/qXRZG9cgLgrATmVUO3QLvzJeM8dGplZsOm
	vU+3cmCC7a2tzM3qnEqD3GYWBqf7ZOBT3MkzS4eHG5fo9qzZmcaRdzVL6B4iybdyowdQ0DdcoMG
	aGKB1CZ2hL/u9N2D5RAD+ylolD8FbTfvmzYwDEuqded48vTXuKldSOyRPB89ZI1/Y6SbIk2vPM9
	xs4bJHREx7xpfQFBHWYTJXpa2FNNdMVRNKoLrP6bO8luFo87bQpeVggWBd680VlL5hkCEl00w7g
	2cWFZpllwhQ==
X-Received: by 2002:a05:600c:8b56:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4bb55ad0711mr284989995e9.29.1794914128746;
        Tue, 17 Nov 2026 03:15:28 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8220sm59773745e9.5.2026.11.17.03.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:15:28 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 17 Nov 2026 15:15:16 +0400
Subject: [PATCH 2/3] usb: typec: tcpm: Leave SRC_VDM_IDENTITY_REQUEST
 whatever the cable answers
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
Message-Id: <20261117-tcpm-soft-reset-sop-v1-2-c7e1543828c0@flipper.net>
References: <20261117-tcpm-soft-reset-sop-v1-0-c7e1543828c0@flipper.net>
In-Reply-To: <20261117-tcpm-soft-reset-sop-v1-0-c7e1543828c0@flipper.net>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-usb@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=alchark@flipper.net;
 h=from:subject:message-id; bh=GcD+2Vp+u0FkZkbqOsmPAdEh3rJkylbYEoZ9S0w4x4U=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT9MfcydXcz60u8f7Oh0rO+JiJtmfe0ApPHqSksR1qc7
 83b+nJxx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFO9Q5uR4Y71dIXi93fuJYuzyQcmpCgv6rNelPRNQ3rxo1Py1d+maTD8Yl6xY+G
 cHX/+CxqrJE4VW5QtfWNyIn9djMPejUEef+onMQAA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

When its first Source_Capabilities goes unacknowledged, a source that is
the VCONN source asks the cable plug for its identity in
SRC_VDM_IDENTITY_REQUEST. Entering that state sets upcoming_state to
SRC_SEND_CAPABILITIES, but the ACK and send error paths go there
directly and leave upcoming_state set, so the first SRC_READY after the
contract sends Source_Capabilities again. The second negotiation can cut
into the sink's own Discover Identity, and once ended in a Hard Reset
between two FUSB302B ports. If the cable plug acknowledges the request
but never answers, or NAKs it, nothing leaves the state at all: the
source sends no Source_Capabilities until the sink gives up with a Hard
Reset, which cycles VBUS.

Schedule the move to SRC_SEND_CAPABILITIES on entering the state, after
tTypeCSendSourceCap, the interval between Source_Capabilities, instead of
setting upcoming_state. Keep the ACK and send error paths moving on at
once, and a message from the sink interrupting as before.

Fixes: af8b627046bc ("usb: typec: tcpm: add state machine support for SRC_VDM_IDENTITY_REQUEST")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8c5be904d772..947fca918414 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6553,7 +6553,11 @@ static void run_state_machine(struct tcpm_port *port)
 	/* Cable states */
 	case SRC_VDM_IDENTITY_REQUEST:
 		mod_vdm_discovery_delayed_work(port, 0);
-		port->upcoming_state = SRC_SEND_CAPABILITIES;
+		/*
+		 * Go on with Source_Capabilities whatever becomes of Discover
+		 * Identity, unless the cable plug answers sooner
+		 */
+		tcpm_set_state(port, SRC_SEND_CAPABILITIES, PD_T_SEND_SOURCE_CAP);
 		break;
 
 	default:

-- 
2.56.0

