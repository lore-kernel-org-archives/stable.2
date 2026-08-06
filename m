Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974313976BA;
	Thu,  6 Aug 2026 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996488; cv=none; b=QM/YxCUGeOyv7qQg/jn5OiATvgZp7YGcaLvH7O35s9DnzqLhtfYSlF7P+OJ7pQUkgsCenPMkzROTFXZBmegAOmHeOVla4XgNAKKooRIZJ7mIEWkX8wU+Ubm4lPDNAZ7PmkuGkZBhz8l6kk+5bhe5D0yg+LNlqIzMcaLkU+FbsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996488; c=relaxed/simple;
	bh=+ZxxIBjOAkjCaBMcskoSDQyY8idNcT5ah8g/trROG9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrG369JgTsUZ2wVGKuZ36XmW3AWRHeB1OgET0A4LUrvBWeW+5XoBkyks+90dckIPzJQzshA08Z1MPo17exhEtm4iB5kFiKDDfhTPiqr9C69G9Ia9cTmX4CJ+Ica3ESg8tyClETJFfUDDqDWmGv18btCc9QXeSTlton7d4+TErUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iB2UUeOr; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iB2UUeOr"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a4d;
	Thu, 6 Aug 2026 14:07:54 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jiri Kosina <jikos@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Ben Martel <benm@symmetric.co.nz>,
	Stephen Blackheath <stephen@symmetric.co.nz>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] tty: ipwireless: shut down setup timer before freeing hardware
Date: Thu,  6 Aug 2026 14:07:40 +0800
Message-ID: <20260806060741.714-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5af675d03a1kunmc1045b49289430
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTRkeVhodTRhDSExKSU8dQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iB2UUeOrGX/hV4riKfPr8ePBPYs4wxMWaXEoVy203Oh6N4XHhfn8VRzFDYvrcmv54iqzP3C2eFnsu7Mel0EzZ6gzg+BsNl+gLt4YUY4IDmgY9ehy9xU5sEi2KZRJ/4O1kB6q5bqh0PMihIE+awzX3sZVVxX72hnvIzoqTaRSk24=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=rSEmjRBE4v1UIpSrh/ztXnharFntaNpe+cZjJlKxOMA=;
	h=date:mime-version:subject:message-id:from;

ipwireless_stop_interrupts() uses timer_delete() for a timer whose callback
can rearm itself. timer_delete() neither waits for a running callback nor
prevents that callback from rearming the timer. The callback can therefore
continue to access struct ipw_hardware after ipwireless_hardware_free() has
freed it.

Use timer_shutdown_sync() so teardown waits for the callback and prevents
any further rearming.

Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/tty/ipwireless/hardware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
index 0bfcbca6e2df..fb3554a6e04b 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -1721,7 +1721,7 @@ void ipwireless_stop_interrupts(struct ipw_hardware *hw)
 	if (!hw->shutting_down) {
 		/* Tell everyone we are going down. */
 		hw->shutting_down = 1;
-		timer_delete(&hw->setup_timer);
+		timer_shutdown_sync(&hw->setup_timer);
 
 		/* Prevent the hardware from sending any more interrupts */
 		do_close_hardware(hw);
-- 
2.50.1.windows.1

