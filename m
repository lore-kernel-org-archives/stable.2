Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790283;
	b=x8x9jP9Qtk39eIkuP65c0zRsTQ03dsGOKOm7FLVOoE0GYR6J1e4C2MiKYx+a+6bysKVx
	 IbpTwPWSauoSIs++6cZPrv1QNy3pPdojEBCamNiYOaL16xlfL92VEuow2dWU6Ro6GPtPg
	 I6mh+Li1gu1RsjzlPc3oPJRiUPE0aLogaL987ZEAc2Bm1DBUq7IC3OTozmssRmBgj5LBD
	 uI+WCt9TiyTS0eJHpZmOQpYF9neD7MNOGkl//2WOoJSboin4cWJcKV32PNrrUrKhJV0fK
	 TuUQvS8kefNl3HzJxPjoF+Zmzl0YOKpjNE0hQk90ozriBV7j+HeN2RK+Ko0oidY42rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ak9btoKvCTu9rSZ5ihFwJ6IGdjrz6GkJZ1ClTIBPTY0=;
	b=n4074k1EOhzYE5sRJBadqEC8LDG7/CsITDL/S5Cr28x4pOljiiYdaLFmZpLoPnCCBolK
	 pJyFw52VBpK8e0grrFWC2WRqbj0PFq1WaqOtQz80o04m9hkp74vj021dB9flE8FCOfY18
	 uznumZnBVaVwo/GGpDDIayhadG+KW07AiiPigtDv9JD/cLH71Bgq2qouIi+UP3JWlYC4h
	 UKIrq3Ml1NjDptjnLtWtgmtxloyW5yTfvX+DuAaN3iIKk9gjhEbRcUyYE8oIkIDPjznjC
	 zPMhUcwhIwbtK2RwnbfRSCBUEmIMUfT56J7HPY7tfQRY+nZw06/E7WIUOPRzXZuvVyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V4WKbwUk;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB9606BA96
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57BB9606BA96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V4WKbwUk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so86957875e9.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795790282; x=1796395082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ak9btoKvCTu9rSZ5ihFwJ6IGdjrz6GkJZ1ClTIBPTY0=;
        b=V4WKbwUk6XKF50bdPPfvuoEfaX8vaN7h4O9lQCGdoop/etfJo3VY7ax4y4sY7VKVAB
         CZ1dZR3pGKlNmD5qzkmpIRfdPbyqNUL4YpeV1Lx4agawNQHQxzGKPNfwS2K1f/BK6iEx
         UjZdVD8VsH4I4Jw/a4OfAXewO5YkZ8DGefnsJq8RGw95GpS3rqnL9wLBn1A8PY94EYIG
         vo5T32ZHKsWoubaWF7eZ/RE9na5w1d04XMiMvbU3wyO1PPDSzAe6YK3Ub/diBRFi7B/G
         DG+JYdu5GQ/ki934i+5xT6pl0MUKvhCJj1Uu/22Fu62RJDJ2UdzPU7PZ8qn+I0nS8kD2
         2gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790282; x=1796395082;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ak9btoKvCTu9rSZ5ihFwJ6IGdjrz6GkJZ1ClTIBPTY0=;
        b=HruhhKQ9Pv2TVwqrzNc3IX5UcifbRaqy8iScqhgHU6xoDA6wgvA7CEwvQTxHAuz61n
         rYXgk6PZrw173d+VXg2mwMS8bvOK7pKJ3hIZe1COlrM9QY6vp44z2SIuxPEvlSaLeGzo
         qifqDw01GezArNP+1HSQwR7kd9Qb6AK/6exNCCjh/CfnjzoYyF47KywtxZSukfloe+Yz
         w3fsLeV1ypUDnQWnQKYx2uwarEFkZYvgJDetDU76ou7wAy08x9ktN1Ua89C5ZHtmMfso
         XtMRw8p4INK3ik77fGU86+e/zA3XWUD8yJ9HO9NnLBrgFwqC23pzxb/jC5r2V3t1Nftv
         oy8Q==
X-Forwarded-Encrypted: i=1; AL+hErFmztC9qSD3XuYMDvMkuNu8J8Qrz8q2jk8F06t8JSzv0HCnSbUXzmPp6FWe4LO6H+NrKraWqnI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qS4CFlORrRbeQ2lCh6fP5bh1m6YYbQ4WAn97Smi3ItgUhov14
	lrg94ewgM41JSvxmnkcRbyIrMgn+YsJ8RQhQd3zuRgJtJSKFmZPpfiogPrncheG7xec=
X-Gm-Gg: AZFdTZcXgn9f+gAcxKfLszy/GmnTe5AkhbkUSfPzPDlkTX5w/ecPKVQHey8o7/jQw1t
	tBSAP6v3EQy7IeKKHKhwTaCb80Sw/F24UlWvcQ+15chTkcpaVZRG/PXykjIAb0wRYtcYixC8Ojo
	755WGztKv25udMraa/RLy8m7cRqPI+WSOct/6e32Gys5K4vI84ZXqWJzjXByrEDaxlCEvXEWSlt
	jgkGmnHtDxQKyBAPlWf+LYa0J6XCZnhh3d53eBurZ1dLhRZI5tnxtSiCqBpJ8sx3xMXjU+YX+bV
	KGb2gTsKNG12dBdEqjqmaJkfFPHACYIpFn8jQ/wMK5yapbOyrfwVoKKpbm0rj0psz0vuM+6hYtk
	cxJ7dhLRsbq3gkY5Ud87opU6y8YjRSolKmvPl6wVn+wKwL7/qn6oiUXISfmILYiYx9LweJlBJru
	lpaVnZkWqsXF87ziFmWP8oofMwjeQpnYbfQqLUSGv5v7VgOusBiATPO9h+f77ek0A+v886HZGQT
	lhvQ9F/OLAZswJxEfXq3/axhIEgLW4d1V2ZnvYr2M2z/ac7hhfilf3ztg19JTLa8GxjCGKn7Ei8
	j7aiqLy9JQaQRr71GCkeQLf0mzCeCgMTaBeuNI55l/kwKpl6
X-Received: by 2002:a05:600d:82d3:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4bb8880f0ebmr544746205e9.9.1795790281075;
        Fri, 27 Nov 2026 06:38:01 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906cdcc1sm419542555e9.2.2026.11.27.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:38:00 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Matthias Fend <matthias.fend@emfend.at>, Adam Ford <aford173@gmail.com>, 
 Maarten Zanders <maarten@zanders.be>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261127-vc5-6975-dbl-v2-0-5a05581902c1@zanders.be>
References: <20261127-vc5-6975-dbl-v2-0-5a05581902c1@zanders.be>
Subject: Re: [PATCH v2 0/2] clk: vc5: Enable PFD frequency doubler for
 VersaClock 6E
Message-Id: <179579027496.2788166.14775637168016686741.b4-ty@b4>
Date: Fri, 27 Nov 2026 15:37:54 +0100
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=307; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=fXRDzVXdeqNjLpM8kAgxXB8K0CijXAk5Qps7nA0KRCc=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcU49b+AoUhCT7VF6+/nci38OeBtNgvZLur0/VLpbM3
 p16am1cRykLgxgXg6yYIksNd7X4O0mtL7Om69yGmcPKBDKEgYtTACZyuISR4XbyJofv5xfN+r27
 453nRdX17JnCTLlMLC+9qtw55nOcK2P4p6p8Yvaino8zXgv++7yi8v32j7YODqfjdq8ocTNI8Gw
 9zgMA
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Applied to clk/linux.git (clk-pile), thanks!

[1/2] clk: vc5: Enable PFD frequency doubler for 5P49V6965
      https://git.kernel.org/clk/linux/c/94cff4fea1c1
[2/2] clk: vc5: Enable PFD frequency doubler for 5P49V6975
      https://git.kernel.org/clk/linux/c/ab7a5a9007f5

Best regards,
--
Jerome

