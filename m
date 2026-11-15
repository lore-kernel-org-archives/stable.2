Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794785059;
	b=G46IWrG2yjCQELWnH0GrDE4y6OwHvr16LfmiHbC/y5uwtExbdQ7SmxiK8JlYs+uxGArD
	 D3YpqDgQgGOGk+4m4fumeNwe3wol3UoANPJWxRYSJtonhMjGnERavjDBdtE/s1kQoR32d
	 teYFCtTP5PAstZHaRF1WMIIrEOUTfxtxi8NEY82aUfLcYImNK5gDZFWLy7Fzf92dUtPST
	 Gx5S2uDze1u3XuvgMTUsaD4xI/biOWedU1aTXXhcs1LZtIZsiCCBa2PO4hY9++vIm48Gp
	 6x9kbEJwOMtIQorVFVwjwWBhS0oqIZC+v1XCx55H01ulYVTAuqQLfbFDYpV2fSjxUWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+/Z4L9oHVW0yiRbluEN2fpODjMHQCBt/wYZxCW702Rw=;
	b=F62OphSFbD+tkW3KYSNS42jcEhqU3EWXqqZuvXVBtRzzJXM+iJI/ShC4gZcOlb+Pwl4y
	 JoVaNtdFGBm8gkYhW/9XdXqTLlCaE3wiBLULZx1hSo2nKhbSRYyEUVgOF5KIgIq/FRTig
	 VyoomesI/F7rDG/HgcObi7s9XHPUTdax3Tc3VurQNShuXwgoIFc6ZmPjeEb9kEbgNGq+h
	 lpygKOK0XWoL6bPsYUukHlZSTxS4SbPmy0cYBYCwi08NMQ9LijSQzh4cBn/FLtM+9ssiB
	 WduPaVfPHxkmSkT7eqIckS1PSbyKXNI/Vcj3FQJykiVRcm1s0MfAfDMyEtC4yPfSb0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=k-tech.co.jp;
	spf=pass smtp.mailfrom=k-tech.co.jp;
	dkim=pass header.d=k-tech.co.jp header.i=@k-tech.co.jp header.a=rsa-sha256 header.s=google header.b=R4Xmh2mw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA5606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9EA5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=k-tech.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=k-tech.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=k-tech.co.jp header.i=@k-tech.co.jp header.a=rsa-sha256 header.s=google header.b=R4Xmh2mw
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c1479a959aso2287513e87.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794785057; cv=none;
        d=google.com; s=arc-20260327;
        b=TnIhfPypmt89zMF0Lc6Z0VW9Hnwd1MB92mfV2zlYYuyHvIGWutaXJl2RHIomKj6u0M
         Cxv8QCP8F+PDoXziSU4WhP+bgtk/SCWYN5sSALtKgxGZvQmWBRbGQJxHOKKg1MTjiZbq
         vddoJMmIwNCPyzRHBzpNnwL0vRObjZ/monQzLqnxNB5WR2JnnkX7e91QQVIlLerAnFxr
         Bo+DBR1FtvDl2C7CIOd5hSLIwJ7mUqFuABZJS9kJlXTC34NLPTEHcLG61Ko0wO9k+EQV
         raP2VkL53yV7ghzKd4xux1hRqfoYbJ50fWMCxRQEdY9J9yK3kBP2QfCOrtHGKwhPeaCq
         HOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+/Z4L9oHVW0yiRbluEN2fpODjMHQCBt/wYZxCW702Rw=;
        fh=F4ULNILDT0OzN44xjbcwxDj117yuJZ5G7w2muzWYpqw=;
        b=UenYtoLUAHj+cka2lsU+1KHmubF4DoaXOsMzFeMPzP4OHzM19ZC7kfpusaOMZqzHCW
         TGGU84Y85Pg30pySwteXied6JaDYfeU4qXgHlfLbC8XOTfbd+LkFqMjByOj0g/RwxaAW
         k3MsyyNiXcFC++W+qL4ie9yzB1Zv4ULS1J27anLOiN0sluk4cQSBRXYGzKcnH/NTxRJM
         w58WDtU/1IHOIwupuhfXMQeOoX7bwOgbk34Ic3Wk0gHQfkFVVrWZtPHvb7bOazbp+9WO
         65AhJnA/jgF0QOVoFszP+ndxJWrQlUIXUgfhzxOcrZMwgN1OMciThA7BVATIqYLTe2CF
         8wbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=k-tech.co.jp; s=google; t=1794785057; x=1795389857; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/Z4L9oHVW0yiRbluEN2fpODjMHQCBt/wYZxCW702Rw=;
        b=R4Xmh2mwXLsPCOaJD8TW7ya7EtAVRGAaQIG5L3wZG7XdQW+qhsrN5zBWRhdhBktZne
         awo7HfP9rtfuGqN0RtshAvP5AAVtSRFPbN4OxYTAVrIWiIiXPHFCtgU+wN8/4pobBYUM
         nFyIfIYy4AJ8VbkbedE3IhZyc3WL8mdyP2u6r6w21KfHMJpKJk/5qMWeFV9EcQfCoMeM
         VwzEa4ZE72D4dbYkoDRjPqVr+izUivDRp0TueTZOZUetXUMJYpDdeieFfzOZ9U/qBM/h
         Q9GA3i/zmbvw1E6xwQMDQ6jtGzub270bUq5urqk3w9aEbCaOZLIrtX+L2R3i2q0eAlYc
         HuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794785057; x=1795389857;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+/Z4L9oHVW0yiRbluEN2fpODjMHQCBt/wYZxCW702Rw=;
        b=ZRABZn3SX29svIDmYxSDiCINuNB38bxunkmOaMyBCEewveDexYG15RqMEWJRdL+neZ
         /Uwn3CRyhiNG2Xhh/d7rKHeUYdUgXIW6DPVSUPRRte+DIHkRb2VN89Pw6BuUncy8izag
         Z62HjufIJV+9vteVR78y9usyMb/aDu5QcfSSaBReIM5yXAzV8nABwoGfxbGR5TBrj6/Q
         /Khxg3L4CfHBwiA3T8PdXXX8q/1Qp9yMI43chLLKllN3d0HK4b7htBE/YlUxjB4sSLMI
         orZCAtW0OmcnvVtIYgOWEXp0SV1aYdUnMEvyduwRoHU+TgHFIiyw6vNbW31RzroeAnHF
         0Tag==
X-Forwarded-Encrypted: i=1; AL+hErGLPnpUr3bTZ5zqtLNkcuix0H1ZuBAFMQYQjpOlRe+xFZVC5OvQlnteevJyt9ftnB7/1Uycniw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xJ2OR78YVP27WL8vgJzavtjlSKYpAF0LKMxYyGZn5wsn+vC87
	sr1tZoc91NFv84WHBj+GcIUvZFqzHTphLDC7LqQ+9lFbuG/rlTG/HJi3ub/4lw+HJy4b0PVgMa4
	3jCUbsK/xZruk3J82nyltO7Yv/q88/KdOIgPLoLXSoA==
X-Gm-Gg: AYBFou3vs+Xbsoe8Hua0ep8ZSUJQGfqu8hVCmhG5gADBXaYTxxN2ZlzRm3FArdJD8FI
	DTpYI0LO83LZu5UyufMjdpopqmFRUCcXLQjhb75WCS4KuWrRCi3qCEjYFBg7eOfdCfjcfeF7r1l
	k8olaBWunPmGt7vI/StCs3jyKEQky9Zdyhl8qum6dfaBcNngjbfCZTk12GWuE7DbiDtm/hlnpKE
	vnGwvL9Eg2ajfOfwpjqZjkToI+BwGvGXK6/nhpTv/tneJFOlXhnv+3OC1Rjkvr2a57cPka89AqF
	e6M93MBM7G50m/VmkftLZmP2LzPGzeV3uyyRG5uecrxAvt//qmaSyeQu+nEDuyNA5p5ngSI01NH
	y+SbCyJYQLq/Cz6loS+MB/Ks54CrBgzB0QDtmYsc9g8n5lkmWY4h2+SQxCQQfdS/piCE=
X-Received: by 2002:a05:6512:3c8d:b0:5c0:bca:77cd with SMTP id
 2adb3069b0e04-5c1709e0f4bmr3285081e87.42.1794785056172; Sun, 15 Nov 2026
 15:24:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113033833.124797-1-goto@k-tech.co.jp> <avb1CyLqJGI_MtXv@gmail.com>
In-Reply-To: <avb1CyLqJGI_MtXv@gmail.com>
From: Yuichiro Goto <goto@k-tech.co.jp>
Date: Mon, 16 Nov 2026 08:24:02 +0900
X-Gm-Features: AclHuK9TcUvv-xb8BW0WisisJi7QnpM6fvoiPZapBIoaiw0rO_faqX91PXWLlCk
Message-ID: <CAFn2DuFZFtgsjD-TTrK5x-C43sE328Pi5hoxOCvzcKoM0DpWCQ@mail.gmail.com>
Subject: Re: [PATCH] configfs: wait for pending RCU callbacks on module exit
To: Breno Leitao <leitao@debian.org>
Cc: a.hindborg@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Breno,

On Fri, Nov 13, 2026 at 8:33 PM Breno Leitao <leitao@debian.org> wrote:
> Is this still the case on mainline? Since commit 3bc999d944b3 ("mm/slab:
> introduce kfree_rcu_nolock()") in v7.3, kmem_cache_destroy() calls
> rcu_barrier() unconditionally, and configfs_exit() already reaches it:
>
> configfs_exit()
>         kmem_cache_destroy(configfs_dir_cachep)
>                 kvfree_rcu_barrier_on_cache()
>                         rcu_barrier()
>
> so the pending configfs_free_inode() calls finish before configfs_exit()
> returns.

You are right, thanks for pointing it out. I reproduced the oops on
v6.18.63, which does not have 3bc999d944b3. With that commit,
configfs_exit() already waits for the pending callbacks in
kmem_cache_destroy(), and I confirmed that v7.3-rc2 with
CONFIG_RCU_LAZY=y no longer oopses with the same commands.

So please drop this patch for mainline.

3bc999d944b3 is not a fix and is unlikely to be backported, so the
stable trees that contain e9c03af21cc7 are still affected. I would like
to send the explicit rcu_barrier() to stable instead, referring to
3bc999d944b3 as the upstream equivalent. Does that sound reasonable?

Kind regards,
Yuichiro Goto
