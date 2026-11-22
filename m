Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795331336;
	b=3LSAOz0HI0o4JFS2iruffIHbLQ5Y4BnGpv5IxQZqVsQP1Xgg4AD+2rWUVE1q6EM0FFLA
	 5WVckQ/Kj9hsH9/AcmG1Ygeuw1go75JX3uSeJBOFnK2ub4djdP8DlHqdt7yFUObpO5XSS
	 a5Wb5widUALhtSl81lizbPlJNw+6g3ADUF2/U+sjjxEizqUAY9NmsMsubE44vw8AblFnD
	 Rsqidg0LQQs/7d2poaCCzz9ksKDsU1uzmnXX5mz7Qo20vNudKXXsGBtMp8xbOkJiRa/Z9
	 /9cLkCAnXFRViNVjS8Nsi+kpQ6c1G9kQk5xTCflJosgNdrj2nCy6GKK54tiE5Wa5fpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795331336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=a99BfP2kEbISB20mRXBJCu27gZNr5+UqvH+W0E0W/KU=;
	b=Em9AZK+BH6vaPzAofTtABIAn4Gvp8jmpChRyL7wMWD0Nnm8GfKAmY1Xml9+LDO5V+xc8
	 uOgHX9QePIRF6mQNqJYSolUhQLzzORqv7NgHdL7hBegLQyAXYL/88rqsHt7LMQOhaVckW
	 x3JcKf5gLlxTc5wQzhmB75P3OAjQ2sXvmdQ+W/iI4NQBIT0SWeHqdw+vRlA9rewGd19uo
	 Q2bYV5XQuHaBS07ExcT5prtF8wQP+oCm5X5PB+k3pld6lRHCjXVxwGpEz8zBAeI+0G1GM
	 X0x87z/D/h1ZJcP4Vud/8IJTDvqWmCJqNeMSwx/97vzf+r7b//2lME/Gy7IQ3EfQGYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=V+4aedvw;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE8606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FBE8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=V+4aedvw
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55d2b4a99d4so25424561cf.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 23:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795331335; x=1795936135; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a99BfP2kEbISB20mRXBJCu27gZNr5+UqvH+W0E0W/KU=;
        b=V+4aedvwNCn+7sHkfORGQNrevZch/Nwg8GWvxBqRxo7l4mVtIjQXPFsHAM+fp4jQv1
         /m7yzGGYoL39gZxbBrIXTNOOu3s/WlDaQm+KTaP5k/3Olc7zNtQZuxumQqT6HrT+D+d6
         P4XX5FYra6wgt+RI1Q2OoMgSHhqCtLh9UA1HxJfIACfcTxh3s2amdkWe+fKtDDZcqJRd
         uQILVG5sWzO+YHEMJxaTxsVYOmG0IFA2ehUetCI7xS+9P4K4jzkbfcfIBh7pOR7FS4n6
         Z05GUleDDPTZ7EfGx/rPWvobhxcyH76LhPRa6fj2LffXJrS8/U2F38BWsKA/N2FjbCVy
         dumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795331335; x=1795936135;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a99BfP2kEbISB20mRXBJCu27gZNr5+UqvH+W0E0W/KU=;
        b=HCxIeVzWdxRI7JIOD8lOyWQIvjqt81zSLsISqUC1wEEzyXdeewq9onk/KmLFK5DOVW
         654uLCPxbg6c4vGZtc4Ly8+JcBMMJQM52Ldx4XfgquijQHi+8lkBO5SvRKeRlT4rAbDN
         nP3s2xVMaRN1sxcxwvIP1svSEP7xrVny5W8tI/uaQGfYMsUWhszsJziapfpUXopBwOOP
         3dpuqS9e0r03f9QqOZ5EJxMUClL4dRVJnpJiVFoIS3L2ibFAsj714vf+0+yLYIZgfMa/
         CqsOMR2uj9SiHLxe99c+87TkBE+iNDKj6K/2EqD9gxJXSHzcohOAOLkz5VM2GnzDAWlE
         e2ZA==
X-Forwarded-Encrypted: i=1; AL+hErEKqKI/v9BxophqJUmWzcu8a1pCdri0C22HJnCmkHfH2Z8/gCM1IZzFk0xdmqvB3bQf5AhBkd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Zn1/0/jS7fc9U+EG9MFu/g+nExhx45de47EbsRbWx8emy7r0b
	PVB6qK67TqbZ9GWJFHaWR3+Nka/xZSozESdnPafEArom6isdTsvOZQftvgDYHQdrWgU=
X-Gm-Gg: AZFdTZcvyHIamBnRjoaNtteqm8U3jsgu0WSmYCNQ/xxli8ROj2og9sNDMphS5CX1oK8
	Swf5Z/kcjdv0Y9pusFKl2kir5/THa2zH5L2ckpAhwoZmHCicXvW4nmZ2YQwfdKUKD9yMbSgD0ED
	fLjgQ3vRXHxr9RlDspH5jK2qXmBN/Y3nESUS3aA5q+rm3LqHG7AYxW3rMCMaSvTgogfodhQpjzJ
	Ew3DqA1NGNfCydKfU5Ra2DSYgZQT9BRjsOBOJXMRUtUjs9df7o4YPnyfs5bYY+mVqMveRtSNyfR
	bkKxVdM1NG+nrCxRbqfn5y2xMS3/c9FFNPOgrBT0XDPCNGbzmKTOc9wn65VvRjgh/meT3sE/FKl
	Kmp9bbOC5Tzpm7VZUgxelk3lI/gft8wStnV3PWVUhO+kE2datgcHo3jRIXHQblXqaXTWB/Q0xdF
	xwdpqTvpYq44ti4xj7nYIHQ25UJTI0vrXa1lepJU6xv1vxq8SH8j257W+Q+rul5OE6lDebJHO2E
	mmBr6L0+OVWw02gZMabCzSjeYYvPMa+e1PDSZI0UEKIrVhhfx2o0C1SQ4JUcvfEYwqrv7fDdp5H
	Jq5pXcEtBFqIBo+WTkjfd8BWI50rM9+0oplRczpVAYyVHNrS79KvAnogT/UvBLg+BfG+jrwMGVu
	lJ6Y93gk=
X-Received: by 2002:a05:622a:138d:b0:536:702c:f8e4 with SMTP id d75a77b69052e-55d76a75253mr152041481cf.49.1795331335422;
        Sat, 21 Nov 2026 23:08:55 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7888fb27sm66124541cf.25.2026.11.21.23.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:08:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] [v3] mm/mempolicy: replace copy_nodes_to_user()
 interface with put_nodes()
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 larips <larips950@gmail.com>, stable@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
In-Reply-To: <20261120185248.823415-2-arnd@kernel.org>
References: <20261120185248.823415-1-arnd@kernel.org>
 <20261120185248.823415-2-arnd@kernel.org>
Date: Sun, 22 Nov 2026 02:08:54 -0500
Message-Id: <179533133443.412063.14905382167508572303.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-20 19:52 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The get_nodes() function handles copying node masks from userspace,
> while copy_nodes_to_user() copies the same masks to userspace, but
> with a different argument order and slightly different meaning of the
> same variables.
> 
> To make that less confusing, change copy_nodes_to_user() to look more
> like get_nodes(), using similar name and arguments as well as adjusting
> the maxnode value once, and restructure it for readability.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

