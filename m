Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9932E151
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787498282; cv=none; b=UHgV7nkkddvuU+ItNUOAw3jZeWqBagUlJv9w78FOa5z+1pHS0dsHWXEP2xv099kNb1wDsEBV4vkyp0VJusP+ID1P1xDld36041g81DnkfnMqNoyW6zmEj4kNdhqnM+qywkMu8/ggVrHMZM19SBUDBo74aEax28fssAwIb5C43A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787498282; c=relaxed/simple;
	bh=6lN12AIgQiPJz2Kow1rLb4w6YVrECt7pOuPq56ji09c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRqS1ZDa6wEJM9grCSSjaRW1G9+AZrraaj0Ao8XRHQlmAbMqALZ0nVukFSR6YAkdHblBqtRKxlW2vD0k5ncJJbdE9kRVDe81TZ/RQI66scY/0nV7oplcRTDmydKU248wnphBIs+LwR9VJ/Cyv9kXYNlHOpQvCptfi4O4UFPLzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz5uzO+f; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz5uzO+f"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so2720088a91.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787498280; x=1788103080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8+kkSUH6z+rcpiejvViicwcB0HlF0dRs5GEUbWGBoZ0=;
        b=iz5uzO+f/JjrZnOHtid3n7AtIomaL56xyEjyFGS2oGmdk2VYNYsr3VSCC12Nr8g2bQ
         5JbPM6xaUZEvZ7xHmwO8sB/vNHulqs/MgMnHY73TMY/I+1IR/eBSqEC98Xw1AzeBLBSF
         wYS2nzBAEiWxn16KET/i0+sE7Oz/Nr8s9BE6PH6C8Ev2NmjG0F87wqaOmtUc2N3zrwW6
         pXj2w0zYwz/wQzcEcexCQfaZrOkhYHW+NOZMebFhq1i1vM8JxwJbGZr+0upmLy2d6dFH
         BkMhV8i4rjK02jxIJlYi6gWCVPWumjoiFbKkICbhr+s77u8lI/KH/40n6kHMVNZclEtT
         sYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787498280; x=1788103080;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+kkSUH6z+rcpiejvViicwcB0HlF0dRs5GEUbWGBoZ0=;
        b=ohObnp8jQiBNkgdXbCFQp1qeiEZn/yp2wQUj5JqK26eIKurl5Cle6R6HWgF2eaVea2
         uWIi8G4fkdcdIVJdkWCMlkPM0wNIF6vZhTzEvz7dGbqK6d0KWuH53IJs+N9cWDcHZ1T3
         NeyePC9JBdiHW7H8AlCd8siDZKTsiuWoEcmnuRk4ZaYmasdsrkDgsBX7YR97g/Gm/VDg
         nJNRb9Rq61T5NPCSgHaqj+bmQWY9fuR2ITpHHXkLHgg8shPnBLgrPwynsyvpZm3yjMh/
         Atwmi5Cs6nS8x4kK8gFKPeise6QUawxvxSB6V1uIPIftIZlhuJVL7BM8pnIOOxWKGvbv
         +QPA==
X-Forwarded-Encrypted: i=1; AHgh+RpUhPxZaYR03B5Oc8k6ElHvY2f0dKyxJjpZSWigsCEhvyR0STogmf4o+F+bAjh2JS59w3SxLIs=@vger.kernel.org
X-Gm-Message-State: AFuF++mzmwLqO2hIeBM+Mvz70oPslIIpeNAiVL4O64fbPk0XvqD4UVrR
	DwP0ejrJBcz+5NPGVSDyg+qOB9TvAYou1j6eA55QqkZSDW9PfY3TXhxQ6nmpy7WU
X-Gm-Gg: AR+sD11R96GibZdP7sUMDNQJdTRv1oNPpqUpLf5EDiSX6FdOVkMedNSndtVydvNL3EQ
	LK4IFtMSEiMpVo9ito8zxNFF9zvJ1B/3QKRX8/TnnKwLGzjBYySg38QyxO+RLpyOjcMnNbZvhyM
	/F7WyPcsqHDhg9oPfmwBAtoVlqKEa1+ixo4U3/pnILtVmFi+dtSZ1UNy6RGqiFub1mSFdcI2fgk
	30wnj9KIaioTCvHkwSJGEbtGD+Oxq+btTeouES0+kaECJVtqc6aY8Uklz3yGxs5sjVQWxhhAg4n
	o5D2uEcUZajnKEYJ8qULSM2L1s78XSH3a9qxRWZ32FCZAKLkEDeDO1XKirOp4D5MRvlkggxbVK/
	gD+pY2Xa5ljXKzLjZrq8VAbDbAa+d5kNhRPMXJ1bmrPTcvtXItJuF1fwX+04tsWHYEIIeUBZnTq
	eVwX5r9ads8KgETN0tqGZTl7RcpfD2tcHWgRB6PccjoQ97xA01ihM2ZVBvMtDCBV+GPFIycuRB1
	6QdWLBYPwNRTiSXuUcvjBNtQc56uXM=
X-Received: by 2002:a17:90b:3883:b0:380:540:d499 with SMTP id 98e67ed59e1d1-395def03e79mr20461038a91.6.1787498279919;
        Sun, 23 Aug 2026 08:17:59 -0700 (PDT)
Received: from localhost ([2409:40c4:10ff:376f:bea1:1f87:a96a:c2c3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860ec7f7sm17786260c88.6.2026.08.23.08.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 08:17:59 -0700 (PDT)
Date: Sun, 23 Aug 2026 20:47:55 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, 
	linux-usb@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Forest <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>, 
	Michal Pecio <michal.pecio@gmail.com>, Mathieu Fluhr <mathieu.fluhr@gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
Message-ID: <aosGtkE_diwVJJtB@eggarch>
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>

On Sun, Aug 23, 2026 at 12:36:55PM +0200, Thorsten Leemhuis wrote:
> that ticket apparently didn't help. And no other fix is in sight, or am
> I missing something?
> 
> Mathias reverting the culprit in mainline a option to resolve this (I
> assume it is not, but I'm asking just to be sure)?
I don't think a revert is needed here, we're just trading one regression
for another.
Commit 8f5b7e2bec1c introduced the 200ms hold for all superspeed hubs,
but it's only useful for external ones. Root hubs are superspeed hubs
too so they go through the same code, but there's nothing useful for
the hold to do there:
A root hub has no upstream suspended hub whose wake propagation we need
to wait for and xhci already handles late USB3 link training itself.

Also hubs have a 0 second autosuspend delay (596d789a211d), so this hold
is the only thing stretching the awake window.

and anything opening or closing /dev/bus/usb nodes auto resumes and auto
suspends the whole host controller, adb's periodic enumeration does that
so on the reported affected systems every SS roothub cycle grows from
~30 to ~235ms (from the dynamic debug traces in
https://lore.kernel.org/all/qc0nhk9c6l0a08bkfeplrm3qjssgrjkvkp@sonic.net/)
which makes suspend move from close() call into delayed work and results
in the ~1Hz stress loop described upthread.

I think skipping the hold for hubs without a parent device, i.e. keep TB
dock behaviour everywhere it matters, should fix this.

Patch below could any of the reporters test it?

Thanks,
DrEggCake

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index d92bf887739d..f642ea0c31dc 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1346,7 +1346,8 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		device_unlock(&hdev->dev);
 	}
 
-	if (type == HUB_RESUME && hub_is_superspeed(hub->hdev)) {
+	if (type == HUB_RESUME && hub->hdev->parent &&
+	    hub_is_superspeed(hub->hdev)) {
 		/* give usb3 downstream links training time after hub resume */
 		usb_autopm_get_interface_no_resume(
 			to_usb_interface(hub->intfdev));
