Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401827;
	b=2RukMI6NkFMzeNYhy0CU/p/L6UznNpLygtK8u1geWvILD8Fs0Tmb5q0raY9ykTuf2MZl
	 QW7ytLttCDh1aUgdvPlPPRNq+ysWEysrMf1kOLUkBHcxcpG6cC3sYSSMOIQRrUGImS0ST
	 Y3hth2TMOuXaSgc5JI4QYR0ey8zEd2wu301apq2PByHioubEuqKxL4MSmwNVZIhWv3oNq
	 QMG59ycuq8sJ02XKTMXsYIaarFtgJ/vsusr5y6QQVrQI+8FYAYcHn8+l4EqKNRoLCHSps
	 gzuITziULtZfgaoICyTg4hBlBgefYM20nefJNYCDQtL/WSNOhIiY4nfwU6nxxmjyDnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401827;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yd5fH2AProMUuE+LUBrS93lMr/XlRRxFbHWMpgM+ObM=;
	b=Ug1RJdoabIAk5ebc3d/sPFOA9NthA9hI/SMcPwSDHXnCvEek7jHv1Dx5F/apWIt2rkLc
	 tUg+RK5Ga5O5d5UvbfBKvmUDuWGuAk9Srf1jFal1HmtH2vK6BSjjf2X3oDi/XlWw23buw
	 fhA1xDJ4vVdtMNqaK55jMt4iZjK+nHr14NI8mUoB1ytaWRPiZNDnacZV8WvVgUScoB0bW
	 Z2eah2hLWfItkELFBJJcjW2Qof5mj9tRlwtIoN3LehGxnKYTyMZ0bxiqlhPkEUmD0tLqh
	 LNxvZWeAAsLy4s0skmQvGmYAAvyW+YwnwHh/bCu2T2kMDM0AgVOFXRJfRYPrkHxNQmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C30606A31E;
	Mon, 23 Nov 2026 02:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67C30606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: abe03dece6e711f19a56ed5b684f684d-20261123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:87b57ca8-9352-4006-9045-7befbe19131c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:8ab76f97b73cc3ed65a6849a00b17523,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|850|865|898,TC:nil,Content:0|15|50
	|99,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: abe03dece6e711f19a56ed5b684f684d-20261123
X-User: huangwei@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <huangwei@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1960239668; Mon, 23 Nov 2026 10:43:32 +0800
From: Huang Wei <huangwei@kylinos.cn>
To: Bertrand Jacquin <bertrand@jacquin.bzh>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	huangwei@kylinos.cn
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in power level debugfs
Date: Mon, 23 Nov 2026 10:43:26 +0800
Message-Id: <20261123024326.2693527-1-huangwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <awHB7a-zLM3GpC9C@lady-voodoo.lan>
References: <20261010120357.4937-1-bertrand@jacquin.bzh> <2026112040-splashy-power-2d46@gregkh> <awHB7a-zLM3GpC9C@lady-voodoo.lan>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Nov 21, 2026 at 04:08:13PM +0000, Bertrand Jacquin wrote:
> ucsi->connector never transitions back to NULL. only ucsi_init() writes to
> it through ucsi->work where it's assigned only once, after all ports are
> registered. Every failure path before that assignment leaves it NULL and
> never cleared afterwards.

I re-verified this in the current source and it checks out, including
the -EPROBE_DEFER retry path: each ucsi_init() run works on a local
allocation, and ucsi->connector is only assigned once all ports have
registered, so a retry cannot leave a stale pointer either.

> The only end of its lifetime is ucsi_unregister(), which calls
> ucsi_debugfs_unregister() before kfree(ucsi->connector).

Confirmed. ucsi_unregister() cancels the init work first, then calls
ucsi_debugfs_unregister() before kfree(ucsi->connector), and the
debugfs SRCU drain makes sure a show callback has either finished
before the array is freed, or fails with -EIO afterwards.

So the only transition a reader can race with is NULL -> valid, and
for that direction the check is enough. My Reviewed-by stands.
