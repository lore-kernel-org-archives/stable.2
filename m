Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043D46982A;
	Thu,  1 Oct 2026 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853616; cv=none; b=mCL+o4YWjY/E6Anr6c2LcBvts/oX8+iex/H4Z3+kQQFwJTVCre/Ptt5sQpGuI8B4Qj01YN99v5UWH9s2Ch8r3nU+iyINC5oMBfSqeMbQ2BFM1646/gUoCyCsr4smcCZDUGTmstPILokgFgMakSgjmUAh6XZgFP5lCWc3LVYtFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853616; c=relaxed/simple;
	bh=kC/SzT5P0GDpWs7ARTKCt5H2D1WolDLs9/sRczCePFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAzzOhv4053D0xjzdE5t//54azv1+9g1/HdDl2i69pO0aVxx1Q+BWR23Un+4HACEByovyDN6Pkj9h9qBLnlRETkZqj3lO9p7MrAbnysy0VaJC/H1kElVYVqONvkOQWefjIKtK5Yhym6IbFEVfK4S2bgUQhilIjki3Dq5NQfgjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jnnvfEIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jnnvfEIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AE01F000FF;
	Thu,  1 Oct 2026 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790853615;
	bh=xB6QT33ZavTbqXDTWpFlpBT4Sv9WrndP5GaMulwx55s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jnnvfEIMTf53wFShCOIVdFx/MoSiRrWSAdnCl+Y/gv47V7uyJxZQOyJd2tmWzYy6K
	 9CKRXfO73OhBnkHhEn6Zb7cPjrUGxgIkAO9ww1ZIXV0bQ5hQbjHqVt02dqqIL0U+sL
	 PbVqtnuBZV88EeMz3wM1MfssDVMp7hBXHT2HK8XY=
Date: Thu, 1 Oct 2026 13:20:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: xy521521@gmail.com
Cc: stern@rowland.harvard.edu, Hongyu Xie <xiehongyu1@kylinos.cn>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb-storage: ene_ub6250: don't let the card-type
 probe hang forever
Message-ID: <2026100128-crystal-islamic-b783@gregkh>
References: <20260929144640.2028-1-xy521521@gmail.com>
 <20261001091523.16934-1-xy521521@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001091523.16934-1-xy521521@gmail.com>

On Thu, Oct 01, 2026 at 05:15:23PM +0800, xy521521@gmail.com wrote:
> From: Hongyu Xie <xiehongyu1@kylinos.cn>
> 
> ene_ub6250_probe() queries the card type with ene_get_card_type() while
> holding us->dev_mutex (the locking added by commit 445fc368c6bc
> ("usb-storage: ene_ub6250: fix race between scan work and probe")).
> The query is a bulk-only transaction: CBW, 1-byte data-in and CSW, each
> transferred by usb_stor_bulk_transfer_buf(), which waits for URB
> completion with MAX_SCHEDULE_TIMEOUT.
> 
> That unbounded wait is safe only while a SCSI command is being handled,
> because the command's abort machinery (usb_stor_stop_transport() via
> US_FLIDX_ABORTING) is the only thing that can terminate it.  At probe
> time no SCSI command exists, so a device that passes enumeration but
> never services bulk transfers wedges the probe forever:
> 
>     hub_event:         usb_stor_msg_common() <- ene_send_scsi_cmd
>                        <- ene_ub6250_probe  (holds us->dev_mutex)
>     events_freezable:  usb_stor_scan_dwork  (blocked on us->dev_mutex)
> 
> syzbot reports the second worker as "INFO: task hung in
> usb_stor_scan_dwork"; the hub_event worker is stuck in the same wait
> but sleeps interruptibly, which the hung-task detector ignores.
> 
> Bound the three probe-time transfers with a 30 s timeout through a new
> usb_stor_bulk_transfer_buf_timeout() helper, so a dead device fails the
> probe cleanly and the existing error path unwinds via
> usb_stor_disconnect().
> 
> Fixes: 445fc368c6bc ("usb-storage: ene_ub6250: fix race between scan work and probe")
> Reported-by: syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=30552b4cbe99d6d91306
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
> 
> Changes in v2 (formatting only, no functional change):
> - fix checkpatch --strict "alignment should match open parenthesis"
>   complaints on the newly added continuation lines
> - rename the fDir parameter of ene_send_scsi_cmd[_timeout]() to fdir
>   to silence the CamelCase check

Don't do coding style changes while trying to make a bugfix, as that is
mixing up too many different things.

Please make this a patch series, with the bugfix first, and then if you
want to fix up the coding style issues, that should be a follow-on
patch.

thanks,

greg k-h
