Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C53FFAC1
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371376; cv=none; b=X55UEEKdrnmIVTLSXtikrxdmTlnmY81g/tfGSp8Csmk5Hc/81WPNwqxp25v4j7rG7rl5MPBuRutELGqzco53u29Hqhk88J8Dc9rcvY26I32Wk8nFHolUCu/FXS6kCOz67dXqcq4LpZjhpBURTNTMQ0rNFw2YaYyr5BUcmaMtyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371376; c=relaxed/simple;
	bh=QFWRRi3dcvbfNDuINnUyg6dlCUW+03hLVAiuG+24s80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDCyC+ELROt87S/Y/mABShGIjz8YoonpUt1NNOEvakLyNTtCJYuqHfpPv8v3Bv4X0VNHUS561qDxJpY03J0EUaJaM5DR0mu4PEODbMFmM59OK3Faw2HlC/1hnxXQ3W1oM+vmtdHiG1vHCpuGNcum31AXEH6xOYJAxW1aRImHFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK7OlqPU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK7OlqPU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c00f74baso21521455e9.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783371371; x=1783976171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwPoF8Fmw0t1qCCzDlMOhOvsU58fwUTJ7U89Tmxw7lk=;
        b=KK7OlqPUNeWHSfP2FfMJpu1StRw3cgmHkgxc0K1R/2qQTtOZq0uNZCX4Y+AjmQmkxg
         OBcrwsxunT9SMQOwMptor1Us2jXgKccoMPnKifKIvV2Abm62vvCuwQXQyVq3kOvuTfg0
         CffnSWkXDXWfNaLJYZbwoBaAUgB/vlljsUVX2H465tA2ExYHSVXRQSJ0S4arGxyk0+By
         6eAnaDlkKjUvuMGUQtB2QsXDwi8/9eZiBpdQ2P3gPXth+odWCOb5xcgUDVCN3BqXLWyz
         UmXrKpLpINjfLlOiaShTuNa7fB5eULSTCChl/rmm7fn/5UB7VqCNG7gZltTuKkr1ZkNU
         e6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371371; x=1783976171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwPoF8Fmw0t1qCCzDlMOhOvsU58fwUTJ7U89Tmxw7lk=;
        b=S2Tp3738AIwWAZG2ve5QHZdHQFbXQ2SHpL8+qhybEiBjSkOSSaCDgdjB4oWvvBXqhA
         wsM3aSOUMC8HApd5qkpUE2pOIqagN4yBnQ1xm/u7ta7HxSCVRRuaBXQZ4i7/THTEI35v
         GWTlEM82YdXC0tNx6B/3aNDQwYjVX0dO+AdLvxtaEB/odoanMSOyzbJn9pPdcwPncjXu
         pGJPZnvMklMgXbLpYOgaMvCTEt2Eu2+O5vR3Ne06oQ/+uykA3kAwST5iypQz+CWa5emw
         sl2JmNYUFZX0JTlnrk7pjxd0pbstmRDpZUQWDHHbAgEf0ZFeAUeLB1ShPug60PF3a2X8
         PPkg==
X-Forwarded-Encrypted: i=1; AHgh+RqMZjg0WeIpRnVTX15uY9ZE+9FDDqKj69ijZ5jDkld/tedShqWGUJBBnStzkMW4vKaXCGVA63A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTf80hbDNHNSpg9gOJprxqAZoCln+ddjIny45xzSiyzN6aZaXb
	pSDJ8MoAhACmcG/bLF5jRwROy5IMcJn4NRohVhjIWIi8lLKHeUjY/2HK
X-Gm-Gg: AfdE7cn9WdcemqIszhCAvjgNA4CKnclylIgYVgrDkRwMWI1yit6fLi5qbgaAQ2bPQw/
	cikjZOpMa1uFYaTgo/9E2nmUkv7F7HeQsckhxiJUD0Axxc7aOmcAyTTLc/AI3I3rT095P4KuMjc
	1Z6VXnbSsG8R+WYJLFIl4FZdTXG+ZT/wswEqMkPUCTu7/LWcfOfnZpTe9592HhDRC+nFm2zZekH
	xeGw9uqIXvXxL9K0S7snjIVLN2j/Bt9m4xv963xUzb488Yt/+TPMtj1Vr0FBTza2p90i/EESF61
	9tk5pRyMWXE+779PXBG/u1viuWeEwSuJpaMzrrqTM+4ocVA6nlo6MnZG7exlY85iOxAkUmR/Ryr
	P65Y+vsSAmStHi9LqU3kqwm96MmSGNiuDSO/zjYapAKt5zUoWEsgVLiM63KoBNS+Ju8wkjCB6+d
	1Sl6tvadKsuYkak7tF8OnYmIKbehliOYGVmLOYypJww/MzAYehTcWBm3We3AHVWpejlbzkGhg=
X-Received: by 2002:a05:600c:4f88:b0:493:bd37:1cdf with SMTP id 5b1f17b1804b1-493df083006mr23349065e9.2.1783371369725;
        Mon, 06 Jul 2026 13:56:09 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294b3sm244745e9.3.2026.07.06.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:56:08 -0700 (PDT)
Date: Mon, 6 Jul 2026 22:56:00 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] proc: Fix broken error paths for namespace links
Message-ID: <ua3v3vjbbyzae5twf2oywqysfwnojqy4fmhzfucqwahy75pgb7@bwq7sdgwyft5>
References: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>

On Mon, Jul 06, 2026 at 08:22:42PM +0200, Jann Horn wrote:
> Don't return the return value of down_read_killable() (0) when a ptrace
> access check fails, return -EACCES as intended.
> 

This is the kind of a bug LLMs can find very reliably.

In fact Sashiko did report it, along with something extra to take a look
at:

https://sashiko.dev/#/patchset/20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33%40google.com

