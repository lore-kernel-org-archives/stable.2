Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515270;
	b=VeDS0KMMGKi4tbWwngd/U4q7mtYRC2kXByLUr1sQqqt+muhCKJ58VnPgUmK4nztnaa9S
	 Tjq0SIlHVBGKMFsM2ji8ZntwcUBHMnMVXjAaFpOcRS+jsf42MeBxgRqqqjggrFOkvf7Qb
	 wnBQoiZ0YnqF40CzVvoLehbIqE/miwh0lTMvMrX31+vscRfI0UZ4KeE/MMJD87MisHHUu
	 4PgS4XHYX0tzPeWO3WmHAgCSjKcxonepww+XiuLJJ2sGlxqyx35+UQa3tDuLr2n7xR9Ry
	 HwH0lS1LM65m37ws6gUcaih/UphnzgoBwCdqtvFljAJHFNwUDoaRHSg04WftiPBZPAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sqzRA9UrTkSrnhG0afFV62l+ePZ4vnCL9ohyTPGZ/WA=;
	b=b8c7nHC3tygYJJqZZUYTyR2ugR5L/HSuOK88z8Aqdw8wj04L6p7HpuvjhPwZGb+WIvTc
	 XLDb6hA7rtIR8XhNG64eLN0jtMoklTf0TjEW8f03pZddYoVDrdgjkTWh5JJvxSIOB1IY/
	 PkmZbzCnz6ANliIk0gGGdctKhHP2b5UXDt8NKnnh5Zwyq+L5jflX2Ruu33pJ10a89GMiy
	 CQlopZ/2iz5EbRH3x/SidnTuy0D5To8iVlqzyaFkNJ8dEtiJWf9yBs+oSMl7cmlZkYh1q
	 kvsNEO+iHbP6xnhbo0C00qGgoumeffaPL+W5D/LYfGPyQcQQYzueNemY902ZD5rRj3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FSXY6HrW;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF36606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF36606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FSXY6HrW
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eab93a9862so93663e0c.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515269; x=1795120069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sqzRA9UrTkSrnhG0afFV62l+ePZ4vnCL9ohyTPGZ/WA=;
        b=FSXY6HrWohav0xzx4hrdId11gMGlVIU6liGz3RGbsAhmAcNXDFu8lnG5WTM9O44qGM
         eD0cmTPlZsKG9NPyYgOvMYMNM4JAQYGdl+YvxzAiNmM9hAaLa9V6Q29clS98xl5BQ+xj
         qi5rIDGPi2Xcdu+WpFwQgBLFgF+HTRRdHDYIC2WC/L1U/5axruhO5xu0XDZnT5fksT9y
         SrHXB8JwuZj2zN8A6Joxqp7ick0aV4ARCpGO+H5osp5kX4dztAfO/UPwCrU/YbhcQb8e
         ZfBB6+fjB8Co7knW/Wr2fN3RA04egkjhu4veS/V7ewnpO3rez8Cw4+3pqBgwGwrlZCtv
         TvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515269; x=1795120069;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqzRA9UrTkSrnhG0afFV62l+ePZ4vnCL9ohyTPGZ/WA=;
        b=pF0OakyM5chTh2nS0qRnMb9uyJBXT6tfqmqdIT8gIKQZx0FaBxEzQgMYiMbDR6ZCbs
         3F3LKGTWJx7q1b+QPWSvKkrpDh95or51rb3XsiBZY22VONTDtEQMGxSG8ihhaCAhbjC1
         UIkHwtRy2EvxVqlkjypjCEGZp0LZorRsAWj1HxTwO1ryjJOg2rhaSpYTShsw3pQae48n
         IouZaWFspQ+avX8YbOQtKZasi+W6WmaujtXr78pStN2wQIR0gHBMM/A+jxofUES7AO36
         rMYWIiJsaSayMUqgjTinrNzz+UV5Lpx+jcaef4Nhpc4QxUiqTq3KA2fnOjDP9tAgaTvI
         NrEQ==
X-Forwarded-Encrypted: i=1; AL+hErHg8h0o1/RUzBh2/pXHdWeY+01Dp9SPq4KOjJRP/ru8kNBQk4V8aVd0Tpb90GsBcEZidWztDYo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EY/wxQ6YUAmIOIQy7iNSgZqm1JT2dqCr15tHVxE8rV7XzNszn
	7fHZBuynRplMJYAPJYAemDhVdfimBRrdSepQEkvp3hBd9Cwqhw4eXdPa
X-Gm-Gg: AYBFou02fxNTlJ7grkV/KkuFKhQSj8+5NV93wfv7zBsXNCELG0ryTiXHwnet2e/IpXh
	yT7dF9tgYQ1bdoGSP+J9GvJmSSXglaZWFTgZWr4YWYgdT5qc7KKR5ooOTdrbL6xd9EeOAD859cL
	YAxkclaoPJWlqoLoYRffzcdoxX3azaCK6uxeAC9dtytLn4eVRe1C6eCZXZSz8p7xUi1mbUDx15y
	IezmXsCKSinECRYwAS4wlnBwt93GwRv64fCiv6BqvQZaYIDQGCfHwrmxElrEFV5y4XcIDtaORpn
	FLQO2tqWxbL8D1H1oT1KU+kPVfS95ADNkJj4sCKjY06SG7li8Xxtg00ikFfe7IHbuM8GDOpgFJo
	mMy87ERBfo1THXTjuNdEXw2Med3DxvjA2bnSxj32Uqb8fF1pn0qEt14KfF53Z/j0raKvdhn3FzG
	SvUyEsGN7ieaItjve0lZJ6e28sJhpLSWwVJs+mCzvzF6IG6cNXoprOv1y6sExsUn8R2BfOMnoum
	5oDDoJ0VwSuReLM+XPQNPW/P5J5/KMhccFOY/7HJmO/c0YIh3ulAzhwm0a/6UpqnBi6sQMAGV6n
	sXSxXf24dA4hIiF8zmwipKnvpsbqYgU5HNejNew7EEZ0tWxj40yFc7Ms9+abZ43FMcIMtEN/U01
	MAubKeOWIpOhmHa8tkb2aPfda+cY36l73Sc/ajUqQftOAqlhkx+Hc0y2DWX9Qymjg
X-Received: by 2002:a05:6122:249a:b0:5ea:c727:11fa with SMTP id 71dfb90a1353d-5ee344ed328mr127187e0c.0.1794515269435;
        Thu, 12 Nov 2026 12:27:49 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c779474ecsm367275241.2.2026.11.12.12.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:27:48 -0800 (PST)
Date: Thu, 12 Nov 2026 15:27:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 steffen.klassert@secunet.com, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org, 
 Hassan Sultan <hassansultan@google.com>
Message-ID: <willemdebruijn.kernel.bc632ebec32d@gmail.com>
In-Reply-To: <20261112111619.14ff70e1@kernel.org>
References: <20261111221129.829218-1-willemdebruijn.kernel@gmail.com>
 <20261112111619.14ff70e1@kernel.org>
Subject: Re: [PATCH net] net: gso: fall back to skb_segment when fraglist
 cannot satisfy checksum
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 11 Nov 2026 17:10:33 -0500 Willem de Bruijn wrote:
> > skb_segment_list() keeps the original transport headers and checksum
> > state of its frag_list members. It ignores the checksum bits in features
> > and does not initialize the SKB_GSO_CB() checksum state. This breaks in
> > two cases:
> 
> Does not apply?

Will rebase in v2.
