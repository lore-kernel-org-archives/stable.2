Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA7406297
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570440; cv=none; b=UNLvOFNvGLZ4N0Ys2Yg0mr8vZO6qCG9nJMwV9TyXs9y33wCVlIxHMPyhEEd6Kz8Uj+S6CFHS5oWwjPHDM3GkclhfpVgpLmrDut7W3XhhON7/mAuKJCIy/kzkiROFHDGiFPXdcWAT9Ku5ULZ9uhJVOIZOroZ2t1UvS/64hVXKp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570440; c=relaxed/simple;
	bh=/s0OWpAnlfnM5sngCnBOVrB7W7QOzcVq4ktfWbYZA8c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O3lwuHLBe1WskCRMtuT5lS/0ZBSCzULYvNwNAcmW0AVi+Yxhv6BQuk4ftRYjpG1WCaf8eJK4NXH0QxBNcQ5MsoqrnjRnZpJWQiKGIGGrpx4aYihpAp39kW8R+Gr/nUT6BXoRIALNVWYipemUx2XD9YG/BJpCrmfCt1/d/c73YZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ra3UpX7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ra3UpX7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C6E1F00893;
	Thu,  4 Jun 2026 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570439;
	bh=e6V2Hn9U/jYG61PnlVYfuRK6zEOE2L/whS8fHfrrAJo=;
	h=Subject:To:Cc:From:Date;
	b=ra3UpX7LGBgQAw01Y1OBqzOKbb2losTaG6ZenNq7O26E3Fl7OsMwlB9/2zARIdLWE
	 UyT5KhPDsub8ghUKnxY9Pr5KSaaHCVYbgX+8nfrvnmEVdwa1XLQRTyJcJt89JjchCN
	 ik+rarrmAQYrGiPN/UjY0VhUi/umaURISasfYJv8=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix UART_RX_PAR_EN bit position" failed to apply to 5.15-stable tree
To: prasanna.s@oss.qualcomm.com,gregkh@linuxfoundation.org,konrad.dybcio@oss.qualcomm.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:52:51 +0200
Message-ID: <2026060451-antiquely-coauthor-6f4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ca2584d841b69391ffc4144840563d2e1a0018df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060451-antiquely-coauthor-6f4d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca2584d841b69391ffc4144840563d2e1a0018df Mon Sep 17 00:00:00 2001
From: Prasanna S <prasanna.s@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:56:13 +0530
Subject: [PATCH] serial: qcom-geni: fix UART_RX_PAR_EN bit position

UART_RX_PAR_EN is incorrectly defined as bit 3, which triggers false
framing errors (S_GP_IRQ_1_EN) and causes received data to be dropped
when parity is enabled and the parity bit is 0.

Define UART_RX_PAR_EN as bit 4 of the SE_UART_RX_TRANS_CFG register, as
specified in the reference manual.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Cc: stable <stable@kernel.org>
Signed-off-by: Prasanna S <prasanna.s@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260428-serial-bit-correct-v1-1-9131ad5b97d8@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b365dd5da3cb..5139a9d21b2b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -50,7 +50,7 @@
 #define TX_STOP_BIT_LEN_2		2
 
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_PAR_EN			BIT(3)
+#define UART_RX_PAR_EN			BIT(4)
 
 /* SE_UART_RX_WORD_LEN */
 #define RX_WORD_LEN_MASK		GENMASK(9, 0)

