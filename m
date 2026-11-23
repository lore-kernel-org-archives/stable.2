Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461471;
	b=oz8/PEy6q4tT7UklnIQa6C0xIrBjobIfijSka+B6ZlXTdJ6SlpQGhZ1rQj1CzAXSr74E
	 I5lWmgpWPWVEKqGqAr3pRsd0DWgJI1RiYM3CpGnm1g2CLBz9hYTUwvFD8AhcqztLKzSzu
	 sK73MkM9Kr+qjUZbVFG+49u+0Yt2Bey8vqF/VZnqgPMIi+uC4qoOpyX6ru8zOwrwuIow/
	 UmVht8cTuj+zWxyNY9XqM6RpJ4Ff2mfhkzSfL2VJiAwWHBzPqje4i7LjCv0QiC2an/cSA
	 TBZf7ZmHahS6lF/nLg62MwisrMFOzP4bRi0uPr8u4Rnr/sv5z1Q/FnWqy71se7eFwsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461471;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G4qYWpqovmvk+9CIMhCz421wyrCHWIrInzS+iRYLtfA=;
	b=RwebbOjmthznXGsMv0+1CTAQvkhTkedAVMz9V+baY1Q7jnjDcpJjQTB+F/ONa5H0WAKi
	 fUyf1vLTdNQj6JAnSnvhExU2kZ08lglwf0ar0FRpz4qgRXoU4W+3SfIQ/CpkMXQHcxJK7
	 lALXxPoGUbBRkju42kM4kBAwzbecuI7mDtIRwe0XByryzy7V5PtMzTRKZky/mepkUJeDc
	 qdSd0mjS7LqexJFAMonDw3k7yeK7FfkN5CB6/i4DdwHRGqYBw2VBXt8XtdpBqWN7F7Vwp
	 aptqYaw/KRRVFbJccMB0zvLmxNV9lauueHzLX6RZEl/jJh64VWbkyFajyzjN9QyOSzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KI122c90;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF9606A31A;
	Mon, 23 Nov 2026 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KI122c90
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E001F000C4;
	Mon, 23 Nov 2026 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461470;
	bh=G4qYWpqovmvk+9CIMhCz421wyrCHWIrInzS+iRYLtfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KI122c90sEnif9hK3syRdPPZSe9CHD2HNBjHwGBi7zdCtUoVfisue0CSwIJ5XYb/i
	 mrjtqdbh1hP41qUITVa4+U882r9pJ8l4TCNX8Pox7246EQ01h16vMTYrZZgZ58rA0Q
	 BXAofhs8US8tJMvYbH3RMI94A6wzvT/HrNI5huoTYvumiVMZ+jAcyBdVxmXQxL+O4y
	 8lXhZnhIxRy22dv7VVNZmxVtKOvUA8Exx2dt+/5G96mXblF27fqKjIca2olF9Z7M95
	 i8dAA6lKoKLnku8AgNtE54C7lPTuSQX3893gdbevbUV8proxg6MX7BWv3+0M3XgTRN
	 zp4Wsz579O4fQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/13] mmc: meson-gx: Fail request when descriptor chain DMA mapping fails
Date: Mon, 23 Nov 2026 19:15:48 +0000
Message-ID: <20261123191703.179283-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
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

meson_mmc_pre_req() flags eligible transfers with
SD_EMMC_DESC_CHAIN_MODE before mapping the scatterlist with
dma_map_sg().  If dma_map_sg() fails and returns 0, meson_mmc_pre_req()
logs an error but leaves SD_EMMC_DESC_CHAIN_MODE set with
data->sg_count equal to 0.  When meson_mmc_request() subsequently
dispatches the transfer to meson_mmc_desc_chain_transfer(), the
for_each_sg() loop executes zero iterations and
desc[data->sg_count - 1].cmd_cfg writes to desc[-1], corrupting memory
immediately preceding the coherent descriptor buffer before starting the
DMA engine.

Check that data->sg_count is non-zero before starting a descriptor chain
request in meson_mmc_request() and complete the request with -EINVAL if
mapping failed.

Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
Closes: https://sashiko.dev/#/bug/linux-e22e5db6-4232-447c-82b0-6850ad48d2a2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d2b9b5df9596..f859d9ac0a0a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -914,6 +914,13 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (host->needs_pre_post_req)
 		meson_mmc_pre_req(mmc, mrq);
 
+	if (mrq->data && meson_mmc_desc_chain_mode(mrq->data) &&
+	    !mrq->data->sg_count) {
+		mrq->cmd->error = -EINVAL;
+		mmc_request_done(mmc, mrq);
+		return;
+	}
+
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
-- 
2.56.1.750.gf70dc682cf-goog

