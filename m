Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11D346A11;
	Fri, 14 Aug 2026 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714311; cv=none; b=K6hoOeEFra+LCz72BqejXQBs80zns8gL7GbJn8oVS2E/9x7q8GprYq/a/5E+M8eSx3EWUVsawmAUGToVEpiqNdp/TX9+Rl1tYGjD1Ez9MD1AVYjnb7YRwpLlv5AK/87VflSbqxJiEaO1mDh63q7gUZkLpzPtm2rhTeKHVPwvQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714311; c=relaxed/simple;
	bh=iGKAThE6v93p5mUZFHCKi0YKXYgVN/v0BDC7F/79ACE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJgJSWDMIlKp6h3Bd0ZvQqGGPAQCoUleIaRraZJEFlaGjceT/WSOUTpB++0LCAm3MZwb6UtaNTiE66kpSy7N26CKMblqTGJ4FE/eEhRuRkba+SHTzwp9KW/lA5oVJHPrv3bJvTP1aanctkeOleG5JZKjrVomrOGrrXAHQ3qU4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx3cUszk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx3cUszk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E691F000E9;
	Fri, 14 Aug 2026 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786714310;
	bh=9ZoVl74b1R3gmQ2FbYo+d4AyOhJLlJgJ+LwTVBWSbNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nx3cUszkVbQpgDk69qw2lFTF+PxyTHpqY/DT2BMCXvMLhrEF7uadHT4WfGB4doCc4
	 Qe9U21ClDLFeL8VwkkOOTsU17i4bBTWJv/i7hs7CNUTXY3xpBUrChrbbV4r6Ji/+DH
	 J8pP6NYj8Pjpm66KUsFmLYE2qo4SA0L5UQxAKCdBzwDDkj/3EfDnl2bNmWHCADiEKD
	 0rgGJwVfSabKMEHhvn3aLlh+qqYKXKsExkwVpC4RutH485SIE8ptOECJcI65IGEyrO
	 etMZ/E2rDZLzm0YhP6MFarhObGyy6iKMT7/9FersI9ecuJE0OeB6a+gJ9w0nvwy25f
	 Sgjimornjdfzw==
Date: Fri, 14 Aug 2026 15:31:45 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: Re: [PATCH] HID: multitouch: stop the release timer from being
 rearmed on remove
Message-ID: <an8YpGjIs9ze5GvW@beelink>
References: <20260724000958.938675-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724000958.938675-1-qwe.aldo@gmail.com>

On Jul 23 2026, Aldo Ariel Panzardo wrote:
> mt_remove() quiesces the sticky-finger timer before stopping the
> hardware:
> 
>     timer_delete_sync(&td->release_timer);
> 
>     sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
>     hid_hw_stop(hdev);
> 
> timer_delete_sync() waits for a running callback and dequeues the timer,
> but it does not stop the timer from being armed again. The transport is
> still delivering reports at that point, and the report path rearms it:
> 
>     if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
>         if (td->mt_io_flags & MT_IO_SLOTS_MASK)
>             mod_timer(&td->release_timer,
>                       jiffies + msecs_to_jiffies(100));
> 
> A report that arrives after timer_delete_sync() has returned therefore
> leaves the timer queued. td is allocated with devm_kzalloc() against
> hdev->dev, so it is freed when the driver is unbound, after mt_remove()
> returns. When the timer fires afterwards, mt_expired_timeout()
> dereferences the freed td:
> 
>     struct mt_device *td = timer_container_of(td, t, release_timer);
>     struct hid_device *hdev = td->hdev;
> 
>     if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
> 
> Simply moving the teardown after hid_hw_stop() does not fix this on its
> own, because mt_expired_timeout() calls mt_release_contacts(), which
> walks hdev->inputs; the timer still has to be quiesced before
> hid_hw_stop() tears the input devices down.
> 
> Use timer_shutdown_sync() instead, which additionally makes any later
> mod_timer() a no-op, so neither ordering constraint has to be traded off
> against the other. This is the final-teardown pattern the function was
> introduced for, and hid-wiimote already uses it for the same reason.
> 
> Fixes: 4f4001bc76fd ("HID: multitouch: fix rare Win 8 cases when the touch up event gets missing")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260723224211.613112-1-you@example.com?part=1
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> Found by code inspection after Sashiko AI review flagged the teardown
> ordering while reviewing an unrelated patch of mine. I have not
> reproduced the use-after-free at runtime: it needs a report to land in
> the window between timer_delete_sync() returning and the device being
> unbound, which I have no way to drive reliably on the hardware I have.
> The window and the rearm path are visible in the code, and the fix does
> not depend on the race being hit.
> 
>  drivers/hid/hid-multitouch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0495152091e3..f25065b9ec66 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2233,7 +2233,7 @@ static void mt_remove(struct hid_device *hdev)
>  {
>  	struct mt_device *td = hid_get_drvdata(hdev);
>  
> -	timer_delete_sync(&td->release_timer);
> +	timer_shutdown_sync(&td->release_timer);

Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

>  
>  	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
>  	hid_hw_stop(hdev);
> -- 
> 2.43.0
> 
> 
