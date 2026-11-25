Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636662;
	b=1m3AuHEXXl3uOQSU4XS3+F0dxScT9Y9PfGz94Cm6Se2C/wNiUuTWO1bMxty0Cf6g7uW0
	 fK0c3CxnHS9Ip63KBmYQlnAyykE2AwTNlajZush+OJVLvTJkUt5QscF06W99Nj74qmGzF
	 P3Eg3lzmVEtIPhWuCLYL/Ovk6ggbkLXXJfgMMkRm1Jv4mBYvYS68AfyGcn4fn783xJqAj
	 ndR+CWsh+lWAG6btg2Szh4fayuW7xY0M/krf5GeTgm9bJAXBovCBxcziggv3lTOSlZtXg
	 gY8hr5cY6O3mNiSm1rdSW/X59G0gZcALf8UcW9qWGh6VHpG4M1e1JPJW2o++MQXQ6QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FnWutwVHAzlegSMVJ4Kfkk7OIUcj8sfxBwSeQGcqrD4=;
	b=o6YDG3ayZVJu9FbAVfMyTKGveJheA38d24++1yyH3C4QyZhOVwYALhPbU4zxa7wYCkqD
	 IcNAsQ0mz0VVt6yoQu3pqcKsHSmgaJJ4Gm4ns6VlEnak1JqC6hPPsqOezrFosgxeX7xT9
	 EAq6k/+O0EwwWdrqy8xZlQkLBijDwVh4kaUWbEbb3Dvf28dsJICLkOrh0nA6bx+5LkHj7
	 yS7T2agSow4A63XKrnCZ+6U+Hj6rTXCnF7t+ziwyPPZAXx1rSxAfmfbDbcArqP0bQ/plR
	 pH/WLruP3bFIbbQBgfOxXM+V3MrgDeYjqLxjo0+Geh2HpEwKDb4vS59/YyMdFqONXkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=BJIbTReu;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3948606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3948606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=BJIbTReu
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2761c69fbso7857980c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795636661; x=1796241461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FnWutwVHAzlegSMVJ4Kfkk7OIUcj8sfxBwSeQGcqrD4=;
        b=BJIbTReuQbMD2EPqIi2oK/iI7IFqoFFIRB9NyHmHtd8O/sYk+ilqqcXO+oJxkErXNl
         4COQpCv+xRboHxL7oaaxZD0ziFIbxVOQXAeQkX10BXPdjfohhc85+DcaIdix42cjc+dg
         hcD7MK9kaOZa0zLM+lf1pLuzJt/7d6BOAJT6XL/4s+HG7twLRzsd1FXwk5lUhwNbpStb
         6rHUpptWd4sg+WjHPTAXkzTKUARYoFyN4LUTDd+tTGasG1rZ0Q7Ymvp03iFPI73IbtJ6
         9GfKH9RhotXSZ+Vo9coboFv4S0eQVoRgtbUahK8EaQQeALr2X93QgVx+GwhD2Z3yo+RV
         KLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636661; x=1796241461;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FnWutwVHAzlegSMVJ4Kfkk7OIUcj8sfxBwSeQGcqrD4=;
        b=cyAVv+M90RqxkrXX5TT/t5h5IwYPUZd1JgIiUKtHRNsJFpZrSblUCZ7MxgtcbbR2sa
         vh3/PkrZiQBzA8crr5wsXJR4JbLWZczm0/IHaBHoal46kr9xLT2FUnjYn+HtlohDarLW
         0I6GV5SUjuVPLlzHgP8cPVf5aWhuHSQZxLVMVx2at0YxyLqIUg2ahliK0FCMQgdGekcs
         fEtl348jQ2GMD9yP+tDnBoUXCZreba7P6u+hJKKw6JqngQKVLoa5BUgfeIgYDUjZ2phA
         kZnQp4LHd8haKhf5J1rJ5wS6RmsKlFbOO4kIyyE6GiazcswPW+t3bSUjXKk2if3/0FPm
         JuMg==
X-Gm-Message-State: APuU4Z8IeNu1OCcg9gPEl0jD/UEFkhqVHqU91g4OjWmC1SeADETa0X4M
	nxOrgrQT1upzLw/hhApAk75J9pEwGMlR2Evqblv1aDIoRH5K6cYBbEBdcvfcOzk6aR3VeM/6A1u
	Jr8DBSfE=
X-Gm-Gg: AZFdTZfRLiV0djpJASyMLSWS8uy/ND5e66GKlF029+7oajPoCV0qdjp/6Ty0gllopQL
	LFZjduFBqKUr20Hd94s1pzm5W+LvuQlArn39o47Z1YzY3Jd51uQRt2NzK10U7KcpWSKSEQjbDdd
	SKv7o2HALjW81if3rH/eBc/ve7n+yG01CT30WSe71MIkEoR5yX7Z9F6ZkGhG1UPw9Ufhqzq0362
	92rR7LGVBkv9KGBoxGs8rZ3XUIeJR+mbA54PgsLggPKzFyGV6iOOU0NtZbT/4k2TIkyKMA9tjef
	zOfdwMN6i+P6KRoSknsJfFXwk/iXOSpDk7LVm0AuGKOvShStvlOCWbBmiFXHaIHZI2xWo9YK50X
	LLCiE/87nV0We+XR23/8BNkVESUSmxlsU6IFxH5hA/q+lLmE5ckxpLUClgs1+AL/FC6yK/O3Kix
	3UNHyKK1D9GPZbMKLsz3UE/2xTkOrFavPcFdaVhF7hS8UxvpvoXvEvqJWRJly2DyFAJ46BivK5B
	kXYAZL4o+58740pw53dLBP4hN6tcFpFeQP7o+tnYMuCcx/8uXsN1QbqRCGE5bIHrDV/0Xb04l2Z
	pRDdm6lyJDNYff9ZLoCbFO/jFdMxjkTLYvVLlmABHDuoe5szPR60/hQdWOD+YO92Aoh5B743pAZ
	g7PZbxPaRqMTr+j4eXp6cOXXEHvrYKJfUCCtmxgtotetyTCQ=
X-Received: by 2002:a05:7301:3a82:b0:374:ea35:9069 with SMTP id 5a478bee46e88-3856fb67380mr17732201eec.39.1795636660967;
        Wed, 25 Nov 2026 11:57:40 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm59596522eec.14.2026.11.25.11.57.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:57:40 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: ast@kernel.org,
	cratiu@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	ipsec@lists.linux.dev,
	jhs@mojatatu.com,
	joe@dama.to,
	kuba@kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shawnq1@163.com,
	steffen.klassert@secunet.com,
	willemb@google.com
Subject: [PATCH 6.18.y 0/5] net: validate GSO headers and preserve XFRM inner offsets
Date: Wed, 25 Nov 2026 14:57:30 -0500
Message-ID: <20261125195735.57472-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Please apply these five patches to 6.18.y. Patch 2 fixes CVE-2026-53091;
the others are its prerequisite and the upstream fixes that followed it.

1/5 be1b70ab21cb initialises shinfo->gso_segs for SKB_GSO_DODGY
    packets. Patches 2 and 4 build on it. It applies unchanged.
2/5 7fb4c1967011 pulls GSO headers into the linear area before
    transmit accounting uses them and drops malformed packets. It
    needed adaptation; see its backport note.
3/5 fa90a3145c03 stops xfrm from overwriting inner header offsets set
    by a tunnel. Without it, patch 2 drops VXLAN-over-IPsec GSO traffic.
    It applies unchanged.
4/5 c6648c9f3b51 bounds the segment count and accounted length of
    untrusted GSO packets. Only its context differs from upstream.
5/5 35d2d6e5ac0d rejects a negative TCP header offset in the code
    added by patch 2. It applies unchanged.

Patch 2 is in 6.6.160, 6.12.114 and 7.0.10, and in mainline since 7.1.
It does not cherry-pick onto 6.18.y (checked on 6.18.57 and 6.18.65)
because 6.18.y predates the qdisc_pkt_len_segs_init() rename and its
pkt_segs accounting. Patch 5 is also in 6.6.163 and 6.12.118. All five
changes are in 7.3.6.

Compiled net/core/dev.o, net/core/skbuff.o and net/xfrm/xfrm_output.o
with CONFIG_WERROR=y on 6.18.65 with the whole series applied, from a
cumulative x86_64 tree, with and without the current queue-6.18
patches. The intermediate patches were not built separately. No kernel
boot or runtime test was performed.

An LLM was used to prepare these backports and to check applicability
and stable-queue history; I reviewed the result.

Thanks,
Artem Dinaburg
