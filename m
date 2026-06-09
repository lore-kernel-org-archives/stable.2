Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC935E1D9;
	Tue,  9 Jun 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974783; cv=none; b=E78im8WpjgeaEyc5I/k8bvXQ+0Vn6sUfwIouzvOHrQ3yRWi3Qj0aD6y68qiAI37wYeOzW+WImO03yH23jzgwzlg13zEmrwj+I4an4KM6KBWPbVw+iHnl95SFGHasFf3DAj8NNBLCEuKJkjl94QgMBYe1MybKX5JIYXIfDBXLwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974783; c=relaxed/simple;
	bh=xMgcYcolNdpZFjTTRkA44kIuPU/eKVBzDgStF/3Ch4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJfwjiZj+6J+hJTiQzQbyp48h4WRV6hxqx1uLdwK0h+YGKe+dkgfqf0x7fc3tqQokkvOrnA2OjbeO3WW6nPF40H2e4WxSzQQ4OrsNsMQ5QVFPuYUH5tjrappAq/HGt4dLtuUogVk2YH/Eak/dE4lAaVsmmxfPZQx8zPLD6TgLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Upsn0Izl; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Upsn0Izl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=44
	1oI75A3DiUMyUNb96b+ndobyPHuqxaJuMlZ8Mxlsk=; b=Upsn0IzlUv5jmnULn7
	6oFFSjknORw15wB5PDSNScXkexPdpak1nn5arHRSct/enbUZ2kW7MpJOFbni9Eks
	1PGjPwrwY4HKROxB7a8ge1oUbdh4XlGlxF5MG18k6E+H9wndNWjsu7vbjvkH9eGV
	v3YWgbHjztKfhEJTGqck8eyTI=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wC3tOqdhCdqU+8qCQ--.4915S2;
	Tue, 09 Jun 2026 11:12:33 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	linux-i2c@vger.kernel.org,
	wsa+renesas@sang-engineering.com
Subject: Please cherry-pick commit 617eb7c0961a
Date: Tue,  9 Jun 2026 11:12:27 +0800
Message-Id: <20260609031227.21001-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3tOqdhCdqU+8qCQ--.4915S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU24lkDUUUU
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAAGtkWonhKHMqgAA3z

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Hi,

Please cherry-pick the following upstream commit into stable trees 
from 5.10 up to 7.0:

617eb7c0961a8dfcfc811844a6396e406b2923ea

It fixes a local DoS via userspace-controlled integer overflow 
in the I2C_TIMEOUT ioctl.

The patch applies cleanly to all active LTS branches.

Thanks,
Mingyu Wang

