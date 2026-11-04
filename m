Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816327;
	b=RsoIr5vRk6KyE6QiOIA3nHlkNix1af0UdvnM39fPsbpIJgHRkGwOjXSyQrEAoIugkDXu
	 Z9PCWL4QmLYPcRTfH0+hobL0P71Au0W4+442fDGpUs/BrCSfM42/eM7OcD4jDVLZFonmm
	 pCruE5p+Q8nD1S1qldlMIcaNSyhzKVILkKBTlh562oQYEt6VT5PTer34ALYGLSydPavkU
	 ro7HhyexJmuyFQ5HsClh5fipejBr5BV9xYYoy05eLjikOia0YKhZ3HnFAmM7Z8N8TEfAH
	 bJpMhZ7seZ6w5tJHQnD8eBzARNYOtdujKj5TgAynC0M7Y4Kt1h5k4dzYIoeLGcz6v9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4GPzEeskCMuHN+9ELTAtP0YMdODZoiPzj+5M9PuL64Y=;
	b=NVVvd2117KIPVLXR8AVuDkjegtdofxQQPzzWFhvWwessAM0DU6j3rqUkfFz+Eyqlk0+u
	 u0Udndn2LNzyIZJOneYQbti2yoHZabXYsj2kpC8zP7yV66mhSY+CLE/Pt90zw1XaxzphR
	 fibBF0EJnucoaawWlTwjx2kFMoW9m65snqMhTI3tqRYzUkFW1AwLsOCS3yNC45kQ5FG5z
	 FpikEpih31V+23U9r2i/tkANmyb8ZeT69etd8kKSjwzo2D8hydHuVaq+8H0dn32p6l8Q4
	 LbyPfe2JbOBhehRzULWkTDP5afTq9L4PVKO+QpAS3AlE+m66+K76E0YGeIYjkHJ9tkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c68PXakd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464B606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2464B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c68PXakd
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0a93ce04fso73791a91.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:18:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793816326; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBIMQUi+MBB0WbaujCF7PYnmhe5i5VmEMdXNMrSK0KKaouUxJ0UqxURPn6xD4tc+XM
         cDk2fScaP/FLKf/W5VOQYwDkqfLb9APxzDkQBQ01HcdmnA3IMxRwjM9lUVciKnIOV95u
         INaQYq111qcgw/tjn7pMh3PfPIVB1gaYWiaBe+wCIAQJYLAbThQ/zV+gL4pfWqSqIYz6
         aIkX1dXSwXqPWh5MUXmOKM0P0YxEDx6Ky07N5Emx+U81Idk3N2eI57xyLvsxefLNTe6u
         0S6KXimIvSYMB9d3kS64fGfjpp66uTctQLOAxipv0ydpvQfSsuDdDYs6hMxGmF9ULqCN
         rHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4GPzEeskCMuHN+9ELTAtP0YMdODZoiPzj+5M9PuL64Y=;
        fh=Pe65Htc2OuZvZQfjh8Rcm1qixpJBgNJy1eLE0vvgAhU=;
        b=fAv2+CeKIMTOS3DSWX+aoPA6VMME2Xji2A+8VZHCnkz5PLHuMHJbh5iKRbzK2Wq4qv
         qcER1UuS0w7YrnVaWUfpnFhgRGA6uqyMjGGNOIjVWAAsJiAOSMg3Q+JN6Z25SzLRB5m2
         JuckbF+dLxo3M1rD87sbEl5xpYErPvSrmCxpvq9OeOxxuImOIilPNUqDGI7j3hb+13vJ
         KwZUQnm6NHeSeA3XOZsigJdaCFVxrlXTI53gs9FrcJPaME7Mj6VdTx8PtBz+IdyD1ytF
         0NCGRvQ/1/YURGDJfzgli/wgcy3XYVjDU7B64iTperPjdMISQVBCRNqGRuLp8QjIiyVL
         osMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816326; x=1794421126; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GPzEeskCMuHN+9ELTAtP0YMdODZoiPzj+5M9PuL64Y=;
        b=c68PXakdXhEO5dlYzvgscPLyWrKpe8P4Marnie+H4cl2bi2BHcIZJX+c9l+dBSiOt5
         qjiT8aXawR9AlJR66KOG7jquxhl7uANljiyCtXVsjqPIEh2GHIf9AVBNN0/+yL+mf3bm
         Yj9m/Hnru8VAaAS7KJsTr7xjVOR3FZCHXoSn0JufzuNU9oOzHtiASm77/UMgcXclMLC7
         tLM14EeCclvivKn9q9dQV9jxHtcRasNAlCihS92jc0/f+MeoVLGjc8xc0T+W2Z9gOkJy
         zFJx3B4sHRYCPA0Ns9eKfWMJ5Y5725Wy5Hlo1H9+3c9UQWNVNHSvrc2cSq70KX1oFKAY
         /gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816326; x=1794421126;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4GPzEeskCMuHN+9ELTAtP0YMdODZoiPzj+5M9PuL64Y=;
        b=cDtG1Mwj6G0uYUy4TT9GI8C/E/QEBQKnSeSI4JtzWlY3IjOaeLYEo9KC4aEIz2pEGn
         t3Yd/rCq4ZfMCrt8V+9G9+RdoK21acek1KsWUpARaYoxJoAuBAtiEGL0tuBjCr2gzvtX
         GD9ZVF8g0dBstfXLLH4QBNornN+w4IJNnbDbiZ4rO9EKrZtbS7F2QCA7R3Dv5nUYJLv0
         72wtm0u178lXxag72VaScpbRJ372kNJZpOFbgA7CcKfH4Pbh8jd/z2Cf5XbgrIU7tqCP
         kCoCvRngM9YgPxbnd4ruRnZ03QU0fpjrYUlKGlVZGcolD83N/2dR4NP06DUz1v9j2jcC
         kqFA==
X-Forwarded-Encrypted: i=1; AKwUvBy56gseQZ93Sd0+DRG8PAbHXTqRw3gywodGZF542bVmV9FFAqXCGWah+8Hvxzz5tSeJnEV+sXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EIiykAi/0MQW+BzRy722g+/eVoXYkh+cE+pwiLr2lnxCjKv8R
	efZrmbEaUkZnhvE3WLvekiwubQeJ4wD7eEtp7hg7X71YQfbxkYnBkRjHieqZCCrICX7vxnx0Fis
	3vkK4Rw/SpoxpupUGcbWoaOeK0k0SZ9M=
X-Gm-Gg: AYBFou2Pdab3bOCNuwhZMLD31FJCi0FIgr4tdv+HCxOMJOqD6kPT+CKm99XhdcPqZXT
	/KqYusR59OlrT2P1DvCYZFmkE1Uff/F5OYXmcvMJiiwZ9GZmeZd6teFb5fRCwV+MsfKptVONgGH
	gyC+F3If/oGcbDwGwNQALoosKKBivaM0Ge22ykFPmPUi3ivoxCnmYbW3AGGTAcZB1YhwX7AXjqP
	k/lZcHuJ7pn+Qvqxud5F368xYBBHlpNPN+GhQCgNFV7dbtaFeJNqEKcRlcrztqVRUvzkZXZvWjB
	BWDBHuaccnnFi9wyJF8/n+lMA/5yg+mO48xt13mKoJp6vNFooChFUvBjniFXdRtflzPvHoFqNBR
	LRZCJcPDrWMlHB0OmV+qLJqcEPwPUGku1YLNeQOvU3zfaC5pSUaLEH1BbZ+E=
X-Received: by 2002:a17:90a:fb8f:b0:3b0:9e2f:cfc5 with SMTP id
 98e67ed59e1d1-3b09e2fd7f7mr2261179a91.1.1793816326501; Wed, 04 Nov 2026
 10:18:46 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103170703.1600310-1-lui2012qwq@gmail.com> <20261104140608.GF478286@unreal>
In-Reply-To: <20261104140608.GF478286@unreal>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Thu, 5 Nov 2026 02:18:30 +0800
X-Gm-Features: AclHuK_OH9O0hxjTTaAz9x62fRlwS-_o5uMRpIReHTKZ5ae0puZ_WpbvlqiHt_0
Message-ID: <CAE=Q7=5iOdUgPsD7dg722e55_1wNR2Uh9LnCT524wiFAD6=sHw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/ipoib: cancel the AH reaper work synchronously
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 04, 2026, Leon Romanovsky wrote:
> Please revisit this once you can reproduce the issue with real IPoIB code,
> not code that merely resembles it.

ok.  Reproduced on stock, unmodified ib_ipoib running over a Soft-RoCE
(rxe) transport in QEMU - the harness shims sit below ib_ipoib and the
driver itself is untouched.  The escaped reaper re-arms and the timer
fires one second after the teardown on the destroyed workqueue:

    BUG: KASAN: use-after-free in __run_timer_base.part.0+0x80c/0x900
    Write of size 8 by task swapper/0/0

v2 is posted as a fresh thread; it carries the full harness diff and
reproducer inline.  Changes vs v1:
 - cancel_delayed_work_sync() -> disable_delayed_work_sync(), so the
   work stays disabled past the teardown instead of being re-enabled;
 - the misleading comment above ipoib_stop_ah_reaper() fixed (the final
   ipoib_reap_dead_ahs() never touches the work item).

v1: https://lore.kernel.org/r/<20261103170703.1600310-1-lui2012qwq@gmail.com>

Chengyu
