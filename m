Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227615;
	b=Mez3QZb/xpwWhXkFBaokqY1qkPKi0svWORb0Ihu8WCyuEdgcgTXX93+e2vKMuo6NdfbC
	 hDpkq1Noq6SJuUZ8cKhXZ4Rjoi+XpEqhsTH4HVl876FPG81kvZWYMALVaz6LniDil4UIr
	 sbrr/0ACMsviBFCSKHus76aGfy1GA43eCe6iycVRK87c3fynCLheqpqmqkiGJ/hEELkmi
	 k5GRoQtdTbLfZ1bW82TbAKXArRgFk121sYkuzeTXR0V7UAJh2hX2xcdPi34V6tiZm8lbJ
	 Fb1bDYZLWBTwmOve2dr527MUoornpzU6MfM3kEwETpe9I3J4u+o/p3OYRpwbgfgUz5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227615;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=4M5v/hY+kOczd+ysevcmCc3bFFIgJbCT2vaUCNfx0mo=;
	b=wRGT5MacQyq0pHxXi9t0McCbWi6biqqCxAQ39r1Zr/UIy1MNgXzUnHAEC4cnPlkRSGt4
	 E8yKj4EP4tzEQtQWtyLOOdRKXSVcOpc8RbQ7gUd0VEbEcewqwLm0C1oQhPCx78PTT6zmd
	 vY+yXwgoUX7SLWeFefLT23bloEa+sqgNoMIHP4wDDFJ5SaI8h9Ap+eGUHOIy/n/lTpedo
	 EO34DzL4540KgJBG14YUym8HCuzb1JzBkIOtY+j+AFVbGwDuXYVRxr8zPGcT7ksFtojDR
	 HR7WhRpDKP9z2WiMgZTXtnroP177IBIRE91res4X3ljygpAXos+RAc3l8y7qxa1HK4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=D9q8JT8D;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95A606A323;
	Mon,  9 Nov 2026 12:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D95A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=D9q8JT8D
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNTj029Snz4yjSd;
	Mon, 09 Nov 2026 20:33:24 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794227604;
	bh=7kW5/iwLHrpMe+gbCylgUW1piFSCHLbOCGCPJrQrg5g=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=D9q8JT8DuAWXDjWcC89uERCcCfC+MLDCWmvj71QmjpRLv8dZb0umVfFZjHUrfh5bT
	 TJfZsrjNGsl9pd+hLzYKoHyvHcSpegVOgdtrkoTkfWwFM2CXJZ4sT7NkKModcfr//1
	 kwVQTi7mazZ3rIqojeWm5EdKAHzfcEtgSARI3RxOMpiFg/wrPVvH/qoAGkt2zqjQHz
	 U9GgykQy01Xd9wumDQUwg2vA2yTEu8HQdCIt4swMF0yTrM19BPCVj5cmCuxJZ8Czvj
	 KWi3b4vX5YlC8xcvrebKPLhL4kPWektgRsIPxZDjUa2j3VWvAHkcQLSnvlcJ8zfSQy
	 ugm17/iscIeLg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A9CXHx7000110;
	Mon, 9 Nov 2026 20:33:17 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 20:33:20 +0800 (CST)
X-Zmail-TransId: 2afb6af1bd90e10-bac93
X-Mailer: Zmail v1.0
Message-ID: <20261109203320542JEYrsjSWEO22mMpmG7U_n@zte.com.cn>
In-Reply-To: <3b00799f-2fef-44bc-b798-79273c5c0ca7@kernel.org>
References: 20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn,3b00799f-2fef-44bc-b798-79273c5c0ca7@kernel.org
Date: Mon, 9 Nov 2026 20:33:20 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <david@kernel.org>, <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>, <ziy@nvidia.com>, <matthew.brost@intel.com>,
        <joshua.hahnjy@gmail.com>, <byungchul@sk.com>, <gourry@gourry.net>,
        <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gbW0vbWlncmF0ZTogZml4IHNvZnRsb2NrdXAgaW4gZG9fcGFnZXNfbW92ZSgpIHdpdGggaHVnZSBwYWdlIGFycmF5cw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A9CXHx7000110
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 09 Nov 2026 20:33:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1BD94.000/4jNTj029Snz4yjSd

Hi David,

fair enough -- and your reading is correct: preempt=none is unselectable
under PREEMPT_DYNAMIC, and the arches that can still pick PREEMPT_NONE
have no NUMA, so mainline cannot reach this path.

I was aiming at the 6.6 LTS configs that shipped PREEMPT_NONE + NUMA: two
lines of cond_resched(), no behaviour change, same as do_pages_stat() got
in 8e934ab44389.  If you and Andrew would rather not carry a stable-only
fix, just say so and I will withdraw it.

Thanks,
Shao
