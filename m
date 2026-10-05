Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D05172C2
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220683; cv=none; b=Fs83s99UPvTCRnuOXIP97IHUmmV8btOtEiqoLv5B/dZnVT/tbV19KTOZbCC7I3NU+sDMzUQQigjrPqwyY0hTQEFpkb4PLPCNC0HaSY8vIkB6SlSK40i6ZL+4WpFI4AQRZ9gNqVQLc2XyM1lDo4/xLlJ80Bxckd4ho2eoLYYi5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220683; c=relaxed/simple;
	bh=KwoUecnVMa3MFQCze6SSlAFVZhCBBAZK3KfrSDj4Yh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+Fq4gIChSLeVhm1y/JrrnZ9nQobL6QGZKk1Ij9n1RdMJq/4RYGPelVaAll92vRqvkwIrEhABOfjUnlXxsn7ufEkaH2e7/3HV479cJ3kkjUGNam+lrU609RqzIwhpzkj5kcfiIncmQ4OK+B9LCVr/8dI6rBgiBtFKg4fRxE63IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTkXXgMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTkXXgMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9796F1F000FF;
	Mon,  5 Oct 2026 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220682;
	bh=BxSJnjxar8g7Z+wgVngsd8/410WNVbUf8sN+wBIb8LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTkXXgMf2fSSePhY+1mui4he42yy5SoHBoIGqa24sFs897anr8dzkCR+CvkHkheXn
	 Tjy/yK1ZipTngw3SP826j0EnUSo+NrSweSUsIG5AU+LlolaoSbqcP++t+P1tR47lAn
	 cAbkxpw/0KCU4VxN95ll61/qJg30e8Gr/AKAjCftyOjt638gNu00NF+MB/KgQGsuJd
	 rFRtxcDQxdRk5VUuHAUKj9PfpdLjTKMOjLstmOjsIkjLaAIM2B6FfNHG2TDYdXl3d/
	 sCx5o3sYvUQXHrFeLX1CdWEueILWwvJlf4z8BJ1AeDbiIX2hlNkT/T2HzMZrLzczFR
	 RPEqNXbUxLNJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] tty: tty_port: restore TTY_IO_ERROR on activation failure
Date: Mon,  5 Oct 2026 13:17:54 -0400
Message-ID: <20261005171429.3065052-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005171429.3065052-1-sashal@kernel.org>
References: <2026100521-mammal-arose-32f1@gregkh>
 <20261005171429.3065052-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 56964f6a31238fb41d5830bb42520c5b10ff7d8f ]

Make sure to restore the TTY_IO_ERROR flag if activation fails to
prevent I/O attempts on a port that is gone or powered down.

This specifically avoids issues like kernel panic due to unclocked
accesses or NULL-pointer dereferences when accessing powered down or
deregistered ports when a TTY ioctl races with hangup and open.

Note that the flag is set again in tty_port_close() but not restoring it
on activation failure leaves a window where drivers fail to handle the
ioctl-hangup race.

Fixes: a9a37ec33a1b ("tty: tty_port: Move the IO_ERROR clear")
Cc: stable <stable@kernel.org>  # 2.6.33
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260908084000.218528-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 64b2584ff7a18..10d707e3c0344 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -765,8 +765,10 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
-			if (retval)
+			if (retval) {
+				set_bit(TTY_IO_ERROR, &tty->flags);
 				return retval;
+			}
 		}
 		tty_port_set_initialized(port, true);
 	}
-- 
2.53.0

