Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367913;
	b=FWNB69zcwFX5W8HD5xmRuc9jZXu0zNwMjZSbsIVkdrPSgiHNuEvz2MvH0i/kF466EtCT
	 F2iX0ZEl/lvfu9DzEUnxlGRAql12unLJQMRHtjb+fS6WqlM9gaMv/m03aFbi7Dp4dfrMW
	 fQOBTd8tpyI5+jZ+fGJoT6K3NSmN8n4JQi5O/11kBkdHyc96FcoWTdFb8NHkePz0JuOeJ
	 /ijD8h5UP7CKsuODZU9jYLgWzxTH1IDO1+hyKjzXBDw85vonterHTylCWELkuPvcKQ+SA
	 nn+6P55jlHf9ahS9L6xPa1NiJ+slsce1gdwCslGbLVRUFMFy1L9a7G15zH0jHgVzWug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=78iLp+ukyIH3Bqo6jdwjTQqg9ybQFd9VxizK2IPYkLQ=;
	b=rNCQcy81CHXuOYTdYLCcApaV8VMsLSmM6om/D+mpwN0k0EOH5baK/AxlD2Vw25J87LxT
	 71PGzcD/xpnrCvkeA/vOinfWc/pqFdsheGcN9m38CFJj6NyFna9FyHgv4pPMAsCDOtiF1
	 Gv14Xmnp0HUlQL9D0RYIynL5Ue3SZ4pQvcm+bFDR/FqS/fen1hxupwn3FSLDxhvO+DcB5
	 8QJjAaVwup2HeWCUB9E9hxpG+4KdXF5CmcisZUZGeo4NB4g2l7BDGxKJhmZe4P3QVPgZj
	 y9A3lUlAoXE0VrxlZjpOk7OKPQVXjoSPcaL5/59GjMTAxwh/jNsYvFHGLVtJRnBhKHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MSEwHngh;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FA606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 17:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D9FA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MSEwHngh
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f0481b35c9so12750545ad.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795367912; x=1795972712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=78iLp+ukyIH3Bqo6jdwjTQqg9ybQFd9VxizK2IPYkLQ=;
        b=MSEwHnghHFpvG/H9NvyBLNcSG8oKpaTq8hFGjcbk45OKxp7HM52R6ckrAw/Q/A7gGx
         xHgWbgp6sLH23mTJmJwkBVHRXwgTJV95FigsUnpApXdZaqauZJfdZGt2cDkc3zpquCw+
         bE74Mp/xYKn5jeOU0Os9Bx4CmTm2Az6CLgl915HHUkDpUpTPESCFkKVKLLU24bi29sr4
         gnVxtBpSKoN8zR9F4EUzHSYofP3ITSLuXKPHFztugHXkr6sQe4jVhtxC19Pqpg2D87y9
         XPrlZwJafq+RfLxT1uWctWAvNka/48LMeP/QkJVXiqK/sY3z+bJiSh05GF3CuxEhtayN
         xC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795367912; x=1795972712;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78iLp+ukyIH3Bqo6jdwjTQqg9ybQFd9VxizK2IPYkLQ=;
        b=MEzkf2OAVmk+UqxCjklCoCCIscM8sVshfWyq821KNzRSido7t9CwoH2plZBX8lwQ4M
         SUqyjarDuLi5KCdtlpWfY0+wJNUp+wHJRQ3ZqAbZn5nR/zulWDq+8dkOHrlDINcueDb5
         ZZ6pXzK/yUfrnYU06YWQy7ax0W8HoLDdjjTHTdIRCB7/XZutoBK6Ke79Pdp0UhHvXj2G
         fAp6VWCPS62pSvMFql5/dxDyPPisPeQQaQBB25p7UXEVm0KoylvFn191jimIJoTOAMdv
         0GHs3uZtGF+bloXtRVG1WZV67lydOw0Isq2FksxRQIvWstdIHzOqEvDwGwlvhxJkl3yl
         cEsw==
X-Forwarded-Encrypted: i=1; AL+hErE2bim2McLz5d+ehYbFNOBFpTeEEgG5tsMOiOH37FWXIecEPvOlyigV7cUN+iGK7NTKjwLa3MM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZZ64BsgPhwmxqiRgF06ncYktrIk/ASw0/lS4WCtM5jLzhd9T2
	LSY7bkwt0kDr7HHLuzEayuP1iSwXBmrhQ+OuU8Nl515+rpsCxL8w1tjUOk5u/8Bc/YWmbOrwbP3
	90hsekx4=
X-Gm-Gg: AZFdTZc3w9I5JqNFHphK/jjfd0yEE4oqt2/rkZegpNZcjvvLPuPy8CXcOjzdnaX5Ptv
	lX/9wqpbmQ1YQ4gxOnC48Ql4VDHqyjXnnP94Tl0F6cFaxy3cfnggEakIbgzITl0cMrarsSA9loa
	psyJbk4GzYRhq0YJIsnFmTi2e+nVmxAhqChHZMbvByuvfSrZfQ57M322YOd66FDlqSFgm3S3mdM
	JwlhgMs25cJ1i+vU7rsmCjIKy29RggSTMxW8DTANH6l9YgDt0Cs/ahvOrKliBRWscHW5rhdobdA
	O+LdhPSzjkMS6FFnhaaNU5eUgszS0lanyuclDATJJDjo38vBmpUsoNMQ7TdOBagth7RAXEXbnuE
	+0tuX6AZ3EUyCc1skgAvNrtQuhxXj87TOiPeI08LHjIenUmg20002Ijza6JSvPNvTtwmTUf0GC1
	jXiPjNCLR8LkZvUF3IEgiNAcqPTN6KRel+rU7ut0/rxJDxJ6lRndb2VAIQxqLcPWYf+65Iy6dXd
	OfmWKfhssp9jCow9K28yMIoF73boTj1va7qd7VwSqS82lS5Z5InFkVbJuWH9nXA7/HRw0cjO7at
	Ip1qHyhc7yKkwMBqcJSDAR0Vw+ZiJICQg4p6NNGQ9x7H0iJG1JDPRqOr3YEL4Z2QzFxVGdk=
X-Received: by 2002:a17:902:f603:b0:2e9:7dda:bfce with SMTP id d9443c01a7336-2f03f2760efmr88354605ad.74.1795367912601;
        Sun, 22 Nov 2026 09:18:32 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84364sm40712525ad.5.2026.11.22.09.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:18:32 -0800 (PST)
Date: Sun, 22 Nov 2026 09:18:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Cc: fadouse@pm.me, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/sched: act_ife: return -EAGAIN after
 dropping rtnl_lock in load_metaops_and_vet()
Message-ID: <20261122091830.3266fcd0@phoenix.local>
In-Reply-To: <20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-v2-1-67c413c45928@pm.me>
References: <20261122-b4-02-act-ife-rtnl-uaf-v2-102eba468698-v2-1-67c413c45928@pm.me>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Nov 2026 20:45:52 +0800
YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org> wrote:

> +		if (ops && rtnl_held) {
> +			/* We dropped the RTNL mutex in order to perform the
> +			 * module load. Tell the caller to replay the request
> +			 * under a fresh RTNL critical section.
> +			 */

I prefer that comments stay in "short and sweet" style.
AI and new developers seem to like long comments.
This comment has the classic /* add one to i */ style...
In other words the comment doesn't tell human more than is already
obvious from the code.
