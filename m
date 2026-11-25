Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586748;
	b=Ag2fExpmUgY9X+ne22vLW6WSdCzeSO2o7h53qhdeKe5OA44+b+xoZPcKS4xa8qflzWGR
	 DxIJgv6cKzBpXw9bho9oc6qEp0XiDauwAkbhJ/WVdMB025eGl4/mO7OQ4DEjLR0TvT/lE
	 pgrmApSDZpr09MmJC1BRytbNVn+xuYPGJFneq/v/yup69QqDbnuRonUaMOEYm0kMHEkov
	 MfpmCHubJdrhEI+Y0IgcDjPJ9dn9cjSotbXhl5/TA/ZHdFEhBecX2CbKuRP/pYx6ehiyL
	 Qn1EsfJvkWUjK0ZeKd1zBIxJHhDw3AAKEaqkb48bIa9gxEo85qii32IZVdpU/NVw/7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
	b=GheIs6ifqt+0oHBsY0dFDLur+kRcyq/oqV5WfWUpcqzpAYZooz2cXIDz8894xl8IMY9o
	 dpndFL7bZxvezfgxsTNjf48YUuXLbR2FmWkdf3AKg7876/hrTIBFa9hp24LQ/3UBKds1P
	 fFYb7XHtzVqdwrUjX4yEb4OGJz9LmjGoLKC7eoPbxsGyWPScgwpB63Z+u41pD4FSjf7RI
	 gaZV2jUoXLiLGETbgZ5gjOxSe6fs2PPIrhgL3xlRj1PdPX3xwUCfU0ka64HfmosRd0c6N
	 TvI7/BVo7Fp4abcz4vnFx4qKgtYc1rjnsvOZpZgM6CGzQuH3h5LgJGadRaUy1fSJ7eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQ9RGk4T;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21060606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21060606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQ9RGk4T
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-385d8a00598so7913383eec.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586747; x=1796191547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
        b=sQ9RGk4Tox3CJBgaHd1rERGLKFnMlSEy04aCuumhalHDASrM93RkBheM3kfuO487fS
         RTFW+tp4XwuGTm2cLzQvr1Ge2pYadRPBHZpVt6UPz+xpa8HKhFn7ak/N1YJbo+bu1AIC
         yagdq45DU5MqDJNP3sQBCmYdFWU916d5hc6eXEbd9H2F/g/ojM1sE/XVAvAbzg+zunqV
         O5/aGKchAF1/92KN6ghTvUf/im50ffIbXI0nxFTsGjz3YvZnqkVdbJsZ6gFrnSDFfq2t
         OBnd8/q4v2YL+eEGxvYSPFROxgOxfWusmUtxdTOKMuIuLfZfx/E3dZLIAdibltkRBJj+
         wyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586747; x=1796191547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
        b=VG6Z2Q4jROQggvFTQj/KnoG7tabcGXpQTD8GkVTsKILr9At3YqLM/Xl869BCN0VrvX
         Cx3tIadw5TCz52dWF/TE847ZgSxlYPqGA/z/viNPjrt9P/n1GrkPuMEi4YNhTqQeaPEE
         HdKlDk/G27iNmh3QT99FQnG2nxqLCJ7WbXW8rBl3/IJPHWiWXUVRuW12Oz6gz9BiVV+b
         oCpt2+Yezp1iLrgf4m7ocXVst8LFVY4DB6rY3L6iDr8RR59xYvRrIkaaZ07EiMe6nE3d
         JFZFXFw1kF4aBWIzNGWMgeNqJmsBFrDwdXys8kWYM+ttZ/FcMOqYHrQk5slwV5SVcjJQ
         dfvg==
X-Forwarded-Encrypted: i=1; AL+hErFgy6UeCtGWOn9BsWSESreF/9XvMG9/XL/g3ay5CYhbWs6Lx9oc/GlZhVFXbJBFRlnNdRr1W6Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hY9VC3k94rihrQAHAa03hbl0jSiuQ7uBcdK+9mbG6xMcEl/OR
	b38JKoi1OuK1MhfcjfOX27Tq/32kVufm/zDTM8AOjT0xoyv4THN3bYhV
X-Gm-Gg: AZFdTZe3zWYtx63FMw8Mmd3/681Z0nrixygnnLV+ICXQJjGNP2fdqXE4CnxMkvhcwfE
	tSTa0RXxxaJZM2ZaUKH2UbnRFrO5B9pwjlMiuZhFaTJF3dssUJZt/Q6MTtiL5IAdjMA7uM371h4
	TXu90vwVJdSD32bWKWq/xIJRhZO7GL0tSF1oKOIUGsgL2R3HYMpNfzR9Vp0TlRRhW2URRPl6Gsl
	7KufTnps91PgYKLOeIJrlFN7ObJooLb2u0SDPpypHd8HGbLnRik22FtU/RCJY7fXjUz8r+vm1QX
	FvA5r5cCzi+ObUslq2fyEXU5lq2MFnCxSYjz7OgtYSKqCrTpeaD2SEx6D+AkpwkhJtEoUTx/kFS
	M7I3CS0CGaFeEWWpkleccCNdLPVJtDMW0jM9LoemlzOPxnjgI1VPSlRZZILq1ntxb4EftiF62pb
	RzLpQWMgi2pkx7LbYms925qgIghKiWlEst9dmuHGKl4DJH9VAQcKinxLly9kKQiJZv27UhYvSwV
	alMY5oWZBKwjiMMKGMZ5Uo6RrUfOZnmLQjjOOPFTAUcLKkpWGpB0i6qUauojMzoGmEpefSWjGe9
	2bksS5zzAmqGgWfb0d4huKENe1Jg6BJvnfMMlf08uZDODAMgH2PCu6BX3zZdoMVNV1DSb3JXDDg
	J
X-Received: by 2002:a05:693c:8948:20b0:386:b08e:4b7b with SMTP id 5a478bee46e88-386b08e4e93mr8414503eec.29.1795586747002;
        Tue, 24 Nov 2026 22:05:47 -0800 (PST)
Received: from O1PCCC03033100.cn.corp.seagroup.com ([143.92.127.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm57080152eec.26.2026.11.24.22.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:05:46 -0800 (PST)
From: "chenglong.ma" <longpareto@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	2312891301@qq.com,
	blum@kernel.org,
	co+6dcbccedc9ec6452@bugs.sh,
	eperezma@redhat.com,
	fangxy@xiaopeng.com,
	jasowangio@gmail.com,
	kmehltretter@gmail.com,
	linfeng.sun.dev@gmail.com,
	lirongqing@baidu.com,
	oss.patchbox@gmail.com,
	p@1g4.org,
	phx0fer@gmail.com,
	physicalmtea@gmail.com,
	sergiiushakov@google.com,
	shubham@octane.security,
	stable@vger.kernel.org,
	stjepan.poljak@gmail.com,
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
	tavhadia@gmail.com,
	tjdqudcks0424@naver.com,
	tz2294@columbia.edu,
	xieyongji@bytedance.com,
	xmei5@asu.edu,
	yuz08559@gmail.com,
	zenghui.yu@linux.dev,
	zhaimingbing@cmss.chinamobile.com,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Date: Wed, 25 Nov 2026 14:05:32 +0800
Message-ID: <20261125060533.1296-1-longpareto@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <awWOpS3HR_2FTN3I@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org> <awWOpS3HR_2FTN3I@gremlin>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2026 at 01:51:29PM +0000, Lorenzo Stoakes (ARM) wrote:
> It looks like it doesn't need VM_IO anyway, the other changes in the patch
> make it redundant AFAICT, so you should send something like the below with
> a Fixes pointing at bb2e6f166547:

Sorry about that: it went to security@kernel.org (hence no lore thread),
I did not test it on 7.4-rc, and you're right that VM_IO is redundant,
since vduse_domain_set_map() is the only way vhost-vdpa entries reach
the domain iotlb and it already rejects anything backed by the domain
file.

I'll send the one-liner with Fixes: bb2e6f166547 and your Reported-by
and Suggested-by once I have actually run it on current mainline.

Thanks for catching this.
