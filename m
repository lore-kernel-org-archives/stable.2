Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6B27453
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780714034; cv=none; b=OehyO4aC43Ncjq8SgVtCs/Oa1Tla8cH9vhxOZn7Pmr9cNWV4+nI6+9DVJcQQZoxcTxa2csOa1/nF2Lv1UJ9q0Wbu39iHVKC79OR50IAVauOpjvj28RscZI+VocKYeCsL98/ggNXiCh/+0TJNlYDlz9kGlasmqtDoNxstBMeL9rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780714034; c=relaxed/simple;
	bh=e3dskd3fzL3iqR4GJwuFgAOMGPlloCqXnevLBK8wNH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neSWLfZ/JvHaY2mREDgcyzQ14SWG7qSJRTyaJHDdIxTx9mvR8+jtzOkgxWkGZ0uzlFiAQT0ths3h4NaijjHo8U9Q2PL2U4nmDJVXhW3rKyBG6bJDX6NGvZ/EU2aK6s+XPnNR1qMIh02WVwhyM4jSlknIWZZNxECAGSj1pHmK3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWlVMI17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWlVMI17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB5E1F00898;
	Sat,  6 Jun 2026 02:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780714033;
	bh=tFbZU+LV6wqz5YWWVZqC/E9zRrn9yZ5k6FfL5rkif/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWlVMI170NiDUsfXGr3wJxlxK1KidSCMSPvm+id24Fj4LWXxUqRzUwBA6ivv/0F5x
	 b5yxBi40Wki18cYD2pxps4BsKDHOaLlALaWVI3loAffwyvvpxWocRhHj8sm6AWOvwc
	 JSBvFs43YfGE2Z5UP8VS2evo/Geqe27UUaGuEl6RVQtEtf1rbz8wAFda36hby3V51j
	 L+eCBycQUST4X6sEO0UooGAGYR6LfRPVYsrzIQdoeEszBdKONQb1anIR/tn5QkXJTC
	 3RPCOGkxyh+90lv8uSm3Dic+YzA/5e/N1y/DNAsawwXEdO+DgKFqDd+J8ZsGiAlWFx
	 DuQ400I52oeYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prasanna S <prasanna.s@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] serial: qcom-geni: fix UART_RX_PAR_EN bit position
Date: Fri,  5 Jun 2026 22:47:09 -0400
Message-ID: <20260606024709.2514691-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606024709.2514691-1-sashal@kernel.org>
References: <2026060450-emphatic-dictator-79c4@gregkh>
 <20260606024709.2514691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Prasanna S <prasanna.s@oss.qualcomm.com>

[ Upstream commit ca2584d841b69391ffc4144840563d2e1a0018df ]

UART_RX_PAR_EN is incorrectly defined as bit 3, which triggers false
framing errors (S_GP_IRQ_1_EN) and causes received data to be dropped
when parity is enabled and the parity bit is 0.

Define UART_RX_PAR_EN as bit 4 of the SE_UART_RX_TRANS_CFG register, as
specified in the reference manual.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Cc: stable <stable@kernel.org>
Signed-off-by: Prasanna S <prasanna.s@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260428-serial-bit-correct-v1-1-9131ad5b97d8@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b7579da9af9d98..c5fcdd5667b46f 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -47,7 +47,7 @@
 #define TX_STOP_BIT_LEN_2		2
 
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_PAR_EN			BIT(3)
+#define UART_RX_PAR_EN			BIT(4)
 
 /* SE_UART_RX_WORD_LEN */
 #define RX_WORD_LEN_MASK		GENMASK(9, 0)
-- 
2.53.0

