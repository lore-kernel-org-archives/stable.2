Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193748;
	b=Bo4dL9+DUvUqj1A3PpCeKlg85SZLd8zcPLlt7BBNMLKmgv2qkZR4k7REULrg1yLknR/K
	 IO87ExnHHN2pBQbwujzrgG01t2hMTRTm9yHY6/JKFfaichiVTdn9C3aqoAgnTliChcua+
	 RwOs9m2hmknmEez9ZKJXTFidd/h1AGAL2CD02+zd4M6HR2SFXyzO3qlMxlG1ohJlA4Qt4
	 EISxBXKgtY9Rm717qLJ1Nt6kGltmWTjP7ytrjQ+vRviJ4XEPGlsyfCd7oiYOFmRm2fQ24
	 DMPHRDVW6iGFxlicVcRJk5jR9fnLAgO5fNzxyAYQJAb7zIBqgj7EVlCipPXApLB1P9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193748;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wKIG3YJ3npUiBqpk4e7Vx8ULUtnVSba6MBLNJ8mK1PE=;
	b=5b1/EHW5qOQ2L7n0ri1nVYLdpwmnYvTaHST5/WxFyURV5qFZUm/1MrxoZb0zPkgxeiOU
	 0rSPYJtGS2ZJlSSFrqcz9Er+CAFFOgSIBvLRdD1v0kIsZuSR2+EahhSR9qzZFfSDI13N9
	 pA215J8YCzvxHqNG5l8umKoHZOmzL4l96lmlt7VNO34ubJleOp7C7mqQnLXL2gdPjTp6G
	 t1Vqdj3pqdFfkO4tJy1IhRVtXlPoZqCvFXln08LSj/J5UM9Gz59P21GJ3D6rHWriD87ov
	 MYzKE/nka6BOovUTH0vvT/U4f2ob/3iPkhnY+o+QtEPuNeRTGEwQaRSFpuXTyw9uOWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3widikj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0731B606A31E;
	Wed, 28 Oct 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3widikj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71A71F031E6;
	Wed, 28 Oct 2026 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193747;
	bh=wKIG3YJ3npUiBqpk4e7Vx8ULUtnVSba6MBLNJ8mK1PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3widikjOghmoFtHsoWwAIicVmUcLp2/F0ouEe3cQQcyEBmYxM7nUiJtKK/kAY8P7
	 ijtoN5u8clN7GcBfLlgFBMv1jkRjKkinzlCagro8Gm3gVSpgqZTsLkAXqYlZKZXVii
	 iVSIDxJ5wzEdxrrkW6qKaP16F1bBYg61MHaBByNw7kSsG64uz4WigdO8ihxkm4d1uP
	 /kty5qksH6GpxRk4A3Dp+tEMTMmaqjIUp6Yas3JXS5VSwZZN+oBWgofWGJn/h2eTom
	 jMGhspCPeSVEt8+cYEbxuatYN3z+oi+CGLAZV1K0ZONbNYd+S0IIvuvC7EzHGYMlN4
	 w0FIHORbP143A==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xM3bl-000000033XB-2e2l;
	Wed, 28 Oct 2026 14:22:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] tty: n_hdlc: fix read() hangup check
Date: Wed, 28 Oct 2026 14:20:49 +0100
Message-ID: <20261028132049.728457-4-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028132049.728457-1-johan@kernel.org>
References: <20261028132049.728457-1-johan@kernel.org>
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

When a tty is hung up, the file ops are generally set to
hung_up_tty_fops, but this is not the case for, for example,
/dev/console.

Make sure to check the TTY_HUPPING flag so that a hangup is detected and
read() returns zero also with /dev/console (as is done for n_tty [1]).

Note that before commit c96cf923a98d ("tty: Don't block on IO when ldisc
change is pending") a task hanging up the tty would get stuck in
uninterruptible sleep when there are blocked readers, but since then
read() incorrectly returns -EAGAIN instead.

The false-positive stuck hangup issue was flagged by an LLM.

[1] 28b0f8a6962a ("tty: make n_tty_read() always abort if hangup is in progress")

Fixes: 1035b63d3c6f ("n_hdlc: fix read and write locking")
Cc: stable@vger.kernel.org	# 2.6.38
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/n_hdlc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 02676ae9b112..1a3a276f2db3 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -437,7 +437,8 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 			ret = -EIO;
 			break;
 		}
-		if (tty_hung_up_p(file))
+
+		if (tty_hung_up_p(file) || test_bit(TTY_HUPPING, &tty->flags))
 			break;
 
 		rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list);
-- 
2.55.0

