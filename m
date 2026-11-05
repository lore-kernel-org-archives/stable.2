Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904275;
	b=SgVGVmIp/+LQtIh5DyVRhrSlAbohGyrQjTogAoNZYTXS1JZeYgdAZ1EpCqFWbujVLvz9
	 +0+pZXDgBJbtmr3LVvKIvW1ldiINAV5ZaqC+oBujScWCTMjjo2NsiMMz8QAoALqH1mTdF
	 FLsTlpt3Rxw9P7N71oAFzFcRqXBl2Fq4LEz7B4oYDR0qpUuKjEY0CTgeQfe4cMtbDuJGW
	 /2QTUO3sV6hfRUM3guVozDgbdDbLbohl8tEprFlHSsJezqUw4ridCfikX+b0t6eTxPaeB
	 zCBud9X7UL9eDTTiJGvONSziEjv8Z0irufWihVkt1anf+ABzD1q4POrkZaT9wryygOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R3MeO5bU9u9vZq0BWi1LFpN7YGyhm0gURVRh2ZqhZrE=;
	b=q0/9nh/3AqTALmFx3KkBAjtoiWBoGURXma4mX2bt7joKjS+VOdQEegm8bbYkz9PxoPEe
	 U88ffD0laVdZlHhDPkdyaC1HczDWao3mw8MZ0MRNPi1UXtwwrbJrrheWuytmZMQ21maAN
	 5xE+FsVV9i5R2SO5x44TSBnfBLMsi1/X3b27rRwm+tLvML/904twYwFYh+tLwk7R5jWZ8
	 IVJ7GWAlqOFajKrH0v3HNNVwcDeLZ98rIhqc+bgtsfmIU/HoNJlXTNBkZ1YIGFtHekkrc
	 Xx+AQ0uslbo6zrRu5hHsfi8wQOCTS/ldmibNKZBkUrakD7uAmYBBRG42nzWlXPAvkzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e0yO+Yt1;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB6606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAB6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e0yO+Yt1
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c3fd91337baso87903666b.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 10:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904273; x=1794509073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R3MeO5bU9u9vZq0BWi1LFpN7YGyhm0gURVRh2ZqhZrE=;
        b=e0yO+Yt1X9dK5zUWtqluc01kM8rGMGf1AjxO5Vx4oz11JObBFSGNEtaZoL0SyWsUqS
         QbUys7570/8D8S2wooUCG2fa83MBkuMwT4+81BD2e8XBtMDQHw7jmJNoNWVqhN4H5WrJ
         o4RjOc3YgikXkNbNIA375TNF0wptj9v6u13xV750RZBb5gXKbevXpRbMMrZbCI2M43/h
         fyVEKdY06hsmqXxDbi/h8x/t4KnPya55oFcQvnNY/ZrG3Vi50pBhuvLXE9oX8M8vGADU
         rv7jJP/d98piUPYaBt7FIAAcKsouzDpcJ7CjFebfr1McSyjYGPjKA4X7mNjtTFVa4oCm
         ehHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904273; x=1794509073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R3MeO5bU9u9vZq0BWi1LFpN7YGyhm0gURVRh2ZqhZrE=;
        b=JnBLJKfCq6TbQt3EleJ9e0EEDSguCAu45WCIYiNKpEWCKBEcCvPXqB590vJe3drViE
         HMjom4WDnUR86gipPBUwlf3416r9pfRA4vJ/yzXYgR1SP7vuxCYdONjDk1GcUjesMs18
         ps70RsPdX05UUjwpCwOlzeVAIzBjE/Nw9k0h0HbJ4B/b2xoD7lFt3wckDbJq6EQnd5LA
         fSSQQdkFAsoUkky0D8D8U5f34FYZCA/mQqoF1DNrmJsCyD7XKzDJUUBxk0Gtx8rapBmQ
         SwRgIqA0bX2THeHn+skLQwwBj5qKlYLd3OsW+ea4IVGoFWDHSH9duK0duN2aEYzHbV8N
         9P4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzaZhsuubZROW71dw3XYMb414GG5KKkqnZgk/YGZL7KQL6YyQunJcx6aaw0/ly3dtTkJqCIKuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zQDlSoIOurDNL8fuNI57oTWA22RLiHPk2un6WSFIGh+LS7Vxy
	TgL3wWhzuf+ShCL/VQSFJPEnSmXKQvR5djMOn9eTE0dkrq4MmBUmlXol
X-Gm-Gg: AYBFou0MVDoDMcKWh+DYVU5IF49NbRqhVkPa5We4j+9HwfjIZoK7w5VagxbQmut+E2i
	wMFxUEv5dm8lblX+GMvR08O6mmPD+CVOQPNu3TlMAXQx+IUS5hAddBrF655L8XRjk+Rvy9YN8uK
	1+PqQIcDQ5BBO/dK6dw1fVbFQubs5OtMbMzfSUdZ9qpzRoCWnhP4tYSuzembDNG+8D4KQ7DKlYp
	Y/XLQZyNQo3neThvrhZ6IpYg2EAqj/LiDyzqTe0qg3gpk+Nn4V/zLndkR5wqf9YkNkqaXpgeFBN
	owQ/nlQv2sjPuss6Nulp7qEQmMzOWEWyRR9yKZa3QlmJSTZgdI8fDb7pi1X6jQssl4AmnT+qhup
	GGht6rZLUR/qmi5cotaoTbXhqF7GUTtgLJwJ/J03Xix+N0pRT1GbJzjwwrZ2VvXz8lw1slmbfY7
	LjnnIaRkh51leX5e8F1IqL4NLpVit1et9YdYP2+gtubF2E8DSEv5ZqZyo9azY/lrLBHAjQbHbyR
	gOxYSZtgsSVLi6AEcQfq26OKY64m57rCbhThjqElunBz4lJPUv56Bo9jbb26qTnhk29
X-Received: by 2002:a17:907:d0f:b0:c48:a838:c188 with SMTP id a640c23a62f3a-c4d34c59db0mr39140466b.13.1793904272964;
        Thu, 05 Nov 2026 10:44:32 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d354ac249sm8993666b.5.2026.11.05.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:44:32 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 5 Nov 2026 19:44:30 +0100
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Liam R. Howlett (Google)" <liam@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Michal Hocko <mhocko@suse.com>,
	Baoquan He <bhe@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
Message-ID: <auzOjphJ8DWpXwUy@milan>
References: <urkgmijyytg3rrislm5fdzmfggqavzpiry23f6lpkqonvy2tqx@d56stj3eixfa>
 <auaFhOa5EBz4gJwK@gondor.apana.org.au>
 <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au>
 <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
 <aurAxRpCwzeyXeVj@gondor.apana.org.au>
 <CAHk-=wgPvbYRcKpQ8WTH-EYZRgMG0KSH+cZxY5-Hyf+X7JjWsw@mail.gmail.com>
 <aurJZ81qnbiHH_P1@gondor.apana.org.au>
 <ausS3LQNkdc6lBy3@milan>
 <auxDm_YO4oACA_d2@gondor.apana.org.au>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auxDm_YO4oACA_d2@gondor.apana.org.au>

On Thu, Nov 05, 2026 at 04:51:39PM +0800, Herbert Xu wrote:
> On Wed, Nov 04, 2026 at 12:11:24PM +0100, Uladzislau Rezki wrote:
> >
> > There are users in kernel. For example:
> 
> Thanks for the list.
> 
> > drivers/GPU
> >     /* Allocate the file in vmalloc memory, it's likely to be big */
> >     iter.start = __vmalloc(file_size, GFP_NOWAIT);
> > 
> > AMD-GPU:
> >     kvzalloc(size, GFP_NOWAIT);
> >     kvzalloc_objs(struct amdgpu_coredump_ring, GFP_NOWAIT);
> >     kvzalloc(ring->ring_size, GFP_NOWAIT);
> 
> These appear to be executing out of process context without spin
> locks so they're not really GFP_ATOMIC.
> 
> > Virtio ring-testing:
> >     (alloc_ring(0)), gfpflags_allow_blocking(0) does not allow blocking.
> 
> I didn't really look into this as it's just test code.
> 
> > net/ipv4/udp.c:
> >     err = bpf_iter_udp_realloc_batch(iter, batch_sks, GFP_NOWAIT);
> 
> This looks buggy in exactly the same way as rhashtable.  It's
> called under spin_lock_bh, and the same lock can be taken on
> the softirq path on another CPU.
> 
> So are there any safe users of kvmalloc with GFP_ATOMIC? If not
> I suggest that we change kvmalloc to disallow vmalloc when called
> with GFP_ATOMIC.
> 
kvmalloc() disallow and vmalloc() allow?

The deadlock looks like from below spin_lock():

<snip>
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e4570bbed854..97aac4a4a92b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1025,7 +1025,13 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			}
 		}
 	} else {
-		spin_lock(&br->hash_lock);
+		if (in_serving_softirq()) {
+			if (!spin_trylock(&br->hash_lock))
+				return;
+		} else {
+			spin_lock(&br->hash_lock);
+		}
+
 		fdb = fdb_create(br, source, addr, vid, flags);
 		if (fdb) {
 			trace_br_fdb_update(br, source, addr, vid, flags);
<snip>

is that applicable for bridge update code?

--
Uladzislau Rezki
