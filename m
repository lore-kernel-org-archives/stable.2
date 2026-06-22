Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A424344D9B
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152929; cv=none; b=XenznMxIL8Sz4qubrGmNvlXZ9/T7eIqqysezZxWsVvP59xl6aJDbvsi75/WTTomzviDg56RCJ7eLkW+8wyLi0+cPZ4RToc9Lid4qzrznnmMFPZV85WH8JA7s5U3xp36LBjEMPY97q5c0RBO+8rFDDHHNg7oiYfm9oXBmhm1Piuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152929; c=relaxed/simple;
	bh=SGBlUrE1CYvkAsoFhupgwqHbmryO09vV1weN5LC6u7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9SnLxWbPNziEk0kaObPle/89JBoyU0dxrHaBw+6o7n544a3dPIVgNoXXnMyFsafv/mXMdk0Vo699Dmzb7wHUxQ+OE72gOq/7MQFk/iplOysNroQpXxLVbN+bF++qDK3XQVGA5xDenbyJz1bWPLSAABSz514Fw5uWmGXILmnRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdu/ilGG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdu/ilGG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4645995069bso2679659f8f.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782152927; x=1782757727; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGBlUrE1CYvkAsoFhupgwqHbmryO09vV1weN5LC6u7s=;
        b=jdu/ilGGtSDoUAWmc+6mLjWauz3JMfS1Edwms05imqq/cY6m7A0Ku2NPnNE8DCwKiQ
         5UYbIMX6mKe6Q4w8eab8qfAmAPtybf07VoMNdPwR7DJ0WrzWE5o/HRbIC7OVNQhTF63u
         33eOPli07q/ucJSWiFadFd8wKx9LE6eN4x7XrjSEhu80A2qwK18BZ2KF9Z/YFOUogGlw
         evrhfwAkInc6mjYLzJSkjH05PDf0mrPy3j0wygAGBpv9kSKns3yM1gBptaRFXoCs+d8n
         2n9P1Fsg6g+7IdtZVWeDUHTirOFkBWM3O5cwGZtg9g+1fylTilOmnTQMwoIP/iNe2HcL
         8Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152927; x=1782757727;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGBlUrE1CYvkAsoFhupgwqHbmryO09vV1weN5LC6u7s=;
        b=g4NrLOn7UnPvVJR2ucmEIYNICVQQczHsBddna9tXwmi9uphL8mgEPVK3WWc1vqxBxg
         qo+1CwiVcEzwSSQYPmvprOSA+jvLILJsj6jsOR3OLko2pF3rnVN4Odl3nBraFQA+wnBM
         OF9JQMrFJXb9fya6El18L3/1r+D1Pa4BQSM3yeiNN339WR+2BIr/JbjLQk1Kzk0kG6A6
         waI52ZV4TerzDiOVdeQ5k/am0HzWXu7Vexwz6w79BDoTmShL5Y5Yhba9v2dViT4u9SCR
         WtkjC8XAzsHxfOKxkrDUUI/xTRBAmVCWgxn3YLxQJBkNjjRhNDiJMWeMwIqnR/oqfy9B
         DMWg==
X-Forwarded-Encrypted: i=1; AFNElJ9fbd5soy1VTZBj1f6PFEpTkDKIHDK7M/F4MbGvG4+pyggcYTw5WuqRo6V78bAFTjSc0iIm3+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmk/naQBM+iqqFkYeppScgWFEWLHDAUziLqtYKrxyL9WI+ad6
	IeKV0Hy27KoI/RhMHot7eKEGMaa4dnnqvNpIXleIagFz5zcansdH6hk=
X-Gm-Gg: AfdE7ckIvF9e04HAPJhbH57z1eytatrwdCLhqXOyNwnPRs7roH2yZ2pvHwhd2BZykME
	IftXSy85fudoo5pGwQxKe7PlRQ+I5ES4DPHYs+MjZ8ehudjRGLde0pc729DU/XKsqpxaiVXURQd
	j2QTyyh06KNGbrpzXyfYDsqLgUXMMgDec+NZjFgEp2Gz0aviTfIEZYd0hEipMjf3zUYAZhzgIDG
	Qfn5T5zJ1R/XhIU0fXirVieUDuYOzskC4zRWsmyjmpNo9tcKeQoI4n0tkHru82PjgYw+a+8sMqw
	39g6ImNmbBNkSC2/dxvcBgGRA3ETjiL1Q3g2t4vr7P5h0kuXMqXmVQCP4Gz/ccr3UYoiEP59jbh
	R3xQ6pDExCPmpVdu8qkCiASHELW3P4BcDAmvZwq2Wygpxa3WJjz+VDj5J+hbC10qPdZ1rMb5ngi
	hTZWNhBRLi75r2+TjsTSUwyxHjDVw=
X-Received: by 2002:a05:600c:638e:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4923eea91efmr253997895e9.0.1782152926404;
        Mon, 22 Jun 2026 11:28:46 -0700 (PDT)
Received: from kali (88-170-213-78.subs.proxad.net. [88.170.213.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667882f7sm29067783f8f.21.2026.06.22.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:28:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2] profiling: don't free prof_cpu_mask on init failure
Date: Mon, 22 Jun 2026 18:28:45 -0000
Message-ID: <178215292501.1603617.6905680542049189509@gmail.com>
In-Reply-To: <fb12bd4b-58e0-4d78-a725-7e2d44b6350c@I-love.SAKURA.ne.jp>
References: <20260622000022.3375262-1-tristmd@gmail.com>
 <fb12bd4b-58e0-4d78-a725-7e2d44b6350c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2026/06/22 20:32, Tetsuo Handa wrote:
> Why 22b8ce94708f ? That commit did not add free_cpumask_var().
> Since free_cpumask_var() was removed by 7c51f7bbf057, your patch might want
> explanation about why you choose to only avoid UAF-read for stable kernels
> instead of try to apply 7c51f7bbf057.

Thanks for the review. You're right, the Fixes tag should be
c309b917cab5 ("cpumask: convert kernel/profile.c").

I went with the minimal fix you suggested since 7c51f7bbf057 touches
two files and adds serialization, which felt heavier for a stable
backport.

Would a v3 with the corrected Fixes tag and a note explaining the
choice over 7c51f7bbf057 work, or would you prefer to just Cc stable
on your commit?

Tristan
