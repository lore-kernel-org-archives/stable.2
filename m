Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663712;
	b=GFGQG+FvE6jyIwptdaZp30MZOkpkYQ2z51BiuhhgDLx1mWtOwoJ4AGz/JkNMmGnnslPt
	 rFIIl/6LZndjvUUBR4hUz9YulfSm7pxiKf3XjOGW6IYEREtLh7DVR0E9RxgwVpWowuQj0
	 nSBfPPVVgWUkzioFRCDd0eQQTm3ileu8q5rY66Y92/G23GT7InCB44oi3aUf0l6a6yxoI
	 RB3dNGNWx4jj8NX60TskvOO3CiLNkb2Oo5ye/h48c9zYDNXem7KEuqhUNGc8zwuiytju/
	 giRrgLudKkU8qpwkocfJVCfKnFw247JYQkzivG7I67G2WlRizaVjFXMxg/ikPnk1Bpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HqIBIkYmDIeS5rS19uDkZorN+oiTXB7kdAGh3sJeepU=;
	b=zN2bzcMWJ8a4/yYV9sjQNF4tCGVKT9Mq90/yp0zBEEayCJNkOHY9KEXQk7uRWpHpRpwj
	 QndvyCNHVgHdDjhOU6+0hkFsQKqlA99+9cyqvAflavm9iCQcEoTe8LVPB2X4zkHS6AxJW
	 WhDBJkOTl/DpxC4AABE0j2AQbWNyeeixnTWStMnn+eNuDg9GM6ObPCq8sP+Q2N7YOGGra
	 Qkh1AoxLs0e+HUM+V2mVvvI1HqbbfmRizfhlS73fRfYp8ifQwK4tIPpwYWq6K4Bvk3x+q
	 QQpbF1pbElPZhxWxfobyWxzPVIgsvKEjUGHQYeCZS9CdEKIYGkSFIoIJ/h0sdtYEbZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kiYfm6Xj;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455B606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5455B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kiYfm6Xj
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-92110499585so60022286d6.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795663710; x=1796268510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HqIBIkYmDIeS5rS19uDkZorN+oiTXB7kdAGh3sJeepU=;
        b=kiYfm6XjKY16umLSzCMx9xtkmZ6TgMTLPuigyDJSnxMHXRyT5aJnlv+ZiYqIq/b64g
         QaVsAKPDujWPMBaZtJXoEJWyTbIe0Je+xB/kVlbVf1Lk221ap+ngxBGXvH7jDWq5KqSc
         kzM6dIwbzHfRAQMuYe/pu155R3nm7ArfhYdqfgLzk+4ugKaOW61VPKERVFuZ1IrPxEPG
         IEft8W99MCOb8zFwLdWH0z+G33Pwl8+QnHKF8C9gIviY3XzX/akGPwrpPYuai4OdIy8o
         3/DsW0URM/aTVvVwRYeAa0MhWFJXGgt3v+2jtiLZrqwbbnixtQlxMBmk7yNI+b3mDkSN
         2tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663710; x=1796268510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HqIBIkYmDIeS5rS19uDkZorN+oiTXB7kdAGh3sJeepU=;
        b=FjDl7DMX44a8l09G2jNahaTV7Tp2qOxPheZ2UlCEB7edBDuybLWlap3iX7hb5/SLr9
         JTZpoeinJfNa0jsrVyKIw9i0+ZBZEtZlCUkOWlLoKXTIpyINse0R/HNrbWzkGwRpHd+8
         maHSC9Tp0X+biB9lkm0SttLJbgZavFAeT61nAfb5WELlqQfdPYdTwkZx/ZA+CZOIQJKj
         /md9db37uqo7iusty0jywqvjnOQ4H9imtpwSEhMytFoXzSZv6LON2Dz/kKBQSxM+FVGu
         gCYtBEB269Um5OGUhPvYLK7Y0tt6AHQBOBO+pSlRNE2kw221zUqmddKKNTu6VGhrvy58
         gnsQ==
X-Forwarded-Encrypted: i=1; AL+hErEVssHUEhtrs19FD5aM4aIhe12uAyBShydw1uvU15mAa2K/xCj6t/HtuOTzIT1modpM+gujQtg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YvwGThu/vDkUDJocLT9VaRFkv6HRtnrEJAsdV3+zVvQAM9pSu
	KcYjIrFWKRJ0ZRZ9e8qMCkXIVxc0+NZFsqtUpT9lyybj/9PJgghUUqthsgS76fAV0w==
X-Gm-Gg: AZFdTZdIG2Eo/+UReQl6Yk96uZfmlmCqu4I04BEeOpbv5Grtu8HOIoq458YfU+vA+M2
	p0ko0kT+6AtRr2ldrRu5oNszF9vWw6r8b5tDPHkp448hucdijTeR1zqBm1pTMBhqDqpcHQxX6l9
	OhSvvV7IaGylKUr3HiwOQJaFyS9F770eYl34KyxvleQRxUH7YIlFV1+aBT14zLDETjBJI8Tn9Y9
	3FWrd1BW+c8geBxOFQ2+On8lZm2yjQiBSeTdcfK4XtE7nCMkG6NdnV8ydFi3V+b0U5unrcIRrqB
	z1DQC15noQav1/eek+YPL3nIWyXQNwrPh+7X1sj+hB17pxU8xvUvTPkaz7jEZ2Ov/grdXG9b/Ae
	aVf79ebluSs3d0KmJ6N6K0hrigp0C1+XF0371rTjZEkZq/EsVPLraRXhpOJIImRRF8SHQytefpO
	hfxHs92WZgHnokqCF5GIZ9s0DQ6vaBlhe7Tf3rPSbhIF/MeoyAD9EFhJ8/R84CXkbmEV2twJtxH
	71LMk0rKS5PFhbzh3F+BXckllb07hE+b2qFFee/FvpuTmJNKJZyIjTcouFAN6fJ+WVfnJYDSd52
	qkfv/sCMwN4h76MsC5R4mV8BymNbH1CT2FpaB9TLQyO9Wu+R1THW
X-Received: by 2002:a05:6214:451a:b0:921:39bd:6d05 with SMTP id 6a1803df08f44-92139bd6d64mr355239416d6.6.1795663710198;
        Wed, 25 Nov 2026 19:28:30 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm177671026d6.39.2026.11.25.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:28:29 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gfs2: restart rename when a signal interrupts the glock wait
Date: Wed, 25 Nov 2026 22:28:26 -0500
Message-ID: <20261126032826.4156477-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125185332.2549812-1-agruenba@redhat.com>
References: <20261125175007.3659558-1-hengyul@cs.unc.edu> <20261125185332.2549812-1-agruenba@redhat.com>
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

Hi Andreas,

On Wed, 25 Nov 2026 at 19:53, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> Why not make gfs2_glock_async_wait() non-interruptible instead?
> Something like the below should work.

That is better, thanks.

There is one problem in the sketch:

>  			prepare_to_wait(waitq[i], wait + i, TASK_INTERRUPTIBLE);
>  		if (!glocks_pending(num_gh, ghs))
>  			break;
> -		if (signal_pending(current)) {
> +		ret = schedule_timeout_killable(ret);

schedule_timeout_killable() sets the task state to TASK_KILLABLE again
after glocks_pending() has been checked. If the last pending glock is
granted between the check and that point, the wakeup sets the task to
TASK_RUNNING and removes the wait entry, and then the state is
overwritten. The task then sleeps until the timeout expires. It does
not hang, but the rename waits for the rest of the timeout.

I would pass TASK_KILLABLE to prepare_to_wait() and keep
schedule_timeout():

	for (;;) {
		for (i = 0; i < num_gh; i++)
			prepare_to_wait(waitq[i], wait + i, TASK_KILLABLE);
		if (!glocks_pending(num_gh, ghs))
			break;
		if (fatal_signal_pending(current)) {
			ret = -EINTR;
			break;
		}
		ret = schedule_timeout(ret);
		if (!glocks_pending(num_gh, ghs))
			break;
		if (!ret) {
			ret = -ESTALE; /* request timed out. */
			break;
		}
	}

The back-off sleep would be schedule_timeout_killable() followed by
fatal_signal_pending(), as in your sketch.

I tested this version on gfs2 for-next with lock_nolock, KASAN and
lockdep. The mv reproducer from the patch moves all 12000 files, and no
rename fails with EINTR under SA_RESTART handlers, handlers without
SA_RESTART, or stop / continue. SIGKILL and SIGTERM still end a rename,
and fsck.gfs2 is clean afterwards.

If that is fine with you, I will send a v2 like this with your
Suggested-by.

Thanks,
Hengyu
