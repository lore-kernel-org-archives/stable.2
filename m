Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458795;
	b=SWk4oWM2G/eY5eUJEiJ7REwPNKCOZ+ZzPluSIAFqjHQjEZZCvd9KtM2Xcbq+VoN6ivuJ
	 qsdt11mN/NrKO6RD994WdTCEXmj6OyJHIUDqlDTtqrOZNX561VN3iyN/sB1NAjQq9nFJC
	 SQ7yDCIRsgE6CS5+dmutEVL+bp3hZ54ST6/rVSKkneQ+n/LbREPhVSBmiUiHsV7b9C7hl
	 RT4wW/Fv3/KDBZgh0IeIqmRvY85t7nVPyyGdcPzG7nol4CaW7u8UNRWgHr2wCkRZWxtWQ
	 QjcKsSvQ5TwB39vnmePJacVRqfw+lXolGFNosOjQDQgeGrsH6EBxMKRyHJgghOo2ELQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k/vvoWLU9b5SxPTSJ6QaYudpiRsLaOpf788XZvWh2s4=;
	b=bkB4aPDA78Iz+JDeCyrVTynyupT0nknnbB65QbwsXscSWTYHPGt+jwkPge70avNF+u3X
	 0kV2b0Frc78e37o4tH9UG4t3hPXfYO9NCOT6QItqYGoJKpLtzjmWVO9bUIskGIqNCu83r
	 xUjmkDiiG8atfb3STZ662+wKfPgggPKfAEjvZTFO3Crye5wOXYMeKtNxX9lbGI9Pob/du
	 nq0YOU9K1p3eEf6XpVAclfv7dtCiCYfkspKMB8RakJUg7mit6AxqLI0sMQcHYAsJxCdP/
	 O2pIyY0rtKC67HmYloZaRhJRRJJIN+++Fm7QYV1XxNj1uBdn8Pfib99FzqzqlIOmxFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRaYdGJV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC3606A335;
	Mon, 23 Nov 2026 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRaYdGJV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6714A1F000D2;
	Mon, 23 Nov 2026 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458794;
	bh=k/vvoWLU9b5SxPTSJ6QaYudpiRsLaOpf788XZvWh2s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hRaYdGJVVUOE5MXG3UXMmA9NOzLtrpn6IBrCBE/cElmoA55keTqMDjjVYCLuLwwMp
	 qJI1Glt/7M/CYqHbCsorn+fPldDHf8A/GsmaYm6+safgRB29bxY6TU/WcZtf8izgvA
	 1eLx265/YqmZMPEZ1qZYwOO9LIswtJm4EhkqBlHnk0q2nJU7VPx9WDPque7dqNQHQc
	 jr4DJ9pw9Ai99YJun6N4LHfnFmrqdNoSaBPOmJWWaOFrlalcohoKgfS1c543Oi7Psp
	 +jfuWUUiZsXAWa+ZwYi1jNKQJcCIyVWNYq/LR7Jt4979Gt96SnCA83jNLZI46GZU5v
	 ydA/+tSYUBFaQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Bridges <icb@fastmail.org>,
	"Cheng, Wacom" <pingc@wacom.com>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] Input: wacom_w8001 - use reinit_completion() in w8001_command()
Date: Mon, 23 Nov 2026 18:31:16 +0000
Message-ID: <20261123183200.3900004-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

w8001->cmd_done is already initialised in w8001_connect() before opening
the serio port, yet w8001_command() calls init_completion() again for
each command.

Calling init_completion() on an active completion reinitialises its
internal waitqueue spinlock, triggering lockdep warnings and racing with
complete() in w8001_interrupt() if a late response to a previously
timed-out command arrives concurrently.

Use reinit_completion() in w8001_command() instead.

Fixes: 3eb1aa43ef5c ("Input: add support for Wacom W8001 penabled serial touchscreen")
Closes: https://sashiko.dev/#/bug/linux-002efaac-c345-4827-8f1c-7b9d9226c713
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/touchscreen/wacom_w8001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index d8d1cdc3f09e..a85ef93bdd29 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -362,7 +362,7 @@ static int w8001_command(struct w8001 *w8001, unsigned char command,
 	int rc;
 
 	w8001->response_type = 0;
-	init_completion(&w8001->cmd_done);
+	reinit_completion(&w8001->cmd_done);
 
 	rc = serio_write(w8001->serio, command);
 	if (rc == 0 && wait_response) {
-- 
2.56.1.750.gf70dc682cf-goog

