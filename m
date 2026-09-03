Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42029305680;
	Thu,  3 Sep 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426223; cv=none; b=R4lNeri0J554POAa02I5psLE1Ea93Rheg1hmVqbtHWulCWTWQhwRf+AKTJ9m83VbkFX+96xcu/gUG7hadBttJzZWpXTCDChu8/Sy735eUXKbfejAXJ1D1qlcGWpZYgUjE1gvQJx+pg/GE5fZSYiTsEZNaL2yXpSpZJul+d1e9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426223; c=relaxed/simple;
	bh=J9pzeTRSX8tyvwBWC9Qzfg0J5T1NZf6RxNPmwnTgShg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJi/H9YBws1xccaGrySZD2gukYcRZRzpla7/41HBSCSDZvjU/qXX7i5X0xQdWOyGouvA6YUNW/gnDkFG0MRlgVbLv3JWnaI2P4Vlqofc0o7Gbm3juSSI+EVjshMjynY17omV8FzwktbqZoZ9LNqbFnRzvDShG2KGzNFxrARit9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1mqeQaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1mqeQaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27B11F000E9;
	Thu,  3 Sep 2026 09:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788426221;
	bh=Bo3M2wAKIFGdoV6Gsf2EUkbox2lHlAyGcrrY6tZbE4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z1mqeQaCmxL3aYsFTUE8CtbcZCe4AHQbn4i43ECzq2z9MyBKqR34YxguWHCUukB7u
	 KTfxwZAmsnroNjhFMedZcoraepMQakoaH3nEnJuf93W6RRegpx4WXd/3Ql/RYVO6YG
	 D5UiwwKurfmhNIdQLgexx8fNXRgGeRqALukoR/uw3vZNBhxDGQB0dxCk0pEP6V2ZdF
	 BqjFfC15M2pwrp9L/k1jTPPTW9gKaDG/kKkhEDvPLIodlPSE6cJZvh/9n3rdETwuLe
	 DQc8sXqCB37+jfdcsX5vyWHJMyU+6omTML/zVlb9Tghfu1a9VkeLaq6WNeL/j5pz0I
	 i9ZgAs55KnbbQ==
Date: Thu, 3 Sep 2026 10:03:38 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mailbox: pcc: Synchronize channel IRQ before unmapping
 shared memory
Message-ID: <20260903-impetuous-exceptional-python-db8aba@sudeepholla>
References: <20260828161033.3783599-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161033.3783599-1-christian.loehle@arm.com>

On Fri, Aug 28, 2026 at 05:10:33PM +0100, Christian Loehle wrote:
> pcc_mbox_free_channel() unmaps the PCC shared-memory region before
> mbox_free_channel() invokes the controller shutdown callback. For
> interrupt-capable extended subspaces, an in-flight handler may
> consequently access the mapping after it has been invalidated.
> 
> Release the mailbox channel first so its IRQ is disabled and synchronized
> before unmapping the shared-memory region. Serialize PCC channel
> acquisition and release across this sequence: once mbox_free_channel()
> makes the channel available, another client must not replace the
> shared-memory mapping until the old one has been unmapped.
> 

Breno Leitao has already posted the fix for the unmapping before freeing
the channel. You just need the mutex guards.

> Fixes: 7f9e19f207be ("mailbox: pcc: Check before sending MCTP PCC response ACK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/mailbox/pcc.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 

I believe after Breno's patch, it can be as simple as below:

Regards,
Sudeep

-->8

diff --git i/drivers/mailbox/pcc.c w/drivers/mailbox/pcc.c
index 9888dab64639..e5e8caa54cf2 100644
--- i/drivers/mailbox/pcc.c
+++ w/drivers/mailbox/pcc.c
@@ -53,6 +53,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/log2.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
@@ -113,6 +114,7 @@ struct pcc_chan_info {
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
 static struct pcc_chan_info *chan_info;
 static int pcc_chan_count;
+static DEFINE_MUTEX(pcc_chan_mutex);

 /*
  * PCC can be used with perf critical drivers such as CPPC
@@ -392,6 +394,8 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
 		return ERR_PTR(-ENOENT);

+	guard(mutex)(&pcc_chan_mutex);
+
 	pchan = chan_info + subspace_id;
 	chan = pchan->chan.mchan;
 	if (IS_ERR(chan) || chan->cl) {
@@ -434,6 +438,8 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 	struct pcc_chan_info *pchan_info;
 	struct pcc_mbox_chan *pcc_mbox_chan;

+	guard(mutex)(&pcc_chan_mutex);
+
 	if (!chan || !chan->cl)
 		return;
 	pchan_info = chan->con_priv;

