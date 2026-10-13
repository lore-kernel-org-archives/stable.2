Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDC3E8C78
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879364; cv=none; b=EsQjcjd47W5zYMq7MBWWgEuUEajF4TTH28UTszRjuk9Cbj84m/uYPtVvXhoXt9rd75xi5dbSoeDxJG9K856sUVYxPXQvSFI4RQj5mc0dUksC4H1cCtOun1fmIXbq1tzy9kvjrylet4WXuJTHgjInG9kZDqRodCkKo0l9VqYnHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879364; c=relaxed/simple;
	bh=C/ARK74uliOtwkcw6316CD3zAAtjsGQvFbgR46N2lmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jmh6JzRoT5IBk299UEiPYJtJ3153l+sdcvRdFSmLlf+XL5LsXBofkdQ1ICF7H4GCRTLh2LSlgjI62yd1mKrFHBWjLMTQh0sfirje+UDpKjkE5ooOFy3o5lK/aRzn1LrcBP/ruwrTf05quemPKgwufH0quIVkexex52SpHxqo1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSEWJ4C2; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSEWJ4C2"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd60e4e8bc3so1272738a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791879362; x=1792484162; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KGgAoWCyHbq3nH+bLKo0Xd8Jo/MUjZUtoCUYkzt3TnQ=;
        b=bSEWJ4C204SMb05ZUYBwyFgwCYSz6dRErdPi0hRfDIZnlkF0ToNWwem9rPL6mrYXG2
         /4l8fjuh0MZpQuzlUMGnvq3hsU47v3oYKwXd196Gz+bTtFlrzSRYNvZkt4OVVqH2K0tG
         iORO1mNl+DGksBagAQ78qVnUjTNbPqXoJFqh2ayJLzKmeO9BJ9+CEW8H5xrAMtfxHijQ
         1qprx0VliVBGJ/K6qHD2I9DDLEPGHAk6xQeVUSU4nhhvNg7yR4RPRJ/ME4oagArutF8o
         DHBuaMBC+q6osMk2C/sfQ/8XC51SUhAoEmENpODSMRyDwLLISLVC07g1H6pqG2NWRI9n
         BZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879362; x=1792484162;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGgAoWCyHbq3nH+bLKo0Xd8Jo/MUjZUtoCUYkzt3TnQ=;
        b=LpfZYlsOC6lEeVuVSzcNKcpyiy2oH5g3Vc3GI48wjFRS8Oo6Xa8hO+GwW99prgg5Cd
         bJUpXRw8F2T2LeRT8xzYqdQ+akNPrLRbvRn3buVfGwHKDuLD22WboSFMGTq9wFYdWRce
         rCSjOxZ6AezjScvGg25NmjVzVSbExlAzngSlu9tlm91h+Bn+Ef5Gtj+cWOHqJHEHqtmg
         4DRTIMY1tf3htPTeXfnLlG8YmtrcMRLwIvEUeHe3BDT7HcibpEN26QrUQIi0KcregMQX
         O3vBw2vJfySB8+5MEy6xzyBl87Uv7zLpCb6aKxKJ/84uQxqQ/yoIXAm320F6Jt6p72BW
         SBHg==
X-Forwarded-Encrypted: i=1; AKwUvBxQvA9O51+xr8uAXPzqoMDFYGaSuDUmOfEh7oOIeL/pnWRqRiRmU+a8ooHtfVXga3FonlbkFMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnleI42huiMSdT8nU6+b4DDyYl/coWFcPc8JBSg84Cjech3vra
	8aem6mfhT/qSZcOmOTETpP8h7DPlTunJewc8RXqnSTZwOygoeqbgUETh60UpqkbDceqzyq4ycnq
	SUSyJISYhMg==
X-Received: from pfbjr11.prod.google.com ([2002:a05:6a00:914b:b0:888:e7c7:5580])
 (user=kyletso job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2183:b0:88b:7712:6e21
 with SMTP id d2e1a72fcca58-897c72fd976mr10228154b3a.33.1791879361957; Tue, 13
 Oct 2026 01:16:01 -0700 (PDT)
Date: Tue, 13 Oct 2026 08:15:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013081549.2375441-1-kyletso@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Fix out-of-bounds read of the pds and
 pd_list arrays
From: Kyle Tso <kyletso@google.com>
To: badhri@google.com, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, kyletso@google.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

select_usb_power_delivery_show() iterates through port->pds (via the
pd_get() callback) and tcpm_find_pd_data() iterates through
port->pd_list until they find a NULL entry. However, tcpm_fw_get_caps()
allocates only port->pd_count entries for each array, and
tcpm_port_register_pd() fills all of them. Without a NULL terminator,
both loops read and dereference one entry past the end:

  Unable to handle kernel paging request at virtual address
  adacafaea9a8ac1a
  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
  pc : select_usb_power_delivery_show+0xa4/0x110
  lr : select_usb_power_delivery_show+0x90/0x110
  Call trace:
   select_usb_power_delivery_show+0xa4/0x110
   dev_attr_show+0x38/0x74
   sysfs_kf_seq_show+0xb4/0x130
   kernfs_seq_show+0x44/0x54
   seq_read_iter+0x158/0x4ec
   kernfs_fop_read_iter+0x68/0x1bc
   vfs_read+0x230/0x2c0
   ksys_read+0x78/0xe8
   __arm64_sys_read+0x1c/0x2c
   invoke_syscall+0x58/0x118
   el0_svc_common+0xb4/0xf4
   do_el0_svc+0x24/0x80
   el0_svc+0x2c/0x90
   el0t_64_sync_handler+0x68/0xb4
   el0t_64_sync+0x1a4/0x1a8

Allocate one extra, zeroed entry for both arrays so that they are
always NULL-terminated.

Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
Cc: stable@vger.kernel.org
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d721baef5210..8f4e10ec6d66 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -8376,14 +8376,21 @@ static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode
 		}
 	}
 
-	port->pds = devm_kcalloc(port->dev, port->pd_count, sizeof(struct usb_power_delivery *),
+	/*
+	 * Allocate one extra entry for each array to keep them NULL-terminated.
+	 * select_usb_power_delivery_show() iterates through port->pds (via the
+	 * pd_get callback) until it finds a NULL entry. Similarly,
+	 * tcpm_find_pd_data() iterates through port->pd_list until it finds a
+	 * NULL entry.
+	 */
+	port->pds = devm_kcalloc(port->dev, port->pd_count + 1, sizeof(struct usb_power_delivery *),
 				 GFP_KERNEL);
 	if (!port->pds) {
 		ret = -ENOMEM;
 		goto put_capabilities;
 	}
 
-	port->pd_list = devm_kcalloc(port->dev, port->pd_count, sizeof(struct pd_data *),
+	port->pd_list = devm_kcalloc(port->dev, port->pd_count + 1, sizeof(struct pd_data *),
 				     GFP_KERNEL);
 	if (!port->pd_list) {
 		ret = -ENOMEM;
-- 
2.56.0.385.gd3acb90ef8-goog

