Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683874;
	b=N+Zpq9GJiT8MqGNR0Xg97hbKg9cVayCx4bKkL9Fr4Sg9aO9n2XkZybfH4nkrN7kHDrZD
	 q2ig94X3+wTmnUnGZHkqs5855uHGC1Hk5F5fwwJQMAUs5hYqTuhnz/OP6hV1Tqt+ftH4E
	 gjlW9PEHNOj/67cS5mmToDcaXIMiPf8Wr5vgd9+FcSmtvQh0Odv38tfmklvbWQl69k257
	 SYmvwzzx2yXvMPQyooFSZtpjNrxFBS0OTetbnsqEcopBj9XZTdan8ATeH7fcgE429PuAw
	 CkQHxtiB7yx0O68yD2HNDEPovOUEZn280kBW7+CzNP4XftSCJaawlB9xFxqvdTLQbzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=en8oIneNJAmjOzu+xMV6SYXy5/gd3CUstwgbCCSBQCs=;
	b=fRrhFFaWJpJjYVacywIhBSw0xs02GPN0OMCR/Rzrfr4SaEav/E6kaPSfXckmeCMP98xO
	 6q0JXon0/4QYt4B1YWecBbzRlGgJ+LlwnAbZ+TjKrmm2mrGRdFRl6Eelig80TKasfsFqR
	 OG5Q3xs2KhFLdmEs+nXRgqdeZWkMyXtCezMOl5kU0MkI59Q2haQe1AHILT2h+ekEvStJt
	 ZDj7u5bQ/qqMmEBDEUAc1RISOtoKz8CFA4tJUXZ+sQqOXgkTuSF3TzrxfDpi0z/QAoN7n
	 sDnPeqgVjAiDC7CLIsQsbev3StuQO4nKIS+739EYUD67fnokwmWrx9viYl+ocDeJNYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=G5c171lD;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BC606A329;
	Sat, 14 Nov 2026 19:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C59BC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=G5c171lD
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jRkRH11bDzlfclg;
	Sat, 14 Nov 2026 19:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794683860; x=1797275861; bh=en8oIneNJAmjOzu+xMV6SYXy
	5/gd3CUstwgbCCSBQCs=; b=G5c171lD1cJQCBvC4Tauk8/KXImHWnIzwSgADQCS
	kSRECFe805Q9sWHLREEOTzx/RlsUVN/AIQNOsi2tAYwoMu4CwLOF+1PIEDtXhLvc
	91eCTpcmXBqrdHqQ5sQ1M4Cw6jRmXk/8EgRYjHmjPlM2rqivp/DJYxcr0LSvNknd
	D7Cv9oE6Yjfe15TzsODmpBGXruXwYcXv7TQziCnuXVBoGyvAgJaDHkU3/G3BmZTX
	cKd19497FsToUe9rQcsO2n+MWY+pji9pBa+BoeUZ9EHlnUn3bzs1ghXwSTs3nGPX
	ywFs9SNn+VwJMbIYRBtR70fmC3VZAYykN+9bNaqxWJXU8g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0QpjjgwETs-d; Sat, 14 Nov 2026 19:17:40 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jRkR81tj8zlkvQ5;
	Sat, 14 Nov 2026 19:17:40 +0000 (UTC)
Message-ID: <426d5936-54aa-4b4a-b70f-73f506c5a902@acm.org>
Date: Sat, 14 Nov 2026 11:17:38 -0800
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
Subject: Re: [PATCH] nbd: do not reinitialize a live socket lock when
 reclassifying
To: Aibing Chen <chenaibing@cmss.chinamobile.com>, josef@toxicpanda.com,
 axboe@kernel.dk
Cc: edumazet@kernel.org, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org,
 syzbot+b29ed72382b0e218323a@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261114150547.842-1-chenaibing@cmss.chinamobile.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261114150547.842-1-chenaibing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/26 07:05, Aibing Chen wrote:
 > +#define sock_lock_reclassify_and_name(sk, sname, skey, name, key)	\
 > +do {									\
 > +	sk_owner_set(sk, THIS_MODULE);					\
 > +	lockdep_set_class_and_name(&(sk)->sk_lock.slock,		\
 > +				   (skey), (sname));			\
 > +	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 > +} while (0)

Unlike the other callers of sock_lock_init_class_and_name(), which run
on freshly created in-kernel sockets before the socket is bound,
connected, or exposed to userspace, NBD operates on an already-connected
socket whose file descriptor is still held by userspace. Removing
spin_lock_init() is not sufficient to make reclassifying a live socket
safe:

1. Unsynchronized lockdep_init_map_type() on a live lock is racy.
    sock_allow_reclassification() is an unsynchronized check and
    nbd_reclassify_socket() holds no lock on sk and does not disable
    BH/IRQs. Both lockdep_set_class_and_name() and lockdep_init_map()
    call lockdep_init_map_type(), which clears lock->class_cache[],
    writes lock->name, and then writes lock->key without synchronization.

    If another CPU (via a syscall on the shared socket fd or a concurrent
    NBD_SET_SOCK on another /dev/nbdX device) or a softirq/timer
    (bh_lock_sock_nested()) concurrently acquires sk->sk_lock or
    sk->sk_lock.slock, look_up_lock_class() can observe a torn
    (lock->name, lock->key) pair and trigger:

      WARN_ONCE(class->name != lock->name &&
                lock->key != &__lockdep_no_validate__,
                "Looking for class \"%s\" with key %ps, but found a 
different class \"%s\" with the same key\n", ...)

    or permanently register the global af_family_* key with the NBD class
    name.

    Additionally, lock_sock_nested() calls
    mutex_acquire(&sk->sk_lock.dep_map, ...) before acquiring
    sk->sk_lock.slock or setting sk->sk_lock.owned = 1, and keeps
    dep_map acquired in lockdep while sleeping in __lock_sock().
    Reinitializing dep_map while another task holds it in lockdep also
    breaks match_held_lock() when hlock->references is non-zero.

2. sk_owner_set(sk, THIS_MODULE) leaks module references on repeated
    calls. When CONFIG_PROVE_LOCKING && CONFIG_MODULES is enabled,
    sk_owner_set() unconditionally calls __module_get(owner) and
    overwrites sk->sk_owner, while sk_prot_free() only calls
    sk_owner_put(sk) once when the socket is freed. Because userspace
    retains the socket fd, passing the same fd to NBD_SET_SOCK multiple
    times (e.g. in an NBD_SET_SOCK / NBD_CLEAR_SOCK loop as in the syzbot
    reproducer, or across multiple NBD devices) leaks a module reference
    on THIS_MODULE on every call after the first.

3. Because userspace retains the socket fd, reclassifying the socket to
    sk_lock-AF_INET-NBD does not prevent userspace from calling
    sendmsg()/sendto() on that fd and faulting in user pages
    (&mm->mmap_lock) while holding sk_lock-AF_INET-NBD. That recreates
    the exact sk_lock-AF_INET-NBD -> &mm->mmap_lock -> fs_reclaim ->
    sk_lock-AF_INET-NBD circular dependency that commit d532cddb6c60
    ("nbd: Reclassify sockets to avoid lockdep circular dependency")
    attempted to avoid, as already reported by syzbot:
  
https://lore.kernel.org/lkml/6aec646f.aca85a03.3b899.0000.GAE@google.com/

A possible solution is as follows:
* Revert both commit d532cddb6c60 ("nbd: Reclassify sockets to avoid
   lockdep circular dependency") and 9280e6edf656 ("nbd: don't warn when
   reclassifying a busy socket lock") because live sockets can be
   reclassified safely.
* Defer socket TX and shutdown from nbd_queue_rq() to a workqueue.
   Make nbd_queue_rq() enqueue the request onto a TX queue and schedule a
   work item on an unbound workqueue allocated without WQ_MEM_RECLAIM,
   similar to lo->workqueue in loop.c or nvme_tcp_wq in tcp.c.

Thanks,

Bart.
