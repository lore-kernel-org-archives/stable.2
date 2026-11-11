Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794411734;
	b=3BoWRPTIN7DJ2BQ4g1yF0hblQ2b/oPWe5Fp73cSKw++JJXcsKZ4oWwH967uqnGTT8umR
	 xVYA1t8VtCNfA/+HP7/k55ftQKjqwGJeqSG38hDwitjLFXecthKeuRH7n0PKq3ik0cMDZ
	 RkNTJ+SBM8UIxp2jfBtD6/+4VEHuCKrkhLzdKAJKvnAwtS66isAFUitTfyCtkqk85zsHU
	 WQ5kKFM7C3FsupbmnYRIDgUOPbmqv22ZNDdXc6QXFVmFbOkEKWn/bzrF2DgR7+m44G6Hj
	 1WwUeo6SS0bxIdl5K0/6H4kXyoGeDZKDNxOImrUHwYzrEDYAW8k2nRkPOmnWjZo3YWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZD+vbtbPmFOJcN2OyXTBdL4gMWgwvLA87K5+LSebFco=;
	b=j76JwILTc1iqnUxu6UssZFaGc8MaKjHObnNH4wvc3eSd3ZD92nPN109ySvaAQjjPOjF4
	 LNAozbVxN71hUBW8sBxuNt/tGCLkaCFXNjA4KNDbi9zYD5hSVDWEU/eKA9AsysZxTPJFc
	 rn25QMwDJWIHeWS8KHiUp8r0SL5miUQfbaOe5qHb7ThUeUFyrz8kxvolhZhWlFHSt5m3y
	 4VEFQj+DRE0RcpRAFNyxHH/fMFJNLLwQZz/8XWSrK9/D3JE1qLY9WD97Z2ddw1tNv5tGY
	 s6iFPHNsst+OeRjuJC2UY3expcc156jHWUP34BLAI9gEdLsmz0EJe0w1L9aeSXhXPuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ILrsDdmm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175F606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E175F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ILrsDdmm
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a315ed211so3648608eec.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:42:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794411733; cv=none;
        d=google.com; s=arc-20260327;
        b=jVLYeQUPr3w13fq27lBnu4sDio8pejPzVS/RqKSuVL4BWhzHPM80q6Y+Mr/2Rh5MkU
         2eiMxRocBlGHmIyd0r6s/VhdHxnWEhCQMLZDHTA4PVfcK0VB7YaCB9Va4uX23YwhBeRI
         nZ3NnpKjrc53R77c3BAi6/i+VrQkhJLylAZ+cqjh0+zZeZse1gD9X/lkdnfGJLeVZcPq
         /VCaUlRLNgaySkurjltYjz0G+DvShQcbSOYVuong82e8Wh/MMWx934ApFxugAO1CiK7c
         vNa7Kh6Z5RhijS0vX3154qL/YstR8vcq2i8edotRcqJHHSEmUAYVGVmmgQ2Zhi5fT3c4
         OM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZD+vbtbPmFOJcN2OyXTBdL4gMWgwvLA87K5+LSebFco=;
        fh=j3jSLidzTkNvM72x+6/SH2hNohQgXXLImba7XZnLNDs=;
        b=II13gpBOQHw2fTIgbXbNSDTxBON4n8PlAP+clZI90oJUTtBOOgdWfgfd+ta9K3oJ/X
         IedVpxXkBwOYQSbzCWe7RL+8Hq4jygjU9sGnGI64Pl+rQ5sRdNRy4ZMjP285MolLNddS
         D26IuUTBqhFsHBlk3pvSbLIba9HvBGH/itnm4EEtFW/2JLdZDG3IPSVuOpeGE7pQY8je
         OySXAFQaUNQ6JDr48UAwPNG+K2hos0mV5MaR4zR1bCv3Y5OjR7+w0dfbvPspEPGA1Ca3
         3ydzHKe8Av7G6LPpCtuigSDiR/7qBlTKbMGScvMUG7aTkG6VXGuVczmvkNFjU/HYmZMt
         adaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411733; x=1795016533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZD+vbtbPmFOJcN2OyXTBdL4gMWgwvLA87K5+LSebFco=;
        b=ILrsDdmmAvzqhD3TiNivNeF0J3+4JJsWrW9RQqTyes0Jt/1NIaT38z1TSZwlRZiVcy
         98MR5a4CwfT/wbSrYAoqvQgQnCONz6ZmLwipoJB32SrMrl1+ZbNF1O1Q1BC0mBBDcmDq
         nR3JIdl15O8tUaCjVcBRZ5CgoCZCGtH8v5dOQEek1bcF/FejZXezQwcOGgDag3b92qxR
         547BWc2HmXMoxFFxZqg0vESpxdfk1lcGoyHdtCM186PCuE1shfkKEioix2RrXy+5hVEE
         uZ/FHlRnVle2GxQuaD0QmME5KVBngRYC2Lb7MYBKm0GvtOleg5aDWY6AjsIEIH8N5uXe
         TAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411733; x=1795016533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZD+vbtbPmFOJcN2OyXTBdL4gMWgwvLA87K5+LSebFco=;
        b=ZUOvTXFsyceth27uxA+yaeDNevHeogCWh3bzwgow6KyuWYgtX1Vs9xd4WoJpx2FZDr
         KBlNwqRJMN2YiUv8VxWRTCSgXyqMzVASBcrWYhVyHTUoH1ZAUqGW4SxHSEDETR8+nlvN
         7khKrssyghY2UIqpP1Ry8pAQQOPsbqSReu+5L9NAIVWGZl1bycB6qiPW/88CPGkQ9RGU
         f+5JuQM6p5ZhgR0kWw2F//JCVbplEa7VMioDdMiYMIp8DF5k3+CQnLbrCSfwGmZLdshk
         7cVy4j8vwfAy2Pmz2IslyQHX2Vvz9Xu66Ih8ELBl7y35k7UDLwL9IAxMiOYKcrJTrx7b
         JTfQ==
X-Forwarded-Encrypted: i=1; AL+hErEL3CCt3Otp1zyNVL1r+iIXbgQIgWK24C+8t0lFd8zQr8OM3mIEbglztUygoYr/lrKB1kPD2lI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/S8yBKNUO3zaLDfQwzNcSQ2opdfFVJ8S66g59YUorcjLsLWs1u
	+xcZB620dUQkbMBuE57Y+4s7RUg6K8YHiB1aX2naNI0UChOeyvI77YagiY4Avk5xsWLOArPKW/G
	N7dRE4lw2gqQZa8lRko5xs2itbXBlUi3Xx5sHoTA=
X-Gm-Gg: AYBFou3icmLoLg7V8FJ1kmYpLt+SovVzp8641AinmBNVoYf8tMQ1vPYpsPVgHJ9hx6a
	0eyqLLuhqPzNPpQoruk5LL4TJkL4GlY8lTBIGSTBYmhdK2vRSzLpg/1Wt1xdzl7uIdusxmi5unF
	BFeRojLGNSDaGrrlZJUW9ZWmbh1VKwBIhNcqPKFPMoeQ46AXf5BHPW2dqTMWdLJmyftwmoOYm4o
	01GfTlnxFPR5K1f+dCy9ixn6R1EiyiwZ0otTGFf66QqggYvP5fE4cA55uuZkOZsY9821Y9lHjpr
	dzDzzfXyFZlYo1JuHLJ4i3D1v7XxandgJRgSC6CT8gvKb5R6RItCORloQ8ANyfIyGapWuN+ZlIF
	nCTledbezqA9FDRwAwJwl3n3sql5vVeEfdk3QM9p5sAPKAkdjAUpwua/dthTn92H1wFxigw==
X-Received: by 2002:a05:7300:d190:b0:361:2a55:b94e with SMTP id
 5a478bee46e88-3766a2fc88bmr3428916eec.15.1794411732633; Wed, 11 Nov 2026
 07:42:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111090447.3047656-1-hj351016@gmail.com> <avR_tx9ze-eAa0_N@ashevche-desk.local>
In-Reply-To: <avR_tx9ze-eAa0_N@ashevche-desk.local>
From: khj <hj351016@gmail.com>
Date: Thu, 12 Nov 2026 00:42:01 +0900
X-Gm-Features: AclHuK-fUYFWM7BPj5Q2pN3hGxopZ3Dab9DAvaDPkb3_oUwcCHkHx9Q25tIIqHI
Message-ID: <CAGr5VtMvrt0OoJ58FPtaGy1tcQGqW9VMhZMb0dA9rg1gA5TSHQ@mail.gmail.com>
Subject: Re: [PATCH] HSI: ssi_protocol: don't cancel_work_sync() under
 ssi->lock in ssip_reset
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Kaixin Wang <kxwang23@m.fudan.edu.cn>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 > But is it okay to run before timers are gone

 Good question. The three timers never queue ssi->work, so cancelling the
 work before deleting them cannot let a timer re-arm it: keep_alive only
 re-arms itself, and rx_wd/tx_wd just call ssip_error(). ssi->work is
 queued only by the xmit path (ssip_pn_xmit(), SEND_READY). So the v1
 ordering is safe in that respect.

 But your question made me look harder, and the real problem is bigger
 than the lock: ssip_reset() is itself called from softirq context on
 several paths -- the rx_wd/tx_wd watchdog timers reach it via
 ssip_error(), and so do the ssip_*_complete() HSI message callbacks.
 cancel_work_sync() has an unconditional might_sleep(), so it is invalid
 in ssip_reset() on all of those, not just under ssi->lock. Moving it out
 of the lock (v1) does not fix that.

 The cancel guards teardown/free, so its right home is the process-context
 stop path, not ssip_reset(). I'll send a v2 that drops cancel_work_sync()
 from ssip_reset() and does it in ssip_pn_stop() instead, which is still on
 the remove path (unregister_netdev() -> ndo_stop), so the UAF fix is
 preserved. The watchdog/error reset paths do not free anything and
 ssip_xmit_work() bails once main_state !=3D ACTIVE, so they do not need a
 synchronous cancel.

 Thanks,
 Hyunjung

2026=EB=85=84 11=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 11:46,=
 Andy Shevchenko
<andriy.shevchenko@linux.intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Nov 11, 2026 at 06:04:47PM +0900, Hyunjung Ko wrote:
> > ssip_reset() calls cancel_work_sync(&ssi->work) inside the
> > spin_lock_bh(&ssi->lock) section. cancel_work_sync() calls might_sleep(=
),
> > so running it under the bh spinlock triggers "BUG: sleeping function ca=
lled
> > from invalid context". In addition, the cancelled work ssip_xmit_work()=
 ->
> > ssip_xmit() takes ssi->lock itself, so waiting for it while holding the
> > lock can deadlock.
> >
> > Move cancel_work_sync() out of the locked section. It still runs in
> > ssip_reset() before teardown, so the use-after-free fix is preserved.
>
> But is it okay to run before timers are gone?
>
> ...
>
> >       spin_unlock_bh(&ssi->lock);
> >       if (test_and_clear_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
> >               ssi_waketest(cl, 0); /* FIXME: To be removed */
> > +     cancel_work_sync(&ssi->work);
> >       spin_lock_bh(&ssi->lock);
> >       timer_delete(&ssi->rx_wd);
> >       timer_delete(&ssi->tx_wd);
> >       timer_delete(&ssi->keep_alive);
> > -     cancel_work_sync(&ssi->work);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
