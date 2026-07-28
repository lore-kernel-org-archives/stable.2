Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5F422541
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234880; cv=none; b=QY2aib6a6eU+1tPHgfFG8ADc4GTZy+GLr77QHkIgISueUAiC9XKiZiW1OQXAU/wdO4dAf08EOtV9zM06yzPS0PVaneWjO/p1wshguD09zguFavG4KtmgXdj7rfaUVeAGBtKmUXyO/IbNdL9U4dKvdCNxYTn3GV++dlnLk1LgnQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234880; c=relaxed/simple;
	bh=LT/S5/RTKji/bNPUDq6Rj/EjZf1QYtHX1ZfD0Xh1oas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0TYwnHLo5/pKvQ6CF4YXlibyigjQr4DowzXEFLyrmwgtHLjsKWeiPMx2TMx1JDszDDoz7T24BQrkkvjP/Iuk5QqGlvUxKsarEeRDGl2usiPYS2+au4w1hRetKx32vHmkzY/SfIEhVlkfoXfsuY+0RhDQALHABEAbJR3muGahcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHxTLZyJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDtX1kKr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHxTLZyJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDtX1kKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785234878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xdQhFpRWUzD9Fj2435WhQROQlSe5SUcwou//jy23Pg=;
	b=FHxTLZyJjZuhWXNx3VSHklIYdWVa+nevqY3SbqZvSDPHEX+ubzLVZ6RFnTX3OhqMslk2vT
	ZyKyBbTMKBS6ATNcQjwIHIhy7MOBhDUcS66GqtC6ijsSMLD2Bhem5D43XqRYUiFoNpIOOW
	gktWT7CtN4VVajJthQD9RdDvay9IKq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-X-DkCHaDNqiuPkHH4GZ8tQ-1; Tue, 28 Jul 2026 06:34:36 -0400
X-MC-Unique: X-DkCHaDNqiuPkHH4GZ8tQ-1
X-Mimecast-MFC-AGG-ID: X-DkCHaDNqiuPkHH4GZ8tQ_1785234875
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f835ac1aeso2652998f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785234875; x=1785839675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xdQhFpRWUzD9Fj2435WhQROQlSe5SUcwou//jy23Pg=;
        b=RDtX1kKrB36BZVfkt4ovjOC8ZVb9a0eF8NKn8qGmhUl9qrpLCgHI6yMqIM33mOwosp
         G+vJ+H3v+iQQm7wxL2XRileWi1WsvRxsws5n9n0seAYLRgiwmAqxygAWujeWcU/UGBiq
         LXkOMIc2VcTEfNgT3i+m0TVRFU8dO3k1J+wUA8DoKPFY5TVzkuIUVn8dh5Z8QyObueXy
         Y4KEcKMYkbAYVAJFlVP4Q4eQGmfCvYAAgpjXtQDZ5EhKTv8b3Am9wUK2kuO8WKHGuBn+
         uHxXcqLJZGVRnr/uOOSELQLa2n+V0Pf11xaLD7YbIj+41gaaTaPQ2XPWRRE+/acR7fT6
         /i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785234875; x=1785839675;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xdQhFpRWUzD9Fj2435WhQROQlSe5SUcwou//jy23Pg=;
        b=dgHlrfzGVqri0beGHw5VAmd3yWmoMcV/Vn23qYyzYec8RaEZOWEcnhCsfvAaHTWOeX
         921ucOaFVhczfx7RAMLupv8rafgcU2idvK2wo0A7gM19mjcf+/rUbVYzgTKwyerLYLes
         FeLjzA6kUtexGP4PJmKCzVJePuW03jvxIP/ndKTRevs2N3cqh5tSHitxS0PuXIiRfJ94
         wnNlwd3cMK4hiRrHTrHCakeW4Ns6obUTY9fY1bCEtA6sJDpShri7WSFH336OY/KqmUsr
         QcMqjf8REGpXayABskTuEEztRhtaFor2cnVnVcribr1qPBBClsKhLHB1BP4DlT4Jwa7n
         Lr2w==
X-Forwarded-Encrypted: i=1; AHgh+RriZFKPZPwABC9yGxQCe05ePZUjL8wO4BmG9Bwi6ztd8/CVxvnA4vIH1Nv4Yx7EoFOjFTqXZQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUiKIzRxIGkxEw06oZ3DhL2QhCv/FnAkXQ19wRDfRNNCevSgH
	VlA+JsL5Z6LH4cLp3xIyJjKl70Z8mpgxz49un5qTPSunGhMStWAWJq+r+uQgGuNeYvUtBYSY3w/
	nQJolHoo3D2bkdoulycSKi7guSUBReDWI0Lc64Rv/XBwEc+d5viQCaUysLA==
X-Gm-Gg: AR+sD13zC4mUUgZ7+j5vqGBBKlP5DVFCSVKIBzdjzeBhGyMwazsEUDYAB9U1JxWe9CV
	+1NUmVv/9vbwp6E6D0hSm/kgTXFJ/U+ynZFxwvKw7WnaqxNwIkcRh4MMNFzNaTeIgMOTaWHYY+n
	/Mt5xjIiMtM/NSaTQqcEpzsAkaYGY5tfpD4uM2IshIPGv2NromGLOwIovGdNJGXwZEZiM/DYefp
	MvkWz1y3SWIJ80+Whb9T7pKAZl3kbDtvrmB8s06giV2eP49If0Tg5p7gB9uhobB7ywInqGoM0Mk
	b4i/Qg7K/qA0jVKAS2E6P1+2lOXQItrhFlj0fUV2wC0e/Nf8yoxUUe6RhL2IJ0F3cJj/99I3C2o
	oeOA83yZB1BLbfKbyenMqa1zdbHlQXkCSkP70DgMQN6UWS2qjVgHFDfAgY0fszv+OXzdlKVgGs1
	A+rw==
X-Received: by 2002:a05:6000:4283:b0:47f:826c:7422 with SMTP id ffacd0b85a97d-47fb1e70bebmr1968716f8f.17.1785234875147;
        Tue, 28 Jul 2026 03:34:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4283:b0:47f:826c:7422 with SMTP id ffacd0b85a97d-47fb1e70bebmr1968677f8f.17.1785234874656;
        Tue, 28 Jul 2026 03:34:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm56558149f8f.9.2026.07.28.03.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 03:34:34 -0700 (PDT)
Message-ID: <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
Date: Tue, 28 Jul 2026 12:34:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, john.fastabend@gmail.com, jiri@resnulli.us,
 zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com,
 victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org,
 Santosh Kalluri <santosh.kalluri129@gmail.com>
References: <20260723105210.817079-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260723105210.817079-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 12:52 PM, Jamal Hadi Salim wrote:
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index bd6f945bd388..700f878fc3cd 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -297,16 +297,29 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
>  					next = rtnl_dereference(f->next);
>  					RCU_INIT_POINTER(b->ht[h2], next);
>  					tcf_unbind_filter(tp, &f->res);
> -					if (tcf_exts_get_net(&f->exts))
> -						route4_queue_work(f);
> -					else
> -						__route4_delete_filter(f);
> +					/* Always defer the free.  The direct
> +					 * __route4_delete_filter() path has no
> +					 * grace period and races with readers
> +					 * that cached f in the fastmap.
> +					 */
> +					tcf_exts_get_net(&f->exts);
> +					route4_queue_work(f);

Sashiko fears the above would be race prone:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com



>  				}
>  			}
>  			RCU_INIT_POINTER(head->table[h1], NULL);
>  			kfree_rcu(b, rcu);
>  		}
>  	}
> +
> +	/* All filters are unlinked; no new reader can find them on the
> +	 * chain.  Wait for in-flight readers that may still hold a filter
> +	 * pointer and have published it into the fastmap after we unlinked.
> +	 * Then flush the stale entries while head is still valid under
> +	 * RTNL, matching the route4_delete() pattern.
> +	 */
> +	synchronize_rcu();
> +	route4_reset_fastmap(head);

This really looks like quite a big hammer. Since there is already a 
synchronization point for both reader and write while acquiring the 
fastmap_lock, I'm wondering if something alike the following could work ?!?
(completely untested!!!):

---
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index bd6f945bd388..8cecc945dcde 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -52,6 +52,7 @@ struct route4_filter {
 	struct tcf_result	res;
 	struct tcf_exts		exts;
 	u32			handle;
+	bool			dying;
 	struct route4_bucket	*bkt;
 	struct tcf_proto	*tp;
 	struct rcu_work		rwork;
@@ -66,9 +67,11 @@ static inline int route4_fastmap_hash(u32 id, int iif)
 
 static DEFINE_SPINLOCK(fastmap_lock);
 static void
-route4_reset_fastmap(struct route4_head *head)
+route4_reset_fastmap(struct route4_head *head, struct route4_filter *f)
 {
 	spin_lock_bh(&fastmap_lock);
+	if (f)
+		f->dying = true;
 	memset(head->fastmap, 0, sizeof(head->fastmap));
 	spin_unlock_bh(&fastmap_lock);
 }
@@ -81,9 +84,11 @@ route4_set_fastmap(struct route4_head *head, u32 id, int iif,
 
 	/* fastmap updates must look atomic to aling id, iff, filter */
 	spin_lock_bh(&fastmap_lock);
-	head->fastmap[h].id = id;
-	head->fastmap[h].iif = iif;
-	head->fastmap[h].filter = f;
+	if (!f->dying) {
+		head->fastmap[h].id = id;
+		head->fastmap[h].iif = iif;
+		head->fastmap[h].filter = f;
+	}
 	spin_unlock_bh(&fastmap_lock);
 }
 
@@ -338,7 +343,7 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 			 * notice we unlink'd the filter so we can't get it
 			 * back in the fastmap.
 			 */
-			route4_reset_fastmap(head);
+			route4_reset_fastmap(head, f);
 
 			/* Delete it */
 			tcf_unbind_filter(tp, &f->res);
@@ -558,7 +563,7 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 		}
 	}
 
-	route4_reset_fastmap(head);
+	route4_reset_fastmap(head, fold);
 	*arg = f;
 	if (fold) {
 		tcf_unbind_filter(tp, &fold->res);

