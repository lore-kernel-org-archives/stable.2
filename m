Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D34DE729
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605895; cv=none; b=HxTlbvyYHLDHoWFu+tqAqyhpqBpQv+T8KxEAwzh9d3+TraunStiSv+qPR/auH6m16SbpWflzt80Hb3Txv2ZSi0jMOanIG7/C8L+emNssZE6TJnmGhhuII8QBGLWTALhVDuN/buMy3uZsZBs58DsFI5/fvnha7Ip9QNfOte6R+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605895; c=relaxed/simple;
	bh=D3TXq3ux30ZNnfK6lC/HKLzji/G3Th4nc3cSemt7ugs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qev4reIUJ4eKs6cKbqh+EMKch8w3mJiJQ5Vzou7hgKLCXFAvb2jJkf/Nyo0n0AKgJrDzU5684VlsIZLpJftypYASDWASle8Ux+T+5nJKZT/yN3SY9UBwSFaFB+CcVrhJcn7wtCL4wtnuuHt5HmdtMK4g46oO7QCJviXwuobq+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=00aMNaGV; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="00aMNaGV"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d06so2131882c88.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790605884; x=1791210684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1z8ZKhhaN5u9NWisVj47vzqbZOwB7wmqGzyey1IEdyo=;
        b=00aMNaGVqCsBfl/3kMvAjybg2Vic0g0YqY2HqJTRC6Q2Th1V1wJyLgQVmlOTsHSDb4
         AKEa80v6S0UlWvhwrEY82BLapMF+5Lt1A5A+ucnzCQAC0zGPeXaSy2uKZs78+Kvt8pbJ
         fb9dtu2ZNG5ZEXe45PgSkKfJUHoNqg0qNF+s0ydacdGlcQwxHxeXErNaukIeHKexvMTG
         eHgw5rO0e0o9+rL0OTSHkc+AragEgST6rVHV5cjXDeZl3DiEfvBAMulO8gXjf9B1CAu/
         3ZxYr/g+YMDSYPSIqm2NenDTIKVTHTZCOGsNI7Xm/h0BD9eeaVRiqZuKwvGBXlyROsd+
         bMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605884; x=1791210684;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1z8ZKhhaN5u9NWisVj47vzqbZOwB7wmqGzyey1IEdyo=;
        b=ETZGBgZ4R+8sUdZUpzNvq77OZWr/P2Ba4Sls1fVcSCOIrKdIa9WQBPxsKRSqM1YtmM
         Xtj5+DQL3V3AG1eILzkegCKt3nQd2cQCkCZBKbjnWNHHNiFARPoOgCRvgENzU+ZrNxuw
         m5L3lvNi/v2Sqs5Bk35e9Eo45x1CgjSkrATvhRb17n+1G06h40HoaMsJRRL0+yDCirN8
         PsWD2oo/ZmqOm/Hi37jN63MRW6PykVZmhOlFxffzs23R3Wf7jD6wyXzd+74latR1pxR6
         wjYazVPmfEbi15ZrgxgFDjOCO11fVNfMoudU8ahUWn1T71VvFGWg1O2slYbf3tPWBc/0
         J7zw==
X-Forwarded-Encrypted: i=1; AKwUvBzTS5geG/wt9D+geXDijpzO6+VA10ruELWT7tWWZ4CXz77gdeJnFX47XW8gMLoHVIAF7y6Dt6M=@vger.kernel.org
X-Gm-Message-State: AFuF++lrVrEL6lCZTtQdPGOoc9n1jnZdto6Hls0YcMCoqzx4G9Y7glgs
	FRbuYpawhGSA0pGhIJHNO/s1HBybPjhlhKp+D2n1lmXME0fx2EOa8deqAVUUJDYuW3w=
X-Gm-Gg: AYBFou3AAwFLKKkgpdbkMbUKA8Oawi2i5lQYfZy1dbI2HPS9Mofnakfe4zQv415k2FK
	iV8cu93Y/E5l4Ly9kIcLHg7JtCaG/6yHWBvuLoKIqjvCewtBb55NNdZ9E3JIp6dvsy6OmgwucX4
	lw6zQyAF3bdduAZI1daoUYtLWm+nER+VLzmWUqKlJ2WmEarOrRHc7IVbNZPpMF9ZKf4yiWEgWUo
	y2AITZdZdwSQTwTrcURFMs9En8Z7ib/lk4TbAEKmt60TMRLYDvewZrRrIFiPH7B/faDu7S8IFRq
	b+XLxLMrPTKg9XSgw14r8BxRnK5lYvzphh9Ff4ed8lCAlebLmgrF9DrgXMBJfl5ClhouTeZSZuk
	UbRNZAbTxUjypAvf0K/vuBfWCV5t1asktzj6sk4zl9ZSTTBTLi93HH4FknCyLQHBSWaOA0AOY76
	0sAJoKfvh6g8Bg3oVrE6M6yb7LOtcqkBDOgUnSAkSWQKpv3c7ikl7JBv9OGnJCzTleqNN8MgTHE
	fNtzHvLtrAE7PDUgedFNpT8QZkv6V8CMdfZKAwyk2YrCPfy8AW/GurRdQ==
X-Received: by 2002:a05:701b:2616:b0:144:edc5:32d5 with SMTP id a92af1059eb24-146cfec8ddcmr8983096c88.22.1790605882718;
        Mon, 28 Sep 2026 07:31:22 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm28616577c88.13.2026.09.28.07.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: lollipopkit <a@lolli.tech>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260927074206.65427-1-a@lolli.tech>
References: <20260927074206.65427-1-a@lolli.tech>
Subject: Re: [PATCH] io_uring/cmd_net: end TX_TIMESTAMP multishot when the
 CQ is full
Message-Id: <179060588158.984285.6234217255544312653.b4-ty@b4>
Date: Mon, 28 Sep 2026 08:31:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 27 Sep 2026 15:42:06 +0800, lollipopkit wrote:
> SOCKET_URING_OP_TX_TIMESTAMP arms an EPOLLERR apoll multishot and, on
> each error queue edge, posts one 32 byte aux CQE per timestamp skb. Aux
> CQEs have no overflow backing, so io_uring_cmd_post_mshot_cqe32() fails
> once the CQ ring is full. The loop then stops, splices the unprocessed
> skbs back onto sk_error_queue and returns -EAGAIN.
> 
> -EAGAIN is IOU_RETRY, so the request goes idle until the next poll
> event. io_arm_apoll() forces EPOLLET and draining the CQ does not re-run
> the command, so the spliced-back timestamps stay queued until an
> unrelated later timestamp produces a new edge.
> 
> [...]

Applied, thanks!

[1/1] io_uring/cmd_net: end TX_TIMESTAMP multishot when the CQ is full
      commit: 3a3d93070c5ec8b8049d57025987ba313420bda9

Best regards,
-- 
Jens Axboe



