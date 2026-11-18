Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.74.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026253;
	b=qr+3WEL6xb8aBN3l2Dop74SsoKW1GVoO0b36dThMS9tinNbvHGvBgyz4Ko7JQQ2uod/C
	 1bm48rXNc/GGCv2MeRRxRnSO+MedzeeM4ksPMDLfh01skEMEz2H8MnHpWdMwyaROSJYsZ
	 095FQ0P1DS4olxoaikbcPAwaSpWQ7a9Fksg3ai4t9iOCHO8aFcxKEXgtOBkTL7NDyOuUC
	 KIiRjGg57PIcT4BvGic5J6yG0+kxl7XiAKeqFrLujoZBz5p/87vIxIwdVGyVtv2LUIMHE
	 8OOUniSQpZfAnDQfR2v01Rl3zw7kZ26vsCbeTxshXgXe62AihxVxYc58FxIKwZF1VUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026253;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Info-Out:X-JNJ;
	bh=G/lIww7et98viW/5VX21jdn8thD7SKB2sXXE7AmwGI0=;
	b=tLeVI7lubrdTjM8k3ECHE2RxG03PAzTNUfLuiCyKT7XegVX4s2QwXt8yGIQ4Pm/J0mLq
	 IrfICsCCcab2FV7MUTV9aQJvqwwJqSv50mvXety2QTNvddy9/qCpsjlTFAZkALVKjNsaT
	 d9Bwlf8B7WnWyQlGk2uYNCSkH+1rIHRyf6FXvY57NRLI69RzVibYvV3aUyvaopp5NqZEs
	 cShunCLvrFoMg1pVZoIiWMn1y0fS62hDsPxpIjsdkamEsLN+N5rZ3SfGVnEXfSbgIDmfr
	 oXzFythSbOMDyfMXj1wYVwC6dsED+82ajekTxaslTw8zYqa2jkQ6Fj0plX8iAtVfaNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=putintsev.com;
	spf=pass smtp.mailfrom=putintsev.com;
	dkim=pass header.d=putintsev.com header.i=@putintsev.com header.a=rsa-sha256 header.s=sig1 header.b=JRLjZPDL;
	arc=none smtp.remote-ip=57.103.74.231
Received: from outbound.ms.icloud.com (ms-2004l-snip4-11.eps.apple.com [57.103.74.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD6606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3BD6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=putintsev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=putintsev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=putintsev.com header.i=@putintsev.com header.a=rsa-sha256 header.s=sig1 header.b=JRLjZPDL
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPS id 5606E180033D;
	Wed, 18 Nov 2026 18:24:10 +0000 (UTC)
X-ICL-RepId: 01a1efe6-e9f1-7911-b26a-4b06a4697068
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=putintsev.com; s=sig1; t=1795026252; x=1826562252; bh=G/lIww7et98viW/5VX21jdn8thD7SKB2sXXE7AmwGI0=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=JRLjZPDLnoiSwSA0CnV3M1PUPBwZ6oB19NSKQBLlBqjX2GgKn9ZWR6R+3NWoHemYzz/uBaOWHm3hBF9xjoRKfj2TWHcvK4v7eGh0nQNZI6fCyfOPRldaSB7Hoc6k7cVoIAKfBZ96d5kaBmu9R++Q398mgE7A/mufk5er142b9jGMD/sjSDxyyM0CE8JY7dKioJqNq59xdb6y3kIdOjquFkCsiHZs7iIs0LZsCSTQZ+lxSbTq+EUODbLgmwTLe8aIWYnYIUAdBHYbNEahH0fkmUTfImPU7FczYaYkeP3jQaKCiGTWHJvHtnEEssax7WICzJUNhZfE76RA7eRAVRcGPw==
mail-alias-created-date: 1771854267065
Received: from macbookpro.lan (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPSA id 2D33418000A4;
	Wed, 18 Nov 2026 18:24:09 +0000 (UTC)
From: Roman Putintsev <roman@putintsev.com>
To: roman@putintsev.com
Cc: stable@vger.kernel.org
Subject: [PATCH] spi: tegra114: re-assert CS after a mid-message cs_change
Date: Wed, 18 Nov 2026 13:23:44 -0500
Message-ID: <20261118182344.23056-1-roman@putintsev.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-ORIG-GUID: fixuk8Pl4qE1UFF6HupDkA9nKkH2HWF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3MyBTYWx0ZWRfX3AY/PZ6ou0e6
 y54M9gYndeZFmAI0xrSSz/ASgByP27cgvigKmbm6A9yEcdTtA5TadHcfxw0L/OVCAV9Mm5kFhgB
 rl6sreXFJY964DT8bSRy7x7tEdbCWAkS5/PMHHqrTZHiuZGuC3foxzGIFI84YASru4NVwJWbQur
 PMrewXNBpnx2myD6MKL9WG4yLUfNrxdBE8QerNPkF7rfs+8EjE30NrPTMhxYRv/CYfBbfVDRYSB
 knfYs9y+ySMiQsMfJjQUD4uhCxHcwPeieO70iM8eOEZSNcBY43yZ/DMDUxkZzk28zRqd66Xgd2Q
 BD9jFy0CW9D4B9nyTbe19Laki9ciYjjNLaYdIsiUYBRCpP62y6DetgL03fii9g=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3MyBTYWx0ZWRfX10Z0QX3L83Gw
 u7nRQkxrTqk0e3pQN6hfbckpJHXOBg0JbZ2aJEs74hxGHXv3uJgACITF7DKXbwOqxrtbaz/cDdv
 31Estk1BIVY8HXij6PZ9RsX6rdMmgf4=
X-Proofpoint-GUID: fixuk8Pl4qE1UFF6HupDkA9nKkH2HWF9
X-Authority-Info-Out: v=2.4 cv=MI31C8Zl c=1 sm=1 tr=0 ts=6afded4a
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kibvr5HLtuNvmma_iept:22 a=hnSFvG8eRDSKuwTuik2m:22 a=VwQbUJbxAAAA:8
 a=gNxGhvmwAAAA:8 a=7g2LsxMrY8pxi2ky23YA:9 a=O8hF6Hzn-FEA:10
 a=yjIKAdwAKDrTRT0yDhyo:22
X-JNJ: AAAAAAABAlrGLXguhdvmA0BlvF8fHGJmQmv49Oga/QBqQDuJwPHhcudPNwolSrQ3mlD6um
 QFbNX2cYZ6NWtPsQ6DfdhpsLAVFaunQYLxbmvp8Fjvi1/MsDnm21lIMMYEc/7cRZ/OxfF+
 jt4aWEfckt0D3LIkYov3QmClg1nSVrfZH5NlyvSJLoQZlqxYAtP9cnajq5IDcLhSjY2pKV
 WKR2oiFA4jR3/K04Fy0Icwq1rl7e24BNP3rLEyX2kZc3I/3XmCiSrjgWW5SS02NhHV2I7W
 tM+yTyqUBh+/Xm7GoQtzS7NOatdqCJzUUnN3AOdT5e8pfiZY8r9TFFOa6nLHl4BAsTXTZR
 4X+YvJkCVgaMselOdnVMFHVggDOP2V4j7ZeDZEJKJus5Lxm2ULUKQbFreWMB1XFZPEDKC3
 5KLLNm5lvhN02ItB3pFek6Ek/jpBuP3X+rulqf2PD4fEzIEvc18VIhJt8S9oCH1J/wgGru
 fDHVn8PJE/88fWtgqM5xUw+KGDGlLypIQszY9OkxqUZX3hrqrG+jSea2WjBMJLYMKPHjlp
 FRlzUFYQvl0qAl7NlohBIH2vbEq45PppfzoJu4OxQALSsYMwhxJf63M4WYI6MiM4u3F8d1
 nTW73DwQ3rWQUMJaz1JQsh9q5zCBbGEO6XjwOpy9y2T/W6bC5zz8zp/F2hu5waSqwfjrzO
 q3TsPcf1HzF3/rjqqmyG+1LD/ipndBIijX4JLrRDvl8DFIhqBU7+k8gVlqp4nwbUsZTxB4
 Km6Ka6ZUDGZbNHOecvcRXERLvr345kG+NxX9c3CFv6XW4C6ckyfcDvjAY0qrzn3SK6YKSz
 tbkVWwWWHO9K13fS7XH5umNd2CrJLQdNXKE05Awq7N1r7qsGLE1RNoA+badjg5J9OGpUiF
 RL8YJT8ciZgUOA3WwbSck2hnZytuCGvVI1P7dTiZ8YNcNJvk7/iY1XsNelaWwWyrfXRc3S
 cp5iYpHBgQ0EtP2fqMRqXAGGTDWYfh+RQ3VkxI0FlAAwP7Jy7QqKemSb+KwchWPIHrfNI/
 L5V7D5EJ6cnsIUUkR+S9WA96qvQZ7rnbh6qfg1lfS9B9Xi2SZ/j4YsFe9PKjbHp1NHaY+q
 w8VaTAsspWPDX7ygAey4qJXQ/aK4vdnQhbWijLKvvSbSWYQWyon10D/coxCONx2pD7+6ZH
 5jHuAOoRi551NRtdVXpz7NmaCFYmWn6w==

When a transfer has cs_change set and is not the last one of a message,
tegra_spi_transfer_one_message() ends it with tegra_spi_transfer_end().
That function deasserts CS and stores the deasserted state in
tspi->command1_reg (SPI_CS_SW_VAL). The next transfer is not the first one
of the message, so tegra_spi_setup_transfer_one() reuses command1_reg
unchanged: the controller clocks that transfer out with CS inactive. The
slave never sees the data and no error is reported.

Every driver that splits a message into "write payload, toggle CS, write
trigger" hits this. mcp251xfd does it for every CAN frame, so an MCP2518FD
never transmits: the frame reaches the chip's RAM, but the write that sets
UINC|TXREQ in the TX FIFO control register is lost. Reception uses
single-transfer messages and still works.

Before commit f3e182c33e53 ("spi: tegra114: de-assert CS before SPI mode
change") the deassertion did not touch command1_reg and the next transfer
asserted CS on its own. Mark the following transfer as the first one of a
message again, so that it takes the setup path that asserts CS.

Tested on a reComputer Orin J40 Mini with an MCP2518FD on spi1.0. No frame
was transmitted before this change; with it CAN traffic runs in both
directions with no errors.

Fixes: f3e182c33e53 ("spi: tegra114: de-assert CS before SPI mode change")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Putintsev <roman@putintsev.com>
---
 drivers/spi/spi-tegra114.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f43f2df..d2fda21 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1116,6 +1116,8 @@ complete_xfer:
 		} else if (xfer->cs_change) {
 			tegra_spi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
+			/* CS was deasserted, assert it for the next transfer */
+			is_first_msg = true;
 		}
 
 	}

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
