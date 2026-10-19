Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF34E3EF6;
	Mon, 19 Oct 2026 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413498; cv=none; b=LE8qXL+EjynKTeWtQVv1RWMxs3fvTd3kFpkdgut1pL+Fazn7sERGuXLTPgcT7KbsgI2uwgjqAMRBJDdVuLD+W8I0988RgEdKOs42c1kVNS6jHdMPwxXJ0aVuX2yqlE3Im29RxZvGy5IcZJXHFXfFNoCmn4B/ddPp1FNjVENJtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413498; c=relaxed/simple;
	bh=TO/S6KVK1H7HpELPgxH3S44B16HHp3OoVjLk9zaUKJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXvL+iWg82w+pcAbFNLLhsdvAcWKGK1ukwuwZQ6c/B3YvzX+MALKZfpY8Bq6H54ZcMicuLGosAmSXUpjliBKfpv2g7WXOTQeeU9ppT4Oh8/NtUcqUvjZkT7LXNEAotWoP0vUy0dKHqZ7f0Pm+OKDbfm7uozsiMsigc65aE+EBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dHfz2xgH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dHfz2xgH"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35C1E593;
	Mon, 19 Oct 2026 14:35:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792413359;
	bh=TO/S6KVK1H7HpELPgxH3S44B16HHp3OoVjLk9zaUKJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHfz2xgHLpUYLWRmQd8nQSwek3OE3kZ+MXgAnj7KZMPlZTuEfKXdL53wGT/GTLRgd
	 ovdzwgrFgx2H3EPdTHQnIHVN+CMJMrH2lrjI5c275MYAEB9wtWmv8YeOGTPw0qlHZ6
	 NzLLjX0JMCYvFc/vZMLgyt5Qh2T9pFE+xmUxQctg=
Date: Mon, 19 Oct 2026 15:38:03 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0J7RgdGC0LDRiNC+0LI=?= <ostashow@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Add quirk to retry SET_INTERFACE for
 SVBONY SV105C
Message-ID: <20261019123803.GA855235@killaraus.ideasonboard.com>
References: <20261019-sv105c-retry-set-interface-v1-1-ab2f08bc3fcb@gmail.com>
 <20261019111712.GP595565@killaraus.ideasonboard.com>
 <449eb143-37a8-4044-a071-63fe495c0213@kernel.org>
 <20261019112726.GR595565@killaraus.ideasonboard.com>
 <CAAquLuDc==WsbOYTfuKV2tspTSQAvB7kg2r2aqbE2rs3tYx2LA@mail.gmail.com>
 <d2d5e53a-ba8b-4b66-8e15-0c45e08e0f3f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2d5e53a-ba8b-4b66-8e15-0c45e08e0f3f@kernel.org>

On Mon, Oct 19, 2026 at 02:33:11PM +0200, Hans de Goede wrote:
> On 19-Oct-26 1:58 PM, Константин Осташов wrote:
> > On Mon, Oct 19, 2026 at 02:27:26PM +0300, Laurent Pinchart wrote:
> >> On Mon, Oct 19, 2026 at 01:21:49PM +0200, Hans de Goede wrote:
> >>> On 19-Oct-26 1:17 PM, Laurent Pinchart wrote:
> >>>> What does Windows do differently then ?
> >>>
> >>> I guess Windows always has a short-delay of at least one USB frame-time
> >>> between the VS_COMMIT and SET_INTERFACE. I think we should simply add
> >>> a flseep(1000) before the set_interface instead of adding a quirk for
> >>> this.
> >>
> >> The commit message says it doesn't help, but I can't tell if that can be
> >> trusted.
> > 
> > Fair point. I have measured both sides again.
> > 
> > Windows 11, AMD xHCI, camera on a root port, 120 stream starts with
> > ffmpeg/DirectShow (MJPEG 1920x1080, and YUYV 1920x1080 for 5 of them),
> > captured with USBPcap and an ETW trace of USBXHCI/UCX/USBHUB3:
> > 
> > - The requests are the same as on Linux: PROBE GET_CUR, SET_CUR,
> >   GET_CUR, GET_MAX, GET_MIN, SET_CUR, GET_CUR, then a 26 byte COMMIT,
> >   then SET_INTERFACE alt 6. There is nothing else in between.
> > - The SET_INTERFACE URB is submitted 22 us after the COMMIT completes.
> >   The xHCI driver first runs a Configure Endpoint command (3 ms), then
> >   queues the control transfer. That puts about 3 ms between the two
> >   requests.
> 
> When you say "then queurs the control transfer", you mean the control
> transfer for the SET_INTERFACE, right ?
> 
> I wonder if the problem is that Linux is missing this Configure Endpoint
> command ?
> 
> > - The control transfer completes successfully after 263 ms, every time
> >   (402 ms for YUYV 1920x1080). In a 100 start run, the ETW trace shows
> >   exactly 10 control transfers on the camera's EP0 per start (8 for
> >   probe/commit and 2 for SET_INTERFACE alt 6/alt 0). There was no
> >   Reset Endpoint command, and every xHCI command completed with Success.
> >   Windows does not see an error and does not retry. 0 failures out of
> >   120.
> > 
> > Linux 6.18, Raspberry Pi 4 (VL805 xHCI, camera behind the VL805's
> > internal USB 2.0 hub). I added an fsleep() right before
> > usb_set_interface() in uvc_video_start_transfer() and checked the
> > resulting gap in usbmon. 20 starts per value, MJPEG 1920x1080, auto
> > exposure:
> > >   fsleep()   COMMIT -> SET_INTERFACE (usbmon)   first SET_INTERFACE -EPROTO
> >   none          0.35 -   0.90 ms                 1/20
> >   1 ms          1.53 -   1.84 ms                 2/20
> >   5 ms          5.42 -   7.26 ms                 6/20
> >   20 ms        20.4  -  26.4  ms                 3/20
> >   100 ms      100.7  - 108.1  ms                 5/20
> >   300 ms      319.5  - 325.2  ms                 1/20
> > 
> > So a delay does not help, even one longer than the time the device
> > takes to complete the request.
> > 
> > The timing differs between failure and success. A failing
> > SET_INTERFACE completes with -EPROTO about 1 ms after it is submitted.
> > A successful one, whether the first attempt or the retry, takes about
> > 260 ms, the same as on Windows. My guess is that the device starts
> > reconfiguring right after the SETUP stage and sometimes fails to
> > answer the status stage for a few microframes before it starts
> > NAKing. The VL805 then reports a transaction error. I have no bus
> > analyzer to confirm this.
> > 
> > I also need to correct the commit message: the failure rate is not a
> > stable 80%. Today it was between 0% and 50% per series of 10 to 20
> > starts, with auto exposure failing more often than manual exposure.
> > The retry always succeeded on the first attempt.
> > 
> > With 0 out of 120 on Windows against roughly 15% per start on the Pi,
> > the difference is real. I can't tell yet whether it comes from the OS
> > or from the host controller. I haven't tested the camera with Linux
> > on a non-VL805 controller. I can do that before a v2 if it would help.
> 
> Have you tried reproducing this on a different XHCI controller then
> the one found in the Raspberry Pi 4 ?

In particular the same one as the system running windows.

> I wonder if this problem
> is specific to the VL805 xHCI controller.
> 
> Likewise have you tried reproducing this under Windows with an USB2.0
> hub in between ?

-- 
Regards,

Laurent Pinchart
