Received: from mx-relay48-hz3-if1.hornetsecurity.com (mx-relay48-hz3-if1.hornetsecurity.com [94.100.134.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17331E9B1A
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390163; cv=pass; b=Zp6H4LhQh0JPrk2vJGBgTrMa2QKauprDY1slk0nf1riWKPV8vapP++ebOd5boZsjqoGQS66F5c3ee6Cu1OR9sIFpPGvo7FkshHuptkaOfJVhvtmKhZeavLiUQ2V246+iOjoH8eA1C+XN3vYzr93nAYJg/ORt/73YGHpts+9cAfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390163; c=relaxed/simple;
	bh=N+obUYDHSwW6SvDclE09pHgjCgk3YBHWvuqWv/pfUlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vqt+hKPQHssxB8UDTQJ10/Lmpq06IFPxYYAtofIYX6b80Zxhlpujj512DvLR47rpTO7j8xLbdrOzqeu42h47gHvEbj7GbqkKQ6J4PX26a6NdarX0o9h4mzqTkYgIzQJMaLsS5/8a1SGrKS/04wdEWnDwEfTcnScI16Ixn+pOm40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net; spf=pass smtp.mailfrom=marcant.net; dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b=uU9d5b0K; dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b=UUdMSs0b; arc=pass smtp.client-ip=94.100.134.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcant.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcant.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marcant.net header.i=@marcant.net header.b="uU9d5b0K";
	dkim=pass (2048-bit key) header.d=marcant.net header.i=@marcant.net header.b="UUdMSs0b"
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=217.14.160.69, headerfrom=marcant.net)
 smtp.mailfrom=marcant.net smtp.helo=rossini.marcant.net; dkim=pass
 header.d=marcant.net header.s=gandalf header.a=rsa-sha256; dmarc=pass
 header.from=marcant.net orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=rvdl9kcK3h/HGJkyOzJDtw5a44dH9kR79k1JcbpYz1k=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1786390149;
 b=qDMxRA6bhASWnCqGlyHLtGSaRI1WyjpFtoSRPs87XY001whOOyjEZcROQGKVNwwbwfiXf4eg
 B8uYbfISaHMgEmdC+1TmxCPPPnqtoHSFFvH4O50Fblb7KfIwUoWbMRhjPIsuR/kfGNTn/OmgApb
 nbGCW1W2hUyVx4kaAXzhNGj3hieQLtbFUmj+oXyZ6e09mQL9qgpBGIL4SvG5wBOXmr1LnchbGVz
 s2Zk8H19eUs61RcPIDfzBihT/ya5b/I7yt50ztGpNkIFTA4EOpu1eEhXoL1ROpqjQ66BPLuti31
 2kcUI0nLD0+30mRHmNB2sWiskc9+nnPLO9zk/SOZaEGRg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1786390149;
 b=TwDzXSY5gzrjfm9v9myfNj4sQFRHZQp5rflbaUCjcQAAC4ZVTm2yGilP94p+VsTsjV3YBtUu
 yv8/v6sDnalhh4j65d2npBdMkeFx59vhv4hwPWhLMxLDxpZp8ZF1wB073YfdE/WHwl6DdH3SmEI
 e0vCxHSIlReirqkgxcus8ieUVpwjizYyLkNHzCBrcBDUNzw4VOXO4RjD/2tTakMb4QIJtURQbdB
 yWSuTknDKOovFgS8Y0BuX6D8ciHLGadjm7591bSyv6zuQkfJXpZN+182lUHGHqNNC7z14vtugpv
 yPpjcmrKCdMBTFnBhzHvtzfBPtY4dZlkf1I7hKC8EDWZQ==
Received: from rossini.marcant.net ([217.14.160.69]) by mx-gate48-hz3;
 Mon, 10 Aug 2026 21:29:09 +0200
Received: from futile.kalnet.hooya.de (unknown [192.168.203.16])
	by rossini.marcant.net (Postfix) with ESMTP id E3F4F960010;
	Mon, 10 Aug 2026 21:28:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 rossini.marcant.net E3F4F960010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcant.net;
	s=gandalf; t=1786390140;
	bh=rvdl9kcK3h/HGJkyOzJDtw5a44dH9kR79k1JcbpYz1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uU9d5b0KrTrh8RpzxO9bEvV7y4JAf5cEkEXM34laS61gnXcp+vHY9nrG+PLISI+kA
	 nMxw8aL4DLhLlgz4Hhk5aTNgrJi4t/MN8wKX0uVf6DhSHM8m20uKRFTqW6hQtE0rKw
	 Ks5cXKjmf1/2u53x7YQWAiveAviO5HhqiI0X3bm4=
From: =?UTF-8?q?Andr=C3=A9=20Valentin?= <avalentin@marcant.net>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	Kalle Valo <kvalo@kernel.org>,
	avalentin@marcant.net,
	stable@vger.kernel.org,
	Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
Subject: [PATCH v3] wifi: ath11k: run ahb shutdown() teardown only on WCN6750
Date: Mon, 10 Aug 2026 21:28:59 +0200
Message-ID: <20260810192859.949348-1-avalentin@marcant.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260808213551.4169863-1-avalentin@marcant.net>
References: <20260808213551.4169863-1-avalentin@marcant.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:avalentin@marcant.net
X-cloud-security-recipient:stable@vger.kernel.org
X-cloud-security-Mailarchiv: E-Mail archived for: avalentin@marcant.net
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-gate48-hz3 with 4hJlDX1vqSz1kNcF7
X-cloud-security-connect: rossini.marcant.net[217.14.160.69], TLS=1, IP=217.14.160.69
X-cloud-security-Digest:e56c1128890484b534035f16abfc5fd8
X-cloud-security:scantime:1.758
DKIM-Signature: a=rsa-sha256;
 bh=rvdl9kcK3h/HGJkyOzJDtw5a44dH9kR79k1JcbpYz1k=; c=relaxed/relaxed;
 d=marcant.net; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1786390148; v=1;
 b=UUdMSs0bgUA0YP51/z4Kj+aLbwYHT4EgnAOkm6TqRZ6IuePi0lc2KCoIbkOhgUZ4bP1hyU8o
 Lst06DlkzsvWbKxfVIcqaZADZdrPixvAW6uCc2iZLOikavZdYXWekTpZPhbfXnX/ev7l3rE0G48
 Dk/8McEZ229k/mBp5/7f6NSjIjrxEDHO0Hwn3HbfHTEXgbcUVU3oS4GrvdBzcwnoLbPQPUPIlwM
 0hx/7rx3UZmPxjGYnmb6vGsCzhEx2su4oDuovwRt3crTK0FEO8gIF1rAwQ06Z1zZ0bDsRdAs82P
 1182dRFeoYf3j/lVGcvp9ivO5cz4WJxUJGVL8hDgvwecg==

The AHB shutdown() callback was added solely for WCN6750, which must stop
DMA before the SMMU is torn down at system reboot/shutdown. It was
registered unconditionally in the shared ath11k_ahb_driver, so it also
runs on the IPQ AHB targets (IPQ8074/IPQ6018/IPQ5018), which never had a
shutdown() handler before and have no such SMMU requirement.

The commit message claimed the change "will not impact other AHB ath11k
devices", but it does: on IPQ6018 the teardown stops the WCSS Q6 remote
processor firmware, which leaves shared WCSS state such that the boot ROM
hangs during DDR training on the following warm reset -- only a cold
(power-on) reset recovers, so a plain reboot never comes back and needs a
physical power cycle. This was pinned by bisecting the teardown: skipping
ath11k_qmi_firmware_stop() (i.e. not stopping the Q6) is what lets the
warm reset train DDR and boot normally, whereas none of the q6v5 power,
reset or clock steps reproduce it on their own.

Restrict the shutdown() teardown to WCN6750 via hw_params, restoring the
pre-regression behaviour for the IPQ AHB targets: they simply have no
shutdown() teardown again, exactly as they did for years before that
change, and on reboot/shutdown the SoC reset re-initializes the WCSS from
scratch. WCN6750 keeps the teardown. Module removal (rmmod / remove()) is
unchanged for all targets.

Verified on a MikroTik Chateau 5G R17 ax (IPQ6018): before, a plain
reboot froze in the boot ROM during DDR training; after, it trains DDR
and boots the kernel across repeated reboots.

Fixes: ac41c2b642b1 ("wifi: ath11k: Register shutdown handler for WCN6750")
Cc: stable@vger.kernel.org
Cc: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
Signed-off-by: André Valentin <avalentin@marcant.net>
---
Changes in v3 (per Jeff Johnson's v2 review):
- ahb.c/hw.h: fix block comment style (/* on its own line) and drop the
  chip references from the generic code -- describe the behaviour, not the
  chipset; only the hw_params initializer ties it to WCN6750.
- core.c: explicitly initialize shutdown_teardown in every hw_params record
  (= false on all but WCN6750).

v2: https://lore.kernel.org/linux-wireless/20260808213551.4169863-1-avalentin@marcant.net/
v1: https://lore.kernel.org/linux-wireless/20260807094858.1548216-1-avalentin@marcant.net/

 drivers/net/wireless/ath/ath11k/ahb.c  | 10 ++++++++++
 drivers/net/wireless/ath/ath11k/core.c | 10 ++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  7 +++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 1e1dea4..18f7bff 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1288,6 +1288,16 @@ static void ath11k_ahb_shutdown(struct platform_device *pdev)
 	 * remove() is invoked during rmmod & shutdown() during
 	 * system reboot/shutdown.
 	 */
+
+	/*
+	 * Only run the teardown where hw_params requests it. Where it is not
+	 * required, stopping the firmware here would leave shared state that
+	 * hangs the following warm reset, so skip it and let the SoC reset
+	 * re-initialize the hardware from scratch instead.
+	 */
+	if (!ab->hw_params.shutdown_teardown)
+		return;
+
 	ath11k_ahb_remove_prepare(ab);
 
 	if (!(test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)))
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8dacc87..2a10173 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -41,6 +41,7 @@ MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
 static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.hw_rev = ATH11K_HW_IPQ8074,
+		.shutdown_teardown = false,
 		.name = "ipq8074 hw2.0",
 		.fw = {
 			.dir = "IPQ8074/hw2.0",
@@ -130,6 +131,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
+		.shutdown_teardown = false,
 		.name = "ipq6018 hw1.0",
 		.fw = {
 			.dir = "IPQ6018/hw1.0",
@@ -218,6 +220,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.name = "qca6390 hw2.0",
 		.hw_rev = ATH11K_HW_QCA6390_HW20,
+		.shutdown_teardown = false,
 		.fw = {
 			.dir = "QCA6390/hw2.0",
 			.board_size = 256 * 1024,
@@ -310,6 +313,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.name = "qcn9074 hw1.0",
 		.hw_rev = ATH11K_HW_QCN9074_HW10,
+		.shutdown_teardown = false,
 		.fw = {
 			.dir = "QCN9074/hw1.0",
 			.board_size = 256 * 1024,
@@ -396,6 +400,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.name = "wcn6855 hw2.0",
 		.hw_rev = ATH11K_HW_WCN6855_HW20,
+		.shutdown_teardown = false,
 		.fw = {
 			.dir = "WCN6855/hw2.0",
 			.board_size = 256 * 1024,
@@ -488,6 +493,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.name = "wcn6855 hw2.1",
 		.hw_rev = ATH11K_HW_WCN6855_HW21,
+		.shutdown_teardown = false,
 		.fw = {
 			.dir = "WCN6855/hw2.1",
 			.board_size = 256 * 1024,
@@ -578,6 +584,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.name = "wcn6750 hw1.0",
 		.hw_rev = ATH11K_HW_WCN6750_HW10,
+		.shutdown_teardown = true,
 		.fw = {
 			.dir = "WCN6750/hw1.0",
 			.board_size = 256 * 1024,
@@ -662,6 +669,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ5018_HW10,
+		.shutdown_teardown = false,
 		.name = "ipq5018 hw1.0",
 		.fw = {
 			.dir = "IPQ5018/hw1.0",
@@ -748,6 +756,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.name = "qca2066 hw2.1",
 		.hw_rev = ATH11K_HW_QCA2066_HW21,
+		.shutdown_teardown = false,
 		.fw = {
 			.dir = "QCA2066/hw2.1",
 			.board_size = 256 * 1024,
@@ -839,6 +848,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.name = "qca6698aq hw2.1",
 		.hw_rev = ATH11K_HW_QCA6698AQ_HW21,
+		.shutdown_teardown = false,
 		.fw = {
 			.dir = "QCA6698AQ/hw2.1",
 			.board_size = 256 * 1024,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 4996536..f35bb96 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -231,6 +231,13 @@ struct ath11k_hw_params {
 	bool cfr_support;
 	u32 cfr_num_stream_bufs;
 	u32 cfr_stream_buf_size;
+	/*
+	 * Run the ahb shutdown() teardown (stop DMA before the SMMU is torn
+	 * down at reboot/shutdown). Only set where the teardown is required;
+	 * where it is not, running it would stop the firmware and leave shared
+	 * state that hangs the following warm reset.
+	 */
+	bool shutdown_teardown;
 };
 
 struct ath11k_hw_ops {

base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
-- 
2.47.3

