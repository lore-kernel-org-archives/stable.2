Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597879;
	b=gOgxdG2nbEQ/cpFbr+ECSn5Z8IKABfjbDw4xBbQ/r4RhZ3JvthI6mYmAwtXtdNvXVd53
	 SHrDDeTcllpdwWR533WgFY5cdJpd4axnK9eyjgHSyO2QBh6k9VJShMAIRISI/Wox7YCjz
	 80I73DAxlLSBgUVfHRehkCIcrBvwkGCElO/Of30YvTcJ15GZoQRET4xiFDB/7kKEKM9zN
	 HdZVv1uvLop0ZAFI8/WPuTfFm91JhtXmFFFpkY33DL0FOV37R0N1+vGta+iRsviNfCB+I
	 bbKj+aR7SJ8K9cS5aH8ihb2dUaRpsXsbhjrtEx/r0yp3a2alksqCrX9EBCDwOD/MkyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597879;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YXO8QEsWAjNbJSedg5jGQWScpXF+b53n+NzKi0jBBRk=;
	b=J4CaUBfx1LAmKnjl9YiybmUJ/6nROs7zd2L9GTBnqsx9dRzbMgyKfX9xtClij7obYOpP
	 UtlM6o3/xQwrkWwqpQPQmvL6uzd+DxhOkeE8klCQlfuUzh9LmUY/1eSbU3r/0lSv1oOH1
	 Mvcv3ES1MODtdgipDraOF8guAOhWBSKM4D3qdXK98KVoy3Lm1/9d0JKXqSBwN3+kV1vUS
	 sywn30vrIqwTaPAkOTVnhwV0BEs3Ar28Alm4OcTO256ULNaxoYlDQp9ziyMXDpHcqCTzZ
	 fxakFAqx9paTcL3k09xCjVL+Kw2+ZQ2Zu5kyoNy99gGA8EiAmQrAU3QohV5dFIwfDlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NG7lfs6S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C8606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NG7lfs6S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472701F000C0;
	Wed, 25 Nov 2026 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597878;
	bh=YXO8QEsWAjNbJSedg5jGQWScpXF+b53n+NzKi0jBBRk=;
	h=Subject:To:Cc:From:Date;
	b=NG7lfs6SlPCHoX41pLqJgtm30qqrBDCII2ZZwnF10QQtXk4nCZpuxkLo9fPZ0G/9d
	 Fnvy8JFvlp5T0t77F/Ru7CsqzNKHewy3bSRSTu7sGKPC2CYmkT86utOBRkErTLxuhj
	 oXZe1lKEfkAmueBcOgX6af5YOSgd3vYcSPpS7bq4=
Subject: FAILED: patch "[PATCH] gve: Block invalid ring sizes when device options are 0" failed to apply to 7.3-stable tree
To: treapking@google.com,hramamurthy@google.com,jordanrhee@google.com,joshwash@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:59:42 +0100
Message-ID: <2026112542-ethanol-oasis-b0ce@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x edc9a730ad3c98662047a76db2d7f26ea4350b2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112542-ethanol-oasis-b0ce@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From edc9a730ad3c98662047a76db2d7f26ea4350b2e Mon Sep 17 00:00:00 2001
From: Pin-yen Lin <treapking@google.com>
Date: Mon, 9 Nov 2026 18:20:35 +0000
Subject: [PATCH] gve: Block invalid ring sizes when device options are 0

On older device versions, minimum ring sizes in the device option are
reported as 0. The driver imports these 0 values, allowing userspace
(`ethtool -G`) to request invalidly small ring sizes.

This issue was discovered and actually triggered by the
drivers/net/ring_reconfig.py selftest (ringparam test case). Halving the
ring size down to 1 triggered a kernel NULL pointer dereference in
gve_tx_alloc_rings_dqo():

  BUG: kernel NULL pointer dereference, address: 0000000000000002
  RIP: 0010:gve_tx_alloc_rings_dqo+0x1c4/0x510 [gve]
  Call Trace:
   <TASK>
   gve_queues_mem_alloc+0x29/0xa0 [gve]
   gve_adjust_config+0x1b/0x140 [gve]
   gve_set_ringparam+0x1f4/0x250 [gve]
   ethnl_set_rings+0x260/0x440
   ...

Fix this by falling back to the driver's default minimum ring sizes
(GVE_DEFAULT_MIN_RX_RING_SIZE and GVE_DEFAULT_MIN_TX_RING_SIZE) whenever
the device option reports minimum ring sizes as 0.
The device reports either both minimum ring sizes or neither, so a
single fallback for both is sufficient.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the device")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20261109182036.2910559-4-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 8b215fca9c1b..2c848f0c23dc 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -191,7 +191,9 @@ void gve_parse_device_option(struct gve_priv *priv,
 		*dev_op_modify_ring = (void *)(option + 1);
 
 		/* device has not provided min ring size */
-		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
 			priv->device_info.default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:

