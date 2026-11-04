Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773559;
	b=JymnVNvizS8atJst2EGBQWA+vfLKI98YUa5tb4TjgNAU5/dzkAgZ4/pFhJyhVBHP0dmC
	 UwZE6EK8dr+q5GdvUSgLM5lAInvOB9GZrQoJlt1zDGLVRfcXP88Xq8pozgELGHPqBhn7I
	 vUh74Ljvged8KZNb4zNauVsv8RAKw3ByTuhxDPHynkCo/h4UzH672/RyCQf3JmRI1lulW
	 iqFFoqqV8UGZMQG8popuGTyHKc0ysU+exI1wfj6QZMaD8eTFJJgsz6RyJjojCX11uHrQ+
	 KKHFJQjOLdsOL6EVZ/hA23//XApZPsV+aOyw6KrYsmewi/GydmA1l0iBg8TE7TMFLrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Eed9z5suww4/zRV4jVvjzbO04jNWYIPB5y+W3yGdy9E=;
	b=qCW7G9j4rUhzUUFxU3ioPPUbekewwoWspObef/IsZIDSyQi4atSWTcX4PuNj4y+MBn+f
	 avk8mq9Ac3ytTmGno1MVBzt/uhKqzFbne53TVf8CXkTMMQ4E3RTDIo67+36bS2S86vJYN
	 lHb+IIE4gdBl4u6lUnxLT6b/u/UEfplxkutWUvfZ4KcpvHHzXsJjLW80XjR+erPpV8DIC
	 q9hJrw4M6n9H4aWTqxwUkMXsuj7/P/b6XYYZLL4hoe9xNLgrcCB0v/pU9GNX6sHCvjlhW
	 i8UiQPhP6GDm3CEzkDOjGOJft80nU4uFT/NY0Fe1Ry9bsu7OAxmo1BwbrA0Q8lx/zdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=UM4QTsp+;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641C606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C641C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=UM4QTsp+
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so274755a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793773558; x=1794378358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eed9z5suww4/zRV4jVvjzbO04jNWYIPB5y+W3yGdy9E=;
        b=UM4QTsp+PqpxBSBnGqCzNhSX3eLBiKNzmrQYPknx4q2n0jGhih7gClXbRIzKaj1Tyl
         b2Druavk7Sm7f9O5NktMHL0U7eOtBcRv2rkls8rBpmfL55JVLpT4sEgGw5GDMTRcMNVE
         dzX8ZP57XnfnaPvxoh6ZPTZxMoClmZSaGi5i+ANPUmFLTgNkVDXcJ1tsaoFYESnIpTn1
         Zf/1DUI22oiGY5T5c3Ks6BgVnnWSJ2L3SHgF/PRxOLZDOP6M8KX6ynX4tKw/CBrTU98l
         yiw9ILmlTGooTjid//JulEprh/ZCbowjDfZWhNPwzgK0SCAMA4FpgZ0WhalKRDPENsjt
         hnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773558; x=1794378358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eed9z5suww4/zRV4jVvjzbO04jNWYIPB5y+W3yGdy9E=;
        b=uG7ons1BqJ6eLn/N9ohSIpd0TA+yOnOfn4tkrvbPLATZAb92N+IhjwLnTAv5TKjeIa
         mxRUWK9ZkVJaWb9ZMwXPtewHvcTnub/QLuDjlSjjiGYUdmu78b0CKfEu271fizJ+j0N6
         kh7viAJu2v43bAais5zgFb3jIluflhGQ5cYrxamfB2z9HL1KlcZ94zFzcV92DdoxvsYw
         kGYeBrfVLLdTLHKOH14TLKTFIjeJ++1dGREE7DSVex+Tbv1R3z/r7A+gFv7CqR9l+G53
         Dpsnqs81T3GT85Y0JdFJjNW2hulLds9H6+YsbsYkIABOZYrABS2jqzcjYOr7dyqTZh/c
         vP3w==
X-Forwarded-Encrypted: i=1; AKwUvBx/D/7l6FPsDL/yk0V8p3ga+5/gi1f8z2+yM3QmQbJ9fZDepU4pNY2yfozgRVAi8s9Ig/5nv+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zQyzzlqWr/n+FuGYr+SwgEtx2rnK7Nr88pGUGCS9abqRqZf8N
	ycUTbWBgbFCDJEBRnPowBgB+Dz0h9J8NbUbksiVrYXtI8e/Oo8My39UrManA2wJdRvc=
X-Gm-Gg: AYBFou2dZ3Tk2+p5taMzkW32+WKmWr4HRvvxAiId0pjoPNQ7GTSW/d8Uj0kV0+B7e9s
	jurx9f+qnxVEB+MabYSElUI4GB2TKBbP4kjfkDTtg++MCPZhZoxgUwhqu5QBbaCFM4Qk43VavGV
	Eb2PdN8dfI/AXQ1fxUAiWmaRyfv80Gt3Hqq88w+d5mMdUsUhgj842I9u0ckcfzOSqLu+SXkYyg5
	qHolL2MNYI2HLg3kdeaJ8PL0hT7i9XOAluQbgMVFqTmoOz+Cu1C45MzTVaCSg0sS5N/BLQGWxoU
	0qJEe5iVEva/WoRlCVPg0DUdz/Tl6wDA/Di4URnupkY+wdMTAfcmEphy+sB6WCveS+Kj6gRY4l/
	TRF740hmrU/7NbC7E2ja8mS7aa5rNHMCeSU1hFS5WvSVHtKf7Cv/1CTdn0SzfGCoT7WWXy4yNv9
	lcPVAaJwnAOqGyplytd2Q6PS7jDdVmQY0GNThtNdblmY5hdaPnyANqfHkb8u+iINGHJRv19D5bx
	XXUefzhUB1Uf8XKZcOHG8pJ2OcGij4dZyKWy62/2c+WxGWV8osUDazy28XaVOpB2qg8UJzhFr0a
	4x5QzIy9JNh2SA6aW1MmX6gyaG0yPG4fUIjBDQ==
X-Received: by 2002:a17:90a:c886:b0:3ac:80dc:f407 with SMTP id 98e67ed59e1d1-3ae89865dcfmr11962403a91.60.1793773558155;
        Tue, 03 Nov 2026 22:25:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([61.251.99.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093c499a5sm2672357a91.2.2026.11.03.22.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:25:57 -0800 (PST)
Date: Wed, 4 Nov 2026 01:25:24 -0500
From: Gregory Price <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, kasong@tencent.com,
	qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com,
	rientjes@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, muchun.song@linux.dev,
	osalvador@suse.de, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	ying.huang@linux.alibaba.com, brendan.jackman@linux.dev,
	hannes@cmpxchg.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, Bessel.Wang@huawei.com,
	jiang.liu@huawei.com, mgorman@techsingularity.net,
	anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 07/12] mm/mmzone: read each zoneref slot once when
 filtering by nodemask
Message-ID: <aurP1MUp8HhhjV75@gourry-fedora-PF4VCD3F>
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-8-gourry@gourry.net>
 <DML8OO28WT5O.3U6NG100XWKZP@nvidia.com>
 <a5270059-e5a7-4c8a-9f04-96135f79ea72@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5270059-e5a7-4c8a-9f04-96135f79ea72@kernel.org>

On Tue, Nov 03, 2026 at 04:00:45PM +0100, Vlastimil Babka (SUSE) wrote:
> > 
> > It is better to spell out the rename from zref_in_nodemask() to
> > zone_in_nodemask().
> 
> Added:
> 
> To achieve that, rename zref_in_nodemask() to zone_in_nodemask() and
> pass a zone instead of zoneref pointer.
>

ack.  Assuming you don't need me to respin just for that.

~Gregory
