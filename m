Received: from www1.rhinostone.net (www1.rhinostone.net [95.142.169.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C230C177;
	Thu, 15 Oct 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.142.169.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071055; cv=none; b=VeRE4mwbAWbQDnli/UAdNQ77AO+YuRvAbW6tI08TpIxKctNhHWYQtHOUrTzY42cer8T34ElOe/paon+ZtpU2XCoLO5hoeiDV1KOtfzj41yVUsppIZKuyHZsXsxn8Jeg2TkqpDwXOeYAHwJm7C63QLvYPUs61Qii24g8XdbZKfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071055; c=relaxed/simple;
	bh=VwpyHI9FINANPgMLd6EKXXWPl6Nehgrjk8sldgoKxkc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TkTI3txr9NKzYVCItndk9PviwLKsDM06m2XTF9wY0SwyRqOGUHSUKl1M6Khg4B2xKtk54JCCfRITHenPW6Pa8QTTRGXPDsfgPDzQNd0jWkvn8WSLMA80buftkR34V7xeaz/vyMgtISIBx2n5wOH077OdRRac5AfEa4iBL9AeQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rhinostone.com; spf=pass smtp.mailfrom=rhinostone.com; dkim=pass (1024-bit key) header.d=rhinostone.com header.i=@rhinostone.com header.b=xL81Ufvy; arc=none smtp.client-ip=95.142.169.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rhinostone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rhinostone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rhinostone.com header.i=@rhinostone.com header.b="xL81Ufvy"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by www1.rhinostone.net (Postfix) with ESMTP id 8842843F3C;
	Thu, 15 Oct 2026 15:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rhinostone.com;
	 h=content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id; s=1476224331601; t=1792070574; x=1793884975;
	 bh=VwpyHI9FINANPgMLd6EKXXWPl6Nehgrjk8sldgoKxkc=; b=xL81UfvyTUc4
	Srx5TBF+v8UbYKYYR3720ZO4rgnBja8lsn9JueJT9RZJ6IjLJBSWEAmfxw5OE/6W
	vEWMgR0gnE77IN1q4qJHUl83Ils3p+7cZx2qNYviqNgZOj6HE2wANh6pOMGM3ncb
	5rDmf8mcqGMeqaYfdg+Atxj+Ve8ZDmY=
X-Virus-Scanned: Debian amavis at www1.rhinostone.net
Received: from www1.rhinostone.net ([127.0.0.1])
 by localhost (www1.rhinostone.net [127.0.0.1]) (amavis, port 10026) with LMTP
 id LdAlKxSdL4wc; Thu, 15 Oct 2026 15:22:54 +0200 (CEST)
Received: from [IPV6:2605:59c0:1e76:6110:c969:a728:bdd4:1496] (unknown [IPv6:2605:59c0:1e76:6110:c969:a728:bdd4:1496])
	(Authenticated sender: m.etouman@rhinostone.com)
	by www1.rhinostone.net (Postfix) with ESMTPA id 48A5643F34;
	Thu, 15 Oct 2026 15:22:53 +0200 (CEST)
Message-ID: <d8f91886-6b07-4dfb-8d9f-a1424fe8c572@rhinostone.com>
Date: Thu, 15 Oct 2026 14:22:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
To: stable@vger.kernel.org
Cc: Mattia Meleleo <mattia.meleleo@coralogix.com>,
 John Fastabend <john.fastabend@gmail.com>,
 "Jakub Sitnicki," <jakub@cloudflare.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
From: Martin Luther ETOUMAN <m.etouman@rhinostone.com>
Subject: Request: 04af4efde58a ("bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program") for 6.12.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Please consider commit 04af4efde58a ("bpf, sockmap: Account for receive
queue in FIONREAD without a verdict program"), merged for v7.2, for the
6.12.y stable tree.

It fixes 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap"), which
reached 6.12.y in 6.12.75 (as c2681ce178a2). Since then, ioctl(FIONREAD)
on a TCP socket that sits in a sockhash with no stream or skb verdict
program returns 0 while data waits in sk_receive_queue. 04af4efde58a
carries a Fixes: tag for 929e30f93125 but no Cc: stable, and it is in
neither 6.12.113 nor the current queue-6.12.

How we hit it: a Kubernetes cluster running Calico v3.30 with sidecar
acceleration enabled (FelixConfiguration sidecarAccelerationEnabled:
true). Calico's sock_ops program puts every established TCP socket of a
local pod in a sockhash; only an sk_msg program is attached, no verdict
program. On Debian's 6.12.111, nginx 1.29.8 proxying a plain-HTTP
upstream stops partway through responses of a few hundred KB: its
FIONREAD reads on the upstream socket return 0 while the receive queue
still holds data, and no new epoll event comes.

Measured with one nginx pod on one node (6.12.111), 8 fetches of a
250577-byte file per path:
   - upstream socket in Calico's sockhash: 0 of 8 complete; nginx-debug
     logs 23 FIONREAD results on it, all 0;
   - upstream over 127.0.0.1 (not in the sockhash): 8 of 8 complete.
The same test on 6.12.69 completes 8 of 8 on both paths, and on 6.12.111
with sidecar acceleration turned off (no sockhash) it completes 8 of 8
on both paths.

On applying it: against v6.12.113 the net/ipv4/tcp_bpf.c hunks apply
(offset 1 line), but the include/linux/skmsg.h hunk does not apply as is
(it fails at line 551), so the backport needs an adjustment. We have not
built or tested a backported patch.

The patch series:
https://lore.kernel.org/bpf/20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com

Thanks,
Martin Luther ETOUMAN NDAMBWE
Hello,

Please consider commit 04af4efde58a ("bpf, sockmap: Account for receive
queue in FIONREAD without a verdict program"), merged for v7.2, for the
6.12.y stable tree.

It fixes 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap"), which
reached 6.12.y in 6.12.75 (as c2681ce178a2). Since then, ioctl(FIONREAD)
on a TCP socket that sits in a sockhash with no stream or skb verdict
program returns 0 while data waits in sk_receive_queue. 04af4efde58a
carries a Fixes: tag for 929e30f93125 but no Cc: stable, and it is in
neither 6.12.113 nor the current queue-6.12.

How we hit it: a Kubernetes cluster running Calico v3.30 with sidecar
acceleration enabled (FelixConfiguration sidecarAccelerationEnabled:
true). Calico's sock_ops program puts every established TCP socket of a
local pod in a sockhash; only an sk_msg program is attached, no verdict
program. On Debian's 6.12.111, nginx 1.29.8 proxying a plain-HTTP
upstream stops partway through responses of a few hundred KB: its
FIONREAD reads on the upstream socket return 0 while the receive queue
still holds data, and no new epoll event comes.

Measured with one nginx pod on one node (6.12.111), 8 fetches of a
250577-byte file per path:
   - upstream socket in Calico's sockhash: 0 of 8 complete; nginx-debug
     logs 23 FIONREAD results on it, all 0;
   - upstream over 127.0.0.1 (not in the sockhash): 8 of 8 complete.
The same test on 6.12.69 completes 8 of 8 on both paths, and on 6.12.111
with sidecar acceleration turned off (no sockhash) it completes 8 of 8
on both paths.

On applying it: against v6.12.113 the net/ipv4/tcp_bpf.c hunks apply
(offset 1 line), but the include/linux/skmsg.h hunk does not apply as is
(it fails at line 551), so the backport needs an adjustment. We have not
built or tested a backported patch.

The patch series:
https://lore.kernel.org/bpf/20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com

Thanks,
Martin Luther ETOUMAN NDAMBWE

