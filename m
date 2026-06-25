Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31532936C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395697; cv=none; b=oqWpiH4OdOZJe0IORP/vl1poyYNP1iiJyhP8hpPar3Jo/523c63m4VssyqXQR8ODrlR4NSGrz035Mk0d6JO3cjJiCKlKWVAYQ2dAkmVmur4sLbbMj9IsrIUcfoULBJ48/ntsp7wffuRXiraCrMDRaUj3rGcWAK20m/PKybt0YQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395697; c=relaxed/simple;
	bh=jho8W/TRhhgyB6sxz5B7/W7j4V8XkBy6joZzfof5dRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOkfzsv9YBdXva6xynIcprrhzsbvkmAEgk+Eo30UvjKTIlwhLWcFSYvKewcdghYsnuaQv4NyWMEb2W+vzDhzoXFPpZ+aj8/lxmB4fInHvY3iFMzksWOsqeOdCxP5n6I79s4ZNCOkIpVAN3xGyvtHwm8t0dEDVH1mWs4t4zp4H0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1XCoLvh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1XCoLvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D1E1F000E9;
	Thu, 25 Jun 2026 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782395695;
	bh=l0oiXDPFOLQj93eKN3HMJ44duZmuABLSkp2DOUYM8ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V1XCoLvh2cgXyCI6dipeYGLzhZtsYHYKQdSNadtaYWqz5kpvCGFZMTXTBZu9N+eGY
	 omhrmtRP9yBe/xhezeb7n8WdP7qQK9CtKSKabZ3bSOudYput6cZU0fppCPA5g/j4iG
	 99RJLekdmGcmMKlnzoSPMz0G8BFOo8ZmYEuW/MYbexDeiglroi9l66hXrBYWRfoHeM
	 Eo6i4FRei4F+CkjL6KFyCTydK/H+lstkSSU//bDnPZOxEdFg2oRIsDSa3fvI6CQIaQ
	 JwUyrZgwTzBsXfoT1n4lkmmDcaLxv6FvVeUqr4PPaoVcu/PrdpUgMUoCIkQ8lZKquZ
	 O19Xc9Xs37wgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stepan Ionichev <sozdayvek@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
Date: Thu, 25 Jun 2026 09:54:53 -0400
Message-ID: <20260625135453.2421817-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062538-lash-atrium-5f0f@gregkh>
References: <2026062538-lash-atrium-5f0f@gregkh>
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
index 60a05bfecde39c..d1cf00cd945d97 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -688,8 +688,10 @@ static int dw8250_probe(struct platform_device *pdev)
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

