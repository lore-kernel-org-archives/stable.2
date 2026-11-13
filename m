Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560509;
	b=B4jmh4SVyx/4CCCcKn5HKT+HSMDzdYFzKqnWXnYTrn/pStJfNcP8Ps2wb2j7I23MS6HK
	 BxkXUYeFgwHi85TJvl09ewaNr0AHQ5LBLhmPB4BPlsvaFPp9Iq6VRqSQkP0IoXUrO18uw
	 2sGqEbLzXTNquNLpADgL2AWbchjUExScESOBliKZLt8Y2Os7eo8tlS0y95ucLW1XBK7qu
	 +c58v6CfChNRdSxD8EBkE+/DmQg29Yyy9FrMGbf4CzhuvuRmaqHUP8BNs7tDCNbHNnpDD
	 qTYEWtL5RRwiBECUxhoR6UfVWsROOBCqzc803pRK5T5zOUjpgvyarjaJQ1qbdmpDCdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560509;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=M6B8f0IfLCQpM2CN85V5qfdLHaKaGk88JdSAU1srRdw=;
	b=VXBwQzAvxiQmToBqrVNTRT8RASeJyJO+Rl2MEBNjYWuj5oXX9YxM/eZjcfaXOJbeuHo/
	 ALaXQthA2TexAQ42Wsb9z/eISIBnrGT/UPOhXNg1rVoO4WNVUwtDHRD+BqCjEPmRVZCr8
	 UwwCfAj/cim8skDiJE7A58m3qlHCUlLWYezaesv/94fSYIknsl72prLnwRFcxPKOBoh3Y
	 pS9qg0FRd2G7MpQRRSAo+0jtL6tNjKAE5GQ2oM8jlahz13ZYv6lCESlO9BSZnhGviBAe8
	 pfpanwX+Prs1dAMs8Ao/v63Mbk9rpWdCxHUFAIWBlvonG0Z37FzH0Wiyc4PG+wGNPbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WE6EFMsU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472C606A886;
	Fri, 13 Nov 2026 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WE6EFMsU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02021F000CA;
	Fri, 13 Nov 2026 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794560508;
	bh=M6B8f0IfLCQpM2CN85V5qfdLHaKaGk88JdSAU1srRdw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=WE6EFMsUyMnowKzvAHr9vnxGBEHn+Rg21j+T3LKafH709q8yTd6nWRLdHn5c1acHU
	 2apMniFhLz9r6ZCdNuo/dzf2tVUccyZS6EPNHaDE3CT34e0vQ0wcJBh9AAp/ztm+Nv
	 AXx9u9JwwxSMYFHqqZoDhcK4tqI4e26yt/MtB7T2hsm7XKkjkJNZiY5vkJ/E2FJHX/
	 n4vXqG8/+i0WXFEXZMQryk92nmg69ls7oVQshtpFJYBDno4s0gTQOG0G8OJ/CRgJIC
	 FHGVN1nAk60MMsQ3kRyPtEzBlcOHAr434jgPiGsaSjjZfg24raeQN+4glU9dqg89m6
	 8QCMBv567sRRw==
Message-ID: <5042d545-24ae-4567-a39c-a28bcb1d1ed1@kernel.org>
Date: Fri, 13 Nov 2026 10:01:44 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v3 00/10] media: synopsys: hdmirx: support an HDMI bridge
 in front of the receiver
To: Sascha Hauer <s.hauer@pengutronix.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>,
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: Gerald Loacker <gerald.loacker@wolfvision.net>,
 Lucas Sinn <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
Content-Language: en-US, nl
In-Reply-To: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sascha,

On 05/10/2026 15:28, Sascha Hauer wrote:
> The Synopsys HDMI receiver driver assumes the HDMI connector belongs to
> it: the connector's +5V line arrives on hpd-gpios, and there is nothing
> between the source and the receiver. On the board this series comes from
> that is not the case. An HDMI bridge owns the connector, the receiver
> sits behind it, and the two are described by an OF graph endpoint.
> 
> Three things follow from that, and the series is arranged in that order.
> 
> Patch 1 comes before them and is a fix for the driver as it is. The
> driver data is devm allocated, but an open file descriptor keeps the
> video device alive past unbind, so the last close works on freed memory.
> The media device the series adds would have been torn down the same way,
> which is why the fix leads the series. It stands on its own and is
> marked for stable.
> 
> Patches 2-3 give the driver a media device and register the video device
> as an entity with a sink pad. On their own they add a graph with one node
> in it; they exist so that there is somewhere for the bridge to appear.
> 
> Patches 4-5 add the endpoint to the binding and bind the remote subdev
> through a v4l2 async notifier, linking its source pad to the receiver's
> sink pad. Such a board cannot provide hpd-gpios, so the binding requires
> either hpd-gpios or the port. Without an endpoint in the device tree the
> driver keeps working exactly as before, so boards wired straight to the
> connector are unaffected.
> 
> Patch 6 is fallout from the wait for signal lock, which was bounded by an
> iteration count whose duration came from the 5V debounce it called
> each time round. That debounce goes away on a board with no hpd-gpios
> later in the series, so the wait gets a real timeout first.
> 
> Patches 7-10 are the 5V state itself. Patch 7 stops probe requiring an
> interrupt for hpd-gpios. Patch 8 makes v4l2_device_unregister_subdev()
> wait for notifications already in flight. Nothing kept a subdev from
> notifying a v4l2_device that was unbinding it; that is not new with this
> series, as asynchronously bound subdevs sending V4L2_EVENT_SOURCE_CHANGE
> race the same way today. Patch 9 adds V4L2_DEVICE_NOTIFY_RX_POWER_PRESENT,
> and patch 10 has the receiver set v4l2_dev.notify and take the state from
> whatever is bound in front of it. The notification is only an edge, as
> the 5V interrupt is with hpd-gpios: the hotplug worker then asks the
> subdev through g_input_status(), so nothing is cached that could go
> stale against bind or unbind. Without a det_irq there is nothing to
> disable across suspend and remove either, so patch 10 disables the
> hotplug work items themselves instead of cancelling them. Patch 8 is
> what lets the notify callback read sd->v4l2_dev while the subdev is
> being unbound.
> 
> V4L2_CID_DV_RX_POWER_PRESENT is otherwise the only place this state is
> published - adv7604, adv7842, tc358743 and tda1997x all set that control
> from their cable detect interrupt and stop there - while a format change
> already gets an in-kernel notification through v4l2_subdev_notify_event().
> An earlier version of this series hooked the control with
> v4l2_ctrl_notify() instead. That reaches into another device's control
> handler, and the only thing it bought was working with those four
> drivers unmodified, which turns out to be worth nothing: they are HDMI
> sinks, so none of them could sit in front of an HDMI receiver anyway.
> 
> Nothing in tree sends the new notification yet. The driver for the device
> on this board does, and the alternative was a mechanism that no in-tree
> driver could have used either.
> 
> There is no in-tree device tree using the new port yet: the board is not
> upstream, and the device in front of the receiver, a Lontium LT86102UXE
> 1:2 HDMI splitter, has no driver upstream either. I would rather send the
> infrastructure for review now than sit on it until the board lands.
> 
> Tested on that board, and build tested for arm64 at each patch with W=1.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

As mentioned in my reply to patch 1/10 I'll take that one. But for the remaining
9 patches I need to see the 'v4l2-compliance -m /dev/mediaX -s' output to make
sure the media device topology is sane and streaming works as expected.

Use the v4l2-compliance version from the v4l-utils git repo so you have the latest
code.

I also need more time to review the v4l2 core notify patches. Apologies for not
doing that sooner, I hadn't noticed before that this series made core changes as well.

I haven't looked at that notify code for years, so I will need to refresh my
memory.

My plan is to merge patch 1/10 today in our next branch. It is probably best
if you post a v4 rebased to that and including the v4l2-compliance output in
the cover letter.

Regards,

	Hans

> ---
> Changes in v3:
> - new patch 1: free the driver data from the v4l2_device release callback
>   instead of devres, an open file descriptor keeps the video device alive
>   past unbind. The media device cleanup Sashiko flagged on the old patch
>   1 was the same problem, which predates the series (Sashiko on patch 1)
> - v4l2-device: wait for the SRCU grace period on every subdev
>   unregistration, not only when the v4l2_device has a notify callback,
>   as the reader dereferences v4l2_dev either way (Sashiko on patch 7)
> - Link to v2: https://lore.kernel.org/r/20260924-hdmirx-media-v2-0-c12f641d8b0f@pengutronix.de
> 
> Changes in v2:
> - dt-bindings: squash "add the source port" and "make hpd-gpios optional"
>   into one patch and require exactly one of hpd-gpios and port (Conor)
> - dt-bindings: drop the OS-specific sentence from the port description
>   (Conor)
> - hdmirx: take graph_mutex around media_create_pad_link() in the async
>   bound callback, the media device is already registered (Sashiko)
> - new patch 7: v4l2-device: wait for notifications when unregistering a
>   subdev, so a notification cannot outlive the unbind of the receiver
>   (Sashiko on patch 9)
> - hdmirx: ask the subdev in front for the 5V state on every notification
>   instead of caching what the notification carries, and disable the
>   hotplug work items across probe, suspend and remove instead of gating
>   the workers on a flag and cancelling once more after the notifier is
>   unregistered
> - Link to v1: https://lore.kernel.org/r/20260923-hdmirx-media-v1-0-ea3d77d4a5f3@pengutronix.de
> 
> ---
> Gerald Loacker (6):
>       media: synopsys: hdmirx: add media device infrastructure
>       media: synopsys: hdmirx: add media entity for video capture device
>       media: synopsys: hdmirx: add async subdevice support
>       media: synopsys: hdmirx: give the signal lock wait a real timeout
>       media: synopsys: hdmirx: skip the 5V detect interrupt without a GPIO
>       media: synopsys: hdmirx: get the 5V state from the upstream subdev
> 
> Sascha Hauer (4):
>       media: synopsys: hdmirx: free the driver data when the last user is gone
>       dt-bindings: media: snps,dw-hdmi-rx: add a port for a bridge in front
>       media: v4l2-device: wait for notifications when unregistering a subdev
>       media: v4l2-subdev: notify the bridge when the source power changes
> 
>  .../devicetree/bindings/media/snps,dw-hdmi-rx.yaml |  21 +-
>  Documentation/driver-api/media/v4l2-subdev.rst     |   8 +-
>  drivers/media/platform/synopsys/hdmirx/Kconfig     |   1 +
>  .../media/platform/synopsys/hdmirx/snps_hdmirx.c   | 355 +++++++++++++++++----
>  drivers/media/v4l2-core/v4l2-device.c              |  42 +++
>  include/media/v4l2-device.h                        |  15 +-
>  include/media/v4l2-subdev.h                        |  12 +
>  7 files changed, 386 insertions(+), 68 deletions(-)
> ---
> base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> change-id: 20260904-hdmirx-media-fe7eb952b2be
> 
> Best regards,

