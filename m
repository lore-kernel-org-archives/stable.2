Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733305;
	b=3bI02/pP/MjYzKpaJ9TXLQuxikJ6nIFoko79uQCjwLZMCbsNBH1moMI9plbz6sc0g3+n
	 ydfaxS2IYPp67uaAHjofAjsHQYNL0vZoVGfAcRX+JizkU1LedVNone7fzmB7JQJ8LIEAH
	 f2prVTOt+UETBIMyKPGMdbSK9JGEKVaouAXSfphbJ9S7qNDBnLojS3ByeTbmwERBbLDgW
	 hxO85YXcaIHSQzCtvAeyZB/2Dbqz2JnpZOAHQVV6MheHP5bJRU+Duq9VU7TVepcTxWp+x
	 a5w+SgduAz4sTJXdEmlSf/i6XxSOjoC7cUNB4bEU1lCNS6BUKsSqLAvgpC/6/GohXmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733305;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=6PDKL1rAzaImATTAORc/yJkECZgOXtmpf6KdI2W0Yzg=;
	b=ePz7rHpEgTzzmK6TvTjQ1SsJcGz3EXiKztP2kgAQhXxOU0k6J0bZJlhls2utKWcVWUVn
	 8VnLC+VEh8R397ateYWpGAnMJ2p1k6WJMvnEzmRBobGodUERwFdLX8P2fjgvYaDCwOSt6
	 tydu5MaGfb5hd33pvw6N3vLAsBvEgOKzRsde02CbtNKDzI9VXGTXyaQAULcg6LUOWLdu5
	 X5/P+xWMU5WcF4kPwJaAl/6UWnB50FKFTl0qgWmgF3Q1Jncadp84CMBkhC7zjrhwbgEmG
	 QOHJOmXbFBq/cAvEzctTFrU5RdF9+HfeY4ZX29Hb5P+5yh2dA+pLf1eMbjQ5OMDGCpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="MEDHLg/e";
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC2D606A31A;
	Sun, 15 Nov 2026 09:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCC2D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MEDHLg/e
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jS4jw6Pxjz8XrrJ;
	Sun, 15 Nov 2026 17:01:40 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794733300;
	bh=6PDKL1rAzaImATTAORc/yJkECZgOXtmpf6KdI2W0Yzg=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=MEDHLg/eaADWM7nJ42GBGAoxynM/3cxQk0ZakECcU0wXrpI6JAHlV9lDLpWzoJRed
	 FxxYCWeOcmm7nz/kgosSJJzYWc3XZqp6+1lZcXQ0WvpGMPitIbulPjZaAFKDlvu9E5
	 nHLCJ0Vz4UR6waGlsydsHt5njTjgnMhcA/8ZMzpfZtO2KIZj6kn9E4xSRtHcJdHxz1
	 TtEXwee62wzxDeDAb1rgE6rAqlThcd9ndmR8l2xPZTA2Ln88lv/xgVCDr+x1RT0DQ/
	 CFIl3d4yibQ97bmVXiwYR4/IWOg0hZa0HRAnj5NfvTpk7Mw1JUZKvPaEKfJ0TkwD4A
	 XBmAdZUg6VyyA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AF91anr094626;
	Sun, 15 Nov 2026 17:01:36 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 17:01:38 +0800 (CST)
X-Zmail-TransId: 2afa6af974f2466-6c1fc
X-Mailer: Zmail v1.0
Message-ID: <20261115170138759eOTny6ELzQaEpo1MVAd6r@zte.com.cn>
In-Reply-To: <avkYMF-_bBaIfBly@fedora-laptop>
References: 202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn,20261111225801025TKHDW7iZbMR4sFQAc8af5@zte.com.cn,avkYMF-_bBaIfBly@fedora-laptop
Date: Sun, 15 Nov 2026 17:01:38 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <tom.leiming@gmail.com>
Cc: <shuah@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <axboe@kernel.dk>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAzLzRdIHVibGs6IGNhbmNlbCBjb21taXRzIGFycml2aW5nIGFmdGVyIHRoZSBxdWllc2NlIHNjYW4=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AF91anr094626
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 15 Nov 2026 17:01:40 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF974F4.000/4jS4jw6Pxjz8XrrJ

> Please add this as a new recovery selftest in v2, so the fix is
> covered.

Thanks for the reproducer. I've prepared a driver revision and a new
recovery selftest using fault_inject's existing delay, with no kernel
hooks. The selftest has three cases; the first is your reproducer. It
waits for an in-flight direct write, quiesces the device, and requires
both the write and QUIESCED before cleanup can issue another control
command. The base stays LIVE; the revised driver passes.

> With zero copy or auto buffer registration the committed request
> may still be in flight when the command is aborted here.

I've made the distinction explicit rather than bypassing the guard at
one call site. After COMMIT's buffer operations, the new command is
marked COMMIT_READY before the old request's references are dropped.
Both non-batch dispatch paths clear that bit before queuing task work.
With cancellation set while dispatch is quiesced, the scan can cancel a
waiting command even if its previous request remains started, while
preserving the guard for a new request already queued to the command.

This also matters if cancellation starts just after COMMIT: an early
check alone misses that case. The third case uses a registered buffer:
it submits COMMIT first and verifies that the write is still
outstanding. The scan must abort all four commands, and releasing the
buffer must then let the committed write complete successfully. My
earlier draft passed the first two cases but failed this one; the
current revision passes all three.

> If ublk_wait_for_idle_io() fails with -EBUSY or -EINTR, ->canceling
> is left set and ublk_cancel_dev() isn't called.

I've documented that the idle-wait error leaves canceling set and skips
the scan. The next late command receives ABORT even though QUIESCE_DEV
returned an error; this change does not roll cancellation back. That
error-path behavior was checked in source, not established by the runtime
tests below.

> The new check fires whenever ->canceling is set, not only for
> QUIESCE_DEV, so the subject and commit log are narrower than the
> change.

Agreed. The new subject is "ublk: cancel late commands while the queue is
canceling", and the log includes STOP_DEV and server exit.

The helper is renamed ublk_complete_canceled_cmd().

> io->cmd and UBLK_IO_FLAG_ACTIVE are stored here before ->canceling
> is read, with no barrier in between ...

I've added explicit paired smp_mb() barriers between command publication
and the cancellation check, and before the scan's ACTIVE load, with a
comment explaining the pairing. Queue quiescing serializes queue_rq, but
the uring command handler can publish independently, so I would rather
make that publication ordering explicit than rely on quiescing alone.

> If ublk_get_data() fails and falls back to requeue ...

The second case holds NEED_GET_DATA across a successful quiesce, then
submits an unmappable address. This reaches the real mapping
failure/requeue path. The base completes only three of four commands
with ABORT; the revised driver completes all four, and the device
reaches QUIESCED after the server's ring/file references are released.
The common post-processing cancellation check covers this fallthrough
path.

All three cases (fault_inject delay, NEED_GET_DATA/requeue, registered
buffer) were run against the same next-20261113 x86_64 base and fixed
guests, using QEMU/KVM with four vCPUs and 2 GiB RAM. The existing
stop_restart and stop_live_restart modes also passed on both kernels,
with eight successful reads per mode. Kernel W=1 and selftest -Werror
builds completed; the driver has the same pre-existing shmem stack-frame
warning on both builds. I have not tested concurrent off-task
registrations, automatic buffer registration, or a weakly ordered
architecture.

Thanks,
Shao
