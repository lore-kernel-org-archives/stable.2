Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22F3019D8;
	Wed, 15 Jul 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124052; cv=none; b=JaWP7ETMovtex6ywdisKq1frT987oSem6iTQtqRq/aDp3HQHnbbLCbr0UDaCF466OmlQMfKgjMZGGZQwEplf2XqCTsE0ie4sDMiC/mfB9h/PG2KN+0NNqVNWsjnVz6z4QmXN4O5s4fo5RsRfpCwBWwjYwrvc2tRN3Shw36ZWogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124052; c=relaxed/simple;
	bh=ukjcdgTG9XuOq7t7zom1ncaSxqFFGv0mhRH4E08Au5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqxSrSlF5lQSlQgkxuXs5hOpZAim7pKL09W96UPrU22SKIYorQ3vpMgNzRxef4JhqPHc5idqkqaEXL89e8Q9FD1+pk9ckPgvDgRktUWbZseVyyI62Q1xS+tV91aMTq8Xg4LTP4gY5FhlEmB5ql8JvBpTJgS+D18EZzM5i5FGoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsbaqvhZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsbaqvhZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784124051; x=1815660051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ukjcdgTG9XuOq7t7zom1ncaSxqFFGv0mhRH4E08Au5E=;
  b=fsbaqvhZdhmTlvgc7wrtZXMzsH5x5n0KmS8EL8Sa1Etc29pN/zXQF2vX
   nTmddP4qk93lYp+/fxjhwC9+ix3vHYBfgOltaVHfTCn83EXZKG7fqCN8S
   +N3L6T8dkM0QEzFBAdI/6L9Iw6EL8y4Frw0z1scnXMamSUqK2iWT9aBMs
   yXDrGeo3JvKGLCm9nS0sod37Wkwj6r9gGr3pRyiiLblIByki9pcNeXqP0
   Pp3TZxJWxYaPWz5v785ZExUjTbivGJIgotE9uV3vx6Qxt8J7HhuBOqhOb
   QvSiV3Hlsq5Ec4J8iOZCopUo/cY1I178ofJd3bxPXBI4MiWmZp7dddVdP
   g==;
X-CSE-ConnectionGUID: lurNblnIQaqXl3mm5lQdkg==
X-CSE-MsgGUID: 2LvZImLrR36A90OMgH9MuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84543315"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84543315"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:00:51 -0700
X-CSE-ConnectionGUID: Uh786iniRrmjo7zN+7u/3A==
X-CSE-MsgGUID: 83FZPJTrTmSurlB6sr2Vqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="255681857"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 15 Jul 2026 07:00:47 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 3E21995; Wed, 15 Jul 2026 16:00:46 +0200 (CEST)
Date: Wed, 15 Jul 2026 17:00:44 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] drm/xe/i2c: Fix the interrupt handling
Message-ID: <aleSjGxhStAiqLk6@kuha>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <20260713155601.711389-3-heikki.krogerus@linux.intel.com>
 <alcoDtq2aul-tA_h@black.igk.intel.com>
 <aldYjL2pxA7QxoLN@kuha>
 <ald1HG6KzjWb9CUK@black.igk.intel.com>
 <aleEReNBnQMy3-1E@kuha>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aleEReNBnQMy3-1E@kuha>

Hi Raag,

> > > > > -	/* Forward interrupt to I2C adapter */
> > > > > -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> > > > > +	xe_i2c_handle_smbus_alert(xe->i2c);
> > > > 
> > > > [1] Can we move the below re-assert code to wq now? Or do you suspect any
> > > > side-effects?
> > > 
> > > I think that you know this better than I do. But at this point
> > > interrupt is cleared, so why should we wait for the wq?
> > 
> > When does AMC clear the alert signal? Is it when you query from the wq?
> > If the answer is yes, there's a possibility we might end up with an
> > interrupt storm here.
> > 
> > > To play it safe, can we change this as a followup if necessary?
> > 
> > Sure, I'll leave it to you.
> 
> I'll move it to the wq. There are no side-effects.

Can you check does this work:

diff --git a/drivers/gpu/drm/xe/xe_amc.c b/drivers/gpu/drm/xe/xe_amc.c
index b44d5765f2ed5..1a517b79d0bb3 100644
--- a/drivers/gpu/drm/xe/xe_amc.c
+++ b/drivers/gpu/drm/xe/xe_amc.c
@@ -11,9 +11,12 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 
+#include "regs/xe_i2c_regs.h"
+
 #include "xe_amc.h"
 #include "xe_device.h"
 #include "xe_i2c.h"
+#include "xe_mmio.h"
 
 /**
  * DOC: Add-In Management Controller (AMC)
@@ -103,7 +106,7 @@ static void xe_amc_work(struct work_struct *work)
        ret = i2c_master_send(client, (u8 *)request, sizeof(*request));
        if (ret < 0) {
                dev_err(&client->dev, "failed to send request (%d)\n", ret);
-               return;
+               goto out_reassert_interrupt;
        }
 
        /* AMC needs 20ms to generate the response. */
@@ -112,22 +115,22 @@ static void xe_amc_work(struct work_struct *work)
        ret = i2c_master_recv(client, (u8 *)&response, sizeof(response));
        if (ret < 0) {
                dev_err(&client->dev, "failed to read response (%d)\n", ret);
-               return;
+               goto out_reassert_interrupt;
        }
 
        if (!response.header.len) {
                dev_err(&client->dev, "empty response from AMC\n");
-               return;
+               goto out_reassert_interrupt;
        }
 
        if (memcmp(&response.message, &request->message, sizeof(struct amc_message))) {
                dev_err(&client->dev, "response does not match the request\n");
-               return;
+               goto out_reassert_interrupt;
        }
 
        if (response.error) {
                dev_err(&client->dev, "AMC error 0x%02x\n", response.error);
-               return;
+               goto out_reassert_interrupt;
        }
 
        dev_dbg(&client->dev, "%s: Alert reason: %d\n", __func__, response.value);
@@ -143,12 +146,19 @@ static void xe_amc_work(struct work_struct *work)
        default:
                break;
        }
+
+out_reassert_interrupt:
+       xe_mmio_rmw32(amc->i2c->mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
 }
 
 void xe_amc_handle_alert(struct xe_i2c *i2c)
 {
+       xe_mmio_rmw32(i2c->mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
+
        if (i2c->client[XE_I2C_CLIENT_AMC])
                queue_work(system_long_wq, &i2c->amc->work);
+       else
+               xe_mmio_rmw32(i2c->mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
 }
 
 int xe_amc_init(struct xe_i2c *i2c)
diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 8a978526e2b66..3859d4a9f75e4 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -87,6 +87,8 @@ static void xe_i2c_client_work(struct work_struct *work)
        };
 
        i2c->client[XE_I2C_CLIENT_AMC] = i2c_new_client_device(i2c->adapter, &info);
+
+       xe_i2c_irq_postinstall(i2c_adapter_to_xe_device(i2c->adapter));
 }
 
 static int xe_i2c_notifier(struct notifier_block *nb, unsigned long action, void *data)
@@ -183,17 +185,10 @@ static bool xe_i2c_irq_present(struct xe_device *xe)
  */
 void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
 {
-       struct xe_mmio *mmio = xe_root_tile_mmio(xe);
-
        if (!(master_ctl & I2C_IRQ) || !xe_i2c_irq_present(xe))
                return;
 
        xe_i2c_handle_smbus_alert(xe->i2c);
-
-       /* Deassert after I2C adapter clears the interrupt */
-       xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
-       /* Reassert to allow subsequent interrupt generation */
-       xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
 }
 
 void xe_i2c_irq_reset(struct xe_device *xe)
@@ -392,6 +387,5 @@ int xe_i2c_probe(struct xe_device *xe)
                return ret;
        }
 
-       xe_i2c_irq_postinstall(xe);
        return devm_add_action_or_reset(drm_dev, xe_i2c_remove, i2c);
 }

Thanks,

-- 
heikki
