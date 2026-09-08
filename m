Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3534216C;
	Tue,  8 Sep 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860201; cv=none; b=UftdoDDXOW+ijbjskhBnhkfD2wvGYz1ynky9phCMnltAqjccU5nNGXk4JD+lrsK31x6BWtQB2kzhPJl8Ggp7JfD5vALnvD9+NRix7nMy7Ced0ZPMSgETLgjqE8vxvAb1SHEVFY5i47gXUm9vn8Ovd48vRuT/lVHQg7KDkpCcX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860201; c=relaxed/simple;
	bh=T/LyB2Jn3cJpv3JTXrzGFw2wKygWpGUuk2LHMmwo1ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbkYbXMevbKx1UU/V4WJugtasVme1ctY9QBbpSr9XxjnM0ymHckwfdxoWBUBdUgJ5gbdCCj8qfeBowdkv1rjYrSwsofDH3z0sWKV7Mu8jpuibkuMMLYPLpNy+ESX+/+O0Ov+LktW/Y2aZq2oa6DbiCua18bSPMRA2JB86bkLZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=EBMHDpBb; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="EBMHDpBb"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1788860186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B5cCpiqQ3DduiMiz+5Y5SL/HfgVWTGtAFGgqh+D7DyI=;
	b=EBMHDpBbY+JPXrDRAz/7xXUAnGvUIMLfZu2SSIJSdO6cjL0E1tZNX6qz/3INkjdjUNQ/Gb
	kkvFPX1PxAEp8migaDzTWgmC/RV3aSUjVMOiQUvDaGVjfa7Gi7vI6atPTSg6J4MMKBQddr
	+syAb7+Hh4aYCbpd8Ka8b56lECEgvJM=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Artem Shimko <a.shimko.dev@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 5.10] serial: 8250_dw: fix port leak on clock notifier failure
Date: Tue,  8 Sep 2026 12:36:20 +0300
Message-ID: <20260908093626.15492-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the error handling in dw8250_probe() and fixes a
port leak. When clk_notifier_register() fails, probe() returns an error
but the 8250 port registered just before it stays registered: the
matching serial8250_unregister_port() lives in dw8250_remove(), which is
not called on probe failure. The port slot then stays occupied until a
rebind, and the devm-allocated driver data is freed while the port still
references it (via private_data and the serial_in/serial_out callbacks),
a use-after-free hazard.

The first patch converts the probe() error paths to dev_err_probe().
The second patch unregisters the 8250 port on the
clk_notifier_register() error path.

Andy Shevchenko (1):
  serial: 8250_dw: Use dev_err_probe()

Stepan Ionichev (1):
  serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails

 drivers/tty/serial/8250/8250_dw.c | 32 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 18 deletions(-)
-- 
2.43.0

