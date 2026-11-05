Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887084;
	b=JCvD600mnmSy4T4lZhp6P7/0N8zt5qw1aAvyj950tCH+hFBqtAIPewGcXPe8VbwE+zRA
	 MZyz0Ikl03PI8sXfIp34/VSMyrsY2XUhxCE3oWFdOvyHabvtXOBeaSTY0ZLen48tQDK9w
	 bExicvhYFOPRnX/zVFipKjDSEFC67vqOw4nPj23TucRyGvGRC94tNNEHH+LUT3c4+g2vR
	 5sYf05JnMXr4EWqD9HHWvPm01ip3Ra+MH1sbVUjkJbPi/V9frVrlRhRdXvP8i6S9VXVb/
	 7O/V4vEvJUyn65Pd94y+bSgWt3bC89195KFF01LDRG6iovWNIJ4UhuF77j+WW7FMZSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887084;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=pPBo8tnNZskBWdcYk57vjkMabC2vizbpChaQ43BRYoc=;
	b=YkM2hb1ZiaIpif+J4ftLNNnLBp9huBqOQE+Ds9NfMXq1BCw55eV3lZ9RoVkNo2XEQNGH
	 LUk7iohabzkE7UZWMdfAnDSOaj36jYMUA6zLibpDmFHqdqBeRV2zUWcVdMfd1V/H8KWqV
	 ROmnFdffj1NFNyhB+a5Oz4g8iJV7ngfiYVnmIKTRGOdaKuN3RorHZJWBjw0kFtEuBzEzY
	 du3R6Mh+K30GYOG7Mc8L4+ydnsySa6PNpg0ATeKLQvNUJRgAWHNaPlSeQilcXZrIxWHyL
	 ULY4/cfvukLESHpN1QAc+fWwOun064ecUn3QExsd8Ifwduek4PpgT427OIlGO37L5Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F1606A31B;
	Thu,  5 Nov 2026 13:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F7F1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jL3mM0nMZz8XrrJ;
	Thu, 05 Nov 2026 21:57:55 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A5DvokP060217;
	Thu, 5 Nov 2026 21:57:50 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 21:57:53 +0800 (CST)
X-Zmail-TransId: 2afb6aec8b619db-d412d
X-Mailer: Zmail v1.0
Message-ID: <20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn>
Date: Thu, 5 Nov 2026 21:57:53 +0800 (CST)
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
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZXQ6IGZpeCBzdGFsZSBsb2cgcGFnZSBkYXRhIGFuZCBhIFpOUyBJZGVudGlmeSBlcnJvcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A5DvokP060217
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Nov 2026 21:57:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC8B63.000/4jL3mM0nMZz8XrrJ

This series fixes two issues in the nvmet Identify and Get Log Page
paths.  Both patches are independent and can be applied on their own or
as a subset.

Patch 1 zeroes the unused part of the fixed-size Get Log Page replies.
The transfer length is supplied by the host, and the transports send the
whole buffer back, so a request larger than the log page used to return
stale kernel memory.  It covers the Supported Log Pages, Commands
Supported and Effects, Supported Features, Endurance Group, Reservation
and Rotational Media Information pages, and clamps the Error log ring
walk to the requested length while keeping the most recent error first,
as the specification requires.

Patch 2 returns the namespace lookup error for an Identify command with
CNS 05h and CSI 02h on a namespace that does not exist, instead of
overwriting it with the status of the identify buffer copy.

Both patches were runtime-tested on 7.3.0-next-20261030 (QEMU/TCG
guest).  Patch 1 was tested with an nvmet-tcp target and a file-backed
namespace, using a 4096-byte Get Log Page; patch 2 with the loop
transport and CONFIG_BLK_DEV_ZONED.  The Rotational Media Information
and Reservation log changes of patch 1 are not runtime-tested: the test
guest has no rotational namespace and no persistent-reservation setup.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
