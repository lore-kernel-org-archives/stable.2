Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915398;
	b=q9Tg26lBcUmh/Z+KFqgYm/kG/oBGaEap53ewq69A19iDb0Q5otGVMg87nDqEpZLrl0dU
	 LR2tbTAoL4uvOEzM9s7avPpF30guA+AZpzhYPVNbzNvgZvheQO4Q7/lIoQ6rJ0fBXEGK8
	 iQTnQlIvx6NLhtS5rh3C7+l1XLziVEa1capLtUmlgQudFFU0YWW8FCmAlzB8ipY9R+qnI
	 VWk4JFdUnbllDFoRd3VD0/VVWnEz+2Qijx4+i9uhZ69hezvwKhYiy+VIinG1w6Nk1lfqh
	 AjHcq9H2pzPEodKswTQGJHzrKLEpE79MYYOdupWXz2QpXdcqQ9c9AWgO38gXdTvwHaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915398;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pee9pP4QeB8RIQBY95fiYNoGPLQBEUz6Tv8/k+LSC4w=;
	b=ttz6XNXOBGU3fTCdaKn/PgLTpdHjN7+fISxJh7oX0Mw9CiagHx4ybtrSE0tEPYWR/8nn
	 Ky60KsPsSQN1HyBxvrul+9D0xLWpu5kADWTpgJQ+iHAaq02Dacp3s37VU+ecG94IWJmbE
	 mhQKggQTgfWkaAE8QRhkvSDAZtYcZ9a00wFPzP+VWrMOmaUBm7qgKJvDCTjV65dkoPOHh
	 9ml1CowKLGUFE/YDsStA0/pyCZbeH8lqW8XmKIVTNeV90I7vQTyKZIbOzliH+AA3OoAZB
	 9NWg2Ba6PFL9x3/CecBd98w0vRSdvT07SPJtbjbBzny/URpXnI2/JZR05dTwRF4RXiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Sd1DPZ1q;
	arc=none smtp.remote-ip=43.163.128.50
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221FE606A329;
	Tue, 17 Nov 2026 11:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221FE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Sd1DPZ1q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794915385;
	bh=Pee9pP4QeB8RIQBY95fiYNoGPLQBEUz6Tv8/k+LSC4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sd1DPZ1ql12ULapsBhlG1WzqwZCEzrBI44Soy2eXk/GbK3bHXq5NTtGPodC+2W6J3
	 EnDwYY8hNf2YLDm+HxKL6FmChPBA8080vPlpRfiBdB9ECtiwNKcL8OSAIt/yHC6gh3
	 +DOMD5wAqmEytScCGNeEnlSZBn1xwV6P4ELL/Fgo=
Received: from localhost.localdomain ([240e:3bb:3032:791:29fa:b4bf:6c02:60d0])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 916B4002; Tue, 17 Nov 2026 19:36:22 +0800
X-QQ-mid: xmsmtpt1794915382t4bmvah4y
Message-ID: <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com>
X-QQ-XMAILINFO: McQ2ZMlMYdZ8wUy72l/LqzWMAcLSML8kmiKM1BJ0xzHJdDw0CtolP8eo3h10OH
	 qOEOaTVLbtBqs91up1zXOXwaVkIHmegC3r96NZVdNUNUDXeX7jyFSbou+uy6sApMzjtaZc+R/EiS
	 FDF9N+jfaYb/GQmoP1E09yeKNJSmqCQU5btxyXhKP8WSwsmnk7PYJmXa7a2ngJWYAfdFPcqJDh9k
	 5RMApOMy9DTL5t67vN6d6SBqEmQEJQeGUJvOvyAnJJNAFIJw+YZ88tsYPgQcpWk1MJB4WnAtvnz7
	 /+ZKdHUPDBjeD+ZX0RpgGutfG5Du05S3+0bSdphCTslQYU0E+IwDIgIUYxn3exf0Tf0RhTfRxl9q
	 /MTmXpSFtVOK5UkdSnwCEqDWJmFI0psbiz6743uX3Th6zxBPKCiGt67H0XQujCDrJ9NHpXvZSSGi
	 uWyFdwNVvWCRbH46hGH0bUYKjM5U+3b8nAL6falxttJo61GyfdrV49Z8M8xKeomUoOZV1Hc0qCva
	 qIX0rz9N5Ij3iRUxpVllcFSuKETxMfTQqjn7iiq7qdi6SeX8w/hJ8Y5b56jmRRk+c+fFO6wWRLYE
	 BQVEPMr7ejxxvxGA32YgjChXduYe74OPrrIqjajdmpIYQ+n/Tk+nrx+Kj0WHOdblYZcAHdiX0wDy
	 eCk2YElAGPYW2Zld/uDYEAAHatDnhK94eoZB0bMc4qc3Np8HtOWEO0CtxKGeFvutmVMvXURZbwON
	 9quiVmbfLGUIkeOhoSssP1eCRP8X34ov/RorUuc+FIU0JZ8gnDWU6A6JI3Pz50Ih4HpIBY2jny7f
	 z7O03ZjkTMDX0/S9U3Gy8K5Sa5XTcy1/zWh+HnW94xuI9WoRDnZaNoUjss/VswsNsMeCp8B2dlly
	 AT9BRYwsRJEhjhR5Tga7KTFfAj1a1w4ruRD1gCmsvC7gJwWVvjg3PFeff6LlR0Kw8PqUemIgXRJM
	 CEewt7QiGb2REuyDHCfNjWGaclSgcV9UygFSlbKPTmXxUaEKBH4nzJXJes9zZvELeOLN31DMS3ex
	 1M0qQS3RvUYGVU7lEQYR7LmSj2lidGUhgOKhxMFacZA96IvbWtOxJXspWsaaA=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: memoriaru@foxmail.com
To: linux-usb@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com,
	badhri@google.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	memoriaru@foxmail.com
Subject: [PATCH usb v2] usb: typec: tcpm: align SOP' Soft Reset handling with SOP
Date: Tue, 17 Nov 2026 19:36:21 +0800
X-OQ-MSGID: <20261117113621.75401-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <avw6CtZkJqvwj4eL@black.igk.intel.com>
References: <avw6CtZkJqvwj4eL@black.igk.intel.com>
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

From: Zhang Hewei <memoriaru@foxmail.com>

The PD message duplicate-check and the SOFT_RESET state handling treat
the SOP and SOP' channels differently:

- tcpm_pd_rx_handler() exempts PD_CTRL_SOFT_RESET from the MessageID
  duplicate check on the SOP path (the USB PD spec 6.6.1.2 note: a
  Soft_Reset Message always carries MessageID zero, so the duplicate
  check must not drop it), but the SOP' branch of the same switch has
  no such exemption. A cable that sends a second Soft Reset over SOP'
  (MessageID zero again) has that message silently dropped by the
  stale rx_msgid_prime comparison, and the cable-side re-negotiation
  stalls.

- run_state_machine()'s SOFT_RESET case resets message_id/rx_msgid but
  not message_id_prime/rx_msgid_prime, while the initiator path
  (SOFT_RESET_SEND, SOP_PRIME branch) resets both counter pairs. After
  a responder-side soft reset the prime counters stay stale.

Reset the prime counters together with the SOP counters and exempt
Soft Reset from the SOP' duplicate check, aligning the SOP' handling
with the SOP path.

Found by code inspection; a software TCPC stub was built for the
responder path.

Fixes: 6bd181ba60 ("usb: typec: tcpm: add control message support to sop'")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 tcpm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tcpm.c b/tcpm.c
index bb90211..95f748d 100644
--- a/tcpm.c
+++ b/tcpm.c
@@ -4200,7 +4200,8 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 		*/
 		switch (rx_sop_type) {
 		case TCPC_TX_SOP_PRIME:
-			if (msgid == port->rx_msgid_prime)
+			if (msgid == port->rx_msgid_prime &&
+			    type != PD_CTRL_SOFT_RESET)
 				goto done;
 			port->rx_msgid_prime = msgid;
 			break;
@@ -6193,6 +6194,8 @@ static void run_state_machine(struct tcpm_port *port)
 	case SOFT_RESET:
 		port->message_id = 0;
 		port->rx_msgid = -1;
+		port->message_id_prime = 0;
+		port->rx_msgid_prime = -1;
 		/* remove existing capabilities */
 		tcpm_partner_source_caps_reset(port);
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
-- 
2.39.5 (Apple Git-154)

