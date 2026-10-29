Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316465;
	b=34BQrf628FMX7/1jTnOYUKxjCZkJaJ0RUxxP9/kfIaBewaetQcN1oP9TUjcljo5Byf5Z
	 gaPbfO+hcxUEhwQmSiC6p/isiCuyDX84GS23m1lzNDAZ628/wSXY4hskhaUGkuVUyB+kt
	 8+CmkKxQRaQzICjxbuPUs4UrBnl0GUmBYEl9jhnZRRxEu0O06Xed5tBC4MnvW4L/PiyhX
	 GFy6sGxcpI58tgC7/Wi99FYDI+hnXvbmIE6UKoPEWQ+IMqoz2lOr+rCKVWnaq2AyuZfro
	 BJvADFDUUvVylrOxhe864U9eAekkqjYu2etPbBUizZGNGpPYCoWWjc8yksgc2RP0h3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
	b=EdsSGOQOhfIThjFPeLntBEjVAsLJxyXae5Jk/VKJD7sFcdthp2Oc0+CcNSfgAgGnWPK0
	 9J9MJq2bmDzMcy0zDBAkzWNMILeeOHZa0DZjicVFCTDda6tVwNGRsZxwxlnYmdyUDPjRt
	 NEI++RB44h0Uszo+c+riyDm7yXsUgxM5bYVlATkxDPISh8vYAbqENDCSXz5g2dkaeAmqM
	 8Ic87lsKNIvbHSQcN6B2d0hNbyHcDjVjaCuILjNCO6AugCT4AyitYSoL8EC8qy7GYaywq
	 C6/S5CaAa46CCytdk8z1s+QYEuciN02om9QDLtzt5Mm+4zqNslevcqAiV9nKakU8ulw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=D9aZ7Wzv;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852BF606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 23:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 852BF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=D9aZ7Wzv
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f3c8958d5so7791185a.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793316463; x=1793921263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
        b=D9aZ7Wzvfx0yphYngHaag3ODs+QTcnPjozdlmU3oIz2a6h97M4mZm8/YYLLzQfV7Cn
         w05GuZxQxJeUaEtD1UXJWBdiR8GrpKIZhCdXgrU3hyFh56PPJT7nO9k3CxMsB8K2JLbD
         jRwxfh2HBafByWOrgVlA5h1CrVf4CD161eMYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316463; x=1793921263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
        b=naKBd1NN7WzWS1F9TWT6pc3zA2TOIY+hq5fLrXTI5rB/JGULZUHMWHQ9JpRcDYr49Q
         yJZMkT9snvGGJYoKSRt1z2GqJjjp6s69psM0JRfVisn+n5mQaycx4mBPxFa3DB8tG3C3
         duuj+Muzntk74zhKsgrzvZOFY/oFTZK1BPXw3UdX3AE5T7gQBKmTVm2ldOTxzlDH6zS0
         xf5Tz86EBPb0DZNrnb1+BUewF1zFlPhnIkuWNBVAJwQwXKLy8VsoAjqSEDxQXzN1QzPB
         UDnBngN9ms9N5jbMuoWDzh0hCboZkhP2yLAPdMK88KzySs6H1mN9qQSJqctxM0tLpben
         3fJw==
X-Forwarded-Encrypted: i=1; AKwUvByKU73RnudMCHdpKx5DEITqJ++A83+Rfz5kKHpC5Eg3clO1pqtJLM35hrjMYIK/h/NsfJfanro=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKFYn2kIrcR8xoSbz926j7eMIScZXjCF/GIQNpW+W6zNsOELkw
	OEOGU2snaVrfbHnmhw8kNWna8FKM/KeuxeEewe/KtX0VOeWSrm5c5WObyKZlBNL1jA==
X-Gm-Gg: AYBFou3KQ8048scF/LAeUPHxCOagxLca7n9sNFxCOmzCBv8+BfAFM4z82oaec1NX3//
	ESLVMMOMyoFRYD7bpk8KhYimCcUYkvHrgpkuqXNTerAJCQYn1Vr8r49dr6YqC5ioUcs+wprLMGI
	c8hInHANC3iw8/CXhUfYaVrQ9WGTVLFeku9UCf8f8Ssbw2bM+3tQZCF99VL7TU9HqgtRVcNykg+
	8+9TjuZQMoubHQ+KtsJ94gKhMV4oP5z64FrKQu7Fgl2dCsb7WMIRuq7mYzFturLi791XPLMmuz6
	Bj0o2mC6uH5sgt9NntFXiLtUARZLj1yL3GDyJGfdf2Xk3xhPUFvI1CC5yLTmk3sOPyCyHDH7muu
	+IF0z0cy9l5V/ui5QT+Bh2O81gWUDqSdtMpHZtKFUSruVOiN2FUTrhURrTmjl1/n9Rx3urc4mdk
	3/hn6c3v+ME/F9TSPWqP/lgN2o0wMYUoDVH7xs0OtLydvF+gHnDRxLiRjdYaKF6mwQgUdcr389v
	+ue2FpJO7IT6OH5U7xV6WiKAdT2Iw1KgRkhcrGrdDNBuS/gnEMJPyitXSKHvJtZeWQ0y1S7eTPJ
	VmqHjbMM9CuoNa9pW/oMVf27ETN08rd5JZHkfANUCeUjO5gxoi+6EUbEw/9IZ22bMFRS+d9yqaE
	=
X-Received: by 2002:a05:620a:8005:b0:93f:611d:a18e with SMTP id af79cd13be357-944216ed622mr140154385a.55.1793316463321;
        Thu, 29 Oct 2026 16:27:43 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424243823sm5384385a.21.2026.10.29.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:27:42 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace boundaries
Date: Thu, 29 Oct 2026 19:27:36 -0400
Message-Id: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This series fixes three independent boundary problems in net/sched.

1/3 act_ife: encode a configured zero metadata value.  ife_check_meta_u32()
reserves an 8-byte TLV for a configured zero value, but the encoder
returned without writing it, leaking stale skb headroom bytes.

2/3 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/3 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

Origins:

1/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/3: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The three patches are independent.  They target net and carry a stable
nomination.  They are sent together because they share the short-skb and
namespace-boundary review context.

Jamal Hadi Salim (3):
  net/sched: act_ife: encode a configured zero metadata value
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace

 net/sched/act_ife.c  | 8 +++++---
 net/sched/sch_teql.c | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
