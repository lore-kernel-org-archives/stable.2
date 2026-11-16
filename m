Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794802715;
	b=gg3PZytAlwaH0rYevx2lAZhST85Fe8hsiZ3Jv8NoIgzefJenvqLdTinVh1y5QGa8NCTN
	 9VuT8/8z7da3JLz50FoE8oR/HbEX/P0iHJ229dRjdbdIGQsTSH9IvKo+KO3oMo+BlfgZH
	 za8ID+OilHEM5cqIWNdBJJKrwEr8NsS5yr0lXG9LLMXTW8DtXcQ6a9FmgmEAxOJDqGD08
	 fUIbIjL4f6lPt01yvHLw35ZJ8ZhvOrXrHJySN77t7YMLW0uh8ewyg3ceJEsZBMsXVOWMP
	 sZb0Tsn+AcaGawhpLW8jp8i/FVgmsSNxIAxL4DmhqlRPP6DC78yTFSy/Ke0yKotQydA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794802715;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hYB9QxJ6y3l190KgAF2MxxG55ObWJ38ho5V5o8yjcbs=;
	b=FRIDyKtrskqI/3I/tvkAP2HvxIF+ZLXE1C8BktA5mdkqPuy26uiLnkqefWpeCzPzziKQ
	 PvFkmwI9vLIPUSQuvjRzMpybPhfHemtDwmNFDODGmNs3S+7tUeSN3xVWlsvoGczHYzKEN
	 rn6a22u85EUtGs636Oaec6HgK8wv5Ho9meAiup5G+fdKAylTHcot4HRqEuIeHWicS7FWT
	 /KvXDnw3bQAbB08drB5mJ/wVwEzXfkt3mYCj6ukWQLk8RqLv6YpMyxudssudXCeNJcdRo
	 EJAxJoDHrn79NOBelNy/Wz3kRB0B35SX1NDTGCbTnwGX0PPKWHxnNdhdq6XZGIBJP/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6Pk7AEX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E8606A339;
	Mon, 16 Nov 2026 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6Pk7AEX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967421F000C7;
	Mon, 16 Nov 2026 04:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794802715;
	bh=hYB9QxJ6y3l190KgAF2MxxG55ObWJ38ho5V5o8yjcbs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g6Pk7AEXjED/QcO0G++bBT6AgkKLtGQukfKho6mZ9cvqv1J2bM4C4+bq/EjG0CqQB
	 OJ8FNH5L8lJaAiVAaEBbbV52cqH0qNU++NKKjY8ut+XsVKD3uxfwptbtEQvXXG3hpe
	 E0u1bBJjtdD1jw9gxVI4hsuXwLYF2jVLe4qrkfqTVf/zq3u3e53ZFifEj3ST8HA6Vh
	 gQ5hNhB59yVpAm/l3geTDFAKk0ve4MZNLECXtGYiFD+Qiwvsi5e7HL2sSGp6wDM0ji
	 +E59WNz9Zh59RwsVNpwFueN1xWorAoB3263X9c1z+N4uB955g4mEBEp3RQz1vA/73d
	 0TlVJA8Z4yKmA==
Subject:
 Re: [PATCH can-next v7 6/6] can: gs_usb: properly shut down timestamp worker
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuangpeng.kernel@gmail.com, stable@vger.kernel.org,
 vadim.fedorenko@linux.dev, kuba@kernel.org
Date: Mon, 16 Nov 2026 04:18:34 +0000
Message-ID: <179480271415.3132.12503701210475918543@kernel.org>
In-Reply-To: <20261114-gs_usb-fixes-v7-6-58b6341b1c08@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-6-58b6341b1c08@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message gives the wrong reason for the change.

--

can: gs_usb: properly shut down timestamp worker

This commit disables the timestamp delayed work at init time, enables it
in gs_usb_timestamp_start(), and switches gs_usb_timestamp_stop() from
cancel_delayed_work_sync() to disable_delayed_work_sync().

> To avoid self-rescheduling of the timestamp worker, shut it down using
> disable_delayed_work_sync() instead of cancel_delayed_work_sync().

[Severity: Low]

Is this reason accurate? cancel_delayed_work_sync() already seems to
handle a self-requeueing work.

cancel_delayed_work_sync() goes through __cancel_work_sync(), and that
function always disables the work before it flushes. It only re-enables
the work after the callback has finished:

kernel/workqueue.c:__cancel_work_sync() {
    ...
	ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
    ...
	if (wq_online)
		__flush_work(work, true);

	if (!(cflags & WORK_CANCEL_DISABLE))
		enable_work(work);
    ...
}

Suppose gs_usb_timestamp_work() requeues itself while the flush is
waiting:

drivers/net/can/usb/gs_usb.c:gs_usb_timestamp_work() {
    ...
	schedule_delayed_work(&parent->timestamp,
			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
}

The work is still disabled at that point, so the requeue is rejected.
The kernel-doc for cancel_work_sync() also says it "can be used even if
the work re-queues itself".

The only other place that queues parent->timestamp is
gs_usb_timestamp_start(). It runs from gs_can_open() under RTNL, and
only when parent->active_channels == 0. Leaving the work enabled
between stop and start therefore does not appear to be reachable as a
bug.

The enable/disable count added by this patch looks balanced across the
init, start, stop, and open error paths.

The parent commit, "can: gs_usb: fix hardware timestamp state for mixed
channels" (Cc: stable), says this follow-up is needed to avoid
self-rescheduling the timestamp worker. It also says it was split out
to simplify backporting. Together, the two messages could suggest that
stable kernels without this patch still have a live self-rescheduling
bug. Older kernels also blocked the self-requeue during cancel, through
WORK_OFFQ_CANCELING.

Could the commit message describe this as cleanup or hardening, making
the stopped state explicit, rather than as a fix for self-rescheduling?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261114-gs_usb-fixes-v7-0-58b6341b1c08%40pengutronix.de
