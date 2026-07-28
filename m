Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFD44E021
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270340; cv=none; b=q0xycbEG6Vj+/7+EqY3dAzIJm+geCuQtWBQx5doeEc711f/kWoluBC+MikCwv2X5XgPnOb3gKSiIu1M8hAML+sPeqW/zdkUnIg5Ex7jLvRNeOcSbnX5NsGx2qdszzfW65GfETe8DQjqwNcm7uSVfmBC80srA5XgiaSUJBMQaTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270340; c=relaxed/simple;
	bh=p6zmJ1zu1+RL0MiiP/4UYl0hFtaw1+qbOgAeR31gc6k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qgUbU3inNa8zuLwHAjLhed/BEB2piGoMr1HDiq1G9cpeDTGFVZ13aYkjuevD9kta2DwKbBmY8m4kAfOm7Snr9CtK2gZl5e7vPkjxHQyGzFfYPryzbhyU17She3UjpPJxTgKixIB2IDvbWJCnJZPyYx3lL7F1/U4H4xnvhpSjMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl5cX33H; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl5cX33H"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81f36179dd5so4610917b3.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785270338; x=1785875138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jztAXRFwasloX8cNXV5kk0XS+9iLdyAy7im/Gre2hoU=;
        b=Jl5cX33HPIHdwPxeSrlFpNXrxsNgYz9smxmaBL70xWjjgT+yNd13O/FmTTPRayc4Gh
         IrVhViUliKny4KCIJxdapXA+Mewh0HorQsvWzvZ1jCtTkcOrjITPIh71olVdAuwJEUtm
         8q/RNjtXVP8yPH1U8SX21RBMNm7Px8Vkfw2eQHkvIW9521nhFbrLLcm17CAePvdslIyj
         0eIjpCZpKHogjiwq81zUx7qBPQJ3EHIN3C+OTR2K+XZd8XnONtNCA28hWSnCbUtfuP97
         RPgk3IjSM+UBOlVuobIWzEBDp+QWziluWTr9iXiT6gnNY6rze304vfoD8E1LTQ56P8Wj
         vlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270338; x=1785875138;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jztAXRFwasloX8cNXV5kk0XS+9iLdyAy7im/Gre2hoU=;
        b=l1vKTfSVR4wk2Oq81sBnUPN3djbkXI5iE93+I2rFaxy7Eu6C6HGytM7MU8yMSdcG8U
         2fMOl2GCeV8aZ8gLjjtZ6wKFhZoAbvLPdSU4E91VPKatK46n0eadeC4LsKn+AqOxPE14
         Uir3g0ZIMlvGphQ42YZ0fnJAi/c4w/vuAoiywXKLIhWKgqp93g+OnxdXuscTzIjLNeZG
         AgD2hjBCoRLkdiVL3kkT7bJcHuDFKn0NbWQ83bQd8xEVftTaw+z8nIGoSrLS4JjWfX+S
         wp/LkAfeGCOKHKVXivufC9ow+ylruVFEN5DGHL29YHB768m0E6K33YF8Xha2u3xaiLAg
         8UDw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2qOVxPK+DjT7W79UGQ8PLLoKdL6xbiDbvP7B2Fg4ut071HRaoaymvU2HGE1sei1G4P7Jb2V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjC9t9GnMZuf0rRym2Mn9pvc7EvGJNvjQqvdPiM+U1NTa7Fmcx
	LpsVQnZyE6HJJDd+QWKlzHCgLlPlqPESGmm+9Cv2ncMIiwzstJuqz7AA
X-Gm-Gg: AR+sD12zvO7RNQJECF+PlUQSu4Vjwyow2c9o/wBB/gmCo1dMfz1bO9WCKin1CXHEkGH
	6Vva/8QElj26CarLrSFV7HGD8mHAKNR+SlF4CcTdln0qm8hrIvAlTiAHKhM3+zAvEo8WH85EeUI
	WlXNoVTrklFCRe3cRIdLwdKmq3xpzNdC6gN/X46s/xMTahR3bn4Xpy0om7djpN7DwwYUkqoNUXS
	XuzpPwp6pEK3F5EWQvqRBDfyQmxk+wzXOk7YRVDTdScicx6A9hTmmrGIOuDshrS1/V0+coGtFNk
	HhukLhITXbs9od41J7sPGpRGo6UfQ3pIWxdWryAFpq/7i89MJCPolBFsIDiQM8s4HUB8sI8B8HS
	JZfvSS4GzbmvDf0YOYXzJXcXV2I/CeONW0tHE1gg6IBNA92levh+JQ01VDmxv3fWrnuzkbRUeZI
	0+OM10fejb3scbryglp3E2jJuveDJZMPshjClYZnWMK+dd/eBEHA==
X-Received: by 2002:a05:690c:a8f:b0:80c:85e5:8732 with SMTP id 00721157ae682-81f992e339fmr18401707b3.64.1785270338266;
        Tue, 28 Jul 2026 13:25:38 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa25ed2bbsm5648227b3.0.2026.07.28.13.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:25:37 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:25:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 Qihang <q.h.hack.winter@gmail.com>
Message-ID: <willemdebruijn.kernel.2edc77d9c7459@gmail.com>
In-Reply-To: <20260728031345.49562-2-q.h.hack.winter@gmail.com>
References: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
 <20260728031345.49562-1-q.h.hack.winter@gmail.com>
 <20260728031345.49562-2-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net v3 1/2] packet: use consistent hard_header_len in
 non-ring send paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> packet_snd() reads dev->hard_header_len multiple times while allocating
> and constructing an skb. Device reconfiguration can change this value
> concurrently, for example through bonding device type changes.
> 
> For SOCK_RAW, packet_snd() can save a larger value in reserve and later
> allocate headroom using a smaller value. Moving skb->data back by reserve
> then places it before skb->head, and the following copy from userspace can
> attempt an out-of-bounds write.
> 
> packet_sendmsg_spkt() has the same issue because it calculates its
> reservation and header offset from separate reads before dropping the RCU
> read lock to allocate the skb.
> 
> Add LL_RESERVED_SPACE_EX() for callers that already saved a header length.
> Read hard_header_len once in packet_snd() and use it for allocation and
> construction. In packet_sendmsg_spkt(), preserve the allocation-time value
> through the device lookup retry.
> 
> The separate SOCK_DGRAM consistency problem between hard_header_len and
> header_ops->create is not addressed here.
> 
> Fixes: b84bbaf7a6c8 ("packet: in packet_snd start writing at link layer allocation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

New revisions should not be sent as a reply to an existing thread.
