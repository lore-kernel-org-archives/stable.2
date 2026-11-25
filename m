Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608361;
	b=bRz2kEL9nq3X5z+dtkh9bvnO3RJsY+4ECNWQU3hrjDmVGmBmi2OMB8ZBCw0/Rz5SlPVC
	 /R6rfFpAahOslyAtS7FaXuTMjuC0VSs+szM6hFCcv9qrj64x7WpOWS1A53mpTONFHAJ6f
	 +fA/FT1i317VmrSr6P8UlAh5HkBbNrv/wXH7HDv6pMeZPZKcXWgJOd5LOqw/F02DEmVQ0
	 mXJVaPXf/py8p/aFF6NFabdx/wBElBj2JxiLVY0G+K+SeRtf+FZ332KXiSwkckk3wZxBO
	 FyHLnN5EYqcL2UEz+HSAegW99w7ZHOwDLf2OegOy3a0Z1FuwJfD+r3fi/Z/seDI+qjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608361;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FnPYfuMHd7Ay5fWtox8rZh4gRLxZT0XKDK2fP+iqhZU=;
	b=DOkaGNPVzLG2S1uRcicUhB06vjkfEtnetSqOlXBWZFD1CyJQWTDQUcVsi1meOUP4b/wi
	 vRhMdDiDqH2QmHCfJ6FhkRH48t5e35yauaOZyWWEqHewl6ttHXMbbZ0mvaISVA/uvwgju
	 RoA2rFGt9g3SRhAapIW9Vql2iCUmCrM1RHARYVnlq5LBVjOxRFsLi3OsahxbXAPQg/hLK
	 /G9PjzRWztMcUjXnCtBlenKfj3adysufyeRl5iv/Sj5DL2GwKuND1waAUcv9PcbbIAL4W
	 P7qympmUkbCb1aI6sATOUase1fKP3vuRmMRQGWX14kYylQuEoCtGt+1HO9J7+AdQkbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jLonQsvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEF606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jLonQsvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C231F000C6;
	Wed, 25 Nov 2026 12:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608360;
	bh=FnPYfuMHd7Ay5fWtox8rZh4gRLxZT0XKDK2fP+iqhZU=;
	h=Subject:To:Cc:From:Date;
	b=jLonQsvJK291XwahD8LKmsI74ez4WNKcn1dEQ1VYH5qR0DXMKBFzuzlJv2vZdF7Vr
	 VmjqwMza733jZGvF9UZ5SVPbXrlxC7+KtlqirJqlJ9E+RA8ohv/XNit5RkEV+eE3yz
	 SGsklJLdMJBBbxlvmygF59spgFIZ6iDSuai6l73U=
Subject: FAILED: patch "[PATCH] serial: samsung: don't leak the tty on an RX IRQ" failed to apply to 5.10-stable tree
To: josef@toxicpanda.com,alim.akhtar@samsung.com,gregkh@linuxfoundation.org,jirislaby@kernel.org,krzk@kernel.org,peter.griffin@linaro.org,r.baldyga@samsung.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:32:52 +0100
Message-ID: <2026112552-acre-justifier-533d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7ada442f5ef77f8d53f608a0141a5e88a888ca9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112552-acre-justifier-533d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ada442f5ef77f8d53f608a0141a5e88a888ca9f Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 12:06:47 +0100
Subject: [PATCH] serial: samsung: don't leak the tty on an RX IRQ

s3c24xx_serial_rx_chars_dma() starts by taking a reference to the tty.
If the interrupt is not a receive timeout, it switches the port from PIO
back to DMA and leaves through the "finish" label, which does not drop
the reference.

A port with RX DMA changes to PIO on every receive timeout, that is at
the end of every burst of data, and comes back this way when the next
burst starts.  So each burst takes a reference which is never dropped,
and the tty structure is not freed when the port is closed for the last
time.

Drop the reference on both paths.

Fixes: b543c301c2c5 ("serial: samsung: add DMA support for RX")
Cc: stable <stable@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Robert Baldyga <r.baldyga@samsung.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20261027-tty-llm-v1-21-99b0202ae546@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 640f85e2d636..c9a870a8d155 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -736,14 +736,13 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(struct s3c24xx_uart_port *ourport
 
 	s3c24xx_serial_rx_drain_fifo(ourport);
 
-	if (tty) {
+	if (tty)
 		tty_flip_buffer_push(t);
-		tty_kref_put(tty);
-	}
 
 	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
 
 finish:
+	tty_kref_put(tty);
 	uart_port_unlock(port);
 
 	return IRQ_HANDLED;

