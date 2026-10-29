Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255703;
	b=QcUOKUlvudUmHAeFBX5EgAx2IijouPfd0mr0xrWEK/YpUwTxpUCmYQH4f8Z6lXMC63Xw
	 e7MDwVE/UlYOQ0WbQ/CJUU+a/IX83dR+ttHtDYs8aKw40P5gKHQjCE2oAbmN5CBY55Y5l
	 /ELqRfTVl8rZzj5INSpDANqNGAyTft2WIC29SGX10c6FqoHYDxbfna+ZJT5RTz1oaUgV1
	 IAyeQ8XImpWsnVwiF39ouPkmblXi/Sxokkv0mkXDyJqb8zv31BIq8RWDl4Wk6w266KXzH
	 laeBQadan7Fgw9eWChn6JeWfyw0TLnJApSTd1vUHd/EkPZXW4Xqe0gAD3f0y1xpqRIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255703;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x5INpC/TW9P8TybwCRkB3lmN+6UMVRc6sZVh2qTFmfw=;
	b=Qh5w4UUXdWj7+QFFTNSw8Bbsa5HYEx9zqd1rf4W5cZIBqjYNsCFpKXxUKCmZp7HDEFbL
	 h4Yf1AqZ6w/x2zwWJSpd20yobFE538zVDd6CKgd3846FVygApCAByK4kSGApRuPmc0C+6
	 SB8setN7/mXDnq0Rqwp2nZ9HRdHMxHusRjrW/DyvQc4E1jidW0G+TAUqbf96OPH6EctWo
	 drBRINCaICJvA+8bU3ntVSPPngwb0S2K1z60oXo8l4j0BNXhEEry9l5s+3C0cviGBqoc9
	 VsS9PFOagc7wU27ltWCsGaa/oKQYIV3TPrWPrx6YadnGtRctUv+16196Lva55C+oRJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KGxVOloO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF9606A31C;
	Thu, 29 Oct 2026 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KGxVOloO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AD21F01825;
	Thu, 29 Oct 2026 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793255702;
	bh=x5INpC/TW9P8TybwCRkB3lmN+6UMVRc6sZVh2qTFmfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KGxVOloO7JeP6Nf+hZubrikFHsg77bBepl/ODWvzb7WWnFALT/o+YU5xCXawfZzP+
	 hVG5o8WzkjvP3D0fV/7rJeoXHUmpr9eu8JP8hmm4m755B3AZ9dgD8FdrcrtJVRfVnk
	 RMGU/OmoaT5AnL4POn4xd/Uy455Fg70FPpRYpJFQ=
Date: Wed, 28 Oct 2026 23:35:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Shuah Khan <shuah@kernel.org>, Lu Shuaibing <shuaibinglu@126.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christopher Lameter (Ampere)" <cl@gentwo.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, Jan Koester
 <jan.koester@tuxist.de>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ipc/msg: prevent msg_qbytes limit bypass in IPC_SET
Message-Id: <20261028233502.e7ab1c2ba951d2015d8a1fa9@linux-foundation.org>
In-Reply-To: <20261027-ipc-msg-qbytes-v2-1-48d8f72f1359@gentwo.org>
References: <20261027-ipc-msg-qbytes-v2-1-48d8f72f1359@gentwo.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 23:42:51 -0700 "Shubhang Kaushik (Ampere)" <sh@gentwo.org> wrote:

> The msg_qbytes field in the msqid64_ds userspace ABI is an unsigned
> long. Commit 889b331724c82 ("ipc/msg.c: consolidate all xxxctl_down()
> functions") passed that value to msgctl_down() as an int.
> 
> An unprivileged owner can set msg_qbytes to UINT_MAX. The narrowing
> conversion produces -1 on supported Linux targets, so the check against
> the int-valued msg_ctlmnb sysctl does not reject the request:
> 
> 	if (msg_qbytes > ns->msg_ctlmnb &&
> 	    !capable(CAP_SYS_RESOURCE))
> 
> The value is then assigned to the unsigned long q_qbytes field, setting
> it to ULONG_MAX. This bypasses the CAP_SYS_RESOURCE requirement for
> increasing a queue above MSGMNB.
> 
> It also bypasses the effective per-queue message-count limit: zero-length
> messages consume kernel memory but not queue bytes. An unprivileged queue
> owner can therefore cause memory pressure or exhaustion beyond the
> configured per-queue allowance, subject to other resource limits.
> 
> Keep msg_qbytes as unsigned long through validation and assignment.
> Also preserve its type in ipcctl_obtain_check(), which supplies it to
> the unsigned-long audit field.
> 
> Add a regression test which drops CAP_SYS_RESOURCE and verifies that
> IPC_SET with UINT_MAX fails with EPERM. Skip the test when capabilities
> or System V message queues are unavailable.

Thanks.  Sashiko AI review asked a thing:

https://sashiko.dev/#/patchset/20261027-ipc-msg-qbytes-v2-1-48d8f72f1359@gentwo.org
