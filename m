Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991712;
	b=tL5FxHK5zet9/29jh+SQ4s70o1yyrn81oq95+VI4l/QvZNXX1qKMoOExIRuq01Zu0Jy7
	 4UYiohFzAm4mp2224cvdED7uD1XB4ttj95hQtKjuDHaJJJ4/ypxlxdu2KZPJZ82afuaL4
	 xk6SBUs2tn/M/gvq6+NR+8WrhiJO6ZqVjIGuAEsQwiSrJA7oQoAiiA76TDYthFn5kWpY8
	 jzHDvjrK/L2ED4RGiUEbENjNn3Xr6OUzE98nLlXy8C4oZBj7xz/v280s1uXeNJ1yNEuTl
	 BfRHhqOWtC9nN4zC/i1iWc+9QtR2kd+mHrtH3swkTSVW4UdnpFi6d726MP6FtVpMZ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991712;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=jFwNhMQtFRDsrVaFQZzJ44aGiK+g4FPeGXnzbFSKe5w=;
	b=dcddLHNZdSvQxWQT9HRM6vVVtVJqkJkSP+RTpcciFtviqtjLxeqgewFQs2MhvIPoO75G
	 Y/gCntEfYgXSLtQ9QX+JUfCesFlGh7LIHVylQn2/Z5IDy/7toeygDLXjfaqGiEP3HZiEs
	 sw6YrLsu0esaAi1h/icErE8g2R9gghIEaufzqOFOQ4G22CxukrYGPCs/S3bIln2YvS+Vl
	 Zm3kQ5bVwk80Qgf5rRjTkozeLBeliDXzo6FCoGTQtcU2TGqoHUdU6cqPa0V7+5mvkwGJD
	 f6NriNwQxA5oCq+hQR9KDLaSxXb4EXoqOmDO71oTMJLugZFjTUISCzycm48/0nrs0Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZRKbwYj7;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43079606A325;
	Wed, 18 Nov 2026 08:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43079606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZRKbwYj7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jF
	wNhMQtFRDsrVaFQZzJ44aGiK+g4FPeGXnzbFSKe5w=; b=ZRKbwYj7lHIJ3c6nYd
	WLH4OWUEq8D3TdY6alrubz3MwfM6BsnB20zlLqx9alrJgJoj+FdUvFAikZT0XjkB
	c5K7NoMTv2PFFFSY6XS+hLd17B8Eh7/gQTbpXmORATrKvzUhw5qHX8lqaRRiHGtO
	fortEcyI/6jWJ484cQVnfMJs8=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3Py5UZv1qDYYDGQ--.2045S2;
	Wed, 18 Nov 2026 16:48:20 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] parport: do not re-enable interrupts in parport_claim()
Date: Wed, 18 Nov 2026 16:48:18 +0800
Message-ID: <20261118084818.2348842-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026111853-raffle-entwine-0b64@gregkh>
References: <20261118075816.2323688-1-zihengw03@163.com> <2026111853-raffle-entwine-0b64@gregkh>
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
X-CM-TRANSID:PSgvCgD3Py5UZv1qDYYDGQ--.2045S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWxtrW7Cr15Xw1DArWfuFg_yoW8Xw47pF
	WYgas09rWDXFW7uwnrXanFkw4Ykw4Fk3y3CF9Yqw47Awn8Ar9Fvr4Igr4j9an09r47Xa1v
	vFW5J393CF4DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhyCJUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7RTIGWr9ZlQfHgAA3M

On Wed, Nov 18, 2026 at 09:11:37AM +0100, Greg Kroah-Hartman wrote:
> Are you saying that this lock is never held in irq context?

No, it can be taken in hardirq.  One path is lp_console_write() ->
parport_release() -> parport_claim() for a waiting device, as the
console write callback may run in interrupt context.

The invariant that matters is that every user disables local
interrupts before taking waitlist_lock: parport_unregister_device()
uses spin_lock_irq(), and both wait list paths in parport_claim() run
under write_lock_irqsave(&port->cad_lock).  Plain spin_lock() is
therefore safe there, even for a hardirq caller.

The old spin_unlock_irq() is the problem: it turns interrupts back on
while cad_lock is still write-held, and for a hardirq caller it does
so inside the interrupt handler.  The "blocked" path in the same
function already uses plain spin_lock().

In your other mail you wrote:

> So, this isn't a real issue given that no one has actually noticed it
> in 20+ years?
...
> parport devices should not be used by 2 users at once.  If you do so,
> you get to keep the broken pieces :)

Sorry, "two users" was unclear: I meant two parport drivers taking
turns through the wait list, not simultaneous use, which is what the
wait list is there for.  The race is rare and was found by code
review, not from a user report.  I still think the change is worth
having, as it is small and fixes the interrupt state, but I will leave
that decision to you.  I am happy to drop it, or to resend with a
clearer subject and without the stable tag.

Thanks,
Ziheng

