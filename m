Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E04071E3;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763502; cv=none; b=EYQ6lvV5MRAs6QHRr6cFbIHyUI4qRct3w6St19zKbqJy5GJ3jpuNzVKD057cKbFH6mpEVifrxpM51z4xFO55l7slLT4iyCC57glZ1kSi0O2g3GiqLO+4SFoNx7rASb3wrJjmWGk55/g3KbJhpET0NaIE1uisGquTVJ2P8aQ8zmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763502; c=relaxed/simple;
	bh=FkFIFfY5SJigabcSWWhXlaO3fAJU+Vo/qJIley++sNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5vmVEdZFTd/prE+xeA9WX9aYszIbgML4iirE+RfgeZ6GmOCh6ktVtO7go6Ld+6es8+aCdpmcYRST5Zng01kYxBokyOy41K/ArJEDsn76Wi93AHiqxknwC4euS6uOHlWkvGhsQ2ZZaB7AkIhaVyRNV84pAT+m1S30fr7DRZjJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eywWcZwF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eywWcZwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC941F00AC4;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763500;
	bh=LXQTQ/3II3SO4NJRoY1gLUjaK+rJhs2DGgp0+AQspig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eywWcZwFfUqWEuURKikHq/qXSwH+/mRxwKYMSba8CGUCWG1R4A3f+999b+ct+jtDG
	 JAxJTAEz6FxWdHP4WR7Cq87mtn70g7/Llb3Oq+IX/bgZot/hFOqUCFz7LxgPECtxrg
	 KXA825mB/cEofcMSAibuvnGsPagHHXgxebrRfqAPTG9kiar+IbBzMgHhkbaHBncWyV
	 zu9/ni86dNQ6i6PJu5y8B9dXHNOgu41/+tq4CIP+E9ymsTrqXBOABOQy8AwgVAh3S6
	 ujcd/S3Ufs38/JoNzsy1nh0OiOLn4rpxYt7go6x9rDY/4vs13Z6CFFe6ECXEqz4QZG
	 Hb53J3hdvXyZg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3T69-00000000OCA-3rWo;
	Mon, 07 Sep 2026 08:44:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 4/4] serial: abort TIOCMIWAIT on hangup
Date: Mon,  7 Sep 2026 08:44:18 +0200
Message-ID: <20260907064418.92953-5-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907064418.92953-1-johan@kernel.org>
References: <20260907064418.92953-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing hangup check to the TIOCMIWAIT wait loop to avoid going
back to sleep (indefinitely) after being woken on hangup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c2c2c8fe1a4c..45d160743ea0 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1244,6 +1244,11 @@ static int uart_wait_modem_status(struct tty_struct *tty, struct uart_state *sta
 			break;
 		}
 
+		if (tty_io_error(tty)) {
+			ret = -EIO;
+			break;
+		}
+
 		schedule();
 
 		/* see if a signal did it */
-- 
2.55.0

