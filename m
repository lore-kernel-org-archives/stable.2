Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEA360EFB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569987; cv=none; b=siXaPacbytZsSPHfW4m8+nj8CgEicJK29hnTPtcRdGMlXUvjh3AFTim0Vk8dVO/fI6rug74qa5RopzRI/XKh6ShEkcNHf/kvkcLu92huhUyr8oqroAqoRG/Q3FQIUfadiTOl89aB32/VlyxINUlGjrHCkb1b1wDweFTyCZMSJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569987; c=relaxed/simple;
	bh=6uh4YnXpSi1lLwBTO+YVWeDooOQJez8uCGIDahJcoYk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WrjjRt/ngtCX9szYNGTH4vWQRc4F5zmYPB54ioWQH2ZYy38RZa+pzC4d9zSfrrExGzovG6PoItjaQf3z51beO37Ra0riqciQW/8Z3RZXgFfyDEeUGImrIeQoH94KKxQo36JU/FSKlaAjhX/rE3GPI/rpVVqNiL3upRmXPROJlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7WMn8+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7WMn8+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666941F00893;
	Thu,  4 Jun 2026 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569985;
	bh=K4SvpmJXrJMs889BSfqSATo65dV/WTnyvo4EAI35JLM=;
	h=Subject:To:Cc:From:Date;
	b=L7WMn8+cGZANv/EGSAWP8MW8qL2lvxPNGt6+KG9YdX/hsPog8sQh13yt9ohwP+M7e
	 siZsw7eJs8sAXIrcsIoUuPgRCmUlYGaGCypbBEjyPhl3WrrpUk89ndSbCy0etypLy7
	 Vji2AOxF9KKyorxznoSRpeaNHcmJ2kv5xfCQQpiA=
Subject: FAILED: patch "[PATCH] USB: serial: digi_acceleport: fix memory corruption with" failed to apply to 6.18-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:45:27 +0200
Message-ID: <2026060427-gossip-stony-dea7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x cb3560e8eab1dfa1cac1ed52631adf8ec6ff2cd5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060427-gossip-stony-dea7@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb3560e8eab1dfa1cac1ed52631adf8ec6ff2cd5 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 20 May 2026 16:26:22 +0200
Subject: [PATCH] USB: serial: digi_acceleport: fix memory corruption with
 small endpoints

Add the missing bulk-out buffer size sanity checks to avoid
out-of-bounds memory accesses or slab corruption should a malicious
device report smaller buffers than expected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index d515df045c4c..c481208255eb 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1229,15 +1229,34 @@ static int digi_port_init(struct usb_serial_port *port, unsigned port_num)
 static int digi_startup(struct usb_serial *serial)
 {
 	struct digi_serial *serial_priv;
+	int oob_port_num;
 	int ret;
+	int i;
+
+	/*
+	 * The port bulk-out buffers must be large enough for header and
+	 * buffered data.
+	 */
+	for (i = 0; i < serial->type->num_ports; i++) {
+		if (serial->port[i]->bulk_out_size < DIGI_OUT_BUF_SIZE + 2)
+			return -EINVAL;
+	}
+
+	/*
+	 * The OOB port bulk-out buffer must be large enough for the two
+	 * commands in digi_set_modem_signals().
+	 */
+	oob_port_num = serial->type->num_ports;
+	if (serial->port[oob_port_num]->bulk_out_size < 8)
+		return -EINVAL;
 
 	serial_priv = kzalloc_obj(*serial_priv);
 	if (!serial_priv)
 		return -ENOMEM;
 
 	spin_lock_init(&serial_priv->ds_serial_lock);
-	serial_priv->ds_oob_port_num = serial->type->num_ports;
-	serial_priv->ds_oob_port = serial->port[serial_priv->ds_oob_port_num];
+	serial_priv->ds_oob_port_num = oob_port_num;
+	serial_priv->ds_oob_port = serial->port[oob_port_num];
 
 	ret = digi_port_init(serial_priv->ds_oob_port,
 						serial_priv->ds_oob_port_num);

