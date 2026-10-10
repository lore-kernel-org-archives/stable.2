Received: from mx.eu-west-1.pants-on.net (mx.eu-west-1.pants-on.net [52.48.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887AC446047
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.48.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791630291; cv=fail; b=Aulk9rTn6CobuFcs7cEJLyuMO774xnRN9ea7vV6yApDr/zrfPSs1Cb8Ks7CckOqxuWV8xOLF/IUl8mARHtiFSw0qjrLiFMOzaccu8rqMMB65spcOyTAz24CKNJqujn0uGESfjehhAtnT+kM2Z2Xp8zgrZKysq3/95a6wfr5glrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791630291; c=relaxed/simple;
	bh=PA0gpYuL9Sc0pQpb0IG7wfO/HdsgcPxep78OwUvAZmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8MkGlMRyG/00TVvXiuhVUSD7iDFExhDDgTiM53ADzuAetrmf0aOxmztbQ8hKk46moRIhbk45Qs4IooYYtmQF8imfKahwvsdwKo4/xcrsE6ywjNb8/uiTY7kyAnblOE1/Cz5ykAciqG6AbjTTVyw3jD9Cxz9Es8pj2v/t2mkSho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jacquin.bzh; spf=pass smtp.mailfrom=jacquin.bzh; dkim=pass (2048-bit key) header.d=jacquin.bzh header.i=@jacquin.bzh header.b=qf/Fquag; arc=fail smtp.client-ip=52.48.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jacquin.bzh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacquin.bzh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacquin.bzh header.i=@jacquin.bzh header.b="qf/Fquag"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=mx.eu-west-1.pants-on.net; s=20240827.rsa; t=1791630288;
	 b=NyoOxVez2aT5DrUPzzUv/z6nI4mQkgqpcGNXC5dP5Oy/n00X7u6O3AQ2c9ke06XLu05KefDIHC
	  MBrg9Z3x/0xUNd7ObkGZSGWa3JkZhsz3Y8Ij6PuvgRQUMbvQLCJKxdpsmlOAWkQHPQk3toa8JZ
	  AB7cLwhy76PqsADd16P0vu8KOuDZeFPg8IX3t6qwU9OOs3wQ3L2Qjq/Ne1SyQYtdNe5JJ+z+aP
	  z1eyD1MYQL9USN1kzokEuPmmYogZPzhCj8HcMNa04dhiW2q/fQBkBcsbsA0n/SjP4KVi4bKL2D
	  6wvTT4YLUcDOIvB6KqC3DdisXK9TFO0mOnvp4EjI/b4TYg==;
ARC-Authentication-Results: i=1; mx.eu-west-1.pants-on.net; smtp.remote-ip=2001:470:1b3f:100:c143:c31c:85e6:efd7;
	iprev=fail smtp.remote-ip=2001:470:1b3f:100:c143:c31c:85e6:efd7;
	auth=pass (LOGIN) smtp.auth=bertrand@jacquin.bzh
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=mx.eu-west-1.pants-on.net; s=20240827.rsa; t=1791630288; x=1794308688;
	bh=PA0gpYuL9Sc0pQpb0IG7wfO/HdsgcPxep78OwUvAZmU=;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	  DKIM-Signature;
	b=BWV17lexDjmmxTk9qqFG8zB+qFmwJAMPSfu/hPum7FKi0uI7LabPdS9+x8bbFEn9V/7okeQ8mV
	  lS7rk+0549CSR8cg0J6nbWOQYvvgy6NoIJQwXZsPQIB/v+tsCOB/mDuVMhTDpWM7X4ZdLgcrqT
	  xXELstZ2GYzVv9gMxoCwC+CpxqjA0IBsvtTwzVMGu/wjtFzpqTle7iSCQhvQETWpzt34dT1DTq
	  8IpGdR86czIahACEb8zWXr6BNCNUl9qu4l+2oDoYjZvFVz8ED0EZHS2pYeBdtGaAyl4Rzf4bDM
	  H+qRFl3xVmYRH8RnjhOe+evy1AkPEr3PwZdFmyG0Fexi7Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jacquin.bzh
	; s=20240222.rsa; h=BIMI-Selector:Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Author;
	bh=PS3ypG6/V5TKHBrClzMCRNtxHOfvTt2g3hC576rf8ds=; i=@jacquin.bzh; t=1791630288
	; x=1794308688; b=qf/FquagAnMi2ez/+h/vDXasB/gGg3aYw79vhmRDww6nCEsuZ5D9dQf2rMg
	roLgpK1BeBsXqpGSjy0VY0eMt9843pMHPOqayQ0WNrIB03tziN2Xapau5LMbyEZSOKS98OUHV+fFD
	RS5UW30Kzhoz9I6PhHCO3aLQiC+Ww2bzuhpqia1enANwGXe1pTSQKmcX3eM0eLbu6aya5xcziuLVH
	560s8tPlEPky+h9zbtAG2HQp2OeHK11fg6DFa1ZLPoe9o3UGx4GownCbKYngy59Y4Bd65DQcz+LxD
	Av6JrYu8UysHXD+MryGsV73v+CecF0E1qlXh3E0C+G5JVC0D68FA==;
Authentication-Results: mx.eu-west-1.pants-on.net;
	iprev=fail smtp.remote-ip=2001:470:1b3f:100:c143:c31c:85e6:efd7;
	auth=pass (LOGIN) smtp.auth=bertrand@jacquin.bzh
Received: from [2001:470:1b3f:100:c143:c31c:85e6:efd7] (port=17080 helo=lady-voodoo.lan)
	by mx.eu-west-1.pants-on.net
	with ESMTPSA (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	id 1xFUsd-00000000yGf-14lP; Sat, 10 Oct 2026 11:04:43 +0000
From: Bertrand Jacquin <bertrand@jacquin.bzh>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: venkat.jayaraman@intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in power level debugfs
Date: Sat, 10 Oct 2026 13:03:57 +0100
Message-ID: <20261010120357.4937-1-bertrand@jacquin.bzh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
BIMI-Selector: v=BIMI1; s=default;

ucsi_register() creates the debugfs entries right away, but
ucsi->connector is only set by ucsi_init(), which runs later from
ucsi->work and only publishes the connectors once the PPM has been
reset and all ports are registered. Until then, or for good if init
fails, ucsi->connector is NULL, yet the peak_current, avg_current and
vbus_voltage show callbacks dereference it unconditionally.

On an Intel NUC13ANKi5 whose PPM never answers when CONFIG_ACPI_EC=n,
reading those files after the failed init oopses:

  ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
  BUG: kernel NULL pointer dereference, address: 000000000000045c
  #PF: supervisor read access in kernel mode
  RIP: 0010:ucsi_debugfs_register+0x291/0x420 [typec_ucsi]
  Call Trace:
   <TASK>
   seq_read_iter+0x1e4/0x4c0
   seq_read+0x12b/0x160
   full_proxy_read+0x9a/0x1f0
   vfs_read+0xba/0x320
   ksys_read+0x74/0x110
   do_syscall_64+0x79/0x240
   entry_SYSCALL_64_after_hwframe+0x71/0x79

Return -ENODEV from those callbacks while no connector is available.

Fixes: c851b71fd6cd ("usb: typec: ucsi: Add support for READ_POWER_LEVEL command")
Cc: stable@vger.kernel.org
Signed-off-by: Bertrand Jacquin <bertrand@jacquin.bzh>
---
 drivers/usb/typec/ucsi/debugfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
index 77a0dd75edd3..911a151ac16a 100644
--- a/drivers/usb/typec/ucsi/debugfs.c
+++ b/drivers/usb/typec/ucsi/debugfs.c
@@ -92,6 +92,9 @@ static int ucsi_peak_curr_show(struct seq_file *m, void *v)
 {
 	struct ucsi *ucsi = m->private;
 
+	if (!ucsi->connector)
+		return -ENODEV;
+
 	seq_printf(m, "%u mA\n", ucsi->connector->peak_current);
 	return 0;
 }
@@ -101,6 +104,9 @@ static int ucsi_avg_curr_show(struct seq_file *m, void *v)
 {
 	struct ucsi *ucsi = m->private;
 
+	if (!ucsi->connector)
+		return -ENODEV;
+
 	seq_printf(m, "%u mA\n", ucsi->connector->avg_current);
 	return 0;
 }
@@ -110,6 +116,9 @@ static int ucsi_vbus_volt_show(struct seq_file *m, void *v)
 {
 	struct ucsi *ucsi = m->private;
 
+	if (!ucsi->connector)
+		return -ENODEV;
+
 	seq_printf(m, "%u mV\n", ucsi->connector->vbus_voltage);
 	return 0;
 }
