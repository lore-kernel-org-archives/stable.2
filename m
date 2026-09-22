Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908672D6E64;
	Tue, 22 Sep 2026 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062300; cv=none; b=PQC4sGeqhEyyF1I5+JHxfZTgCkk69OqaVJ2Socwc1YTw8HEvki/Q93tp8nGj92ElX0if+l7JecB6ZZDji/bf/arn3lsfKOkcbKVGJU+XkN13kJGonMvXYkSvGx52YPQzwE7obebu0H62KzAE65S5LRjMQBGgbokz+2chGuw8iEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062300; c=relaxed/simple;
	bh=+iUKsOj9QehkNvX27bTqyWxdnCTfC9cb72PQksr3A98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGuaN2GusMHTKYeG6TwUYIkG1OhnGZzhIMnpbsZK36rWr4kPImg8UFBCewZ/jhJaH0MZxbObd7Cm2MKqg9UCt87xg+7mTUT1xsiz2QLnIm9+jUNbLtjzbRjqYnMyn88KJjPCcRl5OHEPWJDyjTvEmhWq5NziFS+P80cTKVnUbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaPgumb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaPgumb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BFC1F00893;
	Tue, 22 Sep 2026 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790062299;
	bh=vCx8Z0Cvw101Bn+x/dq8ie+wLCtqmnP1DPb+BhNQuw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HaPgumb3S4J8bSjGXEQdBOJt9I//3Zw3NIU12CPeS1+28Fe3u7ePrY4oNPWmGGZ/c
	 4jnh/meee7bCFuFaB9l5ctrb7RRdPWIgNd+xeh20BmtjGG3kxKZSF3fCT2hY0OEg7i
	 RqiCqDCMHxNheEAsK08VLWBBaKreuFutUmqC2NQ7EN7veRALy37AR48EfVMvCceEBW
	 yGljoAnSNygxDcPWylldzcqHf4W3NAgVuQ9We67El67iTplQbmPqQOqz6AYilqqk0n
	 oWmaGAhvadk10meotxTak1NQiqvAlJtvNe6MCOGxuKB/syx85X3H4qUeX1hXdwtyTg
	 faE+SLAiVicFA==
Date: Tue, 22 Sep 2026 08:31:34 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <Jason.Gerecke@wacom.com>
Subject: Re: [PATCH 1/2] Write shared touch initial status only once
Message-ID: <20260922073134.GE2348773@google.com>
References: <20260916020301.24188-1-ping.cheng@wacom.com>
 <CAF8JNhKTVO7xro4qAoq4NG=4TWheb7rFU93AZEfeRJfJeqUfRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8JNhKTVO7xro4qAoq4NG=4TWheb7rFU93AZEfeRJfJeqUfRw@mail.gmail.com>

> Do you have any questions about my patches, especially this first one?
> I added it to make the assignment consistent with your patch. Since
> the is_soft_touch_switch can only be set by pad, we would only get to
> this assignment once. It won't be assigned more than once with the
> current firmware logic. If you don't see an issue with the patch, can
> you give it an acked-by?
> 
> The second patch adds the softkey touch switch back, which is
> important. I hope my fix can be merged upstream along with your
> patchset. Otherwise we break userland.

Honestly, you know this driver much better than I do.

The change looks sound to my uninformed eyes though.

Bear in mind that the subject line does not match the style expected of
the subsystem - or anywhere else for that matter.  =:-)

> On Tue, Sep 15, 2026 at 7:03 PM Ping Cheng <pinglinux@gmail.com> wrote:
> >
> > From: Ping Cheng <ping.cheng@wacom.com>
> >
> > To match the same logic as with other shared data during registeration,

Spell check.

> > use WRITE_ONCE for is_touch_on too.
> >
> > Cc: stable@vger.kernel.org

Fixes:

With those fixed:

Reviewed-by: Lee Jones <lee@kernel.org>

> > Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> > ---
> >  drivers/hid/wacom_sys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 8dc7aa1c0a26..33fa491fba92 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
> >                  * match historic default.
> >                  */
> >                 if (wacom_wac->is_soft_touch_switch)
> > -                       wacom_wac->shared->is_touch_on = true;
> > +                       WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
> >         }
> >
> >         if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
> > --
> > 2.55.0
> >

-- 
Lee Jones
