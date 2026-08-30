Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9628FFF6;
	Sun, 30 Aug 2026 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101963; cv=none; b=LP+FzBv+ugc/zz/X+y39/ZHRo28uOtCOnoT67yGjLbO/K1MFt4OaDufK+xV1UWGq/iK0+TiYM88adWZ5hMwBFSPcudkSWutOqQDK4XeKrKWtnOUNiKtDiwC5dyZJVAyUoXCTqI143Wf8NkSZfLeWLkn10OddNQ10/wDdwutBe7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101963; c=relaxed/simple;
	bh=evJepSGuzGoWlLnAMFRPe8iRN2DWWqU6ds2d42fT4Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=um8JegqfpRSvMVtVVrmV9OrCAMS+2K0aT3nMf0Cbr2IEE9JsqFESV+HM2WLQWlWN1dFtQ5g9z4eliab9cXg9wzN1Ggok5CyefXuipUfqoa5sy4K8UKoMuoKlQCziPrOnHUl9fKF6tNb47Eu+us22r/KTvFt0S4vGiVXlENBeqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Dj+E8JwV; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Dj+E8JwV"
Received: from fedora.intra.ispras.ru (unknown [10.10.165.18])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9240540755CF;
	Sun, 30 Aug 2026 14:53:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9240540755CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1788101611;
	bh=XfajMX9CbuMgDEeBVGJXZ9nzYyzLpt8bRW52v/wenZo=;
	h=From:To:Cc:Subject:Date:From;
	b=Dj+E8JwVwrmsti55gIlUBPmoPUzoI0lP5JpoCUyHfTCcTqkJ9kiTalNN2TcPvXRJT
	 RMPS9uxeUfYR61BDH5DIn5GLAc4tTLgmGH13h/6lFRJzkeTj6rMbG6Pyfm348IqfDo
	 4KWzZQZb8s4I6O99p7zElfzof5M0U8JHXGC2rVjo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] Revert "USB: serial: keyspan_pda: fix information leak"
Date: Sun, 30 Aug 2026 17:53:19 +0300
Message-ID: <20260830145321.100701-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit cccef1711efbcdbe999738ac27d37b9ef6271abd which is
commit 6bfc8d01ac4068eced509f8fc74d0cd205e4dcec upstream.

The 5.10 backport is incorrect - instead of keyspan_pda_write_start() it
touches the wrong function keyspan_pda_write() which now returns an
incorrect number of buffered bytes.

It turns out that the proper fix for keyspan_pda_write_start() has been
already incorporated into the ported version of upstream commit
034e38e8f687 ("USB: serial: keyspan_pda: add write-fifo support"), for
unknown reason.

Other stable kernels, starting with 5.15, got proper backports.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/usb/serial/keyspan_pda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 21dfd9bdc150..7141660d5d59 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -606,7 +606,7 @@ static int keyspan_pda_write(struct tty_struct *tty, struct usb_serial_port *por
 	if (rc)
 		return rc;
 
-	return 0;
+	return count;
 }
 
 static void keyspan_pda_dtr_rts(struct usb_serial_port *port, int on)
-- 
2.55.0

