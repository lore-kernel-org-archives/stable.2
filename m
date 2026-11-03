Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748413;
	b=SbMkBV3qbOJ6gtgERAbKmfn2UuvRi96yw/c9BAHhCcXgih7PDjKSxsrWmck7ya3nEB8F
	 onPc8GK6fyzxjA8I5GZiJCzy6f7FZUknk2K0B6qKhgXvC+Evf0+Pmo7+j/L27DFZSfRog
	 WU8+GdbVqastu1G9gygk+LErLncNL8qBNNCjZc5Ydwd8JHRbACnRK2cz568gMYH7zAii5
	 vC8dmwTGZBDHoq+1VDz2s57oWEQz3hzuBKLoDc+J8t3yJ+om16qr7gW0yNYUZcxlF49Ls
	 5yLYJVj3HKSsqOYHuCFiZU3Hh5ffdcHAODu8YuUOqx1vw9w5c2EylV6cNCtRxCxF8Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6GC1/D8rCTZG76ZRBb6JFA+whGRoK5mBSHc05PTJ2Kk=;
	b=UONvgQuq0IdJ64GkRb1HzV0JBa+qXZUd6tP1fV7SQ8fzAExla28mFRjcM6vA/EIDlfoE
	 1ApxEFmcwKMRHypvQzOt/wRXic4oc1FN1+ukK9TlbidFtytDBRxXJdZeqrbrxFPX/sazt
	 pqpoYoFGzHMwu0MHYCb4U4VoIMmbZPT1vvPHzAmjARHSvwUYBzOr5No3uMOJ3Qk5SUqLH
	 NoUvv5h8b6oYtJrwK5cibdRza/nabZrK4HD5ofdWU/0kzIcMk6+XlmnmWOoWaVhIQI/X/
	 ctYKAela/XGd2b0CUiCLDMUHfctTV0CgUHoSwZpEhFUQfmctfbQMnAXfe1iEUR0tjZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O9Nn3YTE;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B87606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B87606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O9Nn3YTE
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so717755e9.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793748411; x=1794353211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6GC1/D8rCTZG76ZRBb6JFA+whGRoK5mBSHc05PTJ2Kk=;
        b=O9Nn3YTE8dyOZfeNiT5qpPNlfOm3EpYECrP3B0GPokTicn25MDq/RklC3lk/43H4o2
         YwK5z7zAxc+yq5rl3ajLofqGchDVxhiHP4kdq85jIj5F70xyhoRXzXtkg2lW02UV/BF/
         0XtglXYfHNqnVdECtu8K0Y4rNO9WiqaDuopEEZCCIVpGbHrAY1EgS3Z4YZBYhlxmFVAv
         RKqPEJcilYuUi2qnG7qmEw7L9cNB3HppLx17T4mXPAvR49XenhXqZgIMr9MtTrfMk57w
         pj4Syrncp0XCTySp4/9eonuhN307DFVRjQIccB1QOecqL76g28Zlbl1dUvm7fhW8LcG8
         UTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748411; x=1794353211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6GC1/D8rCTZG76ZRBb6JFA+whGRoK5mBSHc05PTJ2Kk=;
        b=Ck0TsaSIqX8bL+LwQjXw4BvBDiVnhVSL6OOFXrJKvUCRIjoIvm/ug9zfau0wIfo8zg
         fxlcKTyhGqenGt122PkcJzl0KH5rq66BLbgTmBpwfi0wxq0SrYeRwl+jAMxgo6OblXwG
         kffaIG74nb4O3z1QxdKCt70isDm4QlxBUTmZTWuNani/xJ3xNXgvXFTPqEPpGQmVujWW
         f+9XGiGIEb2eALRELFf9hlyUNvd48Grrw5941oZ3EAVvnbEW2j5006Q4164dzY0b0yIk
         xFLzUBypf4NwcZLhiog13gU0tv/0SLvRbDHVMA00kb4hHwSqOccWsco7GdhAKbuKCmkL
         NxmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqwo6QNFbvTNlsP+TCyidkNUtiBI5nhnfnzegJ4/6ydYJSpRdQdTNFJ6LNXX7aowNnV/gLCII=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZMVu4XBQaBgqdOqorU7IH2QFgDwBqDTNatDeHsbUpjJ2fuuT+
	0yt5ckqsYfmf2olP08DaGaK5ZKl7dVuCRr43r9CD+nI0sP6m4fo88Lc=
X-Gm-Gg: AYBFou35ZT+wxCVoCUSRnVImiUUH9jyhpyh2/W5HxqQ9VuIlsQOwur2KTsnC3Tsw/Pl
	H+FgRSQEiCiIywkCbFImMqALSwd+xH4ESkpJ+A7KKSROYCJBfFf4yam6BtKEGF2/Oyltg6//+sm
	s01jQ/VfdRYDpBQXR7wgRb8/ZA5wuQl4asd0ooQgtegkrjyhxSkOzbxRit1L6aFOTEq/UMUs6so
	CMuQbGeT+uxaQxNoBbZWJiLZXKroYmXatdHdv1rPXVhjmQmGk8xpOSs9Ypkrsyc0mtUmFbtTsVw
	BIpp5tYZ7F1V3ALr/nAicpLAz0+QiW3Wpbbjub6tMQF7qYqbqIAqoCJLG1l9n9wNTpwANa5k17/
	VE7vKMFuHV/y7fvbfgApZPLYcJ74NwPRDqrmwFy3ogotfkrumHtJ/m5nSXmIhj8TxtSxnvm0Z/j
	MpfhWfPXUCY/pTHS/aLp9+WT8v814UJ7X2QOR/bgZ5iC3JXLHUSV3SEQnrgJ03qxtgg6X3kKWNW
	xckf9lUddCQfmjkPtu8RkQOx/K+vtedkD39YX8YrIJQ+t88ND4/0ylfIT3bi/EM57djXQI9nPwd
	8sstkDN0GY6UW2uQSac=
X-Received: by 2002:a05:600c:83c5:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4ac1970b976mr282294535e9.33.1793748411490;
        Tue, 03 Nov 2026 15:26:51 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ecdasm13822005e9.5.2026.11.03.15.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:26:50 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless] wifi: wfx: validate num_tx_confs against message length
Date: Tue,  3 Nov 2026 23:26:50 +0000
Message-ID: <20261103232650.13350-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

wfx_hif_multi_tx_confirm() iterates over the tx_conf_payload flexible
array based on body->num_tx_confs, but does not check that the message
is actually large enough to contain that many entries. Add a check
comparing num_tx_confs against the available message payload before
iterating.

Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/silabs/wfx/hif_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/silabs/wfx/hif_rx.c b/drivers/net/wireless/silabs/wfx/hif_rx.c
index 64ca8acb8e4f2..42417db66c128 100644
--- a/drivers/net/wireless/silabs/wfx/hif_rx.c
+++ b/drivers/net/wireless/silabs/wfx/hif_rx.c
@@ -62,8 +62,17 @@ static int wfx_hif_multi_tx_confirm(struct wfx_dev *wdev,
 				    const struct wfx_hif_msg *hif, const void *buf)
 {
 	const struct wfx_hif_cnf_multi_transmit *body = buf;
+	size_t needed;
 	int i;
 
+	needed = sizeof(*body) +
+		 body->num_tx_confs * sizeof(body->tx_conf_payload[0]);
+	if (le16_to_cpu(hif->len) < sizeof(*hif) + needed) {
+		dev_warn(wdev->dev, "invalid num_tx_confs %d for msg length %d\n",
+			 body->num_tx_confs, le16_to_cpu(hif->len));
+		return -EINVAL;
+	}
+
 	WARN(body->num_tx_confs <= 0, "corrupted message");
 	for (i = 0; i < body->num_tx_confs; i++)
 		wfx_tx_confirm_cb(wdev, &body->tx_conf_payload[i]);
-- 
2.47.3

