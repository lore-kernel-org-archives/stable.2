Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890939;
	b=GNo0tPmsuBU2KMR327iBK+2Iq8peSqUeBc74obipD0oQ0lZCCtqc2zCU2tPV63f8u27C
	 lMxCufHXL8FiZW8xRD5zZeDot6/rfMorcY8ovXLyAW+zg+u9Obb9H8gEUTRfifok8sNgY
	 Cu91tWUzhBQWMMNCd2QpFsH4JRmCVDQFUweeXtGcOex1d1nNJKgUp1pQIXYXUWNdQksoB
	 0TZP3iqgiy5/pefOEY7VdpaNozAP5A1nSy7oKK6jdXMzhJgVkoJPFVCEDISRzrzAgbL/j
	 Jm0LQ3fvxqQQvAzPbBfPKMo2sTKTVXAVnBMeEqO3friTAqhALd7VhNBYap36/bwgnkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890939;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Th2EePlfDg5QnQaDDFMLBDaeEnUxKbLxz61zlAt+uE0=;
	b=mjkjyooXQKJBJP9/l3FwwUtu9YtZREMXPFiX+LQl5YzKVig0/Jd8Xu/49hk3LveNgcgh
	 8A8KqZTxxmr++84Y4UyKwEZx+Dr07LmNaMMYC/BxEyVetRDr67m2TNZiDvSdFr/gjYsRB
	 ZcSyfh5z7Un49J4Y5JU2yjAzdAzejWTNLC+gDrt980iUkatX67clUjIDsFkf2zHIpGt4j
	 pPCF4/wS/mNyW4RySynqqk+i8Vj9g7LMhwd2mIrDzUu26h0tkMuFzRpB45/mHsxlF779b
	 JfW0k+0pu0fD8mOFSnl9dFRLMjALeJ1dblEypFKFViVu5v+pcrcxbeKLDIkydWAxt4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="meR5T6/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C2390606A33C;
	Thu,  5 Nov 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meR5T6/I
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AD8AA1F000C1;
	Thu,  5 Nov 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890938;
	bh=Th2EePlfDg5QnQaDDFMLBDaeEnUxKbLxz61zlAt+uE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=meR5T6/I46yjJhz4yyyaHZYAQbaaa+3LeJAZX3g6igvawMtWZvFh1TSt+Dgar55Ew
	 RH6DUGlGdCeYliFyiQcVFeKqZ+pyVB8PZPefKd1SyRrjACqwpwdnqe9uP+t12DDiIQ
	 idmBs69Qy4W72zpR1NJN80sK5asD4at1nQgmEE32ioowlW372OvX9GJ+sS5CNU/+JH
	 REajFGxH4nWRlvyp00anCJ9/4CkF6aXztOaLLTetHobngeHLffkS7a2M4g7chRpWzJ
	 D8zVJ4b0xCDrArTfUY34wVXxtQVI0w0kaVFU0UA498EmQRakXSahJZUtKZtBHUk+2a
	 JWGCrjOeKuw5A==
Date: Thu, 5 Nov 2026 16:02:14 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: fix waitqueue deadlock on chip deregistration
Message-ID: <k73l7tb5qwvzk76uv5e56kz4yybuqgpiq7u5qt46z6xc3bgle7@lkqecrcpaerv>
References: <20261105-gpio-cdev-srcu-deadlock-v1-1-6047117030ec@oss.qualcomm.com>
 <20261105145711.GA92894@rigel>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105145711.GA92894@rigel>

On Thu, Nov 05, 2026 at 10:57:11PM +0800, Kent Gibson wrote:
> On Thu, Nov 05, 2026 at 03:47:59PM +0100, Bartosz Golaszewski wrote:
> > The three calls to wait_event_interruptible_locked() sleep while holding
> > gdev->srcu. In gpiochip_remove(), synchronize_srcu() runs before
> > gcdev_unregister(). The latter fires the waitqueue wakeup events from
> > the notifier callbacks, so a reader blocked on an empty FIFO never leaves
> > its SRCU section and the removal will block forever in the former.
> > 
> > Since rcu_access_pointer() is a plain READ_ONCE(), we don't really need
> > to take the SRCU read lock. We don't access the chip structure after
> > checking it. Remove the lock and instead make the waitqueue aware of the
> > possible chip deregistration. Keep the initial gdev->chip checks as
> > removing them may change the error codes visible to user-space, for
> > instance in cases of a non-blocking read on an empty fifo.
> > 
> > Ideally, we'd factor out the common code into a dedicated helper but
> > there doesn't seem to exist a clean way of passing a kfifo as argument
> > so let's open-code the three call sites.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > ---
> > I've had it on my TODO list for a while. I vaguely remember someone
> > reporting it to me but can't find the reference anymore. Please feel
> > free to add a Reported-by: and Closes:.
> > 
> 
> Isn't this the same as patch 4/7 in Adrian's series[1]?
>

Dang it, yes indeed. Which may explain why I had it written down for
some reason and thought I was supposed to fix it.

Nevermind this patch.

Bart
