Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343373;
	b=hm9uteiZf6Buq9UX/4RR2KL4+LdfEAjYJ43W4IdupHQcDcHR6qR0jF4VDAXxVnz6+6Ar
	 DQ0DLQUFZ9P31HpLRSwJNdOTNd3YZ3wJSD3h+Fg9p6Gk4WIDQPm0a5hLnAiIqAevTRnsf
	 Up5SZ2CvvGmMAJxL3E3RjJN1qjOOo78Z3diA75ZqNZSqD19lttVRyXl/VThoH9plvDYGW
	 MTXGKWm564ShfsQOXkmE+rZah1VJbOGDs9cm2PLgCjRawj+yVkagyzmSFdXvUo3d3YwCg
	 8q5R0wl03Tq6fu0hqAPd5PQGWs/OgT6futGOr9kPh8+naHqhH4eQbJrEs/T16gUsIOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mMqHLV6VcBMfgC9DOilhYmCk2rXv+eDJ7hlvLS0rBF4=;
	b=t0poYSSg0E3AQlR3LrqN8ixJK6ISaCte9CRIHEeT8srPS3WzBX8NRks4UvNl0n3l3kVm
	 1wlTTS+t4PL/VLXDDG/f2qW3WdRoDFDEy8sBVJX5tMc8h7A5JPY3xM4+WfFfLdCgzT9Gw
	 Dn6aCCgpQJMJAEZ/WJwPLOwAHPfdH21mC7AxggYMS9gdYLX+TyVL35V79MTc3kHyucuW4
	 CimECxAjO/emVY7yGnzRAjW9w6cOBjUim3vczpHhm0ZPAwCDVmFKAQwNAs6DErAQSro/F
	 1IOA9bGTVKbzvsxJbFkTbZcg4/Hwgmz3/qHImysNxQn3aWGUyFRHoNzEov+lIZOdS0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQHMOPVK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556F606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQHMOPVK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3B51F008A1;
	Tue, 10 Nov 2026 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343373;
	bh=mMqHLV6VcBMfgC9DOilhYmCk2rXv+eDJ7hlvLS0rBF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AQHMOPVKYIPXsQCRP9dqCZb+2tUqoAiPn6YZEYCT29R2RDp0/4dkB37sWAqJQYmo8
	 5sxoRTQNz0M/jD+TdJqkVMUGzbGT6RZirs6M2QIWLdhe82JsKV+69UneX5PcQzKjB1
	 /qRPbrEVF1KTT9UhpwtJ/YfdherWkKDZvC4Ckdrd7g64rZCHdIRNl55RStBv9+z3Ic
	 u51Bm5N2z5GOJoD72uOi8fSGcDdwn1F5pzeumgZ2Q/iTODLVaKk2+kpP4LfImb56w1
	 foNe3bfibxT5Zm/zqGQ8Sk5QNYzMRqF0r9fIm3Y6OgRjOTZi9k/asIo1SPZBNZzpDz
	 61aBo7B9ydHbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] serial: exar: add optional board_init function
Date: Tue, 10 Nov 2026 15:42:49 -0500
Message-ID: <20261110204132.3796786-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110204132.3796786-1-sashal@kernel.org>
References: <20261107054802-failed-6.1-33d337816e00@kernel.org>
 <20261110204132.3796786-1-sashal@kernel.org>
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

From: Parker Newman <pnewman@connecttech.com>

[ Upstream commit 393b520a99b21d9ec6d4bb32e7c05bbb4f6dc777 ]

Add an optional "board_init()" function pointer to struct exar8250_board
which is called once during probe prior to setting up the ports. It will
be used in subsequent patches of this series.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
Link: https://lore.kernel.org/r/0e72a3154114c733283ff273bc1e31456ee101f4.1713382717.git.pnewman@connecttech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 33d337816e00 ("serial: 8250_exar: store the GPIO platform device in struct exar8250")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index b8efa464f1b3e..060090adabac6 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -177,12 +177,14 @@ struct exar8250_platform {
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
  * @reg_shift: describes UART register mapping in PCI memory
- * @setup: quirk run at ->probe() stage
+ * @board_init: quirk run once at ->probe() stage before setting up ports
+ * @setup: quirk run at ->probe() stage for each port
  * @exit: quirk run at ->remove() stage
  */
 struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
+	int     (*board_init)(struct exar8250 *priv, struct pci_dev *pcidev);
 	int	(*setup)(struct exar8250 *, struct pci_dev *,
 			 struct uart_8250_port *, int);
 	void	(*exit)(struct pci_dev *pcidev);
@@ -726,6 +728,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+	if (board->board_init) {
+		rc = board->board_init(priv, pcidev);
+		if (rc) {
+			dev_err_probe(&pcidev->dev, rc,
+					"failed to init serial board\n");
+			return rc;
+		}
+	}
+
 	for (i = 0; i < nr_ports && i < maxnr; i++) {
 		rc = board->setup(priv, pcidev, &uart, i);
 		if (rc) {
-- 
2.53.0

