Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685489;
	b=npvw9AttQGmxB5c8+/BnObJ6W5w5BHGHKKjIwzuU6Dm8bdZskwui8A6LtbGXkA5dd1al
	 cDtwRScAv9VKrT7Kbrp++nA72gZFuknU2kjOqejitqSm/ZLq6gtm4oqJA6hRUPYEgXh9d
	 TPjRHuCOymtGECF/rlahiQ2iwsCRNif9e+Rb3rDrIqJji7uIKbozLMEd22vgtfDD+uLGI
	 YycTIjXH4jnYPV199NGiNvhA/qa/x22pkvVGM0XoYyPUPGeUbsQ7CQU9uozhaZYDC1Gxx
	 Zm6uzA+pyzpQ48TNdDyU7Ulqsbj/FeXoQT0Y7rCSxsW3SBIkOwTsuCjXKavNOD1N9DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ITSPRyINPqhtMUKNtyCCuAmF1A5H7xEXnM5pndQVT0E=;
	b=gIg+TtAUB4811Vg7T5gv91opG/RQJd51m2/WhMyPGUgBzk7OibMVuWnQurOl9pSt7dYL
	 nYiOWIlt52STZ74fDLMS/LaecDkbyZ/vqACQeCLz2d68oy8//2IQhxo7NfggA+3y7KBBw
	 7i8M6Pmj/8QydBA6q3TufLyYg+HHSlU9n1HVyjhy6AqPTho2OHFmgluApUgNbTgkPDj90
	 ENkcnWUU8x00Vx//PIKTyB2Sbm15/y1yey/7iifSwi4CTK5emOHwAT03eYmqJavvw8wx3
	 C10WvS5xWSY3PgSr45T8W+X/1TFjw7hJ67rFIZWWCuA4O51nSQwMZmeQNF5k+z3XUUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=0++N3oqx;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16966606A31B;
	Thu, 22 Oct 2026 16:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16966606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=0++N3oqx
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j9WNw330jz1XM4Tn;
	Thu, 22 Oct 2026 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792685483; x=1795277484; bh=ITSPRyINPqhtMUKNtyCCuAmF
	1A5H7xEXnM5pndQVT0E=; b=0++N3oqxw8m30/ScwP1EXlPjZU+BiRbnIz9zMA/3
	XtySZ6o4+m2WNmWtLtd7VJ0f5B6UfglPc6Vk9elWpkN4QQHXMFJVMjMXPwsccTKG
	nj0DSacc8QD/qtM6zXtzroUtJS56YqRfqYaKrGud4HmgtGYRmpnmFyVyCEqTIZTx
	M2+/s1aSP/5+qJt8BwxY7kq8nVkCk0e7+16KAdyTM2QOQ7AkPA3Nc/2EuDWsA2hm
	3DPoaR09KGOQwEoXi1Vpmyx6dalM+2d6TLCH18PaHeNhybuslJs+1FVRXUgBt4Ic
	v/weLrEV8vJFBm64vlXqZEIqpEr6+kSUyV7Jsd6nhnBpsQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ffT1teyxUFT7; Thu, 22 Oct 2026 16:11:23 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j9WNp4kBmz1XM4Tl;
	Thu, 22 Oct 2026 16:11:22 +0000 (UTC)
Message-ID: <301966cd-198b-4b67-af34-7f8fec19817c@acm.org>
Date: Thu, 22 Oct 2026 09:11:21 -0700
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
Subject: Re: [PATCH v3 2/2] nbd: drop stale partitions on NBD_CLEAR_SOCK
To: daan@amutable.com, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, stable@vger.kernel.org
References: <20261022-b4-loop-nbd-stale-partitions-v3-0-7c58ecab69c8@amutable.com>
 <20261022-b4-loop-nbd-stale-partitions-v3-2-7c58ecab69c8@amutable.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261022-b4-loop-nbd-stale-partitions-v3-2-7c58ecab69c8@amutable.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 6:31 AM, Daan De Meyer via B4 Relay wrote:
> +	/*
> +	 * Drop the partitions of the disconnected device on the next open.
> +	 * They can exist even with max_part zero as they may have been added
> +	 * manually with BLKPG. Dropping them here is not possible as that
> +	 * needs open_mutex, which nbd_open() acquires under config_lock.
> +	 */

The lock order is reversed in this comment and also in the patch
description. The actual lock hierarchy is the reverse: bdev_open holds
disk->open_mutex when calling blkdev_get_whole -> nbd_open, so nbd_open
acquires config_lock under open_mutex (open_mutex -> nbd_index_mutex ->
config_lock), whereas nbd_clear_sock_ioctl is called with config_lock
held. The conclusion (cannot take open_mutex inside
nbd_clear_sock_ioctl) is still right.

Thanks,

Bart.
