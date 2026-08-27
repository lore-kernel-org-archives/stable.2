Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65C2D249B;
	Thu, 27 Aug 2026 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806285; cv=none; b=mzHOx/2xg79mvHndQ28BlSNCqwEumLfqEndR+oRJAzhstGH142EyTZ97USvXONS/1z1ohVX98QC9RanadQw1X5/hcmtaKKfotU2J4vCxOr5HEeZv2r0N6OCJZiC5lLCCo1AqChsAERjPE/aHmY5bBCe360emDSBp6eaADkeVt6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806285; c=relaxed/simple;
	bh=2PVJUMRIGdBgdYhtfLUqslgdMUPalwr9L3uqDL4BfhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG8S2evusjB4I4ReOUUOlhvgLNjW+7+q+++CbCtqjvIZKTCnWTlSRsi/JHM+1v1mdvl7j5HnzwnO+ew+AxN6NyUWG88QiO/tLLQbWMnSKnLX2zVlphbYZQG9c9hMqhqk0mZbSYE5tHPdWU3BERVzZOpvYw2LjDoM12yMsW1g8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mrgfsavx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mrgfsavx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4230D1F000E9;
	Thu, 27 Aug 2026 04:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787806283;
	bh=wjVZd0huYEMVFiNAJ3n+nO8GVkhWb7AlzOb28Smkp/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mrgfsavx0r2eMDVwlPziwy2L385VnsLzFyB13COBWTr25W3lMohgo/UEZ7BJ1BY2M
	 b4j9jYFspt/It1wb4S5p0dgwuyyVsLr5xsJhA7YECa8BgTj9X0maXkukrm35n1PTGh
	 KeILD3lqrQ81dJnKegCtwP7DTH7ZhZJ4mWWf99ak=
Date: Thu, 27 Aug 2026 06:51:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: dwlsalmeida@gmail.com, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, mchehab@kernel.org,
	stable@vger.kernel.org,
	syzbot+c7fc4794e59786f5b4dc@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] media: vidtv: fix uaf in
 vidtv_bridge_on_new_pkts_avail
Message-ID: <2026082737-traitor-shorter-a4cc@gregkh>
References: <20260827042229.12561-1-jeffinphilip14@gmail.com>
 <20260827042615.12777-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827042615.12777-1-jeffinphilip14@gmail.com>

On Thu, Aug 27, 2026 at 09:56:15AM +0530, Jeffin Philip wrote:
> >Attempting to unbind a dvbdevice that is in the process of feeding
> >data causes a UAF as we free the underlying device without
> >stopping the feed first. Fix this by stopping the stream first using
> >vidtv_stop_streaming(). However, our codepath in the reproducer
> >(mentioned in the below reply) does not decrement our users
> >(dmxdev->dvr_dvbdev->users) to 1 after it has been incremented to 2
> >by our read() in the reproducer, that is only possible on .release.
> >This can cause a task hang as dvb_dmxdev_release() uses wait_event()
> >in the wait_queue unless we use a close(fd)(in the reproducer).
> >Is this a problem? Please advise.
> 
> Reproducer:
> 
> #include <fcntl.h>
> #include <unistd.h>
> #include <pthread.h>
> #include <linux/dvb/dmx.h>
> #include <sys/ioctl.h>
> 
> static void *feed_thread(void *arg)
> {
>     int i = 100;
>     int fd = open("/dev/dvb/adapter0/demux0", O_RDWR | O_NONBLOCK);
>     struct dmx_sct_filter_params params = {
>         .pid = 0,
>         .filter = { .filter = {0}, .mask = {0} },
>         .flags = DMX_IMMEDIATE_START,
>     };
>     ioctl(fd, DMX_SET_FILTER, &params);
>     char buf[188];
>     read(fd, buf, sizeof(buf));
>     //no close(fd) here
>     return NULL;
> }
> 
> int main(void)
> {
>     pthread_t t;
>     pthread_create(&t, NULL, feed_thread, NULL);
>     sleep(1);
>     int fd = open("/sys/bus/platform/drivers/vidtv/unbind", O_WRONLY);

While "fun", this is not a normal path that users ever will hit.  See
this thread where I propose tainting the kernel if you attempt to do
this:
	 https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org

thanks,

greg k-h
