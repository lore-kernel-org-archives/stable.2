Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3F4AE138;
	Tue,  8 Sep 2026 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875533; cv=none; b=QJNu2SAivldGRrWO68vYW6YhhzSR14qsCvB37Y/xyUD33dzbYHqJUIiGlAgiNd+Wb511oHlzr6/O26Zn4btt07FOcBLegZjTNiryZSaebrQ/WhnVuy72uyPLwE4fhVT4xJIg+GNj/338+cwlaqEyjMeoejDL+VPpgWttF+KcC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875533; c=relaxed/simple;
	bh=Df8qXEo8UsnQNwgRqqCMUapr8nbkoYTbtsz3wYoOMFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmEnX8VbDztjzTZLR3nXTz23igQB87Axz45mj7UYcA0MKkC5L+sfRC9Cu3KMhFk+KNgstSF6ZJjjtD3n9hlVs529E8xjNx4MU5LD4z3um2Il/WFow2GKDCPVoVUIeMAQZAqda0/ioLzU3BM4F+iY8sjbC8Fix9xa+5aBgd4ogpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyTqK3uB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyTqK3uB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDB11F00A3A;
	Tue,  8 Sep 2026 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875520;
	bh=jnCS9pXhim/eWcVp4OfT3e5HfVEzS4dxTYx15mUGx7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GyTqK3uBYEYmXJviIwBtmA2VyVbmhAa5UC8WjRmVm+V/gskQgEiYidpBJoPglmL8p
	 FB2lMbYuirXZAAJmflJhY7n9zD029aIFvqG78e3MkPlsz3aCNGecGzyHdn/OkmS8I6
	 rCvPWZWqMsJH00LODKMp3BHjIypaqMtxUav1SorNNfg57tbw9hG9fTjloRuz7dmXwB
	 5ztAZaEsxQI2Bs5T+AgPs/RirVdgAdPCGuhYWmHEbZa3yZ5V3hq/jXWQ8nV9HCD5I0
	 rQvgOmUoGZ7DK7DI/fcbHYR+UrjtdvVv/uEeb5rUf/UJpiRs8W/3w3iawD6rZr4aCZ
	 lryKtVQZpYJ0w==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3wEv-00000001jBY-3XE6;
	Tue, 08 Sep 2026 15:51:57 +0200
Date: Tue, 8 Sep 2026 15:51:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Adriano =?utf-8?Q?C=C3=B3rdova?= <adrianox@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mmc: vub300: fix use-after-free in vub300 teardown
Message-ID: <aqAS_dB3_whEBd0O@hovoldconsulting.com>
References: <20260907151428.643841-1-adrianox@gmail.com>
 <ap-4khETBju3X8-T@hovoldconsulting.com>
 <CAMGU2hXrURUh3NknkgLnmyiJiEwEqZdDz3Ujy5tO8oqVMD9OJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGU2hXrURUh3NknkgLnmyiJiEwEqZdDz3Ujy5tO8oqVMD9OJw@mail.gmail.com>

On Tue, Sep 08, 2026 at 10:28:06AM -0300, Adriano Córdova wrote:
> El mar, 8 sept 2026 a las 4:26, Johan Hovold (<johan@kernel.org>) escribió:
> >
> > On Mon, Sep 07, 2026 at 12:14:28PM -0300, Adriano Cordova wrote:
> > > Do not dereference mmc/vub300/udev after the final kref_put, because
> > > it can release them via mmc_free_host()/usb_put_dev().
> > >
> > > Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
> >
> > This commit reverted a buggy change so if anything is broken here, this
> > isn't the commit to blame.
> >
> > > Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
> > > Link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> >
> > Are you missing an Assisted-by tag?

Again, are you using an LLM without disclosing it?

> > > ---
> > >  drivers/mmc/host/vub300.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > > index 2dae474dcd06..a1a6aa1aafdb 100644
> > > --- a/drivers/mmc/host/vub300.c
> > > +++ b/drivers/mmc/host/vub300.c
> > > @@ -370,13 +370,14 @@ static void vub300_delete(struct kref *kref)
> > >  {                            /* kref callback - softirq */
> > >       struct vub300_mmc_host *vub300 = kref_to_vub300_mmc_host(kref);
> > >       struct mmc_host *mmc = vub300->mmc;
> > > +     struct usb_device *udev = vub300->udev;
> > >
> > >       usb_free_urb(vub300->command_out_urb);
> > >       vub300->command_out_urb = NULL;
> > >       usb_free_urb(vub300->command_res_urb);
> > >       vub300->command_res_urb = NULL;
> > > -     usb_put_dev(vub300->udev);
> > >       mmc_free_host(mmc);
> > > +     usb_put_dev(udev);
> >
> > This makes no sense at all as the driver data is freed by
> > mmc_free_host().
> 
> mmc_free_host() only frees mmc (struct mmc_host) and vub300
> (struct vub300_mmc_host), but the udev (struct usb_device, linked
> as mmc->parent) is not freed by mmc_free_host() and has to be
> freed separately.
> 
> But it cannot be freed before mmc_free_host(), because the kobject
> cleanup code of mmc_host accesses it in mmc_host_classdev_release()
> via host->parent->of_node.

That's a bug in MMC core. It needs to hold a reference to the parent, or
just store the id directly. 

And your LLM didn't put any of this in the commit message.

> > >       /*
> > >        * and hence also frees vub300
> > >        * which is contained at the end of struct mmc
> > > @@ -1794,8 +1795,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
> > >                       construct_request_response(vub300, cmd);
> > >                       vub300->resp_len = 0;
> > >                       mutex_unlock(&vub300->cmd_mutex);
> > > -                     kref_put(&vub300->kref, vub300_delete);
> > >                       mmc_request_done(vub300->mmc, req);
> > > +                     kref_put(&vub300->kref, vub300_delete);
> >
> > This order has been here since the driver was merged.
> >
> > >                       return;
> > >               }
> > >       }
> > > @@ -1946,8 +1947,8 @@ static void vub300_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
> > >                   satisfy_request_from_offloaded_data(vub300, cmd)) {
> > >                       cmd->error = 0;
> > >                       mutex_unlock(&vub300->cmd_mutex);
> > > -                     kref_put(&vub300->kref, vub300_delete);
> > >                       mmc_request_done(mmc, req);
> > > +                     kref_put(&vub300->kref, vub300_delete);
> >
> > Same here.
> >
> > So if this is wrong (it does look suspicious, but this driver is just a
> > mess) then that's the commit to blame.
> 
> Hope is more clear now, it makes sense to me, and I think the Fixes:
> tag is right.

No, these issues were there since the driver was merged, that is, they
were introduced by commit 88095e7b473a ("mmc: Add new VUB300
USB-to-SD/SDIO/MMC driver") in 2011. (And the of_node issue was
introduced in 2021.)

The broken devres change may or may not have masked them for a bit, but
the revert is not the culprit here.

> >
> > >                       return;
> > >               } else {
> > >                       vub300->cmd = cmd;

Johan
