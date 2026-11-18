Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986830;
	b=hRoA3QAaC4N1RkAGe41a7K0r9AUM3yY7vL1VOYY/53gUetG9JJeDTf36Lr9AeYS+mZRS
	 3/UGU6t9UtpbfHDJoZre8BJ/VKrkgUbqRtLymT00ntIw4O3tFARCw9MhljpAA0xhYiECo
	 8n71KBYUwpTHHBXA8o/b7Td1eRnlfm1jd2jbTzmyRyhGyOdWwC+XrZ7TNzvWE5bdLY/bR
	 kBw4eJyMAXLMEh2Hh9mz9ARfTJrQUIKGqia+Yg/GpoH9+0XFcbcqBixBW/4vphEjEoSTl
	 GhoJ/pDwIiwnUw/xXjAz3R0VVPG9YJtD6YdiuSQNjmItAYx4eXqGvER2DdNJk8/IqnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gmvbVp6faEXvDlLMjXYC745ZB8kPjAh6JMcn8m79P6Q=;
	b=lgl7JYDH2k9STze5jzB2rc/on/DGnAO+RdMP3WOARZbLwqufZVyE5Yy0l1NPS4U63HLr
	 cxusB4aeOP/2MD64rbC1JXr7RCvu8+WERbdIEKv0oH1K7IguxGJ2ycStyw+Dp1jmuntvT
	 EYtfrK+aeFZkYsMMe0L7d8/kOyTek2/I1we2k9W3I0CM4D/qGsV7d3FP0iLKu//k8JUZV
	 dyBp1d2ycJrYSoxVnWwu4TfTBlOOYmW+iFCh4IwmhDXwC/39x9JR3zc84vwuuENpIoG3/
	 9w+zPAyC44uzuFxOhx/ijZhSGhdn6xsyrBACxfnN6Vkqw+7xJtPdX7VDHDeqrz2hcpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=0B+cGqjb;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656F606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6656F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=0B+cGqjb
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a5506f09f5so352998f8f.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 23:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794986828; x=1795591628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmvbVp6faEXvDlLMjXYC745ZB8kPjAh6JMcn8m79P6Q=;
        b=0B+cGqjbNeLds2u708MQ9QyK9g6VNvjwPsuRUJq3bfhI9l/7ddRFXaWUsnu/SrAURD
         HvPBNaigvjLBHsFy3Y0fB4WuGaCk3K9VxGUexCZR556zHTSyX73fDHJnmAGfSZywagdu
         DUXq46bBEFPP1Gk2H7J80Pdvx+G9rctCCSbeCv3EfkcTFyKzZZWVO05JuKbfO/tFynaA
         G+t8Dp4Y3RN57/mzW3DaJDmVCjVWHA5LnnK+egIZYuxf1laxqzHJhRpgZtKkjO4mT+mv
         1xzy629pmMOPAEKGTPxIWk408ZbDKBmx209t9pZn6hzgKTH0C0RY1bmZTrBeBFvAqV8h
         +Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794986828; x=1795591628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gmvbVp6faEXvDlLMjXYC745ZB8kPjAh6JMcn8m79P6Q=;
        b=eMgJ0lzUck9k41dhigUBESQXTmtXwkwihD7bjP/YV1uJyNirEVuy/jcNYXKSdKR4Uk
         BVZZj5nut4GlJpLDnkBhfBxLOox7F7mkv5H+QHb6zl4yohsMYaIFZ33hfO2COkJNX9qE
         JRw78g/mqDbvLd9bYv89cHBj7kjML/poE0XnyIdEgyhv20XIc00ENVfInTP0HUav2R77
         SKYg0dOFi2vUp9zJdpUtvnDaeBSYY74H4exh1E/my0tQqBBg4KH82Jnlyk+jaI5dHj8d
         o3RcJkYUvNKOwgXkwcHUtW2psTNiIaFm3B+jbxLiCJWv+ffgL+1ruNBhUd1AXQEcldT5
         bnEw==
X-Forwarded-Encrypted: i=1; AL+hErGTxiLxOCwb/acIFOp5PvqjN7337oEidgxnXJNGaR0ktb/FGVLe6WIT1Cu9zCnjU72d7f/xF7E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jUyr+S56bKQQ46exOLrxcNsX6rtnJY0T71lFB2YbyvxH+EuEf
	6RxpDOmpShY/XxZAlDycFXK0LKztDeN73RNk2BVryCmPMngNTsiMIomea7+yZS+6BTc=
X-Gm-Gg: AZFdTZeHTymOL7b9w74jqWgCYU0d4gMh9CC1uliaNv90iMKIEiInRE7gM75xoe+o5un
	7Sawerb1uqMHQbfy1YadlLKQBWgdwyjwewwAYIAOGqf66nudPeZ38uxHC9eDjEdIqUoYC85wGRx
	u6Jq3iQIs+0wRzcT/OD2OwXMcu9FFLTM/wSe1GJag4GpUn/lzEmlC9zMqUJyTUxn7L5c9FOBbeh
	fzQDa5UFwN69ZJFYqVQyOXQ2ETIQPpDJ5tvdadyx/YQs7bswDnRNwf1JYHtz5weo7kjY1rKOvHh
	iPiRIF1oaIiA/DXCZEPl1QlxhK/z5kRyoH6Zqgv0JJ7vhmwEgTQveflKDmYjheXTX8g3F4AemAq
	RzAqt32IY4g21Dp06icPrV/ca0+QLL/3ouwV9U4CnhDT+Wt9QGDDr/9DYocin9PP6DXP7nyaF11
	d8cGd5U6jjPJqiJRvS/ZIFqNBcKePIsSZWGlLLT5kA4ouP0drM2Z0LHsIdO5770EpHHbBsp1Q6k
	u2spIievYyDr71P2Uh5ypwfYyRPZjOu70QJZQrnMxjUdIYMG9guhdydP0YlEw6BLNRJOVjpJkWZ
	VfJha876EKAZRMNdM+ionviYVW6jna7Pg1DFspvpavUdJuWvNz6jt2uMXVfxh1RvDqdrWL1mroi
	3lYgPB8VSQg==
X-Received: by 2002:a05:6000:490c:b0:4a7:7bec:e159 with SMTP id ffacd0b85a97d-4a77bece556mr855808f8f.15.1794986827761;
        Tue, 17 Nov 2026 23:27:07 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095f21sm2901099f8f.38.2026.11.17.23.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:27:07 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 18 Nov 2026 11:26:40 +0400
Subject: [PATCH v2 2/4] usb: typec: tcpm: Stop replaying
 Source_Capabilities after cable discovery
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
Message-Id: <20261118-tcpm-soft-reset-sop-v2-2-b6decdc95e66@flipper.net>
References: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net>
In-Reply-To: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net>
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 RD Babiera <rdbabiera@google.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-usb@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681; i=alchark@flipper.net;
 h=from:subject:message-id; bh=2Ny84LlQ3zhUCvoplIosLPZF+LUcjGQ3WYkPbhaGJy0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT9DXbNE52xdtl1Z/11KjL/cndWy7xRuOQoGfmSV/zfe
 xnV6TIZHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1kypGhg/PLprV1P1Z/eCzyNR0QUX5SWd7lq279D/BgPNXos1lsw2MDEdXPd/
 VlbRO7IuNVs/FyId/d550VzwXHfnVbmpb2i6u+4wA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

When its first Source_Capabilities goes unacknowledged, a source that is
the VCONN source asks the cable plug for its identity in
SRC_VDM_IDENTITY_REQUEST. Entering that state sets upcoming_state to
SRC_SEND_CAPABILITIES, for a message from the sink that interrupts it
through SRC_READY. The ACK and send error paths go to
SRC_SEND_CAPABILITIES directly and leave upcoming_state set, so the
first SRC_READY after the contract sends Source_Capabilities again. The
second negotiation can cut into the sink's own Discover Identity, and
once ended in a Hard Reset between two FUSB302B ports.

Clear upcoming_state when SRC_SEND_CAPABILITIES follows
SRC_VDM_IDENTITY_REQUEST directly.

Fixes: af8b627046bc ("usb: typec: tcpm: add state machine support for SRC_VDM_IDENTITY_REQUEST")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8c5be904d772..b9146658f6e5 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5544,6 +5544,12 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_ams_start(port, POWER_NEGOTIATION);
 		break;
 	case SRC_SEND_CAPABILITIES:
+		/*
+		 * Straight from Discover Identity to the cable plug, rather
+		 * than back through SRC_READY after a message from the sink
+		 */
+		if (port->prev_state == SRC_VDM_IDENTITY_REQUEST)
+			port->upcoming_state = INVALID_STATE;
 		port->caps_count++;
 		if (port->caps_count > PD_N_CAPS_COUNT) {
 			tcpm_set_state(port, SRC_READY, 0);

-- 
2.56.0

