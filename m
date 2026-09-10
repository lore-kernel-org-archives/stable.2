Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9A48A2CC;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045711; cv=none; b=N3v71cpBo53spa4r9WigNQVAvZ4hblrO8Mv8e3P+NpPmz2loOtnYiBW6srlwJdlNWStJcCQ3XbJo4g3D8yh9cFUNnQ98UeTxFiUYU9uI/gd1K1XZKJnmMGogj8t0P3uC6SSK/joWf6S8CYMBSc24DqbcSYTrTAUk2b4MGt5jSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045711; c=relaxed/simple;
	bh=T0eDH7EZA4xtoy/k/cA/kR66PSALuZ5xMZugpP97LwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRWIEk3WBFr5cx5DWlLL3765dJBoJI+NHQEDzfJsCsqHXZPBCR+XAqgGTkOLZtpCeba7+hg1BVFOlmNklBevJflLqm+aMu2OQIZpZwxkv+16z7ZpwSmN+X9TsAQ0E2n5w3pia6OXq11rAOeOI6utIeuIm24iez7SFpnXKMyUgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbM0YamC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbM0YamC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C851F00893;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045708;
	bh=QR/jT8+fh8O4lU8TXCcsWfuRox1z2vMh4P/ANZ/SU8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbM0YamCytcQCQj64jxlAxLY6xLOs2nmQ6S4jejaNNWpnl96UWzw8me3PMJYX8fDV
	 Xt/blsqXftHLyjclhPDR65ITj9q/Bv+ZPVbtL0c7N4p+l4bEi0/i8LYtxe+wQ9DBAE
	 y4t78GG0YlqUlO3MPrvaiHzA2W9UeFc2+JuMl4a2b/Tig30ImPmY0PxMLpgvgHgUQ8
	 DuRXWbrQjpvvRzsakCltw72byWBbuOGiIcUQ9FZnc/H2ccDS187diawVjABRwJlhDU
	 S+UjwfooeD5typIrTkstTzLHZ6+2Is2KmzrDPtbUk1K/1HYYLYywI1iLwfSh1gUJf2
	 x70h27X0OMmSQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4eVu-00000002hCj-05C1;
	Thu, 10 Sep 2026 15:08:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 4/4] serial: abort TIOCMIWAIT on hangup
Date: Thu, 10 Sep 2026 15:08:16 +0200
Message-ID: <20260910130816.642699-5-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910130816.642699-1-johan@kernel.org>
References: <20260910130816.642699-1-johan@kernel.org>
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
index f7b30f77b231..33c8f3b6ac81 100644
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

