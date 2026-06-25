Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616C2EFD9B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394894; cv=none; b=CZym9pIbLd1LjAhQML8kFi48/N7t8Q5/Mx8z9n9AEiBL3AKfMpnq9p4hgitc1euQqQNowi78lyyjXyshBdT4C57k4UKET1uTgywaYWRTq+xBBTmg/fuPMpQY6ZeiGhf96b0V7C2d3mE1hTm2Sguc3Q7DQUX4ZPoahfOJcJ+eZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394894; c=relaxed/simple;
	bh=rrxIPqMfGhcAO5jWIktqxeb87TWBwYbSpsrWeVDMhYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCglfAUagNHE0rzg87CsCMpLsQsK8RT9pKtK4d3zTzDed9GiJryxKa25xKvIQyRC86XeDVCOAxNx8yUDBSjm2aNb3L90wY+dwgz/4lURRXtESvydLnwUrnkTpmiQPdslTodR1MvU4ECWwVLboI1aPFD5LT+u1oZV8TmcDG8mOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNh3NM1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNh3NM1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFDF1F000E9;
	Thu, 25 Jun 2026 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782394893;
	bh=ILtkIpWh7eTRXqJwczrY9gdkYhQVX4oVpCZcgrFZYwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNh3NM1oHSawZC+TesLqhVHPEe6Rl7bMLMnyL668PETFDg5jw8jZFrrFX9oJ+iPDW
	 73IXneK6OISwi0AW5JmgObyUl6pA3PZu3m0ZPglTeCDEHA0hMbchXUvCXemg4jJuJp
	 SJ8qVBFmtcJNI4RosdOeZHOpuQIQ0sLIl3GNdiie21nVpaVnh2r0np4Zk6j82JsRWd
	 Pnm1e33ySByK7K0oqeNeVBFnnoYk4M3frVbtJN6cIHAerbDpfEqCaQwhsBNpaAOEXA
	 2hyKtzAgMiTEkDH2i/OqrEu6Kt+YoG1F3pLkwcpF3MGXt3O2FPMO8jjv9SWp44WkKO
	 5tGP0r4yUl7Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stepan Ionichev <sozdayvek@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
Date: Thu, 25 Jun 2026 09:41:29 -0400
Message-ID: <20260625134129.2411401-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062537-untying-ripening-0030@gregkh>
References: <2026062537-untying-ripening-0030@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stepan Ionichev <sozdayvek@gmail.com>

[ Upstream commit 10fc708b4de7f86002d2d735a2dbf3b5b7f65692 ]

dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
and then, if the device has a clock, registers a clock notifier. If
clk_notifier_register() fails, probe returns the error but leaves the
8250 port registered. The matching serial8250_unregister_port() lives
in dw8250_remove(), which is not called when probe fails, so the port
slot stays occupied until the device is rebound or the system is
rebooted. The devm-allocated driver data is freed while the port still
references it (via the saved private_data and serial_in/serial_out
callbacks), so any access to that port slot before a rebind is a
use-after-free hazard.

Unregister the port on the clk_notifier_register() error path.

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260514143746.23671-2-sozdayvek@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 4103178725e396..7a000836354397 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -846,8 +846,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_unbound_wq, &data->clk_work);
 	}
 
-- 
2.53.0

