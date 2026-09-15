Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C337F8AF;
	Tue, 15 Sep 2026 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457571; cv=none; b=jGqalcbmfwsx0rGeSKJtvHUWCoLIu5ji5d0Pw+EjxM/y+78X6UrP8TdfzqfA/+VVrLJibBkVIYeInsL/2XlfP1agzgFjLkUAJKv4oghfxTRThWXz0BNj+KwMmJBZhe6J092bqgxI38OR16TuuKl9kz46DSLlFsQFwD/SNfhGkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457571; c=relaxed/simple;
	bh=LDs6I2jPsHw2k1hgz401FIbxmAeyrSVVAQ4vvdjNX9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv5kerreUfHQiGkpKeBuuEntQOYaQ94aQjKjd6yRpXung2Nbzt4ALgGqdNFgAWqI/HRujxYC9Y+nCLWBYKvsX2e4QrSzsa/CrOn135CH4ap0dN09JOpW2SVNzuNz+sB5ZJHJXwI/9C5khbgjZk/T0z5G2dwnmO0CG/8NY4ttIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9eWBOZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9eWBOZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED341F000FF;
	Tue, 15 Sep 2026 07:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789457567;
	bh=t0MXmvAYFbl3pWAUKe1hTqhIpwLgs5+cLwr/ViIXAbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c9eWBOZtqrtkV1jmvswlq3CY6h/7DF6hXL0Bpb+BDJ1SpQ7+nHx1wWimafchCnVWU
	 i6EQ0U5w8Yue3S4s2E6+aCV/5BPFFQL4ykOvLbWVBoI9vShV3CIMzM3kZv8Gc+Subr
	 n3SNWO0B7EENjbHdhBePrU+YPSb99U91kPSoDhK+jiNx1XwqaZAw4cxp7TvpzWjkzC
	 Hu/gi5tnZfFAH+Mt5BrV5R78RZOXlk7+H3pnyf9qaXx7rcu/f+DheWq2YD8/8TH6iW
	 Kfuj6cso8XrxyXAs1HciY42LHrLuwijlCtMu4h0HzWhEB9Wokn/bVXwFmjr1AN49vO
	 N0V7PzqSCjpeQ==
Date: Tue, 15 Sep 2026 00:32:46 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Fan Wu <12321260@zju.edu.cn>
Cc: Fan Wu <fanwu01@zju.edu.cn>, linux-usb@vger.kernel.org,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>, Sicong Huang <congei42@163.com>
Subject: Re: [PATCH] usb: cdns3: fix use-after-free in cdns3_gadget_exit()
Message-ID: <aqj0nuWTHTLpghOJ@hu-petche-lv.qualcomm.com>
References: <20260909095655.694527-1-fanwu01@zju.edu.cn>
 <aqIVzxZyRyx67GPX@hu-petche-lv.qualcomm.com>
 <4BDFACF5-50C7-43B5-861C-9467B6E3D819@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BDFACF5-50C7-43B5-861C-9467B6E3D819@zju.edu.cn>

On 26-09-10 13:50:46, Fan Wu wrote:
> > On Sep 10, 2026, at 10:28, Peter Chen <peter.chen@kernel.org> wrote:
> > 
> > We may cancel work before going to de-init. How about move them before
> > 
> > pm_runtime_put_autosuspend(cdns->dev);
> > 
> > 
> 
> Hi Peter,
> 
> Thanks for the review.
> 
> I think the work items need to be cancelled only after the gadget has
> been quiesced. Moving the cancellations before
> pm_runtime_put_autosuspend() would run them while the gadget driver is
> still bound and requests may still be queued.
> 
> In particular, an EP0 status request can queue pending_status_wq from
> cdns3_gadget_ep0_queue(), and an endpoint request can queue
> aligned_buf_wq from cdns3_prepare_aligned_request_buf(). Thus either
> work can be re-queued after an early cancellation and before
> usb_del_gadget() unbinds the gadget driver.
> 
> usb_del_gadget() performs the gadget unbind and synchronizes the gadget
> IRQ; devm_free_irq() then removes the driver's IRQ handler. Keeping the
> cancellations after these teardown steps ensures that both works are
> drained before cdns3_free_all_eps() and the aligned buffers are freed.
> 
> Could we keep the current placement?

Sure, your comment is reasonable.

-- 

Thanks,
Peter Chen
